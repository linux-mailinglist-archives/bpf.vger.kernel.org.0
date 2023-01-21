Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597C367625F
	for <lists+bpf@lfdr.de>; Sat, 21 Jan 2023 01:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjAUA0A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 19:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjAUA0A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 19:26:00 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9731421D
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:25:22 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KMuivp014370
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:24:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=GGcHHzhUAPQXs8Rj7cxvgIFWeGBy7PNVz2TCRl0tdj0=;
 b=MGpfKEm0/tH4G8kdrNK2Ys+fbIDMWnr6zX1EINIpvNmgQdf8wQqGfVrPPFNekte8d4zJ
 tfBF6YkydWjbppmVSDOP8s8+Dk8zI0LuzG5Eeaoq58K1YaDMiAf0EHVdo3AoXKt4dWUc
 HxyrcDVrVtiGuDrKuaN0rdzLxaQEdAnHIV8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n6tvvpngr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:24:29 -0800
Received: from twshared22340.15.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 16:24:28 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 613F014F495E4; Fri, 20 Jan 2023 16:24:18 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next] bpf: Refactor release_regno searching logic
Date:   Fri, 20 Jan 2023 16:24:17 -0800
Message-ID: <20230121002417.1684602-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: i-BLJi7Xircxim4hoFzUUlJSdqGFYqb3
X-Proofpoint-GUID: i-BLJi7Xircxim4hoFzUUlJSdqGFYqb3
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_13,2023-01-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kfuncs marked KF_RELEASE indicate that they release some
previously-acquired arg. The verifier assumes that such a function will
only have one arg reg w/ ref_obj_id set, and that that arg is the one to
be released. Multiple kfunc arg regs have ref_obj_id set is considered
an invalid state.

For helpers, OBJ_RELEASE is used to tag a particular arg in the function
proto, not the function itself. The arg with OBJ_RELEASE type tag is the
arg that the helper will release. There can only be one such tagged arg.
When verifying arg regs, multiple helper arg regs w/ ref_obj_id set is
also considered an invalid state.

Currently the ref_obj_id and OBJ_RELEASE searching is done in the code
that examines each individual arg (check_func_arg for helpers and
check_kfunc_args inner loop for kfuncs). This patch pulls out this
searching to occur before individual arg type handling, resulting in a
cleaner separation of logic and shared logic between kfuncs and helpers.

Two new helper functions are added:
  * args_find_ref_obj_id_regno
    * For helpers and kfuncs. Searches through arg regs to find
      ref_obj_id reg and returns its regno.

  * helper_proto_find_release_arg_regno
    * For helpers only. Searches through fn proto args to find the
      OBJ_RELEASE arg and returns the corresponding regno.

The refactoring strives to keep failure logic and error messages
unchanged. However, because the release arg searching is now done before
any arg-specific type checking, verifier states that are invalid due to
both invalid release arg state _and_ some type- or helper-specific
checking logic might see the release arg-related error message first,
when previously verification would fail for the other reason.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
This patch appeared in a rbtree series, but is no longer necessary for
that work. Regardless, it's independently useful as it pulls out some
logic common to kfunc and helper verification. The rbtree version added
some additional functionality, while this patch doesn't, so it's not
marked as a v2 of that patch.

Regardless, including changelog as there was some feedback on that patch
which is addressed here.

