Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D07513D43
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 23:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352119AbiD1VPk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 17:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352133AbiD1VPj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 17:15:39 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494B27E1E2
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 14:12:07 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id BC96BBAF4BCC; Thu, 28 Apr 2022 14:11:51 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, memxor@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, toke@redhat.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v3 1/6] bpf: Add MEM_UNINIT as a bpf_type_flag
Date:   Thu, 28 Apr 2022 14:10:54 -0700
Message-Id: <20220428211059.4065379-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220428211059.4065379-1-joannelkoong@gmail.com>
References: <20220428211059.4065379-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,TVD_RCVD_IP autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of having uninitialized versions of arguments as separate
bpf_arg_types (eg ARG_PTR_TO_UNINIT_MEM as the uninitialized version
of ARG_PTR_TO_MEM), we can instead use MEM_UNINIT as a bpf_type_flag
modifier to denote that the argument is uninitialized.

Doing so cleans up some of the logic in the verifier. We no longer
need to do two checks against an argument type (eg "if
(base_type(arg_type) =3D=3D ARG_PTR_TO_MEM || base_type(arg_type) =3D=3D
ARG_PTR_TO_UNINIT_MEM)"), since uninitialized and initialized
versions of the same argument type will now share the same base type.

In the near future, MEM_UNINIT will be used by dynptr helper functions
as well.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/bpf.h   | 17 +++++++++--------
 kernel/bpf/helpers.c  |  4 ++--
 kernel/bpf/verifier.c | 26 ++++++++------------------
 3 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index be94833d390a..d0c167865504 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -389,7 +389,9 @@ enum bpf_type_flag {
 	 */
 	PTR_UNTRUSTED		=3D BIT(6 + BPF_BASE_TYPE_BITS),
=20
-	__BPF_TYPE_LAST_FLAG	=3D PTR_UNTRUSTED,
+	MEM_UNINIT		=3D BIT(7 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	=3D MEM_UNINIT,
 };
=20
 /* Max number of base types. */
@@ -408,16 +410,11 @@ enum bpf_arg_type {
 	ARG_CONST_MAP_PTR,	/* const argument used as pointer to bpf_map */
 	ARG_PTR_TO_MAP_KEY,	/* pointer to stack used as map key */
 	ARG_PTR_TO_MAP_VALUE,	/* pointer to stack used as map value */
-	ARG_PTR_TO_UNINIT_MAP_VALUE,	/* pointer to valid memory used to store a=
 map value */
=20
-	/* the following constraints used to prototype bpf_memcmp() and other
-	 * functions that access data on eBPF program stack
+	/* Used to prototype bpf_memcmp() and other functions that access data
+	 * on eBPF program stack
 	 */
 	ARG_PTR_TO_MEM,		/* pointer to valid memory (stack, packet, map value) =
*/
-	ARG_PTR_TO_UNINIT_MEM,	/* pointer to memory does not need to be initial=
ized,
-				 * helper function must fill all bytes or clear
-				 * them in error case.
-				 */
=20
 	ARG_CONST_SIZE,		/* number of bytes accessed from memory */
 	ARG_CONST_SIZE_OR_ZERO,	/* number of bytes accessed from memory or 0 */
@@ -449,6 +446,10 @@ enum bpf_arg_type {
 	ARG_PTR_TO_ALLOC_MEM_OR_NULL	=3D PTR_MAYBE_NULL | ARG_PTR_TO_ALLOC_MEM,
 	ARG_PTR_TO_STACK_OR_NULL	=3D PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
 	ARG_PTR_TO_BTF_ID_OR_NULL	=3D PTR_MAYBE_NULL | ARG_PTR_TO_BTF_ID,
+	/* pointer to memory does not need to be initialized, helper function m=
ust fill
+	 * all bytes or clear them in error case.
+	 */
+	ARG_PTR_TO_UNINIT_MEM		=3D MEM_UNINIT | ARG_PTR_TO_MEM,
=20
 	/* This must be the last entry. Its purpose is to ensure the enum is
 	 * wide enough to hold the higher bits reserved for bpf_type_flag.
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3e709fed5306..8a2398ac14c2 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -103,7 +103,7 @@ const struct bpf_func_proto bpf_map_pop_elem_proto =3D=
 {
 	.gpl_only	=3D false,
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_CONST_MAP_PTR,
-	.arg2_type	=3D ARG_PTR_TO_UNINIT_MAP_VALUE,
+	.arg2_type	=3D ARG_PTR_TO_MAP_VALUE | MEM_UNINIT,
 };
=20
 BPF_CALL_2(bpf_map_peek_elem, struct bpf_map *, map, void *, value)
@@ -116,7 +116,7 @@ const struct bpf_func_proto bpf_map_peek_elem_proto =3D=
 {
 	.gpl_only	=3D false,
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_CONST_MAP_PTR,
-	.arg2_type	=3D ARG_PTR_TO_UNINIT_MAP_VALUE,
+	.arg2_type	=3D ARG_PTR_TO_MAP_VALUE | MEM_UNINIT,
 };
=20
 const struct bpf_func_proto bpf_get_prandom_u32_proto =3D {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 813f6ee80419..4565684839f1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5378,12 +5378,6 @@ static int process_kptr_func(struct bpf_verifier_e=
nv *env, int regno,
 	return 0;
 }
=20
-static bool arg_type_is_mem_ptr(enum bpf_arg_type type)
-{
-	return base_type(type) =3D=3D ARG_PTR_TO_MEM ||
-	       base_type(type) =3D=3D ARG_PTR_TO_UNINIT_MEM;
-}
-
 static bool arg_type_is_mem_size(enum bpf_arg_type type)
 {
 	return type =3D=3D ARG_CONST_SIZE ||
@@ -5523,7 +5517,6 @@ static const struct bpf_reg_types kptr_types =3D { =
.types =3D { PTR_TO_MAP_VALUE } }
 static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_M=
AX] =3D {
 	[ARG_PTR_TO_MAP_KEY]		=3D &map_key_value_types,
 	[ARG_PTR_TO_MAP_VALUE]		=3D &map_key_value_types,
-	[ARG_PTR_TO_UNINIT_MAP_VALUE]	=3D &map_key_value_types,
 	[ARG_CONST_SIZE]		=3D &scalar_types,
 	[ARG_CONST_SIZE_OR_ZERO]	=3D &scalar_types,
 	[ARG_CONST_ALLOC_SIZE_OR_ZERO]	=3D &scalar_types,
@@ -5537,7 +5530,6 @@ static const struct bpf_reg_types *compatible_reg_t=
ypes[__BPF_ARG_TYPE_MAX] =3D {
 	[ARG_PTR_TO_BTF_ID]		=3D &btf_ptr_types,
 	[ARG_PTR_TO_SPIN_LOCK]		=3D &spin_lock_types,
 	[ARG_PTR_TO_MEM]		=3D &mem_types,
-	[ARG_PTR_TO_UNINIT_MEM]		=3D &mem_types,
 	[ARG_PTR_TO_ALLOC_MEM]		=3D &alloc_mem_types,
 	[ARG_PTR_TO_INT]		=3D &int_ptr_types,
 	[ARG_PTR_TO_LONG]		=3D &int_ptr_types,
@@ -5711,8 +5703,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
 		return -EACCES;
 	}
=20
-	if (base_type(arg_type) =3D=3D ARG_PTR_TO_MAP_VALUE ||
-	    base_type(arg_type) =3D=3D ARG_PTR_TO_UNINIT_MAP_VALUE) {
+	if (base_type(arg_type) =3D=3D ARG_PTR_TO_MAP_VALUE) {
 		err =3D resolve_map_arg_type(env, meta, &arg_type);
 		if (err)
 			return err;
@@ -5798,8 +5789,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
 		err =3D check_helper_mem_access(env, regno,
 					      meta->map_ptr->key_size, false,
 					      NULL);
-	} else if (base_type(arg_type) =3D=3D ARG_PTR_TO_MAP_VALUE ||
-		   base_type(arg_type) =3D=3D ARG_PTR_TO_UNINIT_MAP_VALUE) {
+	} else if (base_type(arg_type) =3D=3D ARG_PTR_TO_MAP_VALUE) {
 		if (type_may_be_null(arg_type) && register_is_null(reg))
 			return 0;
=20
@@ -5811,7 +5801,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
 			verbose(env, "invalid map_ptr to access map->value\n");
 			return -EACCES;
 		}
-		meta->raw_mode =3D (arg_type =3D=3D ARG_PTR_TO_UNINIT_MAP_VALUE);
+		meta->raw_mode =3D arg_type & MEM_UNINIT;
 		err =3D check_helper_mem_access(env, regno,
 					      meta->map_ptr->value_size, false,
 					      meta);
@@ -5838,11 +5828,11 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
 			return -EACCES;
 	} else if (arg_type =3D=3D ARG_PTR_TO_FUNC) {
 		meta->subprogno =3D reg->subprogno;
-	} else if (arg_type_is_mem_ptr(arg_type)) {
+	} else if (base_type(arg_type) =3D=3D ARG_PTR_TO_MEM) {
 		/* The access to this pointer is only checked when we hit the
 		 * next is_mem_size argument below.
 		 */
-		meta->raw_mode =3D (arg_type =3D=3D ARG_PTR_TO_UNINIT_MEM);
+		meta->raw_mode =3D arg_type & MEM_UNINIT;
 	} else if (arg_type_is_mem_size(arg_type)) {
 		bool zero_size_allowed =3D (arg_type =3D=3D ARG_CONST_SIZE_OR_ZERO);
=20
@@ -6189,9 +6179,9 @@ static bool check_raw_mode_ok(const struct bpf_func=
_proto *fn)
 static bool check_args_pair_invalid(enum bpf_arg_type arg_curr,
 				    enum bpf_arg_type arg_next)
 {
-	return (arg_type_is_mem_ptr(arg_curr) &&
+	return (base_type(arg_curr) =3D=3D ARG_PTR_TO_MEM &&
 	        !arg_type_is_mem_size(arg_next)) ||
-	       (!arg_type_is_mem_ptr(arg_curr) &&
+	       (base_type(arg_curr) !=3D ARG_PTR_TO_MEM &&
 		arg_type_is_mem_size(arg_next));
 }
=20
@@ -6203,7 +6193,7 @@ static bool check_arg_pair_ok(const struct bpf_func=
_proto *fn)
 	 * helper function specification.
 	 */
 	if (arg_type_is_mem_size(fn->arg1_type) ||
-	    arg_type_is_mem_ptr(fn->arg5_type)  ||
+	    base_type(fn->arg5_type) =3D=3D ARG_PTR_TO_MEM ||
 	    check_args_pair_invalid(fn->arg1_type, fn->arg2_type) ||
 	    check_args_pair_invalid(fn->arg2_type, fn->arg3_type) ||
 	    check_args_pair_invalid(fn->arg3_type, fn->arg4_type) ||
--=20
2.30.2

