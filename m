Return-Path: <bpf+bounces-48083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BBEA03EBA
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0481882A0C
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639811EE7DF;
	Tue,  7 Jan 2025 12:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5U81iPc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206E1EF0BD;
	Tue,  7 Jan 2025 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251760; cv=none; b=B4yOL77K1oJkCXeKMSzvqQ/rbcl30/oNVQjWhcZUfDWNoOtkC+GzyOnrdzDkcMIoOWXXLjuwl6s8zXAUfZeagmqiba4duijYsPtszDqLvBloeefu+Vy3CiRv4Z/vu7SfVR1df68zYOAMeWCArEg77SAK8LfssfUS5yXyAzXZ194=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251760; c=relaxed/simple;
	bh=KOPDlz0ubcytn137RK5uLmqeFSDFDGCRERP7Ce2gcWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3zQQ4t/SXPzKPs7y+7IweNmmCkRukY5aG+CKcooughC/XRxcVgiMeEqYi4+VinMMW1OFW+jH/HSf0mkVZR1JcfocRysayJxEajukU9K5pLyD2dgrO4qHFXvuCr7PkKyvAmFKtwbzAx7xluSTCJyYP+EKbaEsuDT+MyLFCkvSoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5U81iPc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21631789fcdso165274375ad.1;
        Tue, 07 Jan 2025 04:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251725; x=1736856525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7mDzi2V2kDe56cR1ad6kssWnrtOL5M6WFmdeiINw/g=;
        b=e5U81iPcshfXEq/iXBJz9O1V52t0Z720NL7KoZLcfm/WyQEeF7cklQ3Ulqh6ZaZrAr
         V/oso9sr0aIg31CTjHTd87ic5J75ELgJoVW2AotFpKOHtTRDWNqMhkxT0Kja0cFcyCLu
         E/+WPhKR/KhbiAq485w9RjjU5Ti/T5IdjYOuqn1Gnn+nLCqWKRPjj9kdpZ1ZKHsfsXXx
         Zd+gC8+KmX/34BHQ5L6/g/EKc2hCyC6Yc9GDxHJR+yOIv+6Sdv6+rvNUSaB3iUwjHTzQ
         PoDHsIZHEdbKMS4naCkh3LCFs36TuC7aTw4egNk/qt3eFL7Xu76EejIwP5EqpUu9ng6T
         hqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251725; x=1736856525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7mDzi2V2kDe56cR1ad6kssWnrtOL5M6WFmdeiINw/g=;
        b=pXedTlYzdDJmeqrpEOT6vbnUVRUHPdR4Ca6njSyrJLievX8nvAAFbB/m8MhDsXfGA9
         RjnwVzZW9s4NliWNNj0AXZFgVjltR4XlULEkSPg6nphFwL2onVXIMsYJUGh3fcGPQcev
         edt1QJlEeHz2/O8CHhJGxULHkn5YyN4AcWhsMJiT/ZyAFUePbSpNtpGNfaU23UJpqt7B
         /yXvA/xKnx7BtfmFuQylYMIsJj9WVRfO8845VxzON9wZ1J0RZMKCBCWkto6H51dNXlC/
         Fsty2H6Tz58rM1NGYEOIuqWyO5DXQwpst6viPw/LOHzRuqJd8PvAuYds3l9yPzVncdxR
         CCoA==
X-Forwarded-Encrypted: i=1; AJvYcCVPluuMIcCEAXm249R9s0EiwTYSvV44ze7GpolQEMh7r9oKCw2TEg4CSBV/Q9IgGFf1Qip/+HY9ohEdvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOQ4hBJxa+U6Nw2Ha2nSS0MHvAiZ8wF+6FMelXNfqrG9KMdEWw
	nTPo5ZC9PYDGpOsu8pJCuBStujv1x/x31RGhA3P97o+mhTcAbVcv
X-Gm-Gg: ASbGnctm9PcLleLpYfh7BLmXA1aso/j2MzPYvIDUTbtOM+H7mghXwnKEsyKfw4EkZF6
	KvH32yETDtxYPI8i1/MS+cQyLuq9nKGmwCkwt89d9u7uq5nTcqzIKA/nvf/ygPLsd5yyIJBhQDS
	7FAPRV6559NdZIaWHwSUYjeK3Xtg/6TJAMQMrFM24zBHMk2W1DECCRopQQ0yLoidmnfqGR48N/X
	wDZriyYfEP7Ue8q1MIuRmQhdz+Yy33v+3IH9ouFt0rzpK1e0sw1J3jRiLXfGJzEglq7
