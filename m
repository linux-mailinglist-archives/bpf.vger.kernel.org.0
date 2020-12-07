Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D55E2D15CE
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 17:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgLGQQ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 11:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgLGQQ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 11:16:27 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4319C061749
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 08:15:46 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id r11so3079616wrs.23
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 08:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zKhPLuQByBWIZw1uYTkwBeWZCWJCpLKTPppsP1+IhXE=;
        b=ZTpFsZawTsqrTEhsVv6t+Xqhsz76zbNDKpourLTywyfZrA+bWEhWDAl0911tNvZZHw
         l6/Arau5+HTyRJG+IqDJDhx3gqNqcQRffwrp2glc4TbVOr8lk2/uOA9FyfY81rb3mSbP
         UQr0wmYQM95kB34h4NaJhaLyioUCzmL9a5e2Zeso0x/pObQB+eQbGMluMY/Kw5lOR9wg
         pIewJKsuDxu4r5HpPWeLGpeH/8UCUH6Lws1tawzxZipSyvITa+0iCrHPVNBHbFx4zFtm
         dOPc4NAoBZVuiXe/2azfkr0hHkgl4h3Vxnp4MvSjNRv2xzpszRmlLnwuiyGxzn7RFVWA
         qomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zKhPLuQByBWIZw1uYTkwBeWZCWJCpLKTPppsP1+IhXE=;
        b=RRkkRqBWjSsj1LY4jY9aQK7gxvhopv2VpvQR6Qi0sZ5iOT38D8PWFZ3iPcCS5v9uiA
         h55C399HNEoPzqHGo3G9Q5O/2HLqrT3K7sQsXL7A7lS1fqQhej+AuYNn2Z0MSaWlIAyu
         OS2Y4icFvMtI6R5m9ZA+cM3XwO0VE7o2xu+ni0TgZseeSskBArXVB/FKwG9Ch9b7VxTW
         6uK93w0VtCv6V30tQMmpcau9mWjVsK43C0ZsYOYN35xCHpFWBOf/WgRUH3x1NRMUxQOk
         hCjruDwuU++BT8ARHGRdT3rix3/hkfwNRDZ1dT4Pnomem0eBGQdqsgejarzSAY06YB4L
         Fr1g==
X-Gm-Message-State: AOAM532rSSjgOIgYuDs28WoDOewhHTGY5lXEX86w6pV/lgzuPaQlgZ2u
        8Y9pR/V3Bhuos+8h0DlLprY9F/fKpsSZ/Z2n7KEYEiSgRDT7vOCIObqDeklvMSRmOu5BNPAhSCk
        ZS7DHi1vmr6emRkTmzUZJQVQxnD72gR8+/UtxoYOP1IPTEuemOrFjioTgsyz0cVU=
X-Google-Smtp-Source: ABdhPJzPFZTgMmWGu1YCSsxY0YVICXeUcTVncl9Zvb2JOefQlybNeEyykZOozKpIuJZkK+Oa8rGufwMtCB8FBQ==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:e084:: with SMTP id
 x126mr19124582wmg.109.1607357309765; Mon, 07 Dec 2020 08:08:29 -0800 (PST)
Date:   Mon,  7 Dec 2020 16:07:31 +0000
In-Reply-To: <20201207160734.2345502-1-jackmanb@google.com>
Message-Id: <20201207160734.2345502-9-jackmanb@google.com>
Mime-Version: 1.0
References: <20201207160734.2345502-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH bpf-next v4 08/11] bpf: Pull out a macro for interpreting
 atomic ALU operations
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

Since the atomic operations that are added in subsequent commits are
all isomorphic with BPF_ADD, pull out a macro to avoid the
interpreter becoming dominated by lines of atomic-related code.

Note that this sacrificies interpreter performance (combining
STX_ATOMIC_W and STX_ATOMIC_DW into single switch case means that we
need an extra conditional branch to differentiate them) in favour of
compact and (relatively!) simple C code.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 kernel/bpf/core.c | 80 +++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 41 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 28f960bc2e30..1d9e5dcde03a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1618,55 +1618,53 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 	LDX_PROBE(DW, 8)
 #undef LDX_PROBE
 
