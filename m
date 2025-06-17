Return-Path: <bpf+bounces-60874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7DFADDF7D
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 01:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2647B3BFA8D
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 23:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9CA296176;
	Tue, 17 Jun 2025 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2lhv53X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93E029614D;
	Tue, 17 Jun 2025 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750202330; cv=none; b=ENNKcaC4LhFwsGgJx33vhFWf1djhzfooTsbjsULn2Iz8k8I53XwTKi7HJRrJQFmh9/lMACDHcDOiNFItCQstRVPFHIZCV+RCmUPXhgHWmf4KHsHvVXuW/CfWRjCvYQvvxV28GmG01GnJ8jtfAHsQPaEcA6E/VZRA2Gwx0OCXhJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750202330; c=relaxed/simple;
	bh=hXHbeVdrL8/IwH4m36ZNDV1Cg1XjK31grHHOCqkLZEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2IuBAP8lO+zam1U+TVXIzaTedfRiAqyD/FzDySAyRhc3D7RcT/GL7fOZdy3AYe5uGf0x1TwuwJXcyUxZI52W1AWwj02nNfmV2UwUVgMTy9XJw10hFX9ScL0duJS2qiJczatqTf/Rc8lTwfp8dmvMYGECqfw6b8MQwrFPYRWmf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2lhv53X; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fada2dd785so81556816d6.2;
        Tue, 17 Jun 2025 16:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750202327; x=1750807127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnkE53FG9ikGHH8F2xhs4VzH2zUUfbxluuFPSdwntJk=;
        b=I2lhv53XcpMptzJszdREzFsE+zEKZun4xxv6OAQHe4q7QJJDDqO3AQoHIH+z9oq3Dj
         v/sf8bkUnVOOZVlvXwxmlgjHvFHobgRJPEzD4hKw1hYUOkdirLv1ga37Q2aveWiM7vZG
         71FMlOh0MM3u6a5K4xUJ9onr4PD0Cs8msvZgSWR/Cp5NxfvdCrJLU+NzuCCbV05QKht8
         Wf89lMGqBrrFgmuQr9gUfxdsnEj+u2ox9sLFy/yxA04di5NVShnUNqjpVqNAKo3h+ufl
         WOAa59N24U0Z0dEhOeGI3fu4WvV/dBxbu8ScWicfxhB6Y3NcxJWTj8pGcw6RtcyvY6CC
         EgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750202327; x=1750807127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnkE53FG9ikGHH8F2xhs4VzH2zUUfbxluuFPSdwntJk=;
        b=C9m2iT0K1YrQ/CSDHtJnc21Bg6cs84m2S4PvbzD70GaNVtNfran4ahoeqzsMX4q0dr
         VEqOAsWK10eVKnrNBuKftD/fMx0ECQQFagq4pf6mus/JAPfchy45Q6QFco50fdVU9Ud9
         X60zkix5HMwt9q9/P7zINONTD5NfaABgZeXOIz6gk7+3fBh69vxHgt5jJo3r9xnvwFB6
         lAaIidF1MNaCbAqErQg2RnGIR0Fxdk0Iodj+TbqH/sJoEvT1NCAcYD+hyB3MmbATDnbk
         NSRQXqITctrHuGcNRNz1VQ1+jqpJbXcv9Wtu2L+dBRCYscs5T8g/aKEe2YCO1kbXb4e0
         G6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJiRPfJyMabAyqX4V+7O4nQaoVgtH81CpRU0IpSGOzEKUjH1xyFwBCO0mkn3f/iLW99DM=@vger.kernel.org, AJvYcCUnABpVjFu1A9rRTsfgqNzxVPW2ULm+evGde5LYqaYHF8pBL29Sl9knCS8S+WtW6532cDLRIE/zNyC1cldT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4NfXJM8K0nQD8JqCQqMMatQiwDra15nVJdXKQc9sB7TczDZOb
	qNvH5Q5J3StBBkORe8wZjHZ2J0vFMiwuS4DG0l37S6Zwmf5BLKKp8pW/
