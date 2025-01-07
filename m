Return-Path: <bpf+bounces-48076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 512B4A03EA9
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E4B16442F
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F761F03C5;
	Tue,  7 Jan 2025 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VriRcPjo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3431EE7BB;
	Tue,  7 Jan 2025 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251718; cv=none; b=VeTuTKo7Kj+bictEogWA5Ihp+uHEf0rhQQPmzR3en6wKKMXKmpu7IH1NwR6tOuqizwwoJMFrMqDpPic1+YHWdlZiAvDQbICLifCZhpwvt/p9/72pcr4xA7KJ+3wxjwb38yGQNlCGmIdN6fqsSxnWPKsWBgeM+TWlRdYYK0xt878=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251718; c=relaxed/simple;
	bh=u0GtLfmQGUEfx5RJXT7SHBRXTxZavPgYb3DiQyrE32g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJ09Uy72Zt1zP/3Pwa4la6QgzJtsReK8WUwVzkdA3E9G3Tut9v1i7Fl+y74robm2ALLk4tzKJTctnFizpS5ZbgTQWpWK6wWTVIkJgMUzmXQZKM4P8DKev1xaBjnzMZPkTL41GeVT121NRW+rEwp58QzeT/Gf/BabEpb/lPevqzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VriRcPjo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21628b3fe7dso218295135ad.3;
        Tue, 07 Jan 2025 04:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251700; x=1736856500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SxNlHBwGatFKyZh1YrXFFqd/Sw71g3y4E/dnODeXAw=;
        b=VriRcPjo2EO3y7m9YhkIQc0kKH1mE7WJgP0lbvRK+HOLZtEM69ZlvXJdDjAUGHH1Qo
         EamcceRrqtQxcDTz0vRIkUbPBQwi4IJwr+Eqr9ahnyZu0Aao6SsFSR2k3fJUS1IZKUeN
         Ym5SLLt1DUvumvBtMwIFqvoCAr5TI9GdiRWoYGCZUqFHZP2tH/grXHAN7UNweuZeHEUL
         O7jOUuJJZREA6cy7cH5dh7HpukL+wHBd7AnBHYJqo7LSBCbIPjfF9GUc8GgfVut/h75x
         vURhr6Qltx6nRnoo6JerbTp9HUVs1nVF9yTuxlrPhKs+0VlIKXKtDNSJs7Yqqxut+v2+
         GEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251700; x=1736856500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SxNlHBwGatFKyZh1YrXFFqd/Sw71g3y4E/dnODeXAw=;
        b=V2JwA9pZwjEFuQuFLh7qXlZiCb85yCdgYIMHGdmLrei9g6yGfxXL/UVo1RMISdfpF4
         tOR0Ikx/NoJhZ+yuNxsSLyqHlhQ61rfwFcGB+bUS2Tjc6Y1myIiwqpUMcwvtF1ZqFo9V
         ompHo7vvYY4F6uqGxGLEKmYVTn5kz/mqYd2BA5LDhjP7d/b1rYSWMusmzxhaI4uIfeXI
         WpBSSQdubSoDyUBMO8EziS/Pq077ShTmeEA2HwnohswmS8fMv7tEWHwmtsYOvx0tNvWD
         eTiYqGd5Dn+dGlwm1rUKkit+yh7A9Mtds+r3IaR8YoB3O256WBQyfnG1XdydIR4+6MuV
         ECgA==
X-Forwarded-Encrypted: i=1; AJvYcCXABYfqe2l7NYoMKWaxEmI/LTDGjsUr3MKvoTDnyiM7+5MNqvDcQgOp4DEbT2/hGm0qNIf0MKJJE5RTRg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Sx+ic8+1aR1wgFKFpUXSZJTaqCsf0W5krIq6HQOIHU3ptShx
	2PsmxRpxdB6eu1+9On/Bv7n6cIJzdeR30ACKRyvOvC/38Ohv1KO3
X-Gm-Gg: ASbGncvz2tG3/vkveGSTsuJNbxmRTCTx9qBF8Lel2iEFaP+wMWKkg1ycPZ3Doq2dTF4
	Vry6tWIOXUP1x5MrP0qbzYf/vDoX9nxxPJF/I0plIUSF8J9HmZ6PaXaTCxj+wajONMNOkLLgiRE
	aVq6m3/7jD91wy+LzR8RRDrCh/W2Ol0l3ElWJz78NuxxGXkY3o2xW6sf8GV2rhx4ZF2GtBtWxpR
	i+gnMlzAbF5kQA/nt3iUy3Q0Zpad0lVZ5DUlID5Sgt74taEyFcdwqJJRj9TvUsYSFbG
