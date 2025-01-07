Return-Path: <bpf+bounces-48080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59DEA03EB1
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7247163E23
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9D51F12E8;
	Tue,  7 Jan 2025 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNiBVrvG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A692B1F0E31;
	Tue,  7 Jan 2025 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251740; cv=none; b=SFssSFI3N4q8Z7WmkiZhsAD0Hfe+u3/QNC+z+d6hzUbem9ZXUpEnLpcgluiL34AZ4cRZ0vmIVnq7CaHn61QanNBpxaN/S8HGcnVyq6crCxMtHhfQSDa8lAlgXsn+Zx14Oij3R7YCpCnBL4I9yrVGjzMmUMk1+0UW3GHXFb7nkNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251740; c=relaxed/simple;
	bh=EHJeTu9LpZCTV6MNhTXwOlGx9U1Hi/QCyocVOYX16VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMHCWPxLHJmZBSeWcFRKImrzC13rW45hIql2A8nt/7oVje/l15r3rnKJEDl4M1tln0D3f9TvRFu7ahYffrHoial9ro8wrfCwKoAi8Zs0jvHXdrfKi0Qg9obLqh//HNhmqefHdaHpiiIRRbk6zyG9RTfvB5brmLwjGhA7ZWIDHbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNiBVrvG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21619108a6bso209375995ad.3;
        Tue, 07 Jan 2025 04:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251728; x=1736856528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Avr5zrWxvqU6u4D79YsABli7JY6gs1aynzmiVyQrjoo=;
        b=kNiBVrvGczxojCq3SY7qvQGfsfF4K67BizqWvhW2WqnnyG+iUlbjfu6tadD/eCmal5
         /pK52Gh4SsKFotE+HgEn4Veeh+4QT2+Y05cgL06TGYRKo2kb6eEvdbqZvawwg08i2R2L
         y0KBQLvFjJ5tpjlIAFdSnOuaZSHMbBq+IwndhqDlmbvJ60Q/CL3zxzxpTFGP21EFYWtv
         esFStfL7T6qvy2eksT3ZCsdsl0fy4PjNKitgEb2A8pSgCl7o/I1fagATYJe3KYcfOd6x
         fQtnLkKrj85TRNLSjy4hgsSYS5YaUWZZDpTCpSNv9762ClCFJfJUaZ778RGtRMc9iFcY
         rgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251728; x=1736856528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Avr5zrWxvqU6u4D79YsABli7JY6gs1aynzmiVyQrjoo=;
        b=xJF05rhL/xjkBHoSiZu7idLBbUKBRT/P+iJB0oaW5Eab+J+EX2ReFLDZmZsiWDNr5X
         fUDCTRVxiJ5OSt53DA5rZg3PSbElCcP7be7dKNyoYiK4YmNNzb36bWeOJ0Xrm72y/EC0
         2SgSNWShUk3+rCDiXijHGZd+7AevC6BwAoYb//NkbvlSvFieqrOGosU4KEFYZFzYCgmu
         7LkcEs8d+e7eAT2HuMAjERKiFjjGt+SuOZSYP6FeAyt2hMUQogd9x2BaRe9JWZaix3yH
         FQ5bOn8kBKj/xVXOsbgRJrBAekiMAD0rBor+aK8NKE50cPDK3nVMLd1hWqKWfapjqoJP
         A9wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ0kn/2UM02jq310hOi8gEigsdaTLgxQPpZcYEEGPGFekQmVx4ZE5GJVFXuJ8OIhMxcrOergVAVipfog==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Oci2U7UE6lgV8PWcTr6ffrrYsqymPSzjmQJ9hgr8wEjWMm/E
	ov2IBqnLhMLu/mmP8WlaHu1P5hTfSfHak2fyRRj6OQRhf9phpV5z
X-Gm-Gg: ASbGnctte+tJfF85tWGBHzwYMaciQzsoy3LzBY4viyOVmNHX91QltfKKZbOBDMpbYAJ
	IX7Bredxbuw2P4RMAg8840gshNDIoMXpm+l0ISYf8Z1JbPaNCHqD6DCWLYQaD/ZL9eqQwWWnDzS
	KfEbv5dlKvLGOzheG+T/qWie/O0PBvUY1N4k0aPsSfiddumHeWgaM2GH1LGYO0krshl8zo+/ENJ
	c2bZiXdbFnw6afGkIiNUhmjqHWhR3GvWWNx3+zHg2ri8hOvBc+pSQ9PxGCS7uwLpxMg
X-Google-Smtp-Source: AGHT+IFQU222wEqut6YxLqWX3vKxdPmjpCZ6ZVIHKaFAl4WbT1+D6QKlfX1lHoQuqt0tkt47p2vjKA==
X-Received: by 2002:a05:6a20:430e:b0:1e6:b2d7:4cf0 with SMTP id adf61e73a8af0-1e6b2d74d7amr11044762637.41.1736251728035;
        Tue, 07 Jan 2025 04:08:48 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:08:47 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 17/22] ublk: bpf: attach bpf aio prog to ublk device
