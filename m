Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C007445B70
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 22:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhKDVED (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 17:04:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49416 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231936AbhKDVEB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Nov 2021 17:04:01 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A4JF5vE010001
        for <bpf@vger.kernel.org>; Thu, 4 Nov 2021 14:01:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Td/9nc1chySVMiT7KCu7+yV+mGV+LprD7FbRJZ1V1NA=;
 b=p1zcZlIA5Hh3TFxH2GVzELPmsXfsNFydE1dxctrxwlMa/RyXrZcIyw5S5YB01BNs6jPW
 PjSgT/oACq6y4eAl2v/L13unc4wro82FLjntMoETg0FWjZ7y0NtpjLk6VTN3kojzk0hG
 FW38JboQ3S8Kj7Deon+AWzTHJouElCt7sqg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c4ngsrrbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 04 Nov 2021 14:01:22 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 4 Nov 2021 14:01:21 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 91DA91DE98A0F; Thu,  4 Nov 2021 14:01:11 -0700 (PDT)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kernel-team@fb.com>, <kpsingh@kernel.org>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v3 bpf-next 1/2] bpf: introduce helper bpf_find_vma
Date:   Thu, 4 Nov 2021 14:01:04 -0700
Message-ID: <20211104210105.2599475-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211104210105.2599475-1-songliubraving@fb.com>
References: <20211104210105.2599475-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 25EViBXZJFNoI0rCQaPh-96Vcu50IFB8
X-Proofpoint-ORIG-GUID: 25EViBXZJFNoI0rCQaPh-96Vcu50IFB8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-04_07,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111040081
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In some profiler use cases, it is necessary to map an address to the
backing file, e.g., a shared library. bpf_find_vma helper provides a
flexible way to achieve this. bpf_find_vma maps an address of a task to
the vma (vm_area_struct) for this address, and feed the vma to an callbac=
k
BPF function. The callback function is necessary here, as we need to
ensure mmap_sem is unlocked.

It is necessary to lock mmap_sem for find_vma. To lock and unlock mmap_se=
m
safely when irqs are disable, we use the same mechanism as stackmap with
build_id. Specifically, when irqs are disabled, the unlocked is postponed
in an irq_work. Refactor stackmap.c so that the irq_work is shared among
bpf_find_vma and stackmap helpers.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       | 20 ++++++++++
 kernel/bpf/btf.c               |  5 ++-
 kernel/bpf/mmap_unlock_work.h  | 65 ++++++++++++++++++++++++++++++++
 kernel/bpf/stackmap.c          | 68 +++++++---------------------------
 kernel/bpf/task_iter.c         | 55 ++++++++++++++++++++++++---
 kernel/bpf/verifier.c          | 34 +++++++++++++++++
 kernel/trace/bpf_trace.c       |  2 +
 tools/include/uapi/linux/bpf.h | 20 ++++++++++
 9 files changed, 209 insertions(+), 61 deletions(-)
 create mode 100644 kernel/bpf/mmap_unlock_work.h

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2be6dfd68df99..df3410bff4b06 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2157,6 +2157,7 @@ extern const struct bpf_func_proto bpf_btf_find_by_=
name_kind_proto;
 extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
 extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
 extern const struct bpf_func_proto bpf_kallsyms_lookup_name_proto;
