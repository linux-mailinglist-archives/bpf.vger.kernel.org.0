Return-Path: <bpf+bounces-48079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A487BA03EB0
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A271885316
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518911F03C8;
	Tue,  7 Jan 2025 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsPB2/1O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9F91DFE0A;
	Tue,  7 Jan 2025 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251735; cv=none; b=cS9L2LQbJcCcnf7MERy2Ik5J1UBMdcu5komXdzFqIZrgjfnFCHhQypClJ18VwGcoAX16lfpp4+yVf487ucmsJXl84tBwT8zCtQvd0zJH4r+NJ/mS3nPAXkWUgTwsaXUPe5qbk3o3mpOl9wxUcP0lG982pZWIuZc80mWEcpe/bVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251735; c=relaxed/simple;
	bh=eHznBwop2mDpz2vdgcSlQkIZPviDdCxuRAT4iPGpYio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOIbznOK9ukyo/mu5IRG2dOYqWCDJp7FQXnUrLjGbLjTJI2XrG3UUBG1a5qfkR4OVehzDyIIkiNmhqnP3LE13HI8JmEDW2toEpquAbJgZgXyXsC6tGv0OPjKDOm8nJ1m5Zw19EecI8AVkdLD5tGoUb80JADQH4FQ8+ih+yYUq4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsPB2/1O; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21628b3fe7dso218297525ad.3;
        Tue, 07 Jan 2025 04:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251709; x=1736856509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuVs/Dhtg/rqdT/P+jUJ6cUXUeXkBAdWAoqGqwWwJHc=;
        b=hsPB2/1OGz1kaBhQx1Zr9wcaSOKqCYA1pN/a7wx3oTUB/vDPZlZnd+YON7Yo/gKNj3
         ZdkysY5ZjKi0EsqTlnDKmFs/Gwd81Sy1h6ybzLDuf4pxfLIuc6nc6/mptL7fIapZNCxn
         hGGEP2txmyCRmONeUbwpD78JQGo/o5NIsspHcXkKrdHKAstR/gp/fdRd7RF6BuR0nB2K
         1x68L0gotUn5oGadVm8/0S4P6t7PzgbSI0nVv26E6VMySsLwzzOC5l6aSW8HsYhZ6j+T
         GXrGqo02NxvOhaIpiUTRCUo7HcPpj3l6YPES5TlZ0G8kjoaHBFAbtUkjZTwtkbK63UdQ
         K9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251709; x=1736856509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuVs/Dhtg/rqdT/P+jUJ6cUXUeXkBAdWAoqGqwWwJHc=;
        b=gjlO6bQC+Y5z1iKV0ZGhgkWBywPBomUw/3ehy9Id89vMHWisvv7VRQZRZKvncvKPoN
         ubvQR8b0ZothuItjhPGA1sURvpmVLtBN/vgYB/ehBRvfiXU71j6O3797YnWwR6mZZMll
         gRvTKbOImOAZClFfwK7eaRd6MhJ0z4nqOVzGgWm9KxR74Jc04/SoIl+Pt9LV2jUkAvH5
         umlcDj9vivlK5c4l1kmaY22Ht0DfXQkEg5BGBzjmWA4/XuKjeh3lCPvXqluf8gR8PIsN
         0J4y1EnNpWrCtZ7Nt2OudpWEcLQxrdRVH6HfLthNNNcuszoUZa7djKRXpWXIYPdi+iks
         zorA==
X-Forwarded-Encrypted: i=1; AJvYcCXWtLoSuzMp/xMNBAC5C9tFGv/2tvPFqVr5jCmyfydlr0wVseH6Y65w9QA92xcroQHXI+89G9+SsM2O/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyryX9SZSqcYoe7RszDhuBeAACPe3qe9/dZyJR9dgiVBhEaWrOD
	6u6Mzo2zPOCQAE7uiyYLm42deA6Texx/Xx7sa6I1REXe6EJgY1sL
X-Gm-Gg: ASbGncvUiItIfhjCbK62bed13+WhJ5ToaUIC1sIXVtMIMNXpSar0fx/EcoaIfza/LCL
	z3StCdkNbL4Q7yI/rQQ2DkXvwFUt86qAdlCN9ZLlkNt7OtN9cONyXTmGdVQCr1uNdGu+01R9my6
	pc9DDoeKRezsSL2qXXpBhr3Abr9Erev2LVafU6baUFWykl5NwkBGv/BABIhO/hQZ7B1vbdNquyi
	CLS3YOxCOKL+fHUdes9BF81QIXTrhsP8sfaQDnGmiCIT5kox+1ZP6wVCtzEXnOnuP92
X-Google-Smtp-Source: AGHT+IG8JRG66VyxKo7OHp6oFe7EHUQ/km+xwQfaSQllDMuBjxQ3wkKk6QpPMBY9BsTb6wzQs7g4rg==
X-Received: by 2002:a05:6a21:3991:b0:1db:ed8a:a607 with SMTP id adf61e73a8af0-1e5e047b457mr100622648637.11.1736251709154;
        Tue, 07 Jan 2025 04:08:29 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:08:28 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 11/22] ublk: bpf: enable ublk-bpf
Date: Tue,  7 Jan 2025 20:04:02 +0800
Message-ID: <20250107120417.1237392-12-tom.leiming@gmail.com>
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

