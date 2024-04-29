Return-Path: <bpf+bounces-28181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FCD8B64B3
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AACA1C216FC
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359791836FF;
	Mon, 29 Apr 2024 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2XjgASh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA771836D3
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426580; cv=none; b=D0g/mxPRrB5TfK/9sVRzLB/Ct4lTWVuUCX+CqtfihWp6ibdxjmdeOtulfjn5jaml51sNGNlTodxH2s2zHqdX5/ZkHkdozLx28XbnqpP/zoiNKVK8qZ/7BfdnDMaom3JSjg6U7VFcwgHTFf+Yg+/JLsR8ByBHF3M8qAZUFCMZb80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426580; c=relaxed/simple;
	bh=Z2LkQHTsgWCWz/Q/PwJpz3s4i9iXX/Tm62a7jtcZ9YY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p3w0SJrNBQSbzbjAfnuP6WVPZ1ds1vTNbX8PsVeR5y50Bu4Li5AzizD7PjB1wK2WBbxd0xG7azmSAb3QKSwG8tOjgG6RR2eZjwSZPhpJs4g8f2675ZQ/0luFnQ3tQXk+p75ghI57BXe9HHn5O3+ESwML56V+MhcH1vBNHY1v2/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2XjgASh; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c70e46f3caso3021271b6e.2
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 14:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714426578; x=1715031378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdRBves7cYltUiulBFm9u6fqywNCkscd2bo/pr1PFdU=;
        b=M2XjgAShGf+bX7PlxCjPF70xqyPa9ukLJMpSInJ+2vv0p5zrSxdqBGVIzwplA8KivU
         W+h9VTCGILsXaW83hhJ0ZZZnBNQTX0E5YKzqiup8PV/coDqQztZElvcoMppcI8V/7VE1
         mpLYqgUvwGF3WCMbC1MSt9dbyEagrKCcs0+5m+/pNgXBUV335Ey9I+tosgbTmgNAhAN5
         obBNRey8q/DzJ3Mzk2BcaFZj9T4gg6xofOrcVH4L6Un0hg0v33jSXrXb57mMkJbjU9Zq
         ekR3pzayVtdy1im98jDXjBkalh3VWu1meDW3SLTQ0Ropq1Rph+jEDrr/Ub2s+20i7+6e
         WMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714426578; x=1715031378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdRBves7cYltUiulBFm9u6fqywNCkscd2bo/pr1PFdU=;
        b=qx9dHcnY7obJ101RsPhrgdId+xJTWQCjWrQCIYiX8UEiuILk5zJvgjb3revuGtd5hh
         XioET1/qqmVNnmPGHbLlBeCTZ/KAj+lgsNQhtZYoTuvpaRZFAJBL6O5Xe6UfH3gqV9y0
         5BezV/nBC6po7PmCuW2ZCBkcVGItSUIBJYNCdjKBhkyP+j66FBiyjn01BsM2ML0qQ7XU
         4x8bUnM8hCzXT5jQHKAqFF8lFXvyT2xmo5VLmi+n58JUGEZEwzRdWTJUBLeatYk4ck9p
         lo5afze/SkFZCF6e8IT98AgDgJNjG5h2A7yHEXrWGRRcKHfcmtFhywKC6bImbfN+jULK
         sjnA==
X-Gm-Message-State: AOJu0Yz4r8EdV/odqlL8yWLGc+69YdBC4QYdhWBV91TT1dhfKjKCoH3W
	/2fSTVEVq0Xlbod8+Cna1AbNZbf3TqKcsstLn/xMhbGrYTJLN1fvMby7cQ==
