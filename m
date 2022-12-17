Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D24B64F832
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 09:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiLQIZX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 03:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiLQIZW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 03:25:22 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAE92F671
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:20 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BH5qkwp030537
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=9yXH+9FWKbjALTm/uvReMqMnPQGzcjqDCn+aWUOEg6o=;
 b=csbmpvpK721zkdKUPZGIJL/8W/0+k92KhheI0t2uTTk4yz/yDp68hFrAHx3jtmILAuZz
 2TnjwJCC/Vz0MAlzKYMGV+YWhTndv1YQ1Cnj4AfUOVLkyFr39el3nUEXIu2M9huur2mS
 mi2btTBn2z/y9UAFHz7ECJbYLJJVclerMPo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mh6uj8mng-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:25:19 -0800
Received: from twshared19053.17.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 17 Dec 2022 00:25:18 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id CA04512A9DFA3; Sat, 17 Dec 2022 00:25:11 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 01/13] bpf: Support multiple arg regs w/ ref_obj_id for kfuncs
Date:   Sat, 17 Dec 2022 00:24:54 -0800
Message-ID: <20221217082506.1570898-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221217082506.1570898-1-davemarchevsky@fb.com>
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: HKmg48cWBHvmKa36zdyCE9eZACQt1lOe
X-Proofpoint-GUID: HKmg48cWBHvmKa36zdyCE9eZACQt1lOe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-17_03,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, kfuncs marked KF_RELEASE indicate that they release some
previously-acquired arg. The verifier assumes that such a function will
only have one arg reg w/ ref_obj_id set, and that that arg is the one to
be released. Multiple kfunc arg regs have ref_obj_id set is considered
an invalid state.

For helpers, RELEASE is used to tag a particular arg in the function
proto, not the function itself. The arg with OBJ_RELEASE type tag is the
arg that the helper will release. There can only be one such tagged arg.
When verifying arg regs, multiple helper arg regs w/ ref_obj_id set is
also considered an invalid state.

Later patches in this series will result in some linked_list helpers
marked KF_RELEASE having a valid reason to take two ref_obj_id args.
Specifically, bpf_list_push_{front,back} can push a node to a list head
which is itself part of a list node. In such a scenario both arguments
to these functions would have ref_obj_id > 0, thus would fail
verification under current logic.

This patch changes kfunc ref_obj_id searching logic to find the last arg
reg w/ ref_obj_id and consider that the reg-to-release. This should be
backwards-compatible with all current kfuncs as they only expect one
such arg reg.

Currently the ref_obj_id and OBJ_RELEASE searching is done in the code
that examines each individual arg (check_func_arg for helpers and
check_kfunc_args inner loop for kfuncs). This patch pulls out this
searching to occur before individual arg type handling, resulting in a
cleaner separation of logic.

Two new helpers are added:
  * args_find_ref_obj_id_regno
    * For helpers and kfuncs. Searches through arg regs to find
      ref_obj_id reg and returns its regno. Helpers set allow_multi =3D
      false, retaining "only one ref_obj_id arg" behavior, while kfuncs
      set allow_multi =3D true and get the last ref_obj_id arg reg back.

  * helper_proto_find_release_arg_regno
    * For helpers only. Searches through fn proto args to find the
      OBJ_RELEASE arg and returns the corresponding regno.

