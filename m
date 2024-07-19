Return-Path: <bpf+bounces-35079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B09C79376E5
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 12:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22FBBB21854
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 10:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD2912FB37;
	Fri, 19 Jul 2024 10:55:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A51C84A3F;
	Fri, 19 Jul 2024 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721386558; cv=none; b=dNuCx5aQ28FkiakMNbJg5+rrDn5fSPnZDEteTTxGM6d8QOUb7L19yyI0oVNaExj6lh5vzPhXlUMsLj+yPul5bF9lzDHRbL4Tj9wZPol/bqpuJSTXjR8pNjBxqdILUtGo3tMTALjcoFoCpK0R/Rq09LOUEagTvzgC+dMt5tquJXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721386558; c=relaxed/simple;
	bh=DHI2hedDMMz07VqAFSjDnNrW1QMMfKLU3MTa+sYZTFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JW4WIgyIiCvkdkxexyYH19NQHiF9I16bzQqjspfuteUoZquSETKcMnHfskuw1bB0SySZ5A/xuqlW5u+ZPEluQpavYA+RgHEzHePGeQibhSbylcrhUTR/EhRdUXwXU0+PNT0Juf8swM3kasz0pRkaLlDiXJ+sAa/0qdlEbMQlgcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WQRRJ4Pglz4f3jdW;
	Fri, 19 Jul 2024 18:55:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id BEA701A0568;
	Fri, 19 Jul 2024 18:55:52 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP3 (Coremail) with SMTP id _Ch0CgD3BVE0RppmM3cvAg--.11767S7;
	Fri, 19 Jul 2024 18:55:52 +0800 (CST)
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
Subject: [PATCH bpf-next v2 5/9] bpf, verifier: improve signed ranges inference for BPF_AND
Date: Fri, 19 Jul 2024 19:00:55 +0800
Message-Id: <20240719110059.797546-6-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240719110059.797546-1-xukuohai@huaweicloud.com>
References: <20240719110059.797546-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgD3BVE0RppmM3cvAg--.11767S7
X-Coremail-Antispam: 1UD129KBjvAXoW3Zw1fWF1kKr1fXF1UWr17ZFb_yoW8Gw17Co
	WFvr4jy3yxGr48GFyYyw1DtryFgryUGrnrGr1UtF15CFyUAa13X3WUAr48Gr1avF4rKry8
	Cr17KrWktw1xJFnxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOY7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU0sqXPUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Shung-Hsi Yu <shung-hsi.yu@suse.com>

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
Acked-by: Xu Kuohai <xukuohai@huawei.com>
---
 kernel/bpf/verifier.c | 63 +++++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 78104bd85274..d3f3a464a871 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13511,6 +13511,40 @@ static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
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
@@ -13530,16 +13564,10 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
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
@@ -13560,16 +13588,11 @@ static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
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
2.30.2


