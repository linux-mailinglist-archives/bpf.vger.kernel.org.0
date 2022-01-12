Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C7148C388
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 12:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbiALLuA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 06:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbiALLt7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 06:49:59 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CE7C06173F
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 03:49:59 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id p18so1390273wmg.4
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 03:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j4QdLRSemRwUKhYexVuGLpMb1M1o/yw2NHxB03Q+OmI=;
        b=KBI2y1EnlFFpuVBQrOtPj48EH1yBEz1UItneik8mgxIMmm9EUYB0Jm2ZtqtvTICzlW
         OgE4kgIAgXcFXNSlUFXDX/q3gzzwwmyPuXG1ODmqYEXGkT0nckxcy5aW6dMSSNkqhnvN
         QiEYDORfe5j51yDFae6QSccTdWO6aepb20ikxSSJSFPuwRrzmTuCWgxF/L3qj4kq8zPt
         Idj2K5OSrHe6LsrbWvDNSZxEHBsF3yoP1ONPBwx94nprFFbMmaOsyweC/H0QsWWJLSog
         +/ubnlVrB7XZzc6LPeGzqjCDU/36gcu6iqopksHywNChNbAuh2jZsbgq+hWSONPr3l0o
         g0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j4QdLRSemRwUKhYexVuGLpMb1M1o/yw2NHxB03Q+OmI=;
        b=RvN0LKCANRC3qeEfiHLB76VCyvB954aSD5Hd3V5VcTjbTQq8uvRBdi2BihYaD4jm89
         U2U7Lj42Gcg8Te/2Q8hY4r2vXWwcGFrdeSaKiTp7vlt8Y5Q5983oLLOqy9Mv1HqIOPQp
         Y8mpSenZJoAYjX+gokcJ4ASeSzTDPEo2w5Rgca1zME3LfV0dbDo6GdzGWTPALb9B85nX
         jg3TnVUNKbgvhpvf90u92AmREpoSy82s4lQ6Rv3vS3NZkLxpb5FGcdQWTagOIgblduz2
         vVVu26Wv4Mi0pVzUzzfsGsu52l9DTNY0QZ+q1sHaZLQTdjteBiU8uNsEkfUFf0oVxK7O
         GLMA==
X-Gm-Message-State: AOAM5333P4tcXhuplACVo9f0vlzinq1CnxUQqilpifkEplD25zapJfYU
        Ih9u2FSoxxJKwCeUgFoFVXeFe1bPa7+IFg==
X-Google-Smtp-Source: ABdhPJxnJ1hy67tviymoOt0ZNGGl4V3o8i6xKJN/Kh4PsVM0R1zSFexGgFCTsStzqy5NkBl3NmVrog==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr6543018wmh.44.1641988197828;
        Wed, 12 Jan 2022 03:49:57 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:1381:d05e:375f:8daf])
        by smtp.gmail.com with ESMTPSA id k7sm4139761wmi.37.2022.01.12.03.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 03:49:57 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, joe@cilium.io,
        fam.zheng@bytedance.com, cong.wang@bytedance.com,
        alexei.starovoitov@gmail.com, song@kernel.org,
        quentin@isovalent.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v6] bpf/scripts: raise an exception if the correct number of helpers are not generated
Date:   Wed, 12 Jan 2022 11:49:53 +0000
Message-Id: <20220112114953.722380-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently bpf_helper_defs.h and the bpf helpers man page are auto-generated
using function documentation present in bpf.h. If the documentation for the
helper is missing or doesn't follow a specific format for e.g. if a function
is documented as:
 * long bpf_kallsyms_lookup_name( const char *name, int name_sz, int flags, u64 *res )
instead of
 * long bpf_kallsyms_lookup_name(const char *name, int name_sz, int flags, u64 *res)
(notice the extra space at the start and end of function arguments)
then that helper is not dumped in the auto-generated header and results in
an invalid call during eBPF runtime, even if all the code specific to the
helper is correct.

This patch checks the number of functions documented within the header file
with those present as part of #define __BPF_FUNC_MAPPER and raises an
Exception if they don't match. It is not needed with the currently documented
upstream functions, but can help in debugging when developing new helpers
when there might be missing or misformatted documentation.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>

---
v5->v6:
- change from error in auto-generated files to exception in bpf_doc.py
  if the correct number of helpers are not generated (suggested by
  Quentin Monnet)

