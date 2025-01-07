Return-Path: <bpf+bounces-48086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBABA03EC0
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5377E3A537E
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41C81F0E5B;
	Tue,  7 Jan 2025 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2hsUFGZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96611F0E38;
	Tue,  7 Jan 2025 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251782; cv=none; b=oXnkkWaO0EATK7vjhNIfxpUCPGxmtE2ccIMy/DQ4QZ9eAuQ4QhcEXkbWugc8kgWckmavsUdSqxJ6TCHwsy3rAA8hh44L3La/8dHmcCi6cNgiPFPpDb+5x3ddwmuJTe4TUhJkRlxCIM9e3PZ+brfr4g4EFoi102R3DOIVlvvVzOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251782; c=relaxed/simple;
	bh=RA3agkgGPoh3lll3WbU1VW0805xDHkJnUwLXxAsotgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwlVUz11WhlzFjXl8sEKVs6PweujnKKs7tgU5vAG8KOWyzb9MweJFM1DHf5eko8GJg2gJK8PlxiD1S+BaQ/Rd5c3uFBW3mCXSSr6YQm9Extpd1O04YmMwBRNeUTqHZ3vgMhRg6cKlK8ora6h7/8H+kySrj1DQLamuHzx2v2K0Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2hsUFGZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21669fd5c7cso228823805ad.3;
        Tue, 07 Jan 2025 04:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251722; x=1736856522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3G38mp2BMfe/0ANq/zJ1yKW8K0dgj9kh1DASCV+yEbE=;
        b=P2hsUFGZSNz3dAciWLz9svBy6DYas8hGLVQ6HcKM5PujCZaGu84v6uk78opVv1UPoo
         rpgcGRcRQQtQ4qyzBgx90+UUO5ET4rD146nf/OGBslKpdOrG+v8ZX/4syagKOkQxjwQM
         2oKNlJTaVleFJt26djlqNu9CPQO1J/GM3ZVVsFhiEzacCEdmyMesuDN44JlxqSuFRjI5
         FvrHtoaKcbwvN1m1pwyT/YKDYzSc4VncGouGRs0oK18BmL96nO3tLqseYvyD8TlE3koM
         Sz/1lT9w3U6SW3lF5rBU2orUXwKt+ZfuenKrsMnDtnbqPwErbmbXmYCgUE/kuU7sYhOt
         27VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251722; x=1736856522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3G38mp2BMfe/0ANq/zJ1yKW8K0dgj9kh1DASCV+yEbE=;
        b=OTkobXi1LAc/psstd+CphLowhxhSqATFr8AG3vHVtz0RPgg0oKnT+DjJX9VrnAflSy
         0/DE/J8yHXHqoypzOBDS4grdnB2riNHr1SueHm9Z2OHYeWPSHfzFiqBoSS9vsIjUHNzF
         JHKo0yN7kk6/z047W7PhZ5dNBWXrnbfyPerDR0xyRtQb5QwiETO7BXUm7X2YEa5AqBNs
         FeI+JG7OmDrghr5na+jrUYCUVcAQSdV47sEFnBDntM6ZaUx2sBVwPX+/DZ1PdcoE7QSr
         X58zGmBatUCkSNvigxv6QlHGhDpF1VV8yzRmFakTA/CTlUgfYod6ZaO3+wdG4JuFDTeo
         MRgg==
X-Forwarded-Encrypted: i=1; AJvYcCU2SgWam3Cj1hIrgeml4gjFXzYCuW6vbI/dkh+9yxSulQ6W1eZWaM3xLJd/ccBXB0++FCorc9TCsvs5/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvKIMWhaASwXN0n0AMJQd4B06MFcwD+i41SlAKfhogDWVWf6K/
	Q8LaV/nLb+7e396zqnRx3CHxqGg9/jd2ZBWr8HakJwEbELyfcsIv
X-Gm-Gg: ASbGncuXZ0+XCs7OFl/XSBBgIvk1Es9CIYKy2zaQbZUduHSacP5qYYlXA/MGyA44cBc
	PP7VkWbEleVkaSgG921xJ0FsUwP9Edm7hInw0hkQLMLRD9aCr15IqXgZUAueALXZumanJ3ZhzMl
	c/pN95Q/F+XL3dC2yWKGu2U7oyYBWpGMd9pStyoZBz+KCqG+f0twmI8YfE6ae5J5zvmRZYk2s1t
	r+u2KhkodnyNSnGJbALyKx9TQfY7DePrTj4CEL5WJB0/WO1FhUy0Ziw2PYsSeSqMnWf
