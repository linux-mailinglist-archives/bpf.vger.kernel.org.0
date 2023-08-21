Return-Path: <bpf+bounces-8175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2223E7830F3
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 21:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CB7280F04
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40C611711;
	Mon, 21 Aug 2023 19:33:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ACD5684
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 19:33:51 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB26C2
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:33:49 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LIGZZm019809
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:33:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=DwsDN6UHcpH82vQi2k2Ud79uc+Qclz+APkHqCE98Ix4=;
 b=VtvICIErYnKHhAJXboQfJUIA3eIjqlNtc7TcSsdpR+1+ZlSCxfslNwuC2/PPvaav14yk
 urx9HOpU9CSHMrw3yo3HUSdQOPQutW5wBJspqw/HO2UFqKfUxEz2SdPQ8SDTp4aBmzSW
 1sN3Mdb3CNMdmxT9YixcPGLWyznpA8fVp6o= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3sjug3es0b-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:33:49 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 21 Aug 2023 12:33:25 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id B8A78230241CB; Mon, 21 Aug 2023 12:33:21 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>, <yonghong.song@linux.dev>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 6/7] bpf: Allow bpf_spin_{lock,unlock} in sleepable progs
Date: Mon, 21 Aug 2023 12:33:10 -0700
Message-ID: <20230821193311.3290257-7-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821193311.3290257-1-davemarchevsky@fb.com>
References: <20230821193311.3290257-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: SN2ZLn1Z3ADftKnQY2PlasEzGsdJhi_n
X-Proofpoint-ORIG-GUID: SN2ZLn1Z3ADftKnQY2PlasEzGsdJhi_n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_08,2023-08-18_01,2023-05-22_02
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 9e7a4d9831e8 ("bpf: Allow LSM programs to use bpf spin locks")
disabled bpf_spin_lock usage in sleepable progs, stating:

 Sleepable LSM programs can be preempted which means that allowng spin
 locks will need more work (disabling preemption and the verifier
 ensuring that no sleepable helpers are called when a spin lock is
 held).

This patch disables preemption before grabbing bpf_spin_lock. The second
requirement above "no sleepable helpers are called when a spin lock is
held" is implicitly enforced by current verifier logic due to helper
calls in spin_lock CS being disabled except for a few exceptions, none
of which sleep.

Due to above preemption changes, bpf_spin_lock CS can also be considered
a RCU CS, so verifier's in_rcu_cs check is modified to account for this.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/helpers.c  | 2 ++
 kernel/bpf/verifier.c | 9 +++------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 945a85e25ac5..8bd3812fb8df 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -286,6 +286,7 @@ static inline void __bpf_spin_lock(struct bpf_spin_lo=
ck *lock)
 	compiletime_assert(u.val =3D=3D 0, "__ARCH_SPIN_LOCK_UNLOCKED not 0");
 	BUILD_BUG_ON(sizeof(*l) !=3D sizeof(__u32));
 	BUILD_BUG_ON(sizeof(*lock) !=3D sizeof(__u32));
+	preempt_disable();
 	arch_spin_lock(l);
 }
=20
@@ -294,6 +295,7 @@ static inline void __bpf_spin_unlock(struct bpf_spin_=
lock *lock)
 	arch_spinlock_t *l =3D (void *)lock;
=20
 	arch_spin_unlock(l);
+	preempt_enable();
 }
=20
 #else
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 55607ab30522..33e4b854d2d4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5062,7 +5062,9 @@ static int map_kptr_match_type(struct bpf_verifier_=
env *env,
  */
 static bool in_rcu_cs(struct bpf_verifier_env *env)
 {
-	return env->cur_state->active_rcu_lock || !env->prog->aux->sleepable;
+	return env->cur_state->active_rcu_lock ||
+	       env->cur_state->active_lock.ptr ||
+	       !env->prog->aux->sleepable;
 }
=20
 /* Once GCC supports btf_type_tag the following mechanism will be replac=
ed with tag check */
@@ -16980,11 +16982,6 @@ static int check_map_prog_compatibility(struct b=
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


