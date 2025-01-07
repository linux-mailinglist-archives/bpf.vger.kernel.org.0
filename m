Return-Path: <bpf+bounces-48075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9213A03EA5
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7C91885346
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1511F0E39;
	Tue,  7 Jan 2025 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgTFJyea"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2EA1EE7AA;
	Tue,  7 Jan 2025 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251708; cv=none; b=uPHqWv62BAEdcH/WpU/A1VVsVCyFAaYpgmu/566GcWoqnnZddenl5TDyFDMU4tpnMD2m3aYr4iEfNf4WrI8TwwiyjnInbYDMCCQ8SYWS/wCJOopgZ12ASPOINRuMMowi5ux33jb8tYaOjtTvTeaFBEDHI2JmSBTZvzNbxfXqkVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251708; c=relaxed/simple;
	bh=KpB8oZdccyptJ51tr/eLtNf7aCHFsrx2/aU7p0RUFOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnBPD/l+4a3RBNLs8rA7EXG9bfUMiSjmM2zR+vE8t4qYFrOIPV4mU/T5KpNFL3s6Rm+CV1fKYXrw1IS5g9/Lb/cgYhPlmX4YQw6DYTW/aRF93FLKFgwTUChEXyie4yRCmRFU1ItvFNy9MbjXpXlrrn0ehUdKACuBso/93GY6vbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgTFJyea; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-218c8aca5f1so31260545ad.0;
        Tue, 07 Jan 2025 04:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251693; x=1736856493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75TVTqAygBf7jlHWTgqW0xceJCICHP0IxYYCkmaSwCo=;
        b=JgTFJyeaFwdGfvhgd0cMTc1oeQMl/H3BVlHOhBp/trZ5c0Ost+RAS0Eye8G4xAbGOt
         fnXF/QnCS3p6IxOMYUyt6IllYT8OggDK+HGFPcQGKNUx/jdgJYZhU6uKeaVnkCnPWGzZ
         wpxTmtWZ104rA+Mmb42BGrxlTyL1d7ZgY9StlA9Jf3jNVgm00ulD3SuiBG/t1h/nzlyP
         qotE0d5VupWJnXgTfz9iB+fhW15LGrXKVqlHdtwuh/R0RKAs44UFB63x1xvGY+fOuauj
         QYHLPQTS01+nYD/R5DpxxUqAWR+XpPxvGJlqb5dqFMWcZHmdQpdElrZU697tvQ7w94JM
         /AJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251693; x=1736856493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75TVTqAygBf7jlHWTgqW0xceJCICHP0IxYYCkmaSwCo=;
        b=VmZvm8uGDqsPOfWgWKrUDA5N6Thg4l+30dIdFfk2zrqdfx7HuQpxjdXJDr0Dw/N/Eg
         armsJ64MZcsjm3uqDGBINUvtxs4Qg3tYjYDETEt1iwJjuaKLXG5s/SZNeUK2ji4tVTgA
         VZMQ4SGj9Zeq3PfX1l5EaXDuk+XrqCQEql3aDdFrLpN07VwH7eC4HOjbkMzTnUv4Kxa5
         ySctiidxK5+pg+Fl9/59zVorBXxrQ1GGFEHUcvPBGLiZLLMOcWHmMxmZodh6U0nyLHbA
         jSRDhdgM62ervQLi2wq13+J6w7wwgpWSURA9FveYhUZftx85oPPzs2yQJ4N/A2TCYCzN
         31Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWfpIO/HEhEXFiTFmpYi8cvEAl/8EG+TZgyS7fDWz7TeyPUXgFBT+8vramKDPW/r+mIS1Vnv0DgZBePoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQK+USB3yctFIUCZ966/6P52i2r2IeMcW/2MVPAOOCxRrWrUEr
	KWBBG5VtSxpuCkpipE7v7CxHbuOS9cbKcj3L/+o2EyRR3sdw3BZ2
X-Gm-Gg: ASbGncuNxsr2dVOyzoS5ujx6NRXl3tO0ZHs87DiOg8NT6UzXsjQLdFELv9KCP8+vNeb
	VLPwgCKwCdxSR8443S6cTJQkyPTdMYhM/7PcTrVqwKfKvRWPKGjvmZslstlIGTcvDk9lSII+TmM
	BjbAb/6AsNYu+gHuTb3nK7PqrCt8x+EIb9dT4+VrmzBNtnYaOXSx4AdPkzmHwf6ulShd7Tno9fP
	FfNgEF3GZGIARO7ClCuMfX28ayeEAYbc/ldsHoWN8g+yC/uQgeLZ1tIc7ULEEKl/7as
