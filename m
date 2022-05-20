Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9382A52E3F0
	for <lists+bpf@lfdr.de>; Fri, 20 May 2022 06:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345361AbiETEne convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 20 May 2022 00:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345370AbiETEnd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 00:43:33 -0400
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F2D14AA74
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 21:43:30 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id F0AF1C9E200B; Thu, 19 May 2022 21:43:18 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v5 3/6] bpf: Dynptr support for ring buffers
Date:   Thu, 19 May 2022 21:42:42 -0700
Message-Id: <20220520044245.3305025-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220520044245.3305025-1-joannelkoong@gmail.com>
References: <20220520044245.3305025-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
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

Currently, our only way of writing dynamically-sized data into a ring
buffer is through bpf_ringbuf_output but this incurs an extra memcpy
cost. bpf_ringbuf_reserve + bpf_ringbuf_commit avoids this extra
memcpy, but it can only safely support reservation sizes that are
statically known since the verifier cannot guarantee that the bpf
program won’t access memory outside the reserved space.

The bpf_dynptr abstraction allows for dynamically-sized ring buffer
reservations without the extra memcpy.

There are 3 new APIs:

long bpf_ringbuf_reserve_dynptr(void *ringbuf, u32 size, u64 flags, struct bpf_dynptr *ptr);
void bpf_ringbuf_submit_dynptr(struct bpf_dynptr *ptr, u64 flags);
void bpf_ringbuf_discard_dynptr(struct bpf_dynptr *ptr, u64 flags);

