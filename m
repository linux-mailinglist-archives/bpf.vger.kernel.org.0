Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44BE1C81AD
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 07:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgEGFjo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 01:39:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9346 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726877AbgEGFjk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 01:39:40 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0475aYkv004112
        for <bpf@vger.kernel.org>; Wed, 6 May 2020 22:39:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=V3CtjC2PiB+MBdplFiHNEa954VIjiO9FVy3lu+rilMI=;
 b=Pe2aotZUJk+41ks5BUdH01fgoj39UC3L22vC1yGWlFHvh2VRajlpT5UHHuZ62a9Z+RN6
 2HtTaSPUpZpfZ/792r/DgwGVF26NDYfNpyAdY5kpP7XhDrftRzj6bVms+GGrBIyZlWzN
 WHyX1dulX9RrZxk7fMTbxds3xFejFi/WBeg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30up69eddc-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 May 2020 22:39:39 -0700
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 6 May 2020 22:39:31 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 067403701B99; Wed,  6 May 2020 22:39:27 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     Andrii Nakryiko <andriin@fb.com>, <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v3 11/21] bpf: add task and task/file iterator targets
Date:   Wed, 6 May 2020 22:39:27 -0700
Message-ID: <20200507053927.1543615-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200507053915.1542140-1-yhs@fb.com>
References: <20200507053915.1542140-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_02:2020-05-05,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070043
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Only the tasks belonging to "current" pid namespace
are enumerated.

For task/file target, the bpf program will have access to
  struct task_struct *task
  u32 fd
  struct file *file
where fd/file is an open file for the task.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/Makefile    |   2 +-
 kernel/bpf/task_iter.c | 332 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 333 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/task_iter.c

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index b2b5eefc5254..37b2d8620153 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -2,7 +2,7 @@
 obj-y :=3D core.o
 CFLAGS_core.o +=3D $(call cc-disable-warning, override-init)
