Return-Path: <bpf+bounces-30440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2835A8CDD21
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 01:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E8A1F21CE2
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 23:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AE9128812;
	Thu, 23 May 2024 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWLR9T1s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E7084D25
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 23:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716505739; cv=none; b=vD2pR2X3JJhFas6BZq8VBTqrkY31LcLWXBQiZO7avr2pfblOWH0bFyVd0wf4oNecaE4A4H2guCO6BnsZDbs2iLyVa9+RlPGw9PJtACBOE853iq+kkoZ0avLV9cFj3GqleM4Q3OBCE8bRanTIybnWaalpllVzDAOX+qrNl+PiBqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716505739; c=relaxed/simple;
	bh=MWDCpjl9BLy3RGzWzjmcFwlOX12n4Lxxz8u31F8OV80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K81QuhB6EkNOShGH916v3Rj2sZg4hi7R4iJ+GwJjfaIhhSpz/PiA7x/RvuRdUbxayiF5KvcxwlarP6InOHqSigUBT7UVNRzvQ9QrUVHIx8mSVYJ2FUah/BsxStMeNAIF6BWQef0il/hE2sRlYnzFa6A3UI60wonJ29ms+Gf9s/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWLR9T1s; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-62a087bc74bso2609527b3.2
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 16:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716505736; x=1717110536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsUJ/ZUPCANLU2SOSyqnWVxDYlfF/YXSX4GUUYnQdmY=;
        b=XWLR9T1skpg1XSsvc+4RLOQAPZ8ypWQpMB+Z8QPpQ2ixRQSovUu7OwdnaJPgYoVmlR
         OlsF4VRVvt2t3P8KPGAsb9XNQNJn9qDqX69ceCpQFvH3lz0ucNk+agHbXmvsu+6JRE3Z
         7Kd9qtDp7+I8sbPaYAUD/uIRiuogWrT2s8BN8C84PBN4KPe2nEL9ZK5ZHYetFRjLrATr
         //00SXInLSKCFeqMWPF+t5gTaHKUBN9D7q2+uQVhSvr7jA7kybmM/RlP1UizM4Q3MOcB
         TSHc4TQ0UYQQX2v/FFhrMPPbu/7mfhm27+ZOFM5eaRBvQpMLyPSvktU7ZEAmGFg6E/aV
         ogeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716505736; x=1717110536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsUJ/ZUPCANLU2SOSyqnWVxDYlfF/YXSX4GUUYnQdmY=;
        b=YVNNL45tWXWwEYYmMLfD30FpsluPbD8gOKdAh1lEg6kAekALJEVz9WBbfGF+Ycy8Da
         YscQ/etZynEVTHOX3Opcf+4y04uIIJKbNtSquuBkWPr6PtI69VSNn9ZGycUtqyVKi+it
         Rb8/lM53eRTle2GIkStkWChIFkbQq0dCmIjNC3MHkUxmyQlGfOmndbrrLLcX8/HEA7tX
         /koSxKCq1v1HmjS1cKFSPyntpT+EV6w+gJbrcp3EO5vWvZubtoxD3r6e1RST33J0G4QR
         ru+8CorFgETNiyuiGhvFVcI4ZmXWOKVOEVraqkKHI5BDtE0I01B3ySB/YvXYgUXBaUJv
         sRBQ==
X-Gm-Message-State: AOJu0YyZnKQ1ArHBpjL6iZrXkb9WiZESQ41r9aFJhg/KIgPK5bfD/M9m
	P39qyBKC+jvksOub/cBcPgTgQLZxsSqjttiCZZjcWQ5hA5xemsVK9Y9v3Q==
X-Google-Smtp-Source: AGHT+IExVd9a5w5wA9Hgfxvdgo+IqYXLuBrgfOlhSG2QrOJUcWYRl16Iy/U3Q4bKHVqQOpm6g72g9g==
X-Received: by 2002:a0d:d454:0:b0:61d:fd33:d065 with SMTP id 00721157ae682-62a08d8abe8mr6501767b3.15.1716505735842;
        Thu, 23 May 2024 16:08:55 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b7f1:1457:70d4:ab6c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a37d5d0sm474087b3.16.2024.05.23.16.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:08:55 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 3/8] bpf: support epoll from bpf struct_ops links.
Date: Thu, 23 May 2024 16:08:43 -0700
Message-Id: <20240523230848.2022072-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523230848.2022072-1-thinker.li@gmail.com>
References: <20240523230848.2022072-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add epoll support to bpf struct_ops links to trigger EPOLLHUP event upon
detachment.

This patch implements the "poll" of the "struct file_operations" for BPF
links and introduces a new "poll" operator in the "struct bpf_link_ops". By
implementing "poll" of "struct bpf_link_ops" for the links of struct_ops,
the file descriptor of a struct_ops link can be added to an epoll file
descriptor to receive EPOLLHUP events.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h         |  1 +
 kernel/bpf/bpf_struct_ops.c | 17 +++++++++++++++++
 kernel/bpf/syscall.c        | 31 ++++++++++++++++++++++++++-----
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b600767ebe02..5f7496ef8b7c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1612,6 +1612,7 @@ struct bpf_link_ops {
 			      struct bpf_link_info *info);
 	int (*update_map)(struct bpf_link *link, struct bpf_map *new_map,
 			  struct bpf_map *old_map);
