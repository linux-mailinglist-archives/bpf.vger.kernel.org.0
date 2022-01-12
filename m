Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D4E48CC0F
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 20:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344531AbiALTfd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 14:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345002AbiALTeh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 14:34:37 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9EDC061756
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:34:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v66-20020a256145000000b006115377709aso6498026ybb.3
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z0MPDtD7Ryvxqv7atBRsBBIy5nWrE/2KAVK5YgOTQ1o=;
        b=VaG+BDhGZiRMcx7ILPx1FKbDTYZIDzGrso2CIFJmUNjFyeyGBFQ4Bn+yCTmenl8Dwi
         wGgZUj4CrlbMl1AjY30cFMZ43I1GxcQnqq8c5ZbXC/5wqcBX9AAhEQ1ziIQFIfs+5RHd
         HcD0l/r9p6yk9BjCYObTqUOnlXR13FbXzC9ISOYhGHmGF/zZk+OdizCyQTf2CRtps7Um
         Q7yP0/YbxYRpgPk0OWhhtmTRROmiV5Kim1teK/XFWKLyta4G1w4alZ48htehoJgV6tHU
         SFnhnGjJgZ8ALSEI8k9W5tXGRiq6VqU+jrwLSift35fqjIFLKmgImre1XAmlmWXzWovM
         CdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z0MPDtD7Ryvxqv7atBRsBBIy5nWrE/2KAVK5YgOTQ1o=;
        b=REwPyJvkn3PQiNt4dAzKta3w1SaxrVitfKH+Su/4YcjhcQbTMkju9ZzQFgpLSmSfJ4
         yFZv/zCkLFKsKpiGAbFXmlwQZmlFWCVmDpmzQQP8wZczYzL8JvpsCONpQHX1ReoGzs/G
         h/k5Fs76kg3KD3TnkSKrDATyR+3U3PqgNjKS1Sf4tyTENo3TAkcHiffDnLfeuOx20c+h
         IjeOrsRN+YbONkQznnXi87ElWj3/7Q1VPuD1mU1mORRQKQiyk2yFuNkr7gyX9QhFWWV6
         nEsv3VXCPk9GncRmRDogUV8Pl+/iAF/osU4KQTsKkkzw5pE9KdoxdIPPtG7Ai9jly6yl
         eJLA==
X-Gm-Message-State: AOAM531WdW7ckIFA1YfC/GTrEThhUuns9CxeCzotsEO14k8oY9A4XiRa
        K7NDURezfU/tGCY6i3X4IdQuhCh41mw=
X-Google-Smtp-Source: ABdhPJzWfqiG6bT1zNC+0Yk0Mn6uDFTcEAh1A/ccHTR+XZ1KYXS5ZNRMTqK4k7Zpqsao7ViIO5AQ9gsprPc=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:ddf2:9aea:6994:df79])
 (user=haoluo job=sendgmr) by 2002:a25:6e82:: with SMTP id j124mr1481119ybc.512.1642016074445;
 Wed, 12 Jan 2022 11:34:34 -0800 (PST)
Date:   Wed, 12 Jan 2022 11:31:49 -0800
In-Reply-To: <20220112193152.3058718-1-haoluo@google.com>
Message-Id: <20220112193152.3058718-6-haoluo@google.com>
Mime-Version: 1.0
References: <20220112193152.3058718-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH RESEND RFC bpf-next v1 5/8] bpf: Introduce a new program type bpf_view.
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce a new program type called "bpf_view", which can be used to
print out a kernel object's state to a seq file. So the signature of
this program consists of two parameters: a seq file and a kernel object.
Currently only 'struct cgroup' is supported.

