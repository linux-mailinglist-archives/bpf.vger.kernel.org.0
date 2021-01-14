Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7811C2F6944
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 19:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbhANSSu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 13:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbhANSSt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 13:18:49 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5413FC0613D3
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 10:18:09 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id f7so5266148qvr.4
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 10:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4StJvEPcqpOoMaFQqXp2l4E4gqPLXrwP2qT6WBxKOzM=;
        b=GobCPeYowh3r/lLNPJLitXo++prm+HDGITq517VlpQwWxv+IKVbVnnse0Jw9P4pWKj
         uTaVx7oEQ/QvfRvlJD8a4w1UJD6rqIFwCsglox0IyRzeh7p6ou2NhSNr6eLh8JIdOu/H
         i+6ehi/Mlf6qSdLWZNtpNBy7Tq8uhLUa5n5cfRf4KK/YncdZzTDpg7f1pWwBqJlh4XZE
         wK3l3NTW/Aq0GZTw3cF5i4RIzjJyrzbOhJyi2QVmySeBwpicPt1+XQujMxTFvaF5YNGs
         E0alYo1fhFIeiKC8rKgPPGmsxvZYh3OteW+N3JE29e1XPOnmtXHICScigIQgJXXHo63K
         e1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4StJvEPcqpOoMaFQqXp2l4E4gqPLXrwP2qT6WBxKOzM=;
        b=lpUKsknMpzdXDHUcyDjGxUFY3Ustdj4gTmOsr9bWj0n6wKiTymcsVkrRzvKHfIARy+
         hRD+tW5VYKFBuO/TmQu1yLEwzJb2oHHdPDeKgwj+lnOoDiYp0VtdgKa7pfLfD4XaHmax
         YnJkolonaq1pm0xZIn/TPyU/yvGwAAjrDRDd/6voIBzbTJ5HUJt7q7b1w01OCKd8EABD
         KK6CPs9oF2vb0/zpB4/BGyA77puTwGzZR3exC3NvkWm1BpIUqEfm95j7Lr657jU3oxzk
         8Jvg7vtmBvjKAFKQkyTsuos+86wxkPqXzZeEHhT0+KBXq4pho2P2yCxFjYrA6dwEyZfh
         kXvg==
X-Gm-Message-State: AOAM531oHQ3qxSkvUgQ0il3AMuNTLqOdt3t6zad5bmbwZ3evtfByFzFw
        jGgDKL6drT1BHYcXsD8xamALzNbeDq9J+En0XzxAZLUfGyITLPrGWkwF+s1+UbTdcziPhs+0Kzl
        B4HF/oxDM3OncNlF3i0XCvdYMGYYfwDeI4Ot3882EwRzzSEePIw2MM/U7GHcUjPM=
X-Google-Smtp-Source: ABdhPJygvCFqDDlF4ox29jIpa6X40Y6F/9plae/kqJpo7jaYHxrswA8ZOl2XU+Gf4hWMwhNTnYQ+RbO2hzxzKA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6214:727:: with SMTP id
 c7mr8439214qvz.22.1610648288369; Thu, 14 Jan 2021 10:18:08 -0800 (PST)
Date:   Thu, 14 Jan 2021 18:17:41 +0000
In-Reply-To: <20210114181751.768687-1-jackmanb@google.com>
Message-Id: <20210114181751.768687-2-jackmanb@google.com>
Mime-Version: 1.0
References: <20210114181751.768687-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v7 01/11] bpf: x86: Factor out emission of ModR/M for
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

