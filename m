Return-Path: <bpf+bounces-45170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0819D2509
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 12:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453451F25526
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 11:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10A11C9EC6;
	Tue, 19 Nov 2024 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fLPZu+eI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B551C07C2
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016442; cv=none; b=seaxtnUdS0t8qT/M+JBLbG8vSqE3Yw3sDZJpTvLQTZbCjQyt9Uu/Au9Dd6ub5Hs3DLEcpJa33ra8LO9WS/u/cWPky0WyG39akIoqFnfEp/AZ8tzcuK9aOEQN7rsdh8KvtWoJn+oUXp/k0cvBYTALOwWPv6idoNxsXPJi+XVw974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016442; c=relaxed/simple;
	bh=tqtX6iqF5s2MOzO/M1nG7GkJ4rUrQzkKhLScK4zYCE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLGzQ9j8NbKiLFThgtOuXyJVTXQVKCURD0CMtantT+EpBqieU/f93dFpu88FSZY6Joo9m2b/SfIZRWP2LyZ2tzngc3ojuEpzhwkrhxMyvuXh1kv2sLpdxtVSHbteb7AodRBK3hGZOukOz2elQA5JyRpZ9YtRM2WVbkaSdZHvLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fLPZu+eI; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-53da2140769so3247840e87.3
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 03:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732016437; x=1732621237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4g8dfgAtwv9ZrTE8q0yVwxbw5YGK0iVPTEw9OeOCTpw=;
        b=fLPZu+eIonq7vfqsN7fV+2dRmRw2DXSjk6MgsipYVcOkKrRhpzne+L3+rTjHKf1AEp
         wCVmlxR52qnf3QzgW1gbgUeOIBGQzkQvw2SoE02CTdf82LLakPYbtuvsxxefXi9n/BC3
         6f1SaOdYrf73c+pin9zUea99nBmTR4nIwL6PXVxZrEp3h+/SQKLeQdTuinhivEdVp4Bg
         nyCZw/5PDjaxtCf+G5/QBUJIAnYPhWfUMaEkt0UOFOznHSp5ofLEJQ6ivl1tfwaj2SUE
         3UHhiA9aAsTpHTLywku08vMUYHi13V8KCwnsQie8tN6VcyqOslJU5HJn7QKQcqyhNwaK
         03OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732016437; x=1732621237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4g8dfgAtwv9ZrTE8q0yVwxbw5YGK0iVPTEw9OeOCTpw=;
        b=uPBbu6/p6gtqMcfV1FR9LJcxgUgSrKBq4Fh4yDqbT+rzMkppFGMldItln445+dabIr
         1416mLQD8/VtC0Q9OzxDi/IHAYm4/68f4Yo0aKaKY+PdhcDbATnSvPENhDdPC2OjMtZh
         neuSQ2/erwGaKjpGbPmXBEay0+hH7TQLEWv9X7szqyRn7pj/h2jPEPC23cBKwHKUNJ7Q
         CYnxRh3WTy4N+lHdfMVxDEAkAkpB4acfrkwC3/uePXnUQtEh8LhjldSV+1VxvEqCCnC4
         2XELemtm+/K2LXYJGjx6kcgMafMmK00eSKy6f4GQkXlqO3ksB6McS6ldMF+bdQXuWVqW
         893w==
X-Gm-Message-State: AOJu0YyBnZ5UcLK3YUvrg25PRlCmCZrnXYWZI1x2C1FBd20fUe1an7Uq
	B50O22lb4/4YcNiNQZZE3ABGHDcEx+9wknwfX5EbHirhEo3x3P2Gz5Jgc4eqJGqHr8bmb0SOpy/
	XLtJIIg==
X-Google-Smtp-Source: AGHT+IFv1LDZZsf6itrHW7ToiwvZWwlIgKcfSWZgzUHXfg+VbSYhezMcAH1x1NnQJ/N0oC+DsiqZ0w==
X-Received: by 2002:a05:6512:1294:b0:53d:a86e:4f19 with SMTP id 2adb3069b0e04-53dab2a213cmr5967277e87.25.1732016437199;
        Tue, 19 Nov 2024 03:40:37 -0800 (PST)
