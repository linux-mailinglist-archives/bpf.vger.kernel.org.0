Return-Path: <bpf+bounces-8695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C60F788F74
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 21:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0429C28177B
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 19:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF0119387;
	Fri, 25 Aug 2023 19:54:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E24322B
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 19:54:34 +0000 (UTC)
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15791987
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 12:54:32 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 9926F2565A0AE; Fri, 25 Aug 2023 12:54:19 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 10/13] selftests/bpf: Remove unnecessary direct read of local percpu kptr
Date: Fri, 25 Aug 2023 12:54:19 -0700
Message-Id: <20230825195419.97874-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825195328.92126-1-yonghong.song@linux.dev>
References: <20230825195328.92126-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,
	TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For the second argument of bpf_kptr_xchg(), if the reg type contains
MEM_ALLOC and MEM_PERCPU, which means a percpu allocation,
after bpf_kptr_xchg(), the argument is marked as MEM_RCU and MEM_PERCPU
if in rcu critical section. This way, re-reading from the map value
is not needed. Remove it from the percpu_alloc_array.c selftest.

Without previous kernel change, the test will fail like below:

  0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
  ; int BPF_PROG(test_array_map_10, int a)
  0: (b4) w1 =3D 0                        ; R1_w=3D0
  ; int i, index =3D 0;
  1: (63) *(u32 *)(r10 -4) =3D r1         ; R1_w=3D0 R10=3Dfp0 fp-8=3D000=
0????
  2: (bf) r2 =3D r10                      ; R2_w=3Dfp0 R10=3Dfp0
  ;
  3: (07) r2 +=3D -4                      ; R2_w=3Dfp-4
  ; e =3D bpf_map_lookup_elem(&array, &index);
  4: (18) r1 =3D 0xffff88810e771800       ; R1_w=3Dmap_ptr(off=3D0,ks=3D4=
,vs=3D16,imm=3D0)
  6: (85) call bpf_map_lookup_elem#1    ; R0_w=3Dmap_value_or_null(id=3D1=
,off=3D0,ks=3D4,vs=3D16,imm=3D0)
  7: (bf) r6 =3D r0                       ; R0_w=3Dmap_value_or_null(id=3D=
1,off=3D0,ks=3D4,vs=3D16,imm=3D0) R6_w=3Dmap_value_or_null(id=3D1,off=3D0=
,ks=3D4,vs=3D16,imm=3D0)
  ; if (!e)
  8: (15) if r6 =3D=3D 0x0 goto pc+81       ; R6_w=3Dmap_value(off=3D0,ks=
=3D4,vs=3D16,imm=3D0)
  ; bpf_rcu_read_lock();
  9: (85) call bpf_rcu_read_lock#87892          ;
  ; p =3D e->pc;
  10: (bf) r7 =3D r6                      ; R6=3Dmap_value(off=3D0,ks=3D4=
,vs=3D16,imm=3D0) R7_w=3Dmap_value(off=3D0,ks=3D4,vs=3D16,imm=3D0)
  11: (07) r7 +=3D 8                      ; R7_w=3Dmap_value(off=3D8,ks=3D=
4,vs=3D16,imm=3D0)
  12: (79) r6 =3D *(u64 *)(r6 +8)         ; R6_w=3Dpercpu_rcu_ptr_or_null=
_val_t(id=3D2,off=3D0,imm=3D0)
  ; if (!p) {
  13: (55) if r6 !=3D 0x0 goto pc+13      ; R6_w=3D0
  ; p =3D bpf_percpu_obj_new(struct val_t);
  14: (18) r1 =3D 0x12                    ; R1_w=3D18
  16: (b7) r2 =3D 0                       ; R2_w=3D0
  17: (85) call bpf_percpu_obj_new_impl#87883   ; R0_w=3Dpercpu_ptr_or_nu=
ll_val_t(id=3D4,ref_obj_id=3D4,off=3D0,imm=3D0) refs=3D4
  18: (bf) r6 =3D r0                      ; R0=3Dpercpu_ptr_or_null_val_t=
(id=3D4,ref_obj_id=3D4,off=3D0,imm=3D0) R6=3Dpercpu_ptr_or_null_val_t(id=3D=
4,ref_obj_id=3D4,off=3D0,imm=3D0) refs=3D4
  ; if (!p)
  19: (15) if r6 =3D=3D 0x0 goto pc+69      ; R6=3Dpercpu_ptr_val_t(ref_o=
bj_id=3D4,off=3D0,imm=3D0) refs=3D4
  ; p1 =3D bpf_kptr_xchg(&e->pc, p);
  20: (bf) r1 =3D r7                      ; R1_w=3Dmap_value(off=3D8,ks=3D=
4,vs=3D16,imm=3D0) R7=3Dmap_value(off=3D8,ks=3D4,vs=3D16,imm=3D0) refs=3D=
4
  21: (bf) r2 =3D r6                      ; R2_w=3Dpercpu_ptr_val_t(ref_o=
bj_id=3D4,off=3D0,imm=3D0) R6=3Dpercpu_ptr_val_t(ref_obj_id=3D4,off=3D0,i=
mm=3D0) refs=3D4
  22: (85) call bpf_kptr_xchg#194       ; R0_w=3Dpercpu_ptr_or_null_val_t=
(id=3D6,ref_obj_id=3D6,off=3D0,imm=3D0) refs=3D6
  ; if (p1) {
  23: (15) if r0 =3D=3D 0x0 goto pc+3       ; R0_w=3Dpercpu_ptr_val_t(ref=
_obj_id=3D6,off=3D0,imm=3D0) refs=3D6
  ; bpf_percpu_obj_drop(p1);
  24: (bf) r1 =3D r0                      ; R0_w=3Dpercpu_ptr_val_t(ref_o=
bj_id=3D6,off=3D0,imm=3D0) R1_w=3Dpercpu_ptr_val_t(ref_obj_id=3D6,off=3D0=
,imm=3D0) refs=3D6
  25: (b7) r2 =3D 0                       ; R2_w=3D0 refs=3D6
  26: (85) call bpf_percpu_obj_drop_impl#87882          ;
  ; v =3D bpf_this_cpu_ptr(p);
  27: (bf) r1 =3D r6                      ; R1_w=3Dscalar(id=3D7) R6=3Dsc=
alar(id=3D7)
  28: (85) call bpf_this_cpu_ptr#154
  R1 type=3Dscalar expected=3Dpercpu_ptr_, percpu_rcu_ptr_, percpu_truste=
d_ptr_

The R1 which gets its value from R6 is a scalar. But before insn 22, R6 i=
s
  R6=3Dpercpu_ptr_val_t(ref_obj_id=3D4,off=3D0,imm=3D0)
Its type is changed to a scalar at insn 22 without previous patch.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/percpu_alloc_array.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_array.c b/too=
ls/testing/selftests/bpf/progs/percpu_alloc_array.c
index 3bd7d47870a9..bbc45346e006 100644
--- a/tools/testing/selftests/bpf/progs/percpu_alloc_array.c
+++ b/tools/testing/selftests/bpf/progs/percpu_alloc_array.c
@@ -146,10 +146,6 @@ int BPF_PROG(test_array_map_10)
 			/* race condition */
 			bpf_percpu_obj_drop(p1);
 		}
-
-		p =3D e->pc;
-		if (!p)
-			goto out;
 	}
=20
 	v =3D bpf_this_cpu_ptr(p);
--=20
2.34.1


