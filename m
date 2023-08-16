Return-Path: <bpf+bounces-7892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66AC77E164
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 14:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E80F1C21014
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 12:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2CF107BF;
	Wed, 16 Aug 2023 12:22:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4A8DF57;
	Wed, 16 Aug 2023 12:22:42 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801A92D47;
	Wed, 16 Aug 2023 05:22:13 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GCI0Mt023293;
	Wed, 16 Aug 2023 12:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=q9AhJjcwrKeKKfGXDoGS/fZRNNeZiPjnBnZlx49JZZE=;
 b=CQAt3X8kxN2EAREku8sHa9gObXjlHFW/wJy6cootO8gNEDmnGdBOjeS9LBzokrLCjArD
 IYQgpqo9se7TDorSprHXFQm87bgOtFewMW7rzSUvB4u+Fi1IrqcjslC8jEvHY5zxaO/y
 PP9tulkwOJQE8IEWSi5EN1nAw46LhaneKuSugbVBCdBsxZiTx9jKmL/t4pgY51fkKbJY
 +Bj5Ghf7Kv/4IEl8z6jpBda0N3F6+MnIb/DVAVY0k43ZX30G+XikNHAPqB6h2FvoYu1V
 vFYfPbZP2s94EQuVpLi9Yp44MFhKH51lkxxCMJb5VP8wy47hJO2f1olec7BSx2sYgLTz NA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sgx048mmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Aug 2023 12:21:48 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37GCB4UD021895;
	Wed, 16 Aug 2023 12:21:48 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sgx048mme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Aug 2023 12:21:48 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37GAL6On003446;
	Wed, 16 Aug 2023 12:21:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3semdsmjfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Aug 2023 12:21:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37GCLhhI11600392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Aug 2023 12:21:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD50920040;
	Wed, 16 Aug 2023 12:21:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D51D82004B;
	Wed, 16 Aug 2023 12:21:39 +0000 (GMT)
Received: from li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.in.ibm.com (unknown [9.204.206.180])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Aug 2023 12:21:39 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: srikar@linux.vnet.ibm.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, haoluo@google.com,
        hawk@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, netdev@vger.kernel.org, sachinp@linux.ibm.com,
        sdf@google.com, song@kernel.org, yhs@fb.com, vishalc@linux.ibm.com
Subject: [PATCH] Fix invalid escape sequence warnings
Date: Wed, 16 Aug 2023 17:51:33 +0530
Message-Id: <20230816122133.1231599-1-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230811084739.GY3902@linux.vnet.ibm.com>
References: <20230811084739.GY3902@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ni1vr0Yufmq6LHza8J1mtIR-9onUPdgp
X-Proofpoint-GUID: FVG1B_V01_11AQzXP3Jz7yX5Vf0G_Skp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_10,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308160105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The Python script `bpf_doc.py` uses regular expressions with
backslashes in string literals, which results in SyntaxWarnings
during its execution.

This patch addresses these warnings by converting relevant string
literals to raw strings, which interpret backslashes as literal
characters. This ensures that the regular expressions are parsed
correctly without causing any warnings.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

