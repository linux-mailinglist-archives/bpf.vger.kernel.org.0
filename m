Return-Path: <bpf+bounces-59937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1DFAD094D
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFBE3B4803
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9779220F2C;
	Fri,  6 Jun 2025 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkalUGtj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1AB21D3F6
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749243881; cv=none; b=Pep0BZMj7PsykIRn3oArdub8pqJ24EYgL2mFtg3+V0tQcXNi8FRPnVypqc50eYHyAs0xiL7rO/XaAWtCA+NDCioC89g4lP/9OI8HzV5BmYC/N2d8MqTuwNmCD3qj2MvLM4/u1a1Mp/fcYS66c9IjWLDQKZjlgsZ+GGfS5hsCcS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749243881; c=relaxed/simple;
	bh=Ul07GFSnXT2ptuegrS6QGqWKAVIhdx0EjzXOl0mRDvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9LRg1cReH5uvFdBkibhpm/50wK3gsKVMbtnbXvFNN3hQMwxNEje29kv6uwKFCyGZq5z0jxNW1keNwpoV7gE0Go4DWbJvg9i7viqBoYVhKajfJ+5tecY5MvyiT3wpi8/uquFrdak1cF/96uSnSLxsYS35INGqeycrFPOFY8aQwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkalUGtj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742c3d06de3so2973756b3a.0
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 14:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749243879; x=1749848679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzRdM+5P55ADSu+qThhMRVdCbdr57+JWUjbJlVZ3Rgk=;
        b=fkalUGtjZ1hCTY6SChm/HqqcgRCYfWae7IKBxpWlsGt8iXaHORW4HZob1NO50snpNh
         Tz0if0gQ+naRiVlZAUjzkrtgujL0wlH83R/mCSQjw7pqrGX83WDV37e6hAIVKS0D9fR8
         Av14lnCcKq03LGDhyEk7KHLmjTRhbd1RPu+jEsTMTvJZhXf8BYSAUPBfyz/sh9dEDLcT
         Xm/Zrf9HPQaCLDR9rRNTINzf9VujzyP32fs8ZTYi8RG+5LQJqKTEODEoZ1sYc0rUn39k
         KBMFCjHt9rHBjqPoPF03YoVZ5nFRYry1FQd2f9MTPQ4YsttH7ZBwTH6g/66OYZlmwCpP
         soRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749243879; x=1749848679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzRdM+5P55ADSu+qThhMRVdCbdr57+JWUjbJlVZ3Rgk=;
        b=NUqUoyDJhd57oxDuB6x7qf5gsQ+s/5Cn7eDqkoJJfSPDEfDAouzS3HYmY0PPAotis1
         TDqPeOHX6VZsEIwx1WGIiKpCxqPNKD+Eqj0XmqrIqCavE7m3PhwMY7Q74Tt1NkKoLMyg
         oRsRlorFy+xiUAdVV0NA7uFsen3jubWbeQjnWkP6XcgGOghZTGcUXpQ8K0S2SKZB1Pjy
         79ITr5iUz4/3jS141vjJxNf0rm8XU+3GHYpD4tVrzAzxtIeYIPZnrgJYlX+Nh6EMFh5R
         LqgMt6dQUtTFSkl/naudjyQE2RF9Id1mSaS5Bf4gaDsb2kafsdrNx0RdLp0J2wbFn8pP
         ZiHA==
X-Gm-Message-State: AOJu0YyVTCz8n/UCNGI+zNB1ISu2UQHrQxnLN+pRVtvrhATxMIubOU5U
	5i6ooZkuRgCj6L9DNNZOakRnYNiys5hB+scynRA6kqwqlMjq97/U0yKnYgjafca9
