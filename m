Return-Path: <bpf+bounces-45694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B08199DA33F
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 08:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71125283C03
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 07:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09801547E7;
	Wed, 27 Nov 2024 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJVT7awu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9595A146A87;
	Wed, 27 Nov 2024 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732693329; cv=none; b=OVAH4my5cejUbujoE2Y0rM33Ygawc6ADC3H59PInIkpI8i+GELOs8UYaSyPVfByJkzjCQQWVSSF1mLM/agwKaOkmQTIOX4zHlu//iuN6a/2RpxLNGWvMGm+5yp5piWlEKL7JSh3cZG7elkumPrRsRL4003jHjli2IqZeVFSv+ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732693329; c=relaxed/simple;
	bh=n2ttvNoV1XL707it2hYYq89Nyv4j83JCIIFJHKcj4VE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IaVKAAxlrpb/V7cbxLgnFJI6WZ8rZcPIn7Pv9baRRrIF0aSxfDDl6OKWsCC1Ia8DLt5vHWrXINfqC2gnoVrDVUxGeEl40uZi+4//4rYmRa7TefRGbuxBrJl4ZvGyP0fj2KtsXEpnhQBKe0MnunLSc73KLFjypA3KY/iQjYuJRgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJVT7awu; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d41f721047so46796146d6.1;
        Tue, 26 Nov 2024 23:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732693326; x=1733298126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pUeFWqsXwpt4WTXkPzNXsf4Gi9tVXueAa/I+0CZw2Bo=;
        b=JJVT7awuD8jCpy4jlIJtqfusJqo9NdDrpLub92Z5LHh7VWpm7RWSwgkbqzIvsXedZC
         0wFRi9EK7AaW1vyKxSB91FWbNXJ/qW9lpw52kbxh7c0NQiy4DzbjhgnB6gMUUINbgstX
         cfkZk44rlm+RNGSSjjNgsB9Sh3Ldp1dXI0cmZkfR3kbb0Qt8+lskEQKIEEwiLhx2HXZv
         DQeAffe/FBSjR+6AOAIi4gQN7CzlfT9flJX0zBvX7+8na5ctUNqdB0flTbON3NCOPZuh
         XnvQQA+j0qxDFI3TjW5awheqQYUVbZqSkYPPS2GuCGeSRPh+SlDQLS4kLUGHiQKOnHFO
         WhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732693326; x=1733298126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUeFWqsXwpt4WTXkPzNXsf4Gi9tVXueAa/I+0CZw2Bo=;
        b=eyTc3Ge9fB/sC9KhBNQfI8QvOcaIQ+jNZqeF/IUAqQr1/LADr3yDXInD4gIym+ej59
         ZI3UvcCzMW4Z5bHV9Bs3l1ctzJOtiIRM28TQRgwSlkcSln4IRnVmQ39WsrasToINtZCs
         dox7JXQ837vh3XRCkTuQmkIO55hlQ4Zu3qBAg/QH9TNcU5cB8PUHQ6DQePFnxcWDA/Dc
         r4jVQwpDkNYDGeuTuIaQryHvAHyFjdSgaqyzIs3k8B9C3XcLHZzrswR7AwAVsehS4649
         J2V/DuCfhGI7GquOn/Vr+TkZH7rO1X9ymkybGKJ2i/3TaYXKO7M1GboL5wfOMShrUVZB
         9rNA==
X-Forwarded-Encrypted: i=1; AJvYcCWrNOr7mkRhcxrMsdHf1vQceEg1392Ai50er2We7RVDGq93USC4PSICndcguW+yX2kw2QvuwR9Ze5kRdvd2@vger.kernel.org, AJvYcCXBVuim0bKJnHxgKw3aB82j1Sa5Tp5TKnS9qwu5VnihVvHEVLlAlrsWxubhEL5devrqlzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp8iJXMZdD/8MWfKfjFp3Izb4WhIXt0s2spogbuXbeKnXGynZG
	LtnIv00qcmTJp6NVA75r2E++C1wH/yJp2bA7k7wF/5/i8vGCgetV
