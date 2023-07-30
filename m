Return-Path: <bpf+bounces-6355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCBF7685B2
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 15:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513D6281739
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 13:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29B62102;
	Sun, 30 Jul 2023 13:43:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5D520FF
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 13:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7276CC433C7;
	Sun, 30 Jul 2023 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690724579;
	bh=os+fIg9VaPtQcJxkcjnZXUDl3h/oKx1ZdEndq3GKDgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DsoB1Jd2YZ2+7Jw18wXNE7jrKx1bS8OF0pCpIGfLtIuwsv+LA3Q4s6PTFPBqH5wFC
	 KLEeTmHMc/e2quNH9aTXTqH4OKTUghdGnHZ2w5jBftABuTQB4hjW1We6RQU9v/ty9v
	 Sb8A7SYuad1Vj7v5AN/SKjmWO+6jwH7PYOvHqO9TpeLA3BXDMO88KNdANqlTiQz5zd
	 8tJv7KEAbs3IypuF1zvnsxq/DpxqsyeXeJZFN6+WZJJ1lpgw8xJmEQSHucrPx4qmZj
	 igYfCz2EwRlyJImCMd3425JI/DhDB5wsOVndUnFNvGzm/UuJ+1+V3FPtFRJdf4jdJl
	 96Ym4bguav+Qw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCHv5 bpf-next 03/28] bpf: Add multi uprobe link
Date: Sun, 30 Jul 2023 15:41:58 +0200
Message-ID: <20230730134223.94496-4-jolsa@kernel.org>
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

Adding new multi uprobe link that allows to attach bpf program
to multiple uprobes.

Uprobes to attach are specified via new link_create uprobe_multi
union:

  struct {
    __aligned_u64   path;
    __aligned_u64   offsets;
    __aligned_u64   ref_ctr_offsets;
    __u32           cnt;
    __u32           flags;
  } uprobe_multi;

Uprobes are defined for single binary specified in path and multiple
calling sites specified in offsets array with optional reference
counters specified in ref_ctr_offsets array. All specified arrays
have length of 'cnt'.

The 'flags' supports single bit for now that marks the uprobe as
return probe.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/trace_events.h   |   6 +
 include/uapi/linux/bpf.h       |  16 +++
 kernel/bpf/syscall.c           |  14 +-
 kernel/trace/bpf_trace.c       | 237 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  16 +++
 5 files changed, 286 insertions(+), 3 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index e66d04dbe56a..5b85cf18c350 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -752,6 +752,7 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    u32 *fd_type, const char **buf,
 			    u64 *probe_offset, u64 *probe_addr);
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 #else
 static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 {
@@ -798,6 +799,11 @@ bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	return -EOPNOTSUPP;
 }
+static inline int
+bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 enum {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7abb382dc6c1..f112a0b948f3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1039,6 +1039,7 @@ enum bpf_attach_type {
 	BPF_NETFILTER,
 	BPF_TCX_INGRESS,
 	BPF_TCX_EGRESS,
+	BPF_TRACE_UPROBE_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -1057,6 +1058,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_STRUCT_OPS = 9,
 	BPF_LINK_TYPE_NETFILTER = 10,
 	BPF_LINK_TYPE_TCX = 11,
+	BPF_LINK_TYPE_UPROBE_MULTI = 12,
 	MAX_BPF_LINK_TYPE,
 };
 
@@ -1190,6 +1192,13 @@ enum {
 	BPF_F_KPROBE_MULTI_RETURN = (1U << 0)
 };
 
+/* link_create.uprobe_multi.flags used in LINK_CREATE command for
+ * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
+ */
+enum {
+	BPF_F_UPROBE_MULTI_RETURN = (1U << 0)
+};
+
 /* link_create.netfilter.flags used in LINK_CREATE command for
  * BPF_PROG_TYPE_NETFILTER to enable IP packet defragmentation.
  */
@@ -1626,6 +1635,13 @@ union bpf_attr {
 				};
 				__u64		expected_revision;
 			} tcx;
+			struct {
+				__aligned_u64	path;
+				__aligned_u64	offsets;
+				__aligned_u64	ref_ctr_offsets;
+				__u32		cnt;
+				__u32		flags;
+			} uprobe_multi;
 		};
 	} link_create;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7c01186d4078..75c83300339e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2815,10 +2815,12 @@ static void bpf_link_free_id(int id)
 
 /* Clean up bpf_link and corresponding anon_inode file and FD. After
  * anon_inode is created, bpf_link can't be just kfree()'d due to deferred
- * anon_inode's release() call. This helper marksbpf_link as
+ * anon_inode's release() call. This helper marks bpf_link as
  * defunct, releases anon_inode file and puts reserved FD. bpf_prog's refcnt
  * is not decremented, it's the responsibility of a calling code that failed
  * to complete bpf_link initialization.
+ * This helper eventually calls link's dealloc callback, but does not call
+ * link's release callback.
  */
 void bpf_link_cleanup(struct bpf_link_primer *primer)
 {
@@ -3757,8 +3759,12 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 		if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
 		    attach_type != BPF_TRACE_KPROBE_MULTI)
 			return -EINVAL;
