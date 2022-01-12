Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A64348CBF4
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 20:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356453AbiALT12 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 14:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345162AbiALT0c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 14:26:32 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E061C061245
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:26:07 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i81-20020a253b54000000b00611b1da1f8fso1551449yba.5
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yDXL8UUzK/9+buL6gkbXy9spq4LQS1BDsh/qrssDu7Q=;
        b=RF11mGZx2zr+S6RJLpOtEnxIWCNKMsMa12V1GuPNVcWvrLZvemgyDY/sSPkFnYOf+D
         6TkEJKWH0W6R4Tnd7+dZBv/ZDktlsWiVNxKVTtjsH2tjEYJXpFtFkoNSMPwYhtiOcJRD
         5lWWYmPkXwuSnh/qEUkzhAoVPpvrVW6MOp6iJXm95a/Tw3elLkr5jhEcJusq41vbLl6X
         J/+WC/5aVpuPk6ZIAjndPoWba80QD0wDZxW0jlVcBp6K1UWEA1RL9yzIte2PHJUa6P9A
         HhtTiDiFp7zwezlHQ2jl90giKPao9u/qfJc2eRg0EzSiWYbiSUHbGZRfIPBDYO2vp0n9
         /dTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yDXL8UUzK/9+buL6gkbXy9spq4LQS1BDsh/qrssDu7Q=;
        b=PAifrDwx6SPHFTiyRoetZHVTBBQyUuZROHZtGRqpULaJtBhAUTVQVeCe1/Ta0fAzJv
         4dLwNbEiNY1wO9orsmO56A0NaxDKTZppezGsJu6whUJR7zCuNC/00kiyFqdhUYicipC7
         sVpBJqoPtgVmlFp4NqHGg2j0YMc7djZjDnYZAFRfiCgE8pSSzhZtdkFqVOK/F6QAkavd
         fl+QQjFZQqyE6vY0sBvv57nbXASBMWlnV8PsMmItbzQmdiD4w9Mx+uePbvhgpV1E2oLD
         nM7WzbgVCJPjQVXUtu3uHxtBwXt4CMiRHs+h5vA5XzT+4pMWrX7WdBCz3CXuh5sH6biA
         GIyA==
X-Gm-Message-State: AOAM530MesYwkDvIEBHWf9TzJvlDwigKupCfQ9ZshNG+6QQhiKNyjqUU
        OyxWeuFzDiLO61po2cfrj0v54IjiB0Q=
X-Google-Smtp-Source: ABdhPJyheBqhOzTcvV+uhHfkduy3S5cLxMWybXi9ki2uwDuLhYbJe68pxiDg5RFWa1AsJ9LAQi/k8ditmTk=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:ddf2:9aea:6994:df79])
 (user=haoluo job=sendgmr) by 2002:a25:c3c4:: with SMTP id t187mr1409170ybf.634.1642015566506;
 Wed, 12 Jan 2022 11:26:06 -0800 (PST)
Date:   Wed, 12 Jan 2022 11:25:46 -0800
In-Reply-To: <20220112192547.3054575-1-haoluo@google.com>
Message-Id: <20220112192547.3054575-8-haoluo@google.com>
Mime-Version: 1.0
References: <20220112192547.3054575-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH RESEND RFC bpf-next v1 7/8] bpf: Add seq_show operation for
 bpf in cgroupfs
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, Joe@google.com,
        Burton@google.com, jevburton.kernel@gmail.com,
        Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previous patches allow exposing bpf objects to kernfs file system.
They allow creating file entries in kernfs, which can reference bpf
objects. The referred bpf objects can be used to customize the new
entry's file operations.

In particular, this patch introduces one concrete use case of this
feature. It implements the .seq_show file operation for the cgroup
file system. The seq_show handler takes the bpf object and use it to
format its output seq file. The bpf object needs to be a link to the
newly introduced "bpf_view" program type.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 kernel/bpf/bpf_view.c    | 11 ++++++++
 kernel/bpf/bpf_view.h    |  1 +
 kernel/bpf/inode.c       |  4 +--
 kernel/bpf/inode.h       |  3 +++
 kernel/bpf/kernfs_node.c | 58 +++++++++++++++++++++++++++++++++++++++-
 5 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_view.c b/kernel/bpf/bpf_view.c
index 967a9240bab4..8f035c5a9b6a 100644
--- a/kernel/bpf/bpf_view.c
+++ b/kernel/bpf/bpf_view.c
@@ -166,6 +166,17 @@ static struct bpf_view_target_info cgroup_view_tinfo = {
 	.btf_id			= 0,
 };
 