X-Gm-Gg: ASbGncsuJuYl7VVud++SxqdFMEfyxf27MD6XoesirJI6hD8mZ3Q0DWtvsavb/LOm9Un
	rZzJoDr3axtbHRq3kgAJYSHmdzH5Q2syQvb1/e5yC/VoajQZvlR7/8iQRq7G5d1xl4lMeIwDgVU
	5MkjNBDf9rpAwZM9+7d4e2ax7NQF8H0oh+N+eLo1Vpv5RCisAfJRHAq1xTK4QmKhYO4L0p36Rgm
	HEjU7RnCHuVsEPC77Ez/ZfMhpi+8HHChEE47ZvZKS06VmEeDKQOsOAtR466VXFJT0MJm6RYIULX
	kkjgxYRyPEK4kD74IS1Q/CzZ
X-Google-Smtp-Source: AGHT+IEq2gw3b+WLjB/Mh1kpHvZvn5Y0StozzJBewkPMWhxJt8+Y+qhqDWkoXtDvVsq8bPB+0zGnHg==
X-Received: by 2002:a05:6214:2405:b0:6d4:2806:1764 with SMTP id 6a1803df08f44-6d864e02367mr29558286d6.43.1732693326289;
        Tue, 26 Nov 2024 23:42:06 -0800 (PST)
Received: from Matan-Desktop.localdomain (ool-457a37de.dyn.optonline.net. [69.122.55.222])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6d451ab42cdsm63119906d6.55.2024.11.26.23.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 23:42:05 -0800 (PST)
From: Matan Shachnai <m.shachnai@gmail.com>
To: ast@kernel.org
Cc: Matan Shachnai <m.shachnai@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
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
Subject: [PATCH v2] bpf, verifier: Improve precision of BPF_MUL
Date: Wed, 27 Nov 2024 02:41:56 -0500
Message-Id: <20241127074156.17567-1-m.shachnai@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch improves (or maintains) the precision of register value tracking
in BPF_MUL across all possible inputs. It also simplifies
scalar32_min_max_mul() and scalar_min_max_mul().

As it stands, BPF_MUL is composed of three functions:

case BPF_MUL:
  tnum_mul();
  scalar32_min_max_mul();
  scalar_min_max_mul();

The current implementation of scalar_min_max_mul() restricts the u64 input
ranges of dst_reg and src_reg to be within [0, U32_MAX]:

    /* Both values are positive, so we can work with unsigned and
     * copy the result to signed (unless it exceeds S64_MAX).
     */
    if (umax_val > U32_MAX || dst_reg->umax_value > U32_MAX) {
        /* Potential overflow, we know nothing */
        __mark_reg64_unbounded(dst_reg);
        return;
    }

This restriction is done to avoid unsigned overflow, which could otherwise
wrap the result around 0, and leave an unsound output where umin > umax. We
also observe that limiting these u64 input ranges to [0, U32_MAX] leads to
a loss of precision. Consider the case where the u64 bounds of dst_reg are
[0, 2^34] and the u64 bounds of src_reg are [0, 2^2]. While the
multiplication of these two bounds doesn't overflow and is sound [0, 2^36],
the current scalar_min_max_mul() would set the entire register state to
unbounded.

The key idea of our patch is that if there’s no possibility of overflow, we
can multiply the unsigned bounds; otherwise, we set the 64-bit bounds to
[0, U64_MAX], marking them as unbounded.

if (check_mul_overflow(*dst_umax, src_reg->umax_value, dst_umax) ||
       (check_mul_overflow(*dst_umin, src_reg->umin_value, dst_umin))) {
        /* Overflow possible, we know nothing */
        dst_reg->umin_value = 0;
        dst_reg->umax_value = U64_MAX;
    }
  ...