+extern const struct bpf_func_proto bpf_find_vma_proto;
=20
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ba5af15e25f5c..509eee5f0393d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4938,6 +4938,25 @@ union bpf_attr {
  *		**-ENOENT** if symbol is not found.
  *
  *		**-EPERM** if caller does not have permission to obtain kernel addre=
ss.
+ *
+ * long bpf_find_vma(struct task_struct *task, u64 addr, void *callback_=
fn, void *callback_ctx, u64 flags)
+ *	Description
+ *		Find vma of *task* that contains *addr*, call *callback_fn*
+ *		function with *task*, *vma*, and *callback_ctx*.
+ *		The *callback_fn* should be a static function and
+ *		the *callback_ctx* should be a pointer to the stack.
+ *		The *flags* is used to control certain aspects of the helper.
+ *		Currently, the *flags* must be 0.
+ *
+ *		The expected callback signature is
+ *
+ *		long (\*callback_fn)(struct task_struct \*task, struct vm_area_struc=
t \*vma, void \*callback_ctx);
+ *
+ *	Return
+ *		0 on success.
+ *		**-ENOENT** if *task->mm* is NULL, or no vma contains *addr*.
+ *		**-EBUSY** if failed to try lock mmap_lock.
+ *		**-EINVAL** for invalid **flags**.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5120,6 +5139,7 @@ union bpf_attr {
 	FN(trace_vprintk),		\
 	FN(skc_to_unix_sock),		\
 	FN(kallsyms_lookup_name),	\
+	FN(find_vma),			\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index dbc3ad07e21b6..cdb0fba656006 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6342,7 +6342,10 @@ const struct bpf_func_proto bpf_btf_find_by_name_k=
ind_proto =3D {
 	.arg4_type	=3D ARG_ANYTHING,
 };
=20
-BTF_ID_LIST_GLOBAL_SINGLE(btf_task_struct_ids, struct, task_struct)
+BTF_ID_LIST_GLOBAL(btf_task_struct_ids)
+BTF_ID(struct, task_struct)
+BTF_ID(struct, file)
+BTF_ID(struct, vm_area_struct)
=20
 /* BTF ID set registration API for modules */
=20
diff --git a/kernel/bpf/mmap_unlock_work.h b/kernel/bpf/mmap_unlock_work.=
h
new file mode 100644
index 0000000000000..5d18d7d85bef9
--- /dev/null
+++ b/kernel/bpf/mmap_unlock_work.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2021 Facebook
+ */
+
+#ifndef __MMAP_UNLOCK_WORK_H__
+#define __MMAP_UNLOCK_WORK_H__
+#include <linux/irq_work.h>
+
+/* irq_work to run mmap_read_unlock() in irq_work */
+struct mmap_unlock_irq_work {
+	struct irq_work irq_work;
+	struct mm_struct *mm;
+};
+
+DECLARE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
+
+/*
+ * We cannot do mmap_read_unlock() when the irq is disabled, because of
+ * risk to deadlock with rq_lock. To look up vma when the irqs are
+ * disabled, we need to run mmap_read_unlock() in irq_work. We use a
+ * percpu variable to do the irq_work. If the irq_work is already used
+ * by another lookup, we fall over.
+ */
+static inline bool bpf_mmap_unlock_get_irq_work(struct mmap_unlock_irq_w=
ork **work_ptr)
+{
+	struct mmap_unlock_irq_work *work =3D NULL;
+	bool irq_work_busy =3D false;
+
+	if (irqs_disabled()) {
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			work =3D this_cpu_ptr(&mmap_unlock_work);
+			if (irq_work_is_busy(&work->irq_work)) {
+				/* cannot queue more up_read, fallback */
+				irq_work_busy =3D true;
+			}
+		} else {
+			/*
+			 * PREEMPT_RT does not allow to trylock mmap sem in
+			 * interrupt disabled context. Force the fallback code.
+			 */
+			irq_work_busy =3D true;
+		}
+	}
+
+	*work_ptr =3D work;
+	return irq_work_busy;
+}
+
+static inline void bpf_mmap_unlock_mm(struct mmap_unlock_irq_work *work,=
 struct mm_struct *mm)
+{
+	if (!work) {
+		mmap_read_unlock(mm);
+	} else {
+		work->mm =3D mm;
+
+		/* The lock will be released once we're out of interrupt
+		 * context. Tell lockdep that we've released it now so
+		 * it doesn't complain that we forgot to release it.
+		 */
+		rwsem_release(&mm->mmap_lock.dep_map, _RET_IP_);
+		irq_work_queue(&work->irq_work);
+	}
+}
+
+#endif /* __MMAP_UNLOCK_WORK_H__ */
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 6e75bbee39f0b..528f22c67e6f8 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -7,10 +7,10 @@
 #include <linux/kernel.h>
 #include <linux/stacktrace.h>
 #include <linux/perf_event.h>
-#include <linux/irq_work.h>
 #include <linux/btf_ids.h>
 #include <linux/buildid.h>
 #include "percpu_freelist.h"
+#include "mmap_unlock_work.h"
=20
 #define STACK_CREATE_FLAG_MASK					\
 	(BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY |	\
@@ -31,25 +31,19 @@ struct bpf_stack_map {
 	struct stack_map_bucket *buckets[];
 };
=20
-/* irq_work to run up_read() for build_id lookup in nmi context */
-struct stack_map_irq_work {
-	struct irq_work irq_work;
-	struct mm_struct *mm;
-};
+DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
=20
-static void do_up_read(struct irq_work *entry)
+static void do_mmap_read_unlock(struct irq_work *entry)
 {
-	struct stack_map_irq_work *work;
+	struct mmap_unlock_irq_work *work;
=20
 	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT)))
 		return;
