Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1284A6936AD
	for <lists+bpf@lfdr.de>; Sun, 12 Feb 2023 10:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBLJ1e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Feb 2023 04:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBLJ1e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Feb 2023 04:27:34 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1AA13D45
        for <bpf@vger.kernel.org>; Sun, 12 Feb 2023 01:27:31 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31C9Plqr012939
        for <bpf@vger.kernel.org>; Sun, 12 Feb 2023 01:27:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=jtoEjlXiBSKpytTKnU/zgeI4Zay2B3iXKukenzyxGxE=;
 b=osXBkJCwObak6upo22MD5T2wBvz+ed4t1swZst01sWdEVsEQk24xg9ZanHBF+1NRieCt
 inR6645xY5V2urGzjyD/FwtvbL/P0MUSny/C5dGZPiB27P/Elg2+lshQJQlah2eH1of9
 rcfGIeftrjJDN2sGHUXP+XiiMt7gVzLxVgM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3npb79vag7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 12 Feb 2023 01:27:30 -0800
Received: from twshared6233.02.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sun, 12 Feb 2023 01:27:30 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id F0A1416CA54D5; Sun, 12 Feb 2023 01:27:18 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v5 bpf-next 1/9] bpf: Migrate release_on_unlock logic to non-owning ref semantics
Date:   Sun, 12 Feb 2023 01:27:07 -0800
Message-ID: <20230212092715.1422619-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230212092715.1422619-1-davemarchevsky@fb.com>
References: <20230212092715.1422619-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Xb8G6zsaJgVUcyehP51fNPhrus4J8_3z
X-Proofpoint-GUID: Xb8G6zsaJgVUcyehP51fNPhrus4J8_3z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-11_15,2023-02-09_03,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch introduces non-owning reference semantics to the verifier,
specifically linked_list API kfunc handling. release_on_unlock logic for
refs is refactored - with small functional changes - to implement these
semantics, and bpf_list_push_{front,back} are migrated to use them.

When a list node is pushed to a list, the program still has a pointer to
the node:

  n =3D bpf_obj_new(typeof(*n));

  bpf_spin_lock(&l);
  bpf_list_push_back(&l, n);
  /* n still points to the just-added node */
  bpf_spin_unlock(&l);

What the verifier considers n to be after the push, and thus what can be
done with n, are changed by this patch.

Common properties both before/after this patch:
  * After push, n is only a valid reference to the node until end of
    critical section
  * After push, n cannot be pushed to any list
  * After push, the program can read the node's fields using n

Before:
  * After push, n retains the ref_obj_id which it received on
    bpf_obj_new, but the associated bpf_reference_state's
    release_on_unlock field is set to true
    * release_on_unlock field and associated logic is used to implement
      "n is only a valid ref until end of critical section"
  * After push, n cannot be written to, the node must be removed from
    the list before writing to its fields
  * After push, n is marked PTR_UNTRUSTED

After:
  * After push, n's ref is released and ref_obj_id set to 0. NON_OWN_REF
    type flag is added to reg's type, indicating that it's a non-owning
    reference.
    * NON_OWN_REF flag and logic is used to implement "n is only a
      valid ref until end of critical section"
  * n can be written to (except for special fields e.g. bpf_list_node,
    timer, ...)

Summary of specific implementation changes to achieve the above:

  * release_on_unlock field, ref_set_release_on_unlock helper, and logic
    to "release on unlock" based on that field are removed

  * The anonymous active_lock struct used by bpf_verifier_state is
    pulled out into a named struct bpf_active_lock.

  * NON_OWN_REF type flag is introduced along with verifier logic
    changes to handle non-owning refs

  * Helpers are added to use NON_OWN_REF flag to implement non-owning
    ref semantics as described above
    * invalidate_non_owning_refs - helper to clobber all non-owning refs
      matching a particular bpf_active_lock identity. Replaces
      release_on_unlock logic in process_spin_lock.
    * ref_set_non_owning - set NON_OWN_REF type flag after doing some
      sanity checking
    * ref_convert_owning_non_owning - convert owning reference w/
      specified ref_obj_id to non-owning references. Set NON_OWN_REF
      flag for each reg with that ref_obj_id and 0-out its ref_obj_id

  * Update linked_list selftests to account for minor semantic
    differences introduced by this patch
    * Writes to a release_on_unlock node ref are not allowed, while
      writes to non-owning reference pointees are. As a result the
      linked_list "write after push" failure tests are no longer scenario=
