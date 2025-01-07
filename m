Return-Path: <bpf+bounces-48077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBB2A03EAA
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E59D57A1DF0
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6492C1EF0BC;
	Tue,  7 Jan 2025 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I76fVNy0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB941E04A1;
	Tue,  7 Jan 2025 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251718; cv=none; b=T5t3dKPycd6lVhmaLSud68I7oL7KymXWZtlWNn9MdA2XbbySN+1ZIoOTS4xTAWBQ6/6syp3+A0BeKrA2Nr36Y9RWHoosx2LRs3x27MTiVfVR7QQ4/NEYOZq5Lc0UUQ06OwBo8wNrg55Qk1AdZe02o7tOOiw77/ghAnAOdnnW8+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251718; c=relaxed/simple;
	bh=cnPLy76INlaLrwkt7MAjvY9YxgcT87cLRYGRQL14RRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enbgR3iCOcqTxctk/9FkAwp9bseRe0+FrPe+cvCxBd0XvuxjWxyM2xJ1ADE5jP9v9WiliTa+P9Lxd3IpoyXW4Yb1JBK9bIztoVX9HeOtuZthB5i4xjBVX/IUP1TfMzoP/msIxC0ebayQXQchXPBeBjnZ1+NKHWpAXYVNQQkc8Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I76fVNy0; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f13acbe29bso20001542a91.1;
        Tue, 07 Jan 2025 04:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251703; x=1736856503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaTnWdIWLR1sE2ww6RDndLTTgfPGGW5SN20fYrYrxaE=;
        b=I76fVNy06dBCVeQJFL9okoRmLTo4686eUyc1PxNKBHf+/0vyFjEVpI+mREu48y/fBD
         YpTbFhxHHQR/L9oMftpdnLCJkYoS0vV+SYfZmsZuOjH0tCCcuyhXonuclxYhCxnBu/m+
         /HSTFZeeS0s4IitningAfkQCh8MjC5vlvXAmcWtkkDERZoTT0hTCVU1AiiQUoGKXQu2h
         8kqOOutWmipuQpNZXUKpETLnWhHI+mlArOs2/GvgHOm/FGjULAfdjeuVA4Lw7W4D6tkw
         oKKwvQpVS2VmEzxAQcnrhQIfgPTS+DfLjyamMi3vqadQBrSeTTfpAB+XI1delcv6J2Lt
         wIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251703; x=1736856503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaTnWdIWLR1sE2ww6RDndLTTgfPGGW5SN20fYrYrxaE=;
        b=Jyc0/uPu0MVO6OGh12lE/SDlzE12Topqk9vrbkUkm6tscbbOpK4gZeTWFaHu+/glMN
         oIeoJcSqvH0QPNhLDMA4nvYRXZ7+PK2ebREsq32O6L7ZE206LtifYhlGCaX9S4UCYnuS
         K5BlmzXurkQckSd8ADsYtTGY2Df00l9ZCCvnhprttA4iWx7xBgIjfu+TH7/e7vddlfrM
         AeWY643Ne5zeXjdQGjaxDZXPaF9s1UVIsu2DvgvvZe2W/4HifX/hTiCu9qqsHr+NnKlv
         tqsU5CSsgcy99IcpJ9U+WXhg1WNbMQKktTgTsJGGHUtZbeeAxeH3UHjtiOShVEkSdjLW
         Me9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvQstFNLk3CaWzn2pbUmV+IFqiPY1K9gI9dyu0vUkkLk3H6kPKG+4qxSdNQsPlJkk16oe3lHo3JdynBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmuOQMaRsKOFDyQ04V6awAOl5/SHaaXHcLBUNfGr6CzGy5zXpo
	HiKA5oc9klaEEgfyJXLEfCEUZXK1lHfuEouiAf7cFhmYvzw1Y0ZYXVMLZiiFcz4=
