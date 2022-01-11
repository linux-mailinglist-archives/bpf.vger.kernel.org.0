Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EF548AC2F
	for <lists+bpf@lfdr.de>; Tue, 11 Jan 2022 12:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbiAKLIt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jan 2022 06:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbiAKLIs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jan 2022 06:08:48 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11495C06173F
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 03:08:48 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o7-20020a05600c510700b00347e10f66d1so706561wms.0
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 03:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IkHUCwSjjyfx8ucKqaAw0ursDWAsu/NhKNDufeKgJ9I=;
        b=7zRk4plA+PArINRyAn+JgGo8q3HPaEUTLWeny7xo10W6ErG2bNZaJetAWbme8Nmkfe
         NnOIpsTZgq77tKot4TJKbAGGxSDUchp6hZKQugnvNjwLHVCFwO97EhiVWQu6ZLICP5cf
         yQxDz4CYtOVWuLYn8HUJsQGS7uuPfVa0OEXvpV79sx3cmREX7oSo9HoFavyLaNptWvEP
         9y1cWqniHGM5Zfulh4FehlSqofJL/ZSaVQaPSwZJ3PDL9LPA5g7sfRYlm97nqQd52XBl
         5qxHdrYb5MwjZ+Sk1WtW21HY+4v09TxRmR92vvVliRVJ6Axpc0nWmjyPW9TXj5MuUDMk
         Cm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IkHUCwSjjyfx8ucKqaAw0ursDWAsu/NhKNDufeKgJ9I=;
        b=K+/qAgbFF1ob46S3wNTSb+pcbpZVw4IJBaZPjPutgLNSRamS88gixZfbgGFV3sf2Ij
         TdHNypPVozSVhtBHVwoa0EpwqCW/bIUcEZCwRSVhyT7AaKFCdKMUhoXW9lggevj7fF2S
         k9qvMjC89RoDpGpQBNEgdUE1r+qKmcqWR0QsXloBjiMH71RLPTQpJKbUHpMQG9BYEcLP
         2VvW0qoKvSnKb2jRIo8Bl2k5+JKnBWXCD01JqVlN9RBqoBinBDhZP7RqYBYxAEiFC7k9
         kyR4//BseI0gpOeXjpOxGuKz8FoyWodWt4ojpZuK66421zOxnNlYkPhsdyE2Mtob+aug
         xqQA==
X-Gm-Message-State: AOAM533it7z6MtDVUtTsMkkRfHxjYtPYWAg8UFMN7qCbrFqXOrnCPsIr
        bVHiPRpTBAU/hy+fOaGeNcrmuPsPZ1T0mQ==
X-Google-Smtp-Source: ABdhPJyJ3Xhti0suAqluY118OM0C1QZLx0KvZAb94l8zqQIhHsQyOmwneQnPxiNtjr1vXGTuMqLN5w==
X-Received: by 2002:a05:600c:a4c:: with SMTP id c12mr2030390wmq.60.1641899326515;
        Tue, 11 Jan 2022 03:08:46 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:3b22:c269:f398:55da])
        by smtp.gmail.com with ESMTPSA id c11sm1638748wmq.48.2022.01.11.03.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 03:08:46 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, joe@cilium.io,
        fam.zheng@bytedance.com, cong.wang@bytedance.com,
        alexei.starovoitov@gmail.com, song@kernel.org,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v3] bpf/scripts: add warning if the correct number of helpers are not auto-generated
Date:   Tue, 11 Jan 2022 11:08:42 +0000
Message-Id: <20220111110842.4071569-1-usama.arif@bytedance.com>
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
v2->v3:
- Removed check if value is already in set (suggested by Song Liu)

v1->v2:
- Fix CI error reported by Alexei Starovoitov
---
 scripts/bpf_doc.py | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index a6403ddf5de7..8d96f08ea7a6 100755
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
@@ -193,19 +195,40 @@ class HeaderParser(object):
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
@@ -509,6 +532,8 @@ class PrinterHelpers(Printer):
     """
     def __init__(self, parser):
         self.elements = parser.helpers
+        self.desc_unique_helpers = parser.desc_unique_helpers
+        self.define_unique_helpers = parser.define_unique_helpers
 
     type_fwds = [
             'struct bpf_fib_lookup',
@@ -628,6 +653,22 @@ class PrinterHelpers(Printer):
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