X-Google-Smtp-Source: AGHT+IHq3eUPzQggEyxNltVEksBMHROn2XG5o87qcYDtvp72CpXlxLsl8R3nBVqtokdMIDakCP6ElQ==
X-Received: by 2002:a05:6a00:2445:b0:725:d64c:f122 with SMTP id d2e1a72fcca58-72d1036a99fmr4581556b3a.2.1736251725091;
        Tue, 07 Jan 2025 04:08:45 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:08:44 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 16/22] ublk: bpf: add bpf aio struct_ops
Date: Tue,  7 Jan 2025 20:04:07 +0800
Message-ID: <20250107120417.1237392-17-tom.leiming@gmail.com>
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

Add bpf aio struct_ops, so that application code can provide bpf
aio completion callback in the struct_ops prog, then bpf aio can be
supported.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk/Makefile      |   2 +-
 drivers/block/ublk/bpf_aio.c     |   7 ++
 drivers/block/ublk/bpf_aio.h     |  12 +++
 drivers/block/ublk/bpf_aio_ops.c | 152 +++++++++++++++++++++++++++++++
 4 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100644 drivers/block/ublk/bpf_aio_ops.c

diff --git a/drivers/block/ublk/Makefile b/drivers/block/ublk/Makefile
index 7094607c040d..a47f65eb97f8 100644
--- a/drivers/block/ublk/Makefile
+++ b/drivers/block/ublk/Makefile
@@ -5,6 +5,6 @@ ccflags-y			+= -I$(src)
 
 ublk_drv-$(CONFIG_BLK_DEV_UBLK)	:= main.o
 ifeq ($(CONFIG_UBLK_BPF), y)
-ublk_drv-$(CONFIG_BLK_DEV_UBLK)	+= bpf_ops.o bpf.o bpf_aio.o
+ublk_drv-$(CONFIG_BLK_DEV_UBLK)	+= bpf_ops.o bpf.o bpf_aio.o bpf_aio_ops.o
 endif
 obj-$(CONFIG_BLK_DEV_UBLK)	+= ublk_drv.o
