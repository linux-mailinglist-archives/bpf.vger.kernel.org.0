Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E615207F6
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 00:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiEIWsg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 18:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiEIWsg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 18:48:36 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389692A28C9
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 15:44:38 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id ADE25C2576CC; Mon,  9 May 2022 15:44:18 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v4 2/6] bpf: Add verifier support for dynptrs and implement malloc dynptrs
Date:   Mon,  9 May 2022 15:42:53 -0700
Message-Id: <20220509224257.3222614-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220509224257.3222614-1-joannelkoong@gmail.com>
References: <20220509224257.3222614-1-joannelkoong@gmail.com>
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

This patch adds the bulk of the verifier work for supporting dynamic
pointers (dynptrs) in bpf. This patch implements malloc-type dynptrs
through 2 new APIs (bpf_dynptr_alloc and bpf_dynptr_put) that can be
called by a bpf program. Malloc-type dynptrs are dynptrs that dynamically
allocate memory on behalf of the program.

A bpf_dynptr is opaque to the bpf program. It is a 16-byte structure
defined internally as:

struct bpf_dynptr_kern {
    void *data;
    u32 size;
    u32 offset;
} __aligned(8);

The upper 8 bits of *size* is reserved (it contains extra metadata about
read-only status and dynptr type); consequently, a dynptr only supports
memory less than 16 MB.

The 2 new APIs for malloc-type dynptrs are:

long bpf_dynptr_alloc(u32 size, u64 flags, struct bpf_dynptr *ptr);
void bpf_dynptr_put(struct bpf_dynptr *ptr);

Please note that there *must* be a corresponding bpf_dynptr_put for
every bpf_dynptr_alloc (even if the alloc fails). This is enforced
by the verifier.

In the verifier, dynptr state information will be tracked in stack
slots. When the program passes in an uninitialized dynptr
(ARG_PTR_TO_DYNPTR | MEM_UNINIT), the stack slots corresponding
to the frame pointer where the dynptr resides at are marked STACK_DYNPTR.

For helper functions that take in initialized dynptrs (eg
bpf_dynptr_read + bpf_dynptr_write which are added later in this
patchset), the verifier enforces that the dynptr has been initialized
properly by checking that their corresponding stack slots have been marke=
d
as STACK_DYNPTR. Dynptr release functions (eg bpf_dynptr_put) will clear
the stack slots. The verifier enforces at program exit that there are no
referenced dynptrs that haven't been released.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/bpf.h            |  62 ++++++++-
 include/linux/bpf_verifier.h   |  21 +++
 include/uapi/linux/bpf.h       |  30 +++++
 kernel/bpf/helpers.c           |  75 +++++++++++
 kernel/bpf/verifier.c          | 228 ++++++++++++++++++++++++++++++++-
 scripts/bpf_doc.py             |   2 +
 tools/include/uapi/linux/bpf.h |  30 +++++
 7 files changed, 445 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d0c167865504..e078b8a911fe 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -391,9 +391,14 @@ enum bpf_type_flag {
=20
 	MEM_UNINIT		=3D BIT(7 + BPF_BASE_TYPE_BITS),
=20
-	__BPF_TYPE_LAST_FLAG	=3D MEM_UNINIT,
+	/* DYNPTR points to dynamically allocated memory. */
+	DYNPTR_TYPE_MALLOC	=3D BIT(8 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	=3D DYNPTR_TYPE_MALLOC,
 };
=20
+#define DYNPTR_TYPE_FLAG_MASK	DYNPTR_TYPE_MALLOC
+
 /* Max number of base types. */
 #define BPF_BASE_TYPE_LIMIT	(1UL << BPF_BASE_TYPE_BITS)
=20
@@ -436,6 +441,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string =
*/
 	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
 	ARG_PTR_TO_KPTR,	/* pointer to referenced kptr */
+	ARG_PTR_TO_DYNPTR,      /* pointer to bpf_dynptr. See bpf_type_flag for=
 dynptr type */
 	__BPF_ARG_TYPE_MAX,
=20
 	/* Extended arg_types. */
@@ -2347,4 +2353,58 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, c=
onst u64 *raw_args,
 			u32 **bin_buf, u32 num_args);
 void bpf_bprintf_cleanup(void);
