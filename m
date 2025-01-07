Return-Path: <bpf+bounces-48073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52524A03EA2
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21E0164C11
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA1D1F03D1;
	Tue,  7 Jan 2025 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T00pvf3D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538E01E633C;
	Tue,  7 Jan 2025 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251702; cv=none; b=raTnVibM21W+Pq247vttSDk60ChNwn9Zk8sGpRQhPUs92EYV3FqwrnBiHzT1UeTjlVIzQ412acb3+spkhmXY+pAQgesVlz40L4WVYFhffa/vNMpSziYgajTnH0WTe5WexqelE1glE/KxJxr4oVEdlO3Egg9QNs3JRtMuXArUcas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251702; c=relaxed/simple;
	bh=+w6vfnNIOAsGGzyADWtv6PequakMaBaQyMrXmjHxk5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhdqBECg3s5hGXvt+W2GCn/yFyvje32Zg2UF52tI9GP69Rwm5t3Zb5edqlfvFjqI/+z3jzIoiaAXOGW3Cow2BBQm8ynjWAX0503Omu2bORcPd4i5abRyhzqNgd+35fYdTH8sgW1BOmsMuZHw+f5d3cd8EwGVd4O0hm7NGfom6b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T00pvf3D; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2162c0f6a39so232873235ad.0;
        Tue, 07 Jan 2025 04:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251690; x=1736856490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5rVHdH2toybo/cyBeNRe7L6eC3QpRQ56FS/o4CoUgg=;
        b=T00pvf3DNlCJGbqop6nogaVDpV+izttUCj2GlLj6Q2Fqg/FRLEl1ydnDIxEAQjdAw0
         +ge8tBcNroKahfEnYOD/LR7gGM+NDHDcpVmrq+BX8wG2zkGR70uh9kCFoeeXwSEHSmib
         aVCsf1fUFL4vhN6pAZZ2J/bwDUZfiRhl6ZEk22WhQXay+ErgK6Y2Rn08/jA5dfwgKSex
         lhECxFCZ8J/q1Jsq5uiqyWzhKWaDrwYGmtKGIVdMVjPO1FUO52ICkForMleHtMDXoFvI
         SO2v0T0XUmkHryAIfOUhIJc0lYQERWHpK/FKiu/73tNrthzloeC41vJd2Vak7mfs/neh
         jypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251690; x=1736856490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5rVHdH2toybo/cyBeNRe7L6eC3QpRQ56FS/o4CoUgg=;
        b=eglaXqgjnCV2IuL6v1MkfnIKxDFXJWUgV9iIEF5GiGFY9LajHgz8bho6cdyPejoRby
         D60PW2K7O5DkM7dkOut3LHNXpdZFhcVsXrcMoTLM86BDhWudZIBk3vEzxZOoV2YCJhUw
         zZsLal5t/ucu8IwHi7TzOAaYCZjmF1HXVVdnjFxViCi9rJFgBX6A5ypo9FCBS4VZTWiq
         DFcpHj6sBXGM2qI3LNIcD5k8tchcN7Dsl6Fb2jOqm98mDDM4FeHjilQvAMHVIrY5xcFS
         L0ANzQQ5aw+i6udc51hEafLLyxfjqSWkJ9T4+WmX8V5H8UQ+ggfQKuVY1NhMvB+nduU+
         YbVg==
X-Forwarded-Encrypted: i=1; AJvYcCWHIoBpOHqGm54M9ohPna9vWrs2+h2mu62vTV/9O5yAQqYyNsqR97jJ98YYEOU+DviTJsr2BHyC0M1Nnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuLqPjEg2HClXe8Xmgp5zPDaAq3ciIM57dRh82XFrORfmWTGoa
	jnvCm0Z7bwg/BUZRBE3nw/PdPBtqB0LdKCLeqze67r1j9t0+xZnv
