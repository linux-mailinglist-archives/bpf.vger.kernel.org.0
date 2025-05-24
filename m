Return-Path: <bpf+bounces-58903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21913AC3113
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 21:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC59A9E1986
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 19:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A49F1F1315;
	Sat, 24 May 2025 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlADtoNY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AE233997
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748114399; cv=none; b=UTOqtsMmUKmTNV6HlubVJfiGIc7SVlQH2l3dpm0YFSHVbS5blV1iT3CiC8c+lfdq9GzyG6f/OACu/hK1Z+LSdTthElptYCF/wgyjZMdfyELljqbYn0KW5kkaKPJXb1MRJPty2nUvRny3ZvkWoJPMfLJJQUyKcxiH+4MXDH9fnJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748114399; c=relaxed/simple;
	bh=Yuo/tV5SX63bKkQreOq0jf3lal3hXa4VXKhcoTVfXMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THNk66vlxaPb4Uai4e0hEm9Ej5Rxv9OEQ9vGITJPzftRSWTFmp9JVhc2/BmcA1Dv1+9V6AmM5Do30DlTqW6FndXQYWAdH+20SqWWqX5FjS+xwjBcx0QN9X6oeDx4zA/B4Oix8B6Zgpe4ZhthWK3CJ73PfOPOX83aSqApzWI0y3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlADtoNY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742c73f82dfso703923b3a.2
        for <bpf@vger.kernel.org>; Sat, 24 May 2025 12:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748114397; x=1748719197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEvT+WIJjxG+lNhBekuoMuA0f7Yrxvdy9EUKvw5fRBw=;
        b=IlADtoNYkGvBXS8V3Gq4RX0MhvyKdBu4rfYg2NeLuHznJxtU+srVFxPqbpPac0ySaY
         W97zOWv/zv4v0NexUH7lVeEyug5MxCWL5ID16V/9f0eO3pJk2+UypSvbwVULXBwF66Jm
         FAn7sUhbPMiSwy78dTKubE7SN4YS+xDWohBfFJXX6i8O3f5Giy1cOHCCN5Ht5O73dzEU
         PbomCBB3QAkNGou3TlLkmH4es8PmMXIufZnQbBcZq5m9lrQ83fgCBbftlU1MtvOAR5LF
         66mzLXh0bXKbUl7WgDCKtGkWx+FxOcbnZ3EOgMns8gbt81ytwouJZAHgHC3wpWMV3mgY
         oxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748114397; x=1748719197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEvT+WIJjxG+lNhBekuoMuA0f7Yrxvdy9EUKvw5fRBw=;
        b=sKmCJ4NdZK2zBImzElLJXf3cWcevtI81X7YSqOcDogDQ6ytEXxq73z/xWWMWMpQzIj
         zI9a5BP+xgkjdZPAJmlMSfcpYQRbMF59N84cw5kfk36/2lkqJCOfwE4dioqqazZbEG5W
         eMtk5rozvm251MfDB0aZ/34GNBi3jNWPU3w5lRqMUwMLslnaRuFGEu5bZxtk2YaKdZzK
         4/WnzWok+WtBZEOUgEDPj0S5lCxEhqA6HDhTt63qo1v8OZjwXQxOlxggswOyHVCa81VM
         UoAttoiPw3q23WxqGqgp6MTGC6wsU+ocGk0NKjkoSSDn45zjk5vkpi+/FtvSUQ4XMesQ
         nYcg==
X-Gm-Message-State: AOJu0YzUzld0hRo4B8RperYhYksfa9fiMYNdDNxVLjGdBKtxZnPSgjqx
	ZOMxqyhiZ1nboVBuH6gIWx7nPshuVgjPfiMmoUPZ5uSM4zFDRCalpc0ThU8EOTQL
