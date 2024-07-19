Return-Path: <bpf+bounces-35065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01619374E8
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 10:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1644F2829E3
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 08:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C50E84E14;
	Fri, 19 Jul 2024 08:13:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C685F873;
	Fri, 19 Jul 2024 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376813; cv=none; b=fxzskq9vsB50GgDYnkgBslrrSEZKgkKVZL7EAtEHK2OIFk8lSu8agRu3dbPfUUzYeDGq2hiiZp9zIa8bQXXUqrqtBpMGgTXfrBqRf9C4clVifF6ASbtmb7PAn7WLDHHXd8Z43ez/kjeezjtvFMPFVZYXNu0Q83QgtNUyg+oPUiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376813; c=relaxed/simple;
	bh=+u96y2PLe3rPFfZVDvASz+mVhX4U052f/7GrNA3iDyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a2jgTNyYh8Y6dSjM93/JCEBA7zUfWzydrJhzyJ6doaUUaLr7rGJT5EhWDaZvnZ0lvt3A/dHRwTLRJePBoLb0DEBjW01GcYfjQwvhynqoK6neq25u+/r3GE+wgeDysfVEVEHajIKciwtCh7qg5yOTOXp5kvEGrX1/suciIJKNRC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WQMqx1ybtz4f3jkK;
	Fri, 19 Jul 2024 16:13:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5A56C1A0188;
	Fri, 19 Jul 2024 16:13:25 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP3 (Coremail) with SMTP id _Ch0CgCXo04hIJpm5CslAg--.56491S7;
	Fri, 19 Jul 2024 16:13:25 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Florent Revest <revest@google.com>
Subject: [PATCH bpf-next v1 5/9] bpf, verifier: improve signed ranges inference for BPF_AND
Date: Fri, 19 Jul 2024 16:17:45 +0800
Message-Id: <20240719081749.769748-6-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240719081749.769748-1-xukuohai@huaweicloud.com>
References: <20240719081749.769748-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCXo04hIJpm5CslAg--.56491S7
X-Coremail-Antispam: 1UD129KBjvJXoW3Zw1fWF1kKr1fGr1rAr1UKFg_yoWkur4Upr
	ZxGrnFgF4kJrW8Zr9rtw1DJrZ5Xr18A3W8JryDAryxZr12kFyYyr17GrW8JF9xCrWkXr4x
	JF1qgw4DtF4UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Shung-Hsi Yu <shung-hsi.yu@suse.com>

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
tight [-1, 0] range after instruction "r0 s>>= 63", it was not able to
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

This can be further improved with the observation that for negative range
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
Acked-by: Xu Kuohai <xukuohai@huawei.com>
---
 kernel/bpf/verifier.c | 62 +++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 78104bd85274..66010045ed1e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13511,6 +13511,39 @@ static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
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
@@ -13530,16 +13563,10 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
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
@@ -13560,16 +13587,11 @@ static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
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
2.30.2


