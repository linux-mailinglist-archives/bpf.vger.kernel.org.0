Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D7C5A1DB5
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 02:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiHZAh5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 20:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiHZAh4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 20:37:56 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9B7C7F91
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 17:37:55 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PM4IHg029103
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 17:37:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=mfmD4/qLodBzTH+IaoaHea9d2r9RXkYv+c+jQc2s0Hk=;
 b=K4K7tvWt+kOWfd+EifFrQ3LUl1ou3C09LIUmk0WPl+6KRqmT6MCu9L1UKEr0CGrzdsPV
 vpcCQQyHsjsfQ6Y/2Ko8pMuhVwQyPJqMBZ+WTpCiLA7lLdfv+0Lk6FSwHNYSOayGilAL
 ep2brH0LCYxyxPBzY5gbCYsskeXwEJaVr8Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j6g8dsakk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 17:37:54 -0700
Received: from twshared30313.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 25 Aug 2022 17:37:53 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 4A1AC71E4B7D; Thu, 25 Aug 2022 17:37:48 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v7 1/5] bpf: Parameterize task iterators.
Date:   Thu, 25 Aug 2022 17:37:08 -0700
Message-ID: <20220826003712.2810158-2-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220826003712.2810158-1-kuifeng@fb.com>
References: <20220826003712.2810158-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 4Ll8h9Sys_rOdHKPWj0RruSnZwoQMCzU
X-Proofpoint-ORIG-GUID: 4Ll8h9Sys_rOdHKPWj0RruSnZwoQMCzU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_11,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow creating an iterator that loops through resources of one
thread/process.

People could only create iterators to loop through all resources of
files, vma, and tasks in the system, even though they were interested
in only the resources of a specific task or process.  Passing the
additional parameters, people can now create an iterator to go
through all resources or only the resources of a task.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h            |  25 +++++++
 include/uapi/linux/bpf.h       |   6 ++
 kernel/bpf/task_iter.c         | 128 ++++++++++++++++++++++++++-------
 tools/include/uapi/linux/bpf.h |   6 ++
 4 files changed, 141 insertions(+), 24 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9c1674973e03..31ac2c1181f5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1730,6 +1730,27 @@ int bpf_obj_get_user(const char __user *pathname, =
int flags);
 	extern int bpf_iter_ ## target(args);			\
 	int __init bpf_iter_ ## target(args) { return 0; }
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
+ *	Iterate over resources of every task of a process / task group.
+ */
+enum bpf_iter_task_type {
+	BPF_TASK_ITER_ALL =3D 0,
+	BPF_TASK_ITER_TID,
+	BPF_TASK_ITER_TGID,
+};
+
 struct bpf_iter_aux_info {
 	/* for map_elem iter */
 	struct bpf_map *map;
@@ -1739,6 +1760,10 @@ struct bpf_iter_aux_info {
 		struct cgroup *start; /* starting cgroup */
 		enum bpf_cgroup_iter_order order;
 	} cgroup;
+	struct {
+		enum bpf_iter_task_type	type;
+		u32 pid;
+	} task;
 };
=20
 typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0f61f09f467a..385deab984e1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -110,6 +110,12 @@ union bpf_iter_link_info {
 		__u32	cgroup_fd;
 		__u64	cgroup_id;
 	} cgroup;
+	/* Parameters of task iterators. */
+	struct {
+		__u32	tid;
+		__u32	pid;
+		__u32	pid_fd;
+	} task;
 };
=20
 /* BPF syscall commands, see bpf(2) man-page for more details. */
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 8c921799def4..1200cfde71e3 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -12,6 +12,8 @@
=20
 struct bpf_iter_seq_task_common {
 	struct pid_namespace *ns;
+	enum bpf_iter_task_type	type;
+	u32 pid;
 };
