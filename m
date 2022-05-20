Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BB752E3FB
	for <lists+bpf@lfdr.de>; Fri, 20 May 2022 06:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345355AbiETEnb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 00:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbiETEn2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 00:43:28 -0400
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB7514AA74
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 21:43:26 -0700 (PDT)
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id BF56AC9E1FF0; Thu, 19 May 2022 21:43:13 -0700 (PDT)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v5 1/6] bpf: Add verifier support for dynptrs
Date:   Thu, 19 May 2022 21:42:40 -0700
Message-Id: <20220520044245.3305025-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220520044245.3305025-1-joannelkoong@gmail.com>
References: <20220520044245.3305025-1-joannelkoong@gmail.com>
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
pointers (dynptrs) in bpf.

A bpf_dynptr is opaque to the bpf program. It is a 16-byte structure
defined internally as:

struct bpf_dynptr_kern {
    void *data;
    u32 size;
    u32 offset;
} __aligned(8);

The upper 8 bits of *size* is reserved (it contains extra metadata about
read-only status and dynptr type). Consequently, a dynptr only supports
memory less than 16 MB.

There are different types of dynptrs (eg malloc, ringbuf, ...). In this
patchset, the most basic one, dynptrs to a bpf program's local memory,
is added. For now only local memory that is of reg type PTR_TO_MAP_VALUE
is supported.

In the verifier, dynptr state information will be tracked in stack
slots. When the program passes in an uninitialized dynptr
(ARG_PTR_TO_DYNPTR | MEM_UNINIT), the stack slots corresponding
to the frame pointer where the dynptr resides at are marked
STACK_DYNPTR. For helper functions that take in initialized dynptrs (eg
bpf_dynptr_read + bpf_dynptr_write which are added later in this
patchset), the verifier enforces that the dynptr has been initialized
properly by checking that their corresponding stack slots have been
marked as STACK_DYNPTR.

The 6th patch in this patchset adds test cases that the verifier should
successfully reject, such as for example attempting to use a dynptr
after doing a direct write into it inside the bpf program.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: David Vernet <void@manifault.com>
---
 include/linux/bpf.h            |  28 +++++
 include/linux/bpf_verifier.h   |  18 ++++
 include/uapi/linux/bpf.h       |   5 +
 kernel/bpf/verifier.c          | 188 ++++++++++++++++++++++++++++++++-
 scripts/bpf_doc.py             |   2 +
 tools/include/uapi/linux/bpf.h |   5 +
 6 files changed, 243 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c107392b0ba7..f34f3ff36203 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -392,10 +392,15 @@ enum bpf_type_flag {
=20
 	MEM_UNINIT		=3D BIT(7 + BPF_BASE_TYPE_BITS),
=20
+	/* DYNPTR points to memory local to the bpf program. */
+	DYNPTR_TYPE_LOCAL	=3D BIT(8 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	=3D __BPF_TYPE_FLAG_MAX - 1,
 };
=20
+#define DYNPTR_TYPE_FLAG_MASK	DYNPTR_TYPE_LOCAL
+
 /* Max number of base types. */
 #define BPF_BASE_TYPE_LIMIT	(1UL << BPF_BASE_TYPE_BITS)
=20
@@ -438,6 +443,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string =
*/
 	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
 	ARG_PTR_TO_KPTR,	/* pointer to referenced kptr */
+	ARG_PTR_TO_DYNPTR,      /* pointer to bpf_dynptr. See bpf_type_flag for=
 dynptr type */
 	__BPF_ARG_TYPE_MAX,
=20
 	/* Extended arg_types. */
@@ -2374,4 +2380,26 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, c=
onst u64 *raw_args,
 			u32 **bin_buf, u32 num_args);
 void bpf_bprintf_cleanup(void);
