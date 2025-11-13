Return-Path: <bpf+bounces-74382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C94BC574E9
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 13:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83AF24E5879
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 12:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E7A34DCEC;
	Thu, 13 Nov 2025 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHykL+dr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4051234DCE9
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035207; cv=none; b=DOFEbhQMeFirY2G5cpJBvGMo24rUlMqbBdsY8B6jrrZGn+EsI6WjLQuPaFsrmIcbMQGP7rLv7mcAjAGF6b2TGs4gFcn0k0gb/UtBgzUrv3qwamamzWTLI2XB8nAp6RyXCcPc4EiOySuJ0GBxIk0azu8+wEv+8C7lqTodHMIRYvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035207; c=relaxed/simple;
	bh=pIveeSzj6i0AGp1kNzA0NDr1gOHhtDQMZMyw6zynZQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+GUi31C/VdRvSsD3pvgtJz5LEawRdFo+6XH8WDVIIXbbklEvkC+vcGnVJNlk4KxkTpV3SIhEROLzjgUGmwU0rTn7dZM0rjZGfR/5E7BNVe3brX67BTHWVmACsBk/J8ypzEyKSpwQx8oFDgU43pYeHKMaTDktlgRCBDxjJZt2iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHykL+dr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4775895d69cso4055705e9.0
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 04:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763035203; x=1763640003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aua+W08t/byOMJPjPNanlN6jE5TAgPSaiLXUlwOzmHk=;
        b=dHykL+drxj3NXG9NW7XfZOiPGQlXPomF2KId708Zy6vNtYcXGBM0zoBEu9eYSLMP7F
         T4CRG/0rQKi64z3JgbW6Y0erNMV0MTGv/tRsAaLmmctfkmLwmTKkPQwGDcu++M0P8q5e
         vU9/alQjpJ0iHFSZ944WraI4mtfjfw/51Inl29bXfH3/Y8CdEUWvF5WHwKz+a3iXaHof
         BXnLXC/YuNyeaHwN7LOOkT0McIHrmIqqf2hooC7T7nm67ItOomfXt/eJEuLPkoaZtks9
         wrGg6AIr34VvhLu9EdASc4Ghak0NS+yg6IazdnDWFlAtoWOKu6Kaq5QJyLGH4d87wVA/
         cBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763035203; x=1763640003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aua+W08t/byOMJPjPNanlN6jE5TAgPSaiLXUlwOzmHk=;
        b=cT5/Y1nD90gUc+4ZxT1/LS/13wQaIbljZcVdC3dJHpCkP6BfZsNltKb8fUFqMEhI0P
         6aNmcmsM1vbnAzxcNNZrtFCpzDlvm14s+IGjwMJF1TsKEeGKdVDta/eBvCQV9TkZ8S/q
         tUtOj+IixB58gm2u4FLwjulKoBzAOJMpk8XOPyLjkKwKspmT7W6kFYhwMeWL4umUtd8M
         J8UWUykuNEiF0sIc4KmDtNyn8FCWiOeOW8qb1faySqu3wxR50/MXC/Ofh4/SDpIvBYEo
         yL9sgxMymmYsNy81E6SpG+yWWxz21buuU7FApcn9ByYL4LTXJamjQ6I1s6nD/xFbYV45
         F7cQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1+fZJR9gZmcL2Wt7S1jz30P92iD2iBNaWQ9I2b4bDb6llUl/PBMrAn/97GKC6Y92c108=@vger.kernel.org
X-Gm-Message-State: AOJu0YwalkkWTFlcMCr38GOn3hVnVpDzV35yxktQ0EhQB+i5dEYpsYPm
	xpiPLmvjVEX2YGAgBBhV0M/mN+G2cF2p/oRsnym/LKE4lFWbijBNA3Qf
X-Gm-Gg: ASbGncvC+nZyKqNhwvcpCzWT4wadxwtssuqyfTsIBEWzWafDag8f+aYD/VA6bih+RJ4
	e9CF2VqAsO9WCysUbyMGOnOcA+CBrGDQLRGHXzAlvrL4E4QDpzZcaCF8qENJ6cPtXl/FWFwV1u2
	M4LvlnQkXLeRsu22X1uXZv2o/vNop57KTNdINmP5E1I8RiDRFGJzfe6YOq3hMBzismhXzOu5ncs
	IdFGjbbny2Y2dr66b/Q8Yaws2t6jfIpeC4hD0Yz3tr0N7X4q8lpJHa17cQgzw9lXV/2mlDfny11
	1NljWWtv1UHWciCpzSaZ91m/4XLP/iLJwWiIDjLCYw6WCU7cLFV4OV3uDp0iAyTz5R6LcCt84Su
	lk4ChfP2jZkL7tn7/BvVRp3Rf2OfiAOKYYJSOQcWw6hBcSXHoFaE0vHt1MdxfjMHuHo5rAg==
X-Google-Smtp-Source: AGHT+IHnh450rSZrRsHtm+2fGnvU4l+JfvHOq1cwC49twD59D87wME0J4R2fbl9kNoVWl4OD2i/BYQ==
X-Received: by 2002:a05:600c:45d4:b0:46f:d682:3c3d with SMTP id 5b1f17b1804b1-4778707cabdmr53188235e9.13.1763035203021;
        Thu, 13 Nov 2025 04:00:03 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:6794])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85e6fsm3686816f8f.18.2025.11.13.04.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 04:00:02 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	ming.lei@redhat.com
Subject: [PATCH v3 03/10] io_uring: export __io_run_local_work
Date: Thu, 13 Nov 2025 11:59:40 +0000
Message-ID: <d8eac55be0091ab4b0bc786e17199706de272aa3.1763031077.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1763031077.git.asml.silence@gmail.com>
References: <cover.1763031077.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__io_run_local_work() will be used later by bpf code, export it.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/io_uring.c | 4 ++--
 io_uring/io_uring.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index b26c2a0a0295..4139cfc84221 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1350,8 +1350,8 @@ static int __io_run_local_work_loop(struct llist_node **node,
 	return ret;
 }
 
-static int __io_run_local_work(struct io_ring_ctx *ctx, io_tw_token_t tw,
-			       int min_events, int max_events)
+int __io_run_local_work(struct io_ring_ctx *ctx, io_tw_token_t tw,
+			int min_events, int max_events)
 {
 	struct llist_node *node;
 	unsigned int loops = 0;
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 53bc3ef14f9e..a4474eec8a13 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -140,6 +140,8 @@ int io_uring_fill_params(unsigned entries, struct io_uring_params *p);
 bool io_cqe_cache_refill(struct io_ring_ctx *ctx, bool overflow, bool cqe32);
 int io_run_task_work_sig(struct io_ring_ctx *ctx);
 int io_run_local_work(struct io_ring_ctx *ctx, int min_events, int max_events);
+int __io_run_local_work(struct io_ring_ctx *ctx, io_tw_token_t tw,
+			int min_events, int max_events);
 void io_req_defer_failed(struct io_kiocb *req, s32 res);
 bool io_post_aux_cqe(struct io_ring_ctx *ctx, u64 user_data, s32 res, u32 cflags);
 void io_add_aux_cqe(struct io_ring_ctx *ctx, u64 user_data, s32 res, u32 cflags);
-- 
2.49.0


