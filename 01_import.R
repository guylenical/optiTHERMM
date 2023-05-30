#Ths is the R scripts provided by REDCap that encodes the data

#Clear existing data and graphics
#rm(list=ls())
graphics.off()
#Load Hmisc library
library(Hmisc)
#Read Data
data_uk=read.csv('data/optithermm_uk_data_2023-05-30.csv')
#Setting Labels

label(data_uk$record_id)="Record ID"
label(data_uk$redcap_event_name)="Event Name"
label(data_uk$redcap_survey_identifier)="Survey Identifier"
label(data_uk$optithermm_survey_timestamp)="Survey Timestamp"
label(data_uk$referral_id)="Whats the referral ID?"
label(data_uk$hospital_name_bb7995)="Please enter the name of your hospital"
label(data_uk$town_or_city_dac7f1)="In which city or town is your hospital located?"
label(data_uk$hospital_country_05a896)="In which country is your hospital located?"
label(data_uk$country_other)="Which OTHER country?"
label(data_uk$hospital_admit_treat_burns_8bbf40)="Which groups do you treat in your hospital?"
label(data_uk$hospital_role_e1e5f6)="Please select your role within the burns team:"
label(data_uk$hospital_role_other_392cc2)="Which other role?"
label(data_uk$hospital_statements_79b57b)="Which of the following statements about your hospital is true:"
label(data_uk$max_burn_size_67286f)="Please enter the maximum burn size that can be treated by your hospital as a percentage of total body surface area (TBSA). For example, if your maximum burned area is 15% TBSA, enter the number 15 in the space below."
label(data_uk$number_burns_to20_percent)="1-20%"
label(data_uk$number_burns_to40_percent)="21-40%"
label(data_uk$number_burns_to60_percent)="41-60%"
label(data_uk$number_burns_to80_percent)="61-80%"
label(data_uk$number_burns_to100_percent)="81-100%"
label(data_uk$hospital_inhalation_7db247)="Does your hospital admit and treat patients with suspected inhalation injury?"
label(data_uk$hospital_theatre_4b33c3)="Which of the following statements is true?"
label(data_uk$hospital_protocol_3ff69f)="Do you have any existing protocols or guidelines at your hospital relating to the perioperative temperature management of any burn patients?"
label(data_uk$hospital_instruction_584fc5)="We would be very grateful if you could please attach a copy of your institutional guidelines. Alternatively, you can send them to info@optithermm.org"
label(data_uk$ambienttemp_maxtemp_5c1d38)="What is the maximum temperature that can be attained in the operating theatre used for burns in your hospital?"
label(data_uk$ambienttemp_preferedtemp_809d8f)="What would be yourprefererred operating theatre target temperaturefor a major burn case in your operating theatre?"
label(data_uk$ambienttemp_maxtemp_icu_5c5d1a)="What is themaximum room temperaturethat can be attained in theintensive care unit,or equivalent unit,used for major burns patients in your hospital?"
label(data_uk$ambienttemp_facilities_832c30)="Does your hospital have any facilities with temperature regulation outside of the operating theatre?"
label(data_uk$ambienttemp_facilities_all_209310___1)="Which of the following facilities outside of the operating theatre have temperature regulation? (choice=Intensive care or critical care unit (highest level of support))"
label(data_uk$ambienttemp_facilities_all_209310___2)="Which of the following facilities outside of the operating theatre have temperature regulation? (choice=High dependency unit (or equivalent intermediate level of support))"
label(data_uk$ambienttemp_facilities_all_209310___3)="Which of the following facilities outside of the operating theatre have temperature regulation? (choice=Patient room or bed space area on burns ward (basic level of support))"
label(data_uk$ambienttemp_facilities_all_209310___4)="Which of the following facilities outside of the operating theatre have temperature regulation? (choice=Wet room or equivalent room used for dressing changes)"
label(data_uk$tempcontrol_warming_9f2c7e___1)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Heated operating theatre e.g. by means of a temperature regulated airflow)"
label(data_uk$tempcontrol_warming_9f2c7e___2)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Additional insulating layers on patient e.g. drapes, gamgee® or blankets)"
label(data_uk$tempcontrol_warming_9f2c7e___3)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Heating lamp or equivalent radiant heaters)"
label(data_uk$tempcontrol_warming_9f2c7e___4)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Convective forced-air patient warming devices e.g. Bair Hugger®)"
label(data_uk$tempcontrol_warming_9f2c7e___5)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Conductive heating device e.g. warmed mattress, pads or garment in direct contact with patient)"
label(data_uk$tempcontrol_warming_9f2c7e___6)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Warmed intravenous fluids)"
label(data_uk$tempcontrol_warming_9f2c7e___7)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Warmed topical fluids e.g. skin antiseptic or wound irrigation solutions)"
label(data_uk$tempcontrol_warming_9f2c7e___8)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Intravascular temperature controlling devices such as heated central venous line e.g. Thermogard XP®)"
label(data_uk$tempcontrol_warming_9f2c7e___9)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Oesophageal heat exchanger e.g. ensoETM®)"
label(data_uk$tempcontrol_warming_9f2c7e___10)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Haemofiltration via vascular route with circuit set to warming)"
label(data_uk$tempcontrol_warming_9f2c7e___11)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Other)"
label(data_uk$tempcontrol_warming_9f2c7e___12)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=None of the above)"
label(data_uk$tempcontrol_warming_other_8d3367)="Which other warming method(s)?"
label(data_uk$tempcontrol_cool_a24e84___1)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=Decreasing room temperature e.g. thermostat down to minimum)"
label(data_uk$tempcontrol_cool_a24e84___2)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=Removing dressings)"
label(data_uk$tempcontrol_cool_a24e84___3)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=Convective forced air cooling device e.g. cooling fan)"
label(data_uk$tempcontrol_cool_a24e84___4)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=Conductive cooling device e.g. cooling mattress)"
label(data_uk$tempcontrol_cool_a24e84___5)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=Cooled intravenous fluids)"
label(data_uk$tempcontrol_cool_a24e84___6)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=Cooled topical fluids e.g. skin antiseptics, wound irrigation or tepid sponging)"
label(data_uk$tempcontrol_cool_a24e84___7)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=Intravascular temperature controlling devices set to cooling e.g. Coolgard ®)"
label(data_uk$tempcontrol_cool_a24e84___8)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=Oesphageal heat exchanger set to cooling)"
label(data_uk$tempcontrol_cool_a24e84___9)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=Haemofiltration via vascular route with circuit set to cooling)"
label(data_uk$tempcontrol_cool_a24e84___10)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=Other)"
label(data_uk$tempcontrol_cool_a24e84___11)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=None of the above)"
label(data_uk$tempcontrol_cooling_other_01b525)="Which other cooling method(s)?"
label(data_uk$tempcontrol_measure_9fc87b___1)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=In-ear tympanic membrane thermometer)"
label(data_uk$tempcontrol_measure_9fc87b___2)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Non-contact or infrared thermometer)"
label(data_uk$tempcontrol_measure_9fc87b___3)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Rectal thermometer or probe)"
label(data_uk$tempcontrol_measure_9fc87b___4)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Traditional glass intra-oral thermometer)"
label(data_uk$tempcontrol_measure_9fc87b___5)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Axillary thermometer or probe)"
label(data_uk$tempcontrol_measure_9fc87b___6)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Urinary bladder probe)"
label(data_uk$tempcontrol_measure_9fc87b___7)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Forehead strip thermometer)"
label(data_uk$tempcontrol_measure_9fc87b___8)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Oropharyngeal or endotracheal temperature probe)"
label(data_uk$tempcontrol_measure_9fc87b___9)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Skin temperature probe)"
label(data_uk$tempcontrol_measure_9fc87b___10)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Other)"
label(data_uk$tempcontrol_measure_9fc87b___11)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=None of the above)"
label(data_uk$tempcontrol_measure_other_41173f)="Which other measurement method(s)?"
label(data_uk$tempcontrol_importance_961a0f)="Considering the measurement and management of patient body temperature, which of the following variables do you consider to be most clinically important?"
label(data_uk$bodytempbefore_minimum_3f80ad)="Consider a patient at your hospital who is due to undergo burn surgery. Is there aminimum body temperaturebelow which you would delay burn surgery?"
label(data_uk$bodytempbefore_maximum_3d8d7a)="Consider a patient at your hospital who is due to undergo burn surgery. Is there a maximum body temperature above which you would delay burn surgery?"
label(data_uk$tempduring_minimum_7aaba4)="At your hospital do you have a preferredminimumpatient body temperature during burns surgery?"
label(data_uk$tempduring_maximum_effc85)="Do you have a setmaximumpatient body temperature during burn surgery?"
label(data_uk$rct)="There is emerging evidence that perioperative cooling of a patient with burns may have a beneficial effect. Would you be willing to be involved in a future clinical trial testing an intervention to cool a patient?"
label(data_uk$respondentemail_f9534c)="If you would like to be sent the results of our study, please enter your email. This is entirely optional. Your email would not be used for any purpose other than to send you the results of the study.  If you would prefer not to provide your email, please skip this question.  Your email address will be kept according to General data_uk Protection Regulation (GDPR) and privacy regulations. Your data_uk will only be used to communicate with you about this study. At the end of the study your details will be erased. You can remove yourself from the email list at any point by emailing info@optithermm.org"
label(data_uk$comments_feedback_7ea7f7)="If you have any comments, feedback or further information, please enter it in the box to the right. Thank you for contributing."
label(data_uk$optithermm_survey_complete)="Complete?"
#Setting Units


