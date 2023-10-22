Return-Path: <bpf+bounces-12912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A099B7D2097
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 03:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78E91C20B56
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 01:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25F681C;
	Sun, 22 Oct 2023 01:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVtHS9fi"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E62A48
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 01:08:54 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33463D60
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 18:08:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-991c786369cso310318666b.1
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 18:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697936931; x=1698541731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piktWMIbUbvsCPFZL+ZgEoXRBrJsrW87UAPGh4LxYBU=;
        b=WVtHS9fipVPtbU71Mmei7antFzbcsJoKsm6itQvkRj3qeadCyi1OpTiTVHEJkWccBU
         rxMQXW3cj0TbRdnaE3t5bAF1PEPlUnsnTg3O3gh5lHe+aRFLDmqOEfOV3CBr4X7JYJfH
         Zb2WpaFtJRii5l8DR7YxNmVldlsRofr0tzr+AZhoGSAT457c3rR0cNtmgznMq22CEaxV
         p4BG5XGaS3Tl7Q99KVgU9dmEpy9ApK3NPMyrJJhXHp8BfBS3B31JTf6XqKXo5CSF84Xk
         ilTMfopjbx4ZTT5Jd5T9yFsvcYvGdxxL81Iy/4Z0E+zEdQf9KC/6HHNR4bdEW1TZ8C2u
         yOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697936931; x=1698541731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piktWMIbUbvsCPFZL+ZgEoXRBrJsrW87UAPGh4LxYBU=;
        b=uDMN3E5kUQyMfZde0wdinSy4xwALCh1NwEhAiBnLRZsJha93kzr14ZBeaSoO0cjaS7
         hB4sags4uESsyz2w7aN308OsRrI0+s0Ik2JR0tufbXKc18uxdwQTzuJI7QPH2AlZ+MaI
         bLOkwb1t4K2w4tXCTT91iT+W/W60M7iI7gx3HnXbMHwKbgr/L041K+7YTqFgEPiPWEvR
         2gE+N0HW7pffe5n4NCfG6E5Gy3DNu3xju/cSyDthYjxo4+ZiK1L91cPym/JDs0LEOQ2k
         cADC+dRuUlJAAxlr1st18bZpuQ97qhmi+Glw+T0An5lmaJrYq20cD+T/C8BEsgMcSezW
         OrSg==
X-Gm-Message-State: AOJu0Yy60R9sKGVcon6GE4TWesH9aLaeQP4jHGoxGDZsEH2pX1PWtN+T
	131A6aQrlYitoRpCmX79KS+pYbor/Fn6BhUo
X-Google-Smtp-Source: AGHT+IEOozfB3FSWTsEYNmDtchSxnFlLaU4/kW0j3U3cPZaSYfazvd4pik1TvxnCa7W+0oyDChDbsA==
X-Received: by 2002:a17:907:6d07:b0:9a1:f10d:9746 with SMTP id sa7-20020a1709076d0700b009a1f10d9746mr3900869ejc.20.1697936931364;
        Sat, 21 Oct 2023 18:08:51 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906655000b009c3f1b3e988sm4276143ejn.90.2023.10.21.18.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 18:08:50 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	awerner32@gmail.com,
	john.fastabend@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 6/7] selftests/bpf: test if state loops are detected in a tricky case
Date: Sun, 22 Oct 2023 04:08:11 +0300
Message-ID: <20231022010812.9201-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231022010812.9201-1-eddyz87@gmail.com>
References: <20231022010812.9201-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A convoluted test case for iterators convergence logic that
demonstrates that states with branch count equal to 0 might still be
a part of not completely explored loop.

E.g. consider the following state diagram:

               initial     Here state 'succ' was processed first,
                 |         it was eventually tracked to produce a
                 V         state identical to 'hdr'.
    .---------> hdr        All branches from 'succ' had been explored
    |            |         and thus 'succ' has its .branches == 0.
    |            V
    |    .------...        Suppose states 'cur' and 'succ' correspond
    |    |       |         to the same instruction + callsites.
    |    V       V         In such case it is necessary to check
    |   ...     ...        whether 'succ' and 'cur' are identical.
    |    |       |         If 'succ' and 'cur' are a part of the same loop
    |    V       V         they have to be compared exactly.
    |   succ <- cur
    |    |
    |    V
    |   ...
    |    |
    '----'

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/iters.c | 177 ++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index ee85cc6d3444..89aaddec9a6d 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -998,6 +998,183 @@ __naked int loop_state_deps1(void)
 	);
 }
 
