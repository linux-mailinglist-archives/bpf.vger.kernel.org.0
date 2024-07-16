Return-Path: <bpf+bounces-34918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B101B9329C0
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 16:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6698A281950
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5A619CD1B;
	Tue, 16 Jul 2024 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L9lnxCJI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F07A1990D7
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721141563; cv=none; b=iWUBTwOecgL/XEjVPPlNvfbcFVnb1c1SBtNZy2mT2cj2315aoREPJbhAYGjT/Ml/xvOYB+X29AMFDp8jeTROuA1rQKSv0lP7ThVVYftqU9uboNBO+XcNLlRzxjPPY0OZC00qX3AgOVRq811W09Xi3MGvPPvKKSyAYuO5hvfjH58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721141563; c=relaxed/simple;
	bh=tThjEzmfJoq1dgK8yKOd9whDy/KW1ojZ60ReMIu71ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnbtYHLFGR/fkh7hc4KpyZuS4MTeWNctFaju1pYAeBfzePKgLBe9sHF0Y7ZZ9rn9xxC4wtaDXbV+SBH/uYE2WuoydvWWu5lr5Wjn8I5FX5N6P88b0XcgtdbPQAlAgxN6Uw0HOs7puW04YE1zzejc3K/Z7+oxDiYRe9wKa28z5Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L9lnxCJI; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eea8ea8bb0so104815151fa.1
        for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 07:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721141559; x=1721746359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HhQ44Rb3p3NpHrr7w4L+WTWqB4Yu35NDMF2codvLnMw=;
        b=L9lnxCJIdCcw+o6hvwW9JQ9jtyXchWYYsAXaalYBxsxgkJ4e2tlclt3x+E6pnFm0ri
         MA0PJMLzKwqiDE7BFx/HgZZLD4RhTtHkkS9Upjd0Z6pm1Xs7wbqnBkx2+l6bT9d6kd5L
         LAXCtc+lWfHiGL1Yf8XJpNB9Mr16BUBr+9Ys0ekDUD3p5C7SrsR10iA6+V+/FcE6Buq7
         kLe8EziVmpSj3ubiRleZWhYezkLXr24nKqRh4stfyaEvxqtrb+E93vDdjQhsFxJfwe1g
         TgyHfZDRqr3/mDnqIVO9ipSzAkvjwqktFRkFE17wmqMZoz2n6S/Kxn9kdtA2A3xyDFa1
         dwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721141559; x=1721746359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhQ44Rb3p3NpHrr7w4L+WTWqB4Yu35NDMF2codvLnMw=;
        b=PxQThCJT57DjbQuOlzwJA+CK+xTpADHu3oA1EUtehieE4Keg+qCoLD309Sj7IjzBrz
         iMxwlTMcXdErt3a+6YeEJzNtmKWaWhVaamEYAWs2boak+36GIiBVEGAltoO+BFH4RDkn
         +V2sOti3jeYCej1lQDk0ouaHfsW4s6Y7pJczXpHZ1WTcda/i/+PUopxxh2/rnLppj96+
         1AR2H0dq4+nmw5vQTK/XB7kSbCHThIVIIgATVaVz6EdvECroWR/TP+C8Or3GVgX8PMgv
         BlQjoulWzBAOjuiO4RKdOMJsd/m4Nem4yJ82lhGQPuYdVMZV0hvoFNadhVoAQekKRtVM
         Oxjw==
X-Gm-Message-State: AOJu0YwzohlGoUau/4mo4KdmuBRqILPLB1/SY2bsV5rzNqYtovbyIQ14
	oq1pHyMGUJ3yeZK6nJY9CRdrLkgNN3C0IFXPHyShRQtSqGu3RJFeT0PzYijIctg=
