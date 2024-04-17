Return-Path: <bpf+bounces-27017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E048A79D5
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 02:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD784B20FF2
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 00:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887A26FBF;
	Wed, 17 Apr 2024 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS81ieKi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C74566A
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 00:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313522; cv=none; b=D/doUjPY16ViIO+0RFDOfvOIP08AVR/D8wLvuiDyeQwW8m5D8Hziu/z7SyuOQlH05PSXG680xQhudFcfLb7fWcFv+WhWI8t2a4RF24+fvlgb8dY9aw0/dJ8TquESjZlSmG4SiTUKhqYdyG3HJlZJisXLp9XlP9Wr40ICpSh2cik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313522; c=relaxed/simple;
	bh=Yx1Q1zSjzLHgfIqSIout/sNivmbXEggIwzwb5rv4iRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jiIxhE8t/TU3fdyRTUy3xxJCcnHHfMOUjTob2Iukj+4kiF/cMX1DIFYe74ep9S96ikkhJH9mzFOuS/GO2dXXLkID9QgEa+/bzGJ5Ide4BstDJNNvNBaRuIv/TmFIDbrpaHTT5zUtpZOnljLXVFwyib/q5Ie23+eytCBGKIrvxGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS81ieKi; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6181237230dso58239607b3.2
        for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 17:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713313519; x=1713918319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNEly3AnpniV7iTnXaOTqTEtDvtPcSEmn/7hZ6VUUoo=;
        b=CS81ieKibKyjTM1dfAAFVDPFoBqUSbtkDs7KQADyFE0hZklxDMmz+Em7qruZwAiA04
         VZ9V6DvXK84bBkTK1+QxXXpD7gu3jnbkqIenoOcUPDhAJkongiHYqZlsIXn8e/uEJ9+j
         lSqQiNMklgHg8p/QwAekrlzEV/k9QJXsF3WZh5h1rJWDMzsEPUm3skMV8UpViNmNNS/o
         JaqUjCLHkev7m4bAampLhTDeokOKYe6DPQHBjBCX1/jqh/ex60XMQ7tZOwi4P+wjyFB9
         8HI73PD8H/DVWP24OP8vynjXtohpRwN3FsoL5kEle4DCq4jMeF3WGjBX7piCUOgfwc1k
         qHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713313519; x=1713918319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNEly3AnpniV7iTnXaOTqTEtDvtPcSEmn/7hZ6VUUoo=;
        b=B1U7TN59yKLQlse0ENMLQqG+/ATDXnEnRjAqXcoZ5QPKIQBJd1uSuqyxv011FeE/Xt
         tRwA3GTTjg2n8n6UWPNYUWrkyjPPko8HugJx04WUTXqWeWuJ3DX++5JT4uu6zOY7DXIz
         27hWdZUvSv4/U14MKP31Z6i3xkBq01SUKwZCqXvQF/TYNBAJN7ufF0rmBqRA7tFU8o5l
         JXgFwgS2Xzjgd0JzoaWV01scKbI0/1SD+OWfwBnwCVixX4JzL7j3hOydb46cIVAQinGO
         SjjtXHK2Tq/0n3JPG3G9V6pUudLAuecHoG9xzQm6qi/ejcYLzXCSUrYvSDJyBt8Qf+Hw
         SAHA==
X-Gm-Message-State: AOJu0YzkJeT0NtU5aLFDplXLIEX60q50vNYR9LBwr7rSM/Y9pgh/zfbC
	EZNZSql5p2B0IbWjNUFC17586UCy0s5xNL/6mgKwj9UPf/p55TBfBdzZ2g==
X-Google-Smtp-Source: AGHT+IHd9Lr3tAwRwWlNwHxtzDXHdauVjFQtWmVWmKkv4EwZ8bzUMEk4iKthGWrEwc+EqzjGKYw1+g==
X-Received: by 2002:a81:be07:0:b0:61a:c32c:9cd5 with SMTP id i7-20020a81be07000000b0061ac32c9cd5mr7425863ywn.46.1713313517853;
        Tue, 16 Apr 2024 17:25:17 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:2bf6:8300:76f:3cae])
        by smtp.gmail.com with ESMTPSA id z79-20020a814c52000000b00617e3ac0deesm2792555ywa.86.2024.04.16.17.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 17:25:17 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: enable the "open" operator on a pinned path of a struct_osp link.
