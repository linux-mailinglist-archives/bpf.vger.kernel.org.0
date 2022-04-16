Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE4F503498
	for <lists+bpf@lfdr.de>; Sat, 16 Apr 2022 08:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiDPHCL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 16 Apr 2022 03:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDPHCL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Apr 2022 03:02:11 -0400
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B924D9CC
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 23:59:37 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id AE635B1DE61B; Fri, 15 Apr 2022 23:35:39 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, memxor@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, toke@redhat.com,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v2 3/7] bpf: Add bpf_dynptr_from_mem, bpf_dynptr_alloc, bpf_dynptr_put
Date:   Fri, 15 Apr 2022 23:34:25 -0700
Message-Id: <20220416063429.3314021-4-joannelkoong@gmail.com>
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

This patch adds 3 new APIs and the bulk of the verifier work for
supporting dynamic pointers in bpf.

There are different types of dynptrs. This patch starts with the most
basic ones, ones that reference a program's local memory
(eg a stack variable) and ones that reference memory that is dynamically
allocated on behalf of the program. If the memory is dynamically
allocated by the program, the program *must* free it before the program
exits. This is enforced by the verifier.

The added APIs are:

long bpf_dynptr_from_mem(void *data, u32 size, u64 flags, struct bpf_dynp=
tr *ptr);
long bpf_dynptr_alloc(u32 size, u64 flags, struct bpf_dynptr *ptr);
void bpf_dynptr_put(struct bpf_dynptr *ptr);

This patch sets up the verifier to support dynptrs. Dynptrs will always
reside on the program's stack frame. As such, their state is tracked
in their corresponding stack slot, which includes the type of dynptr
(DYNPTR_LOCAL vs. DYNPTR_MALLOC).

When the program passes in an uninitialized dynptr (ARG_PTR_TO_DYNPTR |
MEM_UNINIT), the stack slots corresponding to the frame pointer
where the dynptr resides at are marked as STACK_DYNPTR. For helper functi=
ons
that take in initialized dynptrs (such as the next patch in this series
which supports dynptr reads/writes), the verifier enforces that the
dynptr has been initialized by checking that their corresponding stack
slots have been marked as STACK_DYNPTR. Dynptr release functions
(eg bpf_dynptr_put) will clear the stack slots. The verifier enforces at
program exit that there are no acquired dynptr stack slots that need
to be released.

There are other constraints that are enforced by the verifier as
well, such as that the dynptr cannot be written to directly by the bpf
program or by non-dynptr helper functions. The last patch in this series
contains tests that trigger different cases that the verifier needs to
successfully reject.