#Setting Factors(will create new variable for factors)
data_uk$redcap_event_name.factor = factor(data_uk$redcap_event_name,levels=c("survey_1_arm_1","survey_2_arm_1","survey_3_arm_1","survey_4_arm_1","survey_5_arm_1"))
data_uk$hospital_country_05a896.factor = factor(data_uk$hospital_country_05a896,levels=c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49"))
data_uk$hospital_admit_treat_burns_8bbf40.factor = factor(data_uk$hospital_admit_treat_burns_8bbf40,levels=c("1","2","3"))
data_uk$hospital_role_e1e5f6.factor = factor(data_uk$hospital_role_e1e5f6,levels=c("1","2","3","4","5","6"))
data_uk$hospital_statements_79b57b.factor = factor(data_uk$hospital_statements_79b57b,levels=c("1","2"))
data_uk$number_burns_to20_percent.factor = factor(data_uk$number_burns_to20_percent,levels=c("1","2","3","4","5","6","7"))
data_uk$number_burns_to40_percent.factor = factor(data_uk$number_burns_to40_percent,levels=c("1","2","3","4","5","6","7"))
data_uk$number_burns_to60_percent.factor = factor(data_uk$number_burns_to60_percent,levels=c("1","2","3","4","5","6","7"))
data_uk$number_burns_to80_percent.factor = factor(data_uk$number_burns_to80_percent,levels=c("1","2","3","4","5","6","7"))
data_uk$number_burns_to100_percent.factor = factor(data_uk$number_burns_to100_percent,levels=c("1","2","3","4","5","6","7"))
data_uk$hospital_inhalation_7db247.factor = factor(data_uk$hospital_inhalation_7db247,levels=c("1","0"))
data_uk$hospital_theatre_4b33c3.factor = factor(data_uk$hospital_theatre_4b33c3,levels=c("1","2","3"))
data_uk$hospital_protocol_3ff69f.factor = factor(data_uk$hospital_protocol_3ff69f,levels=c("1","0","2"))
data_uk$ambienttemp_maxtemp_5c1d38.factor = factor(data_uk$ambienttemp_maxtemp_5c1d38,levels=c("1","2","3","4","5","6","7","8","9","10","11","12","13","14"))
data_uk$ambienttemp_preferedtemp_809d8f.factor = factor(data_uk$ambienttemp_preferedtemp_809d8f,levels=c("1","2","3","4","5","6","7","8","9","10","11","12","13","14"))
data_uk$ambienttemp_maxtemp_icu_5c5d1a.factor = factor(data_uk$ambienttemp_maxtemp_icu_5c5d1a,levels=c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"))
data_uk$ambienttemp_facilities_832c30.factor = factor(data_uk$ambienttemp_facilities_832c30,levels=c("1","0","2"))
data_uk$ambienttemp_facilities_all_209310___1.factor = factor(data_uk$ambienttemp_facilities_all_209310___1,levels=c("0","1"))
data_uk$ambienttemp_facilities_all_209310___2.factor = factor(data_uk$ambienttemp_facilities_all_209310___2,levels=c("0","1"))
data_uk$ambienttemp_facilities_all_209310___3.factor = factor(data_uk$ambienttemp_facilities_all_209310___3,levels=c("0","1"))
data_uk$ambienttemp_facilities_all_209310___4.factor = factor(data_uk$ambienttemp_facilities_all_209310___4,levels=c("0","1"))
data_uk$tempcontrol_warming_9f2c7e___1.factor = factor(data_uk$tempcontrol_warming_9f2c7e___1,levels=c("0","1"))
data_uk$tempcontrol_warming_9f2c7e___2.factor = factor(data_uk$tempcontrol_warming_9f2c7e___2,levels=c("0","1"))
data_uk$tempcontrol_warming_9f2c7e___3.factor = factor(data_uk$tempcontrol_warming_9f2c7e___3,levels=c("0","1"))
data_uk$tempcontrol_warming_9f2c7e___4.factor = factor(data_uk$tempcontrol_warming_9f2c7e___4,levels=c("0","1"))
data_uk$tempcontrol_warming_9f2c7e___5.factor = factor(data_uk$tempcontrol_warming_9f2c7e___5,levels=c("0","1"))
data_uk$tempcontrol_warming_9f2c7e___6.factor = factor(data_uk$tempcontrol_warming_9f2c7e___6,levels=c("0","1"))
data_uk$tempcontrol_warming_9f2c7e___7.factor = factor(data_uk$tempcontrol_warming_9f2c7e___7,levels=c("0","1"))
data_uk$tempcontrol_warming_9f2c7e___8.factor = factor(data_uk$tempcontrol_warming_9f2c7e___8,levels=c("0","1"))
data_uk$tempcontrol_warming_9f2c7e___9.factor = factor(data_uk$tempcontrol_warming_9f2c7e___9,levels=c("0","1"))
data_uk$tempcontrol_warming_9f2c7e___10.factor = factor(data_uk$tempcontrol_warming_9f2c7e___10,levels=c("0","1"))
data_uk$tempcontrol_warming_9f2c7e___11.factor = factor(data_uk$tempcontrol_warming_9f2c7e___11,levels=c("0","1"))
data_uk$tempcontrol_warming_9f2c7e___12.factor = factor(data_uk$tempcontrol_warming_9f2c7e___12,levels=c("0","1"))
data_uk$tempcontrol_cool_a24e84___1.factor = factor(data_uk$tempcontrol_cool_a24e84___1,levels=c("0","1"))
data_uk$tempcontrol_cool_a24e84___2.factor = factor(data_uk$tempcontrol_cool_a24e84___2,levels=c("0","1"))
data_uk$tempcontrol_cool_a24e84___3.factor = factor(data_uk$tempcontrol_cool_a24e84___3,levels=c("0","1"))
data_uk$tempcontrol_cool_a24e84___4.factor = factor(data_uk$tempcontrol_cool_a24e84___4,levels=c("0","1"))
data_uk$tempcontrol_cool_a24e84___5.factor = factor(data_uk$tempcontrol_cool_a24e84___5,levels=c("0","1"))
data_uk$tempcontrol_cool_a24e84___6.factor = factor(data_uk$tempcontrol_cool_a24e84___6,levels=c("0","1"))
data_uk$tempcontrol_cool_a24e84___7.factor = factor(data_uk$tempcontrol_cool_a24e84___7,levels=c("0","1"))
data_uk$tempcontrol_cool_a24e84___8.factor = factor(data_uk$tempcontrol_cool_a24e84___8,levels=c("0","1"))
data_uk$tempcontrol_cool_a24e84___9.factor = factor(data_uk$tempcontrol_cool_a24e84___9,levels=c("0","1"))
data_uk$tempcontrol_cool_a24e84___10.factor = factor(data_uk$tempcontrol_cool_a24e84___10,levels=c("0","1"))
data_uk$tempcontrol_cool_a24e84___11.factor = factor(data_uk$tempcontrol_cool_a24e84___11,levels=c("0","1"))
data_uk$tempcontrol_measure_9fc87b___1.factor = factor(data_uk$tempcontrol_measure_9fc87b___1,levels=c("0","1"))
data_uk$tempcontrol_measure_9fc87b___2.factor = factor(data_uk$tempcontrol_measure_9fc87b___2,levels=c("0","1"))
data_uk$tempcontrol_measure_9fc87b___3.factor = factor(data_uk$tempcontrol_measure_9fc87b___3,levels=c("0","1"))
data_uk$tempcontrol_measure_9fc87b___4.factor = factor(data_uk$tempcontrol_measure_9fc87b___4,levels=c("0","1"))
data_uk$tempcontrol_measure_9fc87b___5.factor = factor(data_uk$tempcontrol_measure_9fc87b___5,levels=c("0","1"))
data_uk$tempcontrol_measure_9fc87b___6.factor = factor(data_uk$tempcontrol_measure_9fc87b___6,levels=c("0","1"))
data_uk$tempcontrol_measure_9fc87b___7.factor = factor(data_uk$tempcontrol_measure_9fc87b___7,levels=c("0","1"))
data_uk$tempcontrol_measure_9fc87b___8.factor = factor(data_uk$tempcontrol_measure_9fc87b___8,levels=c("0","1"))
data_uk$tempcontrol_measure_9fc87b___9.factor = factor(data_uk$tempcontrol_measure_9fc87b___9,levels=c("0","1"))
data_uk$tempcontrol_measure_9fc87b___10.factor = factor(data_uk$tempcontrol_measure_9fc87b___10,levels=c("0","1"))
data_uk$tempcontrol_measure_9fc87b___11.factor = factor(data_uk$tempcontrol_measure_9fc87b___11,levels=c("0","1"))
data_uk$tempcontrol_importance_961a0f.factor = factor(data_uk$tempcontrol_importance_961a0f,levels=c("1","2","3"))
data_uk$bodytempbefore_minimum_3f80ad.factor = factor(data_uk$bodytempbefore_minimum_3f80ad,levels=c("1","2","3","4","5","6","7","8","9","10","11"))
data_uk$bodytempbefore_maximum_3d8d7a.factor = factor(data_uk$bodytempbefore_maximum_3d8d7a,levels=c("1","2","3","4","5","6","7","8","9"))
data_uk$tempduring_minimum_7aaba4.factor = factor(data_uk$tempduring_minimum_7aaba4,levels=c("1","2","3","4","5","6","7","8","9","10","11","12"))
data_uk$tempduring_maximum_effc85.factor = factor(data_uk$tempduring_maximum_effc85,levels=c("1","2","3","4","5","6","7","8","9","10"))
data_uk$rct.factor = factor(data_uk$rct,levels=c("1","2","3","4"))
data_uk$optithermm_survey_complete.factor = factor(data_uk$optithermm_survey_complete,levels=c("0","1","2"))

levels(data_uk$redcap_event_name.factor)=c("Survey 1","Survey 2","Survey 3","Survey 4","Survey 5")
levels(data_uk$hospital_country_05a896.factor)=c("Australia","UK (England, Scotland, Wales, Northern Ireland)","New Zealand","..","Austria","Belgium","Bulgaria","Croatia","Cyprus","Czechia","Denmark","Estonia","Finland","France","Germany","Greece","Hungary","Ireland","Italy","Latvia","Lithuania","Luxembourg","Malta","Netherlands","New Zealand","Poland","Portugal","Romania","Scotland","Slovakia","Slovenia","Spain","Sweden","Wales","Andorra","Armenia","Azerbaijan","Belarus","Georgia","Iceland","Liechtenstein","Moldova","Monaco","Norway","Russia","San Marino","Switzerland","Ukraine","OTHER")
levels(data_uk$hospital_admit_treat_burns_8bbf40.factor)=c("Adults","Children","Adults and children")
levels(data_uk$hospital_role_e1e5f6.factor)=c("Plastic surgeon","General surgeon","Surgeon in another surgical speciality","Anaesthetist","Intensivist or critical care doctor","Other")
levels(data_uk$hospital_statements_79b57b.factor)=c("My hospital only accepts patients below a certain burn size or complexity","My hospital accepts patients with any burn size or complexity")
levels(data_uk$number_burns_to20_percent.factor)=c("0","1-5","6-10","11-15","16-20",">20","Dont know")
levels(data_uk$number_burns_to40_percent.factor)=c("0","1-5","6-10","11-15","16-20",">20","Dont know")
levels(data_uk$number_burns_to60_percent.factor)=c("0","1-5","6-10","11-15","16-20",">20","Dont know")
levels(data_uk$number_burns_to80_percent.factor)=c("0","1-5","6-10","11-15","16-20",">20","Dont know")
levels(data_uk$number_burns_to100_percent.factor)=c("0","1-5","6-10","11-15","16-20",">20","Dont know")
levels(data_uk$hospital_inhalation_7db247.factor)=c("Yes","No")
levels(data_uk$hospital_theatre_4b33c3.factor)=c("My hospital has a dedicated operating theatre that is only used for burns cases","My hospital has an operating theatre shared between burns and general plastic surgery","My hospital has an operating theatre shared between burns and other surgical specialties e.g. vascular surgery, orthopaedic surgery")
levels(data_uk$hospital_protocol_3ff69f.factor)=c("Yes","No","I dont know")
levels(data_uk$ambienttemp_maxtemp_5c1d38.factor)=c("Less than 24ºC (Less than 75ºF)","24ºC (75ºF)","25ºC (77ºF)","26ºC (79ºF)","27ºC (81ºF)","28ºC (82ºF)","29ºC (84ºF)","30ºC (86ºF)","31ºC (88ºF)","32ºC (90ºF)","33ºC (91ºF)","34ºC (93ºF)","More than 34ºC  (More than 93ºF)","I dont know")
levels(data_uk$ambienttemp_preferedtemp_809d8f.factor)=c("Less than 24ºC (Less than 75ºF)","24ºC (75ºF)","25ºC (77ºF)","26ºC (79ºF)","27ºC (81ºF)","28ºC (82ºF)","29ºC (84ºF)","30ºC (86ºF)","31ºC (88ºF)","32ºC (90ºF)","33ºC (91ºF)","34ºC (93ºF)","More than 34ºC  (More than 93ºF)","We do not have a target operating theatre temperature for burns cases")
levels(data_uk$ambienttemp_maxtemp_icu_5c5d1a.factor)=c("My hospital does not have an intensive care unit","Less than 24ºC (Less than 75ºF)","24ºC (75ºF)","25ºC (77ºF)","26ºC (79ºF)","27ºC (81ºF)","28ºC (82ºF)","29ºC (84ºF)","30ºC (86ºF)","31ºC (88ºF)","32ºC (90ºF)","33ºC (91ºF)","34ºC (93ºF)","More than 34ºC  (More than 93ºF)","I dont know")
levels(data_uk$ambienttemp_facilities_832c30.factor)=c("Yes","No","I dont know")
levels(data_uk$ambienttemp_facilities_all_209310___1.factor)=c("Unchecked","Checked")
levels(data_uk$ambienttemp_facilities_all_209310___2.factor)=c("Unchecked","Checked")
levels(data_uk$ambienttemp_facilities_all_209310___3.factor)=c("Unchecked","Checked")
levels(data_uk$ambienttemp_facilities_all_209310___4.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_warming_9f2c7e___1.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_warming_9f2c7e___2.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_warming_9f2c7e___3.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_warming_9f2c7e___4.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_warming_9f2c7e___5.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_warming_9f2c7e___6.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_warming_9f2c7e___7.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_warming_9f2c7e___8.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_warming_9f2c7e___9.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_warming_9f2c7e___10.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_warming_9f2c7e___11.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_warming_9f2c7e___12.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_cool_a24e84___1.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_cool_a24e84___2.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_cool_a24e84___3.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_cool_a24e84___4.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_cool_a24e84___5.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_cool_a24e84___6.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_cool_a24e84___7.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_cool_a24e84___8.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_cool_a24e84___9.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_cool_a24e84___10.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_cool_a24e84___11.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_measure_9fc87b___1.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_measure_9fc87b___2.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_measure_9fc87b___3.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_measure_9fc87b___4.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_measure_9fc87b___5.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_measure_9fc87b___6.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_measure_9fc87b___7.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_measure_9fc87b___8.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_measure_9fc87b___9.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_measure_9fc87b___10.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_measure_9fc87b___11.factor)=c("Unchecked","Checked")
levels(data_uk$tempcontrol_importance_961a0f.factor)=c("Absolute patient core body temperature","Absolute patient peripheral body temperature","I dont know")
levels(data_uk$bodytempbefore_minimum_3f80ad.factor)=c("Less than 32ºC (Less than 90ºF)","32ºC (90ºF)","33ºC (91ºF)","34ºC (93ºF)","35ºC (95ºF)","36ºC (97ºF)","37ºC (99ºF)","38ºC (100ºF)","39ºC (102ºF)","More than 39ºC (More than 102ºF)","We do not have a set minimum patient body temperature before starting burn surgery")
levels(data_uk$bodytempbefore_maximum_3d8d7a.factor)=c("Less than 36ºC (Less than 97ºF)","36ºC (97ºF)","37ºC (99ºF)","38ºC (100ºF)","39ºC (102ºF)","40ºC (104ºF)","41ºC (106ºF)","More than 41ºC (More than 106ºF)","We do not have a set maximum patient body temperature before starting burn surgery")
levels(data_uk$tempduring_minimum_7aaba4.factor)=c("Less than 32ºC (Less than 90ºF)","32ºC (90ºF)","33ºC (91ºF)","34ºC (93ºF)","35ºC (95ºF)","36ºC (97ºF)","37ºC (99ºF)","38ºC (100ºF)","39ºC (102ºF)","More than 39ºC (More than 102ºF)","We do not have a set minimum patient body temperature during burn surgery","I dont know")
levels(data_uk$tempduring_maximum_effc85.factor)=c("Less than 36ºC (Less than 97ºF)","36ºC (97ºF)","37ºC (99ºF)","38ºC (100ºF)","39ºC (102ºF)","40ºC (104ºF)","41ºC (106ºF)","More than 41ºC (More than 106ºF)","We do not have a set maximum patient body temperature during burn surgery","I dont know")
levels(data_uk$rct.factor)=c("Yes, in adults","Yes, in adults and children","Yes, in children","Not interested")
levels(data_uk$optithermm_survey_complete.factor)=c("Incomplete","Unverified","Complete")

# Import Australian data
#Read Data
data_anz=read.csv('data/optithermm_anz_data_2022-12-13.csv')
#Setting Labels

label(data_anz$record_id)="Record ID"
label(data_anz$redcap_event_name)="Event Name"
label(data_anz$redcap_repeat_instrument)="Repeat Instrument"
label(data_anz$redcap_repeat_instance)="Repeat Instance"
label(data_anz$redcap_survey_identifier)="Survey Identifier"
label(data_anz$optithermm_survey_timestamp)="Survey Timestamp"
label(data_anz$referral_id)="Whats the referral ID?"
label(data_anz$hospital_name_bb7995)="Please enter the name of your hospital"
label(data_anz$town_or_city_dac7f1)="In which city or town is your hospital located?"
label(data_anz$hospital_country_05a896)="In which country is your hospital located?"
label(data_anz$country_other)="Which OTHER country?"
label(data_anz$hospital_admit_treat_burns_8bbf40)="Which groups do you treat in your hospital?"
label(data_anz$hospital_role_e1e5f6)="Please select your role within the burns team:"
label(data_anz$hospital_role_other_392cc2)="Which other role?"
label(data_anz$hospital_statements_79b57b)="Which of the following statements about your hospital is true:"
label(data_anz$max_burn_size_67286f)="Please enter the maximum burn size that can be treated by your hospital as a percentage of total body surface area (TBSA). For example, if your maximum burned area is 15% TBSA, enter the number 15 in the space below."
label(data_anz$number_burns_to20_percent)="1-20%"
label(data_anz$number_burns_to40_percent)="21-40%"
label(data_anz$number_burns_to60_percent)="41-60%"
label(data_anz$number_burns_to80_percent)="61-80%"
label(data_anz$number_burns_to100_percent)="81-100%"
label(data_anz$hospital_inhalation_7db247)="Does your hospital admit and treat patients with suspected inhalation injury?"
label(data_anz$hospital_theatre_4b33c3)="Which of the following statements is true?"
label(data_anz$hospital_protocol_3ff69f)="Do you have any existing protocols or guidelines at your hospital relating to the perioperative temperature management of any burn patients?"
label(data_anz$hospital_instruction_584fc5)="We would be very grateful if you could please attach a copy of your institutional guidelines. Alternatively, you can send them to info@optithermm.org"
label(data_anz$ambienttemp_maxtemp_5c1d38)="What is the maximum temperature that can be attained in the operating theatre used for burns in your hospital?"
label(data_anz$ambienttemp_preferedtemp_809d8f)="What would be yourprefererred operating theatre target temperaturefor a major burn case in your operating theatre?"
label(data_anz$ambienttemp_maxtemp_icu_5c5d1a)="What is themaximum room temperaturethat can be attained in theintensive care unit,or equivalent unit,used for major burns patients in your hospital?"
label(data_anz$ambienttemp_facilities_832c30)="Does your hospital have any facilities with temperature regulation outside of the operating theatre?"
label(data_anz$ambienttemp_facilities_all_209310___1)="Which of the following facilities outside of the operating theatre have temperature regulation? (choice=Intensive care or critical care unit (highest level of support))"
label(data_anz$ambienttemp_facilities_all_209310___2)="Which of the following facilities outside of the operating theatre have temperature regulation? (choice=High dependency unit (or equivalent intermediate level of support))"
label(data_anz$ambienttemp_facilities_all_209310___3)="Which of the following facilities outside of the operating theatre have temperature regulation? (choice=Patient room or bed space area on burns ward (basic level of support))"
label(data_anz$ambienttemp_facilities_all_209310___4)="Which of the following facilities outside of the operating theatre have temperature regulation? (choice=Wet room or equivalent room used for dressing changes)"
label(data_anz$tempcontrol_warming_9f2c7e___1)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Heated operating theatre e.g. by means of a temperature regulated airflow)"
label(data_anz$tempcontrol_warming_9f2c7e___2)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Additional insulating layers on patient e.g. drapes, gamgee® or blankets)"
label(data_anz$tempcontrol_warming_9f2c7e___3)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Heating lamp or equivalent radiant heaters)"
label(data_anz$tempcontrol_warming_9f2c7e___4)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Convective forced-air patient warming devices e.g. Bair Hugger®)"
label(data_anz$tempcontrol_warming_9f2c7e___5)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Conductive heating device e.g. warmed mattress, pads or garment in direct contact with patient)"
label(data_anz$tempcontrol_warming_9f2c7e___6)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Warmed intravenous fluids)"
label(data_anz$tempcontrol_warming_9f2c7e___7)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Warmed topical fluids e.g. skin antiseptic or wound irrigation solutions)"
label(data_anz$tempcontrol_warming_9f2c7e___8)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Intravascular temperature controlling devices such as heated central venous line e.g. Thermogard XP®)"
label(data_anz$tempcontrol_warming_9f2c7e___9)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Oesophageal heat exchanger e.g. ensoETM®)"
label(data_anz$tempcontrol_warming_9f2c7e___10)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Haemofiltration via vascular route with circuit set to warming)"
label(data_anz$tempcontrol_warming_9f2c7e___11)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=Other)"
label(data_anz$tempcontrol_warming_9f2c7e___12)="Which methods do you use in your hospital to warm burn patients in the operating room? (choice=None of the above)"
label(data_anz$tempcontrol_warming_other_8d3367)="Which other warming method(s)?"
label(data_anz$tempcontrol_cool_a24e84___1)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=Decreasing room temperature e.g. thermostat down to minimum)"
label(data_anz$tempcontrol_cool_a24e84___2)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=Removing dressings)"
label(data_anz$tempcontrol_cool_a24e84___3)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=Convective forced air cooling device e.g. cooling fan)"
label(data_anz$tempcontrol_cool_a24e84___4)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=Conductive cooling device e.g. cooling mattress)"
label(data_anz$tempcontrol_cool_a24e84___5)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=Cooled intravenous fluids)"
label(data_anz$tempcontrol_cool_a24e84___6)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=Cooled topical fluids e.g. skin antiseptics, wound irrigation or tepid sponging)"
label(data_anz$tempcontrol_cool_a24e84___7)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=Intravascular temperature controlling devices set to cooling e.g. Coolgard ®)"
label(data_anz$tempcontrol_cool_a24e84___8)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=Oesphageal heat exchanger set to cooling)"
label(data_anz$tempcontrol_cool_a24e84___9)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=Haemofiltration via vascular route with circuit set to cooling)"
label(data_anz$tempcontrol_cool_a24e84___10)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=Other)"
label(data_anz$tempcontrol_cool_a24e84___11)="Which methodsdo you use inyour hospital tocoolburn patients in the operating room? (choice=None of the above)"
label(data_anz$tempcontrol_cooling_other_01b525)="Which other cooling method(s)?"
label(data_anz$tempcontrol_measure_9fc87b___1)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=In-ear tympanic membrane thermometer)"
label(data_anz$tempcontrol_measure_9fc87b___2)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Non-contact or infrared thermometer)"
label(data_anz$tempcontrol_measure_9fc87b___3)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Rectal thermometer or probe)"
label(data_anz$tempcontrol_measure_9fc87b___4)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Traditional glass intra-oral thermometer)"
label(data_anz$tempcontrol_measure_9fc87b___5)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Axillary thermometer or probe)"
label(data_anz$tempcontrol_measure_9fc87b___6)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Urinary bladder probe)"
label(data_anz$tempcontrol_measure_9fc87b___7)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Forehead strip thermometer)"
label(data_anz$tempcontrol_measure_9fc87b___8)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Oropharyngeal or endotracheal temperature probe)"
label(data_anz$tempcontrol_measure_9fc87b___9)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Skin temperature probe)"
label(data_anz$tempcontrol_measure_9fc87b___10)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=Other)"
label(data_anz$tempcontrol_measure_9fc87b___11)="How do you measure patient body temperature in your burn patients undergoing surgery? (choice=None of the above)"
label(data_anz$tempcontrol_measure_other_41173f)="Which other measurement method(s)?"
label(data_anz$tempcontrol_importance_961a0f)="Considering the measurement and management of patient body temperature, which of the following variables do you consider to be most clinically important?"
label(data_anz$bodytempbefore_minimum_3f80ad)="Consider a patient at your hospital who is due to undergo burn surgery. Is there aminimum body temperaturebelow which you would delay burn surgery?"
label(data_anz$bodytempbefore_maximum_3d8d7a)="Consider a patient at your hospital who is due to undergo burn surgery. Is there a maximum body temperature above which you would delay burn surgery?"
label(data_anz$tempduring_minimum_7aaba4)="At your hospital do you have a preferredminimumpatient body temperature during burns surgery?"
label(data_anz$tempduring_maximum_effc85)="Do you have a setmaximumpatient body temperature during burn surgery?"
label(data_anz$rct)="There is emerging evidence that perioperative cooling of a patient with burns may have a beneficial effect. Would you be willing to be involved in a future clinical trial testing an intervention to cool a patient?"
label(data_anz$respondentemail_f9534c)="If you would like to be sent the results of our study, please enter your email. This is entirely optional. Your email would not be used for any purpose other than to send you the results of the study.  If you would prefer not to provide your email, please skip this question.  Your email address will be kept according to General Data Protection Regulation (GDPR) and privacy regulations. Your data will only be used to communicate with you about this study. At the end of the study your details will be erased. You can remove yourself from the email list at any point by emailing info@optithermm.org"
label(data_anz$comments_feedback_7ea7f7)="If you have any comments, feedback or further information, please enter it in the box to the right. Thank you for contributing."
label(data_anz$optithermm_survey_complete)="Complete?"
#Setting Units