The following patches will introduce a call site for this program type
and allow users to customize the format of printing out the state of
kernel objects to userspace.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h            |   4 +
 include/uapi/linux/bpf.h       |   2 +
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/bpf_view.c          | 179 +++++++++++++++++++++++++++++++++
 kernel/bpf/bpf_view.h          |  24 +++++
 kernel/bpf/syscall.c           |   3 +
 kernel/bpf/verifier.c          |   6 ++
 kernel/trace/bpf_trace.c       |  12 ++-
 tools/include/uapi/linux/bpf.h |   2 +
 9 files changed, 230 insertions(+), 4 deletions(-)
 create mode 100644 kernel/bpf/bpf_view.c
 create mode 100644 kernel/bpf/bpf_view.h

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2ec693c3d6f6..16f582dfff7e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1622,6 +1622,10 @@ void bpf_iter_map_show_fdinfo(const struct bpf_iter_aux_info *aux,
 int bpf_iter_map_fill_link_info(const struct bpf_iter_aux_info *aux,
 				struct bpf_link_info *info);
 
+bool bpf_view_prog_supported(struct bpf_prog *prog);
+int bpf_view_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
+			 struct bpf_prog *prog);
+
 int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b0383d371b9a..efa0f21d13ba 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -982,6 +982,7 @@ enum bpf_attach_type {
 	BPF_MODIFY_RETURN,
 	BPF_LSM_MAC,
 	BPF_TRACE_ITER,
+	BPF_TRACE_VIEW,
 	BPF_CGROUP_INET4_GETPEERNAME,
 	BPF_CGROUP_INET6_GETPEERNAME,
 	BPF_CGROUP_INET4_GETSOCKNAME,
@@ -1009,6 +1010,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_NETNS = 5,
 	BPF_LINK_TYPE_XDP = 6,
 	BPF_LINK_TYPE_PERF_EVENT = 7,
+	BPF_LINK_TYPE_VIEW = 8,
 
 	MAX_BPF_LINK_TYPE,
 };
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index b1abf0d94b5b..c662734d83c5 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -8,7 +8,7 @@ CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
 
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
-obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o kernfs_node.o
+obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o kernfs_node.o bpf_view.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o
diff --git a/kernel/bpf/bpf_view.c b/kernel/bpf/bpf_view.c
new file mode 100644
index 000000000000..967a9240bab4
--- /dev/null
+++ b/kernel/bpf/bpf_view.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/bpf.h>
+#include <linux/btf_ids.h>
+#include <linux/cgroup.h>
+#include <linux/filter.h>
+#include "bpf_view.h"
+
+static struct list_head targets = LIST_HEAD_INIT(targets);
+
+/* bpf_view_link operations */
+
+struct bpf_view_target_info {
+	struct list_head list;
+	const char *target;
+	u32 ctx_arg_info_size;
+	struct bpf_ctx_arg_aux ctx_arg_info[BPF_VIEW_CTX_ARG_MAX];
+	u32 btf_id;
+};
+
+struct bpf_view_link {
+	struct bpf_link link;
+	struct bpf_view_target_info *tinfo;
+};
+
+static void bpf_view_link_release(struct bpf_link *link)
+{
+}
+
+static void bpf_view_link_dealloc(struct bpf_link *link)
+{
+	struct bpf_view_link *view_link =
+		container_of(link, struct bpf_view_link, link);
+	kfree(view_link);
+}
+
+static void bpf_view_link_show_fdinfo(const struct bpf_link *link,
+				      struct seq_file *seq)
+{
+	struct bpf_view_link *view_link =
+		container_of(link, struct bpf_view_link, link);
+
+	seq_printf(seq, "attach_target:\t%s\n", view_link->tinfo->target);
+}
+
+static const struct bpf_link_ops bpf_view_link_lops = {
+	.release = bpf_view_link_release,
+	.dealloc = bpf_view_link_dealloc,
+	.show_fdinfo = bpf_view_link_show_fdinfo,
+};
+
+bool bpf_link_is_view(struct bpf_link *link)
+{
+	return link->ops == &bpf_view_link_lops;
+}
+
+int bpf_view_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
+			 struct bpf_prog *prog)
+{
+	struct bpf_link_primer link_primer;
+	struct bpf_view_target_info *tinfo;
+	struct bpf_view_link *link;
+	u32 prog_btf_id;
+	bool existed = false;
+	int err;
+
+	prog_btf_id = prog->aux->attach_btf_id;
+	list_for_each_entry(tinfo, &targets, list) {
+		if (tinfo->btf_id == prog_btf_id) {
+			existed = true;
+			break;
+		}
+	}
+	if (!existed)
+		return -ENOENT;
+
+	link = kzalloc(sizeof(*link), GFP_USER | __GFP_NOWARN);
+	if (!link)
+		return -ENOMEM;
+
+	bpf_link_init(&link->link, BPF_LINK_TYPE_VIEW, &bpf_view_link_lops, prog);
+	link->tinfo = tinfo;
+	err = bpf_link_prime(&link->link, &link_primer);
+	if (err) {
+		kfree(link);
+		return err;
+	}
+
+	return bpf_link_settle(&link_primer);
+}
+
+int run_view_prog(struct bpf_prog *prog, void *ctx)
+{
+	int ret;
+
+	rcu_read_lock();
+	migrate_disable();
+	ret = bpf_prog_run(prog, ctx);
+	migrate_enable();
+	rcu_read_unlock();
+
+	return ret;
+}
+
+bool bpf_view_prog_supported(struct bpf_prog *prog)
+{
+	const char *attach_fname = prog->aux->attach_func_name;
+	const char *prefix = BPF_VIEW_FUNC_PREFIX;
+	u32 prog_btf_id = prog->aux->attach_btf_id;
+	struct bpf_view_target_info *tinfo;
+	int prefix_len = strlen(prefix);
+	bool supported = false;
+
+	if (strncmp(attach_fname, prefix, prefix_len))
+		return false;
+
+	list_for_each_entry(tinfo, &targets, list) {
+		if (tinfo->btf_id && tinfo->btf_id == prog_btf_id) {
+			supported = true;
+			break;
+		}
+		if (!strcmp(attach_fname + prefix_len, tinfo->target)) {
+			tinfo->btf_id = prog->aux->attach_btf_id;
+			supported = true;
+			break;
+		}
+	}
+	if (supported) {
+		prog->aux->ctx_arg_info_size = tinfo->ctx_arg_info_size;
+		prog->aux->ctx_arg_info = tinfo->ctx_arg_info;
+	}
+	return supported;
+}
+
+/* Generate BTF_IDs */
+BTF_ID_LIST(bpf_view_btf_ids)
+BTF_ID(struct, seq_file)
+BTF_ID(struct, cgroup)
+
+/* Index of bpf_view_btf_ids */
+enum {
+	BTF_ID_SEQ_FILE = 0,
+	BTF_ID_CGROUP,
+};
+
+static void register_bpf_view_target(struct bpf_view_target_info *target,
+				     int idx[BPF_VIEW_CTX_ARG_MAX])
+{
+	int i;
+
+	for (i = 0; i < target->ctx_arg_info_size; ++i)
+		target->ctx_arg_info[i].btf_id = bpf_view_btf_ids[idx[i]];
+
+	INIT_LIST_HEAD(&target->list);
+	list_add(&target->list, &targets);
+}
+
+DEFINE_BPF_VIEW_FUNC(cgroup, struct seq_file *seq, struct cgroup *cgroup)
+
+static struct bpf_view_target_info cgroup_view_tinfo = {
+	.target			= "cgroup",
+	.ctx_arg_info_size	= 2,
+	.ctx_arg_info		= {
+		{ offsetof(struct bpf_view_cgroup_ctx, seq), PTR_TO_BTF_ID },
+		{ offsetof(struct bpf_view_cgroup_ctx, cgroup), PTR_TO_BTF_ID },
+	},
+	.btf_id			= 0,
+};
+
+static int __init bpf_view_init(void)
+{
+	int cgroup_view_idx[BPF_VIEW_CTX_ARG_MAX] = {
+		BTF_ID_SEQ_FILE, BTF_ID_CGROUP };
+
+	register_bpf_view_target(&cgroup_view_tinfo, cgroup_view_idx);
+
+	return 0;
+}
+late_initcall(bpf_view_init);
+
diff --git a/kernel/bpf/bpf_view.h b/kernel/bpf/bpf_view.h
new file mode 100644
index 000000000000..1a1110a5727f
--- /dev/null
+++ b/kernel/bpf/bpf_view.h
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#ifndef _BPF_VIEW_H_
+#define _BPF_VIEW_H_
+
+#include <linux/bpf.h>
+
+#define BPF_VIEW_FUNC_PREFIX "bpf_view_"
+#define DEFINE_BPF_VIEW_FUNC(target, args...) \
+	extern int bpf_view_ ## target(args); \
+	int __init bpf_view_ ## target(args) { return 0; }
+
+#define BPF_VIEW_CTX_ARG_MAX 2
+
+struct bpf_view_cgroup_ctx {
+	__bpf_md_ptr(struct seq_file *, seq);
+	__bpf_md_ptr(struct cgroup *, cgroup);
+};
+
+bool bpf_link_is_view(struct bpf_link *link);
+
+/* Run a bpf_view program */
+int run_view_prog(struct bpf_prog *prog, void *ctx);
+
+#endif  // _BPF_VIEW_H_
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fa4505f9b611..32ac84d3ac0b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3175,6 +3175,7 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_CGROUP_SETSOCKOPT:
 		return BPF_PROG_TYPE_CGROUP_SOCKOPT;
 	case BPF_TRACE_ITER:
