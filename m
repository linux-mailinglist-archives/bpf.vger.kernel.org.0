Return-Path: <bpf+bounces-35066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4789374EC
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 10:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B3CFB21F12
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 08:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52865FB95;
	Fri, 19 Jul 2024 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FfIu/y7J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA82F208BA
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721377043; cv=none; b=jY7CFj7/rdgQwDx4F6WX4K/eobKKrHZnGdSX1zBFaGFxwgWeyIZbMX/9xNiTkIiZ5UiLZ6RlcsVvsaqVRMYp3KCOARTWyGQ0kmJzvSvr7e70Q9SdpSWCt4K7ago98mi2JAk2Bl9+dwBrtEPhXqVbOr61VwM5tSpWpDNHHwBJKNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721377043; c=relaxed/simple;
	bh=kpK8XYkq2cqVeNo+k2pBKmQYPPjOkHlTEYLrg9Ojkxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wzn5NL2D6ov+tPsS4ZnXg546i/ny4fDUj/fxIoqKChBVenZwGlhuBoygtM9UZLD5+9s/LrfBtUZQvL81YlbHI+CP5FKrzDhLtWWq5n7ddDhTffzWGj8SElX9cw16WBpyTYa9Rgg+Mi/0aLOiNjptiEVfkGSzyToEFu75m7LqHv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FfIu/y7J; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eedec7fbc4so21117501fa.0
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 01:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721377039; x=1721981839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IoXxVoynmrbPKV08GLhtL6OkXKwW///D4O6cy3o+agA=;
        b=FfIu/y7JiwgsugnSB1hxYg18yu94bkhPU52NvOEHSHM1Wisrra3LJBFZhQbIsAJFMi
         lQoEtPVOxK4gdTBEJnVjphKsz2HLjwQ53tL7b0KRUKQ9scwGOnKJjfS+1vhMuYkhqdMh
         VI0yMMxAFCWrx49zg/RDISMsjmYO16fxtRzKk+WveIy6AwIpS/64lKvH6EyHQsOoImX8
         QTcQs+tCNdNqA3jEK8ag5nr3DzkBfpC18N6c25y3uD83pf0Lv8Q9tGEUpGl4jKRviAaF
         IefmBxQ7oHHSK4EPkXZSK8ZQqP5/Tjg2kaUwtKugwNa8x56ieUswjIEhGqYefRLgJ4FL
         1ZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721377039; x=1721981839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IoXxVoynmrbPKV08GLhtL6OkXKwW///D4O6cy3o+agA=;
        b=U9CQPSZXRi8CNGj/hMM2k1DhGFX5lr9400zevef97HZLyYkxJBzcee1/qDSKhPcbQ+
         P7ctpanzPfNGwO4VmteH9c7M1RX6SPuXbSK7glYmq4qnEd2HIkhaWevhOZeFUw8ib5Gt
         Jp7mWtOHR14t+7jUnKpUDxdqUkuRXSyi3FaV9O/WbUYRBXnVjV3GAlxeVbPE6GXGLOSF
         rJsmJ9hPuxey6C4iD2MeT05rmULtRJXqcixs8x6FYups9Y6cG+5COy0fooCEFMdojyvp
         wwYSZlAibhjU71i6PTuXEUMAehlGIIokiUtV7jHeNW1vmj2sIpDAbuyQB3YPK8t67VD0
         7rSA==
X-Forwarded-Encrypted: i=1; AJvYcCX3cxLbu0jzRiznje4RxF7nqu96/Hqs8umaRe3/27E/Nh6xrn7VeR2nSR3GEXGK62/KTQcigNuXr3CvdP+VOMbX7DHx
X-Gm-Message-State: AOJu0YwkUAAwNKmTIGGFDKqlHNHqL3oGeXWlLuQjRPssQEBssyqIY3Ek
	PIWkr5gPA0h6GD7vmMqXyt2YsWqpBCS8wPFVlPWfYNvIFzGd5Zf6/7FRr8o/6sM=
X-Google-Smtp-Source: AGHT+IEFYOgvKCfTsA0T6kl5dM/v8L91Lmbfx2iXZuP80uMlj6M68PLEgplNs9GkjvnO8nmXBTCb2Q==
X-Received: by 2002:a2e:8e83:0:b0:2ee:e083:c007 with SMTP id 38308e7fff4ca-2ef05c78d4fmr31748261fa.12.1721377030104;
        Fri, 19 Jul 2024 01:17:10 -0700 (PDT)