X-Gm-Gg: ASbGncuoV6Rw8Vzz2mGapZv4etMM4136O4qbpzph17CMmMbjxw4t2nNGRjnzT+zJcB3
	qlSS8TrFDDHcWKUIB8aNdKGi7c6P0QJmvahuLTIGnBqMdSx4OaqLVejXdwIBJVu1E7J6/3wc5te
	HjfPhNzVT2Q+sVymj7tXgcqsm9eCsEayujNUME1MEnuS4VHYs5jjhRH35oKWPwEhJdc6x1/vpNl
	eN/cCvsWuND8CnosXG0n34shvaz1m9cHYSr96c62e+bWp0FLdkOh7ZL1fQAbAoKug5J
X-Google-Smtp-Source: AGHT+IFr1d4pwqLkSCGFFQm9QKDqDv3wd+SOHJxuD+sYVAabFB2Hslc9uE3oYjnCZhjGR4XE+k4XHQ==
X-Received: by 2002:a05:6a21:9211:b0:1e1:b0e8:11dc with SMTP id adf61e73a8af0-1e745ce0e21mr4577306637.21.1736251690088;
        Tue, 07 Jan 2025 04:08:10 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:08:09 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 05/22] ublk: move private definitions into private header
Date: Tue,  7 Jan 2025 20:03:56 +0800
Message-ID: <20250107120417.1237392-6-tom.leiming@gmail.com>
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

Add one private header file and move private definitions into this
file.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk/main.c | 150 +-----------------------------------
 drivers/block/ublk/ublk.h | 157 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 158 insertions(+), 149 deletions(-)
 create mode 100644 drivers/block/ublk/ublk.h

diff --git a/drivers/block/ublk/main.c b/drivers/block/ublk/main.c
index 1a63a1aa99ed..2510193303bb 100644
--- a/drivers/block/ublk/main.c
+++ b/drivers/block/ublk/main.c
@@ -19,7 +19,6 @@
 #include <linux/errno.h>
 #include <linux/major.h>
 #include <linux/wait.h>
-#include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
@@ -35,162 +34,15 @@
 #include <linux/ioprio.h>
 #include <linux/sched/mm.h>
 #include <linux/uaccess.h>
-#include <linux/cdev.h>
 #include <linux/io_uring/cmd.h>
-#include <linux/blk-mq.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
 #include <asm/page.h>
 #include <linux/task_work.h>
 #include <linux/namei.h>
 #include <linux/kref.h>
-#include <uapi/linux/ublk_cmd.h>
-
-#define UBLK_MINORS		(1U << MINORBITS)
-
-/* private ioctl command mirror */
-#define UBLK_CMD_DEL_DEV_ASYNC	_IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
-
-/* All UBLK_F_* have to be included into UBLK_F_ALL */
-#define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY \
-		| UBLK_F_URING_CMD_COMP_IN_TASK \
-		| UBLK_F_NEED_GET_DATA \
-		| UBLK_F_USER_RECOVERY \
-		| UBLK_F_USER_RECOVERY_REISSUE \
-		| UBLK_F_UNPRIVILEGED_DEV \
-		| UBLK_F_CMD_IOCTL_ENCODE \
-		| UBLK_F_USER_COPY \
-		| UBLK_F_ZONED \
-		| UBLK_F_USER_RECOVERY_FAIL_IO)
-
-#define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
-		| UBLK_F_USER_RECOVERY_REISSUE \
-		| UBLK_F_USER_RECOVERY_FAIL_IO)
-
-/* All UBLK_PARAM_TYPE_* should be included here */
-#define UBLK_PARAM_TYPE_ALL                                \
-	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
-	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED)
-
-struct ublk_rq_data {
-	struct llist_node node;
-
-	struct kref ref;
-};
-
-struct ublk_uring_cmd_pdu {
-	struct ublk_queue *ubq;
-	u16 tag;
-};
-
-/*
- * io command is active: sqe cmd is received, and its cqe isn't done
- *
- * If the flag is set, the io command is owned by ublk driver, and waited
- * for incoming blk-mq request from the ublk block device.
- *
- * If the flag is cleared, the io command will be completed, and owned by
- * ublk server.
- */
-#define UBLK_IO_FLAG_ACTIVE	0x01
-
-/*
- * IO command is completed via cqe, and it is being handled by ublksrv, and
- * not committed yet
- *
- * Basically exclusively with UBLK_IO_FLAG_ACTIVE, so can be served for
- * cross verification
- */
-#define UBLK_IO_FLAG_OWNED_BY_SRV 0x02
-
-/*
- * IO command is aborted, so this flag is set in case of
- * !UBLK_IO_FLAG_ACTIVE.
- *
- * After this flag is observed, any pending or new incoming request
- * associated with this io command will be failed immediately
- */
-#define UBLK_IO_FLAG_ABORTED 0x04
-
-/*
- * UBLK_IO_FLAG_NEED_GET_DATA is set because IO command requires
- * get data buffer address from ublksrv.
- *
- * Then, bio data could be copied into this data buffer for a WRITE request
- * after the IO command is issued again and UBLK_IO_FLAG_NEED_GET_DATA is unset.
- */
-#define UBLK_IO_FLAG_NEED_GET_DATA 0x08
-
-/* atomic RW with ubq->cancel_lock */
-#define UBLK_IO_FLAG_CANCELED	0x80000000
 
