Return-Path: <bpf+bounces-29297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D31698C1737
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1BA2822AC
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F227D14AD22;
	Thu,  9 May 2024 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zlKbabrt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B8E1487F4
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285041; cv=none; b=iPLxjTjsxMrLR06gw9p3O+3Y/PrfN3MBQGQDgAFKoRv/GnT9ahgyvnCaHDuvRePn3QnDlYLFJmPVK3J/O0umx0OKZUsMM1YWlact0lgUWv/7jKtvLjLAa3WE2rD5gKGeCRm5e0UBLu/5I3CW3io8uyPIQeaI+AYRkSngVQXe680=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285041; c=relaxed/simple;
	bh=hpXwRj8PmsHLP9pVcjGSKT04NzDcN++/f0/62HSOBzI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K1JvZI00Uf80uR+4Hxh9T94eWVRcwTYLGRyghv6jdYuE1snxgRAEBfT7NfndApbgS5+2rK9mryRGtD9t3/aM42QNLNp8tYQFHJ2upt7TQjUMasERK8R4iPsyaYK3VeZbqdINyUsHXBjB3aRrHnKHyOzCuNZQkK9Wdy2uVOVpsK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zlKbabrt; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ece5eeb7c0so1083729b3a.2
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285039; x=1715889839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QQBoWhnW3eSJL5OjfxzO0lzEIXAyAkfzlFMU1Ex8yOg=;
        b=zlKbabrtJoqeIp8fggTL2YfHq9Ra2BMTSv6I2WhJCc6SSIddYUjs9/BLjdpqOK9GYA
         fnpqkT+m25PnuTDgD0a+c/T50aueGu8/vqRXrvYB3/J+6QdymfNGltWdrNdlSu02Piio
         K9MY4kemFuKHeNu0LfxGtxJsLu90AFjPOqzGC8+CZ0Qv+vh0FbAdKR9ePRDe01OcvY0c
         u+aeuwJX18UOj+to649hnZ4PmohTHNI0qS53yNkq07uABtXFLTbLcxbHci2qtGO6jw5S
         p6izLbE6UUMeiXqUi68xCFWuCoqwVt5dyEXrh+iM7hgiMKY1AhlDxZP5JudAvvUKQrKy
         hE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285039; x=1715889839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQBoWhnW3eSJL5OjfxzO0lzEIXAyAkfzlFMU1Ex8yOg=;
        b=Dq2PtZdH17TrNJ8rbBBrWDCS1otkHFvwa8M9lccUB6/3ukw/OnmmmmDeSKyWi8u2cU
         mj4EICHTMh9/MT3fp6i45yTW6/P+A+pEfKvIWVOb9ei7dmJgvf+uyoNzbfZeLsvMHf2S
         IHTDlLF4VbZqw4YuUe00WdMVZLBwBgeEA1TkCNRRsqp5iJQCtZULBfTqdXazSoYd8RLp
         3p3VnQz0PgZVwYeCHlRbO8frA23N8BjIQ6D7uzP949Bx/ySGBeidfwcrU7yntN+/QrRN
         rOAnxLmR+Y4y3S0FMQyH3Em4aYDrB0ZAkIaCEsb2M6dEID3J/F4wMMpVeCdruQKlQC6B
         MPiw==
X-Forwarded-Encrypted: i=1; AJvYcCXblvSuhA/t3RKSNCstULI4jd485Rp0X+Qa4aeUlCEL2lia7gg1U0Ew+EzXgkngONfxEUYF0cH3Z42yV9KMg8bqxG23
X-Gm-Message-State: AOJu0Ywstip0P+bfBFfKjJ9q4OKSsGHpwb/PB5j0oujvzIb9FG28g13N
	oWHJWN7+sl/KvnC3mmNU5kwB0AdPAjhfP4Xl5Kr7mMU3eahO3/00vdP2fMiwJOjvKIbd1se0Hgv
	LmQ==
X-Google-Smtp-Source: AGHT+IHMhChQUGH3o/y/Xjd523PA1kFSsocfDFneSTYQRZIsze/kEjlVNH96NGo8Y5vnkXmCBqnyZyOLRsw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:a91:b0:6f4:d079:bb24 with SMTP id
 d2e1a72fcca58-6f4e0296acamr10866b3a.1.1715285039543; Thu, 09 May 2024
 13:03:59 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:59 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-68-edliaw@google.com>
Subject: [PATCH v3 67/68] selftests/wireguard: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/wireguard/qemu/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/wireguard/qemu/init.c b/tools/testing/selftests/wireguard/qemu/init.c
index 3e49924dd77e..08113f3c6189 100644
--- a/tools/testing/selftests/wireguard/qemu/init.c
+++ b/tools/testing/selftests/wireguard/qemu/init.c
@@ -2,8 +2,6 @@
 /*
  * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  */
-
-#define _GNU_SOURCE
 #include <unistd.h>
 #include <errno.h>
 #include <string.h>
-- 
2.45.0.118.g7fe29c98d7-goog


