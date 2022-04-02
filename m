Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF85B4EFDE3
	for <lists+bpf@lfdr.de>; Sat,  2 Apr 2022 04:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbiDBCBv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Apr 2022 22:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbiDBCBu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Apr 2022 22:01:50 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DB2111752
        for <bpf@vger.kernel.org>; Fri,  1 Apr 2022 18:59:58 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2320C6ZA031458
        for <bpf@vger.kernel.org>; Fri, 1 Apr 2022 18:59:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=xuh2pjN+YwLe8RWXzrXXIPdWMGqsyF0e8GJDvHOm7aE=;
 b=DJJf/2/8AjrYyDQgGUDogo6OQBQaBquvVeCorlDXD9RprHH5EiagbHPfStAWsAJD1xi8
 GQmOcEzps3V6Nq1fpuHA6HBvXaVz2n2pzCPt7Rkp3xvoJsxi2Q/9YaAGgSQnHMaXLF3k
 oa+uj/GdTd7X8qMNHTXhgAi0Iw2l8GBOM48= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f5gpgaxa5-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 01 Apr 2022 18:59:57 -0700
Received: from twshared14141.02.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 18:59:55 -0700
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id D1C94A79067A; Fri,  1 Apr 2022 18:59:43 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 3/7] bpf: Add bpf_dynptr_from_mem, bpf_malloc, bpf_free
Date:   Fri, 1 Apr 2022 18:58:22 -0700
Message-ID: <20220402015826.3941317-4-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220402015826.3941317-1-joannekoong@fb.com>
References: <20220402015826.3941317-1-joannekoong@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mq8J9NRTKpVRqTEN4Dj0yiZhrA4OqC7_
X-Proofpoint-GUID: mq8J9NRTKpVRqTEN4Dj0yiZhrA4OqC7_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_08,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Joanne Koong <joannelkoong@gmail.com>

This patch adds 3 new APIs and the bulk of the verifier work for
supporting dynamic pointers in bpf.

There are different types of dynptrs. This patch starts with the most
basic ones, ones that reference a program's local memory
(eg a stack variable) and ones that reference memory that is dynamically
allocated on behalf of the program. If the memory is dynamically
allocated by the program, the program *must* free it before the program
exits. This is enforced by the verifier.

The added APIs are:

long bpf_dynptr_from_mem(void *data, u32 size, struct bpf_dynptr *ptr);
long bpf_malloc(u32 size, struct bpf_dynptr *ptr);
void bpf_free(struct bpf_dynptr *ptr);

This patch sets up the verifier to support dynptrs. Dynptrs will always
reside on the program's stack frame. As such, their state is tracked
in their corresponding stack slot, which includes the type of dynptr
(DYNPTR_LOCAL vs. DYNPTR_MALLOC).

When the program passes in an uninitialized dynptr (ARG_PTR_TO_DYNPTR |
MEM_UNINIT), the stack slots corresponding to the frame pointer
where the dynptr resides at is marked as STACK_DYNPTR. For helper functio=
ns
that take in iniitalized dynptrs (such as the next patch in this series
which supports dynptr reads/writes), the verifier enforces that the
dynptr has been initialized by checking that their corresponding stack
slots have been marked as STACK_DYNPTR. Dynptr release functions
(eg bpf_free) will clear the stack slots. The verifier enforces at progra=
m
exit that there are no dynptr stack slots that need to be released.

