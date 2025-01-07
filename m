Return-Path: <bpf+bounces-48082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 230FAA03EB7
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE34163C4A
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC86F1F03D8;
	Tue,  7 Jan 2025 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QU/VBZ4z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79041EE7D5;
	Tue,  7 Jan 2025 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251749; cv=none; b=bmZdrwMD5f8RrQcUUo21rgAKtYqoX9M7B2uTGBfQb1LoAmS1Ee1ynDWgJXhL1C8RTiiQcZMqRs5dz6JITDP2te826Mr/Oab/r4kEdSgFPaIIvX9X1G1scWdq7PEIVUxVmNXpTe0f5HxbXs67QwKu3Q0joiSH5ixck735HJ85l+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251749; c=relaxed/simple;
	bh=UOVyCpofd4EXdvIUpGT4UjWdrswzHfdF2v4vMcmK59o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ue7UZ8PmrZcSSSYoRbplkS9IUQjVUwj08nSKf6b5lQezdMNs/trN40sIcge/dYxqiMNXe0kuLDybx07bMcvT3nVsduwHbSjmSr/7mDj7pe0Kz+3QOQyaIqlebg95ZgwdOEseIc6yaIdHnytJTp3B5ZabSLS7m8UPKlg1ssZUZyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QU/VBZ4z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21628b3fe7dso218304075ad.3;
        Tue, 07 Jan 2025 04:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251735; x=1736856535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z28FLukQqDxI3mqoQ1xUq6UUA9jJA+giSyvGS4e6c8c=;
        b=QU/VBZ4zRuSCSSKtW/3Ijsvn65PD5UT0+bOdueWFmrlLskamg9cMFD2QQo5f5FsVcY
         s6oTQb5QzBwMexaLeEypTQqWFeGrx/xW+vNGPm5vaZ++VzDOBE6/w4QdNrT8dOnvwvaE
         h7EPVGUfg3iS5LsyVJ1Dmu1+5ouMVGl+qPMvI0W8LXVPGpdnqFwE72LzUFESTvINBbID
         dr01++fjdgGOSxlURTsj/xsr60sTRa/aqEWMCAtXbqQ8UHhQ7ymH9+/TPBrNJQchJOOZ
         dfkN0RVZPP54hpDGLxaQPGhSfu0/Wg9sL3tqrXsVmFsKLGaLr22vjWrNnsDeZK+rV5G4
         HzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251735; x=1736856535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z28FLukQqDxI3mqoQ1xUq6UUA9jJA+giSyvGS4e6c8c=;
        b=gzTBh6wAKA/hkVt4GdiyXLs8aFKj5pgdc7VWOLkvTFjneHmHuwclHxpcsq6PNjJONk
         a/phmLlP1JuZ34nzRDzx530uuL2YLuaSB/eF9uKE+NI0o7HXhVJ89HPTImbLO4i8r4T3
         xo9AmM9JLwDQXLZrotSDcd1kCbuGBLO3q+yJVnww9U3RmkTBD+LFs1XEorTBOVfMFgKD
         ebnWpFCHWvU+lPEv9HLadHWawP+7DTkfVU/PMuWIqJcxOgKH2h2LV0una87lKe+na+kK
         HDbIT9rRJACNxfEM00DSWuF43recn2ytypl/5wL+UDeu2NcborpEW6MfZ4UorkVPeXuZ
         5UWw==
X-Forwarded-Encrypted: i=1; AJvYcCUDNxI1TrLRqVTnzPkmf7Qb9jXiaN/hXxua8y+w+MzAPHKdaRfiNnwYo6rKI12LJp4P91FnNlfAU47ojg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr494e6c2CSJGt5QKtJMzXtemeKg6W8xdkNjYGYim9VhfpheBQ
	OQQ1peEFNI1cuAs8B0rnHYss2fO47B6+ZbTrji8+aWwKPO5vsfehlmslUxwdXKc=
