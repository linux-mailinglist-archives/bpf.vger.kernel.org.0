Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9085E683487
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 19:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjAaSBN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 13:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjAaSAu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 13:00:50 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF43206A1
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:00:31 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VGdeR9016855
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:00:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=infRqNjpV5Frkpwger41i1BZ7IC1b/itmqDIw+zIvNg=;
 b=EUORme5NGIKncznApYR1BcbXLlCmjMaxgSoe7sDKu+3wUZYOumUc5T7Qf9eB8+nKVyq7
 if0m3zlKWvT2sRHSGB7YBVEsF3dAnT+UOqdzC2g9pRYWM1aaav/1es/uuQRB3xpLF8Lp
 gztWSiOnk1IjoXjv6N8og+4bSX6ZnT/TZic= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nd1q2rmwg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:00:31 -0800
Received: from twshared21680.02.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 31 Jan 2023 10:00:30 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 7133015D5BB61; Tue, 31 Jan 2023 10:00:18 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v3 bpf-next 01/11] bpf: Migrate release_on_unlock logic to non-owning ref semantics
Date:   Tue, 31 Jan 2023 10:00:06 -0800
Message-ID: <20230131180016.3368305-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230131180016.3368305-1-davemarchevsky@fb.com>
References: <20230131180016.3368305-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: EMyFgcDOaq5QxlmTJKDqWtHhOL8EUnYF
X-Proofpoint-ORIG-GUID: EMyFgcDOaq5QxlmTJKDqWtHhOL8EUnYF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
  * After push, n's ref is released and ref_obj_id set to 0. The
    bpf_reg_state's non_owning_ref_lock struct is populated with the
    currently active lock
    * non_owning_ref_lock and logic is used to implement "n is only a
      valid ref until end of critical section"
  * n can be written to (except for special fields e.g. bpf_list_node,
    timer, ...)
  * No special type flag is added to n after push

Summary of specific implementation changes to achieve the above:

  * release_on_unlock field, ref_set_release_on_unlock helper, and logic
    to "release on unlock" based on that field are removed

  * The anonymous active_lock struct used by bpf_verifier_state is
    pulled out into a named struct bpf_active_lock.

  * A non_owning_ref_lock field of type bpf_active_lock is added to
    bpf_reg_state's PTR_TO_BTF_ID union

  * Helpers are added to use non_owning_ref_lock to implement non-owning
    ref semantics as described above
    * invalidate_non_owning_refs - helper to clobber all non-owning refs
      matching a particular bpf_active_lock identity. Replaces
      release_on_unlock logic in process_spin_lock.
    * ref_set_non_owning_lock - set non_owning_ref_lock for a reg based
      on current verifier state
    * ref_convert_owning_non_owning - convert owning reference w/
      specified ref_obj_id to non-owning references. Setup
      non_owning_ref_lock for each reg with that ref_obj_id and 0 out
      its ref_obj_id

After these changes, linked_list's "release on unlock" logic continues
to function as before, except for the semantic differences noted above.
The patch immediately following this one makes minor changes to
linked_list selftests to account for the differing behavior.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf.h          |   1 +
 include/linux/bpf_verifier.h |  39 ++++-----
 kernel/bpf/verifier.c        | 164 +++++++++++++++++++++++++----------
 3 files changed, 136 insertions(+), 68 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ae7771c7d750..a6f9ac8ff12a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -180,6 +180,7 @@ enum btf_field_type {
 	BPF_KPTR       =3D BPF_KPTR_UNREF | BPF_KPTR_REF,
 	BPF_LIST_HEAD  =3D (1 << 4),
 	BPF_LIST_NODE  =3D (1 << 5),
+	BPF_GRAPH_NODE_OR_ROOT =3D BPF_LIST_NODE | BPF_LIST_HEAD,
 };