X-Google-Smtp-Source: AGHT+IH+93tib9I3CsDT9s05atKapyruR2G4c7itWJkFbpoz+llX05XKNRiFeZJKnIGE8qw8pVE66g==
X-Received: by 2002:a05:6a21:3985:b0:1e1:9662:a6f2 with SMTP id adf61e73a8af0-1e5e07f973dmr108038894637.35.1736251722083;
        Tue, 07 Jan 2025 04:08:42 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:08:41 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 15/22] ublk: bpf: add bpf aio kfunc
Date: Tue,  7 Jan 2025 20:04:06 +0800
Message-ID: <20250107120417.1237392-16-tom.leiming@gmail.com>
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

Define bpf aio kfunc for bpf prog to submit AIO, so far it begins with
filesystem IO only, and in the future, it may be extended for network IO.

Only bvec buffer is covered for doing FS IO over this buffer, but it
is easy to cover UBUF because we have the great iov iter.

With bpf aio, not only user-kernel context switch is avoided, but also
user-kernel buffer copy is saved. It is very similar with loop's direct
IO implementation.

These kfuncs can be used for other subsystems, and should have belong to
lib/, but let's start from ublk first. When it becomes mature or gets more
use cases, it can be moved to /lib.

Define bpf struct_ops of bpf_aio_complete_ops which needs to be implemented
by the caller for completing bpf aio via bpf prog, which will be done in the
following patches.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk/Makefile  |   2 +-
 drivers/block/ublk/bpf.c     |  40 +++++-
 drivers/block/ublk/bpf.h     |   1 +
 drivers/block/ublk/bpf_aio.c | 251 +++++++++++++++++++++++++++++++++++
 drivers/block/ublk/bpf_aio.h |  66 +++++++++
 5 files changed, 358 insertions(+), 2 deletions(-)
 create mode 100644 drivers/block/ublk/bpf_aio.c
 create mode 100644 drivers/block/ublk/bpf_aio.h

diff --git a/drivers/block/ublk/Makefile b/drivers/block/ublk/Makefile
index f843a9005cdb..7094607c040d 100644
--- a/drivers/block/ublk/Makefile
+++ b/drivers/block/ublk/Makefile
@@ -5,6 +5,6 @@ ccflags-y			+= -I$(src)
 
 ublk_drv-$(CONFIG_BLK_DEV_UBLK)	:= main.o
 ifeq ($(CONFIG_UBLK_BPF), y)
-ublk_drv-$(CONFIG_BLK_DEV_UBLK)	+= bpf_ops.o bpf.o
+ublk_drv-$(CONFIG_BLK_DEV_UBLK)	+= bpf_ops.o bpf.o bpf_aio.o
 endif
 obj-$(CONFIG_BLK_DEV_UBLK)	+= ublk_drv.o
diff --git a/drivers/block/ublk/bpf.c b/drivers/block/ublk/bpf.c
index ef1546a7ccda..d5880d61abe5 100644
--- a/drivers/block/ublk/bpf.c
+++ b/drivers/block/ublk/bpf.c
@@ -155,8 +155,23 @@ BTF_ID_FLAGS(func, ublk_bpf_get_iod, KF_TRUSTED_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, ublk_bpf_get_io_tag, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, ublk_bpf_get_queue_id, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, ublk_bpf_get_dev_id, KF_TRUSTED_ARGS)
+
+/* bpf aio kfunc */
+BTF_ID_FLAGS(func, bpf_aio_alloc, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_aio_alloc_sleepable, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_aio_release)
+BTF_ID_FLAGS(func, bpf_aio_submit)
 BTF_KFUNCS_END(ublk_bpf_kfunc_ids)
 
