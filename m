Return-Path: <bpf+bounces-7688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66BC77B11C
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 08:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716B6280F50
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 06:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228286AA8;
	Mon, 14 Aug 2023 06:07:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2C63B2
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 06:07:40 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3824130;
	Sun, 13 Aug 2023 23:07:39 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E5wDIA008544;
	Mon, 14 Aug 2023 06:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=RakeFN8xdX8Q8mJzFizh+TfMadxF+rWy8YJcONZPKd8=;
 b=qlLINEA/LIhOGERVCv4wD5gbiy5cLRUg0qDIOYITL/nqa0oo0oMxRWO/uSorpBIdQYq6
 ZPNgmLyC6D7loUN95NH+UtuxcslSurDJl9nVsG6zkUd2LCqpeB9u8brzM/gYKKcovmBe
 OcARaawfEoN+qJEjBZn23QpQa732A8le4F7ya9Bmgb4ibfhrKLq+Ymc3YUgQirhzu/3r
 IYCtpZgjEaXLuPm9N+bv0WPaz6cVsx3RTD4rz/wKTutVJbMQ3pgul0W/wK5PnZVsoJfV
 RhW4usk64BxMx+yLPES7FDIM+D96ZqQOqK9OZaINRezg6ahsZ977rIkZqH2cfRupBa+d /Q== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfekc04ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 06:07:29 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37E5KPEF018831;
	Mon, 14 Aug 2023 06:07:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3seq4111ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 06:07:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37E67Nli15270542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Aug 2023 06:07:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD3BF2004E;
	Mon, 14 Aug 2023 06:07:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C09D82004D;
	Mon, 14 Aug 2023 06:07:22 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Aug 2023 06:07:22 +0000 (GMT)
Received: from bgray-lenovo-p15.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id BA40B6064E;
	Mon, 14 Aug 2023 16:07:17 +1000 (AEST)
From: Benjamin Gray <bgray@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-doc@vger.kernel.org, bpf@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc: abbotti@mev.co.uk, hsweeten@visionengravers.com, jan.kiszka@siemens.com,
        kbingham@kernel.org, mykolal@fb.com,
        Benjamin Gray <bgray@linux.ibm.com>
Subject: [PATCH 7/8] selftests/bpf: fix Python string escapes
Date: Mon, 14 Aug 2023 16:07:03 +1000
Message-ID: <20230814060704.79655-8-bgray@linux.ibm.com>
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
X-Proofpoint-GUID: Fbc1edc-jH_FGc-4Wk-eSSGZXYc1ES_k
X-Proofpoint-ORIG-GUID: Fbc1edc-jH_FGc-4Wk-eSSGZXYc1ES_k
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
 .../selftests/bpf/test_bpftool_synctypes.py    | 18 +++++++++---------
 tools/testing/selftests/bpf/test_offload.py    |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_bpftool_synctypes.py b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
index 0cfece7ff4f8..b21bc1a35bf4 100755
--- a/tools/testing/selftests/bpf/test_bpftool_synctypes.py
+++ b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
@@ -80,7 +80,7 @@ class ArrayParser(BlockParser):
         Parse a block and return data as a dictionary. Items to extract must be
         on separate lines in the file.
         """
-        pattern = re.compile('\[(BPF_\w*)\]\s*= (true|false),?$')
+        pattern = re.compile('\\[(BPF_\\w*)\\]\\s*= (true|false),?$')
         entries = set()
         while True:
             line = self.reader.readline()
@@ -178,7 +178,7 @@ class FileExtractor(object):
         @enum_name: name of the enum to parse
         """
         start_marker = re.compile(f'enum {enum_name} {{\n')
-        pattern = re.compile('^\s*(BPF_\w+),?(\s+/\*.*\*/)?$')
+        pattern = re.compile('^\\s*(BPF_\\w+),?(\\s+/\\*.*\\*/)?$')
         end_marker = re.compile('^};')
         parser = BlockParser(self.reader)
         parser.search_block(start_marker)
@@ -227,7 +227,7 @@ class FileExtractor(object):
         @block_name: name of the blog to parse, 'TYPE' in the example
         """
         start_marker = re.compile(f'\*{block_name}\* := {{')
-        pattern = re.compile('\*\*([\w/-]+)\*\*')
+        pattern = re.compile('\\*\\*([\\w/-]+)\\*\\*')
         end_marker = re.compile('}\n')
         return self.__get_description_list(start_marker, pattern, end_marker)
 
@@ -246,7 +246,7 @@ class FileExtractor(object):
         @block_name: name of the blog to parse, 'TYPE' in the example
         """
         start_marker = re.compile(f'"\s*{block_name} := {{')
-        pattern = re.compile('([\w/]+) [|}]')
+        pattern = re.compile('([\\w/]+) [|}]')
         end_marker = re.compile('}')
         return self.__get_description_list(start_marker, pattern, end_marker)
 
@@ -265,7 +265,7 @@ class FileExtractor(object):
         @macro: macro starting the block, 'HELP_SPEC_OPTIONS' in the example
         """
         start_marker = re.compile(f'"\s*{macro}\s*" [|}}]')
-        pattern = re.compile('([\w-]+) ?(?:\||}[ }\]])')
+        pattern = re.compile('([\\w-]+) ?(?:\\||}[ }\\]])')
         end_marker = re.compile('}\\\\n')
         return self.__get_description_list(start_marker, pattern, end_marker)
 
@@ -284,7 +284,7 @@ class FileExtractor(object):
         @block_name: name of the blog to parse, 'TYPE' in the example
         """
         start_marker = re.compile(f'local {block_name}=\'')
-        pattern = re.compile('(?:.*=\')?([\w/]+)')
+        pattern = re.compile('(?:.*=\')?([\\w/]+)')
         end_marker = re.compile('\'$')
         return self.__get_description_list(start_marker, pattern, end_marker)
 
@@ -316,7 +316,7 @@ class MainHeaderFileExtractor(SourceFileExtractor):
             {'-p', '-d', '--pretty', '--debug', '--json', '-j'}
         """
         start_marker = re.compile(f'"OPTIONS :=')
-        pattern = re.compile('([\w-]+) ?(?:\||}[ }\]"])')
+        pattern = re.compile('([\\w-]+) ?(?:\\||}[ }\\]"])')
         end_marker = re.compile('#define')
 
         parser = InlineListParser(self.reader)
@@ -338,8 +338,8 @@ class ManSubstitutionsExtractor(SourceFileExtractor):
 
             {'-p', '-d', '--pretty', '--debug', '--json', '-j'}
         """
-        start_marker = re.compile('\|COMMON_OPTIONS\| replace:: {')
-        pattern = re.compile('\*\*([\w/-]+)\*\*')
+        start_marker = re.compile('\\|COMMON_OPTIONS\\| replace:: {')
+        pattern = re.compile('\\*\\*([\\w/-]+)\\*\\*')
         end_marker = re.compile('}$')
 
         parser = InlineListParser(self.reader)
diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index 40cba8d368d9..f7cee0d1d36e 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -429,7 +429,7 @@ class NetdevSim:
     def __init__(self, nsimdev, port_index, ifname):
         # In case udev renamed the netdev to according to new schema,
         # check if the name matches the port_index.
-        nsimnamere = re.compile("eni\d+np(\d+)")
+        nsimnamere = re.compile("eni\\d+np(\\d+)")
         match = nsimnamere.match(ifname)
         if match and int(match.groups()[0]) != port_index + 1:
             raise Exception("netdevice name mismatches the expected one")
-- 
2.41.0