#Setting Factors(will create new variable for factors)
data_anz$redcap_event_name.factor = factor(data_anz$redcap_event_name,levels=c("survey_1_arm_1","survey_2_arm_1","survey_3_arm_1","survey_4_arm_1","survey_5_arm_1"))
data_anz$redcap_repeat_instrument.factor = factor(data_anz$redcap_repeat_instrument,levels=c("optithermm_survey"))
data_anz$hospital_country_05a896.factor = factor(data_anz$hospital_country_05a896,levels=c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49"))
data_anz$hospital_admit_treat_burns_8bbf40.factor = factor(data_anz$hospital_admit_treat_burns_8bbf40,levels=c("1","2","3"))
data_anz$hospital_role_e1e5f6.factor = factor(data_anz$hospital_role_e1e5f6,levels=c("1","2","3","4","5","6"))
data_anz$hospital_statements_79b57b.factor = factor(data_anz$hospital_statements_79b57b,levels=c("1","2"))
data_anz$number_burns_to20_percent.factor = factor(data_anz$number_burns_to20_percent,levels=c("1","2","3","4","5","6","7"))
data_anz$number_burns_to40_percent.factor = factor(data_anz$number_burns_to40_percent,levels=c("1","2","3","4","5","6","7"))
data_anz$number_burns_to60_percent.factor = factor(data_anz$number_burns_to60_percent,levels=c("1","2","3","4","5","6","7"))
data_anz$number_burns_to80_percent.factor = factor(data_anz$number_burns_to80_percent,levels=c("1","2","3","4","5","6","7"))
data_anz$number_burns_to100_percent.factor = factor(data_anz$number_burns_to100_percent,levels=c("1","2","3","4","5","6","7"))
data_anz$hospital_inhalation_7db247.factor = factor(data_anz$hospital_inhalation_7db247,levels=c("1","0"))
data_anz$hospital_theatre_4b33c3.factor = factor(data_anz$hospital_theatre_4b33c3,levels=c("1","2","3"))
data_anz$hospital_protocol_3ff69f.factor = factor(data_anz$hospital_protocol_3ff69f,levels=c("1","0","2"))
data_anz$ambienttemp_maxtemp_5c1d38.factor = factor(data_anz$ambienttemp_maxtemp_5c1d38,levels=c("1","2","3","4","5","6","7","8","9","10","11","12","13","14"))
data_anz$ambienttemp_preferedtemp_809d8f.factor = factor(data_anz$ambienttemp_preferedtemp_809d8f,levels=c("1","2","3","4","5","6","7","8","9","10","11","12","13","14"))
data_anz$ambienttemp_maxtemp_icu_5c5d1a.factor = factor(data_anz$ambienttemp_maxtemp_icu_5c5d1a,levels=c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"))
data_anz$ambienttemp_facilities_832c30.factor = factor(data_anz$ambienttemp_facilities_832c30,levels=c("1","0","2"))
data_anz$ambienttemp_facilities_all_209310___1.factor = factor(data_anz$ambienttemp_facilities_all_209310___1,levels=c("0","1"))
data_anz$ambienttemp_facilities_all_209310___2.factor = factor(data_anz$ambienttemp_facilities_all_209310___2,levels=c("0","1"))
data_anz$ambienttemp_facilities_all_209310___3.factor = factor(data_anz$ambienttemp_facilities_all_209310___3,levels=c("0","1"))
data_anz$ambienttemp_facilities_all_209310___4.factor = factor(data_anz$ambienttemp_facilities_all_209310___4,levels=c("0","1"))
data_anz$tempcontrol_warming_9f2c7e___1.factor = factor(data_anz$tempcontrol_warming_9f2c7e___1,levels=c("0","1"))
data_anz$tempcontrol_warming_9f2c7e___2.factor = factor(data_anz$tempcontrol_warming_9f2c7e___2,levels=c("0","1"))
data_anz$tempcontrol_warming_9f2c7e___3.factor = factor(data_anz$tempcontrol_warming_9f2c7e___3,levels=c("0","1"))
data_anz$tempcontrol_warming_9f2c7e___4.factor = factor(data_anz$tempcontrol_warming_9f2c7e___4,levels=c("0","1"))
data_anz$tempcontrol_warming_9f2c7e___5.factor = factor(data_anz$tempcontrol_warming_9f2c7e___5,levels=c("0","1"))
data_anz$tempcontrol_warming_9f2c7e___6.factor = factor(data_anz$tempcontrol_warming_9f2c7e___6,levels=c("0","1"))
data_anz$tempcontrol_warming_9f2c7e___7.factor = factor(data_anz$tempcontrol_warming_9f2c7e___7,levels=c("0","1"))
data_anz$tempcontrol_warming_9f2c7e___8.factor = factor(data_anz$tempcontrol_warming_9f2c7e___8,levels=c("0","1"))
data_anz$tempcontrol_warming_9f2c7e___9.factor = factor(data_anz$tempcontrol_warming_9f2c7e___9,levels=c("0","1"))
data_anz$tempcontrol_warming_9f2c7e___10.factor = factor(data_anz$tempcontrol_warming_9f2c7e___10,levels=c("0","1"))
data_anz$tempcontrol_warming_9f2c7e___11.factor = factor(data_anz$tempcontrol_warming_9f2c7e___11,levels=c("0","1"))
data_anz$tempcontrol_warming_9f2c7e___12.factor = factor(data_anz$tempcontrol_warming_9f2c7e___12,levels=c("0","1"))
data_anz$tempcontrol_cool_a24e84___1.factor = factor(data_anz$tempcontrol_cool_a24e84___1,levels=c("0","1"))
data_anz$tempcontrol_cool_a24e84___2.factor = factor(data_anz$tempcontrol_cool_a24e84___2,levels=c("0","1"))
data_anz$tempcontrol_cool_a24e84___3.factor = factor(data_anz$tempcontrol_cool_a24e84___3,levels=c("0","1"))
data_anz$tempcontrol_cool_a24e84___4.factor = factor(data_anz$tempcontrol_cool_a24e84___4,levels=c("0","1"))
data_anz$tempcontrol_cool_a24e84___5.factor = factor(data_anz$tempcontrol_cool_a24e84___5,levels=c("0","1"))
data_anz$tempcontrol_cool_a24e84___6.factor = factor(data_anz$tempcontrol_cool_a24e84___6,levels=c("0","1"))
data_anz$tempcontrol_cool_a24e84___7.factor = factor(data_anz$tempcontrol_cool_a24e84___7,levels=c("0","1"))
data_anz$tempcontrol_cool_a24e84___8.factor = factor(data_anz$tempcontrol_cool_a24e84___8,levels=c("0","1"))
data_anz$tempcontrol_cool_a24e84___9.factor = factor(data_anz$tempcontrol_cool_a24e84___9,levels=c("0","1"))
data_anz$tempcontrol_cool_a24e84___10.factor = factor(data_anz$tempcontrol_cool_a24e84___10,levels=c("0","1"))
data_anz$tempcontrol_cool_a24e84___11.factor = factor(data_anz$tempcontrol_cool_a24e84___11,levels=c("0","1"))
data_anz$tempcontrol_measure_9fc87b___1.factor = factor(data_anz$tempcontrol_measure_9fc87b___1,levels=c("0","1"))
data_anz$tempcontrol_measure_9fc87b___2.factor = factor(data_anz$tempcontrol_measure_9fc87b___2,levels=c("0","1"))
data_anz$tempcontrol_measure_9fc87b___3.factor = factor(data_anz$tempcontrol_measure_9fc87b___3,levels=c("0","1"))
data_anz$tempcontrol_measure_9fc87b___4.factor = factor(data_anz$tempcontrol_measure_9fc87b___4,levels=c("0","1"))
data_anz$tempcontrol_measure_9fc87b___5.factor = factor(data_anz$tempcontrol_measure_9fc87b___5,levels=c("0","1"))
data_anz$tempcontrol_measure_9fc87b___6.factor = factor(data_anz$tempcontrol_measure_9fc87b___6,levels=c("0","1"))
data_anz$tempcontrol_measure_9fc87b___7.factor = factor(data_anz$tempcontrol_measure_9fc87b___7,levels=c("0","1"))
data_anz$tempcontrol_measure_9fc87b___8.factor = factor(data_anz$tempcontrol_measure_9fc87b___8,levels=c("0","1"))
data_anz$tempcontrol_measure_9fc87b___9.factor = factor(data_anz$tempcontrol_measure_9fc87b___9,levels=c("0","1"))
data_anz$tempcontrol_measure_9fc87b___10.factor = factor(data_anz$tempcontrol_measure_9fc87b___10,levels=c("0","1"))
data_anz$tempcontrol_measure_9fc87b___11.factor = factor(data_anz$tempcontrol_measure_9fc87b___11,levels=c("0","1"))
data_anz$tempcontrol_importance_961a0f.factor = factor(data_anz$tempcontrol_importance_961a0f,levels=c("1","2","3"))
data_anz$bodytempbefore_minimum_3f80ad.factor = factor(data_anz$bodytempbefore_minimum_3f80ad,levels=c("1","2","3","4","5","6","7","8","9","10","11"))
data_anz$bodytempbefore_maximum_3d8d7a.factor = factor(data_anz$bodytempbefore_maximum_3d8d7a,levels=c("1","2","3","4","5","6","7","8","9"))
data_anz$tempduring_minimum_7aaba4.factor = factor(data_anz$tempduring_minimum_7aaba4,levels=c("1","2","3","4","5","6","7","8","9","10","11","12"))
data_anz$tempduring_maximum_effc85.factor = factor(data_anz$tempduring_maximum_effc85,levels=c("1","2","3","4","5","6","7","8","9","10"))
data_anz$rct.factor = factor(data_anz$rct,levels=c("1","2","3","4"))
data_anz$optithermm_survey_complete.factor = factor(data_anz$optithermm_survey_complete,levels=c("0","1","2"))

levels(data_anz$redcap_event_name.factor)=c("Survey 1","Survey 2","Survey 3","Survey 4","Survey 5")
levels(data_anz$redcap_repeat_instrument.factor)=c("Optithermm Survey")
levels(data_anz$hospital_country_05a896.factor)=c("Australia","UK (England, Scotland, Wales, Northern Ireland)","New Zealand","..","Austria","Belgium","Bulgaria","Croatia","Cyprus","Czechia","Denmark","Estonia","Finland","France","Germany","Greece","Hungary","Ireland","Italy","Latvia","Lithuania","Luxembourg","Malta","Netherlands","New Zealand","Poland","Portugal","Romania","Scotland","Slovakia","Slovenia","Spain","Sweden","Wales","Andorra","Armenia","Azerbaijan","Belarus","Georgia","Iceland","Liechtenstein","Moldova","Monaco","Norway","Russia","San Marino","Switzerland","Ukraine","OTHER")
levels(data_anz$hospital_admit_treat_burns_8bbf40.factor)=c("Adults","Children","Adults and children")
levels(data_anz$hospital_role_e1e5f6.factor)=c("Plastic surgeon","General surgeon","Surgeon in another surgical speciality","Anaesthetist","Intensivist or critical care doctor","Other")
levels(data_anz$hospital_statements_79b57b.factor)=c("My hospital only accepts patients below a certain burn size or complexity","My hospital accepts patients with any burn size or complexity")
levels(data_anz$number_burns_to20_percent.factor)=c("0","1-5","6-10","11-15","16-20",">20","Dont know")
levels(data_anz$number_burns_to40_percent.factor)=c("0","1-5","6-10","11-15","16-20",">20","Dont know")
levels(data_anz$number_burns_to60_percent.factor)=c("0","1-5","6-10","11-15","16-20",">20","Dont know")
levels(data_anz$number_burns_to80_percent.factor)=c("0","1-5","6-10","11-15","16-20",">20","Dont know")
levels(data_anz$number_burns_to100_percent.factor)=c("0","1-5","6-10","11-15","16-20",">20","Dont know")
levels(data_anz$hospital_inhalation_7db247.factor)=c("Yes","No")
levels(data_anz$hospital_theatre_4b33c3.factor)=c("My hospital has a dedicated operating theatre that is only used for burns cases","My hospital has an operating theatre shared between burns and general plastic surgery","My hospital has an operating theatre shared between burns and other surgical specialties e.g. vascular surgery, orthopaedic surgery")
levels(data_anz$hospital_protocol_3ff69f.factor)=c("Yes","No","I dont know")
levels(data_anz$ambienttemp_maxtemp_5c1d38.factor)=c("Less than 24ºC (Less than 75ºF)","24ºC (75ºF)","25ºC (77ºF)","26ºC (79ºF)","27ºC (81ºF)","28ºC (82ºF)","29ºC (84ºF)","30ºC (86ºF)","31ºC (88ºF)","32ºC (90ºF)","33ºC (91ºF)","34ºC (93ºF)","More than 34ºC  (More than 93ºF)","I dont know")
levels(data_anz$ambienttemp_preferedtemp_809d8f.factor)=c("Less than 24ºC (Less than 75ºF)","24ºC (75ºF)","25ºC (77ºF)","26ºC (79ºF)","27ºC (81ºF)","28ºC (82ºF)","29ºC (84ºF)","30ºC (86ºF)","31ºC (88ºF)","32ºC (90ºF)","33ºC (91ºF)","34ºC (93ºF)","More than 34ºC  (More than 93ºF)","We do not have a target operating theatre temperature for burns cases")
levels(data_anz$ambienttemp_maxtemp_icu_5c5d1a.factor)=c("My hospital does not have an intensive care unit","Less than 24ºC (Less than 75ºF)","24ºC (75ºF)","25ºC (77ºF)","26ºC (79ºF)","27ºC (81ºF)","28ºC (82ºF)","29ºC (84ºF)","30ºC (86ºF)","31ºC (88ºF)","32ºC (90ºF)","33ºC (91ºF)","34ºC (93ºF)","More than 34ºC  (More than 93ºF)","I dont know")
levels(data_anz$ambienttemp_facilities_832c30.factor)=c("Yes","No","I dont know")
levels(data_anz$ambienttemp_facilities_all_209310___1.factor)=c("Unchecked","Checked")
levels(data_anz$ambienttemp_facilities_all_209310___2.factor)=c("Unchecked","Checked")
levels(data_anz$ambienttemp_facilities_all_209310___3.factor)=c("Unchecked","Checked")
levels(data_anz$ambienttemp_facilities_all_209310___4.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_warming_9f2c7e___1.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_warming_9f2c7e___2.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_warming_9f2c7e___3.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_warming_9f2c7e___4.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_warming_9f2c7e___5.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_warming_9f2c7e___6.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_warming_9f2c7e___7.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_warming_9f2c7e___8.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_warming_9f2c7e___9.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_warming_9f2c7e___10.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_warming_9f2c7e___11.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_warming_9f2c7e___12.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_cool_a24e84___1.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_cool_a24e84___2.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_cool_a24e84___3.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_cool_a24e84___4.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_cool_a24e84___5.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_cool_a24e84___6.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_cool_a24e84___7.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_cool_a24e84___8.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_cool_a24e84___9.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_cool_a24e84___10.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_cool_a24e84___11.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_measure_9fc87b___1.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_measure_9fc87b___2.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_measure_9fc87b___3.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_measure_9fc87b___4.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_measure_9fc87b___5.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_measure_9fc87b___6.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_measure_9fc87b___7.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_measure_9fc87b___8.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_measure_9fc87b___9.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_measure_9fc87b___10.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_measure_9fc87b___11.factor)=c("Unchecked","Checked")
levels(data_anz$tempcontrol_importance_961a0f.factor)=c("Absolute patient core body temperature","Absolute patient peripheral body temperature","I dont know")
levels(data_anz$bodytempbefore_minimum_3f80ad.factor)=c("Less than 32ºC (Less than 90ºF)","32ºC (90ºF)","33ºC (91ºF)","34ºC (93ºF)","35ºC (95ºF)","36ºC (97ºF)","37ºC (99ºF)","38ºC (100ºF)","39ºC (102ºF)","More than 39ºC (More than 102ºF)","We do not have a set minimum patient body temperature before starting burn surgery")
levels(data_anz$bodytempbefore_maximum_3d8d7a.factor)=c("Less than 36ºC (Less than 97ºF)","36ºC (97ºF)","37ºC (99ºF)","38ºC (100ºF)","39ºC (102ºF)","40ºC (104ºF)","41ºC (106ºF)","More than 41ºC (More than 106ºF)","We do not have a set maximum patient body temperature before starting burn surgery")
levels(data_anz$tempduring_minimum_7aaba4.factor)=c("Less than 32ºC (Less than 90ºF)","32ºC (90ºF)","33ºC (91ºF)","34ºC (93ºF)","35ºC (95ºF)","36ºC (97ºF)","37ºC (99ºF)","38ºC (100ºF)","39ºC (102ºF)","More than 39ºC (More than 102ºF)","We do not have a set minimum patient body temperature during burn surgery","I dont know")
levels(data_anz$tempduring_maximum_effc85.factor)=c("Less than 36ºC (Less than 97ºF)","36ºC (97ºF)","37ºC (99ºF)","38ºC (100ºF)","39ºC (102ºF)","40ºC (104ºF)","41ºC (106ºF)","More than 41ºC (More than 106ºF)","We do not have a set maximum patient body temperature during burn surgery","I dont know")
levels(data_anz$rct.factor)=c("Yes, in adults","Yes, in adults and children","Yes, in children","Not interested")
levels(data_anz$optithermm_survey_complete.factor)=c("Incomplete","Unverified","Complete")

