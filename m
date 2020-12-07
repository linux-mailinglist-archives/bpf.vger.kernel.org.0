Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DE12D1596
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 17:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgLGQI4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 11:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgLGQI4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 11:08:56 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9053C0617B0
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 08:08:15 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id m91so461245qva.21
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 08:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=j/coOO3IKOdSaOfJ3wqiBZ3KaCdyY0hEgLU+r80vPUs=;
        b=I36vtmcnTyxFYOmiqiPgxadSYWAsjO+op4FfMTkVic9jl/uEocEHAPIH99J28rHU+H
         J8VyK7M/xxdMnhFpOYhDOCj3bqO276nXazmvWwgRJTZaUokleuShogPNoYRi4I35attT
         y+ZeQqavoOLEBWNZ0hUbDw2vmx+yjygEf537iqsFwfWsvJJ+TJigkvAexKIQ7VWuXlxP
         16L4CAeoCTXv9hiNXOgh7Nyd4JhRoS/MrJPr45MkTs8gE4L530gVs1lVWcNX5+NcMAuv
         CEHMidrbj1J5sXNbcStcb4SYQO3pGMkXkbNJws6pmcK0ycL8nV1k8CMhNqK+vJK23uMa
         oqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j/coOO3IKOdSaOfJ3wqiBZ3KaCdyY0hEgLU+r80vPUs=;
        b=sWo3bFGPEXrOQnwQnR2SPIykMQlH8SY5Ihq0IpvUwwJScYsboRKdjWWGIzfLm8nCsn
         nDQaPZej4gdMbvHx3zfhVB7i5XqXqkAM4yCGiTY1UZHXB5OoTCkm+3tLovEwX/cYyNfv
         MLtzUp89+Y0BnP35G83aWpcqxN2ib0BVXwnUwOV65TwHeKWWdkbHkUribOXdHGfG62X0
         5OXIFxR2l9DIGI+COgg21f2+T20M6y6EdAQ62f+y4nTuhv8Ff1okWgc51gjZBVzKWEZL
         +Qea3s4hfEuHad2HK+s80zzBoJklRv9aCySuXp6v9BSb+0DA96g6EfZNj65gr4jd5xPW
         EKDA==
X-Gm-Message-State: AOAM5316xadbeE3nTtR01+A65UO3Dz8rmSNtXTKMVIRZ2njN1f+AK+Yg
        B09x1pGciWAyR7qaNwYQepFvS+4f7sJdVKAy8jGx74L6f1xOWjHXp13sgJqmpN8IqgY4I0+vejT
        umbF6QjEhdFgRdbINFvMFk+iO5qwe4H00IOq5K2yZT/Acz4GwCnoNK497aKYzv5I=
X-Google-Smtp-Source: ABdhPJzQjoDPtmDlyR8EWmHh3eOfPSgXNrm27/UV/GIsoB4gO7SktrghBFimIdbXyj6QM1d5iGb/Lyxee7H+uA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6214:10c6:: with SMTP id
 r6mr16980502qvs.44.1607357294782; Mon, 07 Dec 2020 08:08:14 -0800 (PST)
Date:   Mon,  7 Dec 2020 16:07:24 +0000
In-Reply-To: <20201207160734.2345502-1-jackmanb@google.com>
Message-Id: <20201207160734.2345502-2-jackmanb@google.com>
Mime-Version: 1.0
References: <20201207160734.2345502-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH bpf-next v4 01/11] bpf: x86: Factor out emission of ModR/M for
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
index 796506dcfc42..cc818ed7c2b9 100644
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
2.29.2.576.ga3fc446d84-goog