=20
-	work =3D container_of(entry, struct stack_map_irq_work, irq_work);
+	work =3D container_of(entry, struct mmap_unlock_irq_work, irq_work);
 	mmap_read_unlock_non_owner(work->mm);
 }
=20
-static DEFINE_PER_CPU(struct stack_map_irq_work, up_read_work);
-
 static inline bool stack_map_use_build_id(struct bpf_map *map)
 {
 	return (map->map_flags & BPF_F_STACK_BUILD_ID);
@@ -149,35 +143,13 @@ static void stack_map_get_build_id_offset(struct bp=
f_stack_build_id *id_offs,
 					  u64 *ips, u32 trace_nr, bool user)
 {
 	int i;
+	struct mmap_unlock_irq_work *work =3D NULL;
+	bool irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&work);
 	struct vm_area_struct *vma;
-	bool irq_work_busy =3D false;
-	struct stack_map_irq_work *work =3D NULL;
-
-	if (irqs_disabled()) {
-		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
-			work =3D this_cpu_ptr(&up_read_work);
-			if (irq_work_is_busy(&work->irq_work)) {
-				/* cannot queue more up_read, fallback */
-				irq_work_busy =3D true;
-			}
-		} else {
-			/*
-			 * PREEMPT_RT does not allow to trylock mmap sem in
-			 * interrupt disabled context. Force the fallback code.
-			 */
-			irq_work_busy =3D true;
-		}
-	}
=20
-	/*
-	 * We cannot do up_read() when the irq is disabled, because of
-	 * risk to deadlock with rq_lock. To do build_id lookup when the
-	 * irqs are disabled, we need to run up_read() in irq_work. We use
-	 * a percpu variable to do the irq_work. If the irq_work is
-	 * already used by another lookup, we fall back to report ips.
-	 *
-	 * Same fallback is used for kernel stack (!user) on a stackmap
-	 * with build_id.
+	/* If the irq_work is in use, fall back to report ips. Same
+	 * fallback is used for kernel stack (!user) on a stackmap with
+	 * build_id.
 	 */
 	if (!user || !current || !current->mm || irq_work_busy ||
 	    !mmap_read_trylock(current->mm)) {
@@ -203,19 +175,7 @@ static void stack_map_get_build_id_offset(struct bpf=
_stack_build_id *id_offs,
 			- vma->vm_start;
 		id_offs[i].status =3D BPF_STACK_BUILD_ID_VALID;
 	}
-
-	if (!work) {
-		mmap_read_unlock(current->mm);
-	} else {
-		work->mm =3D current->mm;
-
-		/* The lock will be released once we're out of interrupt
-		 * context. Tell lockdep that we've released it now so
-		 * it doesn't complain that we forgot to release it.
-		 */
-		rwsem_release(&current->mm->mmap_lock.dep_map, _RET_IP_);
-		irq_work_queue(&work->irq_work);
-	}
+	bpf_mmap_unlock_mm(work, current->mm);
 }
=20
 static struct perf_callchain_entry *