=20
+/* the implementation of the opaque uapi struct bpf_dynptr */
+struct bpf_dynptr_kern {
+	void *data;
+	/* Size represents the number of usable bytes of dynptr data.
+	 * If for example the offset is at 4 for a local dynptr whose data is
+	 * of type u64, the number of usable bytes is 4.
+	 *
+	 * The upper 8 bits are reserved. It is as follows:
+	 * Bits 0 - 23 =3D size
+	 * Bits 24 - 30 =3D dynptr type
+	 * Bit 31 =3D whether dynptr is read-only
+	 */
+	u32 size;
+	u32 offset;
+} __aligned(8);
+
+enum bpf_dynptr_type {
+	BPF_DYNPTR_TYPE_INVALID,
+	/* Points to memory that is local to the bpf program */
+	BPF_DYNPTR_TYPE_LOCAL,
+};
+
 #endif /* _LINUX_BPF_H */
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1f1e7f2ea967..af5b2135215e 100644
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
@@ -174,9 +186,15 @@ enum bpf_stack_slot_type {
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
+#define BPF_DYNPTR_SIZE		sizeof(struct bpf_dynptr_kern)
+#define BPF_DYNPTR_NR_SLOTS		(BPF_DYNPTR_SIZE / BPF_REG_SIZE)
=20
 struct bpf_stack_state {
 	struct bpf_reg_state spilled_ptr;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0210f85131b3..c9cf76c1dc63 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6521,6 +6521,11 @@ struct bpf_timer {
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9b59581026f8..24437918121f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -259,6 +259,7 @@ struct bpf_call_arg_meta {
 	u32 ret_btf_id;
 	u32 subprogno;
 	struct bpf_map_value_off_desc *kptr_off_desc;
+	u8 uninit_dynptr_regno;
 };
=20
 struct btf *btf_vmlinux;
@@ -580,6 +581,7 @@ static char slot_type_char[] =3D {
 	[STACK_SPILL]	=3D 'r',
 	[STACK_MISC]	=3D 'm',
 	[STACK_ZERO]	=3D '0',
+	[STACK_DYNPTR]	=3D 'd',
 };
=20
 static void print_liveness(struct bpf_verifier_env *env,
@@ -595,6 +597,25 @@ static void print_liveness(struct bpf_verifier_env *=
env,
 		verbose(env, "D");
 }
=20
+static int get_spi(s32 off)
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
@@ -646,6 +667,108 @@ static void mark_verifier_state_scratched(struct bp=
f_verifier_env *env)
 	env->scratched_stack_slots =3D ~0ULL;
 }
=20
+static enum bpf_dynptr_type arg_to_dynptr_type(enum bpf_arg_type arg_typ=
e)
+{
+	switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
+	case DYNPTR_TYPE_LOCAL:
+		return BPF_DYNPTR_TYPE_LOCAL;
+	default:
+		return BPF_DYNPTR_TYPE_INVALID;
+	}
+}
+
+static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg,
+				   enum bpf_arg_type arg_type, int insn_idx)
+{
+	struct bpf_func_state *state =3D func(env, reg);
+	enum bpf_dynptr_type type;
+	int spi, i;
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
+	state->stack[spi].spilled_ptr.dynptr.first_slot =3D true;
+	state->stack[spi].spilled_ptr.dynptr.type =3D type;
+	state->stack[spi - 1].spilled_ptr.dynptr.type =3D type;
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
+	state->stack[spi].spilled_ptr.dynptr.first_slot =3D false;
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
@@ -5399,6 +5522,11 @@ static bool arg_type_is_release(enum bpf_arg_type =
type)
 	return type & OBJ_RELEASE;
 }
=20
+static bool arg_type_is_dynptr(enum bpf_arg_type type)
+{
+	return base_type(type) =3D=3D ARG_PTR_TO_DYNPTR;
+}
+
 static int int_ptr_type_to_size(enum bpf_arg_type type)
 {
 	if (type =3D=3D ARG_PTR_TO_INT)
@@ -5538,6 +5666,7 @@ static const struct bpf_reg_types *compatible_reg_t=
ypes[__BPF_ARG_TYPE_MAX] =3D {
 	[ARG_PTR_TO_CONST_STR]		=3D &const_str_ptr_types,
 	[ARG_PTR_TO_TIMER]		=3D &timer_types,
 	[ARG_PTR_TO_KPTR]		=3D &kptr_types,
+	[ARG_PTR_TO_DYNPTR]		=3D &stack_ptr_types,
 };
=20
 static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
@@ -5627,8 +5756,13 @@ int check_func_arg_reg_off(struct bpf_verifier_env=
 *env,
 	bool fixed_off_ok =3D false;
=20
 	switch ((u32)type) {
-	case SCALAR_VALUE:
 	/* Pointer types where reg offset is explicitly allowed: */
+	case PTR_TO_STACK:
+		if (arg_type_is_dynptr(arg_type) && reg->off % BPF_REG_SIZE) {
+			verbose(env, "cannot pass in dynptr at an offset\n");
+			return -EINVAL;
+		}
+		fallthrough;
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
 	case PTR_TO_MAP_KEY:
@@ -5638,7 +5772,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env =
*env,
 	case PTR_TO_MEM | MEM_ALLOC:
 	case PTR_TO_BUF:
 	case PTR_TO_BUF | MEM_RDONLY:
-	case PTR_TO_STACK:
+	case SCALAR_VALUE:
 		/* Some of the argument types nevertheless require a
 		 * zero register offset.
 		 */
@@ -5836,6 +5970,36 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
 		bool zero_size_allowed =3D (arg_type =3D=3D ARG_CONST_SIZE_OR_ZERO);
=20
 		err =3D check_mem_size_reg(env, reg, regno, zero_size_allowed, meta);
+	} else if (arg_type_is_dynptr(arg_type)) {
+		if (arg_type & MEM_UNINIT) {
+			if (!is_dynptr_reg_valid_uninit(env, reg)) {
+				verbose(env, "Dynptr has to be an uninitialized dynptr\n");
+				return -EINVAL;
+			}
+
+			/* We only support one dynptr being uninitialized at the moment,
+			 * which is sufficient for the helper functions we have right now.
+			 */
+			if (meta->uninit_dynptr_regno) {
+				verbose(env, "verifier internal error: multiple uninitialized dynptr=
 args\n");
+				return -EFAULT;
+			}
+
+			meta->uninit_dynptr_regno =3D regno;
+		} else if (!is_dynptr_reg_valid_init(env, reg, arg_type)) {
+			const char *err_extra =3D "";
+
+			switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
+			case DYNPTR_TYPE_LOCAL:
+				err_extra =3D "local ";
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
@@ -6969,9 +7133,27 @@ static int check_helper_call(struct bpf_verifier_e=
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
index 0210f85131b3..c9cf76c1dc63 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6521,6 +6521,11 @@ struct bpf_timer {
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

