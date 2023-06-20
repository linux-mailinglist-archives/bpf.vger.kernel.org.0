Return-Path: <bpf+bounces-2883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2AD73665A
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09832280FA8
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF22AD37;
	Tue, 20 Jun 2023 08:36:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DED4400
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E10C433C0;
	Tue, 20 Jun 2023 08:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250184;
	bh=XPt4D40Gg/8SfYdRvptF6aJm7+mRLT92BufL7JpLUzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bymWWX3fOq2hzRRS9rQF0PxmIAYf9YeJkk/EfU/CiCRdkVV7pQKf7XUfhkmM7bpdE
	 o+4xY+zSV02l37u+nYESF8JaVk5eEynfkTDA/KuRjlNub7gf94f3ruTe1WgO4G5/p7
	 bo0DUy/+ic03MO20qq06u5TFYlIIcV3f5JuH1y4BphJtOsdE4/zJdgK/ezgP+te3KF
	 eMR2t5SQaHlcNQw5tL6fzKoEtDcsMbm8DbsqG+c753JJ4LOXdq9468SJTh+eGjiwIm
	 9u7u0b+PW4YKe4SoCWmUKL+MiCGiZUmH9lvGP60gBr2j7XSw0tdC7Ua0qjOV8+rbZT
	 L7S1Fuhfn/zZA==
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
	Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf-next 03/24] bpf: Add pid filter support for uprobe_multi link
Date: Tue, 20 Jun 2023 10:35:29 +0200
Message-ID: <20230620083550.690426-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620083550.690426-1-jolsa@kernel.org>
References: <20230620083550.690426-1-jolsa@kernel.org>
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
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/syscall.c           |  2 +-
 kernel/trace/bpf_trace.c       | 33 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  1 +
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 12d4174fce8f..117acca838f1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1592,6 +1592,7 @@ union bpf_attr {
 				__aligned_u64	offsets;
 				__aligned_u64	ref_ctr_offsets;
 				__aligned_u64	cookies;
+				__u32		pid;
 			} uprobe_multi;
 		};
 	} link_create;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3ae444898c15..b871f0eb8a05 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4651,7 +4651,7 @@ static int bpf_map_do_batch(const union bpf_attr *attr,
 	return err;
 }
 
-#define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.cookies
+#define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.pid
 static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 {
 	enum bpf_prog_type ptype;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f9cd7d283426..5c5b543d7d03 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2945,6 +2945,7 @@ struct bpf_uprobe_multi_link {
 	struct bpf_link link;
 	u32 cnt;
 	struct bpf_uprobe *uprobes;
+	struct task_struct *task;
 };
 
 struct bpf_uprobe_multi_run_ctx {
@@ -2971,6 +2972,8 @@ static void bpf_uprobe_multi_link_release(struct bpf_link *link)
 	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
 	bpf_uprobe_unregister(&umulti_link->path, umulti_link->uprobes, umulti_link->cnt);
 	path_put(&umulti_link->path);
+	if (umulti_link->task)
+		put_task_struct(umulti_link->task);
 }
 
 static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
@@ -3000,6 +3003,9 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
 	struct bpf_run_ctx *old_run_ctx;
 	int err = 0;
 
+	if (link->task && current != link->task)
+		return 0;
+
 	might_fault();
 
 	rcu_read_lock_trace();
@@ -3027,6 +3033,16 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
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
@@ -3064,10 +3080,12 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	struct bpf_link_primer link_primer;
 	struct bpf_uprobe *uprobes = NULL;
 	u64 __user *ucookies, cookie = 0;
+	struct task_struct *task = NULL;
 	void __user *upath;
 	u32 flags, cnt, i;
 	struct path path;
 	char *name;
+	pid_t pid;
 	int err;
 
 	/* no support for 32bit archs yet */
@@ -3110,6 +3128,15 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
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
@@ -3143,11 +3170,15 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 			uprobes[i].consumer.handler = uprobe_multi_link_handler;
 
 		ref_ctr_offsets[i] = ref_ctr_offset;
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
@@ -3175,6 +3206,8 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	kvfree(ref_ctr_offsets);
 	kvfree(uprobes);
 	kfree(link);
+	if (task)
+		put_task_struct(task);
 error_path_put:
 	path_put(&path);
 	return err;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 12d4174fce8f..117acca838f1 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1592,6 +1592,7 @@ union bpf_attr {
 				__aligned_u64	offsets;
 				__aligned_u64	ref_ctr_offsets;
 				__aligned_u64	cookies;
+				__u32		pid;
 			} uprobe_multi;
 		};
 	} link_create;
-- 
2.41.0