Date: Tue, 16 Apr 2024 17:25:12 -0700
Message-Id: <20240417002513.1534535-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417002513.1534535-1-thinker.li@gmail.com>
References: <20240417002513.1534535-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the "open" operator for the inodes of BPF links to allow applications
to obtain a file descriptor of a struct_ops link from a pinned path.

Applications have the ability to update a struct_ops link with another
struct_ops map. However, they were unable to open pinned paths of the links
with this patch. This implies that updating a link through its pinned paths
was not feasible.

This patch adds the "open" operator to bpf_link_ops and uses bpf_link_ops
as the i_fop for inodes of struct_ops links. "open" will be called to open
the pinned path represented by an inode. Additionally, bpf_link_ops will be
used as the f->f_ops of the opened "file" to provide operators for the
"file".

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h         |  4 ++++
 kernel/bpf/bpf_struct_ops.c | 10 ++++++++++
 kernel/bpf/inode.c          | 11 ++++++++---
 kernel/bpf/syscall.c        | 14 +++++++++++++-
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5034c1b4ded7..23b831ec9b71 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2160,6 +2160,10 @@ extern const struct super_operations bpf_super_ops;
 extern const struct file_operations bpf_map_fops;
 extern const struct file_operations bpf_prog_fops;
 extern const struct file_operations bpf_iter_fops;
+extern const struct file_operations bpf_link_fops;
+
+/* Required by bpf_link_open() */
+int bpffs_struct_ops_link_open(struct inode *inode, struct file *filp);
 
 #define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type) \
 	extern const struct bpf_prog_ops _name ## _prog_ops; \
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 86c7884abaf8..8be4f755a182 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1198,3 +1198,13 @@ void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct bpf_map *map
 
 	info->btf_vmlinux_id = btf_obj_id(st_map->btf);
 }
+
+int bpffs_struct_ops_link_open(struct inode *inode, struct file *filp)
+{
+	struct bpf_struct_ops_link *link = inode->i_private;
+
+	/* Paired with bpf_link_put_direct() in bpf_link_release(). */
+	bpf_link_inc(&link->link);
+	filp->private_data = link;
+	return 0;
+}
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index af5d2ffadd70..b020d761ab0a 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -360,11 +360,16 @@ static int bpf_mkmap(struct dentry *dentry, umode_t mode, void *arg)
 
 static int bpf_mklink(struct dentry *dentry, umode_t mode, void *arg)
 {
+	const struct file_operations *fops;
 	struct bpf_link *link = arg;
 
-	return bpf_mkobj_ops(dentry, mode, arg, &bpf_link_iops,
-			     bpf_link_is_iter(link) ?
-			     &bpf_iter_fops : &bpffs_obj_fops);
+	if (bpf_link_is_iter(link))
+		fops = &bpf_iter_fops;
+	else if (link->type == BPF_LINK_TYPE_STRUCT_OPS)
+		fops = &bpf_link_fops;
+	else
+		fops = &bpffs_obj_fops;
+	return bpf_mkobj_ops(dentry, mode, arg, &bpf_link_iops, fops);
 }
 
 static struct dentry *
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7d392ec83655..f66bc6215faa 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3108,7 +3108,19 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 }
 #endif
 
-static const struct file_operations bpf_link_fops = {
+/* Support opening pinned links */
+static int bpf_link_open(struct inode *inode, struct file *filp)
+{
+	struct bpf_link *link = inode->i_private;
+
+	if (link->type == BPF_LINK_TYPE_STRUCT_OPS)
+		return bpffs_struct_ops_link_open(inode, filp);
+
+	return -EOPNOTSUPP;
+}
+
+const struct file_operations bpf_link_fops = {
+	.open = bpf_link_open,
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= bpf_link_show_fdinfo,
 #endif
-- 
2.34.1