X-Google-Smtp-Source: AGHT+IE+QA5e7Gk02EUeAn2TLiaLEB5cdazVkJEF7C/3/PCLDNbM6i0IR/WDIGWmTRpRqEl61bgOZA==
X-Received: by 2002:a2e:9d86:0:b0:2ee:4a67:3d82 with SMTP id 38308e7fff4ca-2eef4191defmr19882211fa.28.1721141558983;
        Tue, 16 Jul 2024 07:52:38 -0700 (PDT)
Received: from u94a (2001-b011-fa04-1e5c-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:1e5c:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-790c3ac9811sm3148355a12.52.2024.07.16.07.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 07:52:38 -0700 (PDT)
Date: Tue, 16 Jul 2024 22:52:26 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, Matan Shachnai <m.shachnai@rutgers.edu>
Subject: [RFC bpf-next] bpf, verifier: improve signed ranges inference for
 BPF_AND
Message-ID: <ykuhustu7vt2ilwhl32kj655xfdgdlm2xkl5rff6tw2ycksovp@ss2n4gpjysnw>
References: <20240711113828.3818398-1-xukuohai@huaweicloud.com>
 <20240711113828.3818398-4-xukuohai@huaweicloud.com>
 <phcqmyzeqrsfzy7sb4rwpluc37hxyz7rcajk2bqw6cjk2x7rt5@m2hl6enudv7d>
 <4ff2c89e-0afc-4b17-a86b-7e4971e7df5b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ff2c89e-0afc-4b17-a86b-7e4971e7df5b@huaweicloud.com>

This commit teach the BPF verifier how to infer signed ranges directly
from signed ranges of the operands to prevent verifier rejection, which
is needed for the following BPF program's no-alu32 version, as shown by
Xu Kuohai:

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

This sequence of instructions comes from Clang's transformation located
in DAGCombiner::SimplifySelectCC() method, which combined the "fmode &
FMODE_WRITE" check with the return statement without needing BPF_JMP at
all. See Eduard's comment for more detail of this transformation[0].

While the verifier can correctly infer that the value of r0 is in a
tight [-1, 0] range after instruction "r0 s>>= 63", is was not able to
come up with a tight range for "r0 &= -13" (which would be [-13, 0]),
and instead inferred a very loose range:

    r0 s>>= 63; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
    r0 &= -13 ; R0_w=scalar(smax=0x7ffffffffffffff3,umax=0xfffffffffffffff3,smax32=0x7ffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))

The reason is that scalar*_min_max_add() mainly relies on tnum for
interring value in register after BPF_AND, however [-1, 0] cannot be
tracked precisely with tnum, and effectively turns into [0, -1] (i.e.
tnum_unknown). So upon BPF_AND the resulting tnum is equivalent to

    dst_reg->var_off = tnum_and(tnum_unknown, tnum_const(-13))

And from there the BPF verifier was only able to infer smin=S64_MIN,
smax=0x7ffffffffffffff3, which is outside of the expected [-4095, 0]
range for return values, and thus the program was rejected.

To allow verification of such instruction pattern, update
scalar*_min_max_and() to infer signed ranges directly from signed ranges
of the operands. With BPF_AND, the resulting value always gains more
unset '0' bit, thus it only move towards 0x0000000000000000. The
difficulty lies with how to deal with signs. While non-negative
(positive and zero) value simply grows smaller, a negative number can
grows smaller, but may also underflow and become a larger value.

To better address this situation we split the signed ranges into
negative range and non-negative range cases, ignoring the mixed sign
cases for now; and only consider how to calculate smax_value.

Since negative range & negative range preserve the sign bit, so we know
the result is still a negative value, thus it only move towards S64_MIN,
but never underflow, thus a save bet is to use a value in ranges that is
closet to 0, thus "max(dst_reg->smax_value, src->smax_value)". For
negative range & positive range the sign bit is always cleared, thus we
know the resulting is a non-negative, and only moves towards 0, so a
safe bet is to use smax_value of the non-negative range. Last but not
least, non-negative range & non-negative range is still a non-negative
value, and only moves towards 0; however same as the unsigned range
case, the maximum is actually capped by the lesser of the two, and thus
min(dst_reg->smax_value, src_reg->smax_value);

