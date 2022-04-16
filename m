Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DA950348D
	for <lists+bpf@lfdr.de>; Sat, 16 Apr 2022 08:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiDPGzy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 16 Apr 2022 02:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDPGzy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Apr 2022 02:55:54 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C8B10EC44
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 23:53:22 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 82DE1B1DE619; Fri, 15 Apr 2022 23:35:39 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, memxor@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, toke@redhat.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v2 2/7] bpf: Add OBJ_RELEASE as a bpf_type_flag
Date:   Fri, 15 Apr 2022 23:34:24 -0700
Message-Id: <20220416063429.3314021-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220416063429.3314021-1-joannelkoong@gmail.com>
References: <20220416063429.3314021-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, we hardcode in the verifier which functions are release
functions. We have no way of differentiating which argument is the one
to be released (we assume it will always be the first argument).

This patch adds OBJ_RELEASE as a bpf_type_flag. This allows us to
determine which argument in the function needs to be released, and
removes having to hardcode a list of release functions into the
verifier.

Please note that currently, we only support one release argument in a
helper function. In the future, if/when we need to support several
release arguments within the function, OBJ_RELEASE is necessary
since there needs to be a way of differentiating which arguments are the
release ones.

In the near future, OBJ_RELEASE will be used by dynptr helper functions
such as bpf_dynptr_put.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/bpf.h          |  4 +++-
 include/linux/bpf_verifier.h |  3 +--
 kernel/bpf/btf.c             |  3 ++-
 kernel/bpf/ringbuf.c         |  4 ++--
 kernel/bpf/verifier.c        | 44 +++++++++++++++++-------------------
 net/core/filter.c            |  2 +-
 6 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 12b90de9c46d..29964cdb1dd6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -344,7 +344,9 @@ enum bpf_type_flag {
=20
 	MEM_UNINIT		=3D BIT(5 + BPF_BASE_TYPE_BITS),
=20
-	__BPF_TYPE_LAST_FLAG	=3D MEM_UNINIT,
+	OBJ_RELEASE		=3D BIT(6 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	=3D OBJ_RELEASE,
 };
=20
 /* Max number of base types. */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c1fc4af47f69..7a01adc9e13f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -523,8 +523,7 @@ int check_ptr_off_reg(struct bpf_verifier_env *env,
 		      const struct bpf_reg_state *reg, int regno);
 int check_func_arg_reg_off(struct bpf_verifier_env *env,
 			   const struct bpf_reg_state *reg, int regno,
-			   enum bpf_arg_type arg_type,
-			   bool is_release_func);
+			   enum bpf_arg_type arg_type, bool arg_release);
 int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_re=
g_state *reg,
 			     u32 regno);
 int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *re=
g,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0918a39279f6..e5b765a84aec 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5830,7 +5830,8 @@ static int btf_check_func_arg_match(struct bpf_veri=
fier_env *env,
 		ref_t =3D btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
=20
-		ret =3D check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE, rel);
+		ret =3D check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE,
+					     rel && reg->ref_obj_id);
 		if (ret < 0)
 			return ret;
=20
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 710ba9de12ce..5173fd37590f 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -404,7 +404,7 @@ BPF_CALL_2(bpf_ringbuf_submit, void *, sample, u64, f=
lags)
 const struct bpf_func_proto bpf_ringbuf_submit_proto =3D {
 	.func		=3D bpf_ringbuf_submit,
 	.ret_type	=3D RET_VOID,
-	.arg1_type	=3D ARG_PTR_TO_ALLOC_MEM,
+	.arg1_type	=3D ARG_PTR_TO_ALLOC_MEM | OBJ_RELEASE,
 	.arg2_type	=3D ARG_ANYTHING,
 };
=20
@@ -417,7 +417,7 @@ BPF_CALL_2(bpf_ringbuf_discard, void *, sample, u64, =
flags)
 const struct bpf_func_proto bpf_ringbuf_discard_proto =3D {
 	.func		=3D bpf_ringbuf_discard,
 	.ret_type	=3D RET_VOID,
-	.arg1_type	=3D ARG_PTR_TO_ALLOC_MEM,
+	.arg1_type	=3D ARG_PTR_TO_ALLOC_MEM | OBJ_RELEASE,
 	.arg2_type	=3D ARG_ANYTHING,
 };
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 355566979e36..8deb588a19ce 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -257,6 +257,7 @@ struct bpf_call_arg_meta {
 	struct btf *ret_btf;
 	u32 ret_btf_id;
 	u32 subprogno;
+	bool release_ref;
 };
=20
 struct btf *btf_vmlinux;
@@ -471,17 +472,6 @@ static bool type_may_be_null(u32 type)
 	return type & PTR_MAYBE_NULL;
 }
