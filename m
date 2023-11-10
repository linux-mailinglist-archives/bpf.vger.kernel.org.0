Return-Path: <bpf+bounces-14664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B937E75ED
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 01:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408BA1C20CD8
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 00:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C17382;
	Fri, 10 Nov 2023 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBFC7F6
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 00:27:00 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204932D7C
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 16:27:00 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MYCAY013908
	for <bpf@vger.kernel.org>; Thu, 9 Nov 2023 16:27:00 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u7w3e41dv-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 16:26:59 -0800
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 16:26:55 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 6ABD13B3FA051; Thu,  9 Nov 2023 16:26:43 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v2 bpf 2/3] bpf: fix precision backtracking instruction iteration
Date: Thu, 9 Nov 2023 16:26:37 -0800
Message-ID: <20231110002638.4168352-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110002638.4168352-1-andrii@kernel.org>
References: <20231110002638.4168352-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: atrgbvE3n5crgPHBiONGvkv7E9jsc3y2
X-Proofpoint-GUID: atrgbvE3n5crgPHBiONGvkv7E9jsc3y2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_17,2023-11-09_01,2023-05-22_02

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

This bug was exposed by verifier_loop1.c's bounded_recursion subtest, onc=
e
the next fix in this patch set is applied.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Fixes: b5dc0163d8fd ("bpf: precise scalar_value tracking")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b87715b364fd..484c742f733e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3516,12 +3516,29 @@ static int push_jmp_history(struct bpf_verifier_e=
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
@@ -4401,10 +4418,10 @@ static int __mark_chain_precision(struct bpf_veri=
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


