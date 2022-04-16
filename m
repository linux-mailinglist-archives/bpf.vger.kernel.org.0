Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22D250348A
	for <lists+bpf@lfdr.de>; Sat, 16 Apr 2022 08:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiDPGx7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 16 Apr 2022 02:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDPGx6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Apr 2022 02:53:58 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6391B10EC44
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 23:51:25 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 03663B1DE616; Fri, 15 Apr 2022 23:35:38 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, memxor@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, toke@redhat.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v2 1/7] bpf: Add MEM_UNINIT as a bpf_type_flag
Date:   Fri, 15 Apr 2022 23:34:23 -0700
Message-Id: <20220416063429.3314021-2-joannelkoong@gmail.com>
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
 include/linux/bpf.h      | 17 +++++++++--------
 kernel/bpf/bpf_lsm.c     |  4 ++--
 kernel/bpf/cgroup.c      |  4 ++--
 kernel/bpf/helpers.c     | 12 ++++++------
 kernel/bpf/stackmap.c    |  6 +++---
 kernel/bpf/verifier.c    | 36 +++++++++++++-----------------------
 kernel/trace/bpf_trace.c | 30 +++++++++++++++---------------
 net/core/filter.c        | 26 +++++++++++++-------------
 8 files changed, 63 insertions(+), 72 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bdb5298735ce..12b90de9c46d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -342,7 +342,9 @@ enum bpf_type_flag {
 	 */
 	MEM_PERCPU		=3D BIT(4 + BPF_BASE_TYPE_BITS),
=20
-	__BPF_TYPE_LAST_FLAG	=3D MEM_PERCPU,
+	MEM_UNINIT		=3D BIT(5 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	=3D MEM_UNINIT,
 };
=20
 /* Max number of base types. */
@@ -361,16 +363,11 @@ enum bpf_arg_type {
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
@@ -400,6 +397,10 @@ enum bpf_arg_type {
 	ARG_PTR_TO_SOCKET_OR_NULL	=3D PTR_MAYBE_NULL | ARG_PTR_TO_SOCKET,
 	ARG_PTR_TO_ALLOC_MEM_OR_NULL	=3D PTR_MAYBE_NULL | ARG_PTR_TO_ALLOC_MEM,
 	ARG_PTR_TO_STACK_OR_NULL	=3D PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
+	/* pointer to memory does not need to be initialized, helper function m=
ust fill
+	 * all bytes or clear them in error case.
+	 */
+	ARG_PTR_TO_MEM_UNINIT		=3D MEM_UNINIT | ARG_PTR_TO_MEM,
=20
 	/* This must be the last entry. Its purpose is to ensure the enum is
 	 * wide enough to hold the higher bits reserved for bpf_type_flag.
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 064eccba641d..11ebadc82e8d 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -94,7 +94,7 @@ static const struct bpf_func_proto bpf_ima_inode_hash_p=
roto =3D {
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	=3D &bpf_ima_inode_hash_btf_ids[0],
-	.arg2_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg2_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg3_type	=3D ARG_CONST_SIZE,
 	.allowed	=3D bpf_ima_inode_hash_allowed,
 };
@@ -112,7 +112,7 @@ static const struct bpf_func_proto bpf_ima_file_hash_=
proto =3D {
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	=3D &bpf_ima_file_hash_btf_ids[0],
-	.arg2_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg2_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg3_type	=3D ARG_CONST_SIZE,
 	.allowed	=3D bpf_ima_inode_hash_allowed,
 };
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 128028efda64..4947e3324480 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1724,7 +1724,7 @@ static const struct bpf_func_proto bpf_sysctl_get_c=
urrent_value_proto =3D {
 	.gpl_only	=3D false,
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_CTX,
-	.arg2_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg2_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg3_type	=3D ARG_CONST_SIZE,
 };
=20
@@ -1744,7 +1744,7 @@ static const struct bpf_func_proto bpf_sysctl_get_n=
ew_value_proto =3D {
 	.gpl_only	=3D false,
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_CTX,
-	.arg2_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg2_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg3_type	=3D ARG_CONST_SIZE,
 };
=20
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 315053ef6a75..a47aae5c7335 100644
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
@@ -237,7 +237,7 @@ const struct bpf_func_proto bpf_get_current_comm_prot=
o =3D {
 	.func		=3D bpf_get_current_comm,
 	.gpl_only	=3D false,
 	.ret_type	=3D RET_INTEGER,
-	.arg1_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg1_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg2_type	=3D ARG_CONST_SIZE,
 };
=20
@@ -616,7 +616,7 @@ const struct bpf_func_proto bpf_get_ns_current_pid_tg=
id_proto =3D {
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_ANYTHING,
 	.arg2_type	=3D ARG_ANYTHING,
-	.arg3_type      =3D ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type      =3D ARG_PTR_TO_MEM_UNINIT,
 	.arg4_type      =3D ARG_CONST_SIZE,
 };
=20
@@ -663,7 +663,7 @@ const struct bpf_func_proto bpf_copy_from_user_proto =
=3D {
 	.func		=3D bpf_copy_from_user,
 	.gpl_only	=3D false,
 	.ret_type	=3D RET_INTEGER,
-	.arg1_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg1_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg2_type	=3D ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	=3D ARG_ANYTHING,
 };
@@ -693,7 +693,7 @@ const struct bpf_func_proto bpf_copy_from_user_task_p=
roto =3D {
 	.func		=3D bpf_copy_from_user_task,
 	.gpl_only	=3D true,
 	.ret_type	=3D RET_INTEGER,
-	.arg1_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg1_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg2_type	=3D ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	=3D ARG_ANYTHING,
 	.arg4_type	=3D ARG_PTR_TO_BTF_ID,
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 34725bfa1e97..24fdda340008 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -465,7 +465,7 @@ const struct bpf_func_proto bpf_get_stack_proto =3D {
 	.gpl_only	=3D true,
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_CTX,
-	.arg2_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg2_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg3_type	=3D ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	=3D ARG_ANYTHING,
 };
@@ -493,7 +493,7 @@ const struct bpf_func_proto bpf_get_task_stack_proto =
=3D {
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	=3D &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
-	.arg2_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg2_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg3_type	=3D ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	=3D ARG_ANYTHING,
 };
@@ -556,7 +556,7 @@ const struct bpf_func_proto bpf_get_stack_proto_pe =3D=
 {
 	.gpl_only	=3D true,
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_CTX,
-	.arg2_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg2_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg3_type	=3D ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	=3D ARG_ANYTHING,
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d175b70067b3..355566979e36 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5134,12 +5134,6 @@ static int process_timer_func(struct bpf_verifier_=
env *env, int regno,
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
@@ -5273,7 +5267,6 @@ static const struct bpf_reg_types timer_types =3D {=
 .types =3D { PTR_TO_MAP_VALUE }
 static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_M=
AX] =3D {
 	[ARG_PTR_TO_MAP_KEY]		=3D &map_key_value_types,
 	[ARG_PTR_TO_MAP_VALUE]		=3D &map_key_value_types,
-	[ARG_PTR_TO_UNINIT_MAP_VALUE]	=3D &map_key_value_types,
 	[ARG_CONST_SIZE]		=3D &scalar_types,
 	[ARG_CONST_SIZE_OR_ZERO]	=3D &scalar_types,
 	[ARG_CONST_ALLOC_SIZE_OR_ZERO]	=3D &scalar_types,
@@ -5287,7 +5280,6 @@ static const struct bpf_reg_types *compatible_reg_t=
ypes[__BPF_ARG_TYPE_MAX] =3D {
 	[ARG_PTR_TO_BTF_ID]		=3D &btf_ptr_types,
 	[ARG_PTR_TO_SPIN_LOCK]		=3D &spin_lock_types,
 	[ARG_PTR_TO_MEM]		=3D &mem_types,
-	[ARG_PTR_TO_UNINIT_MEM]		=3D &mem_types,
 	[ARG_PTR_TO_ALLOC_MEM]		=3D &alloc_mem_types,
 	[ARG_PTR_TO_INT]		=3D &int_ptr_types,
 	[ARG_PTR_TO_LONG]		=3D &int_ptr_types,
@@ -5451,8 +5443,7 @@ static int check_func_arg(struct bpf_verifier_env *=
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
@@ -5528,8 +5519,7 @@ static int check_func_arg(struct bpf_verifier_env *=
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
@@ -5541,7 +5531,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
 			verbose(env, "invalid map_ptr to access map->value\n");
 			return -EACCES;
 		}
-		meta->raw_mode =3D (arg_type =3D=3D ARG_PTR_TO_UNINIT_MAP_VALUE);
+		meta->raw_mode =3D arg_type & MEM_UNINIT;
 		err =3D check_helper_mem_access(env, regno,
 					      meta->map_ptr->value_size, false,
 					      meta);
@@ -5568,11 +5558,11 @@ static int check_func_arg(struct bpf_verifier_env=
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
@@ -5894,15 +5884,15 @@ static bool check_raw_mode_ok(const struct bpf_fu=
nc_proto *fn)
 {
 	int count =3D 0;
=20
-	if (fn->arg1_type =3D=3D ARG_PTR_TO_UNINIT_MEM)
+	if (fn->arg1_type =3D=3D ARG_PTR_TO_MEM_UNINIT)
 		count++;
-	if (fn->arg2_type =3D=3D ARG_PTR_TO_UNINIT_MEM)
+	if (fn->arg2_type =3D=3D ARG_PTR_TO_MEM_UNINIT)
 		count++;
-	if (fn->arg3_type =3D=3D ARG_PTR_TO_UNINIT_MEM)
+	if (fn->arg3_type =3D=3D ARG_PTR_TO_MEM_UNINIT)
 		count++;
-	if (fn->arg4_type =3D=3D ARG_PTR_TO_UNINIT_MEM)
+	if (fn->arg4_type =3D=3D ARG_PTR_TO_MEM_UNINIT)
 		count++;
-	if (fn->arg5_type =3D=3D ARG_PTR_TO_UNINIT_MEM)
+	if (fn->arg5_type =3D=3D ARG_PTR_TO_MEM_UNINIT)
 		count++;
=20
 	/* We only support one arg being in raw mode at the moment,
@@ -5915,9 +5905,9 @@ static bool check_raw_mode_ok(const struct bpf_func=
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
@@ -5929,7 +5919,7 @@ static bool check_arg_pair_ok(const struct bpf_func=
_proto *fn)
 	 * helper function specification.
 	 */
 	if (arg_type_is_mem_size(fn->arg1_type) ||
-	    arg_type_is_mem_ptr(fn->arg5_type)  ||
+	    base_type(fn->arg5_type) =3D=3D ARG_PTR_TO_MEM ||
 	    check_args_pair_invalid(fn->arg1_type, fn->arg2_type) ||
 	    check_args_pair_invalid(fn->arg2_type, fn->arg3_type) ||
 	    check_args_pair_invalid(fn->arg3_type, fn->arg4_type) ||
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 7fa2ebc07f60..36fe08097b3b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -175,7 +175,7 @@ const struct bpf_func_proto bpf_probe_read_user_proto=
 =3D {
 	.func		=3D bpf_probe_read_user,
 	.gpl_only	=3D true,
 	.ret_type	=3D RET_INTEGER,
-	.arg1_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg1_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg2_type	=3D ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	=3D ARG_ANYTHING,
 };
@@ -212,7 +212,7 @@ const struct bpf_func_proto bpf_probe_read_user_str_p=
roto =3D {
 	.func		=3D bpf_probe_read_user_str,
 	.gpl_only	=3D true,
 	.ret_type	=3D RET_INTEGER,
-	.arg1_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg1_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg2_type	=3D ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	=3D ARG_ANYTHING,
 };
@@ -238,7 +238,7 @@ const struct bpf_func_proto bpf_probe_read_kernel_pro=
to =3D {
 	.func		=3D bpf_probe_read_kernel,
 	.gpl_only	=3D true,
 	.ret_type	=3D RET_INTEGER,
-	.arg1_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg1_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg2_type	=3D ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	=3D ARG_ANYTHING,
 };
@@ -273,7 +273,7 @@ const struct bpf_func_proto bpf_probe_read_kernel_str=
_proto =3D {
 	.func		=3D bpf_probe_read_kernel_str,
 	.gpl_only	=3D true,
 	.ret_type	=3D RET_INTEGER,
-	.arg1_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg1_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg2_type	=3D ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	=3D ARG_ANYTHING,
 };
@@ -293,7 +293,7 @@ static const struct bpf_func_proto bpf_probe_read_com=
pat_proto =3D {
 	.func		=3D bpf_probe_read_compat,
 	.gpl_only	=3D true,
 	.ret_type	=3D RET_INTEGER,
-	.arg1_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg1_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg2_type	=3D ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	=3D ARG_ANYTHING,
 };
@@ -312,7 +312,7 @@ static const struct bpf_func_proto bpf_probe_read_com=
pat_str_proto =3D {
 	.func		=3D bpf_probe_read_compat_str,
 	.gpl_only	=3D true,
 	.ret_type	=3D RET_INTEGER,
-	.arg1_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg1_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg2_type	=3D ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	=3D ARG_ANYTHING,
 };
@@ -610,7 +610,7 @@ static const struct bpf_func_proto bpf_perf_event_rea=
d_value_proto =3D {
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_CONST_MAP_PTR,
 	.arg2_type	=3D ARG_ANYTHING,
-	.arg3_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg4_type	=3D ARG_CONST_SIZE,
 };
=20
@@ -1112,7 +1112,7 @@ static const struct bpf_func_proto bpf_get_branch_s=
napshot_proto =3D {
 	.func		=3D bpf_get_branch_snapshot,
 	.gpl_only	=3D true,
 	.ret_type	=3D RET_INTEGER,
-	.arg1_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg1_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg2_type	=3D ARG_CONST_SIZE_OR_ZERO,
 };
=20
@@ -1406,7 +1406,7 @@ static const struct bpf_func_proto bpf_get_stack_pr=
oto_tp =3D {
 	.gpl_only	=3D true,
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_CTX,
-	.arg2_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg2_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg3_type	=3D ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	=3D ARG_ANYTHING,
 };
@@ -1469,12 +1469,12 @@ BPF_CALL_3(bpf_perf_prog_read_value, struct bpf_p=
erf_event_data_kern *, ctx,
 }
=20
 static const struct bpf_func_proto bpf_perf_prog_read_value_proto =3D {
-         .func           =3D bpf_perf_prog_read_value,
-         .gpl_only       =3D true,
-         .ret_type       =3D RET_INTEGER,
-         .arg1_type      =3D ARG_PTR_TO_CTX,
-         .arg2_type      =3D ARG_PTR_TO_UNINIT_MEM,
-         .arg3_type      =3D ARG_CONST_SIZE,
+	.func           =3D bpf_perf_prog_read_value,
+	.gpl_only       =3D true,
+	.ret_type       =3D RET_INTEGER,
+	.arg1_type      =3D ARG_PTR_TO_CTX,
+	.arg2_type      =3D ARG_PTR_TO_MEM_UNINIT,
+	.arg3_type      =3D ARG_CONST_SIZE,
 };
=20
 BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, c=
tx,
diff --git a/net/core/filter.c b/net/core/filter.c
index a7044e98765e..9aafec3a09ed 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1743,7 +1743,7 @@ static const struct bpf_func_proto bpf_skb_load_byt=
es_proto =3D {
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_CTX,
 	.arg2_type	=3D ARG_ANYTHING,
-	.arg3_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg4_type	=3D ARG_CONST_SIZE,
 };
=20
@@ -1777,7 +1777,7 @@ static const struct bpf_func_proto bpf_flow_dissect=
or_load_bytes_proto =3D {
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_CTX,
 	.arg2_type	=3D ARG_ANYTHING,
-	.arg3_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg4_type	=3D ARG_CONST_SIZE,
 };
=20
@@ -1821,7 +1821,7 @@ static const struct bpf_func_proto bpf_skb_load_byt=
es_relative_proto =3D {
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_CTX,
 	.arg2_type	=3D ARG_ANYTHING,
-	.arg3_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg4_type	=3D ARG_CONST_SIZE,
 	.arg5_type	=3D ARG_ANYTHING,
 };
@@ -3943,7 +3943,7 @@ static const struct bpf_func_proto bpf_xdp_load_byt=
es_proto =3D {
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_CTX,
 	.arg2_type	=3D ARG_ANYTHING,
-	.arg3_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg4_type	=3D ARG_CONST_SIZE,
 };
=20
@@ -3970,7 +3970,7 @@ static const struct bpf_func_proto bpf_xdp_store_by=
tes_proto =3D {
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_CTX,
 	.arg2_type	=3D ARG_ANYTHING,
-	.arg3_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg4_type	=3D ARG_CONST_SIZE,
 };
=20
@@ -4544,7 +4544,7 @@ static const struct bpf_func_proto bpf_skb_get_tunn=
el_key_proto =3D {
 	.gpl_only	=3D false,
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_CTX,
-	.arg2_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg2_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg3_type	=3D ARG_CONST_SIZE,
 	.arg4_type	=3D ARG_ANYTHING,
 };
@@ -4579,7 +4579,7 @@ static const struct bpf_func_proto bpf_skb_get_tunn=
el_opt_proto =3D {
 	.gpl_only	=3D false,
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_CTX,
-	.arg2_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg2_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg3_type	=3D ARG_CONST_SIZE,
 };
=20
@@ -5386,7 +5386,7 @@ const struct bpf_func_proto bpf_sk_getsockopt_proto=
 =3D {
 	.arg1_type	=3D ARG_PTR_TO_BTF_ID_SOCK_COMMON,
 	.arg2_type	=3D ARG_ANYTHING,
 	.arg3_type	=3D ARG_ANYTHING,
-	.arg4_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg4_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg5_type	=3D ARG_CONST_SIZE,
 };
=20
@@ -5420,7 +5420,7 @@ static const struct bpf_func_proto bpf_sock_addr_ge=
tsockopt_proto =3D {
 	.arg1_type	=3D ARG_PTR_TO_CTX,
 	.arg2_type	=3D ARG_ANYTHING,
 	.arg3_type	=3D ARG_ANYTHING,
-	.arg4_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg4_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg5_type	=3D ARG_CONST_SIZE,
 };
=20
@@ -5544,7 +5544,7 @@ static const struct bpf_func_proto bpf_sock_ops_get=
sockopt_proto =3D {
 	.arg1_type	=3D ARG_PTR_TO_CTX,
 	.arg2_type	=3D ARG_ANYTHING,
 	.arg3_type	=3D ARG_ANYTHING,
-	.arg4_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg4_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg5_type	=3D ARG_CONST_SIZE,
 };
=20
@@ -5656,7 +5656,7 @@ static const struct bpf_func_proto bpf_skb_get_xfrm=
_state_proto =3D {
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_CTX,
 	.arg2_type	=3D ARG_ANYTHING,
-	.arg3_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg4_type	=3D ARG_CONST_SIZE,
 	.arg5_type	=3D ARG_ANYTHING,
 };
@@ -10741,7 +10741,7 @@ static const struct bpf_func_proto sk_reuseport_l=
oad_bytes_proto =3D {
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_CTX,
 	.arg2_type	=3D ARG_ANYTHING,
-	.arg3_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg4_type	=3D ARG_CONST_SIZE,
 };
=20
@@ -10759,7 +10759,7 @@ static const struct bpf_func_proto sk_reuseport_l=
oad_bytes_relative_proto =3D {
 	.ret_type	=3D RET_INTEGER,
 	.arg1_type	=3D ARG_PTR_TO_CTX,
 	.arg2_type	=3D ARG_ANYTHING,
-	.arg3_type	=3D ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	=3D ARG_PTR_TO_MEM_UNINIT,
 	.arg4_type	=3D ARG_CONST_SIZE,
 	.arg5_type	=3D ARG_ANYTHING,
 };
--=20
2.30.2

