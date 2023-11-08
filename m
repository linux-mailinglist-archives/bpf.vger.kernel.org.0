Return-Path: <bpf+bounces-14535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 305567E60E1
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 00:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487D51C20C1A
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 23:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224E637162;
	Wed,  8 Nov 2023 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086CD37158
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 23:12:14 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E8D258D
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 15:12:14 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8KNNNx030521
	for <bpf@vger.kernel.org>; Wed, 8 Nov 2023 15:12:13 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u7w34t7m0-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 15:12:13 -0800
Received: from twshared2123.40.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 15:12:09 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 39F0D3B2E7DDB; Wed,  8 Nov 2023 15:11:58 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 2/4] bpf: fix precision backtracking instruction iteration
Date: Wed, 8 Nov 2023 15:11:50 -0800
Message-ID: <20231108231152.3583545-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108231152.3583545-1-andrii@kernel.org>
References: <20231108231152.3583545-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8ytUAz04ddQI6nOdGpQ7r6S6CdXN0TUD
X-Proofpoint-ORIG-GUID: 8ytUAz04ddQI6nOdGpQ7r6S6CdXN0TUD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_10,2023-11-08_01,2023-05-22_02

Fix an edge case in __mark_chain_precision() which prematurely stops
backtracking instructions in a state if it happens that state's first
and last instruction indexes are the same. This situations doesn't
necessarily mean that there were no instructions simulated in a state,
but rather that we starting from the instruction, jumped around a bit,
and then ended up at the same instruction before checkpointing or
marking precision.

To distinguish between these two possible situations, we need to consult
jump history. If it's empty or contain a single record "bridging" parent
state and first instruction of processed state, then we indeed
backtracked all instructions in this state. But if history is not empty,
we are definitely not done yet.

Move this logic inside get_prev_insn_idx() to contain it more nicely.
Use -ENOENT return code to denote "we are out of instructions"
situation.

This bug was exposed by verifier_cfg.c's bounded_recursion subtest, once
the next fix in this patch set is applied.

Fixes: b5dc0163d8fd ("bpf: precise scalar_value tracking")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9d2af05e37a2..edca7f1ad335 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3662,12 +3662,29 @@ static int push_jmp_history(struct bpf_verifier_e=
nv *env,
=20
 /* Backtrack one insn at a time. If idx is not at the top of recorded
  * history then previous instruction came from straight line execution.
+ * Return -ENOENT if we exhausted all instructions within given state.
+ *
+ * It's legal to have a bit of a looping with the same starting and endi=
ng
+ * insn index within the same state, e.g.: 3->4->5->3, so just because c=
urrent
+ * instruction index is the same as state's first_idx doesn't mean we ar=
e
+ * done. If there is still some jump history left, we should keep going.=
 We
+ * need to take into account that we might have a jump history between g=
iven
+ * state's parent and itself, due to checkpointing. In this case, we'll =
have
+ * history entry recording a jump from last instruction of parent state =
and
+ * first instruction of given state.
  */
 static int get_prev_insn_idx(struct bpf_verifier_state *st, int i,
 			     u32 *history)
 {
 	u32 cnt =3D *history;
=20
+	if (i =3D=3D st->first_insn_idx) {
+		if (cnt =3D=3D 0)
+			return -ENOENT;
+		if (cnt =3D=3D 1 && st->jmp_history[0].idx =3D=3D i)
+			return -ENOENT;
+	}
+
 	if (cnt && st->jmp_history[cnt - 1].idx =3D=3D i) {
 		i =3D st->jmp_history[cnt - 1].prev_idx;
 		(*history)--;
@@ -4542,10 +4559,10 @@ static int __mark_chain_precision(struct bpf_veri=
fier_env *env, int regno)
 				 * Nothing to be tracked further in the parent state.
 				 */
 				return 0;
-			if (i =3D=3D first_idx)
-				break;
 			subseq_idx =3D i;
 			i =3D get_prev_insn_idx(st, i, &history);
+			if (i =3D=3D -ENOENT)
+				break;
 			if (i >=3D env->prog->len) {
 				/* This can happen if backtracking reached insn 0
 				 * and there are still reg_mask or stack_mask
--=20
2.34.1


