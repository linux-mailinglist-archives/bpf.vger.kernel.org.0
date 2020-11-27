Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768822C6B25
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 18:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732966AbgK0R6K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 12:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732965AbgK0R6K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Nov 2020 12:58:10 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D75C0613D2
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:58:08 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id p16so3781569wrx.4
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 09:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=l/XmS3F8heDnnCjC/QfV3ASRMXtsU72vcNxRpP0pgcs=;
        b=ODBuhzIhRy9z+TV6wyH1yjSarGBb4XmnN5EPraWYd1vPji65yN00rSZc4BOORsN10F
         KUeBOIxRFoEbm8drjKMMs5bkgePqf3zFtQv0HrzoEvdjVaJ+PRbyrBBzUndMp3jqgRzf
         zIy1HHpUp3V7nyA/AEHmMjl8CN2le2PY8sbBAGa0fG0FOCSjsluVQbFQ9v0xBJ/96eyn
         qag9Th0QAqHNfKM2mQYxNCpc5Kffi9lTsde/4HpofgU9ifatDDSECJrZ8Qcg5u2jJnWW
         DAOCt0MQ+Kbm4Jty+GHSBLfYNxgGV0ljuF31KDPbped5l0U5plfpzcayOhUo1dq0oS4C
         fwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l/XmS3F8heDnnCjC/QfV3ASRMXtsU72vcNxRpP0pgcs=;
        b=J146vua/I8mKnEOQoqi7PshVZ/xEzHVtGS/AWvNlUNlYSgSzvYCErq3DA2RpNTE/HC
         lUGlgdF+kVMGWvb+sueRwkkTQblyf3YvCMDGl0dYOUQNLWKt2K+s3pc85Iad7Fmx8kpc
         wWGdCbsXUs+dhPIylQUWgUeRDQQtg/jpAoZQwcIbJgjLMcG4ILErex1JUd1dcZTEPxAY
         q3rSyWnbXTvHUb1Fxh/vZq1+gL2/iuJXMWVorpCTwCxw1aYgvBHDmGV5BovpRgqBXYWb
         f2rI+8/2Pe9mn1MB1xnQTP2lHxQRAJRczVAa9ZH2YkGVHHAG2S/V1zy8b/2hYpukY6Nl
         IPSg==
X-Gm-Message-State: AOAM530zecVjuAAIA0WPRwiWQSXX1G/PLgoXP8I/pI7n6AnxLKAwWKLL
        tQS5k+pyzxqHAyNO9LpT7Y3rGB9CdgO2HTdhwPxNihw/RlJMMCuiegZrRiwaHUWF2lxyTar3r7O
        VBqPliaxmTyIe3MaU74l61fgWFD6BR3REPFvmInVava5e8/ETc1H2teYN9otST0c=
X-Google-Smtp-Source: ABdhPJxrqimB5kfC4aGvATRJWvBfKmL+97XEjnMgu/Khl1atRW6kZO7Yyo7TGLngWUlU2fos3PI8GDhHlYsr/A==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:adf:e787:: with SMTP id
 n7mr12379892wrm.153.1606499887359; Fri, 27 Nov 2020 09:58:07 -0800 (PST)
Date:   Fri, 27 Nov 2020 17:57:34 +0000
In-Reply-To: <20201127175738.1085417-1-jackmanb@google.com>
Message-Id: <20201127175738.1085417-10-jackmanb@google.com>
Mime-Version: 1.0
References: <20201127175738.1085417-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 bpf-next 09/13] bpf: Pull out a macro for interpreting
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

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 kernel/bpf/core.c | 79 +++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 05350a8f87c0..20a5351d1dc2 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1626,55 +1626,52 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
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
+#define ATOMIC(BOP, KOP)						\
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
+		ATOMIC(BPF_ADD, add)
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
2.29.2.454.gaff20da3a2-goog