+__bpf_kfunc void bpf_aio_release_dtor(void *aio)
+{
+	bpf_aio_release(aio);
+}
+CFI_NOSEAL(bpf_aio_release_dtor);
+BTF_ID_LIST(bpf_aio_dtor_ids)
+BTF_ID(struct, bpf_aio)
+BTF_ID(func, bpf_aio_release_dtor)
+
 static const struct btf_kfunc_id_set ublk_bpf_kfunc_set = {
 	.owner = THIS_MODULE,
 	.set   = &ublk_bpf_kfunc_ids,
@@ -164,6 +179,12 @@ static const struct btf_kfunc_id_set ublk_bpf_kfunc_set = {
 
 int __init ublk_bpf_init(void)
 {
+	const struct btf_id_dtor_kfunc aio_dtors[] = {
+		{
+			.btf_id	      = bpf_aio_dtor_ids[0],
+			.kfunc_btf_id = bpf_aio_dtor_ids[1]
+		},
+	};
 	int err;
 
 	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
@@ -172,5 +193,22 @@ int __init ublk_bpf_init(void)
 		pr_warn("error while setting UBLK BPF tracing kfuncs: %d", err);
 		return err;
 	}
-	return ublk_bpf_struct_ops_init();
+
+	err = ublk_bpf_struct_ops_init();
+	if (err) {
+		pr_warn("error while initializing ublk bpf struct_ops: %d", err);
+		return err;
+	}
+
+	err = register_btf_id_dtor_kfuncs(aio_dtors, ARRAY_SIZE(aio_dtors),
+			THIS_MODULE);
+	if (err) {
+		pr_warn("error while registering aio destructor: %d", err);
+		return err;
+	}
+
+	err = bpf_aio_init();
+	if (err)
+		pr_warn("error while initializing bpf aio kfunc: %d", err);
+	return err;
 }
diff --git a/drivers/block/ublk/bpf.h b/drivers/block/ublk/bpf.h
index 4e178cbecb74..0ab25743ae7d 100644
--- a/drivers/block/ublk/bpf.h
+++ b/drivers/block/ublk/bpf.h
@@ -3,6 +3,7 @@
 #define UBLK_INT_BPF_HEADER
 
 #include "bpf_reg.h"
+#include "bpf_aio.h"
 
 typedef unsigned long ublk_bpf_return_t;
 typedef ublk_bpf_return_t (*queue_io_cmd_t)(struct ublk_bpf_io *io, unsigned int);
diff --git a/drivers/block/ublk/bpf_aio.c b/drivers/block/ublk/bpf_aio.c
new file mode 100644
index 000000000000..65013fe8054f
--- /dev/null
+++ b/drivers/block/ublk/bpf_aio.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Red Hat */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/bpf.h>
+#include <linux/bpf_mem_alloc.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/filter.h>
+
+#include "bpf_aio.h"
+
+static int __bpf_aio_submit(struct bpf_aio *aio);
+
+static struct kmem_cache *bpf_aio_cachep;
+static struct kmem_cache *bpf_aio_work_cachep;
+static struct workqueue_struct *bpf_aio_wq;
+
+static inline bool bpf_aio_is_rw(int op)
+{
+	return op == BPF_AIO_OP_FS_READ || op == BPF_AIO_OP_FS_WRITE;
+}
+
+/* check if it is short read */
+static bool bpf_aio_is_short_read(const struct bpf_aio *aio, long ret)
+{
+	return ret >= 0 && ret < aio->bytes &&
+		bpf_aio_get_op(aio) == BPF_AIO_OP_FS_READ;
+}
+
+/* zeroing the remained bytes starting from `off` to end */
+static void bpf_aio_zero_remained(const struct bpf_aio *aio, long off)
+{
+	struct iov_iter iter;
+
+	iov_iter_bvec(&iter, ITER_DEST, aio->buf.bvec, aio->buf.nr_bvec, aio->bytes);
+	iter.iov_offset = aio->buf.bvec_off;
+
+	iov_iter_advance(&iter, off);
+	iov_iter_zero(aio->bytes - off, &iter);
+}
+
+static void bpf_aio_do_completion(struct bpf_aio *aio)
+{
+	if (aio->iocb.ki_filp)
+		fput(aio->iocb.ki_filp);
+	if (aio->work)
+		kmem_cache_free(bpf_aio_work_cachep, aio->work);
+}
+
+/* ->ki_complete callback */
+static void bpf_aio_complete(struct kiocb *iocb, long ret)
+{
+	struct bpf_aio *aio = container_of(iocb, struct bpf_aio, iocb);
+
+	if (unlikely(ret == -EAGAIN)) {
+		aio->opf |= BPF_AIO_FORCE_WQ;
+		ret = __bpf_aio_submit(aio);
+		if (!ret)
+			return;
+	}
+
+	/* zero the remained bytes in case of short read */
+	if (bpf_aio_is_short_read(aio, ret))
+		bpf_aio_zero_remained(aio, ret);
+
+	bpf_aio_do_completion(aio);
+	aio->ops->bpf_aio_complete_cb(aio, ret);
+}
+
+static void bpf_aio_prep_rw(struct bpf_aio *aio, unsigned int rw,
+		struct iov_iter *iter)
+{
+	iov_iter_bvec(iter, rw, aio->buf.bvec, aio->buf.nr_bvec, aio->bytes);
+	iter->iov_offset = aio->buf.bvec_off;
+
+	if (unlikely(aio->opf & BPF_AIO_FORCE_WQ)) {
+		aio->iocb.ki_flags &= ~IOCB_NOWAIT;
+		aio->iocb.ki_complete = NULL;
+	} else {
+		aio->iocb.ki_flags |= IOCB_NOWAIT;
+		aio->iocb.ki_complete = bpf_aio_complete;
+	}
+}
+
+static int bpf_aio_do_submit(struct bpf_aio *aio)
+{
+	int op = bpf_aio_get_op(aio);
+	struct iov_iter iter;
+	struct file *file = aio->iocb.ki_filp;
+	int ret;
+
+	switch (op) {
+	case BPF_AIO_OP_FS_READ:
+		bpf_aio_prep_rw(aio, ITER_DEST, &iter);
+		if (file->f_op->read_iter)
+			ret = file->f_op->read_iter(&aio->iocb, &iter);
+		else
+			ret = -EOPNOTSUPP;
+		break;
+	case BPF_AIO_OP_FS_WRITE:
+		bpf_aio_prep_rw(aio, ITER_SOURCE, &iter);
+		if (file->f_op->write_iter)
+			ret = file->f_op->write_iter(&aio->iocb, &iter);
+		else
+			ret = -EOPNOTSUPP;
+		break;
+	case BPF_AIO_OP_FS_FSYNC:
+		ret = vfs_fsync_range(aio->iocb.ki_filp, aio->iocb.ki_pos,
+				aio->iocb.ki_pos + aio->bytes - 1, 0);
+		if (unlikely(ret && ret != -EINVAL))
+			ret = -EIO;
+		break;
+	case BPF_AIO_OP_FS_FALLOCATE:
+		ret = vfs_fallocate(aio->iocb.ki_filp, aio->iocb.ki_flags,
+				aio->iocb.ki_pos, aio->bytes);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (ret == -EIOCBQUEUED) {
+		ret = 0;
+	} else if (ret != -EAGAIN) {
+		bpf_aio_complete(&aio->iocb, ret);
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static void bpf_aio_submit_work(struct work_struct *work)
+{
+	struct bpf_aio_work *aio_work = container_of(work, struct bpf_aio_work, work);
+
+	bpf_aio_do_submit(aio_work->aio);
+}
+
+static int __bpf_aio_submit(struct bpf_aio *aio)
+{
+	struct work_struct *work;
+
+do_submit:
+	if (likely(!(aio->opf & BPF_AIO_FORCE_WQ))) {
+		int ret = bpf_aio_do_submit(aio);
+
+		/* retry via workqueue in case of -EAGAIN */
+		if (ret != -EAGAIN)
+			return ret;
+		aio->opf |= BPF_AIO_FORCE_WQ;
+	}
+
+	if (!aio->work) {
+		bool in_irq = in_interrupt();
+		gfp_t gfpflags = in_irq ? GFP_ATOMIC : GFP_NOIO;
+
+		aio->work = kmem_cache_alloc(bpf_aio_work_cachep, gfpflags);
+		if (unlikely(!aio->work)) {
+			if (in_irq)
+				return -ENOMEM;
+			aio->opf &= ~BPF_AIO_FORCE_WQ;
+			goto do_submit;
+		}
+	}
+
+	aio->work->aio = aio;
+	work = &aio->work->work;
+	INIT_WORK(work, bpf_aio_submit_work);
+	queue_work(bpf_aio_wq, work);
+
+	return 0;
+}
+
+static struct bpf_aio *__bpf_aio_alloc(gfp_t gfpflags, unsigned op,
+				       enum bpf_aio_flag aio_flags)
+{
+	struct bpf_aio *aio;
+
+	if (op >= BPF_AIO_OP_LAST)
+		return NULL;
+
+	if (aio_flags & BPF_AIO_OP_MASK)
+		return NULL;
+
+	aio = kmem_cache_alloc(bpf_aio_cachep, gfpflags);
+	if (!aio)
+		return NULL;
+
+	memset(aio, 0, sizeof(*aio));
+	aio->opf = op | (unsigned int)aio_flags;
+	return aio;
+}
+
+__bpf_kfunc struct bpf_aio *bpf_aio_alloc(unsigned int op, enum bpf_aio_flag aio_flags)
+{
+	return __bpf_aio_alloc(GFP_ATOMIC, op, aio_flags);
+}
+
+__bpf_kfunc struct bpf_aio *bpf_aio_alloc_sleepable(unsigned int op, enum bpf_aio_flag aio_flags)
+{
+	return __bpf_aio_alloc(GFP_NOIO, op, aio_flags);
+}
+
+__bpf_kfunc void bpf_aio_release(struct bpf_aio *aio)
+{
+	kmem_cache_free(bpf_aio_cachep, aio);
+}
+
+/* Submit AIO from bpf prog */
+__bpf_kfunc int bpf_aio_submit(struct bpf_aio *aio, int fd, loff_t pos,
+		unsigned bytes, unsigned io_flags)
+{
+	struct file *file;
+
+	if (!aio->ops)
+		return -EINVAL;
+
+	file = fget(fd);
+	if (!file)
+		return -EINVAL;
+
+	/* we could be called from io completion handler */
+	if (in_interrupt())
+		aio->opf |= BPF_AIO_FORCE_WQ;
+
+	aio->iocb.ki_pos = pos;
+	aio->iocb.ki_filp = file;
+	aio->iocb.ki_flags = io_flags;
+	aio->bytes = bytes;
+	if (bpf_aio_is_rw(bpf_aio_get_op(aio))) {
+		if (file->f_flags & O_DIRECT)
+			aio->iocb.ki_flags |= IOCB_DIRECT;
+		else
+			aio->opf |= BPF_AIO_FORCE_WQ;
+		aio->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
+	} else {
+		aio->opf |= BPF_AIO_FORCE_WQ;
+	}
+
+	return __bpf_aio_submit(aio);
+}
+
+int __init bpf_aio_init(void)
+{
+	bpf_aio_cachep = KMEM_CACHE(bpf_aio, SLAB_PANIC);
+	bpf_aio_work_cachep = KMEM_CACHE(bpf_aio_work, SLAB_PANIC);
+	bpf_aio_wq = alloc_workqueue("bpf_aio", WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+
+	return 0;
+}
diff --git a/drivers/block/ublk/bpf_aio.h b/drivers/block/ublk/bpf_aio.h
new file mode 100644
index 000000000000..625737965c90
--- /dev/null
+++ b/drivers/block/ublk/bpf_aio.h
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2024 Red Hat */
+#ifndef UBLK_BPF_AIO_HEADER
+#define UBLK_BPF_AIO_HEADER
+
+#define	BPF_AIO_OP_BITS		8
+#define	BPF_AIO_OP_MASK		((1 << BPF_AIO_OP_BITS) - 1)
+
+enum bpf_aio_op {
+	BPF_AIO_OP_FS_READ	= 0,
+	BPF_AIO_OP_FS_WRITE,
+	BPF_AIO_OP_FS_FSYNC,
+	BPF_AIO_OP_FS_FALLOCATE,
+	BPF_AIO_OP_LAST,
+};
+
+enum bpf_aio_flag_bits {
+	/* force to submit io from wq */
+	__BPF_AIO_FORCE_WQ	= BPF_AIO_OP_BITS,
+	__BPF_AIO_NR_BITS,	/* stops here */
+};
+
+enum bpf_aio_flag {
+	BPF_AIO_FORCE_WQ	= (1 << __BPF_AIO_FORCE_WQ),
+};
+
+struct bpf_aio_work {
+	struct bpf_aio		*aio;
+	struct work_struct	work;
+};
+
+/* todo: support ubuf & iovec in future */
+struct bpf_aio_buf {
+	unsigned int		bvec_off;
+	int			nr_bvec;
+	const struct bio_vec	*bvec;
+};
+
+struct bpf_aio {
+	unsigned int opf;
+	unsigned int bytes;
+	struct bpf_aio_buf	buf;
+	struct bpf_aio_work	*work;
+	const struct bpf_aio_complete_ops *ops;
+	struct kiocb iocb;
+};
+
+typedef void (*bpf_aio_complete_t)(struct bpf_aio *io, long ret);
+
+struct bpf_aio_complete_ops {
+	unsigned int		id;
+	bpf_aio_complete_t	bpf_aio_complete_cb;
+};
+
+static inline unsigned int bpf_aio_get_op(const struct bpf_aio *aio)
+{
+	return aio->opf & BPF_AIO_OP_MASK;
+}
+
+int bpf_aio_init(void);
+struct bpf_aio *bpf_aio_alloc(unsigned int op, enum bpf_aio_flag aio_flags);
+struct bpf_aio *bpf_aio_alloc_sleepable(unsigned int op, enum bpf_aio_flag aio_flags);
+void bpf_aio_release(struct bpf_aio *aio);
+int bpf_aio_submit(struct bpf_aio *aio, int fd, loff_t pos, unsigned bytes,
+		unsigned io_flags);
+#endif
-- 
2.47.0