+		if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI &&
+		    attach_type != BPF_TRACE_UPROBE_MULTI)
+			return -EINVAL;
 		if (attach_type != BPF_PERF_EVENT &&
-		    attach_type != BPF_TRACE_KPROBE_MULTI)
+		    attach_type != BPF_TRACE_KPROBE_MULTI &&
+		    attach_type != BPF_TRACE_UPROBE_MULTI)
 			return -EINVAL;
 		return 0;
 	case BPF_PROG_TYPE_SCHED_CLS:
@@ -4954,8 +4960,10 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 	case BPF_PROG_TYPE_KPROBE:
 		if (attr->link_create.attach_type == BPF_PERF_EVENT)
 			ret = bpf_perf_link_attach(attr, prog);
-		else
+		else if (attr->link_create.attach_type == BPF_TRACE_KPROBE_MULTI)
 			ret = bpf_kprobe_multi_link_attach(attr, prog);
+		else if (attr->link_create.attach_type == BPF_TRACE_UPROBE_MULTI)
+			ret = bpf_uprobe_multi_link_attach(attr, prog);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index c92eb8c6ff08..10284fd46f98 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -23,6 +23,7 @@
 #include <linux/sort.h>
 #include <linux/key.h>
 #include <linux/verification.h>
+#include <linux/namei.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -2965,3 +2966,239 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 	return 0;
 }
 #endif