X-Gm-Gg: ASbGncuLbAD6MvbqUu+l5Hi7NOxiwZc31QVASADClYSMLbeqUBq7Lzq0rX4P7wgL6FT
	3nwZE75+Lx8AzGoEte9k7qLtJt8jeLcogK+zricjjY/SOEWdywWIUff+dTpu+R4+c3u4cOmmgif
	VftennpDPC7l2FYrjst4RODI93xHeruCF+PYTuIaLsuYlqu9Eo6POowobqXItOYrSX6Mf8URDLo
	Cqgbx22Cs48jLJRs5ioxRAUioOPQRjV5QLpzmz3I4R5VrqwVDZQh1ItCpK8fIZNt89t
X-Google-Smtp-Source: AGHT+IE/IbyVPD6/Pj2zLNT+fW1Fsx1kN0ii1GFHjth+jWZh0cZqXDm/340Ft45v7O8hlWH1wn4XIg==
X-Received: by 2002:a05:6a00:1c92:b0:725:4915:c0f with SMTP id d2e1a72fcca58-72d103dc480mr4429129b3a.11.1736251702842;
        Tue, 07 Jan 2025 04:08:22 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:08:22 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 09/22] ublk: bpf: attach bpf prog to ublk device
Date: Tue,  7 Jan 2025 20:04:00 +0800
Message-ID: <20250107120417.1237392-10-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250107120417.1237392-1-tom.leiming@gmail.com>
References: <20250107120417.1237392-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attach bpf program to ublk device before adding ublk disk, and detach it
after the disk is removed.

ublk device needs to provide the struct_ops ID for attaching the specific
prog, and each ublk device has to attach to only single bpf prog.

So that we can use the attached bpf prog for handling ublk IO command.

Meantime add two ublk bpf callbacks for prog to attach & detach ublk
device.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk/Makefile  |  2 +-
 drivers/block/ublk/bpf.c     | 99 ++++++++++++++++++++++++++++++++++++
 drivers/block/ublk/bpf.h     | 33 ++++++++++++
 drivers/block/ublk/bpf_ops.c | 34 +++++++++++++
 drivers/block/ublk/main.c    | 25 ++++++---
 drivers/block/ublk/ublk.h    | 16 ++++++
 6 files changed, 200 insertions(+), 9 deletions(-)
 create mode 100644 drivers/block/ublk/bpf.c

diff --git a/drivers/block/ublk/Makefile b/drivers/block/ublk/Makefile
index 7058b0fc13bf..f843a9005cdb 100644
--- a/drivers/block/ublk/Makefile
+++ b/drivers/block/ublk/Makefile
@@ -5,6 +5,6 @@ ccflags-y			+= -I$(src)
 
 ublk_drv-$(CONFIG_BLK_DEV_UBLK)	:= main.o
 ifeq ($(CONFIG_UBLK_BPF), y)
-ublk_drv-$(CONFIG_BLK_DEV_UBLK)	+= bpf_ops.o
+ublk_drv-$(CONFIG_BLK_DEV_UBLK)	+= bpf_ops.o bpf.o
 endif
 obj-$(CONFIG_BLK_DEV_UBLK)	+= ublk_drv.o
