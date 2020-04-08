Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 585051A2C46
	for <lists+bpf@lfdr.de>; Thu,  9 Apr 2020 01:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDHXZ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Apr 2020 19:25:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18950 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726701AbgDHXZ4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Apr 2020 19:25:56 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 038NPjHm019373
        for <bpf@vger.kernel.org>; Wed, 8 Apr 2020 16:25:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=IE8OUiiL1n8YlRo6yHL7j6Jpoa+aB3JApvQTMY81bIY=;
 b=rLRRg8kFso5wMIzmg6lNNPH2FGnUmU0j5oxVfqabofw5wcnx4XBienCJeAcejc1H5DKO
 mBbmmljfgUoSNz7c6o6+SxAYE7iEe5nebMOGiMVeeRCjFyxCeaMCQm2jC1tLLv8m4ycJ
 NyhdWpiGtb9ukaqpqN42hdQP6TqoyVNa2gs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3091m37bp8-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2020 16:25:55 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 8 Apr 2020 16:25:35 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id EB9D83700D98; Wed,  8 Apr 2020 16:25:29 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     Andrii Nakryiko <andriin@fb.com>, <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [RFC PATCH bpf-next 08/16] bpf: add task and task/file targets
Date:   Wed, 8 Apr 2020 16:25:29 -0700
Message-ID: <20200408232529.2676060-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200408232520.2675265-1-yhs@fb.com>
References: <20200408232520.2675265-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-08_09:2020-04-07,2020-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004080164
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
 kernel/bpf/dump_task.c | 294 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/dump_task.c

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 4a1376ab2bea..7e2c73deabab 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D reuseport_array.o
 endif
 ifeq ($(CONFIG_SYSFS),y)
 obj-$(CONFIG_DEBUG_INFO_BTF) +=3D sysfs_btf.o
-obj-$(CONFIG_BPF_SYSCALL) +=3D dump.o
+obj-$(CONFIG_BPF_SYSCALL) +=3D dump.o dump_task.o
 endif
 ifeq ($(CONFIG_BPF_JIT),y)
 obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_struct_ops.o
