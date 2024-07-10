Return-Path: <bpf+bounces-34354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6FB92C9C1
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 06:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C101C22328
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 04:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E468D376E6;
	Wed, 10 Jul 2024 04:29:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2958F45
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 04:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720585774; cv=none; b=lTteZ+v255HZfeCzt+dZEvuxJi38MvlDaMYsHuJnLd/gGNQ54TXbcUpd0U0Upai3ysHMadi8FkcsQrl0qvJsclgj6uxzwFdondPNqZjdOCjNCPNU1AD9U/awEIGDkSorbLQuOj6Zm3yJ2AkQQnZbzAIASZ9BsK/djWmecf0HaXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720585774; c=relaxed/simple;
	bh=dOm/uxw9xpSoMMyDwyXZwTEYVpm65r0t/SWGh+kB3RU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G5iceeO8Y3o5YB2GT2e3RwPDWTSgxaBH4rjGO3YDBSha5mVhpZKT3mPsk2IAek1sidCsgPWiLbkFr6QZw348h88TSvyqqugk7Vfwvmg9IZLgYyQgs0N8UeeWRte7VDN+v0XUNxOXL3Z7BLCpngTIVVmqiUjOugpGdA6YjKs0H7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 9287766A8CD3; Tue,  9 Jul 2024 21:29:15 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: Get better reg range with ldsx and 32bit compare
Date: Tue,  9 Jul 2024 21:29:15 -0700
Message-ID: <20240710042915.1211933-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With latest llvm19, the selftest iters/iter_arr_with_actual_elem_count
failed with -mcpu=3Dv4.

The following are the details:
  0: R1=3Dctx() R10=3Dfp0
  ; int iter_arr_with_actual_elem_count(const void *ctx) @ iters.c:1420
  0: (b4) w7 =3D 0                        ; R7_w=3D0
  ; int i, n =3D loop_data.n, sum =3D 0; @ iters.c:1422
  1: (18) r1 =3D 0xffffc90000191478       ; R1_w=3Dmap_value(map=3Diters.=
bss,ks=3D4,vs=3D1280,off=3D1144)
  3: (61) r6 =3D *(u32 *)(r1 +128)        ; R1_w=3Dmap_value(map=3Diters.=
bss,ks=3D4,vs=3D1280,off=3D1144) R6_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xf=
fffffff,var_off=3D(0x0; 0xffffffff))
  ; if (n > ARRAY_SIZE(loop_data.data)) @ iters.c:1424
  4: (26) if w6 > 0x20 goto pc+27       ; R6_w=3Dscalar(smin=3Dsmin32=3D0=
,smax=3Dumax=3Dsmax32=3Dumax32=3D32,var_off=3D(0x0; 0x3f))
  5: (bf) r8 =3D r10                      ; R8_w=3Dfp0 R10=3Dfp0
  6: (07) r8 +=3D -8                      ; R8_w=3Dfp-8
  ; bpf_for(i, 0, n) { @ iters.c:1427
  7: (bf) r1 =3D r8                       ; R1_w=3Dfp-8 R8_w=3Dfp-8
  8: (b4) w2 =3D 0                        ; R2_w=3D0
  9: (bc) w3 =3D w6                       ; R3_w=3Dscalar(id=3D1,smin=3Ds=
min32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D32,var_off=3D(0x0; 0x3f)) R6_w=3D=
scalar(id=3D1,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D32,var_of=
f=3D(0x0; 0x3f))
  10: (85) call bpf_iter_num_new#45179          ; R0=3Dscalar() fp-8=3Dit=
er_num(ref_id=3D2,state=3Dactive,depth=3D0) refs=3D2
  11: (bf) r1 =3D r8                      ; R1=3Dfp-8 R8=3Dfp-8 refs=3D2
  12: (85) call bpf_iter_num_next#45181 13: R0=3Drdonly_mem(id=3D3,ref_ob=
j_id=3D2,sz=3D4) R6=3Dscalar(id=3D1,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax3=
2=3Dumax32=3D32,var_off=3D(0x0; 0x3f)) R7=3D0 R8=3Dfp-8 R10=3Dfp0 fp-8=3D=
iter_num(ref_id=3D2,state=3Dactive,depth=3D1) refs=3D2
  ; bpf_for(i, 0, n) { @ iters.c:1427
  13: (15) if r0 =3D=3D 0x0 goto pc+2       ; R0=3Drdonly_mem(id=3D3,ref_=
obj_id=3D2,sz=3D4) refs=3D2
  14: (81) r1 =3D *(s32 *)(r0 +0)         ; R0=3Drdonly_mem(id=3D3,ref_ob=
j_id=3D2,sz=3D4) R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7ffffff=
f) refs=3D2
  15: (ae) if w1 < w6 goto pc+4 20: R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2=
