Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E979D2F6952
	for <lists+bpf@lfdr.de>; Thu, 14 Jan 2021 19:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbhANSTn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 13:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729673AbhANSTm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 13:19:42 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0BEC06179E
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 10:18:25 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id g17so2954568wrr.11
        for <bpf@vger.kernel.org>; Thu, 14 Jan 2021 10:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=GnGYLZQpXXpyrj8V8AXVE35GZ42ZV37BIth5wG6TAKc=;
        b=oEFvraAACDuc/sC3rYp4Qpya1srkmm9MPd3Jw/1QVatQwpM6kmtAqVDzDkZPsp9NbI
         zKE4eBInIo41m/6VCI8A9q2QKj19A9+oh5WWhi24SbKfgG9xO/1rtnjIQR8evUz82HGO
         LxjGYy/adXmfmehKX9CUBKKhn57pftDgB2OF03qSFHL06KkAyhEmw1mbXnz53sAT4kBv
         RG+4Nf5IMggCwBkZaUgrfN8FDEKNFU080Wo9sBPQxLyFuh2O9czBfdvkOH+bFaMvQvmn
         /TROFTg4oo1piDjHQwjkFpcEmNSQftLSskmd7nKRZV3VNR8NKKBMWMFb4ZOIEiGtGUJd
         YkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GnGYLZQpXXpyrj8V8AXVE35GZ42ZV37BIth5wG6TAKc=;
        b=i1ae4eq7dTiv8WOWZZF+Xp5uq0zD9G0XOO/wUXQne6o1yXqjieKFSDcfOkqzDfI+Lp
         HzYo0c4VBsmh1pJla13Mqj+nvcfCyG8+N+Ka7jSxWSi6+N0lSCKLcnesYH64TRWvJ7SD
         3rSc25p0uWAIRQ2l8oPISleUtzflA6LJUmoSF1lMtyKoYYJl2B3SWStcQ79yHC8UT5+6
         6U6yDwKY23148MxrykjM+KfZPoD6W+rgQiPdVfMTYdUv01BnvkFjfOFk6v8iKnQTOxvC
         NsNFj6oCCIgJQ61JluFWBYpOABo5WDxnVlvrsXvHx6zDzLQ87GQAWzBwG58YptJUGu1e
         3Ijw==
X-Gm-Message-State: AOAM532OhTpezxKnBYmK5zxgZGzhMb2V/U7e3Rsn0X0nq16jMGc01Ert
        MYvkrOtuo1U9Mjkxs6gwYJ4CvYmR0h724IoyTKQpzqxt4GI851vCZR96tkvcnGiqBDXMHuHFWJr
        cA7ucTFynDNsi+TTNw6R9iGVqA8gkHkIysCoeAn9H7QWSbqjZokqlmAkEmTFUNro=
X-Google-Smtp-Source: ABdhPJxqVj/QSoJLjdEgCfWVad9Ku075T8z89lrvlTHoNoZcrsPrKr+wc+tdqTKloVBcyUPiO7+SPtFGYHG1bg==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:2c89:: with SMTP id
 s131mr557023wms.0.1610648303757; Thu, 14 Jan 2021 10:18:23 -0800 (PST)
Date:   Thu, 14 Jan 2021 18:17:48 +0000
In-Reply-To: <20210114181751.768687-1-jackmanb@google.com>
Message-Id: <20210114181751.768687-9-jackmanb@google.com>
Mime-Version: 1.0
References: <20210114181751.768687-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v7 08/11] bpf: Pull out a macro for interpreting
 atomic ALU operations
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
index 4df6daba43ef..8669e685825f 100644
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
2.30.0.284.gd98b1dd5eaa7-goog

