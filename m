Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07FE2F6948
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 19:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbhANSTC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 13:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbhANSTC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 13:19:02 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF365C0613ED
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 10:18:11 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id l5so993210wmi.4
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 10:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=e3m9lxWPd1akNGwOE664d3Ddb1cr1DVVkpzRKRihJEs=;
        b=rQpGB9V5yhSwWzU9RMRGRVgJVUD8nzV+R0RQDYOJfkw96d682qtbR437Mm6LcVInL0
         JHW658/7wEazraKZtMIFod2sX6J35N0ANaH4mPi2xQjgrlckAkxl93tLsWnYvBzUcuCj
         3NTjqqUDuhue/7iAqdcEUR9PEjeeRYym1binmkMBBQwc97WeKDbphuX1NMmOYNzx/dQC
         AAxa/HWXPm2FOjpFXBQbWGfsaaxav7tLeg37ruH+KT5UK0JFuNSll3fmXhFMjXKzAWvL
         eJ7tSci7X8grqu7ejSayVQ6QqDRADGVdJyxEtFEn/idgGPOsOn++jDlsyUgK/4e5yhW4
         X8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e3m9lxWPd1akNGwOE664d3Ddb1cr1DVVkpzRKRihJEs=;
        b=oPxdXcK+Ysrk/7qQgnbvzf32oHqiMfNWibinX9h4fh2ngkUobeoRnVlLUPlcs8odJF
         njPwt99gO5+UH+QAWLhF5Qu/g0X1+1ZIOAlKaSnNN/7NNdyWp4n0GADnaKHFaWMFuUBV
         /GYAomE4vBUGABIZY5ftqmwFVSeoJQNGbitOYV9ke4lAHIxWbZgzt5wS3BEnMW5OC/DG
         0Lgo5tkiiMAQV5oM5wZubeb0+7JWTRnSyCfiFF508ikgeL7f+kzIr/GbnnvDib2wUZar
         264fYo92wSvSOi671XNdJ6+zAYkX7Df9ZfhYwPLd0BSu9g9coPBjRH9GgJSsaZOO12xu
         IAcg==
X-Gm-Message-State: AOAM532YGp/ThNLhDkhXTEnvKuzo5DgH//RTpN3C0z6e0UL3Ewd0hV5D
        sfyBJX5+OXoTrt1sGhxLFveQ63QceQZQhe+aijeybUEumGBYGkFCbXW+UaYnYOzDqPU8YmmDEKg
        5Uuz7HrmlNY8NsnMSVfpk639dxtVsjwR7PWHaZzR+Sm6aPJCql7jQER0iLJv8zr0=
X-Google-Smtp-Source: ABdhPJx0ImXsxQbwK/xVFh0DFFJJEG/tckNQEyIDiVEm73x7+tmZ3WbSZ++fYdeDBWKCMof5smtvV8JPyMNY6g==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a7b:c841:: with SMTP id
 c1mr2904838wml.48.1610648290566; Thu, 14 Jan 2021 10:18:10 -0800 (PST)
Date:   Thu, 14 Jan 2021 18:17:42 +0000
In-Reply-To: <20210114181751.768687-1-jackmanb@google.com>
Message-Id: <20210114181751.768687-3-jackmanb@google.com>
Mime-Version: 1.0
References: <20210114181751.768687-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v7 02/11] bpf: x86: Factor out emission of REX byte
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

The JIT case for encoding atomic ops is about to get more
complicated. In order to make the review & resulting code easier,
let's factor out some shared helpers.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 39 ++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 30526776fa78..f15c93275a18 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -702,6 +702,21 @@ static void emit_insn_suffix(u8 **pprog, u32 ptr_reg, u32 val_reg, int off)
 	*pprog = prog;
 }
 
+/*
+ * Emit a REX byte if it will be necessary to address these registers
+ */
+static void maybe_emit_mod(u8 **pprog, u32 dst_reg, u32 src_reg, bool is64)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+	if (is64)
+		EMIT1(add_2mod(0x48, dst_reg, src_reg));
+	else if (is_ereg(dst_reg) || is_ereg(src_reg))
+		EMIT1(add_2mod(0x40, dst_reg, src_reg));
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
+			maybe_emit_mod(&prog, dst_reg, src_reg,
+				       BPF_CLASS(insn->code) == BPF_ALU64);
 			EMIT2(b2, add_2reg(0xC0, dst_reg, src_reg));
 			break;
 
@@ -1302,20 +1315,16 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP32 | BPF_JSGE | BPF_X:
 		case BPF_JMP32 | BPF_JSLE | BPF_X:
 			/* cmp dst_reg, src_reg */
-			if (BPF_CLASS(insn->code) == BPF_JMP)
-				EMIT1(add_2mod(0x48, dst_reg, src_reg));
-			else if (is_ereg(dst_reg) || is_ereg(src_reg))
-				EMIT1(add_2mod(0x40, dst_reg, src_reg));
+			maybe_emit_mod(&prog, dst_reg, src_reg,
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
+			maybe_emit_mod(&prog, dst_reg, src_reg,
+				       BPF_CLASS(insn->code) == BPF_JMP);
 			EMIT2(0x85, add_2reg(0xC0, dst_reg, src_reg));
 			goto emit_cond_jmp;
 
@@ -1351,10 +1360,8 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP32 | BPF_JSLE | BPF_K:
 			/* test dst_reg, dst_reg to save one extra byte */
 			if (imm32 == 0) {
-				if (BPF_CLASS(insn->code) == BPF_JMP)
-					EMIT1(add_2mod(0x48, dst_reg, dst_reg));
-				else if (is_ereg(dst_reg))
-					EMIT1(add_2mod(0x40, dst_reg, dst_reg));
+				maybe_emit_mod(&prog, dst_reg, dst_reg,
+					       BPF_CLASS(insn->code) == BPF_JMP);
 				EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
 				goto emit_cond_jmp;
 			}
-- 
2.30.0.284.gd98b1dd5eaa7-goog

