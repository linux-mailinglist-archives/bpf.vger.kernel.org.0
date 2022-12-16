Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4676264E5C9
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 03:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiLPB7k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 20:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiLPB7j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 20:59:39 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAA22A435
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 17:59:38 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BG0gBAl003361
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 17:59:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=q0dkVT1046Z/0Ay02N3rdXqy7E1eepT0+HFV6m4yjtU=;
 b=C9qMmJEfbIDdmxFNzgCmEyjWZhmBZ+z58ZuJz/sqNLY5iZTPsKRRb7LzrYtuUBAbOvLC
 7c4AiQJCASdEBLY9WevEYt6Xrcqu5PjIF0NYUDN4DWSEbTeUVKwwCko7tAUcPlqlDn3Q
 KLpJEUdCGgHR+GEbOUyciWbTZ3HKsGW4E5VrdNVG7tsXWEa6UNevXxdGfwpeupZ2Mnx3
 X0PT0YvZPY+6iC07944657Pk8fQAj0cuEE/2GoMPRlwa9y+z2pHV9XQRbCEDfMkiVo8N
 guOmSiOBWlzvNsluIOlU5ZUA4pchfcoDVIWd/r4lAI507/zgLxSwCtGUztQewz2SsHMw QQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mfy5sykn2-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 17:59:38 -0800
Received: from twshared26225.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 15 Dec 2022 17:59:36 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 2FCB3A5F24D; Thu, 15 Dec 2022 17:59:30 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <kernel-team@meta.com>, <song@kernel.org>
CC:     Kui-Feng Lee <kuifeng@meta.com>,
        Nathan Slingerland <slinger@meta.com>
Subject: [PATCH bpf-next 1/2] bpf: keep a reference to the mm, in case the task is dead.
Date:   Thu, 15 Dec 2022 17:59:11 -0800
Message-ID: <20221216015912.991616-2-kuifeng@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221216015912.991616-1-kuifeng@meta.com>
References: <20221216015912.991616-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: oRDd4ZAIvI-m7UlFMU8Lf-xS4MoXjbWi
X-Proofpoint-ORIG-GUID: oRDd4ZAIvI-m7UlFMU8Lf-xS4MoXjbWi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_12,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix the system crash that happens when a task iterator travel through
vma of tasks.

In task iterators, we used to access mm by following the pointer on
the task_struct; however, the death of a task will clear the pointer,
even though we still hold the task_struct.  That can cause an
unexpected crash for a null pointer when an iterator is visiting a
task that dies during the visit.  Keeping a reference of mm on the
iterator ensures we always have a valid pointer to mm.

Co-developed-by: Song Liu <song@kernel.org>
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
Reported-by: Nathan Slingerland <slinger@meta.com>
---
 kernel/bpf/task_iter.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index c2a2182ce570..c4ab9d6cdbe9 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -438,6 +438,7 @@ struct bpf_iter_seq_task_vma_info {
 	 */
 	struct bpf_iter_seq_task_common common;
 	struct task_struct *task;
+	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	u32 tid;
 	unsigned long prev_vm_start;
@@ -456,16 +457,19 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_=
info *info)
 	enum bpf_task_vma_iter_find_op op;
 	struct vm_area_struct *curr_vma;
 	struct task_struct *curr_task;
+	struct mm_struct *curr_mm;
 	u32 saved_tid =3D info->tid;
