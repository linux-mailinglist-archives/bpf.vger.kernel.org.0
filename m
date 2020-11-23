Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE76A2C11FF
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 18:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732193AbgKWRcW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 12:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730667AbgKWRcW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Nov 2020 12:32:22 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8F9C0613CF
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 09:32:21 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id z129so2538615qkb.13
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 09:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=S3LKp+3RvK8OZkmGe150smJLkvcUKra31qzmBdRpcwc=;
        b=KmaQiwWpXRuF/UZAZzDRoJgxZfaG1+6duIsUQWCdYRGcqdxqdIgTWPAp1FaQE7zFWP
         c5Lc/6/rBwcuQb26eeKik6O11jJEOE12+HKMTsAWa73R0rXQ24Y9rPpq3mMBwZxgk5hs
         g+vOjehJkQHe7Jqc/LvFdonRuOkk+1AD9cASSIcWArn+Vs8bKKg05WtHDT0Wf3GIxDe/
         yXsw4+/omX4Wj7Cn/w5YcLNMd5aq3SsXr58YXzlQmjvsHbGlMB8uixETh+zBsRPk09Me
         bZgw7yR/qSC3YlmOC5Znt2t/bAH6gy2fORJ9Sh/ZwPLeU6RBTbE0nrMsHNnT5nAd8OH3
         G9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S3LKp+3RvK8OZkmGe150smJLkvcUKra31qzmBdRpcwc=;
        b=dnCk7aQOdXVVdd2hE19VvW+M/wMyBjrCeJ+hk3+9QlbQSsYOrkkTA0BngL/I67L5gA
         vUzyucvYHmazGOAq140SYWnTfaHTHlvuW/mLatbS8t8AzIlTS+why9Lwrx/sQb7I/9yK
         Iab3TTwDGLjuI4IdPlwy57D1FVXqyiatRxNWNTwmhslvsNQITj+AUerStwNzgYmtCOtz
         cXo5e9BMewHVghFcqH+6FIWqVjxfCCR8VJfmrlZKS6+/9XQg2I9sJbfUKusc7NUp3DtO
         Nw9ZUIc+99egGVEEkp+2ZyY8JGW1fcRMfizjY51ahiz8iuupW77qhkDFhZ+c8h+Rcj25
         iJEA==
X-Gm-Message-State: AOAM530YHRpfJYx9tkcGlcja+Qln3Bm9H/SG+b/HUrIgJhDzOTk33mQN
        T9C0vuE8/KorH+VsMT2SDxOlvLOqQXEnNZUappcW/HHkQgqLoLggc27b+6gZDSKmRIVMan+zqNb
        iV8bsJLuF7Zl9A7O9rdFGRpTmYYr+kk2HDQ70QdB8+sHWjJ4vfPgRoT/DDWv/ZAs=
X-Google-Smtp-Source: ABdhPJwmqoLq0Qk/TBRCaaMqIXFMyah7qWd3d1a3eXBMI6puLVsRKMVSF7qjkKHNHtq6EuDZh+IcyrsD8SbYRQ==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a0c:b65b:: with SMTP id
 q27mr462967qvf.8.1606152741044; Mon, 23 Nov 2020 09:32:21 -0800 (PST)
Date:   Mon, 23 Nov 2020 17:31:57 +0000
In-Reply-To: <20201123173202.1335708-1-jackmanb@google.com>
Message-Id: <20201123173202.1335708-3-jackmanb@google.com>
Mime-Version: 1.0
References: <20201123173202.1335708-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 2/7] bpf: x86: Factor out emission of REX byte
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

The JIT case for encoding atomic ops is about to get more
complicated. In order to make the review & resulting code easier,
let's factor out some shared helpers.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/net/bpf_jit_comp.c | 39 ++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 94b17bd30e00..a839c1a54276 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -702,6 +702,21 @@ static void emit_modrm_dstoff(u8 **pprog, u32 r1, u32 r2, int off)
 	*pprog = prog;
 }
 
+/*
+ * Emit a REX byte if it will be necessary to address these registers
+ */
+static void maybe_emit_rex(u8 **pprog, u32 reg_rm, u32 reg_reg, bool wide)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+	if (wide)
+		EMIT1(add_2mod(0x48, reg_rm, reg_reg));
+	else if (is_ereg(reg_rm) || is_ereg(reg_reg))
+		EMIT1(add_2mod(0x40, reg_rm, reg_reg));
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
+			maybe_emit_rex(&prog, dst_reg, src_reg,
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
+			maybe_emit_rex(&prog, dst_reg, src_reg,
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
+			maybe_emit_rex(&prog, dst_reg, src_reg,
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
+				maybe_emit_rex(&prog, dst_reg, dst_reg,
+					       BPF_CLASS(insn->code) == BPF_JMP);
 				EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
 				goto emit_cond_jmp;
 			}
-- 
2.29.2.454.gaff20da3a2-goog