For now, local dynptrs cannot point to referenced memory since the
memory can be freed anytime. Support for this will be added as part
of a separate patchset.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/bpf.h            |  68 +++++-
 include/linux/bpf_verifier.h   |  28 +++
 include/uapi/linux/bpf.h       |  44 ++++
 kernel/bpf/helpers.c           | 110 ++++++++++
 kernel/bpf/verifier.c          | 372 +++++++++++++++++++++++++++++++--
 scripts/bpf_doc.py             |   2 +
 tools/include/uapi/linux/bpf.h |  44 ++++
 7 files changed, 654 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 29964cdb1dd6..fee91b07ee74 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -346,7 +346,16 @@ enum bpf_type_flag {
=20
 	OBJ_RELEASE		=3D BIT(6 + BPF_BASE_TYPE_BITS),
=20
-	__BPF_TYPE_LAST_FLAG	=3D OBJ_RELEASE,
+	/* DYNPTR points to a program's local memory (eg stack variable). */
+	DYNPTR_TYPE_LOCAL	=3D BIT(7 + BPF_BASE_TYPE_BITS),
+
+	/* DYNPTR points to dynamically allocated memory. */
+	DYNPTR_TYPE_MALLOC	=3D BIT(8 + BPF_BASE_TYPE_BITS),
+
+	/* May not be a referenced object */
+	NO_OBJ_REF		=3D BIT(9 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	=3D NO_OBJ_REF,
 };
=20
 /* Max number of base types. */
@@ -390,6 +399,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_STACK,	/* pointer to stack */
 	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string =
*/
 	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
+	ARG_PTR_TO_DYNPTR,      /* pointer to bpf_dynptr. See bpf_type_flag for=
 dynptr type */
 	__BPF_ARG_TYPE_MAX,
=20
 	/* Extended arg_types. */
@@ -2394,4 +2404,60 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, c=
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
+	/* Local memory used by the bpf program (eg stack variable) */
+	BPF_DYNPTR_TYPE_LOCAL,
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
index 7a01adc9e13f..e11440a44e92 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -72,6 +72,27 @@ struct bpf_reg_state {
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
+		/* For stack slots that a local dynptr points to. We need to track
+		 * this to prohibit programs from using stack variables that are
+		 * pointed to by dynptrs as a dynptr, eg something like
+		 *
+		 * bpf_dyntpr_from_mem(&ptr, sizeof(ptr), 0, &local);
+		 * bpf_dynptr_alloc(16, 0, &ptr);
+		 * bpf_dynptr_write(&local, 0, corrupt_data, sizeof(ptr));
+		 */
+		bool is_dynptr_data;
+
 		/* Max size from any of the above. */
 		struct {
 			unsigned long raw1;
@@ -174,9 +195,16 @@ enum bpf_stack_slot_type {
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
index d14b10b85e51..e339b2697d9a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5143,6 +5143,42 @@ union bpf_attr {
  *		The **hash_algo** is returned on success,
  *		**-EOPNOTSUP** if the hash calculation failed or **-EINVAL** if
  *		invalid arguments are passed.
+ *
+ * long bpf_dynptr_from_mem(void *data, u32 size, u64 flags, struct bpf_=
dynptr *ptr)
+ *	Description
+ *		Get a dynptr to local memory *data*.
+ *
+ *		For a dynptr to a dynamic memory allocation, please use
+ *		bpf_dynptr_alloc instead.
+ *
+ *		The maximum *size* supported is DYNPTR_MAX_SIZE.
+ *		*flags* is currently unused.
+ *	Return
+ *		0 on success, -E2BIG if the size exceeds DYNPTR_MAX_SIZE,
+ *		-EINVAL if flags is not 0.
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
@@ -5339,6 +5375,9 @@ union bpf_attr {
 	FN(copy_from_user_task),	\
 	FN(skb_set_tstamp),		\
 	FN(ima_file_hash),		\
+	FN(dynptr_from_mem),		\
+	FN(dynptr_alloc),		\
+	FN(dynptr_put),			\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
@@ -6486,6 +6525,11 @@ struct bpf_timer {
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
index a47aae5c7335..87c14edda315 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1374,6 +1374,110 @@ void bpf_timer_cancel_and_free(void *val)
 	kfree(t);
 }
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
+BPF_CALL_4(bpf_dynptr_from_mem, void *, data, u32, size, u64, flags, str=
uct bpf_dynptr_kern *, ptr)
+{
+	int err;
+
+	err =3D bpf_dynptr_check_size(size);
+	if (err)
+		goto error;
+
+	/* flags is currently unsupported */
+	if (flags) {
+		err =3D -EINVAL;
+		goto error;
+	}
+
+	bpf_dynptr_init(ptr, data, BPF_DYNPTR_TYPE_LOCAL, 0, size);
+
+	return 0;
+
+error:
+	bpf_dynptr_set_null(ptr);
+	return err;
+}
+
+const struct bpf_func_proto bpf_dynptr_from_mem_proto =3D {
+	.func		=3D bpf_dynptr_from_mem,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_MEM_UNINIT | NO_OBJ_REF,
+	.arg2_type	=3D ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	=3D ARG_ANYTHING,
+	.arg4_type	=3D ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT,
+};
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
@@ -1426,6 +1530,12 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_loop_proto;
 	case BPF_FUNC_strncmp:
 		return &bpf_strncmp_proto;
+	case BPF_FUNC_dynptr_from_mem:
+		return &bpf_dynptr_from_mem_proto;
+	case BPF_FUNC_dynptr_alloc:
+		return &bpf_dynptr_alloc_proto;
+	case BPF_FUNC_dynptr_put:
+		return &bpf_dynptr_put_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8deb588a19ce..bf132c6822e4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -187,6 +187,9 @@ struct bpf_verifier_stack_elem {
 					  POISON_POINTER_DELTA))
 #define BPF_MAP_PTR(X)		((struct bpf_map *)((X) & ~BPF_MAP_PTR_UNPRIV))
=20
+/* forward declarations */
+static bool arg_type_is_mem_size(enum bpf_arg_type type);
+
 static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
 {
 	return BPF_MAP_PTR(aux->map_ptr_state) =3D=3D BPF_MAP_PTR_POISON;
@@ -257,7 +260,9 @@ struct bpf_call_arg_meta {
 	struct btf *ret_btf;
 	u32 ret_btf_id;
 	u32 subprogno;
-	bool release_ref;
+	u8 release_regno;
+	bool release_dynptr;
+	u8 uninit_dynptr_regno;
 };
=20
 struct btf *btf_vmlinux;
@@ -576,6 +581,7 @@ static char slot_type_char[] =3D {
 	[STACK_SPILL]	=3D 'r',
 	[STACK_MISC]	=3D 'm',
 	[STACK_ZERO]	=3D '0',
+	[STACK_DYNPTR]	=3D 'd',
 };
=20
 static void print_liveness(struct bpf_verifier_env *env,
@@ -591,6 +597,25 @@ static void print_liveness(struct bpf_verifier_env *=
env,
 		verbose(env, "D");
 }
=20
+static inline int get_spi(s32 off)
+{
+	return (-off - 1) / BPF_REG_SIZE;
+}
+
+static bool is_spi_bounds_valid(struct bpf_func_state *state, int spi, u=
32 nr_slots)
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
@@ -642,6 +667,191 @@ static void mark_verifier_state_scratched(struct bp=
f_verifier_env *env)
 	env->scratched_stack_slots =3D ~0ULL;
 }
=20
+#define DYNPTR_TYPE_FLAG_MASK (DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_MALLOC)
+
+static int arg_to_dynptr_type(enum bpf_arg_type arg_type)
+{
+	switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
+	case DYNPTR_TYPE_LOCAL:
+		return BPF_DYNPTR_TYPE_LOCAL;
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
+				   enum bpf_arg_type arg_type)
+{
+	struct bpf_func_state *state =3D cur_func(env);
+	enum bpf_dynptr_type type;
+	int spi, i;
+
+	spi =3D get_spi(reg->off);
+
+	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
+		return -EINVAL;
+
+	type =3D arg_to_dynptr_type(arg_type);
+	if (type =3D=3D BPF_DYNPTR_TYPE_INVALID)
+		return -EINVAL;
+
+	for (i =3D 0; i < BPF_REG_SIZE; i++) {
+		state->stack[spi].slot_type[i] =3D STACK_DYNPTR;
+		state->stack[spi - 1].slot_type[i] =3D STACK_DYNPTR;
+	}
+
+	state->stack[spi].spilled_ptr.dynptr.type =3D type;
+	state->stack[spi - 1].spilled_ptr.dynptr.type =3D type;
+
+	state->stack[spi].spilled_ptr.dynptr.first_slot =3D true;
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
+	state->stack[spi].spilled_ptr.dynptr.type =3D 0;
+	state->stack[spi - 1].spilled_ptr.dynptr.type =3D 0;
+
+	state->stack[spi].spilled_ptr.dynptr.first_slot =3D 0;
+
+	return 0;
+}
+
+static int mark_as_dynptr_data(struct bpf_verifier_env *env, const struc=
t bpf_func_proto *fn,
+			       struct bpf_reg_state *regs)
+{
+	struct bpf_func_state *state =3D cur_func(env);
+	struct bpf_reg_state *reg, *mem_reg =3D NULL;
+	enum bpf_arg_type arg_type;
+	u64 mem_size;
+	u32 nr_slots;
+	int i, spi;
+
+	/* We must protect against the case where a program tries to do somethi=
ng
+	 * like this:
+	 *
+	 * bpf_dynptr_from_mem(&ptr, sizeof(ptr), 0, &local);
+	 * bpf_dynptr_alloc(16, 0, &ptr);
+	 * bpf_dynptr_write(&local, 0, corrupt_data, sizeof(ptr));
+	 *
+	 * If ptr is a variable on the stack, we must mark the stack slot as
+	 * dynptr data when a local dynptr to it is created.
+	 */
+	for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
+		arg_type =3D fn->arg_type[i];
+		reg =3D &regs[BPF_REG_1 + i];
+
+		if (base_type(arg_type) =3D=3D ARG_PTR_TO_MEM) {
+			if (base_type(reg->type) =3D=3D PTR_TO_STACK) {
+				mem_reg =3D reg;
+				continue;
+			}
+			/* if it's not a PTR_TO_STACK, then we don't need to
+			 * mark anything since it can never be used as a dynptr.
+			 * We can just return here since there will always be
+			 * only one ARG_PTR_TO_MEM in fn.
+			 */
+			return 0;
+		} else if (arg_type_is_mem_size(arg_type)) {
+			mem_size =3D roundup(reg->var_off.value, BPF_REG_SIZE);
+		}
+	}
+
+	if (!mem_reg || !mem_size) {
+		verbose(env, "verifier internal error: invalid ARG_PTR_TO_MEM args for=
 %s\n", __func__);
+		return -EFAULT;
+	}
+
+	spi =3D get_spi(mem_reg->off);
+	if (!is_spi_bounds_valid(state, spi, mem_size)) {
+		verbose(env, "verifier internal error: variable not initialized on sta=
ck in %s\n", __func__);
+		return -EFAULT;
+	}
+
+	nr_slots =3D mem_size / BPF_REG_SIZE;
+	for (i =3D 0; i < nr_slots; i++)
+		state->stack[spi - i].spilled_ptr.is_dynptr_data =3D true;
+
+	return 0;
+}
+
+static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, str=
uct bpf_reg_state *reg,
+				       bool *is_dynptr_data)
+{
+	struct bpf_func_state *state =3D func(env, reg);
+	int spi;
+
+	spi =3D get_spi(reg->off);
+
+	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
+		return true;
+
+	if (state->stack[spi].slot_type[0] =3D=3D STACK_DYNPTR ||
+	    state->stack[spi - 1].slot_type[0] =3D=3D STACK_DYNPTR)
+		return false;
+
+	if (state->stack[spi].spilled_ptr.is_dynptr_data ||
+	    state->stack[spi - 1].spilled_ptr.is_dynptr_data) {
+		*is_dynptr_data =3D true;
+		return false;
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
+
+	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
+	    state->stack[spi].slot_type[0] !=3D STACK_DYNPTR ||
+	    state->stack[spi - 1].slot_type[0] !=3D STACK_DYNPTR ||
+	    !state->stack[spi].spilled_ptr.dynptr.first_slot)
+		return false;
+
+	/* ARG_PTR_TO_DYNPTR takes any type of dynptr */
+	if (arg_type =3D=3D ARG_PTR_TO_DYNPTR)
+		return true;
+
+	return state->stack[spi].spilled_ptr.dynptr.type =3D=3D arg_to_dynptr_t=
ype(arg_type);
+}
+
+static bool stack_access_into_dynptr(struct bpf_func_state *state, int s=
pi, int size)
+{
+	int nr_slots =3D roundup(size, BPF_REG_SIZE) / BPF_REG_SIZE;
+	int i;
+
+	for (i =3D 0; i < nr_slots; i++) {
+		if (state->stack[spi - i].slot_type[0] =3D=3D STACK_DYNPTR)
+			return true;
+	}
+
+	return false;
+}
+
 /* The reg state of a pointer or a bounded scalar was saved when
  * it was spilled to the stack.
  */
@@ -2878,6 +3088,12 @@ static int check_stack_write_fixed_off(struct bpf_=
verifier_env *env,
 	}
=20
 	mark_stack_slot_scratched(env, spi);
+
+	if (stack_access_into_dynptr(state, spi, size)) {
+		verbose(env, "direct write into dynptr is not permitted\n");
+		return -EINVAL;
+	}
+
 	if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) &&
 	    !register_is_null(reg) && env->bpf_capable) {
 		if (dst_reg !=3D BPF_REG_FP) {
@@ -2999,6 +3215,12 @@ static int check_stack_write_var_off(struct bpf_ve=
rifier_env *env,
 		slot =3D -i - 1;
 		spi =3D slot / BPF_REG_SIZE;
 		stype =3D &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
+
+		if (*stype =3D=3D STACK_DYNPTR) {
+			verbose(env, "direct write into dynptr is not permitted\n");
+			return -EINVAL;
+		}
+
 		mark_stack_slot_scratched(env, spi);
=20
 		if (!env->allow_ptr_leaks
@@ -5141,6 +5363,16 @@ static bool arg_type_is_int_ptr(enum bpf_arg_type =
type)
 	       type =3D=3D ARG_PTR_TO_LONG;
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
@@ -5278,6 +5510,7 @@ static const struct bpf_reg_types *compatible_reg_t=
ypes[__BPF_ARG_TYPE_MAX] =3D {
 	[ARG_PTR_TO_STACK]		=3D &stack_ptr_types,
 	[ARG_PTR_TO_CONST_STR]		=3D &const_str_ptr_types,
 	[ARG_PTR_TO_TIMER]		=3D &timer_types,
+	[ARG_PTR_TO_DYNPTR]		=3D &stack_ptr_types,
 };
=20
 static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
@@ -5450,10 +5683,16 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
 		return err;
=20
 skip_type_check:
-	/* check_func_arg_reg_off relies on only one referenced register being
-	 * allowed for BPF helpers.
-	 */
 	if (reg->ref_obj_id) {
+		if (arg_type & NO_OBJ_REF) {
+			verbose(env, "Arg #%d cannot be a referenced object\n",
+				arg + 1);
+			return -EINVAL;
+		}
+
+		/* check_func_arg_reg_off relies on only one referenced register being
+		 * allowed for BPF helpers.
+		 */
 		if (meta->ref_obj_id) {
 			verbose(env, "verifier internal error: more than one arg with ref_obj=
_id R%d %u %u\n",
 				regno, reg->ref_obj_id,
@@ -5463,16 +5702,26 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
 		meta->ref_obj_id =3D reg->ref_obj_id;
 	}
 	if (arg_type & OBJ_RELEASE) {
-		if (!reg->ref_obj_id) {
+		if (arg_type_is_dynptr(arg_type)) {
+			struct bpf_func_state *state =3D func(env, reg);
+			int spi =3D get_spi(reg->off);
+
+			if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
+			    !state->stack[spi].spilled_ptr.id) {
+				verbose(env, "arg %d is an unacquired reference\n", regno);
+				return -EINVAL;
+			}
+			meta->release_dynptr =3D true;
+		} else if (!reg->ref_obj_id) {
 			verbose(env, "arg %d is an unacquired reference\n", regno);
 			return -EINVAL;
 		}
-		if (meta->release_ref) {
-			verbose(env, "verifier internal error: more than one release_ref arg =
R%d\n",
-				regno);
+		if (meta->release_regno) {
+			verbose(env, "verifier internal error: more than one release_regno %u=
 %u\n",
+				meta->release_regno, regno);
 			return -EFAULT;
 		}
-		meta->release_ref =3D true;
+		meta->release_regno =3D regno;
 	}
=20
 	if (arg_type =3D=3D ARG_CONST_MAP_PTR) {
@@ -5565,6 +5814,44 @@ static int check_func_arg(struct bpf_verifier_env =
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
+			bool is_dynptr_data =3D false;
+
+			if (!is_dynptr_reg_valid_uninit(env, reg, &is_dynptr_data)) {
+				if (is_dynptr_data)
+					verbose(env, "Arg #%d cannot be a memory reference for another dynp=
tr\n",
+						arg + 1);
+				else
+					verbose(env, "Arg #%d dynptr has to be an uninitialized dynptr\n",
+						arg + 1);
+				return -EINVAL;
+			}
+
+			meta->uninit_dynptr_regno =3D arg + BPF_REG_1;
+		} else if (!is_dynptr_reg_valid_init(env, reg, arg_type)) {
+			const char *err_extra =3D "";
+
+			switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
+			case DYNPTR_TYPE_LOCAL:
+				err_extra =3D "local ";
+				break;
+			case DYNPTR_TYPE_MALLOC:
+				err_extra =3D "malloc ";
+				break;
+			default:
+				break;
+			}
+			verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
+				err_extra, arg + 1);
+			return -EINVAL;
+		}
 	} else if (arg_type_is_alloc_size(arg_type)) {
 		if (!tnum_is_const(reg->var_off)) {
 			verbose(env, "R%d is not a known constant'\n",
@@ -6545,6 +6832,28 @@ static int check_reference_leak(struct bpf_verifie=
r_env *env)
 	return state->acquired_refs ? -EINVAL : 0;
 }
=20
+/* Called at BPF_EXIT to detect if there are any reference-tracked dynpt=
rs that have
+ * not been released. Dynptrs to local memory do not need to be released=
.
+ */
+static int check_dynptr_unreleased(struct bpf_verifier_env *env)
+{
+	struct bpf_func_state *state =3D cur_func(env);
+	int allocated_slots, i;
+
+	allocated_slots =3D state->allocated_stack / BPF_REG_SIZE;
+
+	for (i =3D 0; i < allocated_slots; i++) {
+		if (state->stack[i].slot_type[0] =3D=3D STACK_DYNPTR) {
+			if (dynptr_type_refcounted(state->stack[i].spilled_ptr.dynptr.type)) =
{
+				verbose(env, "spi=3D%d is an unreleased dynptr\n", i);
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *regs)
 {
@@ -6686,8 +6995,38 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 			return err;
 	}
=20
-	if (meta.release_ref) {
-		err =3D release_reference(env, meta.ref_obj_id);
+	regs =3D cur_regs(env);
+
+	if (meta.uninit_dynptr_regno) {
+		enum bpf_arg_type type;
+
+		/* we write BPF_W bits (4 bytes) at a time */
+		for (i =3D 0; i < BPF_DYNPTR_SIZE; i +=3D 4) {
+			err =3D check_mem_access(env, insn_idx, meta.uninit_dynptr_regno,
+					       i, BPF_W, BPF_WRITE, -1, false);
+			if (err)
+				return err;
+		}
+
+		type =3D fn->arg_type[meta.uninit_dynptr_regno - BPF_REG_1];
+
+		err =3D mark_stack_slots_dynptr(env, &regs[meta.uninit_dynptr_regno], =
type);
+		if (err)
+			return err;
+
+		if (type & DYNPTR_TYPE_LOCAL) {
+			err =3D mark_as_dynptr_data(env, fn, regs);
+			if (err)
+				return err;
+		}
+	}
+
+	if (meta.release_regno) {
+		if (meta.release_dynptr) {
+			err =3D unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
+		} else {
+			err =3D release_reference(env, meta.ref_obj_id);
+		}
 		if (err) {
 			verbose(env, "func %s#%d reference has not been acquired before\n",
 				func_id_name(func_id), func_id);
@@ -6695,8 +7034,6 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 		}
 	}
=20
-	regs =3D cur_regs(env);
-
 	switch (func_id) {
 	case BPF_FUNC_tail_call:
 		err =3D check_reference_leak(env);
@@ -6704,6 +7041,11 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 			verbose(env, "tail_call would lead to reference leak\n");
 			return err;
 		}
+		err =3D check_dynptr_unreleased(env);
+		if (err) {
+			verbose(env, "tail_call would lead to dynptr memory leak\n");
+			return err;
+		}
 		break;
 	case BPF_FUNC_get_local_storage:
 		/* check that flags argument in get_local_storage(map, flags) is 0,
@@ -11696,6 +12038,10 @@ static int do_check(struct bpf_verifier_env *env=
)
 					return -EINVAL;
 				}
=20
+				err =3D check_dynptr_unreleased(env);
+				if (err)
+					return err;
+
 				if (state->curframe) {
 					/* exit from nested function */
 					err =3D prepare_func_exit(env, &env->insn_idx);
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
index d14b10b85e51..e339b2697d9a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5143,6 +5143,42 @@ union bpf_attr {
  *		The **hash_algo** is returned on success,
  *		**-EOPNOTSUP** if the hash calculation failed or **-EINVAL** if
  *		invalid arguments are passed.
+ *
+ * long bpf_dynptr_from_mem(void *data, u32 size, u64 flags, struct bpf_=
dynptr *ptr)
+ *	Description
+ *		Get a dynptr to local memory *data*.
+ *
+ *		For a dynptr to a dynamic memory allocation, please use
+ *		bpf_dynptr_alloc instead.
+ *
+ *		The maximum *size* supported is DYNPTR_MAX_SIZE.
+ *		*flags* is currently unused.
+ *	Return
+ *		0 on success, -E2BIG if the size exceeds DYNPTR_MAX_SIZE,
+ *		-EINVAL if flags is not 0.
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
@@ -5339,6 +5375,9 @@ union bpf_attr {
 	FN(copy_from_user_task),	\
 	FN(skb_set_tstamp),		\
 	FN(ima_file_hash),		\
+	FN(dynptr_from_mem),		\
+	FN(dynptr_alloc),		\
+	FN(dynptr_put),			\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
@@ -6486,6 +6525,11 @@ struct bpf_timer {
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

