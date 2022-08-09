Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB1258D3E9
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 08:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiHIGhc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 02:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiHIGhb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 02:37:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7E018B27
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 23:37:29 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278NSEdr014403
        for <bpf@vger.kernel.org>; Mon, 8 Aug 2022 23:37:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=eYyEg9fTghI+7u/ntaSyzZw7foaQEakc2d5/Ob/j19g=;
 b=QYA37LiCc5yIJ+g5EcCLc5rpTMMlT4kUQU/wvYlTIbFpN0kIJP7kV7kjDkEx0Iefj+Hl
 Fj/85m/OgHt0KMVAdvs0FCENJlVyvqm1w1vO1SubMppFbYdRWof5gtg7GP/spgch1EX4
 IpbUKPSRCovJbKja3pKb7Ell/NdMypvJlE8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hu9utjjt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 23:37:29 -0700
Received: from twshared16418.24.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 8 Aug 2022 23:37:28 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 08E0C671675F; Mon,  8 Aug 2022 23:35:02 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v3 1/3] bpf: Parameterize task iterators.
Date:   Mon, 8 Aug 2022 23:34:59 -0700
Message-ID: <20220809063501.667610-2-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220809063501.667610-1-kuifeng@fb.com>
References: <20220809063501.667610-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8kmfXxOGY4yFQ60BaXjNsmJcJGh7vA8f
X-Proofpoint-ORIG-GUID: 8kmfXxOGY4yFQ60BaXjNsmJcJGh7vA8f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_03,2022-08-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 include/linux/bpf.h            |   8 ++
 include/uapi/linux/bpf.h       |  36 +++++++++
 kernel/bpf/task_iter.c         | 134 +++++++++++++++++++++++++++------
 tools/include/uapi/linux/bpf.h |  36 +++++++++
 4 files changed, 190 insertions(+), 24 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 11950029284f..bef81324e5f1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1718,6 +1718,14 @@ int bpf_obj_get_user(const char __user *pathname, =
int flags);
=20
 struct bpf_iter_aux_info {
 	struct bpf_map *map;
+	struct {
+		enum bpf_iter_task_type	type;
+		union {
+			u32 tid;
+			u32 tgid;
+			u32 pid_fd;
+		};
+	} task;
 };
=20
 typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ffcbf79a556b..3d0b9e34089f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -87,10 +87,46 @@ struct bpf_cgroup_storage_key {
 	__u32	attach_type;		/* program attach type (enum bpf_attach_type) */
 };
=20
+/*
+ * The task type of iterators.
+ *
+ * For BPF task iterators, they can be parameterized with various
+ * parameters to visit only some of tasks.
+ *
+ * BPF_TASK_ITER_ALL (default)
+ *	Iterate over resources of every task.
+ *
+ * BPF_TASK_ITER_TID
+ *	Iterate over resources of a task/tid.
+ *
+ * BPF_TASK_ITER_TGID
+ *	Iterate over reosurces of evevry task of a process / task group.
+ *
+ * BPF_TASK_ITER_PIDFD
+ *	Iterate over resources of every task of a process /task group specifi=
ed by a pidfd.
+ */
+enum bpf_iter_task_type {
+	BPF_TASK_ITER_ALL =3D 0,
+	BPF_TASK_ITER_TID,
+	BPF_TASK_ITER_TGID,
+	BPF_TASK_ITER_PIDFD,
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
+		enum bpf_iter_task_type	type;
+		union {
+			__u32 tid;
+			__u32 tgid;
+			__u32 pid_fd;
+		};
+	} task;
 };
=20
 /* BPF syscall commands, see bpf(2) man-page for more details. */
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 8c921799def4..047d94493117 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -12,6 +12,12 @@
=20
 struct bpf_iter_seq_task_common {
 	struct pid_namespace *ns;
+	enum bpf_iter_task_type	type;
+	union {
+		u32 tid;
+		u32 tgid;
+		u32 pid_fd;
+	};
 };
