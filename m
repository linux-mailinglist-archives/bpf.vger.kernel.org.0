Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8081648B5F6
	for <lists+bpf@lfdr.de>; Tue, 11 Jan 2022 19:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346225AbiAKSo1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jan 2022 13:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346274AbiAKSoX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jan 2022 13:44:23 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14942C061748
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 10:44:22 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so1069039wmb.1
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 10:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oy92h6e9BAZsootgH+gvRkELl7f00gVeyQFjnWa6ihU=;
        b=oZ6/e71H7XLFuOoAVe1qNEbCEsn/B5dLjIon+Pvt7TpIQQ2vsE/Et5NWlmp+cutFTi
         hBt8lBkyC37VbSUGoAD0Ik61mrupxBiIfwZI/YzqOMovbNkKz5DR/7a9joTluGBhr/uf
         k0e+SiWpajECh/MFHSPeA6/Og3ICRFIq6G19JDjkOGp3mVKFvOgOg2bmQBksKP60BqI2
         TdmctTXelmYlzE1B+Xklu87WKn1RN/aAT8TPE1GWAxGYY9tOWlHZy1pBgafQhpVF/OeV
         aYvq9RP9LbkREw9RdXBw7V6lGpzWFt4mVgME5iXyyUhjfKA9P/AKHbzahHFMsPW4eRNt
         te3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oy92h6e9BAZsootgH+gvRkELl7f00gVeyQFjnWa6ihU=;
        b=YEtBcmduzlyFUPJFQUx368yZpidYrFzqF+DDFnitUnp1XBExDyF93jok9K4TvdT0iu
         YsRxdl2jWEQK5DA6SXdFPpm4pHh5mkVpHxULT0fYSvsrlM3/8+gASbQzfiGgWiTBc5JU
         idySE52FulEELXM6KnfOKdLcQfQIZC9Bpcjv777L9a9mo2/6nTHkVnO+g4wa0rYcz9jE
         32S63EuKSSse/Tjz2g+Fa3wmJRt/u4JYDphv2/BCH/oVN8TLYyW5GX8Bzi7Bxloak0jD
         pKN99JRhhlQtCCZOYvQb96EjWjvHvGSYrKxQuIMyHuUfzdQGgusKZhstVTBoKCwp0F4U
         7Z6A==
X-Gm-Message-State: AOAM53020HVGTnReVIA9+9nhzhus1C4ZlBm5mnuDDBWoJDSdmWQjWUHm
        bxdMb9vkIz0BOoP+wLszLt43QakSC0xKMA==
X-Google-Smtp-Source: ABdhPJx26w3lqlaGi6WMPtdgidSj23sUbzS4HYUIAv8igDkSNtFbJs8T1VXgfwajHHkl1VmUBJLzIw==
X-Received: by 2002:a05:600c:1d11:: with SMTP id l17mr2890291wms.134.1641926660470;
        Tue, 11 Jan 2022 10:44:20 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:1381:d05e:375f:8daf])
        by smtp.gmail.com with ESMTPSA id y14sm1649741wma.19.2022.01.11.10.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 10:44:20 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, joe@cilium.io,
        fam.zheng@bytedance.com, cong.wang@bytedance.com,
        alexei.starovoitov@gmail.com, song@kernel.org,
        quentin@isovalent.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v5] bpf/scripts: add an error if the correct number of helpers are not generated
Date:   Tue, 11 Jan 2022 18:44:18 +0000
Message-Id: <20220111184418.196442-1-usama.arif@bytedance.com>
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
with those present as part of #define __BPF_FUNC_MAPPER and generates an
error in the header file and the man page if they don't match. It is not
needed with the currently documented upstream functions, but can help in
debugging when developing new helpers when there might be missing or
misformatted documentation.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>

---
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
 scripts/bpf_doc.py | 74 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 4 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index a6403ddf5de7..adf08fa963a4 100755
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
@@ -305,9 +330,11 @@ class PrinterHelpersRST(PrinterRST):
     """
     def __init__(self, parser):
         self.elements = parser.helpers
+        self.desc_unique_helpers = parser.desc_unique_helpers
+        self.define_unique_helpers = parser.define_unique_helpers
 
     def print_header(self):
-        header = '''\
+        header_name = '''\
 ===========
 BPF-HELPERS
 ===========
@@ -317,6 +344,8 @@ list of eBPF helper functions
 
 :Manual section: 7
 
+'''
+        header_description = '''
 DESCRIPTION
 ===========
 
@@ -349,7 +378,27 @@ HELPERS
 =======
 '''
         PrinterRST.print_license(self)
-        print(header)
+
+        print(header_name)
+
+        # Add an error if the correct number of helpers are not auto-generated.
+        nr_desc_unique_helpers = len(self.desc_unique_helpers)
+        nr_define_unique_helpers = len(self.define_unique_helpers)
+        if nr_desc_unique_helpers != nr_define_unique_helpers:
+            header_error = '''
+.. error::
+    The number of unique helpers in description (%d) don\'t match the number of unique helpers defined in __BPF_FUNC_MAPPER (%d)
+''' % (nr_desc_unique_helpers, nr_define_unique_helpers)
+            if nr_desc_unique_helpers < nr_define_unique_helpers:
+                # Function description is parsed until no helper is found (which can be due to
+                # misformatting). Hence, only print the first missing/misformatted function.
+                header_error += '''
+.. error::
+    The description for %s is not present or formatted correctly.
+''' % (self.define_unique_helpers[nr_desc_unique_helpers])
+            print(header_error)
+
+        print(header_description)
 
     def print_footer(self):
         footer = '''
@@ -509,6 +558,8 @@ class PrinterHelpers(Printer):
     """
     def __init__(self, parser):
         self.elements = parser.helpers
+        self.desc_unique_helpers = parser.desc_unique_helpers
+        self.define_unique_helpers = parser.define_unique_helpers
 
     type_fwds = [
             'struct bpf_fib_lookup',
@@ -628,6 +679,21 @@ class PrinterHelpers(Printer):
 /* Forward declarations of BPF structs */'''
 
         print(header)
+
+        nr_desc_unique_helpers = len(self.desc_unique_helpers)
+        nr_define_unique_helpers = len(self.define_unique_helpers)
+        if nr_desc_unique_helpers != nr_define_unique_helpers:
+            header_error = '''
+#error The number of unique helpers in description (%d) don\'t match the number of unique helpers defined in __BPF_FUNC_MAPPER (%d)
+''' % (nr_desc_unique_helpers, nr_define_unique_helpers)
+            if nr_desc_unique_helpers < nr_define_unique_helpers:
+                # Function description is parsed until no helper is found (which can be due to
+                # misformatting). Hence, only print the first missing/misformatted function.
+                header_error += '''
+#error The description for %s is not present or formatted correctly.
+''' % (self.define_unique_helpers[nr_desc_unique_helpers])
+            print(header_error)
+
         for fwd in self.type_fwds:
             print('%s;' % fwd)
         print('')
-- 
2.25.1

