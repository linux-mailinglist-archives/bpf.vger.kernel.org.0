Return-Path: <bpf+bounces-2881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71675736658
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2850B2811A5
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1D3BE62;
	Tue, 20 Jun 2023 08:36:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2210EAD48
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F55C433C8;
	Tue, 20 Jun 2023 08:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687250164;
	bh=8o3UKWpW7XacEVg3k9OJXjCKgmWSwdm9wEffUSUaOls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HOJRCdskDkc5NE1vDw2FNOpyb/Zx3gtzwFUvbpBgizhBrvzo3OwKUdbgCIsQOwgR0
	 ZXwegQjURsyOaGzjC83oHgKwnlUM4WzIqFB6bL/KdoINQZhOzkcR7RZOLafL+wHrRm
	 9m+8FFHv5xGtNnT6yMp4BHdoLBK3p109QmxsuI7uQwh8gp5fD26LcKeZx/sPNgRnOJ
	 mwCMMXHBQv3v7D2jb7B0/5fD5lD8uMCKcHmOLorCgCXewogMFsKkIJs+Cu1J0E0OE0
	 kXG/DIWTkngyCqrkyzQ0F/cxqklPe1/MyoMNMAy9mUsPCv9C04n5q36RGnuX5uKxno
	 qtHtgb7W7JkNw==
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
	Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf-next 01/24] bpf: Add multi uprobe link
Date: Tue, 20 Jun 2023 10:35:27 +0200
Message-ID: <20230620083550.690426-2-jolsa@kernel.org>
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

Adding new multi uprobe link that allows to attach bpf program
to multiple uprobes.

Uprobes to attach are specified via new link_create uprobe_multi
union:

  struct {
          __u32           flags;
          __u32           cnt;
          __aligned_u64   path;
          __aligned_u64   offsets;
          __aligned_u64   ref_ctr_offsets;
  } uprobe_multi;

Uprobes are defined for single binary specified in path and multiple
calling sites specified in offsets array with optional reference
counters specified in ref_ctr_offsets array. All specified arrays
have length of 'cnt'.

The 'flags' supports single bit for now that marks the uprobe as
return probe.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/trace_events.h   |   6 +
 include/uapi/linux/bpf.h       |  14 ++
 kernel/bpf/syscall.c           |  12 +-
 kernel/trace/bpf_trace.c       | 237 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  14 ++
 5 files changed, 281 insertions(+), 2 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 0e373222a6df..b0db245fc0f5 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -749,6 +749,7 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    u32 *fd_type, const char **buf,
 			    u64 *probe_offset, u64 *probe_addr);
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
+int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 #else
 static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 {
@@ -795,6 +796,11 @@ bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
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
index a7b5e91dd768..bfbc1246b220 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1035,6 +1035,7 @@ enum bpf_attach_type {
 	BPF_TRACE_KPROBE_MULTI,
 	BPF_LSM_CGROUP,
 	BPF_STRUCT_OPS,
+	BPF_TRACE_UPROBE_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -1052,6 +1053,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_KPROBE_MULTI = 8,
 	BPF_LINK_TYPE_STRUCT_OPS = 9,
 	BPF_LINK_TYPE_NETFILTER = 10,
+	BPF_LINK_TYPE_UPROBE_MULTI = 11,
 
 	MAX_BPF_LINK_TYPE,
 };
@@ -1169,6 +1171,11 @@ enum bpf_link_type {
  */
 #define BPF_F_KPROBE_MULTI_RETURN	(1U << 0)
 
+/* link_create.uprobe_multi.flags used in LINK_CREATE command for
+ * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
+ */
+#define BPF_F_UPROBE_MULTI_RETURN	(1U << 0)
+
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
  * the following extensions:
  *
@@ -1578,6 +1585,13 @@ union bpf_attr {
 				__s32		priority;
 				__u32		flags;
 			} netfilter;
+			struct {
+				__u32		flags;
+				__u32		cnt;
+				__aligned_u64	path;
+				__aligned_u64	offsets;
+				__aligned_u64	ref_ctr_offsets;
+			} uprobe_multi;
 		};
 	} link_create;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a75c54b6f8a3..a96e46cd407e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3516,6 +3516,11 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 		return prog->enforce_expected_attach_type &&
 			prog->expected_attach_type != attach_type ?
 			-EINVAL : 0;
+	case BPF_PROG_TYPE_KPROBE:
+		if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
+		    attach_type != BPF_TRACE_KPROBE_MULTI)
+			return -EINVAL;
+		fallthrough;
 	default:
 		return 0;
 	}