Listing out the above reasoning as a table (dst_reg abbreviated as dst,
src_reg abbreviated as src, smax_value abbrivated as smax) we get:

                        |                         src_reg
       smax = ?         +---------------------------+---------------------------
                        |        negative           |       non-negative
---------+--------------+---------------------------+---------------------------
         | negative     | max(dst->smax, src->smax) |         src->smax
dst_reg  +--------------+---------------------------+---------------------------
         | non-negative |         dst->smax         | min(dst->smax, src->smax)

However this is quite complicated, luckily it can be simplified given
the following observations

    max(dst_reg->smax_value, src_reg->smax_value) >= src_reg->smax_value
    max(dst_reg->smax_value, src_reg->smax_value) >= dst_reg->smax_value
    max(dst_reg->smax_value, src_reg->smax_value) >= min(dst_reg->smax_value, src_reg->smax_value)

So we could substitute the cells in the table above all with max(...),
and arrive at:

                        |                         src_reg
      smax' = ?         +---------------------------+---------------------------
                        |        negative           |       non-negative
---------+--------------+---------------------------+---------------------------
         | negative     | max(dst->smax, src->smax) | max(dst->smax, src->smax)
dst_reg  +--------------+---------------------------+---------------------------
         | non-negative | max(dst->smax, src->smax) | max(dst->smax, src->smax)

Meaning that simply using

  max(dst_reg->smax_value, src_reg->smax_value)

to calculate the resulting smax_value would work across all sign combinations.


For smin_value, we know that both non-negative range & non-negative
range and negative range & non-negative range both result in a
non-negative value, so an easy guess is to use the minimum non-negative
value, thus 0.

                        |                         src_reg
       smin = ?         +----------------------------+---------------------------
                        |          negative          |       non-negative
---------+--------------+----------------------------+---------------------------
         | negative     |             ?              |             0
dst_reg  +--------------+----------------------------+---------------------------
         | non-negative |             0              |             0

This leave the negative range & negative range case to be considered. We
know that negative range & negative range always yield a negative value,
so a preliminary guess would be S64_MIN. However, that guess is too
imprecise to help with the r0 <<= 62, r0 s>>= 63, r0 &= -13 pattern
we're trying to deal with here.

This can be further improve with the observation that for negative range
& negative range, the smallest possible value must be one that has
longest _common_ most-significant set '1' bits sequence, thus we can use
min(dst_reg->smin_value, src->smin_value) as the starting point, as the
smaller value will be the one with the shorter most-significant set '1'
bits sequence. But that alone is not enough, as we do not know whether
rest of the bits would be set, so the safest guess would be one that
clear alls bits after the most-significant set '1' bits sequence,
something akin to bit_floor(), but for rounding to a negative power-of-2
instead.

    negative_bit_floor(0xffff000000000003) == 0xffff000000000000
    negative_bit_floor(0xf0ff0000ffff0000) == 0xf000000000000000
    negative_bit_floor(0xfffffb0000000000) == 0xfffff80000000000

With negative range & negative range solve, we now have:

                        |                         src_reg
       smin = ?         +----------------------------+---------------------------
                        |        negative            |       non-negative
---------+--------------+----------------------------+---------------------------
         |   negative   |negative_bit_floor(         |             0
         |              |  min(dst->smin, src->smin))|
dst_reg  +--------------+----------------------------+---------------------------
         | non-negative |           0                |             0

