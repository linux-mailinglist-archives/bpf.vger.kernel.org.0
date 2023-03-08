Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5816B6AFDAE
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 04:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjCHDzE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 7 Mar 2023 22:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjCHDzD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 22:55:03 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5B9984C0
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 19:55:01 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3281EJ7v019149
        for <bpf@vger.kernel.org>; Tue, 7 Mar 2023 19:55:00 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p6ffw14p1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 19:55:00 -0800
Received: from twshared38955.16.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Mar 2023 19:54:29 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id CB854298A54CC; Tue,  7 Mar 2023 19:54:19 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH v4 bpf-next 1/8] bpf: factor out fetching basic kfunc metadata
Date:   Tue, 7 Mar 2023 19:54:09 -0800
Message-ID: <20230308035416.2591326-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308035416.2591326-1-andrii@kernel.org>
References: <20230308035416.2591326-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: F-jByo7Q2svmc1SnvE9WvBDsS5aw0ddm
X-Proofpoint-ORIG-GUID: F-jByo7Q2svmc1SnvE9WvBDsS5aw0ddm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_18,2023-03-07_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Factor out logic to fetch basic kfunc metadata based on struct bpf_insn.
This is not exactly short or trivial code to just copy/paste, and this
information is sometimes necessary in other parts of verifier logic.
Subsequent patches will rely on this to determine if an instruction is
a kfunc call to iterator next method.

No functional changes intended, including that verbose() warning
behavior when kfunc is not allowed for a particular program type.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 92 +++++++++++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b2116ca78d9a..8d40fba6a1c0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10079,24 +10079,21 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 	return 0;
 }
 
-static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
-			    int *insn_idx_p)
+static int fetch_kfunc_meta(struct bpf_verifier_env *env,
+			    struct bpf_insn *insn,
+			    struct bpf_kfunc_call_arg_meta *meta,
+			    const char **kfunc_name)
 {
-	const struct btf_type *t, *func, *func_proto, *ptr_type;
-	u32 i, nargs, func_id, ptr_type_id, release_ref_obj_id;
-	struct bpf_reg_state *regs = cur_regs(env);
-	const char *func_name, *ptr_type_name;
-	bool sleepable, rcu_lock, rcu_unlock;
-	struct bpf_kfunc_call_arg_meta meta;
-	int err, insn_idx = *insn_idx_p;
-	const struct btf_param *args;
-	const struct btf_type *ret_t;
+	const struct btf_type *func, *func_proto;
+	u32 func_id, *kfunc_flags;
+	const char *func_name;
 	struct btf *desc_btf;
-	u32 *kfunc_flags;
 
-	/* skip for now, but return error when we find this in fixup_kfunc_call */
+	if (kfunc_name)
+		*kfunc_name = NULL;
+
 	if (!insn->imm)
-		return 0;
+		return -EINVAL;
 
 	desc_btf = find_kfunc_desc_btf(env, insn->off);
 	if (IS_ERR(desc_btf))
@@ -10105,22 +10102,51 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	func_id = insn->imm;
 	func = btf_type_by_id(desc_btf, func_id);
 	func_name = btf_name_by_offset(desc_btf, func->name_off);
+	if (kfunc_name)
+		*kfunc_name = func_name;
 	func_proto = btf_type_by_id(desc_btf, func->type);
 
 	kfunc_flags = btf_kfunc_id_set_contains(desc_btf, resolve_prog_type(env->prog), func_id);
 	if (!kfunc_flags) {
-		verbose(env, "calling kernel function %s is not allowed\n",
-			func_name);
 		return -EACCES;
 	}
 
-	/* Prepare kfunc call metadata */
-	memset(&meta, 0, sizeof(meta));
-	meta.btf = desc_btf;
-	meta.func_id = func_id;
-	meta.kfunc_flags = *kfunc_flags;
-	meta.func_proto = func_proto;
-	meta.func_name = func_name;
+	memset(meta, 0, sizeof(*meta));
+	meta->btf = desc_btf;
+	meta->func_id = func_id;
+	meta->kfunc_flags = *kfunc_flags;
+	meta->func_proto = func_proto;
+	meta->func_name = func_name;
+
+	return 0;
+}
+
+static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			    int *insn_idx_p)
+{
+	const struct btf_type *t, *ptr_type;
+	u32 i, nargs, ptr_type_id, release_ref_obj_id;
+	struct bpf_reg_state *regs = cur_regs(env);
+	const char *func_name, *ptr_type_name;
+	bool sleepable, rcu_lock, rcu_unlock;
+	struct bpf_kfunc_call_arg_meta meta;
+	struct bpf_insn_aux_data *insn_aux;
+	int err, insn_idx = *insn_idx_p;
+	const struct btf_param *args;
+	const struct btf_type *ret_t;
+	struct btf *desc_btf;
+
+	/* skip for now, but return error when we find this in fixup_kfunc_call */
+	if (!insn->imm)
+		return 0;
+
+	err = fetch_kfunc_meta(env, insn, &meta, &func_name);
+	if (err == -EACCES && func_name)
+		verbose(env, "calling kernel function %s is not allowed\n", func_name);
+	if (err)
+		return err;
+	desc_btf = meta.btf;
+	insn_aux = &env->insn_aux_data[insn_idx];
 
 	if (is_kfunc_destructive(&meta) && !capable(CAP_SYS_BOOT)) {
 		verbose(env, "destructive kfunc calls require CAP_SYS_BOOT capability\n");
@@ -10173,7 +10199,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		err = release_reference(env, regs[meta.release_regno].ref_obj_id);
 		if (err) {
 			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
-				func_name, func_id);
+				func_name, meta.func_id);
 			return err;
 		}
 	}
