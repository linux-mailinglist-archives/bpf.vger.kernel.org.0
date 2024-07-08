Return-Path: <bpf+bounces-34093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5989592A60A
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7CE284C7E
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 15:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A12D142E8D;
	Mon,  8 Jul 2024 15:46:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D64139568
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453610; cv=none; b=JhxE3FZ2k6CUCbwBEingC8O2aa4/3WtZxhUNpznATENZ8EWWLsPYeXEodxmDDU9v0BQWe/xozlwqYfVF+aMgQ6fVaJprUnxRsoteYCA+WsHKmU573InsNrXCOhUrI5eOn1gKrLZU3kBO1I3TKbs4QX2hiWbCrAdnNLUkG8HXnBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453610; c=relaxed/simple;
	bh=+la4gNJoiWD3Y44qBTJL2jWBnscbfH6CrHnJ4EYkL/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lf4gaGgZZWHC06pOdmoy58N+YakBJUmjacs3pEAZIZCXqs/rJ+BB0pyHgoPOZXaVaWEs0lUSfwhKPWtCcVdACU0Y5cURyvorV03MqJJa8tlW7qAm1y6lTIdtTdzjVqz0H+KAYCtHccGiPkimfeM5IWNzXomfwPBZrzg8ftl+T5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 2921965B78CB; Mon,  8 Jul 2024 08:46:34 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Workaround iters/iter_arr_with_actual_elem_count failure when -mcpu=cpuv4
Date: Mon,  8 Jul 2024 08:46:34 -0700
Message-ID: <20240708154634.283426-1-yonghong.song@linux.dev>
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

Actually insn #15 smin range can be better. Since after comparison, we kn=
ow smin32=3D0 and smax32=3D32.
With insn #14 being a sign-extension load. We will know top 32bits should=
 be 0 as well.
Current verifier is not able to handle this, and this patch is a workarou=
nd to fix
test failure by changing variable 'i' type from 'int' to 'unsigned' which=
 will give
proper range during comparison.

  ; bpf_for(i, 0, n) { @ iters.c:1428
  13: (15) if r0 =3D=3D 0x0 goto pc+2       ; R0=3Drdonly_mem(id=3D3,ref_=
obj_id=3D2,sz=3D4) refs=3D2
  14: (61) r1 =3D *(u32 *)(r0 +0)         ; R0=3Drdonly_mem(id=3D3,ref_ob=
j_id=3D2,sz=3D4) R1_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,var_off=3D=
(0x0; 0xffffffff)) refs=3D2
  ...
  from 15 to 20: R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2,sz=3D4) R1=3Dscala=
r(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D31,var_off=3D(0x0; 0x=
1f)) R6=3Dscalar(id=3D1,smin=3Dumin=3Dsmin32=3Dumin32=3D1,smax=3Dumax=3Ds=
max32=3Dumax32=3D32,var_off=3D(0x0; 0x3f)) R7=3D0 R8=3Dfp-8 R10=3Dfp0 fp-=
8=3Diter_num(ref_id=3D2,state=3Dactive,depth=3D1) refs=3D2
  20: R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2,sz=3D4) R1=3Dscalar(smin=3Dsm=
in32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D31,var_off=3D(0x0; 0x1f)) R6=3Ds=
calar(id=3D1,smin=3Dumin=3Dsmin32=3Dumin32=3D1,smax=3Dumax=3Dsmax32=3Duma=
x32=3D32,var_off=3D(0x0; 0x3f)) R7=3D0 R8=3Dfp-8 R10=3Dfp0 fp-8=3Diter_nu=
m(ref_id=3D2,state=3Dactive,depth=3D1) refs=3D2
  ; sum +=3D loop_data.data[i]; @ iters.c:1430
  20: (67) r1 <<=3D 2                     ; R1_w=3Dscalar(smin=3Dsmin32=3D=
0,smax=3Dumax=3Dsmax32=3Dumax32=3D124,var_off=3D(0x0; 0x7c)) refs=3D2
  21: (18) r2 =3D 0xffffc90000185478      ; R2_w=3Dmap_value(map=3Diters.=
bss,ks=3D4,vs=3D1280,off=3D1144) refs=3D2
  23: (0f) r2 +=3D r1
  mark_precise: frame0: last_idx 23 first_idx 20 subseq_idx -1
  ...

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/iters.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/se=
lftests/bpf/progs/iters.c
index 16bdc3e25591..d1801d151a12 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1419,7 +1419,8 @@ SEC("raw_tp")
 __success
 int iter_arr_with_actual_elem_count(const void *ctx)
 {
-	int i, n =3D loop_data.n, sum =3D 0;
+	unsigned i;
+	int n =3D loop_data.n, sum =3D 0;
=20
 	if (n > ARRAY_SIZE(loop_data.data))
 		return 0;
--=20
2.43.0


