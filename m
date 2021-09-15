Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550E140C9B3
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 18:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhIOQGf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 12:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhIOQGf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Sep 2021 12:06:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EA5C061574
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 09:05:16 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id e26so2601393wmk.2
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 09:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j5qiGNc6TL4ZxIaAssezpy+bCEyPPH0oPGpAv/m9MRQ=;
        b=beycTiFpFkpZrqKFlhgb8YrW3r+e1bEATQaAZrKtlg0B5S06AqSY9uCPEEXOIOP5+b
         Hq44FuIo/G3N+jZ+gDqIHZQ986NX2qbn0zZnVSYgdAmyZY5mZAAFUEMTvou7rufTiXVt
         Ao0LvZcVFGzTArInZCcK879lYcio/PAPZc6QKBaCFlXKOxoQZV6wyj6ebLk9ie9z1hwV
         ss4Mf/LyOuUj3fQmDzabilJbn5l3MeLCgoHAArMRsAhOT6dk3EhO7b0RHwHUKoI63squ
         1EeeyCZnienR3DzTCBXHY0mXK55UoEp6ikSgULpdLNolra0raQNeKEKf1V3yFzElmoIp
         jEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j5qiGNc6TL4ZxIaAssezpy+bCEyPPH0oPGpAv/m9MRQ=;
        b=lE1gXJDyK1fbLv16NlymyxOs+2FgacYB0uxbP7O7p5z63kxMIg6aYVOUXbIZQSRS8V
         xQClxwlq1k4aACSd6k0LUJPTq23GJYPcLpmXGECGc2vV0dipE+gBHfabxopfsmw/vT+N
         wET3Y8JsYfKjU2L56MTVTy6Znj4rwXhR5qK3d7U4JVGRuKSM7+4KzCHtds4ZWtoqAqTA
         EdUynREyiIXBF3vOAJ+AxGDoUSdSHSm6wPp3vzLWbZl4r3Ij5fueIWDueSmWCJ2Kd4DI
         CfbAJcgRWrnmcBCCvi3gSbd8WItsmo/YWjDcuGZo0QuVQX2Z1iqyqdJeqDjb0FWPAi3U
         PazA==
X-Gm-Message-State: AOAM532Ugr4nLjlBZMZ/T6xgM1s4+a23dJXSfMx28Y+R1FdKVbJwgY27
        9fGMJtdMrrykbQSi8t9wHXNrHxgyb6khAg==
X-Google-Smtp-Source: ABdhPJzXuoKKrc8CUrkIPhJ0Eo+blqXadAPQhlbW40sp4Lo4YB2SjStVw/5c8kg9SW9qjhAQiycotw==
X-Received: by 2002:a1c:21c3:: with SMTP id h186mr482812wmh.89.1631721914309;
        Wed, 15 Sep 2021 09:05:14 -0700 (PDT)
Received: from localhost.localdomain ([109.255.233.251])
        by smtp.gmail.com with ESMTPSA id q128sm5743757wma.27.2021.09.15.09.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 09:05:13 -0700 (PDT)
From:   Piotr Krysiuk <piotras@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        paulburton@kernel.org, johan.almbladh@anyfinetworks.com,
        tsbogend@alpha.franken.de, Piotr Krysiuk <piotras@gmail.com>
Subject: [PATCH] bpf, mips: Validate conditional branch offsets
Date:   Wed, 15 Sep 2021 17:04:37 +0100
Message-Id: <20210915160437.4080-1-piotras@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The conditional branch instructions on MIPS use 18-bit signed offsets
allowing for a branch range of 128 KBytes (backward and forward).
However, this limit is not observed by the cBPF JIT compiler, and so
the JIT compiler emits out-of-range branches when translating certain
cBPF programs. A specific example of such a cBPF program is included in
the "BPF_MAXINSNS: exec all MSH" test from lib/test_bpf.c that executes
anomalous machine code containing incorrect branch offsets under JIT.

