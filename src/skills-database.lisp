;;; Handles the application database

;;; Database connection functions

(defun connect-to-db ()
  "Connect to the application database"
  (mito:connect-toplevel :sqlite3 :database-name "../resources/resume-builder.db"))

(defun disconnect-from-db ()
  "Disconnect from the application database"
  (mito:disconnect-toplevel))

;;; Table definitions

(mito:deftable section ()
  ((id :col-type (:int)
       :primary-key t)
   (name :col-type (:varchar 32))
   (description :col-type (:varchar 256)))
  (:conc-name section-))

(mito:deftable skill ()
  ((id :col-type (:int)
       :primary-key t)
   (name :col-type (:varchar 32))
   (section :col-type (:int))
   (description :col-type (:varchar 256)))
  (:conc-name skill-))

;;; Table maintenance functions

(defun ensure-tables ()
  "Creates the tables in the database"
  (mito:ensure-table-exists 'skill)
  (mito:ensure-table-exists 'section))

;;; Section table functions

(defvar sections
  (mito:retrieve-dao 'section))

(defun add-section (name description)
  "Adds a new section to the database"
  (mito:create-dao 'section :name name :description description)
  (retrieve-sections))

(defun retrieve-sections ()
  "Gets the sections from the database"
  (setf sections (mito:retrieve-dao 'section)))

(defun get-section (id)
  "Gets the name of a section"
  (mito:find-dao 'section :id id))

(defun print-sections (&optional (sections-to-use nil))
  "Prints the available sections, or the given set of sections."
  (if (null sections-to-use)
      (setf sections-to-use sections))
  (mapcar #'(lambda (a)
              (format t "~a: ~a | ~a ~%"
                      (section-id a)
                      (section-name a)
                      (section-description a)))
          sections-to-use))

(defun delete-section (id)
  "Removes a section from the database. Checks to see if it is not used first."
  (if (null (get-skills-for-section id))
      (mito:delete-by-values 'section :id id)
      (format t "Unable to delete, Section is still being used by a skill")))

;;; Skill table functions

(defvar skills
  (mito:retrieve-dao 'skill))

(defun add-skill (name section description)
  "Adds a skill to the database"
  (if (null (get-section section))
      (format t "Section ~a does not exist" section)
      (mito:create-dao 'skill :name name :section section :description description))
  (retrieve-skills))

(defun retrieve-skills ()
  "Gets the skills from the database"
  (setf skills (mito:retrieve-dao 'skill)))

(defun print-skills (&optional &key (skills-to-use "null"))
  "Prints the current available skills, or the given set of skills."
  (mapcar #'(lambda (a)
              (format t "~a: ~a | ~a | ~a ~%"
                      (skill-id a)
                      (skill-name a)
                      (section-name (get-section (skill-section a)))
                      (skill-description a)))
          (if (equal skills-to-use "null")
              skills
              skills-to-use)))

(defun delete-skill (id)
  "Removes a skill from the database"
  (mito:delete-by-values 'skill :id id))

(defun get-skills-for-section (section)
  "Gets all the skills for a section."
  (mito:select-dao 'skill
    (sxql:where (:= :section section))))

;;; TODO: design templates and write database functions for them.