X-Gm-Gg: ASbGnctdS3LWKqmRyp5Byzz5hCG91dXwUydczdz5loUQDfaI4euCy/3HPCgR1AfQLoD
	tz3+oNcsIwmQiC4+3PopikTZwjF3lmLyVvMyUrkCk4ZX0pRZRvqsA62AaGV2bpANV68GIcY4HIR
	nbnb53aGBPFN4Yuho5b41uoOanNtkSVjz5VNX6903Jj2lhQSHRdoeEd6vnixE2vhMIe14kukBRj
	wW1zZURfzdtA5XLpxsvblp6LChOEkl3ECm209ilC1RxCVDtFxl8aLRhdkYEgRIsWOzESqDOj/ul
	sGZ80muGdkvQv7RXKDbr9jTQSj0tsMB9XL7p6jR5N85ebBlFdGrzvpYsRw==
X-Google-Smtp-Source: AGHT+IERupEi0p2XvMqNLqror5JPPpOHJ+tftWhAD5PJ75aN/bZ+f/Kkn6T585r80mJP1Rif/jzevw==
X-Received: by 2002:a05:6a00:2303:b0:736:34a2:8a18 with SMTP id d2e1a72fcca58-74827f4494cmr7078744b3a.24.1749243878657;
        Fri, 06 Jun 2025 14:04:38 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5ed58beasm1352640a12.15.2025.06.06.14.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 14:04:38 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 11/11] selftests/bpf: tests with a loop state missing read/precision mark
Date: Fri,  6 Jun 2025 14:03:52 -0700
Message-ID: <20250606210352.1692944-12-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606210352.1692944-1-eddyz87@gmail.com>
References: <20250606210352.1692944-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test case absent_mark_in_the_middle_state is equivalent of the
following C program:

   1: r8 = bpf_get_prandom_u32();
   2: r6 = -32;
   3: bpf_iter_num_new(&fp[-8], 0, 10);
   4: if (unlikely(bpf_get_prandom_u32() == r8))
   5:   r6 = -31;
   6: for (;;) {
   7:   if (!bpf_iter_num_next(&fp[-8]))
   8:     break;
   9:   if (unlikely(bpf_get_prandom_u32() == r8))
  10:     *(u64 *)(fp + r6) = 7;
  11: }
  12: bpf_iter_num_destroy(&fp[-8]);
  13: return 0;

W/o a fix that instructs verifier to ignore branches count for loop
entries verification proceeds as follows:
- 1-4, state is {r6=-32,fp-8=active};
- 6, checkpoint A is created with {r6=-32,fp-8=active};
- 7, checkpoint B is created with {r6=-32,fp-8=active},
     push state {r6=-32,fp-8=active} from 7 to 9;
- 8,12,13, {r6=-32,fp-8=drained}, exit;
- pop state with {r6=-32,fp-8=active} from 7 to 9;
- 9, push state {r6=-32,fp-8=active} from 9 to 10;
- 6, checkpoint C is created with {r6=-32,fp-8=active};
- 7, checkpoint A is hit, no precision propagated for r6 to C;
- pop state {r6=-32,fp-8=active} from 9 to 10;
- 10, state is {r6=-31,fp-8=active}, r6 is marked as read and precise,
      these marks are propagated to checkpoints A and B (but not C, as
      it is not the parent of current state;
- 6, {r6=-31,fp-8=active} checkpoint C is hit, because r6 is not
     marked precise for this checkpoint;
- the program is accepted, despite a possibility of unaligned u64
  stack access at offset -31.

The test case absent_mark_in_the_middle_state2 is similar except the
following change:

       r8 = bpf_get_prandom_u32();
       r6 = -32;
       bpf_iter_num_new(&fp[-8], 0, 10);
       if (unlikely(bpf_get_prandom_u32() == r8)) {
         r6 = -31;
 + jump_into_loop:
 +       goto +0;
 +       goto loop;
 +     }
 +     if (unlikely(bpf_get_prandom_u32() == r8))
 +       goto jump_into_loop;
 + loop:
       for (;;) {
         if (!bpf_iter_num_next(&fp[-8]))
           break;
         if (unlikely(bpf_get_prandom_u32() == r8))
           *(u64 *)(fp + r6) = 7;
       }
       bpf_iter_num_destroy(&fp[-8])
       return 0

The goal is to check that read/precision marks are propagated to
checkpoint created at 'goto +0' that resides outside of the loop.

The test case absent_mark_in_the_middle_state3 is a bit different and
is equivalent to the C program below:

    int absent_mark_in_the_middle_state3(void)
    {
      bpf_iter_num_new(&fp[-8], 0, 10)
      loop1(-32, &fp[-8])
      loop1_wrapper(&fp[-8])
      bpf_iter_num_destroy(&fp[-8])
    }

    int loop1(num, iter)
    {
      while (bpf_iter_num_next(iter)) {
        if (unlikely(bpf_get_prandom_u32()))
          *(fp + num) = 7;
      }
      return 0
    }

    int loop1_wrapper(iter)
    {
      r6 = -32;
      r8 = bpf_get_prandom_u32();
      if (unlikely(bpf_get_prandom_u32() == r8))
        r6 = -31;
      loop1(r6, iter);
      return 0;
    }

The unsafe state is reached in a similar manner, but the loop is
located inside a subprogram that is called from two locations in the
main subprogram. This detail is important for exercising
bpf_scc_visit->backedges memory management.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/iters.c | 277 ++++++++++++++++++++++
 1 file changed, 277 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 76adf4a8f2da..649b239585e5 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1649,4 +1649,281 @@ int clean_live_states(const void *ctx)
 	return 0;
 }
 
