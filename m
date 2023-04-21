Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F4E6EB0D9
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 19:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjDURnY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 13:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjDURnF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 13:43:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F9D10DB
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-2f95231618aso1299168f8f.1
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 10:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682098970; x=1684690970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHTjUK1nlMMZ5K5TaRoj7e1KPdrrZbj1t7pD8k+4mIg=;
        b=JRcrwpo31YOT2UTdDN5WBMHH5mRBUs9KzUlOfztrNt17w6zv5hm8Yh+odXYkCAGvA5
         EhomazDQjxXCFAf88EfSvVri47GFxNLeGyJGIuKhEXW0tkWZfRbZfqjL7sIfVxZJMZkR
         zr+OhBiLxqR8o7rJFYkx0k/Fk0fJ2LG07bZRh5w5xOxClnrPHLB2HlpsC3cc/hFgUmGo
         1NpzwD+L1ebDnhtL4kI+t2LPXtLJa6B2rANqStPsnoIY9zcZsFuT3XtT3rtNCoKeVCuf
         ngn2GF3lBXWRZl16aeAJwTAa0Zj0+I37b6OFmj7ZB6sX5nOkHPRZMzb5FxEoAuYhxxtn
         iHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098970; x=1684690970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHTjUK1nlMMZ5K5TaRoj7e1KPdrrZbj1t7pD8k+4mIg=;
        b=Zopm4KGzm3E07b7HirsIspYzSFqRUYfMPbJlkQEZpfvIZMDci4XSPB09AqFDm/rxU2
         DOx7UnI4M/MMtAIpaXG+or9YJgg6TslIeC7/a1iDjUCuwB0XtFseifMW7N9oeHPryvmM
         k3TkvqaeXQJlzrjGJMKSjUx913Ks8+tNCgoZ2bYixlV2bZWEc4034KWSI/1S/uYpa4QY
         E9pUud7yijdAxlwFp1p2vQ/6oXIeJ5kY+N3ssChI4UNdT9prgyCYZxJy9BFeKv6meCGV
         Oi6XhDtQ5uAEmVU4vWVQC92vh/AQEbztr9hnIonOdA95Gel4kHF7yOJtJz0Du6WGnFgJ
         3wqg==
X-Gm-Message-State: AAQBX9dYTIaVSBo3O5gKYtGOpU2NOAoC2ImuQhvgHjrAdeXkpdWexUDB
        +Of3RSd5P/R3+T0ygpQyxzfWMRGcylhp/g==
X-Google-Smtp-Source: AKy350b41cONiqyfsY2vXpZxMqgca+Y2fFnW0ofooj0wJxWGIt5i2xCvYWt8KHNm+jUvxqqxysQMfw==
X-Received: by 2002:a5d:4d49:0:b0:2f6:4a39:9701 with SMTP id a9-20020a5d4d49000000b002f64a399701mr4099082wru.41.1682098970084;
        Fri, 21 Apr 2023 10:42:50 -0700 (PDT)
Received: from bigfoot.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm4849933wrz.75.2023.04.21.10.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 10:42:49 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 04/24] selftests/bpf: verifier/btf_ctx_access converted to inline assembly
Date:   Fri, 21 Apr 2023 20:42:14 +0300
Message-Id: <20230421174234.2391278-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421174234.2391278-1-eddyz87@gmail.com>
References: <20230421174234.2391278-1-eddyz87@gmail.com>
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

Test verifier/btf_ctx_access automatically converted to use inline assembly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../bpf/progs/verifier_btf_ctx_access.c       | 32 +++++++++++++++++++
 .../selftests/bpf/verifier/btf_ctx_access.c   | 25 ---------------
 3 files changed, 34 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/btf_ctx_access.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index db55d125928c..b42601f7edcb 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -11,6 +11,7 @@
 #include "verifier_bounds_deduction_non_const.skel.h"
 #include "verifier_bounds_mix_sign_unsign.skel.h"
 #include "verifier_bpf_get_stack.skel.h"
+#include "verifier_btf_ctx_access.skel.h"
 #include "verifier_cfg.skel.h"
 #include "verifier_cgroup_inv_retcode.skel.h"
 #include "verifier_cgroup_skb.skel.h"
@@ -87,6 +88,7 @@ void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_deduction);
 void test_verifier_bounds_deduction_non_const(void)     { RUN(verifier_bounds_deduction_non_const); }
 void test_verifier_bounds_mix_sign_unsign(void) { RUN(verifier_bounds_mix_sign_unsign); }
 void test_verifier_bpf_get_stack(void)        { RUN(verifier_bpf_get_stack); }
+void test_verifier_btf_ctx_access(void)       { RUN(verifier_btf_ctx_access); }
 void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
 void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_retcode); }
 void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c b/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
new file mode 100644
index 000000000000..a570e48b917a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Converted from tools/testing/selftests/bpf/verifier/btf_ctx_access.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("fentry/bpf_modify_return_test")
+__description("btf_ctx_access accept")
+__success __retval(0)
+__naked void btf_ctx_access_accept(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + 8);		/* load 2nd argument value (int pointer) */\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("fentry/bpf_fentry_test9")
+__description("btf_ctx_access u32 pointer accept")
+__success __retval(0)
+__naked void ctx_access_u32_pointer_accept(void)
+{
+	asm volatile ("					\
+	r2 = *(u32*)(r1 + 0);		/* load 1nd argument value (u32 pointer) */\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/verifier/btf_ctx_access.c b/tools/testing/selftests/bpf/verifier/btf_ctx_access.c
deleted file mode 100644
index 0484d3de040d..000000000000
--- a/tools/testing/selftests/bpf/verifier/btf_ctx_access.c
+++ /dev/null
@@ -1,25 +0,0 @@
-{
-	"btf_ctx_access accept",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 8),	/* load 2nd argument value (int pointer) */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACING,
-	.expected_attach_type = BPF_TRACE_FENTRY,
-	.kfunc = "bpf_modify_return_test",
-},
-
-{
-	"btf_ctx_access u32 pointer accept",
-	.insns = {
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),	/* load 1nd argument value (u32 pointer) */
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.result = ACCEPT,
-	.prog_type = BPF_PROG_TYPE_TRACING,
-	.expected_attach_type = BPF_TRACE_FENTRY,
-	.kfunc = "bpf_fentry_test9",
-},
-- 
2.40.0