+bool bpf_link_is_cgroup_view(struct bpf_link *link)
+{
+	struct bpf_view_link *view_link;
+
+	if (!bpf_link_is_view(link))
+		return false;
+
+	view_link = container_of(link, struct bpf_view_link, link);
+	return view_link->tinfo == &cgroup_view_tinfo;
+}
+
 static int __init bpf_view_init(void)
 {
 	int cgroup_view_idx[BPF_VIEW_CTX_ARG_MAX] = {
diff --git a/kernel/bpf/bpf_view.h b/kernel/bpf/bpf_view.h
index 1a1110a5727f..a02564e529cb 100644
--- a/kernel/bpf/bpf_view.h
+++ b/kernel/bpf/bpf_view.h
@@ -17,6 +17,7 @@ struct bpf_view_cgroup_ctx {
 };
 
 bool bpf_link_is_view(struct bpf_link *link);
+bool bpf_link_is_cgroup_view(struct bpf_link *link);
 
 /* Run a bpf_view program */
 int run_view_prog(struct bpf_prog *prog, void *ctx);
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 7e93e477b57c..1ae4a7b8c732 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -115,8 +115,6 @@ struct fsnotify_ops bpf_notify_ops = {
 	.free_mark = notify_free_mark,
 };
 
-static int bpf_inode_type(const struct inode *inode, enum bpf_type *type);
-
 /* Watch the destruction of an inode and calls the callbacks in the given
  * notify_ops.
  */
@@ -211,7 +209,7 @@ static struct inode *bpf_get_inode(struct super_block *sb,
 	return inode;
 }
 
-static int bpf_inode_type(const struct inode *inode, enum bpf_type *type)
+int bpf_inode_type(const struct inode *inode, enum bpf_type *type)
 {
 	*type = BPF_TYPE_UNSPEC;
 	if (inode->i_op == &bpf_prog_iops)
diff --git a/kernel/bpf/inode.h b/kernel/bpf/inode.h
index c12d385a3e2a..dea78341549b 100644
--- a/kernel/bpf/inode.h
+++ b/kernel/bpf/inode.h
@@ -17,6 +17,9 @@ struct notify_ops {
 	void (*free_inode)(void *object, enum bpf_type type, void *priv);
 };
 
+/* Get the type of bpf object from bpffs inode. */
+int bpf_inode_type(const struct inode *inode, enum bpf_type *type);
+
 #ifdef CONFIG_FSNOTIFY
 /* Watch the destruction of an inode and calls the callbacks in the given
  * notify_ops.
diff --git a/kernel/bpf/kernfs_node.c b/kernel/bpf/kernfs_node.c
index 3d331d8357db..7b58bfc1951e 100644
--- a/kernel/bpf/kernfs_node.c
+++ b/kernel/bpf/kernfs_node.c
@@ -3,15 +3,33 @@
  * Expose eBPF objects in kernfs file system.
  */
 
+#include <linux/bpf.h>
 #include <linux/fs.h>
 #include <linux/kernfs.h>
+#include <linux/btf_ids.h>
+#include <linux/magic.h>
+#include <linux/seq_file.h>
 #include "inode.h"
+#include "bpf_view.h"
 
 /* file_operations for kernfs file system */
 
 /* Command for removing a kernfs entry */
 #define REMOVE_CMD "rm"
 
+static const struct kernfs_ops bpf_generic_ops;
+static const struct kernfs_ops bpf_cgroup_ops;
+
+/* Choose the right kernfs_ops for different kernfs. */
+static const struct kernfs_ops *bpf_kernfs_ops(struct super_block *sb)
+{
+	if (sb->s_magic == CGROUP_SUPER_MAGIC ||
+	    sb->s_magic == CGROUP2_SUPER_MAGIC)
+		return &bpf_cgroup_ops;
+
+	return &bpf_generic_ops;
+}
+
 /* Handler when the watched inode is freed. */
 static void kn_watch_free_inode(void *obj, enum bpf_type type, void *kn)
 {
@@ -80,7 +98,7 @@ int bpf_obj_do_pin_kernfs(struct dentry *dentry, umode_t mode, void *obj,
 	if (!inode)
 		return -ENXIO;
 
-	ops = &bpf_generic_ops;
+	ops = bpf_kernfs_ops(sb);
 	kn = __kernfs_create_file(parent_kn, dentry->d_iname, mode,
 				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
 				  0, ops, inode, NULL, NULL);
@@ -107,3 +125,41 @@ int bpf_obj_do_pin_kernfs(struct dentry *dentry, umode_t mode, void *obj,
 	iput(inode);
 	return 0;
 }
+
+/* file_operations for cgroup file system */
+static int bpf_cgroup_seq_show(struct seq_file *seq, void *v)
+{
+	struct bpf_view_cgroup_ctx ctx;
+	struct kernfs_open_file *of;
+	struct kernfs_node *kn;
+	struct cgroup *cgroup;
+	struct inode *inode;
+	struct bpf_link *link;
+	enum bpf_type type;
+
+	of = seq->private;
+	kn = of->kn;
+	cgroup = kn->parent->priv;
+
+	inode = kn->priv;
+	if (bpf_inode_type(inode, &type))
+		return -ENXIO;
+
+	if (type != BPF_TYPE_LINK)
+		return -EACCES;
+
+	link = inode->i_private;
+	if (!bpf_link_is_cgroup_view(link))
+		return -EACCES;
+
+	ctx.seq = seq;
+	ctx.cgroup = cgroup;
+
+	return run_view_prog(link->prog, &ctx);
+}
+
+static const struct kernfs_ops bpf_cgroup_ops = {
+	.seq_show	= bpf_cgroup_seq_show,
+	.write          = bpf_generic_write,
+	.read           = bpf_generic_read,
+};
-- 
2.34.1.448.ga2b2bfdf31-goog