Date: Tue,  7 Jan 2025 20:04:08 +0800
Message-ID: <20250107120417.1237392-18-tom.leiming@gmail.com>
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

Attach bpf aio program to ublk device before adding ublk disk, and detach it
after the disk is removed. And when the bpf aio prog is unregistered,
all devices will detach from the prog automatically.

ublk device needs to provide the bpf aio struct_ops ID for attaching the
specific prog, and each ublk device has to attach to only single bpf prog.

So that we can use the attached bpf aio prog to submit bpf aio for handling ublk IO.

Given bpf aio prog is attached to ublk device, ublk bpf prog has to
provide one kfunc to assign 'bpf_aio_complete_ops *' to 'struct bpf_aio'
instance.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk/bpf.c         | 81 +++++++++++++++++++++++++++++++-
 drivers/block/ublk/bpf_aio.c     |  4 ++
 drivers/block/ublk/bpf_aio.h     |  4 ++
 drivers/block/ublk/bpf_aio_ops.c | 22 +++++++++
 drivers/block/ublk/ublk.h        | 10 ++++
 include/uapi/linux/ublk_cmd.h    |  4 +-
 6 files changed, 123 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk/bpf.c b/drivers/block/ublk/bpf.c
index d5880d61abe5..921bbbcf4d9e 100644
--- a/drivers/block/ublk/bpf.c
+++ b/drivers/block/ublk/bpf.c
@@ -19,6 +19,79 @@ static int ublk_set_bpf_ops(struct ublk_device *ub,
 	return 0;
 }
 
