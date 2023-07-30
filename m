Return-Path: <bpf+bounces-6357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C22397685B4
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 15:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29921C209CF
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 13:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBD62102;
	Sun, 30 Jul 2023 13:43:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E713363
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 13:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F749C433C7;
	Sun, 30 Jul 2023 13:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690724599;
	bh=cc6/LJfyIujGDdOPfY68II/+tjL8Y0P4OlTnqBoCOMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SRwdsVVfNafB9xJqK6td0UWKeRZdZ1zymvzLiO5d0CA6y4osmuIcGO5eS7SPnnDSP
	 4criYj1jM3euVK6bkSGX5CvJRghNLnE+AFCoZ0UIT5sMXWEI2gk3SFa0YnSx/0TQkR
	 dQy7nlUpjwti1H2CyAYHnHHOqc7gI/sNIz8CgOUi5yL6Dh6PLh15lMtmG8Zpsv94ok
	 qBkyuG7qOoBp+ppLKQU5aCbYsqUF1J561+QE8Hwglgm0wAq14n3tQtfv9l9erMMYD5
	 IpqB4jj60bDdBVzrsCY/lbs5rfzGhY20KQmvjdfq8D+G5yrkzaaXIZfvEA5UpF03zm
	 c9RNeJlSAeqFQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCHv5 bpf-next 05/28] bpf: Add pid filter support for uprobe_multi link
Date: Sun, 30 Jul 2023 15:42:00 +0200
Message-ID: <20230730134223.94496-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730134223.94496-1-jolsa@kernel.org>
References: <20230730134223.94496-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to specify pid for uprobe_multi link and the uprobes
are created only for task with given pid value.

Using the consumer.filter filter callback for that, so the task gets
filtered during the uprobe installation.

We still need to check the task during runtime in the uprobe handler,
because the handler could get executed if there's another system
wide consumer on the same uprobe (thanks Oleg for the insight).

Cc: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/syscall.c           |  2 +-
 kernel/trace/bpf_trace.c       | 33 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  1 +
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2b6cd7d1c165..558902237338 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1642,6 +1642,7 @@ union bpf_attr {
 				__aligned_u64	cookies;
 				__u32		cnt;
 				__u32		flags;
+				__u32		pid;
 			} uprobe_multi;
 		};
 	} link_create;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 98459fb34ff7..54df18b3fc4e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4883,7 +4883,7 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 	return err;
 }
 
-#define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.flags
+#define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.pid
 static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 {
 	struct bpf_prog *prog;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d73a47bd2bbd..d5f30747378a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2998,6 +2998,7 @@ struct bpf_uprobe_multi_link {
 	struct bpf_link link;
 	u32 cnt;
 	struct bpf_uprobe *uprobes;
+	struct task_struct *task;
 };
 
 struct bpf_uprobe_multi_run_ctx {
@@ -3023,6 +3024,8 @@ static void bpf_uprobe_multi_link_release(struct bpf_link *link)
 
 	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
 	bpf_uprobe_unregister(&umulti_link->path, umulti_link->uprobes, umulti_link->cnt);
+	if (umulti_link->task)
+		put_task_struct(umulti_link->task);
 }
 
 static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
@@ -3054,6 +3057,9 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	struct bpf_run_ctx *old_run_ctx;
 	int err = 0;
 
+	if (link->task && current != link->task)
+		return 0;
+
 	might_fault();
 
 	migrate_disable();
@@ -3076,6 +3082,16 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	return err;
 }
 
+static bool
+uprobe_multi_link_filter(struct uprobe_consumer *con, enum uprobe_filter_ctx ctx,
+			 struct mm_struct *mm)
+{
+	struct bpf_uprobe *uprobe;
+
+	uprobe = container_of(con, struct bpf_uprobe, consumer);
+	return uprobe->link->task->mm == mm;
+}
+
 static int
 uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
 {
@@ -3109,12 +3125,14 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	unsigned long *ref_ctr_offsets = NULL;
 	struct bpf_link_primer link_primer;
 	struct bpf_uprobe *uprobes = NULL;
+	struct task_struct *task = NULL;
 	unsigned long __user *uoffsets;
 	u64 __user *ucookies;
 	void __user *upath;
 	u32 flags, cnt, i;
 	struct path path;
 	char *name;
+	pid_t pid;
 	int err;
 
 	/* no support for 32bit archs yet */
@@ -3158,6 +3176,15 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 		goto error_path_put;
 	}
 
+	pid = attr->link_create.uprobe_multi.pid;
+	if (pid) {
+		rcu_read_lock();
+		task = get_pid_task(find_vpid(pid), PIDTYPE_PID);
+		rcu_read_unlock();
+		if (!task)
+			goto error_path_put;
+	}
+
 	err = -ENOMEM;
 
 	link = kzalloc(sizeof(*link), GFP_KERNEL);
@@ -3192,11 +3219,15 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 			uprobes[i].consumer.ret_handler = uprobe_multi_link_ret_handler;
 		else
 			uprobes[i].consumer.handler = uprobe_multi_link_handler;
+
+		if (pid)
+			uprobes[i].consumer.filter = uprobe_multi_link_filter;
 	}
 
 	link->cnt = cnt;
 	link->uprobes = uprobes;
 	link->path = path;
+	link->task = task;
 
 	bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
 		      &bpf_uprobe_multi_link_lops, prog);
@@ -3225,6 +3256,8 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	kvfree(ref_ctr_offsets);
 	kvfree(uprobes);
 	kfree(link);
+	if (task)
+		put_task_struct(task);
 error_path_put:
 	path_put(&path);
 	return err;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2b6cd7d1c165..558902237338 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1642,6 +1642,7 @@ union bpf_attr {
 				__aligned_u64	cookies;
 				__u32		cnt;
 				__u32		flags;
+				__u32		pid;
 			} uprobe_multi;
 		};
 	} link_create;
-- 
2.41.0


