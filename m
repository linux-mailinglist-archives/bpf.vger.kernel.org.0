Return-Path: <bpf+bounces-18795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A078221BC
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 20:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8F92B221B7
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 19:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D487D15AD8;
	Tue,  2 Jan 2024 19:07:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E489615AD2
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 191E62C3C8262; Tue,  2 Jan 2024 11:07:26 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next] bpf: Track aligned st store as imprecise spilled registers
Date: Tue,  2 Jan 2024 11:07:26 -0800
Message-Id: <20240102190726.2017424-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With patch set [1], precision backtracing supports register spill/fill
to/from the stack. The patch [2] allows initial imprecise register spill
with content 0. This is a common case for cpuv3 and lower for
initializing the stack variables with pattern
  r1 =3D 0
  *(u64 *)(r10 - 8) =3D r1
and the [2] has demonstrated good verification improvement.

For cpuv4, the initialization could be
  *(u64 *)(r10 - 8) =3D 0
The current verifier marks the r10-8 contents with STACK_ZERO.
Similar to [2], let us permit the above insn to behave like
imprecise register spill which can reduce number of verified states.

I checked cpuv3 and cpuv4 with and without this patch.
There is no change for cpuv3 since '*(u64 *)(r10 - 8) =3D 0'
is only generated with cpuv4.

For cpuv4:
$ ../veristat -C old.cpuv4.csv new.cpuv4.csv -e file,prog,insns,states -s=
 '|insns_diff|'
File                                                   Program           =
                                    Insns (A)  Insns (B)  Insns    (DIFF)=
  States (A)  States (B)  States (DIFF)
-----------------------------------------------------  ------------------=
----------------------------------  ---------  ---------  ---------------=
  ----------  ----------  -------------
pyperf600_bpf_loop.bpf.linked3.o                       on_event          =
                                         6066       4889  -1177 (-19.40%)=
         403         321  -82 (-20.35%)
xdp_synproxy_kern.bpf.linked3.o                        syncookie_tc      =
                                        12412      11719    -693 (-5.58%)=
         345         330   -15 (-4.35%)
xdp_synproxy_kern.bpf.linked3.o                        syncookie_xdp     =
                                        12478      11794    -684 (-5.48%)=
         346         331   -15 (-4.34%)
test_cls_redirect.bpf.linked3.o                        cls_redirect      =
                                        35483      35387     -96 (-0.27%)=
        2179        2177    -2 (-0.09%)
local_storage_bench.bpf.linked3.o                      get_local         =
                                          228        168    -60 (-26.32%)=
          17          14   -3 (-17.65%)
test_l4lb_noinline.bpf.linked3.o                       balancer_ingress  =
                                         4494       4522     +28 (+0.62%)=
         217         219    +2 (+0.92%)
test_l4lb_noinline_dynptr.bpf.linked3.o                balancer_ingress  =
                                         1432       1455     +23 (+1.61%)=
          92          94    +2 (+2.17%)
verifier_iterating_callbacks.bpf.linked3.o             widening          =
                                           52         41    -11 (-21.15%)=
           4           3   -1 (-25.00%)
test_xdp_noinline.bpf.linked3.o                        balancer_ingress_v=
6                                        3462       3458      -4 (-0.12%)=
         216         216    +0 (+0.00%)
...

test_l4lb_noinline and test_l4lb_noinline_dynptr has minor regression, bu=
t
pyperf600_bpf_loop and local_storage_bench gets pretty good improvement.

  [1] https://lore.kernel.org/all/20231205184248.1502704-1-andrii@kernel.=
org/
  [2] https://lore.kernel.org/all/20231205184248.1502704-9-andrii@kernel.=
org/

Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c                                   | 2 +-
 tools/testing/selftests/bpf/progs/verifier_spill_fill.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a376eb609c41..17ad0228270e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4491,7 +4491,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
 		if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
 			state->stack[spi].spilled_ptr.id =3D 0;
 	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
-		   insn->imm !=3D 0 && env->bpf_capable) {
+		   env->bpf_capable) {
 		struct bpf_reg_state fake_reg =3D {};
=20
 		__mark_reg_known(&fake_reg, insn->imm);
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/to=
ols/testing/selftests/bpf/progs/verifier_spill_fill.c
index 39fe3372e0e0..05de3de56e79 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -496,13 +496,13 @@ SEC("raw_tp")
 __log_level(2)
 __success
 /* make sure fp-8 is all STACK_ZERO */
-__msg("2: (7a) *(u64 *)(r10 -8) =3D 0          ; R10=3Dfp0 fp-8_w=3D0000=
0000")
+__msg("2: (7a) *(u64 *)(r10 -8) =3D 0          ; R10=3Dfp0 fp-8_w=3D0")
 /* but fp-16 is spilled IMPRECISE zero const reg */
 __msg("4: (7b) *(u64 *)(r10 -16) =3D r0        ; R0_w=3D0 R10=3Dfp0 fp-1=
6_w=3D0")
 /* validate that assigning R2 from STACK_ZERO doesn't mark register
  * precise immediately; if necessary, it will be marked precise later
  */
-__msg("6: (71) r2 =3D *(u8 *)(r10 -1)          ; R2_w=3D0 R10=3Dfp0 fp-8=
_w=3D00000000")
+__msg("6: (71) r2 =3D *(u8 *)(r10 -1)          ; R2_w=3D0 R10=3Dfp0 fp-8=
_w=3D0")
 /* similarly, when R2 is assigned from spilled register, it is initially
  * imprecise, but will be marked precise later once it is used in precis=
e context
  */
--=20
2.34.1