X-Gm-Gg: ASbGncs/gxNEcUEOfq8fwls/+GPlGRNkMYd9QAiehZ7k6AlpGvqcxHssl9BZuEBRswt
	8uuqVg7UsAHuBrFQCC6dqdaqXtn5HC9azceEuRshDwjHyFfA9Tf8BQK6siuX8ig+XtKevKAIU4N
	DaaJHY+7b7DDgO6QD7itdAT3sUXj5X5w2nmm1vrVd1+EP9PHcpjUOLdzlyFhfNQf6TSO9HIeie/
	zGdlEjRedBFROxMI/nGrVevstu87/aI27ThYe937plCjwRYxu6jIt0m2PAKvDgnHOY58eGNqw0d
	uOUnC41TBlXHysBAiAXr0kEvBh80rnzCwAnVd30Bf2ttn4pKei9+WR2U2zo5/BxzE6Qhq+WKV9l
	0REd36hyy6dFNk20DNgaWP7CboC3luaqIcDX4V3BnDxvXOeiStdEpwmaMrNAaEDZJVV6bPhOmOu
	N+qOBh
X-Google-Smtp-Source: AGHT+IHaTbLCKv23sZOosWI1/Vf9+BEf41wdE5/ruCwj9JQXNlK/sJ3I0Sxl0EWjIxz268/gRM2upw==
X-Received: by 2002:a05:6214:5f07:b0:6fa:9a6a:7d03 with SMTP id 6a1803df08f44-6fb47773412mr299993226d6.7.1750202327311;
        Tue, 17 Jun 2025 16:18:47 -0700 (PDT)
