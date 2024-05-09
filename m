Return-Path: <bpf+bounces-29261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B628C167C
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4631FB242E1
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FDC13BC37;
	Thu,  9 May 2024 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFTp/NUm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8722F13BACA
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284937; cv=none; b=dKqfBiKz2lC4qaNFBb7oZd5jt/Iu2gReyl5VUG4V+d9M0wLzA3aqOcX69QDqR8tNcwzmR+1oAH88hIDOFg9QEQ1YDuSKPuGUJMUiz5+rzYkEf0jpGsUHHG8Z2hd08UJx3INFFNs+Zj0xw6baLeQEmfvhj3DOZdW6eQe06+OWqQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284937; c=relaxed/simple;
	bh=Q8vMNdjv6oUz3ffMNcoe90QZDt2uRoBqgozhP5DTiA0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mn1/t7E2m0z+XL+QLmNDOGGe9e7bOaTtvBjReE67RpS+pLqVfqTLfeTRKZDaOdCefpa8Vx2DEqcZyENGUbZzfOw34anUIzBfdoFIvv6/n/mXZQTablRlNzzDwnr9ld1MP46chBqR4/8/Y7vh/MpBjbvWxrxrIZXYVgjB0CQBO1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFTp/NUm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be23bb01aso24374747b3.2
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284933; x=1715889733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ea0S0oR7atF2Lg5jk6+sVnhZ8gGTM0V6dmG3kMF6TeI=;
        b=IFTp/NUmnUR+jPPz4ujog3zcMgIwi3YGl67rPta55u0EYf55NSd92iDLr2zqaMJ7Ge
         a8fMNeB4LzFmiXwz34o3m+tI8GnDdJ+ie3emfW5JcPmxnXx7gYSvly1UWadyXOmY9h5v
         kDWJ8Yp5IfDhmMylqCSkgemMI4oK0PtB7qXiuB1Kb50H2b55NXwB6rtUmNpzJexISHju
         2oe0f9U4h+k54Ha7p1H16kdt5DE7mbYTMfvZpKiOy/x5QbcvoMkk8IJXCAGljyHI1G/5
         D8tN38y3Nv52Blzefk+23RURsZW2ZEM29+cf1dl8TVik3dSk5Fc+GVXMU6sDuYCo/ALZ
         lq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284933; x=1715889733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ea0S0oR7atF2Lg5jk6+sVnhZ8gGTM0V6dmG3kMF6TeI=;
        b=XFY6uQ8OP+1snC6e4+uuseZj2yTfoGELJgLX3OocfXymOTWoqgT8gKr22NnxZLOPcq
         NuqbSAKF9ainHhLMIwbLpyQbDO5YvHnj/oKmNpdeybEBgB1ZKYLe/Ue46BKFiCjhHwtt
         W9qLl6QddxpfFUDFtOw9TfFiAnAszeVA0EemQIa6LOHsJXSrBsVdC0Lbam8IanVUfru1
         EraRnWlJe5HFQTihtIBYCjNUdABU3KcGsJjU7OcU0aYH5OoZO0gdxiollWvQu1VKhy0s
         AOuMkDVMq9XJyc5yb8yyPGbZ11c11JeAZIMUZ7m2W9QmN6NTpPXph+o2gXpcD1mQbc0S
         yGOg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ399bVbpHz9VuVm0sDwn0q8+cejds8H8T3ZryiX16zCwUgiWOUrYcHfNF2JDaDh5vZtNtiGQFnOrrG0pyxp0ybDBT
X-Gm-Message-State: AOJu0YzMnu9lyJMqRqK5micrZOfLDQOjV6Ekc20ZWEibC13u7x4G2ae+
	DYGIGea8pN/xpkxUBEd4tc5BcomIesSr+pHFeaI1x8oQIph1sdBUtxV/NG6OdQ7Ph8hTnKB3oEk
	Ppg==
X-Google-Smtp-Source: AGHT+IF/jnDS4ymNWQMUF/oWdD6iqbobUDLDZUHVjJQIP+SRjrwW5c29IOEMwIEB1XpBJKq7KUUsEHKahpI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1002:b0:de5:9f2c:c17c with SMTP id
 3f1490d57ef6-dee4f37bbfbmr149190276.9.1715284933545; Thu, 09 May 2024
 13:02:13 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:23 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-32-edliaw@google.com>
Subject: [PATCH v3 31/68] selftests/mincore: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Edward Liaw <edliaw@google.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mincore/mincore_selftest.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index e949a43a6145..e12398366523 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -4,9 +4,6 @@
  *
  * Copyright (C) 2020 Collabora, Ltd.
  */
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
-- 
2.45.0.118.g7fe29c98d7-goog