=20
+/* the implementation of the opaque uapi struct bpf_dynptr */
+struct bpf_dynptr_kern {
+	void *data;
+	/* Size represents the number of usable bytes in the dynptr.
+	 * If for example the offset is at 200 for a malloc dynptr with
+	 * allocation size 256, the number of usable bytes is 56.
+	 *
+	 * The upper 8 bits are reserved.
+	 * Bit 31 denotes whether the dynptr is read-only.
+	 * Bits 28-30 denote the dynptr type.
+	 */
+	u32 size;
+	u32 offset;
+} __aligned(8);
+
+enum bpf_dynptr_type {
+	BPF_DYNPTR_TYPE_INVALID,
+	/* Memory allocated dynamically by the kernel for the dynptr */
+	BPF_DYNPTR_TYPE_MALLOC,
+};
+
+/* Since the upper 8 bits of dynptr->size is reserved, the
+ * maximum supported size is 2^24 - 1.
+ */
+#define DYNPTR_MAX_SIZE	((1UL << 24) - 1)
+#define DYNPTR_SIZE_MASK	0xFFFFFF
+#define DYNPTR_TYPE_SHIFT	28
+#define DYNPTR_TYPE_MASK	0x7
+
+static inline enum bpf_dynptr_type bpf_dynptr_get_type(struct bpf_dynptr=
_kern *ptr)
+{
+	return (ptr->size >> DYNPTR_TYPE_SHIFT) & DYNPTR_TYPE_MASK;
+}
+
+static inline void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum=
 bpf_dynptr_type type)
