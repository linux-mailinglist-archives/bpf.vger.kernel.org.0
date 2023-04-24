Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1156ED1F5
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjDXQFG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjDXQFF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:05:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F7C5FE4
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:05:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08423619FC
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 16:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8CDC433D2;
        Mon, 24 Apr 2023 16:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682352302;
        bh=Wpl2V0t7OSZNPoVz9hs1eafvBjE4FFr5lf6tX8CPPrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NpOSgmQkOOI8wgQQeejPrym/cwaNDv/RwwydusJIDrnQ/jQQoyUpw8Tld9zxiOXZ+
         T8fKul7EqRwnqLPXrFrh1mDFvWW3eAT0fAu9wmfmkdkp9EHTkhveg3UVFoyUt8IfJR
         w6s/G8Uc02Izpycmw3hzwa+l1HKW6s3XSS1dTFQrH67VvhjuIi92tv23rlqeNu14CO
         00iy5MrztV6UR9TrREUGEqta3LE1YUwKyh2N02JLM7663ASoX7XIovxekBnDOHBISO
         g4v5oun91u7w9AvTP7roKKcPcdu5c9TiKeIH6CSCyVqEqdPtVNxF1/Y1iX1EOG/WXU
         vu8PGg7oR+j+w==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC/PATCH bpf-next 01/20] bpf: Add multi uprobe link
Date:   Mon, 24 Apr 2023 18:04:28 +0200
Message-Id: <20230424160447.2005755-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424160447.2005755-1-jolsa@kernel.org>
References: <20230424160447.2005755-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding new multi uprobe link that allows to attach bpf program
to multiple uprobes.

Uprobes to attach are specified via new link_create uprobe_multi
union:

  struct {
          __u32           flags;
          __u32           cnt;
          __aligned_u64   paths;
          __aligned_u64   offsets;
          __aligned_u64   ref_ctr_offsets;
  } uprobe_multi;

Uprobes are defined in paths/offsets/ref_ctr_offsets arrays with
the same 'cnt' length. Each uprobe is defined with a single index
in all three arrays:

  paths[idx], offsets[idx] and/or ref_ctr_offsets[idx]

The 'flags' supports single bit for now that marks the uprobe as
return probe.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/trace_events.h |   6 +
 include/uapi/linux/bpf.h     |  14 +++
 kernel/bpf/syscall.c         |  16 ++-
 kernel/trace/bpf_trace.c     | 231 +++++++++++++++++++++++++++++++++++
 4 files changed, 265 insertions(+), 2 deletions(-)

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
index 1bb11a6ee667..debc041c6ca5 100644
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
@@ -1568,6 +1575,13 @@ union bpf_attr {
 				__s32		priority;
 				__u32		flags;
 			} netfilter;
+			struct {
+				__u32		flags;
+				__u32		cnt;
+				__aligned_u64	paths;
+				__aligned_u64	offsets;
+				__aligned_u64	ref_ctr_offsets;
+			} uprobe_multi;
 		};
 	} link_create;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 14f39c1e573e..0b789a33317b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4601,7 +4601,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 		break;
 	case BPF_PROG_TYPE_KPROBE:
 		if (attr->link_create.attach_type != BPF_PERF_EVENT &&
-		    attr->link_create.attach_type != BPF_TRACE_KPROBE_MULTI) {
+		    attr->link_create.attach_type != BPF_TRACE_KPROBE_MULTI &&
+		    attr->link_create.attach_type != BPF_TRACE_UPROBE_MULTI) {
 			ret = -EINVAL;
 			goto out;
 		}
@@ -4666,10 +4667,21 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 		ret = bpf_perf_link_attach(attr, prog);
 		break;
 	case BPF_PROG_TYPE_KPROBE:
+		/* Ensure that program with eBPF_TRACE_UPROBE_MULTI attach type can
+		 * attach only to uprobe_multi link. It has its own runtime context
+		 * which is specific for get_func_ip/get_attach_cookie helpers.
+		 */
+		if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI &&
+		    attr->link_create.attach_type != BPF_TRACE_UPROBE_MULTI) {
+			ret = -EINVAL;
+			goto out;
+		}
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
index bcf91bc7bf71..b84a7d01abf4 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -23,6 +23,7 @@
 #include <linux/sort.h>
 #include <linux/key.h>
 #include <linux/verification.h>
+#include <linux/namei.h>
 
 #include <net/bpf_sk_storage.h>
 
@@ -2901,3 +2902,233 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 	return 0;
 }
 #endif