Received: from localhost (2001-b011-fa04-f863-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:f863:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f3461fsm72842555ad.154.2024.11.19.03.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:40:35 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [RFC bpf-next v2 1/3] bpf, verifier: improve signed ranges reasoning for BPF_AND
Date: Tue, 19 Nov 2024 19:40:19 +0800
Message-ID: <20241119114023.397450-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119114023.397450-1-shung-hsi.yu@suse.com>
References: <20241119114023.397450-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve BPF verifier's inference of signed ranges. Deduce signed ranges
directly from signed ranges of the operands by doing

    dst_reg->smin_value = negative_bit_floor(min(dst_reg->smin_value, src_reg->smin_value))
    dst_reg->smax_value = max(dst_reg->smax_value, src_reg->smax_value)

See below for the complete explanation. The improvement is needed to prevent
verifier rejection of BPF program like the one presented by Xu Kuohai:

    SEC("lsm/bpf_map")
    int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode)
    {
         if (map != (struct bpf_map *)&data_input)
    	    return 0;

    	 if (fmode & FMODE_WRITE)
    	    return -EACCES;

         return 0;
    }

Where the relevant verifer log upon rejection are:

    ...
    5: (79) r0 = *(u64 *)(r1 +8)          ; R0_w=scalar() R1=ctx()
    ; if (fmode & FMODE_WRITE) @ test_libbpf_get_fd_by_id_opts.c:32
    6: (67) r0 <<= 62                     ; R0_w=scalar(smax=0x4000000000000000,umax=0xc000000000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xc000000000000000))
    7: (c7) r0 s>>= 63                    ; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
    ;  @ test_libbpf_get_fd_by_id_opts.c:0
    8: (57) r0 &= -13                     ; R0_w=scalar(smax=0x7ffffffffffffff3,umax=0xfffffffffffffff3,smax32=0x7ffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))
    9: (95) exit

This sequence of instructions comes from Clang's transformation located in
DAGCombiner::SimplifySelectCC() method, which combined the "fmode &
FMODE_WRITE" check with the return statement without needing BPF_JMP at all.
See Eduard's comment for more detail of this transformation[0].

While the verifier can correctly infer that the value of r0 is in a tight
[-1, 0] range after instruction "r0 s>>= 63", is was not able to come up with a
tight range for "r0 &= -13" (which would be [-13, 0]), and instead inferred a
very loose range [S64_MIN, -13]:

    r0 s>>= 63; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
    r0 &= -13 ; R0_w=scalar(smax=0x7ffffffffffffff3,umax=0xfffffffffffffff3,smax32=0x7ffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))

The reason is that scalar*_min_max_add() mainly relies on tnum for inferring
bounds in register after BPF_AND, however [-1, 0] cannot be tracked precisely
with tnum, and was effectively turns into [0, -1] (i.e. tnum_unknown). So upon
BPF_AND the resulting tnum is equivalent to

    dst_reg->var_off = tnum_and(tnum_unknown, tnum_const(-13))

And from there the BPF verifier was only able to infer smin=S64_MIN and
smax=0x7ffffffffffffff3, which is outside of the allowed [-4095, 0] range for
return values, and thus the program was rejected.

To allow verification of such instruction pattern, update scalar*_min_max_and()
to infer signed ranges directly from signed ranges of the operands.

For BPF_AND, the resulting value always gains more unset '0' bit, thus it only
move towards 0x0000000000000000. The difficulty lies with how to deal with
signs. While non-negative (positive and zero) value simply grows smaller, a
negative number can grows smaller, but may also "underflow" and become a larger
value.

To better address this situation we split the signed ranges into negative range
and non-negative range cases, ignoring the mixed sign cases for now; and only
consider how to calculate smax_value.

Since negative range & negative range preserve the sign bit, so we know the
result is still a negative value, thus it only move towards S64_MIN, but never
underflow, thus a save bet for smax is a value in ranges that is closest to 0,
thus "max(dst_reg->smax_value, src->smax_value)". For negative range &
non-negative range the sign bit is always cleared, thus we know the resulting
value is non-negative, and only moves towards 0, so a safe bet for smax is the
smax_value of the non-negative range. Last but not least, non-negative range &
non-negative range is still a non-negative value, and only moves towards 0;
same as the unsigned range case, the maximum is actually capped by the lesser
of the two, and thus min(dst_reg->smax_value, src_reg->smax_value);

Listing out the above reasoning as a table (dst_reg abbreviated as dst, src_reg
abbreviated as src, smax_value abbrivated as smax) we get:

                        |                         src_reg
       smax = ?         +---------------------------+---------------------------
                        |        negative           |       non-negative
