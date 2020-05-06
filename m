Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263631C64C9
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 02:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgEFADh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 May 2020 20:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbgEFADg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 May 2020 20:03:36 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9958C061A41
        for <bpf@vger.kernel.org>; Tue,  5 May 2020 17:03:35 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t9so10872pjw.0
        for <bpf@vger.kernel.org>; Tue, 05 May 2020 17:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FX6e20EgkCKDRplcbN8VIX8Q54OU7fQsuv0YDgw22to=;
        b=DGRBrU5lGGOAfmrpZkIzPhRETbzDiQU82spA1HQTJz0PJGRxx2nnsDinlYJB08t5Gs
         N9qJ+YxSQDx6R8jEiQy/+pinOvUHPL0UQsiyoQHMaWua1KOwacCH4h3fA7qjmKdgQx60
         egKbXI77B4sIMlPNVqIq+HeFM8XxaWfSoTxPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FX6e20EgkCKDRplcbN8VIX8Q54OU7fQsuv0YDgw22to=;
        b=p48FNqSG8K8EN6Cfs5eQoL8ZSLBY6O2U8wWYA9ytQ/HkzbqyrJPoZ6e3Q0JUG/u3pM
         9nCido1MUsi9DGwyL3pqC5bckxD2iXrqf+qPjwHDHe4aUzTwJ3Pdkai6rKm7g3CSClCn
         WrarFXN0zV+vKB6DWAYeZXHvGYjiljvP7CQOBJD8Q1sTyVyqcqhwphwPHu16/dc8TrW9
         mrIe76PgFalTl2adf5mcXI/I0aO5R4gV70TXBQj0lno6AoTCL2gGw2RZNLROW7o4jo29
         eD/uBcvxAtjipEeB3bL3XmC6yaXxmFa9pPG4ARfHV2JvQRS1z9lyGlghfbuNDJU9c7gx
         as+A==
X-Gm-Message-State: AGi0PuawhWJrp0QYW25oxJWuPo9fvsOUg01JOv+CoxdN+UPr4lim/oJ4
        6e6Ek6zPvfh9bVTDbDLfsMoAhAmmMv5yfw==
X-Google-Smtp-Source: APiQypLNx/JIySQJ9tf33R7EMx5nSMIBF/Nl3MLH+ZUPJbxEIkPuPEABvWRA4nvRflSAMZlcjS6SUw==
X-Received: by 2002:a17:90a:7065:: with SMTP id f92mr3527567pjk.160.1588723414979;
        Tue, 05 May 2020 17:03:34 -0700 (PDT)
Received: from localhost.localdomain (c-73-53-94-119.hsd1.wa.comcast.net. [73.53.94.119])
        by smtp.gmail.com with ESMTPSA id u3sm133912pfn.217.2020.05.05.17.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 17:03:34 -0700 (PDT)
From:   Luke Nelson <lukenels@cs.washington.edu>
X-Google-Original-From: Luke Nelson <luke.r.nels@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 4/4] bpf, riscv: Optimize BPF_JSET BPF_K using andi on RV64
Date:   Tue,  5 May 2020 17:03:20 -0700
Message-Id: <20200506000320.28965-5-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506000320.28965-1-luke.r.nels@gmail.com>
References: <20200506000320.28965-1-luke.r.nels@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch optimizes BPF_JSET BPF_K by using a RISC-V andi instruction
when the BPF immediate fits in 12 bits, instead of first loading the
immediate to a temporary register.

Examples of generated code with and without this optimization:

BPF_JMP_IMM(BPF_JSET, R1, 2, 1) without optimization:

  20: li    t1,2
  24: and   t1,a0,t1
  28: bnez  t1,0x30

BPF_JMP_IMM(BPF_JSET, R1, 2, 1) with optimization:

  20: andi  t1,a0,2
  24: bnez  t1,0x2c

BPF_JMP32_IMM(BPF_JSET, R1, 2, 1) without optimization:

  20: li    t1,2
  24: mv    t2,a0
  28: slli  t2,t2,0x20
  2c: srli  t2,t2,0x20
  30: slli  t1,t1,0x20
  34: srli  t1,t1,0x20
  38: and   t1,t2,t1
  3c: bnez  t1,0x44

BPF_JMP32_IMM(BPF_JSET, R1, 2, 1) with optimization:

  20: andi  t1,a0,2
  24: bnez  t1,0x2c

In these examples, because the upper 32 bits of the sign-extended
immediate are 0, BPF_JMP BPF_JSET and BPF_JMP32 BPF_JSET are equivalent
and therefore the JIT produces identical code for them.

Co-developed-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index b07cef952019..6cfd164cbe88 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -792,8 +792,6 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_JMP32 | BPF_JSGE | BPF_K:
 	case BPF_JMP | BPF_JSLE | BPF_K:
 	case BPF_JMP32 | BPF_JSLE | BPF_K:
-	case BPF_JMP | BPF_JSET | BPF_K:
-	case BPF_JMP32 | BPF_JSET | BPF_K:
 		rvoff = rv_offset(i, off, ctx);
 		s = ctx->ninsns;
 		if (imm) {
@@ -813,15 +811,28 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 
 		/* Adjust for extra insns */
 		rvoff -= (e - s) << 2;
+		emit_branch(BPF_OP(code), rd, rs, rvoff, ctx);
+		break;
 
-		if (BPF_OP(code) == BPF_JSET) {
-			/* Adjust for and */
-			rvoff -= 4;
-			emit(rv_and(rs, rd, rs), ctx);
-			emit_branch(BPF_JNE, rs, RV_REG_ZERO, rvoff, ctx);
+	case BPF_JMP | BPF_JSET | BPF_K:
+	case BPF_JMP32 | BPF_JSET | BPF_K:
+		rvoff = rv_offset(i, off, ctx);
+		s = ctx->ninsns;
+		if (is_12b_int(imm)) {
+			emit(rv_andi(RV_REG_T1, rd, imm), ctx);
 		} else {
-			emit_branch(BPF_OP(code), rd, rs, rvoff, ctx);
+			emit_imm(RV_REG_T1, imm, ctx);
+			emit(rv_and(RV_REG_T1, rd, RV_REG_T1), ctx);
 		}
+		/* For jset32, we should clear the upper 32 bits of t1, but
+		 * sign-extension is sufficient here and saves one instruction,
+		 * as t1 is used only in comparison against zero.
+		 */
+		if (!is64 && imm < 0)
+			emit(rv_addiw(RV_REG_T1, RV_REG_T1, 0), ctx);
+		e = ctx->ninsns;
+		rvoff -= (e - s) << 2;
+		emit_branch(BPF_JNE, RV_REG_T1, RV_REG_ZERO, rvoff, ctx);
 		break;
 
 	/* function call */
-- 
2.17.1

