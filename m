Return-Path: <bpf+bounces-30174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0028CB62E
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 00:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649EB2817BE
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 22:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DCB6D1BA;
	Tue, 21 May 2024 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMzns63I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921DD3DB89
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 22:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716331987; cv=none; b=nC0xVqaX6HPDagohY4Z+FVYsz1yxLYijtqmlJXohBj8rTR7oiMw7zi0m8KLsB/QXRhMyoDOTFsUTz36kXra71ug6yi7gSEBOXJK1WguHz931okivd5ZSgKtwmZst6WhuRBiFpng9r9ely8DkPlVRf4X2zazFzo++yeBBzWizGp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716331987; c=relaxed/simple;
	bh=04LoSuRRxOtHnGba7+hhoWLwL7VVgeZlsTwx0PPIAgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P+CUI+RWf1twEQAn26r77zC81kB/hJmSS/SWI40KC5xbiHzArwfJA0uZZTl9UXHm2KYmut3wu90zUiEzgLWuSXKRlKkxaDTwULXp5f0YL+sA6Y24+/AJoDyuE3vBv+fEzGWwpgKejLC8Ce/RFBBb8biANh9G3E+26xwmWDUjwIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMzns63I; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-deb65b541faso220784276.0
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 15:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716331984; x=1716936784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IfzfcI2K9QtYKxHBIj5Q4K0FDQCL16Wws/rejUd8fg=;
        b=RMzns63IjbG6WkXLkZ+FD7aQjAsGwjzZ1b0yo1+P214dPMVw8jLj/YIiFxvKicW7Ns
         FkobNNoPTjt/T6/WzuADy5MLtLoV9eMukf2e1u0MryA16DhM9P0GpfkpKA3IxWuEOaTE
         WU9ZFNz1G64y61yLE9qnhT00WQY3cOf3lQW6n8/u0Sr4Yppw9/kjEUMBsOIPaiOMqBws
         jEpqg+ymlD/p/xznh0fqKT15mexE1cmAn/qjR6KftLLt7sIMvPOI2bBAyP9VKP5PwU8Z
         O8lzLgfTcmrW2ofBEzLTK4EgG9IRcoffegvbPsGGj7IylReczE40hFOb89VFDOEEdbHe
         b2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716331984; x=1716936784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IfzfcI2K9QtYKxHBIj5Q4K0FDQCL16Wws/rejUd8fg=;
        b=q7+5vjBHGRtpcltU47kQOCONwGsHYGaFi0J/D0vqaMeurXso2XoOj4idnzHfsI7+op
         uYdcWO1MK2J450vEVUCi/VuqdFJJDmkjqcXXBlddl7G9RG4F+3UppAyUX/QIGhxXLoUj
         STSeFiAd28QYNYKKyLlas1/jzwLtlTI7vVfMj4xGHpd1mr5WU5P5yfQmGJLrI9CNvmwt
         WSc+SoyXH2gaofTn1LmbFu16v/t92HaSweksBL+dWQmFAlzgBv+anEtLBE/hXhCcKZDT
         Ud5qmk+YA7GiGcFJFwhxXJBAcSk+BT1F8Xt29kp//6D86XMfudxeNs6L8MnJVe6mxKvJ
         iWfA==
X-Gm-Message-State: AOJu0YwV+tM7hG6nLy+PHFazeU3Bm1hCoshzMSULVa//r5knsl6+no9h
	M7/2fFngdrqvj0tihhtHP1AJJ6Tb3Oyr6fNaGsmOuUvQPnJKONAdFsBptw==
X-Google-Smtp-Source: AGHT+IF1WiupjfZsV1FMjQCCu8X1+uV5BzuID1DY+Y1siACxZ5ykwECqdb8By4o0Mrt8zSByOsuWwA==
X-Received: by 2002:a05:6902:18d3:b0:df4:dd4c:2b0e with SMTP id 3f1490d57ef6-df4e0dc8f1bmr574438276.48.1716331984236;
        Tue, 21 May 2024 15:53:04 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1437:59a6:29be:9221])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd385be51sm5584956276.54.2024.05.21.15.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 15:53:03 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 3/7] bpf: support epoll from bpf struct_ops links.
Date: Tue, 21 May 2024 15:51:17 -0700
Message-Id: <20240521225121.770930-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521225121.770930-1-thinker.li@gmail.com>
References: <20240521225121.770930-1-thinker.li@gmail.com>
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
index fb6e8a3190ef..794549dc9f4b 100644
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
 	/* Once reg() is called, the object and link is already available
 	 * to the subsystem, and it can call
 	 * bpf_struct_ops_map_link_detach() to unreg() it. However, it is
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