---------+--------------+---------------------------+---------------------------
         | negative     | max(dst->smax, src->smax) |         src->smax
dst_reg  +--------------+---------------------------+---------------------------
         | non-negative |         dst->smax         | min(dst->smax, src->smax)

However this is quite complicated, and could use some simplification given the
following observations:

    max(dst_reg->smax_value, src_reg->smax_value) >= src_reg->smax_value
    max(dst_reg->smax_value, src_reg->smax_value) >= dst_reg->smax_value
    max(dst_reg->smax_value, src_reg->smax_value) >= min(dst_reg->smax_value, src_reg->smax_value)

So we could do a safe substitution replacing all cells of the table above with
max(...), and arrive at:

                        |                         src_reg
      smax' = ?         +---------------------------+---------------------------
  smax'(r) >= smax(r)   |        negative           |       non-negative
---------+--------------+---------------------------+---------------------------
         | negative     | max(dst->smax, src->smax) | max(dst->smax, src->smax)
dst_reg  +--------------+---------------------------+---------------------------
         | non-negative | max(dst->smax, src->smax) | max(dst->smax, src->smax)

Meaning that simply using

    max(dst_reg->smax_value, src_reg->smax_value)

to calculate the resulting smax_value would work across all sign combinations
(while a bit imprecise in certain cases).

For smin_value, we know that both non-negative range & non-negative range and
negative range & non-negative range both result in a non-negative value, so an
easy guess is to use the minimum value in non-negative range, thus 0.

                        |                         src_reg
       smin = ?         +----------------------------+---------------------------
                        |          negative          |       non-negative
---------+--------------+----------------------------+---------------------------
         | negative     |             ?              |             0
dst_reg  +--------------+----------------------------+---------------------------
         | non-negative |             0              |             0

That leaves the negative range & negative range case to be considered. We know
that negative range & negative range always yield a negative value, so a
preliminary guess would be S64_MIN. However, that guess is too imprecise to
help with the r0 <<= 62, r0 s>>= 63, r0 &= -13 pattern we're trying to deal
with here.

Further improvement comes with the observation that for negative range &
negative range, the smallest possible value must be one that has longest
_common_ most-significant set '1' bits sequence, thus we can use
min(dst_reg->smin_value, src->smin_value) as the starting point, as the smaller
value will be the one with the shorter most-significant set '1' bits sequence.
But that alone is not enough, as we do not know whether rest of the bits would
be set, so the safest guess would be one that clear alls bits after the
most-significant set '1' bits sequence, something akin to bit_floor(), but for
rounding to a negative power-of-2 instead.

    negative_bit_floor(0xffff000000000003) == 0xffff000000000000
    negative_bit_floor(0xfffffb0000000000) == 0xfffff80000000000
    negative_bit_floor(0xffffffffffffffff) == 0xffffffffffffffff /* -1 remains unchanged */
    negative_bit_floor(0x0000fb0000000000) == 0x0000000000000000 /* non-negative values became 0 */

With negative range & negative range solve, we now have:

                        |                         src_reg
       smin = ?         +----------------------------+---------------------------
                        |        negative            |       non-negative
---------+--------------+----------------------------+---------------------------
         |   negative   |negative_bit_floor(         |             0
         |              |  min(dst->smin, src->smin))|
dst_reg  +--------------+----------------------------+---------------------------
         | non-negative |           0                |             0

This can be also simplified with some observations. (Quadrants refers to the
cells in above table, number start from top-right cell -- I, and goes
counter-clockwise):

  A. min(dst_reg->smin_value, src_reg->smin_value) < 0  /* dst negative & src non-negative, quadrant I */
  B. min(dst_reg->smin_value, src_reg->smin_value) < 0  /* dst non-negative & src negative, quadrant III */
  C. min(dst_reg->smin_value, src_reg->smin_value) >= 0 /* dst non-negative & src non-negative, quadrant IV */

  D. negative_bit_floor(x) s<= x /* for any x, negative_bit_floor(x) is always smaller (or equal to the original value) */
  E. negative_bit_floor(y) == 0  /* when y is non-negative, i.e. y >= 0, since the most-significant is unset, so every bit is unset */

