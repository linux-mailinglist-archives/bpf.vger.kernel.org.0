Return-Path: <bpf+bounces-7692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 115C077B13C
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 08:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338AF1C2099B
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 06:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F39881E;
	Mon, 14 Aug 2023 06:07:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AC6846D
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 06:07:46 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04DD10D0;
	Sun, 13 Aug 2023 23:07:43 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E63RkV005694;
	Mon, 14 Aug 2023 06:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KCClE1Pg9KTc+d/BWRyMuSCzOTTnUY58PaLYLhLAO0M=;
 b=lSt01/R3eBZhJREChxdEVRzN/1ZzKiPAj7496FRMUXKxQiU7kskJRI8ypIrrX8pFKkOW
 54XRomaixzqIawWBgmarqMkQJWqrsgC0wqEfoa4EFGaiIyEmZw5EFrpHfYQB5abWuf1s
 n/8Zdy3kpc1OQNamZWxHTFjFnhsU5+VbeW2zjCjz6iEORgaYfoKUrjnqkVZv2Ud9kxov
 k3jRcX8LSnZ8E2xPwY7ZqIySCYrAXxwsvv6LNfLORquQBD7pS0htnZQHZu+oPq2PDUJo
 JEjPn6f1yhFdde4EyB7jkLsgq0lKV+S1Fp7ENmT27NN2e7KV+6TD77uS3LQGra0+4QC3 gA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfenqrf8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 06:07:26 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37E5Qeaw001085;
	Mon, 14 Aug 2023 06:07:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3semsxt0fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 06:07:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37E67LNp65339718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Aug 2023 06:07:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63B272004F;
	Mon, 14 Aug 2023 06:07:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 665CE20040;
	Mon, 14 Aug 2023 06:07:20 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Aug 2023 06:07:20 +0000 (GMT)
Received: from bgray-lenovo-p15.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B03106058C;
	Mon, 14 Aug 2023 16:07:17 +1000 (AEST)
From: Benjamin Gray <bgray@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-doc@vger.kernel.org, bpf@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc: abbotti@mev.co.uk, hsweeten@visionengravers.com, jan.kiszka@siemens.com,
        kbingham@kernel.org, mykolal@fb.com,
        Benjamin Gray <bgray@linux.ibm.com>