---
 scripts/bpf_doc.py | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index eaae2ce78381..dfd819c952b2 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -59,9 +59,9 @@ class Helper(APIElement):
         Break down helper function protocol into smaller chunks: return type,
         name, distincts arguments.
         """
-        arg_re = re.compile('((\w+ )*?(\w+|...))( (\**)(\w+))?$')
+        arg_re = re.compile(r'((\w+ )*?(\w+|...))( (\**)(\w+))?$')
         res = {}
-        proto_re = re.compile('(.+) (\**)(\w+)\(((([^,]+)(, )?){1,5})\)$')
+        proto_re = re.compile(r'(.+) (\**)(\w+)\(((([^,]+)(, )?){1,5})\)$')
 
         capture = proto_re.match(self.proto)
         res['ret_type'] = capture.group(1)
@@ -114,11 +114,11 @@ class HeaderParser(object):
         return Helper(proto=proto, desc=desc, ret=ret)
 
     def parse_symbol(self):
-        p = re.compile(' \* ?(BPF\w+)$')
+        p = re.compile(r' \* ?(BPF\w+)$')
         capture = p.match(self.line)
         if not capture:
             raise NoSyscallCommandFound
-        end_re = re.compile(' \* ?NOTES$')
+        end_re = re.compile(r' \* ?NOTES$')
         end = end_re.match(self.line)
         if end:
             raise NoSyscallCommandFound
@@ -133,7 +133,7 @@ class HeaderParser(object):
         #   - Same as above, with "const" and/or "struct" in front of type
         #   - "..." (undefined number of arguments, for bpf_trace_printk())
         # There is at least one term ("void"), and at most five arguments.
-        p = re.compile(' \* ?((.+) \**\w+\((((const )?(struct )?(\w+|\.\.\.)( \**\w+)?)(, )?){1,5}\))$')
+        p = re.compile(r' \* ?((.+) \**\w+\((((const )?(struct )?(\w+|\.\.\.)( \**\w+)?)(, )?){1,5}\))$')
         capture = p.match(self.line)
         if not capture:
             raise NoHelperFound
@@ -141,7 +141,7 @@ class HeaderParser(object):
         return capture.group(1)
 
     def parse_desc(self, proto):
-        p = re.compile(' \* ?(?:\t| {5,8})Description$')
+        p = re.compile(r' \* ?(?:\t| {5,8})Description$')
         capture = p.match(self.line)
         if not capture:
             raise Exception("No description section found for " + proto)
@@ -154,7 +154,7 @@ class HeaderParser(object):
             if self.line == ' *\n':
                 desc += '\n'
             else:
-                p = re.compile(' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
+                p = re.compile(r' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
                 capture = p.match(self.line)
                 if capture:
                     desc_present = True
@@ -167,7 +167,7 @@ class HeaderParser(object):
         return desc
 
     def parse_ret(self, proto):
-        p = re.compile(' \* ?(?:\t| {5,8})Return$')
+        p = re.compile(r' \* ?(?:\t| {5,8})Return$')
         capture = p.match(self.line)
         if not capture:
             raise Exception("No return section found for " + proto)
@@ -180,7 +180,7 @@ class HeaderParser(object):
             if self.line == ' *\n':
                 ret += '\n'
             else:
-                p = re.compile(' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
+                p = re.compile(r' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
                 capture = p.match(self.line)
                 if capture:
                     ret_present = True
@@ -219,12 +219,12 @@ class HeaderParser(object):
         self.seek_to('enum bpf_cmd {',
                      'Could not find start of bpf_cmd enum', 0)
         # Searches for either one or more BPF\w+ enums
-        bpf_p = re.compile('\s*(BPF\w+)+')
+        bpf_p = re.compile(r'\s*(BPF\w+)+')
         # Searches for an enum entry assigned to another entry,
         # for e.g. BPF_PROG_RUN = BPF_PROG_TEST_RUN, which is
         # not documented hence should be skipped in check to
         # determine if the right number of syscalls are documented
-        assign_p = re.compile('\s*(BPF\w+)\s*=\s*(BPF\w+)')
+        assign_p = re.compile(r'\s*(BPF\w+)\s*=\s*(BPF\w+)')
         bpf_cmd_str = ''
         while True:
             capture = assign_p.match(self.line)
@@ -239,7 +239,7 @@ class HeaderParser(object):
                 break
             self.line = self.reader.readline()
         # Find the number of occurences of BPF\w+
-        self.enum_syscalls = re.findall('(BPF\w+)+', bpf_cmd_str)
+        self.enum_syscalls = re.findall(r'(BPF\w+)+', bpf_cmd_str)
 
     def parse_desc_helpers(self):
         self.seek_to(helpersDocStart,
@@ -263,7 +263,7 @@ class HeaderParser(object):
         self.seek_to('#define ___BPF_FUNC_MAPPER(FN, ctx...)',
                      'Could not find start of eBPF helper definition list')
         # Searches for one FN(\w+) define or a backslash for newline
-        p = re.compile('\s*FN\((\w+), (\d+), ##ctx\)|\\\\')
+        p = re.compile(r'\s*FN\((\w+), (\d+), ##ctx\)|\\\\')
         fn_defines_str = ''
         i = 0
         while True:
@@ -278,7 +278,7 @@ class HeaderParser(object):
                 break
             self.line = self.reader.readline()
         # Find the number of occurences of FN(\w+)
-        self.define_unique_helpers = re.findall('FN\(\w+, \d+, ##ctx\)', fn_defines_str)
+        self.define_unique_helpers = re.findall(r'FN\(\w+, \d+, ##ctx\)', fn_defines_str)
 
     def validate_helpers(self):
         last_helper = ''
@@ -425,7 +425,7 @@ class PrinterRST(Printer):
         try:
             cmd = ['git', 'log', '-1', '--pretty=format:%cs', '--no-patch',
                    '-L',
-                   '/{}/,/\*\//:include/uapi/linux/bpf.h'.format(delimiter)]
+                   r'/{}/,/\*\//:include/uapi/linux/bpf.h'.format(delimiter)]
             date = subprocess.run(cmd, cwd=linuxRoot,
                                   capture_output=True, check=True)
             return date.stdout.decode().rstrip()
@@ -496,7 +496,7 @@ HELPERS
                             date=lastUpdate))
 
     def print_footer(self):
-        footer = '''
+        footer = r'''
 EXAMPLES
 ========
 
@@ -598,7 +598,7 @@ SEE ALSO
             one_arg = '{}{}'.format(comma, a['type'])
             if a['name']:
                 if a['star']:
-                    one_arg += ' {}**\ '.format(a['star'].replace('*', '\\*'))
+                    one_arg += r' {}**\ '.format(a['star'].replace('*', '\\*'))
                 else:
                     one_arg += '** '
                 one_arg += '*{}*\\ **'.format(a['name'])
-- 
2.41.0


