Return-Path: <bpf+bounces-331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7116FF391
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 16:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DEF52816BD
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 14:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1414D19E7C;
	Thu, 11 May 2023 14:05:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF521F922
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 14:05:23 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36AD1BE3
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 07:05:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-307664010fdso8009322f8f.0
        for <bpf@vger.kernel.org>; Thu, 11 May 2023 07:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683813920; x=1686405920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+0hKNNWmRQfIu/SiuEG0+az8Xkvq0CqyEA3LnGZyCAg=;
        b=KTGkmfBHhQFrmlEG8nvdfgLd4g64pwTK7QVz5UWaBKVzvMwVKnnFAs/XPa/+yg3zvD
         ViQkaRZBp2bh732aGJHebfT/fAcUX9OxPhHMJtf0yb5jd5RABp20/jRwmjtqoidG3+SV
         QN3yCR8poBgdBo3e26jSB8r2hJps7ljWZHLaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683813920; x=1686405920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0hKNNWmRQfIu/SiuEG0+az8Xkvq0CqyEA3LnGZyCAg=;
        b=R4RD6xmD8yQRKdmlFKCrRz6VIzIH/MXtWti5xWtIIckM2wOffbB29Y4mxX6U+w3EL8
         PfWfn1jeBy6+2qAuPwziJQ9Nt+PhqyshVhXonGc5gp9R9WKhgtDIssnI8ZUxgYx1LTJV
         47RWDa+FUMELI1Z5sWuabMZlQvVVZZRK59CXS66Cl+Xfn/UEP2c8GzIGXzTMiwEPaz75
         0viJX2Ca3wY1M7+NZlE04yYzujLkizraY27/7DjfdjYN2qvoRfkiAuFMGunUW7iTBl0v
         dsyZPCixVNhehmJzNTNYM0k+PLhU1N7UaRpgwyQC8EqiJyyvolthD7zJuK6PEZZ/1aTd
         UqlA==
X-Gm-Message-State: AC+VfDwMdT7gUFLl585uccUrOIHiln6b70xn+oK4JZ+pxzO/0mYWKWWy
	RqhFHy40eAGQIhorrDTddpSWEHctibwEyo4Alfc=
X-Google-Smtp-Source: ACHHUZ7rFCMX1qt7gZNWDKE0BlEiI6EWZb54dXhpG0bVe6/JSOdyFFgCCaHOrGPReNHwHvh3+2WILQ==
X-Received: by 2002:a5d:6049:0:b0:307:a7c6:7875 with SMTP id j9-20020a5d6049000000b00307a7c67875mr6460407wrt.56.1683813919515;
        Thu, 11 May 2023 07:05:19 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:9d82:f624:96da:8b56])
        by smtp.gmail.com with ESMTPSA id y15-20020adfe6cf000000b0030633152664sm20526078wrm.87.2023.05.11.07.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:05:18 -0700 (PDT)
From: Florent Revest <revest@chromium.org>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	mark.rutland@arm.com,
	xukuohai@huaweicloud.com,
	zlim.lnx@gmail.com,
	yhs@meta.com,
	Florent Revest <revest@chromium.org>,
	Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next v2] arm64,bpf: Support struct arguments in the BPF trampoline
Date: Thu, 11 May 2023 16:05:07 +0200
Message-ID: <20230511140507.514888-1-revest@chromium.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This extends the BPF trampoline JIT to support attachment to functions
that take small structures (up to 128bit) as argument. This is trivially
achieved by saving/restoring a number of "argument registers" rather
than a number of arguments.

The AAPCS64 section 6.8.2 describes the parameter passing ABI.
"Composite types" (like C structs) below 16 bytes (as enforced by the
BPF verifier) are provided as part of the 8 argument registers as
explained in the section C.12.

Signed-off-by: Florent Revest <revest@chromium.org>
Acked-by: Yonghong Song <yhs@fb.com>
---

Diff since v1: The stack layout comment now says "arg reg" instead of "arg".

 arch/arm64/net/bpf_jit_comp.c                | 55 ++++++++++----------
 tools/testing/selftests/bpf/DENYLIST.aarch64 |  1 -
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index b26da8efa616..145b540ec34f 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1731,21 +1731,21 @@ static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
 	}
 }
 
