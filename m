Return-Path: <bpf+bounces-14478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1C47E558F
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 12:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27CF7B20E9A
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 11:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9C115EA6;
	Wed,  8 Nov 2023 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="WofPxmh0"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1731379
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 11:30:34 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7B4B0
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 03:30:34 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7NHa7T025794
	for <bpf@vger.kernel.org>; Wed, 8 Nov 2023 03:24:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=PuLsguifoxTg8uq3bAEQmh8+x5D4mTT/6hjfK5D6dDs=;
 b=WofPxmh0oiqx9FUkvmKbCeNuYh1JwJZTTdLDY/uBTMQJffswglUTdmjjU+cQr+re8BWo
 LBBJzHxLsgAdCIaktW98zG6DJTWviliSmiKjPDijVZRornFH/wHKlPn56xkPJ8mAWUzW
 RxRLH/ug3X4FgTnEMCInAKgtru6tzWCuMN0/iUfXFXFlDdjLGxwr00mo1ewAjl9QaH3N
 9xpqHX8g5q5Q+30buJDsqit7xmHzCD9+wF2cCwAWfnyRwWVnmOuQbNhMk2/FRM47pmh0
 Mr4dvfq615Y2XsDHf9Lj/uRdzPQnyukPgqHTSIs6zT3tc2L8kHdMz0YuRVGxHM1GIvon pQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u7w2x50ew-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 08 Nov 2023 03:24:09 -0800
Received: from twshared29647.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 03:24:00 -0800
Received: by devbig1151.frc2.facebook.com (Postfix, from userid 149108)
	id DE54C7A6BFBA; Wed,  8 Nov 2023 03:23:55 -0800 (PST)
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
Subject: [PATCH v2 bpf-next] bpf: add crosstask check to __bpf_get_stack
Date: Wed, 8 Nov 2023 03:23:34 -0800
Message-ID: <20231108112334.3433136-1-jordalgo@meta.com>
X-Mailer: git-send-email 2.39.3
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vXb869sM_8bknGbDNN75EfJet0Tv85UG
X-Proofpoint-GUID: vXb869sM_8bknGbDNN75EfJet0Tv85UG
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-08_01,2023-05-22_02

Currently get_perf_callchain only supports user stack walking for
the current task. Passing the correct *crosstask* param will return
0 frames if the task passed to __bpf_get_stack isn't the current
one instead of a single incorrect frame/address. This change
passes the correct *crosstask* param but also does a preemptive
check in __bpf_get_stack if the task is current and returns
-EOPNOTSUPP if it is not.

This issue was found using bpf_get_task_stack inside a BPF
iterator ("iter/task"), which iterates over all tasks.
bpf_get_task_stack works fine for fetching kernel stacks
but because get_perf_callchain relies on the caller to know
if the requested *task* is the current one (via *crosstask*)
it was failing in a confusing way.

It might be possible to get user stacks for all tasks utilizing
something like access_process_vm but that requires the bpf
program calling bpf_get_task_stack to be sleepable and would
therefore be a breaking change.

Fixes: fa28dcb82a38 ("bpf: Introduce helper bpf_get_task_stack()")
Signed-off-by: Jordan Rome <jordalgo@meta.com>
---

Changes in v2:
* Return -EOPNOTSUPP in __bpf_get_stack if crosstask and user stack
* Remove changes to bpf selftests (will make a separate patch)

v1:
https://lore.kernel.org/bpf/20231106221423.564362-1-jordalgo@meta.com/

 include/uapi/linux/bpf.h       |  3 +++
 kernel/bpf/stackmap.c          | 11 ++++++++++-
 tools/include/uapi/linux/bpf.h |  3 +++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0f6cdf52b1da..bda948a685e5 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4517,6 +4517,8 @@ union bpf_attr {
  * long bpf_get_task_stack(struct task_struct *task, void *buf, u32 size, =
u64 flags)
  *	Description
  *		Return a user or a kernel stack in bpf program provided buffer.
+ *		Note: the user stack will only be populated if the *task* is
+ *		the current task; all other tasks will return -EOPNOTSUPP.
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
index d6b277482085..dff7ba539701 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -388,6 +388,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struc=
t task_struct *task,
 {
 	u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
 	bool user_build_id =3D flags & BPF_F_USER_BUILD_ID;
+	bool crosstask =3D task && task !=3D current;
 	u32 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
 	bool user =3D flags & BPF_F_USER_STACK;
 	struct perf_callchain_entry *trace;
@@ -410,6 +411,14 @@ static long __bpf_get_stack(struct pt_regs *regs, stru=
ct task_struct *task,
 	if (task && user && !user_mode(regs))
 		goto err_fault;
=20
+	/* get_perf_callchain does not support crosstask user stack walking
+	 * but returns an empty stack instead of NULL.
+	 */
+	if (crosstask && user) {
+		err =3D -EOPNOTSUPP;
+		goto clear;
+	}
+
 	num_elem =3D size / elem_size;
 	max_depth =3D num_elem + skip;
 	if (sysctl_perf_event_max_stack < max_depth)
@@ -421,7 +430,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struc=
t task_struct *task,
 		trace =3D get_callchain_entry_for_task(task, max_depth);
 	else
 		trace =3D get_perf_callchain(regs, 0, kernel, user, max_depth,
-					   false, false);
+					   crosstask, false);
 	if (unlikely(!trace))
 		goto err_fault;
=20
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0f6cdf52b1da..bda948a685e5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4517,6 +4517,8 @@ union bpf_attr {
  * long bpf_get_task_stack(struct task_struct *task, void *buf, u32 size, =
u64 flags)
  *	Description
  *		Return a user or a kernel stack in bpf program provided buffer.
+ *		Note: the user stack will only be populated if the *task* is
+ *		the current task; all other tasks will return -EOPNOTSUPP.
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
--=20
2.39.3


