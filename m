Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C594E503497
	for <lists+bpf@lfdr.de>; Sat, 16 Apr 2022 08:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiDPHCK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 16 Apr 2022 03:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDPHCJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Apr 2022 03:02:09 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AC04D268
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 23:59:37 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 2A247B1DE620; Fri, 15 Apr 2022 23:35:39 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, memxor@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, toke@redhat.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v2 5/7] bpf: Add dynptr data slices
Date:   Fri, 15 Apr 2022 23:34:27 -0700
Message-Id: <20220416063429.3314021-6-joannelkoong@gmail.com>
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

This patch adds a new helper function

void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len);

which returns a pointer to the underlying data of a dynptr. *len*
must be a statically known value. The bpf program may access the returned
data slice as a normal buffer (eg can do direct reads and writes), since
the verifier associates the length with the returned pointer, and
enforces that no out of bounds accesses occur.

This requires a few additions to the verifier. For every
referenced-tracked dynptr that is initialized, we create a unique id
and attach any data slices for that dynptr to the id. When a release
function is called on the dynptr (eg bpf_dynptr_put), we invalidate all
slices that correspond to that dynptr id. This ensures the slice can't
be used after its dynptr has been invalidated.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/bpf_verifier.h   |  2 +
 include/uapi/linux/bpf.h       | 12 +++++
 kernel/bpf/helpers.c           | 28 +++++++++++
 kernel/bpf/verifier.c          | 88 +++++++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h | 12 +++++
 5 files changed, 135 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e11440a44e92..f914e00a300c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -109,6 +109,8 @@ struct bpf_reg_state {
 	 * for the purpose of tracking that it's freed.
 	 * For PTR_TO_SOCKET this is used to share which pointers retain the
 	 * same reference to the socket, to determine proper reference freeing.
+	 * For stack slots that are dynptrs, this is used to track references t=
o
+	 * the dynptr to determine proper reference freeing.
 	 */
 	u32 id;
 	/* PTR_TO_SOCKET and PTR_TO_TCP_SOCK could be a ptr returned
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index abe9a221ef08..a47e8b787033 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5196,6 +5196,17 @@ union bpf_attr {
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
@@ -5397,6 +5408,7 @@ union bpf_attr {
 	FN(dynptr_put),			\
 	FN(dynptr_read),		\
 	FN(dynptr_write),		\
+	FN(dynptr_data),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index ae2239375c51..5bcc640a39db 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1530,6 +1530,32 @@ const struct bpf_func_proto bpf_dynptr_write_proto=
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
+	.ret_type	=3D RET_PTR_TO_ALLOC_MEM_OR_NULL,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR,
+	.arg2_type	=3D ARG_ANYTHING,
+	.arg3_type	=3D ARG_CONST_ALLOC_SIZE_OR_ZERO,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
@@ -1592,6 +1618,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_dynptr_read_proto;
 	case BPF_FUNC_dynptr_write:
 		return &bpf_dynptr_write_proto;
+	case BPF_FUNC_dynptr_data:
+		return &bpf_dynptr_data_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bf132c6822e4..06b29802c4ec 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -189,6 +189,9 @@ struct bpf_verifier_stack_elem {
=20
 /* forward declarations */
 static bool arg_type_is_mem_size(enum bpf_arg_type type);
+static void release_reg_references(struct bpf_verifier_env *env,
+				   struct bpf_func_state *state,
+				   int ref_obj_id);
=20
 static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
 {
@@ -483,7 +486,8 @@ static bool may_be_acquire_function(enum bpf_func_id =
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
@@ -494,7 +498,8 @@ static bool is_acquire_function(enum bpf_func_id func=
_id,
 	if (func_id =3D=3D BPF_FUNC_sk_lookup_tcp ||
 	    func_id =3D=3D BPF_FUNC_sk_lookup_udp ||
 	    func_id =3D=3D BPF_FUNC_skc_lookup_tcp ||
-	    func_id =3D=3D BPF_FUNC_ringbuf_reserve)
+	    func_id =3D=3D BPF_FUNC_ringbuf_reserve ||
+	    func_id =3D=3D BPF_FUNC_dynptr_data)
 		return true;
=20
 	if (func_id =3D=3D BPF_FUNC_map_lookup_elem &&
@@ -516,6 +521,11 @@ static bool is_ptr_cast_function(enum bpf_func_id fu=
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
@@ -691,7 +701,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifie=
r_env *env, struct bpf_reg_
 {
 	struct bpf_func_state *state =3D cur_func(env);
 	enum bpf_dynptr_type type;
-	int spi, i;
+	int spi, id, i;
=20
 	spi =3D get_spi(reg->off);
=20
@@ -712,11 +722,25 @@ static int mark_stack_slots_dynptr(struct bpf_verif=
ier_env *env, struct bpf_reg_
=20
 	state->stack[spi].spilled_ptr.dynptr.first_slot =3D true;
=20
+	/* Generate an id for the dynptr if the dynptr type can be
+	 * acquired/released.
+	 *
+	 * This is used to associated data slices with dynptrs, so that
+	 * if a dynptr gets invalidated, its data slices will also be
+	 * invalidated.
+	 */
+	if (dynptr_type_refcounted(type)) {
+		id =3D ++env->id_gen;
+		state->stack[spi].spilled_ptr.id =3D id;
+		state->stack[spi - 1].spilled_ptr.id =3D id;
+	}
+
 	return 0;
 }
=20
 static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struc=
t bpf_reg_state *reg)
 {
+	struct bpf_verifier_state *vstate =3D env->cur_state;
 	struct bpf_func_state *state =3D func(env, reg);
 	int spi, i;
=20
@@ -730,6 +754,15 @@ static int unmark_stack_slots_dynptr(struct bpf_veri=
fier_env *env, struct bpf_re
 		state->stack[spi - 1].slot_type[i] =3D STACK_INVALID;
 	}
=20
+	/* Invalidate any slices associated with this dynptr */
+	if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) =
{
+		for (i =3D 0; i <=3D vstate->curframe; i++)
+			release_reg_references(env, vstate->frame[i],
+					       state->stack[spi].spilled_ptr.id);
+		state->stack[spi].spilled_ptr.id =3D 0;
+		state->stack[spi - 1].spilled_ptr.id =3D 0;
+	}
+
 	state->stack[spi].spilled_ptr.dynptr.type =3D 0;
 	state->stack[spi - 1].spilled_ptr.dynptr.type =3D 0;
=20
@@ -839,6 +872,20 @@ static bool is_dynptr_reg_valid_init(struct bpf_veri=
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
 static bool stack_access_into_dynptr(struct bpf_func_state *state, int s=
pi, int size)
 {
 	int nr_slots =3D roundup(size, BPF_REG_SIZE) / BPF_REG_SIZE;
@@ -5630,6 +5677,14 @@ int check_func_arg_reg_off(struct bpf_verifier_env=
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
@@ -7191,10 +7246,28 @@ static int check_helper_call(struct bpf_verifier_=
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
@@ -9630,7 +9703,8 @@ static void mark_ptr_or_null_regs(struct bpf_verifi=
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
index abe9a221ef08..a47e8b787033 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5196,6 +5196,17 @@ union bpf_attr {
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
@@ -5397,6 +5408,7 @@ union bpf_attr {
 	FN(dynptr_put),			\
 	FN(dynptr_read),		\
 	FN(dynptr_write),		\
+	FN(dynptr_data),		\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