Now, to update the signed bounds based on the unsigned bounds, we need to
ensure that the unsigned bounds don't cross the signed boundary (i.e., if
((s64)reg->umin_value <= (s64)reg->umax_value)). We observe that this is
done anyway by __reg_deduce_bounds later, so we can just set signed bounds
to unbounded [S64_MIN, S64_MAX]. Deferring the assignment of s64 bounds to
reg_bounds_sync removes the current redundancy in scalar_min_max_mul(),
which currently sets the s64 bounds based on the u64 bounds only in the
case where umin <= umax <= 2^(63)-1.

Below, we provide an example BPF program (below) that exhibits the
imprecision in the current BPF_MUL, where the outputs are all unbounded. In
contrast, the updated BPF_MUL produces a bounded register state:

BPF_LD_IMM64(BPF_REG_1, 11),
BPF_LD_IMM64(BPF_REG_2, 4503599627370624),
BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
BPF_LD_IMM64(BPF_REG_3, 809591906117232263),
BPF_ALU64_REG(BPF_MUL, BPF_REG_3, BPF_REG_1),
BPF_MOV64_IMM(BPF_REG_0, 1),
BPF_EXIT_INSN(),

Verifier log using the old BPF_MUL:

func#0 @0
0: R1=ctx() R10=fp0
0: (18) r1 = 0xb                      ; R1_w=11
2: (18) r2 = 0x10000000000080         ; R2_w=0x10000000000080
4: (87) r2 = -r2                      ; R2_w=scalar()
5: (87) r2 = -r2                      ; R2_w=scalar()
6: (5f) r1 &= r2                      ; R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=11,var_off=(0x0; 0xb)) R2_w=scalar()
7: (18) r3 = 0xb3c3f8c99262687        ; R3_w=0xb3c3f8c99262687
9: (2f) r3 *= r1                      ; R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=11,var_off=(0x0; 0xb)) R3_w=scalar()
...

Verifier using the new updated BPF_MUL (more precise bounds at label 9)

func#0 @0
0: R1=ctx() R10=fp0
0: (18) r1 = 0xb                      ; R1_w=11
2: (18) r2 = 0x10000000000080         ; R2_w=0x10000000000080
4: (87) r2 = -r2                      ; R2_w=scalar()
5: (87) r2 = -r2                      ; R2_w=scalar()
6: (5f) r1 &= r2                      ; R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=11,var_off=(0x0; 0xb)) R2_w=scalar()
7: (18) r3 = 0xb3c3f8c99262687        ; R3_w=0xb3c3f8c99262687
9: (2f) r3 *= r1                      ; R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=11,var_off=(0x0; 0xb)) R3_w=scalar(smin=0,smax=umax=0x7b96bb0a94a3a7cd,var_off=(0x0; 0x7fffffffffffffff))
...

Finally, we proved the soundness of the new scalar_min_max_mul() and
scalar32_min_max_mul() functions. Typically, multiplication operations are
expensive to check with bitvector-based solvers. We were able to prove the
soundness of these functions using Non-Linear Integer Arithmetic (NIA)
theory. Additionally, using Agni [2,3], we obtained the encodings for
scalar32_min_max_mul() and scalar_min_max_mul() in bitvector theory, and
were able to prove their soundness using 16-bit bitvectors (instead of
64-bit bitvectors that the functions actually use).

In conclusion, with this patch,

1. We were able to show that we can improve the overall precision of
   BPF_MUL. We proved (using an SMT solver) that this new version of
   BPF_MUL is at least as precise as the current version for all inputs.

2. We are able to prove the soundness of the new scalar_min_max_mul() and
   scalar32_min_max_mul(). By leveraging the existing proof of tnum_mul
   [1], we can say that the composition of these three functions within
   BPF_MUL is sound.

[1] https://ieeexplore.ieee.org/abstract/document/9741267
[2] https://link.springer.com/chapter/10.1007/978-3-031-37709-9_12
[3] https://people.cs.rutgers.edu/~sn349/papers/sas24-preprint.pdf