Aside from the intentional semantic change for kfuncs, the rest of the
refactoring strives to keep failure logic and error messages unchanged.
However, because the release arg searching is now done before any
arg-specific type checking, verifier states that are invalid due to both
invalid release arg state _and_ some type- or helper-specific checking
might see release arg-related error message first.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c | 206 ++++++++++++++++++++++++++++--------------
 1 file changed, 138 insertions(+), 68 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a5255a0dcbb6..824e2242eae5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6412,49 +6412,6 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
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
-			verbose(env, "R%d must be referenced when passed to release function\=
n",
-				regno);
-			return -EINVAL;
-		}
-		if (meta->release_regno) {
-			verbose(env, "verifier internal error: more than one release argument=
\n");
-			return -EFAULT;
-		}
-		meta->release_regno =3D regno;
-	}
-
-	if (reg->ref_obj_id) {
-		if (meta->ref_obj_id) {
-			verbose(env, "verifier internal error: more than one arg with ref_obj=
_id R%d %u %u\n",
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
@@ -6565,6 +6522,27 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
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
@@ -7699,10 +7677,78 @@ static void update_loop_inline_state(struct bpf_v=
erifier_env *env, u32 subprogno
 				 state->callback_subprogno =3D=3D subprogno);
 }
=20
+/* Call arg meta's ref_obj_id is used to either:
+ *   - For release funcs, keep track of ref that needs to be released
+ *   - For other funcs, keep track of ref that needs to be propagated to=
 retval
+ *
+ * Find and return:
+ *   - Regno that should become meta->ref_obj_id on success
+ *     (regno > 0 since BPF_REG_1 is first arg)
+ *   - 0 if no arg had ref_obj_id set
+ *   - Negative err if some invalid arg reg state
+ *
+ * allow_multi controls whether multiple args w/ ref_obj_id set is valid
+ *   - true: regno of _last_ such arg reg is returned
+ *   - false: err if multiple args w/ ref_obj_id set are seen
+ */
+static int args_find_ref_obj_id_regno(struct bpf_verifier_env *env, stru=
ct bpf_reg_state *regs,
+				      u32 nargs, bool allow_multi)
+{
+	struct bpf_reg_state *reg;
+	u32 i, regno, found_regno =3D 0;
+
+	for (i =3D 0; i < nargs; i++) {
+		regno =3D i + 1;
+		reg =3D &regs[regno];
+
+		if (!reg->ref_obj_id)
+			continue;
+
+		if (!allow_multi && found_regno) {
+			verbose(env, "verifier internal error: more than one arg with ref_obj=
_id R%d %u %u\n",
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
+/* Find the OBJ_RELEASE arg in helper func proto and return:
+ *   - regno of single OBJ_RELEASE arg
+ *   - 0 if no arg in the proto was OBJ_RELEASE
+ *   - Negative err if some invalid func proto state
+ */
+static int helper_proto_find_release_arg_regno(struct bpf_verifier_env *=
env,
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
+			verbose(env, "verifier internal error: more than one release argument=
\n");
+			return -EFAULT;
+		}
+
+		release_regno =3D i + BPF_REG_1;
+	}
+
+	return release_regno;
+}
+
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_in=
sn *insn,
 			     int *insn_idx_p)
 {
 	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
+	int i, err, func_id, nargs, release_regno, ref_regno;
 	const struct bpf_func_proto *fn =3D NULL;
 	enum bpf_return_type ret_type;
 	enum bpf_type_flag ret_flag;
@@ -7710,7 +7756,6 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 	struct bpf_call_arg_meta meta;
 	int insn_idx =3D *insn_idx_p;
 	bool changes_data;
-	int i, err, func_id;
=20
 	/* find function prototype */
 	func_id =3D insn->imm;
@@ -7774,8 +7819,38 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 	}
=20
 	meta.func_id =3D func_id;
+	regs =3D cur_regs(env);
+
+	/* find actual arg count */
+	for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++)
+		if (fn->arg_type[i] =3D=3D ARG_DONTCARE)
+			break;
+	nargs =3D i;
+
+	release_regno =3D helper_proto_find_release_arg_regno(env, fn, nargs);
+	if (release_regno < 0)
+		return release_regno;
+
+	ref_regno =3D args_find_ref_obj_id_regno(env, regs, nargs, false);
+	if (ref_regno < 0)
+		return ref_regno;
+	else if (ref_regno > 0)
+		meta.ref_obj_id =3D regs[ref_regno].ref_obj_id;
+
+	if (release_regno > 0) {
+		if (!regs[release_regno].ref_obj_id &&
+		    !register_is_null(&regs[release_regno]) &&
+		    !arg_type_is_dynptr(fn->arg_type[release_regno - BPF_REG_1])) {
+			verbose(env, "R%d must be referenced when passed to release function\=
n",
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
@@ -7799,8 +7874,6 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 			return err;
 	}
=20
-	regs =3D cur_regs(env);
-
 	/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
 	 * be reinitialized by any dynptr helper. Hence, mark_stack_slots_dynpt=
r
 	 * is safe to do directly.
@@ -8795,10 +8868,11 @@ static int process_kf_arg_ptr_to_list_node(struct=
 bpf_verifier_env *env,
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfu=
nc_call_arg_meta *meta)
 {
 	const char *func_name =3D meta->func_name, *ref_tname;
+	struct bpf_reg_state *regs =3D cur_regs(env);
 	const struct btf *btf =3D meta->btf;
 	const struct btf_param *args;
 	u32 i, nargs;
-	int ret;
+	int ret, ref_regno;
=20
 	args =3D (const struct btf_param *)(meta->func_proto + 1);
 	nargs =3D btf_type_vlen(meta->func_proto);
@@ -8808,17 +8882,31 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 		return -EINVAL;
 	}
=20
+	ref_regno =3D args_find_ref_obj_id_regno(env, cur_regs(env), nargs, tru=
e);
+	if (ref_regno < 0) {
+		return ref_regno;
+	} else if (!ref_regno && is_kfunc_release(meta)) {
+		verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF=
_ID\n",
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
@@ -8875,18 +8963,6 @@ static int check_kfunc_args(struct bpf_verifier_en=
v *env, struct bpf_kfunc_call_
 			return -EINVAL;
 		}
=20
-		if (reg->ref_obj_id) {
-			if (is_kfunc_release(meta) && meta->ref_obj_id) {
-				verbose(env, "verifier internal error: more than one arg with ref_ob=
j_id R%d %u %u\n",
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
@@ -8929,7 +9005,7 @@ static int check_kfunc_args(struct bpf_verifier_env=
 *env, struct bpf_kfunc_call_
 			return -EFAULT;
 		}
=20
-		if (is_kfunc_release(meta) && reg->ref_obj_id)
+		if (is_kfunc_release(meta) && regno =3D=3D meta->release_regno)
 			arg_type |=3D OBJ_RELEASE;
 		ret =3D check_func_arg_reg_off(env, reg, regno, arg_type);
 		if (ret < 0)
@@ -9049,12 +9125,6 @@ static int check_kfunc_args(struct bpf_verifier_en=
v *env, struct bpf_kfunc_call_
 		}
 	}
=20
-	if (is_kfunc_release(meta) && !meta->release_regno) {
-		verbose(env, "release kernel function %s expects refcounted PTR_TO_BTF=
_ID\n",
-			func_name);
-		return -EINVAL;
-	}
-
 	return 0;
 }
=20
--=20
2.30.2