diff --git a/drivers/block/ublk/bpf.c b/drivers/block/ublk/bpf.c
new file mode 100644
index 000000000000..479045a5f0d9
--- /dev/null
+++ b/drivers/block/ublk/bpf.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Red Hat */
+
+#include "ublk.h"
+#include "bpf.h"
+
+static int ublk_set_bpf_ops(struct ublk_device *ub,
+		struct ublk_bpf_ops *ops)
+{
+	int i;
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		if (ops && ublk_get_queue(ub, i)->bpf_ops) {
+			ublk_set_bpf_ops(ub, NULL);
+			return -EBUSY;
+		}
+		ublk_get_queue(ub, i)->bpf_ops = ops;
+	}
+	return 0;
+}
+
+static int ublk_bpf_prog_attach_cb(struct bpf_prog_consumer *consumer,
+				   struct bpf_prog_provider *provider)
+{
+	struct ublk_device *ub = container_of(consumer, struct ublk_device,
+					      prog);
+	struct ublk_bpf_ops *ops = container_of(provider,
+			struct ublk_bpf_ops, provider);
+	int ret;
+
+	if (!ublk_get_device(ub))
+		return -ENODEV;
+
+	ret = ublk_set_bpf_ops(ub, ops);
+	if (ret)
+		goto fail_put_dev;
+
+	if (ops->attach_dev) {
+		ret = ops->attach_dev(ub->dev_info.dev_id);
+		if (ret)
+			goto fail_reset_ops;
+	}
+	return 0;
+
+fail_reset_ops:
+	ublk_set_bpf_ops(ub, NULL);
+fail_put_dev:
+	ublk_put_device(ub);
+	return ret;
+}
+
+static void ublk_bpf_prog_detach_cb(struct bpf_prog_consumer *consumer,
+				    bool unreg)
+{
+	struct ublk_device *ub = container_of(consumer, struct ublk_device,
+					      prog);
+	struct ublk_bpf_ops *ops = container_of(consumer->provider,
+			struct ublk_bpf_ops, provider);
+
+	if (unreg) {
+		blk_mq_freeze_queue(ub->ub_disk->queue);
+		ublk_set_bpf_ops(ub, NULL);
+		blk_mq_unfreeze_queue(ub->ub_disk->queue);
+	} else {
+		ublk_set_bpf_ops(ub, NULL);
+	}
+	if (ops->detach_dev)
+		ops->detach_dev(ub->dev_info.dev_id);
+	ublk_put_device(ub);
+}
+
+static const struct bpf_prog_consumer_ops ublk_prog_consumer_ops = {
+	.attach_fn	= ublk_bpf_prog_attach_cb,
+	.detach_fn	= ublk_bpf_prog_detach_cb,
+};
+
+int ublk_bpf_attach(struct ublk_device *ub)
+{
+	if (!ublk_dev_support_bpf(ub))
+		return 0;
+
+	/* todo: ublk device need to provide struct_ops prog id */
+	ub->prog.prog_id = 0;
+	ub->prog.ops = &ublk_prog_consumer_ops;
+
+	return ublk_bpf_prog_attach(&ub->prog);
+}
+
+void ublk_bpf_detach(struct ublk_device *ub)
+{
+	if (!ublk_dev_support_bpf(ub))
+		return;
+	ublk_bpf_prog_detach(&ub->prog);
+}
+
+int __init ublk_bpf_init(void)
+{
+	return ublk_bpf_struct_ops_init();
+}
diff --git a/drivers/block/ublk/bpf.h b/drivers/block/ublk/bpf.h
index e3505c9ab86a..4e178cbecb74 100644
--- a/drivers/block/ublk/bpf.h
+++ b/drivers/block/ublk/bpf.h
@@ -7,6 +7,8 @@
 typedef unsigned long ublk_bpf_return_t;
 typedef ublk_bpf_return_t (*queue_io_cmd_t)(struct ublk_bpf_io *io, unsigned int);
 typedef void (*release_io_cmd_t)(struct ublk_bpf_io *io);
+typedef int (*attach_dev_t)(int dev_id);
+typedef void (*detach_dev_t)(int dev_id);
 
 #ifdef CONFIG_UBLK_BPF
 #include <linux/filter.h>
@@ -47,6 +49,12 @@ struct ublk_bpf_ops {
 	/* called when the io command reference drops to zero, can't be sleepable */
 	release_io_cmd_t	release_io_cmd;
 
+	/* called when attaching bpf prog to this ublk dev */
+	attach_dev_t		attach_dev;
+
+	/* called when detaching bpf prog from this ublk dev */
+	detach_dev_t		detach_dev;
+
 	/* private: don't show in doc, must be the last field */
 	struct bpf_prog_provider	provider;
 };
