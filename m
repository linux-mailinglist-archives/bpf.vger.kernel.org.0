Return-Path: <bpf+bounces-29265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 657FA8C168F
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE31289F57
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E04D8613B;
	Thu,  9 May 2024 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DvilGzYl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F32B13CAA6
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284949; cv=none; b=q9VbnQxGJEg+6tV5ls3WTJKuQDN0H/2hXEbIO7ZdvjL5myPl+nHygG2MPc8WKuHSuhKhVtjHvuTYjJ/dfuJKlqFca9hb+mUn1OcTgiJuJHYZWSOn/vgbMWZAzw6doFT+R++kZOZt1tzRLhNYCs8nBE49RAQj13G/kOdpXyZ60ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284949; c=relaxed/simple;
	bh=WxA21+L2Zuykor9dBqpJGTKesy/LFIZkyBfJiqKwSMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PUk+c2/+/ryZ3caPyZ4Ll3jViA5SpLa0Oy3/UvMuvoMGmnJTRTJwsSk2CTIZFa13Bw10FbbcvOjQFc72eXQMAeHjEgjHewCgub1HGCDyiF4K+xwRDMdbaCoJfZkZHZ7uAMbr+6jVZKpF653AcTKVVMWRAXaukk8CW4YTPvdFvRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DvilGzYl; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f49fc7b5e6so1346240b3a.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284947; x=1715889747; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mGN3dzX1Fg/8DMWBisk+V0BflWzMHd7DBmLWWSrLzcU=;
        b=DvilGzYlCUiqWoI2SHcvhol5+mm5PgXUf1s2z+AfW15AIMFMPMxMi7FlS+JKUMVDla
         Cq6s03jYu15ot/MM0c8I6W9gaGC5FBzivKX49TJeZ4oxzmlevPtNAp/lzKhathGxcoTo
         jcpWxe0BKLn1hMaASvISxD8+Co5cBLq29a3jtrQEDdxber9nQvu4o3vg9qTDkAFKdLqX
         gRGVY2Z46bga8aMS7c+/LDfBWok2LpYga2h97f8Tkf40usWSvrE067IQwCrHJYeSZqGU
         I6fzoYai1JUyVXQZLRmqbFI/8aG15LSvy+RbTrQ1SwLiYhZy0Wbrsdht1lbRYerr6f0S
         3SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284947; x=1715889747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGN3dzX1Fg/8DMWBisk+V0BflWzMHd7DBmLWWSrLzcU=;
        b=sNZC/BT2w66r9RdUgmO5j3m42pc8xhaTzT1iwRuyJ6asugo+Fj7YGrxNUPjyhHhGGI
         9fMbPALj/iPO9FMouJEsYVnEXIvrWQIjdORmMBhIZxtiE17zfgWPu9zHb6RenJxuk4Ki
         jBJTHr8DO/FC+hXPNW0gvkqhJNVAq9KyoUY2gja+U6NpgW+LExmtZ/ajaBqpxoy+VIG+
         9otlIZnVBdG1aWExOUs7LW2fd+lrCipppzrrva0gdzkMCQTXhwftlF9hVQAX2Pepnwu3
         TJprFxkj2Th8inEBWlOZWrkMj73lQkg2dkVR3QmoXnN4RKHLgjO3DPBU+klhCTxo1OBz
         DK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQz8Wg6GhsEUBUA6mMtDznNJTMKV6U9rCd5oPyz16ctOWOVt35TWo7jbk1XQV+EKdm6yJUBR2cQyW1qZOnkyo75ZmQ
X-Gm-Message-State: AOJu0Yyb4zLUx6JJZbCoYD45epUSCyG0fbCe88ysqVnKsEXlxI9sdoc/
	g7FxcznXu22Ude1dEzowgekwafnuFg7VWQ8xdxiGtI8XyN95zJQI6RNn+iPnkOifn7eMtzT6Uul
	yTA==
X-Google-Smtp-Source: AGHT+IE13kb/DRTCsG66In5JbdvATNZ7UNmIfPfoP+M9Al27cmAukFzPSkQdhJiJAXpJTvsnAezDpKm1rN0=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:2da6:b0:6f4:47dd:5f41 with SMTP id
 d2e1a72fcca58-6f4e040fefamr9101b3a.6.1715284946869; Thu, 09 May 2024 13:02:26
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:27 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-36-edliaw@google.com>
Subject: [PATCH v3 35/68] selftests/move_mount_set_group: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 .../selftests/move_mount_set_group/move_mount_set_group_test.c   | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
index bcf51d785a37..bd975670f61d 100644
--- a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
+++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdio.h>
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog


