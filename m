Return-Path: <bpf+bounces-30223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AEF8CB7C6
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABDE51C20983
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FB615278F;
	Wed, 22 May 2024 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/ucLtSs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271C715251D
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339690; cv=none; b=FV1ri5VY64MLwL6G9zq252LrYNSgcSf5zjhDUBLgTaW8oyO8v6PyqhiLYdfpj0oAWru7Vqs+7z36o/td/jtFY9kY/q8uUIM2XQn0+PvzUIfsAjDu4ipaqiOd8ApTAKOB/qzDzvj8mLNOHNehX6tG9146T9ZHi1jCoebLwNHoxrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339690; c=relaxed/simple;
	bh=MTodUmyJXfHVVr8W8CfAFa090pYkk2toySoZR7GP0Sk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o8As+FJmoILdUCHQtHu/tl7xxWT0D/tVkbWYI9fFm4rk20nQiNrXC8l4bZfvtLDZ6q3wL4u6GgHvl+ksbSkiLcMqgqTzkHW6//5K5snD/A7vbI6ZP66O3o25MKfrwm/nGhwrydY3WH14Mn47SKcu5JjjmVIJFh+4yDV2nRD6sgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/ucLtSs; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6658175f9d4so3959903a12.0
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339689; x=1716944489; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a9qeTCFtvuxbGsifiEmJumkkd9/puPZE3ppF8UEgJw0=;
        b=r/ucLtSsVYWgqYTaJTNB+ELgUHHbbR7RO6ag712NLigCuiAl0DRRzQBUFVoizX/I4P
         9xxiYd6mQWklDOhc8JTZYJH5Nnf2UY66xGO6HRubEKqYxM2uMgnFM1x7J6Irt5eSqnoe
         EtOTEU9cZnMbBIMGLdp5pg29LMecC1ioipuzvnJffCmdQ559xEnBsdAgUuk1zir3c4MD
         N4HFHk6RviVFj+39A7cCIs9VvSPGu+9WBLDYr3TFuOPq1rSjGEifJrRSQ9C3hUoBrKm6
         242KIPBWlTox8FHpZRpRieHl61G11kCSAm+eX0+4J0eMd4cBhseERIdSFnX/6Grk2tX7
         lMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339689; x=1716944489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9qeTCFtvuxbGsifiEmJumkkd9/puPZE3ppF8UEgJw0=;
        b=GtLwbQQV2tYVUz/wFPoL6Y3EVzauJ4N3IOSfEXVZQdOsc8i8jG5NxukaefrzXoKxoM
         9TeaRZhLRrHMdJ3kjO4+46r8vfvMcDLy5jTqurpZYCXSWedmdHDOfu5YfLJ6JdEQEYG7
         6uiJyKByquYDZpraQa0G1nqh37VEnmZqiHtJF645ZWQc4nqJACz4fw6GJ4qIbr8ss+t3
         nssGJx4aDLj2vOTZdVk0hox7BMSulUif/FtJ7mbpzWZtC0nH69iyp5/zL/UqpHBZHQma
         vyU7bFltR2sVhLGqlFRX+aPq3NgzoGdHxIukE4wMW6DtV/qcfLw6q6WkF23BrGRy0BrJ
         UllQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoA8h6gKjg3vgMRAAT4nohtdqk5UgEco8MxFaSHugPAufkVJClfeXed+OkfH6zAhsX3ldIRureI/azvb0WxLavEgQV
X-Gm-Message-State: AOJu0Yz50ZjrQTMtaNizzV3WWCjpWfMgeHWMSF0hXCQMIknFbtcNvubz
	mJskhrQOz5JK6S2xM6uEgHIZdqztOgL1D6GSG+mvVLghoUdpPIw/bcNJ1f64LCqjFw1dpbgkZO0
	JAQ==
X-Google-Smtp-Source: AGHT+IGEcjqj8zufEeTMy6AMcaIsqkRg6a51FGXyadk70W9VXPBiz86Gg8WH59rMqAlu/ildvCYIItBNoi4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:dd53:0:b0:658:956f:9800 with SMTP id
 41be03b00d2f7-6764de8cb6fmr2228a12.7.1716339688506; Tue, 21 May 2024 18:01:28
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:26 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-41-edliaw@google.com>
Subject: [PATCH v5 40/68] selftests/perf_events: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/perf_events/remove_on_exec.c   | 2 --
 tools/testing/selftests/perf_events/sigtrap_threads.c  | 2 --
 tools/testing/selftests/perf_events/watermark_signal.c | 2 --
 3 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/perf_events/remove_on_exec.c b/tools/testing/selftests/perf_events/remove_on_exec.c
index 5814611a1dc7..ef4d923f4759 100644
--- a/tools/testing/selftests/perf_events/remove_on_exec.c
+++ b/tools/testing/selftests/perf_events/remove_on_exec.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2021, Google LLC.
  */
 
-#define _GNU_SOURCE
-
 /* We need the latest siginfo from the kernel repo. */
 #include <sys/types.h>
 #include <asm/siginfo.h>
diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
index d1d8483ac628..14d1a3c8cb5c 100644
--- a/tools/testing/selftests/perf_events/sigtrap_threads.c
+++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2021, Google LLC.
  */
 
-#define _GNU_SOURCE
-
 /* We need the latest siginfo from the kernel repo. */
 #include <sys/types.h>
 #include <asm/siginfo.h>
diff --git a/tools/testing/selftests/perf_events/watermark_signal.c b/tools/testing/selftests/perf_events/watermark_signal.c
index 49dc1e831174..19557bd16e9e 100644
--- a/tools/testing/selftests/perf_events/watermark_signal.c
+++ b/tools/testing/selftests/perf_events/watermark_signal.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/perf_event.h>
-- 
2.45.1.288.g0e0cd299f1-goog


