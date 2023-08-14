Return-Path: <bpf+bounces-7689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFC377B11D
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 08:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39879280FB8
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 06:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B851D7477;
	Mon, 14 Aug 2023 06:07:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9090E6D24
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 06:07:41 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED89D10CE;
	Sun, 13 Aug 2023 23:07:39 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E5wBcp008423;
	Mon, 14 Aug 2023 06:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4buwukZ5Q5s/sczhLVm9BL/btmO7r3lPwlubrVtFnXA=;
 b=qQfnr+E58ivI+hFJYR9ebjzXXAhIj/10neBMkV+3nbOoVDqcX/XxtB2eC9XEhRx0TV6F
 yfDi5+YpZgIU9H4xMDFByx/XpH5QAzYcoNlIezptFSqnkK1l2SR3OdWBDZdltCfALPRB
 6iXnlUlDUZhwLZL8Kkl2C+mtsnyO0QToab/VNw87adR0kI8RHXf76Uzold5/MiSnc2Q5
 ryHAjrL11Di4Cc4KsJ0Z/0zoZIqs+J2xmCj8lxyD3Zt896omzdxQ1NY0F1bqWQygNTQb
 Z1k0CjvWLllQN27nXDKQTued+O8lvbqKfutGGYaOgn1dJbDIAXKTo1GtIZAuJRcclZ1M fA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfekc04ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 06:07:25 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37E4CvM5007832;
	Mon, 14 Aug 2023 06:07:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3senwjsg1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 06:07:23 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37E67LKx43843858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Aug 2023 06:07:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B76520040;
	Mon, 14 Aug 2023 06:07:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60C7A2004B;
	Mon, 14 Aug 2023 06:07:20 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Aug 2023 06:07:20 +0000 (GMT)
Received: from bgray-lenovo-p15.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A9D4C603C2;
	Mon, 14 Aug 2023 16:07:17 +1000 (AEST)
From: Benjamin Gray <bgray@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-doc@vger.kernel.org, bpf@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc: abbotti@mev.co.uk, hsweeten@visionengravers.com, jan.kiszka@siemens.com,
        kbingham@kernel.org, mykolal@fb.com,
        Benjamin Gray <bgray@linux.ibm.com>
Subject: [PATCH 2/8] Documentation/sphinx: fix Python string escapes
Date: Mon, 14 Aug 2023 16:06:58 +1000
Message-ID: <20230814060704.79655-3-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814060704.79655-1-bgray@linux.ibm.com>
References: <20230814060704.79655-1-bgray@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VRzP-0K8w31oeuVqJAmrHynY3iRijDCP
X-Proofpoint-ORIG-GUID: VRzP-0K8w31oeuVqJAmrHynY3iRijDCP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_24,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140055
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Python 3.6 introduced a DeprecationWarning for invalid escape sequences.
This is upgraded to a SyntaxWarning in Python 3.12, and will eventually
be a syntax error.

Fix these now to get ahead of it before it's an error.

Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
---
 Documentation/sphinx/cdomain.py             | 2 +-
 Documentation/sphinx/kernel_abi.py          | 2 +-
 Documentation/sphinx/kernel_feat.py         | 2 +-
 Documentation/sphinx/kerneldoc.py           | 2 +-
 Documentation/sphinx/maintainers_include.py | 8 ++++----
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/sphinx/cdomain.py b/Documentation/sphinx/cdomain.py
index ca8ac9e59ded..dbdc74bd0772 100644
--- a/Documentation/sphinx/cdomain.py
+++ b/Documentation/sphinx/cdomain.py
@@ -93,7 +93,7 @@ def markup_ctype_refs(match):
 #
 RE_expr = re.compile(r':c:(expr|texpr):`([^\`]+)`')
 def markup_c_expr(match):
-    return '\ ``' + match.group(2) + '``\ '
+    return '\\ ``' + match.group(2) + '``\\ '
 
 #
 # Parse Sphinx 3.x C markups, replacing them by backward-compatible ones
diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index b5feb5b1d905..b9f026f016fd 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -138,7 +138,7 @@ class KernelCmd(Directive):
                 code_block += "\n    " + l
             lines = code_block + "\n\n"
 
-        line_regex = re.compile("^\.\. LINENO (\S+)\#([0-9]+)$")
+        line_regex = re.compile("^\\.\\. LINENO (\\S+)\\#([0-9]+)$")
         ln = 0
         n = 0
         f = fname
diff --git a/Documentation/sphinx/kernel_feat.py b/Documentation/sphinx/kernel_feat.py
index 27b701ed3681..d17adc1a367a 100644
--- a/Documentation/sphinx/kernel_feat.py
+++ b/Documentation/sphinx/kernel_feat.py
@@ -104,7 +104,7 @@ class KernelFeat(Directive):
 
         lines = self.runCmd(cmd, shell=True, cwd=cwd, env=shell_env)
 
-        line_regex = re.compile("^\.\. FILE (\S+)$")
+        line_regex = re.compile("^\\.\\. FILE (\\S+)$")
 
         out_lines = ""
 
diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 9395892c7ba3..d6ec34ce2232 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -130,7 +130,7 @@ class KernelDocDirective(Directive):
             result = ViewList()
 
             lineoffset = 0;
-            line_regex = re.compile("^\.\. LINENO ([0-9]+)$")
+            line_regex = re.compile("^\\.\\. LINENO ([0-9]+)$")
             for line in lines:
                 match = line_regex.search(line)
                 if match:
diff --git a/Documentation/sphinx/maintainers_include.py b/Documentation/sphinx/maintainers_include.py
index 328b3631a585..73be47963153 100755
--- a/Documentation/sphinx/maintainers_include.py
+++ b/Documentation/sphinx/maintainers_include.py
@@ -77,7 +77,7 @@ class MaintainersInclude(Include):
             line = line.rstrip()
 
             # Linkify all non-wildcard refs to ReST files in Documentation/.
-            pat = '(Documentation/([^\s\?\*]*)\.rst)'
+            pat = '(Documentation/([^\\s\\?\\*]*)\\.rst)'
             m = re.search(pat, line)
             if m:
                 # maintainers.rst is in a subdirectory, so include "../".
@@ -90,11 +90,11 @@ class MaintainersInclude(Include):
                 output = "| %s" % (line.replace("\\", "\\\\"))
                 # Look for and record field letter to field name mappings:
                 #   R: Designated *reviewer*: FullName <address@domain>
-                m = re.search("\s(\S):\s", line)
+                m = re.search("\\s(\\S):\\s", line)
                 if m:
                     field_letter = m.group(1)
                 if field_letter and not field_letter in fields:
-                    m = re.search("\*([^\*]+)\*", line)
+                    m = re.search("\\*([^\\*]+)\\*", line)
                     if m:
                         fields[field_letter] = m.group(1)
             elif subsystems:
@@ -112,7 +112,7 @@ class MaintainersInclude(Include):
                     field_content = ""
 
                     # Collapse whitespace in subsystem name.
-                    heading = re.sub("\s+", " ", line)
+                    heading = re.sub("\\s+", " ", line)
                     output = output + "%s\n%s" % (heading, "~" * len(heading))
                     field_prev = ""
                 else:
-- 
2.41.0


