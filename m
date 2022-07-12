Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337475729E2
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 01:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiGLX0N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 19:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiGLX0M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 19:26:12 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21714A850C;
        Tue, 12 Jul 2022 16:26:12 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p128so9421278iof.1;
        Tue, 12 Jul 2022 16:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d3YvOgvXOXgKJ9W7BKp/jkotIdUHeW5Mi6XOrIgvd1o=;
        b=kJSM4FUJOFEyyoUlphbsiJKDF2fNs2Q+gA9Fkw7292mE0XgsScrHFuFpU6ZaG4FHoR
         8jim+pM87JzYkIEcjbuYVe+HBhJyJVyRChTMGYD+s1rhfzt6Vs/gYwByIJSz5sKu9pXM
         zB2z8LCeDF6vGQvLA2uw2+SC+Ga1W5AOEQ8hfWuCtu++Q3rEHbrcGXCFpNp2ctU6bkBv
         ut0nnOg+/qJ3rMOoDwp/z6BntO0mnu0kbMy+W23h+qgP+uelv4SzTrRaAdwH8Dx1jVPL
         HHJoeJeEA9qaZNwHxV+uKU9sAnU9H0CTrhfBW8LK2TZ1oSOf4aapoR4OJPGX5PEpbM21
         dZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d3YvOgvXOXgKJ9W7BKp/jkotIdUHeW5Mi6XOrIgvd1o=;
        b=Q6D90a1P0MXm3L4Z2uKaobsrr6t5ScHnndXBe3HRGZxW2x5Yon3OtZpDuu0c83tjks
         N36e0XBfZ5CpCbLw75csglkerjvLWYR2yaCmoC+zTV+kT4014okynM8AirNqpKHxFWNa
         BB5IIVXuI9yYIwxyrsfSTx71/rt+u1cNmWKnfwcVzgyv2eatZrBB/HbG6JOjIKjpQZPp
         XLntxycvSCUR4dt2OGM8PCUklMcouWv587pNbuckff7lAea9872OyJfj5aEQUbv+Npo3
         3PxQVUL02+83Cms3ktojH994yU4duq+TzbXJ7iw9566Y0NvBzTzl/Em94TQHzpsSJKJ3
         bsIQ==
X-Gm-Message-State: AJIora9M3UhXcYnlJHHoA0bnRrFKxks1pcMjL3WQuUoAiEyCLGdqXbq0
        SEL66AiUdNc2AEFokr7JomjAl/VDDNMyrNYn
X-Google-Smtp-Source: AGRyM1saynzQkwGM+ob0Kfg8t62NJax3I9qIPugPBKcuk0nur2+1d9I6KibU7dK0bZ0KsICgPJcMuQ==
X-Received: by 2002:a05:6638:134a:b0:33f:20b6:398b with SMTP id u10-20020a056638134a00b0033f20b6398bmr334606jad.301.1657668371297;
        Tue, 12 Jul 2022 16:26:11 -0700 (PDT)
Received: from james-x399.localdomain (71-218-105-222.hlrn.qwest.net. [71.218.105.222])
        by smtp.gmail.com with ESMTPSA id o17-20020a92d4d1000000b002dbee570531sm4194605ilm.18.2022.07.12.16.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 16:26:10 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v3] bpf/scripts: Generate GCC compatible helpers
Date:   Tue, 12 Jul 2022 17:25:56 -0600
Message-Id: <20220712232556.248863-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The current bpf_helper_defs.h helpers are llvm specific and don't work
correctly with gcc.

GCC appears to required kernel helper funcs to have the following
attribute set: __attribute__((kernel_helper(NUM)))

Generate gcc compatible headers based on the format in bpf-helpers.h.

This generates GCC/Clang compatible helpers, for example:
	/* Helper macro for GCC/Clang compatibility */
	#define NOARG
	#if __GNUC__ && !__clang__
	#define BPF_HELPER_DEF(num, ret_star, ret_type, name, ...) \
	ret_type ret_star name(__VA_ARGS__) __attribute__((kernel_helper(num)));
	#else
	#define BPF_HELPER_DEF(num, ret_star, ret_type, name, ...) \
	static ret_type ret_star(*name)(__VA_ARGS__) = (void *) num;
	#endif

	BPF_HELPER_DEF(1, *, void, bpf_map_lookup_elem, void *map, const void *key)

	BPF_HELPER_DEF(2, NOARG, long, bpf_map_update_elem, void *map, const void *key, const void *value, __u64 flags)

See:
https://github.com/gcc-mirror/gcc/blob/releases/gcc-12.1.0/gcc/config/bpf/bpf-helpers.h#L24-L27

This fixes the following build error:
error: indirect call in function, which are not supported by eBPF

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - use a conditional helper macro
Changes v1 -> v2:
  - more details in commit log
---
 scripts/bpf_doc.py | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index a0ec321469bd..45f51ff1318c 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -717,6 +717,16 @@ class PrinterHelpers(Printer):
         header = '''\
 /* This is auto-generated file. See bpf_doc.py for details. */
 
+/* Helper macro for GCC/Clang compatibility */
+#define NOARG
+#if __GNUC__ && !__clang__
+#define BPF_HELPER_DEF(num, ret_star, ret_type, name, ...) \\
+ret_type ret_star name(__VA_ARGS__) __attribute__((kernel_helper(num)));
+#else
+#define BPF_HELPER_DEF(num, ret_star, ret_type, name, ...) \\
+static ret_type ret_star(*name)(__VA_ARGS__) = (void *) num;
+#endif
+
 /* Forward declarations of BPF structs */'''
 
         print(header)
@@ -746,6 +756,11 @@ class PrinterHelpers(Printer):
             return
         self.seen_helpers.add(proto['name'])
 
+        if proto['ret_star']:
+            ret_star = proto['ret_star']
+        else:
+            ret_star = 'NOARG'
+
         print('/*')
         print(" * %s" % proto['name'])
         print(" *")
@@ -762,8 +777,8 @@ class PrinterHelpers(Printer):
                 print(' *{}{}'.format(' \t' if line else '', line))
 
         print(' */')
-        print('static %s %s(*%s)(' % (self.map_type(proto['ret_type']),
-                                      proto['ret_star'], proto['name']), end='')
+        print('BPF_HELPER_DEF(%d, %s, %s, %s, ' % (len(self.seen_helpers),
+            ret_star, self.map_type(proto['ret_type']), proto['name']), end='')
         comma = ''
         for i, a in enumerate(proto['args']):
             t = a['type']
@@ -781,7 +796,7 @@ class PrinterHelpers(Printer):
             comma = ', '
             print(one_arg, end='')
 
-        print(') = (void *) %d;' % len(self.seen_helpers))
+        print(')')
         print('')
 
 ###############################################################################
-- 
2.34.1