v4->v5:
- Converted warning to error incase of missing/misformatted helper doc
  (suggested by Song Liu)

v3->v4:
- Added comments to make code clearer
- Added warning to man page as well (suggested by Quentin Monnet)

v2->v3:
- Removed check if value is already in set (suggested by Song Liu)

v1->v2:
- Fix CI error reported by Alexei Starovoitov
---
 scripts/bpf_doc.py | 50 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index a6403ddf5de7..76c96df095e3 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -87,6 +87,8 @@ class HeaderParser(object):
         self.line = ''
         self.helpers = []
         self.commands = []
+        self.desc_unique_helpers = set()
+        self.define_unique_helpers = []
 
     def parse_element(self):
         proto    = self.parse_symbol()
@@ -193,19 +195,42 @@ class HeaderParser(object):
             except NoSyscallCommandFound:
                 break
 
-    def parse_helpers(self):
+    def parse_desc_helpers(self):
         self.seek_to('* Start of BPF helper function descriptions:',
                      'Could not find start of eBPF helper descriptions list')
         while True:
             try:
                 helper = self.parse_helper()
                 self.helpers.append(helper)
+                proto = helper.proto_break_down()
+                self.desc_unique_helpers.add(proto['name'])
             except NoHelperFound:
                 break
 
+    def parse_define_helpers(self):
+        # Parse the number of FN(...) in #define __BPF_FUNC_MAPPER to compare
+        # later with the number of unique function names present in description.
+        # Note: seek_to(..) discards the first line below the target search text,
+        # resulting in FN(unspec) being skipped and not added to self.define_unique_helpers.
+        self.seek_to('#define __BPF_FUNC_MAPPER(FN)',
+                     'Could not find start of eBPF helper definition list')
+        # Searches for either one or more FN(\w+) defines or a backslash for newline
+        p = re.compile('\s*(FN\(\w+\))+|\\\\')
+        fn_defines_str = ''
+        while True:
+            capture = p.match(self.line)
+            if capture:
+                fn_defines_str += self.line
+            else:
+                break
+            self.line = self.reader.readline()
+        # Find the number of occurences of FN(\w+)
+        self.define_unique_helpers = re.findall('FN\(\w+\)', fn_defines_str)
+
     def run(self):
         self.parse_syscall()
-        self.parse_helpers()
+        self.parse_desc_helpers()
+        self.parse_define_helpers()
         self.reader.close()
 
 ###############################################################################
@@ -295,6 +320,25 @@ class PrinterRST(Printer):
 
         print('')
 
+def helper_number_check(desc_unique_helpers, define_unique_helpers):
+    """
+    Checks the number of functions documented within the header file
+    with those present as part of #define __BPF_FUNC_MAPPER and raise an
+    Exception if they don't match.
+    """
+    nr_desc_unique_helpers = len(desc_unique_helpers)
+    nr_define_unique_helpers = len(define_unique_helpers)
+    if nr_desc_unique_helpers != nr_define_unique_helpers:
+        helper_exception = '''
+The number of unique helpers in description (%d) don\'t match the number of unique helpers defined in __BPF_FUNC_MAPPER (%d)
+''' % (nr_desc_unique_helpers, nr_define_unique_helpers)
+        if nr_desc_unique_helpers < nr_define_unique_helpers:
+            # Function description is parsed until no helper is found (which can be due to
+            # misformatting). Hence, only print the first missing/misformatted function.
+            helper_exception += '''
+The description for %s is not present or formatted correctly.
+''' % (define_unique_helpers[nr_desc_unique_helpers])
+        raise Exception(helper_exception)
 
 class PrinterHelpersRST(PrinterRST):
     """
@@ -305,6 +349,7 @@ class PrinterHelpersRST(PrinterRST):
     """
     def __init__(self, parser):
         self.elements = parser.helpers
+        helper_number_check(parser.desc_unique_helpers, parser.define_unique_helpers)
 
     def print_header(self):
         header = '''\
@@ -509,6 +554,7 @@ class PrinterHelpers(Printer):
     """
     def __init__(self, parser):
         self.elements = parser.helpers
+        helper_number_check(parser.desc_unique_helpers, parser.define_unique_helpers)
 
     type_fwds = [
             'struct bpf_fib_lookup',
-- 
2.25.1

