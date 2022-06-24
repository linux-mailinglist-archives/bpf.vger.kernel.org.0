Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D6B558D1C
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 04:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiFXCHC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 22:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiFXCHA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 22:07:00 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D244E3A9
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 19:06:59 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z19so1411646edb.11
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 19:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3qFmR+ZzyTE/7iBqNnRBYvNlOiXaymY4to15+CafWDU=;
        b=B6pIx3QXSMWbgNT+Fmi9/D6Ah5+n3O7fc9lChwXckCpjicZrKO6Oh6E+EVZraSKIm6
         i1cYAkN/Mx2hr9vPZcjhPyIk5rMciMQOQdEPCkINtxN4+5ZbywKDBLhYY96BldCGoQFg
         +/H3Xg6jIvsPWkkFvnHYvioj/VB0Ef+Tl9fnPHM4+f0fseVSrUywSwtG2RTjMmPJH9HU
         IWSeyMQs/eVGcv++nuy+t4TdodA3vn42fPkWTLoUvV39jVqt8sEwBZLGRyNp2lMZ4T6P
         6j8nzLF/xMCbetVib31OsHqMsY2fyMtZkgmk3xDkZHTA/Qi4Y56thAlF6125YFXvVRFN
         JFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3qFmR+ZzyTE/7iBqNnRBYvNlOiXaymY4to15+CafWDU=;
        b=l28ffNUZVHa9tvnlu1lunUHLI+9tcYEpUa2e3vNs2D/sYUhQQYyNS7BdKRNSsPy5VT
         VNgcxeLeoSWfiOlFf7nUN4v3ElRLW6xj7gXugvTtxkVjKCP2Sg/G/nNpHnI2nCGBGGG5
         9KpaMdIVdPqvt8xDvfo67QQ2lhqiPWTDt7ltyvzVEZsBGHtftgK63rrh2ddFpfKFLLZR
         O4UchyxpnsEZaOFXZOrr0EdDEHejE8SNyDNYj01h0yGYEiM7K4N4naJv7MH3l37ZO7l1
         r1IRvoZT9e3yL4gydhhGPWKictTWD9VUzx8/McovzW3lSVn6ZVXEzK+ME7xpiHX0YDFQ
         H65g==
X-Gm-Message-State: AJIora/9hsKKYe2O3pamnvSgYQz7aI0vKnsXzHn2O6TU3J8qk3XyWr5K
        c4bkmhvoz3NF2Rvo9vdu6fUzW3RQGdgHSo6c
X-Google-Smtp-Source: AGRyM1sO7TC3yyKjv/KKlmjwLI+8TN9rfHE26GKBOGKy2kQCTAHwxCqPXlu8NO9m6+0z7Jao3YVqvQ==
X-Received: by 2002:a05:6402:1386:b0:431:6911:a151 with SMTP id b6-20020a056402138600b004316911a151mr14475595edv.105.1656036417963;
        Thu, 23 Jun 2022 19:06:57 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id h10-20020a50ed8a000000b00435728cd12fsm856595edr.18.2022.06.23.19.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 19:06:57 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, dan.carpenter@oracle.com
Cc:     eddyz87@gmail.com
Subject: [PATCH bpf-next 2/2] selftest/bpf: test for use after free bug fix in inline_bpf_loop
Date:   Fri, 24 Jun 2022 05:06:13 +0300
Message-Id: <20220624020613.548108-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624020613.548108-1-eddyz87@gmail.com>
References: <20220624020613.548108-1-eddyz87@gmail.com>
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

This test verifies that bpf_loop inlining works as expected when
address of `env->prog` is updated. This address is updated upon BPF
program reallocation.  Reallocation is handled by
core.c:bpf_prog_realloc, which reuses old memory if page boundary is
not crossed. The value of `len` in the test is chosen to cross this
boundary on bpf_loop patching.

Verifies that use after free bug in inline_bpf_loop() reported by Dan
Carpenter is fixed.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/test_verifier.c   | 39 +++++++++++++++++++
 .../selftests/bpf/verifier/bpf_loop_inline.c  | 11 ++++++
 2 files changed, 50 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 7fe897c66d81..f9d553fbf68a 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -425,6 +425,45 @@ static void bpf_fill_torturous_jumps(struct bpf_test *self)
 	}
 }
 
+static void bpf_fill_big_prog_with_loop_1(struct bpf_test *self)
+{
+	struct bpf_insn *insn = self->fill_insns;
+	/* This test was added to catch a specific use after free
+	 * error, which happened upon BPF program reallocation.
+	 * Reallocation is handled by core.c:bpf_prog_realloc, which
+	 * reuses old memory if page boundary is not crossed. The
+	 * value of `len` is chosen to cross this boundary on bpf_loop
+	 * patching.
+	 */
+	const int len = getpagesize() - 25;
+	int callback_load_idx;
+	int callback_idx;
+	int i = 0;
+
+	insn[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_1, 1);
+	callback_load_idx = i;
+	insn[i++] = BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW,
+				 BPF_REG_2, BPF_PSEUDO_FUNC, 0,
+				 777 /* filled below */);
+	insn[i++] = BPF_RAW_INSN(0, 0, 0, 0, 0);
+	insn[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0);
+	insn[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_4, 0);
+	insn[i++] = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop);
+
+	while (i < len - 3)
+		insn[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0);
+	insn[i++] = BPF_EXIT_INSN();
+
+	callback_idx = i;
+	insn[i++] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0);
+	insn[i++] = BPF_EXIT_INSN();
+
+	insn[callback_load_idx].imm = callback_idx - callback_load_idx - 1;
+	self->func_info[1].insn_off = callback_idx;
+	self->prog_len = i;
+	assert(i == len);
+}
+
 /* BPF_SK_LOOKUP contains 13 instructions, if you need to fix up maps */
 #define BPF_SK_LOOKUP(func)						\
 	/* struct bpf_sock_tuple tuple = {} */				\
diff --git a/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
index 232da07c93b5..2d0023659d88 100644
--- a/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
+++ b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
@@ -244,6 +244,17 @@
 	.func_info_cnt = 3,
 	BTF_TYPES
 },
+{
+	"inline bpf_loop call in a big program",
+	.insns = {},
+	.fill_helper = bpf_fill_big_prog_with_loop_1,
+	.expected_insns = { PSEUDO_CALL_INSN() },
+	.unexpected_insns = { HELPER_CALL_INSN() },
+	.result = ACCEPT,
+	.func_info = { { 0, MAIN_TYPE }, { 16, CALLBACK_TYPE } },
+	.func_info_cnt = 2,
+	BTF_TYPES
+},
 
 #undef HELPER_CALL_INSN
 #undef PSEUDO_CALL_INSN
-- 
2.25.1