+	case BPF_TRACE_VIEW:
 		return BPF_PROG_TYPE_TRACING;
 	case BPF_SK_LOOKUP:
 		return BPF_PROG_TYPE_SK_LOOKUP;
@@ -4235,6 +4236,8 @@ static int tracing_bpf_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
 
 	if (prog->expected_attach_type == BPF_TRACE_ITER)
 		return bpf_iter_link_attach(attr, uattr, prog);
+	else if (prog->expected_attach_type == BPF_TRACE_VIEW)
+		return bpf_view_link_attach(attr, uattr, prog);
 	else if (prog->type == BPF_PROG_TYPE_EXT)
 		return bpf_tracing_prog_attach(prog,
 					       attr->link_create.target_fd,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bfb45381fb3f..ce7816519c93 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9770,6 +9770,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 		case BPF_MODIFY_RETURN:
 			return 0;
 		case BPF_TRACE_ITER:
+		case BPF_TRACE_VIEW:
 			break;
 		default:
 			return -ENOTSUPP;
@@ -13971,6 +13972,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 
 		break;
 	case BPF_TRACE_ITER:
+	case BPF_TRACE_VIEW:
 		if (!btf_type_is_func(t)) {
 			bpf_log(log, "attach_btf_id %u is not a function\n",
 				btf_id);
@@ -14147,6 +14149,10 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		if (!bpf_iter_prog_supported(prog))
 			return -EINVAL;
 		return 0;
+	} else if (prog->expected_attach_type == BPF_TRACE_VIEW) {
+		if (!bpf_view_prog_supported(prog))
+			return -EINVAL;
+		return 0;
 	}
 
 	if (prog->type == BPF_PROG_TYPE_LSM) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 21aa30644219..9413b5af6e2c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1630,6 +1630,12 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	}
 }
 