Received: from lima-default.. (pool-108-50-252-180.nwrknj.fios.verizon.net. [108.50.252.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb5db9f173sm12992576d6.14.2025.06.17.16.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 16:18:47 -0700 (PDT)
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
To: ast@kernel.org
Cc: m.shachnai@rutgers.edu,
	srinivas.narayana@rutgers.edu,
	santosh.nagarakatte@rutgers.edu,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] bpf, verifier: Improve precision for BPF_ADD and BPF_SUB
Date: Tue, 17 Jun 2025 19:17:31 -0400
Message-ID: <20250617231733.181797-2-harishankar.vishwanathan@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250617231733.181797-1-harishankar.vishwanathan@gmail.com>
References: <20250617231733.181797-1-harishankar.vishwanathan@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch improves the precison of the scalar(32)_min_max_add and
scalar(32)_min_max_sub functions, which update the u(32)min/u(32)_max
ranges for the BPF_ADD and BPF_SUB instructions. We discovered this more
precise operator using a technique we are developing for automatically
synthesizing functions for updating tnums and ranges.

According to the BPF ISA [1], "Underflow and overflow are allowed during
arithmetic operations, meaning the 64-bit or 32-bit value will wrap".
Our patch leverages the wrap-around semantics of unsigned overflow and
underflow to improve precision.

Below is an example of our patch for scalar_min_max_add; the idea is
analogous for all four functions.

There are three cases to consider when adding two u64 ranges [dst_umin,
dst_umax] and [src_umin, src_umax]. Consider a value x in the range
[dst_umin, dst_umax] and another value y in the range [src_umin,
src_umax].

(a) No overflow: No addition x + y overflows. This occurs when even the
largest possible sum, i.e., dst_umax + src_umax <= U64_MAX.

(b) Partial overflow: Some additions x + y overflow. This occurs when
the largest possible sum overflows (dst_umax + src_umax > U64_MAX), but
the smallest possible sum does not overflow (dst_umin + src_umin <=
U64_MAX).

(c) Full overflow: All additions x + y overflow. This occurs when both
the smallest possible sum and the largest possible sum overflow, i.e.,
both (dst_umin + src_umin) and (dst_umax + src_umax) are > U64_MAX.

The current implementation conservatively sets the output bounds to
unbounded, i.e, [umin=0, umax=U64_MAX], whenever there is *any*
possibility of overflow, i.e, in cases (b) and (c). Otherwise it
computes tight bounds as [dst_umin + src_umin, dst_umax + src_umax]:

if (check_add_overflow(*dst_umin, src_reg->umin_value, dst_umin) ||
    check_add_overflow(*dst_umax, src_reg->umax_value, dst_umax)) {
	*dst_umin = 0;
	*dst_umax = U64_MAX;
}

Our synthesis-based technique discovered a more precise operator.
Particularly, in case (c), all possible additions x + y overflow and
wrap around according to eBPF semantics, and the computation of the
output range as [dst_umin + src_umin, dst_umax + src_umax] continues to
work. Only in case (b), do we need to set the output bounds to
unbounded, i.e., [0, U64_MAX].

Case (b) can be checked by seeing if the minimum possible sum does *not*
overflow and the maximum possible sum *does* overflow, and when that
happens, we set the output to unbounded:

min_overflow = check_add_overflow(*dst_umin, src_reg->umin_value, dst_umin);
max_overflow = check_add_overflow(*dst_umax, src_reg->umax_value, dst_umax);

if (!min_overflow && max_overflow) {
	*dst_umin = 0;
	*dst_umax = U64_MAX;
}

Below is an example eBPF program and the corresponding log from the
verifier. At instruction 7: (0f) r5 += r3, due to conservative overflow
handling, the current implementation of scalar_min_max_add() sets r5's
bounds to [0, U64_MAX], which is then updated by reg_bounds_sync() to
[0x3d67e960f7d, U64_MAX].

0: R1=ctx() R10=fp0
0: (85) call bpf_get_prandom_u32#7    ; R0_w=scalar()
1: (bf) r3 = r0                       ; R0_w=scalar(id=1) R3_w=scalar(id=1)
2: (18) r4 = 0x950a43d67e960f7d       ; R4_w=0x950a43d67e960f7d
4: (4f) r3 |= r4                      ; R3_w=scalar(smin=0x950a43d67e960f7d,smax=-1,umin=0x950a43d67e960f7d,smin32=0xfe960f7d,umin32=0x7e960f7d,var_off=(0x950a43d67e960f7d; 0x6af5bc298169f082)) R4_w=0x950a43d67e960f7d
5: (18) r5 = 0xc014a00000000000       ; R5_w=0xc014a00000000000
7: (0f) r5 += r3                      ; R3_w=scalar(smin=0x950a43d67e960f7d,smax=-1,umin=0x950a43d67e960f7d,smin32=0xfe960f7d,umin32=0x7e960f7d,var_off=(0x950a43d67e960f7d; 0x6af5bc298169f082)) R5_w=scalar(smin=0x800003d67e960f7d,umin=0x3d67e960f7d,smin32=0xfe960f7d,umin32=0x7e960f7d,var_off=(0x3d67e960f7d; 0xfffffc298169f082))
8: (b7) r0 = 0                        ; R0_w=0
9: (95) exit

With our patch, r5's bounds after instruction 7 are set to a much more
precise [0x551ee3d67e960f7d, 0xc0149fffffffffff] by
scalar_min_max_add().

...
7: (0f) r5 += r3                      ; R3_w=scalar(smin=0x950a43d67e960f7d,smax=-1,umin=0x950a43d67e960f7d,smin32=0xfe960f7d,umin32=0x7e960f7d,var_off=(0x950a43d67e960f7d; 0x6af5bc298169f082)) R5_w=scalar(smin=0x800003d67e960f7d,umin=0x551ee3d67e960f7d,umax=0xc0149fffffffffff,smin32=0xfe960f7d,umin32=0x7e960f7d,var_off=(0x3d67e960f7d; 0xfffffc298169f082))
8: (b7) r0 = 0                        ; R0_w=0
9: (95) exit

The logic for scalar32_min_max_add is analogous. For the
scalar(32)_min_max_sub functions, the reasoning is similar but applied
to detecting underflow instead of overflow.

We verified the correctness of the new implementations using Agni [3,4].

We since also discovered that a similar technique has been used to
calculate output ranges for unsigned interval addition and subtraction
in Hacker's Delight [2].

[1] https://docs.kernel.org/bpf/standardization/instruction-set.html
[2] Hacker's Delight Ch.4-2, Propagating Bounds through Add’s and Subtract’s
[3] https://github.com/bpfverif/agni
[4] https://people.cs.rutgers.edu/~sn349/papers/sas24-preprint.pdf

Co-developed-by: Matan Shachnai <m.shachnai@rutgers.edu>
Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
---
 kernel/bpf/verifier.c | 76 +++++++++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 279a64933262..f403524bd215 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14605,14 +14605,25 @@ static void scalar32_min_max_add(struct bpf_reg_state *dst_reg,
 	s32 *dst_smax = &dst_reg->s32_max_value;
 	u32 *dst_umin = &dst_reg->u32_min_value;
 	u32 *dst_umax = &dst_reg->u32_max_value;
+	u32 umin_val = src_reg->u32_min_value;
+	u32 umax_val = src_reg->u32_max_value;
+	bool min_overflow, max_overflow;
 
 	if (check_add_overflow(*dst_smin, src_reg->s32_min_value, dst_smin) ||
 	    check_add_overflow(*dst_smax, src_reg->s32_max_value, dst_smax)) {
 		*dst_smin = S32_MIN;
 		*dst_smax = S32_MAX;
 	}
-	if (check_add_overflow(*dst_umin, src_reg->u32_min_value, dst_umin) ||
-	    check_add_overflow(*dst_umax, src_reg->u32_max_value, dst_umax)) {
+
+	/* If either all additions overflow or no additions overflow, then
+	 * it is okay to set: dst_umin = dst_umin + src_umin, dst_umax =
+	 * dst_umax + src_umax. Otherwise (some additions overflow), set
+	 * the output bounds to unbounded.
+	 */
+	min_overflow = check_add_overflow(*dst_umin, umin_val, dst_umin);
+	max_overflow = check_add_overflow(*dst_umax, umax_val, dst_umax);
+
+	if (!min_overflow && max_overflow) {
 		*dst_umin = 0;
 		*dst_umax = U32_MAX;
 	}
@@ -14625,14 +14636,25 @@ static void scalar_min_max_add(struct bpf_reg_state *dst_reg,
 	s64 *dst_smax = &dst_reg->smax_value;
 	u64 *dst_umin = &dst_reg->umin_value;
 	u64 *dst_umax = &dst_reg->umax_value;
+	u64 umin_val = src_reg->umin_value;
+	u64 umax_val = src_reg->umax_value;
+	bool min_overflow, max_overflow;
 
 	if (check_add_overflow(*dst_smin, src_reg->smin_value, dst_smin) ||
 	    check_add_overflow(*dst_smax, src_reg->smax_value, dst_smax)) {
 		*dst_smin = S64_MIN;
 		*dst_smax = S64_MAX;
 	}
-	if (check_add_overflow(*dst_umin, src_reg->umin_value, dst_umin) ||
-	    check_add_overflow(*dst_umax, src_reg->umax_value, dst_umax)) {
+
+	/* If either all additions overflow or no additions overflow, then
+	 * it is okay to set: dst_umin = dst_umin + src_umin, dst_umax =
+	 * dst_umax + src_umax. Otherwise (some additions overflow), set
+	 * the output bounds to unbounded.
+	 */
+	min_overflow = check_add_overflow(*dst_umin, umin_val, dst_umin);
+	max_overflow = check_add_overflow(*dst_umax, umax_val, dst_umax);
+
+	if (!min_overflow && max_overflow) {
 		*dst_umin = 0;
 		*dst_umax = U64_MAX;
 	}
@@ -14643,8 +14665,11 @@ static void scalar32_min_max_sub(struct bpf_reg_state *dst_reg,
 {
 	s32 *dst_smin = &dst_reg->s32_min_value;
 	s32 *dst_smax = &dst_reg->s32_max_value;
+	u32 *dst_umin = &dst_reg->u32_min_value;
+	u32 *dst_umax = &dst_reg->u32_max_value;
 	u32 umin_val = src_reg->u32_min_value;
 	u32 umax_val = src_reg->u32_max_value;
+	bool min_underflow, max_underflow;
 
 	if (check_sub_overflow(*dst_smin, src_reg->s32_max_value, dst_smin) ||
 	    check_sub_overflow(*dst_smax, src_reg->s32_min_value, dst_smax)) {
@@ -14652,14 +14677,18 @@ static void scalar32_min_max_sub(struct bpf_reg_state *dst_reg,
 		*dst_smin = S32_MIN;
 		*dst_smax = S32_MAX;
 	}
-	if (dst_reg->u32_min_value < umax_val) {
-		/* Overflow possible, we know nothing */
-		dst_reg->u32_min_value = 0;
-		dst_reg->u32_max_value = U32_MAX;
-	} else {
-		/* Cannot overflow (as long as bounds are consistent) */
-		dst_reg->u32_min_value -= umax_val;
-		dst_reg->u32_max_value -= umin_val;
+
+	/* If either all subtractions underflow or no subtractions
+	 * underflow, it is okay to set: dst_umin = dst_umin - src_umax,
+	 * dst_umax = dst_umax - src_umin. Otherwise (some subtractions
+	 * underflow), set the output bounds to unbounded.
+	 */
+	min_underflow = check_sub_overflow(*dst_umin, umax_val, dst_umin);
+	max_underflow = check_sub_overflow(*dst_umax, umin_val, dst_umax);
+
+	if (min_underflow && !max_underflow) {
+		*dst_umin = 0;
+		*dst_umax = U32_MAX;
 	}
 }
 
@@ -14668,8 +14697,11 @@ static void scalar_min_max_sub(struct bpf_reg_state *dst_reg,
 {
 	s64 *dst_smin = &dst_reg->smin_value;
 	s64 *dst_smax = &dst_reg->smax_value;
+	u64 *dst_umin = &dst_reg->umin_value;
+	u64 *dst_umax = &dst_reg->umax_value;
 	u64 umin_val = src_reg->umin_value;
 	u64 umax_val = src_reg->umax_value;
+	bool min_underflow, max_underflow;
 
 	if (check_sub_overflow(*dst_smin, src_reg->smax_value, dst_smin) ||
 	    check_sub_overflow(*dst_smax, src_reg->smin_value, dst_smax)) {
@@ -14677,14 +14709,18 @@ static void scalar_min_max_sub(struct bpf_reg_state *dst_reg,
 		*dst_smin = S64_MIN;
 		*dst_smax = S64_MAX;
 	}
-	if (dst_reg->umin_value < umax_val) {
-		/* Overflow possible, we know nothing */
-		dst_reg->umin_value = 0;
-		dst_reg->umax_value = U64_MAX;
-	} else {
-		/* Cannot overflow (as long as bounds are consistent) */
-		dst_reg->umin_value -= umax_val;
-		dst_reg->umax_value -= umin_val;
+
+	/* If either all subtractions underflow or no subtractions
+	 * underflow, it is okay to set: dst_umin = dst_umin - src_umax,
+	 * dst_umax = dst_umax - src_umin. Otherwise (some subtractions
+	 * underflow), set the output bounds to unbounded.
+	 */
+	min_underflow = check_sub_overflow(*dst_umin, umax_val, dst_umin);
+	max_underflow = check_sub_overflow(*dst_umax, umin_val, dst_umax);
+
+	if (min_underflow && !max_underflow) {
+		*dst_umin = 0;
+		*dst_umax = U64_MAX;
 	}
 }
 
-- 
2.45.2


