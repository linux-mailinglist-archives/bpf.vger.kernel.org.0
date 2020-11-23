Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6145C2C11FE
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 18:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbgKWRcV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 12:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730667AbgKWRcV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Nov 2020 12:32:21 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69F0C0613CF
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 09:32:19 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id x9so13400608qvt.16
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 09:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=pCm5bSXPkdYGa8DRY20xR0eBkPwWiyvd1AYgQ0fdFE4=;
        b=HhliMXauLQ0TrVwB8xd97VFOY7NCCoEm9IX+gtCpIFaPrvYlEjNCxEMYBxxUzzUWDz
         jVIMaqHqHtKuG+R7W347P75yyjILKcuVtHgAeOtGiMzcqLogSST7J7TaemOgkwuLVI8u
         HNW99QR6ouOn8LR7tlgkcVujDs/Y/6RVYtseGLHbgR4DO+DJF/dfG9AXCPJZD/hwJxx9
         Lu3puQMOorfBhg+175K3C52rkOp416zDm017w0LLvIVFF6DcdwSlzrrs4tvKQxCSfU80
         mF2vj3uOnYTt2JuP71wso3iYFwliO2jCoBN3FUwrCIW6p1SiCO3CW+K7Olh64/k/pnR4
         urlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pCm5bSXPkdYGa8DRY20xR0eBkPwWiyvd1AYgQ0fdFE4=;
        b=WqfKa1FM3uuhblMwYV69WtYen+eqJ6QdNv/QxHbg9RsfVwlZ25mvUDYiiaXkgv+Scp
         kHn5O2JFvKaCXNSlk0zxGR0o2EJlI7IVI2a3CxJes2PATdJQJRPwFy0nnC4g+MF+/jEC
         lSCiP5HeYCIRk3b20MM+V5yenOFPjlodWhJpbzUYM2w3yP9AA5VG1WL1UkDOoRpMcJEF
         Jvm2LC2i2b04O19+Das8HEfMxS3nd/cz3XxEXs51PmI4YyFZ1WGR4R2xL/pR5OMO3PTV
         4zWVjKleIuST/60h2h8lStpdCUycgnL+0QG2pElr1Wxy9SccttS0x1aruFb4+Np9r4Hm
         8A/w==
X-Gm-Message-State: AOAM531KdY7BEW8EMuwEZVD18Uj07KGa/j6zA8M7LjQMMQLbUT0tYND8
        VQC5PnEnvHHdnABuz+iQetZJMyNBlt5nUJylSDk/D7ybXp8dK0mKEZhK+a/D1+gx8DKw9xlXsEE
        B/tVaM5Ps8k8if96Heam83dU2bGW4mmWNbgZYB34ZASJrngTkk7h90t56KRlKU8o=
X-Google-Smtp-Source: ABdhPJyHTtN0KCsiNSZakjt4YlqBl+CsuCdatLftJ4JPMXDQCPE4mO+0mogE+QNINuuf2fgc+QXqOLbaFoQl6w==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6214:10e3:: with SMTP id
 q3mr385976qvt.3.1606152738906; Mon, 23 Nov 2020 09:32:18 -0800 (PST)
Date:   Mon, 23 Nov 2020 17:31:56 +0000
In-Reply-To: <20201123173202.1335708-1-jackmanb@google.com>
Message-Id: <20201123173202.1335708-2-jackmanb@google.com>
Mime-Version: 1.0
References: <20201123173202.1335708-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 1/7] bpf: Factor out emission of ModR/M for *(reg + off)
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
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

