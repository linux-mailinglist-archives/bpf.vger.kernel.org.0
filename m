Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300BD599867
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 11:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348000AbiHSJNN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 05:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242959AbiHSJNM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 05:13:12 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917DC2181
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 02:13:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u14so4443309wrq.9
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 02:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ypeZ8t5+lS1GPmgig0Z7RCJC1wV2T8VE04TuEFrbnvE=;
        b=RZUt/43HuxfC6vElzCIKYrAaxxCOdwyXhSRcDcabt37jpWZ5KAgZhAEfKywnWEfvR7
         9n1Jh5stUI5TnnUt2FKA8ri6ZsgjRn17W8wF+/fv/yCqC+UASrZoAdckn/Fr6kxgqKK6
         gM8jUcfso+ZH1im/WMoHOaoaHUAjz3h3WMXQclmf7l/UsF1QNy08r3D8FghmLJaOa9mf
         e4TPXZ6kp9cLD46Wi1EzEjEL/v44Ctf92tGLo/B03WBFqxaCNTNbTEKiaKR2N30L0F9a
         cNA/j80zuwQP+6leOT4A0jjha4W2jqmsI6PlpzAJY9PMKKmZROLWmnVvnfh+CUo6+pu5
         s/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ypeZ8t5+lS1GPmgig0Z7RCJC1wV2T8VE04TuEFrbnvE=;
        b=xXU7RYYJna6BV3UIFBKxLdhBkihfk/iYAGwNcZ57zWnIn+jkOo1Nf+en6yYtQ9Odft
         JPxSxFh4vLzZWJ49vaazRibsiInqoIX6kNEhUYh+oSF6lup2+EjF586hwXSLNVVamR/P
         ZRRUDFyOF3eIb8ymeNb1wQeCDmTiTzL6Fa41d8Liv6MwDM9E1qDOVlNG+S6dsexu9+27
         4Vd7RV4fT39pj8DFvA0WOOQGDJ3lGlMl0xeJ5a+MjnsLZTF7aFraq+9qRP2Ffp2YQEGE
         IWiWStGa/UuKYNqorxi1/g2lb5sjYTJxHYdaxM8aM3McEBYwigfJSPhYAN+89Dsc+sPC
         pf8w==
X-Gm-Message-State: ACgBeo209UabAqf38V0hTFjxoqq2dFvYQK8JVeIzAWEVojZFc8BxIhjP
        4SOyljtN1p9bIhrb0jpFXfM=
X-Google-Smtp-Source: AA6agR7PcRHB2Qrmirw4N1aGlJktV3DlvEJ4Ux+CkT7nBmsF10ETsP6eLZ8KEC1NNAVGUnUFXkHJYA==
X-Received: by 2002:a5d:654e:0:b0:225:2ee3:6c2c with SMTP id z14-20020a5d654e000000b002252ee36c2cmr3554168wrv.93.1660900388642;
        Fri, 19 Aug 2022 02:13:08 -0700 (PDT)
Received: from jimi.localdomain ([213.57.189.88])
        by smtp.gmail.com with ESMTPSA id z6-20020a1cf406000000b003a2f2bb72d5sm9360175wma.45.2022.08.19.02.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 02:13:08 -0700 (PDT)
From:   Eyal Birger <eyal.birger@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH bpf-next] bpf/scripts: use helper enum value instead of relying on comment order
Date:   Fri, 19 Aug 2022 12:12:44 +0300
Message-Id: <20220819091244.1001962-1-eyal.birger@gmail.com>
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

Before this change, the enumerated value was derived from the comment
order, which assumes comments are always appended, however, there doesn't
seem to be an enforcement anywhere for maintaining a strict order.

When adding new helpers it is very puzzling when the userspace application
breaks in weird places if the comment is inserted instead of appended -
because the generated helper ABI is incorrect and shifted.

This commit attempts to ease this by always using bpf_func_id order as
the helper value.

Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
---
 scripts/bpf_doc.py | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index dfb260de17a8..7797aa032eca 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -88,7 +88,7 @@ class HeaderParser(object):
         self.helpers = []
         self.commands = []
         self.desc_unique_helpers = set()
-        self.define_unique_helpers = []
+        self.define_unique_helpers = {}
         self.desc_syscalls = []
         self.enum_syscalls = []
 
@@ -245,24 +245,24 @@ class HeaderParser(object):
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
         # Searches for either one or more FN(\w+) defines or a backslash for newline
-        p = re.compile('\s*(FN\(\w+\))+|\\\\')
-        fn_defines_str = ''
+        p = re.compile('\s*FN\((\w+)\)+|\\\\')
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
@@ -573,6 +573,7 @@ class PrinterHelpers(Printer):
     def __init__(self, parser):
         self.elements = parser.helpers
         self.elem_number_check(parser.desc_unique_helpers, parser.define_unique_helpers, 'helper', '__BPF_FUNC_MAPPER')
+        self.define_unique_helpers = parser.define_unique_helpers
 
     type_fwds = [
             'struct bpf_fib_lookup',
@@ -761,7 +762,7 @@ class PrinterHelpers(Printer):
             comma = ', '
             print(one_arg, end='')
 
-        print(') = (void *) %d;' % len(self.seen_helpers))
+        print(') = (void *) %d;' % self.define_unique_helpers[proto['name']])
         print('')
 
 ###############################################################################
-- 
2.34.1

