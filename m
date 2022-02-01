Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDC14A668C
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 21:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiBAUzu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 15:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiBAUzr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 15:55:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EDAC06173B
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 12:55:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t91-20020a25aae4000000b0061963cce3c1so23022710ybi.11
        for <bpf@vger.kernel.org>; Tue, 01 Feb 2022 12:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dm/QA8eOMDyEhqviMMC11srMRKdcrEoIlVOAi9iuAaY=;
        b=EOpU/04WC7Oa2ypb8D//Kiwq9aBRceZLH54HJIBWJcN5sfbyJClGGQd3F6+YQNVBDQ
         jdJZd32Fxzn1EOKRz+B6vMy1XkIVgutEM7xSmFjH1isBkX9PnzFOJ2W07aCMDp9hjaFT
         Uh/XWgmOlvSPqHhBb7qlZ7XOcwvovINKjGp23bvs/3SzI48jMQM92CFVhoX8Tfl2pC0S
         QtLWTpdraQA72kWfRUivi9scYXS1M3M2zT+YhXfMlKzTrxchFyTpw9+8JhubV0++SgP6
         cXhWvvhQ5cj5yZm2a7bzwRYwN78qEn1TwnAuhHmFYzj8AWvrJ7CEEEd/40O8S+dp6uNn
         txiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dm/QA8eOMDyEhqviMMC11srMRKdcrEoIlVOAi9iuAaY=;
        b=PNFznF9Ll+TnLcTL1iexSfHE8Rc8l5Ga6dXNkQuamTKpKrg1z1J3u8R39DTHV+wRj5
         watI5ghP6m3ZEfEeXFQ1gXiDu2WC3DIFm7ocOWhwObUkRS5ZS64wZZtZQb51aTd/x17C
         kW4uyscRX1UaaiBNeUxccv9j/UkqYOKw3DSERRaHDqeVL82ImpdIYsPdBN3VYtxjuW19
         wq6Dr6U/SNasrA3ckxAdhKaRbEJCj3yIks/+5BRx6Y8Ix3gOMzO1FCYRgAjgcfja9I4x
         nTlwQagsRDFCN6HqnxOgsAUtM0/XDE49zFPd6uUQuplFWrJHqM0/KwgrVuQLYuJAXcE/
         +fyg==
X-Gm-Message-State: AOAM532tIBSGkIq0jduh1O3d8/0LijBhCAJEcqDzE6GrsfYb8BySFVwT
        tH8bCj5n/IKy2K5pWWFnFpe5d3Ujmi4=
X-Google-Smtp-Source: ABdhPJzDi2kBw0BS06ZEeFeTZkDZ0K3lIomhmC8BXon0zUnggjPKNcyl2sAP1ZdF6cD1y5QNjzBtlyYQEJs=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:1cdb:a263:2495:80fd])
 (user=haoluo job=sendgmr) by 2002:a81:1a55:: with SMTP id a82mr88441ywa.369.1643748946816;
 Tue, 01 Feb 2022 12:55:46 -0800 (PST)
Date:   Tue,  1 Feb 2022 12:55:32 -0800
In-Reply-To: <20220201205534.1962784-1-haoluo@google.com>
Message-Id: <20220201205534.1962784-4-haoluo@google.com>
Mime-Version: 1.0
References: <20220201205534.1962784-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH RFC bpf-next v2 3/5] bpf: cgroup_view iter
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce a new type of iter prog: 'cgroup_view'. It prints out cgroup's
state.

Cgroup_view is supposed to be used together with directory tagging. When
cgroup_view is pinned in a directory, it tags that directory as
KERNFS_REP, i.e. a replicate of the cgroup hierarchy. Whenever a
subdirectory is created, if there is a child cgroup of the same name
exists, the subdirectory inherits the pinned cgroup_view object from
its parent and holds a reference of the corresponding kernfs node.

The cgroup_view prog takes a pointer to the cgroup and can use family
of seq_print helpers to print out cgroup state. A typical use case of
cgroup_view is to extend the cgroupfs interface.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h           |   2 +
 kernel/bpf/Makefile           |   2 +-
 kernel/bpf/bpf_iter.c         |  11 ++++
 kernel/bpf/cgroup_view_iter.c | 114 ++++++++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/cgroup_view_iter.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6eb0b180d33b..494927b2b3c2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1610,6 +1610,7 @@ typedef const struct bpf_func_proto *
 
 enum bpf_iter_feature {
 	BPF_ITER_RESCHED	= BIT(0),
+	BPF_ITER_INHERIT	= BIT(1),
 };
 
 #define BPF_ITER_CTX_ARG_MAX 2
@@ -1647,6 +1648,7 @@ bpf_iter_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
 int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr, struct bpf_prog *prog);
 int bpf_iter_new_fd(struct bpf_link *link);
 bool bpf_link_is_iter(struct bpf_link *link);
