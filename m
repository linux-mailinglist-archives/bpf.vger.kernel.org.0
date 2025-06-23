Return-Path: <bpf+bounces-61257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 224B8AE3426
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 06:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6FC916F6C5
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 04:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE391A23AD;
	Mon, 23 Jun 2025 04:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKLrkNWh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB3D10A1E;
	Mon, 23 Jun 2025 04:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750651485; cv=none; b=lju+nFZY7/WbI69TQeqSgVdwi3lS2R/uGo9IVrxF3xLmP2cI0RnzUeuogk4sdRXHUVP8Nqw6hONo4FKiRJFJbz+q7/y2QeOcxWVQcDbA/6lfTp/N4Z3UvNcwPIiNqJZcJonR1yNpgW879vv8E++UmCNr/2S/Z4uf5aXsovgmBxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750651485; c=relaxed/simple;
	bh=nw0HZ/MY1R0AfsbyhAholz+uRmivzjRSJqewjIU5Ttc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DnlnJTnaDDmspzDnXk7hBvWU7lj9gbo4/9J6T+cUKiLrB2jGKeZO+bpdlhq/1/iTPQtLMp4LXXxrR14/Atut/XSWRdSC93vQ2HHmXKVFJZMrhnKRGjji+1Ol0S3VP3q/g/bb0US6vCMSMIU4myuiXljjdY6nS0oqVyxd0bdXL0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKLrkNWh; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d219896edeso447748585a.1;
        Sun, 22 Jun 2025 21:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750651482; x=1751256282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvZn2UHvruNWAJqVxizc+nhbDtjTIhNXgvVbLLYHuUk=;
        b=EKLrkNWhY90LmEA5AG9/GMbERpJjd8aKHn7+1nf/fyuPiZLa2Lf25KdxCJPZOkJ1pt
         Uvi6MtuVzdVum1TXh7SdVGYluJiZ3r6mCZAzR04UQ8vfBISrCrGd5frWkfI1JPdkihIZ
         OUB/H+AdQMMKTwNTlBWqZjdDsYYA3ijN/iDphHGeULzDMVbTVjkExb5ddoMLHFPqIRv0
         VzSuxlMu0AhOOYozhrRM1xBBOzaH3tEcM7Md20yT3c3hhCifovJWdQOpwNjTJ1UU+gg0
         vadpcugs7D6qs7SV9022TeYTQzaHSVoYQpfNicZrfz/cWL4QcvJdYi27m4pyuOPrdgeT
         eLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750651482; x=1751256282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvZn2UHvruNWAJqVxizc+nhbDtjTIhNXgvVbLLYHuUk=;
        b=i8ar8/QxuJA/4JqDrn0Wz6tnHiXvAST8X4jHOrTJ6L9vf77ES5nC2ZQTIll1KR2nOy
         S2aLsWWVPFpJQhlkQ9R4XuqYGDVlL3fetagB9k36cfpC5ZKTMbYGfCTAJEXgYQqKeWrq
         2sXV8sQBhBL+5XnYy+eiTxJUGxP0GAIrVTcb7BGWU2KaWHdownIovBP7Z9Wuw1F3OVzU
         gDHmxYjxn7kBxQ/VgnwX8HsyvbPh7Sz43E5t4n3i797zdExOfeRysdyB+4nuT+Tddud7
         N9Uto9ubjsUuaWupRfjABS0I4E+Sd3Iz3OnWAnOSGB51/Dh0Yjzacr1t74ZrzionEHfF
         ygSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1BakbJMpJu1z3wUUjLEFYkASKAklIwzLEuraEu9HYtMWcjO1U1oR5VU8+UrtjKQlEIs5fjbctXVFSAn1w@vger.kernel.org, AJvYcCWOmkPWG6rpZzTWAYY7dnU0e5bspq9ZjYHfePSUyPXJAGuK1lriMFE8yf2R35BPkwcL1vU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaQv0NS5w9F0nA4/NCA0Lr/HZUqjBAVNsPhcKH+cfv9g7fNHjD
	ZkfA/feRiEqhnVFVOzmZoxRK+UgYS9SMAqVBz4+fjD1D4H/z6B17wv5n
X-Gm-Gg: ASbGnctP0/C6mNHqI11rGO5WSz0VM7uePizJT5HPSgJ9g9t+omOTkEhJOOOguCqVX9F
	SKK0CL5+KZOB9z46MVR/S2uUBEuI2M0jh+Hjs3yI4qUF19VoOqvXY5YVNRYp8ZVtHaBeLMIb8Yo
	zEUaBNC7rC7KcOP/AshlrVRId6zSrd/lx5kjD0fFN2p7S0GkodxgL+B2YVo2uBrA7kgC2h8eGjf
	HLLNbDhPFls6MYagcUxKjeXXqPpoTigNJmVlmlrGda9cdAue8wxtCTDHeHt7AG4ZPWT9ar+JtX4
	6yr3BWkmOnxymbyv/dwTb76xKrcWcjd+PSn3y5/Ka7rKYT9Vxj1rn8RLnB9t+lbcq75ltdTBKIH
	hALXg5Km3XfTl6Jy84NE0aNz50godseWmpfCKHqS4X/rk6BUFE42AtjlgVz1N+JMxm1PZ/A==
X-Google-Smtp-Source: AGHT+IH9596AlMlifeMZTXGzaSdRIMkbnWhJ7RJVTh9YxLnayJSOqQNQQXzfDlMxHJ5Zibiiwpc5IQ==
X-Received: by 2002:a05:620a:3948:b0:7cd:2857:331c with SMTP id af79cd13be357-7d3f99391b4mr1451307585a.42.1750651482134;
        Sun, 22 Jun 2025 21:04:42 -0700 (PDT)
Received: from lima-default.. (pool-108-50-252-180.nwrknj.fios.verizon.net. [108.50.252.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99fc0a8sm347274385a.80.2025.06.22.21.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 21:04:41 -0700 (PDT)
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
Subject: [PATCH v3 1/2] bpf, verifier: Improve precision for BPF_ADD and BPF_SUB
Date: Mon, 23 Jun 2025 00:03:56 -0400
Message-ID: <20250623040359.343235-2-harishankar.vishwanathan@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250623040359.343235-1-harishankar.vishwanathan@gmail.com>
References: <20250623040359.343235-1-harishankar.vishwanathan@gmail.com>
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
verifier.

The current implementation of scalar_min_max_add() sets r3's bounds to
[0, U64_MAX] at instruction 5: (0f) r3 += r3, due to conservative
overflow handling.

0: R1=ctx() R10=fp0
0: (b7) r4 = 0                        ; R4_w=0
1: (87) r4 = -r4                      ; R4_w=scalar()
2: (18) r3 = 0xa000000000000000       ; R3_w=0xa000000000000000
4: (4f) r3 |= r4                      ; R3_w=scalar(smin=0xa000000000000000,smax=-1,umin=0xa000000000000000,var_off=(0xa000000000000000; 0x5fffffffffffffff)) R4_w=scalar()
5: (0f) r3 += r3                      ; R3_w=scalar()
6: (b7) r0 = 1                        ; R0_w=1
7: (95) exit

With our patch, r3's bounds after instruction 5 are set to a much more
precise [0x4000000000000000,0xfffffffffffffffe].

...
5: (0f) r3 += r3                      ; R3_w=scalar(umin=0x4000000000000000,umax=0xfffffffffffffffe)
6: (b7) r0 = 1                        ; R0_w=1
7: (95) exit

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