diff --git a/drivers/block/ublk/bpf_aio.c b/drivers/block/ublk/bpf_aio.c
index 65013fe8054f..6e93f28f389b 100644
--- a/drivers/block/ublk/bpf_aio.c
+++ b/drivers/block/ublk/bpf_aio.c
@@ -243,9 +243,16 @@ __bpf_kfunc int bpf_aio_submit(struct bpf_aio *aio, int fd, loff_t pos,
 
 int __init bpf_aio_init(void)
 {
+	int err;
+
 	bpf_aio_cachep = KMEM_CACHE(bpf_aio, SLAB_PANIC);
 	bpf_aio_work_cachep = KMEM_CACHE(bpf_aio_work, SLAB_PANIC);
 	bpf_aio_wq = alloc_workqueue("bpf_aio", WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
 
+	err = bpf_aio_struct_ops_init();
+	if (err) {
+		pr_warn("error while initializing bpf aio struct_ops: %d", err);
+		return err;
+	}
 	return 0;
 }
diff --git a/drivers/block/ublk/bpf_aio.h b/drivers/block/ublk/bpf_aio.h
index 625737965c90..07fcd43fd2ac 100644
--- a/drivers/block/ublk/bpf_aio.h
+++ b/drivers/block/ublk/bpf_aio.h
@@ -3,6 +3,8 @@
 #ifndef UBLK_BPF_AIO_HEADER
 #define UBLK_BPF_AIO_HEADER
 
+#include "bpf_reg.h"
+
 #define	BPF_AIO_OP_BITS		8
 #define	BPF_AIO_OP_MASK		((1 << BPF_AIO_OP_BITS) - 1)
 
@@ -47,9 +49,18 @@ struct bpf_aio {
 
 typedef void (*bpf_aio_complete_t)(struct bpf_aio *io, long ret);
 
+/**
+ * struct bpf_aio_complete_ops - A BPF struct_ops of callbacks allowing to
+ * 	complete `bpf_aio` submitted by `bpf_aio_submit()`
+ * @id: id used by bpf aio consumer, defined by globally
+ * @bpf_aio_complete_cb: callback for completing submitted `bpf_aio`
+ * @provider: holding all consumers of this struct_ops prog, used by
+ * 	kernel only
+ */
 struct bpf_aio_complete_ops {
 	unsigned int		id;
 	bpf_aio_complete_t	bpf_aio_complete_cb;
+	struct bpf_prog_provider provider;
 };
 
 static inline unsigned int bpf_aio_get_op(const struct bpf_aio *aio)
@@ -58,6 +69,7 @@ static inline unsigned int bpf_aio_get_op(const struct bpf_aio *aio)
 }
 
 int bpf_aio_init(void);
+int bpf_aio_struct_ops_init(void);
 struct bpf_aio *bpf_aio_alloc(unsigned int op, enum bpf_aio_flag aio_flags);
 struct bpf_aio *bpf_aio_alloc_sleepable(unsigned int op, enum bpf_aio_flag aio_flags);
 void bpf_aio_release(struct bpf_aio *aio);
diff --git a/drivers/block/ublk/bpf_aio_ops.c b/drivers/block/ublk/bpf_aio_ops.c
new file mode 100644
index 000000000000..12757f634dbd
--- /dev/null
+++ b/drivers/block/ublk/bpf_aio_ops.c
@@ -0,0 +1,152 @@
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
+#include "bpf_aio.h"
+
+static DEFINE_XARRAY(bpf_aio_all_ops);
+static DEFINE_MUTEX(bpf_aio_ops_lock);
+
+static bool bpf_aio_ops_is_valid_access(int off, int size,
+		enum bpf_access_type type, const struct bpf_prog *prog,
+		struct bpf_insn_access_aux *info)
+{
+	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
+}
+
+static int bpf_aio_ops_btf_struct_access(struct bpf_verifier_log *log,
+		const struct bpf_reg_state *reg,
+		int off, int size)
+{
+	/* bpf_aio prog can change nothing */
+	if (size > 0)
+		return -EACCES;
+
+	return NOT_INIT;
+}
+
+static const struct bpf_verifier_ops bpf_aio_verifier_ops = {
+	.get_func_proto = bpf_base_func_proto,
+	.is_valid_access = bpf_aio_ops_is_valid_access,
+	.btf_struct_access = bpf_aio_ops_btf_struct_access,
+};
+
+static int bpf_aio_ops_init(struct btf *btf)
+{
+	return 0;
+}
+
+static int bpf_aio_ops_check_member(const struct btf_type *t,
+		const struct btf_member *member,
+		const struct bpf_prog *prog)
+{
+	if (prog->sleepable)
+		return -EINVAL;
+	return 0;
+}
+
+static int bpf_aio_ops_init_member(const struct btf_type *t,
+		const struct btf_member *member,
+		void *kdata, const void *udata)
+{
+	const struct bpf_aio_complete_ops *uops;
+	struct bpf_aio_complete_ops *kops;
+	u32 moff;
+
+	uops = (const struct bpf_aio_complete_ops *)udata;
+	kops = (struct bpf_aio_complete_ops*)kdata;
+
+	moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct bpf_aio_complete_ops, id):
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
+static int bpf_aio_reg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_aio_complete_ops *ops = kdata;
+	struct bpf_aio_complete_ops *curr;
+	int ret = -EBUSY;
+
+	mutex_lock(&bpf_aio_ops_lock);
+	if (!xa_load(&bpf_aio_all_ops, ops->id)) {
+		curr = kmalloc(sizeof(*curr), GFP_KERNEL);
+		if (curr) {
+			*curr = *ops;
+			bpf_prog_provider_init(&curr->provider);
+			ret = xa_err(xa_store(&bpf_aio_all_ops, ops->id,
+						curr, GFP_KERNEL));
+		} else {
+			ret = -ENOMEM;
+		}
+	}
+	mutex_unlock(&bpf_aio_ops_lock);
+
+	return ret;
+}
+
+static void bpf_aio_unreg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_aio_complete_ops *ops = kdata;
+	struct bpf_prog_consumer *consumer, *tmp;
+	struct bpf_aio_complete_ops *curr;
+	LIST_HEAD(consumer_list);
+
+	mutex_lock(&bpf_aio_ops_lock);
+	curr = xa_erase(&bpf_aio_all_ops, ops->id);
+	if (curr)
+		list_splice_init(&curr->provider.list, &consumer_list);
+	mutex_unlock(&bpf_aio_ops_lock);
+
+	list_for_each_entry_safe(consumer, tmp, &consumer_list, node)
+		bpf_prog_consumer_detach(consumer, true);
+	kfree(curr);
+}
+
+static void bpf_aio_cb(struct bpf_aio *io, long ret)
+{
+}
+
+static struct bpf_aio_complete_ops __bpf_aio_ops = {
+	.bpf_aio_complete_cb	=	bpf_aio_cb,
+};
+
+static struct bpf_struct_ops bpf_aio_ops = {
+	.verifier_ops = &bpf_aio_verifier_ops,
+	.init = bpf_aio_ops_init,
+	.check_member = bpf_aio_ops_check_member,
+	.init_member = bpf_aio_ops_init_member,
+	.reg = bpf_aio_reg,
+	.unreg = bpf_aio_unreg,
+	.name = "bpf_aio_complete_ops",
+	.cfi_stubs = &__bpf_aio_ops,
+	.owner = THIS_MODULE,
+};
+
+int __init bpf_aio_struct_ops_init(void)
+{
+	int err;
+
+	err = register_bpf_struct_ops(&bpf_aio_ops, bpf_aio_complete_ops);
+	if (err)
+		pr_warn("error while registering bpf aio struct ops: %d", err);
+
+	return 0;
+}
-- 
2.47.0


