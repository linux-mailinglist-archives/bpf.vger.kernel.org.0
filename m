Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F76492C1B
	for <lists+bpf@lfdr.de>; Tue, 18 Jan 2022 18:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiARRQb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jan 2022 12:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347121AbiARRQa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Jan 2022 12:16:30 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A468DC06161C
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 09:16:29 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so9369213wme.0
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 09:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QaNKqE3U1RjWP26io09HMXs9eYblque2Wy88a25K/4Y=;
        b=SEU5kUXfb0NVqApfhGhdd5Mi5tjACcqqXxRnbc/9d+aLVTCjeKJzjR+kAmyQjk+KcL
         BnypLB7ppnAne/OH4PPXobpKVDA8uLT2o/DRVxQB9j+fxlVH4l/PBSt4ZlycAj52V1Ud
         VmQ+qR2f/AC6XQ55tTDQXEPuTAzhZMQf/r4CFlt5VySlwuevwRm88g89pC7dmtiMI2XA
         P4vIzrQe91f1goQn1wZqX5GdDmuwXfCRNJ5SIjFyYgDayfE3EoQ9atfdgSmmZ2CsPe51
         GeB0qrI5bQAQJisXbl6Y0zSGdrDBJEueakZ2HS228twdvczelds2Pef3GSMV4nl5LS0l
         oCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QaNKqE3U1RjWP26io09HMXs9eYblque2Wy88a25K/4Y=;
        b=6ixkArlso4W/Ur9jAYedxYzxbKKQ21vWD4VLB7Ppt7ZhEHBsxbel7waBBMFi+HtBws
         AMm2w581xOdYtQ5YGZDCTjxm1otDbNndPWcW0nXOrBZTwYlVznY8CsEDJF9e8h1B5SOE
         /3NIWAAPzef85NxPbd8gM4t0Eu/cut8RvSb1VDagcNtIniGwGmgfdIZOPhLZeEiBxeIn
         K8yb8bhix12j9kuV9CQ9lOReLRXmNzn6CgTxaMjTD8nn2JJFtH4DkdQuwB75vvmR2Fzu
         touk3YEWa8QdWvLPkbON2+J/SbXvKve58aAhpN9Sf9xlj5m3CKbEBjZTQfHnD2JQ95Qk
         QRvg==
X-Gm-Message-State: AOAM532NoAW/n5hU/ZYedYI8OoRmmIfkpuwJ9WlC8NX3dlMJ2FK+fDOh
        FMHaQ8M3D5GYmVSepnn5C3gxiXQ1E3U5ww==
X-Google-Smtp-Source: ABdhPJzBsoxAm61Se4RWoqJBznr0AgqGgWBMsOiulQ9uYJV9a0Mr+4mNbMT5sswBk4RCm+ISg0SboA==
X-Received: by 2002:a05:6000:1a89:: with SMTP id f9mr25085445wry.41.1642526187943;
        Tue, 18 Jan 2022 09:16:27 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:d40a:ebf3:7c3b:c5af])
        by smtp.gmail.com with ESMTPSA id g6sm18983449wri.80.2022.01.18.09.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 09:16:27 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, fam.zheng@bytedance.com,
        cong.wang@bytedance.com, song@kernel.org, quentin@isovalent.com,
        andrii.nakryiko@gmail.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH bpf-next v2 2/2] bpf/scripts: Raise an exception if the correct number of sycalls are not generated
Date:   Tue, 18 Jan 2022 17:16:09 +0000
Message-Id: <20220118171609.1044550-2-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220118171609.1044550-1-usama.arif@bytedance.com>
References: <20220118171609.1044550-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently the syscalls rst and subsequently man page are auto-generated
using function documentation present in bpf.h. If the documentation for the
syscall is missing or doesn't follow a specific format, then that syscall
is not dumped in the auto-generated rst.

This patch checks the number of syscalls documented within the header file
with those present as part of the enum bpf_cmd and raises an Exception if
they don't match. It is not needed with the currently documented upstream
syscalls, but can help in debugging when developing new syscalls when
there might be missing or misformatted documentation.

The function helper_number_check is moved to the Printer parent
class and renamed to elem_number_check as all the most derived children
classes are using this function now.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>