=20
 struct btf_field_kptr {
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 127058cfec47..1c6bbde40705 100644
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
@@ -68,6 +84,7 @@ struct bpf_reg_state {
 		struct {
 			struct btf *btf;
 			u32 btf_id;
+			struct bpf_active_lock non_owning_ref_lock;
 		};
=20
 		u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
@@ -223,11 +240,6 @@ struct bpf_reference_state {
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
@@ -328,21 +340,8 @@ struct bpf_verifier_state {
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
index f689eb1f5140..4b1883ffcf21 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -190,6 +190,10 @@ struct bpf_verifier_stack_elem {
=20
 static int acquire_reference_state(struct bpf_verifier_env *env, int ins=
n_idx);
 static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d);
+static void invalidate_non_owning_refs(struct bpf_verifier_env *env,
+				       struct bpf_active_lock *lock);
+static int ref_set_non_owning_lock(struct bpf_verifier_env *env,
+				   struct bpf_reg_state *reg);
=20
 static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
 {
@@ -931,6 +935,9 @@ static void print_verifier_state(struct bpf_verifier_=
env *env,
 				verbose_a("id=3D%d", reg->id);
 			if (reg->ref_obj_id)
 				verbose_a("ref_obj_id=3D%d", reg->ref_obj_id);
+			if (reg->non_owning_ref_lock.ptr)
+				verbose_a("non_own_id=3D(%p,%d)", reg->non_owning_ref_lock.ptr,
+					  reg->non_owning_ref_lock.id);
 			if (t !=3D SCALAR_VALUE)
 				verbose_a("off=3D%d", reg->off);
 			if (type_is_pkt_pointer(t))
@@ -4826,7 +4833,8 @@ static int check_ptr_to_btf_access(struct bpf_verif=
ier_env *env,
 			return -EACCES;
 		}
=20
-		if (type_is_alloc(reg->type) && !reg->ref_obj_id) {
+		if (type_is_alloc(reg->type) && !reg->ref_obj_id &&
+		    !reg->non_owning_ref_lock.ptr) {
 			verbose(env, "verifier internal error: ref_obj_id for allocated objec=
t must be non-zero\n");
 			return -EFAULT;
 		}
@@ -5784,9 +5792,7 @@ static int process_spin_lock(struct bpf_verifier_en=
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
@@ -5802,25 +5808,11 @@ static int process_spin_lock(struct bpf_verifier_=
env *env, int regno,
 			verbose(env, "bpf_spin_unlock of different lock\n");
 			return -EINVAL;
 		}
-		cur->active_lock.ptr =3D NULL;
-		cur->active_lock.id =3D 0;
=20
-		for (i =3D fstate->acquired_refs - 1; i >=3D 0; i--) {
-			int err;
+		invalidate_non_owning_refs(env, &cur->active_lock);
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
@@ -6279,6 +6271,23 @@ static int check_reg_type(struct bpf_verifier_env =
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
@@ -6300,6 +6309,18 @@ int check_func_arg_reg_off(struct bpf_verifier_env=
 *env,
 		 */
 		if (arg_type_is_dynptr(arg_type) && type =3D=3D PTR_TO_STACK)
 			return 0;
+
+		if (type =3D=3D (PTR_TO_BTF_ID | MEM_ALLOC) && reg->off) {
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
@@ -7061,6 +7082,20 @@ static int release_reference(struct bpf_verifier_e=
nv *env,
 	return 0;
 }
=20
+static void invalidate_non_owning_refs(struct bpf_verifier_env *env,
+				       struct bpf_active_lock *lock)
+{
+	struct bpf_func_state *unused;
+	struct bpf_reg_state *reg;
+
+	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
+		if (reg->non_owning_ref_lock.ptr &&
+		    reg->non_owning_ref_lock.ptr =3D=3D lock->ptr &&
+		    reg->non_owning_ref_lock.id =3D=3D lock->id)
+			__mark_reg_unknown(env, reg);
+	}));
+}
+
 static void clear_caller_saved_regs(struct bpf_verifier_env *env,
 				    struct bpf_reg_state *regs)
 {
@@ -8674,38 +8709,55 @@ static int process_kf_arg_ptr_to_kptr(struct bpf_=
verifier_env *env,
 	return 0;
 }
=20
-static int ref_set_release_on_unlock(struct bpf_verifier_env *env, u32 r=
ef_obj_id)
+static int ref_set_non_owning_lock(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg)
 {
-	struct bpf_func_state *state =3D cur_func(env);
+	struct bpf_verifier_state *state =3D env->cur_state;
+
+	if (!state->active_lock.ptr) {
+		verbose(env, "verifier internal error: ref_set_non_owning_lock w/o act=
ive lock\n");
+		return -EFAULT;
+	}
+
+	if (reg->non_owning_ref_lock.ptr) {
+		verbose(env, "verifier internal error: non_owning_ref_lock already set=
\n");
+		return -EFAULT;
+	}
+
+	reg->non_owning_ref_lock.id =3D state->active_lock.id;
+	reg->non_owning_ref_lock.ptr =3D state->active_lock.ptr;
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
+				ref_set_non_owning_lock(env, reg);
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
@@ -8840,7 +8892,6 @@ static int process_kf_arg_ptr_to_list_node(struct b=
pf_verifier_env *env,
 {
 	const struct btf_type *et, *t;
 	struct btf_field *field;
-	struct btf_record *rec;
 	u32 list_node_off;
=20
 	if (meta->btf !=3D btf_vmlinux ||
@@ -8857,9 +8908,8 @@ static int process_kf_arg_ptr_to_list_node(struct b=
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
@@ -8885,8 +8935,8 @@ static int process_kf_arg_ptr_to_list_node(struct b=
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
@@ -9156,11 +9206,11 @@ static int check_kfunc_call(struct bpf_verifier_e=
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
@@ -9255,6 +9305,24 @@ static int check_kfunc_call(struct bpf_verifier_en=
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
--=20
2.30.2