@@ -4681,7 +4686,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 		break;
 	case BPF_PROG_TYPE_KPROBE:
 		if (attr->link_create.attach_type != BPF_PERF_EVENT &&
-		    attr->link_create.attach_type != BPF_TRACE_KPROBE_MULTI) {
+		    attr->link_create.attach_type != BPF_TRACE_KPROBE_MULTI &&
+		    attr->link_create.attach_type != BPF_TRACE_UPROBE_MULTI) {
 			ret = -EINVAL;
 			goto out;
 		}
@@ -4748,8 +4754,10 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
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
index 2bc41e6ac9fe..806ea9fd210d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -23,6 +23,7 @@
 #include <linux/sort.h>
 #include <linux/key.h>
 #include <linux/verification.h>
+#include <linux/namei.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -2912,3 +2913,239 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
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
+	path_put(&umulti_link->path);
+}
+
+static void bpf_uprobe_multi_link_dealloc(struct bpf_link *link)
+{
+	struct bpf_uprobe_multi_link *umulti_link;
+
+	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
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
+	struct bpf_run_ctx *old_run_ctx;
+	int err = 0;
+
+	might_fault();
+
+	rcu_read_lock_trace();
+	migrate_disable();
+
+	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
+		goto out;
+
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+
+	if (!prog->aux->sleepable)
+		rcu_read_lock();
+
+	err = bpf_prog_run(link->link.prog, regs);
+
+	if (!prog->aux->sleepable)
+		rcu_read_unlock();
+
+	bpf_reset_run_ctx(old_run_ctx);
+
+out:
+	__this_cpu_dec(bpf_prog_active);
+	migrate_enable();
+	rcu_read_unlock_trace();
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
+	unsigned long __user *uref_ctr_offsets, ref_ctr_offset = 0;
+	struct bpf_uprobe_multi_link *link = NULL;
+	unsigned long __user *uoffsets, offset;
+	unsigned long *ref_ctr_offsets = NULL;
+	struct bpf_link_primer link_primer;
+	struct bpf_uprobe *uprobes = NULL;
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
+		err = -EINVAL;
+		goto error_path_put;
+	}
+
+	err = -ENOMEM;
+
+	link = kzalloc(sizeof(*link), GFP_KERNEL);
+	uprobes = kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL);
+	ref_ctr_offsets = kvcalloc(cnt, sizeof(*ref_ctr_offsets), GFP_KERNEL);
+
+	if (!uprobes || !ref_ctr_offsets || !link)
+		goto error_free;
+
+	for (i = 0; i < cnt; i++) {
+		if (uref_ctr_offsets && __get_user(ref_ctr_offset, uref_ctr_offsets + i)) {
+			err = -EFAULT;
+			goto error_free;
+		}
+		if (__get_user(offset, uoffsets + i)) {
+			err = -EFAULT;
+			goto error_free;
+		}
+
+		uprobes[i].offset = offset;
+		uprobes[i].link = link;
+
+		if (flags & BPF_F_UPROBE_MULTI_RETURN)
+			uprobes[i].consumer.ret_handler = uprobe_multi_link_ret_handler;
+		else
+			uprobes[i].consumer.handler = uprobe_multi_link_handler;
+
+		ref_ctr_offsets[i] = ref_ctr_offset;
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
+					     uprobes[i].offset, ref_ctr_offsets[i],
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
index a7b5e91dd768..bfbc1246b220 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1035,6 +1035,7 @@ enum bpf_attach_type {
 	BPF_TRACE_KPROBE_MULTI,
 	BPF_LSM_CGROUP,
 	BPF_STRUCT_OPS,
+	BPF_TRACE_UPROBE_MULTI,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -1052,6 +1053,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_KPROBE_MULTI = 8,
 	BPF_LINK_TYPE_STRUCT_OPS = 9,
 	BPF_LINK_TYPE_NETFILTER = 10,
+	BPF_LINK_TYPE_UPROBE_MULTI = 11,
 
 	MAX_BPF_LINK_TYPE,
 };
@@ -1169,6 +1171,11 @@ enum bpf_link_type {
  */
 #define BPF_F_KPROBE_MULTI_RETURN	(1U << 0)
 
+/* link_create.uprobe_multi.flags used in LINK_CREATE command for
+ * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
+ */
+#define BPF_F_UPROBE_MULTI_RETURN	(1U << 0)
+
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
  * the following extensions:
  *
@@ -1578,6 +1585,13 @@ union bpf_attr {
 				__s32		priority;
 				__u32		flags;
 			} netfilter;
+			struct {
+				__u32		flags;
+				__u32		cnt;
+				__aligned_u64	path;
+				__aligned_u64	offsets;
+				__aligned_u64	ref_ctr_offsets;
+			} uprobe_multi;
 		};
 	} link_create;
 
-- 
2.41.0