X-Gm-Gg: ASbGncsBfQmYPJuq5yXs/DuUmEu8tNxPQ+p8u/oS1nsjmA1/ORdwAoZvFRMBGefKptv
	zDILWcCaoM2XqmvnE10L6kuy8l5pRkK8GNEA34LnYRYZ/DhpxqGsFfzGkk5MMsezIOROYyq2vE/
	/i/3Sopx00RTXkTL/z8fiNq0U8RcxO1HJyNKQm2t/ijCgM6KVRrloXSa9cDwJHuvnirjpTuoIIy
	kp5d5Qov6d/1+odYITBJ7s5LVeUFbI5Z7DK1tQWkBqw3fnuBnFHwdVz3wHHrfSweMIM7UUswIYe
	XDk10hhenFPXHHhpM9ops1ub4G5EGaFNGIfMmMrwxHKQhWw=
X-Google-Smtp-Source: AGHT+IEY19gOT5SIWy6hS8nOx1EhDHb8BlVbgSsC0QNRaGkcyiLvaYKCV2svLVcgW6zcyrj396hRNQ==
X-Received: by 2002:a05:6a00:21c2:b0:73e:10ea:b1e9 with SMTP id d2e1a72fcca58-745fdfc46a6mr5783267b3a.6.1748114397231;
        Sat, 24 May 2025 12:19:57 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a986b38bsm14558298b3a.129.2025.05.24.12.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 12:19:56 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 11/11] selftests/bpf: tests with a loop state missing read/precision mark
Date: Sat, 24 May 2025 12:19:32 -0700
Message-ID: <20250524191932.389444-12-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250524191932.389444-1-eddyz87@gmail.com>
References: <20250524191932.389444-1-eddyz87@gmail.com>
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
   4: if (unlikely(bpf_get_prandom_u32()))
   5:   r6 = -31;
   6: for (;;) {
   7:   if (!bpf_iter_num_next(&fp[-8]))
   8:     break;
   9:   if (unlikely(bpf_get_prandom_u32()))
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
       if (unlikely(bpf_get_prandom_u32())) {
         r6 = -31;
 + jump_into_loop:
 +       goto +0;
 +       goto loop;
 +     }
 +     if (unlikely(bpf_get_prandom_u32()))
 +       goto jump_into_loop;
 + loop:
       for (;;) {
         if (!bpf_iter_num_next(&fp[-8]))
           break;
         if (unlikely(bpf_get_prandom_u32()))
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
      if (unlikely(bpf_get_prandom_u32()))
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
index 76adf4a8f2da..7dd92a303bf6 100644
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
+	 * if (unlikely(bpf_get_prandom_u32()))
+	 *   r6 = -31;
+	 * while (bpf_iter_num_next(&fp[-8])) {
+	 *   if (unlikely(bpf_get_prandom_u32()))
+	 *     *(fp + r6) = 7;
+	 * }
+	 * bpf_iter_num_destroy(&fp[-8])
+	 * return 0
+	 */
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r8 = r0;"
+		"r7 = 0;"
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
+	 *     if (unlikely(bpf_get_prandom_u32())) {
+	 *       r6 = -31;
+	 * jump_into_loop:
+	 *       goto +0;
+	 *       goto loop;
+	 *     }
+	 *     if (unlikely(bpf_get_prandom_u32()))
+	 *       goto jump_into_loop;
+	 * loop:
+	 *     while (bpf_iter_num_next(&fp[-8])) {
+	 *       if (unlikely(bpf_get_prandom_u32()))
+	 *         *(fp + r6) = 7;
+	 *     }
+	 *     bpf_iter_num_destroy(&fp[-8])
+	 *     return 0
+	 */
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r8 = r0;"
+		"r7 = 0;"
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
+	 *     r6 = num;
+	 *     r7 = iter;
+	 *     while (bpf_iter_num_next(r7)) {
+	 *       if (unlikely(bpf_get_prandom_u32()))
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
+	 *    if (unlikely(bpf_get_prandom_u32()))
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


