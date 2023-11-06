Return-Path: <bpf+bounces-14332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8157E2FA5
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 23:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6C6280D37
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 22:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBC02EB0A;
	Mon,  6 Nov 2023 22:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GCKnqsCP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33062EAFB
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 22:15:13 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C94A183
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 14:15:12 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6LoS5M013255
	for <bpf@vger.kernel.org>; Mon, 6 Nov 2023 14:15:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=bcrHRwees4Bbne5VjEl2TTLS20WUPzv3z/h5wkgi7/M=;
 b=GCKnqsCPatb54nPeE2MZ4AE2n6bvMZai8xZoFrYJUDwuf9n/k43cW7vGN3HD8G+OpQUl
 4VLf0tC4ks67p9iEostDxauPqKOYXnuJiCfarkKSviHknM6tg2a33kXG5UXUl+EU3OWI
 esEn1+gA1ZmEUhkjCvHeBWi43dvv2NsPgDMOtK8uk/kJaoDqmRuwa9HpJ8IQJrfUkTkK
 nlv1hyUOUJHI9qcyqT1662q7UtOHSkmZCm3pKv/U9j0J1CIZX6CnVhGaCgEvA03vspMA
 r33sjJvX1Beg9gAMm34vW2C0cpqg2wFLiPnCalYzql8w/hCP2YIPfykBwWnn1fI5zsPi zQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u72a6brnb-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 14:15:11 -0800
Received: from twshared29647.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 14:15:10 -0800
Received: by devbig1151.frc2.facebook.com (Postfix, from userid 149108)
	id ED17E791951D; Mon,  6 Nov 2023 14:14:54 -0800 (PST)
From: Jordan Rome <jordalgo@meta.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Jordan Rome
	<jordalgo@meta.com>
Subject: [PATCH bpf-next] bpf: stackmap: add crosstask check to `__bpf_get_stack`
Date: Mon, 6 Nov 2023 14:14:23 -0800
Message-ID: <20231106221423.564362-1-jordalgo@meta.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Set6Cg6qZ0ifGiP13uOwvWUPYR-byD6P
X-Proofpoint-GUID: Set6Cg6qZ0ifGiP13uOwvWUPYR-byD6P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02

Currently `get_perf_callchain` only supports user stack walking for
the current task. Passing the correct *crosstask* param will return
-EFAULT if the task passed to `__bpf_get_stack` isn't the current
one instead of a single incorrect frame/address.

This issue was found using `bpf_get_task_stack` inside a BPF
iterator ("iter/task"), which iterates over all tasks.
`bpf_get_task_stack` works fine for fetching kernel stacks
but because `get_perf_callchain` relies on the caller to know
if the requested *task* is the current one (via *crosstask*)
it wasn't returning an error.

It might be possible to get user stacks for all tasks utilizing
something like `access_process_vm` but that requires the bpf
program calling `bpf_get_task_stack` to be sleepable and would
therefore be a breaking change.

Fixes: fa28dcb82a38 ("bpf: Introduce helper bpf_get_task_stack()")
Signed-off-by: Jordan Rome <jordalgo@meta.com>
---
 include/uapi/linux/bpf.h                                | 3 +++
 kernel/bpf/stackmap.c                                   | 3 ++-
 tools/include/uapi/linux/bpf.h                          | 3 +++
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c       | 3 +++
 tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c | 5 +++++
 5 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0f6cdf52b1da..da2871145274 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4517,6 +4517,8 @@ union bpf_attr {
  * long bpf_get_task_stack(struct task_struct *task, void *buf, u32 size=
, u64 flags)
  *	Description
  *		Return a user or a kernel stack in bpf program provided buffer.
+ *		Note: the user stack will only be populated if the *task* is
+ *		the current task; all other tasks will return -EFAULT.
  *		To achieve this, the helper needs *task*, which is a valid
  *		pointer to **struct task_struct**. To store the stacktrace, the
  *		bpf program provides *buf* with a nonnegative *size*.
@@ -4528,6 +4530,7 @@ union bpf_attr {
  *
  *		**BPF_F_USER_STACK**
  *			Collect a user space stack instead of a kernel stack.
+ *			The *task* must be the current task.
  *		**BPF_F_USER_BUILD_ID**
  *			Collect buildid+offset instead of ips for user stack,
  *			only valid if **BPF_F_USER_STACK** is also specified.
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index d6b277482085..96641766e90c 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -388,6 +388,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
 {
 	u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
 	bool user_build_id =3D flags & BPF_F_USER_BUILD_ID;
+	bool crosstask =3D task && task !=3D current;
 	u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
 	bool user =3D flags & BPF_F_USER_STACK;
 	struct perf_callchain_entry *trace;
@@ -421,7 +422,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
 		trace =3D get_callchain_entry_for_task(task, max_depth);
 	else
 		trace =3D get_perf_callchain(regs, 0, kernel, user, max_depth,
-					   false, false);
+					   crosstask, false);
 	if (unlikely(!trace))
 		goto err_fault;
=20
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 0f6cdf52b1da..da2871145274 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4517,6 +4517,8 @@ union bpf_attr {
  * long bpf_get_task_stack(struct task_struct *task, void *buf, u32 size=
, u64 flags)
  *	Description
  *		Return a user or a kernel stack in bpf program provided buffer.
+ *		Note: the user stack will only be populated if the *task* is
+ *		the current task; all other tasks will return -EFAULT.
  *		To achieve this, the helper needs *task*, which is a valid
  *		pointer to **struct task_struct**. To store the stacktrace, the
  *		bpf program provides *buf* with a nonnegative *size*.
@@ -4528,6 +4530,7 @@ union bpf_attr {
  *
  *		**BPF_F_USER_STACK**
  *			Collect a user space stack instead of a kernel stack.
+ *			The *task* must be the current task.
  *		**BPF_F_USER_BUILD_ID**
  *			Collect buildid+offset instead of ips for user stack,
  *			only valid if **BPF_F_USER_STACK** is also specified.
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
index 4e02093c2cbe..757635145510 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -332,6 +332,9 @@ static void test_task_stack(void)
 	do_dummy_read(skel->progs.dump_task_stack);
 	do_dummy_read(skel->progs.get_task_user_stacks);
=20
+	ASSERT_EQ(skel->bss->num_user_stacks, 1,
+		  "num_user_stacks");
+
 	bpf_iter_task_stack__destroy(skel);
 }
=20
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c b/to=
ols/testing/selftests/bpf/progs/bpf_iter_task_stack.c
index f2b8167b72a8..442f4ca39fd7 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
@@ -35,6 +35,8 @@ int dump_task_stack(struct bpf_iter__task *ctx)
 	return 0;
 }
=20
+int num_user_stacks =3D 0;
+
 SEC("iter/task")
 int get_task_user_stacks(struct bpf_iter__task *ctx)
 {
@@ -51,6 +53,9 @@ int get_task_user_stacks(struct bpf_iter__task *ctx)
 	if (res <=3D 0)
 		return 0;
=20
+	/* Only one task, the current one, should succeed */
+	++num_user_stacks;
+
 	buf_sz +=3D res;
=20
 	/* If the verifier doesn't refine bpf_get_task_stack res, and instead
--=20
2.39.3