@@ -723,11 +683,11 @@ const struct bpf_map_ops stack_trace_map_ops =3D {
 static int __init stack_map_init(void)
 {
 	int cpu;
-	struct stack_map_irq_work *work;
+	struct mmap_unlock_irq_work *work;
=20
 	for_each_possible_cpu(cpu) {
-		work =3D per_cpu_ptr(&up_read_work, cpu);
-		init_irq_work(&work->irq_work, do_up_read);
+		work =3D per_cpu_ptr(&mmap_unlock_work, cpu);
+		init_irq_work(&work->irq_work, do_mmap_read_unlock);
 	}
 	return 0;
 }
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index b48750bfba5aa..fec91586dfce8 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -8,6 +8,7 @@
 #include <linux/fdtable.h>
 #include <linux/filter.h>
 #include <linux/btf_ids.h>
+#include "mmap_unlock_work.h"
=20
 struct bpf_iter_seq_task_common {
 	struct pid_namespace *ns;
@@ -524,10 +525,6 @@ static const struct seq_operations task_vma_seq_ops =
=3D {
 	.show	=3D task_vma_seq_show,
 };
=20
-BTF_ID_LIST(btf_task_file_ids)
-BTF_ID(struct, file)
-BTF_ID(struct, vm_area_struct)
-
 static const struct bpf_iter_seq_info task_seq_info =3D {
 	.seq_ops		=3D &task_seq_ops,
 	.init_seq_private	=3D init_seq_pidns,
@@ -586,6 +583,52 @@ static struct bpf_iter_reg task_vma_reg_info =3D {
 	.seq_info		=3D &task_vma_seq_info,
 };
=20
+BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
+	   bpf_callback_t, callback_fn, void *, callback_ctx, u64, flags)
+{
+	struct mmap_unlock_irq_work *work =3D NULL;
+	struct vm_area_struct *vma;
+	bool irq_work_busy =3D false;
+	struct mm_struct *mm;
+	int ret =3D -ENOENT;
+
+	if (flags)
+		return -EINVAL;
+
+	if (!task)
+		return -ENOENT;
+
+	mm =3D task->mm;
+	if (!mm)
+		return -ENOENT;
+
+	irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&work);
+
+	if (irq_work_busy || !mmap_read_trylock(mm))
+		return -EBUSY;
+
+	vma =3D find_vma(mm, start);
+
+	if (vma && vma->vm_start <=3D start && vma->vm_end > start) {
+		callback_fn((u64)(long)task, (u64)(long)vma,
+			    (u64)(long)callback_ctx, 0, 0);
+		ret =3D 0;
+	}
+	bpf_mmap_unlock_mm(work, mm);
+	return ret;
+}
+
+const struct bpf_func_proto bpf_find_vma_proto =3D {
+	.func		=3D bpf_find_vma,
+	.ret_type	=3D RET_INTEGER,
+	.arg1_type	=3D ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	=3D &btf_task_struct_ids[0],
+	.arg2_type	=3D ARG_ANYTHING,
+	.arg3_type	=3D ARG_PTR_TO_FUNC,
+	.arg4_type	=3D ARG_PTR_TO_STACK_OR_NULL,
+	.arg5_type	=3D ARG_ANYTHING,
+};
+
 static int __init task_iter_init(void)
 {
 	int ret;
@@ -596,13 +639,13 @@ static int __init task_iter_init(void)
 		return ret;
=20
 	task_file_reg_info.ctx_arg_info[0].btf_id =3D btf_task_struct_ids[0];
-	task_file_reg_info.ctx_arg_info[1].btf_id =3D btf_task_file_ids[0];
+	task_file_reg_info.ctx_arg_info[1].btf_id =3D btf_task_struct_ids[1];
 	ret =3D  bpf_iter_reg_target(&task_file_reg_info);
 	if (ret)
 		return ret;
=20
 	task_vma_reg_info.ctx_arg_info[0].btf_id =3D btf_task_struct_ids[0];
-	task_vma_reg_info.ctx_arg_info[1].btf_id =3D btf_task_file_ids[1];
+	task_vma_reg_info.ctx_arg_info[1].btf_id =3D btf_task_struct_ids[2];
 	return bpf_iter_reg_target(&task_vma_reg_info);
 }
 late_initcall(task_iter_init);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f0dca726ebfde..1aafb43f61d1c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6132,6 +6132,33 @@ static int set_timer_callback_state(struct bpf_ver=
ifier_env *env,
 	return 0;
 }
=20
+static int set_find_vma_callback_state(struct bpf_verifier_env *env,
+				       struct bpf_func_state *caller,
+				       struct bpf_func_state *callee,
+				       int insn_idx)
+{
+	/* bpf_find_vma(struct task_struct *task, u64 addr,
+	 *               void *callback_fn, void *callback_ctx, u64 flags)
+	 * (callback_fn)(struct task_struct *task,
+	 *               struct vm_area_struct *vma, void *callback_ctx);
+	 */
+	callee->regs[BPF_REG_1] =3D caller->regs[BPF_REG_1];
+
+	callee->regs[BPF_REG_2].type =3D PTR_TO_BTF_ID;
+	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
+	callee->regs[BPF_REG_2].btf =3D  btf_vmlinux;
+	callee->regs[BPF_REG_2].btf_id =3D btf_task_struct_ids[2];
+
+	/* pointer to stack or null */
+	callee->regs[BPF_REG_3] =3D caller->regs[BPF_REG_4];
+
+	/* unused */
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+	callee->in_callback_fn =3D true;
+	return 0;
+}
+
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx=
)
 {
 	struct bpf_verifier_state *state =3D env->cur_state;
@@ -6489,6 +6516,13 @@ static int check_helper_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn
 			return -EINVAL;
 	}