v0 -> v1: https://lore.kernel.org/bpf/20221217082506.1570898-2-davemarchevs=
ky@fb.com/
 * Remove allow_multi from args_find_ref_obj_id_regno, no need to
   support multiple ref_obj_id arg regs
 * No need to use temp variable 'i' to count nargs (David)
 * Proper formatting of function-level comments on newly-added helpers (Dav=
id)

 kernel/bpf/verifier.c | 218 +++++++++++++++++++++++++++++-------------
 1 file changed, 150 insertions(+), 68 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ca7db2ce70b9..99b76202c3b6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6418,49 +6418,6 @@ static int check_func_arg(struct bpf_verifier_env *e=
nv, u32 arg,
 		return err;
=20
 skip_type_check:
-	if (arg_type_is_release(arg_type)) {
-		if (arg_type_is_dynptr(arg_type)) {
-			struct bpf_func_state *state =3D func(env, reg);
-			int spi;
-
-			/* Only dynptr created on stack can be released, thus
-			 * the get_spi and stack state checks for spilled_ptr
-			 * should only be done before process_dynptr_func for
-			 * PTR_TO_STACK.
-			 */
-			if (reg->type =3D=3D PTR_TO_STACK) {
-				spi =3D get_spi(reg->off);
-				if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
-				    !state->stack[spi].spilled_ptr.ref_obj_id) {
-					verbose(env, "arg %d is an unacquired reference\n", regno);
-					return -EINVAL;
-				}
-			} else {
-				verbose(env, "cannot release unowned const bpf_dynptr\n");
-				return -EINVAL;
-			}
-		} else if (!reg->ref_obj_id && !register_is_null(reg)) {
-			verbose(env, "R%d must be referenced when passed to release function\n",
-				regno);
-			return -EINVAL;
-		}
-		if (meta->release_regno) {
-			verbose(env, "verifier internal error: more than one release argument\n=
");
-			return -EFAULT;
-		}
-		meta->release_regno =3D regno;
-	}
-
-	if (reg->ref_obj_id) {
-		if (meta->ref_obj_id) {
-			verbose(env, "verifier internal error: more than one arg with ref_obj_i=
d R%d %u %u\n",
-				regno, reg->ref_obj_id,
-				meta->ref_obj_id);
-			return -EFAULT;
-		}
-		meta->ref_obj_id =3D reg->ref_obj_id;
-	}
-
 	switch (base_type(arg_type)) {
 	case ARG_CONST_MAP_PTR:
 		/* bpf_map_xxx(map_ptr) call: remember that map_ptr */
@@ -6571,6 +6528,27 @@ static int check_func_arg(struct bpf_verifier_env *e=
nv, u32 arg,
 		err =3D check_mem_size_reg(env, reg, regno, true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
+		if (meta->release_regno =3D=3D regno) {
+			struct bpf_func_state *state =3D func(env, reg);
+			int spi;
+
+			/* Only dynptr created on stack can be released, thus
+			 * the get_spi and stack state checks for spilled_ptr
+			 * should only be done before process_dynptr_func for
+			 * PTR_TO_STACK.
+			 */
+			if (reg->type =3D=3D PTR_TO_STACK) {
+				spi =3D get_spi(reg->off);
+				if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
+				    !state->stack[spi].spilled_ptr.ref_obj_id) {
+					verbose(env, "arg %d is an unacquired reference\n", regno);
+					return -EINVAL;
+				}
+			} else {
+				verbose(env, "cannot release unowned const bpf_dynptr\n");
+				return -EINVAL;
+			}
+		}
 		err =3D process_dynptr_func(env, regno, arg_type, meta);
 		if (err)
 			return err;
@@ -7706,10 +7684,91 @@ static void update_loop_inline_state(struct bpf_ver=
ifier_env *env, u32 subprogno
 				 state->callback_subprogno =3D=3D subprogno);
 }
=20
+/**
+ * args_find_ref_obj_id_regno() - Find regno that should become meta->ref_=
obj_id
+ * @env: Verifier env
+ * @regs: Regs to search for ref_obj_id
+ * @nargs: Number of arg regs to search
+ *
+ * Call arg meta's ref_obj_id is used to either:
+ * * For release funcs, keep track of ref that needs to be released
+ * * For other funcs, keep track of ref that needs to be propagated to ret=
val
+ *
+ * Find the arg regno with nonzero ref_obj_id
+ *
+ * Return:
+ * * On success, regno that should become meta->ref_obj_id (regno > 0 since
+ *   BPF_REG_1 is first arg
+ * * 0 if no arg had ref_obj_id set
+ * * -err if some invalid arg reg state
+ */
+static int args_find_ref_obj_id_regno(struct bpf_verifier_env *env, struct=
 bpf_reg_state *regs,
+				      u32 nargs)
+{
+	struct bpf_reg_state *reg;
+	u32 i, regno, found_regno =3D 0;
+
+	for (i =3D 0; i < nargs; i++) {
+		regno =3D i + BPF_REG_1;
+		reg =3D &regs[regno];
+
+		if (!reg->ref_obj_id)
+			continue;
+
+		if (found_regno) {
+			verbose(env, "verifier internal error: more than one arg with ref_obj_i=
d R%d %u %u\n",
+				regno, reg->ref_obj_id, regs[found_regno].ref_obj_id);
+			return -EFAULT;
+		}
+
+		found_regno =3D regno;
+	}
+
+	return found_regno;
+}
+
+/**
+ * helper_proto_find_release_arg_regno() - Find OBJ_RELEASE arg in func pr=
oto
+ * @env: Verifier env
+ * @fn: Func proto to search for OBJ_RELEASE
+ * @nargs: Number of arg specs to search
+ *
+ * For helpers, to determine which arg reg should be released, loop through
+ * func proto arg specification to find arg with OBJ_RELEASE
+ *
+ * Return:
+ * * On success, regno of single OBJ_RELEASE arg
+ * * 0 if no arg in the proto was OBJ_RELEASE
+ * * -err if some invalid func proto state
+ */
+static int helper_proto_find_release_arg_regno(struct bpf_verifier_env *en=
v,
+					       const struct bpf_func_proto *fn, u32 nargs)
+{
+	enum bpf_arg_type arg_type;
+	int i, release_regno =3D 0;
+
+	for (i =3D 0; i < nargs; i++) {
+		arg_type =3D fn->arg_type[i];
+
+		if (!arg_type_is_release(arg_type))
+			continue;
+
+		if (release_regno) {
+			verbose(env, "verifier internal error: more than one release argument\n=
");
+			return -EFAULT;
+		}
+
+		release_regno =3D i + BPF_REG_1;
+	}
+
+	return release_regno;
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn=
 *insn,
 			     int *insn_idx_p)
 {
 	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
+	int i, err, func_id, nargs, release_regno, ref_regno;
 	const struct bpf_func_proto *fn =3D NULL;
 	enum bpf_return_type ret_type;
 	enum bpf_type_flag ret_flag;
@@ -7717,7 +7776,6 @@ static int check_helper_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn
 	struct bpf_call_arg_meta meta;
 	int insn_idx =3D *insn_idx_p;
 	bool changes_data;
-	int i, err, func_id;
=20
 	/* find function prototype */
 	func_id =3D insn->imm;
@@ -7781,8 +7839,37 @@ static int check_helper_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn
 	}
=20
 	meta.func_id =3D func_id;
+	regs =3D cur_regs(env);
+
+	/* find actual arg count */
+	for (nargs =3D 0; nargs < MAX_BPF_FUNC_REG_ARGS; nargs++)
+		if (fn->arg_type[i] =3D=3D ARG_DONTCARE)
+			break;
+
+	release_regno =3D helper_proto_find_release_arg_regno(env, fn, nargs);
+	if (release_regno < 0)
+		return release_regno;
+
+	ref_regno =3D args_find_ref_obj_id_regno(env, regs, nargs);
+	if (ref_regno < 0)
+		return ref_regno;
+	else if (ref_regno > 0)
+		meta.ref_obj_id =3D regs[ref_regno].ref_obj_id;
+
+	if (release_regno > 0) {
+		if (!regs[release_regno].ref_obj_id &&
+		    !register_is_null(&regs[release_regno]) &&
+		    !arg_type_is_dynptr(fn->arg_type[release_regno - BPF_REG_1])) {
+			verbose(env, "R%d must be referenced when passed to release function\n",
+				release_regno);
+			return -EINVAL;
+		}
+
+		meta.release_regno =3D release_regno;
+	}
+
 	/* check args */
-	for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
+	for (i =3D 0; i < nargs; i++) {
 		err =3D check_func_arg(env, i, &meta, fn);
 		if (err)
 			return err;
@@ -7806,8 +7893,6 @@ static int check_helper_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn
 			return err;
 	}
=20
-	regs =3D cur_regs(env);
-
 	/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
 	 * be reinitialized by any dynptr helper. Hence, mark_stack_slots_dynptr
 	 * is safe to do directly.
@@ -8803,10 +8888,11 @@ static int process_kf_arg_ptr_to_list_node(struct b=
pf_verifier_env *env,
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc=
_call_arg_meta *meta)
 {
 	const char *func_name =3D meta->func_name, *ref_tname;
+	struct bpf_reg_state *regs =3D cur_regs(env);
 	const struct btf *btf =3D meta->btf;
 	const struct btf_param *args;
+	int ret, ref_regno;
 	u32 i, nargs;
-	int ret;
=20
 	args =3D (const struct btf_param *)(meta->func_proto + 1);
 	nargs =3D btf_type_vlen(meta->func_proto);
@@ -8816,17 +8902,31 @@ static int check_kfunc_args(struct bpf_verifier_env=
 *env, struct bpf_kfunc_call_
 		return -EINVAL;
 	}
=20
+	ref_regno =3D args_find_ref_obj_id_regno(env, cur_regs(env), nargs);
+	if (ref_regno < 0) {
+		return ref_regno;
+	} else if (!ref_regno && is_kfunc_release(meta)) {
+		verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF_I=
D\n",
+			func_name);
+		return -EINVAL;
+	}
+
+	meta->ref_obj_id =3D regs[ref_regno].ref_obj_id;
+	if (is_kfunc_release(meta))
+		meta->release_regno =3D ref_regno;
+
 	/* Check that BTF function arguments match actual types that the
 	 * verifier sees.
 	 */
 	for (i =3D 0; i < nargs; i++) {
-		struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[i + 1];
 		const struct btf_type *t, *ref_t, *resolve_ret;
 		enum bpf_arg_type arg_type =3D ARG_DONTCARE;
 		u32 regno =3D i + 1, ref_id, type_size;
 		bool is_ret_buf_sz =3D false;
+		struct bpf_reg_state *reg;
 		int kf_arg_type;
=20
+		reg =3D &regs[regno];
 		t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
=20
 		if (is_kfunc_arg_ignore(btf, &args[i]))
@@ -8883,18 +8983,6 @@ static int check_kfunc_args(struct bpf_verifier_env =
*env, struct bpf_kfunc_call_
 			return -EINVAL;
 		}
=20
-		if (reg->ref_obj_id) {
-			if (is_kfunc_release(meta) && meta->ref_obj_id) {
-				verbose(env, "verifier internal error: more than one arg with ref_obj_=
id R%d %u %u\n",
-					regno, reg->ref_obj_id,
-					meta->ref_obj_id);
-				return -EFAULT;
-			}
-			meta->ref_obj_id =3D reg->ref_obj_id;
-			if (is_kfunc_release(meta))
-				meta->release_regno =3D regno;
-		}
-
 		ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
=20
@@ -8937,7 +9025,7 @@ static int check_kfunc_args(struct bpf_verifier_env *=
env, struct bpf_kfunc_call_
 			return -EFAULT;
 		}
=20
-		if (is_kfunc_release(meta) && reg->ref_obj_id)
+		if (is_kfunc_release(meta) && regno =3D=3D meta->release_regno)
 			arg_type |=3D OBJ_RELEASE;
 		ret =3D check_func_arg_reg_off(env, reg, regno, arg_type);
 		if (ret < 0)
@@ -9057,12 +9145,6 @@ static int check_kfunc_args(struct bpf_verifier_env =
*env, struct bpf_kfunc_call_
 		}
 	}
=20
-	if (is_kfunc_release(meta) && !meta->release_regno) {
-		verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF_I=
D\n",
-			func_name);
-		return -EINVAL;
-	}
-
 	return 0;
 }
=20
--=20
2.30.2