Received: from localhost ([2401:e180:8852:770b:e576:e894:caae:7245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff59e2d7sm724945b3a.170.2024.07.19.01.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 01:17:09 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>,
	bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Matan Shachnai <m.shachnai@rutgers.edu>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [RFC bpf-next v1] bpf, verifier: improve signed ranges inference for BPF_AND
Date: Fri, 19 Jul 2024 16:17:00 +0800
Message-ID: <20240719081702.137173-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit improve BPF verifier's inference of signed ranges by learning new
signed ranges directly from signed ranges of the operands by doing

    dst_reg->smin_value = negative_bit_floor(min(dst_reg->smin_value, src_reg->smin_value))
    dst_reg->smax_value = max(dst_reg->smax_value, src_reg->smax_value)

See below for th complete explanation. The improvement is needed to prevent
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

While the verifier can correctly infer that the value of r0 is in a tight [-1,
0] range after instruction "r0 s>>= 63", is was not able to come up with a
tight range for "r0 &= -13" (which would be [-13, 0]), and instead inferred a
very loose range:

    r0 s>>= 63; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
    r0 &= -13 ; R0_w=scalar(smax=0x7ffffffffffffff3,umax=0xfffffffffffffff3,smax32=0x7ffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))

The reason is that scalar*_min_max_add() mainly relies on tnum for inferring
bounds in register after BPF_AND, however [-1, 0] cannot be tracked precisely
with tnum, and was effectively turns into [0, -1] (i.e. tnum_unknown). So upon
BPF_AND the resulting tnum is equivalent to

    dst_reg->var_off = tnum_and(tnum_unknown, tnum_const(-13))

And from there the BPF verifier was only able to infer smin=S64_MIN and
smax=0x7ffffffffffffff3, which is outside of the expected [-4095, 0] range for
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
underflow, thus a save bet is to use a value in ranges that is closet to 0,
thus "max(dst_reg->smax_value, src->smax_value)". For negative range & positive
range the sign bit is always cleared, thus we know the resulting value is
non-negative, and only moves towards 0, so a safe bet is to use smax_value of
the non-negative range. Last but not least, non-negative range & non-negative
range is still a non-negative value, and only moves towards 0; however same as
the unsigned range case, the maximum is actually capped by the lesser of the
two, and thus min(dst_reg->smax_value, src_reg->smax_value);

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

So we could substitute the cells in the table above all with max(...), and
arrive at:

                        |                         src_reg
      smax' = ?         +---------------------------+---------------------------
  smax'(r) >= smax(r)   |        negative           |       non-negative
---------+--------------+---------------------------+---------------------------
         | negative     | max(dst->smax, src->smax) | max(dst->smax, src->smax)
dst_reg  +--------------+---------------------------+---------------------------
         | non-negative | max(dst->smax, src->smax) | max(dst->smax, src->smax)

Meaning that simply using

    max(dst_reg->smax_value, src_reg->smax_value)

to calculate the resulting smax_value would work across all sign combinations.

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

This can be also simplified with some observations (quadrants refers to the
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

Together these allows the BPF verifier to infer the signed range of the
result of BPF_AND operation using the signed range from its operands,
and use that information

    r0 s>>= 63; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
    r0 &= -13 ; R0_w=scalar(smin=smin32=-16,smax=smax32=0,umax=0xfffffffffffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))

[0] https://lore.kernel.org/bpf/e62e2971301ca7f2e9eb74fc500c520285cad8f5.camel@gmail.com/

Link: https://lore.kernel.org/bpf/phcqmyzeqrsfzy7sb4rwpluc37hxyz7rcajk2bqw6cjk2x7rt5@m2hl6enudv7d/
Cc: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Sending as RFC because this patch is meant to be included as part of Xu
Kuohai's BPF LSM patchset.

Change since v0 <https://lore.kernel.org/bpf/ykuhustu7vt2ilwhl32kj655xfdgdlm2xkl5rff6tw2ycksovp@ss2n4gpjysnw/>:
- Instead of using multiple &= operations to calculate
  negative*_bit_floor(), use fls*() and left shift. This makes the
  intention clearer, but more importantly it is a lot more similar to
  what we have in tnum_range(), opening the door to future refactoring.
- Update the comment to hint that signed range inference was needed to
  workaround the limitation of tnum
- Improve commit message
  - add a TLDR; showing final form of smax and smin calculation
  - give a more thorough explanation on why smin =
    negative_bit_floor(min(dst->smin, src->smin)) works across
    difference sign combinations
  - add example smin/smax value after this patch is applied (based on my
	understanding, not from actual execution; need to be confirmed)
  - other minor typo fixes and word changes
---
 kernel/bpf/verifier.c | 63 +++++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8da132a1ef28..f6827f9e2076 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13466,6 +13466,40 @@ static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
 	}
 }
 
+/* Clears all trailing bits after the most significant unset bit.
+ *
+ * Used for estimating the minimum possible value after BPF_AND. This
+ * effectively rounds a negative value down to a negative power-of-2 value
+ * (except for -1, which just return -1) and returning 0 for non-negative
+ * values. E.g. negative32_bit_floor(0xff0ff0ff) == 0xff000000.
+ */
+static inline s32 negative32_bit_floor(s32 v)
+{
+	u8 bits = fls(~v); /* find most-significant unset bit */
+	u32 delta;
+
+	/* special case, needed because 1UL << 32 is undefined */
+	if (bits > 31)
+		return 0;
+
+	delta = (1UL << bits) - 1;
+	return ~delta;
+}
+
+/* Same as negative32_bit_floor() above, but for 64-bit signed value */
+static inline s64 negative_bit_floor(s64 v)
+{
+	u8 bits = fls64(~v); /* find most-significant unset bit */
+	u64 delta;
+
+	/* special case, needed because 1ULL << 64 is undefined */
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
@@ -13485,16 +13519,10 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
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
+	/* Handle the [-1, 0] & -CONSTANT case that's difficult for tnum */
+	dst_reg->s32_min_value = negative32_bit_floor(min(dst_reg->s32_min_value,
+							  src_reg->s32_min_value));
+	dst_reg->s32_max_value = max(dst_reg->s32_max_value, src_reg->s32_max_value);
 }
 
 static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
@@ -13515,16 +13543,11 @@ static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
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
+	/* Handle the [-1, 0] & -CONSTANT case that's difficult for tnum */
+	dst_reg->smin_value = negative_bit_floor(min(dst_reg->smin_value,
+						     src_reg->smin_value));
+	dst_reg->smax_value = max(dst_reg->smax_value, src_reg->smax_value);
+
 	/* We may learn something more from the var_off */
 	__update_reg_bounds(dst_reg);
 }
-- 
2.45.2