+{
+	ptr->size |=3D type << DYNPTR_TYPE_SHIFT;
+}
+
+static inline u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
+{
+	return ptr->size & DYNPTR_SIZE_MASK;
+}
+
+static inline int bpf_dynptr_check_size(u32 size)
+{
+	return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
+}
+
+void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data, enum bpf_d=
ynptr_type type,
+		     u32 offset, u32 size);
+
+void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1f1e7f2ea967..830a0e11ae97 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -72,6 +72,18 @@ struct bpf_reg_state {
=20
 		u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
=20
+		/* For dynptr stack slots */
+		struct {
+			enum bpf_dynptr_type type;
+			/* A dynptr is 16 bytes so it takes up 2 stack slots.
+			 * We need to track which slot is the first slot
+			 * to protect against cases where the user may try to
+			 * pass in an address starting at the second slot of the
+			 * dynptr.
+			 */
+			bool first_slot;
+		} dynptr;
+
 		/* Max size from any of the above. */
 		struct {
 			unsigned long raw1;
@@ -88,6 +100,8 @@ struct bpf_reg_state {
 	 * for the purpose of tracking that it's freed.
 	 * For PTR_TO_SOCKET this is used to share which pointers retain the
 	 * same reference to the socket, to determine proper reference freeing.
+	 * For stack slots that are dynptrs, this is used to track references t=
o
+	 * the dynptr to determine proper reference freeing.
 	 */
 	u32 id;
 	/* PTR_TO_SOCKET and PTR_TO_TCP_SOCK could be a ptr returned
@@ -174,9 +188,16 @@ enum bpf_stack_slot_type {
 	STACK_SPILL,      /* register spilled into stack */
 	STACK_MISC,	  /* BPF program wrote some data into this slot */
 	STACK_ZERO,	  /* BPF program wrote constant zero */
+	/* A dynptr is stored in this stack slot. The type of dynptr
+	 * is stored in bpf_stack_state->spilled_ptr.dynptr.type
+	 */
+	STACK_DYNPTR,
 };
=20
 #define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
+/* size of a struct bpf_dynptr in bytes */
+#define BPF_DYNPTR_SIZE sizeof(struct bpf_dynptr_kern)
+#define BPF_DYNPTR_NR_SLOTS (BPF_DYNPTR_SIZE / BPF_REG_SIZE)
=20
 struct bpf_stack_state {
 	struct bpf_reg_state spilled_ptr;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 444fe6f1cf35..5a87ed654016 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5154,6 +5154,29 @@ union bpf_attr {
  *		if not NULL, is a reference which must be released using its
  *		corresponding release function, or moved into a BPF map before
  *		program exit.
+ *
+ * long bpf_dynptr_alloc(u32 size, u64 flags, struct bpf_dynptr *ptr)
+ *	Description
+ *		Allocate memory of *size* bytes.
+ *
+ *		Every call to bpf_dynptr_alloc must have a corresponding
+ *		bpf_dynptr_put, regardless of whether the bpf_dynptr_alloc
+ *		succeeded.
+ *
+ *		The maximum *size* supported is DYNPTR_MAX_SIZE.
+ *		Supported *flags* are __GFP_ZERO.
+ *	Return
+ *		0 on success, -ENOMEM if there is not enough memory for the
+ *		allocation, -E2BIG if the size exceeds DYNPTR_MAX_SIZE, -EINVAL
+ *		if the flags is not supported.
+ *
+ * void bpf_dynptr_put(struct bpf_dynptr *ptr)
+ *	Description
+ *		Free memory allocated by bpf_dynptr_alloc.
+ *
+ *		After this operation, *ptr* will be an invalidated dynptr.
+ *	Return
+ *		Void.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5351,6 +5374,8 @@ union bpf_attr {
 	FN(skb_set_tstamp),		\
 	FN(ima_file_hash),		\
 	FN(kptr_xchg),			\
+	FN(dynptr_alloc),		\
+	FN(dynptr_put),			\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
@@ -6498,6 +6523,11 @@ struct bpf_timer {
 	__u64 :64;
 } __attribute__((aligned(8)));
=20
+struct bpf_dynptr {
+	__u64 :64;
+	__u64 :64;
+} __attribute__((aligned(8)));
+
 struct bpf_sysctl {
 	__u32	write;		/* Sysctl is being read (=3D 0) or written (=3D 1).
 				 * Allows 1,2,4-byte read, but no write.
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8a2398ac14c2..a4272e9239ea 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1396,6 +1396,77 @@ const struct bpf_func_proto bpf_kptr_xchg_proto =3D=
 {
 	.arg2_btf_id  =3D BPF_PTR_POISON,
 };
=20
+void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data, enum bpf_d=
ynptr_type type,
+		     u32 offset, u32 size)
+{
+	ptr->data =3D data;
+	ptr->offset =3D offset;
+	ptr->size =3D size;
+	bpf_dynptr_set_type(ptr, type);
+}
+
+void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
+{
+	memset(ptr, 0, sizeof(*ptr));
+}
+
+BPF_CALL_3(bpf_dynptr_alloc, u32, size, u64, flags, struct bpf_dynptr_ke=
rn *, ptr)
+{
+	gfp_t gfp_flags =3D GFP_ATOMIC;
+	void *data;
+	int err;
+
+	err =3D bpf_dynptr_check_size(size);
+	if (err)
+		goto error;
+
+	if (flags) {
+		if (flags =3D=3D __GFP_ZERO) {
+			gfp_flags |=3D flags;
+		} else {
+			err =3D -EINVAL;
+			goto error;
+		}
+	}
+
+	data =3D kmalloc(size, gfp_flags);
+	if (!data) {
+		err =3D -ENOMEM;
+		goto error;
+	}
+
+	bpf_dynptr_init(ptr, data, BPF_DYNPTR_TYPE_MALLOC, 0, size);
+
+	return 0;
+
+error:
+	bpf_dynptr_set_null(ptr);
+	return err;
+}
+
+const struct bpf_func_proto bpf_dynptr_alloc_proto =3D {
+	.func		=3D bpf_dynptr_alloc,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_ANYTHING,
+	.arg2_type	=3D ARG_ANYTHING,
+	.arg3_type	=3D ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_MALLOC | MEM_UNINIT,
+};
+
+BPF_CALL_1(bpf_dynptr_put, struct bpf_dynptr_kern *, dynptr)
+{
+	kfree(dynptr->data);
+	bpf_dynptr_set_null(dynptr);
+	return 0;
+}
+
+const struct bpf_func_proto bpf_dynptr_put_proto =3D {
+	.func		=3D bpf_dynptr_put,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_VOID,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_MALLOC | OBJ_RELEASE,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
@@ -1448,6 +1519,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_loop_proto;
 	case BPF_FUNC_strncmp:
 		return &bpf_strncmp_proto;
+	case BPF_FUNC_dynptr_alloc:
+		return &bpf_dynptr_alloc_proto;
+	case BPF_FUNC_dynptr_put:
+		return &bpf_dynptr_put_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0fe1dea520ae..8cdedc776987 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -187,6 +187,10 @@ struct bpf_verifier_stack_elem {
 					  POISON_POINTER_DELTA))
 #define BPF_MAP_PTR(X)		((struct bpf_map *)((X) & ~BPF_MAP_PTR_UNPRIV))
=20
+static bool arg_type_is_mem_size(enum bpf_arg_type type);
+static int acquire_reference_state(struct bpf_verifier_env *env, int ins=
n_idx);
+static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d);
+
 static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
 {
 	return BPF_MAP_PTR(aux->map_ptr_state) =3D=3D BPF_MAP_PTR_POISON;
@@ -259,6 +263,7 @@ struct bpf_call_arg_meta {
 	u32 ret_btf_id;
 	u32 subprogno;
 	struct bpf_map_value_off_desc *kptr_off_desc;
+	u8 uninit_dynptr_regno;
 };
=20
 struct btf *btf_vmlinux;
@@ -580,6 +585,7 @@ static char slot_type_char[] =3D {
 	[STACK_SPILL]	=3D 'r',
 	[STACK_MISC]	=3D 'm',
 	[STACK_ZERO]	=3D '0',
+	[STACK_DYNPTR]	=3D 'd',
 };
=20
 static void print_liveness(struct bpf_verifier_env *env,
@@ -595,6 +601,25 @@ static void print_liveness(struct bpf_verifier_env *=
env,
 		verbose(env, "D");
 }
=20
+static inline int get_spi(s32 off)
+{
+	return (-off - 1) / BPF_REG_SIZE;
+}
+
+static bool is_spi_bounds_valid(struct bpf_func_state *state, int spi, i=
nt nr_slots)
+{
+	int allocated_slots =3D state->allocated_stack / BPF_REG_SIZE;
+
+	/* We need to check that slots between [spi - nr_slots + 1, spi] are
+	 * within [0, allocated_stack).
+	 *
+	 * Please note that the spi grows downwards. For example, a dynptr
+	 * takes the size of two stack slots; the first slot will be at
+	 * spi and the second slot will be at spi - 1.
+	 */
+	return spi - nr_slots + 1 >=3D 0 && spi < allocated_slots;
+}
+
 static struct bpf_func_state *func(struct bpf_verifier_env *env,
 				   const struct bpf_reg_state *reg)
 {
@@ -646,6 +671,130 @@ static void mark_verifier_state_scratched(struct bp=
f_verifier_env *env)
 	env->scratched_stack_slots =3D ~0ULL;
 }
=20
+static int arg_to_dynptr_type(enum bpf_arg_type arg_type)
+{
+	switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
+	case DYNPTR_TYPE_MALLOC:
+		return BPF_DYNPTR_TYPE_MALLOC;
+	default:
+		return BPF_DYNPTR_TYPE_INVALID;
+	}
+}
+
+static inline bool dynptr_type_refcounted(enum bpf_dynptr_type type)
+{
+	return type =3D=3D BPF_DYNPTR_TYPE_MALLOC;
+}
+
+static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg,
+				   enum bpf_arg_type arg_type, int insn_idx)
+{
+	struct bpf_func_state *state =3D cur_func(env);
+	enum bpf_dynptr_type type;
+	int spi, id, i;
+
+	spi =3D get_spi(reg->off);
+
+	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
+		return -EINVAL;
+
+	for (i =3D 0; i < BPF_REG_SIZE; i++) {
+		state->stack[spi].slot_type[i] =3D STACK_DYNPTR;
+		state->stack[spi - 1].slot_type[i] =3D STACK_DYNPTR;
+	}
+
+	type =3D arg_to_dynptr_type(arg_type);
+	if (type =3D=3D BPF_DYNPTR_TYPE_INVALID)
+		return -EINVAL;
+
+	state->stack[spi].spilled_ptr.dynptr.type =3D type;
+	state->stack[spi - 1].spilled_ptr.dynptr.type =3D type;
+
+	state->stack[spi].spilled_ptr.dynptr.first_slot =3D true;
+
+	if (dynptr_type_refcounted(type)) {
+		/* The id is used to track proper releasing */
+		id =3D acquire_reference_state(env, insn_idx);
+		if (id < 0)
+			return id;
+
+		state->stack[spi].spilled_ptr.id =3D id;
+		state->stack[spi - 1].spilled_ptr.id =3D id;
+	}
+
+	return 0;
+}
+
+static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struc=
t bpf_reg_state *reg)
+{
+	struct bpf_func_state *state =3D func(env, reg);
+	int spi, i;
+
+	spi =3D get_spi(reg->off);
+
+	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
+		return -EINVAL;
+
+	for (i =3D 0; i < BPF_REG_SIZE; i++) {
+		state->stack[spi].slot_type[i] =3D STACK_INVALID;
+		state->stack[spi - 1].slot_type[i] =3D STACK_INVALID;
+	}
+
+	/* Invalidate any slices associated with this dynptr */
+	if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) =
{
+		release_reference(env, state->stack[spi].spilled_ptr.id);
+		state->stack[spi].spilled_ptr.id =3D 0;
+		state->stack[spi - 1].spilled_ptr.id =3D 0;
+	}
+
+	state->stack[spi].spilled_ptr.dynptr.type =3D 0;
+	state->stack[spi - 1].spilled_ptr.dynptr.type =3D 0;
+
+	return 0;
+}
+
+static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, str=
uct bpf_reg_state *reg)
+{
+	struct bpf_func_state *state =3D func(env, reg);
+	int spi =3D get_spi(reg->off);
+	int i;
+
+	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
+		return true;
+
+	for (i =3D 0; i < BPF_REG_SIZE; i++) {
+		if (state->stack[spi].slot_type[i] =3D=3D STACK_DYNPTR ||
+		    state->stack[spi - 1].slot_type[i] =3D=3D STACK_DYNPTR)
+			return false;
+	}
+
+	return true;
+}
+
+static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struc=
t bpf_reg_state *reg,
+				     enum bpf_arg_type arg_type)
+{
+	struct bpf_func_state *state =3D func(env, reg);
+	int spi =3D get_spi(reg->off);
+	int i;
+
+	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
+	    !state->stack[spi].spilled_ptr.dynptr.first_slot)
+		return false;
+
+	for (i =3D 0; i < BPF_REG_SIZE; i++) {
+		if (state->stack[spi].slot_type[i] !=3D STACK_DYNPTR ||
+		    state->stack[spi - 1].slot_type[i] !=3D STACK_DYNPTR)
+			return false;
+	}
+
+	/* ARG_PTR_TO_DYNPTR takes any type of dynptr */
+	if (arg_type =3D=3D ARG_PTR_TO_DYNPTR)
+		return true;
+
+	return state->stack[spi].spilled_ptr.dynptr.type =3D=3D arg_to_dynptr_t=
ype(arg_type);
+}
+
 /* The reg state of a pointer or a bounded scalar was saved when
  * it was spilled to the stack.
  */