s
      that should fail.
    * The test##missing_lock##op and test##incorrect_lock##op
      macro-generated failure tests need to have a valid node argument in
      order to have the same error output as before. Otherwise
      verification will fail early and the expected error output won't be=
 seen.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h                           |   6 +
 include/linux/bpf_verifier.h                  |  38 ++--
 kernel/bpf/verifier.c                         | 168 +++++++++++++-----
 .../selftests/bpf/prog_tests/linked_list.c    |   2 -
 .../testing/selftests/bpf/progs/linked_list.c |   2 +-
 .../selftests/bpf/progs/linked_list_fail.c    | 100 +++++++----
 6 files changed, 206 insertions(+), 110 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4385418118f6..8b5d0b4c4ada 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -181,6 +181,7 @@ enum btf_field_type {
 	BPF_KPTR       =3D BPF_KPTR_UNREF | BPF_KPTR_REF,
 	BPF_LIST_HEAD  =3D (1 << 4),
 	BPF_LIST_NODE  =3D (1 << 5),
+	BPF_GRAPH_NODE_OR_ROOT =3D BPF_LIST_NODE | BPF_LIST_HEAD,
 };
=20
 struct btf_field_kptr {
@@ -576,6 +577,11 @@ enum bpf_type_flag {
 	/* MEM is tagged with rcu and memory access needs rcu_read_lock protect=
ion. */
 	MEM_RCU			=3D BIT(13 + BPF_BASE_TYPE_BITS),
=20
+	/* Used to tag PTR_TO_BTF_ID | MEM_ALLOC references which are non-ownin=
g.
+	 * Currently only valid for linked-list and rbtree nodes.
+	 */
+	NON_OWN_REF		=3D BIT(14 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	=3D __BPF_TYPE_FLAG_MAX - 1,
 };
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index aa83de1fe755..cf1bb1cf4a7b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -43,6 +43,22 @@ enum bpf_reg_liveness {
 	REG_LIVE_DONE =3D 0x8, /* liveness won't be updating this register anym=
ore */
 };
=20
+/* For every reg representing a map value or allocated object pointer,
+ * we consider the tuple of (ptr, id) for them to be unique in verifier
+ * context and conside them to not alias each other for the purposes of
+ * tracking lock state.
+ */
+struct bpf_active_lock {
+	/* This can either be reg->map_ptr or reg->btf. If ptr is NULL,
+	 * there's no active lock held, and other fields have no
+	 * meaning. If non-NULL, it indicates that a lock is held and
+	 * id member has the reg->id of the register which can be >=3D 0.
+	 */
+	void *ptr;
+	/* This will be reg->id */
+	u32 id;
+};
+
 struct bpf_reg_state {
 	/* Ordering of fields matters.  See states_equal() */
 	enum bpf_reg_type type;
@@ -226,11 +242,6 @@ struct bpf_reference_state {
 	 * exiting a callback function.
 	 */
 	int callback_ref;
-	/* Mark the reference state to release the registers sharing the same i=
d
-	 * on bpf_spin_unlock (for nodes that we will lose ownership to but are
-	 * safe to access inside the critical section).
-	 */
-	bool release_on_unlock;
 };
=20
 /* state of the program:
@@ -331,21 +342,8 @@ struct bpf_verifier_state {
 	u32 branches;
 	u32 insn_idx;
 	u32 curframe;
-	/* For every reg representing a map value or allocated object pointer,
-	 * we consider the tuple of (ptr, id) for them to be unique in verifier
-	 * context and conside them to not alias each other for the purposes of
-	 * tracking lock state.
-	 */
-	struct {
-		/* This can either be reg->map_ptr or reg->btf. If ptr is NULL,
-		 * there's no active lock held, and other fields have no
-		 * meaning. If non-NULL, it indicates that a lock is held and
-		 * id member has the reg->id of the register which can be >=3D 0.
-		 */
-		void *ptr;
-		/* This will be reg->id */
-		u32 id;
-	} active_lock;
+
+	struct bpf_active_lock active_lock;
 	bool speculative;
 	bool active_rcu_lock;
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 388245e8826e..f176bc15c879 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -190,6 +190,9 @@ struct bpf_verifier_stack_elem {
=20
 static int acquire_reference_state(struct bpf_verifier_env *env, int ins=
n_idx);
 static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d);
+static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
+static int ref_set_non_owning(struct bpf_verifier_env *env,
+			      struct bpf_reg_state *reg);
=20
 static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
 {
@@ -457,6 +460,11 @@ static bool type_is_ptr_alloc_obj(u32 type)
 	return base_type(type) =3D=3D PTR_TO_BTF_ID && type_flag(type) & MEM_AL=
LOC;
 }
=20
+static bool type_is_non_owning_ref(u32 type)
+{
+	return type_is_ptr_alloc_obj(type) && type_flag(type) & NON_OWN_REF;
+}
+
 static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg=
)
 {
 	struct btf_record *rec =3D NULL;
@@ -1073,6 +1081,8 @@ static void print_verifier_state(struct bpf_verifie=
r_env *env,
 				verbose_a("id=3D%d", reg->id);
 			if (reg->ref_obj_id)
 				verbose_a("ref_obj_id=3D%d", reg->ref_obj_id);
+			if (type_is_non_owning_ref(reg->type))
+				verbose_a("%s", "non_own_ref");
 			if (t !=3D SCALAR_VALUE)
 				verbose_a("off=3D%d", reg->off);
 			if (type_is_pkt_pointer(t))
@@ -5052,7 +5062,8 @@ static int check_ptr_to_btf_access(struct bpf_verif=
ier_env *env,
 			return -EACCES;
 		}
=20
-		if (type_is_alloc(reg->type) && !reg->ref_obj_id) {
+		if (type_is_alloc(reg->type) && !type_is_non_owning_ref(reg->type) &&
+		    !reg->ref_obj_id) {
 			verbose(env, "verifier internal error: ref_obj_id for allocated objec=
t must be non-zero\n");
 			return -EFAULT;
 		}
@@ -6042,9 +6053,7 @@ static int process_spin_lock(struct bpf_verifier_en=
v *env, int regno,
 			cur->active_lock.ptr =3D btf;
 		cur->active_lock.id =3D reg->id;
 	} else {
-		struct bpf_func_state *fstate =3D cur_func(env);
 		void *ptr;
-		int i;
=20
 		if (map)
 			ptr =3D map;
@@ -6060,25 +6069,11 @@ static int process_spin_lock(struct bpf_verifier_=
env *env, int regno,
 			verbose(env, "bpf_spin_unlock of different lock\n");
 			return -EINVAL;
 		}
-		cur->active_lock.ptr =3D NULL;
-		cur->active_lock.id =3D 0;
=20
-		for (i =3D fstate->acquired_refs - 1; i >=3D 0; i--) {
-			int err;
+		invalidate_non_owning_refs(env);
=20
-			/* Complain on error because this reference state cannot
-			 * be freed before this point, as bpf_spin_lock critical
-			 * section does not allow functions that release the
-			 * allocated object immediately.
-			 */
-			if (!fstate->refs[i].release_on_unlock)
-				continue;
-			err =3D release_reference(env, fstate->refs[i].id);
-			if (err) {
-				verbose(env, "failed to release release_on_unlock reference");
-				return err;
-			}
-		}
+		cur->active_lock.ptr =3D NULL;
+		cur->active_lock.id =3D 0;
 	}
 	return 0;
 }
@@ -6546,6 +6541,23 @@ static int check_reg_type(struct bpf_verifier_env =
*env, u32 regno,
 	return 0;
 }
=20
+static struct btf_field *
+reg_find_field_offset(const struct bpf_reg_state *reg, s32 off, u32 fiel=
ds)
+{
+	struct btf_field *field;
+	struct btf_record *rec;
+
+	rec =3D reg_btf_record(reg);
+	if (!rec)
+		return NULL;
+
+	field =3D btf_record_find(rec, off, fields);
+	if (!field)
+		return NULL;
+
+	return field;
+}
+
 int check_func_arg_reg_off(struct bpf_verifier_env *env,
 			   const struct bpf_reg_state *reg, int regno,
 			   enum bpf_arg_type arg_type)
@@ -6567,6 +6579,18 @@ int check_func_arg_reg_off(struct bpf_verifier_env=
 *env,
 		 */
 		if (arg_type_is_dynptr(arg_type) && type =3D=3D PTR_TO_STACK)
 			return 0;
+
+		if ((type_is_ptr_alloc_obj(type) || type_is_non_owning_ref(type)) && r=
eg->off) {
+			if (reg_find_field_offset(reg, reg->off, BPF_GRAPH_NODE_OR_ROOT))
+				return __check_ptr_off_reg(env, reg, regno, true);
+
+			verbose(env, "R%d must have zero offset when passed to release func\n=
",
+				regno);
+			verbose(env, "No graph node or root found at R%d type:%s off:%d\n", r=
egno,
+				kernel_type_name(reg->btf, reg->btf_id), reg->off);
+			return -EINVAL;
+		}
+
 		/* Doing check_ptr_off_reg check for the offset will catch this
 		 * because fixed_off_ok is false, but checking here allows us
 		 * to give the user a better error message.
@@ -6601,6 +6625,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env =
*env,
 	case PTR_TO_BTF_ID | PTR_TRUSTED:
 	case PTR_TO_BTF_ID | MEM_RCU:
 	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
+	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * its fixed offset must be 0. In the other cases, fixed offset
 		 * can be non-zero. This was already checked above. So pass
@@ -7363,6 +7388,17 @@ static int release_reference(struct bpf_verifier_e=
nv *env,
 	return 0;
 }
=20
+static void invalidate_non_owning_refs(struct bpf_verifier_env *env)
+{
+	struct bpf_func_state *unused;
+	struct bpf_reg_state *reg;
+
+	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
+		if (type_is_non_owning_ref(reg->type))
+			__mark_reg_unknown(env, reg);
+	}));
+}
+
 static void clear_caller_saved_regs(struct bpf_verifier_env *env,
 				    struct bpf_reg_state *regs)
 {
@@ -8915,38 +8951,54 @@ static int process_kf_arg_ptr_to_kptr(struct bpf_=
verifier_env *env,
 	return 0;
 }
=20
-static int ref_set_release_on_unlock(struct bpf_verifier_env *env, u32 r=
ef_obj_id)
+static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_r=
eg_state *reg)
 {
-	struct bpf_func_state *state =3D cur_func(env);
+	struct bpf_verifier_state *state =3D env->cur_state;
+
+	if (!state->active_lock.ptr) {
+		verbose(env, "verifier internal error: ref_set_non_owning w/o active l=
ock\n");
+		return -EFAULT;
+	}
+
+	if (type_flag(reg->type) & NON_OWN_REF) {
+		verbose(env, "verifier internal error: NON_OWN_REF already set\n");
+		return -EFAULT;
+	}
+
+	reg->type |=3D NON_OWN_REF;
+	return 0;
+}
+
+static int ref_convert_owning_non_owning(struct bpf_verifier_env *env, u=
32 ref_obj_id)
+{
+	struct bpf_func_state *state, *unused;
 	struct bpf_reg_state *reg;
 	int i;
=20
-	/* bpf_spin_lock only allows calling list_push and list_pop, no BPF
-	 * subprogs, no global functions. This means that the references would
-	 * not be released inside the critical section but they may be added to
-	 * the reference state, and the acquired_refs are never copied out for =
a
-	 * different frame as BPF to BPF calls don't work in bpf_spin_lock
-	 * critical sections.
-	 */
+	state =3D cur_func(env);
+
 	if (!ref_obj_id) {
-		verbose(env, "verifier internal error: ref_obj_id is zero for release_=
on_unlock\n");
+		verbose(env, "verifier internal error: ref_obj_id is zero for "
+			     "owning -> non-owning conversion\n");
 		return -EFAULT;
 	}
+
 	for (i =3D 0; i < state->acquired_refs; i++) {
-		if (state->refs[i].id =3D=3D ref_obj_id) {
-			if (state->refs[i].release_on_unlock) {
-				verbose(env, "verifier internal error: expected false release_on_unl=
ock");
-				return -EFAULT;
+		if (state->refs[i].id !=3D ref_obj_id)
+			continue;
+
+		/* Clear ref_obj_id here so release_reference doesn't clobber
+		 * the whole reg
+		 */
+		bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
+			if (reg->ref_obj_id =3D=3D ref_obj_id) {
+				reg->ref_obj_id =3D 0;
+				ref_set_non_owning(env, reg);
 			}
-			state->refs[i].release_on_unlock =3D true;
-			/* Now mark everyone sharing same ref_obj_id as untrusted */
-			bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
-				if (reg->ref_obj_id =3D=3D ref_obj_id)
-					reg->type |=3D PTR_UNTRUSTED;
-			}));
-			return 0;
-		}
+		}));
+		return 0;
 	}
+
 	verbose(env, "verifier internal error: ref state missing for ref_obj_id=
\n");
 	return -EFAULT;
 }
@@ -9081,7 +9133,6 @@ static int process_kf_arg_ptr_to_list_node(struct b=
pf_verifier_env *env,
 {
 	const struct btf_type *et, *t;
 	struct btf_field *field;
-	struct btf_record *rec;
 	u32 list_node_off;
=20
 	if (meta->btf !=3D btf_vmlinux ||
@@ -9098,9 +9149,8 @@ static int process_kf_arg_ptr_to_list_node(struct b=
pf_verifier_env *env,
 		return -EINVAL;
 	}
=20
-	rec =3D reg_btf_record(reg);
 	list_node_off =3D reg->off + reg->var_off.value;
-	field =3D btf_record_find(rec, list_node_off, BPF_LIST_NODE);
+	field =3D reg_find_field_offset(reg, list_node_off, BPF_LIST_NODE);
 	if (!field || field->offset !=3D list_node_off) {
 		verbose(env, "bpf_list_node not found at offset=3D%u\n", list_node_off=
);
 		return -EINVAL;
@@ -9126,8 +9176,8 @@ static int process_kf_arg_ptr_to_list_node(struct b=
pf_verifier_env *env,
 			btf_name_by_offset(field->graph_root.btf, et->name_off));
 		return -EINVAL;
 	}
-	/* Set arg#1 for expiration after unlock */
-	return ref_set_release_on_unlock(env, reg->ref_obj_id);
+
+	return 0;
 }
=20
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfu=
nc_call_arg_meta *meta)
@@ -9406,11 +9456,11 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
 			    int *insn_idx_p)
 {
 	const struct btf_type *t, *func, *func_proto, *ptr_type;
+	u32 i, nargs, func_id, ptr_type_id, release_ref_obj_id;
 	struct bpf_reg_state *regs =3D cur_regs(env);
 	const char *func_name, *ptr_type_name;
 	bool sleepable, rcu_lock, rcu_unlock;
 	struct bpf_kfunc_call_arg_meta meta;
-	u32 i, nargs, func_id, ptr_type_id;
 	int err, insn_idx =3D *insn_idx_p;
 	const struct btf_param *args;
 	const struct btf_type *ret_t;
@@ -9505,6 +9555,24 @@ static int check_kfunc_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn,
 		}
 	}
=20
+	if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_list_push_front] ||
+	    meta.func_id =3D=3D special_kfunc_list[KF_bpf_list_push_back]) {
+		release_ref_obj_id =3D regs[BPF_REG_2].ref_obj_id;
+		err =3D ref_convert_owning_non_owning(env, release_ref_obj_id);
+		if (err) {
+			verbose(env, "kfunc %s#%d conversion of owning ref to non-owning fail=
ed\n",
+				func_name, func_id);
+			return err;
+		}
+
+		err =3D release_reference(env, release_ref_obj_id);
+		if (err) {
+			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
+				func_name, func_id);
+			return err;
+		}
+	}
+
 	for (i =3D 0; i < CALLER_SAVED_REGS; i++)
 		mark_reg_not_init(env, regs, caller_saved[i]);