-struct ublk_io {
-	/* userspace buffer address from io cmd */
-	__u64	addr;
-	unsigned int flags;
-	int res;
-
-	struct io_uring_cmd *cmd;
-};
-
-struct ublk_queue {
-	int q_id;
-	int q_depth;
-
-	unsigned long flags;
-	struct task_struct	*ubq_daemon;
-	char *io_cmd_buf;
-
-	struct llist_head	io_cmds;
-
-	unsigned short force_abort:1;
-	unsigned short timeout:1;
-	unsigned short canceling:1;
-	unsigned short fail_io:1; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
-	unsigned short nr_io_ready;	/* how many ios setup */
-	spinlock_t		cancel_lock;
-	struct ublk_device *dev;
-	struct ublk_io ios[];
-};
-
-struct ublk_device {
-	struct gendisk		*ub_disk;
-
-	char	*__queues;
-
-	unsigned int	queue_size;
-	struct ublksrv_ctrl_dev_info	dev_info;
-
-	struct blk_mq_tag_set	tag_set;
-
-	struct cdev		cdev;
-	struct device		cdev_dev;
-
-#define UB_STATE_OPEN		0
-#define UB_STATE_USED		1
-#define UB_STATE_DELETED	2
-	unsigned long		state;
-	int			ub_number;
-
-	struct mutex		mutex;
-
-	spinlock_t		lock;
-	struct mm_struct	*mm;
-
-	struct ublk_params	params;
-
-	struct completion	completion;
-	unsigned int		nr_queues_ready;
-	unsigned int		nr_privileged_daemon;
-
-	struct work_struct	nosrv_work;
-};
-
-/* header of ublk_params */
-struct ublk_params_header {
-	__u32	len;
-	__u32	types;
-};
+#include "ublk.h"
 
 static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq);
 