+SEC("?raw_tp")
+__flag(BPF_F_TEST_STATE_FREQ)
+__failure __msg("misaligned stack access off 0+-31+0 size 8")
+__naked int absent_mark_in_the_middle_state(void)
+{
+	/* This is equivalent to C program below.
+	 *
+	 * r8 = bpf_get_prandom_u32();
+	 * r6 = -32;
+	 * bpf_iter_num_new(&fp[-8], 0, 10);
+	 * if (unlikely(bpf_get_prandom_u32() == r8))
+	 *   r6 = -31;
+	 * while (bpf_iter_num_next(&fp[-8])) {
+	 *   if (unlikely(bpf_get_prandom_u32() == r8))
+	 *     *(fp + r6) = 7;
+	 * }
+	 * bpf_iter_num_destroy(&fp[-8])
+	 * return 0
+	 */
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r8 = r0;"
+		"r6 = -32;"
+		"r0 = 0;"
+		"*(u64 *)(r10 - 16) = r0;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 == r8 goto change_r6_%=;"
+	"loop_%=:"
+		"call noop;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto loop_end_%=;"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 == r8 goto use_r6_%=;"
+		"goto loop_%=;"
+	"loop_end_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 0;"
+		"exit;"
+	"use_r6_%=:"
+		"r0 = r10;"
+		"r0 += r6;"
+		"r1 = 7;"
+		"*(u64 *)(r0 + 0) = r1;"
+		"goto loop_%=;"
+	"change_r6_%=:"
+		"r6 = -31;"
+		"goto loop_%=;"
+		:
+		: __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_next),
+		  __imm(bpf_iter_num_destroy),
+		  __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+__used __naked
+static int noop(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+SEC("?raw_tp")
+__flag(BPF_F_TEST_STATE_FREQ)
+__failure __msg("misaligned stack access off 0+-31+0 size 8")
+__naked int absent_mark_in_the_middle_state2(void)
+{
+	/* This is equivalent to C program below.
+	 *
+	 *     r8 = bpf_get_prandom_u32();
+	 *     r6 = -32;
+	 *     bpf_iter_num_new(&fp[-8], 0, 10);
+	 *     if (unlikely(bpf_get_prandom_u32() == r8)) {
+	 *       r6 = -31;
+	 * jump_into_loop:
+	 *       goto +0;
+	 *       goto loop;
+	 *     }
+	 *     if (unlikely(bpf_get_prandom_u32() == r8))
+	 *       goto jump_into_loop;
+	 * loop:
+	 *     while (bpf_iter_num_next(&fp[-8])) {
+	 *       if (unlikely(bpf_get_prandom_u32() == r8))
+	 *         *(fp + r6) = 7;
+	 *     }
+	 *     bpf_iter_num_destroy(&fp[-8])
+	 *     return 0
+	 */
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r8 = r0;"
+		"r6 = -32;"
+		"r0 = 0;"
+		"*(u64 *)(r10 - 16) = r0;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 == r8 goto change_r6_%=;"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 == r8 goto jump_into_loop_%=;"
+	"loop_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto loop_end_%=;"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 == r8 goto use_r6_%=;"
+		"goto loop_%=;"
+	"loop_end_%=:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 0;"
+		"exit;"
+	"use_r6_%=:"
+		"r0 = r10;"
+		"r0 += r6;"
+		"r1 = 7;"
+		"*(u64 *)(r0 + 0) = r1;"
+		"goto loop_%=;"
+	"change_r6_%=:"
+		"r6 = -31;"
+	"jump_into_loop_%=: "
+		"goto +0;"
+		"goto loop_%=;"
+		:
+		: __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_next),
+		  __imm(bpf_iter_num_destroy),
+		  __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+SEC("?raw_tp")
+__flag(BPF_F_TEST_STATE_FREQ)
+__failure __msg("misaligned stack access off 0+-31+0 size 8")
+__naked int absent_mark_in_the_middle_state3(void)
+{
+	/*
+	 * bpf_iter_num_new(&fp[-8], 0, 10)
+	 * loop1(-32, &fp[-8])
+	 * loop1_wrapper(&fp[-8])
+	 * bpf_iter_num_destroy(&fp[-8])
+	 */
+	asm volatile (
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+		/* call #1 */
+		"r1 = -32;"
+		"r2 = r10;"
+		"r2 += -8;"
+		"call loop1;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		/* call #2 */
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call loop1_wrapper;"
+		/* return */
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_destroy),
+		  __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+__used __naked
+static int loop1(void)
+{
+	/*
+	 *  int loop1(num, iter) {
+	 *     r8 = bpf_get_prandom_u32();
+	 *     r6 = num;
+	 *     r7 = iter;
+	 *     while (bpf_iter_num_next(r7)) {
+	 *       if (unlikely(bpf_get_prandom_u32() == r8))
+	 *         *(fp + r6) = 7;
+	 *     }
+	 *     return 0
+	 *  }
+	 */
+	asm volatile (
+		"r6 = r1;"
+		"r7 = r2;"
+		"call %[bpf_get_prandom_u32];"
+		"r8 = r0;"
+	"loop_%=:"
+		"r1 = r7;"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto loop_end_%=;"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 == r8 goto use_r6_%=;"
+		"goto loop_%=;"
+	"loop_end_%=:"
+		"r0 = 0;"
+		"exit;"
+	"use_r6_%=:"
+		"r0 = r10;"
+		"r0 += r6;"
+		"r1 = 7;"
+		"*(u64 *)(r0 + 0) = r1;"
+		"goto loop_%=;"
+		:
+		: __imm(bpf_iter_num_next),
+		  __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+__used __naked
+static int loop1_wrapper(void)
+{
+	/*
+	 *  int loop1_wrapper(iter) {
+	 *    r6 = -32;
+	 *    r7 = iter;
+	 *    r8 = bpf_get_prandom_u32();
+	 *    if (unlikely(bpf_get_prandom_u32() == r8))
+	 *      r6 = -31;
+	 *    loop1(r6, r7);
+	 *    return 0;
+	 *  }
+	 */
+	asm volatile (
+		"r6 = -32;"
+		"r7 = r1;"
+		"call %[bpf_get_prandom_u32];"
+		"r8 = r0;"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 == r8 goto change_r6_%=;"
+	"loop_%=:"
+		"r1 = r6;"
+		"r2 = r7;"
+		"call loop1;"
+		"r0 = 0;"
+		"exit;"
+	"change_r6_%=:"
+		"r6 = -31;"
+		"goto loop_%=;"
+		:
+		: __imm(bpf_iter_num_next),
+		  __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.48.1


