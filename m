Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE842F694C
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 19:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbhANSTa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 13:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbhANST2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 13:19:28 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6452C061793
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 10:18:13 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id l10so2549745wry.16
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 10:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ZTGQEWpWAiK+AJl9ZPeXz4p19Gfj2HCZL+15XnqwBus=;
        b=vGd4GGM3w5XE6M/i617DaYJS+kENfz87vmlw2tsz0M5NYCpCKQfWHCFzKe4Tf0j9ES
         NEIWfdG/VGrTz31tHYltF8nnOHNXQ1IWHPHo017ZgDOthgTqDs8RfnqvvK1xsM/sOfcp
         t+Jt3oxqal/zmhRI5hrRBwNLU5l92SYVlxIrE9wpWQSo+k9oyXyBo/71BeKm6Z4ZuOAG
         DSR3u0Tprz7Nj830fQDawnQfRaH7GmdXwjUr5bYcxI0OocpXdQiE4ZrlcercArLhALbh
         0r/vCvFR4wJVqPC/xYTgEamEbuONQSJ7OBmPuRLwT07Mwt+sgyU/ABi+hZhgGQuQtEfs
         INig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZTGQEWpWAiK+AJl9ZPeXz4p19Gfj2HCZL+15XnqwBus=;
        b=Z/bRzCtqeeAcpmiqFfgRW+hG5pgzsYX0VuYlHAEC/lFhm+qSOnXGxqDPou13AaiRCi
         bSXHjImE3L00FyjBTGtTpjn/zOM4h7YeNEDgIFkrplgtZY8eets4EUn7awX4N5AsZB1b
         tdN4T/kjWm0MQaWwrkgAZpFBxg9HGgX4tUr0PIqXznmsh0uKtQj471p7p/4sUEFMqcxc
         NHyKo+m6z8Hv6Fgsd2w+1fp7P4LPwdrdOZLt0xW1lDclHhzGexlAcgSedQIEmDSM/EEl
         Ds1p1oIEHL334nRCymAUUk4sLMtSZgshAR3j+akud2NlIuCIUZm/GjpPosxpceHAx3GQ
         DSnA==
X-Gm-Message-State: AOAM530tMtx8FBy78OL9lGDDPuSQQ/467A0ybgwYDCs3vvvzN2aOVqls
        a/aFHgQ245ny+t2Bww70QrDMiIGMuhxoC6TATGhcxTs66Im6Uf1eKrx7K0gYv4h257VIjHEkQnv
        eZcVUVZOeXMudmxD0LWz9k4R4rDpbvoNjfAJHGLCNYxwkKeryi6LfqZ8PEMWLvJk=
X-Google-Smtp-Source: ABdhPJwQiuyQV0PO5w4rA22M5XCr1oDX5lpNVltYUd6mc73yKRGJv9MHxI5me3z8hovOllPDs6B6K6byWmHfiw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:600c:2057:: with SMTP id
 p23mr5028719wmg.109.1610648292636; Thu, 14 Jan 2021 10:18:12 -0800 (PST)
Date:   Thu, 14 Jan 2021 18:17:43 +0000
In-Reply-To: <20210114181751.768687-1-jackmanb@google.com>
Message-Id: <20210114181751.768687-4-jackmanb@google.com>
Mime-Version: 1.0
References: <20210114181751.768687-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v7 03/11] bpf: x86: Factor out a lookup table for
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

