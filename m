Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090F5629063
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 04:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbiKODED (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 22:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237555AbiKODDN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 22:03:13 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A08810B6
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 19:02:19 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x11-20020a056a000bcb00b0056c6ec11eefso7090729pfu.14
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 19:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5AIkCTUh38LdhgjcqmXMopWX95gOLvjqlIhAbQ6HyA=;
        b=ZwvO7zet084WHw2NNbL2nH/2JhepQmESb/xkbKDrZhFD7rXiVClnYJnNz2HPlkFqu9
         Ry+yzF0yZ8oiV7/OJEQazrwgilIw6a7C3V6GeatC+nPUohEmxF7rcFqep8BVmsZ4zkdl
         qIG4GOhaL3WMrLDYlnxvKEIY5Ylaxa6JSxZOOzAiFjFY3/b1+tjCPqlMaoLb2+zbfmLh
         3eXcY6OTSJHXwqYPdiE1zqOsrpaMF2Hpq9pgIVOlpSKWdIYvsKQB0/Z+svvx1rsMcFN1
         AVfAGx4kLB4T3kV4jIyy3345Y0VqRwtwiSAEWOShlAMxnRJs8FuZfe7+g8Td1QxXybYd
         YbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5AIkCTUh38LdhgjcqmXMopWX95gOLvjqlIhAbQ6HyA=;
        b=xKzc6RpfjyIT/5wZseRcbtcK3xu0hr4ndYe5kASB7as7aCQTDH39YhrM6uRyGTglSN
         E5yk1h0KlpXG+JFOFIoiIhrO0UlZ5Qb/MO9knbyZvburOiXKqfJxgruDPJhZ3PbjOOpZ
         0ZxGSL1ynVEM6t6oGXjHFWsh5RTQ3VdLLqRujcFgGcM1R84dL+RCWyvd64/FqyzE5AwN
         t+KAcc2IQv0YeG4YXg8Sz8NiuKJ+uGeZ2CEl7TvlMGCfTrZr/C/1YrNwmNqosTFKWNYt
         sNMpmyBxnAFqE4vmyt5OOxSLFSMrhADoe987/J0tosrlGIUYNJvV7tuS+qXmdZslhg7n
         cEoQ==
X-Gm-Message-State: ANoB5pkMBoteXGzqsmDkSKbPAs0YO6EFdXcIac4txZ7czisxjStnkQG+
        jPGKgulhd+y8wOMMOVGwEyz7qaBbdOilQyGvho+G+OteIM9GkYz2YV/kPbHVAUb7Khj2eZN9NcO
        sF+ZU0Gr7vdyAcmlKk0Avrd/oYW2ZMnhqd5lUSI0ZnKBKrIqs7A==
X-Google-Smtp-Source: AA0mqf5ShA3hCnfBoDvhrowJbJznEs4r+D7gQF9n9YYWRe0n8Vk+I8CK63wpuPvFahtMYEOmePixyTA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a62:6283:0:b0:56e:989d:7410 with SMTP id
 w125-20020a626283000000b0056e989d7410mr16594601pfb.1.1668481339043; Mon, 14
 Nov 2022 19:02:19 -0800 (PST)
Date:   Mon, 14 Nov 2022 19:02:03 -0800
In-Reply-To: <20221115030210.3159213-1-sdf@google.com>
Mime-Version: 1.0
References: <20221115030210.3159213-1-sdf@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221115030210.3159213-5-sdf@google.com>
Subject: [PATCH bpf-next 04/11] bpf: Implement hidden BPF_PUSH64 and BPF_POP64 instructions
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Zi Shen Lim <zlim.lnx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implemented for:
- x86_64 jit (tested)
- arm64 jit (untested)

Interpreter is not implemented because push/pop are currently
used only with xdp kfunc and jit is required to use kfuncs.

Fundamentally:
  BPF_ST | BPF_STACK + src_reg == store into the stack
  BPF_LD | BPF_STACK + dst_reg == load from the stack
  off/imm are unused

Updated disasm code to properly dump these new instructions:

  31: (e2) push r1
  32: (79) r5 = *(u64 *)(r1 +56)
  33: (55) if r5 != 0x0 goto pc+2
  34: (b7) r0 = 0
  35: (05) goto pc+1
  36: (79) r0 = *(u64 *)(r5 +32)
  37: (e0) pop r1

Cc: Zi Shen Lim <zlim.lnx@gmail.com>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 arch/arm64/net/bpf_jit_comp.c |  8 ++++++++
 arch/x86/net/bpf_jit_comp.c   |  8 ++++++++
 include/linux/filter.h        | 23 +++++++++++++++++++++++
 kernel/bpf/disasm.c           |  6 ++++++
 4 files changed, 45 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 62f805f427b7..4c0e70e6572a 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1185,6 +1185,14 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		 */
 		break;
 
+		/* kernel hidden stack operations */
+	case BPF_ST | BPF_STACK:
+		emit(A64_PUSH(src, src, A64_SP), ctx);
+		break;
+	case BPF_LD | BPF_STACK:
+		emit(A64_POP(dst, dst, A64_SP), ctx);
+		break;
+
 	/* ST: *(size *)(dst + off) = imm */
 	case BPF_ST | BPF_MEM | BPF_W:
 	case BPF_ST | BPF_MEM | BPF_H:
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index cec5195602bc..528bece87ca4 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1324,6 +1324,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 			EMIT_LFENCE();
 			break;
 
+			/* kernel hidden stack operations */
+		case BPF_ST | BPF_STACK:
+			EMIT1(add_1reg(0x50, src_reg)); /* pushq  */
+			break;
+		case BPF_LD | BPF_STACK:
+			EMIT1(add_1reg(0x58, dst_reg)); /* popq */
+			break;
+
 			/* ST: *(u8*)(dst_reg + off) = imm */
 		case BPF_ST | BPF_MEM | BPF_B:
 			if (is_ereg(dst_reg))
diff --git a/include/linux/filter.h b/include/linux/filter.h
index efc42a6e3aed..42c61ec8f895 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -76,6 +76,9 @@ struct ctl_table_header;
  */
 #define BPF_NOSPEC	0xc0
 
+/* unused opcode for kernel hidden stack operations */
+#define BPF_STACK	0xe0
+
 /* As per nm, we expose JITed images as text (code) section for
  * kallsyms. That way, tools like perf can find it to match
  * addresses.
@@ -402,6 +405,26 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 		.off   = 0,					\
 		.imm   = 0 })
 
+/* Push SRC register value onto the stack */
+
+#define BPF_PUSH64(SRC)						\
+	((struct bpf_insn) {					\
+		.code  = BPF_ST | BPF_STACK,			\
+		.dst_reg = 0,					\
+		.src_reg = SRC,					\
+		.off   = 0,					\
+		.imm   = 0 })
+
+/* Pop stack value into DST register */
+
+#define BPF_POP64(DST)						\
+	((struct bpf_insn) {					\
+		.code  = BPF_LD | BPF_STACK,			\
+		.dst_reg = DST,					\
+		.src_reg = 0,					\
+		.off   = 0,					\
+		.imm   = 0 })
+
 /* Internal classic blocks for direct assignment */
 
 #define __BPF_STMT(CODE, K)					\
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 7b4afb7d96db..9cd22f3591de 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -214,6 +214,9 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->off, insn->imm);
 		} else if (BPF_MODE(insn->code) == 0xc0 /* BPF_NOSPEC, no UAPI */) {
 			verbose(cbs->private_data, "(%02x) nospec\n", insn->code);
+		} else if (BPF_MODE(insn->code) == 0xe0 /* BPF_STACK, no UAPI */) {
+			verbose(cbs->private_data, "(%02x) push r%d\n",
+				insn->code, insn->src_reg);
 		} else {
 			verbose(cbs->private_data, "BUG_st_%02x\n", insn->code);
 		}
@@ -254,6 +257,9 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->code, insn->dst_reg,
 				__func_imm_name(cbs, insn, imm,
 						tmp, sizeof(tmp)));
+		} else if (BPF_MODE(insn->code) == 0xe0 /* BPF_STACK, no UAPI */) {
+			verbose(cbs->private_data, "(%02x) pop r%d\n",
+				insn->code, insn->dst_reg);
 		} else {
 			verbose(cbs->private_data, "BUG_ld_%02x\n", insn->code);
 			return;
-- 
2.38.1.431.g37b22c650d-goog

