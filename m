Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0D259F9EC
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 14:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbiHXM0n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 08:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiHXM0k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 08:26:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2026E1A041
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 05:26:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h24so20564754wrb.8
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 05:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=RPV+kce7IJwxLuwQt71slHHmG1JkhsipLprRDCzxmfo=;
        b=A/x/OXA71VfJ1J9KrzrQGDdzvTm2xvWDpWmKpYnr812RHNYQ3qrPm1CataAwlUnxUj
         /4AcHszHW4ZCEKSHvdxe07I96B+L5tcsDNCRNQRu31FgfBrOtgpn41SSWo1i3qY7YLkJ
         s0lNardaTuucIdlhzMZ9eksE74YrvCLs4cy4rCRrV6qQQ1U+163qKmFjEX7bq7mYy3sI
         JQzAQcY+10TmNeYyuWNX/iklkr/SFjwEeOp48iNPK2lp4cEW9SBlp0ZQz760L02jVzoR
         bGTvLzGJ6XG/bYTPOzfZh1uYT/HQlA7BUm/V4o9yMTXYpA1I7nk+E5/tr4rLyczjGVgi
         OZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=RPV+kce7IJwxLuwQt71slHHmG1JkhsipLprRDCzxmfo=;
        b=BCwsW4NePmeeh84PiQYRS2n6wgMIHKIgwpf7bPyDsCO7fcbiIGhLxD9PscI2hW7O9E
         r7MLe+kqa10pjtFhlJWFfRjWRfjodsKYLIinjL2fB7US85vTWh1YwNPJW/pdj4Lp4qdH
         LSGIUpOhZl8COtsb0cIswNNBq8V5iVh0iCNzblU8VOPMs0ak1dGQLGD2xLwEqTv7Qv6R
         HqrZj8nB3pYLDgKjnjorwKwvwbZsi07p6qz/tlYZzQHOLGT1s9s8PBzMvgjqmKqczL5O
         BlaXrEpPNIlp0wTBh1NTbwKBHkDmZOdPFV01U2I8BsCiLYWq20LuqpsJ67xXov7nUGRQ
         1lbg==
X-Gm-Message-State: ACgBeo1E0zSDzfyN/Qkg6dxeh16qF42P4VbqC6Xhm9fzEHz18kwB11Ra
        kQrJ98V/AjCsL93kGsqDPlI=
X-Google-Smtp-Source: AA6agR4FRbbPMtvRqX/5hP0/bZgqCYhCvLuKQaz+aS18TXcTF5H+GjAr3Mb6gzg+k9IBJSULeT9WmA==
X-Received: by 2002:adf:e109:0:b0:225:4ca5:80d5 with SMTP id t9-20020adfe109000000b002254ca580d5mr10019084wrz.465.1661343997531;
        Wed, 24 Aug 2022 05:26:37 -0700 (PDT)
Received: from localhost.localdomain ([213.57.189.88])
        by smtp.gmail.com with ESMTPSA id w3-20020adfde83000000b002253af82fa7sm17074708wrl.9.2022.08.24.05.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 05:26:37 -0700 (PDT)
From:   Eyal Birger <eyal.birger@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com
Cc:     bpf@vger.kernel.org, Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH bpf-next,v3] bpf/scripts: assert helper enum value is aligned with comment order
Date:   Wed, 24 Aug 2022 15:26:23 +0300
Message-Id: <20220824122623.1599477-1-eyal.birger@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The helper value is ABI as defined by enum bpf_func_id.
As bpf_helper_defs.h is used for the userpace part, it must be consistent
with this enum.

Before this change the comments order was used by the bpf_doc script in
order to set the helper values defined in the helpers file.

When adding new helpers it is very puzzling when the userspace application
breaks in weird places if the comment is inserted instead of appended -
because the generated helper ABI is incorrect and shifted.

This commit sets the helper value to the enum value.

In addition it is currently the practice to have the comments appended
and kept in the same order as the enum. As such, add an assertion
validating the comment order is consistent with enum value.

