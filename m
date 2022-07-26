Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCA7580AB7
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 07:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiGZFR6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 01:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiGZFR6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 01:17:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA5625EB8
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 22:17:56 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26Q0p3Hp019579
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 22:17:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+FWA6mEM0y9dKiZv+Q56+iwR4UVapyob0DVIRKE8lwY=;
 b=Gn/BcSbX5bsTNaj90WLKmR0VCQ+TJPaRBzoDLQvL6/IwlZ03jrPI/wC4gDAHZK6USRsj
 wqid/BXNqb8jtFWSgD/lhbZquinqV1Egw9tYjQMyTOBi5xq+A6dXFZWF3f9Z1O72PWSe
 hQheQACsbFtoklM1d/Par0h8B5gNeslWGTA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hgcajpk6d-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 22:17:55 -0700
Received: from twshared22413.18.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 22:17:54 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 508E95E528AB; Mon, 25 Jul 2022 22:17:43 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
Date:   Mon, 25 Jul 2022 22:17:11 -0700
Message-ID: <20220726051713.840431-2-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220726051713.840431-1-kuifeng@fb.com>
References: <20220726051713.840431-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: cM8-1QzgeyQ0Zzr26LBTFlOVuVCxNdz1
X-Proofpoint-ORIG-GUID: cM8-1QzgeyQ0Zzr26LBTFlOVuVCxNdz1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_13,2022-07-25_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow creating an iterator that loops through resources of one task/threa=
d.

People could only create iterators to loop through all resources of
files, vma, and tasks in the system, even though they were interested
in only the resources of a specific task or process.  Passing the
additional parameters, people can now create an iterator to go
through all resources or only the resources of a task.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 include/linux/bpf.h            |  4 ++
 include/uapi/linux/bpf.h       | 23 ++++++++++
 kernel/bpf/task_iter.c         | 81 +++++++++++++++++++++++++---------
 tools/include/uapi/linux/bpf.h | 23 ++++++++++
 4 files changed, 109 insertions(+), 22 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 11950029284f..c8d164404e20 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1718,6 +1718,10 @@ int bpf_obj_get_user(const char __user *pathname, =
int flags);
=20
 struct bpf_iter_aux_info {
 	struct bpf_map *map;
+	struct {
+		__u32	tid;
+		u8	type;
+	} task;
 };
=20
 typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ffcbf79a556b..991141cacb9e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -87,10 +87,33 @@ struct bpf_cgroup_storage_key {
 	__u32	attach_type;		/* program attach type (enum bpf_attach_type) */
 };
=20
+enum bpf_task_iter_type {
+	BPF_TASK_ITER_ALL =3D 0,
+	BPF_TASK_ITER_TID,
+};
+
 union bpf_iter_link_info {
 	struct {
 		__u32	map_fd;
 	} map;
+	/*
+	 * Parameters of task iterators.
+	 */
+	struct {
+		__u32	tid;
+		/*
+		 * The type of the iterator.
+		 *
+		 * It can be one of enum bpf_task_iter_type.
+		 *
+		 * BPF_TASK_ITER_ALL (default)
+		 *	The iterator iterates over resources of everyprocess.
+		 *
+		 * BPF_TASK_ITER_TID
+		 *	You should also set *tid* to iterate over one task.
+		 */
+		__u8	type;	/* BPF_TASK_ITER_* */
+	} task;
 };
=20
 /* BPF syscall commands, see bpf(2) man-page for more details. */
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 8c921799def4..7979aacb651e 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -12,6 +12,8 @@
=20
 struct bpf_iter_seq_task_common {
 	struct pid_namespace *ns;
+	u32	tid;
+	u8	type;
 };
