Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FB16A1586
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 04:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjBXDlG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 22:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBXDk4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 22:40:56 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BC16013E
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 19:40:46 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536cb268ab8so155125637b3.17
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 19:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=COcCL1RuPlrtQv/M0zJqPpXpZtIWKGOdSOSaIpnmqc0=;
        b=S9et4NA2Y+3yjx/zHug2YBeKwTYCZ5F+tL0oL5SIvF2HoOgkNjF0xtkFU+3wKsh77Y
         1h60CG/8UI7gvLOmOwrIszIT24M+nOxaGT/6Ib8vXoUFIIOedcB1bPL04yusXokHbf/w
         uOFwamGNfM418dktZcmao1FqB0W1+UjpUaLCekhZTfIfqc1xLiVpg4LbT0fjwEtTj9Dm
         d4g0wZHLVup+y+rWNfzIIGavXDyvJt2kD0Nc+nwjY4EHXAvsVKdHrzH/2S3Quwc2b4FD
         C7w2akalMpmyAksccQ5ULx7iEGbvvEQUobZskx5uLsayQWgRaJXxsTLAie1rV9O79Vtj
         y/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COcCL1RuPlrtQv/M0zJqPpXpZtIWKGOdSOSaIpnmqc0=;
        b=sH6ofFDGqFMtDkqk5zZQQnPB52D5ahWkl+0m09LnZS6VTfV/ZhdF/u2csHtbTEw8KK
         qCYEw50JcW07nSE5FyO06Nf8zihD0JEgol1iXudvm1d4cPBVsc58jyz25LXa192X1j5Y
         vPhdcftrp8ROVEUcDlqSwe3Hlmh5uA5kwu687rnwHJLsd/lY9z/jVu9b2LS5ZrMgmU4C
         phjLcBiIyLGh/+RDeUuyBlbN7WBHwhFZFZh83/rWJYn/0viUIliSpbHnjAarsJvxQmef
         IrtyjtDD1z408BBAZ4eon0jvQ4r22ZwPsGD++z5voar/WK/nDO5uE8/CxE5PFeecYLPo
         eypA==
X-Gm-Message-State: AO0yUKW10btas43PeVxkyVM/36MBkCwmFmQmKa478Kf0MFJTjt84ym3F
        QbV3jk6FO/kcEjbBNWgTtVWERO5kOAI=
X-Google-Smtp-Source: AK7set9sQBImjSEw6hSMkC77Qx+4gfNnWsGaQCSGqCOwenwD3YlIWJP/B0BW4UIYXRhCtD+q2ir2G4nO9PQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a5b:cc:0:b0:966:a047:4ce4 with SMTP id
 d12-20020a5b00cc000000b00966a0474ce4mr3005056ybp.10.1677210046078; Thu, 23
 Feb 2023 19:40:46 -0800 (PST)
Date:   Fri, 24 Feb 2023 03:40:18 +0000
In-Reply-To: <20230224034020.2080637-1-edliaw@google.com>
Mime-Version: 1.0
References: <20230224034020.2080637-1-edliaw@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230224034020.2080637-4-edliaw@google.com>
Subject: [PATCH 4.14 v3 3/4] bpf: Fix 32 bit src register truncation on div/mod
From:   Edward Liaw <edliaw@google.com>
To:     stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>
Cc:     bpf@vger.kernel.org, kernel-team@android.com,
        Edward Liaw <edliaw@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

Commit e88b2c6e5a4d9ce30d75391e4d950da74bb2bd90 upstream.

While reviewing a different fix, John and I noticed an oddity in one of the
BPF program dumps that stood out, for example:

  # bpftool p d x i 13
   0: (b7) r0 = 808464450
   1: (b4) w4 = 808464432
   2: (bc) w0 = w0
   3: (15) if r0 == 0x0 goto pc+1
   4: (9c) w4 %= w0
  [...]