In case a different comments ordering is desired, this assertion can
be lifted.

Signed-off-by: Eyal Birger <eyal.birger@gmail.com>

---
v3: based on feedback from Quentin Monnet:
- move assertion to parser
- avoid using define_unique_helpers as elem_number_check() relies on
  it being an array
- set enum_val in helper object instead of passing as a dict to the
  printer

v2: based on feedback from Quentin Monnet:
- assert the current comment ordering
- match only one FN in each line
---
 scripts/bpf_doc.py | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index f4f3e7ec6d44..114b2a60afc8 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -50,6 +50,10 @@ class Helper(APIElement):
     @desc: textual description of the helper function
     @ret: description of the return value of the helper function
     """
+    def __init__(self, *args, **kwargs):
+        super().__init__(*args, **kwargs)
+        self.enum_value = None
+
     def proto_break_down(self):
         """
         Break down helper function protocol into smaller chunks: return type,
@@ -92,6 +96,7 @@ class HeaderParser(object):
         self.commands = []
         self.desc_unique_helpers = set()
         self.define_unique_helpers = []
+        self.helper_enum_vals = {}
         self.desc_syscalls = []
         self.enum_syscalls = []
 
@@ -248,30 +253,54 @@ class HeaderParser(object):
                 break
 
     def parse_define_helpers(self):
-        # Parse the number of FN(...) in #define __BPF_FUNC_MAPPER to compare
-        # later with the number of unique function names present in description.
+        # Parse FN(...) in #define __BPF_FUNC_MAPPER to compare later with the
+        # number of unique function names present in description and use the
+        # correct enumeration value.
         # Note: seek_to(..) discards the first line below the target search text,
         # resulting in FN(unspec) being skipped and not added to self.define_unique_helpers.
         self.seek_to('#define __BPF_FUNC_MAPPER(FN)',
                      'Could not find start of eBPF helper definition list')
-        # Searches for either one or more FN(\w+) defines or a backslash for newline
-        p = re.compile('\s*(FN\(\w+\))+|\\\\')
+        # Searches for one FN(\w+) define or a backslash for newline
+        p = re.compile('\s*FN\((\w+)\)|\\\\')
         fn_defines_str = ''
+        i = 1  # 'unspec' is skipped as mentioned above
         while True:
             capture = p.match(self.line)
             if capture:
                 fn_defines_str += self.line
+                self.helper_enum_vals[capture.expand(r'bpf_\1')] = i
+                i += 1
             else:
                 break
             self.line = self.reader.readline()
         # Find the number of occurences of FN(\w+)
         self.define_unique_helpers = re.findall('FN\(\w+\)', fn_defines_str)
 
+    def assign_helper_values(self):
+        seen_helpers = set()
+        for helper in self.helpers:
+            proto = helper.proto_break_down()
+            name = proto['name']
+            try:
+                enum_val = self.helper_enum_vals[name]
+            except KeyError:
+                raise Exception("Helper %s is missing from enum bpf_func_id" % name)
+
+            # Enforce current practice of having the descriptions ordered
+            # by enum value.
+            seen_helpers.add(name)
+            desc_val = len(seen_helpers)
+            if desc_val != enum_val:
+                raise Exception("Helper %s comment order (#%d) must be aligned with its position (#%d) in enum bpf_func_id" % (name, desc_val, enum_val))
+
+            helper.enum_val = enum_val
+
     def run(self):
         self.parse_desc_syscall()
         self.parse_enum_syscall()
         self.parse_desc_helpers()
         self.parse_define_helpers()
+        self.assign_helper_values()
         self.reader.close()
 
 ###############################################################################
@@ -796,7 +825,7 @@ class PrinterHelpers(Printer):
             comma = ', '
             print(one_arg, end='')
 
-        print(') = (void *) %d;' % len(self.seen_helpers))
+        print(') = (void *) %d;' % helper.enum_val)
         print('')
 
 ###############################################################################
-- 
2.34.1

