Return-Path: <bpf+bounces-8885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F1B78BFA5
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 09:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4EB1280FBD
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 07:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E09A6AA2;
	Tue, 29 Aug 2023 07:50:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C6223D2;
	Tue, 29 Aug 2023 07:50:32 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907EACC9;
	Tue, 29 Aug 2023 00:50:21 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T77Qfr018708;
	Tue, 29 Aug 2023 07:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1E4ZFXBXH4Xhk23ZPZWPL9rS2Wdj69Wfiw7RPc4ik94=;
 b=avgE4B0eIzCTTMI2bgEFa6iFm1Pi7dRrlh8+CB1QjLghsCOrGKs/HtBY5sKXKNnDuO06
 Lq7ykOrWFeQYo/sd/Bpt3rje7Wq0U6A8dEbs5mx7aabkuFPos5OhIqpm6XbJU/mB5Na3
 IbH0pnRMjtrt1JwXeRJ+dxRtvgCO0O6wdzjwc9Z6wVVAgGrgMFPXNMEL8P/V71sNXX8q
 EvT0oYtfizIP8iVaEXPnrG3dRdGk6/Tk+/VP9aCHQ8Rvcnis8YoP7d2FZLapARe8TDRw
 hK5LCalHhCe/RQ+UVcdQpE6uYm/Lzgfbco3aN43yuh6K8MSb7HkVVTFETv98I3ETAW9K uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sra09mdvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Aug 2023 07:50:00 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37T7ZURO015772;
	Tue, 29 Aug 2023 07:49:59 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sra09mdvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Aug 2023 07:49:59 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37T6Iscq019181;
	Tue, 29 Aug 2023 07:49:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqxe1h5fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Aug 2023 07:49:58 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37T7ntRG27918854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Aug 2023 07:49:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEDF020040;
	Tue, 29 Aug 2023 07:49:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BF0F20043;
	Tue, 29 Aug 2023 07:49:51 +0000 (GMT)
Received: from li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com.com (unknown [9.171.49.19])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Aug 2023 07:49:50 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: vishalc@linux.ibm.com
Cc: andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev,
        netdev@vger.kernel.org, quentin@isovalent.com, sachinp@linux.ibm.com,
        sdf@google.com, song@kernel.org, srikar@linux.vnet.ibm.com, yhs@fb.com
Subject: [PATCH v2] Fix invalid escape sequence warnings
Date: Tue, 29 Aug 2023 13:19:31 +0530
Message-Id: <20230829074931.2511204-1-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <e640e5f2-381c-4f65-40b9-c2e3e94696f9@linux.ibm.com>
References: <e640e5f2-381c-4f65-40b9-c2e3e94696f9@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bBcAjev6eif9nKTRyHCO0b1kTSuXb0Pk
X-Proofpoint-GUID: Ry0XuHnbMSr_Uy4ZEuZSHOQjwg-7tYw-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_04,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308290064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The script bpf_doc.py generates multiple SyntaxWarnings related to invalid
escape sequences when executed with Python 3.12. These warnings do not appear in
Python 3.10 and 3.11 and do not affect the kernel build, which completes
successfully.

This patch resolves these SyntaxWarnings by converting the relevant string
literals to raw strings or by escaping backslashes. This ensures that
backslashes are interpreted as literal characters, eliminating the warnings.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 scripts/bpf_doc.py | 56 +++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index eaae2ce78..61b7ddded 100755
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
-- 
2.41.0