@@ -5400,6 +5549,16 @@ static bool arg_type_is_release(enum bpf_arg_type =
type)
 	return type & OBJ_RELEASE;
 }
=20
+static inline bool arg_type_is_dynptr(enum bpf_arg_type type)
+{
+	return base_type(type) =3D=3D ARG_PTR_TO_DYNPTR;
+}
+
+static inline bool arg_type_is_dynptr_uninit(enum bpf_arg_type type)
+{
+	return arg_type_is_dynptr(type) && (type & MEM_UNINIT);
+}
+
 static int int_ptr_type_to_size(enum bpf_arg_type type)
 {
 	if (type =3D=3D ARG_PTR_TO_INT)
@@ -5539,6 +5698,7 @@ static const struct bpf_reg_types *compatible_reg_t=
ypes[__BPF_ARG_TYPE_MAX] =3D {
 	[ARG_PTR_TO_CONST_STR]		=3D &const_str_ptr_types,
 	[ARG_PTR_TO_TIMER]		=3D &timer_types,
 	[ARG_PTR_TO_KPTR]		=3D &kptr_types,
+	[ARG_PTR_TO_DYNPTR]		=3D &stack_ptr_types,
 };
=20
 static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
@@ -5725,7 +5885,16 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
=20
 skip_type_check:
 	if (arg_type_is_release(arg_type)) {
-		if (!reg->ref_obj_id && !register_is_null(reg)) {
+		if (arg_type_is_dynptr(arg_type)) {
+			struct bpf_func_state *state =3D func(env, reg);
+			int spi =3D get_spi(reg->off);
+
+			if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
+			    !state->stack[spi].spilled_ptr.id) {
+				verbose(env, "arg %d is an unacquired reference\n", regno);
+				return -EINVAL;
+			}
+		} else if (!reg->ref_obj_id && !register_is_null(reg)) {
 			verbose(env, "R%d must be referenced when passed to release function\=
n",
 				regno);
 			return -EINVAL;
@@ -5837,6 +6006,43 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
 		bool zero_size_allowed =3D (arg_type =3D=3D ARG_CONST_SIZE_OR_ZERO);
=20
 		err =3D check_mem_size_reg(env, reg, regno, zero_size_allowed, meta);
+	} else if (arg_type_is_dynptr(arg_type)) {
+		/* Can't pass in a dynptr at a weird offset */
+		if (reg->off % BPF_REG_SIZE) {
+			verbose(env, "cannot pass in non-zero dynptr offset\n");
+			return -EINVAL;
+		}
+
+		if (arg_type & MEM_UNINIT)  {
+			if (!is_dynptr_reg_valid_uninit(env, reg)) {
+				verbose(env, "Arg #%d dynptr has to be an uninitialized dynptr\n",
+					arg + BPF_REG_1);
+				return -EINVAL;
+			}
+
+			/* We only support one dynptr being uninitialized at the moment,
+			 * which is sufficient for the helper functions we have right now.
+			 */
+			if (meta->uninit_dynptr_regno) {
+				verbose(env, "verifier internal error: more than one uninitialized d=
ynptr arg\n");
+				return -EFAULT;
+			}
+
+			meta->uninit_dynptr_regno =3D arg + BPF_REG_1;
+		} else if (!is_dynptr_reg_valid_init(env, reg, arg_type)) {
+			const char *err_extra =3D "";
+
+			switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
+			case DYNPTR_TYPE_MALLOC:
+				err_extra =3D "malloc ";
+				break;
+			default:
+				break;
+			}
+			verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
+				err_extra, arg + BPF_REG_1);
+			return -EINVAL;
+		}
 	} else if (arg_type_is_alloc_size(arg_type)) {
 		if (!tnum_is_const(reg->var_off)) {
 			verbose(env, "R%d is not a known constant'\n",
@@ -6963,9 +7169,27 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
=20
 	regs =3D cur_regs(env);
=20
+	if (meta.uninit_dynptr_regno) {
+		/* we write BPF_DW bits (8 bytes) at a time */
+		for (i =3D 0; i < BPF_DYNPTR_SIZE; i +=3D 8) {
+			err =3D check_mem_access(env, insn_idx, meta.uninit_dynptr_regno,
+					       i, BPF_DW, BPF_WRITE, -1, false);
+			if (err)
+				return err;
+		}
+
+		err =3D mark_stack_slots_dynptr(env, &regs[meta.uninit_dynptr_regno],
+					      fn->arg_type[meta.uninit_dynptr_regno - BPF_REG_1],
+					      insn_idx);
+		if (err)
+			return err;
+	}
+
 	if (meta.release_regno) {
 		err =3D -EINVAL;
-		if (meta.ref_obj_id)
+		if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1]))
+			err =3D unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
+		else if (meta.ref_obj_id)
 			err =3D release_reference(env, meta.ref_obj_id);
 		/* meta.ref_obj_id can only be 0 if register that is meant to be
 		 * released is NULL, which must be > R0.
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 096625242475..766dcbc73897 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -633,6 +633,7 @@ class PrinterHelpers(Printer):
             'struct socket',
             'struct file',
             'struct bpf_timer',
+            'struct bpf_dynptr',
     ]
     known_types =3D {
             '...',
@@ -682,6 +683,7 @@ class PrinterHelpers(Printer):
             'struct socket',
             'struct file',
             'struct bpf_timer',
+            'struct bpf_dynptr',
     }
     mapped_types =3D {
             'u8': '__u8',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 444fe6f1cf35..5a87ed654016 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5154,6 +5154,29 @@ union bpf_attr {
  *		if not NULL, is a reference which must be released using its
  *		corresponding release function, or moved into a BPF map before
  *		program exit.
+ *
+ * long bpf_dynptr_alloc(u32 size, u64 flags, struct bpf_dynptr *ptr)
+ *	Description
+ *		Allocate memory of *size* bytes.
+ *
+ *		Every call to bpf_dynptr_alloc must have a corresponding
+ *		bpf_dynptr_put, regardless of whether the bpf_dynptr_alloc
+ *		succeeded.
+ *
+ *		The maximum *size* supported is DYNPTR_MAX_SIZE.
+ *		Supported *flags* are __GFP_ZERO.
+ *	Return
+ *		0 on success, -ENOMEM if there is not enough memory for the
+ *		allocation, -E2BIG if the size exceeds DYNPTR_MAX_SIZE, -EINVAL
+ *		if the flags is not supported.
+ *
+ * void bpf_dynptr_put(struct bpf_dynptr *ptr)
+ *	Description
+ *		Free memory allocated by bpf_dynptr_alloc.
+ *
+ *		After this operation, *ptr* will be an invalidated dynptr.
+ *	Return
+ *		Void.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5351,6 +5374,8 @@ union bpf_attr {
 	FN(skb_set_tstamp),		\
 	FN(ima_file_hash),		\
 	FN(kptr_xchg),			\
+	FN(dynptr_alloc),		\
+	FN(dynptr_put),			\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
@@ -6498,6 +6523,11 @@ struct bpf_timer {
 	__u64 :64;
 } __attribute__((aligned(8)));
=20
+struct bpf_dynptr {
+	__u64 :64;
+	__u64 :64;
+} __attribute__((aligned(8)));
+
 struct bpf_sysctl {
 	__u32	write;		/* Sysctl is being read (=3D 0) or written (=3D 1).
 				 * Allows 1,2,4-byte read, but no write.
--=20
2.30.2