Thus we can derive

    negative_bit_floor(min(dst_reg->smin_value, src_reg->smin_value)) < 0  /* combine A and D, where dst negative & src non-negative */
    negative_bit_floor(min(dst_reg->smin_value, src_reg->smin_value)) < 0  /* combine B and D, where dst non-negative & src negative */
	negative_bit_floor(min(dst_reg->smin_value, src_reg->smin_value)) == 0 /* combine C and E, where dst non-negative & src non-negative */

Substitute quadrants I, III, and IV cells in the table above all with
negative_bit_floor(min(...)), we arrive at:

                        |                         src_reg
       smin' = ?        +----------------------------+---------------------------
  smin'(r) <= smin(r)   |        negative            |       non-negative
---------+--------------+----------------------------+---------------------------
         |   negative   |negative_bit_floor(         |negative_bit_floor(
         |              |  min(dst->smin, src->smin))|  min(dst->smin, src->smin))
dst_reg  +--------------+----------------------------+---------------------------
         | non-negative |negative_bit_floor(         |negative_bit_floor(
         |              |  min(dst->smin, src->smin))|  min(dst->smin, src->smin))

Meaning that simply using

    negative_bit_floor(min(dst_reg->smin_value, src_reg->smin_value))

to calculate the resulting smin_value would work across all sign combinations.

Together these allows us to infer the signed range of the result of BPF_AND
operation using the signed range from its operands. While this also seemingly
removes the propagation of unsigned ranges to signed ranges, such propagation
still happens later within __reg_deduce_bounds(), so there should be no loss of
bound information.

Also, revert changes introduced in commit 229d6db14942 ("selftests/bpf:
Workaround strict bpf_lsm return value check.") previously added to workaround
such verifier rejection.

[0] https://lore.kernel.org/bpf/e62e2971301ca7f2e9eb74fc500c520285cad8f5.camel@gmail.com/

Link: https://lore.kernel.org/bpf/phcqmyzeqrsfzy7sb4rwpluc37hxyz7rcajk2bqw6cjk2x7rt5@m2hl6enudv7d/
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
Tested-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Changes since v1[1,2]
- address comments
  - add code comment in scalar*_min_max_and() to better explaining the
    reasoning (Eduard, Alexei)
  - point out unsigned range are still propagated to signed range later
    in __reg_deduce_bounds() (Edward)
  - point out the fls(~v) special case in negative_bit_floor() (Edward)
- revert workaround added in 229d6db14942

1: https://lore.kernel.org/bpf/20240719110059.797546-6-xukuohai@huaweicloud.com/
2: https://lore.kernel.org/bpf/9505522b-de45-cf52-162b-76a3a52a6efe@gmail.com/
---
 kernel/bpf/verifier.c                         | 105 ++++++++++++++----
 .../bpf/progs/test_libbpf_get_fd_by_id_opts.c |   1 -
 2 files changed, 85 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c4ebb326785..004c4d8e7065 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13888,6 +13888,47 @@ static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
 	}
 }
 
+/* Same as negative_bit_floor() below, but for 32-bit signed value */
+static inline s32 negative32_bit_floor(s32 v)
+{
+	u8 bits = fls(~v); /* find most-significant unset bit */
+	u32 delta;
+
+	/* Special case, see negative_bit_floor() for explanation */
+	if (bits > 31)
+		return 0;
+
+	delta = (1UL << bits) - 1;
+	return ~delta;
+}
+
+/* Clears all trailing bits after the most significant unset bit.
+ *
+ * Used for estimating the minimum possible value after BPF_AND. This
+ * effectively rounds a negative value down to a negative power-of-2 value
+ * (except for -1, which just return -1) and returning 0 for non-negative
+ * values. For example:
+ * - negative_bit_floor(0xffff000000000003) == 0xffff000000000000
+ * - negative_bit_floor(0xfffffb0000000000) == 0xfffff80000000000
+ * - negative_bit_floor(0xffffffffffffffff) == 0xffffffffffffffff
+ * - negative_bit_floor(0x0000fb0000000000) == 0x0000000000000000
+ */
+static inline s64 negative_bit_floor(s64 v)
+{
+	u8 bits = fls64(~v); /* find most-significant unset bit */
+	u64 delta;
+
+	/* Special case. When v is non-negative, ~v have the MSB set, thus
+	 * fls64(~v) = 64. However 1ULL << 64 is undefined, so just return the
+	 * result directly.
+	 */
+	if (bits > 63)
+		return 0;
+
+	delta = (1ULL << bits) - 1;
+	return ~delta;
+}
+
 static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
 				 struct bpf_reg_state *src_reg)
 {
@@ -13906,17 +13947,14 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
 	 */
 	dst_reg->u32_min_value = var32_off.value;
 	dst_reg->u32_max_value = min(dst_reg->u32_max_value, umax_val);
+	/* u32 bounds are propogated into s32 bounds later via __reg_deduce_bounds() */
 
-	/* Safe to set s32 bounds by casting u32 result into s32 when u32
-	 * doesn't cross sign boundary. Otherwise set s32 bounds to unbounded.
+	/* Handle the [-1, 0] & -CONSTANT case that's difficult for tnum, see
+	 * scalar_min_max_and() below for explanation.
 	 */
-	if ((s32)dst_reg->u32_min_value <= (s32)dst_reg->u32_max_value) {
-		dst_reg->s32_min_value = dst_reg->u32_min_value;
-		dst_reg->s32_max_value = dst_reg->u32_max_value;
-	} else {
-		dst_reg->s32_min_value = S32_MIN;
-		dst_reg->s32_max_value = S32_MAX;
-	}
+	dst_reg->s32_min_value = negative32_bit_floor(min(dst_reg->s32_min_value,
+							  src_reg->s32_min_value));
+	dst_reg->s32_max_value = max(dst_reg->s32_max_value, src_reg->s32_max_value);
 }
 
 static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
