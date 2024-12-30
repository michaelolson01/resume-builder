(defpackage resume-builder
  (:use :cl :mito))
(in-package :resume-builder)

;;; First have a way to input the job description
;;;   - save as file and read it in
;;;   - web interface to paste the job description in a text area
;;;   - input interface to paste the job description

;;; Next a way to get skill tags from a database (with appropriate descriptions)
;;;  - Does not have to be complex (csv can be used, or a connection to sqlite or something similar)
;;;  - I imagine something like ["Skill", "Acquired (School, Certain Job, Project...)", "Description"]

;;; Find skill tags in the job description, and make a list of the tags that are going to be used

;;; Get basic template from database
;;;  - This stores the output (special tags for where to put skills?)
;;;  - Multiple profiles can be saved, and can be choosed to be used
;;;  - Separate into sections
;;;  - (header) - Name, links, phone number
;;;  - (education)
;;;      - School
;;;      - Degree
;;;      - Tagged Skills area
;;;  - (work experience)
;;;      - Company Name
;;;      - Company Address
;;;      - Time held
;;;      - Position
;;;      - Tagged Skills area
;;;      - Accomplishments ??? How? necessary?
;;;  - (projects)
;;;      - Project title
;;;      - Time worked on
;;;      - Github or location if accessible
;;;      - Tagged Skills area
;;;  - (skills)
;;;      - Tagged Skills
;;;      - Strip off all but the skill used. This will be redundant because the skill will be listed earlier, but it
;;;      - will make it so the skills are all in one spot.

;;; Add found skills to correct part of template
;;;  - Search for each section (education) match with appropriate tage
;;;     - "Acquired" = "Education & Degree" or "Acquired" = Company Name &c.

;;; Output LaTex format, and compile into a PDF.
