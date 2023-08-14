Return-Path: <bpf+bounces-7691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFDB77B127
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 08:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B55C1C2092F
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 06:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37AC8484;
	Mon, 14 Aug 2023 06:07:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEDE846D
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 06:07:42 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ABB13E;
	Sun, 13 Aug 2023 23:07:40 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E5wCmj008513;
	Mon, 14 Aug 2023 06:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JGHbwUDwCZJLL1E8eoR5git6klTdwxNmSfECAAz5V1E=;
 b=r34X1OCHrEgOz9K0r05KOymawtz024UgtSaEDUwhkBpHnS0VLqInOx3gbbTXWzr0TMwE
 BWAEHjSKE+K1ilU+IoMjqQY2ADE90ACOFki14mQzEsCwS2ZoUw+vYuXQLyh1rmlcnygP
 mYjdAVUpdeDXMO7lxjNbFEyH82IGvAFn9E8IYSWoBgGCdIGaNZcJapg8rKCDtjmei/fz
 ruZ6fDrzwbihWsBqaliKTGsBQDttLP5lsQAhaOMyH/NZscvu/WdZCMNOFQ8tQocWBrbx
 jH2WZxjQPSJW6/sVYpa++B79q0yp7LlUXTPRawnEVtg9viSasutJ2SIzikU2eG1fNr8B eA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfekc04mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 06:07:27 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37E5Qeb0001085;
	Mon, 14 Aug 2023 06:07:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3semsxt0fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 06:07:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37E67NYM6947448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Aug 2023 06:07:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF6502006B;
	Mon, 14 Aug 2023 06:07:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C40A020043;
	Mon, 14 Aug 2023 06:07:22 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Aug 2023 06:07:22 +0000 (GMT)
Received: from bgray-lenovo-p15.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B3CE56056F;
	Mon, 14 Aug 2023 16:07:17 +1000 (AEST)
From: Benjamin Gray <bgray@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-doc@vger.kernel.org, bpf@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc: abbotti@mev.co.uk, hsweeten@visionengravers.com, jan.kiszka@siemens.com,
        kbingham@kernel.org, mykolal@fb.com,
        Benjamin Gray <bgray@linux.ibm.com>
Subject: [PATCH 5/8] tools/perf: fix Python string escapes
Date: Mon, 14 Aug 2023 16:07:01 +1000
Message-ID: <20230814060704.79655-6-bgray@linux.ibm.com>
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
X-Proofpoint-GUID: HrmY5_qpjsyApIPopT-sKiqX1VVbc-D7
X-Proofpoint-ORIG-GUID: HrmY5_qpjsyApIPopT-sKiqX1VVbc-D7
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
 tools/perf/pmu-events/jevents.py                 | 2 +-
 tools/perf/scripts/python/arm-cs-trace-disasm.py | 4 ++--
 tools/perf/scripts/python/compaction-times.py    | 2 +-
 tools/perf/scripts/python/exported-sql-viewer.py | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 12e80bb7939b..87964bf32b62 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -83,7 +83,7 @@ def c_len(s: str) -> int:
   """Return the length of s a C string
 
   This doesn't handle all escape characters properly. It first assumes
-  all \ are for escaping, it then adjusts as it will have over counted
+  all \\ are for escaping, it then adjusts as it will have over counted
   \\. The code uses \000 rather than \0 as a terminator as an adjacent
   number would be folded into a string of \0 (ie. "\0" + "5" doesn't
   equal a terminator followed by the number 5 but the escape of
diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index d59ff53f1d94..cbd866acef2f 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -45,8 +45,8 @@ parser = OptionParser(option_list=option_list)
 # Initialize global dicts and regular expression
 disasm_cache = dict()
 cpu_data = dict()
-disasm_re = re.compile("^\s*([0-9a-fA-F]+):")
-disasm_func_re = re.compile("^\s*([0-9a-fA-F]+)\s.*:")
+disasm_re = re.compile("^\\s*([0-9a-fA-F]+):")
+disasm_func_re = re.compile("^\\s*([0-9a-fA-F]+)\\s.*:")
 cache_size = 64*1024
 
 glb_source_file_name	= None
diff --git a/tools/perf/scripts/python/compaction-times.py b/tools/perf/scripts/python/compaction-times.py
index 2560a042dc6f..b75d90ffb194 100644
--- a/tools/perf/scripts/python/compaction-times.py
+++ b/tools/perf/scripts/python/compaction-times.py
@@ -260,7 +260,7 @@ def pr_help():
 
 comm_re = None
 pid_re = None
-pid_regex = "^(\d*)-(\d*)$|^(\d*)$"
+pid_regex = "^(\\d*)-(\\d*)$|^(\\d*)$"
 
 opt_proc = popt.DISP_DFL
 opt_disp = topt.DISP_ALL
diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 13f2d8a81610..121cf61ba1b3 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -677,8 +677,8 @@ class CallGraphModelBase(TreeModel):
 			#   sqlite supports GLOB (text only) which uses * and ? and is case sensitive
 			if not self.glb.dbref.is_sqlite3:
 				# Escape % and _
-				s = value.replace("%", "\%")
-				s = s.replace("_", "\_")
+				s = value.replace("%", "\\%")
+				s = s.replace("_", "\\_")
 				# Translate * and ? into SQL LIKE pattern characters % and _
 				trans = string.maketrans("*?", "%_")
 				match = " LIKE '" + str(s).translate(trans) + "'"
-- 
2.41.0


