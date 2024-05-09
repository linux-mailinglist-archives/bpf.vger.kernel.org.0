Return-Path: <bpf+bounces-29238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A16F8C15FF
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E678EB24572
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4B5129E72;
	Thu,  9 May 2024 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQrTTZ65"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FDC1292C7
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284875; cv=none; b=JByvVqHgQ7IUG/Xj+1joyfBmaXXadmbbHIF1A6UobsFNlc89AwxrUTZTpPzYBpS2bafMywVLTUQhA5VcaIa+SKYy/zgShal6a/xi25/L5nENRTX0MgZ7Ue+RDgihk8Wh7dXjFTKe2AtLjIbXKeGORsihyrJn2zzC9kOF1SLxGdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284875; c=relaxed/simple;
	bh=2/8sIPk27FSvTOSAq/0YADaOvQGisOhNEwKoHVOrwoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xw1/MmFKYuPgcXCWtSgyGFShpdTJRm8xId7V8OL2ojf0CwqfIgU/jMQhy1IQWgbg5CtGt85xGagpo53jP7J5uvrgsmor23J2lHhZ8raY2Nm2NLEcPUGZEowT/ulQyhB4hNMf+L3/Qudy3JJk9fEV/ewstjOfngiJvijPEFDtwrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQrTTZ65; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ee3b4f8165so11489795ad.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284872; x=1715889672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5dDkrD0dZYNeak58b9GqqXeIHUFk691mZ1uMk+mW0Xo=;
        b=bQrTTZ654PKwJYwymZ0RyY5x+qfOA31YaKC6jhQa17s9os3Py1XzVuKFLytTD1kkpH
         B97yslXeGW3wQBFRRryQOWSYu8jkVZq8mP+CXPA7FzgMCMJZrpOIdbEsvtaXpERtpurh
         0agaPOsG+X9ht8rFOgDQXjFWLqRaAPY0LD4erEK01habuaGK2WryZ6zfP3NfV4RpF5ST
         ASZZThuJuLPRV0TQA0upOPa66kZV0AvLMQQ03wNEt1pPxRfU9WziC5hUce8MIsjmMYKy
         HUs7sx0EkR29oQ+rkfDet7tW1d2013kWuQSS/m6Cv3rpAvTrAFSpjxaHj4fNghWwGxvG
         41Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284872; x=1715889672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dDkrD0dZYNeak58b9GqqXeIHUFk691mZ1uMk+mW0Xo=;
        b=B+yBsixFNyEl9ARoq3GDLGCmPn9tmA7z2DzZF7vIEqBw0Jn6g+mhP7GsODXfB/ukPK
         ZSCAvZ9hPUBPZ9Rz4C9+9kG80evDktOPMiub2Etb0TojgtjIL1qfQwioJeIn+IkRrNt8
         so001Z+AkBVvRxbVBTpdUyUhOpgLitfN3oLxz6wWuJMHbgJLvP1izrSmIDr4mUGv91rV
         R7HpZdo/XBomknzhUk1FXbCguJN6Btmo1ZJ5EYiiXPhZhQAu5wdsfbl0/6YJ7bgEGzpV
         RiL0RRoe+5pYqy+Cedcr4J6V44VcZgPHYbV5YKD4DZiRn8E2YmmA2LafhLP497gAy+hu
         L9Tg==
X-Forwarded-Encrypted: i=1; AJvYcCU9n7/xHfS6w47bxY2/zzd16ZPi0UJV9R1JLUEgcPfTvcDb9p0VRWEK1rDWxDGVbYYIuE7G2+pqYuSmnZoMRde1uUyY
X-Gm-Message-State: AOJu0YwNX9M5eF1G0G6LAjlY8h4xpUcPRG125KABczFWVaG9w+f1NsPe
	ny24jsvKCIvh2KAluhGN3UMWuvY7yRC+2tBjZTx/cCf5Uq4Byr8j2fFA1XU3sCmzFH2AiQ1xWrl
	5xw==
X-Google-Smtp-Source: AGHT+IGN4HNDJxeluOcEKuz7md9IZhJw8i2iBFbn3kCKVQqvAuS4nKMSdcwPm/QUnrOgNSxeyjub3Y+yA1A=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:d488:b0:1e4:7bf1:52b with SMTP id
 d9443c01a7336-1ef43d2df8bmr270375ad.7.1715284871880; Thu, 09 May 2024
 13:01:11 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:00 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-9-edliaw@google.com>
Subject: [PATCH v3 08/68] selftests/cachestat: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/cachestat/test_cachestat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index b171fd53b004..c1a6ce7b0912 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <stdbool.h>
 #include <linux/kernel.h>
-- 
2.45.0.118.g7fe29c98d7-goog