X-Google-Smtp-Source: AGHT+IFUAViiagLy3qu1uxkemLfnUfebGP5gF9AJbQe7nY1uM9rn9B+J0YCqteFXQU+V6e8V1i+3+Q==
X-Received: by 2002:a05:6808:18a3:b0:3c7:5084:ad17 with SMTP id bi35-20020a05680818a300b003c75084ad17mr15254657oib.43.1714426577956;
        Mon, 29 Apr 2024 14:36:17 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b805:4ca7:fd75:4bf])
        by smtp.gmail.com with ESMTPSA id x5-20020a05680801c500b003c8642321c9sm714034oic.50.2024.04.29.14.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 14:36:17 -0700 (PDT)
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
Subject: [PATCH bpf-next 5/6] bpf: support epoll from bpf struct_ops links.
Date: Mon, 29 Apr 2024 14:36:08 -0700
Message-Id: <20240429213609.487820-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429213609.487820-1-thinker.li@gmail.com>
References: <20240429213609.487820-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add epoll support to bpf struct_ops links to trigger EPOLLHUP event upon
detachment.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h         |  2 ++
 kernel/bpf/bpf_struct_ops.c | 14 ++++++++++++++
 kernel/bpf/syscall.c        | 15 +++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eeeed4b1bd32..a4550b927352 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1574,6 +1574,7 @@ struct bpf_link {
 	const struct bpf_link_ops *ops;
 	struct bpf_prog *prog;
 	struct work_struct work;
+	wait_queue_head_t wait_hup;
 };
 
 struct bpf_link_ops {
@@ -1587,6 +1588,7 @@ struct bpf_link_ops {
 			      struct bpf_link_info *info);
 	int (*update_map)(struct bpf_link *link, struct bpf_map *new_map,
 			  struct bpf_map *old_map);
+	__poll_t (*poll)(struct file *file, struct poll_table_struct *pts);
 };
 
 struct bpf_tramp_link {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 4a8a7e5ffc56..f19b6a76591a 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/btf_ids.h>
 #include <linux/rcupdate_wait.h>
+#include <linux/poll.h>
 
 struct bpf_struct_ops_value {
 	struct bpf_struct_ops_common_value common;
@@ -1149,6 +1150,8 @@ bool bpf_struct_ops_kvalue_unreg(void *data)
 	 */
 	bpf_map_put(&st_map->map);
 
+	wake_up_interruptible_poll(&st_link->link.wait_hup, EPOLLHUP);
+
 	ret = true;
 
 fail_unlock:
@@ -1276,15 +1279,26 @@ static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
 
 	mutex_unlock(&update_mutex);
 
+	wake_up_interruptible_poll(&st_link->link.wait_hup, EPOLLHUP);
+
 	return 0;
 }
 
+static __poll_t bpf_struct_ops_map_link_poll(struct file *file,
+					     struct poll_table_struct *ptrs)
+{
+	struct bpf_struct_ops_link *st_link = file->private_data;
+
+	return (st_link->map) ? 0 : EPOLLHUP | EPOLLERR;
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
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4a2f95c4b2ac..b4dbca04d4f5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2990,6 +2990,7 @@ void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
 	link->id = 0;
 	link->ops = ops;
 	link->prog = prog;
+	init_waitqueue_head(&link->wait_hup);
 }
 
 static void bpf_link_free_id(int id)
@@ -3108,6 +3109,19 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 }
 #endif
 
+static __poll_t bpf_link_poll(struct file *file, struct poll_table_struct *pts)
+{
+	struct bpf_link *link = file->private_data;
+
+	if (link->ops->poll) {
+		poll_wait(file, &link->wait_hup, pts);
+
+		return link->ops->poll(file, pts);
+	}
+
+	return 0;
+}
+
 static const struct file_operations bpf_link_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= bpf_link_show_fdinfo,
@@ -3115,6 +3129,7 @@ static const struct file_operations bpf_link_fops = {
 	.release	= bpf_link_release,
 	.read		= bpf_dummy_read,
 	.write		= bpf_dummy_write,
+	.poll		= bpf_link_poll,
 };
 
 static int bpf_link_alloc_id(struct bpf_link *link)
-- 
2.34.1