Furthermore, this issue can be abused to craft undesirable machine
code, where the control flow is hijacked to execute arbitrary Kernel
code.

The following steps can be used to reproduce the issue:

# echo 1 > /proc/sys/net/core/bpf_jit_enable
# modprobe test_bpf test_name="BPF_MAXINSNS: exec all MSH"

This should produce multiple warnings from build_bimm() similar to:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 209 at arch/mips/mm/uasm-mips.c:210 build_insn+0x558/0x590
Micro-assembler field overflow
Modules linked in: test_bpf(+)
CPU: 0 PID: 209 Comm: modprobe Not tainted 5.14.3 #1
Stack : 00000000 807bb824 82b33c9c 801843c0 00000000 00000004 00000000 63c9b5ee
        82b33af4 80999898 80910000 80900000 82fd6030 00000001 82b33a98 82087180
        00000000 00000000 80873b28 00000000 000000fc 82b3394c 00000000 2e34312e
        6d6d6f43 809a180f 809a1836 6f6d203a 80900000 00000001 82b33bac 80900000
        00027f80 00000000 00000000 807bb824 00000000 804ed790 001cc317 00000001
        ...
Call Trace:
[<80108f44>] show_stack+0x38/0x118
[<807a7aac>] dump_stack_lvl+0x5c/0x7c
[<807a4b3c>] __warn+0xcc/0x140
[<807a4c3c>] warn_slowpath_fmt+0x8c/0xb8
[<8011e198>] build_insn+0x558/0x590
[<8011e358>] uasm_i_bne+0x20/0x2c
[<80127b48>] build_body+0xa58/0x2a94
[<80129c98>] bpf_jit_compile+0x114/0x1e4
[<80613fc4>] bpf_prepare_filter+0x2ec/0x4e4
[<8061423c>] bpf_prog_create+0x80/0xc4
[<c0a006e4>] test_bpf_init+0x300/0xba8 [test_bpf]
[<8010051c>] do_one_initcall+0x50/0x1d4
[<801c5e54>] do_init_module+0x60/0x220
[<801c8b20>] sys_finit_module+0xc4/0xfc
[<801144d0>] syscall_common+0x34/0x58

---[ end trace a287d9742503c645 ]---

Then the anomalous machine code executes:

=> 0xc0a18000:  addiu   sp,sp,-16
   0xc0a18004:  sw      s3,0(sp)
   0xc0a18008:  sw      s4,4(sp)
   0xc0a1800c:  sw      s5,8(sp)
   0xc0a18010:  sw      ra,12(sp)
   0xc0a18014:  move    s5,a0
   0xc0a18018:  move    s4,zero
   0xc0a1801c:  move    s3,zero

   # __BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0)
   0xc0a18020:  lui     t6,0x8012
   0xc0a18024:  ori     t4,t6,0x9e14
   0xc0a18028:  li      a1,0
   0xc0a1802c:  jalr    t4
   0xc0a18030:  move    a0,s5
   0xc0a18034:  bnez    v0,0xc0a1ffb8           # incorrect branch offset
   0xc0a18038:  move    v0,zero
   0xc0a1803c:  andi    s4,s3,0xf
   0xc0a18040:  b       0xc0a18048
   0xc0a18044:  sll     s4,s4,0x2
   ...

   # __BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0)
   0xc0a1ffa0:  lui     t6,0x8012
   0xc0a1ffa4:  ori     t4,t6,0x9e14
   0xc0a1ffa8:  li      a1,0
   0xc0a1ffac:  jalr    t4
   0xc0a1ffb0:  move    a0,s5
   0xc0a1ffb4:  bnez    v0,0xc0a1ffb8           # incorrect branch offset
   0xc0a1ffb8:  move    v0,zero
   0xc0a1ffbc:  andi    s4,s3,0xf
   0xc0a1ffc0:  b       0xc0a1ffc8
   0xc0a1ffc4:  sll     s4,s4,0x2

   # __BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, 0)
   0xc0a1ffc8:  lui     t6,0x8012
   0xc0a1ffcc:  ori     t4,t6,0x9e14
   0xc0a1ffd0:  li      a1,0
   0xc0a1ffd4:  jalr    t4
   0xc0a1ffd8:  move    a0,s5
   0xc0a1ffdc:  bnez    v0,0xc0a3ffb8           # correct branch offset
   0xc0a1ffe0:  move    v0,zero
   0xc0a1ffe4:  andi    s4,s3,0xf
   0xc0a1ffe8:  b       0xc0a1fff0
   0xc0a1ffec:  sll     s4,s4,0x2
   ...

   # epilogue
   0xc0a3ffb8:  lw      s3,0(sp)
   0xc0a3ffbc:  lw      s4,4(sp)
   0xc0a3ffc0:  lw      s5,8(sp)
   0xc0a3ffc4:  lw      ra,12(sp)
   0xc0a3ffc8:  addiu   sp,sp,16
   0xc0a3ffcc:  jr      ra
   0xc0a3ffd0:  nop