X-Google-Smtp-Source: AGHT+IEhaylrPRTNtO3wFMYD29Rk/aijozZgikBVkn5Ht+Ts8WhoNQYAiteilc2iDOwyVJSZwxrfJQ==
X-Received: by 2002:a05:6a20:7288:b0:1e1:aa24:2e5c with SMTP id adf61e73a8af0-1e5e083f156mr89926543637.38.1736251699700;
        Tue, 07 Jan 2025 04:08:19 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:08:19 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 08/22] ublk: bpf: add bpf struct_ops
Date: Tue,  7 Jan 2025 20:03:59 +0800
Message-ID: <20250107120417.1237392-9-tom.leiming@gmail.com>
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

Add struct_ops support for ublk, so we can use struct_ops bpf prog to handle
ublk IO command with application defined struct_ops.

Follows the motivation for ublk-bpf:

1) support stacking ublk

- there are many 3rd party volume manager, ublk may be built over ublk
device for simplifying implementation, however, multiple userspace-kernel
context switch for handling one single IO can't be accepted from performance
view of point

- ublk-bpf can avoid user-kernel context switch in most fast io path, so
makes ublk over ublk possible

2) complicated virtual block device

- many complicated virtual block devices have admin&meta code path and
normal io fast path; meta & admin IO handling is usually complicated, so
it can be moved to userspace for relieving development burden; meantime
IO fast path can be kept in kernel space for the sake of high performance.

- bpf provides rich maps, which can help a lot for communication between
userspace and prog or between prog and prog.

- one typical example is qcow2, which meta io handling can be moved to
userspace, and fast io path is implemented with ublk-bpf in which one
efficient bpf map can be looked up first and see if this virtual LBA &
host LBA is found in the map, handle the IO with ublk-bpf if the mapping
is hit, otherwise forward to userspace to deal with meta IO.

3) some simple high performance virtual devices

- such as null & loop, the whole implementation can be done in bpf prog

Export `struct ublk_bpf_ops` as bpf struct_ops, so that bpf prog can
implement callbacks for handling ublk io commands:

- if `UBLK_BPF_IO_QUEUED` is returned from ->queue_io_cmd() or
  ->queue_io_cmd_daemon(), this io command has been queued in bpf prog,
  so it won't be forwarded to userspace

- if `UBLK_BPF_IO_REDIRECT` is returned from ->queue_io_cmd() or
  ->queue_io_cmd_daemon(), this io command will be forwarded to userspace

- if `UBLK_BPF_IO_CONTINUE` is returned from ->queue_io_cmd() or
  ->queue_io_cmd_daemon(), part of this io command is queued, and
  `ublk_bpf_return_t` carries how many bytes queued, so ublk driver will
  continue to call the callback to queue remained bytes of this io command
  further, this way is helpful for implementing stacking devices by
  splitting io command.

Also ->release_io_cmd() is added for providing chance to notify bpf prog
that this io command is going to be released.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk/Kconfig   |  16 +++
 drivers/block/ublk/Makefile  |   3 +
 drivers/block/ublk/bpf.h     | 184 ++++++++++++++++++++++++
 drivers/block/ublk/bpf_ops.c | 261 +++++++++++++++++++++++++++++++++++
 drivers/block/ublk/main.c    |  29 +++-
 drivers/block/ublk/ublk.h    |  33 +++++
 6 files changed, 524 insertions(+), 2 deletions(-)
 create mode 100644 drivers/block/ublk/bpf.h
 create mode 100644 drivers/block/ublk/bpf_ops.c

diff --git a/drivers/block/ublk/Kconfig b/drivers/block/ublk/Kconfig
index b06e3df09779..23aa97d51956 100644
--- a/drivers/block/ublk/Kconfig
+++ b/drivers/block/ublk/Kconfig
@@ -34,3 +34,19 @@ config BLKDEV_UBLK_LEGACY_OPCODES
 	  Say N if you don't want to support legacy command opcode. It is
 	  suggested to enable N if your application(ublk server) switches to
 	  ioctl command encoding.