-	STX_ATOMIC_W:
-		switch (IMM) {
-		case BPF_ADD:
-			/* lock xadd *(u32 *)(dst_reg + off16) += src_reg */
-			atomic_add((u32) SRC, (atomic_t *)(unsigned long)
-				   (DST + insn->off));
-			break;
-		case BPF_ADD | BPF_FETCH:
-			SRC = (u32) atomic_fetch_add(
-				(u32) SRC,
-				(atomic_t *)(unsigned long) (DST + insn->off));
-			break;
-		case BPF_XCHG:
-			SRC = (u32) atomic_xchg(
-				(atomic_t *)(unsigned long) (DST + insn->off),
-				(u32) SRC);
-			break;
-		case BPF_CMPXCHG:
-			BPF_R0 = (u32) atomic_cmpxchg(
-				(atomic_t *)(unsigned long) (DST + insn->off),
-				(u32) BPF_R0, (u32) SRC);
+#define ATOMIC_ALU_OP(BOP, KOP)						\
+		case BOP:						\
+			if (BPF_SIZE(insn->code) == BPF_W)		\
+				atomic_##KOP((u32) SRC, (atomic_t *)(unsigned long) \
+					     (DST + insn->off));	\
+			else						\
+				atomic64_##KOP((u64) SRC, (atomic64_t *)(unsigned long) \
+					       (DST + insn->off));	\
+			break;						\
+		case BOP | BPF_FETCH:					\
+			if (BPF_SIZE(insn->code) == BPF_W)		\
+				SRC = (u32) atomic_fetch_##KOP(		\
+					(u32) SRC,			\
+					(atomic_t *)(unsigned long) (DST + insn->off)); \
+			else						\
+				SRC = (u64) atomic64_fetch_##KOP(	\
+					(u64) SRC,			\
+					(atomic64_t *)(s64) (DST + insn->off)); \
 			break;
-		default:
-			goto default_label;
-		}
-		CONT;
 
 	STX_ATOMIC_DW:
+	STX_ATOMIC_W:
 		switch (IMM) {
-		case BPF_ADD:
-			/* lock xadd *(u64 *)(dst_reg + off16) += src_reg */
-			atomic64_add((u64) SRC, (atomic64_t *)(unsigned long)
-				     (DST + insn->off));
-			break;
-		case BPF_ADD | BPF_FETCH:
-			SRC = (u64) atomic64_fetch_add(
-				(u64) SRC,
-				(atomic64_t *)(s64) (DST + insn->off));
-			break;
+		ATOMIC_ALU_OP(BPF_ADD, add)
+#undef ATOMIC_ALU_OP
+
 		case BPF_XCHG:
-			SRC = (u64) atomic64_xchg(
-				(atomic64_t *)(u64) (DST + insn->off),
-				(u64) SRC);
+			if (BPF_SIZE(insn->code) == BPF_W)
+				SRC = (u32) atomic_xchg(
+					(atomic_t *)(unsigned long) (DST + insn->off),
+					(u32) SRC);
+			else
+				SRC = (u64) atomic64_xchg(
+					(atomic64_t *)(u64) (DST + insn->off),
+					(u64) SRC);
 			break;
 		case BPF_CMPXCHG:
-			BPF_R0 = (u64) atomic64_cmpxchg(
-				(atomic64_t *)(u64) (DST + insn->off),
-				(u64) BPF_R0, (u64) SRC);
+			if (BPF_SIZE(insn->code) == BPF_W)
+				BPF_R0 = (u32) atomic_cmpxchg(
+					(atomic_t *)(unsigned long) (DST + insn->off),
+					(u32) BPF_R0, (u32) SRC);
+			else
+				BPF_R0 = (u64) atomic64_cmpxchg(
+					(atomic64_t *)(u64) (DST + insn->off),
+					(u64) BPF_R0, (u64) SRC);
 			break;
+
 		default:
 			goto default_label;
 		}
-- 
2.29.2.576.ga3fc446d84-goog

