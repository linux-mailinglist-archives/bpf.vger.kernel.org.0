Return-Path: <bpf+bounces-48084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB872A03EBC
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295F63A506E
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD031F12FF;
	Tue,  7 Jan 2025 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOg80+ou"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74231EE7CD;
	Tue,  7 Jan 2025 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251765; cv=none; b=VDJQf+RGfh1ySRYZWOdSd3WxJgvBIhnETBjOP2YByS3EdcO7c8nzqwMI5BBlDjU7zyaM31GE1FxRUEEESGRIqPbL1hRYjENBOb+RldNx+poUcJyx9ialx5Qm4tuSREO+9g6eVLKsfGCwixBQlZi9bkYgZUfX5kq+PChie66u1Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251765; c=relaxed/simple;
	bh=DuYK349QWocmvKBH2q5HjOCLoOLJyazu8j8fZf0/Y0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+X5jm2l9gW0HbmPPX2qlscmL6QUHLD+eRbTzzg8dHTRuW9R60IwJIXciN0CYZmCdCvslRFrry1g/nylCl0k8RFh2AnMu7NLzECcaQTUrhM7shYg2CVVw3N2nU4t4F2SGmsRbEmLrknwL9kWvcYfzlCR7gglnqgvqi6px8Afoqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOg80+ou; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21661be2c2dso205225545ad.1;
        Tue, 07 Jan 2025 04:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251731; x=1736856531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0H88QF/Rk74Ebj0cgESBiJW8Kg50jsqod4brl+UMFwI=;
        b=NOg80+ou1Dt9rU5DTA9QKOmQQHbhU5xU4oV4O9x+CG/7ZolhjUcR4GMG7IudBMPYrq
         jVKRc6m9wZxO5iaiv4RkQpvNJx0VoNSHI8jYD5zwe1lDBYyOgxgwveg9JKFrJzk43/ON
         ymniBFj8J/GHhthS6UUtaAiWEbqE+JDvswnOYDncRZX0cB/UgYnPJWVLSc40CSj6TXEm
         7wOid8z27oyfBTX6lSkUE5GQBC1SjozVMFWoh8Gf2xdRkTuoGjBx6f+m/Dmi1puW0tZK
         RIRPCd9a9cJ65u1M48iqfnJAU/SR6XmDjRwqt3j4i+qXbTZM84GumveBDoiRaTjZrT8D
         luUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251731; x=1736856531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0H88QF/Rk74Ebj0cgESBiJW8Kg50jsqod4brl+UMFwI=;
        b=vAfrts3tVPfQht17pVkETX1ojKllMROGy7/Y0FTPiCgAyUskMSbYl/n4n7VszLUL/A
         MTc9N0oURCMN1NGE6FMeJ8h+zA3O0vOzy5GXNIAIDYFKOFySIwzqN8Mcy6HLmTk0DsV6
         XH+H3WHftud3vMWJ80KwQkdrO5E3HPihQL2vp9sL11SgRqSVhuw5WGwk4mP0fR0eKlCH
         EbMsfQrUkICxytJHEOX+9suHzj2pDh8C5hUShO8+a2NU+0wricKcFuy4zeXlVNGozSv8
         yf5ypeZ6Y6S2yOqVkPHyt3Ij/lhWP4kWi62Z6yGiO6eAJj87r1DSgDDKvELRdP77NnKH
         V/Zg==
X-Forwarded-Encrypted: i=1; AJvYcCV6piKXSDZ90aSSmHvxQZEwffQfrmorwEeuMxnTTamvsC0axbAO4zke5+geFcYKGS3xTyqr7bDDS78sGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4H9oWYf9q/HqcC0Z1XMLGkO+ibSCQJI6vKzjmUmh31okgopJs
	m8lYry/3sv6MutljWRzmIwVYwge7OqJEAuXrL/+hLggiZkST+AQG
X-Gm-Gg: ASbGncs5zWuoRlaTkPkFyFIjDvXRqKX7WZp9k1UKYo5r06qrgIschD3JwKN6GHBpOfr
	bepz/j5lxtyHgZNiw5AzvktqugnKcKNLzkRV9DqganCsWLEQShq8peev8b1UIwSeaJuvCDMPLRK
	/0L4wDSdr7KWGd9rydMnXdl/h8hwPEXTbp1rTH28TY+hN2bZV3JHEOK1BkCqhm2P51F4wYPcT9q
	bNkGg5vYul8eIVOSgIPc5SGyVO5lzAn6u7nKeM4Z/R2WLEySjHwf59ipU8IPxqJeadC
X-Google-Smtp-Source: AGHT+IGnRh9cdtFUwPt/oUrHUR6JYIEVNO9kbawsgfW4Ycr3KcLPP2EX7S6p3lJzxu6HTSlwyhZMRw==
X-Received: by 2002:a05:6a00:8d8c:b0:71e:a3:935b with SMTP id d2e1a72fcca58-72abdee2117mr94750158b3a.25.1736251731560;
        Tue, 07 Jan 2025 04:08:51 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:08:50 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 18/22] ublk: bpf: add several ublk bpf aio kfuncs