+
+config UBLK_BPF
+	bool "UBLK-BPF support"
+	depends on BPF
+	depends on BLK_DEV_UBLK
+	help
+	This option allows to support eBPF programs on the UBLK subsystem.
+	eBPF programs can handle fast IO code path directly in kernel space,
+	and avoid to switch to ublk daemon userspace conext, meantime zero
+	copy can be supported directly.
+
+	Usually target code need to partition into two parts: fast io code path
+	which is run as eBPF prog in kernel context, and slow & complicated
+	meta/admin code path which is run in ublk daemon userspace context.
+	And use efficient bpf map for communication between user mode and
+	kernel bpf prog.
diff --git a/drivers/block/ublk/Makefile b/drivers/block/ublk/Makefile
index 30e06b74dd82..7058b0fc13bf 100644
--- a/drivers/block/ublk/Makefile
+++ b/drivers/block/ublk/Makefile
@@ -4,4 +4,7 @@
 ccflags-y			+= -I$(src)
 
 ublk_drv-$(CONFIG_BLK_DEV_UBLK)	:= main.o
+ifeq ($(CONFIG_UBLK_BPF), y)
+ublk_drv-$(CONFIG_BLK_DEV_UBLK)	+= bpf_ops.o
+endif
 obj-$(CONFIG_BLK_DEV_UBLK)	+= ublk_drv.o
