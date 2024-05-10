Return-Path: <bpf+bounces-29415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121338C1BC1
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FF01C20B03
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE911537EE;
	Fri, 10 May 2024 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PevVrVI/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C45337D
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300991; cv=none; b=d3uUksym2R+1Js5hOSa/rTBcNJ9rIu7f1nwBHtCGRTvJQG5XvjlxTFiw5FqtwJAC4mQX60sH9gCEWymdG+PFwBZmcESpd7cTkobAayGZLnD3DRAgbRLUmecewaYvGbblxpoWgu9T1XRQjmOvAF+S4Bpfbs0TKk7EBvjVmwtbYxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300991; c=relaxed/simple;
	bh=eUPExguRfTNimcD1n3nCj8mT4uUePCZMQR5qu84kVLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yu/SUzZmit9c30EbnOzdvGkr7Cf7Ens8M3uhzDe6aztJTv5whN1D2GIhL0xRTbTxnCGAVWIYUe5P1tY+L6MEeXF7apHPM/D2aHWNv8MCjUGsWGJcg7r7fgdQMt9DneW2GpFGEYo4LJUnAvlHAExnfQQ8ygGz4KNkNCryjlGeHYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PevVrVI/; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c969fa8fd2so887084b6e.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715300988; x=1715905788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6yTtVfiSjzl44U+LGTO04JMGg1y5t8TP/wNxJEy6iE=;
        b=PevVrVI/6BLoqXySCs5gn+muFS3r1VtqohCgZ3PK5vzGrLGR2JJDHkJayeTelOy/Tf
         EdrX4ub0RUehLnPbO/v6Mik1PPOG6wQ5KVa/uFoO6KYQvT/7yQTBRJyg8FLZHNfG8e5E
         Us7FmK+lIXKud5KHYCHXU1slGTKp00DX/atj78vIeZWevwbGxjfI2AtgbitaYxSw1HAq
         NYpG3zVzrvUsyKUosRNcOBOCMZOjBJLMcoYnhE09TSdrlSD81xchvQplNg/m4WdmGOxa
         dQTiwr2fKo32VJpDF8wVE78/RaZ86E8kM/Tx/nvaJkqSC1Qsd3weLF5TQjudML1UUNsh
         162A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715300988; x=1715905788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6yTtVfiSjzl44U+LGTO04JMGg1y5t8TP/wNxJEy6iE=;
        b=a7iDsTNYAvq0fXkjTz7ws+FND7Kk04LepKz+n+KFElgE3LiKhUyajsecDn3arpJKLG
         +ac/89Ih90XUqirhVPZyQZeu+ouSn3z4ZFhF0uTgrrcxQz5l9/2NJO9fWZnycyD8Ba6N
         GOpqPm6exzJgosKDr0XKMBmqM/4oItO6MjQFR293+7hK/8thMa/CkkGxTpCLSB3LWkML
         v4a3umtB1L9VlZE0NVir1sG41mTPvzRiA1UsT+xS1n98rqhM36O6JYUmDdYUk4qKLisQ
         glhRicy9HmZ0AZY/YsbLVeoo4KMgNr7wY335euGv7yEp2cJHAadmsKOkCiR/KJDrICtR
         Depg==
X-Gm-Message-State: AOJu0YwE5qhKLbVSVhVJe0MLlmuhRkGeBvayFMCq7RPVe8hQPryXWMf3
	GIz4G839EUdVaaRnKoztbkiCfgf/UCbPUtYJ18+mLiQXlYUrlyMt2q9MMg==
X-Google-Smtp-Source: AGHT+IEg8+LNggcXyifTFz23buTnhhFp/jAFS4//GENzSDQBlbXZV4Ev7ppI5XfKS0vMavPlORIfVQ==
X-Received: by 2002:a05:6808:487:b0:3c9:6a55:5f1a with SMTP id 5614622812f47-3c9971dcf6cmr1319794b6e.49.1715300988278;
        Thu, 09 May 2024 17:29:48 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:66fe:82c7:2d03:7176])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3c98fc7e00bsm433251b6e.4.2024.05.09.17.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 17:29:47 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/7] bpf: support epoll from bpf struct_ops links.
Date: Thu,  9 May 2024 17:29:38 -0700
Message-Id: <20240510002942.1253354-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510002942.1253354-1-thinker.li@gmail.com>
References: <20240510002942.1253354-1-thinker.li@gmail.com>
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
 kernel/bpf/syscall.c        | 11 +++++++++++
 3 files changed, 29 insertions(+)

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
index 7e270ee15f6e..497526bd5fec 100644
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
+	return (st_link->map) ? 0 : EPOLLHUP;
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
 	err = st_map->st_ops_desc->st_ops->reg(st_map->kvalue.data, &link->link);
 	if (err) {
 		RCU_INIT_POINTER(link->map, NULL);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 13ad74ecf2cd..ad4f81ed27f0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3150,6 +3150,16 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 }
 #endif
 
+static __poll_t bpf_link_poll(struct file *file, struct poll_table_struct *pts)
+{
+	struct bpf_link *link = file->private_data;
+
+	if (link->ops->poll)
+		return link->ops->poll(file, pts);
+
+	return 0;
+}
+
 static const struct file_operations bpf_link_fops = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= bpf_link_show_fdinfo,
@@ -3157,6 +3167,7 @@ static const struct file_operations bpf_link_fops = {
 	.release	= bpf_link_release,
 	.read		= bpf_dummy_read,
 	.write		= bpf_dummy_write,
+	.poll		= bpf_link_poll,
 };
 
 static int bpf_link_alloc_id(struct bpf_link *link)
-- 
2.34.1