+
+#ifdef CONFIG_UPROBES
+struct bpf_uprobe_multi_link;
+
+struct bpf_uprobe {
+	struct bpf_uprobe_multi_link *link;
+	loff_t offset;
+	struct uprobe_consumer consumer;
+};
+
+struct bpf_uprobe_multi_link {
+	struct path path;
+	struct bpf_link link;
+	u32 cnt;
+	struct bpf_uprobe *uprobes;
+};
+
+struct bpf_uprobe_multi_run_ctx {
+	struct bpf_run_ctx run_ctx;
+	unsigned long entry_ip;
+};
+
+static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *uprobes,
+				  u32 cnt)
+{
+	u32 i;
+
+	for (i = 0; i < cnt; i++) {
+		uprobe_unregister(d_real_inode(path->dentry), uprobes[i].offset,
+				  &uprobes[i].consumer);
+	}
+}
+
+static void bpf_uprobe_multi_link_release(struct bpf_link *link)
+{
+	struct bpf_uprobe_multi_link *umulti_link;
+
+	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
+	bpf_uprobe_unregister(&umulti_link->path, umulti_link->uprobes, umulti_link->cnt);
+}
+
+static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
+{
+	struct bpf_uprobe_multi_link *umulti_link;
+
+	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
+	path_put(&umulti_link->path);
+	kvfree(umulti_link->uprobes);
+	kfree(umulti_link);
+}
+
+static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
+	.release = bpf_uprobe_multi_link_release,
+	.dealloc = bpf_uprobe_multi_link_dealloc,
+};
+
+static int uprobe_prog_run(struct bpf_uprobe *uprobe,
+			   unsigned long entry_ip,
+			   struct pt_regs *regs)
+{
+	struct bpf_uprobe_multi_link *link = uprobe->link;
+	struct bpf_uprobe_multi_run_ctx run_ctx = {
+		.entry_ip = entry_ip,
+	};
+	struct bpf_prog *prog = link->link.prog;
+	bool sleepable = prog->aux->sleepable;
+	struct bpf_run_ctx *old_run_ctx;
+	int err = 0;
+
+	might_fault();
+
+	migrate_disable();
+
+	if (sleepable)
+		rcu_read_lock_trace();
+	else
+		rcu_read_lock();
+
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	err = bpf_prog_run(link->link.prog, regs);
+	bpf_reset_run_ctx(old_run_ctx);
+
+	if (sleepable)
+		rcu_read_unlock_trace();
+	else
+		rcu_read_unlock();
+
+	migrate_enable();
+	return err;
+}
+
+static int
+uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs)
+{
+	struct bpf_uprobe *uprobe;
+
+	uprobe = container_of(con, struct bpf_uprobe, consumer);
+	return uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
+}
+
+static int
+uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, struct pt_regs *regs)
+{
+	struct bpf_uprobe *uprobe;
+
+	uprobe = container_of(con, struct bpf_uprobe, consumer);
+	return uprobe_prog_run(uprobe, func, regs);
+}
+
+int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+{
+	struct bpf_uprobe_multi_link *link = NULL;
+	unsigned long __user *uref_ctr_offsets;
+	unsigned long *ref_ctr_offsets = NULL;
+	struct bpf_link_primer link_primer;
+	struct bpf_uprobe *uprobes = NULL;
+	unsigned long __user *uoffsets;
+	void __user *upath;
+	u32 flags, cnt, i;
+	struct path path;
+	char *name;
+	int err;
+
+	/* no support for 32bit archs yet */
+	if (sizeof(u64) != sizeof(void *))
+		return -EOPNOTSUPP;
+
+	if (prog->expected_attach_type != BPF_TRACE_UPROBE_MULTI)
+		return -EINVAL;
+
+	flags = attr->link_create.uprobe_multi.flags;
+	if (flags & ~BPF_F_UPROBE_MULTI_RETURN)
+		return -EINVAL;
+
+	/*
+	 * path, offsets and cnt are mandatory,
+	 * ref_ctr_offsets is optional
+	 */
+	upath = u64_to_user_ptr(attr->link_create.uprobe_multi.path);
+	uoffsets = u64_to_user_ptr(attr->link_create.uprobe_multi.offsets);
+	cnt = attr->link_create.uprobe_multi.cnt;
+
+	if (!upath || !uoffsets || !cnt)
+		return -EINVAL;
+
+	uref_ctr_offsets = u64_to_user_ptr(attr->link_create.uprobe_multi.ref_ctr_offsets);
+
+	name = strndup_user(upath, PATH_MAX);
+	if (IS_ERR(name)) {
+		err = PTR_ERR(name);
+		return err;
+	}
+
+	err = kern_path(name, LOOKUP_FOLLOW, &path);
+	kfree(name);
+	if (err)
+		return err;
+
+	if (!d_is_reg(path.dentry)) {
+		err = -EBADF;
+		goto error_path_put;
+	}
+
+	err = -ENOMEM;
+
+	link = kzalloc(sizeof(*link), GFP_KERNEL);
+	uprobes = kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL);
+
+	if (!uprobes || !link)
+		goto error_free;
+
+	if (uref_ctr_offsets) {
+		ref_ctr_offsets = kvcalloc(cnt, sizeof(*ref_ctr_offsets), GFP_KERNEL);
+		if (!ref_ctr_offsets)
+			goto error_free;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		if (uref_ctr_offsets && __get_user(ref_ctr_offsets[i], uref_ctr_offsets + i)) {
+			err = -EFAULT;
+			goto error_free;
+		}
+		if (__get_user(uprobes[i].offset, uoffsets + i)) {
+			err = -EFAULT;
+			goto error_free;
+		}
+
+		uprobes[i].link = link;
+
+		if (flags & BPF_F_UPROBE_MULTI_RETURN)
+			uprobes[i].consumer.ret_handler = uprobe_multi_link_ret_handler;
+		else
+			uprobes[i].consumer.handler = uprobe_multi_link_handler;
+	}
+
+	link->cnt = cnt;
+	link->uprobes = uprobes;
+	link->path = path;
+
+	bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
+		      &bpf_uprobe_multi_link_lops, prog);
+
+	err = bpf_link_prime(&link->link, &link_primer);
+	if (err)
+		goto error_free;
+
+	for (i = 0; i < cnt; i++) {
+		err = uprobe_register_refctr(d_real_inode(link->path.dentry),
+					     uprobes[i].offset,
+					     ref_ctr_offsets ? ref_ctr_offsets[i] : 0,
+					     &uprobes[i].consumer);
+		if (err) {
+			bpf_uprobe_unregister(&path, uprobes, i);
+			bpf_link_cleanup(&link_primer);
+			kvfree(ref_ctr_offsets);
+			return err;
+		}
+	}
+
+	kvfree(ref_ctr_offsets);
+	return bpf_link_settle(&link_primer);
+
+error_free:
+	kvfree(ref_ctr_offsets);
+	kvfree(uprobes);
+	kfree(link);
+error_path_put:
+	path_put(&path);
+	return err;
+}
+#else /* !CONFIG_UPROBES */
+int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_UPROBES */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7abb382dc6c1..f112a0b948f3 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1039,6 +1039,7 @@ enum bpf_attach_type {
 	BPF_NETFILTER,
 	BPF_TCX_INGRESS,
 	BPF_TCX_EGRESS,
+	BPF_TRACE_UPROBE_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -1057,6 +1058,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_STRUCT_OPS = 9,
 	BPF_LINK_TYPE_NETFILTER = 10,
 	BPF_LINK_TYPE_TCX = 11,
+	BPF_LINK_TYPE_UPROBE_MULTI = 12,
 	MAX_BPF_LINK_TYPE,
 };
 
@@ -1190,6 +1192,13 @@ enum {
 	BPF_F_KPROBE_MULTI_RETURN = (1U << 0)
 };
 
+/* link_create.uprobe_multi.flags used in LINK_CREATE command for
+ * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
+ */
+enum {
+	BPF_F_UPROBE_MULTI_RETURN = (1U << 0)
+};
+
 /* link_create.netfilter.flags used in LINK_CREATE command for
  * BPF_PROG_TYPE_NETFILTER to enable IP packet defragmentation.
  */
@@ -1626,6 +1635,13 @@ union bpf_attr {
 				};
 				__u64		expected_revision;
 			} tcx;
+			struct {
+				__aligned_u64	path;
+				__aligned_u64	offsets;
+				__aligned_u64	ref_ctr_offsets;
+				__u32		cnt;
+				__u32		flags;
+			} uprobe_multi;
 		};
 	} link_create;
 
-- 
2.41.0