These closely follow the functionalities of the original ringbuf APIs.
For example, all ringbuffer dynptrs that have been reserved must be
either submitted or discarded before the program exits.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: David Vernet <void@manifault.com>
---
 include/linux/bpf.h            | 15 ++++++-
 include/linux/bpf_verifier.h   |  2 +
 include/uapi/linux/bpf.h       | 35 +++++++++++++++
 kernel/bpf/helpers.c           | 14 ++++--
 kernel/bpf/ringbuf.c           | 78 ++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c          | 52 +++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h | 35 +++++++++++++++
 7 files changed, 223 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f34f3ff36203..dce532393f3d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -395,11 +395,14 @@ enum bpf_type_flag {
 	/* DYNPTR points to memory local to the bpf program. */
 	DYNPTR_TYPE_LOCAL	= BIT(8 + BPF_BASE_TYPE_BITS),
 
+	/* DYNPTR points to a ringbuf record. */
+	DYNPTR_TYPE_RINGBUF	= BIT(9 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
 
-#define DYNPTR_TYPE_FLAG_MASK	DYNPTR_TYPE_LOCAL
+#define DYNPTR_TYPE_FLAG_MASK	(DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_RINGBUF)
 
 /* Max number of base types. */
 #define BPF_BASE_TYPE_LIMIT	(1UL << BPF_BASE_TYPE_BITS)
@@ -2231,6 +2234,9 @@ extern const struct bpf_func_proto bpf_ringbuf_reserve_proto;
 extern const struct bpf_func_proto bpf_ringbuf_submit_proto;
 extern const struct bpf_func_proto bpf_ringbuf_discard_proto;
 extern const struct bpf_func_proto bpf_ringbuf_query_proto;
+extern const struct bpf_func_proto bpf_ringbuf_reserve_dynptr_proto;
+extern const struct bpf_func_proto bpf_ringbuf_submit_dynptr_proto;
+extern const struct bpf_func_proto bpf_ringbuf_discard_dynptr_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp6_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp_timewait_sock_proto;
@@ -2400,6 +2406,13 @@ enum bpf_dynptr_type {
 	BPF_DYNPTR_TYPE_INVALID,
 	/* Points to memory that is local to the bpf program */
 	BPF_DYNPTR_TYPE_LOCAL,
+	/* Underlying data is a ringbuf record */
+	BPF_DYNPTR_TYPE_RINGBUF,
 };
 
+void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
+		     enum bpf_dynptr_type type, u32 offset, u32 size);
+void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
+int bpf_dynptr_check_size(u32 size);
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index af5b2135215e..e8439f6cbe57 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -100,6 +100,8 @@ struct bpf_reg_state {
 	 * for the purpose of tracking that it's freed.
 	 * For PTR_TO_SOCKET this is used to share which pointers retain the
 	 * same reference to the socket, to determine proper reference freeing.
+	 * For stack slots that are dynptrs, this is used to track references to
+	 * the dynptr to determine proper reference freeing.
 	 */
 	u32 id;
 	/* PTR_TO_SOCKET and PTR_TO_TCP_SOCK could be a ptr returned
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 49fa1475fce3..4cfebe93eaac 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5183,6 +5183,38 @@ union bpf_attr {
  *	Return
  *		0 on success, -E2BIG if the size exceeds DYNPTR_MAX_SIZE,
  *		-EINVAL if flags is not 0.
+ *
+ * long bpf_ringbuf_reserve_dynptr(void *ringbuf, u32 size, u64 flags, struct bpf_dynptr *ptr)
+ *	Description
+ *		Reserve *size* bytes of payload in a ring buffer *ringbuf*
+ *		through the dynptr interface. *flags* must be 0.
+ *
+ *		Please note that a corresponding bpf_ringbuf_submit_dynptr or
+ *		bpf_ringbuf_discard_dynptr must be called on *ptr*, even if the
+ *		reservation fails. This is enforced by the verifier.
+ *	Return
+ *		0 on success, or a negative error in case of failure.
+ *
+ * void bpf_ringbuf_submit_dynptr(struct bpf_dynptr *ptr, u64 flags)
+ *	Description
+ *		Submit reserved ring buffer sample, pointed to by *data*,
+ *		through the dynptr interface. This is a no-op if the dynptr is
+ *		invalid/null.
+ *
+ *		For more information on *flags*, please see
+ *		'bpf_ringbuf_submit'.
+ *	Return
+ *		Nothing. Always succeeds.
+ *
+ * void bpf_ringbuf_discard_dynptr(struct bpf_dynptr *ptr, u64 flags)
+ *	Description
+ *		Discard reserved ring buffer sample through the dynptr
+ *		interface. This is a no-op if the dynptr is invalid/null.
+ *
+ *		For more information on *flags*, please see
+ *		'bpf_ringbuf_discard'.
+ *	Return
+ *		Nothing. Always succeeds.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5382,6 +5414,9 @@ union bpf_attr {
 	FN(kptr_xchg),			\
 	FN(map_lookup_percpu_elem),     \
 	FN(bpf_dynptr_from_mem),	\
+	FN(ringbuf_reserve_dynptr),	\
+	FN(ringbuf_submit_dynptr),	\
+	FN(ringbuf_discard_dynptr),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 0a80db9ed281..76e183a7aa1c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1423,13 +1423,13 @@ static void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum bpf_dynptr_typ
 	ptr->size |= type << DYNPTR_TYPE_SHIFT;
 }
 
-static int bpf_dynptr_check_size(u32 size)
+int bpf_dynptr_check_size(u32 size)
 {
 	return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
 }
 
-static void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
-			    enum bpf_dynptr_type type, u32 offset, u32 size)
+void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
+		     enum bpf_dynptr_type type, u32 offset, u32 size)
 {
 	ptr->data = data;
 	ptr->offset = offset;
@@ -1437,7 +1437,7 @@ static void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 	bpf_dynptr_set_type(ptr, type);
 }
 
-static void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
+void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
 {
 	memset(ptr, 0, sizeof(*ptr));
 }
@@ -1523,6 +1523,12 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_ringbuf_discard_proto;
 	case BPF_FUNC_ringbuf_query:
 		return &bpf_ringbuf_query_proto;
+	case BPF_FUNC_ringbuf_reserve_dynptr:
+		return &bpf_ringbuf_reserve_dynptr_proto;
+	case BPF_FUNC_ringbuf_submit_dynptr:
+		return &bpf_ringbuf_submit_dynptr_proto;
+	case BPF_FUNC_ringbuf_discard_dynptr:
+		return &bpf_ringbuf_discard_dynptr_proto;
 	case BPF_FUNC_for_each_map_elem:
 		return &bpf_for_each_map_elem_proto;
 	case BPF_FUNC_loop:
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 311264ab80c4..ded4faeca192 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -475,3 +475,81 @@ const struct bpf_func_proto bpf_ringbuf_query_proto = {
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_ANYTHING,
 };
+
+BPF_CALL_4(bpf_ringbuf_reserve_dynptr, struct bpf_map *, map, u32, size, u64, flags,
+	   struct bpf_dynptr_kern *, ptr)
+{
+	struct bpf_ringbuf_map *rb_map;
+	void *sample;
+	int err;
+
+	if (unlikely(flags)) {
+		bpf_dynptr_set_null(ptr);
+		return -EINVAL;
+	}
+
+	err = bpf_dynptr_check_size(size);
+	if (err) {
+		bpf_dynptr_set_null(ptr);
+		return err;
+	}
+
+	rb_map = container_of(map, struct bpf_ringbuf_map, map);
+
+	sample = __bpf_ringbuf_reserve(rb_map->rb, size);
+	if (!sample) {
+		bpf_dynptr_set_null(ptr);
+		return -EINVAL;
+	}
+
+	bpf_dynptr_init(ptr, sample, BPF_DYNPTR_TYPE_RINGBUF, 0, size);
+
+	return 0;
+}
+
+const struct bpf_func_proto bpf_ringbuf_reserve_dynptr_proto = {
+	.func		= bpf_ringbuf_reserve_dynptr,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_ANYTHING,
+	.arg3_type	= ARG_ANYTHING,
+	.arg4_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | MEM_UNINIT,
+};
+
+BPF_CALL_2(bpf_ringbuf_submit_dynptr, struct bpf_dynptr_kern *, ptr, u64, flags)
+{
+	if (!ptr->data)
+		return 0;
+
+	bpf_ringbuf_commit(ptr->data, flags, false /* discard */);
+
+	bpf_dynptr_set_null(ptr);
+
+	return 0;
+}
+
+const struct bpf_func_proto bpf_ringbuf_submit_dynptr_proto = {
+	.func		= bpf_ringbuf_submit_dynptr,
+	.ret_type	= RET_VOID,
+	.arg1_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | OBJ_RELEASE,
+	.arg2_type	= ARG_ANYTHING,
+};
+
+BPF_CALL_2(bpf_ringbuf_discard_dynptr, struct bpf_dynptr_kern *, ptr, u64, flags)
+{
+	if (!ptr->data)
+		return 0;
+
+	bpf_ringbuf_commit(ptr->data, flags, true /* discard */);
+
+	bpf_dynptr_set_null(ptr);
+
+	return 0;
+}
+
+const struct bpf_func_proto bpf_ringbuf_discard_dynptr_proto = {
+	.func		= bpf_ringbuf_discard_dynptr,
+	.ret_type	= RET_VOID,
+	.arg1_type	= ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | OBJ_RELEASE,
+	.arg2_type	= ARG_ANYTHING,
+};
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e70aab614394..4b502b8a369e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -187,6 +187,9 @@ struct bpf_verifier_stack_elem {
 					  POISON_POINTER_DELTA))
 #define BPF_MAP_PTR(X)		((struct bpf_map *)((X) & ~BPF_MAP_PTR_UNPRIV))
 
