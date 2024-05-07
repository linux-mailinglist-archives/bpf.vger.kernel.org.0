Return-Path: <bpf+bounces-28761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D09D8BDAE8
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 07:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C2B1C214D8
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 05:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE9E6EB59;
	Tue,  7 May 2024 05:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io2V6ymJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57DC6D1C8
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061378; cv=none; b=DRXcJWUhd1/TkdouKzR6r+GYg/Oq/yRRJxUcVUrxBSC8mCjuxxaBv0JbX3Zdp4UQxgvSYRGJIKonicBak3kYB2uwOjM8kkkZZInaBGeeQNO8PHBeXsXjJvZUQPunbtcOO8Kp3IMLAskq0fQvLCyBpOYSredEsvLkAJ3s9WJs1uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061378; c=relaxed/simple;
	bh=7+0B2PM4IXI7ORkqPIrseOZz5px6mK8KTyStKbg7jn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O7KwdrRg6s/G3c849B6LTcGojhIhWF/zfkRUmXIP688R4kJb+4XFWT3uiyfiI/egdGEZjEWxjEj3tMZ19g622D8k/It2eZfIsV6fU6ttuBYJIPwJVn+/uyMTSNOE51BxyWIrelZexlgq5O3V+v3cM1nem8Wwh1pd7XapeSiinNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Io2V6ymJ; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ad2da2196bso1389539eaf.3
        for <bpf@vger.kernel.org>; Mon, 06 May 2024 22:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715061375; x=1715666175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IgIxfryk/0GhM9FXe4Mf5a5mfor2fDNMojWu1TYABQ=;
        b=Io2V6ymJh2mbe9KePvRMUGtsV2ul8tDLKfga7YDaM3Sv10YzHgKwLl7LnbA3SL0PDq
         5GZr8l5Lw4fUEP6TD1XvGZRQvZTdsJUXT91dSQPW0smWemya6gmFGMeCBU0I+QEFse43
         9e+hAMdmpQDgMvkB1cbvLgVMgyGhi25s4fDvp5SqsNK4G04LQ5kKzBzJFrEJKzumaVhN
         pTFMbYJuMRwToRE/tSG/nJzUuaSZwyhmSpYje89LqVlfx0Mg5lvTPrK7CVJozv0EsUd0
         sbXhEvop5Jf+CLlC3roiu0T2EO9hczQzu76MsMSJ4pU4IKVgSAN6uCDjsfbAHj0MlD/V
         NtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715061375; x=1715666175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IgIxfryk/0GhM9FXe4Mf5a5mfor2fDNMojWu1TYABQ=;
        b=ZmUdVukgAwDpZmTL7x8Yhex2Bi0b5OeRgepx0ZD6sBx/X/indhx4E6jFKtpFgx8bP5
         JSUdBKMFEIfNF/3UGFOh2isBRka4laJx3WyaKOHE/qwXdVIatdzfhQjfueRawuvCSjoL
         HIy7Q1d/4lrI0smrZn5Ck2vxUiUo/VUGgsaLnSqskXGKQold52IL72iSJ44iEYalWdEN
         E/VJQUbdQfAjieWR5ScVEWpAavPyqeYCG2EgOFm65b/uf+AP82ENfMT2UWFRKK0ZG70U
         HgW3nbiZIQgZFY7FMzRaUYq+o9z7tn1d+R8ytIPpzbyu8e8ygGbE+30BVApmn9TOE1yU
         JMDw==
X-Gm-Message-State: AOJu0Yz9Pe1/dXqfzSxRxEVlV6UF7sT2HsZNFoGqnkQ0yZQlTJ8DDHuj
	VYxZzvoUAKQKJ+qm9SOBLM+H2Q2lUWlMrpp/ccOdX9wMKSO+uS6QSCuBCw==
X-Google-Smtp-Source: AGHT+IGuxdTVttejKjbV8ad9uELWof6n8gC9eWEmsicxPpPQag98gaXVWMp5WQfwm20TxMW/rknF1w==
X-Received: by 2002:a4a:3117:0:b0:5b2:1e8:a66d with SMTP id k23-20020a4a3117000000b005b201e8a66dmr7222653ooa.8.1715061375539;
        Mon, 06 May 2024 22:56:15 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:2e7d:922e:d30d:e503])
        by smtp.gmail.com with ESMTPSA id eo8-20020a0568200f0800b005a586b0906esm2317011oob.26.2024.05.06.22.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 22:56:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/6] bpf: support epoll from bpf struct_ops links.
Date: Mon,  6 May 2024 22:55:57 -0700
Message-Id: <20240507055600.2382627-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507055600.2382627-1-thinker.li@gmail.com>
References: <20240507055600.2382627-1-thinker.li@gmail.com>
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
index bd2602982e4d..f37844b1a94c 100644
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
 		rcu_assign_pointer(link->map, NULL);
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


