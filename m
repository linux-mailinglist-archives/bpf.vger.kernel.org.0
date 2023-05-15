Return-Path: <bpf+bounces-561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A78C9703BE3
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 20:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060572813F9
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 18:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8897117742;
	Mon, 15 May 2023 18:07:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7AE17730
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 18:07:54 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFF320938
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 11:07:28 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FFnKbC006717
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 11:07:26 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qj8cvdee6-20
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 11:07:25 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 11:07:25 -0700
Received: from twshared7331.15.prn3.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 11:07:24 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 5FD3130BA5615; Mon, 15 May 2023 11:07:12 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next] bpf: fix calculation of subseq_idx during precision backtracking
Date: Mon, 15 May 2023 11:07:10 -0700
Message-ID: <20230515180710.1535018-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Gg4n7U2DzvOkZZ7eDhxTsjd8heK49XRv
X-Proofpoint-ORIG-GUID: Gg4n7U2DzvOkZZ7eDhxTsjd8heK49XRv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_16,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Subsequent instruction index (subseq_idx) is an index of an instruction
that was verified/executed by verifier after the currently processed
instruction. It is maintained during precision backtracking processing
and is used to detect various subprog calling conditions.

This patch fixes the bug with incorrectly resetting subseq_idx to -1
when going from child state to parent state during backtracking. If we
don't maintain correct subseq_idx we can misidentify subprog calls
leading to precision tracking bugs.

One such case was triggered by test_global_funcs/global_func9 test where
global subprog call happened to be the very last instruction in parent
state, leading to subseq_idx=3D=3D-1, triggering WARN_ONCE:

  [   36.045754] verifier backtracking bug
  [   36.045764] WARNING: CPU: 13 PID: 2073 at kernel/bpf/verifier.c:3503=
 __mark_chain_precision+0xcc6/0xde0
  [   36.046819] Modules linked in: aesni_intel(E) crypto_simd(E) cryptd(=
E) kvm_intel(E) kvm(E) irqbypass(E) i2c_piix4(E) serio_raw(E) i2c_core(E)=
 crc32c_intel)
  [   36.048040] CPU: 13 PID: 2073 Comm: test_progs Tainted: G        W  =
OE      6.3.0-07976-g4d585f48ee6b-dirty #972
  [   36.048783] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
  [   36.049648] RIP: 0010:__mark_chain_precision+0xcc6/0xde0
  [   36.050038] Code: 3d 82 c6 05 bb 35 32 02 01 e8 66 21 ec ff 0f 0b b8=
 f2 ff ff ff e9 30 f5 ff ff 48 c7 c7 f3 61 3d 82 4c 89 0c 24 e8 4a 21 ec =
ff <0f> 0b 4c0

With the fix precision tracking across multiple states works correctly no=
w:

mark_precise: frame0: last_idx 45 first_idx 38 subseq_idx -1
mark_precise: frame0: regs=3Dr8 stack=3D before 44: (61) r7 =3D *(u32 *)(=
r10 -4)
mark_precise: frame0: regs=3Dr8 stack=3D before 43: (85) call pc+41
mark_precise: frame0: regs=3Dr8 stack=3D before 42: (07) r1 +=3D -48
mark_precise: frame0: regs=3Dr8 stack=3D before 41: (bf) r1 =3D r10
mark_precise: frame0: regs=3Dr8 stack=3D before 40: (63) *(u32 *)(r10 -48=
) =3D r1
mark_precise: frame0: regs=3Dr8 stack=3D before 39: (b4) w1 =3D 0
mark_precise: frame0: regs=3Dr8 stack=3D before 38: (85) call pc+38
mark_precise: frame0: parent state regs=3Dr8 stack=3D:  R0_w=3Dscalar() R=
1_w=3Dmap_value(off=3D4,ks=3D4,vs=3D8,imm=3D0) R6=3D1 R7_w=3Dscalar() R8_=
r=3DP0 R10=3Dfpm
mark_precise: frame0: last_idx 36 first_idx 28 subseq_idx 38
mark_precise: frame0: regs=3Dr8 stack=3D before 36: (18) r1 =3D 0xffff888=
104f2ed14
mark_precise: frame0: regs=3Dr8 stack=3D before 35: (85) call pc+33
mark_precise: frame0: regs=3Dr8 stack=3D before 33: (18) r1 =3D 0xffff888=
104f2ed10
mark_precise: frame0: regs=3Dr8 stack=3D before 32: (85) call pc+36
mark_precise: frame0: regs=3Dr8 stack=3D before 31: (07) r1 +=3D -4
mark_precise: frame0: regs=3Dr8 stack=3D before 30: (bf) r1 =3D r10
mark_precise: frame0: regs=3Dr8 stack=3D before 29: (63) *(u32 *)(r10 -4)=
 =3D r7
