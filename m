Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392DB48AFD8
	for <lists+bpf@lfdr.de>; Tue, 11 Jan 2022 15:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242656AbiAKOp5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jan 2022 09:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242631AbiAKOp4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jan 2022 09:45:56 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD29C06173F
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 06:45:56 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q8so33305402wra.12
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 06:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=25tBrQdvOhSDMfpnFvp4W9AH04srjAUSkRAm9JUy38w=;
        b=0SjbH2PkSV5xHaWdBEI57ovzlYl3/ceFlZuJIngoECATUzX96ARkUL36uRUW7RSKBE
         WeeY82f4d3d7WNfv1f2nMxuAVID3/xtExA9sc6fzj6Ir+gjRdulIUALZDIqXG3mQnt+3
         Hfm7apGcOfJTVwmfIFkuFQPNYzqgcBZCREgUmzhoLvwOUYm3f8Yf9KFUFQDDjvthtqt8
         7pMaVaYrvxLZb4qqKi0Ba1EDBuPvpqGro17hRtf5FsanThVAHJvqfysQgOGfP0WFvA01
         fyTtSeUMf0gKwZOXkGyA+yCnpyuc7UCbv87TaTfE3rQxRKYuQ3rA3DqC8wEyoUMPQlTM
         CVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=25tBrQdvOhSDMfpnFvp4W9AH04srjAUSkRAm9JUy38w=;
        b=Dq4VYsikVHO1uZamDXcyx0rLVS1cWw3ie6pKhB8Kxx1DoSUBLHj00xYT+t8cbpSPib
         gig0lxyX2hEYu1CLRdoI/67KCHa2mM7n1Uvi6HKy19X1xew70DpeR7FxPQnCbCx7uMi3
         UDR/Kae7VZqXvlnTYRKWQ9pyWOE0Q4uQrrtiqTBaCyBxAWkpTHbH+8XqrrD1m7MjLL9F
         YBTwMoPF1f9AwrYFf2x53NARg1hdN8E7QKPUmzmBKPJfu5nyTjjxiJcjYpSgns/Y2Zwz
         Tt6OtO/37hlU0ltENtI1ysI2YDLS0xBXnU1N2Xkxm2r3PZtfuP4/oM0J/EsEhsyP+Un5
         iZ0w==
X-Gm-Message-State: AOAM531ZbE3124ZTP7Kn+Y+Xo9aaT5cw7ZgiCcEK3oksoUc9DuDywQHD
        pMHifXSmExO51hVMjMM/+1yvwuzLLy/akA==
X-Google-Smtp-Source: ABdhPJwOF6VwP6g4Gdl3nHBPKYhiKs35bYK3ACFpoIK7P4PiMW2WFWy7xE+xBzKPuumf6TpgIrvtgg==
X-Received: by 2002:a5d:47ad:: with SMTP id 13mr4151825wrb.268.1641912354597;
        Tue, 11 Jan 2022 06:45:54 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:3b22:c269:f398:55da])
        by smtp.gmail.com with ESMTPSA id z4sm1829300wmf.44.2022.01.11.06.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 06:45:54 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, joe@cilium.io,
        fam.zheng@bytedance.com, cong.wang@bytedance.com,
        alexei.starovoitov@gmail.com, song@kernel.org,
        quentin@isovalent.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v4] bpf/scripts: add warning if the correct number of helpers are not auto-generated
Date:   Tue, 11 Jan 2022 14:45:52 +0000
Message-Id: <20220111144552.18534-1-usama.arif@bytedance.com>
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
with those present as part of #define __BPF_FUNC_MAPPER and generates a
warning in the header file and the man page if they don't match. It is not
needed  with the currently documented upstream functions, but can help in
debugging when developing new helpers when there might be missing or
misformatted documentation.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>

---
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
index a6403ddf5de7..e80f4ab26e67 100755
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
+        # Add a warning if the correct number of helpers are not auto-generated.
+        nr_desc_unique_helpers = len(self.desc_unique_helpers)
+        nr_define_unique_helpers = len(self.define_unique_helpers)
+        if nr_desc_unique_helpers != nr_define_unique_helpers:
+            header_warning = '''
+.. warning::
+    The number of unique helpers in description (%d) don\'t match the number of unique helpers defined in __BPF_FUNC_MAPPER (%d)
+''' % (nr_desc_unique_helpers, nr_define_unique_helpers)
+            if nr_desc_unique_helpers < nr_define_unique_helpers:
+                # Function description is parsed until no helper is found (which can be due to
+                # misformatting). Hence, only print the first missing/misformatted function.
+                header_warning += '''
+.. warning::
+    The description for %s is not present or formatted correctly.
+''' % (self.define_unique_helpers[nr_desc_unique_helpers])
+            print(header_warning)
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
+            header_warning = '''
+#warning The number of unique helpers in description (%d) don\'t match the number of unique helpers defined in __BPF_FUNC_MAPPER (%d)
+''' % (nr_desc_unique_helpers, nr_define_unique_helpers)
+            if nr_desc_unique_helpers < nr_define_unique_helpers:
+                # Function description is parsed until no helper is found (which can be due to
+                # misformatting). Hence, only print the first missing/misformatted function.
+                header_warning += '''
+#warning The description for %s is not present or formatted correctly.
+''' % (self.define_unique_helpers[nr_desc_unique_helpers])
+            print(header_warning)
+
         for fwd in self.type_fwds:
             print('%s;' % fwd)
         print('')
-- 
2.25.1

