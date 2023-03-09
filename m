Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D30F6B180E
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 01:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCIAp3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 19:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCIAp2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 19:45:28 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C539F82A8E
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 16:45:26 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328NbJhI024134
        for <bpf@vger.kernel.org>; Wed, 8 Mar 2023 16:45:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=Ce3IePMLMpei05Af8DwAc1qfosCrp7QKrC/0qT3LebQ=;
 b=pwq6mUxK9xwHWI5C3XNqGfNP0cTbnwqyCX8Wf0Uq/SvvcHfiRNL+bPVCKV8/RH0Mp8zC
 eMfyhOgAx+63Kru00XKuJIUwOa6qnYR4L7+MdPBYJjQugdXTBVVz+HNZ8ZHv9HMpu7lC
 FIa8L8r9N0aVeyZibE2IuSYmILAYdKzEsTM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p746p0ff1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 16:45:25 -0800
Received: from twshared6412.04.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 8 Mar 2023 16:45:11 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 1FDC218D887F1; Wed,  8 Mar 2023 16:45:06 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v4 bpf-next] bpf: Refactor release_regno searching logic
Date:   Wed, 8 Mar 2023 16:45:04 -0800
Message-ID: <20230309004504.1153898-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OAxj52pSjlEsFUPYJOQItV6wZtMSsbgb
X-Proofpoint-GUID: OAxj52pSjlEsFUPYJOQItV6wZtMSsbgb
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Changelog:

v3 -> v4: https://lore.kernel.org/bpf/20230214190551.2264057-1-davemarchevs=
ky@fb.com/
 * Remove unneeded cur_regs(env) (Joanne)
 * Remove unneeded is_kfunc_release check (Joanne)
 * Rebase onto latest bpf-next: "Merge branch 'BPF open-coded iterators'"

v2 -> v3: https://lore.kernel.org/bpf/20230131171038.2648165-1-davemarchevs=
ky@fb.com/
 * Edit patch summary for clarity
 * Correct err_multi comment in args_find_ref_obj_id_regno doc string
 * Rebase onto latest bpf-next: 'Revert "bpf: Add --skip_encoding_btf_incon=
sistent_proto, --btf_gen_optimized to pahole flags for v1.25"'

v1 -> v2: https://lore.kernel.org/bpf/20230121002417.1684602-1-davemarchevs=
ky@fb.com/
 * Fix uninitialized variable complaint (kernel test bot)
 * Add err_multi param to args_find_ref_obj_id_regno - kfunc arg reg
   checking wasn't erroring if multiple ref_obj_id arg regs were found,
   retain this behavior

v0 -> v1: https://lore.kernel.org/bpf/20221217082506.1570898-2-davemarchevs=
ky@fb.com/
 * Remove allow_multi from args_find_ref_obj_id_regno, no need to
   support multiple ref_obj_id arg regs
 * No need to use temp variable 'i' to count nargs (David)
 * Proper formatting of function-level comments on newly-added helpers (Dav=
id)


 kernel/bpf/verifier.c | 220 +++++++++++++++++++++++++++++-------------
 1 file changed, 153 insertions(+), 67 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 45a082284464..08898c1fb447 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7425,48 +7425,6 @@ static int check_func_arg(struct bpf_verifier_env *e=
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
-				spi =3D dynptr_get_spi(env, reg);
-				if (spi < 0 || !state->stack[spi].spilled_ptr.ref_obj_id) {
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
@@ -7581,6 +7539,26 @@ static int check_func_arg(struct bpf_verifier_env *e=
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
+				spi =3D dynptr_get_spi(env, reg);
+				if (spi < 0 || !state->stack[spi].spilled_ptr.ref_obj_id) {
+					verbose(env, "arg %d is an unacquired reference\n", regno);
+					return -EINVAL;
+				}
+			} else {
+				verbose(env, "cannot release unowned const bpf_dynptr\n");
+				return -EINVAL;
+			}
+		}
 		err =3D process_dynptr_func(env, regno, insn_idx, arg_type);
 		if (err)
 			return err;
@@ -8797,10 +8775,95 @@ static void update_loop_inline_state(struct bpf_ver=
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
+ * @err_multi: Should this function error if multiple ref_obj_id args found
+ *
+ * Call arg meta's ref_obj_id is used to either:
+ * * For release funcs, keep track of ref that needs to be released
+ * * For other funcs, keep track of ref that needs to be propagated to ret=
val
+ *
+ * Find the arg regno with nonzero ref_obj_id
+ *
+ * If err_multi is false and multiple ref_obj_id arg regs are seen, regno =
of the
+ * last one is returned
+ *
+ * Return:
+ * * On success, regno that should become meta->ref_obj_id (regno > 0 since
+ *   BPF_REG_1 is first arg
+ * * 0 if no arg had ref_obj_id set
+ * * -err if some invalid arg reg state
+ */
+static int args_find_ref_obj_id_regno(struct bpf_verifier_env *env, struct=
 bpf_reg_state *regs,
+				      u32 nargs, bool err_multi)
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
+		if (found_regno && err_multi) {
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
@@ -8808,7 +8871,6 @@ static int check_helper_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn
 	struct bpf_call_arg_meta meta;
 	int insn_idx =3D *insn_idx_p;
 	bool changes_data;
-	int i, err, func_id;
=20
 	/* find function prototype */
 	func_id =3D insn->imm;
@@ -8872,8 +8934,37 @@ static int check_helper_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn
 	}
=20
 	meta.func_id =3D func_id;
+	regs =3D cur_regs(env);
+
+	/* find actual arg count */
+	for (nargs =3D 0; nargs < MAX_BPF_FUNC_REG_ARGS; nargs++)
+		if (fn->arg_type[nargs] =3D=3D ARG_DONTCARE)
+			break;
+
+	release_regno =3D helper_proto_find_release_arg_regno(env, fn, nargs);
+	if (release_regno < 0)
+		return release_regno;
+
+	ref_regno =3D args_find_ref_obj_id_regno(env, regs, nargs, true);
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
 		err =3D check_func_arg(env, i, &meta, fn, insn_idx);
 		if (err)
 			return err;
@@ -8897,8 +8988,6 @@ static int check_helper_call(struct bpf_verifier_env =
*env, struct bpf_insn *insn
 			return err;
 	}
=20
-	regs =3D cur_regs(env);
-
 	if (meta.release_regno) {
 		err =3D -EINVAL;
 		/* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
@@ -10137,10 +10226,11 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 			    int insn_idx)
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
@@ -10150,17 +10240,31 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 		return -EINVAL;
 	}
=20
+	ref_regno =3D args_find_ref_obj_id_regno(env, regs, nargs, false);
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
@@ -10223,18 +10327,6 @@ static int check_kfunc_args(struct bpf_verifier_en=
v *env, struct bpf_kfunc_call_
 			return -EACCES;
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
@@ -10281,7 +10373,7 @@ static int check_kfunc_args(struct bpf_verifier_env=
 *env, struct bpf_kfunc_call_
 			return -EFAULT;
 		}
=20
-		if (is_kfunc_release(meta) && reg->ref_obj_id)
+		if (regno =3D=3D meta->release_regno)
 			arg_type |=3D OBJ_RELEASE;
 		ret =3D check_func_arg_reg_off(env, reg, regno, arg_type);
 		if (ret < 0)
@@ -10494,12 +10586,6 @@ static int check_kfunc_args(struct bpf_verifier_en=
v *env, struct bpf_kfunc_call_
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
2.34.1