Subject: [PATCH 4/8] scripts: fix Python string escapes
Date: Mon, 14 Aug 2023 16:07:00 +1000
Message-ID: <20230814060704.79655-5-bgray@linux.ibm.com>
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
X-Proofpoint-GUID: MY4z4XD1yCu9hVbBz-meb3h3AUQKcBrt
X-Proofpoint-ORIG-GUID: MY4z4XD1yCu9hVbBz-meb3h3AUQKcBrt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_24,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
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
 scripts/bpf_doc.py                          | 56 ++++++++++-----------
 scripts/clang-tools/gen_compile_commands.py |  2 +-
 scripts/gdb/linux/symbols.py                |  2 +-
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index eaae2ce78381..40a2643f94d2 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -59,9 +59,9 @@ class Helper(APIElement):
         Break down helper function protocol into smaller chunks: return type,
         name, distincts arguments.
         """
-        arg_re = re.compile('((\w+ )*?(\w+|...))( (\**)(\w+))?$')
+        arg_re = re.compile('((\\w+ )*?(\\w+|...))( (\\**)(\\w+))?$')
         res = {}
-        proto_re = re.compile('(.+) (\**)(\w+)\(((([^,]+)(, )?){1,5})\)$')
+        proto_re = re.compile('(.+) (\\**)(\\w+)\\(((([^,]+)(, )?){1,5})\\)$')
 
         capture = proto_re.match(self.proto)
         res['ret_type'] = capture.group(1)
@@ -114,11 +114,11 @@ class HeaderParser(object):
         return Helper(proto=proto, desc=desc, ret=ret)
 
     def parse_symbol(self):
-        p = re.compile(' \* ?(BPF\w+)$')
+        p = re.compile(' \\* ?(BPF\\w+)$')
         capture = p.match(self.line)
         if not capture:
             raise NoSyscallCommandFound
-        end_re = re.compile(' \* ?NOTES$')
+        end_re = re.compile(' \\* ?NOTES$')
         end = end_re.match(self.line)
         if end:
             raise NoSyscallCommandFound
@@ -133,7 +133,7 @@ class HeaderParser(object):
         #   - Same as above, with "const" and/or "struct" in front of type
         #   - "..." (undefined number of arguments, for bpf_trace_printk())
         # There is at least one term ("void"), and at most five arguments.
-        p = re.compile(' \* ?((.+) \**\w+\((((const )?(struct )?(\w+|\.\.\.)( \**\w+)?)(, )?){1,5}\))$')
+        p = re.compile(' \\* ?((.+) \\**\\w+\\((((const )?(struct )?(\\w+|\\.\\.\\.)( \\**\\w+)?)(, )?){1,5}\\))$')
         capture = p.match(self.line)
         if not capture:
             raise NoHelperFound
@@ -141,7 +141,7 @@ class HeaderParser(object):
         return capture.group(1)
 
     def parse_desc(self, proto):
-        p = re.compile(' \* ?(?:\t| {5,8})Description$')
+        p = re.compile(' \\* ?(?:\t| {5,8})Description$')
         capture = p.match(self.line)
         if not capture:
             raise Exception("No description section found for " + proto)
@@ -154,7 +154,7 @@ class HeaderParser(object):
             if self.line == ' *\n':
                 desc += '\n'
             else:
-                p = re.compile(' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
+                p = re.compile(' \\* ?(?:\t| {5,8})(?:\t| {8})(.*)')
                 capture = p.match(self.line)
                 if capture:
                     desc_present = True
@@ -167,7 +167,7 @@ class HeaderParser(object):
         return desc
 
     def parse_ret(self, proto):
-        p = re.compile(' \* ?(?:\t| {5,8})Return$')
+        p = re.compile(' \\* ?(?:\t| {5,8})Return$')
         capture = p.match(self.line)
         if not capture:
             raise Exception("No return section found for " + proto)
@@ -180,7 +180,7 @@ class HeaderParser(object):
             if self.line == ' *\n':
                 ret += '\n'
             else:
-                p = re.compile(' \* ?(?:\t| {5,8})(?:\t| {8})(.*)')
+                p = re.compile(' \\* ?(?:\t| {5,8})(?:\t| {8})(.*)')
                 capture = p.match(self.line)
                 if capture:
                     ret_present = True
@@ -219,12 +219,12 @@ class HeaderParser(object):
         self.seek_to('enum bpf_cmd {',
                      'Could not find start of bpf_cmd enum', 0)
         # Searches for either one or more BPF\w+ enums
-        bpf_p = re.compile('\s*(BPF\w+)+')
+        bpf_p = re.compile('\\s*(BPF\\w+)+')
         # Searches for an enum entry assigned to another entry,
         # for e.g. BPF_PROG_RUN = BPF_PROG_TEST_RUN, which is
         # not documented hence should be skipped in check to
         # determine if the right number of syscalls are documented
-        assign_p = re.compile('\s*(BPF\w+)\s*=\s*(BPF\w+)')
+        assign_p = re.compile('\\s*(BPF\\w+)\\s*=\\s*(BPF\\w+)')
         bpf_cmd_str = ''
         while True:
             capture = assign_p.match(self.line)
@@ -239,7 +239,7 @@ class HeaderParser(object):
                 break
             self.line = self.reader.readline()
         # Find the number of occurences of BPF\w+
-        self.enum_syscalls = re.findall('(BPF\w+)+', bpf_cmd_str)
+        self.enum_syscalls = re.findall('(BPF\\w+)+', bpf_cmd_str)
 
     def parse_desc_helpers(self):
         self.seek_to(helpersDocStart,
@@ -263,7 +263,7 @@ class HeaderParser(object):
         self.seek_to('#define ___BPF_FUNC_MAPPER(FN, ctx...)',
                      'Could not find start of eBPF helper definition list')
         # Searches for one FN(\w+) define or a backslash for newline
-        p = re.compile('\s*FN\((\w+), (\d+), ##ctx\)|\\\\')
+        p = re.compile('\\s*FN\\((\\w+), (\\d+), ##ctx\\)|\\\\')
         fn_defines_str = ''
         i = 0
         while True:
@@ -278,7 +278,7 @@ class HeaderParser(object):
                 break
             self.line = self.reader.readline()
         # Find the number of occurences of FN(\w+)
-        self.define_unique_helpers = re.findall('FN\(\w+, \d+, ##ctx\)', fn_defines_str)
+        self.define_unique_helpers = re.findall('FN\\(\\w+, \\d+, ##ctx\\)', fn_defines_str)
 
     def validate_helpers(self):
         last_helper = ''
@@ -425,7 +425,7 @@ class PrinterRST(Printer):
         try:
             cmd = ['git', 'log', '-1', '--pretty=format:%cs', '--no-patch',
                    '-L',
-                   '/{}/,/\*\//:include/uapi/linux/bpf.h'.format(delimiter)]
+                   '/{}/,/\\*\\//:include/uapi/linux/bpf.h'.format(delimiter)]
             date = subprocess.run(cmd, cwd=linuxRoot,
                                   capture_output=True, check=True)
             return date.stdout.decode().rstrip()
@@ -516,7 +516,7 @@ as "Dual BSD/GPL", may be used). Some helper functions are only accessible to
 programs that are compatible with the GNU Privacy License (GPL).
 
 In order to use such helpers, the eBPF program must be loaded with the correct
-license string passed (via **attr**) to the **bpf**\ () system call, and this
+license string passed (via **attr**) to the **bpf**\\ () system call, and this
 generally translates into the C source code of the program containing a line
 similar to the following:
 
@@ -550,7 +550,7 @@ may be interested in:
 * The bpftool utility can be used to probe the availability of helper functions
   on the system (as well as supported program and map types, and a number of
   other parameters). To do so, run **bpftool feature probe** (see
-  **bpftool-feature**\ (8) for details). Add the **unprivileged** keyword to
+  **bpftool-feature**\\ (8) for details). Add the **unprivileged** keyword to
   list features available to unprivileged users.
 
 Compatibility between helper functions and program types can generally be found
@@ -562,23 +562,23 @@ other functions, themselves allowing access to additional helpers. The
 requirement for GPL license is also in those **struct bpf_func_proto**.
 
 Compatibility between helper functions and map types can be found in the
-**check_map_func_compatibility**\ () function in file *kernel/bpf/verifier.c*.
+**check_map_func_compatibility**\\ () function in file *kernel/bpf/verifier.c*.
 
 Helper functions that invalidate the checks on **data** and **data_end**
 pointers for network processing are listed in function
-**bpf_helper_changes_pkt_data**\ () in file *net/core/filter.c*.
+**bpf_helper_changes_pkt_data**\\ () in file *net/core/filter.c*.
 
 SEE ALSO
 ========
 
-**bpf**\ (2),
-**bpftool**\ (8),
-**cgroups**\ (7),
-**ip**\ (8),
-**perf_event_open**\ (2),
-**sendmsg**\ (2),
-**socket**\ (7),
-**tc-bpf**\ (8)'''
+**bpf**\\ (2),
+**bpftool**\\ (8),
+**cgroups**\\ (7),
+**ip**\\ (8),
+**perf_event_open**\\ (2),
+**sendmsg**\\ (2),
+**socket**\\ (7),
+**tc-bpf**\\ (8)'''
         print(footer)
 
     def print_proto(self, helper):
@@ -598,7 +598,7 @@ SEE ALSO
             one_arg = '{}{}'.format(comma, a['type'])
             if a['name']:
                 if a['star']:
-                    one_arg += ' {}**\ '.format(a['star'].replace('*', '\\*'))
+                    one_arg += ' {}**\\ '.format(a['star'].replace('*', '\\*'))
                 else:
                     one_arg += '** '
                 one_arg += '*{}*\\ **'.format(a['name'])
diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index a84cc5737c2c..649a80005c83 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -170,7 +170,7 @@ def process_line(root_directory, command_prefix, file_path):
     # escape the pound sign '#', either as '\#' or '$(pound)' (depending on the
     # kernel version). The compile_commands.json file is not interepreted
     # by Make, so this code replaces the escaped version with '#'.
-    prefix = command_prefix.replace('\#', '#').replace('$(pound)', '#')
+    prefix = command_prefix.replace('\\#', '#').replace('$(pound)', '#')
 
     # Use os.path.abspath() to normalize the path resolving '.' and '..' .
     abs_path = os.path.abspath(os.path.join(root_directory, file_path))
diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index fdad3f32c747..bae7cbff187e 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -82,7 +82,7 @@ lx-symbols command."""
         self.module_files_updated = True
 
     def _get_module_file(self, module_name):
-        module_pattern = ".*/{0}\.ko(?:.debug)?$".format(
+        module_pattern = ".*/{0}\\.ko(?:.debug)?$".format(
             module_name.replace("_", r"[_\-]"))
         for name in self.module_files:
             if re.match(module_pattern, name) and os.path.exists(name):
-- 
2.41.0


