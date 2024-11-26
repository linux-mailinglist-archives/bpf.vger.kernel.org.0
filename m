Return-Path: <bpf+bounces-45631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA27F9D9CB8
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 18:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C0B167C46
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 17:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001BD1DB37A;
	Tue, 26 Nov 2024 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am/I0vO7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8781CEE9B;
	Tue, 26 Nov 2024 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732642786; cv=none; b=t/9KeF6jBss0EouK0DcYeHbXL7045ECu6BlcbeYkKow2nzHKe7+7/7fBhYnUdGH5e4xfaUVm0IE8H2J7bXKt3bznWVW+NgmcG/G4l+tG2JX2SreJ4llodbU9x2jAHw2qIWeaSTiVVgbOwLHQDKA4Ejd7gx/IeYvwYFW1N1xLujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732642786; c=relaxed/simple;
	bh=XvL33wYrLJctvq+rtELeVqyu2cYPnyOESVDz2V6Sq0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eighs4Dx4TA/Gf9nDT2Sr3vVZ8M9ekv/LEu/ZrvTFfODhWa7BsLMIPcBZ8iI9PGLq1cWfsHQwjijp33eYnYDJY2KYsOHfZY03uncu/zyw+HvpixeUZR/Qio9gerfr2z/WSv3heluvLPWdPjP4j0vz6j+gyb2hvOKO4NU7b3T8vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Am/I0vO7; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d41dbf6cfbso44335576d6.3;
        Tue, 26 Nov 2024 09:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732642783; x=1733247583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tZz8BIWiBCDGwfxMrWmOOQtjQ9sxBN7OfQRH+DijiqM=;
        b=Am/I0vO7nMT6WbxWgNiIUUiooGcIsNjxho32xOhhkxtlKDGf+DaVL0PTNlNMWMzSkU
         2+OrSH8FE+z6v1wZCnMGSE1mhrbDRJLG/Sly7Vo+p1GiEhUlvRH5FTwfpa8L003htDHU
         SLuZ+kK4/mZx0QvEr9bnrrvy7c5Cwyo1P9QRaYsauvgRG/TDOu2LD6qhRsVKZuBqJ9GJ
         ECx3sy4BDHYY9AFmlyZ2PDvj2BzS4sS+ZRO5TCXlQBh+ufZ7fcUZT60ahJnDFg7xHOmV
         /2g9CdMTtea+nzxRPBPNyqOqfS+75RYQpHjb8AReGi4iIjPhT4x9OI4yob0Ej2y6p0ep
         8GWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732642783; x=1733247583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZz8BIWiBCDGwfxMrWmOOQtjQ9sxBN7OfQRH+DijiqM=;
        b=duHK4gGK/c59T0XhLqpIRB2VWfo1jSnU0/szv9wm0BPT8Xx2O2JI021tq3Mjrw2xJv
         Pwj1zTdBwy75KJPtXjyWGNWB6SjrXCALi8EVObsorzRMryFh04T1hinKbENVDgbUDamX
         zUJNjnRrmIHBOGTLE/WeeduTAosOYQsSh2lVhdesQBrxjealsJ7ToHgzcGLDMtJlqrPW
         6LmDfwb0mCvtz/AxbGWymfb1czPOI6adbMlpL/N6ewscuEYJ+vknlyRqoYD+zRqX8S6Y
         nC4yXBqWC5Mu2+B093eBzKIm9u0Y2aeXCGuKuNL/LTZPrYLv6l/sAUxxLWdY9eCi12ZV
         /2iw==
X-Forwarded-Encrypted: i=1; AJvYcCVJl6Cwa7PPFC+3AWztc56XK9gHinzMTRTN2CX/MabMqm7rPyAqVGNYyQKFwvOot6eDSk4=@vger.kernel.org, AJvYcCWdQno0t5clq1GClc/LBPycAl0wzZ1kvjSWPxkmUwvAoIuv/vAh8JiZCqlPcCirEnSSUubrwMNQ8UYgoIbe@vger.kernel.org
X-Gm-Message-State: AOJu0YwqqxWiCjh0A35VWd4oJR1HFqELa/U9dHG66lpI5TTYSD6/pGVL
	z0FuIdyDM8mc1JZ1N+f7iTB2o6De4Rdi3PUqWR4F47MzatteBcPA
X-Gm-Gg: ASbGnctYyXlUHKsNqze8zl4dqU543YnOROuET6+Bustc4v6f4JAVoWfaSOcAISq+wOM
	R+VQRv+UkXgT7RrZZg2A1uh7fuh3YOZYFmNTbuun3dpKv4Tk/oP9LnLslB6TAby1KuE333G2AJ3
	Mu1qORqqXPdzzaHg7FqL+TC0tHfXQWPbVuoyZqHQVi41vi+WmP5lZhGtLa7v9A1H6sGts5K3Tec
	Q8+HrwEqVVM/q2qafOA3xhlYfGy7y9XBEo2Ij0tewzycyXLZXqV7/FJkuGQTekENWw8NjI8w6pV
	RlHiu2MnaoL0mA4po0UB9vgGoSg=
X-Google-Smtp-Source: AGHT+IEEaqWvwVL5esJWhQolAfKBcn2hYSal6WKY9t7lrnvufkZQFIKC3Is2Ec3iyANHj9q3ASxZkg==
X-Received: by 2002:ad4:5cc2:0:b0:6d4:25c4:e772 with SMTP id 6a1803df08f44-6d451344cbdmr314281526d6.36.1732642783259;
        Tue, 26 Nov 2024 09:39:43 -0800 (PST)
Received: from Matan-Desktop.localdomain (ool-457a37de.dyn.optonline.net. [69.122.55.222])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6d451b259e9sm57990586d6.93.2024.11.26.09.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 09:39:42 -0800 (PST)
From: Matan Shachnai <m.shachnai@gmail.com>
X-Google-Original-From: Matan Shachnai <m.shachnai@rutgers.edu>
To: ast@kernel.org
Cc: Matan Shachnai <m.shachnai@rutgers.edu>,
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
Subject: [PATCH] bpf, verifier: Improve precision of BPF_MUL
Date: Tue, 26 Nov 2024 12:38:43 -0500
Message-Id: <20241126173844.29680-1-m.shachnai@rutgers.edu>
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

As it stands,BPF_MUL is composed of three functions:

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
Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
---
 kernel/bpf/verifier.c | 72 +++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 48 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c4ebb326785..172816e8f1a4 100644
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
+	dst_reg->smin_value = S32_MIN;
+	dst_reg->smax_value = S32_MAX;
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