Add feature flag of UBLK_F_BPF, meantime pass bpf struct_ops prog
id via ublk parameter from userspace.

ublk-bpf needs to copy data between ublk request pages and userspace
buffer any more, so let ublk_need_map_io() return false for UBLK_F_BPF
too.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk/bpf.c      |  3 +--
 drivers/block/ublk/main.c     | 15 ++++++++++++++-
 drivers/block/ublk/ublk.h     | 10 ++++++----
 include/uapi/linux/ublk_cmd.h | 14 +++++++++++++-
 4 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/block/ublk/bpf.c b/drivers/block/ublk/bpf.c
index 4179b7f61e92..ef1546a7ccda 100644
--- a/drivers/block/ublk/bpf.c
+++ b/drivers/block/ublk/bpf.c
@@ -79,8 +79,7 @@ int ublk_bpf_attach(struct ublk_device *ub)
 	if (!ublk_dev_support_bpf(ub))
 		return 0;
 
-	/* todo: ublk device need to provide struct_ops prog id */
-	ub->prog.prog_id = 0;
+	ub->prog.prog_id = ub->params.bpf.ops_id;
 	ub->prog.ops = &ublk_prog_consumer_ops;
 
 	return ublk_bpf_prog_attach(&ub->prog);
diff --git a/drivers/block/ublk/main.c b/drivers/block/ublk/main.c
index 0b136bc5247f..3c2ed9bf924d 100644
--- a/drivers/block/ublk/main.c
+++ b/drivers/block/ublk/main.c
@@ -416,6 +416,19 @@ static int ublk_validate_params(const struct ublk_device *ub)
 	else if (ublk_dev_is_zoned(ub))
 		return -EINVAL;
 
+	if (ub->params.types & UBLK_PARAM_TYPE_BPF) {
+		const struct ublk_param_bpf *p = &ub->params.bpf;
+
+		if (!ublk_dev_support_bpf(ub))
+			return -EINVAL;
+
+		if (!(p->flags & UBLK_BPF_HAS_OPS_ID))
+			return -EINVAL;
+	} else {
+		if (ublk_dev_support_bpf(ub))
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -434,7 +447,7 @@ static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
 
 static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
 {
-	return !ublk_support_user_copy(ubq);
+	return !(ublk_support_user_copy(ubq) || ublk_support_bpf(ubq));
 }
 
 static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
diff --git a/drivers/block/ublk/ublk.h b/drivers/block/ublk/ublk.h
index 7579b0032a3c..8343e70bd723 100644
--- a/drivers/block/ublk/ublk.h
+++ b/drivers/block/ublk/ublk.h
@@ -24,7 +24,8 @@
 		| UBLK_F_CMD_IOCTL_ENCODE \
 		| UBLK_F_USER_COPY \
 		| UBLK_F_ZONED \
-		| UBLK_F_USER_RECOVERY_FAIL_IO)
+		| UBLK_F_USER_RECOVERY_FAIL_IO \
+		| UBLK_F_BPF)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
@@ -33,7 +34,8 @@
 /* All UBLK_PARAM_TYPE_* should be included here */
 #define UBLK_PARAM_TYPE_ALL                                \
 	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
-	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED)
+	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED | \
+	 UBLK_PARAM_TYPE_BPF)
 
 enum {
 	UBLK_BPF_IO_PREP	= 0,
@@ -193,12 +195,12 @@ static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
 
 static inline bool ublk_support_bpf(const struct ublk_queue *ubq)
 {
-	return false;
+	return ubq->flags & UBLK_F_BPF;
 }
 
 static inline bool ublk_dev_support_bpf(const struct ublk_device *ub)
 {
-	return false;
+	return ub->dev_info.flags & UBLK_F_BPF;
 }
 
 struct ublk_device *ublk_get_device(struct ublk_device *ub);
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index a8bc98bb69fc..27cf14e65cbc 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -207,6 +207,9 @@
  */
 #define UBLK_F_USER_RECOVERY_FAIL_IO (1ULL << 9)
 
+/* ublk IO is handled by bpf prog */
+#define UBLK_F_BPF		(1ULL << 10)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
@@ -401,6 +404,13 @@ struct ublk_param_zoned {
 	__u8	reserved[20];
 };
 
+struct ublk_param_bpf {
+#define UBLK_BPF_HAS_OPS_ID            (1 << 0)
+	__u8	flags;
+	__u8	ops_id;
+	__u8	reserved[6];
+};
+
 struct ublk_params {
 	/*
 	 * Total length of parameters, userspace has to set 'len' for both
@@ -413,12 +423,14 @@ struct ublk_params {
 #define UBLK_PARAM_TYPE_DISCARD         (1 << 1)
 #define UBLK_PARAM_TYPE_DEVT            (1 << 2)
 #define UBLK_PARAM_TYPE_ZONED           (1 << 3)
+#define UBLK_PARAM_TYPE_BPF             (1 << 4)
 	__u32	types;			/* types of parameter included */
 
 	struct ublk_param_basic		basic;
 	struct ublk_param_discard	discard;
 	struct ublk_param_devt		devt;
-	struct ublk_param_zoned	zoned;
+	struct ublk_param_zoned		zoned;
+	struct ublk_param_bpf		bpf;
 };
 
 #endif
-- 
2.47.0


