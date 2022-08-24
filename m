Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A709F59F619
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 11:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbiHXJUB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 05:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbiHXJUA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 05:20:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB4569F6F
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 02:19:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h24so19977161wrb.8
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 02:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=kvkSlDre+GtwV6DDJu2lIVETMmQGjdy5PkI9pHRGkRA=;
        b=XW2JKNxcke9K+zB193mlWjNyOhKUhUNVOAIG9fi5LLvAIQ4wSK5CyIN/+UkyxoMZWi
         hVNB3ZlT5oR0ern/oLKvhUxtA2Fxf2JNppy6qIMXgDRmMHTpkqFIz4lQBJrPcBzNGcW3
         RLFhwdybCUs004A+thToqJqhm+9Zs1h2XWrShywUcf8pRCNk6eYkhZQPaM8BvoLbwIza
         iTXdERGyURISchK53ak8Rn1VeTffGcrZnPLTKbWicfUJXMsb4Bvi95aUZbEM9lKw5Bpa
         HGk7CFapJRSD6TlmiNtI3NYAslccLMwGEFfmiMblOLu9+okkyT5niMa1rCpgk3OfrAk5
         gq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=kvkSlDre+GtwV6DDJu2lIVETMmQGjdy5PkI9pHRGkRA=;
        b=hy8dKbkw73jde3u58kQlqc77Kgn14bzE3ffivU+yfeg+Rk5Hn7VgKvT5iG0eYq3ze1
         SNczlkw4Q687ey/tIcoOPbJAbtfY7iMP0z8jJRXF2t3HZJHr7UvnONK7Dd9WJBiR0oVR
         OUkunMunUhO3k6mhELEZX2e3anlD8gOlxpwxYKXuIp5M9yBA06/+6yzcwpNK2wnWl3rv
         3/ViULDXJU7YKoawZFKFNjZa5zbRvCLb0g+CiIMdaxTdE2p5hMlVFZNgwAy+sbpdyd5L
         y9PZjpzFRhu+jrQJzODnlIdgIrlai5xfAMdBLXn02xIR7esw59wYPIw+NDtMoQClVw2s
         lvtg==
X-Gm-Message-State: ACgBeo11/RBpWtWBTRRi1ritp0GPDTGFHFK1XUInBA1mK7sTbf8LaMsu
        pO/s7BtWuY+Gbmc7Ycnf/A4=
X-Google-Smtp-Source: AA6agR5u+mnqxxZ1U6GM1PKqX07dm2FsklpgHJ5RFB8+lNskUOpBQkA82JpNGm2VmSBoI2jG6wWkyA==
X-Received: by 2002:adf:de91:0:b0:225:2609:27c5 with SMTP id w17-20020adfde91000000b00225260927c5mr16189745wrl.252.1661332796717;
        Wed, 24 Aug 2022 02:19:56 -0700 (PDT)
Received: from localhost.localdomain ([213.57.189.88])
        by smtp.gmail.com with ESMTPSA id t63-20020a1c4642000000b003a673055e68sm1580253wma.0.2022.08.24.02.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 02:19:56 -0700 (PDT)
From:   Eyal Birger <eyal.birger@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com
Cc:     bpf@vger.kernel.org, Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH bpf-next,v2] bpf/scripts: assert helper enum value is aligned with comment order
Date:   Wed, 24 Aug 2022 12:19:40 +0300
Message-Id: <20220824091940.1578705-1-eyal.birger@gmail.com>
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

v2: based on feedback from Quentin Monnet:
- assert the current comment ordering
- match only one FN in each line
---
 scripts/bpf_doc.py | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index f4f3e7ec6d44..80dfb230459d 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -91,7 +91,7 @@ class HeaderParser(object):
         self.helpers = []
         self.commands = []
         self.desc_unique_helpers = set()
-        self.define_unique_helpers = []
+        self.define_unique_helpers = {}
         self.desc_syscalls = []
         self.enum_syscalls = []
 
@@ -248,24 +248,24 @@ class HeaderParser(object):
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
-        fn_defines_str = ''
+        # Searches for one FN(\w+) define or a backslash for newline
+        p = re.compile('\s*FN\((\w+)\)|\\\\')
+        i = 1  # 'unspec' is skipped as mentioned above
         while True:
             capture = p.match(self.line)
             if capture:
-                fn_defines_str += self.line
+                self.define_unique_helpers[capture.expand(r'bpf_\1')] = i
+                i += 1
             else:
                 break
             self.line = self.reader.readline()
-        # Find the number of occurences of FN(\w+)
-        self.define_unique_helpers = re.findall('FN\(\w+\)', fn_defines_str)
 
     def run(self):
         self.parse_desc_syscall()
@@ -608,6 +608,7 @@ class PrinterHelpers(Printer):
     def __init__(self, parser):
         self.elements = parser.helpers
         self.elem_number_check(parser.desc_unique_helpers, parser.define_unique_helpers, 'helper', '__BPF_FUNC_MAPPER')
+        self.define_unique_helpers = parser.define_unique_helpers
 
     type_fwds = [
             'struct bpf_fib_lookup',
@@ -796,7 +797,17 @@ class PrinterHelpers(Printer):
             comma = ', '
             print(one_arg, end='')
 
-        print(') = (void *) %d;' % len(self.seen_helpers))
+        helper_val = self.define_unique_helpers[proto['name']]
+
+        # Assert helper description order is aligned with the enum value
+        desc_val = len(self.seen_helpers)
+        if helper_val != desc_val:
+            print("Helper %s comment order (#%d) must be aligned with its enum "
+                  "order (#%d)" % (proto['name'], desc_val, helper_val),
+                  file=sys.stderr)
+            sys.exit(1)
+
+        print(') = (void *) %d;' % helper_val)
         print('')
 
 ###############################################################################
-- 
2.34.1