diff --git a/drivers/block/ublk/bpf.h b/drivers/block/ublk/bpf.h
new file mode 100644
index 000000000000..e3505c9ab86a
--- /dev/null
+++ b/drivers/block/ublk/bpf.h
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#ifndef UBLK_INT_BPF_HEADER
+#define UBLK_INT_BPF_HEADER
+
+#include "bpf_reg.h"
+
+typedef unsigned long ublk_bpf_return_t;
+typedef ublk_bpf_return_t (*queue_io_cmd_t)(struct ublk_bpf_io *io, unsigned int);
+typedef void (*release_io_cmd_t)(struct ublk_bpf_io *io);
+
+#ifdef CONFIG_UBLK_BPF
+#include <linux/filter.h>
+
+/*
+ * enum ublk_bpf_disposition - how to dispose the bpf io command
+ *
+ * @UBLK_BPF_IO_QUEUED: io command queued completely by bpf prog, so this
+ * 	cmd needn't to be forwarded to ublk daemon any more
+ * @UBLK_BPF_IO_REDIRECT: io command can't be queued by bpf prog, so this
+ * 	cmd will be forwarded to ublk daemon
+ * @UBLK_BPF_IO_CONTINUE: io command is being queued, and can be disposed
+ * 	further by bpf prog, so bpf callback will be called further
+ */
+enum ublk_bpf_disposition {
+       UBLK_BPF_IO_QUEUED = 0,
+       UBLK_BPF_IO_REDIRECT,
+       UBLK_BPF_IO_CONTINUE,
+};
+
+/**
+ * struct ublk_bpf_ops - A BPF struct_ops of callbacks allowing to implement
+ * 			ublk target from bpf program
+ * @id: ops id
+ * @queue_io_cmd: callback for queuing io command in ublk io context
+ * @queue_io_cmd_daemon: callback for queuing io command in ublk daemon
+ */
+struct ublk_bpf_ops {
+	/* struct_ops id, used for ublk device to attach prog */
+	unsigned		id;
+
+	/* queue io command from ublk io context, can't be sleepable */
+	queue_io_cmd_t		queue_io_cmd;
+
+	/* queue io command from target io daemon context, can be sleepable */
+	queue_io_cmd_t		queue_io_cmd_daemon;
+
+	/* called when the io command reference drops to zero, can't be sleepable */
+	release_io_cmd_t	release_io_cmd;
+
+	/* private: don't show in doc, must be the last field */
+	struct bpf_prog_provider	provider;
+};
+
+#define UBLK_BPF_DISPOSITION_BITS	(4)
+#define UBLK_BPF_DISPOSITION_SHIFT	(BITS_PER_LONG - UBLK_BPF_DISPOSITION_BITS)
+
+static inline enum ublk_bpf_disposition ublk_bpf_get_disposition(ublk_bpf_return_t ret)
+{
+	return ret >> UBLK_BPF_DISPOSITION_SHIFT;
+}
+
+static inline unsigned int ublk_bpf_get_return_bytes(ublk_bpf_return_t ret)
+{
+	return ret & ((1UL << UBLK_BPF_DISPOSITION_SHIFT) - 1);
+}
+
+static inline ublk_bpf_return_t ublk_bpf_return_val(enum ublk_bpf_disposition rc,
+		unsigned int bytes)
+{
+	return (ublk_bpf_return_t) ((unsigned long)rc << UBLK_BPF_DISPOSITION_SHIFT) | bytes;
+}
+
+static inline struct request *ublk_bpf_get_req(const struct ublk_bpf_io *io)
+{
+	struct ublk_rq_data *data = container_of(io, struct ublk_rq_data, bpf_data);
+	struct request *req = blk_mq_rq_from_pdu(data);
+
+	return req;
+}
+
+static inline void ublk_bpf_io_dec_ref(struct ublk_bpf_io *io)
+{
+	if (refcount_dec_and_test(&io->ref)) {
+		struct request *req = ublk_bpf_get_req(io);
+
+		if (req->mq_hctx) {
+			const struct ublk_queue *ubq = req->mq_hctx->driver_data;
+
+			if (ubq->bpf_ops && ubq->bpf_ops->release_io_cmd)
+				ubq->bpf_ops->release_io_cmd(io);
+		}
+
+		if (test_bit(UBLK_BPF_IO_COMPLETED, &io->flags)) {
+			smp_rmb();
+			__clear_bit(UBLK_BPF_IO_PREP, &io->flags);
+			__ublk_complete_rq_with_res(req, io->res);
+		}
+	}
+}
+
+static inline void ublk_bpf_complete_io_cmd(struct ublk_bpf_io *io, int res)
+{
+	io->res = res;
+	smp_wmb();
+	set_bit(UBLK_BPF_IO_COMPLETED, &io->flags);
+	ublk_bpf_io_dec_ref(io);
+}
+
+
+bool ublk_run_bpf_handler(struct ublk_queue *ubq, struct request *req,
+			  queue_io_cmd_t cb);
+
+/*
+ * Return true if bpf prog handled this io command, otherwise return false
+ * so that this io command will be forwarded to userspace
+ */
+static inline bool ublk_run_bpf_prog(struct ublk_queue *ubq,
+				struct request *req,
+				queue_io_cmd_t cb,
+				bool fail_on_null)
+{
+	if (likely(cb))
+		return ublk_run_bpf_handler(ubq, req, cb);
+
+	/* bpf prog is un-registered */
+	if (fail_on_null && !ubq->bpf_ops) {
+		__ublk_complete_rq_with_res(req, -EOPNOTSUPP);
+		return true;
+	}
+
+	return false;
+}
+
+static inline queue_io_cmd_t ublk_get_bpf_io_cb(struct ublk_queue *ubq)
+{
+	return ubq->bpf_ops ? ubq->bpf_ops->queue_io_cmd : NULL;
+}
+
+static inline queue_io_cmd_t ublk_get_bpf_io_cb_daemon(struct ublk_queue *ubq)
+{
+	return ubq->bpf_ops ? ubq->bpf_ops->queue_io_cmd_daemon : NULL;
+}
+
+static inline queue_io_cmd_t ublk_get_bpf_any_io_cb(struct ublk_queue *ubq)
+{
+	if (ublk_get_bpf_io_cb(ubq))
+		return ublk_get_bpf_io_cb(ubq);
+
+	return ublk_get_bpf_io_cb_daemon(ubq);
+}
+
+int ublk_bpf_struct_ops_init(void);
+
+#else
+
+static inline bool ublk_run_bpf_prog(struct ublk_queue *ubq,
+				struct request *req,
+				queue_io_cmd_t cb,
+				bool fail_on_null)
+{
+	return false;
+}
+
+static inline queue_io_cmd_t ublk_get_bpf_io_cb(struct ublk_queue *ubq)
+{
+	return NULL;
+}
+
+static inline queue_io_cmd_t ublk_get_bpf_io_cb_daemon(struct ublk_queue *ubq)
+{
+	return NULL;
+}
+
+static inline queue_io_cmd_t ublk_get_bpf_any_io_cb(struct ublk_queue *ubq)
+{
+	return NULL;
+}
+
+static inline int ublk_bpf_struct_ops_init(void)
+{
+	return 0;
+}
+#endif
+#endif
diff --git a/drivers/block/ublk/bpf_ops.c b/drivers/block/ublk/bpf_ops.c
new file mode 100644
index 000000000000..6ac2aebd477e
--- /dev/null
+++ b/drivers/block/ublk/bpf_ops.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Red Hat */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/bpf_verifier.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/filter.h>
+#include <linux/xarray.h>
+
+#include "ublk.h"
+#include "bpf.h"
+
+static DEFINE_XARRAY(ublk_ops);
+static DEFINE_MUTEX(ublk_bpf_ops_lock);
+
+static bool ublk_bpf_ops_is_valid_access(int off, int size,
+					  enum bpf_access_type type,
+					  const struct bpf_prog *prog,
+					  struct bpf_insn_access_aux *info)
+{
+	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
+}
+
+static int ublk_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
+					   const struct bpf_reg_state *reg,
+					   int off, int size)
+{
+	/* ublk prog can change nothing */
+	if (size > 0)
+		return -EACCES;
+
+	return NOT_INIT;
+}
+
+static const struct bpf_verifier_ops ublk_bpf_verifier_ops = {
+	.get_func_proto = bpf_base_func_proto,
+	.is_valid_access = ublk_bpf_ops_is_valid_access,
+	.btf_struct_access = ublk_bpf_ops_btf_struct_access,
+};
+
+static int ublk_bpf_ops_init(struct btf *btf)
+{
+	return 0;
+}
+
+static int ublk_bpf_ops_check_member(const struct btf_type *t,
+				      const struct btf_member *member,
+				      const struct bpf_prog *prog)
+{
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct ublk_bpf_ops, queue_io_cmd):
+	case offsetof(struct ublk_bpf_ops, release_io_cmd):
+		if (prog->sleepable)
+			return -EINVAL;
+	case offsetof(struct ublk_bpf_ops, queue_io_cmd_daemon):
+		break;
+	default:
+		if (prog->sleepable)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ublk_bpf_ops_init_member(const struct btf_type *t,
+				 const struct btf_member *member,
+				 void *kdata, const void *udata)
+{
+	const struct ublk_bpf_ops *uops;
+	struct ublk_bpf_ops *kops;
+	u32 moff;
+
+	uops = (const struct ublk_bpf_ops *)udata;
+	kops = (struct ublk_bpf_ops *)kdata;
+
+	moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct ublk_bpf_ops, id):
+		/* For dev_id, this function has to copy it and return 1 to
+		 * indicate that the data has been handled by the struct_ops
+		 * type, or the verifier will reject the map if the value of
+		 * those fields is not zero.
+		 */
+		kops->id = uops->id;
+		return 1;
+	}
+	return 0;
+}
+
+static int ublk_bpf_reg(void *kdata, struct bpf_link *link)
+{
+	struct ublk_bpf_ops *ops = kdata;
+	struct ublk_bpf_ops *curr;
+	int ret = -EBUSY;
+
+	mutex_lock(&ublk_bpf_ops_lock);
+	if (!xa_load(&ublk_ops, ops->id)) {
+		curr = kmalloc(sizeof(*curr), GFP_KERNEL);
+		if (curr) {
+			*curr = *ops;
+			bpf_prog_provider_init(&curr->provider);
+			ret = xa_err(xa_store(&ublk_ops, ops->id, curr, GFP_KERNEL));
+		} else {
+			ret = -ENOMEM;
+		}
+	}
+	mutex_unlock(&ublk_bpf_ops_lock);
+
+	return ret;
+}
+
+static void ublk_bpf_unreg(void *kdata, struct bpf_link *link)
+{
+	struct ublk_bpf_ops *ops = kdata;
+	struct ublk_bpf_ops *curr;
+	LIST_HEAD(consumer_list);
+	struct bpf_prog_consumer *consumer, *tmp;
+
+	mutex_lock(&ublk_bpf_ops_lock);
+	curr = xa_erase(&ublk_ops, ops->id);
+	if (curr)
+		list_splice_init(&curr->provider.list, &consumer_list);
+	mutex_unlock(&ublk_bpf_ops_lock);
+
+	list_for_each_entry_safe(consumer, tmp, &consumer_list, node)
+		bpf_prog_consumer_detach(consumer, true);
+	kfree(curr);
+}
+
+static void ublk_bpf_prep_io(struct ublk_bpf_io *io,
+		const struct ublksrv_io_desc *iod)
+{
+	io->flags = 0;
+	io->res = 0;
+	io->iod = iod;
+	__set_bit(UBLK_BPF_IO_PREP, &io->flags);
+	/* one is for submission, another is for completion */
+	refcount_set(&io->ref, 2);
+}
+
+/* Return true if io cmd is queued, otherwise forward it to userspace */
+bool ublk_run_bpf_handler(struct ublk_queue *ubq, struct request *req,
+			  queue_io_cmd_t cb)
+{
+	ublk_bpf_return_t ret;
+	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
+	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
+	struct ublk_bpf_io *bpf_io = &data->bpf_data;
+	const unsigned long total = iod->nr_sectors << 9;
+	unsigned int done = 0;
+	bool res = true;
+	int err;
+
+	if (!test_bit(UBLK_BPF_IO_PREP, &bpf_io->flags))
+		ublk_bpf_prep_io(bpf_io, iod);
+
+	do {
+		enum ublk_bpf_disposition rc;
+		unsigned int bytes;
+
+		ret = cb(bpf_io, done);
+		rc = ublk_bpf_get_disposition(ret);
+
+		if (rc == UBLK_BPF_IO_QUEUED)
+			goto exit;
+
+		if (rc == UBLK_BPF_IO_REDIRECT)
+			break;
+
+		if (unlikely(rc != UBLK_BPF_IO_CONTINUE)) {
+			printk_ratelimited(KERN_ERR "%s: unknown rc code %d\n",
+					__func__, rc);
+			err = -EINVAL;
+			goto fail;
+		}
+
+		bytes = ublk_bpf_get_return_bytes(ret);
+		if (unlikely((bytes & 511) || !bytes)) {
+			err = -EREMOTEIO;
+			goto fail;
+		} else if (unlikely(bytes > total - done)) {
+			err = -ENOSPC;
+			goto fail;
+		} else {
+			done += bytes;
+		}
+	} while (done < total);
+
+	/*
+	 * If any bytes are queued, we can't forward to userspace
+	 * immediately because it is too complicated to support two side
+	 * completion.
+	 *
+	 * But the request will be updated and retried after the queued
+	 * part is completed, then it can be forwarded to userspace too.
+	 */
+	res = done > 0;
+	if (!res) {
+		/* will redirect to userspace, so forget bpf handling */
+		__clear_bit(UBLK_BPF_IO_PREP, &bpf_io->flags);
+		refcount_dec(&bpf_io->ref);
+	}
+	goto exit;
+fail:
+	res = true;
+	ublk_bpf_complete_io_cmd(bpf_io, err);
+exit:
+	ublk_bpf_io_dec_ref(bpf_io);
+	return res;
+}
+
+static ublk_bpf_return_t ublk_bpf_run_io_task(struct ublk_bpf_io *io,
+						   unsigned int offset)
+{
+	return ublk_bpf_return_val(UBLK_BPF_IO_REDIRECT, 0);
+}
+
+static ublk_bpf_return_t ublk_bpf_queue_io_cmd(struct ublk_bpf_io *io,
+						    unsigned int offset)
+{
+	return ublk_bpf_return_val(UBLK_BPF_IO_REDIRECT, 0);
+}
+
+static void ublk_bpf_release_io_cmd(struct ublk_bpf_io *io)
+{
+}
+
+static struct ublk_bpf_ops __bpf_ublk_bpf_ops = {
+	.queue_io_cmd = ublk_bpf_queue_io_cmd,
+	.queue_io_cmd_daemon = ublk_bpf_run_io_task,
+	.release_io_cmd = ublk_bpf_release_io_cmd,
+};
+
+static struct bpf_struct_ops bpf_ublk_bpf_ops = {
+	.verifier_ops = &ublk_bpf_verifier_ops,
+	.init = ublk_bpf_ops_init,
+	.check_member = ublk_bpf_ops_check_member,
+	.init_member = ublk_bpf_ops_init_member,
+	.reg = ublk_bpf_reg,
+	.unreg = ublk_bpf_unreg,
+	.name = "ublk_bpf_ops",
+	.cfi_stubs = &__bpf_ublk_bpf_ops,
+	.owner = THIS_MODULE,
+};
+
+int __init ublk_bpf_struct_ops_init(void)
+{
+	int err;
+
+	err = register_bpf_struct_ops(&bpf_ublk_bpf_ops, ublk_bpf_ops);
+	if (err)
+		pr_warn("error while registering ublk bpf struct ops: %d", err);
+
+	return 0;
+}
diff --git a/drivers/block/ublk/main.c b/drivers/block/ublk/main.c
index aefb414ebf6c..29d3e7f656a7 100644
--- a/drivers/block/ublk/main.c
+++ b/drivers/block/ublk/main.c
@@ -43,6 +43,7 @@
 #include <linux/kref.h>
 
 #include "ublk.h"