+static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx);
+static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
+
 static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
 {
 	return BPF_MAP_PTR(aux->map_ptr_state) == BPF_MAP_PTR_POISON;
@@ -672,17 +675,24 @@ static enum bpf_dynptr_type arg_to_dynptr_type(enum bpf_arg_type arg_type)
 	switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
 	case DYNPTR_TYPE_LOCAL:
 		return BPF_DYNPTR_TYPE_LOCAL;
+	case DYNPTR_TYPE_RINGBUF:
+		return BPF_DYNPTR_TYPE_RINGBUF;
 	default:
 		return BPF_DYNPTR_TYPE_INVALID;
 	}
 }
 
+static bool dynptr_type_refcounted(enum bpf_dynptr_type type)
+{
+	return type == BPF_DYNPTR_TYPE_RINGBUF;
+}
+
 static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				   enum bpf_arg_type arg_type, int insn_idx)
 {
 	struct bpf_func_state *state = func(env, reg);
 	enum bpf_dynptr_type type;
-	int spi, i;
+	int spi, i, id;
 
 	spi = get_spi(reg->off);
 
@@ -702,6 +712,16 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 	state->stack[spi].spilled_ptr.dynptr.type = type;
 	state->stack[spi - 1].spilled_ptr.dynptr.type = type;
 
+	if (dynptr_type_refcounted(type)) {
+		/* The id is used to track proper releasing */
+		id = acquire_reference_state(env, insn_idx);
+		if (id < 0)
+			return id;
+
+		state->stack[spi].spilled_ptr.id = id;
+		state->stack[spi - 1].spilled_ptr.id = id;
+	}
+
 	return 0;
 }
 
@@ -720,6 +740,13 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
 		state->stack[spi - 1].slot_type[i] = STACK_INVALID;
 	}
 
+	/* Invalidate any slices associated with this dynptr */
+	if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
+		release_reference(env, state->stack[spi].spilled_ptr.id);
+		state->stack[spi].spilled_ptr.id = 0;
+		state->stack[spi - 1].spilled_ptr.id = 0;
+	}
+
 	state->stack[spi].spilled_ptr.dynptr.first_slot = false;
 	state->stack[spi].spilled_ptr.dynptr.type = 0;
 	state->stack[spi - 1].spilled_ptr.dynptr.type = 0;