There are other constraints that are enforced by the verifier as
well, such as that the dynptr cannot be written to directly by the bpf
program or by non-dynptr helper functions. The last patch in this series
contains tests that trigger different cases that the verifier needs to
successfully reject.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/bpf.h            |  74 ++++++++-
 include/linux/bpf_verifier.h   |  18 +++
 include/uapi/linux/bpf.h       |  40 +++++
 kernel/bpf/helpers.c           |  88 +++++++++++
 kernel/bpf/verifier.c          | 266 ++++++++++++++++++++++++++++++++-
 scripts/bpf_doc.py             |   2 +
 tools/include/uapi/linux/bpf.h |  40 +++++
 7 files changed, 521 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cb9f42866cde..e0fcff9f2aee 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -346,7 +346,13 @@ enum bpf_type_flag {
=20
 	MEM_RELEASE		=3D BIT(6 + BPF_BASE_TYPE_BITS),
=20
-	__BPF_TYPE_LAST_FLAG	=3D MEM_RELEASE,
+	/* DYNPTR points to a program's local memory (eg stack variable). */
+	DYNPTR_TYPE_LOCAL	=3D BIT(7 + BPF_BASE_TYPE_BITS),
+
+	/* DYNPTR points to dynamically allocated memory. */
+	DYNPTR_TYPE_MALLOC	=3D BIT(8 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	=3D DYNPTR_TYPE_MALLOC,
 };
=20
 /* Max number of base types. */
@@ -390,6 +396,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_STACK,	/* pointer to stack */
 	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string =
*/
 	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
+	ARG_PTR_TO_DYNPTR,      /* pointer to bpf_dynptr. See bpf_type_flag for=
 dynptr type */
 	__BPF_ARG_TYPE_MAX,
=20
 	/* Extended arg_types. */
@@ -2396,4 +2403,69 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, c=
onst u64 *raw_args,
 			u32 **bin_buf, u32 num_args);
 void bpf_bprintf_cleanup(void);