X-Google-Smtp-Source: AGHT+IHbDkTIn3sGKq6vC1/3PDsX5aI/VlFvjNwqfXOnZJPV1ZofFXkJR5hvFT/1pjOHNYIgrtrMnA==
X-Received: by 2002:a05:6a00:114b:b0:729:49a:2da6 with SMTP id d2e1a72fcca58-72abdd3c2a4mr94023130b3a.3.1736251693210;
        Tue, 07 Jan 2025 04:08:13 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:08:12 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 06/22] ublk: move several helpers to private header
Date: Tue,  7 Jan 2025 20:03:57 +0800
Message-ID: <20250107120417.1237392-7-tom.leiming@gmail.com>
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

Move several helpers into the private header so that make them visible
to the whole driver, and prepare for supporting ublk-bpf.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk/main.c | 16 +++-------------
 drivers/block/ublk/ublk.h | 11 +++++++++++
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/block/ublk/main.c b/drivers/block/ublk/main.c
index 2510193303bb..aefb414ebf6c 100644
--- a/drivers/block/ublk/main.c
+++ b/drivers/block/ublk/main.c
@@ -47,8 +47,6 @@
 static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq);
 
 static inline unsigned int ublk_req_build_flags(struct request *req);
-static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
-						   int tag);
 static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
 {
 	return ub->dev_info.flags & UBLK_F_USER_COPY;
@@ -325,7 +323,6 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 
 #endif
 
-static inline void __ublk_complete_rq(struct request *req);
 static void ublk_complete_rq(struct kref *ref);
 
 static dev_t ublk_chr_devt;
@@ -496,7 +493,7 @@ static noinline struct ublk_device *ublk_get_device(struct ublk_device *ub)
 }
 
 /* Called in slow path only, keep it noinline for trace purpose */
-static noinline void ublk_put_device(struct ublk_device *ub)
+void ublk_put_device(struct ublk_device *ub)
 {
 	put_device(&ub->cdev_dev);
 }
@@ -512,13 +509,6 @@ static inline bool ublk_rq_has_data(const struct request *rq)
 	return bio_has_data(rq->bio);
 }
 
-static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
-		int tag)
-{
-	return (struct ublksrv_io_desc *)
-		&(ubq->io_cmd_buf[tag * sizeof(struct ublksrv_io_desc)]);
-}
-
 static inline char *ublk_queue_cmd_buf(struct ublk_device *ub, int q_id)
 {
 	return ublk_get_queue(ub, q_id)->io_cmd_buf;
@@ -887,7 +877,7 @@ static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
 }
 
 /* todo: handle partial completion */
-static inline void __ublk_complete_rq(struct request *req)
+void __ublk_complete_rq(struct request *req)
 {
 	struct ublk_queue *ubq = req->mq_hctx->driver_data;
 	struct ublk_io *io = &ubq->ios[req->tag];
@@ -2082,7 +2072,7 @@ static void ublk_remove(struct ublk_device *ub)
 	ublks_added--;
 }
 
-static struct ublk_device *ublk_get_device_from_id(int idx)
+struct ublk_device *ublk_get_device_from_id(int idx)
 {
 	struct ublk_device *ub = NULL;
 
diff --git a/drivers/block/ublk/ublk.h b/drivers/block/ublk/ublk.h
index 12e39a33015a..76aee4225c78 100644
--- a/drivers/block/ublk/ublk.h
+++ b/drivers/block/ublk/ublk.h
@@ -154,4 +154,15 @@ struct ublk_params_header {
 };
 
 
+static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
+		int tag)
+{
+	return (struct ublksrv_io_desc *)
+		&(ubq->io_cmd_buf[tag * sizeof(struct ublksrv_io_desc)]);
+}
+
+struct ublk_device *ublk_get_device_from_id(int idx);
+void ublk_put_device(struct ublk_device *ub);
+void __ublk_complete_rq(struct request *req);
+
 #endif
-- 
2.47.0


