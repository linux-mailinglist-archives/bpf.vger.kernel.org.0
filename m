Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660CF2F3464
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 16:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391926AbhALPnX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 10:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391925AbhALPnX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 10:43:23 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F87C061795
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 07:42:42 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id w204so640016wmb.1
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 07:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4StJvEPcqpOoMaFQqXp2l4E4gqPLXrwP2qT6WBxKOzM=;
        b=Alxp/7McXhYTRj4ejJtb24GbL7XVg9SRHlt2G3JYcMOF79DupYcmHMkpMBV3rA26lL
         /t5W3RV9xFJTYTyzog+0/MA14nHuB+2z8uSslCINuDe4F9Z9NDg4EVm+QjsPIAHL+awx
         cUJBZs88nezRLWlkujK8fNlx1M5fdL+P/0pU4bJujWoHXzl5x0ZEctucjpdRaytc/ULD
         V8VivzQI/ByniVMebsIDDdapi5QgQx4tAXA2849ljJ4+913FTp0ftUwgjbZPjdDd74Rt
         ru5FJctTCCOPTy5xiYvXft5ecFFIUouOM2CVWeAeL+erG+cLh62c++oeysHylF9Wj7z3
         VQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4StJvEPcqpOoMaFQqXp2l4E4gqPLXrwP2qT6WBxKOzM=;
        b=N3/tG8/uosGiwkILYNJGuypDHH5Qg7FWmVXnGwbf/v4mIj8kFsJNGfh2AudhvgbD5z
         ImU1q3FKTvkjaP8VZLCei4h1yMNumRh8Tbxq8zVT7ny02IOPXE7BQxZY6xa3wBZvOg1y
         0R6koNmVBOBDqSXx3OV7kaVXzYmcktL6kbNDMuhK585FrBMZ0DvQX02/aDEeF9PsxhWF
         mNa/BrEuI8hUY9JrFrNeZTgF8WROnB6p8Q6fA69Ph9v5ygARV3bqvyOxzhAeUZlqSvqP
         BwZgLk+qgn6XtduURa4GDmwoba9qJUrT10SC/iakhnzPnfYm1NrXUf6lKP+mVHkYUSLv
         PG5g==
X-Gm-Message-State: AOAM531JlMKOPvT3k4z7cXdZhdpzGvFJHJzQjsCudybv8M62rHN08xaT
        k3nsieFVDiVxuTHm0ia8+SNv2bTwSUMMwYUYw21FIA9LtS5UpfKuuwPutlMrkmHuqnTf/gB8ivB
        b8tOz2QsFg0nyYy6rKfM+WHGQOnUyX4VnfCrSUiL7VlrgPK4NxQaApnN3sTLxCx8=
X-Google-Smtp-Source: ABdhPJy39n98utrSDxBW1caz3c1idclRUV/R3dDPJK/sQu0zHVoQF3090gJOgJ5v2X5g/AMrnVfOWm5chc32Wg==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:adf:8290:: with SMTP id
 16mr4792288wrc.27.1610466161171; Tue, 12 Jan 2021 07:42:41 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:42:25 +0000
In-Reply-To: <20210112154235.2192781-1-jackmanb@google.com>
Message-Id: <20210112154235.2192781-2-jackmanb@google.com>
Mime-Version: 1.0
References: <20210112154235.2192781-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v6 01/11] bpf: x86: Factor out emission of ModR/M for
 *(reg + off)
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

The case for JITing atomics is about to get more complicated. Let's
factor out some common code to make the review and result more
readable.

NB the atomics code doesn't yet use the new helper - a subsequent
patch will add its use as a side-effect of other changes.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/net/bpf_jit_comp.c | 43 +++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 796506dcfc42..30526776fa78 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -681,6 +681,27 @@ static void emit_mov_reg(u8 **pprog, bool is64, u32 dst_reg, u32 src_reg)
 	*pprog = prog;
 }
 
+/* Emit the suffix (ModR/M etc) for addressing *(ptr_reg + off) and val_reg */
+static void emit_insn_suffix(u8 **pprog, u32 ptr_reg, u32 val_reg, int off)
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
+		EMIT2(add_2reg(0x40, ptr_reg, val_reg), off);
+	} else {
+		/* 4-byte signed displacement */
+		EMIT1_off32(add_2reg(0x80, ptr_reg, val_reg), off);
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
+	emit_insn_suffix(&prog, src_reg, dst_reg, off);
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
+	emit_insn_suffix(&prog, dst_reg, src_reg, off);
 	*pprog = prog;
 }
 
@@ -1240,11 +1250,8 @@ st:			if (is_imm8(insn->off))
 			goto xadd;
 		case BPF_STX | BPF_XADD | BPF_DW:
 			EMIT3(0xF0, add_2mod(0x48, dst_reg, src_reg), 0x01);
-xadd:			if (is_imm8(insn->off))
-				EMIT2(add_2reg(0x40, dst_reg, src_reg), insn->off);
-			else
-				EMIT1_off32(add_2reg(0x80, dst_reg, src_reg),
-					    insn->off);
+xadd:
+			emit_modrm_dstoff(&prog, dst_reg, src_reg, insn->off);
 			break;
 
 			/* call */
-- 
2.30.0.284.gd98b1dd5eaa7-goog