@@ -149,7 +157,12 @@ static inline queue_io_cmd_t ublk_get_bpf_any_io_cb(struct ublk_queue *ubq)
 	return ublk_get_bpf_io_cb_daemon(ubq);
 }
 
+int ublk_bpf_init(void);
 int ublk_bpf_struct_ops_init(void);
+int ublk_bpf_prog_attach(struct bpf_prog_consumer *consumer);
+void ublk_bpf_prog_detach(struct bpf_prog_consumer *consumer);
+int ublk_bpf_attach(struct ublk_device *ub);
+void ublk_bpf_detach(struct ublk_device *ub);
 
 #else
 
@@ -176,9 +189,29 @@ static inline queue_io_cmd_t ublk_get_bpf_any_io_cb(struct ublk_queue *ubq)
 	return NULL;
 }
 
+static inline int ublk_bpf_init(void)
+{
+	return 0;
+}
+
 static inline int ublk_bpf_struct_ops_init(void)
 {
 	return 0;
 }
+
+static inline int ublk_bpf_prog_attach(struct bpf_prog_consumer *consumer)
+{
+	return 0;
+}
+static inline void ublk_bpf_prog_detach(struct bpf_prog_consumer *consumer)
+{
+}
+static inline int ublk_bpf_attach(struct ublk_device *ub)
+{
+	return 0;
+}
+static inline void ublk_bpf_detach(struct ublk_device *ub)
+{
+}
 #endif
 #endif
diff --git a/drivers/block/ublk/bpf_ops.c b/drivers/block/ublk/bpf_ops.c
index 6ac2aebd477e..05d8d415b30d 100644
--- a/drivers/block/ublk/bpf_ops.c
+++ b/drivers/block/ublk/bpf_ops.c
@@ -133,6 +133,29 @@ static void ublk_bpf_unreg(void *kdata, struct bpf_link *link)
 	kfree(curr);
 }
 