=20
 struct bpf_iter_seq_task_info {
@@ -22,18 +24,31 @@ struct bpf_iter_seq_task_info {
 	u32 tid;
 };
=20
-static struct task_struct *task_seq_get_next(struct pid_namespace *ns,
+static struct task_struct *task_seq_get_next(struct bpf_iter_seq_task_co=
mmon *common,
 					     u32 *tid,
 					     bool skip_if_dup_files)
 {
 	struct task_struct *task =3D NULL;
 	struct pid *pid;
=20
+	if (common->type =3D=3D BPF_TASK_ITER_TID) {
+		if (*tid)
+			return NULL;
+		rcu_read_lock();
+		pid =3D find_pid_ns(common->tid, common->ns);
+		if (pid) {
+			task =3D get_pid_task(pid, PIDTYPE_PID);
+			*tid =3D common->tid;
+		}
+		rcu_read_unlock();
+		return task;
+	}
+
 	rcu_read_lock();
 retry:
-	pid =3D find_ge_pid(*tid, ns);
+	pid =3D find_ge_pid(*tid, common->ns);
 	if (pid) {
-		*tid =3D pid_nr_ns(pid, ns);
+		*tid =3D pid_nr_ns(pid, common->ns);
 		task =3D get_pid_task(pid, PIDTYPE_PID);
 		if (!task) {
 			++*tid;
@@ -56,7 +71,8 @@ static void *task_seq_start(struct seq_file *seq, loff_=
t *pos)
 	struct bpf_iter_seq_task_info *info =3D seq->private;
 	struct task_struct *task;
=20
-	task =3D task_seq_get_next(info->common.ns, &info->tid, false);
+	task =3D task_seq_get_next(&info->common, &info->tid, false);
+
 	if (!task)
 		return NULL;
=20
@@ -73,7 +89,8 @@ static void *task_seq_next(struct seq_file *seq, void *=
v, loff_t *pos)
 	++*pos;
 	++info->tid;
 	put_task_struct((struct task_struct *)v);
-	task =3D task_seq_get_next(info->common.ns, &info->tid, false);
+
+	task =3D task_seq_get_next(&info->common, &info->tid, false);
 	if (!task)
 		return NULL;
=20
@@ -117,6 +134,18 @@ static void task_seq_stop(struct seq_file *seq, void=
 *v)
 		put_task_struct((struct task_struct *)v);
 }
=20
+static int bpf_iter_attach_task(struct bpf_prog *prog,
+				union bpf_iter_link_info *linfo,
+				struct bpf_iter_aux_info *aux)
+{
+	if (linfo->task.type =3D=3D BPF_TASK_ITER_ALL && linfo->task.tid)
+		return -EINVAL;
+
+	aux->task.type =3D linfo->task.type;
+	aux->task.tid =3D linfo->task.tid;
+	return 0;
+}
+
 static const struct seq_operations task_seq_ops =3D {
 	.start	=3D task_seq_start,
 	.next	=3D task_seq_next,
@@ -137,8 +166,7 @@ struct bpf_iter_seq_task_file_info {
 static struct file *
 task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
 {
-	struct pid_namespace *ns =3D info->common.ns;
-	u32 curr_tid =3D info->tid;
+	u32 saved_tid =3D info->tid;
 	struct task_struct *curr_task;
 	unsigned int curr_fd =3D info->fd;
=20
@@ -151,21 +179,18 @@ task_file_seq_get_next(struct bpf_iter_seq_task_fil=
e_info *info)
 		curr_task =3D info->task;
 		curr_fd =3D info->fd;
 	} else {
-                curr_task =3D task_seq_get_next(ns, &curr_tid, true);
+		curr_task =3D task_seq_get_next(&info->common, &info->tid, true);
                 if (!curr_task) {
                         info->task =3D NULL;
-                        info->tid =3D curr_tid;
                         return NULL;
                 }
=20
-                /* set info->task and info->tid */
+		/* set info->task */
 		info->task =3D curr_task;
-		if (curr_tid =3D=3D info->tid) {
+		if (saved_tid =3D=3D info->tid)
 			curr_fd =3D info->fd;
-		} else {
-			info->tid =3D curr_tid;
+		else
 			curr_fd =3D 0;
-		}
 	}
=20
 	rcu_read_lock();
@@ -186,9 +211,15 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file=
_info *info)
 	/* the current task is done, go to the next task */
 	rcu_read_unlock();
 	put_task_struct(curr_task);
+
+	if (info->common.type =3D=3D BPF_TASK_ITER_TID) {
+		info->task =3D NULL;
+		return NULL;
+	}
+
 	info->task =3D NULL;
 	info->fd =3D 0;
-	curr_tid =3D ++(info->tid);
+	saved_tid =3D ++(info->tid);
 	goto again;
 }
=20
@@ -269,6 +300,8 @@ static int init_seq_pidns(void *priv_data, struct bpf=
_iter_aux_info *aux)
 	struct bpf_iter_seq_task_common *common =3D priv_data;
=20
 	common->ns =3D get_pid_ns(task_active_pid_ns(current));
+	common->type =3D aux->task.type;
+	common->tid =3D aux->task.tid;
 	return 0;
 }
=20
@@ -307,11 +340,10 @@ enum bpf_task_vma_iter_find_op {
 static struct vm_area_struct *
 task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info *info)
 {
-	struct pid_namespace *ns =3D info->common.ns;
 	enum bpf_task_vma_iter_find_op op;
 	struct vm_area_struct *curr_vma;
 	struct task_struct *curr_task;
-	u32 curr_tid =3D info->tid;
+	u32 saved_tid =3D info->tid;
=20
 	/* If this function returns a non-NULL vma, it holds a reference to
 	 * the task_struct, and holds read lock on vma->mm->mmap_lock.
@@ -371,14 +403,13 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_=
info *info)
 		}
 	} else {
 again:
-		curr_task =3D task_seq_get_next(ns, &curr_tid, true);
+		curr_task =3D task_seq_get_next(&info->common, &info->tid, true);
 		if (!curr_task) {
-			info->tid =3D curr_tid + 1;
+			info->tid++;
 			goto finish;
 		}
=20
-		if (curr_tid !=3D info->tid) {
-			info->tid =3D curr_tid;
+		if (saved_tid !=3D info->tid) {
 			/* new task, process the first vma */
 			op =3D task_vma_iter_first_vma;
 		} else {
@@ -430,9 +461,12 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_i=
nfo *info)
 	return curr_vma;
=20
 next_task:
+	if (info->common.type =3D=3D BPF_TASK_ITER_TID)
+		goto finish;
+
 	put_task_struct(curr_task);
 	info->task =3D NULL;
-	curr_tid++;
+	info->tid++;
 	goto again;
=20
 finish:
@@ -533,6 +567,7 @@ static const struct bpf_iter_seq_info task_seq_info =3D=
 {
=20
 static struct bpf_iter_reg task_reg_info =3D {
 	.target			=3D "task",
+	.attach_target		=3D bpf_iter_attach_task,
 	.feature		=3D BPF_ITER_RESCHED,
 	.ctx_arg_info_size	=3D 1,
 	.ctx_arg_info		=3D {
@@ -551,6 +586,7 @@ static const struct bpf_iter_seq_info task_file_seq_i=
nfo =3D {
=20
 static struct bpf_iter_reg task_file_reg_info =3D {
 	.target			=3D "task_file",
+	.attach_target		=3D bpf_iter_attach_task,
 	.feature		=3D BPF_ITER_RESCHED,
 	.ctx_arg_info_size	=3D 2,
 	.ctx_arg_info		=3D {
@@ -571,6 +607,7 @@ static const struct bpf_iter_seq_info task_vma_seq_in=
fo =3D {
=20
 static struct bpf_iter_reg task_vma_reg_info =3D {
 	.target			=3D "task_vma",
+	.attach_target		=3D bpf_iter_attach_task,
 	.feature		=3D BPF_ITER_RESCHED,
 	.ctx_arg_info_size	=3D 2,
 	.ctx_arg_info		=3D {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index ffcbf79a556b..991141cacb9e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -87,10 +87,33 @@ struct bpf_cgroup_storage_key {
 	__u32	attach_type;		/* program attach type (enum bpf_attach_type) */
 };
=20
+enum bpf_task_iter_type {
+	BPF_TASK_ITER_ALL =3D 0,
+	BPF_TASK_ITER_TID,
+};
+
 union bpf_iter_link_info {
 	struct {
 		__u32	map_fd;
 	} map;
+	/*
+	 * Parameters of task iterators.
+	 */
+	struct {
+		__u32	tid;
+		/*
+		 * The type of the iterator.
+		 *
+		 * It can be one of enum bpf_task_iter_type.
+		 *
+		 * BPF_TASK_ITER_ALL (default)
+		 *	The iterator iterates over resources of everyprocess.
+		 *
+		 * BPF_TASK_ITER_TID
+		 *	You should also set *tid* to iterate over one task.
+		 */
+		__u8	type;	/* BPF_TASK_ITER_* */
+	} task;
 };
=20
 /* BPF syscall commands, see bpf(2) man-page for more details. */
--=20
2.30.2

