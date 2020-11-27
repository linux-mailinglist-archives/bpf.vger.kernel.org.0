Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F128C2C6B16
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 18:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732719AbgK0R5v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 12:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732681AbgK0R5v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Nov 2020 12:57:51 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB672C0613D2
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:57:50 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id x62so235897qtd.11
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=pCm5bSXPkdYGa8DRY20xR0eBkPwWiyvd1AYgQ0fdFE4=;
        b=tIaLYwouJp51q4LpdC5w6IxE4wvtbS/vWXbBRw2PKuDiSDRPyxx1bUK25Gbdt41+Fx
         gkYmyxooYOjjdPNUl16J0NlVinIY0MfAxd+Mut69Qa0jLOfu7ZAZk+BDKjAYyi79C+yg
         20Lwa7gg9F3Tkbilhq4e+UBxxMCJFL50IPeczhuyV/0GcQo0xF54K5Dg0x5y5X5ekSKB
         665yHxJEDdyTcsDSHpSOnRBg56ZHLKv3cL7qxQuX0hCXlQp/mBpxx06VPdIOJBkXoBBU
         7aq2o+ACt8z0wgsQMpQOg/eo84fBNm00gfKu7bHs/e5XBA5+aDh9XtHf3OV2C+X+JiQT
         Pi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pCm5bSXPkdYGa8DRY20xR0eBkPwWiyvd1AYgQ0fdFE4=;
        b=icm7KKBYVvc+5QXTuggVpGScYGmZPUnF6nuy81Gf2VfEyDWzGZFihlrI+ovs+f3C8s
         FL20vjzQfWrd6Sbv8XjjpHxSe3OVMJqLGBIjnOZ5cJqDBiFLPT521+gE+Hx8HaqsafIh
         OUt/b7m9A2ZkjSRJgtNiRIpl3DvWK5p1RRkptuHtrdsQRBy3LPzWOqa00cSPEciUrxNz
         m51gQ0D6N6B7q66Jiy9pqxJ3hAPhrTrtQxDSbhpzLXfn8a7+ggxaZJ6vAFgntt1V0z7j
         hQgU5kEieOdI3HoPl0/Fc56HZi9+SRK4Tjx9XEmfYd/NRDvrnvenTOoHHTs1V8cWSSZ8
         q5aw==
X-Gm-Message-State: AOAM531UzM8Wqe0z8tBr1CYDjLYwhV0D+q9U+wVVDs0J2TSaHn4Ox0PE
        nc/gg7UzTWmSY67drgAXRHnWBAClMEsYI0HdJw5jvhJ8+su12zNrZhh6MJBOvBy7YEF+zp82Qbq
        jm0kKIMKdUBHqn2toIOF+kDq54/MleEryty2CjkKcekmP4KnH8usyNmjJn+tQSfQ=
X-Google-Smtp-Source: ABdhPJzoTKHY6AOlzu8QYufpg7MnqU6ov6YK+vXzSz8+X+Yy2baFZMiE73UJR6EQRj7V14nEU91/iqJa66GTjw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:ad4:4432:: with SMTP id
 e18mr9496712qvt.57.1606499869651; Fri, 27 Nov 2020 09:57:49 -0800 (PST)
Date:   Fri, 27 Nov 2020 17:57:26 +0000
In-Reply-To: <20201127175738.1085417-1-jackmanb@google.com>
Message-Id: <20201127175738.1085417-2-jackmanb@google.com>
Mime-Version: 1.0
References: <20201127175738.1085417-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 bpf-next 01/13] bpf: x86: Factor out emission of ModR/M for
 *(reg + off)
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

The case for JITing atomics is about to get more complicated. Let's
factor out some common code to make the review and result more
readable.

NB the atomics code doesn't yet use the new helper - a subsequent
patch will add its use as a side-effect of other changes.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/net/bpf_jit_comp.c | 42 +++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 796506dcfc42..94b17bd30e00 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -681,6 +681,27 @@ static void emit_mov_reg(u8 **pprog, bool is64, u32 dst_reg, u32 src_reg)
 	*pprog = prog;
 }
 
+/* Emit the ModR/M byte for addressing *(r1 + off) and r2 */
+static void emit_modrm_dstoff(u8 **pprog, u32 r1, u32 r2, int off)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+	if (is_imm8(off)) {
+		/* 1-byte signed displacement.
+		 *
+		 * If off == 0 we could skip this and save one extra byte, but
+		 * special case of x86 R13 which always needs an offset is not
+		 * worth the hassle
+		 */
+		EMIT2(add_2reg(0x40, r1, r2), off);
+	} else {
+		/* 4-byte signed displacement */
+		EMIT1_off32(add_2reg(0x80, r1, r2), off);
+	}
+	*pprog = prog;
+}
+
 /* LDX: dst_reg = *(u8*)(src_reg + off) */
 static void emit_ldx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 {
@@ -708,15 +729,7 @@ static void emit_ldx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 		EMIT2(add_2mod(0x48, src_reg, dst_reg), 0x8B);
 		break;
 	}
-	/*
-	 * If insn->off == 0 we can save one extra byte, but
-	 * special case of x86 R13 which always needs an offset
-	 * is not worth the hassle
-	 */
-	if (is_imm8(off))
-		EMIT2(add_2reg(0x40, src_reg, dst_reg), off);
-	else
-		EMIT1_off32(add_2reg(0x80, src_reg, dst_reg), off);
+	emit_modrm_dstoff(&prog, src_reg, dst_reg, off);
 	*pprog = prog;
 }
 
@@ -751,10 +764,7 @@ static void emit_stx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 		EMIT2(add_2mod(0x48, dst_reg, src_reg), 0x89);
 		break;
 	}
-	if (is_imm8(off))
-		EMIT2(add_2reg(0x40, dst_reg, src_reg), off);
-	else
-		EMIT1_off32(add_2reg(0x80, dst_reg, src_reg), off);
+	emit_modrm_dstoff(&prog, dst_reg, src_reg, off);
 	*pprog = prog;
 }
 
@@ -1240,11 +1250,7 @@ st:			if (is_imm8(insn->off))
 			goto xadd;
 		case BPF_STX | BPF_XADD | BPF_DW:
 			EMIT3(0xF0, add_2mod(0x48, dst_reg, src_reg), 0x01);
-xadd:			if (is_imm8(insn->off))
-				EMIT2(add_2reg(0x40, dst_reg, src_reg), insn->off);
-			else
-				EMIT1_off32(add_2reg(0x80, dst_reg, src_reg),
-					    insn->off);
+xadd:			emit_modrm_dstoff(&prog, dst_reg, src_reg, insn->off);
 			break;
 
 			/* call */
-- 
2.29.2.454.gaff20da3a2-goog