diff --git a/drivers/block/ublk/ublk.h b/drivers/block/ublk/ublk.h
new file mode 100644
index 000000000000..12e39a33015a
--- /dev/null
+++ b/drivers/block/ublk/ublk.h
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#ifndef UBLK_INTERNAL_HEADER
+#define UBLK_INTERNAL_HEADER
+
+#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
+#include <linux/cdev.h>
+#include <uapi/linux/ublk_cmd.h>
+
+#define UBLK_MINORS		(1U << MINORBITS)
+
+/* private ioctl command mirror */
+#define UBLK_CMD_DEL_DEV_ASYNC	_IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
+
+/* All UBLK_F_* have to be included into UBLK_F_ALL */
+#define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY \
+		| UBLK_F_URING_CMD_COMP_IN_TASK \
+		| UBLK_F_NEED_GET_DATA \
+		| UBLK_F_USER_RECOVERY \
+		| UBLK_F_USER_RECOVERY_REISSUE \
+		| UBLK_F_UNPRIVILEGED_DEV \
+		| UBLK_F_CMD_IOCTL_ENCODE \
+		| UBLK_F_USER_COPY \
+		| UBLK_F_ZONED \
+		| UBLK_F_USER_RECOVERY_FAIL_IO)
+
+#define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
+		| UBLK_F_USER_RECOVERY_REISSUE \
+		| UBLK_F_USER_RECOVERY_FAIL_IO)
+
+/* All UBLK_PARAM_TYPE_* should be included here */
+#define UBLK_PARAM_TYPE_ALL                                \
+	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
+	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED)
+
+struct ublk_rq_data {
+	struct llist_node node;
+
+	struct kref ref;
+};
+
+struct ublk_uring_cmd_pdu {
+	struct ublk_queue *ubq;
+	u16 tag;
+};
+
+/*
+ * io command is active: sqe cmd is received, and its cqe isn't done
+ *
+ * If the flag is set, the io command is owned by ublk driver, and waited
+ * for incoming blk-mq request from the ublk block device.
+ *
+ * If the flag is cleared, the io command will be completed, and owned by
+ * ublk server.
+ */
+#define UBLK_IO_FLAG_ACTIVE	0x01
+
+/*
+ * IO command is completed via cqe, and it is being handled by ublksrv, and
+ * not committed yet
+ *
+ * Basically exclusively with UBLK_IO_FLAG_ACTIVE, so can be served for
+ * cross verification
+ */
+#define UBLK_IO_FLAG_OWNED_BY_SRV 0x02
+
+/*
+ * IO command is aborted, so this flag is set in case of
+ * !UBLK_IO_FLAG_ACTIVE.
+ *
+ * After this flag is observed, any pending or new incoming request
+ * associated with this io command will be failed immediately
+ */
+#define UBLK_IO_FLAG_ABORTED 0x04
+
+/*
+ * UBLK_IO_FLAG_NEED_GET_DATA is set because IO command requires
+ * get data buffer address from ublksrv.
+ *
+ * Then, bio data could be copied into this data buffer for a WRITE request
+ * after the IO command is issued again and UBLK_IO_FLAG_NEED_GET_DATA is unset.
+ */
+#define UBLK_IO_FLAG_NEED_GET_DATA 0x08
+
+/* atomic RW with ubq->cancel_lock */
+#define UBLK_IO_FLAG_CANCELED	0x80000000
+
+struct ublk_io {
+	/* userspace buffer address from io cmd */
+	__u64	addr;
+	unsigned int flags;
+	int res;
+
+	struct io_uring_cmd *cmd;
+};
+
+struct ublk_queue {
+	int q_id;
+	int q_depth;
+
+	unsigned long flags;
+	struct task_struct	*ubq_daemon;
+	char *io_cmd_buf;
+
+	struct llist_head	io_cmds;
+
+	unsigned short force_abort:1;
+	unsigned short timeout:1;
+	unsigned short canceling:1;
+	unsigned short fail_io:1; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
+	unsigned short nr_io_ready;	/* how many ios setup */
+	spinlock_t		cancel_lock;
+	struct ublk_device *dev;
+	struct ublk_io ios[];
+};
+
+struct ublk_device {
+	struct gendisk		*ub_disk;
+
+	char	*__queues;
+
+	unsigned int	queue_size;
+	struct ublksrv_ctrl_dev_info	dev_info;
+
+	struct blk_mq_tag_set	tag_set;
+
+	struct cdev		cdev;
+	struct device		cdev_dev;
+
+#define UB_STATE_OPEN		0
+#define UB_STATE_USED		1
+#define UB_STATE_DELETED	2
+	unsigned long		state;
+	int			ub_number;
+
+	struct mutex		mutex;
+
+	spinlock_t		lock;
+	struct mm_struct	*mm;
+
+	struct ublk_params	params;
+
+	struct completion	completion;
+	unsigned int		nr_queues_ready;
+	unsigned int		nr_privileged_daemon;
+
+	struct work_struct	nosrv_work;
+};
+
+/* header of ublk_params */
+struct ublk_params_header {
+	__u32	len;
+	__u32	types;
+};
+
+
+#endif
-- 
2.47.0


