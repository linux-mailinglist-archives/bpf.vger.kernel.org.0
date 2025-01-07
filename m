Return-Path: <bpf+bounces-48070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C58AA03E9B
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 400F37A1F5E
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A221EE7C0;
	Tue,  7 Jan 2025 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY9ShYjX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A561EE00E;
	Tue,  7 Jan 2025 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251683; cv=none; b=VFO9Y9hkVoBQInqsuJCHmhdbc6OQ+5M+x43nto+6hGUlS+aeQSADG6aHY/i/+oR9qdDgLuTJ2oHhQggzrG8MmU2HZj+qtfEtP0dQoILqc4MciwJq+3R2U10SCaKPLCc2tJUA3SqRjQfP0YyMTzYtay9+t47Nx/8WhvJZRVgKz/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251683; c=relaxed/simple;
	bh=S6fCJ2dABAQnEpnmkpc3MnkoO2+ZSkdVwy88fnthDAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJihS0bDxPbc76eWj7sqx2Ez96tEYWPg+GoPyjSReXyMDrwrY0mMwiUV3KFfwqfhgm3niEm6zkeNzUMGPu4sGWXedcAZmzSdfRWyvDz5kJfLJJyzgMn3Jj/evLdIaaHN3mXAQy3iPs9tUrzlcH8jVCyfUy7a+U8TFYptLVetTBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lY9ShYjX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21669fd5c7cso228813145ad.3;
        Tue, 07 Jan 2025 04:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251681; x=1736856481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nY7Yr65sXJ0bfSa8yv+g/jvRh1BAnFP0+HXza/gQjg=;
        b=lY9ShYjXhJyoVwqOwsAdS5aB8eIIofqM0q3UwRxE08zY3TCKLJlfo/9E2xjMNDcNNV
         92hRWJKPHILg7S3WSlyNN+MRRt9MZe2M9oq/z5YzPEkncqYpfiZFljKlTI9VEtRzrbtp
         q52gAZdFUvv09lIJAqQRXctPmYziq/I2W/J1fqgqCyOlAOeqHan/zgIXkni41vEOeZeh
         ZnpTfocqcuhl9GuKU+lQphEi011pKfXdw++CVAcWaqAoO0LboP2C1kHKEyPSIoza3Pt1
         ukqG/vX704RZVZZW2apWXzU3Zp8r9cH9KHgn8SlMJ1TQ1SaHbB9oiB2WuyyNpFDKgvR+
         SHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251681; x=1736856481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nY7Yr65sXJ0bfSa8yv+g/jvRh1BAnFP0+HXza/gQjg=;
        b=g6D+u4zvwoLx8S5x8QcOckp5ESVlRjK89kpa3BIJvWLgs0YZaBShSdh/FbtVGFHn53
         iliw88QmxFoN1OZOBX/7+BPqmOIEQc425CJ8JE2klKAYOvl9qbEk9o6mNeydzlvzHJKJ
         GYXxIQ6gjFslGJOXsQY56ogqUeaKzspDyKBa2ehO//WkzEMYjsPxdzN5CpKbsxftxDa8
         tXf5T0olWAPZekUwZ1qNoGFx5spofHgFdTN2DyXUNs5+//fs1Bf1u//QVnRRqQ3pk1aK
         xV35bK+FxyO4TZ5yvCFsvYAPTUgJxyseAz06M1iSalFwGqPQai8e+7QiWFdArpY0Rl8V
         c24Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzzXZSAlVfRfxlJ4JJASjov6C/aqZx6s/Y1j7+oaj9Bk+3pR3T98cHo/Jp1Givu80npRb32LdjH/iMfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz97X7ZcLu/Tfjy2yfZGU/yT7xtoxC1y82crKe245/rAiruAWK+
	rn3l5nB08+pDU/wa77fnIwpm0elC+ZK0DLUqQOM9fvXCKrGZD8ze
