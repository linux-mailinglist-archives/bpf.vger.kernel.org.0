Return-Path: <bpf+bounces-56778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 151B6A9DA2D
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 12:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47199269B3
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 10:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A30227BA1;
	Sat, 26 Apr 2025 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqIJ4zrM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3959F224B15
	for <bpf@vger.kernel.org>; Sat, 26 Apr 2025 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745664412; cv=none; b=UlpRHmaWu9j6GmhwByTZLvF3d7MCVHG9M1Zez2RxIN0ZFRf65LZmyv+pGSuN+BaDdFeC5KStlZuK1STqqXFLpVjq21dlszGnHwKg0opvmWsntPcyhtadcDfHy9Xh8kR/RXA21cVp9S0D+pLvlk0HSrT//FHvhNsiUt6QFZpVZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745664412; c=relaxed/simple;
	bh=Y7t+nuM4SpN8zNbGHaakK0w0dR6D0pqiw67XHcn4OSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuQNqmywOkiz2hXt1Nhr4AzWUluTZ9yd8E/uQZEHeiGjUsWMqcQVVg1ejyIgtPK/1jIwEwLd7uyDe0NIv3aiTrhf6zty3Ni3zCZUfAgDMLuQxkHirCuEWNn7MYTOzS7LX2fdQR+EsjYfTu2e19J9LRf04n+aPM/3sn7G5VLjvs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqIJ4zrM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22c33677183so33776085ad.2
        for <bpf@vger.kernel.org>; Sat, 26 Apr 2025 03:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745664410; x=1746269210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvSDv6geHQnva0tZTlIIVPB3P3hVDgHYHpM1ipg3+Es=;
        b=PqIJ4zrMUNfxktzp2wBcWhcLDR6C0CDXPydQotXqqLX2VWnsuUtyAUlmQIgBO783lG
         zcD0HlWLsScQxpbB7Q4ezSGXEsJbnu9kSBw6poIX/1AuX7sUWLZ/LQR/nwa46sKlAL1k
         MuHInsXN7SM/IOT21gVYx192r/eBtK8H2IJwXpVVUqn0ogcwOgS74Z35sjtzY4diPRUq
         PTL83xATHx2Xhes/gsODtbXM9FuORya6lcWs7D/8iydtEy39PvDTBOJtWAcWrh+kBLj9
         WnXtjmZftG/f5g3gv8a2fSQB74K//MGc2DBTpeQfZJvK5NvP0WbkyoLU0GYvGCQptYg1
         q0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745664410; x=1746269210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvSDv6geHQnva0tZTlIIVPB3P3hVDgHYHpM1ipg3+Es=;
        b=qL8R6XXoPy0NoojSJcoieSJ2Inq89P58XSLxqmI5+QqWuGWx5LnP/26WjInOMeBQy9
         CSe5BqaV+j6KfqIeUlgdtWhGQXsY1SJukbYayHSOm/LkUlZIeyP9Pe5dZNodgRMRiVBu
         MAhlrIcAlA3pe38bNIgEJ/qGOm1l+DBICxVP36LDuyiEfFuofwbojOnztm58eg4dg3g5
         o+chBpocw47mPk0oyXT8o4uQFiDkXoC3wTcGniwrcTM5QE5/YyOl1uqUwCwcICm7h+3C
         3zLLKQCIb9jphic6hYJeHdaBBiyzdO3kwQnjLHwLvPqb9cbUeJdJEHMdUTQD7JR2Jley
         +91Q==
X-Gm-Message-State: AOJu0YzxbvCr4Y6F0XYjbeWfmwtPm1tRFrVA1Tn73tsX/F46yGQNgcb7
	gz2VE7RiNB5OgIqU3IDm2xda16dgvC4/NnGeitw8dzLaSfk+8vXkxSv2kWee
X-Gm-Gg: ASbGnctLbhBAsfNlTIgQfs+DSqfbdZNm2TMR0Sy11jvILS2oPDcwBO/+pnH82ABAa2A
	/nSGQwbAIhDHu5RpdlwPKVQp9b45HfPQaIku5HX//p9gmmLks9YbLiwxIt7ThNkY6SprEqzh/6k
	YFdGTdMzlIyuqIX4Y0fmqnO/W8uWcrfa2SxagHR3mHMjiQdQvUkEpZXA1LPRcOG4hFlRbvO+mMA
	1262KXfgNVqT6tsIH1dgzfAR0OxLx+ll0UX4u7BnFa+Lza03tCQ7uQgmrlpiCsFPKgIjN/0OaVx
	y8+FuwEUj9U/fHEjCpXEw2d3BR2ZP80dbNkB
X-Google-Smtp-Source: AGHT+IGvdQqiy8PuIS/mm/2yaE0uIOIqit2Pjy+sWTAJpPvxmTYna2iwt9Qutk5bz/ylfJw//sUCuA==
X-Received: by 2002:a17:902:cf05:b0:220:e1e6:4457 with SMTP id d9443c01a7336-22dc6a0f26dmr37415125ad.26.1745664410180;
        Sat, 26 Apr 2025 03:46:50 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5102e13sm47094115ad.201.2025.04.26.03.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 03:46:49 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 4/4] selftests/bpf: tests with a loop state missing read/precision mark
Date: Sat, 26 Apr 2025 03:46:34 -0700
Message-ID: <20250426104634.744077-5-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250426104634.744077-1-eddyz87@gmail.com>
References: <20250426104634.744077-1-eddyz87@gmail.com>
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

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/iters.c | 141 ++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 76adf4a8f2da..646dc0fdd44d 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1649,4 +1649,145 @@ int clean_live_states(const void *ctx)
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
 char _license[] SEC("license") = "GPL";
-- 
2.48.1