+SEC("?raw_tp")
+__failure
+__msg("math between fp pointer and register with unbounded")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked int loop_state_deps2(void)
+{
+	/* This is equivalent to C program below.
+	 *
+	 * The case turns out to be tricky in a sense that:
+	 * - states with read+precise mark on c are explored only on a second
+	 *   iteration of the first inner loop and in a state which is pushed to
+	 *   states stack first.
+	 * - states with c=-25 are explored only on a second iteration of the
+	 *   second inner loop and in a state which is pushed to states stack
+	 *   first.
+	 *
+	 * Depending on the details of iterator convergence logic
+	 * verifier might stop states traversal too early and miss
+	 * unsafe c=-25 memory access.
+	 *
+	 *   j = iter_new();             // fp[-16]
+	 *   a = 0;                      // r6
+	 *   b = 0;                      // r7
+	 *   c = -24;                    // r8
+	 *   while (iter_next(j)) {
+	 *     i = iter_new();           // fp[-8]
+	 *     a = 0;                    // r6
+	 *     b = 0;                    // r7
+	 *     while (iter_next(i)) {
+	 *       if (a == 1) {
+	 *         a = 0;
+	 *         b = 1;
+	 *       } else if (a == 0) {
+	 *         a = 1;
+	 *         if (random() == 42)
+	 *           continue;
+	 *         if (b == 1) {
+	 *           *(r10 + c) = 7;     // this is not safe
+	 *           iter_destroy(i);
+	 *           iter_destroy(j);
+	 *           return;
+	 *         }
+	 *       }
+	 *     }
+	 *     iter_destroy(i);
+	 *     i = iter_new();           // fp[-8]
+	 *     a = 0;                    // r6
+	 *     b = 0;                    // r7
+	 *     while (iter_next(i)) {
+	 *       if (a == 1) {
+	 *         a = 0;
+	 *         b = 1;
+	 *       } else if (a == 0) {
+	 *         a = 1;
+	 *         if (random() == 42)
+	 *           continue;
+	 *         if (b == 1) {
+	 *           a = 0;
+	 *           c = -25;
+	 *         }
+	 *       }
+	 *     }
+	 *     iter_destroy(i);
+	 *   }
+	 *   iter_destroy(j);
+	 *   return;
+	 */
+	asm volatile (
+		"r1 = r10;"
+		"r1 += -16;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+		"r6 = 0;"
+		"r7 = 0;"
+		"r8 = -24;"
+	"j_loop_%=:"
+		"r1 = r10;"
+		"r1 += -16;"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto j_loop_end_%=;"
+
+		/* first inner loop */
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+		"r6 = 0;"
+		"r7 = 0;"
+	"i_loop_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto i_loop_end_%=;"
+	"check_one_r6_%=:"
+		"if r6 != 1 goto check_zero_r6_%=;"
+		"r6 = 0;"
+		"r7 = 1;"
+		"goto i_loop_%=;"
+	"check_zero_r6_%=:"
+		"if r6 != 0 goto i_loop_%=;"
+		"r6 = 1;"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 != 42 goto check_one_r7_%=;"
+		"goto i_loop_%=;"
+	"check_one_r7_%=:"
+		"if r7 != 1 goto i_loop_%=;"
+		"r0 = r10;"
+		"r0 += r8;"
+		"r1 = 7;"
+		"*(u64 *)(r0 + 0) = r1;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		"r1 = r10;"
+		"r1 += -16;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 0;"
+		"exit;"
+	"i_loop_end_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+
+		/* second inner loop */
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+		"r6 = 0;"
+		"r7 = 0;"
+	"i2_loop_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto i2_loop_end_%=;"
+	"check2_one_r6_%=:"
+		"if r6 != 1 goto check2_zero_r6_%=;"
+		"r6 = 0;"
+		"r7 = 1;"
+		"goto i2_loop_%=;"
+	"check2_zero_r6_%=:"
+		"if r6 != 0 goto i2_loop_%=;"
+		"r6 = 1;"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 != 42 goto check2_one_r7_%=;"
+		"goto i2_loop_%=;"
+	"check2_one_r7_%=:"
+		"if r7 != 1 goto i2_loop_%=;"
+		"r6 = 0;"
+		"r8 = -25;"
+		"goto i2_loop_%=;"
+	"i2_loop_end_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+
+		"r6 = 0;"
+		"r7 = 0;"
+		"goto j_loop_%=;"
+	"j_loop_end_%=:"
+		"r1 = r10;"
+		"r1 += -16;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32),
+		  __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_next),
+		  __imm(bpf_iter_num_destroy)
+		: __clobber_all
+	);
+}
+
 SEC("?raw_tp")
 __success
 __naked int triple_continue(void)
-- 
2.42.0