This can be further simplied since min(dst->smin, src->smin) < 0 when both
dst_reg and src_reg have a negative range. Which means using

    negative_bit_floor(min(dst_reg->smin_value, src_reg->smin_value)

to calculate the resulting smin_value would work across all sign combinations.

Together these allows us to infer the signed range of the result of BPF_AND
operation using the signed range from its operands.

[0] https://lore.kernel.org/bpf/e62e2971301ca7f2e9eb74fc500c520285cad8f5.camel@gmail.com/

Link: https://lore.kernel.org/bpf/phcqmyzeqrsfzy7sb4rwpluc37hxyz7rcajk2bqw6cjk2x7rt5@m2hl6enudv7d/
Cc: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 62 +++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8da132a1ef28..6d4cdf30cd76 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13466,6 +13466,39 @@ static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
 	}
 }
 
+/* Clears all trailing bits after the most significant unset bit.
+ *
+ * Used for estimating the minimum possible value after BPF_AND. This
+ * effectively rounds a negative value down to a negative power-of-2 value
+ * (except for -1, which just return -1) and returning 0 for non-negative
+ * values. E.g. masked32_negative(0xff0ff0ff) == 0xff000000.
+ */
+static inline s32 negative32_bit_floor(s32 v)
+{
+	/* XXX: per C standard section 6.5.7 right shift of signed negative
+	 * value is implementation-defined. Should unsigned type be used here
+	 * instead?
+	 */
+	v &= v >> 1;
+	v &= v >> 2;
+	v &= v >> 4;
+	v &= v >> 8;
+	v &= v >> 16;
+	return v;
+}
+
+/* Same as negative32_bit_floor() above, but for 64-bit signed value */
+static inline s64 negative_bit_floor(s64 v)
+{
+	v &= v >> 1;
+	v &= v >> 2;
+	v &= v >> 4;
+	v &= v >> 8;
+	v &= v >> 16;
+	v &= v >> 32;
+	return v;
+}
+
 static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
 				 struct bpf_reg_state *src_reg)
 {
@@ -13485,16 +13518,10 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
 	dst_reg->u32_min_value = var32_off.value;
 	dst_reg->u32_max_value = min(dst_reg->u32_max_value, umax_val);
 
-	/* Safe to set s32 bounds by casting u32 result into s32 when u32
-	 * doesn't cross sign boundary. Otherwise set s32 bounds to unbounded.
-	 */
-	if ((s32)dst_reg->u32_min_value <= (s32)dst_reg->u32_max_value) {
-		dst_reg->s32_min_value = dst_reg->u32_min_value;
-		dst_reg->s32_max_value = dst_reg->u32_max_value;
-	} else {
-		dst_reg->s32_min_value = S32_MIN;
-		dst_reg->s32_max_value = S32_MAX;
-	}
+	/* Rough estimate tuned for [-1, 0] & -CONSTANT cases. */
+	dst_reg->s32_min_value = negative32_bit_floor(min(dst_reg->s32_min_value,
+							  src_reg->s32_min_value));
+	dst_reg->s32_max_value = max(dst_reg->s32_max_value, src_reg->s32_max_value);
 }
 
 static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
@@ -13515,16 +13542,11 @@ static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
 	dst_reg->umin_value = dst_reg->var_off.value;
 	dst_reg->umax_value = min(dst_reg->umax_value, umax_val);
 
-	/* Safe to set s64 bounds by casting u64 result into s64 when u64
-	 * doesn't cross sign boundary. Otherwise set s64 bounds to unbounded.
-	 */
-	if ((s64)dst_reg->umin_value <= (s64)dst_reg->umax_value) {
-		dst_reg->smin_value = dst_reg->umin_value;
-		dst_reg->smax_value = dst_reg->umax_value;
-	} else {
-		dst_reg->smin_value = S64_MIN;
-		dst_reg->smax_value = S64_MAX;
-	}
+	/* Rough estimate tuned for [-1, 0] & -CONSTANT cases. */
+	dst_reg->smin_value = negative_bit_floor(min(dst_reg->smin_value,
+						     src_reg->smin_value));
+	dst_reg->smax_value = max(dst_reg->smax_value, src_reg->smax_value);
+
 	/* We may learn something more from the var_off */
 	__update_reg_bounds(dst_reg);
 }
-- 
2.45.2