=20
-/* Determine whether the function releases some resources allocated by a=
nother
- * function call. The first reference type argument will be assumed to b=
e
- * released by release_reference().
- */
-static bool is_release_function(enum bpf_func_id func_id)
-{
-	return func_id =3D=3D BPF_FUNC_sk_release ||
-	       func_id =3D=3D BPF_FUNC_ringbuf_submit ||
-	       func_id =3D=3D BPF_FUNC_ringbuf_discard;
-}
-
 static bool may_be_acquire_function(enum bpf_func_id func_id)
 {
 	return func_id =3D=3D BPF_FUNC_sk_lookup_tcp ||
@@ -5359,11 +5349,10 @@ static int check_reg_type(struct bpf_verifier_env=
 *env, u32 regno,
=20
 int check_func_arg_reg_off(struct bpf_verifier_env *env,
 			   const struct bpf_reg_state *reg, int regno,
-			   enum bpf_arg_type arg_type,
-			   bool is_release_func)
+			   enum bpf_arg_type arg_type, bool arg_release)
 {
-	bool fixed_off_ok =3D false, release_reg;
 	enum bpf_reg_type type =3D reg->type;
+	bool fixed_off_ok =3D false;
=20
 	switch ((u32)type) {
 	case SCALAR_VALUE:
@@ -5388,18 +5377,15 @@ int check_func_arg_reg_off(struct bpf_verifier_en=
v *env,
 	 * fixed offset.
 	 */
 	case PTR_TO_BTF_ID:
-		/* When referenced PTR_TO_BTF_ID is passed to release function,
-		 * it's fixed offset must be 0. We rely on the property that
-		 * only one referenced register can be passed to BPF helpers and
-		 * kfuncs. In the other cases, fixed offset can be non-zero.
+		/* If a referenced PTR_TO_BTF_ID will be released, its fixed offset
+		 * must be 0.
 		 */
-		release_reg =3D is_release_func && reg->ref_obj_id;
-		if (release_reg && reg->off) {
+		if (arg_release && reg->off) {
 			verbose(env, "R%d must have zero offset when passed to release func\n=
",
 				regno);
 			return -EINVAL;
 		}
-		/* For release_reg =3D=3D true, fixed_off_ok must be false, but we
+		/* For arg_release =3D=3D true, fixed_off_ok must be false, but we
 		 * already checked and rejected reg->off !=3D 0 above, so set to
 		 * true to allow fixed offset for all other cases.
 		 */
@@ -5459,7 +5445,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
 	if (err)
 		return err;
=20
-	err =3D check_func_arg_reg_off(env, reg, regno, arg_type, is_release_fu=
nction(meta->func_id));
+	err =3D check_func_arg_reg_off(env, reg, regno, arg_type, arg_type & OB=
J_RELEASE);
 	if (err)
 		return err;
=20
@@ -5476,6 +5462,18 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
 		}
 		meta->ref_obj_id =3D reg->ref_obj_id;
 	}
+	if (arg_type & OBJ_RELEASE) {
+		if (!reg->ref_obj_id) {
+			verbose(env, "arg %d is an unacquired reference\n", regno);
+			return -EINVAL;
+		}
+		if (meta->release_ref) {
+			verbose(env, "verifier internal error: more than one release_ref arg =
R%d\n",
+				regno);
+			return -EFAULT;
+		}
+		meta->release_ref =3D true;
+	}
=20
 	if (arg_type =3D=3D ARG_CONST_MAP_PTR) {
 		/* bpf_map_xxx(map_ptr) call: remember that map_ptr */
@@ -6688,7 +6686,7 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 			return err;
 	}
=20
-	if (is_release_function(func_id)) {
+	if (meta.release_ref) {
 		err =3D release_reference(env, meta.ref_obj_id);
 		if (err) {
 			verbose(env, "func %s#%d reference has not been acquired before\n",
diff --git a/net/core/filter.c b/net/core/filter.c
index 9aafec3a09ed..849611a1a51a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6621,7 +6621,7 @@ static const struct bpf_func_proto bpf_sk_release_p=
roto =3D {
 	.func		=3D bpf_sk_release,
 	.gpl_only	=3D false,
 	.ret_type	=3D RET_INTEGER,
-	.arg1_type	=3D ARG_PTR_TO_BTF_ID_SOCK_COMMON,
+	.arg1_type	=3D ARG_PTR_TO_BTF_ID_SOCK_COMMON | OBJ_RELEASE,
 };
=20
 BPF_CALL_5(bpf_xdp_sk_lookup_udp, struct xdp_buff *, ctx,
--=20
2.30.2

