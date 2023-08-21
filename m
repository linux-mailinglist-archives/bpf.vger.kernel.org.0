Return-Path: <bpf+bounces-8176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4686B7830F4
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 21:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00981280ECC
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 19:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4584011719;
	Mon, 21 Aug 2023 19:33:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EDF5684
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 19:33:52 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3F2DB
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:33:50 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LIGZZo019809
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:33:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=WtjA8imTE/e1BstpGUBpWnnvxy2GCslhkg+864KYAyQ=;
 b=Q32cW+/KhZu8MuEmRCARfNQWrlr2yGwREhfsnlYeuutGGmg01iDdmvET6B8ZGvUeIwOL
 +LatGEP/bfEYHIu682qHgeyAE8HNB7heHTn8pwuu4jARY1wWxK/YZ82ADkj1/Qh9H0Zu
 2ACOPxLjRdO44C9UimtibaCKj91VFB3zhtw= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3sjug3es0b-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:33:50 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 21 Aug 2023 12:33:25 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id DE598230240FA; Mon, 21 Aug 2023 12:33:20 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 5/7] bpf: Consider non-owning refs to refcounted nodes RCU protected
Date: Mon, 21 Aug 2023 12:33:09 -0700
Message-ID: <20230821193311.3290257-6-davemarchevsky@fb.com>
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
X-Proofpoint-GUID: xolGTC002EjOpez8a2kesO1Vf2rGUgQY
X-Proofpoint-ORIG-GUID: xolGTC002EjOpez8a2kesO1Vf2rGUgQY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_08,2023-08-18_01,2023-05-22_02
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

An earlier patch in the series ensures that the underlying memory of
nodes with bpf_refcount - which can have multiple owners - is not reused
until RCU grace period has elapsed. This prevents
use-after-free with non-owning references that may point to
recently-freed memory. While RCU read lock is held, it's safe to
dereference such a non-owning ref, as by definition RCU GP couldn't have
elapsed and therefore underlying memory couldn't have been reused.

From the perspective of verifier "trustedness" non-owning refs to
refcounted nodes are now trusted only in RCU CS and therefore should no
longer pass is_trusted_reg, but rather is_rcu_reg. Let's mark them
MEM_RCU in order to reflect this new state.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h   |  3 ++-
 kernel/bpf/verifier.c | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eced6400f778..12596af59c00 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -653,7 +653,8 @@ enum bpf_type_flag {
 	MEM_RCU			=3D BIT(13 + BPF_BASE_TYPE_BITS),
=20
 	/* Used to tag PTR_TO_BTF_ID | MEM_ALLOC references which are non-ownin=
g.
-	 * Currently only valid for linked-list and rbtree nodes.
+	 * Currently only valid for linked-list and rbtree nodes. If the nodes
+	 * have a bpf_refcount_field, they must be tagged MEM_RCU as well.
 	 */
 	NON_OWN_REF		=3D BIT(14 + BPF_BASE_TYPE_BITS),
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8db0afa5985c..55607ab30522 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8013,6 +8013,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env =
*env,
 	case PTR_TO_BTF_ID | PTR_TRUSTED:
 	case PTR_TO_BTF_ID | MEM_RCU:
 	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
+	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * its fixed offset must be 0. In the other cases, fixed offset
 		 * can be non-zero. This was already checked above. So pass
@@ -10479,6 +10480,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bp=
f_verifier_env *env,
 static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_r=
eg_state *reg)
 {
 	struct bpf_verifier_state *state =3D env->cur_state;
+	struct btf_record *rec =3D reg_btf_record(reg);
=20
 	if (!state->active_lock.ptr) {
 		verbose(env, "verifier internal error: ref_set_non_owning w/o active l=
ock\n");
@@ -10491,6 +10493,9 @@ static int ref_set_non_owning(struct bpf_verifier=
_env *env, struct bpf_reg_state
 	}
=20
 	reg->type |=3D NON_OWN_REF;
+	if (rec->refcount_off >=3D 0)
+		reg->type |=3D MEM_RCU;
+
 	return 0;
 }
=20
@@ -11328,6 +11333,11 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
 		struct bpf_func_state *state;
 		struct bpf_reg_state *reg;
=20
+		if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
+			verbose(env, "Calling bpf_rcu_read_{lock,unlock} in unnecessary rbtre=
e callback\n");
+			return -EACCES;
+		}
+
 		if (rcu_lock) {
 			verbose(env, "nested rcu read lock (kernel function %s)\n", func_name=
);
 			return -EINVAL;
@@ -16689,7 +16699,8 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
=20
-				if (env->cur_state->active_rcu_lock) {
+				if (env->cur_state->active_rcu_lock &&
+				    !in_rbtree_lock_required_cb(env)) {
 					verbose(env, "bpf_rcu_read_unlock is missing\n");
 					return -EINVAL;
 				}
--=20
2.34.1


