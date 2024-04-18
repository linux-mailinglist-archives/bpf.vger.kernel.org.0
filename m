Return-Path: <bpf+bounces-27149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF918AA030
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 18:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D351C21CEA
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 16:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491FC16F29F;
	Thu, 18 Apr 2024 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de/X477W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628A316F821
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458115; cv=none; b=La9fQP0AvctKbT5o7XB9rfRbfgW5Yjl37LshEdSX46xoPFMyiNEwrF2vMCGFy8kZ2PGy+F9VRzYoKcrLblF/PkPtsyTduZTDs5jMmkXM31ZWovxCOhlPwy2bhI30gfuEH+JhO4Cv03yUFbDbynJs3duBAsMoOmhCW74VJZKtwPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458115; c=relaxed/simple;
	bh=iSYgeiWC7yBOtijry+q8yOVxXjoZCLGAvYhJgeW5cPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gjlKq8iFxtcPMya0McKqCcCUAkr3CqkAU9TzrbeF+Ic5h29cz2Ma0OfMR1Y6vDN+6FjH/m4ma4IRX3Pfha38JYT8Wax4JhYZINoV5ho82JRyqCy9wAMFr2rwmp7I39kC1S8g6ooWFONBPyjDv2ZAj+DxwRQBvEQRSKWw47UXEAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=de/X477W; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-238fd648224so485879fac.2
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 09:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713458113; x=1714062913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr+Xb5YIng8DoSV9KjvZ0dyty9Kf6vDWKIcvqZmLO+s=;
        b=de/X477WYW9caeLihh+kdibcxSWEQKakF5IlPF5fWOQPL6UlTq34FhcsilliYPAh86
         kkOOQw8bkrrRhDw7bd8nOd/jQpSRKwB8WlFou5NtzWE5Tctr7izv/+ornJbe4NSwRke8
         6HhhfufEchKd+LlFeXCznKmpwAtvOVQG2Ste6c8NJEjEMFQDmQ0KTtLOFUaEIp+/kEHl
         QwE3H2wrGa2rkfbU1NJF6JmxlILjs0fHuevRO7b5LqKBdufdwKSm2RiBpXuhv2Xszh1Y
         vQsDRV9fphdFj4qKfzLlSd1AEK7WdFMyBxVv84i/wVB/wB1b+dlndSvKQT9jqg7sImBp
         B5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713458113; x=1714062913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tr+Xb5YIng8DoSV9KjvZ0dyty9Kf6vDWKIcvqZmLO+s=;
        b=llgJp6uSrLERpEL23qH/v3pN6cftysMBd9fmYSJDIvs7YcTLqZ4KJ7fngKKkIFngbe
         x2Ul1cwG7fAQyQ3foeWi/j4nIJrYVoMmE4TZS58zyO0sY5J/QZC/iM4tmUMGgza0T5Cr
         C51/2b1E/TYtFQa0tvZXa/6bgwFdrUgB9e9PT1Gl2guN6btrzyPWIEyh7iaZy/6QxO02
         T+tnS65KvmD07OyYTeqyAD/HSt8Q4sDx2z6Qe51IrCWeCewYwZeiFOZ3MK2KvtUKQ5SK
         iRxSS4MOhyhxV2hLfNbH72mbME0yv0fsPNfUElPA01aFTTMMYLMe+rc77+J1EU8tA8v7
         OPfw==
X-Gm-Message-State: AOJu0YwmdvenKsDOAk94hRDuyELbhAtKjtnX63J3jos/pAXHnH2MVK2S
	5sotYWxWuMqW53vLoeETVEGCFiHRF6XWXUz5jU17xRleLRnrncim7P37hA==
X-Google-Smtp-Source: AGHT+IE/EgNIzojL8uoFf9Ay5Agd2HZhMHD6PZsOGbmkmpNHUlMC1lSnVNR8rjXrBCCFUR7quxRgqw==
X-Received: by 2002:a05:6870:c088:b0:22a:1cd5:dc5 with SMTP id c8-20020a056870c08800b0022a1cd50dc5mr3998477oad.20.1713458113231;
        Thu, 18 Apr 2024 09:35:13 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:6fe6:94b6:ddee:aa05])
        by smtp.gmail.com with ESMTPSA id i5-20020a9d53c5000000b006e695048ad8sm376391oth.66.2024.04.18.09.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:35:12 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/2] bpf: enable the "open" operator on a pinned path of a struct_osp link.
Date: Thu, 18 Apr 2024 09:35:08 -0700
Message-Id: <20240418163509.719335-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418163509.719335-1-thinker.li@gmail.com>
References: <20240418163509.719335-1-thinker.li@gmail.com>
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
 include/linux/bpf.h         |  6 ++++++
 kernel/bpf/bpf_struct_ops.c | 10 ++++++++++
 kernel/bpf/inode.c          | 11 ++++++++---
 kernel/bpf/syscall.c        | 16 +++++++++++++++-
 4 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5034c1b4ded7..a0c0234d754b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2160,6 +2160,12 @@ extern const struct super_operations bpf_super_ops;
 extern const struct file_operations bpf_map_fops;
 extern const struct file_operations bpf_prog_fops;
 extern const struct file_operations bpf_iter_fops;
+extern const struct file_operations bpf_link_fops;
+
+#ifdef CONFIG_BPF_JIT
+/* Required by bpf_link_open() */
+int bpffs_struct_ops_link_open(struct inode *inode, struct file *filp);
+#endif
 
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
index 7d392ec83655..265e2faf317d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3108,7 +3108,21 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 }
 #endif
 
-static const struct file_operations bpf_link_fops = {
+/* Support opening pinned links */
+static int bpf_link_open(struct inode *inode, struct file *filp)
+{
+#ifdef CONFIG_BPF_JIT
+	struct bpf_link *link = inode->i_private;
+
+	if (link->type == BPF_LINK_TYPE_STRUCT_OPS)
+		return bpffs_struct_ops_link_open(inode, filp);
+#endif
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


