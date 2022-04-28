Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F750513D3E
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 23:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352138AbiD1VPn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 17:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352143AbiD1VPk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 17:15:40 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55AD8165B
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 14:12:09 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id EF73BBAF4BD4; Thu, 28 Apr 2022 14:11:51 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, memxor@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, toke@redhat.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v3 5/6] bpf: Add dynptr data slices
Date:   Thu, 28 Apr 2022 14:10:58 -0700
Message-Id: <20220428211059.4065379-6-joannelkoong@gmail.com>
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

This patch adds a new helper function

void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len);

which returns a pointer to the underlying data of a dynptr. *len*
must be a statically known value. The bpf program may access the returned
data slice as a normal buffer (eg can do direct reads and writes), since
the verifier associates the length with the returned pointer, and
enforces that no out of bounds accesses occur.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/bpf.h            |  4 +++
 include/uapi/linux/bpf.h       | 12 +++++++
 kernel/bpf/helpers.c           | 28 +++++++++++++++
 kernel/bpf/verifier.c          | 64 ++++++++++++++++++++++++++++++----
 tools/include/uapi/linux/bpf.h | 12 +++++++
 5 files changed, 114 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b276dbf942dd..4d2de868bdbc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -397,6 +397,9 @@ enum bpf_type_flag {
 	/* DYNPTR points to a ringbuf record. */
 	DYNPTR_TYPE_RINGBUF	=3D BIT(9 + BPF_BASE_TYPE_BITS),
=20
+	/* MEM is memory owned by a dynptr */
+	MEM_DYNPTR		=3D BIT(10 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_LAST_FLAG	=3D DYNPTR_TYPE_RINGBUF,
 };
=20
@@ -484,6 +487,7 @@ enum bpf_return_type {
 	RET_PTR_TO_TCP_SOCK_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
 	RET_PTR_TO_SOCK_COMMON_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COM=
MON,
 	RET_PTR_TO_ALLOC_MEM_OR_NULL	=3D PTR_MAYBE_NULL | MEM_ALLOC | RET_PTR_T=
O_ALLOC_MEM,
+	RET_PTR_TO_DYNPTR_MEM_OR_NULL	=3D PTR_MAYBE_NULL | MEM_DYNPTR | RET_PTR=
_TO_ALLOC_MEM,
 	RET_PTR_TO_BTF_ID_OR_NULL	=3D PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
=20
 	/* This must be the last entry. Its purpose is to ensure the enum is
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2d539930b7b2..e3a7c85cc572 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5226,6 +5226,17 @@ union bpf_attr {
  *		0 on success, -EINVAL if *offset* + *len* exceeds the length
  *		of *dst*'s data or if *dst* is an invalid dynptr or if *dst*
  *		is a read-only dynptr.
+ *
+ * void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len)
+ *	Description
+ *		Get a pointer to the underlying dynptr data.
+ *
+ *		*len* must be a statically known value. The returned data slice
+ *		is invalidated whenever the dynptr is invalidated.
+ *	Return
+ *		Pointer to the underlying dynptr data, NULL if the dynptr is
+ *		read-only, if the dynptr is invalid, or if the offset and length
+ *		is out of bounds.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5430,6 +5441,7 @@ union bpf_attr {
 	FN(ringbuf_discard_dynptr),	\
 	FN(dynptr_read),		\
 	FN(dynptr_write),		\
+	FN(dynptr_data),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7206b9e5322f..065815b9fb9f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1519,6 +1519,32 @@ const struct bpf_func_proto bpf_dynptr_write_proto=
 =3D {
 	.arg4_type	=3D ARG_CONST_SIZE_OR_ZERO,
 };
=20
+BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, =
u32, len)
+{
+	int err;
+
+	if (!ptr->data)
+		return 0;
+
+	err =3D bpf_dynptr_check_off_len(ptr, offset, len);
+	if (err)
+		return 0;
+
+	if (bpf_dynptr_is_rdonly(ptr))
+		return 0;
+
+	return (unsigned long)(ptr->data + ptr->offset + offset);
+}
+
+const struct bpf_func_proto bpf_dynptr_data_proto =3D {
+	.func		=3D bpf_dynptr_data,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_PTR_TO_DYNPTR_MEM_OR_NULL,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR,
+	.arg2_type	=3D ARG_ANYTHING,
+	.arg3_type	=3D ARG_CONST_ALLOC_SIZE_OR_ZERO,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
@@ -1585,6 +1611,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_dynptr_read_proto;
 	case BPF_FUNC_dynptr_write:
 		return &bpf_dynptr_write_proto;
+	case BPF_FUNC_dynptr_data:
+		return &bpf_dynptr_data_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1b2ec1049368..3d5b35449113 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -485,7 +485,8 @@ static bool may_be_acquire_function(enum bpf_func_id =
func_id)
 		func_id =3D=3D BPF_FUNC_sk_lookup_udp ||
 		func_id =3D=3D BPF_FUNC_skc_lookup_tcp ||
 		func_id =3D=3D BPF_FUNC_map_lookup_elem ||
-	        func_id =3D=3D BPF_FUNC_ringbuf_reserve;
+		func_id =3D=3D BPF_FUNC_ringbuf_reserve ||
+		func_id =3D=3D BPF_FUNC_dynptr_data;
 }
=20
 static bool is_acquire_function(enum bpf_func_id func_id,
@@ -497,7 +498,8 @@ static bool is_acquire_function(enum bpf_func_id func=
_id,
 	    func_id =3D=3D BPF_FUNC_sk_lookup_udp ||
 	    func_id =3D=3D BPF_FUNC_skc_lookup_tcp ||
 	    func_id =3D=3D BPF_FUNC_ringbuf_reserve ||
-	    func_id =3D=3D BPF_FUNC_kptr_xchg)
+	    func_id =3D=3D BPF_FUNC_kptr_xchg ||
+	    func_id =3D=3D BPF_FUNC_dynptr_data)
 		return true;
=20
 	if (func_id =3D=3D BPF_FUNC_map_lookup_elem &&
@@ -519,6 +521,11 @@ static bool is_ptr_cast_function(enum bpf_func_id fu=
nc_id)
 		func_id =3D=3D BPF_FUNC_skc_to_tcp_request_sock;
 }
=20
+static inline bool is_dynptr_ref_function(enum bpf_func_id func_id)
+{
+	return func_id =3D=3D BPF_FUNC_dynptr_data;
+}
+
 static bool is_cmpxchg_insn(const struct bpf_insn *insn)
 {
 	return BPF_CLASS(insn->code) =3D=3D BPF_STX &&
@@ -569,6 +576,8 @@ static const char *reg_type_str(struct bpf_verifier_e=
nv *env,
 		strncpy(prefix, "rdonly_", 32);
 	if (type & MEM_ALLOC)
 		strncpy(prefix, "alloc_", 32);
+	if (type & MEM_DYNPTR)
+		strncpy(prefix, "dynptr_", 32);
 	if (type & MEM_USER)
 		strncpy(prefix, "user_", 32);
 	if (type & MEM_PERCPU)
@@ -802,6 +811,20 @@ static bool is_dynptr_reg_valid_init(struct bpf_veri=
fier_env *env, struct bpf_re
 	return state->stack[spi].spilled_ptr.dynptr.type =3D=3D arg_to_dynptr_t=
ype(arg_type);
 }
=20
+static bool is_ref_obj_id_dynptr(struct bpf_func_state *state, u32 id)
+{
+	int allocated_slots =3D state->allocated_stack / BPF_REG_SIZE;
+	int i;
+
+	for (i =3D 0; i < allocated_slots; i++) {
+		if (state->stack[i].slot_type[0] =3D=3D STACK_DYNPTR &&
+		    state->stack[i].spilled_ptr.id =3D=3D id)
+			return true;
+	}
+
+	return false;
+}
+
 /* The reg state of a pointer or a bounded scalar was saved when
  * it was spilled to the stack.
  */
@@ -5652,6 +5675,7 @@ static const struct bpf_reg_types mem_types =3D {
 		PTR_TO_MAP_VALUE,
 		PTR_TO_MEM,
 		PTR_TO_MEM | MEM_ALLOC,
+		PTR_TO_MEM | MEM_DYNPTR,
 		PTR_TO_BUF,
 	},
 };
@@ -5804,6 +5828,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env =
*env,
 	case PTR_TO_MEM:
 	case PTR_TO_MEM | MEM_RDONLY:
 	case PTR_TO_MEM | MEM_ALLOC:
+	case PTR_TO_MEM | MEM_DYNPTR:
 	case PTR_TO_BUF:
 	case PTR_TO_BUF | MEM_RDONLY:
 	case PTR_TO_STACK:
@@ -5838,6 +5863,14 @@ int check_func_arg_reg_off(struct bpf_verifier_env=
 *env,
 	return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
 }
=20
+static inline u32 stack_slot_get_id(struct bpf_verifier_env *env, struct=
 bpf_reg_state *reg)
+{
+	struct bpf_func_state *state =3D func(env, reg);
+	int spi =3D get_spi(reg->off);
+
+	return state->stack[spi].spilled_ptr.id;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn)
@@ -7370,10 +7403,28 @@ static int check_helper_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn
 		/* For release_reference() */
 		regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj_id;
 	} else if (is_acquire_function(func_id, meta.map_ptr)) {
-		int id =3D acquire_reference_state(env, insn_idx);
+		int id;
+
+		if (is_dynptr_ref_function(func_id)) {
+			int i;
+
+			/* Find the id of the dynptr we're acquiring a reference to */
+			for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
+				if (arg_type_is_dynptr(fn->arg_type[i])) {
+					id =3D stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
+					break;
+				}
+			}
+			if (unlikely(i =3D=3D MAX_BPF_FUNC_REG_ARGS)) {
+				verbose(env, "verifier internal error: no dynptr args to a dynptr re=
f function");
+				return -EFAULT;
+			}
+		} else {
+			id =3D acquire_reference_state(env, insn_idx);
+			if (id < 0)
+				return id;
+		}
=20
-		if (id < 0)
-			return id;
 		/* For mark_ptr_or_null_reg() */
 		regs[BPF_REG_0].id =3D id;
 		/* For release_reference() */
@@ -9809,7 +9860,8 @@ static void mark_ptr_or_null_regs(struct bpf_verifi=
er_state *vstate, u32 regno,
 	u32 id =3D regs[regno].id;
 	int i;
=20
-	if (ref_obj_id && ref_obj_id =3D=3D id && is_null)
+	if (ref_obj_id && ref_obj_id =3D=3D id && is_null &&
+	    !is_ref_obj_id_dynptr(state, id))
 		/* regs[regno] is in the " =3D=3D NULL" branch.
 		 * No one could have freed the reference state before
 		 * doing the NULL check.
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 2d539930b7b2..e3a7c85cc572 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5226,6 +5226,17 @@ union bpf_attr {
  *		0 on success, -EINVAL if *offset* + *len* exceeds the length
  *		of *dst*'s data or if *dst* is an invalid dynptr or if *dst*
  *		is a read-only dynptr.
+ *
+ * void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len)
+ *	Description
+ *		Get a pointer to the underlying dynptr data.
+ *
+ *		*len* must be a statically known value. The returned data slice
+ *		is invalidated whenever the dynptr is invalidated.
+ *	Return
+ *		Pointer to the underlying dynptr data, NULL if the dynptr is
+ *		read-only, if the dynptr is invalid, or if the offset and length
+ *		is out of bounds.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5430,6 +5441,7 @@ union bpf_attr {
 	FN(ringbuf_discard_dynptr),	\
 	FN(dynptr_read),		\
 	FN(dynptr_write),		\
+	FN(dynptr_data),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