+
+#ifdef CONFIG_UPROBES
+struct bpf_uprobe_multi_link;
+
+struct bpf_uprobe {
+	struct bpf_uprobe_multi_link *link;
+	struct inode *inode;
+	loff_t offset;
+	loff_t ref_ctr_offset;
+	struct uprobe_consumer consumer;
+};
+
+struct bpf_uprobe_multi_link {
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
+static void bpf_uprobe_unregister(struct bpf_uprobe *uprobes, u32 cnt)
+{
+	u32 i;
+
+	for (i = 0; i < cnt; i++) {
+		uprobe_unregister(uprobes[i].inode, uprobes[i].offset,
+				  &uprobes[i].consumer);
+	}
+}
+
+static void bpf_uprobe_multi_link_release(struct bpf_link *link)
+{
+	struct bpf_uprobe_multi_link *umulti_link;
+
+	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
+	bpf_uprobe_unregister(umulti_link->uprobes, umulti_link->cnt);
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
+	struct bpf_run_ctx *old_run_ctx;
+	int err;
+
+	preempt_disable();
+
+	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
+		err = 0;
+		goto out;
+	}
+
+	rcu_read_lock();
+	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
+	err = bpf_prog_run(link->link.prog, regs);
+	bpf_reset_run_ctx(old_run_ctx);
+	rcu_read_unlock();
+
+ out:
+	__this_cpu_dec(bpf_prog_active);
+	preempt_enable();
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
+	void __user **upaths, __user *upath, __user *old_upath = NULL;
+	unsigned long __user *uref_ctr_offsets, ref_ctr_offset = 0;
+	struct bpf_uprobe_multi_link *link = NULL;
+	unsigned long __user *uoffsets, offset;
+	struct bpf_link_primer link_primer;
+	struct bpf_uprobe *uprobes = NULL;
+	struct inode *inode, *old_inode;
+	u32 flags, cnt, i;
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
+	upaths = u64_to_user_ptr(attr->link_create.uprobe_multi.paths);
+	uoffsets = u64_to_user_ptr(attr->link_create.uprobe_multi.offsets);
+	if (!!upaths != !!uoffsets)
+		return -EINVAL;
+
+	uref_ctr_offsets = u64_to_user_ptr(attr->link_create.uprobe_multi.ref_ctr_offsets);
+
+	cnt = attr->link_create.uprobe_multi.cnt;
+	if (!cnt)
+		return -EINVAL;
+
+	uprobes = kvcalloc(cnt, sizeof(*uprobes), GFP_KERNEL);
+	if (!uprobes)
+		return -ENOMEM;
+
+	link = kzalloc(sizeof(*link), GFP_KERNEL);
+	if (!link) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		if (uref_ctr_offsets && __get_user(ref_ctr_offset, uref_ctr_offsets + i)) {
+			err = -EFAULT;
+			goto error;
+		}
+		if (__get_user(offset, uoffsets + i)) {
+			err = -EFAULT;
+			goto error;
+		}
+		if (__get_user(upath, upaths + i)) {
+			err = -EFAULT;
+			goto error;
+		}
+		if (i && old_upath == upath) {
+			inode = old_inode;
+		} else {
+			struct path path;
+			char *name;
+
+			name = strndup_user(upath, PATH_MAX);
+			if (IS_ERR(name)) {
+				err = PTR_ERR(name);
+				goto error;
+			}
+			err = kern_path(name, LOOKUP_FOLLOW, &path);
+			kfree(name);
+			if (err)
+				goto error;
+			if (!d_is_reg(path.dentry)) {
+				err = -EINVAL;
+				path_put(&path);
+				goto error;
+			}
+			inode = d_real_inode(path.dentry);
+			path_put(&path);
+		}
+		old_upath = upath;
+
+		uprobes[i].inode = inode;
+		uprobes[i].offset = offset;
+		uprobes[i].ref_ctr_offset = ref_ctr_offset;
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
+
+	bpf_link_init(&link->link, BPF_LINK_TYPE_UPROBE_MULTI,
+		      &bpf_uprobe_multi_link_lops, prog);
+
+	err = bpf_link_prime(&link->link, &link_primer);
+	if (err)
+		goto error;
+
+	for (i = 0; i < cnt; i++) {
+		err = uprobe_register_refctr(uprobes[i].inode, uprobes[i].offset,
+					     uprobes[i].ref_ctr_offset,
+					     &uprobes[i].consumer);
+		if (err) {
+			bpf_uprobe_unregister(uprobes, i);
+			bpf_link_cleanup(&link_primer);
+			return err;
+		}
+	}
+
+	return bpf_link_settle(&link_primer);
+
+error:
+	kfree(uprobes);
+	kfree(link);
+	return err;
+}
+#else /* !CONFIG_UPROBES */
+int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_UPROBES */
-- 
2.40.0