=20
 struct bpf_iter_seq_task_info {
@@ -22,24 +24,54 @@ struct bpf_iter_seq_task_info {
 	u32 tid;
 };
=20
-static struct task_struct *task_seq_get_next(struct pid_namespace *ns,
+static bool matched_task(struct task_struct *task,
+			 struct bpf_iter_seq_task_common *common,
+			 bool skip_if_dup_file)
+{
+	/* Should not have the same 'files' if skip_if_dup_file is true */
+	bool diff_files_if =3D
+		!skip_if_dup_file ||
+		(thread_group_leader(task) &&
+		 task->files !=3D task->group_leader->files);
+	/* Should have the given tgid if the type is BPF_TASK_ITER_TGI */
+	bool have_tgid_if =3D
+		common->type !=3D BPF_TASK_ITER_TGID ||
+		__task_pid_nr_ns(task, PIDTYPE_TGID,
+				 common->ns) =3D=3D common->pid;
+	return diff_files_if && have_tgid_if;
+}
+
+
+static struct task_struct *task_seq_get_next(struct bpf_iter_seq_task_co=
mmon *common,
 					     u32 *tid,
 					     bool skip_if_dup_files)
 {
 	struct task_struct *task =3D NULL;
 	struct pid *pid;
=20
+	if (common->type =3D=3D BPF_TASK_ITER_TID) {
+		if (*tid && *tid !=3D common->pid)
+			return NULL;
+		rcu_read_lock();
+		pid =3D find_pid_ns(common->pid, common->ns);
+		if (pid) {
+			task =3D get_pid_task(pid, PIDTYPE_PID);
+			*tid =3D common->pid;
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
 			goto retry;
-		} else if (skip_if_dup_files && !thread_group_leader(task) &&
-			   task->files =3D=3D task->group_leader->files) {
+		} else if (!matched_task(task, common, skip_if_dup_files)) {
 			put_task_struct(task);
 			task =3D NULL;
 			++*tid;
@@ -56,7 +88,7 @@ static void *task_seq_start(struct seq_file *seq, loff_=
t *pos)
 	struct bpf_iter_seq_task_info *info =3D seq->private;
 	struct task_struct *task;
=20
-	task =3D task_seq_get_next(info->common.ns, &info->tid, false);
+	task =3D task_seq_get_next(&info->common, &info->tid, false);
 	if (!task)
 		return NULL;
=20
@@ -73,7 +105,7 @@ static void *task_seq_next(struct seq_file *seq, void =
*v, loff_t *pos)
 	++*pos;
 	++info->tid;
 	put_task_struct((struct task_struct *)v);
-	task =3D task_seq_get_next(info->common.ns, &info->tid, false);
+	task =3D task_seq_get_next(&info->common, &info->tid, false);
 	if (!task)
 		return NULL;
=20
@@ -117,6 +149,45 @@ static void task_seq_stop(struct seq_file *seq, void=
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
+	if ((!!linfo->task.tid + !!linfo->task.pid + !!linfo->task.pid_fd) > 1)
+		return -EINVAL;
+
+	aux->task.type =3D BPF_TASK_ITER_ALL;
+	if (linfo->task.tid !=3D 0) {
+		aux->task.type =3D BPF_TASK_ITER_TID;
+		aux->task.pid =3D linfo->task.tid;
+	}
+	if (linfo->task.pid !=3D 0) {
+		aux->task.type =3D BPF_TASK_ITER_TGID;
+		aux->task.pid =3D linfo->task.pid;
+	}
+	if (linfo->task.pid_fd !=3D 0) {
+		aux->task.type =3D BPF_TASK_ITER_TGID;
+		ns =3D task_active_pid_ns(current);
+		if (IS_ERR(ns))
+			return PTR_ERR(ns);
+
+		pid =3D pidfd_get_pid(linfo->task.pid_fd, &flags);
+		if (IS_ERR(pid))
+			return PTR_ERR(pid);
+
+		tgid =3D pid_nr_ns(pid, ns);
+		aux->task.pid =3D tgid;
+		put_pid(pid);
+	}
+
+	return 0;
+}
+
 static const struct seq_operations task_seq_ops =3D {
 	.start	=3D task_seq_start,
 	.next	=3D task_seq_next,
@@ -137,8 +208,7 @@ struct bpf_iter_seq_task_file_info {
 static struct file *
 task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info)
 {
-	struct pid_namespace *ns =3D info->common.ns;
-	u32 curr_tid =3D info->tid;
+	u32 saved_tid =3D info->tid;
 	struct task_struct *curr_task;
 	unsigned int curr_fd =3D info->fd;
=20
@@ -151,21 +221,18 @@ task_file_seq_get_next(struct bpf_iter_seq_task_fil=
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
@@ -186,9 +253,15 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file=
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
@@ -269,6 +342,9 @@ static int init_seq_pidns(void *priv_data, struct bpf=
_iter_aux_info *aux)
 	struct bpf_iter_seq_task_common *common =3D priv_data;
=20
 	common->ns =3D get_pid_ns(task_active_pid_ns(current));
+	common->type =3D aux->task.type;
+	common->pid =3D aux->task.pid;
+
 	return 0;
 }
=20
@@ -307,11 +383,10 @@ enum bpf_task_vma_iter_find_op {
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
@@ -371,14 +446,13 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_=
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
@@ -430,9 +504,12 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_i=
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
@@ -533,6 +610,7 @@ static const struct bpf_iter_seq_info task_seq_info =3D=
 {
=20
 static struct bpf_iter_reg task_reg_info =3D {
 	.target			=3D "task",
+	.attach_target		=3D bpf_iter_attach_task,
 	.feature		=3D BPF_ITER_RESCHED,
 	.ctx_arg_info_size	=3D 1,
 	.ctx_arg_info		=3D {
@@ -551,6 +629,7 @@ static const struct bpf_iter_seq_info task_file_seq_i=
nfo =3D {
=20
 static struct bpf_iter_reg task_file_reg_info =3D {
 	.target			=3D "task_file",
+	.attach_target		=3D bpf_iter_attach_task,
 	.feature		=3D BPF_ITER_RESCHED,
 	.ctx_arg_info_size	=3D 2,
 	.ctx_arg_info		=3D {
@@ -571,6 +650,7 @@ static const struct bpf_iter_seq_info task_vma_seq_in=
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
index 5056cef2112f..a54a1455333c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -110,6 +110,12 @@ union bpf_iter_link_info {
 		__u32	cgroup_fd;
 		__u64	cgroup_id;
 	} cgroup;
+	/* Parameters of task iterators. */
+	struct {
+		__u32	tid;
+		__u32	pid;
+		__u32	pid_fd;
+	} task;
 };
=20
 /* BPF syscall commands, see bpf(2) man-page for more details. */
--=20
2.30.2