=20
 struct bpf_iter_seq_task_info {
@@ -22,24 +28,41 @@ struct bpf_iter_seq_task_info {
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
+		if (*tid && *tid !=3D common->tid)
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
+
+
 		if (!task) {
 			++*tid;
 			goto retry;
-		} else if (skip_if_dup_files && !thread_group_leader(task) &&
-			   task->files =3D=3D task->group_leader->files) {
+		} else if ((skip_if_dup_files && !thread_group_leader(task) &&
+			    task->files =3D=3D task->group_leader->files) ||
+			   (common->type =3D=3D BPF_TASK_ITER_TGID &&
+			    __task_pid_nr_ns(task, PIDTYPE_TGID, common->ns) !=3D common->tgi=
d)) {
 			put_task_struct(task);
 			task =3D NULL;
 			++*tid;
@@ -56,7 +79,8 @@ static void *task_seq_start(struct seq_file *seq, loff_=
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
@@ -73,7 +97,8 @@ static void *task_seq_next(struct seq_file *seq, void *=
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
@@ -117,6 +142,50 @@ static void task_seq_stop(struct seq_file *seq, void=
 *v)
 		put_task_struct((struct task_struct *)v);
 }
=20
+static int bpf_iter_attach_task(struct bpf_prog *prog,
+				union bpf_iter_link_info *linfo,
+				struct bpf_iter_aux_info *aux)
+{
+	unsigned int flags;
+	struct pid_namespace *ns;
+	struct pid *pid;
+	pid_t tgid;
+
+	if (linfo->task.type =3D=3D BPF_TASK_ITER_ALL && linfo->task.pid_fd !=3D=
 0)
+		return -EINVAL;
+
+	aux->task.type =3D linfo->task.type;
+
+	switch (linfo->task.type) {
+	case BPF_TASK_ITER_TID:
+		aux->task.tid =3D linfo->task.tid;
+		break;
+	case BPF_TASK_ITER_TGID:
+		aux->task.tgid =3D linfo->task.tgid;
+		break;
+	case BPF_TASK_ITER_PIDFD:
+		pid =3D pidfd_get_pid(linfo->task.pid_fd, &flags);
+		if (IS_ERR(pid))
+			return PTR_ERR(pid);
+
+		ns =3D task_active_pid_ns(current);
+		if (IS_ERR(ns))
+			return PTR_ERR(ns);
+
+		tgid =3D pid_nr_ns(pid, ns);
+		if (tgid <=3D 0)
+			return -EINVAL;
+
+		aux->task.tgid =3D tgid;
+		aux->task.type =3D BPF_TASK_ITER_TGID;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static const struct seq_operations task_seq_ops =3D {
 	.start	=3D task_seq_start,
 	.next	=3D task_seq_next,
@@ -137,8 +206,7 @@ struct bpf_iter_seq_task_file_info {
 static struct file *
 task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
 {
-	struct pid_namespace *ns =3D info->common.ns;
-	u32 curr_tid =3D info->tid;
+	u32 saved_tid =3D info->tid;
 	struct task_struct *curr_task;
 	unsigned int curr_fd =3D info->fd;
=20
@@ -151,21 +219,18 @@ task_file_seq_get_next(struct bpf_iter_seq_task_fil=
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
@@ -186,9 +251,15 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file=
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
@@ -269,6 +340,17 @@ static int init_seq_pidns(void *priv_data, struct bp=
f_iter_aux_info *aux)
 	struct bpf_iter_seq_task_common *common =3D priv_data;
=20
 	common->ns =3D get_pid_ns(task_active_pid_ns(current));
+	common->type =3D aux->task.type;
+	switch (common->type) {
+	case BPF_TASK_ITER_TID:
+		common->tid =3D aux->task.tid;
+		break;
+	case BPF_TASK_ITER_TGID:
+		common->tgid =3D aux->task.tgid;
+		break;
+	default:
+		break;
+	}
 	return 0;
 }
=20
@@ -307,11 +389,10 @@ enum bpf_task_vma_iter_find_op {
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
@@ -371,14 +452,13 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_=
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
@@ -430,9 +510,12 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_i=
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
@@ -533,6 +616,7 @@ static const struct bpf_iter_seq_info task_seq_info =3D=
 {
=20
 static struct bpf_iter_reg task_reg_info =3D {
 	.target			=3D "task",
+	.attach_target		=3D bpf_iter_attach_task,
 	.feature		=3D BPF_ITER_RESCHED,
 	.ctx_arg_info_size	=3D 1,
 	.ctx_arg_info		=3D {
@@ -551,6 +635,7 @@ static const struct bpf_iter_seq_info task_file_seq_i=
nfo =3D {
=20
 static struct bpf_iter_reg task_file_reg_info =3D {
 	.target			=3D "task_file",
+	.attach_target		=3D bpf_iter_attach_task,
 	.feature		=3D BPF_ITER_RESCHED,
 	.ctx_arg_info_size	=3D 2,
 	.ctx_arg_info		=3D {
@@ -571,6 +656,7 @@ static const struct bpf_iter_seq_info task_vma_seq_in=
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
index ffcbf79a556b..3d0b9e34089f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -87,10 +87,46 @@ struct bpf_cgroup_storage_key {
 	__u32	attach_type;		/* program attach type (enum bpf_attach_type) */
 };
=20
+/*
+ * The task type of iterators.
+ *
+ * For BPF task iterators, they can be parameterized with various
+ * parameters to visit only some of tasks.
+ *
+ * BPF_TASK_ITER_ALL (default)
+ *	Iterate over resources of every task.
+ *
+ * BPF_TASK_ITER_TID
+ *	Iterate over resources of a task/tid.
+ *
+ * BPF_TASK_ITER_TGID
+ *	Iterate over reosurces of evevry task of a process / task group.
+ *
+ * BPF_TASK_ITER_PIDFD
+ *	Iterate over resources of every task of a process /task group specifi=
ed by a pidfd.
+ */
+enum bpf_iter_task_type {
+	BPF_TASK_ITER_ALL =3D 0,
+	BPF_TASK_ITER_TID,
+	BPF_TASK_ITER_TGID,
+	BPF_TASK_ITER_PIDFD,
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
+		enum bpf_iter_task_type	type;
+		union {
+			__u32 tid;
+			__u32 tgid;
+			__u32 pid_fd;
+		};
+	} task;
 };
=20
 /* BPF syscall commands, see bpf(2) man-page for more details. */
--=20
2.30.2

