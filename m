Return-Path: <bpf+bounces-48069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63186A03E97
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C453A208B
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5021EBFED;
	Tue,  7 Jan 2025 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzHuFaop"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC18191F66;
	Tue,  7 Jan 2025 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251679; cv=none; b=M6V8hAH+ld7cPBrZnUkfAb+h1OnvfiG2uY53fpZEyGLnQNLh6GsV7y07PVhxR+iCZKbr5tz8l6AQrf72bySsYp6Il0spYyNELe4JSUd8aUD7PchbeAaTAsF1xxTqFGIAxkAN74KvaMop5fBOvKOx7pLDjGIMrtZ20iyS2eENhTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251679; c=relaxed/simple;
	bh=t74MpXxg79PL3InuSBEprS+afUhwIQZ/M1fsDDoOEjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJA+T98HQ6m3btkL3iyFd7igSEq+ms6s+JiLOt29mVK61Io+Zn6wZe5WE9gyMTfIJsfrFHNOx0lrtSnX79ZQ2r7056hH0zTyiU1CgIVgQSgTDEuLwCbX39sT4uxqKbXl40v2OEZhE/oKF1GEzFDXhFNlVjm4Sj7FymgtPeEJG0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzHuFaop; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21670dce0a7so47679625ad.1;
        Tue, 07 Jan 2025 04:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251678; x=1736856478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3pwQMCsFZzhnkUtRX/8Nct+k631l2JaW7dQ7nyVgqE=;
        b=PzHuFaop0pCjv9Wv7XZrtodMVyfF35zUg6hflMYwO1PXo6Tr3z+hC/gZqhZd1AuXOw
         phgc0lzC7jNxqZLWs47JpxdT3nX2W+p+dBQagQaF3aq+82adWEyLRZznRvGu7HFfVCKk
         4cmlxI9S3TRBZahEiIEI4LRi2S3xFciqJWrbhfW5LBkWDn9uLcGCe270e7CmF2HCyVst
         EeDYJmB+dniCwCX3lFAwwYpb8jsm6CEksqX45xBaCHjt+ex0F86Q7VWHuyJ1DtnuQFy8
         XngvBdGSPzft5n94/q9HHUkaeindhu0equgHOutKYbk9V1p2fj4b15ffVZ5fmTi2JCux
         YI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251678; x=1736856478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3pwQMCsFZzhnkUtRX/8Nct+k631l2JaW7dQ7nyVgqE=;
        b=FSeVXZPetFL32+rh1f67ppjRHSijt+SKQUPQKYrgEtDM0zWDP4JEvVBTlecDZH0jFB
         BhLrebsX5i/53LRqtZJQD9Cj2zDhsBScRDrq4T5WBV2g0uwgTgBKPSsVSlvd7B2PuWon
         B4IMxHfifXXiS77mirfFfJGdscLFc+Gyi9GJ3NX2OwbvrZcGVwybKg9N22sa8PdbHQEn
         S0vBTY4FxkQRhPC3h+xE2FXxlASitEYf1pDP5k8AAnO6ToEnpqXGUpNc3Nznp/5pz/ql
         C/CmtiXFdZonNDOCTMOJpo3oFhEvD4Sp8/uxfr+Q6ZUubtVROkQGVian4UEq/cUhTRKL
         Oo8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9ejMlCbbqCexxEVrh9ZRZLUUxijQRaeZN6NgC9THsm1tyd2bi1ZKenNSG8O4dtXB3D+uaBzrnG7fqbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfWXbLu2FFcMN951oYtpAlrMHApdvp9qzOIH60O9FlP58avVqV
	S8uzxUnsP8h6awc0s8Be23ate7WhsPXNLxHbGebI3NtZxdRmRMnS
X-Gm-Gg: ASbGncuM9jcmpJpgkWW02OmPPIeiKbSmCEcLbFOEdhxq6wN+48BNK/HWCmN/e0T6m19
	deP32JcOnVaWSNGobAzwteEWg3ZXlroFpvQ5tBNuKLkMOLmpqZJdGz1CQH1qeZGYkcgqpFZo04K
	8QgnSX67LSj/QYLLFnqyTBV3zBKltFtbcdvqBnGZ3rpP8YJO1rEL9vA7HR+IQFbl5iudY/pqyC7
	Ate35VsGmkyOvNCGyaZAsv3mu3uiaMtKfJJalP7pPKPm5DobK3L+eyHE3Jwm1uhdH+i
X-Google-Smtp-Source: AGHT+IGyG4eEk8yJR9j/6KIdO5nb0Lre/awjpKAvS61aR1Vcz2EjpxKhHWfrdZOLA7gRheUjf/jukg==
X-Received: by 2002:a05:6a00:4486:b0:725:e015:908d with SMTP id d2e1a72fcca58-72abdd4f29cmr76333568b3a.1.1736251677766;
        Tue, 07 Jan 2025 04:07:57 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:07:57 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 01/22] ublk: remove two unused fields from 'struct ublk_queue'
Date: Tue,  7 Jan 2025 20:03:52 +0800
Message-ID: <20250107120417.1237392-2-tom.leiming@gmail.com>
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

Remove two unused fields(`io_addr` & `max_io_sz`) from `struct ublk_queue`.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 934ab9332c80..77ce3231eba4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -143,8 +143,6 @@ struct ublk_queue {
 
 	struct llist_head	io_cmds;
 
-	unsigned long io_addr;	/* mapped vm address */
-	unsigned int max_io_sz;
 	bool force_abort;
 	bool timeout;
 	bool canceling;
-- 
2.47.0


