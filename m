Return-Path: <bpf+bounces-7695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE6777B14E
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 08:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F29280F92
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 06:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2FA5660;
	Mon, 14 Aug 2023 06:16:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49152185D
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 06:16:33 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02503F4;
	Sun, 13 Aug 2023 23:16:31 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E6Bkb0022430;
	Mon, 14 Aug 2023 06:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Z4fU+YYJUASo5wHESwfoB5sizpj1SLIP29KWGgkn9p4=;
 b=ZPGpBSRRsNQxbfXUWXytkgZrJ5puMr/YQbuBo+/jSurFUpKLtg/etEjz9yAmMYAAfQE6
 eCbslPsNPoQSZif2h+3C1AHCSkYWao3s9tqN1hkW7oaXGeV+3driaG4hXAH3j2ekU+FT
 vZzZwNy+ULyTpBmEgB2RWW4EBGopQ8n0RkoW8xFa9tqWTFdT2y8T9i7vBHYlsJ4yDP/Q
 pMJRL5J0GM8ukZRHhW10f+X4u63xjFiY3s3nIIcqukdtZhZ2A/l6wemZA7BIrYuWb7Zi
 psuZquyiGAvbti6n+4JFda3MZnK4jS2tstcuZHUtcbKonQCIBsopnEKJg6ZQVCRdEzEv pw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfek2g7kk-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 06:15:33 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37E4vifS013413;
	Mon, 14 Aug 2023 06:07:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sepmj97ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 06:07:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37E67NI936897134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Aug 2023 06:07:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58B5C2004F;
	Mon, 14 Aug 2023 06:07:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCA0D2004E;
	Mon, 14 Aug 2023 06:07:22 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Aug 2023 06:07:22 +0000 (GMT)
Received: from bgray-lenovo-p15.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id BDE9A60648;
	Mon, 14 Aug 2023 16:07:17 +1000 (AEST)
From: Benjamin Gray <bgray@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-doc@vger.kernel.org, bpf@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc: abbotti@mev.co.uk, hsweeten@visionengravers.com, jan.kiszka@siemens.com,
        kbingham@kernel.org, mykolal@fb.com,
        Benjamin Gray <bgray@linux.ibm.com>
Subject: [PATCH 8/8] selftests/bpf: fix Python string escapes in f-strings
Date: Mon, 14 Aug 2023 16:07:04 +1000
Message-ID: <20230814060704.79655-9-bgray@linux.ibm.com>
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
X-Proofpoint-GUID: FPckdZT2o3A_ZwQtcMaL8l2LrUWOqdaj
X-Proofpoint-ORIG-GUID: FPckdZT2o3A_ZwQtcMaL8l2LrUWOqdaj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_24,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308140055
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
 tools/testing/selftests/bpf/test_bpftool_synctypes.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_bpftool_synctypes.py b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
index b21bc1a35bf4..a93144b3b2b0 100755
--- a/tools/testing/selftests/bpf/test_bpftool_synctypes.py
+++ b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
@@ -66,7 +66,7 @@ class ArrayParser(BlockParser):
 
     def __init__(self, reader, array_name):
         self.array_name = array_name
-        self.start_marker = re.compile(f'(static )?const bool {self.array_name}\[.*\] = {{\n')
+        self.start_marker = re.compile(f'(static )?const bool {self.array_name}\\[.*\\] = {{\n')
         super().__init__(reader)
 
     def search_block(self):
@@ -226,7 +226,7 @@ class FileExtractor(object):
 
         @block_name: name of the blog to parse, 'TYPE' in the example
         """
-        start_marker = re.compile(f'\*{block_name}\* := {{')
+        start_marker = re.compile(f'\\*{block_name}\\* := {{')
         pattern = re.compile('\\*\\*([\\w/-]+)\\*\\*')
         end_marker = re.compile('}\n')
         return self.__get_description_list(start_marker, pattern, end_marker)
@@ -245,7 +245,7 @@ class FileExtractor(object):
 
         @block_name: name of the blog to parse, 'TYPE' in the example
         """
-        start_marker = re.compile(f'"\s*{block_name} := {{')
+        start_marker = re.compile(f'"\\s*{block_name} := {{')
         pattern = re.compile('([\\w/]+) [|}]')
         end_marker = re.compile('}')
         return self.__get_description_list(start_marker, pattern, end_marker)
@@ -264,7 +264,7 @@ class FileExtractor(object):
 
         @macro: macro starting the block, 'HELP_SPEC_OPTIONS' in the example
         """
-        start_marker = re.compile(f'"\s*{macro}\s*" [|}}]')
+        start_marker = re.compile(f'"\\s*{macro}\\s*" [|}}]')
         pattern = re.compile('([\\w-]+) ?(?:\\||}[ }\\]])')
         end_marker = re.compile('}\\\\n')
         return self.__get_description_list(start_marker, pattern, end_marker)
-- 
2.41.0


