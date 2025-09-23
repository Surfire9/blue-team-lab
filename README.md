# Blue Team Lab 🛡️

This repository documents my journey into **Blue Team cybersecurity** — from TryHackMe basics to SOC analyst skills, home labs, and detection playbooks.

## 📌 Sections
- **01-THM-Basics/** → Notes & screenshots from foundational TryHackMe rooms.
- **02-SOC-L1/** → Incident reports, Splunk/ELK queries, alert triage practice.
- **03-Home-Lab/** → Setup & experiments with Wazuh / Security Onion.
- **04-Projects/** → Detection playbooks & small security projects.
- **05-Resources/** → Study notes, certification prep, resume snippets.

## 🚀 Goal
To build practical, demonstrable skills for SOC/Blue Team roles, and maintain a professional portfolio of work.






## 🔮 Planned Features / Roadmap

- [ ] **Automation** 
  - Add pre-commit hook to run `tools/sanitize.sh` automatically 
  - Create `tools/redact.sh` for quick log sanitization (replace IPs, usernames, creds) 

- [ ] **Detection Playbooks** 
  - Add phishing email detection playbook (MITRE ATT&CK T1566) 
  - Add ransomware detection playbook (file entropy spikes, shadow copy deletion) 
  - Add persistence detection playbook (scheduled tasks, autoruns, new services) 

- [ ] **SOC Artifacts** 
  - Publish at least 3 incident reports from TryHackMe SOC labs 
  - Add Splunk queries for brute force, privilege escalation, and lateral movement 
  - Create ELK stack queries for Windows Event Logs (e.g., 4624/4625 login patterns) 

- [ ] **Home Lab Documentation** 
  - Write detailed Wazuh deployment guide (agent + manager setup) 
  - Document Security Onion deployment and alert triage steps 
  - Add diagrams of network/lab topology 

- [ ] **Projects** 
  - Build sample SIEM dashboard (visualizing SSH brute force trends) 
  - Create small “Threat Hunting” case study using real lab data 
  - Add malware lab notes (sanitized static/dynamic analysis) 

- [ ] **Resources** 
  - Expand certification prep notes (Security+, CySA+, Splunk Fundamentals) 
  - Curate MITRE ATT&CK navigator layers for lab detections 
  - Add references for continuous learning (blogs, podcasts, labs)