+int ublk_bpf_prog_attach(struct bpf_prog_consumer *consumer)
+{
+	unsigned id = consumer->prog_id;
+	struct ublk_bpf_ops *ops;
+	int ret = -EINVAL;
+
+	mutex_lock(&ublk_bpf_ops_lock);
+	ops = xa_load(&ublk_ops, id);
+	if (ops && ops->id == id)
+		ret = bpf_prog_consumer_attach(consumer, &ops->provider);
+	mutex_unlock(&ublk_bpf_ops_lock);
+
+	return ret;
+}
+
+void ublk_bpf_prog_detach(struct bpf_prog_consumer *consumer)
+{
+	mutex_lock(&ublk_bpf_ops_lock);
+	bpf_prog_consumer_detach(consumer, false);
+	mutex_unlock(&ublk_bpf_ops_lock);
+}
+
+
 static void ublk_bpf_prep_io(struct ublk_bpf_io *io,
 		const struct ublksrv_io_desc *iod)
 {
@@ -231,10 +254,21 @@ static void ublk_bpf_release_io_cmd(struct ublk_bpf_io *io)
 {
 }
 
+static int ublk_bpf_attach_dev(int dev_id)
+{
+	return 0;
+}
+
+static void ublk_bpf_detach_dev(int dev_id)
+{
+}
+
 static struct ublk_bpf_ops __bpf_ublk_bpf_ops = {
 	.queue_io_cmd = ublk_bpf_queue_io_cmd,
 	.queue_io_cmd_daemon = ublk_bpf_run_io_task,
 	.release_io_cmd = ublk_bpf_release_io_cmd,
+	.attach_dev	= ublk_bpf_attach_dev,
+	.detach_dev	= ublk_bpf_detach_dev,
 };
 
 static struct bpf_struct_ops bpf_ublk_bpf_ops = {
diff --git a/drivers/block/ublk/main.c b/drivers/block/ublk/main.c
index 29d3e7f656a7..0b136bc5247f 100644
--- a/drivers/block/ublk/main.c
+++ b/drivers/block/ublk/main.c
@@ -486,7 +486,7 @@ static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
 }
 
 /* Called in slow path only, keep it noinline for trace purpose */
-static noinline struct ublk_device *ublk_get_device(struct ublk_device *ub)
+struct ublk_device *ublk_get_device(struct ublk_device *ub)
 {
 	if (kobject_get_unless_zero(&ub->cdev_dev.kobj))
 		return ub;
@@ -499,12 +499,6 @@ void ublk_put_device(struct ublk_device *ub)
 	put_device(&ub->cdev_dev);
 }
 
-static inline struct ublk_queue *ublk_get_queue(struct ublk_device *dev,
-		int qid)
-{
-       return (struct ublk_queue *)&(dev->__queues[qid * dev->queue_size]);
-}
-
 static inline bool ublk_rq_has_data(const struct request *rq)
 {
 	return bio_has_data(rq->bio);
@@ -1492,6 +1486,8 @@ static struct gendisk *ublk_detach_disk(struct ublk_device *ub)
 {
 	struct gendisk *disk;
 
+	ublk_bpf_detach(ub);
+
 	/* Sync with ublk_abort_queue() by holding the lock */
 	spin_lock(&ub->lock);
 	disk = ub->ub_disk;
@@ -2206,12 +2202,19 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 			goto out_put_cdev;
 	}
 
-	ret = add_disk(disk);
+	ret = ublk_bpf_attach(ub);
 	if (ret)
 		goto out_put_cdev;
 
+	ret = add_disk(disk);
+	if (ret)
+		goto out_put_bpf;
+
 	set_bit(UB_STATE_USED, &ub->state);
 
+out_put_bpf:
+	if (ret)
+		ublk_bpf_detach(ub);
 out_put_cdev:
 	if (ret) {
 		ublk_detach_disk(ub);
@@ -2967,8 +2970,14 @@ static int __init ublk_init(void)
 	if (ret)
 		goto free_chrdev_region;
 
+	ret = ublk_bpf_init();
+	if (ret)
+		goto unregister_class;
+
 	return 0;
 
+unregister_class:
+	class_unregister(&ublk_chr_class);
 free_chrdev_region:
 	unregister_chrdev_region(ublk_chr_devt, UBLK_MINORS);
 unregister_mis:
diff --git a/drivers/block/ublk/ublk.h b/drivers/block/ublk/ublk.h
index e9ceadbc616d..7579b0032a3c 100644
--- a/drivers/block/ublk/ublk.h
+++ b/drivers/block/ublk/ublk.h
@@ -7,6 +7,8 @@
 #include <linux/cdev.h>
 #include <uapi/linux/ublk_cmd.h>
 
+#include "bpf_reg.h"
+
 #define UBLK_MINORS		(1U << MINORBITS)
 
 /* private ioctl command mirror */
@@ -153,6 +155,9 @@ struct ublk_device {
 	unsigned long		state;
 	int			ub_number;
 
+#ifdef CONFIG_UBLK_BPF
+	struct bpf_prog_consumer prog;
+#endif
 	struct mutex		mutex;
 
 	spinlock_t		lock;
@@ -173,6 +178,11 @@ struct ublk_params_header {
 	__u32	types;
 };
 
+static inline struct ublk_queue *ublk_get_queue(struct ublk_device *dev,
+		int qid)
+{
+       return (struct ublk_queue *)&(dev->__queues[qid * dev->queue_size]);
+}
 
 static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
 		int tag)
@@ -186,6 +196,12 @@ static inline bool ublk_support_bpf(const struct ublk_queue *ubq)
 	return false;
 }
 
+static inline bool ublk_dev_support_bpf(const struct ublk_device *ub)
+{
+	return false;
+}
+
+struct ublk_device *ublk_get_device(struct ublk_device *ub);
 struct ublk_device *ublk_get_device_from_id(int idx);
 void ublk_put_device(struct ublk_device *ub);
 void __ublk_complete_rq(struct request *req);
-- 
2.47.0


