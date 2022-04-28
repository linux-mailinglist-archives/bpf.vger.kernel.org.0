Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E63A513D3C
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 23:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346296AbiD1VPs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 28 Apr 2022 17:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352170AbiD1VPp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 17:15:45 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0607481FC3
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 14:12:12 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id D70C2BAF4BD0; Thu, 28 Apr 2022 14:11:51 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, memxor@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, toke@redhat.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v3 3/6] bpf: Dynptr support for ring buffers
Date:   Thu, 28 Apr 2022 14:10:56 -0700
Message-Id: <20220428211059.4065379-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220428211059.4065379-1-joannelkoong@gmail.com>
References: <20220428211059.4065379-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
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
---
 include/linux/bpf.h            | 10 ++++-
 include/uapi/linux/bpf.h       | 35 +++++++++++++++++
 kernel/bpf/helpers.c           |  6 +++
 kernel/bpf/ringbuf.c           | 71 ++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c          | 18 +++++++--
 tools/include/uapi/linux/bpf.h | 35 +++++++++++++++++
 6 files changed, 171 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 757440406962..10efbec99e93 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -394,7 +394,10 @@ enum bpf_type_flag {
 	/* DYNPTR points to dynamically allocated memory. */
 	DYNPTR_TYPE_MALLOC	= BIT(8 + BPF_BASE_TYPE_BITS),
 
-	__BPF_TYPE_LAST_FLAG	= DYNPTR_TYPE_MALLOC,
+	/* DYNPTR points to a ringbuf record. */
+	DYNPTR_TYPE_RINGBUF	= BIT(9 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	= DYNPTR_TYPE_RINGBUF,
 };
 
 /* Max number of base types. */
@@ -2203,6 +2206,9 @@ extern const struct bpf_func_proto bpf_ringbuf_reserve_proto;
 extern const struct bpf_func_proto bpf_ringbuf_submit_proto;
 extern const struct bpf_func_proto bpf_ringbuf_discard_proto;
 extern const struct bpf_func_proto bpf_ringbuf_query_proto;
+extern const struct bpf_func_proto bpf_ringbuf_reserve_dynptr_proto;
+extern const struct bpf_func_proto bpf_ringbuf_submit_dynptr_proto;
+extern const struct bpf_func_proto bpf_ringbuf_discard_dynptr_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp6_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_tcp_timewait_sock_proto;
@@ -2370,6 +2376,8 @@ enum bpf_dynptr_type {
 	BPF_DYNPTR_TYPE_INVALID,
 	/* Memory allocated dynamically by the kernel for the dynptr */
 	BPF_DYNPTR_TYPE_MALLOC,
+	/* Underlying data is a ringbuf record */
+	BPF_DYNPTR_TYPE_RINGBUF,
 };
 
 /* Since the upper 8 bits of dynptr->size is reserved, the
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 5a87ed654016..679f960d2514 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5177,6 +5177,38 @@ union bpf_attr {
  *		After this operation, *ptr* will be an invalidated dynptr.
  *	Return
  *		Void.
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
@@ -5376,6 +5408,9 @@ union bpf_attr {
 	FN(kptr_xchg),			\
 	FN(dynptr_alloc),		\
 	FN(dynptr_put),			\
+	FN(ringbuf_reserve_dynptr),	\
+	FN(ringbuf_submit_dynptr),	\
+	FN(ringbuf_discard_dynptr),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a4272e9239ea..2d6f2e28b580 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1513,6 +1513,12 @@ bpf_base_func_proto(enum bpf_func_id func_id)
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
index 311264ab80c4..685bee459525 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -475,3 +475,74 @@ const struct bpf_func_proto bpf_ringbuf_query_proto = {
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_ANYTHING,
 };
+
+BPF_CALL_4(bpf_ringbuf_reserve_dynptr, struct bpf_map *, map, u32, size, u64, flags,
+	   struct bpf_dynptr_kern *, ptr)
+{
+	void *sample;
+	int err;
+
+	err = bpf_dynptr_check_size(size);
+	if (err) {
+		bpf_dynptr_set_null(ptr);
+		return err;
+	}
+
+	sample = (void __force *)____bpf_ringbuf_reserve(map, size, flags);
+
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
+	____bpf_ringbuf_submit(ptr->data, flags);
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
+	____bpf_ringbuf_discard(ptr->data, flags);
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
index 16b7ea54a7e0..1b2ec1049368 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -672,13 +672,15 @@ static void mark_verifier_state_scratched(struct bpf_verifier_env *env)
 	env->scratched_stack_slots = ~0ULL;
 }
 
-#define DYNPTR_TYPE_FLAG_MASK		DYNPTR_TYPE_MALLOC
+#define DYNPTR_TYPE_FLAG_MASK (DYNPTR_TYPE_MALLOC | DYNPTR_TYPE_RINGBUF)
 
 static int arg_to_dynptr_type(enum bpf_arg_type arg_type)
 {
 	switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
 	case DYNPTR_TYPE_MALLOC:
 		return BPF_DYNPTR_TYPE_MALLOC;
+	case DYNPTR_TYPE_RINGBUF:
+		return BPF_DYNPTR_TYPE_RINGBUF;
 	default:
 		return BPF_DYNPTR_TYPE_INVALID;
 	}
@@ -686,7 +688,7 @@ static int arg_to_dynptr_type(enum bpf_arg_type arg_type)
 
 static inline bool dynptr_type_refcounted(enum bpf_dynptr_type type)
 {
-	return type == BPF_DYNPTR_TYPE_MALLOC;
+	return type == BPF_DYNPTR_TYPE_MALLOC || type == BPF_DYNPTR_TYPE_RINGBUF;
 }
 
 static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
@@ -6033,9 +6035,13 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			case DYNPTR_TYPE_MALLOC:
 				err_extra = "malloc ";
 				break;
+			case DYNPTR_TYPE_RINGBUF:
+				err_extra = "ringbuf ";
+				break;
 			default:
 				break;
 			}
+
 			verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
 				err_extra, arg + BPF_REG_1);
 			return -EINVAL;
@@ -6161,7 +6167,10 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
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
@@ -6277,6 +6286,9 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
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
index 5a87ed654016..679f960d2514 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5177,6 +5177,38 @@ union bpf_attr {
  *		After this operation, *ptr* will be an invalidated dynptr.
  *	Return
  *		Void.
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
@@ -5376,6 +5408,9 @@ union bpf_attr {
 	FN(kptr_xchg),			\
 	FN(dynptr_alloc),		\
 	FN(dynptr_put),			\
+	FN(ringbuf_reserve_dynptr),	\
+	FN(ringbuf_submit_dynptr),	\
+	FN(ringbuf_discard_dynptr),	\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.30.2

