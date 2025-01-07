Return-Path: <bpf+bounces-48071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2218DA03E9D
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4CC3A3856
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1C015665C;
	Tue,  7 Jan 2025 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfoZBXsX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5DD1E493F;
	Tue,  7 Jan 2025 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251687; cv=none; b=TmgukVFPxNbV+QAcMwzzZDp4jEliqZLznFlx4zkVznXZ4xXjv9Q96x5VYGZrTazzVDu2dyIBGcm3rxOOfcLNyayuIUCEY6nu2tM0a+VKatKNYAz3Nr+WImgUzDPs8h32aqjh9Y+WeXOMTYWd2FJfIBn4IsRXBS868PgQ9YIycfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251687; c=relaxed/simple;
	bh=59DPAChHlbSsLHeLthqZD/vVzm1UxDZoVPtQtJMjM8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhrClqGSmnuzo8JywR7LCwrQr283lJVFm6aa9jc8fe/wdkG4epn5W2foFAHmco2XeVGcZ+NdQZnJLMOyaSoFr/fgBS+S7RbfUlM0ZmX5G+2AebGuFHuQPxr5+MIDWcsAGSFm9Q2Abmo7BzpEyXDhI1860yP56NuW/sa0TCF3Hrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfoZBXsX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2166f1e589cso5838305ad.3;
        Tue, 07 Jan 2025 04:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251684; x=1736856484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5d781KXFd/53/DYOF0dg8Emjd7VZv5JgYBNfxNXTRwM=;
        b=EfoZBXsXnM2U/gXV9UM2Gw+krYQs7v2zk08CkKIGPPF0JUjiPNPPDIHy7oOK++3wUN
         REv6GjQ10QlKVy83CX+bWDN4P1CypzqB4qGDn7IaxeNSsn1elw9xiDJyHbWRvaRjgFjJ
         jeMA/Guq73ag+ac8puY/q2wAQy//kyRjRwSf6EYB3BbE7b7ZxpHekbp2Uo86ypxDjWtr
         Rx1tjTZ/NN/0mK/FVF7SwWvAn7pz6++o5qM039quZ2v39JPDEY0Gd1y7JkBarKvnR5K8
         GxDZRpB+FygBBm3Dwv6kxfSDbUcRU/wiaqhJ8qN8zNKYrhJZSxiFoMaw5kjc4ELsS/g/
         MkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251684; x=1736856484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5d781KXFd/53/DYOF0dg8Emjd7VZv5JgYBNfxNXTRwM=;
        b=srPk4YjiJ0+YBwSBZZFxMvmC13gthb4sRvGmMg7pAohoHHIBVwfVK+I4RwkGxQtPkv
         FrP7RIlDHYOwMbj0PwPTTtckPjb3UE1C2cLmFmf/RaeH/e3S0zrblgNHCzi2Gjyvj4xl
         h9fXQ00pbdck+cQuZ1bVQSx81Xk2dzP11CyFUaaogIOsgaHvRiS4tuSOL+Cd0vlJMDmY
         yuyXrO3uMmrhSbs+hNJvGHUezFHsyR7umrPqzYwgaJauMnbH9i+KJqDSL8XjScIZP4Lv
         BZyVc2uB7azYqGu5LCiXIv5ngCdMBaOC5mQ44Tpl7fiuaiGy31xIuLzHz7vm/LdiehsN
         g6GQ==
X-Forwarded-Encrypted: i=1; AJvYcCV69Mmt3NXcXzw0LbrRf6JkyGs2qik2Eh2w5LS9KIF6zbyVPF/UNKgBXp+8wHUQjFG/SglSXiGqY7tr9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx7m3jT7ChuBTMRKDTIJIKaLJicho+lErQMUKUeKuVEEQBk/g/
	r1XODn/8onU6YP3ZWNxPam9zYsjjQOhnffUPEHbM7LA0CuS0xzIp
X-Gm-Gg: ASbGncs72MuNaQ9yL176z7Ykofq6TjsI1XxDOmFu4nJuRBE22pm1gpEFn3VbsfR+Xu7
	VeabrtKyP4Lu5HcZJMa26bYUkXIA9SFqTnYFcE6SaFFtrHcQIF5EsdMGCHLu/LrULIxEN7w/lUA
	w/5xvdg0Ymbewo7tOb6Y8cfly/VbKew0CqXExQKGGJ6k4HHkUNPcaYTn8CUCSy/zjUzq0zXd7jh
	PtrWNnSeJ10eUZbVKHIsJ3bTiNLar3jRLcirB9Af1CwSzmGHpLfpLdCzf8Iv1iTR4T+
X-Google-Smtp-Source: AGHT+IG0a0jJHAM2oMSQMiQBYSj/xkezTeRk7Ro8aPZrFqVKE/uENjHLkl5hdVJGIGmPTJTC6qgrJg==
X-Received: by 2002:a05:6a00:1706:b0:726:f7c9:7b36 with SMTP id d2e1a72fcca58-72abdd7bacdmr103732314b3a.8.1736251683958;
        Tue, 07 Jan 2025 04:08:03 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:08:03 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 03/22] ublk: add helper of ublk_need_map_io()
Date: Tue,  7 Jan 2025 20:03:54 +0800
Message-ID: <20250107120417.1237392-4-tom.leiming@gmail.com>
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

ublk_need_map_io() is more readable, and it can cover the coming UBLK_BPF.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 00363e8affc6..1a63a1aa99ed 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -582,6 +582,11 @@ static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
 	return ubq->flags & UBLK_F_USER_COPY;
 }
 
+static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
+{
+	return !ublk_support_user_copy(ubq);
+}
+
 static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
 {
 	/*
@@ -909,7 +914,7 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (ublk_support_user_copy(ubq))
+	if (!ublk_need_map_io(ubq))
 		return rq_bytes;
 
 	/*
@@ -933,7 +938,7 @@ static int ublk_unmap_io(const struct ublk_queue *ubq,
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (ublk_support_user_copy(ubq))
+	if (!ublk_need_map_io(ubq))
 		return rq_bytes;
 
 	if (ublk_need_unmap_req(req)) {
@@ -1809,7 +1814,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
 			goto out;
 
-		if (!ublk_support_user_copy(ubq)) {
+		if (ublk_need_map_io(ubq)) {
 			/*
 			 * FETCH_RQ has to provide IO buffer if NEED GET
 			 * DATA is not enabled
@@ -1831,7 +1836,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
 
-		if (!ublk_support_user_copy(ubq)) {
+		if (ublk_need_map_io(ubq)) {
 			/*
 			 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
 			 * NEED GET DATA is not enabled or it is Read IO.
-- 
2.47.0