@@ -10185,14 +10211,14 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		err = ref_convert_owning_non_owning(env, release_ref_obj_id);
 		if (err) {
 			verbose(env, "kfunc %s#%d conversion of owning ref to non-owning failed\n",
-				func_name, func_id);
+				func_name, meta.func_id);
 			return err;
 		}
 
 		err = release_reference(env, release_ref_obj_id);
 		if (err) {
 			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
-				func_name, func_id);
+				func_name, meta.func_id);
 			return err;
 		}
 	}
@@ -10202,7 +10228,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 					set_rbtree_add_callback_state);
 		if (err) {
 			verbose(env, "kfunc %s#%d failed callback verification\n",
-				func_name, func_id);
+				func_name, meta.func_id);
 			return err;
 		}
 	}
@@ -10211,7 +10237,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		mark_reg_not_init(env, regs, caller_saved[i]);
 
 	/* Check return type */
-	t = btf_type_skip_modifiers(desc_btf, func_proto->type, NULL);
+	t = btf_type_skip_modifiers(desc_btf, meta.func_proto->type, NULL);
 
 	if (is_kfunc_acquire(&meta) && !btf_type_is_struct_ptr(meta.btf, t)) {
 		/* Only exception is bpf_obj_new_impl */
@@ -10260,11 +10286,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				regs[BPF_REG_0].btf = ret_btf;
 				regs[BPF_REG_0].btf_id = ret_btf_id;
 
-				env->insn_aux_data[insn_idx].obj_new_size = ret_t->size;
-				env->insn_aux_data[insn_idx].kptr_struct_meta =
+				insn_aux->obj_new_size = ret_t->size;
+				insn_aux->kptr_struct_meta =
 					btf_find_struct_meta(ret_btf, ret_btf_id);
 			} else if (meta.func_id == special_kfunc_list[KF_bpf_obj_drop_impl]) {
-				env->insn_aux_data[insn_idx].kptr_struct_meta =
+				insn_aux->kptr_struct_meta =
 					btf_find_struct_meta(meta.arg_obj_drop.btf,
 							     meta.arg_obj_drop.btf_id);
 			} else if (meta.func_id == special_kfunc_list[KF_bpf_list_pop_front] ||
@@ -10397,8 +10423,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].id = ++env->id_gen;
 	} /* else { add_kfunc_call() ensures it is btf_type_is_void(t) } */
 
-	nargs = btf_type_vlen(func_proto);
-	args = (const struct btf_param *)(func_proto + 1);
+	nargs = btf_type_vlen(meta.func_proto);
+	args = (const struct btf_param *)(meta.func_proto + 1);
 	for (i = 0; i < nargs; i++) {
 		u32 regno = i + 1;
 
-- 
2.34.1

