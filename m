Return-Path: <bpf+bounces-87-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 973CA6F7BEB
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 06:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510CD280EDF
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 04:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC4D1FC4;
	Fri,  5 May 2023 04:33:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201341859
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 04:33:41 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDA6AD20
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 21:33:38 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3452XRpZ002481
	for <bpf@vger.kernel.org>; Thu, 4 May 2023 21:33:38 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qcs450jaa-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 04 May 2023 21:33:38 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 21:33:35 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id B784A3006D889; Thu,  4 May 2023 21:33:32 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 07/10] bpf: fix mark_all_scalars_precise use in mark_chain_precision
Date: Thu, 4 May 2023 21:33:14 -0700
Message-ID: <20230505043317.3629845-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505043317.3629845-1-andrii@kernel.org>
References: <20230505043317.3629845-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: hkayNnyHkzJxaiTp0HgicGgg88x9ZXM7
X-Proofpoint-ORIG-GUID: hkayNnyHkzJxaiTp0HgicGgg88x9ZXM7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When precision backtracking bails out due to some unsupported sequence
of instructions (e.g., stack access through register other than r10), we
need to mark all SCALAR registers as precise to be safe. Currently,
though, we mark SCALARs precise only starting from the state we detected
unsupported condition, which could be one of the parent states of the
actual current state. This will leave some registers potentially not
marked as precise, even though they should. So make sure we start
marking scalars as precise from current state (env->cur_state).

Further, we don't currently detect a situation when we end up with some
stack slots marked as needing precision, but we ran out of available
states to find the instructions that populate those stack slots. This is
akin the `i >=3D func->allocated_stack / BPF_REG_SIZE` check and should b=
e
handled similarly by falling back to marking all SCALARs precise. Add
this check when we run out of states.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c                          | 16 +++++++++++++---
 tools/testing/selftests/bpf/verifier/precise.c |  9 +++++----
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 13bbaa2485fc..899122832d8e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3806,7 +3806,7 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno)
 				err =3D backtrack_insn(env, i, bt);
 			}
 			if (err =3D=3D -ENOTSUPP) {
-				mark_all_scalars_precise(env, st);
+				mark_all_scalars_precise(env, env->cur_state);
 				bt_reset(bt);
 				return 0;
 			} else if (err) {
@@ -3868,7 +3868,7 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno)
 					 * fp-8 and it's "unallocated" stack space.
 					 * In such case fallback to conservative.
 					 */
-					mark_all_scalars_precise(env, st);
+					mark_all_scalars_precise(env, env->cur_state);
 					bt_reset(bt);
 					return 0;
 				}
@@ -3896,11 +3896,21 @@ static int __mark_chain_precision(struct bpf_veri=
fier_env *env, int regno)
 		}
=20
 		if (bt_empty(bt))
-			break;
+			return 0;
=20
 		last_idx =3D st->last_insn_idx;
 		first_idx =3D st->first_insn_idx;
 	}
+
+	/* if we still have requested precise regs or slots, we missed
+	 * something (e.g., stack access through non-r10 register), so
+	 * fallback to marking all precise
+	 */
+	if (!bt_empty(bt)) {
+		mark_all_scalars_precise(env, env->cur_state);
+		bt_reset(bt);
+	}
+
 	return 0;
 }
=20
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testi=
ng/selftests/bpf/verifier/precise.c
index 77ea018582c5..b8c0aae8e7ec 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -159,8 +159,9 @@
 	mark_precise: frame0: regs=3Dr4 stack=3D before 3\
 	mark_precise: frame0: regs=3D stack=3D-8 before 2\
 	mark_precise: frame0: falling back to forcing all scalars precise\
+	force_precise: frame0: forcing r0 to be precise\
 	mark_precise: frame0: last_idx 5 first_idx 5\
-	mark_precise: frame0: parent state regs=3Dr0 stack=3D:",
+	mark_precise: frame0: parent state regs=3D stack=3D:",
 	.result =3D VERBOSE_ACCEPT,
 	.retval =3D -1,
 },
@@ -187,10 +188,10 @@
 	mark_precise: frame0: falling back to forcing all scalars precise\
 	force_precise: frame0: forcing r0 to be precise\
 	force_precise: frame0: forcing r0 to be precise\
+	force_precise: frame0: forcing r0 to be precise\
+	force_precise: frame0: forcing r0 to be precise\
 	mark_precise: frame0: last_idx 6 first_idx 6\
-	mark_precise: frame0: parent state regs=3Dr0 stack=3D:\
-	mark_precise: frame0: last_idx 5 first_idx 3\
-	mark_precise: frame0: regs=3Dr0 stack=3D before 5",
+	mark_precise: frame0: parent state regs=3D stack=3D:",
 	.result =3D VERBOSE_ACCEPT,
 	.retval =3D -1,
 },
--=20
2.34.1


