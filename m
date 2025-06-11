Return-Path: <bpf+bounces-60382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17775AD5FDC
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 22:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF743A9A4C
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 20:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424FB2BDC25;
	Wed, 11 Jun 2025 20:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eazbcBpm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12802BD027
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 20:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672553; cv=none; b=Ik/SkqtsyVHlGHRFXB8uPGSivj1SGNhUmB9lIhtvxfF0tr03bZUIdjqW8duL5iZQovZvjEp3xyYZsl3t8PICfC4wubU5hQT/yZxdrNoiiiffNt9mwF7rC7TRR4Ec3g9ZvMU0v2M88NGMyx2MQurM0DQrfihwAMZTGB7g6IyySJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672553; c=relaxed/simple;
	bh=Whp5kewlWtqkFKcmYO21wIz+CaANjwjl2aSgl73cu1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmjuMWinQ3veAe217IdwZONxsEjve7z+6vBBDIgVcags8cTKiOfqeXg9fAS+0HMp0gIgYINb8IYlaIYZTXW5K/Ptf21PU/RFXyUEmgk9xI8G0Da3ucwF/VBxLBLFU0FZvl9pfL7Cxm+cpKFORV/+B8Yq8TRI3MBDxzlbtb7avcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eazbcBpm; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70e64b430daso1768277b3.3
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 13:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749672551; x=1750277351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zrGMqlJG1qy7qCv9IUAltADDaVb2Dnz6ndFWfo3xM0=;
        b=eazbcBpmtOWC5t4BkGiiOkDmTGdaSU9+9diuDcn0QCMd5F796DB8By3fnAyX2O69Hr
         GFhQ8sfdBzTw1hU9Z1FqLLOwv6cNsRAzHviVD60hEyzbCBRQeu0QhbKvL32k1djB2e4n
         U3AjuFrJBvcZFiyypqMo4ERpNU2ZRVPh0POXur7m9R7iC7uTCNmKKhWZU88k2HEOG5LZ
         Z5eD6yPVPpEcomhm3sSckzLBSN77C3BZUqCGlXoMZU0GTAOn+4ShOMf1vp+VlgCtCAg5
         WABgsA4L0COVKEqPEZYP4A46lFjALcb1WnTUEX8G4kZD5kQl3ORq/A4s5Sw+hHx8CcrF
         6NOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749672551; x=1750277351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zrGMqlJG1qy7qCv9IUAltADDaVb2Dnz6ndFWfo3xM0=;
        b=u/3JkdUAePK5sTVoCpc4v3ygUc192O0Vr9E7QvxMLkOrzpTbQ3/RgKYhF/LfbQiDUx
         T3pJiLUUWN3fYZUV+D5pyL3dVDYWWNJSuf+YFUdU3G+hD5GKJXSzycXOIiBIkJPz1fax
         DURJGwI0pyIFaeqAxPBlHgmO1sAl3n81rC4S72XSx/CBTxtG84ZO02LE5xYe+sTbmI2x
         noEtdpQt415xKKrlw+vFvmf0pJypSwHQPKSFf0cmfFAjDSFMwooE2PN3k/csnnMsVbVG
         RB9y7gjO2y96m1k8sp4JOMUukhKTkqxlBTJD1eP1nR9YUlGAgTI7JdDAFFqMfmz2zJ2y
         A22A==
X-Gm-Message-State: AOJu0Yx4sbDD1u00iBRSUbDgqz71o+0k4mLFjmSn4BaN1gZJUrUHUQ+w
	h8QmzKBgxW8VDa6Zc4k6WLUcdlPpNWhBd149355F0umukfV8hyInvS9Xdrvm0Ecw
X-Gm-Gg: ASbGncsB67mPHG2R1b67fQPXq7C7agaPXcozk0ecWVPWDvKKbjU7yRu+sIShJZOowKg
	JLHB3kVFZxGmb93HaJnUsKPZvGgMJWUn3JdI7v5liP8sMZKJPM2MnQh2LYaxWKJplVQ+gUZglel
	m7B0BhLGaBHdH5WvEMyoRlsOtSzjs+djzoiH4kOAV92FDHwyyvi726Pl3dJrdRdTY0vQDYrw3jS
	2pJlaws6n59FLLGM4LzUkJ9LH8wILP2zLAlm9CffHTPUNpmDJfFlPf2rJUX2LCD3X4RwkTP4h/a
	Vj17aeeoU6KI/pl2mC18q5L7D6zLfKYbQAXX3Y46M+kTj+TX52r8NrdArMiJzJ3B
X-Google-Smtp-Source: AGHT+IGEfONWGHrREwhD6kTWR4MFHZvSDC+2NKV/31EKNa1scfgGFLdOjNeustOOe0SPv4bvA8nXNA==
X-Received: by 2002:a05:690c:6b09:b0:710:e7e3:ff6 with SMTP id 00721157ae682-71150966354mr7624997b3.12.1749672550737;
        Wed, 11 Jun 2025 13:09:10 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-711520599e1sm162327b3.7.2025.06.11.13.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 13:09:10 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v3 11/11] selftests/bpf: tests with a loop state missing read/precision mark
Date: Wed, 11 Jun 2025 13:08:36 -0700
Message-ID: <20250611200836.4135542-11-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250611200836.4135542-1-eddyz87@gmail.com>
References: <20250611200836.4135542-1-eddyz87@gmail.com>
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
2.47.1


