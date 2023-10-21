Return-Path: <bpf+bounces-12881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4397D1A26
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 03:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10883B2168C
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 01:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F4CA38;
	Sat, 21 Oct 2023 01:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pc4yDv7u"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6938F801
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 01:00:24 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A54D69
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 18:00:22 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5046bf37ec1so1825736e87.1
        for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 18:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697850020; x=1698454820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piktWMIbUbvsCPFZL+ZgEoXRBrJsrW87UAPGh4LxYBU=;
        b=Pc4yDv7u7eYM8gaS+kc40NR5L+sVi6c6vfma7J3bRyDZH3qksK0uT2b/aOI0s9T8OR
         NyvY0akJBN54npX7OAHx+8ylWYmIDEp9ZdMDa5Sh7qV6UDuEGVoQtQgkpFBzHDjeNkGV
         ATkQE/52I93eYB9S9CclH4qTFHgVqQGLvOagbhktkz2RJ4gFakTw1I1hZZXPhAd0Zq7Q
         pqTLUWyP/nB/lrnN2GUIu8STi+XkDyb+5uLqfjjU2luqnXoIkkDPoaoMsd0hVpRT9vjQ
         oVxWSIkWZCp1DyWntUA1yAgA/A+O+1/DQ1uTAhroVvi3isjyrjGkQPrAHVi7U5axr2o3
         Tc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697850020; x=1698454820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piktWMIbUbvsCPFZL+ZgEoXRBrJsrW87UAPGh4LxYBU=;
        b=pCrmU/TMo1dthX/ldVoxjVfh7OUcasYggJN3ioFgC1CrU+GTNhJQUN7Ql5gXEOhDSb
         EP/hr8G9OnTmcQ2F9R/4PWOii13hHilJefpTSw9CEmzhmxQG+NXFWJ0jIw6RV2QJvoy/
         R3mGWteAl3xbNCAGtj7blhmXGA6nIcWdoWC2bKAJslxGiNcsf0KS1jzWFQ/UpiK4Cdrt
         gKk2Aym/Y5/COQx1ub53VCNNSTCGgNSNjKuV38WG1WcWwRmUyZKiajqMHflO9VFsZsjO
         476fCaKEUOZI+Mpzx6bIdG+nCXY+F/Ztjh6oqad8+/gqTHokl6CnYJqtqcnkLw0I4wXc
         IOrw==
X-Gm-Message-State: AOJu0YyKlWXf9npjwYtaGEHNnblnmYBby8UohGN9Y87hj6Zz4jgLGk9I
	NA1L8vru62cWpy5LgkJniVpy49oldOcO8A32
X-Google-Smtp-Source: AGHT+IFdwKu1XJbK57InYOLideZhuVbBiF4KxpmOfggmRTb2xlL0B7NeRwT0i+QW97xE+NPzGVjzwg==
X-Received: by 2002:a19:2d02:0:b0:507:9ff3:d6ec with SMTP id k2-20020a192d02000000b005079ff3d6ecmr2441510lfj.50.1697850020335;
        Fri, 20 Oct 2023 18:00:20 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id cf15-20020a0564020b8f00b0053deb97e8e6sm2370344edb.28.2023.10.20.18.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 18:00:19 -0700 (PDT)
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
Subject: [PATCH bpf-next 4/5] selftests/bpf: test if state loops are detected in a tricky case
Date: Sat, 21 Oct 2023 03:59:38 +0300
Message-ID: <20231021005939.1041-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231021005939.1041-1-eddyz87@gmail.com>
References: <20231021005939.1041-1-eddyz87@gmail.com>
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


