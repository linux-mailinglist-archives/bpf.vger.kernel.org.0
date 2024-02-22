Return-Path: <bpf+bounces-22504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2541885FCDD
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 16:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2B71F27649
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 15:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566E9157E93;
	Thu, 22 Feb 2024 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDQrSykx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282C6157E6D
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616516; cv=none; b=k1R1/v+5k0j7GHhOako6mZzXnBuELBjStw5gUVA5KLGNzXOqq/Ca9KtR2UXZCqZX3CD/nQwP2dbP+i9GDsOEzDTH5CAoW5EBQsD6ZQn3uusVl2qIr4sWBbn99uBwc+M2SUvUX819xBdTpur5ZsvzTSoUd9wZ/h4dGWzpHO4aguE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616516; c=relaxed/simple;
	bh=GFDgM9Bjs3QsReMVZ3mlCKb79B6yRpxO4t3XLpHWXj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1XfmZE7Gc1J8vR6NJYxvnon9sXf+QGx1AWVJzNioZ89+76ais704Wh2du85AUguvsQclunEh0fcRaGOm2ry2RJ0F41DEOdL89ivsnewMmUp3ylnNRmQkSruISdJ3vZc2CKLamqm/aYQUemRW0ZNiFEc1td2lsCe3Oc/J2xqEI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDQrSykx; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3e8c1e4aa7so249132566b.2
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 07:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708616513; x=1709221313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNRdrDKg+lLjUQljgCVGrxuXBz2+59VRT1ktOLKZFE8=;
        b=SDQrSykxNPNbOmEKbVJEWEatrXRKLP6xYn6VUXw5E2aVRbiStr2bQL/DVgfovb2S34
         /T/GDLSXe53QqSbXB67JI+AVGTlE8hzmNkJqOCwgK6zSjnLKgitCbySHHJ1L4RpC4ZQv
         DMnVFaR/zi5pBtE+vqrlAWgRg7SNfwZX8q545osd2rD5UT4ZfM24ydSZbN+mYTrWLM9p
         pCG+DiL/UXkOVzb9c5L2iRkcAsdBKayXA5B/XlmhKN6KvmtHzjN4cdzpJUMNbF9ZLtow
         omvhfT8k2Gp3kg1kNGkPhjQsHEQ2B9EvtwbxfxE7FBYo/IKnXPcd+0TkxTQpoCf4woze
         QyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708616513; x=1709221313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNRdrDKg+lLjUQljgCVGrxuXBz2+59VRT1ktOLKZFE8=;
        b=SQDas0oBfLiY1DklIC7Fb52l7HRlvKiMYzkU8SSPORmaRLfW696UQZHLw3CXiEoHeP
         GZBCCV1cd6Hl+FrusxxNGh8Hi+iAwdh3d6oE8FezBqCT6cB7VaHluQ79yK/N8tzHF/aY
         1CfsckyFfHDZObB5dQJpIVPXJKu0bDH1G1lWrZsjfLmyNd7HYqWuyVBEkzpVJCqihDj4
         3nh2wIgRLZ+lrxIcy6zlEzdDkzPqIaTCWTUUyANZgMPIqdxs6UoabyHin7QhM/qboF+j
         275dGCpk37mWE5NrSIY4veIkBF4T64pfzuUpTge3KaOPPLecaAXsFhVtXzj73sTF2XF+
         FpIw==
X-Gm-Message-State: AOJu0YxyLwU88CfohCefBMrpvidmh7Pn/Fv9gh68B8LOOjrf5OBRypxB
	odaBPTUKMDQFqBlwHuZWe222LFPZlYu/HpkuaNBK9SLgfuFbSmWmwBDpt5Gm
X-Google-Smtp-Source: AGHT+IHmQjezh9zQ2HQF5xZVJEhZk0cSYTFTjMlJUqm90XN5qoj5ckyZVmK6bjjcdx4lz4ZwiK40iQ==
X-Received: by 2002:a17:906:57ca:b0:a3f:ce8:1234 with SMTP id u10-20020a17090657ca00b00a3f0ce81234mr5631103ejr.68.1708616512602;
        Thu, 22 Feb 2024 07:41:52 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id sn24-20020a170906629800b00a3e1939b23bsm5725090ejc.127.2024.02.22.07.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:41:52 -0800 (PST)
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
Subject: [PATCH bpf v3 2/2] selftests/bpf: test case for callback_depth states pruning logic
Date: Thu, 22 Feb 2024 17:41:21 +0200
Message-ID: <20240222154121.6991-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222154121.6991-1-eddyz87@gmail.com>
References: <20240222154121.6991-1-eddyz87@gmail.com>
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

Acked-by: Yonghong Song <yonghong.song@linux.dev>
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