To mitigate this issue, we assert the branch ranges for each emit call
that could generate an out-of-range branch.

Fixes: 36366e367ee9 ("MIPS: BPF: Restore MIPS32 cBPF JIT")
Fixes: c6610de353da ("MIPS: net: Add BPF JIT")
Signed-off-by: Piotr Krysiuk <piotras@gmail.com>
---
 arch/mips/net/bpf_jit.c | 57 +++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 14 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 0af88622c619..cb6d22439f71 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -662,6 +662,11 @@ static void build_epilogue(struct jit_ctx *ctx)
 	((int)K < 0 ? ((int)K >= SKF_LL_OFF ? func##_negative : func) : \
 	 func##_positive)
 
+static bool is_bad_offset(int b_off)
+{
+	return b_off > 0x1ffff || b_off < -0x20000;
+}
+
 static int build_body(struct jit_ctx *ctx)
 {
 	const struct bpf_prog *prog = ctx->skf;
@@ -728,7 +733,10 @@ static int build_body(struct jit_ctx *ctx)
 			/* Load return register on DS for failures */
 			emit_reg_move(r_ret, r_zero, ctx);
 			/* Return with error */
-			emit_b(b_imm(prog->len, ctx), ctx);
+			b_off = b_imm(prog->len, ctx);
+			if (is_bad_offset(b_off))
+				return -E2BIG;
+			emit_b(b_off, ctx);
 			emit_nop(ctx);
 			break;
 		case BPF_LD | BPF_W | BPF_IND:
@@ -775,8 +783,10 @@ static int build_body(struct jit_ctx *ctx)
 			emit_jalr(MIPS_R_RA, r_s0, ctx);
 			emit_reg_move(MIPS_R_A0, r_skb, ctx); /* delay slot */
 			/* Check the error value */
-			emit_bcond(MIPS_COND_NE, r_ret, 0,
-				   b_imm(prog->len, ctx), ctx);
+			b_off = b_imm(prog->len, ctx);
+			if (is_bad_offset(b_off))
+				return -E2BIG;
+			emit_bcond(MIPS_COND_NE, r_ret, 0, b_off, ctx);
 			emit_reg_move(r_ret, r_zero, ctx);
 			/* We are good */
 			/* X <- P[1:K] & 0xf */
@@ -855,8 +865,10 @@ static int build_body(struct jit_ctx *ctx)
 			/* A /= X */
 			ctx->flags |= SEEN_X | SEEN_A;
 			/* Check if r_X is zero */
-			emit_bcond(MIPS_COND_EQ, r_X, r_zero,
-				   b_imm(prog->len, ctx), ctx);
+			b_off = b_imm(prog->len, ctx);
+			if (is_bad_offset(b_off))
+				return -E2BIG;
+			emit_bcond(MIPS_COND_EQ, r_X, r_zero, b_off, ctx);
 			emit_load_imm(r_ret, 0, ctx); /* delay slot */
 			emit_div(r_A, r_X, ctx);
 			break;
@@ -864,8 +876,10 @@ static int build_body(struct jit_ctx *ctx)
 			/* A %= X */
 			ctx->flags |= SEEN_X | SEEN_A;
 			/* Check if r_X is zero */
-			emit_bcond(MIPS_COND_EQ, r_X, r_zero,
-				   b_imm(prog->len, ctx), ctx);
+			b_off = b_imm(prog->len, ctx);
+			if (is_bad_offset(b_off))
+				return -E2BIG;
+			emit_bcond(MIPS_COND_EQ, r_X, r_zero, b_off, ctx);
 			emit_load_imm(r_ret, 0, ctx); /* delay slot */
 			emit_mod(r_A, r_X, ctx);
 			break;
@@ -926,7 +940,10 @@ static int build_body(struct jit_ctx *ctx)
 			break;
 		case BPF_JMP | BPF_JA:
 			/* pc += K */
-			emit_b(b_imm(i + k + 1, ctx), ctx);
+			b_off = b_imm(i + k + 1, ctx);
+			if (is_bad_offset(b_off))
+				return -E2BIG;
+			emit_b(b_off, ctx);
 			emit_nop(ctx);
 			break;
 		case BPF_JMP | BPF_JEQ | BPF_K:
@@ -1056,12 +1073,16 @@ static int build_body(struct jit_ctx *ctx)
 			break;
 		case BPF_RET | BPF_A:
 			ctx->flags |= SEEN_A;
-			if (i != prog->len - 1)
+			if (i != prog->len - 1) {
 				/*
 				 * If this is not the last instruction
 				 * then jump to the epilogue
 				 */
-				emit_b(b_imm(prog->len, ctx), ctx);
+				b_off = b_imm(prog->len, ctx);
+				if (is_bad_offset(b_off))
+					return -E2BIG;
+				emit_b(b_off, ctx);
+			}
 			emit_reg_move(r_ret, r_A, ctx); /* delay slot */
 			break;
 		case BPF_RET | BPF_K:
@@ -1075,7 +1096,10 @@ static int build_body(struct jit_ctx *ctx)
 				 * If this is not the last instruction
 				 * then jump to the epilogue
 				 */
-				emit_b(b_imm(prog->len, ctx), ctx);
+				b_off = b_imm(prog->len, ctx);
+				if (is_bad_offset(b_off))
+					return -E2BIG;
+				emit_b(b_off, ctx);
 				emit_nop(ctx);
 			}
 			break;
@@ -1133,8 +1157,10 @@ static int build_body(struct jit_ctx *ctx)
 			/* Load *dev pointer */
 			emit_load_ptr(r_s0, r_skb, off, ctx);
 			/* error (0) in the delay slot */
-			emit_bcond(MIPS_COND_EQ, r_s0, r_zero,
-				   b_imm(prog->len, ctx), ctx);
+			b_off = b_imm(prog->len, ctx);
+			if (is_bad_offset(b_off))
+				return -E2BIG;
+			emit_bcond(MIPS_COND_EQ, r_s0, r_zero, b_off, ctx);
 			emit_reg_move(r_ret, r_zero, ctx);
 			if (code == (BPF_ANC | SKF_AD_IFINDEX)) {
 				BUILD_BUG_ON(sizeof_field(struct net_device, ifindex) != 4);
@@ -1244,7 +1270,10 @@ void bpf_jit_compile(struct bpf_prog *fp)
 
 	/* Generate the actual JIT code */
 	build_prologue(&ctx);
-	build_body(&ctx);
+	if (build_body(&ctx)) {
+		module_memfree(ctx.target);
+		goto out;
+	}
 	build_epilogue(&ctx);
 
 	/* Update the icache */
-- 
2.30.2

