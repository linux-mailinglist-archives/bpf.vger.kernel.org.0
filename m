Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3018063840B
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 07:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKYGgq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 01:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKYGgp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 01:36:45 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589972936B;
        Thu, 24 Nov 2022 22:36:44 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id io19so3163831plb.8;
        Thu, 24 Nov 2022 22:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3IneC1I9Oj2a9ZQYDCBeO854k07TNWMYUvM3rNqiuM=;
        b=VK14oM4+0HxyoWy1YXQJ5JbPd1Ap7jYTcgoSfi5NBwTLnheCTgWFLCVzekM6Aj9jh2
         89dasAFT0kPib8zurZSr9U2N1h8YmcKUokQgPsz44zMvJAc+CISwgVCH1/5ByxwLh/SB
         rEMSytQik2Vd4mOwBoCKXUB2MCPPRsY/QIkwtSdW/BCVnYTAl6WRDhZ/GP+O4ZAii/MR
         QozxJPMwizuEmHXabY5yfe89FgVLjzxKt6Abd7FaWQlE1zawpvA92LUeyl3tVI6da9Qw
         hMXeSif3QTSXZBksKAKehEaAXxxfA9hM9ERBmEDI1EJMglfiGkphoAB7oJnQn1tPls0T
         YD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3IneC1I9Oj2a9ZQYDCBeO854k07TNWMYUvM3rNqiuM=;
        b=3JisJIMTnj2ePzRjt5CAO1+YMxN31oZQWplQuDiL+F7yGdDvDX1pkqzHVcVa04GsgO
         w/4/JC3QhNzctF2PjbAvbt/O2TIxRO+DzYw5mcUwmWf/nShF4i7hqV/Cyunh+HQ5pGFI
         Am4J62y4GWpRRR/aFk6+tFFkDkV9/OEnmbKtTRtL3Yu7BXXD5+fA99+hBOTPu7xsiPyn
         nVx7N+xUJIaCvCBKTv6+u8RRX5k+VIbD40QQEtwEGSR1+L/Xmsnv887A1mj3GwEHNBvu
         pQcyAUnXJ/XV8SO0A/dwW+PtvpeAOK5BMMu1Vw2J4rV/3Tw6J2CwV4WKXxSUQXGdDCdt
         CCGw==
X-Gm-Message-State: ANoB5pnXHBGN+fvaz/a5s59ifUpdF5qeobuUBmsNGJJHc3bTnpQ8qv4T
        LRzstCQ3dwoV1aQ7/maDCWbK14dahYQ3
X-Google-Smtp-Source: AA0mqf5nittPeOc5mAUZkRgcLNfCcF2tUjMOfO2XWu1OHq3TpG9WNEO1CF0qJsls1lEWcM96SOsbow==
X-Received: by 2002:a17:903:2ce:b0:186:e852:b271 with SMTP id s14-20020a17090302ce00b00186e852b271mr17344706plk.117.1669358203461;
        Thu, 24 Nov 2022 22:36:43 -0800 (PST)
Received: from pc.localdomain ([166.111.83.15])
        by smtp.gmail.com with ESMTPSA id nm18-20020a17090b19d200b001fd6066284dsm2214891pjb.6.2022.11.24.22.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 22:36:43 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next v2 1/3] bpf: Sanitize STX/ST in jited BPF progs with KASAN
Date:   Fri, 25 Nov 2022 14:36:28 +0800
Message-Id: <20221125063630.536657-2-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125063630.536657-1-sunhao.th@gmail.com>
References: <20221125063630.536657-1-sunhao.th@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make the verifier sanitize STX/ST insns in jited BPF programs
by dispatching addr to kernel functions that are instrumented
by KASAN.

Only STX/ST insns that aren't in patches added by other passes
using REG_AX or dst_reg isn't R10 are sanitized. The former
confilicts with us, the latter are trivial for the verifier to
check, skip them to reduce the footprint.