+bool bpf_link_support_inherit(struct bpf_link *link);
 struct bpf_prog *bpf_iter_get_info(struct bpf_iter_meta *meta, bool in_stop);
 int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx);
 void bpf_iter_map_show_fdinfo(const struct bpf_iter_aux_info *aux,
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index c1a9be6a4b9f..d9d2b8541ba7 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -8,7 +8,7 @@ CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
 
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
-obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
+obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o cgroup_view_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
 obj-${CONFIG_BPF_LSM}	  += bpf_inode_storage.o
 obj-$(CONFIG_BPF_SYSCALL) += disasm.o
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 110029ede71e..ff5577a5f73a 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -496,6 +496,17 @@ bool bpf_link_is_iter(struct bpf_link *link)
 	return link->ops == &bpf_iter_link_lops;
 }
 
+bool bpf_link_support_inherit(struct bpf_link *link)
+{
+	struct bpf_iter_link *iter_link;
+
+	if (!bpf_link_is_iter(link))
+		return false;
+
+	iter_link = container_of(link, struct bpf_iter_link, link);
+	return iter_link->tinfo->reg_info->feature & BPF_ITER_INHERIT;
+}
+
 int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr,
 			 struct bpf_prog *prog)
 {
diff --git a/kernel/bpf/cgroup_view_iter.c b/kernel/bpf/cgroup_view_iter.c
new file mode 100644
index 000000000000..a44d115235c4
--- /dev/null
+++ b/kernel/bpf/cgroup_view_iter.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022 Google */
+#include <linux/bpf.h>
+#include <linux/fs.h>
+#include <linux/filter.h>
+#include <linux/kernel.h>
+#include <linux/btf_ids.h>
+#include <linux/cgroup.h>
+#include <linux/kernfs.h>
+#include "inode.h"
+
+static void *cgroup_view_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct bpf_dir_tag *tag;
+	struct kernfs_node *kn;
+	struct cgroup *cgroup;
+	struct inode *dir;
+
+	/* Only one session is supported. */
+	if (*pos > 0)
+		return NULL;
+
+	dir = d_inode(seq->file->f_path.dentry->d_parent);
+	tag = dir->i_private;
+	if (!tag)
+		return NULL;
+
+	kn = tag->private;
+
+	rcu_read_lock();
+	cgroup = rcu_dereference(*(void __rcu __force **)&kn->priv);
+	if (!cgroup || !cgroup_tryget(cgroup))
+		cgroup = NULL;
+	rcu_read_unlock();
+
+	if (!cgroup)
+		return NULL;
+
+	if (*pos == 0)
+		++*pos;
+	return cgroup;
+}
+
+static void *cgroup_view_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	++*pos;
+	return NULL;
+}
+
+struct bpf_iter__cgroup_view {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct cgroup *, cgroup);
+};
+
+DEFINE_BPF_ITER_FUNC(cgroup_view, struct bpf_iter_meta *meta, struct cgroup *cgroup)
+
+static int cgroup_view_seq_show(struct seq_file *seq, void *v)
+{
+	struct bpf_iter__cgroup_view ctx;
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+	int ret = 0;
+
+	ctx.meta = &meta;
+	ctx.cgroup = v;
+	meta.seq = seq;
+	prog = bpf_iter_get_info(&meta, false);
+	if (prog)
+		ret = bpf_iter_run_prog(prog, &ctx);
+
+	return ret;
+}
+
+static void cgroup_view_seq_stop(struct seq_file *seq, void *v)
+{
+	if (v)
+		cgroup_put(v);
+}
+
+static const struct seq_operations cgroup_view_seq_ops = {
+	.start	= cgroup_view_seq_start,
+	.next	= cgroup_view_seq_next,
+	.stop	= cgroup_view_seq_stop,
+	.show	= cgroup_view_seq_show,
+};
+
+BTF_ID_LIST(btf_cgroup_id)
+BTF_ID(struct, cgroup)
+
+static const struct bpf_iter_seq_info cgroup_view_seq_info = {
+	.seq_ops		= &cgroup_view_seq_ops,
+	.init_seq_private	= NULL,
+	.fini_seq_private	= NULL,
+	.seq_priv_size		= 0,
+};
+
+static struct bpf_iter_reg cgroup_view_reg_info = {
+	.target			= "cgroup_view",
+	.feature		= BPF_ITER_INHERIT,
+	.ctx_arg_info_size	= 1,
+	.ctx_arg_info		= {
+		{ offsetof(struct bpf_iter__cgroup_view, cgroup),
+		  PTR_TO_BTF_ID },
+	},
+	.seq_info		= &cgroup_view_seq_info,
+};
+
+static int __init cgroup_view_init(void)
+{
+	cgroup_view_reg_info.ctx_arg_info[0].btf_id = *btf_cgroup_id;
+	return bpf_iter_reg_target(&cgroup_view_reg_info);
+}
+
+late_initcall(cgroup_view_init);
-- 
2.35.0.rc2.247.g8bbb082509-goog