=20
+/* the implementation of the opaque uapi struct bpf_dynptr */
+struct bpf_dynptr_kern {
+	u8 *data;
+	/* The upper 4 bits are reserved. Bit 29 denotes whether the
+	 * dynptr is read-only. Bits 30 - 32 denote the dynptr type.
+	 */
+	u32 size;
+	u32 offset;
+} __aligned(8);
+
+enum bpf_dynptr_type {
+	/* Local memory used by the bpf program (eg stack variable) */
+	BPF_DYNPTR_TYPE_LOCAL,
+	/* Memory allocated dynamically by the kernel for the dynptr */
+	BPF_DYNPTR_TYPE_MALLOC,
+};
+
+/* The upper 4 bits of dynptr->size are reserved. Consequently, the
+ * maximum supported size is 2^28 - 1.
+ */
+#define DYNPTR_MAX_SIZE	((1UL << 28) - 1)
+#define DYNPTR_SIZE_MASK	0xFFFFFFF
+#define DYNPTR_TYPE_SHIFT	29
+
+static inline enum bpf_dynptr_type bpf_dynptr_get_type(struct bpf_dynptr=
_kern *ptr)
+{
+	return ptr->size >> DYNPTR_TYPE_SHIFT;
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
+	if (size =3D=3D 0)
+		return -EINVAL;
+
+	if (size > DYNPTR_MAX_SIZE)
+		return -E2BIG;
+
+	return 0;
+}
+
+static inline int bpf_dynptr_check_off_len(struct bpf_dynptr_kern *ptr, =
u32 offset, u32 len)
+{
+	u32 capacity =3D bpf_dynptr_get_size(ptr) - ptr->offset;
+
+	if (len > capacity || offset > capacity - len)
+		return -EINVAL;
+
+	return 0;
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
index 7a01adc9e13f..bc0f105148f9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -72,6 +72,18 @@ struct bpf_reg_state {
=20
 		u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
=20
+		/* for dynptr stack slots */
+		struct {
+			enum bpf_dynptr_type dynptr_type;
+			/* A dynptr is 16 bytes so it takes up 2 stack slots.
+			 * We need to track which slot is the first slot
+			 * to protect against cases where the user may try to
+			 * pass in an address starting at the second slot of the
+			 * dynptr.
+			 */
+			bool dynptr_first_slot;
+		};
+
 		/* Max size from any of the above. */
 		struct {
 			unsigned long raw1;
@@ -174,9 +186,15 @@ enum bpf_stack_slot_type {
 	STACK_SPILL,      /* register spilled into stack */
 	STACK_MISC,	  /* BPF program wrote some data into this slot */
 	STACK_ZERO,	  /* BPF program wrote constant zero */
+	/* A dynptr is stored in this stack slot. The type of dynptr
+	 * is stored in bpf_stack_state->spilled_ptr.type
+	 */
+	STACK_DYNPTR,
 };
=20
 #define BPF_REG_SIZE 8	/* size of eBPF register in bytes */
+#define BPF_DYNPTR_SIZE 16 /* size of a struct bpf_dynptr in bytes */
+#define BPF_DYNPTR_NR_SLOTS 2
=20
 struct bpf_stack_state {
 	struct bpf_reg_state spilled_ptr;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d14b10b85e51..6a57d8a1b882 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5143,6 +5143,38 @@ union bpf_attr {
  *		The **hash_algo** is returned on success,
  *		**-EOPNOTSUP** if the hash calculation failed or **-EINVAL** if
  *		invalid arguments are passed.
+ *
+ * long bpf_dynptr_from_mem(void *data, u32 size, struct bpf_dynptr *ptr=
)
+ *	Description
+ *		Get a dynptr to local memory *data*.
+ *
+ *		For a dynptr to a dynamic memory allocation, please use bpf_malloc
+ *		instead.
+ *
+ *		The maximum *size* supported is DYNPTR_MAX_SIZE.
+ *	Return
+ *		0 on success or -EINVAL if the size is 0 or exceeds DYNPTR_MAX_SIZE.
+ *
+ * long bpf_malloc(u32 size, struct bpf_dynptr *ptr)
+ *	Description
+ *		Dynamically allocate memory of *size* bytes.
+ *
+ *		Every call to bpf_malloc must have a corresponding
+ *		bpf_free, regardless of whether the bpf_malloc
+ *		succeeded.
+ *
+ *		The maximum *size* supported is DYNPTR_MAX_SIZE.
+ *	Return
+ *		0 on success, -ENOMEM if there is not enough memory for the
+ *		allocation, -EINVAL if the size is 0 or exceeds DYNPTR_MAX_SIZE.
+ *
+ * void bpf_free(struct bpf_dynptr *ptr)
+ *	Description
+ *		Free memory allocated by bpf_malloc.
+ *
+ *		After this operation, *ptr* will be an invalidated dynptr.
+ *	Return
+ *		Void.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5339,6 +5371,9 @@ union bpf_attr {
 	FN(copy_from_user_task),	\
 	FN(skb_set_tstamp),		\
 	FN(ima_file_hash),		\
+	FN(dynptr_from_mem),		\
+	FN(malloc),			\
+	FN(free),			\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
@@ -6486,6 +6521,11 @@ struct bpf_timer {
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
index cc6d480c5c23..ed5a7d9d0a18 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1374,6 +1374,88 @@ void bpf_timer_cancel_and_free(void *val)
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
+BPF_CALL_3(bpf_dynptr_from_mem, void *, data, u32, size, struct bpf_dynp=
tr_kern *, ptr)
+{
+	int err;
+
+	err =3D bpf_dynptr_check_size(size);
+	if (err) {
+		bpf_dynptr_set_null(ptr);
+		return err;
+	}
+
+	bpf_dynptr_init(ptr, data, BPF_DYNPTR_TYPE_LOCAL, 0, size);
+
+	return 0;
+}
+
+const struct bpf_func_proto bpf_dynptr_from_mem_proto =3D {
+	.func		=3D bpf_dynptr_from_mem,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_MEM,
+	.arg2_type	=3D ARG_CONST_SIZE_OR_ZERO,
+	.arg3_type	=3D ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT,
+};
+
+BPF_CALL_2(bpf_malloc, u32, size, struct bpf_dynptr_kern *, ptr)
+{
+	void *data;
+	int err;
+
+	err =3D bpf_dynptr_check_size(size);
+	if (err) {
+		bpf_dynptr_set_null(ptr);
+		return err;
+	}
+
+	data =3D kmalloc(size, GFP_ATOMIC);
+	if (!data) {
+		bpf_dynptr_set_null(ptr);
+		return -ENOMEM;
+	}
+
+	bpf_dynptr_init(ptr, data, BPF_DYNPTR_TYPE_MALLOC, 0, size);
+
+	return 0;
+}
+
+const struct bpf_func_proto bpf_malloc_proto =3D {
+	.func		=3D bpf_malloc,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_ANYTHING,
+	.arg2_type	=3D ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_MALLOC | MEM_UNINIT,
+};
+
+BPF_CALL_1(bpf_free, struct bpf_dynptr_kern *, dynptr)
+{
+	kfree(dynptr->data);
+	bpf_dynptr_set_null(dynptr);
+	return 0;
+}
+
+const struct bpf_func_proto bpf_free_proto =3D {
+	.func		=3D bpf_free,
+	.gpl_only	=3D false,
+	.ret_type	=3D RET_VOID,
+	.arg1_type	=3D ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_MALLOC | MEM_RELEASE,
+};
+
 const struct bpf_func_proto bpf_get_current_task_proto __weak;
 const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
 const struct bpf_func_proto bpf_probe_read_user_proto __weak;
@@ -1426,6 +1508,12 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_loop_proto;
 	case BPF_FUNC_strncmp:
 		return &bpf_strncmp_proto;
+	case BPF_FUNC_dynptr_from_mem:
+		return &bpf_dynptr_from_mem_proto;
+	case BPF_FUNC_malloc:
+		return &bpf_malloc_proto;
+	case BPF_FUNC_free:
+		return &bpf_free_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 80e53303713e..cb3bcb54d4b4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -479,6 +479,11 @@ static bool type_is_release_mem(u32 type)
 	return type & MEM_RELEASE;
 }
=20
+static bool type_is_uninit_mem(u32 type)
+{
+	return type & MEM_UNINIT;
+}
+
 static bool may_be_acquire_function(enum bpf_func_id func_id)
 {
 	return func_id =3D=3D BPF_FUNC_sk_lookup_tcp ||
@@ -583,6 +588,7 @@ static char slot_type_char[] =3D {
 	[STACK_SPILL]	=3D 'r',
 	[STACK_MISC]	=3D 'm',
 	[STACK_ZERO]	=3D '0',
+	[STACK_DYNPTR]	=3D 'd',
 };
=20
 static void print_liveness(struct bpf_verifier_env *env,
@@ -598,6 +604,18 @@ static void print_liveness(struct bpf_verifier_env *=
env,
 		verbose(env, "D");
 }
=20
+static inline int get_spi(s32 off)
+{
+	return (-off - 1) / BPF_REG_SIZE;
+}
+
+static bool check_spi_bounds(struct bpf_func_state *state, int spi, u32 =
nr_slots)
+{
+	int allocated_slots =3D state->allocated_stack / BPF_REG_SIZE;
+
+	return allocated_slots > spi && nr_slots - 1 <=3D spi;
+}
+
 static struct bpf_func_state *func(struct bpf_verifier_env *env,
 				   const struct bpf_reg_state *reg)
 {
@@ -649,6 +667,133 @@ static void mark_verifier_state_scratched(struct bp=
f_verifier_env *env)
 	env->scratched_stack_slots =3D ~0ULL;
 }
=20
+static int arg_to_dynptr_type(enum bpf_arg_type arg_type, enum bpf_dynpt=
r_type *dynptr_type)
+{
+	int type =3D arg_type & (DYNPTR_TYPE_LOCAL | DYNPTR_TYPE_MALLOC);
+
+	switch (type) {
+	case DYNPTR_TYPE_LOCAL:
+		*dynptr_type =3D BPF_DYNPTR_TYPE_LOCAL;
+		break;
+	case DYNPTR_TYPE_MALLOC:
+		*dynptr_type =3D BPF_DYNPTR_TYPE_MALLOC;
+		break;
+	default:
+		/* Can't have more than one type set and can't have no
+		 * type set
+		 */
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static bool dynptr_type_refcounted(struct bpf_func_state *state, int spi=
)
+{
+	enum bpf_dynptr_type type =3D state->stack[spi].spilled_ptr.dynptr_type=
;
+
+	return type =3D=3D BPF_DYNPTR_TYPE_MALLOC;
+}
+
+static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg,
+				   enum bpf_arg_type arg_type)
+{
+	struct bpf_func_state *state =3D cur_func(env);
+	enum bpf_dynptr_type type;
+	int spi, i, err;
+
+	spi =3D get_spi(reg->off);
+
+	if (!check_spi_bounds(state, spi, BPF_DYNPTR_NR_SLOTS))
+		return -EINVAL;
+
+	err =3D arg_to_dynptr_type(arg_type, &type);
+	if (unlikely(err))
+		return err;
+
+	for (i =3D 0; i < BPF_REG_SIZE; i++) {
+		state->stack[spi].slot_type[i] =3D STACK_DYNPTR;
+		state->stack[spi - 1].slot_type[i] =3D STACK_DYNPTR;
+	}
+
+	state->stack[spi].spilled_ptr.dynptr_type =3D type;
+	state->stack[spi - 1].spilled_ptr.dynptr_type =3D type;
+
+	state->stack[spi].spilled_ptr.dynptr_first_slot =3D true;
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
+	if (!check_spi_bounds(state, spi, BPF_DYNPTR_NR_SLOTS))
+		return -EINVAL;
+
+	for (i =3D 0; i < BPF_REG_SIZE; i++) {
+		state->stack[spi].slot_type[i] =3D STACK_INVALID;
+		state->stack[spi - 1].slot_type[i] =3D STACK_INVALID;
+	}
+
+	state->stack[spi].spilled_ptr.dynptr_type =3D 0;
+	state->stack[spi].spilled_ptr.dynptr_first_slot =3D 0;
+	state->stack[spi - 1].spilled_ptr.dynptr_type =3D 0;
+
+	return 0;
+}
+
+/* Check if the dynptr argument is a proper initialized dynptr */
+static bool check_dynptr_init(struct bpf_verifier_env *env, struct bpf_r=
eg_state *reg,
+			      enum bpf_arg_type arg_type)
+{
+	struct bpf_func_state *state =3D func(env, reg);
+	enum bpf_dynptr_type expected_type;
+	int spi, err;
+
+	/* Can't pass in a dynptr at a weird offset */
+	if (reg->off % BPF_REG_SIZE)
+		return false;
+
+	spi =3D get_spi(reg->off);
+
+	if (!check_spi_bounds(state, spi, BPF_DYNPTR_NR_SLOTS))
+		return false;
+
+	if (!state->stack[spi].spilled_ptr.dynptr_first_slot)
+		return false;
+
+	if (state->stack[spi].slot_type[0] !=3D STACK_DYNPTR)
+		return false;
+
+	/* ARG_PTR_TO_DYNPTR takes any type of dynptr */
+	if (arg_type =3D=3D ARG_PTR_TO_DYNPTR)
+		return true;
+
+	err =3D arg_to_dynptr_type(arg_type, &expected_type);
+	if (unlikely(err))
+		return err;
+
+	return state->stack[spi].spilled_ptr.dynptr_type =3D=3D expected_type;
+}
+
+static bool stack_access_into_dynptr(struct bpf_func_state *state, int s=
pi, int size)
+{
+	int nr_slots, i;
+
+	nr_slots =3D min(roundup(size, BPF_REG_SIZE) / BPF_REG_SIZE, spi + 1);
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
@@ -2885,6 +3030,12 @@ static int check_stack_write_fixed_off(struct bpf_=
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
@@ -3006,6 +3157,12 @@ static int check_stack_write_var_off(struct bpf_ve=
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
@@ -5153,6 +5310,16 @@ static bool arg_type_is_int_ptr(enum bpf_arg_type =
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
+	return arg_type_is_dynptr(type) && type & MEM_UNINIT;
+}
+
 static int int_ptr_type_to_size(enum bpf_arg_type type)
 {
 	if (type =3D=3D ARG_PTR_TO_INT)
@@ -5290,6 +5457,7 @@ static const struct bpf_reg_types *compatible_reg_t=
ypes[__BPF_ARG_TYPE_MAX] =3D {
 	[ARG_PTR_TO_STACK]		=3D &stack_ptr_types,
 	[ARG_PTR_TO_CONST_STR]		=3D &const_str_ptr_types,
 	[ARG_PTR_TO_TIMER]		=3D &timer_types,
+	[ARG_PTR_TO_DYNPTR]		=3D &stack_ptr_types,
 };
=20
 static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
@@ -5408,6 +5576,15 @@ int check_func_arg_reg_off(struct bpf_verifier_env=
 *env,
 	return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
 }
=20
+/*
+ * Determines whether the id used for reference tracking is held in a st=
ack slot
+ * or in a register
+ */
+static bool id_in_stack_slot(enum bpf_arg_type arg_type)
+{
+	return arg_type_is_dynptr(arg_type);
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn)
@@ -5458,10 +5635,19 @@ static int check_func_arg(struct bpf_verifier_env=
 *env, u32 arg,
 		return err;
=20
 	arg_release =3D type_is_release_mem(arg_type);
-	if (arg_release && !reg->ref_obj_id) {
-		verbose(env, "R%d arg #%d is an unacquired reference and hence cannot =
be released\n",
-			regno, arg + 1);
-		return -EINVAL;
+	if (arg_release) {
+		if (id_in_stack_slot(arg_type)) {
+			struct bpf_func_state *state =3D func(env, reg);
+			int spi =3D get_spi(reg->off);
+
+			if (!state->stack[spi].spilled_ptr.id)
+				goto unacquired_ref_err;
+		} else if (!reg->ref_obj_id)  {
+unacquired_ref_err:
+			verbose(env, "R%d arg #%d is an unacquired reference and hence cannot=
 be released\n",
+				regno, arg + 1);
+			return -EINVAL;
+		}
 	}
=20
 	err =3D check_func_arg_reg_off(env, reg, regno, arg_type, arg_release);
@@ -5572,6 +5758,40 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
 		bool zero_size_allowed =3D (arg_type =3D=3D ARG_CONST_SIZE_OR_ZERO);
=20
 		err =3D check_mem_size_reg(env, reg, regno, zero_size_allowed, meta);
+	} else if (arg_type_is_dynptr(arg_type)) {
+		bool initialized =3D check_dynptr_init(env, reg, arg_type);
+
+		if (type_is_uninit_mem(arg_type)) {
+			if (initialized) {
+				verbose(env, "Arg #%d dynptr cannot be an initialized dynptr\n",
+					arg + 1);
+				return -EINVAL;
+			}
+			meta->raw_mode =3D true;
+			err =3D check_helper_mem_access(env, regno, BPF_DYNPTR_SIZE, false, m=
eta);
+			/* For now, we do not allow dynptrs to point to existing
+			 * refcounted memory
+			 */
+			if (reg_type_may_be_refcounted_or_null(regs[BPF_REG_1].type)) {
+				verbose(env, "Arg #%d dynptr memory cannot be potentially refcounted=
\n",
+					arg + 1);
+				return -EINVAL;
+			}
+		} else {
+			if (!initialized) {
+				char *err_extra =3D "";
+
+				if (arg_type & DYNPTR_TYPE_LOCAL)
+					err_extra =3D "local ";
+				else if (arg_type & DYNPTR_TYPE_MALLOC)
+					err_extra =3D "malloc ";
+				verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
+					err_extra, arg + 1);
+				return -EINVAL;
+			}
+			if (type_is_release_mem(arg_type))
+				err =3D unmark_stack_slots_dynptr(env, reg);
+		}
 	} else if (arg_type_is_alloc_size(arg_type)) {
 		if (!tnum_is_const(reg->var_off)) {
 			verbose(env, "R%d is not a known constant'\n",
@@ -6552,6 +6772,25 @@ static int check_reference_leak(struct bpf_verifie=
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
+	int i;
+
+	for (i =3D 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
+		if (state->stack[i].slot_type[0] =3D=3D STACK_DYNPTR &&
+		    dynptr_type_refcounted(state, i)) {
+			verbose(env, "spi=3D%d is an unreleased dynptr\n", i);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *regs)
 {
@@ -6693,6 +6932,14 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 			return err;
 	}
=20
+	regs =3D cur_regs(env);
+
+	for (i =3D 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
+		if (arg_type_is_dynptr_uninit(fn->arg_type[i]))
+			err =3D mark_stack_slots_dynptr(env, &regs[BPF_REG_1 + i],
+						      fn->arg_type[i]);
+	}
+
 	if (meta.ref_obj_id) {
 		err =3D release_reference(env, meta.ref_obj_id);
 		if (err) {
@@ -6702,8 +6949,6 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 		}
 	}
=20
-	regs =3D cur_regs(env);
-
 	switch (func_id) {
 	case BPF_FUNC_tail_call:
 		err =3D check_reference_leak(env);
@@ -6711,6 +6956,11 @@ static int check_helper_call(struct bpf_verifier_e=
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
@@ -11703,6 +11953,10 @@ static int do_check(struct bpf_verifier_env *env=
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
index d14b10b85e51..6a57d8a1b882 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5143,6 +5143,38 @@ union bpf_attr {
  *		The **hash_algo** is returned on success,
  *		**-EOPNOTSUP** if the hash calculation failed or **-EINVAL** if
  *		invalid arguments are passed.
+ *
+ * long bpf_dynptr_from_mem(void *data, u32 size, struct bpf_dynptr *ptr=
)
+ *	Description
+ *		Get a dynptr to local memory *data*.
+ *
+ *		For a dynptr to a dynamic memory allocation, please use bpf_malloc
+ *		instead.
+ *
+ *		The maximum *size* supported is DYNPTR_MAX_SIZE.
+ *	Return
+ *		0 on success or -EINVAL if the size is 0 or exceeds DYNPTR_MAX_SIZE.
+ *
+ * long bpf_malloc(u32 size, struct bpf_dynptr *ptr)
+ *	Description
+ *		Dynamically allocate memory of *size* bytes.
+ *
+ *		Every call to bpf_malloc must have a corresponding
+ *		bpf_free, regardless of whether the bpf_malloc
+ *		succeeded.
+ *
+ *		The maximum *size* supported is DYNPTR_MAX_SIZE.
+ *	Return
+ *		0 on success, -ENOMEM if there is not enough memory for the
+ *		allocation, -EINVAL if the size is 0 or exceeds DYNPTR_MAX_SIZE.
+ *
+ * void bpf_free(struct bpf_dynptr *ptr)
+ *	Description
+ *		Free memory allocated by bpf_malloc.
+ *
+ *		After this operation, *ptr* will be an invalidated dynptr.
+ *	Return
+ *		Void.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5339,6 +5371,9 @@ union bpf_attr {
 	FN(copy_from_user_task),	\
 	FN(skb_set_tstamp),		\
 	FN(ima_file_hash),		\
+	FN(dynptr_from_mem),		\
+	FN(malloc),			\
+	FN(free),			\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
@@ -6486,6 +6521,11 @@ struct bpf_timer {
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

