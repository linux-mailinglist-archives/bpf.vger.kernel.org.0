Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324FE492545
	for <lists+bpf@lfdr.de>; Tue, 18 Jan 2022 12:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbiARL4o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jan 2022 06:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241104AbiARL4m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Jan 2022 06:56:42 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CD4C061574
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 03:56:41 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n8so379111wmk.3
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 03:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lvIelu54oJBJmwyaLwL8rubC0MguHdhxl0oTpI2uG5o=;
        b=Nj1UuI87m1P/qhNwsvAmKVwebJKVsvZwPwOX10xscH28+CdyK4yOwUTTCmhOTdlOIN
         +1DCI0czP8DDsKLqMqTT29bllK2yoEy0zWjBrjMk+YKF7/95XGZ+G4lHIo44IZ5/H/bO
         Zy/KT6IkoXT3b1SL+jDFPBGQdSlQDhHGmODvjPBydPkzdeJDhvlpxIhSnZNLmAxgR5fR
         sveZgKWx+vZPiCSr+uXXyHMnbBaYvo6OHPyJaS1DRWgX2eNmHYwR/B/4g8mNk05U2y8R
         sAQYpbVxRSmMyhNCqjzjL0w2b5ERu5+imN39ohMlKLsc1fLBLKBwWZwE4yxBbyRqfdBC
         h2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lvIelu54oJBJmwyaLwL8rubC0MguHdhxl0oTpI2uG5o=;
        b=f1JoeKG/cazd+Tsu6GSmlA2yy38mI31WQw8+d0oDadKOjSd7c/Z8rPAUgb9B0cJVjL
         KXTNqbLywuzv99Fvm6/NRcV66s1ACAXHofE/IyECuDq+ouAnfbPgbtu5dveEuwMNlUx8
         15ssNNMfEq4q+imYoFQM+j241s/qmi0/Y++lanJJcIjCIkjWybbnCNx0yuo2vQ6VK4Rn
         n7sA/JvvqzR5Js8FC68FIYuciNXogoFmgkLpOtH5TCy6mS1gDUt5i65NwURPXQ80lGMc
         fiKIaS31ReduLYCCkRPvbCtFF4OQFv1mSR0px5ge58gnOsM2AwwcWMQKG9gJ0v+5Xsn2
         8jyw==
X-Gm-Message-State: AOAM533NPgQMH/qNOch2DyyRLCXHG+vz6fWUpzIgO/n2y59291r49Pmv
        xU5nvHWP8pj4jye+o/H68aR1aoEHxAevIw==
X-Google-Smtp-Source: ABdhPJwQxau9UmcqTE9fO5ux51Lved/i/0C7qPCn6nAK/9Sw1A2HDYA5NhU4XF3V/d43JxFTCCpbTg==
X-Received: by 2002:adf:d216:: with SMTP id j22mr23728715wrh.577.1642506999435;
        Tue, 18 Jan 2022 03:56:39 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:4699:372e:4a59:14b2])
        by smtp.gmail.com with ESMTPSA id k31sm2234042wms.15.2022.01.18.03.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 03:56:39 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, fam.zheng@bytedance.com,
        cong.wang@bytedance.com, song@kernel.org, quentin@isovalent.com,
        andrii.nakryiko@gmail.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH bpf-next 2/2] bpf/scripts: Raise an exception if the correct number of sycalls are not generated
Date:   Tue, 18 Jan 2022 11:56:20 +0000
Message-Id: <20220118115620.849425-2-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220118115620.849425-1-usama.arif@bytedance.com>
References: <20220118115620.849425-1-usama.arif@bytedance.com>
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
 scripts/bpf_doc.py | 88 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 61 insertions(+), 27 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 20441e5d2..11304427e 100755
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
@@ -266,6 +298,27 @@ class Printer(object):
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
+    The number of unique %s in description (%d) doesn\'t match the number of unique %s defined in %s (%d)
+    ''' % (type, nr_desc_unique_elem, type, instance, nr_define_unique_elem)
+            if nr_desc_unique_elem < nr_define_unique_elem:
+                # Function description is parsed until no helper is found (which can be due to
+                # misformatting). Hence, only print the first missing/misformatted helper/enum.
+                exception_msg += '''
+    The description for %s is not present or formatted correctly.
+    ''' % (define_unique_elem[nr_desc_unique_elem])
+            print(define_unique_elem)
+            print(desc_unique_elem)
+            raise Exception(exception_msg)
 
 class PrinterRST(Printer):
     """
@@ -326,26 +379,6 @@ class PrinterRST(Printer):
 
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
@@ -355,7 +388,7 @@ class PrinterHelpersRST(PrinterRST):
     """
     def __init__(self, parser):
         self.elements = parser.helpers
-        helper_number_check(parser.desc_unique_helpers, parser.define_unique_helpers)
+        self.elem_number_check(parser.desc_unique_helpers, parser.define_unique_helpers, 'helper', '__BPF_FUNC_MAPPER')
 
     def print_header(self):
         header = '''\
@@ -529,6 +562,7 @@ class PrinterSyscallRST(PrinterRST):
     """
     def __init__(self, parser):
         self.elements = parser.commands
+        self.elem_number_check(parser.desc_syscalls, parser.enum_syscalls, 'syscall', 'bpf_cmd')
 
     def print_header(self):
         header = '''\
@@ -560,7 +594,7 @@ class PrinterHelpers(Printer):
     """
     def __init__(self, parser):
         self.elements = parser.helpers
-        helper_number_check(parser.desc_unique_helpers, parser.define_unique_helpers)
+        self.elem_number_check(parser.desc_unique_helpers, parser.define_unique_helpers, 'helper', '__BPF_FUNC_MAPPER')
 
     type_fwds = [
             'struct bpf_fib_lookup',
-- 
2.25.1