mark_precise: frame0: regs=3Dr8 stack=3D before 28: (4c) w7 |=3D w0
mark_precise: frame0: parent state regs=3Dr8 stack=3D:  R0_rw=3Dscalar() =
R6=3D1 R7_rw=3Dscalar() R8_rw=3DP0 R10=3Dfp0 fp-48_r=3Dmmmmmmmm
mark_precise: frame0: last_idx 27 first_idx 16 subseq_idx 28
mark_precise: frame0: regs=3Dr8 stack=3D before 27: (85) call pc+31
mark_precise: frame0: regs=3Dr8 stack=3D before 26: (b7) r1 =3D 0
mark_precise: frame0: regs=3Dr8 stack=3D before 25: (b7) r8 =3D 0

Note how subseq_idx starts out as -1, then is preserved as 38 and then 28=
 as we
go up the parent state chain.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Fixes: fde2a3882bd0 ("bpf: support precision propagation in the presence =
of subprogs")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5c636276d907..f597491259ab 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3864,10 +3864,11 @@ static int __mark_chain_precision(struct bpf_veri=
fier_env *env, int regno)
 	struct bpf_verifier_state *st =3D env->cur_state;
 	int first_idx =3D st->first_insn_idx;
 	int last_idx =3D env->insn_idx;
+	int subseq_idx =3D -1;
 	struct bpf_func_state *func;
 	struct bpf_reg_state *reg;
 	bool skip_first =3D true;
-	int i, prev_i, fr, err;
+	int i, fr, err;
=20
 	if (!env->bpf_capable)
 		return 0;
@@ -3897,8 +3898,8 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno)
 		u32 history =3D st->jmp_history_cnt;
=20
 		if (env->log.level & BPF_LOG_LEVEL2) {
-			verbose(env, "mark_precise: frame%d: last_idx %d first_idx %d\n",
-				bt->frame, last_idx, first_idx);
+			verbose(env, "mark_precise: frame%d: last_idx %d first_idx %d subseq_=
idx %d \n",
+				bt->frame, last_idx, first_idx, subseq_idx);
 		}
=20
 		if (last_idx < 0) {
@@ -3930,12 +3931,12 @@ static int __mark_chain_precision(struct bpf_veri=
fier_env *env, int regno)
 			return -EFAULT;
 		}
=20
-		for (i =3D last_idx, prev_i =3D -1;;) {
+		for (i =3D last_idx;;) {
 			if (skip_first) {
 				err =3D 0;
 				skip_first =3D false;
 			} else {
-				err =3D backtrack_insn(env, i, prev_i, bt);
+				err =3D backtrack_insn(env, i, subseq_idx, bt);
 			}
 			if (err =3D=3D -ENOTSUPP) {
 				mark_all_scalars_precise(env, env->cur_state);
@@ -3952,7 +3953,7 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno)
 				return 0;
 			if (i =3D=3D first_idx)
 				break;
-			prev_i =3D i;
+			subseq_idx =3D i;
 			i =3D get_prev_insn_idx(st, i, &history);
 			if (i >=3D env->prog->len) {
 				/* This can happen if backtracking reached insn 0
@@ -4031,6 +4032,7 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno)
 		if (bt_empty(bt))
 			return 0;
=20
+		subseq_idx =3D first_idx;
 		last_idx =3D st->last_insn_idx;
 		first_idx =3D st->first_insn_idx;
 	}
--=20
2.34.1