@@ -13936,18 +13974,45 @@ static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
 	 */
 	dst_reg->umin_value = dst_reg->var_off.value;
 	dst_reg->umax_value = min(dst_reg->umax_value, umax_val);
-
-	/* Safe to set s64 bounds by casting u64 result into s64 when u64
-	 * doesn't cross sign boundary. Otherwise set s64 bounds to unbounded.
+	/* unsigned bounds are propogated into signed bounds later via
+	 * __reg_deduce_bounds().
+	 */
+
+	/* Now handle the [-1, 0] & -CONSTANT case that's difficult for tnum
+	 */
+	/* Consider different sign combinations:
+	 * - when at least one of the range is non-negative, the result is
+	 *   always non-negative because the sign bit is unset, hence we can
+	 *   use 0 for smin
+	 * - for negative & negative range, the result always preserve their
+	 *   common most-significant '1' bits prefix.
+	 *     1111 1100 xxxx xxxx  &  1111 0001 yyyy yyyy
+         *     = 1111 0000 zzzz zzzz  (prefix '1111' is preserved)
+	 *   we obtain this prefix with the rest of the bit unset with
+	 *   negative_bit_floor(min()).
+	 *
+	 * An approximation of lower bound, that is always safe (i.e. smaller
+	 * or equal to the above) would be to use negative_bit_floor(min()) on
+	 * the inputs, because it already work for negative & negative, and is
+	 * always smaller or equal to 0 on other cases.
+	 */
+	dst_reg->smin_value = negative_bit_floor(min(dst_reg->smin_value,
+						     src_reg->smin_value));
+	/* Consider different sign combinations:
+	 * - negative & negative: smax is larger of the inputs -> max()
+	 * - negative & non-negative: smax the non-negative input
+	 * - non-negative & non-negative: smax is smaller of the inputs -> min()
+	 *
+	 * An approximation of upper bound, that is always safe (i.e. larger or
+	 * equal to the above) would be to use max() on the inputs, because
+	 * that is always larger than both inputs (negative & non-negative), as
+	 * well as than min() on the inputs (non-negative & non-negative).
+	 */
+	dst_reg->smax_value = max(dst_reg->smax_value, src_reg->smax_value);
+
+	/* We may learn something more from the var_off, especially for signed
+	 * bounds when at least one of the input can be non-negative.
 	 */
-	if ((s64)dst_reg->umin_value <= (s64)dst_reg->umax_value) {
-		dst_reg->smin_value = dst_reg->umin_value;
-		dst_reg->smax_value = dst_reg->umax_value;
-	} else {
-		dst_reg->smin_value = S64_MIN;
-		dst_reg->smax_value = S64_MAX;
-	}
-	/* We may learn something more from the var_off */
 	__update_reg_bounds(dst_reg);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c b/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
index 568816307f71..f5ac5f3e8919 100644
--- a/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
+++ b/tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c
@@ -31,7 +31,6 @@ int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode)
 
 	if (fmode & FMODE_WRITE)
 		return -EACCES;
-	barrier();
 
 	return 0;
 }
-- 
2.47.0


