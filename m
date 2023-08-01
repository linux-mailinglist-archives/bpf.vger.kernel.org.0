Return-Path: <bpf+bounces-6571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA23376B813
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 16:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D2728112B
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 14:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B964DC7E;
	Tue,  1 Aug 2023 14:54:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF9E4DC79
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 14:54:46 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A6D120
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 07:54:44 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3716KBwM001469
	for <bpf@vger.kernel.org>; Tue, 1 Aug 2023 07:54:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=MI2rDy25VO7cKQy7sMlhWqDYOVLTiSDeSlvaOt0tyHw=;
 b=Gw/AAg2PdQJqvhbQMZZPs2bLhpNoT92wmFS9CUplYDwpDsiMPFdJvQUR+b1kQUrXVDDm
 8Kx5Ni6NOvZ8NwqDihOCdnexKd9Pa6PjLlOWFRHYmtGhgSB8iA6RHP02eI5AijhwaX9R
 kSwgMTP9JcxS0a9pJrcuSt5UKQkuQwy30bs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3s5ryu0vnj-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 07:54:44 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 07:54:41 -0700
Received: from twshared6136.05.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 07:54:40 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 8FE5E22006B2D; Tue,  1 Aug 2023 07:54:16 -0700 (PDT)
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
Subject: [PATCH v1 bpf-next 1/2] [RFC] bpf: Introduce BPF_F_VMA_NEXT flag for bpf_find_vma helper
Date: Tue, 1 Aug 2023 07:54:13 -0700
Message-ID: <20230801145414.418145-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 2uaMfzrUpPNDIfbuOByicHUSZRJRbnp1
X-Proofpoint-ORIG-GUID: 2uaMfzrUpPNDIfbuOByicHUSZRJRbnp1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_11,2023-08-01_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

At Meta we have a profiling daemon which periodically collects
information on many hosts. This collection usually involves grabbing
stacks (user and kernel) using perf_event BPF progs and later symbolicati=
ng
them. For user stacks we try to use BPF_F_USER_BUILD_ID and rely on
remote symbolication, but BPF_F_USER_BUILD_ID doesn't always succeed. In
those cases we must fall back to digging around in /proc/PID/maps to map
virtual address to (binary, offset). The /proc/PID/maps digging does not
occur synchronously with stack collection, so the process might already
be gone, in which case it won't have /proc/PID/maps and we will fail to
symbolicate.

This 'exited process problem' doesn't occur very often as
most of the prod services we care to profile are long-lived daemons,
there are enough usecases to warrant a workaround: a BPF program which
can be optionally loaded at data collection time and essentially walks
/proc/PID/maps. Currently this is done by walking the vma list:

  struct vm_area_struct* mmap =3D BPF_CORE_READ(mm, mmap);
  mmap_next =3D BPF_CORE_READ(rmap, vm_next); /* in a loop */

Since commit 763ecb035029 ("mm: remove the vma linked list") there's no
longer a vma linked list to walk. Walking the vma maple tree is not as
simple as hopping struct vm_area_struct->vm_next. That commit replaces
vm_next hopping with calls to find_vma(mm, addr) helper function, which
returns the vma containing addr, or if no vma contains addr,
the closest vma with higher start addr.

The BPF helper bpf_find_vma is unsurprisingly a thin wrapper around
find_vma, with the major difference that no 'closest vma' is returned if
there is no VMA containing a particular address. This prevents BPF
programs from being able to use bpf_find_vma to iterate all vmas in a
task in a reasonable way.

This patch adds a BPF_F_VMA_NEXT flag to bpf_find_vma which restores
'closest vma' behavior when used. Because this is find_vma's default
behavior it's as straightforward as nerfing a 'vma contains addr' check
on find_vma retval.

Also, change bpf_find_vma's address parameter to 'addr' instead of
'start'. The former is used in documentation and more accurately
describes the param.