X-Gm-Gg: ASbGncuCUDdyv+bA8D2ujEu28v6jRAeFxJIYMoIxHT/waEREdbCRgnGQ8EyFhHOYcB4
	3n07XHfmmsZ5vQFOri3wh4GwgzD2Qslss5FUn2/6GZTO+nsAg7uXJUL5gox/coiqYhuZ1I8FhJA
	/jcxxOQVl41GH8Jf3vKp8aUKdwtQ9yAts4uakiPqQzedHZb9jfq8vHq9kCo9KQBkqETNq0escO/
	b0U37VIHGqymuYpG1LxBfVdAZ33EVv37mFhqCfKqT1RIdWWZ0n/Zg1gnhJV0sHlDVoG
X-Google-Smtp-Source: AGHT+IFQeLqa9/UEKemi5zYwifY340nv63/+KSbC7bfcikGN77+wT5sopQrYD4I1aL1vEIj3sWfsng==
X-Received: by 2002:a05:6a00:244c:b0:724:bf30:3030 with SMTP id d2e1a72fcca58-72abdbe59f6mr82188396b3a.0.1736251735279;
        Tue, 07 Jan 2025 04:08:55 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:08:54 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 19/22] ublk: bpf: wire bpf aio with ublk io handling
Date: Tue,  7 Jan 2025 20:04:10 +0800
Message-ID: <20250107120417.1237392-20-tom.leiming@gmail.com>
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

Add ublk_bpf_aio_prep_io_buf() and call it before running ublk bpf prog,
so wire everything together.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk/bpf.h     | 13 +++++++++
 drivers/block/ublk/bpf_ops.c | 51 +++++++++++++++++++++++++++++++++++-
 drivers/block/ublk/main.c    |  5 ----
 drivers/block/ublk/ublk.h    |  6 +++++
 4 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk/bpf.h b/drivers/block/ublk/bpf.h
index 0ab25743ae7d..a3d238bc707d 100644
--- a/drivers/block/ublk/bpf.h
+++ b/drivers/block/ublk/bpf.h
@@ -99,6 +99,9 @@ static inline void ublk_bpf_io_dec_ref(struct ublk_bpf_io *io)
 				ubq->bpf_ops->release_io_cmd(io);
 		}
 
+		if (test_bit(UBLK_BPF_BVEC_ALLOCATED, &io->flags))
+			kvfree(io->buf.bvec);
+
 		if (test_bit(UBLK_BPF_IO_COMPLETED, &io->flags)) {
 			smp_rmb();
 			__clear_bit(UBLK_BPF_IO_PREP, &io->flags);
@@ -158,6 +161,11 @@ static inline queue_io_cmd_t ublk_get_bpf_any_io_cb(struct ublk_queue *ubq)
 	return ublk_get_bpf_io_cb_daemon(ubq);
 }
 
+static inline bool ublk_support_bpf_aio(const struct ublk_queue *ubq)
+{
+	return ublk_support_bpf(ubq) && ubq->bpf_aio_ops;
+}
+
 int ublk_bpf_init(void);
 int ublk_bpf_struct_ops_init(void);
 int ublk_bpf_prog_attach(struct bpf_prog_consumer *consumer);
@@ -190,6 +198,11 @@ static inline queue_io_cmd_t ublk_get_bpf_any_io_cb(struct ublk_queue *ubq)
 	return NULL;
 }
 
+static inline bool ublk_support_bpf_aio(const struct ublk_queue *ubq)
+{
+	return false;
+}
+
 static inline int ublk_bpf_init(void)
 {
 	return 0;
diff --git a/drivers/block/ublk/bpf_ops.c b/drivers/block/ublk/bpf_ops.c
index 05d8d415b30d..7085eab5e99b 100644
--- a/drivers/block/ublk/bpf_ops.c
+++ b/drivers/block/ublk/bpf_ops.c
@@ -155,6 +155,49 @@ void ublk_bpf_prog_detach(struct bpf_prog_consumer *consumer)
 	mutex_unlock(&ublk_bpf_ops_lock);
 }
 
