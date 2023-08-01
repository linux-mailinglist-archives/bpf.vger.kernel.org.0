Return-Path: <bpf+bounces-6621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D5076BE85
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 22:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7693281BA8
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 20:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A38263C7;
	Tue,  1 Aug 2023 20:36:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6F54DC94
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 20:36:52 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC56210A
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 13:36:51 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371H6IUg013222
	for <bpf@vger.kernel.org>; Tue, 1 Aug 2023 13:36:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=w427DpxD9OC30qi1XABpB5hdTAq/Bu9i0vaXza3cgSw=;
 b=EhSljf3SJxwS82QqaPHtJnVEmL79z3A5/IntjX+psSA86hNJTVVoym7t0HuhmbX+VhCi
 8Jlc0Fm0ACxWunv1Lt5juPAYSaYHcpdmwj5x8GssNofcrPwqUUNAKVkZIoCzEAUaGWJz
 F/z2maFcJmiHi/o4IiZzhUD1sSnE8Z+cSmA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3s6h3pb95n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 13:36:50 -0700
Received: from twshared3345.02.ash8.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 13:36:49 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 2F1D62204867F; Tue,  1 Aug 2023 13:36:35 -0700 (PDT)
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
Subject: [PATCH v1 bpf-next 5/7] bpf: Consider non-owning refs to refcounted nodes RCU protected
Date: Tue, 1 Aug 2023 13:36:28 -0700
Message-ID: <20230801203630.3581291-6-davemarchevsky@fb.com>
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
X-Proofpoint-ORIG-GUID: ZBOmJ10DQx7GwCCZviPAe25-lvkQ-4ev
X-Proofpoint-GUID: ZBOmJ10DQx7GwCCZviPAe25-lvkQ-4ev
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

The previous patch in the series ensures that the underlying memory of
nodes with bpf_refcount - which can have multiple owners - is not reused
until RCU Tasks Trace grace period has elapsed. This prevents
use-after-free with non-owning references that may point to
recently-freed memory. While RCU read lock is held, it's safe to
dereference such a non-owning ref, as by definition RCU GP couldn't have
elapsed and therefore underlying memory couldn't have been reused.

From the perspective of verifier "trustedness" non-owning refs to
refcounted nodes are now trusted only in RCU CS and therefore should no
longer pass is_trusted_reg, but rather is_rcu_reg. Let's mark them
MEM_RCU in order to reflect this new state.

Similarly to bpf_spin_unlock being a non-owning ref invalidation point,
where non-owning ref reg states are clobbered so that they cannot be
used outside of the critical section, currently all MEM_RCU regs are
marked untrusted after bpf_rcu_read_unlock. This patch makes
bpf_rcu_read_unlock a non-owning ref invalidation point as well,
clobbering the non-owning refs instead of marking untrusted. In the
future we may want to allow untrusted non-owning refs in which case we
can remove this custom logic without breaking BPF programs as it's more
restrictive than the default. That's a big change in semantics, though,
and this series is focused on fixing the use-after-free in most
straightforward way.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h   |  3 ++-
 kernel/bpf/verifier.c | 17 +++++++++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ceaa8c23287f..37fba01b061a 100644
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
index 9014b469dd9d..4bda365000d3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -469,7 +469,8 @@ static bool type_is_ptr_alloc_obj(u32 type)
=20
 static bool type_is_non_owning_ref(u32 type)
 {
-	return type_is_ptr_alloc_obj(type) && type_flag(type) & NON_OWN_REF;
+	return type_is_ptr_alloc_obj(type) &&
+		type_flag(type) & NON_OWN_REF;
 }
=20
 static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg=
)
@@ -8012,6 +8013,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env =
*env,
 	case PTR_TO_BTF_ID | PTR_TRUSTED:
 	case PTR_TO_BTF_ID | MEM_RCU:
 	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
+	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * its fixed offset must be 0. In the other cases, fixed offset
 		 * can be non-zero. This was already checked above. So pass
@@ -10478,6 +10480,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bp=
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
@@ -10490,6 +10493,9 @@ static int ref_set_non_owning(struct bpf_verifier=
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
@@ -11327,10 +11333,16 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
 		struct bpf_func_state *state;
 		struct bpf_reg_state *reg;
=20
+		if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
+			verbose(env, "can't rcu read {lock,unlock} in rbtree cb\n");
+			return -EACCES;
+		}
+
 		if (rcu_lock) {
 			verbose(env, "nested rcu read lock (kernel function %s)\n", func_name=
);
 			return -EINVAL;
 		} else if (rcu_unlock) {
+			invalidate_non_owning_refs(env);
 			bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
 				if (reg->type & MEM_RCU) {
 					reg->type &=3D ~(MEM_RCU | PTR_MAYBE_NULL);
@@ -16679,7 +16691,8 @@ static int do_check(struct bpf_verifier_env *env)
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