Date: Tue,  7 Jan 2025 20:04:09 +0800
Message-ID: <20250107120417.1237392-19-tom.leiming@gmail.com>
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

Add ublk bpf aio kfuncs for bpf prog to do:

- prepare buffer
- assign bpf aio struct_ops
- submit bpf aios for handle ublk io command
- deal with ublk io and bpf aio lifetime, and make sure that
ublk io won't be completed until all bpf aios are completed

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk/bpf.c     | 77 ++++++++++++++++++++++++++++++++++++
 drivers/block/ublk/bpf_aio.c |  6 ++-
 drivers/block/ublk/bpf_aio.h | 38 +++++++++++++++++-
 drivers/block/ublk/ublk.h    |  2 +
 4 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk/bpf.c b/drivers/block/ublk/bpf.c
index 921bbbcf4d9e..c0babf6d5868 100644
--- a/drivers/block/ublk/bpf.c
+++ b/drivers/block/ublk/bpf.c
@@ -228,6 +228,77 @@ ublk_bpf_complete_io(struct ublk_bpf_io *io, int res)
 	ublk_bpf_complete_io_cmd(io, res);
 }
 
+/*
+ * Called before submitting one bpf aio in prog, and this ublk IO's
+ * reference is increased.
+ *
+ * Grab reference of `io` for this `aio`, and the reference will be dropped
+ * by ublk_bpf_dettach_and_complete_aio()
+ */
+__bpf_kfunc int
+ublk_bpf_attach_and_prep_aio(const struct ublk_bpf_io *_io, unsigned off,
+		unsigned bytes, struct bpf_aio *aio)
+{
+	struct ublk_bpf_io *io = (struct ublk_bpf_io *)_io;
+	const struct request *req;
+	const struct ublk_rq_data *data;
+	const struct ublk_bpf_io *bpf_io;
+
+	if (!io || !aio)
+		return -EINVAL;
+
+	req = ublk_bpf_get_req(io);
+	if (!req)
+		return -EINVAL;
+
+	if (off + bytes > blk_rq_bytes(req))
+		return -EINVAL;
+
+	if (req->mq_hctx) {
+		const struct ublk_queue *ubq = req->mq_hctx->driver_data;
+
+		bpf_aio_assign_cb(aio, ubq->bpf_aio_ops);
+	}
+
+	data = blk_mq_rq_to_pdu((struct request *)req);
+	bpf_io = &data->bpf_data;
+	bpf_aio_assign_buf(aio, &bpf_io->buf, off, bytes);
+
+	refcount_inc(&io->ref);
+	aio->private_data = (void *)io;
+
+	return 0;
+}
+
+/*
+ * Called after this attached aio is completed, and the associated ublk IO's
+ * reference is decreased, and if the reference is dropped to zero, complete
+ * this ublk IO.
+ *
+ * Return -EIOCBQUEUED if this `io` is being handled, and 0 is returned
+ * if it can be completed now.
+ */
+__bpf_kfunc void
+ublk_bpf_dettach_and_complete_aio(struct bpf_aio *aio)
+{
+	struct ublk_bpf_io *io = aio->private_data;
+
+	if (io) {
+		ublk_bpf_io_dec_ref(io);
+		aio->private_data = NULL;
+	}
+}
+
+__bpf_kfunc struct ublk_bpf_io *ublk_bpf_acquire_io_from_aio(struct bpf_aio *aio)
+{
+	return aio->private_data;
+}
+
+__bpf_kfunc void ublk_bpf_release_io_from_aio(struct ublk_bpf_io *io)
+{
+}
+
+
 BTF_KFUNCS_START(ublk_bpf_kfunc_ids)
 BTF_ID_FLAGS(func, ublk_bpf_complete_io, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, ublk_bpf_get_iod, KF_TRUSTED_ARGS | KF_RET_NULL)
@@ -240,6 +311,12 @@ BTF_ID_FLAGS(func, bpf_aio_alloc, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_aio_alloc_sleepable, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_aio_release)
 BTF_ID_FLAGS(func, bpf_aio_submit)
+
+/* ublk bpf aio kfuncs */
+BTF_ID_FLAGS(func, ublk_bpf_attach_and_prep_aio)
+BTF_ID_FLAGS(func, ublk_bpf_dettach_and_complete_aio)
+BTF_ID_FLAGS(func, ublk_bpf_acquire_io_from_aio, KF_ACQUIRE)
+BTF_ID_FLAGS(func, ublk_bpf_release_io_from_aio, KF_RELEASE)
 BTF_KFUNCS_END(ublk_bpf_kfunc_ids)
 
 __bpf_kfunc void bpf_aio_release_dtor(void *aio)