+static inline bool prog_support_seq_helpers(const struct bpf_prog *prog)
+{
+	return prog->expected_attach_type == BPF_TRACE_ITER ||
+		prog->expected_attach_type == BPF_TRACE_VIEW;
+}
+
 const struct bpf_func_proto *
 tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1663,15 +1669,15 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_socket_ptr_cookie_proto;
 #endif
 	case BPF_FUNC_seq_printf:
-		return prog->expected_attach_type == BPF_TRACE_ITER ?
+		return prog_support_seq_helpers(prog) ?
 		       &bpf_seq_printf_proto :
 		       NULL;
 	case BPF_FUNC_seq_write:
-		return prog->expected_attach_type == BPF_TRACE_ITER ?
+		return prog_support_seq_helpers(prog) ?
 		       &bpf_seq_write_proto :
 		       NULL;
 	case BPF_FUNC_seq_printf_btf:
-		return prog->expected_attach_type == BPF_TRACE_ITER ?
+		return prog_support_seq_helpers(prog) ?
 		       &bpf_seq_printf_btf_proto :
 		       NULL;
 	case BPF_FUNC_d_path:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b0383d371b9a..efa0f21d13ba 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -982,6 +982,7 @@ enum bpf_attach_type {
 	BPF_MODIFY_RETURN,
 	BPF_LSM_MAC,
 	BPF_TRACE_ITER,
+	BPF_TRACE_VIEW,
 	BPF_CGROUP_INET4_GETPEERNAME,
 	BPF_CGROUP_INET6_GETPEERNAME,
 	BPF_CGROUP_INET4_GETSOCKNAME,
@@ -1009,6 +1010,7 @@ enum bpf_link_type {
 	BPF_LINK_TYPE_NETNS = 5,
 	BPF_LINK_TYPE_XDP = 6,
 	BPF_LINK_TYPE_PERF_EVENT = 7,
+	BPF_LINK_TYPE_VIEW = 8,
 
 	MAX_BPF_LINK_TYPE,
 };
-- 
2.34.1.448.ga2b2bfdf31-goog