=20
+	if (func_id =3D=3D BPF_FUNC_find_vma) {
+		err =3D __check_func_call(env, insn, insn_idx_p, meta.subprogno,
+					set_find_vma_callback_state);
+		if (err < 0)
+			return -EINVAL;
+	}
+
 	if (func_id =3D=3D BPF_FUNC_snprintf) {
 		err =3D check_bpf_snprintf_call(env, regs);
 		if (err < 0)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 7396488793ff7..390176a3031ab 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1208,6 +1208,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, co=
nst struct bpf_prog *prog)
 		return &bpf_get_func_ip_proto_tracing;
 	case BPF_FUNC_get_branch_snapshot:
 		return &bpf_get_branch_snapshot_proto;
+	case BPF_FUNC_find_vma:
+		return &bpf_find_vma_proto;
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
 	default:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index ba5af15e25f5c..509eee5f0393d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4938,6 +4938,25 @@ union bpf_attr {
  *		**-ENOENT** if symbol is not found.
  *
  *		**-EPERM** if caller does not have permission to obtain kernel addre=
ss.
+ *
+ * long bpf_find_vma(struct task_struct *task, u64 addr, void *callback_=
fn, void *callback_ctx, u64 flags)
+ *	Description
+ *		Find vma of *task* that contains *addr*, call *callback_fn*
+ *		function with *task*, *vma*, and *callback_ctx*.
+ *		The *callback_fn* should be a static function and
+ *		the *callback_ctx* should be a pointer to the stack.
+ *		The *flags* is used to control certain aspects of the helper.
+ *		Currently, the *flags* must be 0.
+ *
+ *		The expected callback signature is
+ *
+ *		long (\*callback_fn)(struct task_struct \*task, struct vm_area_struc=
t \*vma, void \*callback_ctx);
+ *
+ *	Return
+ *		0 on success.
+ *		**-ENOENT** if *task->mm* is NULL, or no vma contains *addr*.
+ *		**-EBUSY** if failed to try lock mmap_lock.
+ *		**-EINVAL** for invalid **flags**.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5120,6 +5139,7 @@ union bpf_attr {
 	FN(trace_vprintk),		\
 	FN(skc_to_unix_sock),		\
 	FN(kallsyms_lookup_name),	\
+	FN(find_vma),			\
 	/* */
=20
 /* integer value in 'imm' field of BPF_CALL instruction selects which he=
lper
--=20
2.30.2