---
v1->v2:
- Removed debug prints and fixed formatting.
- Added in syscall documentation that BPF_PROG_RUN is an alias for
BPF_PROG_TEST_RUN (suggested by Quentin Monnet).
---
 include/uapi/linux/bpf.h       |  2 +
 scripts/bpf_doc.py             | 86 +++++++++++++++++++++++-----------
 tools/include/uapi/linux/bpf.h |  2 +
 3 files changed, 63 insertions(+), 27 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8cbb3737ee97..a9c96c21330a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -330,6 +330,8 @@ union bpf_iter_link_info {
  *			*ctx_out*, *data_in* and *data_out* must be NULL.
  *			*repeat* must be zero.
  *
+ *		BPF_PROG_RUN is an alias for BPF_PROG_TEST_RUN.
+ *
  *	Return
  *		Returns zero on success. On error, -1 is returned and *errno*
  *		is set appropriately.
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 20441e5d2d33..096625242475 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -89,6 +89,8 @@ class HeaderParser(object):
         self.commands = []
         self.desc_unique_helpers = set()
         self.define_unique_helpers = []
+        self.desc_syscalls = []
+        self.enum_syscalls = []
 
     def parse_element(self):
         proto    = self.parse_symbol()
@@ -103,7 +105,7 @@ class HeaderParser(object):
         return Helper(proto=proto, desc=desc, ret=ret)
 
     def parse_symbol(self):
-        p = re.compile(' \* ?(.+)$')
+        p = re.compile(' \* ?(BPF\w+)$')
         capture = p.match(self.line)
         if not capture:
             raise NoSyscallCommandFound
@@ -181,26 +183,55 @@ class HeaderParser(object):
             raise Exception("No return found for " + proto)
         return ret
 
-    def seek_to(self, target, help_message):
+    def seek_to(self, target, help_message, discard_lines = 1):
         self.reader.seek(0)
         offset = self.reader.read().find(target)
         if offset == -1:
             raise Exception(help_message)
         self.reader.seek(offset)
         self.reader.readline()
-        self.reader.readline()
+        for _ in range(discard_lines):
+            self.reader.readline()
         self.line = self.reader.readline()
 
-    def parse_syscall(self):
+    def parse_desc_syscall(self):
         self.seek_to('* DOC: eBPF Syscall Commands',
                      'Could not find start of eBPF syscall descriptions list')
         while True:
             try:
                 command = self.parse_element()
                 self.commands.append(command)
+                self.desc_syscalls.append(command.proto)
+
             except NoSyscallCommandFound:
                 break
 
+    def parse_enum_syscall(self):
+        self.seek_to('enum bpf_cmd {',
+                     'Could not find start of bpf_cmd enum', 0)
+        # Searches for either one or more BPF\w+ enums
+        bpf_p = re.compile('\s*(BPF\w+)+')
+        # Searches for an enum entry assigned to another entry,
+        # for e.g. BPF_PROG_RUN = BPF_PROG_TEST_RUN, which is
+        # not documented hence should be skipped in check to
+        # determine if the right number of syscalls are documented
+        assign_p = re.compile('\s*(BPF\w+)\s*=\s*(BPF\w+)')
+        bpf_cmd_str = ''
+        while True:
+            capture = assign_p.match(self.line)
+            if capture:
+                # Skip line if an enum entry is assigned to another entry
+                self.line = self.reader.readline()
+                continue
+            capture = bpf_p.match(self.line)
+            if capture:
+                bpf_cmd_str += self.line
+            else:
+                break
+            self.line = self.reader.readline()
+        # Find the number of occurences of BPF\w+
+        self.enum_syscalls = re.findall('(BPF\w+)+', bpf_cmd_str)
+
     def parse_desc_helpers(self):
         self.seek_to('* Start of BPF helper function descriptions:',
                      'Could not find start of eBPF helper descriptions list')
@@ -234,7 +265,8 @@ class HeaderParser(object):
         self.define_unique_helpers = re.findall('FN\(\w+\)', fn_defines_str)
 
     def run(self):
-        self.parse_syscall()
+        self.parse_desc_syscall()
+        self.parse_enum_syscall()
         self.parse_desc_helpers()
         self.parse_define_helpers()
         self.reader.close()
@@ -266,6 +298,25 @@ class Printer(object):
             self.print_one(elem)
         self.print_footer()
 
+    def elem_number_check(self, desc_unique_elem, define_unique_elem, type, instance):
+        """
+        Checks the number of helpers/syscalls documented within the header file
+        description with those defined as part of enum/macro and raise an
+        Exception if they don't match.
+        """
+        nr_desc_unique_elem = len(desc_unique_elem)
+        nr_define_unique_elem = len(define_unique_elem)
+        if nr_desc_unique_elem != nr_define_unique_elem:
+            exception_msg = '''
+The number of unique %s in description (%d) doesn\'t match the number of unique %s defined in %s (%d)
+''' % (type, nr_desc_unique_elem, type, instance, nr_define_unique_elem)
+            if nr_desc_unique_elem < nr_define_unique_elem:
+                # Function description is parsed until no helper is found (which can be due to
+                # misformatting). Hence, only print the first missing/misformatted helper/enum.
+                exception_msg += '''
+The description for %s is not present or formatted correctly.
+''' % (define_unique_elem[nr_desc_unique_elem])
+            raise Exception(exception_msg)
 
 class PrinterRST(Printer):
     """
@@ -326,26 +377,6 @@ class PrinterRST(Printer):
 
         print('')
 
-def helper_number_check(desc_unique_helpers, define_unique_helpers):
-    """
-    Checks the number of functions documented within the header file
-    with those present as part of #define __BPF_FUNC_MAPPER and raise an
-    Exception if they don't match.
-    """
-    nr_desc_unique_helpers = len(desc_unique_helpers)
-    nr_define_unique_helpers = len(define_unique_helpers)
-    if nr_desc_unique_helpers != nr_define_unique_helpers:
-        helper_exception = '''
-The number of unique helpers in description (%d) doesn\'t match the number of unique helpers defined in __BPF_FUNC_MAPPER (%d)
-''' % (nr_desc_unique_helpers, nr_define_unique_helpers)
-        if nr_desc_unique_helpers < nr_define_unique_helpers:
-            # Function description is parsed until no helper is found (which can be due to
-            # misformatting). Hence, only print the first missing/misformatted function.
-            helper_exception += '''
-The description for %s is not present or formatted correctly.
-''' % (define_unique_helpers[nr_desc_unique_helpers])
-        raise Exception(helper_exception)
-
 class PrinterHelpersRST(PrinterRST):
     """
     A printer for dumping collected information about helpers as a ReStructured
@@ -355,7 +386,7 @@ class PrinterHelpersRST(PrinterRST):
     """
     def __init__(self, parser):
         self.elements = parser.helpers
-        helper_number_check(parser.desc_unique_helpers, parser.define_unique_helpers)
+        self.elem_number_check(parser.desc_unique_helpers, parser.define_unique_helpers, 'helper', '__BPF_FUNC_MAPPER')
 
     def print_header(self):
         header = '''\
@@ -529,6 +560,7 @@ class PrinterSyscallRST(PrinterRST):
     """
     def __init__(self, parser):
         self.elements = parser.commands
+        self.elem_number_check(parser.desc_syscalls, parser.enum_syscalls, 'syscall', 'bpf_cmd')
 
     def print_header(self):
         header = '''\
@@ -560,7 +592,7 @@ class PrinterHelpers(Printer):
     """
     def __init__(self, parser):
         self.elements = parser.helpers
-        helper_number_check(parser.desc_unique_helpers, parser.define_unique_helpers)
+        self.elem_number_check(parser.desc_unique_helpers, parser.define_unique_helpers, 'helper', '__BPF_FUNC_MAPPER')
 
     type_fwds = [
             'struct bpf_fib_lookup',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 8cbb3737ee97..a9c96c21330a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -330,6 +330,8 @@ union bpf_iter_link_info {
  *			*ctx_out*, *data_in* and *data_out* must be NULL.
  *			*repeat* must be zero.
  *
+ *		BPF_PROG_RUN is an alias for BPF_PROG_TEST_RUN.
+ *
  *	Return
  *		Returns zero on success. On error, -1 is returned and *errno*
  *		is set appropriately.
-- 
2.25.1

