Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A4D2C6B1C
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 18:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732863AbgK0R56 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 12:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732858AbgK0R56 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Nov 2020 12:57:58 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70E9C0613D2
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:57:57 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id k128so3462574wme.7
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=H22q+ouf7u9LzglpF3czxswAZ/tYvPaf24TLGDwbSdY=;
        b=q7oY8MHBuEHwS6KdXZOjzfRIdqqQ9Gq5GgEfXpJ3lBShIXyDo2xtCpN5S+0k4mqqJv
         BP9FV9uH44XTe0Pkm5Deh9ldWyDwefxmMlDwSiRqpZknx2J2vHuUpTTJY8xPyfxwKTqf
         1yohpDY3jSIg13YPnnrKMQNwSeap0PQrQoBiVOCEH+byznGShV6BsBJ2zlemsleoKOoC
         EcpHSVCj4+2zuuhnoX9K+8Fsmf9uJVOdYeGslR7uGvnQfNFkdZ5jqW327+1QtxbpgnMI
         PStcypAW1hJ0odoCypA2OdL+yL2M3UwM8ZbgI8T/yH148rMN4gL5I3YbZvxRO8FXIvzA
         KOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H22q+ouf7u9LzglpF3czxswAZ/tYvPaf24TLGDwbSdY=;
        b=OdIkUiMFz0kg2VoUbKNzuGrlhKQuXK1wzZU4QsaVv8+DjARAbRW06iMMMafiFKLtab
         hsStO1LCgjfhBKsv4letJscE++NwpRKj+BrozmJTJOMwIPVeUYlhbLJBG9m2OsENMKvr
         MPaxeNW8tgmgXvYRuAqGA6DMGXV73M7wNuN3FE5vlgy5bjsHQZly6VEXqYNizrPPVmL9
         lDR0dTQXVh6fr1/+vf8+WNj19SSI2l5UUW1bQw6G7r7W4KqzX9UURibfNbzN/bwuwAT+
         cfNr6lJvPFV6hQn2CEJTHF5NnyhCK/I8HLMy6R10Uup20r6dQbBktFWLYId12KznFmDL
         GTTg==
X-Gm-Message-State: AOAM532rjd+kmFk7yrv/gEV/nsihJxjpHyJuVfbp37ITRy0md4HlMxZw
        wqilIBG5l0n734qRsDZJe8kRPZxRb4MljUE+J6GrM3n12gyiguT0pKNGYvtYxOD71rLubI852ae
        Z3et6D74ZPXDahF/UanOEunGJGy0iBGV3Y1x178LKcuhVstZg5uUqo5R2bctF/Vk=
X-Google-Smtp-Source: ABdhPJxqOgiEBu4iK10iq+TzBQOdcgZsckPDRErXaV/RvmgzGe/x7wC+++NAMXvmPHCa9VnPDvQZ0802KxWG3g==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:61c2:: with SMTP id
 v185mr10546867wmb.152.1606499876503; Fri, 27 Nov 2020 09:57:56 -0800 (PST)
Date:   Fri, 27 Nov 2020 17:57:29 +0000
In-Reply-To: <20201127175738.1085417-1-jackmanb@google.com>
Message-Id: <20201127175738.1085417-5-jackmanb@google.com>
Mime-Version: 1.0
References: <20201127175738.1085417-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 bpf-next 04/13] bpf: x86: Factor out a lookup table for
 some ALU opcodes
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

A later commit will need to lookup a subset of these opcodes. To
avoid duplicating code, pull out a table.

The shift opcodes won't be needed by that later commit, but they're
already duplicated, so fold them into the table anyway.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/net/bpf_jit_comp.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 49dea0c1a130..9ecee9d018ac 100644
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
@@ -878,15 +890,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
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
 			maybe_emit_rex(&prog, dst_reg, src_reg,
 				       BPF_CLASS(insn->code) == BPF_ALU64);
+			b2 = simple_alu_opcodes[BPF_OP(insn->code)];
 			EMIT2(b2, add_2reg(0xC0, dst_reg, src_reg));
 			break;
 
@@ -1063,12 +1069,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
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
@@ -1102,11 +1103,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
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
2.29.2.454.gaff20da3a2-goog

