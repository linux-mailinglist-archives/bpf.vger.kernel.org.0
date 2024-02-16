Return-Path: <bpf+bounces-22162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0052858013
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 16:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E8E282828
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 15:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E75412F5B4;
	Fri, 16 Feb 2024 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8NSEpmd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D8E12F592
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095833; cv=none; b=maR2MxohxQRO0wGUk/PvW08xLYzDTOVjidhuki0SvdR+txk5TYDuiawNicJZQKXUQ+SWPuiHSPxKSwSrwJYGaQUvjM/1rd49EsCt9EXTov0cPhqwNfvcWpcgogJM40os24Zpbaw3HmlAmOUPWNn/zdxKODfFPDnzybqfBgc1+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095833; c=relaxed/simple;
	bh=ZZGZ8jg42ZNxJPS33J4vIOEC18dNvJreMcUt/b38mzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgMOrY6mTPoQ0cfh9aTFZuIToy/6AC5lKghYj1djZqf6hlndwn2tiz5hLsoRx9ZBGkUw4Bl9T+Kdl69xtcJOATSV2Rw1kq7eKNylmEyRnQg+pvbam7LcPfHCbZCwfEcwx4rxmswhm+BwMeUwPCZP1LXuibVRrddZijPG1Nviwy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8NSEpmd; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a34c5ca2537so265603666b.0
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 07:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708095830; x=1708700630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbZZJtHttgWYhCWR6rqzHSFm1UqLGzy74tIhV2kB3GA=;
        b=I8NSEpmd2gDsr+ir4gLVeMqbmjIVbuMDqP+ZirIogm1NYiD1OyaSAPOvBzC1c6Ka85
         0MfqUZl3WVJKlsdV0hrwaJy0YTeE0J9P7nHA65OxnLyavtJMfa27JIVVji4wjgEl8xiB
         QfsoNOS5I1uu0zMpEVMj6mS6RpyvtbBm3oZZn//G105wKx3GWSVF6KpnZMYnkfI9KAXq
         DM8E1w9caOGeTm1SZ2FHFk2Fit6UEt3uqjDEhgeirxBO7L9mKLlDYEtUUrrtJzBWMm9m
         scVlO7EdOA5kFuBkQHDZdgVeJM+1X1nHB7olbLGT4PWo3v1ly5wdG9bEekWZ4FYwoSpN
         Ce8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708095830; x=1708700630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbZZJtHttgWYhCWR6rqzHSFm1UqLGzy74tIhV2kB3GA=;
        b=w7o5dZhd/mtt5V0L0Ogeww01reKrSY0OtzCWFLRbSAnY7/c6Zj2oNbLsFGSQ7SRKhb
         8OKOv8VD/PpWaBV37CoCVvGnw58vGgElb0GJ6BuPM7yqap68CdAOkYf07hdCqw08sSCK
         cgPv4mrF20ymDCLFyaG9xRgU/YDEoQKKWG/oMPRvRHdum23/w5to9C6UVpfO9qgogK2/
         dCv4scn1+DPBkyXRYmgIgNUEOsi/QCSprqx06sApSFeW/+IxHaZyLT90j6Qr+7baxQ/k
         IrNRtr4mhi8cg/p9Q0NGrTTfNnHxIPFC8MFq908B/CBgTrwpqTAjNlFjdsGrIsZx+i7R
         78tA==
X-Gm-Message-State: AOJu0Yz0itdnDoDrHIyhDs8SFJlTG+YzM0i4F/AYw5PCZN4NacfmaCyR
	uP+e2uWnBVAr9ZARPitGp2y5iwnR7CFEV7vT3Z5pQ6qLTrtQxo3J8duWwaOW
X-Google-Smtp-Source: AGHT+IFFiSevplw0c9Ow7DxhJi8hIuQGZ/RoHPochOacdp20n9I0L3TSbwzlN+ZJN7FkoFtzW/5ZFA==
X-Received: by 2002:a17:906:b0d9:b0:a3d:2243:29da with SMTP id bk25-20020a170906b0d900b00a3d224329damr3673812ejb.36.1708095830038;
        Fri, 16 Feb 2024 07:03:50 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id fj16-20020a1709069c9000b00a3d07f3ac61sm14209ejc.101.2024.02.16.07.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 07:03:49 -0800 (PST)
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
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: test case for callback_depth states pruning logic
Date: Fri, 16 Feb 2024 17:03:34 +0200
Message-ID: <20240216150334.31937-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216150334.31937-1-eddyz87@gmail.com>
References: <20240216150334.31937-1-eddyz87@gmail.com>
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


