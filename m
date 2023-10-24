Return-Path: <bpf+bounces-13081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1907D43B3
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 02:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A2E1C20A66
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7A310E7;
	Tue, 24 Oct 2023 00:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DokYderV"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7B315D4
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 00:09:39 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1196E10A
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:09:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso584858966b.2
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698106176; x=1698710976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oe+oQUcoVE5FYFQswqIfknvsDZICuSOrT/ozdLpWlwc=;
        b=DokYderVmmb+N2/MpQAO3uFO3AUOHevUNDDRANWnDZvNxYvqVhNjnIevSJWTMbVJhD
         KULVOHa/sQ4XsaTGDuBqubQXqIfVAcaXHPsXAbz3i77GFWlXr2j6OnmA121a5aERcCRO
         fvd5e9ZEgJ/grtQQkwjnW1B+BBerBIRJO7LPTcTnL3RUzgd3tr18Qm6/szV1BayK1k52
         0cWuBn3ZRnfFAnHLTjmc6a49BYqrFe0t6zY+lgStgxobrUzEaUlUgocLGRIW+4HCrQL6
         QXqj2/gEY0n3CI8fBrsxq6ZWda0o7cC1QngtedwSSFJOreLVk0RXOyrJTQzYeHIC26Je
         uSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698106176; x=1698710976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oe+oQUcoVE5FYFQswqIfknvsDZICuSOrT/ozdLpWlwc=;
        b=WCmpbbxBKDiA8reqOFjqDP3S/ixEzBhXZbDEH2LZTSI2KslpSqXgC4S7tsHWHWQxmV
         4+0VJaVzEm/JqmXTHy1u2YqYez8a3qzEBsZiUuRk9VNgDkG83tALTLxhszpc4munsvJY
         VzFVH/rCAYnTURrlKcL1h88YOUZept0zIgRBFNPB4uMA4Hmu2K/ZQd8JdrhfHZyMiMM1
         ZjQXBT+/iPUK9jZX91HiiJnD1nfvrgPmqs1wc5DB9Le4Pwb0Hj5zf3XI5bhYJ7cGPaZw
         6Hpxk+8zhAPFVpDt9QzFT8lj/cdTh23gtKEYZyggPkKLFjclhKOCKmD9OCJnpClySX+Q
         acvA==
X-Gm-Message-State: AOJu0YwNHSywJLnmnXnrINDSzi4B0OMcOg27EfQ+H1SZwTIvfzMsFSjv
	lOpsYap4yu7bwLDc0fymNwVDkr7Twv3RrhO+
X-Google-Smtp-Source: AGHT+IEYFNqohXcJ8bmMDNCFWkKIqREM/3ZHcdau66OkAfrxVO+ZNb3DnTGY0NzpOqK3TQPqqo3DCw==
X-Received: by 2002:a17:907:7f93:b0:9b7:58:52a8 with SMTP id qk19-20020a1709077f9300b009b7005852a8mr9246643ejc.19.1698106176215;
        Mon, 23 Oct 2023 17:09:36 -0700 (PDT)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id d13-20020a1709064c4d00b009a5f1d15642sm7264516ejw.158.2023.10.23.17.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 17:09:35 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 6/7] selftests/bpf: test if state loops are detected in a tricky case
Date: Tue, 24 Oct 2023 03:09:16 +0300
Message-ID: <20231024000917.12153-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024000917.12153-1-eddyz87@gmail.com>
References: <20231024000917.12153-1-eddyz87@gmail.com>
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
index 764a68420c3e..c20c4e38b71c 100644
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