Co-developed-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Matan Shachnai <m.shachnai@gmail.com>
---
 kernel/bpf/verifier.c | 72 +++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 48 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c4ebb326785..4785f3fac70a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13827,65 +13827,41 @@ static void scalar_min_max_sub(struct bpf_reg_state *dst_reg,
 static void scalar32_min_max_mul(struct bpf_reg_state *dst_reg,
 				 struct bpf_reg_state *src_reg)
 {
-	s32 smin_val = src_reg->s32_min_value;
-	u32 umin_val = src_reg->u32_min_value;
-	u32 umax_val = src_reg->u32_max_value;
+	u32 *dst_umin = &dst_reg->u32_min_value;
+	u32 *dst_umax = &dst_reg->u32_max_value;
 
-	if (smin_val < 0 || dst_reg->s32_min_value < 0) {
-		/* Ain't nobody got time to multiply that sign */
-		__mark_reg32_unbounded(dst_reg);
-		return;
-	}
-	/* Both values are positive, so we can work with unsigned and
-	 * copy the result to signed (unless it exceeds S32_MAX).
-	 */
-	if (umax_val > U16_MAX || dst_reg->u32_max_value > U16_MAX) {
-		/* Potential overflow, we know nothing */
-		__mark_reg32_unbounded(dst_reg);
-		return;
-	}
-	dst_reg->u32_min_value *= umin_val;
-	dst_reg->u32_max_value *= umax_val;
-	if (dst_reg->u32_max_value > S32_MAX) {
+	if (check_mul_overflow(*dst_umax, src_reg->u32_max_value, dst_umax) ||
+	    check_mul_overflow(*dst_umin, src_reg->u32_min_value, dst_umin)) {
 		/* Overflow possible, we know nothing */
-		dst_reg->s32_min_value = S32_MIN;
-		dst_reg->s32_max_value = S32_MAX;
-	} else {
-		dst_reg->s32_min_value = dst_reg->u32_min_value;
-		dst_reg->s32_max_value = dst_reg->u32_max_value;
+		dst_reg->u32_min_value = 0;
+		dst_reg->u32_max_value = U32_MAX;
 	}
+
+	/* Set signed bounds to unbounded and improve precision in
+	 * reg_bounds_sync()
+	 */
+	dst_reg->s32_min_value = S32_MIN;
+	dst_reg->s32_max_value = S32_MAX;
 }
 
 static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
 			       struct bpf_reg_state *src_reg)
 {
-	s64 smin_val = src_reg->smin_value;
-	u64 umin_val = src_reg->umin_value;
-	u64 umax_val = src_reg->umax_value;
+	u64 *dst_umin = &dst_reg->umin_value;
+	u64 *dst_umax = &dst_reg->umax_value;
 
-	if (smin_val < 0 || dst_reg->smin_value < 0) {
-		/* Ain't nobody got time to multiply that sign */
-		__mark_reg64_unbounded(dst_reg);
-		return;
-	}
-	/* Both values are positive, so we can work with unsigned and
-	 * copy the result to signed (unless it exceeds S64_MAX).
-	 */
-	if (umax_val > U32_MAX || dst_reg->umax_value > U32_MAX) {
-		/* Potential overflow, we know nothing */
-		__mark_reg64_unbounded(dst_reg);
-		return;
-	}
-	dst_reg->umin_value *= umin_val;
-	dst_reg->umax_value *= umax_val;
-	if (dst_reg->umax_value > S64_MAX) {
+	if (check_mul_overflow(*dst_umax, src_reg->umax_value, dst_umax) ||
+	    check_mul_overflow(*dst_umin, src_reg->umin_value, dst_umin)) {
 		/* Overflow possible, we know nothing */
-		dst_reg->smin_value = S64_MIN;
-		dst_reg->smax_value = S64_MAX;
-	} else {
-		dst_reg->smin_value = dst_reg->umin_value;
-		dst_reg->smax_value = dst_reg->umax_value;
+		dst_reg->umin_value = 0;
+		dst_reg->umax_value = U64_MAX;
 	}
+
+	/* Set signed bounds to unbounded and improve precision in
+	 * reg_bounds_sync()
+	 */
+	dst_reg->smin_value = S64_MIN;
+	dst_reg->smax_value = S64_MAX;
 }
 
 static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
-- 
2.25.1


