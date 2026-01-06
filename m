Return-Path: <bpf+bounces-77928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2296BCF6D99
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 07:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F5DD30285FA
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 06:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E818301016;
	Tue,  6 Jan 2026 06:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="yncaXlqj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87017277C96
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767679826; cv=none; b=T0BL2H0PfXbLzTZDT8nafDeg59HoaUmFSNde/BTsIgZ3ksDYKxrxdIlwHzlhFmR2Q9bw4Dsqhgo/9z+AmcmOS0g5DsLpIxGQz4EAZWcnGMyXakY/K+mRjNt1GC3IDyYdjPbNnPnb2OiAOXzxleFG3ZG5MC7V1vKjF6hxfneJYL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767679826; c=relaxed/simple;
	bh=8EjliAcaOX0pKli7xBbVksAyfCzEXI0SC5Z3PL7qAPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jF7jHVuGgRJmOAyf6k+qoEo4SYxahXJprEFKLrAVhhtjDDr7lpBrR8PhcGt7xqHZD6ox6PiI/BfJ64TlzvuN7Gss6KM+0nyUoAcCrS4OMJr1sI/86bhpbMqeAmOX1is9CefXNWr+a+etOAOaGEAhlsD6vFd0WKnhkfIxzrt9t6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=yncaXlqj; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ee05b2b1beso6026871cf.2
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 22:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1767679823; x=1768284623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5h4SNcrV153fcyzO9nkb9mqSiXfr6YJDjnjMQQ8RhNY=;
        b=yncaXlqj5j4gvxFyVIhBC1iZjT7nwkp6LT19IzaXpmbYFEh08BTzM2AWJKej/dLAMq
         DUWtfrbPMSBnIbFTW80Wjkp5sUx4gvKp+QbgH7EijR8ImNHgsjKGyk5MXrB7xwLs1FN5
         lxbN0tuYrsWDtiDrtV2ztpiMJ+yPFSqN6ycGef/ymBfbrDd8ZJ6icM29X6YpKanKLfvy
         ABtzhudkBV3LyPke9jyjgV3H6rlDoU5ABAAWl2fJLQwa/LVBn+3+wnMvlrcWY8tMOe4s
         u02glrtTgiff1sKsIIUgCxn/MbauCi7SdloKkda0V/zbingzdNN9zOJfYpiwmx9DhT/5
         pGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767679823; x=1768284623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h4SNcrV153fcyzO9nkb9mqSiXfr6YJDjnjMQQ8RhNY=;
        b=tjPQEokfUlGPIWLlUKTAo+0W3WOjWJ4Fk4Zurvx2iseIFyA4LdWIYKKuJsaODvtgF9
         EsC0XgxJxUizSkc74OOpuVAV8sTWNZ573tlG7nfJFpSfY8PuAEUb1FMbisqO5Zl9xalv
         L5FGDTv+bJ1WXusB0ft+XxLHR9zpGbxJb30yw+RO/SUmv+nkQ4r8/OmimnwEagsHjfNd
         +n22fhAAXGGmPK8993RCdpMeLKPXXN7XOwJdrhQZy98SYHM1poNoY3biEnnqsRAZx7B8
         lkweFiprk6VCZ2VQXjITOr9YGfgt/PnWaC5/RhafjG76bV7RM4sVlgvAjyHUt6vCSl90
         tq1Q==
X-Gm-Message-State: AOJu0Yyb0HXQzujDe7FjFhr1419W71ETgksu5BGKhZNhuVVEY3kvPnMq
	/iOaDEiQESIca0GaP+8yAMsfOnAQLrCZTF85mIACLNXJ82mkeobGCvt0B77HTMp7h9QWcqok2iR
	hSh4EKGM=
X-Gm-Gg: AY/fxX54pPT37LCtjH+R2Q4Qgt047U0mRHQFU/bDeoVFhr/M1TFkYVszEPndpmzoh1R
	Cmo4nf3XX5xskYc1a4takYY5rpI5hWz0nRJI9bsDwbDAKk5oVS9y2pXxtDqR7ETyKyoB8cMl076
	XGFEJZEsSFuSYQwC73036eCmEQcie2fs0tg88E/BHJebirDoJT+obR39ZnhzKmHnoLFAFesBaBT
	UK1E4eZJ8r4rjv8XLA3zGKzRehTY1guweXWule7PRepP9/KVuMw00JizNqs5yYOnuHa5nsrMMtF
	kwD44j5QSY6Ez5U5jsEl06ISlhd8eOlrfSs/cYGc6p56AXCsMi1HNZ5A6/S3GkwStjdgzhyPUkT
	7XoPnNH4RZ2X4w9oV0BXfssXCqfSrC9rQo4uXGxUr/NCP1CE9A77DZM5moKz69wu3AXvEGrv5bY
	RdFPYpz32fiQ==
X-Google-Smtp-Source: AGHT+IFcQKOEkdirx+OTEyXoNsJ7LYCMNl8Lz5o3GSOPC3JT1pyAMvSV4W3TRkrn6gOORkbumOwrgw==
X-Received: by 2002:a05:622a:1f11:b0:4f4:c00a:2faa with SMTP id d75a77b69052e-4ffa77a7c81mr24729901cf.42.1767679823171;
        Mon, 05 Jan 2026 22:10:23 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e363b7sm6845511cf.20.2026.01.05.22.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 22:10:22 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 0/2] bpf/verifier: allow calling arena functions when holding BPF lock
Date: Tue,  6 Jan 2026 01:09:51 -0500
Message-ID: <20260106-arena-under-lock-v1-0-6ca9c121d826@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260106-arena-under-lock-90798616e914
Content-Transfer-Encoding: 8bit

BPF arena-related kfuncs now cannot sleep, so they are safe to call
while holding a spinlock. However, the verifier still rejects
programs that do so. Update the verifier to allow arena kfunc
calls while holding a lock.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
Emil Tsalapatis (2):
      bpf/verifier: allow calls to arena functions while holding spinlocks
      selftests/bpf: add tests for arena kfuncs under lock

 kernel/bpf/verifier.c                              | 11 ++++++-
 tools/testing/selftests/bpf/progs/verifier_arena.c | 38 ++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)
---

