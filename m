Return-Path: <bpf+bounces-60244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7E3AD45BF
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 00:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C1C3A6A2C
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 22:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54228286D6F;
	Tue, 10 Jun 2025 22:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyX8ya1W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CB023BCF8;
	Tue, 10 Jun 2025 22:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593663; cv=none; b=AJrCyEh53QSsxBPY9c461W3qWkZwEMfSDHztZU8TQCzeDSEg6Arbv6eLoQQY5UabSJTR1+9dWGqnyr1nU892U9PjL/PhCXJvLOcW9AxHqhuYVURQty/K+pSfQgYWnsYCYtHBUS4NhS10TP0quYqn447HmvJWx6qWG54CsQDk3uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593663; c=relaxed/simple;
	bh=BqH0jeaVcddxfW6lzck44+81m8b1q5PFEjC7k33RKY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NRfOCSB0TjVW8rXJxNVkdTcjJSjUTSl2Mvib1cz5vPzH74+Iodv2dlmEYzR+6bzXoKap9wFCZEL2vF+FubwxPyJgsG/r2sMIJrmMHex4QN1ZWzvzBSqoy3cjrNXUSL3vNwj8WNWNq86pltRiQ+HKEc/OVAGZif99m2UthzfMNf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyX8ya1W; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d21f21baf7so548857485a.0;
        Tue, 10 Jun 2025 15:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749593661; x=1750198461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u6nopEVPr3EY6bCPijItVK8Iof7Knl1yArPRPpKU53M=;
        b=eyX8ya1WUXNktRd87u1UqMu9NiyTJQsSw2/Ass2qWaWPMTvcvoMwlL6v+vqoAWkGSu
         gVnmEsB40fuUsQrzGweFc7gOImwmjMtCzxWp8D1cKeDMavDAjZl2fV14f5RtQgk9WTex
         25wo1X6tX0vOer1aM2azm5GZxE2U20SnMrT0/ZgCcGyHmlpKCIsCPW+4IHMj92UFbhoK
         3HNOxEJkHwbmR/mO8+L7r/MxwFub9t2g7I3mVTO7q3E+w77nzEpcoSdLiSAsZuGFjXWL
         21sc1+jrm/T+j+QZlQLpsP0Mq6S6kyXkODgiqg+ozWcj7GEojLNm86k6jnCaonUqc3wn
         BpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749593661; x=1750198461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6nopEVPr3EY6bCPijItVK8Iof7Knl1yArPRPpKU53M=;
        b=XTe6AE7VU7mQ6SPqZwLZIVRGCO1HG/Ykj175f351nqlrqZ7JZF8onH6PumCoN5CNz6
         MLOFKme/s3wD8DMI8ZVKzEBRrMB2v4E5gUiQ+AIjTJwEL9XFOZyypUYxhtg9E8ciuYXE
         6502vIdWS/EdLXdNiPEH+GyMmQHS2eyrtgCYvIqbNup3ewIzL6OYLj9FcDsfuZyJ1Ldj
         2bep/H6Cm5qOVcKOvlUH1BlUSzCulxTIPr6L/MytciIqOgiBaFkiOPMeV8bpybI9yf7j
         DJLNPvs+Z60D+WinZQFe4+5EKnUuVDhUktSpBTZ/HLHmIg6zoXWBVS81OnA/AC22Muec
         uVbw==
X-Forwarded-Encrypted: i=1; AJvYcCUA1FBpfF9tpysdf+EAuUpBB0huAR7lPaLYM2Px6Ggi0p4pbwhSXPkGziIl+sjJiKsnepc=@vger.kernel.org, AJvYcCXWO8uRtJGRLTI0B0HQM8feYOi/M7DyIA5DRWyGz2jVyVV+pR61cXkzyNC0BVdoQ8Zvy1DpzeooMTVLk8aX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ZNhc02YmVhT0Pxt1tHnH+xeTx8b042uVu/Zyf/9/EuzeMFZD
	VqqmsZ/j+I7wjJGstGQskf+qCtE2mZNLPVoQe0JOSNmS5Nh6OP2GfZCTDyTmijQn
