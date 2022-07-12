Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7C657283F
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 23:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiGLVG7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 17:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiGLVG7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 17:06:59 -0400
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DC6CFB62
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 14:06:58 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id EE11DEDDBC15; Tue, 12 Jul 2022 14:06:45 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1] bpf: Tidy up verifier check_func_arg()
Date:   Tue, 12 Jul 2022 14:06:03 -0700
Message-Id: <20220712210603.123791-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_SOFTFAIL,SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,
        TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch does two things:

1. For matching against the arg type, the match should be against the
base type of the arg type, since the arg type can have different
bpf_type_flags set on it.

2. Uses switch casing to improve readability + efficiency.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 kernel/bpf/verifier.c | 66 +++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 328cfab3af60..26e7e787c20a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5533,17 +5533,6 @@ static bool arg_type_is_mem_size(enum bpf_arg_type=
 type)
 	       type =3D=3D ARG_CONST_SIZE_OR_ZERO;
 }
=20
-static bool arg_type_is_alloc_size(enum bpf_arg_type type)
-{
-	return type =3D=3D ARG_CONST_ALLOC_SIZE_OR_ZERO;
-}
-
-static bool arg_type_is_int_ptr(enum bpf_arg_type type)
-{
-	return type =3D=3D ARG_PTR_TO_INT ||
-	       type =3D=3D ARG_PTR_TO_LONG;
-}
-
 static bool arg_type_is_release(enum bpf_arg_type type)
 {
 	return type & OBJ_RELEASE;
@@ -5929,7 +5918,8 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
 		meta->ref_obj_id =3D reg->ref_obj_id;
 	}
=20
-	if (arg_type =3D=3D ARG_CONST_MAP_PTR) {
+	switch (base_type(arg_type)) {
+	case ARG_CONST_MAP_PTR:
 		/* bpf_map_xxx(map_ptr) call: remember that map_ptr */
 		if (meta->map_ptr) {
 			/* Use map_uid (which is unique id of inner map) to reject:
@@ -5954,7 +5944,8 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
 		}
 		meta->map_ptr =3D reg->map_ptr;
 		meta->map_uid =3D reg->map_uid;
-	} else if (arg_type =3D=3D ARG_PTR_TO_MAP_KEY) {
+		break;
+	case ARG_PTR_TO_MAP_KEY:
 		/* bpf_map_xxx(..., map_ptr, ..., key) call:
 		 * check that [key, key + map->key_size) are within
 		 * stack limits and initialized
@@ -5971,7 +5962,8 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
 		err =3D check_helper_mem_access(env, regno,
 					      meta->map_ptr->key_size, false,
 					      NULL);
-	} else if (base_type(arg_type) =3D=3D ARG_PTR_TO_MAP_VALUE) {
+		break;
+	case ARG_PTR_TO_MAP_VALUE:
 		if (type_may_be_null(arg_type) && register_is_null(reg))
 			return 0;
=20
@@ -5987,14 +5979,16 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
 		err =3D check_helper_mem_access(env, regno,
 					      meta->map_ptr->value_size, false,
 					      meta);
-	} else if (arg_type =3D=3D ARG_PTR_TO_PERCPU_BTF_ID) {
+		break;
+	case ARG_PTR_TO_PERCPU_BTF_ID:
 		if (!reg->btf_id) {
 			verbose(env, "Helper has invalid btf_id in R%d\n", regno);
 			return -EACCES;
 		}
 		meta->ret_btf =3D reg->btf;
 		meta->ret_btf_id =3D reg->btf_id;
-	} else if (arg_type =3D=3D ARG_PTR_TO_SPIN_LOCK) {
+		break;
+	case ARG_PTR_TO_SPIN_LOCK:
 		if (meta->func_id =3D=3D BPF_FUNC_spin_lock) {
 			if (process_spin_lock(env, regno, true))
 				return -EACCES;
@@ -6005,12 +5999,15 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
 			verbose(env, "verifier internal error\n");
 			return -EFAULT;
 		}
-	} else if (arg_type =3D=3D ARG_PTR_TO_TIMER) {
+		break;
+	case ARG_PTR_TO_TIMER:
 		if (process_timer_func(env, regno, meta))
 			return -EACCES;
-	} else if (arg_type =3D=3D ARG_PTR_TO_FUNC) {
+		break;
+	case ARG_PTR_TO_FUNC:
 		meta->subprogno =3D reg->subprogno;
-	} else if (base_type(arg_type) =3D=3D ARG_PTR_TO_MEM) {
+		break;
+	case ARG_PTR_TO_MEM:
 		/* The access to this pointer is only checked when we hit the
 		 * next is_mem_size argument below.
 		 */
@@ -6020,11 +6017,14 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
 						      fn->arg_size[arg], false,
 						      meta);
 		}
-	} else if (arg_type_is_mem_size(arg_type)) {
-		bool zero_size_allowed =3D (arg_type =3D=3D ARG_CONST_SIZE_OR_ZERO);
-
-		err =3D check_mem_size_reg(env, reg, regno, zero_size_allowed, meta);
-	} else if (arg_type_is_dynptr(arg_type)) {
+		break;
+	case ARG_CONST_SIZE:
+		err =3D check_mem_size_reg(env, reg, regno, false, meta);
+		break;
+	case ARG_CONST_SIZE_OR_ZERO:
+		err =3D check_mem_size_reg(env, reg, regno, true, meta);
+		break;
+	case ARG_PTR_TO_DYNPTR:
 		if (arg_type & MEM_UNINIT) {
 			if (!is_dynptr_reg_valid_uninit(env, reg)) {
 				verbose(env, "Dynptr has to be an uninitialized dynptr\n");
@@ -6058,21 +6058,28 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
 				err_extra, arg + 1);
 			return -EINVAL;
 		}
-	} else if (arg_type_is_alloc_size(arg_type)) {
+		break;
+	case ARG_CONST_ALLOC_SIZE_OR_ZERO:
 		if (!tnum_is_const(reg->var_off)) {
 			verbose(env, "R%d is not a known constant'\n",
 				regno);
 			return -EACCES;
 		}
 		meta->mem_size =3D reg->var_off.value;
-	} else if (arg_type_is_int_ptr(arg_type)) {
+		break;
+	case ARG_PTR_TO_INT:
+	case ARG_PTR_TO_LONG:
+	{
 		int size =3D int_ptr_type_to_size(arg_type);
=20
 		err =3D check_helper_mem_access(env, regno, size, false, meta);
 		if (err)
 			return err;
 		err =3D check_ptr_alignment(env, reg, 0, size, true);
-	} else if (arg_type =3D=3D ARG_PTR_TO_CONST_STR) {
+		break;
+	}
+	case ARG_PTR_TO_CONST_STR:
+	{
 		struct bpf_map *map =3D reg->map_ptr;
 		int map_off;
 		u64 map_addr;
@@ -6111,9 +6118,12 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
 			verbose(env, "string is not zero-terminated\n");
 			return -EINVAL;
 		}
-	} else if (arg_type =3D=3D ARG_PTR_TO_KPTR) {
+		break;
+	}
+	case ARG_PTR_TO_KPTR:
 		if (process_kptr_func(env, regno, meta))
 			return -EACCES;
+		break;
 	}
=20
 	return err;
--=20
2.30.2

