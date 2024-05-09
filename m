Return-Path: <bpf+bounces-29237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D2F8C15F5
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B8D1C21083
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C8C128816;
	Thu,  9 May 2024 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QM5pMXYv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415E080C09
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284871; cv=none; b=ffFVgbFv1n7DT2f4kiFS6CXbDJqEU6Dvm+MclDD61hkJBmv/GK61bszaRkoO6ekbaHSlVYszwFi6scG30ccEZUMj1NbzxMYn8Hj1w3TTnH+Zr47AaJ1mTXdhPaqqNimma0LR6CTVE1vfX4datHBB/b9mxD6XbBVbTKvwxv352/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284871; c=relaxed/simple;
	bh=FoY+8htLD+tcBfSG58OctRNszBURt/6xq3bm1HJ3AsI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GEOr+YmdO+DMxONvfvb1EPzjYttxIvXieumSDDoYFqvYX78cXiCuzbK+kiAsZCf73/OeBv/fw1iYGs1pPh08/vHOwiHPD983F+qHc/b7Ez0YFvhCZvgeA9Erawjxxj4froG7+4NF/HdlntewNDy+7BXUfbAAbnCBwbbvn1SEjnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QM5pMXYv; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-61c4c57e97bso1192959a12.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284870; x=1715889670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I0i1BJHEHfvwlJBsnQikq6I2sYMm72umBUDvidl3EP0=;
        b=QM5pMXYvuIjT+hJwvm7ZqbR2i7wUFCbW0Lpb/KmQCl7s/7e5Q6AJI/F5oeWeS+S4Kt
         L51nrwbkKa2XnPeWPS3B7KES9Lox3Xld0m0X9D+qln5QOXtAgynPOE12zxD+4H2NlVup
         PjqrEFtqN3rtn/SNK4k9lJINHVKe8tHNcHYR1ZTadGtRUBwhz/LizigH19dz70NOnjJ5
         cCFbvInbXf3KkBlzXnGh9kUAmLDSrbBZogLV8P/eLRpnMYd6+dJ5TSJulBratq8aUqYw
         5XdIwsSBEe5dbdgsHnmW9JqTuEaQXlZwih4GBMU6/nmD//hJyOrBLihZrTAyejzHLkOb
         bx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284870; x=1715889670;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0i1BJHEHfvwlJBsnQikq6I2sYMm72umBUDvidl3EP0=;
        b=oq2Xub1SttI7qNhsU5Dc51E7G454qPpi/NFi2j9sjGHw7jWU/nfg9653VmIM8WX8w4
         /wZrOvPTup/dHKJ8MRuUuGoyf8p8dHEVzqyz3n6w/1K/BF278VbWxiV2kR8jmKxOogcn
         kJCh6pQq59+MdwYyeXHm8g2jpISZTpKq7uGwIFdnFK498XlRt+tRpJy62fj7WdY9JMHj
         fnxJQdgtD18+ZZf5TFQ+Ao40yeseIN9KZy+zH9vbe5VU+ygbl2k/LP3fryVbkljBhZ+0
         9WOHq7bOhGXEZ+oVslLtH3jmeFcA+3+LOBb8X3zaEhd3qIYXQ4XXQ0VCOTb9vugzXwMF
         RfOg==
X-Forwarded-Encrypted: i=1; AJvYcCW9ZZYc8F/BvDJ63M6neGochSKT/kmauJQ4ItPH8fbmAlanPI30vongR/HU7vjY9+2na0JnU86IDKhsO5y2GkmOyoqf
X-Gm-Message-State: AOJu0YyTDrldFftIwVPfzz++ZKf4uyZhPOpwZEm8LpFn7eHp+oT/W+xO
	Jp85+jfvPaqY/ZNO8fVefL04yQ04H1Y5v/c9qSd4JCaKhMDBK+7QhUZ0CLQedUzPILNuqpdmDU/
	csQ==
X-Google-Smtp-Source: AGHT+IFudhQt1fRt6J0kI3URdQQI5Scuqc2zHiG+e3HEB09m93On8QGiFupoq3VY6GmzMw99gIVvhuFAdzI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:7749:0:b0:5f7:651b:fed8 with SMTP id
 41be03b00d2f7-637427ab755mr973a12.12.1715284869580; Thu, 09 May 2024 13:01:09
 -0700 (PDT)
Date: Thu,  9 May 2024 19:57:59 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-8-edliaw@google.com>
Subject: [PATCH v3 07/68] selftests/breakpoints: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/breakpoints/breakpoint_test_arm64.c   | 3 ---
 tools/testing/selftests/breakpoints/step_after_suspend_test.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
index e7041816085a..e5a95187ac12 100644
--- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
@@ -7,9 +7,6 @@
  * Code modified by Pratyush Anand <panand@redhat.com>
  * for testing different byte select for each access size.
  */
-
-#define _GNU_SOURCE
-
 #include <asm/ptrace.h>
 #include <sys/types.h>
 #include <sys/wait.h>
diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index b8703c499d28..695c10893fa4 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -2,9 +2,6 @@
 /*
  * Copyright (C) 2016 Google, Inc.
  */
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
--
2.45.0.118.g7fe29c98d7-goog