diff --git a/drivers/block/ublk/bpf_aio.c b/drivers/block/ublk/bpf_aio.c
index da050be4b710..06a6cc8f38b1 100644
--- a/drivers/block/ublk/bpf_aio.c
+++ b/drivers/block/ublk/bpf_aio.c
@@ -211,6 +211,7 @@ __bpf_kfunc void bpf_aio_release(struct bpf_aio *aio)
 __bpf_kfunc int bpf_aio_submit(struct bpf_aio *aio, int fd, loff_t pos,
 		unsigned bytes, unsigned io_flags)
 {
+	unsigned op = bpf_aio_get_op(aio);
 	struct file *file;
 
 	/*
@@ -220,6 +221,9 @@ __bpf_kfunc int bpf_aio_submit(struct bpf_aio *aio, int fd, loff_t pos,
 	if (!aio->ops)
 		return -EINVAL;
 
+	if (unlikely((bytes > aio->buf_size) && bpf_aio_is_rw(op)))
+		return -EINVAL;
+
 	file = fget(fd);
 	if (!file)
 		return -EINVAL;
@@ -232,7 +236,7 @@ __bpf_kfunc int bpf_aio_submit(struct bpf_aio *aio, int fd, loff_t pos,
 	aio->iocb.ki_filp = file;
 	aio->iocb.ki_flags = io_flags;
 	aio->bytes = bytes;
-	if (bpf_aio_is_rw(bpf_aio_get_op(aio))) {
+	if (bpf_aio_is_rw(op)) {
 		if (file->f_flags & O_DIRECT)
 			aio->iocb.ki_flags |= IOCB_DIRECT;
 		else
diff --git a/drivers/block/ublk/bpf_aio.h b/drivers/block/ublk/bpf_aio.h
index d144c5e20dcb..0683139f5354 100644
--- a/drivers/block/ublk/bpf_aio.h
+++ b/drivers/block/ublk/bpf_aio.h
@@ -40,11 +40,15 @@ struct bpf_aio_buf {
 
 struct bpf_aio {
 	unsigned int opf;
-	unsigned int bytes;
+	union {
+		unsigned int bytes;
+		unsigned int buf_size;
+	};
 	struct bpf_aio_buf	buf;
 	struct bpf_aio_work	*work;
 	const struct bpf_aio_complete_ops *ops;
 	struct kiocb iocb;
+	void	*private_data;
 };
 
 typedef void (*bpf_aio_complete_t)(struct bpf_aio *io, long ret);
@@ -68,6 +72,38 @@ static inline unsigned int bpf_aio_get_op(const struct bpf_aio *aio)
 	return aio->opf & BPF_AIO_OP_MASK;
 }
 
+/* Must be called from kfunc defined in consumer subsystem */
+static inline void bpf_aio_assign_cb(struct bpf_aio *aio,
+		const struct bpf_aio_complete_ops *ops)
+{
+	aio->ops = ops;
+}
+
+/*
+ * Skip `skip` bytes and assign the advanced source buffer for `aio`, so
+ * we can cover this part of source buffer by this `aio`
+ */
+static inline void bpf_aio_assign_buf(struct bpf_aio *aio,
+		const struct bpf_aio_buf *src, unsigned skip,
+		unsigned bytes)
+{
+	const struct bio_vec *bvec, *end;
+	struct bpf_aio_buf *abuf = &aio->buf;
+
+	skip += src->bvec_off;
+	for (bvec = src->bvec, end = bvec + src->nr_bvec; bvec < end; bvec++) {
+		if (likely(skip < bvec->bv_len))
+			break;
+		skip -= bvec->bv_len;
+	}
+
+	aio->buf_size = bytes;
+	abuf->bvec_off = skip;
+	abuf->nr_bvec = src->nr_bvec - (bvec - src->bvec);
+	abuf->bvec = bvec;
+}
+
+
 int bpf_aio_init(void);
 int bpf_aio_struct_ops_init(void);
 struct bpf_aio *bpf_aio_alloc(unsigned int op, enum bpf_aio_flag aio_flags);
diff --git a/drivers/block/ublk/ublk.h b/drivers/block/ublk/ublk.h
index 2c33f6a94bf2..4bd04512c894 100644
--- a/drivers/block/ublk/ublk.h
+++ b/drivers/block/ublk/ublk.h
@@ -8,6 +8,7 @@
 #include <uapi/linux/ublk_cmd.h>
 
 #include "bpf_reg.h"
+#include "bpf_aio.h"
 
 #define UBLK_MINORS		(1U << MINORBITS)
 
@@ -47,6 +48,7 @@ struct ublk_bpf_io {
 	unsigned long			flags;
 	refcount_t                      ref;
 	int				res;
+	struct bpf_aio_buf		buf;
 };
 
 struct ublk_rq_data {
-- 
2.47.0