=20
-obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o helpers.o tn=
um.o bpf_iter.o map_iter.o
+obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o helpers.o tn=
um.o bpf_iter.o map_iter.o task_iter.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D hashtab.o arraymap.o percpu_freelist.o bp=
f_lru_list.o lpm_trie.o map_in_map.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D local_storage.o queue_stack_maps.o
 obj-$(CONFIG_BPF_SYSCALL) +=3D disasm.o
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
new file mode 100644
index 000000000000..21dd794bf5d9
--- /dev/null
+++ b/kernel/bpf/task_iter.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2020 Facebook */
+
+#include <linux/init.h>
+#include <linux/namei.h>
+#include <linux/pid_namespace.h>
+#include <linux/fs.h>
+#include <linux/fdtable.h>
+#include <linux/filter.h>
+
+struct bpf_iter_seq_task_common {
+	struct pid_namespace *ns;
+};
+
+struct bpf_iter_seq_task_info {
+	/* The first field must be struct bpf_iter_seq_task_common.
+	 * this is assumed by {init, fini}_seq_pidns() callback functions.
+	 */
+	struct bpf_iter_seq_task_common common;
+	u32 tid;
+};
+
+static struct task_struct *task_seq_get_next(struct pid_namespace *ns,
+					     u32 *tid)
+{
+	struct task_struct *task =3D NULL;
+	struct pid *pid;
+
+	rcu_read_lock();
+	pid =3D idr_get_next(&ns->idr, tid);
+	if (pid)
+		task =3D get_pid_task(pid, PIDTYPE_PID);
+	rcu_read_unlock();
+
+	return task;
+}
+
+static void *task_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct bpf_iter_seq_task_info *info =3D seq->private;
+	struct task_struct *task;
+
+	task =3D task_seq_get_next(info->common.ns, &info->tid);
+	if (!task)
+		return NULL;
+
+	++*pos;
+	return task;
+}
+
+static void *task_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct bpf_iter_seq_task_info *info =3D seq->private;
+	struct task_struct *task;
+
+	++*pos;
+	++info->tid;
+	put_task_struct((struct task_struct *)v);
+	task =3D task_seq_get_next(info->common.ns, &info->tid);
+	if (!task)
+		return NULL;
+
+	return task;
+}
+
+struct bpf_iter__task {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct task_struct *, task);
+};
+
+DEFINE_BPF_ITER_FUNC(task, struct bpf_iter_meta *meta, struct task_struc=
t *task)
+
+static int __task_seq_show(struct seq_file *seq, void *v, bool in_stop)
+{
+	struct bpf_iter_meta meta;
+	struct bpf_iter__task ctx;
+	struct bpf_prog *prog;
+
+	meta.seq =3D seq;
+	prog =3D bpf_iter_get_info(&meta, in_stop);
+	if (!prog)
+		return 0;
+
+	meta.seq =3D seq;
+	ctx.meta =3D &meta;
+	ctx.task =3D v;
+	return bpf_iter_run_prog(prog, &ctx);
+}
+
+static int task_seq_show(struct seq_file *seq, void *v)
+{
+	return __task_seq_show(seq, v, false);
+}
+
+static void task_seq_stop(struct seq_file *seq, void *v)
+{
+	if (!v)
+		(void)__task_seq_show(seq, v, true);
+	else
+		put_task_struct((struct task_struct *)v);
+}
+
+static const struct seq_operations task_seq_ops =3D {
+	.start	=3D task_seq_start,
+	.next	=3D task_seq_next,
+	.stop	=3D task_seq_stop,
+	.show	=3D task_seq_show,
+};
+
+struct bpf_iter_seq_task_file_info {
+	/* The first field must be struct bpf_iter_seq_task_common.
+	 * this is assumed by {init, fini}_seq_pidns() callback functions.
+	 */
+	struct bpf_iter_seq_task_common common;
+	struct task_struct *task;
+	struct files_struct *files;
+	u32 tid;
+	u32 fd;
+};
+
+static struct file *task_file_seq_get_next(struct pid_namespace *ns, u32=
 *tid,
+					   int *fd, struct task_struct **task,
+					   struct files_struct **fstruct)
+{
+	struct files_struct *curr_files;
+	struct task_struct *curr_task;
+	u32 curr_tid =3D *tid, max_fds;
+	int curr_fd =3D *fd;
+
+	/* If this function returns a non-NULL file object,
+	 * it held a reference to the task/files_struct/file.
+	 * Otherwise, it does not hold any reference.
+	 */
+again:
+	if (*task) {
+		curr_task =3D *task;
+		curr_files =3D *fstruct;
+		curr_fd =3D *fd;
+	} else {
+		curr_task =3D task_seq_get_next(ns, &curr_tid);
+		if (!curr_task)
+			return NULL;
+
+		curr_files =3D get_files_struct(curr_task);
+		if (!curr_files) {
+			put_task_struct(curr_task);
+			curr_tid =3D ++(*tid);
+			*fd =3D 0;
+			goto again;
+		}
+
+		/* set *fstruct, *task and *tid */
+		*fstruct =3D curr_files;
+		*task =3D curr_task;
+		if (curr_tid =3D=3D *tid) {
+			curr_fd =3D *fd;
+		} else {
+			*tid =3D curr_tid;
+			curr_fd =3D 0;
+		}
+	}
+
+	rcu_read_lock();
+	max_fds =3D files_fdtable(curr_files)->max_fds;
+	for (; curr_fd < max_fds; curr_fd++) {
+		struct file *f;
+
+		f =3D fcheck_files(curr_files, curr_fd);
+		if (!f)
+			continue;
+
+		/* set *fd */
+		*fd =3D curr_fd;
+		get_file(f);
+		rcu_read_unlock();
+		return f;
+	}
+
+	/* the current task is done, go to the next task */
+	rcu_read_unlock();
+	put_files_struct(curr_files);
+	put_task_struct(curr_task);
+	*task =3D NULL;
+	*fstruct =3D NULL;
+	*fd =3D 0;
+	curr_tid =3D ++(*tid);
+	goto again;
+}
+
+static void *task_file_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct bpf_iter_seq_task_file_info *info =3D seq->private;
+	struct files_struct *files =3D NULL;
+	struct task_struct *task =3D NULL;
+	struct file *file;
+
+	file =3D task_file_seq_get_next(info->common.ns, &info->tid, &info->fd,
+				      &task, &files);
+	if (!file) {
+		info->files =3D NULL;
+		info->task =3D NULL;
+		return NULL;
+	}
+
+	++*pos;
+	info->task =3D task;
+	info->files =3D files;
+
+	return file;
+}
+
+static void *task_file_seq_next(struct seq_file *seq, void *v, loff_t *p=
os)
+{
+	struct bpf_iter_seq_task_file_info *info =3D seq->private;
+	struct files_struct *files =3D info->files;
+	struct task_struct *task =3D info->task;
+	struct file *file;
+
+	++*pos;
+	++info->fd;
+	fput((struct file *)v);
+	file =3D task_file_seq_get_next(info->common.ns, &info->tid, &info->fd,
+				      &task, &files);
+	if (!file) {
+		info->files =3D NULL;
+		info->task =3D NULL;
+		return NULL;
+	}
+
+	info->task =3D task;
+	info->files =3D files;
+
+	return file;
+}
+
+struct bpf_iter__task_file {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct task_struct *, task);
+	u32 fd __aligned(8);
+	__bpf_md_ptr(struct file *, file);
+};
+
+DEFINE_BPF_ITER_FUNC(task_file, struct bpf_iter_meta *meta,
+		     struct task_struct *task, u32 fd,
+		     struct file *file)
+
+static int __task_file_seq_show(struct seq_file *seq, void *v, bool in_s=
top)
+{
+	struct bpf_iter_seq_task_file_info *info =3D seq->private;
+	struct bpf_iter__task_file ctx;
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+
+	meta.seq =3D seq;
+	prog =3D bpf_iter_get_info(&meta, in_stop);
+	if (!prog)
+		return 0;
+
+	ctx.meta =3D &meta;
+	ctx.task =3D info->task;
+	ctx.fd =3D info->fd;
+	ctx.file =3D v;
+	return bpf_iter_run_prog(prog, &ctx);
+}
+
+static int task_file_seq_show(struct seq_file *seq, void *v)
+{
+	return __task_file_seq_show(seq, v, false);
+}
+
+static void task_file_seq_stop(struct seq_file *seq, void *v)
+{
+	struct bpf_iter_seq_task_file_info *info =3D seq->private;
+
+	if (!v) {
+		(void)__task_file_seq_show(seq, v, true);
+	} else {
+		fput((struct file *)v);
+		put_files_struct(info->files);
+		put_task_struct(info->task);
+		info->files =3D NULL;
+		info->task =3D NULL;
+	}
+}
+
+static int init_seq_pidns(void *priv_data)
+{
+	struct bpf_iter_seq_task_common *common =3D priv_data;
+
+	common->ns =3D get_pid_ns(task_active_pid_ns(current));
+	return 0;
+}
+
+static void fini_seq_pidns(void *priv_data)
+{
+	struct bpf_iter_seq_task_common *common =3D priv_data;
+
+	put_pid_ns(common->ns);
+}
+
+static const struct seq_operations task_file_seq_ops =3D {
+	.start	=3D task_file_seq_start,
+	.next	=3D task_file_seq_next,
+	.stop	=3D task_file_seq_stop,
+	.show	=3D task_file_seq_show,
+};
+
+static int __init task_iter_init(void)
+{
+	struct bpf_iter_reg task_file_reg_info =3D {
+		.target			=3D "task_file",
+		.seq_ops		=3D &task_file_seq_ops,
+		.init_seq_private	=3D init_seq_pidns,
+		.fini_seq_private	=3D fini_seq_pidns,
+		.seq_priv_size		=3D sizeof(struct bpf_iter_seq_task_file_info),
+	};
+	struct bpf_iter_reg task_reg_info =3D {
+		.target			=3D "task",
+		.seq_ops		=3D &task_seq_ops,
+		.init_seq_private	=3D init_seq_pidns,
+		.fini_seq_private	=3D fini_seq_pidns,
+		.seq_priv_size		=3D sizeof(struct bpf_iter_seq_task_info),
+	};
+	int ret;
+
+	ret =3D bpf_iter_reg_target(&task_reg_info);
+	if (ret)
+		return ret;
+
+	return bpf_iter_reg_target(&task_file_reg_info);
+}
+late_initcall(task_iter_init);
--=20
2.24.1