=20
 	/* If this function returns a non-NULL vma, it holds a reference to
-	 * the task_struct, and holds read lock on vma->mm->mmap_lock.
+	 * the task_struct, holds a refcount on mm->mm_users, and holds
+	 * read lock on vma->mm->mmap_lock.
 	 * If this function returns NULL, it does not hold any reference or
 	 * lock.
 	 */
 	if (info->task) {
 		curr_task =3D info->task;
 		curr_vma =3D info->vma;
+		curr_mm =3D info->mm;
 		/* In case of lock contention, drop mmap_lock to unblock
 		 * the writer.
 		 *
@@ -504,13 +508,15 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_=
info *info)
 		 *    4.2) VMA2 and VMA2' covers different ranges, process
 		 *         VMA2'.
 		 */
-		if (mmap_lock_is_contended(curr_task->mm)) {
+		if (mmap_lock_is_contended(curr_mm)) {
 			info->prev_vm_start =3D curr_vma->vm_start;
 			info->prev_vm_end =3D curr_vma->vm_end;
 			op =3D task_vma_iter_find_vma;
-			mmap_read_unlock(curr_task->mm);
-			if (mmap_read_lock_killable(curr_task->mm))
+			mmap_read_unlock(curr_mm);
+			if (mmap_read_lock_killable(curr_mm)) {
+				mmput(curr_mm);
 				goto finish;
+			}
 		} else {
 			op =3D task_vma_iter_next_vma;
 		}
@@ -535,42 +541,47 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_=
info *info)
 			op =3D task_vma_iter_find_vma;
 		}
=20
-		if (!curr_task->mm)
+		curr_mm =3D get_task_mm(curr_task);
+		if (!curr_mm)
 			goto next_task;
=20
-		if (mmap_read_lock_killable(curr_task->mm))
+		if (mmap_read_lock_killable(curr_mm)) {
+			mmput(curr_mm);
 			goto finish;
+		}
 	}
=20
 	switch (op) {
 	case task_vma_iter_first_vma:
-		curr_vma =3D find_vma(curr_task->mm, 0);
+		curr_vma =3D find_vma(curr_mm, 0);
 		break;
 	case task_vma_iter_next_vma:
-		curr_vma =3D find_vma(curr_task->mm, curr_vma->vm_end);
+		curr_vma =3D find_vma(curr_mm, curr_vma->vm_end);
 		break;
 	case task_vma_iter_find_vma:
 		/* We dropped mmap_lock so it is necessary to use find_vma
 		 * to find the next vma. This is similar to the  mechanism
 		 * in show_smaps_rollup().
 		 */
-		curr_vma =3D find_vma(curr_task->mm, info->prev_vm_end - 1);
+		curr_vma =3D find_vma(curr_mm, info->prev_vm_end - 1);
 		/* case 1) and 4.2) above just use curr_vma */
=20
 		/* check for case 2) or case 4.1) above */
 		if (curr_vma &&
 		    curr_vma->vm_start =3D=3D info->prev_vm_start &&
 		    curr_vma->vm_end =3D=3D info->prev_vm_end)
-			curr_vma =3D find_vma(curr_task->mm, curr_vma->vm_end);
+			curr_vma =3D find_vma(curr_mm, curr_vma->vm_end);
 		break;
 	}
 	if (!curr_vma) {
 		/* case 3) above, or case 2) 4.1) with vma->next =3D=3D NULL */
-		mmap_read_unlock(curr_task->mm);
+		mmap_read_unlock(curr_mm);
+		mmput(curr_mm);
 		goto next_task;
 	}
 	info->task =3D curr_task;
 	info->vma =3D curr_vma;
+	info->mm =3D curr_mm;
 	return curr_vma;
=20
 next_task:
@@ -579,6 +590,7 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_in=
fo *info)
=20
 	put_task_struct(curr_task);
 	info->task =3D NULL;
+	info->mm =3D NULL;
 	info->tid++;
 	goto again;
=20
@@ -587,6 +599,7 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_in=
fo *info)
 		put_task_struct(curr_task);
 	info->task =3D NULL;
 	info->vma =3D NULL;
+	info->mm =3D NULL;
 	return NULL;
 }
=20
@@ -658,7 +671,9 @@ static void task_vma_seq_stop(struct seq_file *seq, v=
oid *v)
 		 */
 		info->prev_vm_start =3D ~0UL;
 		info->prev_vm_end =3D info->vma->vm_end;
-		mmap_read_unlock(info->task->mm);
+		mmap_read_unlock(info->mm);
+		mmput(info->mm);
+		info->mm =3D NULL;
 		put_task_struct(info->task);
 		info->task =3D NULL;
 	}
--=20
2.30.2

