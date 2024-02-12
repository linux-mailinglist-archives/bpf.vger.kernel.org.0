Return-Path: <bpf+bounces-21738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765B085172D
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 15:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79B84B2378F
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 14:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096B23B782;
	Mon, 12 Feb 2024 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVbwhbHa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C6D3B296
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748735; cv=none; b=Q/gUZkSebl2VgOS+rA7MEXsUQxSeThdBRcogsCSDN6CG5/0zy8sMLUs7UaWG/vED1pUdyYlA6SXScHavhVR0kXKIwYr/Xd89XIoWhfaKf4enbnWCNDl5PYwpEWNWmulFGFCJHSfIGd/Ao1BepuFstbrXNcxlRQ+30QN1tyI0WCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748735; c=relaxed/simple;
	bh=ZZGZ8jg42ZNxJPS33J4vIOEC18dNvJreMcUt/b38mzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JChyro27ue2tjX7vO1tpytSZbIsCIb8EMS4ysLw0jpejgcAkq/UQ7C/Bx3qG1Dkpt0jV+DLNrtU3vJ6+aGu+TuNFk1kOUvzxg4WDqGgenRFb+Bmc2/YtXBVb1ce2XZgGeM3H6GrWUM/9ZyNotYe/uDwRhKoVCPKoC7jYNS/VWQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVbwhbHa; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2a17f3217aso423294266b.2
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 06:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707748732; x=1708353532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbZZJtHttgWYhCWR6rqzHSFm1UqLGzy74tIhV2kB3GA=;
        b=iVbwhbHaq3ZQHxXsaVwHqib3Kh2trmThARfyDf16j4YF7ZqSIrtMtNoy9lb391v9Wk
         no+CL+yFcGGx61vwZOr3etk1MGQWVia+OR9VImjxMP+iEpe2R+1IpWqAQRe4kfub+st1
         6DvHTmgRFoJiS450aBwzlff4HNwM92OHy1nbf8GBpjm8nGRThjad8Q9GEDnzCcqO9H/n
         wE2TGzDdjE1RjdRNPg5apY294KQM+2RoYdUJFH4HmQLCRD2wuq39BJdQjVHYDVGSzcyQ
         lGCgRpmSk22FWxzvdTWTEQ+oNAubIvD4sUHIG4TxH96Msg2M/8Y2gT7P4i1YO5pvY9Ea
         STBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707748732; x=1708353532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbZZJtHttgWYhCWR6rqzHSFm1UqLGzy74tIhV2kB3GA=;
        b=bP6TBYtR2Pl6la43OmHXc6zFaz+9vctxpxV/8jn58Aol/zwNG1jhnGclxYvrq1x9q3
         gzYuF+qlP4cy6hsWziUfNezodCNdegOFlVPDUnVQQEwoq8lRVi0eGq/EgC7aFbvHbZl/
         ahKodp/NTXSuWIzWGlRQai60OizIUAa9RsVqsuUATjSzcMb+5MT9c8++nDfMVkuJb/lI
         CcEFMAvxgZ/a6WydaICUkstYYQQ4ElxY2Z4rBSONoWkwfMJxMAkszReKwfgxvnEbIduC
         7dtZlNz0jk1cWOjLUMqoVufqdqRWCXPxB0ZalshELv+ALQ9QrKtoA9Jg9pRlIiHN7ppj
         vaBA==
X-Gm-Message-State: AOJu0YzB1ngcNUG3G9gv7/MUW6TmFC0CBKDgezZ8WkXITrAvNXkWk6bB
	CnVjTQV/rAo5sFj24b2m8BfvQbnUdA9s5KnQCwTOzUzo/bs+2lHnfihtAsgq
