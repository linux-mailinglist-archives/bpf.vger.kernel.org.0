Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6422F3468
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 16:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403868AbhALPoC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 10:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729397AbhALPoB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 10:44:01 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15D7C0617A4
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 07:42:46 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id w204so640091wmb.1
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 07:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ZTGQEWpWAiK+AJl9ZPeXz4p19Gfj2HCZL+15XnqwBus=;
        b=qK+5Htm26MeU6+gJ3X7VhdVrGERTVcewU4/bvrNs3gnN7qHBnnpNIr5SWl7979mEu3
         YgQL252A06kXXddF3PXFbB1XGuNBQk0eYNzUOhxqglEkhuWwaDFCBnko/vwbbJTW4EIQ
         2J9I+BjQABZ+gJ75bG2pJR5HQIHqmnbwNR7W5cHPvO4YNnA6jlRKSPLpX/js/CbdDwn+
         RRmooIqOvwszs2NOzfb/zUCn9fUX+waqwGCRNzDqawXaizDxLECSd67Us+nQF/jN0+Vd
         tf9+Tav6a4UjBTtoIRHmBPY/1o2/BVOp9hQcaKixulXG7ZUREoMUesL1HjviEBMb+VBq
         XXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZTGQEWpWAiK+AJl9ZPeXz4p19Gfj2HCZL+15XnqwBus=;
        b=VdW0lYRgNsIlLu92H/6sX7VgqvOHr3oFcxFBDbXOQZu2Q2lQ/rZ7xKmngZl+NjCRfo
         V6/9ii/GF1OJfkj8UMSxcra8+PEKRWCoInHf39Nd59mgliKphjX0+IL+TKNNH3rcY1yR
         cRphDXWLznyybtozHDkUOwGTH2Jnw3b/BxsAh1iT2VxPmcDhgGLf0nWlTCTF61TV08kB
         zgaCV3F/6KCUy3psIndfqPMFKckh3pIPSv6puJcrFYDlZPr6z4odSsHVDjWUhZLM/RjZ
         xJlhAZXd67wu+qQ3XvU2NXCoiAvjo9fyPpJkIfAfGqIsvVJieNjY+EkpzBz510FlwhvO
         f1cA==
X-Gm-Message-State: AOAM530r3DwOcMaVJf9JQQhb8U3OU8hC0ZqiKuyOGYZL1yHdk7wYVaEB
        wL4NKSHPnC+KBpTr8wdN5TABp93rkN+LYmn//GGp94Xy94Sp8zFMERNuzDqQi+/5QyKtypI5wQ2
        IIJoBY9QbG1hKbGTDZdd+aZHczjCQpbFs5wb7XUwvrMWFZsJp+PohspDns0H9wiQ=
X-Google-Smtp-Source: ABdhPJyW6XQ55d6NBrHqiCTtElubyhVpadacjAlnkBOxd1utVgSsfx15a4mip98cGUVXfCDOihGuVvYpYn8ZvA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:4489:: with SMTP id
 r131mr4256433wma.24.1610466165562; Tue, 12 Jan 2021 07:42:45 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:42:27 +0000
In-Reply-To: <20210112154235.2192781-1-jackmanb@google.com>
Message-Id: <20210112154235.2192781-4-jackmanb@google.com>
Mime-Version: 1.0
References: <20210112154235.2192781-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v6 03/11] bpf: x86: Factor out a lookup table for
 some ALU opcodes
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A later commit will need to lookup a subset of these opcodes. To
avoid duplicating code, pull out a table.

The shift opcodes won't be needed by that later commit, but they're
already duplicated, so fold them into the table anyway.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index f15c93275a18..93f32e0ba0ef 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -205,6 +205,18 @@ static u8 add_2reg(u8 byte, u32 dst_reg, u32 src_reg)
 	return byte + reg2hex[dst_reg] + (reg2hex[src_reg] << 3);
 }
 
+/* Some 1-byte opcodes for binary ALU operations */
+static u8 simple_alu_opcodes[] = {
+	[BPF_ADD] = 0x01,
+	[BPF_SUB] = 0x29,
+	[BPF_AND] = 0x21,
+	[BPF_OR] = 0x09,
+	[BPF_XOR] = 0x31,
+	[BPF_LSH] = 0xE0,
+	[BPF_RSH] = 0xE8,
+	[BPF_ARSH] = 0xF8,
+};
+
 static void jit_fill_hole(void *area, unsigned int size)
 {
 	/* Fill whole space with INT3 instructions */
@@ -862,15 +874,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		case BPF_ALU64 | BPF_AND | BPF_X:
 		case BPF_ALU64 | BPF_OR | BPF_X:
 		case BPF_ALU64 | BPF_XOR | BPF_X:
-			switch (BPF_OP(insn->code)) {
-			case BPF_ADD: b2 = 0x01; break;
-			case BPF_SUB: b2 = 0x29; break;
-			case BPF_AND: b2 = 0x21; break;
-			case BPF_OR: b2 = 0x09; break;
-			case BPF_XOR: b2 = 0x31; break;
-			}
 			maybe_emit_mod(&prog, dst_reg, src_reg,
 				       BPF_CLASS(insn->code) == BPF_ALU64);
+			b2 = simple_alu_opcodes[BPF_OP(insn->code)];
 			EMIT2(b2, add_2reg(0xC0, dst_reg, src_reg));
 			break;
 
@@ -1050,12 +1056,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			else if (is_ereg(dst_reg))
 				EMIT1(add_1mod(0x40, dst_reg));
 
-			switch (BPF_OP(insn->code)) {
-			case BPF_LSH: b3 = 0xE0; break;
-			case BPF_RSH: b3 = 0xE8; break;
-			case BPF_ARSH: b3 = 0xF8; break;
-			}
-
+			b3 = simple_alu_opcodes[BPF_OP(insn->code)];
 			if (imm32 == 1)
 				EMIT2(0xD1, add_1reg(b3, dst_reg));
 			else
@@ -1089,11 +1090,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			else if (is_ereg(dst_reg))
 				EMIT1(add_1mod(0x40, dst_reg));
 
-			switch (BPF_OP(insn->code)) {
-			case BPF_LSH: b3 = 0xE0; break;
-			case BPF_RSH: b3 = 0xE8; break;
-			case BPF_ARSH: b3 = 0xF8; break;
-			}
+			b3 = simple_alu_opcodes[BPF_OP(insn->code)];
 			EMIT2(0xD3, add_1reg(b3, dst_reg));
 
 			if (src_reg != BPF_REG_4)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