The instrumentation is conducted in bpf_misc_fixup(). During it,
R0 and R1 are backed up or exchanged with dst_reg, and the addr
to check is stored into R1. We extend stack size to backup all
the scatch regs, because we don't rely on verifier's knowledge
about the calculated stack size and liveness of each regs. And
the corresponding bpf_asan_storeN() is inserted before store.
The sanitize functions are instrumented with KASAN and they
simply write to the target addr for certain bytes, KASAN conducts
the actual checking. An extra Kconfig is used to enable this,
so normal use case won't be impacted at all.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 kernel/bpf/Kconfig    |  13 ++++
 kernel/bpf/verifier.c | 134 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index 2dfe1079f772..d41e1d2d26f1 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -99,4 +99,17 @@ config BPF_LSM
 
 	  If you are unsure how to answer this question, answer N.
 
+config BPF_PROG_KASAN
+	bool "Enable BPF Program Address Sanitize"
+	depends on BPF_JIT_ALWAYS_ON
+	depends on KASAN
+	help
+	  Enables instrumentation on LDX/STX/ST insn to capture memory
+	  access errors in BPF programs missed by the verifier.
+
+	  The actual check is conducted by KASAN, this feature presents
+	  certain overhead, and should be used mainly by testing purpose.
+
+	  If you are unsure how to answer this question, answer N.
+
 endmenu # "BPF subsystem"
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6599d25dae38..5519c24c5bd4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15327,6 +15327,25 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return 0;
 }
 
+#ifdef CONFIG_BPF_PROG_KASAN
+
+/* Those are functions instrumented with KASAN for actual sanitizing. */
+
+#define BPF_ASAN_STORE(n)                         \
+	notrace u64 bpf_asan_store##n(u##n *addr) \
+	{                                         \
+		u##n ret = *addr;                 \
+		*addr = ret;                      \
+		return ret;                       \
+	}
+
+BPF_ASAN_STORE(8);
+BPF_ASAN_STORE(16);
+BPF_ASAN_STORE(32);
+BPF_ASAN_STORE(64);
+
+#endif
+
 /* Do various post-verification rewrites in a single program pass.
  * These rewrites simplify JIT and interpreter implementations.
  */
@@ -15340,7 +15359,12 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 	const int insn_cnt = prog->len;
 	const struct bpf_map_ops *ops;
 	struct bpf_insn_aux_data *aux;
+#ifndef CONFIG_BPF_PROG_KASAN
 	struct bpf_insn insn_buf[16];
+#else
+	struct bpf_insn insn_buf[32];
+	bool in_patch_use_ax = false;
+#endif
 	struct bpf_prog *new_prog;
 	struct bpf_map *map_ptr;
 	int i, ret, cnt, delta = 0;
@@ -15460,6 +15484,112 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			continue;
 		}
 
