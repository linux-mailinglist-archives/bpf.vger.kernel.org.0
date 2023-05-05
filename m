Return-Path: <bpf+bounces-60-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0341E6F79F0
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 02:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507D41C21624
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256CF1101;
	Fri,  5 May 2023 00:09:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F051010E3
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 00:09:42 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D1D1329F
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 17:09:39 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344KBK1j024221
	for <bpf@vger.kernel.org>; Thu, 4 May 2023 17:09:39 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qckh41a0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 04 May 2023 17:09:38 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 17:09:38 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id B60DF3002FB73; Thu,  4 May 2023 17:09:30 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 07/10] bpf: fix mark_all_scalars_precise use in mark_chain_precision
Date: Thu, 4 May 2023 17:09:05 -0700
Message-ID: <20230505000908.1265044-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230505000908.1265044-1-andrii@kernel.org>
References: <20230505000908.1265044-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: I0VkvQIxBeQOMthIgwaoyRATE1G7Mpff
X-Proofpoint-GUID: I0VkvQIxBeQOMthIgwaoyRATE1G7Mpff
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
index 474966d339b7..dabfa137c29e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3822,7 +3822,7 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno)
 				err =3D backtrack_insn(env, i, bt);
 			}
 			if (err =3D=3D -ENOTSUPP) {
-				mark_all_scalars_precise(env, st);
+				mark_all_scalars_precise(env, env->cur_state);
 				bt_reset(bt);
 				return 0;
 			} else if (err) {
@@ -3884,7 +3884,7 @@ static int __mark_chain_precision(struct bpf_verifi=
er_env *env, int regno)
 					 * fp-8 and it's "unallocated" stack space.
 					 * In such case fallback to conservative.
 					 */
-					mark_all_scalars_precise(env, st);
+					mark_all_scalars_precise(env, env->cur_state);
 					bt_reset(bt);
 					return 0;
 				}
@@ -3912,11 +3912,21 @@ static int __mark_chain_precision(struct bpf_veri=
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