X-Gm-Gg: ASbGncuR6qlfPZJjIU5RcXhu8obfJEZUCgqAJnQ+OxWyrCqOMSwBNN4NIZdrgopZsUk
	Sa98dJBvaY3ocYb3fiROoaqEt6oCO7jlx/LAS6PuoP2GthGCPHVq1s+ZsoBrnHaKyI3u6i8/hW/
	S7itQim7Jrs46+p0Yg/7MyKigZ3yiN/ssl3VQv9flmShaj6R1TsDwkCOwsaQXRxJMRy9yffVjgP
	ogdcQQ5xRG94hd9Qhw0wa6A8gzaDdLgl0eXpZQd12yAhJ8Y2i5cLu8hOJLQX+s+GdiEjaHM21Ix
	QQkKin/x0IY0DMHjChxFF6ErxBeYc+5mE+cufe9rsCLjIq1VJtuMhShL2c7MZYEZT3pKwpqJmEr
	HrypV/gNsMOJYDQa4Tkz6Aj88qnfatP/dIm0ALN/uh7iPmVKCeIb6BoatwYVWENpjuo63Qw==
X-Google-Smtp-Source: AGHT+IESddxOnfayiMA7LJuHgmcjnJBJlJHAC5n/AyxYWchuJYsbO7V9zbu1iHdkSwa2Biy6CeQuHw==
X-Received: by 2002:a05:620a:1a82:b0:7d2:1158:6540 with SMTP id af79cd13be357-7d3a883e696mr160450485a.21.1749593660826;
        Tue, 10 Jun 2025 15:14:20 -0700 (PDT)
Received: from lima-default.. (pool-108-50-252-180.nwrknj.fios.verizon.net. [108.50.252.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d38d2a5531sm503873185a.21.2025.06.10.15.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 15:14:20 -0700 (PDT)
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
To: ast@kernel.org
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Matan Shachnai <m.shachnai@rutgers.edu>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>,
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
Subject: [PATCH] bpf, verifier: Improve precision for BPF_ADD and BPF_SUB
Date: Tue, 10 Jun 2025 18:13:55 -0400
Message-ID: <20250610221356.2663491-1-harishankar.vishwanathan@gmail.com>
X-Mailer: git-send-email 2.45.2
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
verifier. Before instruction 6, register r3 has bounds
[0x8000000000000000, U64_MAX].

The current implementation sets r3's bounds to [0, U64_MAX] after
instruction r3 += r3, due to conservative overflow handling.

0: R1=ctx() R10=fp0
0: (18) r3 = 0x8000000000000000       ; R3_w=0x8000000000000000
2: (18) r4 = 0x0                      ; R4_w=0
4: (87) r4 = -r4                      ; R4_w=scalar()
5: (4f) r3 |= r4                      ; R3_w=scalar(smax=-1,umin=0x8000000000000000,var_off=(0x8000000000000000; 0x7fffffffffffffff)) R4_w=scalar()
6: (0f) r3 += r3                      ; R3_w=scalar()
7: (b7) r0 = 1                        ; R0_w=1
8: (95) exit

With our patch, r3's bounds after instruction 6 are set to a more precise
[0, 0xfffffffffffffffe].

...
6: (0f) r3 += r3                      ; R3_w=scalar(umax=0xfffffffffffffffe)
7: (b7) r0 = 1                        ; R0_w=1
8: (95) exit

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
index b1f797616f20..b4909b9cfc9f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14553,14 +14553,25 @@ static void scalar32_min_max_add(struct bpf_reg_state *dst_reg,
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
@@ -14573,14 +14584,25 @@ static void scalar_min_max_add(struct bpf_reg_state *dst_reg,
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
@@ -14591,8 +14613,11 @@ static void scalar32_min_max_sub(struct bpf_reg_state *dst_reg,
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
@@ -14600,14 +14625,18 @@ static void scalar32_min_max_sub(struct bpf_reg_state *dst_reg,
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
 
@@ -14616,8 +14645,11 @@ static void scalar_min_max_sub(struct bpf_reg_state *dst_reg,
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
@@ -14625,14 +14657,18 @@ static void scalar_min_max_sub(struct bpf_reg_state *dst_reg,
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