=20
@@ -11825,8 +11893,10 @@ static void mark_ptr_or_null_reg(struct bpf_func=
_state *state,
 		 */
 		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !tnum_equals_co=
nst(reg->var_off, 0)))
 			return;
-		if (reg->type !=3D (PTR_TO_BTF_ID | MEM_ALLOC | PTR_MAYBE_NULL) && WAR=
N_ON_ONCE(reg->off))
+		if (!(type_is_ptr_alloc_obj(reg->type) || type_is_non_owning_ref(reg->=
type)) &&
+		    WARN_ON_ONCE(reg->off))
 			return;
+
 		if (is_null) {
 			reg->type =3D SCALAR_VALUE;
 			/* We don't need id and ref_obj_id from this point
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools=
/testing/selftests/bpf/prog_tests/linked_list.c
index 9a7d4c47af63..2592b8aa5e41 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -78,8 +78,6 @@ static struct {
 	{ "direct_write_head", "direct access to bpf_list_head is disallowed" }=
,
 	{ "direct_read_node", "direct access to bpf_list_node is disallowed" },
 	{ "direct_write_node", "direct access to bpf_list_node is disallowed" }=
,
-	{ "write_after_push_front", "only read is supported" },
-	{ "write_after_push_back", "only read is supported" },
 	{ "use_after_unlock_push_front", "invalid mem access 'scalar'" },
 	{ "use_after_unlock_push_back", "invalid mem access 'scalar'" },
 	{ "double_push_front", "arg#1 expected pointer to allocated object" },
diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/test=
ing/selftests/bpf/progs/linked_list.c
index 4ad88da5cda2..4fa4a9b01bde 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.c
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -260,7 +260,7 @@ int test_list_push_pop_multiple(struct bpf_spin_lock =
*lock, struct bpf_list_head
 {
 	int ret;
=20
-	ret =3D list_push_pop_multiple(lock ,head, false);
+	ret =3D list_push_pop_multiple(lock, head, false);
 	if (ret)
 		return ret;
 	return list_push_pop_multiple(lock, head, true);
diff --git a/tools/testing/selftests/bpf/progs/linked_list_fail.c b/tools=
/testing/selftests/bpf/progs/linked_list_fail.c
index 1d9017240e19..69cdc07cba13 100644
--- a/tools/testing/selftests/bpf/progs/linked_list_fail.c
+++ b/tools/testing/selftests/bpf/progs/linked_list_fail.c
@@ -54,28 +54,44 @@
 		return 0;                                   \
 	}
=20
-CHECK(kptr, push_front, &f->head);
-CHECK(kptr, push_back, &f->head);
 CHECK(kptr, pop_front, &f->head);
 CHECK(kptr, pop_back, &f->head);
=20
-CHECK(global, push_front, &ghead);
-CHECK(global, push_back, &ghead);
 CHECK(global, pop_front, &ghead);
 CHECK(global, pop_back, &ghead);
=20
-CHECK(map, push_front, &v->head);
-CHECK(map, push_back, &v->head);
 CHECK(map, pop_front, &v->head);
 CHECK(map, pop_back, &v->head);
=20
-CHECK(inner_map, push_front, &iv->head);
-CHECK(inner_map, push_back, &iv->head);
 CHECK(inner_map, pop_front, &iv->head);
 CHECK(inner_map, pop_back, &iv->head);
=20
 #undef CHECK
=20
+#define CHECK(test, op, hexpr, nexpr)					\
+	SEC("?tc")							\
+	int test##_missing_lock_##op(void *ctx)				\
+	{								\
+		INIT;							\
+		void (*p)(void *, void *) =3D (void *)&bpf_list_##op;	\
+		p(hexpr, nexpr);					\
+		return 0;						\
+	}
+
+CHECK(kptr, push_front, &f->head, b);
+CHECK(kptr, push_back, &f->head, b);
+
+CHECK(global, push_front, &ghead, f);
+CHECK(global, push_back, &ghead, f);
+
+CHECK(map, push_front, &v->head, f);
+CHECK(map, push_back, &v->head, f);
+
+CHECK(inner_map, push_front, &iv->head, f);
+CHECK(inner_map, push_back, &iv->head, f);
+
+#undef CHECK
+
 #define CHECK(test, op, lexpr, hexpr)                       \
 	SEC("?tc")                                          \
 	int test##_incorrect_lock_##op(void *ctx)           \
@@ -108,11 +124,47 @@ CHECK(inner_map, pop_back, &iv->head);
 	CHECK(inner_map_global, op, &iv->lock, &ghead);        \
 	CHECK(inner_map_map, op, &iv->lock, &v->head);
=20
-CHECK_OP(push_front);
-CHECK_OP(push_back);
 CHECK_OP(pop_front);
 CHECK_OP(pop_back);
=20
+#undef CHECK
+#undef CHECK_OP
+
+#define CHECK(test, op, lexpr, hexpr, nexpr)				\
+	SEC("?tc")							\
+	int test##_incorrect_lock_##op(void *ctx)			\
+	{								\
+		INIT;							\
+		void (*p)(void *, void*) =3D (void *)&bpf_list_##op;	\
+		bpf_spin_lock(lexpr);					\
+		p(hexpr, nexpr);					\
+		return 0;						\
+	}
+
+#define CHECK_OP(op)							\
+	CHECK(kptr_kptr, op, &f1->lock, &f2->head, b);			\
+	CHECK(kptr_global, op, &f1->lock, &ghead, f);			\
+	CHECK(kptr_map, op, &f1->lock, &v->head, f);			\
+	CHECK(kptr_inner_map, op, &f1->lock, &iv->head, f);		\
+									\
+	CHECK(global_global, op, &glock2, &ghead, f);			\
+	CHECK(global_kptr, op, &glock, &f1->head, b);			\
+	CHECK(global_map, op, &glock, &v->head, f);			\
+	CHECK(global_inner_map, op, &glock, &iv->head, f);		\
+									\
+	CHECK(map_map, op, &v->lock, &v2->head, f);			\
+	CHECK(map_kptr, op, &v->lock, &f2->head, b);			\
+	CHECK(map_global, op, &v->lock, &ghead, f);			\
+	CHECK(map_inner_map, op, &v->lock, &iv->head, f);		\
+									\
+	CHECK(inner_map_inner_map, op, &iv->lock, &iv2->head, f);	\
+	CHECK(inner_map_kptr, op, &iv->lock, &f2->head, b);		\
+	CHECK(inner_map_global, op, &iv->lock, &ghead, f);		\
+	CHECK(inner_map_map, op, &iv->lock, &v->head, f);
+
+CHECK_OP(push_front);
+CHECK_OP(push_back);
+
 #undef CHECK
 #undef CHECK_OP
 #undef INIT
@@ -303,34 +355,6 @@ int direct_write_node(void *ctx)
 	return 0;
 }
=20
-static __always_inline
-int write_after_op(void (*push_op)(void *head, void *node))
-{
-	struct foo *f;
-
-	f =3D bpf_obj_new(typeof(*f));
-	if (!f)
-		return 0;
-	bpf_spin_lock(&glock);
-	push_op(&ghead, &f->node);
-	f->data =3D 42;
-	bpf_spin_unlock(&glock);
-
-	return 0;
-}
-
-SEC("?tc")
-int write_after_push_front(void *ctx)
-{
-	return write_after_op((void *)bpf_list_push_front);
-}
-
-SEC("?tc")
-int write_after_push_back(void *ctx)
-{
-	return write_after_op((void *)bpf_list_push_back);
-}
-
 static __always_inline
 int use_after_unlock(void (*op)(void *head, void *node))
 {
--=20
2.30.2