X-Gm-Gg: ASbGnctLoXCkZJuP/Melcz1PlKuA2DlGjEwGKCnaKso7Dd0AFmBFpuxNtCcXLYKM4mz
	3QQBxERVKMJxEFS9F3Qo4d8v4HwUB9v3a547DTgbfHr9Wh2vT12Gc6+GIxStu7z0rnQw5QsGxU3
	98bWfJUGM7rA9bIFYBlYy222OZuBbFwOUefo7NXs/yqzrhXh6mj+6c2bVijdCi60GRe8b6jxb51
	GCq1fzsGr0SKJ0LDw1aewaVpHZb8VWYL/cELnws74LUvTsXfn2IN8obaabqyZ+oHFBh
X-Google-Smtp-Source: AGHT+IEo5B9afYHXAr98ia7+X6t/pKWd6xfN3NLc77AJfsbVKQxDXoVhcnGAcR2XLs/Y5+Fun+jnUg==
X-Received: by 2002:a05:6a00:23c1:b0:72a:bc54:be9e with SMTP id d2e1a72fcca58-72abde30d9dmr79487080b3a.15.1736251680927;
        Tue, 07 Jan 2025 04:08:00 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:08:00 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 02/22] ublk: convert several bool type fields into bitfield of `ublk_queue`
Date: Tue,  7 Jan 2025 20:03:53 +0800
Message-ID: <20250107120417.1237392-3-tom.leiming@gmail.com>
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

Convert several `bool` type fields into bitfields of `ublk_queue`, so
that we can remove one padding and save one 4 bytes in `ublk_queue`.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 77ce3231eba4..00363e8affc6 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -143,10 +143,10 @@ struct ublk_queue {
 
 	struct llist_head	io_cmds;
 
-	bool force_abort;
-	bool timeout;
-	bool canceling;
-	bool fail_io; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
+	unsigned short force_abort:1;
+	unsigned short timeout:1;
+	unsigned short canceling:1;
+	unsigned short fail_io:1; /* copy of dev->state == UBLK_S_DEV_FAIL_IO */
 	unsigned short nr_io_ready;	/* how many ios setup */
 	spinlock_t		cancel_lock;
 	struct ublk_device *dev;
@@ -1257,7 +1257,7 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
 		if (!ubq->timeout) {
 			send_sig(SIGKILL, ubq->ubq_daemon, 0);
-			ubq->timeout = true;
+			ubq->timeout = 1;
 		}
 
 		return BLK_EH_DONE;
@@ -1459,7 +1459,7 @@ static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
 		spin_unlock(&ubq->cancel_lock);
 		return false;
 	}
-	ubq->canceling = true;
+	ubq->canceling = 1;
 	spin_unlock(&ubq->cancel_lock);
 
 	spin_lock(&ub->lock);
@@ -1609,7 +1609,7 @@ static void ublk_unquiesce_dev(struct ublk_device *ub)
 	 * can move on.
 	 */
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
-		ublk_get_queue(ub, i)->force_abort = true;
+		ublk_get_queue(ub, i)->force_abort = 1;
 
 	blk_mq_unquiesce_queue(ub->ub_disk->queue);
 	/* We may have requeued some rqs in ublk_quiesce_queue() */
@@ -1672,7 +1672,7 @@ static void ublk_nosrv_work(struct work_struct *work)
 		blk_mq_quiesce_queue(ub->ub_disk->queue);
 		ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
 		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-			ublk_get_queue(ub, i)->fail_io = true;
+			ublk_get_queue(ub, i)->fail_io = 1;
 		}
 		blk_mq_unquiesce_queue(ub->ub_disk->queue);
 	}
@@ -2744,8 +2744,8 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
 	put_task_struct(ubq->ubq_daemon);
 	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
 	ubq->ubq_daemon = NULL;
-	ubq->timeout = false;
-	ubq->canceling = false;
+	ubq->timeout = 0;
+	ubq->canceling = 0;
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
@@ -2844,7 +2844,7 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 		blk_mq_quiesce_queue(ub->ub_disk->queue);
 		ub->dev_info.state = UBLK_S_DEV_LIVE;
 		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-			ublk_get_queue(ub, i)->fail_io = false;
+			ublk_get_queue(ub, i)->fail_io = 0;
 		}
 		blk_mq_unquiesce_queue(ub->ub_disk->queue);
 	}
-- 
2.47.0