,sz=3D4) R1=3Dscalar(smin=3D0xffffffff80000000,smax=3Dsmax32=3Dumax32=3D3=
1,umax=3D0xffffffff0000001f,smin32=3D0,var_off=3D(0x0; 0xffffffff0000001f=
)) R6=3Dscalar(id=3D1,smin=3Dumin=3Dsmin32=3Dumin32=3D1,smax=3Dumax=3Dsma=
x32=3Dumax32=3D32,var_off=3D(0x0; 0x3f)) R7=3D0 R8=3Dfp-8 R10=3Dfp0 fp-8=3D=
iter_num(ref_id=3D2,state=3Dactive,depth=3D1) refs=3D2
  ; sum +=3D loop_data.data[i]; @ iters.c:1429
  20: (67) r1 <<=3D 2                     ; R1_w=3Dscalar(smax=3D0x7fffff=
fc0000007c,umax=3D0xfffffffc0000007c,smin32=3D0,smax32=3Dumax32=3D124,var=
_off=3D(0x0; 0xfffffffc0000007c)) refs=3D2
  21: (18) r2 =3D 0xffffc90000191478      ; R2_w=3Dmap_value(map=3Diters.=
bss,ks=3D4,vs=3D1280,off=3D1144) refs=3D2
  23: (0f) r2 +=3D r1
  math between map_value pointer and register with unbounded min value is=
 not allowed

The source code:
  int iter_arr_with_actual_elem_count(const void *ctx)
  {
        int i, n =3D loop_data.n, sum =3D 0;

        if (n > ARRAY_SIZE(loop_data.data))
                return 0;

        bpf_for(i, 0, n) {
                /* no rechecking of i against ARRAY_SIZE(loop_data.n) */
                sum +=3D loop_data.data[i];
        }

        return sum;
  }

The insn #14 is a sign-extenstion load which is related to 'int i'.
The insn #15 did a subreg comparision. Note that smin=3D0xffffffff8000000=
0 and this caused later
insn #23 failed verification due to unbounded min value.

Actually insn #15 R1 smin range can be better. Before insn #15, we have
  R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7fffffff)
With the above range, we know for R1, upper 32bit can only be 0xffffffff =
or 0.
Otherwise, the value range for R1 could be beyond [smin=3D0xffffffff80000=
000,smax=3D0x7fffffff].

After insn #15, for the true patch, we know smin32=3D0 and smax32=3D32. W=
ith the upper 32bit 0xffffffff,
then the corresponding value is [0xffffffff00000000, 0xffffffff00000020].=
 The range is
obviously beyond the original range [smin=3D0xffffffff80000000,smax=3D0x7=
fffffff] and the
range is not possible. So the upper 32bit must be 0, which implies smin =3D=
 smin32 and
smax =3D smax32.

This patch fixed the issue by adding additional register deduction after =
32-bit compare
insn such that if the signed 32-bit register range is non-negative and 64=
-bit smin is
{S32/S16/S8}_MIN and 64-bit max is no greater than {U32/U16/U8}_MAX.
Here, we check smin with {S32/S16/S8}_MIN since this is the most common r=
esult related to
signed extension load.

With this patch, iters/iter_arr_with_actual_elem_count succeeded with bet=
ter register range:

from 15 to 20: R0=3Drdonly_mem(id=3D7,ref_obj_id=3D2,sz=3D4) R1_w=3Dscala=
r(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D31,var_off=3D(0x0; 0x=
1f)) R6=3Dscalar(id=3D1,smin=3Dumin=3Dsmin32=3Dumin32=3D1,smax=3Dumax=3Ds=
max32=3Dumax32=3D32,var_off=3D(0x0; 0x3f)) R7=3Dscalar(id=3D9,smin=3D0,sm=
ax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff)) R8=3Dscalar(id=3D9,sm=
in=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff)) R10=3Dfp0 fp=
-8=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D3) refs=3D2

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c0263fb5ca4b..3fc557f99b24 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2182,6 +2182,21 @@ static void __reg_deduce_mixed_bounds(struct bpf_r=
eg_state *reg)
 		reg->smin_value =3D max_t(s64, reg->smin_value, new_smin);
 		reg->smax_value =3D min_t(s64, reg->smax_value, new_smax);
 	}
+
+	/* if s32 range is non-negative and s64 range is in [S32/S16/S8_MIN, <=3D=
 S32/S16/S8_MAX],
+	 * the s64/u64 range can be refined.
+	 */
+	if (reg->s32_min_value >=3D 0) {
+		if ((reg->smin_value =3D=3D S32_MIN && reg->smax_value <=3D S32_MAX) |=
|
+		    (reg->smin_value =3D=3D S16_MIN && reg->smax_value <=3D S16_MAX) |=
|
+		    (reg->smin_value =3D=3D S8_MIN && reg->smax_value <=3D S8_MAX)) {
+			reg->smin_value =3D reg->umin_value =3D reg->s32_min_value;
+			reg->smax_value =3D reg->umax_value =3D reg->s32_max_value;
+			reg->var_off =3D tnum_intersect(reg->var_off,
+						      tnum_range(reg->smin_value,
+								 reg->smax_value));
+		}
+	}
 }
=20
 static void __reg_deduce_bounds(struct bpf_reg_state *reg)
--=20
2.43.0


