Return-Path: <bpf+bounces-6622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2A076BE86
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 22:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB5E1C210E8
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 20:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFA1263D6;
	Tue,  1 Aug 2023 20:36:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACD14DC94
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 20:36:53 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E352106
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 13:36:52 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371H6c6S024021
	for <bpf@vger.kernel.org>; Tue, 1 Aug 2023 13:36:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=EVsX5R9UrZerpFwXc7eQC+HrL+FtiLzJjMnCWzXhnRo=;
 b=J9ko/E0GRiStYIgdfXrFdz9IBsvDow4B7fOHbEWU9Y3C/ZEpd9Aqteb1T0r69M+PhYTZ
 dG1BrXUVH2T7fyIpVsXt0KeM7eu/HtnkUAibBFA2QLic657lKlGT95zv4x3b+ijFlLJM
 kwmRyMPaH1hnsTdgFrq9ByEbNoCJPQEF3fk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3s6uyyehh7-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 13:36:52 -0700
Received: from twshared3345.02.ash8.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 13:36:49 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 7E6D122048681; Tue,  1 Aug 2023 13:36:35 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 6/7] [RFC] bpf: Allow bpf_spin_{lock,unlock} in sleepable prog's RCU CS
Date: Tue, 1 Aug 2023 13:36:29 -0700
Message-ID: <20230801203630.3581291-7-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801203630.3581291-1-davemarchevsky@fb.com>
References: <20230801203630.3581291-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Hkf17ABiAgsVpdB7P5Q5r2DEZS_vAbwD
X-Proofpoint-GUID: Hkf17ABiAgsVpdB7P5Q5r2DEZS_vAbwD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_19,2023-08-01_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 9e7a4d9831e8 ("bpf: Allow LSM programs to use bpf spin locks")
disabled bpf_spin_lock usage in sleepable progs, stating:

 Sleepable LSM programs can be preempted which means that allowng spin
 locks will need more work (disabling preemption and the verifier
 ensuring that no sleepable helpers are called when a spin lock is
 held).

It seems that some of this 'ensuring that no sleepable helpers are
called' was done for RCU critical section in commit 9bb00b2895cb ("bpf:
Add kfunc bpf_rcu_read_lock/unlock()"), specifically the check which
fails with verbose "sleepable helper %s#%d in rcu_read_lock region"
message in check_helper_call and similar in check_kfunc_call. These
checks prevent sleepable helper and kfunc calls in RCU critical
sections. Accordingly, it should be safe to allow bpf_spin_{lock,unlock}
in RCU CS. This patch does so, replacing the broad "sleepable progs canno=
t use
bpf_spin_lock yet" check with a more targeted !in_rcu_cs.

[
  RFC: Does preemption still need to be disabled here?
]

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4bda365000d3..d1b8e8964aec 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8270,6 +8270,10 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
 			verbose(env, "can't spin_{lock,unlock} in rbtree cb\n");
 			return -EACCES;
 		}
+		if (!in_rcu_cs(env)) {
+			verbose(env, "sleepable progs may only spin_{lock,unlock} in RCU CS\n=
");
+			return -EACCES;
+		}
 		if (meta->func_id =3D=3D BPF_FUNC_spin_lock) {
 			err =3D process_spin_lock(env, regno, true);
 			if (err)
@@ -16972,11 +16976,6 @@ static int check_map_prog_compatibility(struct b=
pf_verifier_env *env,
 			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
 			return -EINVAL;
 		}
-
-		if (prog->aux->sleepable) {
-			verbose(env, "sleepable progs cannot use bpf_spin_lock yet\n");
-			return -EINVAL;
-		}
 	}
=20
 	if (btf_record_has_field(map->record, BPF_TIMER)) {
--=20
2.34.1


