Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE152C6B18
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 18:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732738AbgK0R5x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 12:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732731AbgK0R5x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Nov 2020 12:57:53 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D57C0613D2
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:57:52 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id d206so4119141qkc.23
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=S3LKp+3RvK8OZkmGe150smJLkvcUKra31qzmBdRpcwc=;
        b=HjJkNd/Fcb7hlI25N2/0RZaPOeJLmob9416QnTRAdWKyICh8nlL4N42gT7uYToO16V
         USLz0UptmPjQlEwvmgho10Ctx+6t/NUOYRkjpaHSs1tXiHAuEyx0ZT9LV8XtNL2aya/Y
         OPqXGnne4x7klTAiwv2z72/uksfWLkcx0t7tCr0/7WB8rUa9Xd16zdIYNBEhyk5oRYGB
         M2YonpjfV6Ujm7xik6fhgGm9CIFXiDZNT8bXQvkfBmtRtrpi3/w3rUL+iCDzq+M1sSu9
         4uzjdd34FZh4N8WzgTiXMirD6XpfZHgE98Xvtwh1wqemySCXDfdx4ar6Lm+Pr4qNrKES
         xmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S3LKp+3RvK8OZkmGe150smJLkvcUKra31qzmBdRpcwc=;
        b=mW617/JHXIuqHlZ5Ridhkk8NnNFJ7yn1Y3ULsa5PJam//JqSQ7Y6n/n9WG3FEr/1Wy
         Ev23/UzsMYsOvdeBSw3peqrBH6Wa2fGihVzkdjuhPINMeE8TF4gNLVKfvCTxIK/+NBDx
         VvNtENT4FDhn4wJfLc4XgTIf8LC8BgRh0wgE5bvGqeriohojL016SY+mjjnzEMvH5PVX
         A3J7IaPR7w+fhmmus11YK2X/9r03eP7tzwRV9OefLd3AxjDqSOqS6TGY6fOlx4nw567O
         oas9xs5L4ggpzmV3t2IuCJxpRaSTitN82+M9hp+OpHkf2htqkq2d7V3a6g2/OvhI6MS8
         6EzA==
X-Gm-Message-State: AOAM531vc2ULhp3FPB92oXoJmyALbolsMXo71/lCSV9UvLAIzNtHU+jc
        ZkU/a3X2s/lStXIfftl4ebzwabjghkhA5jSlJyB5CkV1/LESlrai0oD6hthX3VOahOKQ5assi/3
        rli7l0s7uQ+w+JIecSI+TrnaAM4bb0VZWZeMkTYm6lkB+7xGtyri2PJYmwoYoGw4=
X-Google-Smtp-Source: ABdhPJyyHmArdB3e3yTqjlnMow5d9+BjTkDGqoBU9a+C+qyn1UIo8b9nMbPDQY8AxWcN+k392VZX9ao0Cr7r+A==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6214:2b4:: with SMTP id
 m20mr9656499qvv.34.1606499871986; Fri, 27 Nov 2020 09:57:51 -0800 (PST)
Date:   Fri, 27 Nov 2020 17:57:27 +0000
In-Reply-To: <20201127175738.1085417-1-jackmanb@google.com>
Message-Id: <20201127175738.1085417-3-jackmanb@google.com>
Mime-Version: 1.0
References: <20201127175738.1085417-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 bpf-next 02/13] bpf: x86: Factor out emission of REX byte
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The JIT case for encoding atomic ops is about to get more
complicated. In order to make the review & resulting code easier,
let's factor out some shared helpers.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/net/bpf_jit_comp.c | 39 ++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 94b17bd30e00..a839c1a54276 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -702,6 +702,21 @@ static void emit_modrm_dstoff(u8 **pprog, u32 r1, u32 r2, int off)
 	*pprog = prog;
 }
 
+/*
+ * Emit a REX byte if it will be necessary to address these registers
+ */
+static void maybe_emit_rex(u8 **pprog, u32 reg_rm, u32 reg_reg, bool wide)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+	if (wide)
+		EMIT1(add_2mod(0x48, reg_rm, reg_reg));
+	else if (is_ereg(reg_rm) || is_ereg(reg_reg))
+		EMIT1(add_2mod(0x40, reg_rm, reg_reg));
+	*pprog = prog;
+}
+
 /* LDX: dst_reg = *(u8*)(src_reg + off) */
 static void emit_ldx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 {
@@ -854,10 +869,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			case BPF_OR: b2 = 0x09; break;
 			case BPF_XOR: b2 = 0x31; break;
 			}
-			if (BPF_CLASS(insn->code) == BPF_ALU64)
-				EMIT1(add_2mod(0x48, dst_reg, src_reg));
-			else if (is_ereg(dst_reg) || is_ereg(src_reg))
-				EMIT1(add_2mod(0x40, dst_reg, src_reg));
+			maybe_emit_rex(&prog, dst_reg, src_reg,
+				       BPF_CLASS(insn->code) == BPF_ALU64);
 			EMIT2(b2, add_2reg(0xC0, dst_reg, src_reg));
 			break;
 
@@ -1301,20 +1314,16 @@ xadd:			emit_modrm_dstoff(&prog, dst_reg, src_reg, insn->off);
 		case BPF_JMP32 | BPF_JSGE | BPF_X:
 		case BPF_JMP32 | BPF_JSLE | BPF_X:
 			/* cmp dst_reg, src_reg */
-			if (BPF_CLASS(insn->code) == BPF_JMP)
-				EMIT1(add_2mod(0x48, dst_reg, src_reg));
-			else if (is_ereg(dst_reg) || is_ereg(src_reg))
-				EMIT1(add_2mod(0x40, dst_reg, src_reg));
+			maybe_emit_rex(&prog, dst_reg, src_reg,
+				       BPF_CLASS(insn->code) == BPF_JMP);
 			EMIT2(0x39, add_2reg(0xC0, dst_reg, src_reg));
 			goto emit_cond_jmp;
 
 		case BPF_JMP | BPF_JSET | BPF_X:
 		case BPF_JMP32 | BPF_JSET | BPF_X:
 			/* test dst_reg, src_reg */
-			if (BPF_CLASS(insn->code) == BPF_JMP)
-				EMIT1(add_2mod(0x48, dst_reg, src_reg));
-			else if (is_ereg(dst_reg) || is_ereg(src_reg))
-				EMIT1(add_2mod(0x40, dst_reg, src_reg));
+			maybe_emit_rex(&prog, dst_reg, src_reg,
+				       BPF_CLASS(insn->code) == BPF_JMP);
 			EMIT2(0x85, add_2reg(0xC0, dst_reg, src_reg));
 			goto emit_cond_jmp;
 
@@ -1350,10 +1359,8 @@ xadd:			emit_modrm_dstoff(&prog, dst_reg, src_reg, insn->off);
 		case BPF_JMP32 | BPF_JSLE | BPF_K:
 			/* test dst_reg, dst_reg to save one extra byte */
 			if (imm32 == 0) {
-				if (BPF_CLASS(insn->code) == BPF_JMP)
-					EMIT1(add_2mod(0x48, dst_reg, dst_reg));
-				else if (is_ereg(dst_reg))
-					EMIT1(add_2mod(0x40, dst_reg, dst_reg));
+				maybe_emit_rex(&prog, dst_reg, dst_reg,
+					       BPF_CLASS(insn->code) == BPF_JMP);
 				EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
 				goto emit_cond_jmp;
 			}
-- 
2.29.2.454.gaff20da3a2-goog