+static int ublk_set_bpf_aio_op(struct ublk_device *ub,
+		struct bpf_aio_complete_ops *ops)
+{
+	int i;
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		if (ops && ublk_get_queue(ub, i)->bpf_aio_ops) {
+			ublk_set_bpf_aio_op(ub, NULL);
+			return -EBUSY;
+		}
+		ublk_get_queue(ub, i)->bpf_aio_ops = ops;
+	}
+	return 0;
+}
+
+static int ublk_bpf_aio_prog_attach_cb(struct bpf_prog_consumer *consumer,
+				       struct bpf_prog_provider *provider)
+{
+	struct ublk_device *ub = container_of(consumer, struct ublk_device,
+					      aio_prog);
+	struct bpf_aio_complete_ops *ops = container_of(provider,
+			struct bpf_aio_complete_ops, provider);
+	int ret = -ENODEV;
+
+	if (ublk_get_device(ub)) {
+		ret = ublk_set_bpf_aio_op(ub, ops);
+		if (ret)
+			ublk_put_device(ub);
+	}
+
+	return ret;
+}
+
+static void ublk_bpf_aio_prog_detach_cb(struct bpf_prog_consumer *consumer,
+					bool unreg)
+{
+	struct ublk_device *ub = container_of(consumer, struct ublk_device,
+					      aio_prog);
+
+	if (unreg) {
+		blk_mq_freeze_queue(ub->ub_disk->queue);
+		ublk_set_bpf_aio_op(ub, NULL);
+		blk_mq_unfreeze_queue(ub->ub_disk->queue);
+	} else {
+		ublk_set_bpf_aio_op(ub, NULL);
+	}
+	ublk_put_device(ub);
+}
+
+static const struct bpf_prog_consumer_ops ublk_aio_prog_consumer_ops = {
+	.attach_fn	= ublk_bpf_aio_prog_attach_cb,
+	.detach_fn	= ublk_bpf_aio_prog_detach_cb,
+};
+
+static int ublk_bpf_aio_attach(struct ublk_device *ub)
+{
+	if (!ublk_dev_support_bpf_aio(ub))
+		return 0;
+
+	ub->aio_prog.prog_id = ub->params.bpf.aio_ops_id;
+	ub->aio_prog.ops = &ublk_aio_prog_consumer_ops;
+
+	return bpf_aio_prog_attach(&ub->aio_prog);
+}
+
+static void ublk_bpf_aio_detach(struct ublk_device *ub)
+{
+	if (!ublk_dev_support_bpf_aio(ub))
+		return;
+	bpf_aio_prog_detach(&ub->aio_prog);
+}
+
+
 static int ublk_bpf_prog_attach_cb(struct bpf_prog_consumer *consumer,
 				   struct bpf_prog_provider *provider)
 {
@@ -76,19 +149,25 @@ static const struct bpf_prog_consumer_ops ublk_prog_consumer_ops = {
 
 int ublk_bpf_attach(struct ublk_device *ub)
 {
+	int ret;
+
 	if (!ublk_dev_support_bpf(ub))
 		return 0;
 
 	ub->prog.prog_id = ub->params.bpf.ops_id;
 	ub->prog.ops = &ublk_prog_consumer_ops;
 
-	return ublk_bpf_prog_attach(&ub->prog);
+	ret = ublk_bpf_prog_attach(&ub->prog);
+	if (ret)
+		return ret;
+	return ublk_bpf_aio_attach(ub);
 }
 
 void ublk_bpf_detach(struct ublk_device *ub)
 {
 	if (!ublk_dev_support_bpf(ub))
 		return;
+	ublk_bpf_aio_detach(ub);
 	ublk_bpf_prog_detach(&ub->prog);
 }
 
diff --git a/drivers/block/ublk/bpf_aio.c b/drivers/block/ublk/bpf_aio.c
index 6e93f28f389b..da050be4b710 100644
--- a/drivers/block/ublk/bpf_aio.c
+++ b/drivers/block/ublk/bpf_aio.c
@@ -213,6 +213,10 @@ __bpf_kfunc int bpf_aio_submit(struct bpf_aio *aio, int fd, loff_t pos,
 {
 	struct file *file;
 
+	/*
+	 * ->ops has to assigned by kfunc of consumer subsystem because
+	 * bpf prog lifetime is aligned with the consumer subsystem
+	 */
 	if (!aio->ops)
 		return -EINVAL;
 
diff --git a/drivers/block/ublk/bpf_aio.h b/drivers/block/ublk/bpf_aio.h
index 07fcd43fd2ac..d144c5e20dcb 100644
--- a/drivers/block/ublk/bpf_aio.h
+++ b/drivers/block/ublk/bpf_aio.h
@@ -75,4 +75,8 @@ struct bpf_aio *bpf_aio_alloc_sleepable(unsigned int op, enum bpf_aio_flag aio_f
 void bpf_aio_release(struct bpf_aio *aio);
 int bpf_aio_submit(struct bpf_aio *aio, int fd, loff_t pos, unsigned bytes,
 		unsigned io_flags);
+
+int bpf_aio_prog_attach(struct bpf_prog_consumer *consumer);
+void bpf_aio_prog_detach(struct bpf_prog_consumer *consumer);
+
 #endif
diff --git a/drivers/block/ublk/bpf_aio_ops.c b/drivers/block/ublk/bpf_aio_ops.c
index 12757f634dbd..04ad45fd24e6 100644
--- a/drivers/block/ublk/bpf_aio_ops.c
+++ b/drivers/block/ublk/bpf_aio_ops.c
@@ -120,6 +120,28 @@ static void bpf_aio_unreg(void *kdata, struct bpf_link *link)
 	kfree(curr);
 }
 
+int bpf_aio_prog_attach(struct bpf_prog_consumer *consumer)
+{
+	unsigned id = consumer->prog_id;
+	struct bpf_aio_complete_ops *ops;
+	int ret = -EINVAL;
+
+	mutex_lock(&bpf_aio_ops_lock);
+	ops = xa_load(&bpf_aio_all_ops, id);
+	if (ops && ops->id == id)
+		ret = bpf_prog_consumer_attach(consumer, &ops->provider);
+	mutex_unlock(&bpf_aio_ops_lock);
+
+	return ret;
+}
+
+void bpf_aio_prog_detach(struct bpf_prog_consumer *consumer)
+{
+	mutex_lock(&bpf_aio_ops_lock);
+	bpf_prog_consumer_detach(consumer, false);
+	mutex_unlock(&bpf_aio_ops_lock);
+}
+
 static void bpf_aio_cb(struct bpf_aio *io, long ret)
 {
 }
diff --git a/drivers/block/ublk/ublk.h b/drivers/block/ublk/ublk.h
index 8343e70bd723..2c33f6a94bf2 100644
--- a/drivers/block/ublk/ublk.h
+++ b/drivers/block/ublk/ublk.h
@@ -126,6 +126,7 @@ struct ublk_queue {
 
 #ifdef CONFIG_UBLK_BPF
 	struct ublk_bpf_ops     *bpf_ops;
+	struct bpf_aio_complete_ops     *bpf_aio_ops;
 #endif
 
 	unsigned short force_abort:1;
@@ -159,6 +160,7 @@ struct ublk_device {
 
 #ifdef CONFIG_UBLK_BPF
 	struct bpf_prog_consumer prog;
+	struct bpf_prog_consumer aio_prog;
 #endif
 	struct mutex		mutex;
 
@@ -203,6 +205,14 @@ static inline bool ublk_dev_support_bpf(const struct ublk_device *ub)
 	return ub->dev_info.flags & UBLK_F_BPF;
 }
 
+static inline bool ublk_dev_support_bpf_aio(const struct ublk_device *ub)
+{
+	if (!ublk_dev_support_bpf(ub))
+		return false;
+
+	return ub->params.bpf.flags & UBLK_BPF_HAS_AIO_OPS_ID;
+}
+
 struct ublk_device *ublk_get_device(struct ublk_device *ub);
 struct ublk_device *ublk_get_device_from_id(int idx);
 void ublk_put_device(struct ublk_device *ub);
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 27cf14e65cbc..ed6df4d61e89 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -406,9 +406,11 @@ struct ublk_param_zoned {
 
 struct ublk_param_bpf {
 #define UBLK_BPF_HAS_OPS_ID            (1 << 0)
+#define UBLK_BPF_HAS_AIO_OPS_ID        (1 << 1)
 	__u8	flags;
 	__u8	ops_id;
-	__u8	reserved[6];
+	__u16	aio_ops_id;
+	__u8	reserved[4];
 };
 
 struct ublk_params {
-- 
2.47.0