[
  RFC: This isn't an ideal solution for iteration of all vmas in a task
       in the long term for a few reasons:

     * In nmi context, second call to bpf_find_vma will fail because
       irq_work is busy, so can't iterate all vmas
     * Repeatedly taking and releasing mmap_read lock when a dedicated
       iterate_all_vmas(task) kfunc could just take it once and hold for
       all vmas

    My specific usecase doesn't do vma iteration in nmi context and I
    think the 'closest vma' behavior can be useful here despite locking
    inefficiencies.

    When Alexei and I discussed this offline, two alternatives to
    provide similar functionality while addressing above issues seemed
    reasonable:

      * open-coded iterator for task vma. Similar to existing
        task_vma bpf_iter, but no need to create a bpf_link and read
	bpf_iter fd from userspace.
      * New kfunc taking callback similar bpf_find_vma, but iterating
        over all vmas in one go

     I think this patch is useful on its own since it's a fairly minimal
     change and fixes my usecase. Sending for early feedback and to
     solicit further thought about whether this should be dropped in
     favor of one of the above options.
]

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Cc: Nathan Slingerland <slinger@meta.com>
---
 include/uapi/linux/bpf.h       | 14 ++++++++++++--
 kernel/bpf/task_iter.c         | 12 ++++++++----
 tools/include/uapi/linux/bpf.h | 14 ++++++++++++--
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 70da85200695..947187d76ebc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5169,8 +5169,13 @@ union bpf_attr {
  *		function with *task*, *vma*, and *callback_ctx*.
  *		The *callback_fn* should be a static function and
  *		the *callback_ctx* should be a pointer to the stack.
- *		The *flags* is used to control certain aspects of the helper.
- *		Currently, the *flags* must be 0.
+ *		The *flags* is used to control certain aspects of the helper and
+ *		may be one of the following:
+ *
+ *		**BPF_F_VMA_NEXT**
+ *			If no vma contains *addr*, call *callback_fn* with the next vma,
+ *			i.e. the vma with lowest vm_start that is higher than *addr*.
+ *			This replicates behavior of kernel's find_vma helper.
  *
  *		The expected callback signature is
  *
@@ -6026,6 +6031,11 @@ enum {
 	BPF_F_EXCLUDE_INGRESS	=3D (1ULL << 4),
 };
=20
+/* Flags for bpf_find_vma helper */
+enum {
+	BPF_F_VMA_NEXT		=3D (1ULL << 0),
+};
+
 #define __bpf_md_ptr(type, name)	\
 union {					\
 	type name;			\
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index c4ab9d6cdbe9..a8c87dcf36ad 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -777,7 +777,7 @@ static struct bpf_iter_reg task_vma_reg_info =3D {
 	.show_fdinfo		=3D bpf_iter_task_show_fdinfo,
 };
=20
-BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
+BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, addr,
 	   bpf_callback_t, callback_fn, void *, callback_ctx, u64, flags)
 {
 	struct mmap_unlock_irq_work *work =3D NULL;
@@ -785,10 +785,13 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task=
, u64, start,
 	bool irq_work_busy =3D false;
 	struct mm_struct *mm;
 	int ret =3D -ENOENT;
+	bool vma_next;
=20
-	if (flags)
+	if (flags & ~BPF_F_VMA_NEXT)
 		return -EINVAL;
=20
+	vma_next =3D flags & BPF_F_VMA_NEXT;
+
 	if (!task)
 		return -ENOENT;
=20
@@ -801,9 +804,10 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task,=
 u64, start,
 	if (irq_work_busy || !mmap_read_trylock(mm))
 		return -EBUSY;
=20
-	vma =3D find_vma(mm, start);
+	vma =3D find_vma(mm, addr);
=20
-	if (vma && vma->vm_start <=3D start && vma->vm_end > start) {
+	if (vma &&
+	    ((vma->vm_start <=3D addr && vma->vm_end > addr) || vma_next)) {
 		callback_fn((u64)(long)task, (u64)(long)vma,
 			    (u64)(long)callback_ctx, 0, 0);
 		ret =3D 0;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 70da85200695..947187d76ebc 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5169,8 +5169,13 @@ union bpf_attr {
  *		function with *task*, *vma*, and *callback_ctx*.
  *		The *callback_fn* should be a static function and
  *		the *callback_ctx* should be a pointer to the stack.
- *		The *flags* is used to control certain aspects of the helper.
- *		Currently, the *flags* must be 0.
+ *		The *flags* is used to control certain aspects of the helper and
+ *		may be one of the following:
+ *
+ *		**BPF_F_VMA_NEXT**
+ *			If no vma contains *addr*, call *callback_fn* with the next vma,
+ *			i.e. the vma with lowest vm_start that is higher than *addr*.
+ *			This replicates behavior of kernel's find_vma helper.
  *
  *		The expected callback signature is
  *
@@ -6026,6 +6031,11 @@ enum {
 	BPF_F_EXCLUDE_INGRESS	=3D (1ULL << 4),
 };
=20
+/* Flags for bpf_find_vma helper */
+enum {
+	BPF_F_VMA_NEXT		=3D (1ULL << 0),
+};
+
 #define __bpf_md_ptr(type, name)	\
 union {					\
 	type name;			\
--=20
2.34.1