@@ -5864,7 +5891,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 
 skip_type_check:
 	if (arg_type_is_release(arg_type)) {
-		if (!reg->ref_obj_id && !register_is_null(reg)) {
+		if (arg_type_is_dynptr(arg_type)) {
+			struct bpf_func_state *state = func(env, reg);
+			int spi = get_spi(reg->off);
+
+			if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
+			    !state->stack[spi].spilled_ptr.id) {
+				verbose(env, "arg %d is an unacquired reference\n", regno);
+				return -EINVAL;
+			}
+		} else if (!reg->ref_obj_id && !register_is_null(reg)) {
 			verbose(env, "R%d must be referenced when passed to release function\n",
 				regno);
 			return -EINVAL;
@@ -5999,9 +6035,13 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			case DYNPTR_TYPE_LOCAL:
 				err_extra = "local ";
 				break;
+			case DYNPTR_TYPE_RINGBUF:
+				err_extra = "ringbuf ";
+				break;
 			default:
 				break;
 			}
+
 			verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
 				err_extra, arg + 1);
 			return -EINVAL;
@@ -6127,7 +6167,10 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	case BPF_MAP_TYPE_RINGBUF:
 		if (func_id != BPF_FUNC_ringbuf_output &&
 		    func_id != BPF_FUNC_ringbuf_reserve &&
-		    func_id != BPF_FUNC_ringbuf_query)
+		    func_id != BPF_FUNC_ringbuf_query &&
+		    func_id != BPF_FUNC_ringbuf_reserve_dynptr &&
+		    func_id != BPF_FUNC_ringbuf_submit_dynptr &&
+		    func_id != BPF_FUNC_ringbuf_discard_dynptr)
 			goto error;
 		break;
 	case BPF_MAP_TYPE_STACK_TRACE:
@@ -6243,6 +6286,9 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	case BPF_FUNC_ringbuf_output:
 	case BPF_FUNC_ringbuf_reserve:
 	case BPF_FUNC_ringbuf_query:
+	case BPF_FUNC_ringbuf_reserve_dynptr:
+	case BPF_FUNC_ringbuf_submit_dynptr:
+	case BPF_FUNC_ringbuf_discard_dynptr:
 		if (map->map_type != BPF_MAP_TYPE_RINGBUF)
 			goto error;
 		break;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 49fa1475fce3..4cfebe93eaac 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5183,6 +5183,38 @@ union bpf_attr {
  *	Return
  *		0 on success, -E2BIG if the size exceeds DYNPTR_MAX_SIZE,
  *		-EINVAL if flags is not 0.
+ *
+ * long bpf_ringbuf_reserve_dynptr(void *ringbuf, u32 size, u64 flags, struct bpf_dynptr *ptr)
+ *	Description
+ *		Reserve *size* bytes of payload in a ring buffer *ringbuf*
+ *		through the dynptr interface. *flags* must be 0.
+ *
+ *		Please note that a corresponding bpf_ringbuf_submit_dynptr or
+ *		bpf_ringbuf_discard_dynptr must be called on *ptr*, even if the
+ *		reservation fails. This is enforced by the verifier.
+ *	Return
+ *		0 on success, or a negative error in case of failure.
+ *
+ * void bpf_ringbuf_submit_dynptr(struct bpf_dynptr *ptr, u64 flags)
+ *	Description
+ *		Submit reserved ring buffer sample, pointed to by *data*,
+ *		through the dynptr interface. This is a no-op if the dynptr is
+ *		invalid/null.
+ *
+ *		For more information on *flags*, please see
+ *		'bpf_ringbuf_submit'.
+ *	Return
+ *		Nothing. Always succeeds.
+ *
+ * void bpf_ringbuf_discard_dynptr(struct bpf_dynptr *ptr, u64 flags)
+ *	Description
+ *		Discard reserved ring buffer sample through the dynptr
+ *		interface. This is a no-op if the dynptr is invalid/null.
+ *
+ *		For more information on *flags*, please see
+ *		'bpf_ringbuf_discard'.
+ *	Return
+ *		Nothing. Always succeeds.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5382,6 +5414,9 @@ union bpf_attr {
 	FN(kptr_xchg),			\
 	FN(map_lookup_percpu_elem),     \
 	FN(bpf_dynptr_from_mem),	\
+	FN(ringbuf_reserve_dynptr),	\
+	FN(ringbuf_submit_dynptr),	\
+	FN(ringbuf_discard_dynptr),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.30.2

