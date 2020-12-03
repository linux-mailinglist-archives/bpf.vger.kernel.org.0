Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057972CDAAD
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 17:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbgLCQEN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 11:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgLCQEM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 11:04:12 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34970C061A55
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 08:03:14 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id 198so2334255qkj.7
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 08:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0ZiV8JtnOj2y1hxnSkofHvyMEv1ZFrFbx4Eyr3aUv3w=;
        b=HVBol0JzcgJH7Ul5vN3bvsiqNzXpZyUkasuPalD/BEGlMr+FHMyaGuzmvPL+skOydT
         25mz/ZMUxaDqB7YNd3tQRDJShKzUFtuX5wck/+0hczVpQZpbvw/CMHABSiRwb5fnn8Ld
         LHhGVPBWZus7QYmdIJwU+irg8dLVkVOUDfY4dyUSUVt9+rr5/Il4+zIsK8ARs8JotmUW
         WLBzgq8n2gghPMODS36wyRukW3Hy/f2SwiartK7KSx+JZS6EE49M/5a4YJxsKXo6adcw
         O7hu1p567RFpkzTUpOBFCP+LdEMqbhSJYGYa+jJ9FcBiHOv52Ro6blztV8vBS/fAoGqE
         fscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0ZiV8JtnOj2y1hxnSkofHvyMEv1ZFrFbx4Eyr3aUv3w=;
        b=qvkPuLvwy1T82Sy7ql2DNZANWxyX1lTIsaV53R6FoKZSqx1XqxrQV3khLmYV4moTFO
         x/2K1Qxdscabo/CM3pJeizED3XFXYqx6k0YTWE5NoKYyjrdlDZGozCpkOKQUxVWkau1F
         RkV3WSutEiS8QRLa0xCy0PQAQB/kAAq0h/0quFAT6DuM8cEF+q6nVjBqwNQww0R4kRfN
         MBFilJxEYJmEpXU79BKgyznNpS70XKO70rKwoWkjd6wd2jg3Pn7+P77Rgr7kc4k3LrcT
         BtMCGhWxycV79gB6H8ShH2niAkgWbcEUt36O4N76sNA9vRGe618CHHb0HSDOSi2hbCRt
         8uXg==
X-Gm-Message-State: AOAM530IfE6N4PRWTK6OTXXQwySl+5SUaOq2fyzLWYdx7uY+9LkKc06g
        yUeTyCqvIGkjx16bOo5sn+ngh0FDfI9cBRQ1rPPxN9Q2ASsk/PYq1AZZMocEAhgEa+mtF335gH1
        SkTbmXvYshI8Vu5Ov33WbvHi0+0XeSyD8tliSmS6Jjz58f074NRTH+nqLks+9ce8=
X-Google-Smtp-Source: ABdhPJxRUx6i6Edd0F0R7SLTISys3hXrC24G0wTerh9gRUgjxXHUXqUma+S1VeBjxrdSXD5cfBfRPb/DJK9uVw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:ad4:5106:: with SMTP id
 g6mr3804556qvp.1.1607011393249; Thu, 03 Dec 2020 08:03:13 -0800 (PST)
Date:   Thu,  3 Dec 2020 16:02:33 +0000
In-Reply-To: <20201203160245.1014867-1-jackmanb@google.com>
Message-Id: <20201203160245.1014867-3-jackmanb@google.com>
Mime-Version: 1.0
References: <20201203160245.1014867-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH bpf-next v3 02/14] bpf: x86: Factor out emission of REX byte
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
Change-Id: I66dbd5ad0bf6f820901fb73d6b2c6a63e00483b1
---
 arch/x86/net/bpf_jit_comp.c | 39 ++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index cc818ed7c2b9..7106cfd10ba6 100644
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
 
@@ -1301,20 +1314,16 @@ xadd:			emit_modrm_dstoff(&prog, dst_reg, src_reg, insn->off);
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
 
@@ -1350,10 +1359,8 @@ xadd:			emit_modrm_dstoff(&prog, dst_reg, src_reg, insn->off);
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
2.29.2.454.gaff20da3a2-goog