diff --git a/kernel/bpf/dump_task.c b/kernel/bpf/dump_task.c
new file mode 100644
index 000000000000..69b0bcec68e9
--- /dev/null
+++ b/kernel/bpf/dump_task.c
@@ -0,0 +1,294 @@
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
+struct bpfdump_seq_task_info {
+	struct pid_namespace *ns;
+	struct task_struct *task;
+	u32 id;
+};
+
+static struct task_struct *task_seq_get_next(struct pid_namespace *ns, u=
32 *id)
+{
+	struct task_struct *task;
+	struct pid *pid;
+
+	rcu_read_lock();
+	pid =3D idr_get_next(&ns->idr, id);
+	task =3D get_pid_task(pid, PIDTYPE_PID);
+	if (task)
+		get_task_struct(task);
+	rcu_read_unlock();
+
+	return task;
+}
+
+static void *task_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct bpfdump_seq_task_info *info =3D seq->private;
+	struct task_struct *task;
+	u32 id =3D info->id + 1;
+
+	if (*pos =3D=3D 0)
+		info->ns =3D task_active_pid_ns(current);
+
+	task =3D task_seq_get_next(info->ns, &id);
+	if (!task)
+		return NULL;
+
+	++*pos;
+	info->task =3D task;
+	info->id =3D id;
+
+	return task;
+}
+
+static void *task_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct bpfdump_seq_task_info *info =3D seq->private;
+	struct task_struct *task;
+	u32 id =3D info->id + 1;
+
+	++*pos;
+	task =3D task_seq_get_next(info->ns, &id);
+	if (!task)
+		return NULL;
+
+	put_task_struct(info->task);
+	info->task =3D task;
+	info->id =3D id;
+	return task;
+}
+
+static void task_seq_stop(struct seq_file *seq, void *v)
+{
+	struct bpfdump_seq_task_info *info =3D seq->private;
+
+	if (info->task) {
+		put_task_struct(info->task);
+		info->task =3D NULL;
+	}
+}
+
+static int task_seq_show(struct seq_file *seq, void *v)
+{
+	struct {
+		struct task_struct *task;
+		struct seq_file *seq;
+		u64 seq_num;
+	} ctx =3D {
+		.task =3D v,
+		.seq =3D seq,
+	};
+	struct bpf_prog *prog;
+	int ret;
+
+	prog =3D bpf_dump_get_prog(seq, sizeof(struct bpfdump_seq_task_info),
+				 &ctx.seq_num);
+	ret =3D bpf_dump_run_prog(prog, &ctx);
+
+	return ret =3D=3D 0 ? 0 : -EINVAL;
+}
+
+static const struct seq_operations task_seq_ops =3D {
+        .start  =3D task_seq_start,
+        .next   =3D task_seq_next,
+        .stop   =3D task_seq_stop,
+        .show   =3D task_seq_show,
+};
+
+struct bpfdump_seq_task_file_info {
+	struct pid_namespace *ns;
+	struct task_struct *task;
+	struct files_struct *files;
+	u32 id;
+	u32 fd;
+};
+
+static struct file *task_file_seq_get_next(struct pid_namespace *ns, u32=
 *id,
+					   int *fd, struct task_struct **task,
+					   struct files_struct **fstruct)
+{
+	struct files_struct *files;
+	struct task_struct *tk;
+	u32 sid =3D *id;
+	int sfd;
+
+	/* If this function returns a non-NULL file object,
+	 * it held a reference to the files_struct and file.
+	 * Otherwise, it does not hold any reference.
+	 */
+again:
+	if (*fstruct) {
+		files =3D *fstruct;
+		sfd =3D *fd;
+	} else {
+		tk =3D task_seq_get_next(ns, &sid);
+		if (!tk)
+			return NULL;
+		files =3D get_files_struct(tk);
+		put_task_struct(tk);
+		if (!files)
+			return NULL;
+		*fstruct =3D files;
+		*task =3D tk;
+		if (sid =3D=3D *id) {
+			sfd =3D *fd;
+		} else {
+			*id =3D sid;
+			sfd =3D 0;
+		}
+	}
+
+	spin_lock(&files->file_lock);
+	for (; sfd < files_fdtable(files)->max_fds; sfd++) {
+		struct file *f;
+
+		f =3D fcheck_files(files, sfd);
+		if (!f)
+			continue;
+
+		*fd =3D sfd;
+		get_file(f);
+		spin_unlock(&files->file_lock);
+		return f;
+	}
+
+	/* the current task is done, go to the next task */
+	spin_unlock(&files->file_lock);
+	put_files_struct(files);
+	*fstruct =3D NULL;
+	sid =3D ++(*id);
+	goto again;
+}
+
+static void *task_file_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct bpfdump_seq_task_file_info *info =3D seq->private;
+	struct files_struct *files =3D NULL;
+	struct task_struct *task =3D NULL;
+	struct file *file;
+	u32 id =3D info->id;
+	int fd =3D info->fd + 1;
+
+	if (*pos =3D=3D 0)
+		info->ns =3D task_active_pid_ns(current);
+
+	file =3D task_file_seq_get_next(info->ns, &id, &fd, &task, &files);
+	if (!file) {
+		info->files =3D NULL;
+		return NULL;
+	}
+
+	++*pos;
+	info->id =3D id;
+	info->fd =3D fd;
+	info->task =3D task;
+	info->files =3D files;
+
+	return file;
+}
+
+static void *task_file_seq_next(struct seq_file *seq, void *v, loff_t *p=
os)
+{
+	struct bpfdump_seq_task_file_info *info =3D seq->private;
+	struct files_struct *files =3D info->files;
+	struct task_struct *task =3D info->task;
+	int fd =3D info->fd + 1;
+	struct file *file;
+	u32 id =3D info->id;
+
+	++*pos;
+	fput((struct file *)v);
+	file =3D task_file_seq_get_next(info->ns, &id, &fd, &task, &files);
+	if (!file) {
+		info->files =3D NULL;
+		return NULL;
+	}
+
+	info->id =3D id;
+	info->fd =3D fd;
+	info->task =3D task;
+	info->files =3D files;
+
+	return file;
+}
+
+static void task_file_seq_stop(struct seq_file *seq, void *v)
+{
+	struct bpfdump_seq_task_file_info *info =3D seq->private;
+
+	if (v)
+		fput((struct file *)v);
+	if (info->files) {
+		put_files_struct(info->files);
+		info->files =3D NULL;
+	}
+}
+
+static int task_file_seq_show(struct seq_file *seq, void *v)
+{
+	struct bpfdump_seq_task_file_info *info =3D seq->private;
+	struct {
+		struct task_struct *task;
+		u32 fd;
+		struct file *file;
+		struct seq_file *seq;
+		u64 seq_num;
+	} ctx =3D {
+		.file =3D v,
+		.seq =3D seq,
+	};
+	struct bpf_prog *prog;
+	int ret;
+
+	prog =3D bpf_dump_get_prog(seq, sizeof(struct bpfdump_seq_task_file_inf=
o),
+				 &ctx.seq_num);
+	ctx.task =3D info->task;
+	ctx.fd =3D info->fd;
+	ret =3D bpf_dump_run_prog(prog, &ctx);
+
+	return ret =3D=3D 0 ? 0 : -EINVAL;
+}
+
+static const struct seq_operations task_file_seq_ops =3D {
+        .start  =3D task_file_seq_start,
+        .next   =3D task_file_seq_next,
+        .stop   =3D task_file_seq_stop,
+        .show   =3D task_file_seq_show,
+};
+
+int __init bpfdump__task(struct task_struct *task, struct seq_file *seq,
+			 u64 seq_num) {
+	return 0;
+}
+
+int __init bpfdump__task_file(struct task_struct *task, u32 fd,
+			      struct file *file, struct seq_file *seq,
+			      u64 seq_num)
+{
+	return 0;
+}
+
+static int __init task_dump_init(void)
+{
+	int ret;
+
+	ret =3D bpf_dump_reg_target("task", "bpfdump__task",
+				  &task_seq_ops,
+				  sizeof(struct bpfdump_seq_task_info), 0);
+	if (ret)
+		return ret;
+
+	return bpf_dump_reg_target("task/file", "bpfdump__task_file",
+				   &task_file_seq_ops,
+				   sizeof(struct bpfdump_seq_task_file_info),
+				   0);
+}
+late_initcall(task_dump_init);
--=20
2.24.1