+#include "bpf.h"
 
 static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq);
 
@@ -1061,6 +1062,10 @@ static inline void __ublk_rq_task_work(struct request *req,
 			mapped_bytes >> 9;
 	}
 
+	if (ublk_support_bpf(ubq) && ublk_run_bpf_prog(ubq, req,
+				ublk_get_bpf_io_cb_daemon(ubq), true))
+		return;
+
 	ublk_init_req_ref(ubq, req);
 	ubq_complete_io_cmd(io, UBLK_IO_RES_OK, issue_flags);
 }
@@ -1088,6 +1093,10 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 {
 	struct ublk_rq_data *data = blk_mq_rq_to_pdu(rq);
 
+	if (ublk_support_bpf(ubq) && ublk_run_bpf_prog(ubq, rq,
+				ublk_get_bpf_io_cb(ubq), false))
+		return;
+
 	if (llist_add(&data->node, &ubq->io_cmds)) {
 		struct ublk_io *io = &ubq->ios[rq->tag];
 
@@ -1265,8 +1274,24 @@ static void ublk_commit_completion(struct ublk_device *ub,
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = ub_cmd->zone_append_lba;
 
-	if (likely(!blk_should_fake_timeout(req->q)))
-		ublk_put_req_ref(ubq, req);
+	if (likely(!blk_should_fake_timeout(req->q))) {
+		/*
+		 * userspace may have setup everything, but still let bpf
+		 * prog to handle io by returning -EAGAIN, this way provides
+		 * single bpf io handle fast path, and should simplify things
+		 * a lot.
+		 */
+		if (ublk_support_bpf(ubq) && io->res == -EAGAIN) {
+			if(!ublk_run_bpf_prog(ubq, req,
+					ublk_get_bpf_any_io_cb(ubq), true)) {
+				/* give up now */
+				io->res = -EIO;
+				ublk_put_req_ref(ubq, req);
+			}
+		} else {
+			ublk_put_req_ref(ubq, req);
+		}
+	}
 }
 
 /*
diff --git a/drivers/block/ublk/ublk.h b/drivers/block/ublk/ublk.h
index 76aee4225c78..e9ceadbc616d 100644
--- a/drivers/block/ublk/ublk.h
+++ b/drivers/block/ublk/ublk.h
@@ -33,10 +33,26 @@
 	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
 	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED)
 
+enum {
+	UBLK_BPF_IO_PREP	= 0,
+	UBLK_BPF_IO_COMPLETED   = 1,
+};
+
+struct ublk_bpf_io {
+	const struct ublksrv_io_desc	*iod;
+	unsigned long			flags;
+	refcount_t                      ref;
+	int				res;
+};
+
 struct ublk_rq_data {
 	struct llist_node node;
 
 	struct kref ref;
+
+#ifdef CONFIG_UBLK_BPF
+	struct ublk_bpf_io	bpf_data;
+#endif
 };
 
 struct ublk_uring_cmd_pdu {
@@ -104,6 +120,10 @@ struct ublk_queue {
 
 	struct llist_head	io_cmds;
 
+#ifdef CONFIG_UBLK_BPF
+	struct ublk_bpf_ops     *bpf_ops;
+#endif
+
 	unsigned short force_abort:1;
 	unsigned short timeout:1;
 	unsigned short canceling:1;
@@ -161,8 +181,21 @@ static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
 		&(ubq->io_cmd_buf[tag * sizeof(struct ublksrv_io_desc)]);
 }
 
+static inline bool ublk_support_bpf(const struct ublk_queue *ubq)
+{
+	return false;
+}
+
 struct ublk_device *ublk_get_device_from_id(int idx);
 void ublk_put_device(struct ublk_device *ub);
 void __ublk_complete_rq(struct request *req);
 
+static inline void __ublk_complete_rq_with_res(struct request *req, int res)
+{
+	struct ublk_queue *ubq = req->mq_hctx->driver_data;
+	struct ublk_io *io = &ubq->ios[req->tag];
+
+	io->res = res;
+	__ublk_complete_rq(req);
+}
 #endif
-- 
2.47.0


