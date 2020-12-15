Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919302DAD0D
	for <lists+bpf@lfdr.de>; Tue, 15 Dec 2020 13:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgLOMWZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Dec 2020 07:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbgLOMUE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Dec 2020 07:20:04 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7DBC0619D4
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 04:18:43 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id a205so4548988wme.9
        for <bpf@vger.kernel.org>; Tue, 15 Dec 2020 04:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=GfOHg26UfN7htR+y5ZGUHFu1Y2LwTx5ym50n7DLpgdc=;
        b=LkEd+cbXxHgsj2GfpBjcoW7u5Z5fe8BDFz2UK4YL4Xn1U8VzWplUBXUzYoirUHs8IY
         N6tiBP3aqtPwNIAG/7ZydfCZzOARstKw9zPAa8n/U2nzy5U7SdkU+KrvlgyuDVRabrAs
         tdDAt9i7A1IFDnkji+myd/R4P1E4pegZQdeaGcmV2ODqjrvLfauroIjcGR2+GlKW0Tfi
         D8NDyk5b62oqAjlaREv1odqT9YQNYsv/1jxAOp9RHCfttn0Y/RM/pHTbUqsi2U2jVVKa
         4KIN9Ns15ep7YeeDBrD4XmDXl0FU9QNVcESdhXO41dLxTYhTSCRpXfN/XEkeZFqSDlrD
         +cUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GfOHg26UfN7htR+y5ZGUHFu1Y2LwTx5ym50n7DLpgdc=;
        b=LhCwIqXlxfi1Wtyjtr2CM6xJPZH/3QQXGEsAvJleyIk+UQ+3bzZZUgJvMTv3bM++uT
         VbfAHLtVxROU7bvsZhjluU3Ffa6siL9SlydQ7OD5WBHzcRJ13WZwRo+CVZoUOsOTVx2E
         TQ9QfKKTJKhjz9Q6cS8wr9NN+7HjeuqmBI6lmjS/KFJ3jzu/S0xzyx3zgJz1EYv/RPKo
         0AD3Q8odZ/720N8lVlXGuvXsJLtFoAsQ265w1eBXtD/t6FSwyi6OaPSbuyW7LkX9Hr/g
         YedG6ozscXEUSRB3x2gD7TTplEGgnB8eTDmlc52gAMPqzz4XF1IoDyD5wKnyskcjfn3D
         unjw==
X-Gm-Message-State: AOAM533gvMOiRwYEjhrbeGVJ/UZn63MVbMcOKU+6XdP7EgV+Z9dKCxJm
        F8gIPbuw/L8whbaOSXfzFQ90h4UMc1TKJ79O86Ao3U6DUCEtpI3Zsu3ZnGFJE+Q3V5o3ChsJ4sL
        2d6ub5VBlYtPX8s/RCo8OjsoB/Eh+9QjKqCJqSIFsNiE/mdHBqz3XjdWgVFIS7Sc=
X-Google-Smtp-Source: ABdhPJyRoHZ0OL5TjHJzmQeCqg1MDbUJDCmeJ+0M4rRv0WPtOWX7ykSWBmm5H6vtnNDAwzZh6PdlBt2P1izLmw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:600c:2246:: with SMTP id
 a6mr32653097wmm.80.1608034722508; Tue, 15 Dec 2020 04:18:42 -0800 (PST)
Date:   Tue, 15 Dec 2020 12:18:13 +0000
In-Reply-To: <20201215121816.1048557-1-jackmanb@google.com>
Message-Id: <20201215121816.1048557-10-jackmanb@google.com>
Mime-Version: 1.0
References: <20201215121816.1048557-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH bpf-next v5 08/11] bpf: Pull out a macro for interpreting
 atomic ALU operations
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Yonghong Song <yhs@fb.com>
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
index 4f22cff4491e..7b52affc5bd8 100644
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
+					(atomic64_t *)(unsigned long) (DST + insn->off)); \
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
-				(atomic64_t *)(unsigned long) (DST + insn->off));
-			break;
+		ATOMIC_ALU_OP(BPF_ADD, add)
+#undef ATOMIC_ALU_OP
+
 		case BPF_XCHG:
-			SRC = (u64) atomic64_xchg(
-				(atomic64_t *)(unsigned long) (DST + insn->off),
-				(u64) SRC);
+			if (BPF_SIZE(insn->code) == BPF_W)
+				SRC = (u32) atomic_xchg(
+					(atomic_t *)(unsigned long) (DST + insn->off),
+					(u32) SRC);
+			else
+				SRC = (u64) atomic64_xchg(
+					(atomic64_t *)(unsigned long) (DST + insn->off),
+					(u64) SRC);
 			break;
 		case BPF_CMPXCHG:
-			BPF_R0 = (u64) atomic64_cmpxchg(
-				(atomic64_t *)(unsigned long) (DST + insn->off),
-				(u64) BPF_R0, (u64) SRC);
+			if (BPF_SIZE(insn->code) == BPF_W)
+				BPF_R0 = (u32) atomic_cmpxchg(
+					(atomic_t *)(unsigned long) (DST + insn->off),
+					(u32) BPF_R0, (u32) SRC);
+			else
+				BPF_R0 = (u64) atomic64_cmpxchg(
+					(atomic64_t *)(unsigned long) (DST + insn->off),
+					(u64) BPF_R0, (u64) SRC);
 			break;
+
 		default:
 			goto default_label;
 		}
-- 
2.29.2.684.gfbc64c5ab5-goog