In line 2 we noticed that the mov32 would 32 bit truncate the original src
register for the div/mod operation. While for the two operations the dst
register is typically marked unknown e.g. from adjust_scalar_min_max_vals()
the src register is not, and thus verifier keeps tracking original bounds,
simplified:

  0: R1=ctx(id=0,off=0,imm=0) R10=fp0
  0: (b7) r0 = -1
  1: R0_w=invP-1 R1=ctx(id=0,off=0,imm=0) R10=fp0
  1: (b7) r1 = -1
  2: R0_w=invP-1 R1_w=invP-1 R10=fp0
  2: (3c) w0 /= w1
  3: R0_w=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R1_w=invP-1 R10=fp0
  3: (77) r1 >>= 32
  4: R0_w=invP(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R1_w=invP4294967295 R10=fp0
  4: (bf) r0 = r1
  5: R0_w=invP4294967295 R1_w=invP4294967295 R10=fp0
  5: (95) exit
  processed 6 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

Runtime result of r0 at exit is 0 instead of expected -1. Remove the
verifier mov32 src rewrite in div/mod and replace it with a jmp32 test
instead. After the fix, we result in the following code generation when
having dividend r1 and divisor r6:

  div, 64 bit:                             div, 32 bit:

   0: (b7) r6 = 8                           0: (b7) r6 = 8
   1: (b7) r1 = 8                           1: (b7) r1 = 8
   2: (55) if r6 != 0x0 goto pc+2           2: (56) if w6 != 0x0 goto pc+2
   3: (ac) w1 ^= w1                         3: (ac) w1 ^= w1
   4: (05) goto pc+1                        4: (05) goto pc+1
   5: (3f) r1 /= r6                         5: (3c) w1 /= w6
   6: (b7) r0 = 0                           6: (b7) r0 = 0
   7: (95) exit                             7: (95) exit

  mod, 64 bit:                             mod, 32 bit:

   0: (b7) r6 = 8                           0: (b7) r6 = 8
   1: (b7) r1 = 8                           1: (b7) r1 = 8
   2: (15) if r6 == 0x0 goto pc+1           2: (16) if w6 == 0x0 goto pc+1
   3: (9f) r1 %= r6                         3: (9c) w1 %= w6
   4: (b7) r0 = 0                           4: (b7) r0 = 0
   5: (95) exit                             5: (95) exit

x86 in particular can throw a 'divide error' exception for div
instruction not only for divisor being zero, but also for the case
when the quotient is too large for the designated register. For the
edx:eax and rdx:rax dividend pair it is not an issue in x86 BPF JIT
since we always zero edx (rdx). Hence really the only protection
needed is against divisor being zero.

[Salvatore Bonaccorso: This is an earlier version of the patch provided
by Daniel Borkmann which does not rely on availability of the BPF_JMP32
instruction class. This means it is not even strictly a backport of the
upstream commit mentioned but based on Daniel's and John's work to
address the issue.]

Fixes: 68fda450a7df ("bpf: fix 32-bit divide by zero")
Co-developed-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 include/linux/filter.h | 24 ++++++++++++++++++++++++
 kernel/bpf/verifier.c  | 22 +++++++++++-----------
 2 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7c0e616362f0..55a639609070 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -67,6 +67,14 @@ struct bpf_prog_aux;
 
 /* ALU ops on registers, bpf_add|sub|...: dst_reg += src_reg */
 
+#define BPF_ALU_REG(CLASS, OP, DST, SRC)			\
+	((struct bpf_insn) {					\
+		.code  = CLASS | BPF_OP(OP) | BPF_X,		\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = 0,					\
+		.imm   = 0 })
+
 #define BPF_ALU64_REG(OP, DST, SRC)				\
 	((struct bpf_insn) {					\
 		.code  = BPF_ALU64 | BPF_OP(OP) | BPF_X,	\
@@ -113,6 +121,14 @@ struct bpf_prog_aux;
 
 /* Short form of mov, dst_reg = src_reg */
 
+#define BPF_MOV_REG(CLASS, DST, SRC)				\
+	((struct bpf_insn) {					\
+		.code  = CLASS | BPF_MOV | BPF_X,		\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = 0,					\
+		.imm   = 0 })
+
 #define BPF_MOV64_REG(DST, SRC)					\
 	((struct bpf_insn) {					\
 		.code  = BPF_ALU64 | BPF_MOV | BPF_X,		\
@@ -147,6 +163,14 @@ struct bpf_prog_aux;
 		.off   = 0,					\
 		.imm   = IMM })
 
+#define BPF_RAW_REG(insn, DST, SRC)				\
+	((struct bpf_insn) {					\
+		.code  = (insn).code,				\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = (insn).off,				\
+		.imm   = (insn).imm })
+
 /* BPF_LD_IMM64 macro encodes single 'load 64-bit immediate' insn */
 #define BPF_LD_IMM64(DST, IMM)					\
 	BPF_LD_IMM64_RAW(DST, 0, IMM)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 836791403129..9f04d413df92 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4845,28 +4845,28 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 		    insn->code == (BPF_ALU | BPF_DIV | BPF_X)) {
 			bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
 			struct bpf_insn mask_and_div[] = {
-				BPF_MOV32_REG(insn->src_reg, insn->src_reg),
+				BPF_MOV_REG(BPF_CLASS(insn->code), BPF_REG_AX, insn->src_reg),
 				/* Rx div 0 -> 0 */
-				BPF_JMP_IMM(BPF_JNE, insn->src_reg, 0, 2),
-				BPF_ALU32_REG(BPF_XOR, insn->dst_reg, insn->dst_reg),
+				BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, 2),
+				BPF_RAW_REG(*insn, insn->dst_reg, BPF_REG_AX),
 				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
-				*insn,
+				BPF_ALU_REG(BPF_CLASS(insn->code), BPF_XOR, insn->dst_reg, insn->dst_reg),
 			};
 			struct bpf_insn mask_and_mod[] = {
-				BPF_MOV32_REG(insn->src_reg, insn->src_reg),
+				BPF_MOV_REG(BPF_CLASS(insn->code), BPF_REG_AX, insn->src_reg),
 				/* Rx mod 0 -> Rx */
-				BPF_JMP_IMM(BPF_JEQ, insn->src_reg, 0, 1),
-				*insn,
+				BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, 1),
+				BPF_RAW_REG(*insn, insn->dst_reg, BPF_REG_AX),
 			};
 			struct bpf_insn *patchlet;
 
 			if (insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
 			    insn->code == (BPF_ALU | BPF_DIV | BPF_X)) {
-				patchlet = mask_and_div + (is64 ? 1 : 0);
-				cnt = ARRAY_SIZE(mask_and_div) - (is64 ? 1 : 0);
+				patchlet = mask_and_div;
+				cnt = ARRAY_SIZE(mask_and_div);
 			} else {
-				patchlet = mask_and_mod + (is64 ? 1 : 0);
-				cnt = ARRAY_SIZE(mask_and_mod) - (is64 ? 1 : 0);
+				patchlet = mask_and_mod;
+				cnt = ARRAY_SIZE(mask_and_mod);
 			}
 
 			new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
-- 
2.39.2.637.g21b0678d19-goog

