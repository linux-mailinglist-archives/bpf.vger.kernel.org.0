Return-Path: <bpf+bounces-30195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2EE8CB732
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685AC28110C
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF6F824A7;
	Wed, 22 May 2024 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y+VaS4fP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898FE7E579
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339610; cv=none; b=lkXfc7NVPs1l0yIN0HzwK0ffvyHp141erenlJVSSBEakrg1SGV19zk1PZyo/G2pKqVSWhL6oz5nFZJUJd1nRSPi1TClKfEflBwELXHgJynZJtTPnGTRJxfsGGtB0dX+1DNTyUCbd4/6vglMn7JOSq6Kh9g+SkIT/g9InuI5TGgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339610; c=relaxed/simple;
	bh=62O3V38af8AfBVqt/HK7S1eFdYifF40ZLMchODVkB8g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HyvHcxmXFKJNpJfFpJrKCThkEX+968mA3al/OcT8vQ0f7ddLRlwFE6LMJBnX9fT6I00OZxHf98/OAE9AoLUZwr+IcyYhp9Lf7J9bKg34gIdJ0r2cLESri7z/C3Mrz7JzZBycmcFW+RDYU+gEPeAVJWKlwBYGdx0ixoblkcOBUPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y+VaS4fP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2bd5f87a0e1so3682407a91.0
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339608; x=1716944408; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qBN6dKvcn7a1ilrAwfzcd0ocDzyyL7QD4f+HvB8bOIQ=;
        b=y+VaS4fP0TbbS7MXSz46crvSFsk5xjL+U4Olpf0NxQKuXj5aVFHnvvH9RJcMuBNEoX
         h/dGql9owd/eupptDWu2/4Xzds3ZGBK6CZZuUetUvY/BeZxR4pb/2hk93dNWO2oEjmNH
         XC8JY7rEf7U+GbOFgJ7ngfJ6RH80K/U3XW2TJcZCNSCJV34ZExR9Ns+JsF96EROv15FE
         hVzwFNQbPuOvvljjVM6NzNwB2C4szqrDRKt1E6UcVlODoRw40BM9dZKJqYw3Xx5YsjEO
         SmTdgfKYrBXwF2yvPuPgz15VYfUBcQiWGEzVT6ETh1ksDeJq3tzvB11lRwoxZfwXbkYQ
         O5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339608; x=1716944408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBN6dKvcn7a1ilrAwfzcd0ocDzyyL7QD4f+HvB8bOIQ=;
        b=v7TQJ7UjEnTwE9fOwHeqVdZ/IAQk2QH59CGWbB/YO9u/2jvzCD1DkhLeihZsUlr+o2
         4wvCiVB9WSpiFdQTBrAb5fPUsCmqI4ZjzuD3uSJ9muDEweVKBlNrWSlYyGczikInLg42
         05lkpd3issOB8Ud1AVNj3gDwpM5Q9ZNdtDyYhoce3tMkD4AjpTZldrGsnD9oSL/T2MFg
         FTaVxRIg7Jcsbnu9GEt8vE0jTap+bZET5vclPYHDJpVKIPjm7vopYJS0lH2JGqHpHcdV
         v9pjH7Wb3wHIo7f6uAVc0TalcOg0WuxHONi4wEc3WC7KiQ78Z5GpCbs8bGE2ruC0FvSA
         UNsw==
X-Forwarded-Encrypted: i=1; AJvYcCW8fw7PUWWrb9YYv8TOalaHSQv4o7wJsSlGzdFINM+PT6lzqhEMUs/8OOHfsExTY18hc/ch9UsZdBLXT6oOmtJN4VdN
X-Gm-Message-State: AOJu0Yzhz9xDZYJexQTHeVsC2ZrEhyxp79VM9RvBYACTLDkrrCm07WLl
	HF/fqB4Vasa9t8hS9DbYJ2R7x9+HtkTzrgD+QK83lnNHLIxe9U3ot/n+haRvblN/c2sHWsZRN5I
	M/w==
X-Google-Smtp-Source: AGHT+IHt7Kr5feX1gdf4rvQKP41zb9M+M6WWZuA6mfud336Es8VWWBsR3GXtiDGmwzCkNXAVdnqYPJZFEdE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:9f8f:b0:2bd:9285:c147 with SMTP id
 98e67ed59e1d1-2bd9f4a593cmr5758a91.5.1716339607777; Tue, 21 May 2024 18:00:07
 -0700 (PDT)
Date: Wed, 22 May 2024 00:56:58 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-13-edliaw@google.com>
Subject: [PATCH v5 12/68] selftests/damon: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	SeongJae Park <sj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, damon@lists.linux.dev, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c     | 2 --
 .../damon/debugfs_target_ids_read_before_terminate_race.c       | 1 -
 2 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
index 0cc2eef7d142..3f0dd30f61ef 100644
--- a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
+++ b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
@@ -3,8 +3,6 @@
  * Author: SeongJae Park <sj@kernel.org>
  */
 
-#define _GNU_SOURCE
-
 #include <fcntl.h>
 #include <stdbool.h>
 #include <stdint.h>
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
index b06f52a8ce2d..611396076420 100644
--- a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
+++ b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
@@ -2,7 +2,6 @@
 /*
  * Author: SeongJae Park <sj@kernel.org>
  */
-#define _GNU_SOURCE
 
 #include <fcntl.h>
 #include <stdbool.h>
-- 
2.45.1.288.g0e0cd299f1-goog


