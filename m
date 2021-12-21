Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA0247C54D
	for <lists+bpf@lfdr.de>; Tue, 21 Dec 2021 18:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240568AbhLURsp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 12:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhLURsp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Dec 2021 12:48:45 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A04EC061574
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 09:48:44 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v7so21178539wrv.12
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 09:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K8JOqHiScHpqiHuqTHVGGm6hHTyzSlgS9c4/UNUturw=;
        b=O0UUhUA3ZftuPSlrSycuKX70d7fFOlIJtUQKAJoMIOgkFcYSq3tCf6eOCRU0mAezuo
         sHTincvT58ByLKwJ3mpATtJ8orWyPD83N41ioIluDdQ04u6cxfbE4zL/XUNWzTYX+Dzn
         ogaN2TTTclVA85GWMDwVgc5wG1UDpYm8Hv0pyQzNm4JFJ/lS4kLK5ZGStYcJVFwzAxqS
         Zu5IPH8j/E1KfdBaKm1PjH15lBzQCDy+I9zzn54QrZUqQLoNtpwC5P/iG75oPbozVEaP
         GjCpYf+oYfPGcGd2lXCdKZ2SDu/D9EUDvT67BifrPTa+qfpVWL5AC9871d94DUdl7Ypg
         DZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K8JOqHiScHpqiHuqTHVGGm6hHTyzSlgS9c4/UNUturw=;
        b=MOAZeYeq7xreEe4p1Rz4BZktgibO6P82EXlNsPGnI5QbR+kQtZgs09CyElmJUHLjQC
         qZWbMpNPwZssyZ9cmRg6vX4QMYMgBzdmWZF4vn+oyusvj5g/OSZo0Yh8iN+Daw6TkFJp
         9yPku2xl3BLW+ojbCW8z8dBlSsgp8/VYAYYBDG776WGMnFbkRyHp76pMamqdNo/t765J
         8/IX2qSPSrrAK+bn+k+H0T32TVPZVMjDyy8CVi5ZMdQgoaRVxdHxJlR8iMx/byy7nxM0
         nA3t1QVHyuBA8WBZ1AZ8TrCJIBbqtv4r+xMWMGBwRUvCi5/WQp6jxmH1TNZua6mE+2gL
         ew/w==
X-Gm-Message-State: AOAM533dLitoI9Bl4pSQjvhmOMRj259z4/BjJbhHfCvW6a5XPyfqPCnp
        H2r7XLPXmTIPxydXBk9I6IIKMno781zKA6lu
X-Google-Smtp-Source: ABdhPJwQTOnHSt0Qry8vfpvtdqWm5libZ0Qu/ew/sQtS5WpBQ0LiCbm5+3hxANVky0DY2vMNmolvTQ==
X-Received: by 2002:a5d:65d1:: with SMTP id e17mr3528355wrw.379.1640108922926;
        Tue, 21 Dec 2021 09:48:42 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:815e:f1ac:2c59:353f])
        by smtp.gmail.com with ESMTPSA id l2sm11864416wru.83.2021.12.21.09.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 09:48:42 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, joe@cilium.io,
        fam.zheng@bytedance.com, cong.wang@bytedance.com,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH] bpf/scripts: add warning if the correct number of helpers are not auto-generated
Date:   Tue, 21 Dec 2021 17:48:07 +0000
Message-Id: <20211221174807.1079680-1-usama.arif@bytedance.com>
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
 scripts/bpf_doc.py | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index a6403ddf5de7..736bd853155b 100755
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
+        self.define_unique_helpers = len(re.findall('FN\(\w+\)', fn_defines_str))
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

