Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFF6489B49
	for <lists+bpf@lfdr.de>; Mon, 10 Jan 2022 15:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiAJOba (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jan 2022 09:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbiAJOba (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Jan 2022 09:31:30 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1288DC06173F
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 06:31:30 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id s1so27168511wra.6
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 06:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BkTrZkjjZOYLDB8/6286x9FL60uPsTTrkR9kHWn6A+g=;
        b=xHfnqCgsuhhr5szaddgiBGeCVQ/m8Kuhpadm37Sz0rEEjY8Eb20grfaq+s1neyegxo
         +g4Mvw+RyGNN/aZtYocodiqF8oaUK4Rb56up9JGeirRLLDinw1KoSMIrNg/xdMy7wBKm
         t41gOZywy6iMQLYC+eWYoFszJLcwmVCC0vlx4APlOAeuwlZrHJUezQ//Oh4gIKaBf8iO
         yl6Ai0kja14aPpCR9/a51qGMSf7FJ5YkbDgHtQnuItUzN4sC8KhxkZVjpgL8GeidFzu+
         X0jZ28EPaCO2sdm1GJzmewL3Sf5vuc/ydK6NQLnxIMR74HN9O/1b9WmXIyewWGFq+cXw
         j8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BkTrZkjjZOYLDB8/6286x9FL60uPsTTrkR9kHWn6A+g=;
        b=0/LDoGR52b1tLDGVx2h6/MfgDDS0WdWTxhyspIwsFZgXplmpT3mMgJ5gVqx1GS7wc8
         ckLhLNsqRjmMJcwR/9dlNQB3txjJKyPvOb9Lv2vP33nxkeVZoS78Jjb1schuGj2tCt67
         id86ALgD0vg2xSj53oVaB3oAyuZkZDLr1h3he+r5iHPAnF1PLCkcb3P8sixLHWHp07/V
         NWvzR/VoxobqIo5sAXcqNu93BwOE3dbs90RD5Kb6NHWzwERMKpbN2EKCeRzm2FBk29Nk
         0KhLyifUKOOoLuWHbBIcgIfVkiKcCWxbvhzCKdmvUWUof4t2tj4fLXT/qdzinTMZJiU4
         QAMg==
X-Gm-Message-State: AOAM530B2BOZ2Hu+edsHMA7LH7v43Tzi749aDJyB5fK+XBk8nf1/LoBz
        f57xJYhxvQe32aeWN+opXiu+Gp/zNnux2w==
X-Google-Smtp-Source: ABdhPJwJ7qeBMbM7DTkXNgYcIlYGgt0vtNI+VTbfnCwzE4GCZUFoCFjfiwtPWsgIPr39whMJyHL3GA==
X-Received: by 2002:adf:9dc1:: with SMTP id q1mr12337486wre.18.1641825088520;
        Mon, 10 Jan 2022 06:31:28 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:630b:457a:c617:2b89])
        by smtp.gmail.com with ESMTPSA id o15sm7597159wri.106.2022.01.10.06.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 06:31:28 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, joe@cilium.io,
        fam.zheng@bytedance.com, cong.wang@bytedance.com,
        alexei.starovoitov@gmail.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v2] bpf/scripts: add warning if the correct number of helpers are not auto-generated
Date:   Mon, 10 Jan 2022 14:31:02 +0000
Message-Id: <20220110143102.3466150-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently bpf_helper_defs.h is auto-generated using function documentation
present in bpf.h. If the documentation for the helper is missing
or doesn't follow a specific format for e.g. if a function is documented
as:
 * long bpf_kallsyms_lookup_name( const char *name, int name_sz, int flags, u64 *res )
instead of
 * long bpf_kallsyms_lookup_name(const char *name, int name_sz, int flags, u64 *res)
(notice the extra space at the start and end of function arguments)
then that helper is not dumped in the auto-generated header and results in
an invalid call during eBPF runtime, even if all the code specific to the
helper is correct.

This patch checks the number of functions documented within the header file
with those present as part of #define __BPF_FUNC_MAPPER and generates a
warning in the header file if they don't match. It is not needed with the
currently documented upstream functions, but can help in debugging
when developing new helpers when there might be missing or misformatted
documentation.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>

---
v1->v2:
- Fix CI error reported by Alexei Starovoitov
---
 scripts/bpf_doc.py | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index a6403ddf5de7..e426d2a727cb 100755
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
@@ -193,19 +195,41 @@ class HeaderParser(object):
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
+                if proto['name'] not in self.desc_unique_helpers:
+                    self.desc_unique_helpers.add(proto['name'])
             except NoHelperFound:
                 break
 
+    def parse_define_helpers(self):
+        # Parse the number of FN(...) in #define __BPF_FUNC_MAPPER to compare
+        # later with the number of unique function names present in description
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
@@ -509,6 +533,8 @@ class PrinterHelpers(Printer):
     """
     def __init__(self, parser):
         self.elements = parser.helpers
+        self.desc_unique_helpers = parser.desc_unique_helpers
+        self.define_unique_helpers = parser.define_unique_helpers
 
     type_fwds = [
             'struct bpf_fib_lookup',
@@ -628,6 +654,22 @@ class PrinterHelpers(Printer):
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
+
         for fwd in self.type_fwds:
             print('%s;' % fwd)
         print('')
-- 
2.25.1