-static void save_args(struct jit_ctx *ctx, int args_off, int nargs)
+static void save_args(struct jit_ctx *ctx, int args_off, int nregs)
 {
 	int i;
 
-	for (i = 0; i < nargs; i++) {
+	for (i = 0; i < nregs; i++) {
 		emit(A64_STR64I(i, A64_SP, args_off), ctx);
 		args_off += 8;
 	}
 }
 
-static void restore_args(struct jit_ctx *ctx, int args_off, int nargs)
+static void restore_args(struct jit_ctx *ctx, int args_off, int nregs)
 {
 	int i;
 
-	for (i = 0; i < nargs; i++) {
+	for (i = 0; i < nregs; i++) {
 		emit(A64_LDR64I(i, A64_SP, args_off), ctx);
 		args_off += 8;
 	}
@@ -1764,7 +1764,7 @@ static void restore_args(struct jit_ctx *ctx, int args_off, int nargs)
  */
 static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 			      struct bpf_tramp_links *tlinks, void *orig_call,
-			      int nargs, u32 flags)
+			      int nregs, u32 flags)
 {
 	int i;
 	int stack_size;
@@ -1772,7 +1772,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	int regs_off;
 	int retval_off;
 	int args_off;
-	int nargs_off;
+	int nregs_off;
 	int ip_off;
 	int run_ctx_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
@@ -1795,11 +1795,11 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	 * SP + retval_off  [ return value      ] BPF_TRAMP_F_CALL_ORIG or
 	 *                                        BPF_TRAMP_F_RET_FENTRY_RET
 	 *
-	 *                  [ argN              ]
+	 *                  [ arg reg N         ]
 	 *                  [ ...               ]
-	 * SP + args_off    [ arg1              ]
+	 * SP + args_off    [ arg reg 1         ]
 	 *
-	 * SP + nargs_off   [ args count        ]
+	 * SP + nregs_off   [ arg regs count    ]
 	 *
 	 * SP + ip_off      [ traced function   ] BPF_TRAMP_F_IP_ARG flag
 	 *
@@ -1816,13 +1816,13 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	if (flags & BPF_TRAMP_F_IP_ARG)
 		stack_size += 8;
 
-	nargs_off = stack_size;
+	nregs_off = stack_size;
 	/* room for args count */
 	stack_size += 8;
 
 	args_off = stack_size;
 	/* room for args */
-	stack_size += nargs * 8;
+	stack_size += nregs * 8;
 
 	/* room for return value */
 	retval_off = stack_size;
@@ -1865,12 +1865,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 		emit(A64_STR64I(A64_R(10), A64_SP, ip_off), ctx);
 	}
 
-	/* save args count*/
-	emit(A64_MOVZ(1, A64_R(10), nargs, 0), ctx);
-	emit(A64_STR64I(A64_R(10), A64_SP, nargs_off), ctx);
+	/* save arg regs count*/
+	emit(A64_MOVZ(1, A64_R(10), nregs, 0), ctx);
+	emit(A64_STR64I(A64_R(10), A64_SP, nregs_off), ctx);
 
-	/* save args */
-	save_args(ctx, args_off, nargs);
+	/* save arg regs */
+	save_args(ctx, args_off, nregs);
 
 	/* save callee saved registers */
 	emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
@@ -1897,7 +1897,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_args(ctx, args_off, nargs);
+		restore_args(ctx, args_off, nregs);
 		/* call original func */
 		emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
 		emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);
@@ -1926,7 +1926,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	}
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_args(ctx, args_off, nargs);
+		restore_args(ctx, args_off, nregs);
 
 	/* restore callee saved register x19 and x20 */
 	emit(A64_LDR64I(A64_R(19), A64_SP, regs_off), ctx);
@@ -1967,24 +1967,25 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 				void *orig_call)
 {
 	int i, ret;
-	int nargs = m->nr_args;
+	int nregs = m->nr_args;
 	int max_insns = ((long)image_end - (long)image) / AARCH64_INSN_SIZE;
 	struct jit_ctx ctx = {
 		.image = NULL,
 		.idx = 0,
 	};
 
-	/* the first 8 arguments are passed by registers */
-	if (nargs > 8)
-		return -ENOTSUPP;
-
-	/* don't support struct argument */
+	/* extra registers needed for struct argument */
 	for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
+		/* The arg_size is at most 16 bytes, enforced by the verifier. */
 		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
-			return -ENOTSUPP;
+			nregs += (m->arg_size[i] + 7) / 8 - 1;
 	}
 
-	ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nargs, flags);
+	/* the first 8 registers are used for arguments */
+	if (nregs > 8)
+		return -ENOTSUPP;
+
+	ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nregs, flags);
 	if (ret < 0)
 		return ret;
 
@@ -1995,7 +1996,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 	ctx.idx = 0;
 
 	jit_fill_hole(image, (unsigned int)(image_end - image));
-	ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nargs, flags);
+	ret = prepare_trampoline(&ctx, im, tlinks, orig_call, nregs, flags);
 
 	if (ret > 0 && validate_code(&ctx) < 0)
 		ret = -EINVAL;
diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index cd42e2825bd2..08adc805878b 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -10,4 +10,3 @@ kprobe_multi_test/link_api_addrs                 # link_fd unexpected link_fd: a
 kprobe_multi_test/link_api_syms                  # link_fd unexpected link_fd: actual -95 < expected 0
 kprobe_multi_test/skel_api                       # libbpf: failed to load BPF skeleton 'kprobe_multi': -3
 module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
-tracing_struct                                   # tracing_struct__attach unexpected error: -524 (errno 524)
-- 
2.40.1.521.gf1e218fcd8-goog


