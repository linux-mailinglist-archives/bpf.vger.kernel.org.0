Return-Path: <bpf+bounces-11832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CCC7C0400
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 21:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885771C20C86
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A95138DDF;
	Tue, 10 Oct 2023 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CpCbzR/O"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A502822EE5
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 19:00:11 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E000C6
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 12:00:07 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AIgGxq007923
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 12:00:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+P1PBnH3r+y0tE+bg3wHqpGo2GyILzZhhzKVAkbMLYg=;
 b=CpCbzR/OkKZ3/Voik3W1d3SdjcC+MDHC4lecBM8q5uyMHTmq3wUG67ftYA98nIBTu0XN
 1AWthB17tW000V7s7k6ZoxZY4PWnJ41ZWo0wNa8p18fk5ZCNzGEJVjQG6pkxGLE4R6cD
 pIGNnkQTe9Jca+nOJQLcEcgyObs+wBw0jyE= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tnc4a85ss-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 12:00:07 -0700
Received: from twshared15247.17.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 10 Oct 2023 11:59:51 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 60AD3258848E8; Tue, 10 Oct 2023 11:59:48 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>,
        Nathan Slingerland <slinger@meta.com>
Subject: [PATCH v6 bpf-next 3/4] bpf: Introduce task_vma open-coded iterator kfuncs
Date: Tue, 10 Oct 2023 11:59:43 -0700
Message-ID: <20231010185944.3888849-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010185944.3888849-1-davemarchevsky@fb.com>
References: <20231010185944.3888849-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: kacOxFFa0RBY5nDcKhi0ej6Pibj8QyeA
X-Proofpoint-GUID: kacOxFFa0RBY5nDcKhi0ej6Pibj8QyeA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_14,2023-10-10_01,2023-05-22_02
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds kfuncs bpf_iter_task_vma_{new,next,destroy} which allow
creation and manipulation of struct bpf_iter_task_vma in open-coded
iterator style. BPF programs can use these kfuncs directly or through
bpf_for_each macro for natural-looking iteration of all task vmas.

The implementation borrows heavily from bpf_find_vma helper's locking -
differing only in that it holds the mmap_read lock for all iterations
while the helper only executes its provided callback on a maximum of 1
vma. Aside from locking, struct vma_iterator and vma_next do all the
heavy lifting.

A pointer to an inner data struct, struct bpf_iter_task_vma_data, is the
only field in struct bpf_iter_task_vma. This is because the inner data
struct contains a struct vma_iterator (not ptr), whose size is likely to
change under us. If bpf_iter_task_vma_kern contained vma_iterator directl=
y
such a change would require change in opaque bpf_iter_task_vma struct's
size. So better to allocate vma_iterator using BPF allocator, and since
that alloc must already succeed, might as well allocate all iter fields,
thereby freezing struct bpf_iter_task_vma size.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Cc: Nathan Slingerland <slinger@meta.com>
---
 kernel/bpf/helpers.c   |  3 ++
 kernel/bpf/task_iter.c | 85 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d2840dd5b00d..62a53ebfedf9 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2552,6 +2552,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NU=
LL)
 BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW | KF_RCU)
+BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 7473068ed313..d6e29aca201a 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -7,7 +7,9 @@
 #include <linux/fs.h>
 #include <linux/fdtable.h>
 #include <linux/filter.h>
+#include <linux/bpf_mem_alloc.h>
 #include <linux/btf_ids.h>
+#include <linux/mm_types.h>
 #include "mmap_unlock_work.h"
=20
 static const char * const iter_task_type_names[] =3D {
@@ -803,6 +805,89 @@ const struct bpf_func_proto bpf_find_vma_proto =3D {
 	.arg5_type	=3D ARG_ANYTHING,
 };
=20
+struct bpf_iter_task_vma_kern_data {
+	struct task_struct *task;
+	struct mm_struct *mm;
+	struct mmap_unlock_irq_work *work;
+	struct vma_iterator vmi;
+};
+
+struct bpf_iter_task_vma {
+	/* opaque iterator state; having __u64 here allows to preserve correct
+	 * alignment requirements in vmlinux.h, generated from BTF
+	 */
+	__u64 __opaque[1];
+} __attribute__((aligned(8)));
+
+/* Non-opaque version of bpf_iter_task_vma */
+struct bpf_iter_task_vma_kern {
+	struct bpf_iter_task_vma_kern_data *data;
+} __attribute__((aligned(8)));
+
+__bpf_kfunc int bpf_iter_task_vma_new(struct bpf_iter_task_vma *it,
+				      struct task_struct *task, u64 addr)
+{
+	struct bpf_iter_task_vma_kern *kit =3D (void *)it;
+	bool irq_work_busy =3D false;
+	int err;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_task_vma_kern) !=3D sizeof(struct b=
pf_iter_task_vma));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_vma_kern) !=3D __alignof_=
_(struct bpf_iter_task_vma));
+
+	/* is_iter_reg_valid_uninit guarantees that kit hasn't been initialized
+	 * before, so non-NULL kit->data doesn't point to previously
+	 * bpf_mem_alloc'd bpf_iter_task_vma_kern_data
+	 */
+	kit->data =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_iter_task=
_vma_kern_data));
+	if (!kit->data)
+		return -ENOMEM;
+
+	kit->data->task =3D get_task_struct(task);
+	kit->data->mm =3D task->mm;
+	if (!kit->data->mm) {
+		err =3D -ENOENT;
+		goto err_cleanup_iter;
+	}
+
+	/* kit->data->work =3D=3D NULL is valid after bpf_mmap_unlock_get_irq_w=
ork */
+	irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&kit->data->work);
+	if (irq_work_busy || !mmap_read_trylock(kit->data->mm)) {
+		err =3D -EBUSY;
+		goto err_cleanup_iter;
+	}
+
+	vma_iter_init(&kit->data->vmi, kit->data->mm, addr);
+	return 0;
+
+err_cleanup_iter:
+	if (kit->data->task)
+		put_task_struct(kit->data->task);
+	bpf_mem_free(&bpf_global_ma, kit->data);
+	/* NULL kit->data signals failed bpf_iter_task_vma initialization */
+	kit->data =3D NULL;
+	return err;
+}
+
+__bpf_kfunc struct vm_area_struct *bpf_iter_task_vma_next(struct bpf_ite=
r_task_vma *it)
+{
+	struct bpf_iter_task_vma_kern *kit =3D (void *)it;
+
+	if (!kit->data) /* bpf_iter_task_vma_new failed */
+		return NULL;
+	return vma_next(&kit->data->vmi);
+}
+
+__bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
+{
+	struct bpf_iter_task_vma_kern *kit =3D (void *)it;
+
+	if (kit->data) {
+		bpf_mmap_unlock_mm(kit->data->work, kit->data->mm);
+		put_task_struct(kit->data->task);
+		bpf_mem_free(&bpf_global_ma, kit->data);
+	}
+}
+
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
=20
 static void do_mmap_read_unlock(struct irq_work *entry)
--=20
2.34.1