+#ifdef CONFIG_BPF_PROG_KASAN
+
+/* With CONFIG_BPF_PROG_KASAN, we extend prog stack to MAX_BPF_STACK + 64
+ * to backup scratch regs before calling the sanitize functions, because
+ * we don't rely on verifier's knowledge about calculated stack size or
+ * liveness of each reg.
+ */
+#define __BACKUP_REG(n) \
+	*patch++ = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_##n, -(MAX_BPF_STACK + 8 * n))
+#define BACKUP_SCRATCH_REGS	\
+	__BACKUP_REG(1);	\
+	__BACKUP_REG(2);	\
+	__BACKUP_REG(3);	\
+	__BACKUP_REG(4);	\
+	__BACKUP_REG(5)
+
+#define __RESTORE_REG(n) \
+	*patch++ = BPF_LDX_MEM(BPF_DW, BPF_REG_##n, BPF_REG_10, -(MAX_BPF_STACK + 8 * n))
+#define RESTORE_SCRATCH_REGS	\
+	__RESTORE_REG(1);	\
+	__RESTORE_REG(2);	\
+	__RESTORE_REG(3);	\
+	__RESTORE_REG(4);	\
+	__RESTORE_REG(5)
+
+		/* Patches that use REG_AX confilict with us, skip it.
+		 * This starts with first use of REG_AX, stops only when
+		 * we see next ldx/stx/st insn with valid aux information.
+		 */
+		aux = &env->insn_aux_data[i + delta];
+		if (in_patch_use_ax && (int)aux->ptr_type != 0)
+			in_patch_use_ax = false;
+		if (insn->dst_reg == BPF_REG_AX || insn->src_reg == BPF_REG_AX)
+			in_patch_use_ax = true;
+
+		/* Sanitize ST/STX operation. */
+		if (BPF_CLASS(insn->code) == BPF_ST ||
+		    BPF_CLASS(insn->code) == BPF_STX) {
+			struct bpf_insn sanitize_fn;
+			struct bpf_insn *patch = &insn_buf[0];
+
+			/* Skip st/stx to R10, they're trivial to check. */
+			if (in_patch_use_ax || insn->dst_reg == BPF_REG_10 ||
+				BPF_MODE(insn->code) == BPF_NOSPEC)
+				continue;
+
+			switch (BPF_SIZE(insn->code)) {
+			case BPF_B:
+				sanitize_fn = BPF_EMIT_CALL(bpf_asan_store8);
+				break;
+			case BPF_H:
+				sanitize_fn = BPF_EMIT_CALL(bpf_asan_store16);
+				break;
+			case BPF_W:
+				sanitize_fn = BPF_EMIT_CALL(bpf_asan_store32);
+				break;
+			case BPF_DW:
+				sanitize_fn = BPF_EMIT_CALL(bpf_asan_store64);
+				break;
+			}
+
+			/* Backup R0 and R1, store `dst + off` to R1, invoke the
+			 * sanitize fn, and then restore each reg.
+			 */
+			if (insn->dst_reg == BPF_REG_1) {
+				*patch++ = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_0);
+			} else if (insn->dst_reg == BPF_REG_0) {
+				*patch++ = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_1);
+				*patch++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_0);
+			} else {
+				*patch++ = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_1);
+				*patch++ = BPF_MOV64_REG(BPF_REG_1, insn->dst_reg);
+				*patch++ = BPF_MOV64_REG(insn->dst_reg, BPF_REG_0);
+			}
+			if (insn->off != 0)
+				*patch++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, insn->off);
+			BACKUP_SCRATCH_REGS;
+			/* Call sanitize fn, R1~R5 are saved to stack during jit. */
+			*patch++ = sanitize_fn;
+			RESTORE_SCRATCH_REGS;
+			if (insn->off != 0)
+				*patch++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -insn->off);
+			if (insn->dst_reg == BPF_REG_1) {
+				*patch++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_AX);
+			} else if (insn->dst_reg == BPF_REG_0) {
+				*patch++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
+				*patch++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_AX);
+			} else {
+				*patch++ = BPF_MOV64_REG(BPF_REG_0, insn->dst_reg);
+				*patch++ = BPF_MOV64_REG(insn->dst_reg, BPF_REG_1);
+				*patch++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_AX);
+			}
+			*patch++ = *insn;
+			cnt = patch - insn_buf;
+
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta += cnt - 1;
+			env->prog = prog = new_prog;
+			insn = new_prog->insnsi + i + delta;
+			continue;
+		}
+#endif
+
 		if (insn->code != (BPF_JMP | BPF_CALL))
 			continue;
 		if (insn->src_reg == BPF_PSEUDO_CALL)
@@ -15852,6 +15982,10 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		}
 	}
 
+#ifdef CONFIG_BPF_PROG_KASAN
+	prog->aux->stack_depth = MAX_BPF_STACK + 64;
+#endif
+
 	sort_kfunc_descs_by_imm(env->prog);
 
 	return 0;
-- 
2.38.1