+	__poll_t (*poll)(struct file *file, struct poll_table_struct *pts);
 };
 
 struct bpf_tramp_link {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index f2439acd9757..855a1b2b6e79 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/btf_ids.h>
 #include <linux/rcupdate_wait.h>
+#include <linux/poll.h>
 
 struct bpf_struct_ops_value {
 	struct bpf_struct_ops_common_value common;
@@ -56,6 +57,7 @@ struct bpf_struct_ops_map {
 struct bpf_struct_ops_link {
 	struct bpf_link link;
 	struct bpf_map __rcu *map;
+	wait_queue_head_t wait_hup;
 };
 
 static DEFINE_MUTEX(update_mutex);
@@ -1167,15 +1169,28 @@ static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
 
 	mutex_unlock(&update_mutex);
 
+	wake_up_interruptible_poll(&st_link->wait_hup, EPOLLHUP);
+
 	return 0;
 }
 
+static __poll_t bpf_struct_ops_map_link_poll(struct file *file,
+					     struct poll_table_struct *pts)
+{
+	struct bpf_struct_ops_link *st_link = file->private_data;
+
+	poll_wait(file, &st_link->wait_hup, pts);
+
+	return rcu_access_pointer(st_link->map) ? 0 : EPOLLHUP;
+}
+
 static const struct bpf_link_ops bpf_struct_ops_map_lops = {
 	.dealloc = bpf_struct_ops_map_link_dealloc,
 	.detach = bpf_struct_ops_map_link_detach,
 	.show_fdinfo = bpf_struct_ops_map_link_show_fdinfo,
 	.fill_link_info = bpf_struct_ops_map_link_fill_link_info,
 	.update_map = bpf_struct_ops_map_link_update,
+	.poll = bpf_struct_ops_map_link_poll,
 };
 
 int bpf_struct_ops_link_create(union bpf_attr *attr)
@@ -1213,6 +1228,8 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	 */
 	RCU_INIT_POINTER(link->map, map);
 
+	init_waitqueue_head(&link->wait_hup);
+
 	mutex_lock(&update_mutex);
 	err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, &link->link);
 	if (err) {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 13ad74ecf2cd..741f91153fe6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3150,6 +3150,13 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 }
 #endif
 
+static __poll_t bpf_link_poll(struct file *file, struct poll_table_struct *pts)
+{
+	struct bpf_link *link = file->private_data;
+
+	return link->ops->poll(file, pts);
+}
+
 static const struct file_operations bpf_link_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= bpf_link_show_fdinfo,
@@ -3159,6 +3166,16 @@ static const struct file_operations bpf_link_fops = {
 	.write		= bpf_dummy_write,
 };
 
+static const struct file_operations bpf_link_fops_poll = {
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo	= bpf_link_show_fdinfo,
+#endif
+	.release	= bpf_link_release,
+	.read		= bpf_dummy_read,
+	.write		= bpf_dummy_write,
+	.poll		= bpf_link_poll,
+};
+
 static int bpf_link_alloc_id(struct bpf_link *link)
 {
 	int id;
@@ -3201,7 +3218,9 @@ int bpf_link_prime(struct bpf_link *link, struct bpf_link_primer *primer)
 		return id;
 	}
 
-	file = anon_inode_getfile("bpf_link", &bpf_link_fops, link, O_CLOEXEC);
+	file = anon_inode_getfile("bpf_link",
+				  link->ops->poll ? &bpf_link_fops_poll : &bpf_link_fops,
+				  link, O_CLOEXEC);
 	if (IS_ERR(file)) {
 		bpf_link_free_id(id);
 		put_unused_fd(fd);
@@ -3229,7 +3248,9 @@ int bpf_link_settle(struct bpf_link_primer *primer)
 
 int bpf_link_new_fd(struct bpf_link *link)
 {
-	return anon_inode_getfd("bpf-link", &bpf_link_fops, link, O_CLOEXEC);
+	return anon_inode_getfd("bpf-link",
+				link->ops->poll ? &bpf_link_fops_poll : &bpf_link_fops,
+				link, O_CLOEXEC);
 }
 
 struct bpf_link *bpf_link_get_from_fd(u32 ufd)
@@ -3239,7 +3260,7 @@ struct bpf_link *bpf_link_get_from_fd(u32 ufd)
 
 	if (!f.file)
 		return ERR_PTR(-EBADF);
-	if (f.file->f_op != &bpf_link_fops) {
+	if (f.file->f_op != &bpf_link_fops && f.file->f_op != &bpf_link_fops_poll) {
 		fdput(f);
 		return ERR_PTR(-EINVAL);
 	}
@@ -4966,7 +4987,7 @@ static int bpf_obj_get_info_by_fd(const union bpf_attr *attr,
 					     uattr);
 	else if (f.file->f_op == &btf_fops)
 		err = bpf_btf_get_info_by_fd(f.file, f.file->private_data, attr, uattr);
-	else if (f.file->f_op == &bpf_link_fops)
+	else if (f.file->f_op == &bpf_link_fops || f.file->f_op == &bpf_link_fops_poll)
 		err = bpf_link_get_info_by_fd(f.file, f.file->private_data,
 					      attr, uattr);
 	else
@@ -5101,7 +5122,7 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 	if (!file)
 		return -EBADF;
 
-	if (file->f_op == &bpf_link_fops) {
+	if (file->f_op == &bpf_link_fops || file->f_op == &bpf_link_fops_poll) {
 		struct bpf_link *link = file->private_data;
 
 		if (link->ops == &bpf_raw_tp_link_lops) {
-- 
2.34.1