+static int ublk_bpf_aio_prep_io_buf(const struct request *req)
+{
+	struct ublk_rq_data *data = blk_mq_rq_to_pdu((struct request *)req);
+	struct ublk_bpf_io *io = &data->bpf_data;
+	struct req_iterator rq_iter;
+	struct bio_vec *bvec;
+	struct bio_vec bv;
+	unsigned offset;
+
+	io->buf.bvec = NULL;
+	io->buf.nr_bvec = 0;
+
+	if (!ublk_rq_has_data(req))
+		return 0;
+
+	rq_for_each_bvec(bv, req, rq_iter)
+		io->buf.nr_bvec++;
+
+	if (!io->buf.nr_bvec)
+		return 0;
+
+	if (req->bio != req->biotail) {
+		int idx = 0;
+
+		bvec = kvmalloc_array(io->buf.nr_bvec, sizeof(struct bio_vec),
+				GFP_NOIO);
+		if (!bvec)
+			return -ENOMEM;
+
+		offset = 0;
+		rq_for_each_bvec(bv, req, rq_iter)
+			bvec[idx++] = bv;
+		__set_bit(UBLK_BPF_BVEC_ALLOCATED, &io->flags);
+	} else {
+		struct bio *bio = req->bio;
+
+		offset = bio->bi_iter.bi_bvec_done;
+		bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
+	}
+	io->buf.bvec = bvec;
+	io->buf.bvec_off = offset;
+	return 0;
+}
 
 static void ublk_bpf_prep_io(struct ublk_bpf_io *io,
 		const struct ublksrv_io_desc *iod)
@@ -180,8 +223,14 @@ bool ublk_run_bpf_handler(struct ublk_queue *ubq, struct request *req,
 	bool res = true;
 	int err;
 
-	if (!test_bit(UBLK_BPF_IO_PREP, &bpf_io->flags))
+	if (!test_bit(UBLK_BPF_IO_PREP, &bpf_io->flags)) {
 		ublk_bpf_prep_io(bpf_io, iod);
+		if (ublk_support_bpf_aio(ubq)) {
+			err = ublk_bpf_aio_prep_io_buf(req);
+			if (err)
+				goto fail;
+		}
+	}
 
 	do {
 		enum ublk_bpf_disposition rc;
diff --git a/drivers/block/ublk/main.c b/drivers/block/ublk/main.c
index 3c2ed9bf924d..1974ebd33ce0 100644
--- a/drivers/block/ublk/main.c
+++ b/drivers/block/ublk/main.c
@@ -512,11 +512,6 @@ void ublk_put_device(struct ublk_device *ub)
 	put_device(&ub->cdev_dev);
 }
 
-static inline bool ublk_rq_has_data(const struct request *rq)
-{
-	return bio_has_data(rq->bio);
-}
-
 static inline char *ublk_queue_cmd_buf(struct ublk_device *ub, int q_id)
 {
 	return ublk_get_queue(ub, q_id)->io_cmd_buf;
diff --git a/drivers/block/ublk/ublk.h b/drivers/block/ublk/ublk.h
index 4bd04512c894..00b09589d95c 100644
--- a/drivers/block/ublk/ublk.h
+++ b/drivers/block/ublk/ublk.h
@@ -41,6 +41,7 @@
 enum {
 	UBLK_BPF_IO_PREP	= 0,
 	UBLK_BPF_IO_COMPLETED   = 1,
+	UBLK_BPF_BVEC_ALLOCATED	= 2,
 };
 
 struct ublk_bpf_io {
@@ -215,6 +216,11 @@ static inline bool ublk_dev_support_bpf_aio(const struct ublk_device *ub)
 	return ub->params.bpf.flags & UBLK_BPF_HAS_AIO_OPS_ID;
 }
 
+static inline bool ublk_rq_has_data(const struct request *rq)
+{
+	return bio_has_data(rq->bio);
+}
+
 struct ublk_device *ublk_get_device(struct ublk_device *ub);
 struct ublk_device *ublk_get_device_from_id(int idx);
 void ublk_put_device(struct ublk_device *ub);
-- 
2.47.0