X-Google-Smtp-Source: AGHT+IHWihoL0jlNPksRIIIiXUNeDlO7bC22icya+W8/crYvdnyCxB6vs4fc98e/cUwhyFlRKuuzeA==
X-Received: by 2002:a17:906:11da:b0:a38:488a:601f with SMTP id o26-20020a17090611da00b00a38488a601fmr4209696eja.53.1707748731805;
        Mon, 12 Feb 2024 06:38:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWA+BehaSESfNGN9Evig8xZhg2yLow8fNckpM+kvGm285W5zXcf9hg6aqCvP44su7XcrA5D+DVSrPrc2wD/gStq7KmHRoE1Klk+ZJBsCV++qrBUAJx77ouc1WPp98/jiNOPbU6NmtoPbTOO214My7fWVEfLVb6Jlz9blG4SW4CYHjvQ6Wvx8tqVdoqFcR9z4NPPZ/nufeTSt2Ndv0gFSMuNulzHxlXqGpbSVaqawE62tndR75AK+Pjl306JgrI=
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k3-20020a1709061c0300b00a360ba43173sm266918ejg.99.2024.02.12.06.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 06:38:51 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	kuniyu@amazon.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: test case for callback_depth states pruning logic
Date: Mon, 12 Feb 2024 16:38:32 +0200
Message-ID: <20240212143832.28838-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212143832.28838-1-eddyz87@gmail.com>
References: <20240212143832.28838-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test case was minimized from mailing list discussion [0].
It is equivalent to the following C program:

    struct iter_limit_bug_ctx { __u64 a; __u64 b; __u64 c; };

    static __naked void iter_limit_bug_cb(void)
    {
    	switch (bpf_get_prandom_u32()) {
    	case 1:  ctx->a = 42; break;
    	case 2:  ctx->b = 42; break;
    	default: ctx->c = 42; break;
    	}
    }

    int iter_limit_bug(struct __sk_buff *skb)
    {
    	struct iter_limit_bug_ctx ctx = { 7, 7, 7 };

    	bpf_loop(2, iter_limit_bug_cb, &ctx, 0);
    	if (ctx.a == 42 && ctx.b == 42 && ctx.c == 7)
    	  asm volatile("r1 /= 0;":::"r1");
    	return 0;
    }

The main idea is that each loop iteration changes one of the state
variables in a non-deterministic manner. Hence it is premature to
prune the states that have two iterations left comparing them to
states with one iteration left.
E.g. {{7,7,7}, callback_depth=0} can reach state {42,42,7},
while {{7,7,7}, callback_depth=1} can't.

[0] https://lore.kernel.org/bpf/9b251840-7cb8-4d17-bd23-1fc8071d8eef@linux.dev/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/verifier_iterating_callbacks.c  | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 5905e036e0ea..a955a6358206 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -239,4 +239,74 @@ int bpf_loop_iter_limit_nested(void *unused)
 	return 1000 * a + b + c;
 }
 
+struct iter_limit_bug_ctx {
+	__u64 a;
+	__u64 b;
+	__u64 c;
+};
+
+static __naked void iter_limit_bug_cb(void)
+{
+	/* This is the same as C code below, but written
+	 * in assembly to control which branches are fall-through.
+	 *
+	 *   switch (bpf_get_prandom_u32()) {
+	 *   case 1:  ctx->a = 42; break;
+	 *   case 2:  ctx->b = 42; break;
+	 *   default: ctx->c = 42; break;
+	 *   }
+	 */
+	asm volatile (
+	"r9 = r2;"
+	"call %[bpf_get_prandom_u32];"
+	"r1 = r0;"
+	"r2 = 42;"
+	"r0 = 0;"
+	"if r1 == 0x1 goto 1f;"
+	"if r1 == 0x2 goto 2f;"
+	"*(u64 *)(r9 + 16) = r2;"
+	"exit;"
+	"1: *(u64 *)(r9 + 0) = r2;"
+	"exit;"
+	"2: *(u64 *)(r9 + 8) = r2;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all
+	);
+}
+
+SEC("tc")
+__failure
+__flag(BPF_F_TEST_STATE_FREQ)
+int iter_limit_bug(struct __sk_buff *skb)
+{
+	struct iter_limit_bug_ctx ctx = { 7, 7, 7 };
+
+	bpf_loop(2, iter_limit_bug_cb, &ctx, 0);
+
+	/* This is the same as C code below,
+	 * written in assembly to guarantee checks order.
+	 *
+	 *   if (ctx.a == 42 && ctx.b == 42 && ctx.c == 7)
+	 *     asm volatile("r1 /= 0;":::"r1");
+	 */
+	asm volatile (
+	"r1 = *(u64 *)%[ctx_a];"
+	"if r1 != 42 goto 1f;"
+	"r1 = *(u64 *)%[ctx_b];"
+	"if r1 != 42 goto 1f;"
+	"r1 = *(u64 *)%[ctx_c];"
+	"if r1 != 7 goto 1f;"
+	"r1 /= 0;"
+	"1:"
+	:
+	: [ctx_a]"m"(ctx.a),
+	  [ctx_b]"m"(ctx.b),
+	  [ctx_c]"m"(ctx.c)
+	: "r1"
+	);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


