Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1019B6389C3
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 13:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiKYM3h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 07:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiKYM3c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 07:29:32 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41F91DF0A;
        Fri, 25 Nov 2022 04:29:29 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 9so4022006pfx.11;
        Fri, 25 Nov 2022 04:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hR3Ji7FcwArEUOjffLvo2iTNvZ9EMA692a+e3dnoDBg=;
        b=FxtXeFbxid3eirxxQDVYXmYLtwaSRUE9RGZBmnGrb9qBZlB4zwJEvJMmRww74Hnp/7
         fn/fNEutqmwY+Sjw+uFH6e/yb+lBsClPfKC+r6N2AHK62WWJhGSkMygTQggdRMH81j/N
         4bGi2emBWPXr3qPaP+08Iz28AVzTxrfLjDdwC2sby3Sle12EcXKYiSXa+Pu6Aam2DE7V
         QYbZ5SbG+/wzEsRQKRcSZd8w2Thgf9dSJysSn4E5XG8o/k6hcBRBXxogbHIiUpkjTmiS
         idpF2CmYvcm3HBiUHCyHiuXMdt/tCQn7+rEOuNxQZCH4k4IaNUwEha8vy1mPXXfVmtfo
         Ztqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hR3Ji7FcwArEUOjffLvo2iTNvZ9EMA692a+e3dnoDBg=;
        b=R6tG4uO+LRuEuk/pkT9PmgGJesN2ATDPTjSfTvPdtXiRHIe32TxLzuXyixnlt/Y6bX
         EYiA0xhLSHjSyQDp/fviq8QbyetuHK7pjkGemilvl5mrCFPxF0wGZQ/BtrVEAEgcNxgv
         q5VDLmvz1xnlV1b2cGAT+5GcTgSnH6WWmEfeznpgJOCzKmlhq39wFWFIcg76U7Ly0s4D
         kKS+q/HYeqczqESpExB9Kd3y20owvwCC1VYT+3JUfr50UZrfXLlUqOuaCZTtoMqwFCfO
         BUUiuQAOr/Mso/oOU7jBwIt24JCKqnmb5cVUuhndLsz96wKSGjlwrQIvhrhEq+cI5e1j
         z+Rg==
X-Gm-Message-State: ANoB5pl/VRnE/tudz6wpgodRvMkWwRPDxs+iU9SU4T4Ux8jfO1vralLU
        NrtjsIqCTi8hVyEgy7QgJoCaMOOCcfMN
X-Google-Smtp-Source: AA0mqf5W/mZeleKTEhTCUurqbC+wdEHK54rj8pQyporQcg7OGaRnkqQATio/kH7RocG2P0xjJEdfuA==
X-Received: by 2002:a65:49cb:0:b0:477:27f7:794a with SMTP id t11-20020a6549cb000000b0047727f7794amr17285309pgs.58.1669379369031;
        Fri, 25 Nov 2022 04:29:29 -0800 (PST)
Received: from localhost.localdomain ([144.214.0.6])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902a38e00b0018912c37c8fsm117009pla.129.2022.11.25.04.29.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Nov 2022 04:29:28 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf-next v3 1/3] bpf: Sanitize STX/ST in jited BPF progs with KASAN
Date:   Fri, 25 Nov 2022 20:29:10 +0800
Message-Id: <20221125122912.54709-2-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20221125122912.54709-1-sunhao.th@gmail.com>
References: <20221125122912.54709-1-sunhao.th@gmail.com>
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
all the scratch regs are saved to extended stack to make sure
the checking functions can't corrupt them. Then, the addr to
check plus offset is saved to R1, R0 is backed up to REG_AX.
We extend stack size in this mode because we don't rely on any
verifier's knowledge about calculated stack size or the liveness
of each reg. The corresponding bpf_asan_storeN() is inserted
before store insn, and then regs are restored. The checking
functions are instrumented with KASAN and they simply write to
the target addr for certain bytes, KASAN conducts the actual
checking. An extra Kconfig is used to enable this, so normal
use case won't be impacted at all.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 kernel/bpf/Kconfig    |  13 +++++
 kernel/bpf/verifier.c | 113 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)

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
index 6599d25dae38..7a31fceee370 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15327,6 +15327,26 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return 0;
 }
 
+#ifdef CONFIG_BPF_PROG_KASAN
+
+/* Those are functions instrumented with KASAN for actual sanitizing. */
+
+#define BPF_ASAN_STORE(n)                          \
+	notrace u64 bpf_asan_store##n(u##n *addr); \
+	notrace u64 bpf_asan_store##n(u##n *addr)  \
+	{                                          \
+		u##n ret = *addr;                  \
+		*addr = ret;                       \
+		return ret;                        \
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
@@ -15344,6 +15364,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 	struct bpf_prog *new_prog;
 	struct bpf_map *map_ptr;
 	int i, ret, cnt, delta = 0;
+#ifdef CONFIG_BPF_PROG_KASAN
+	bool in_patch_use_ax = false;
+#endif
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		/* Make divide-by-zero exceptions impossible. */
@@ -15460,6 +15483,92 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			continue;
 		}
 
+#ifdef CONFIG_BPF_PROG_KASAN
+
+/* With CONFIG_BPF_PROG_KASAN, we extend prog stack to MAX_BPF_STACK + 64
+ * to backup scratch regs before calling the sanitize functions, because
+ * we don't rely on verifier's knowledge about calculated stack size or
+ * liveness of each reg.
+ */
+#define __BACKUP_REG(n)                                         \
+	*patch++ = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_##n, \
+			       -(MAX_BPF_STACK + 8 * n))
+#define BACKUP_SCRATCH_REGS \
+	__BACKUP_REG(1);    \
+	__BACKUP_REG(2);    \
+	__BACKUP_REG(3);    \
+	__BACKUP_REG(4);    \
+	__BACKUP_REG(5)
+
+#define __RESTORE_REG(n)                                        \
+	*patch++ = BPF_LDX_MEM(BPF_DW, BPF_REG_##n, BPF_REG_10, \
+			       -(MAX_BPF_STACK + 8 * n))
+#define RESTORE_SCRATCH_REGS \
+	__RESTORE_REG(1);    \
+	__RESTORE_REG(2);    \
+	__RESTORE_REG(3);    \
+	__RESTORE_REG(4);    \
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
+			    BPF_MODE(insn->code) == BPF_NOSPEC)
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
+			BACKUP_SCRATCH_REGS;
+			*patch++ = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_0);
+			if (insn->dst_reg != BPF_REG_1)
+				*patch++ = BPF_MOV64_REG(BPF_REG_1, insn->dst_reg);
+			if (insn->off != 0)
+				*patch++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, insn->off);
+			*patch++ = sanitize_fn;
+			RESTORE_SCRATCH_REGS;
+			*patch++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_AX);
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
@@ -15852,6 +15961,10 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
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

