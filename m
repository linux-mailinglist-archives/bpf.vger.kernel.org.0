Return-Path: <bpf+bounces-29263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B678C1685
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CE38B2445C
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCC413C919;
	Thu,  9 May 2024 20:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gssulq3W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282C985C41
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284944; cv=none; b=tcoJ68Ch7NAOAFiOU+VVphcFKEg1mXve+SyUQinN8+f0Noemk95mnVAYRtsEJvK61MAmSL/icCjbK03PPEV67xOWwxdiNEC2WTfKzjHqr/8NU+JvM/aMdrsi9VAWcoz7a5HY6lpZ+RcDy5dCTUzv59h2qkHAOhEGqEJbBJR5cKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284944; c=relaxed/simple;
	bh=WE+AR6jouAPRHEvvVzrby5R77phYzayRUTXYm2QB4lA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=unxGkAyVzyGW+Pjg+9XcUaNwJBgf4ZzUpJWH8QiJK7ZIWE0QZOKO8/hF5d5P+aKogyRINwIfdaqD0gsey6cMkn7fH+Ylcx+bsICnHBaz12HzQ5cHB02fppWRof945bnm0X0sxzPppD+fsaDHwkJ5qbedQ9QGlCERkdVPwKeB2lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gssulq3W; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so1727428276.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284942; x=1715889742; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t/Pst5TQmmPDAJyMHgqtrqTxRb697RB0f9O6Gjfco/Q=;
        b=Gssulq3WpORjjD4vxfH4Z40X+EaJC4itFJDq6Gm51rxmxNX20+yOnAl+suHO1MypeU
         nSyWvrqm8VKH7ZxaZ90ca3DBdl/cthV7aqSqD+daEgZjw3YzYBEMrTupp+WB9xTQ0Kym
         nHtCW8Ok/u0g0C8RtnHodDvZSaYc6GPWfcgN3XUfbK/Hb0L+x/btgUT81en1gWL+Fo2u
         kY5HabqyPG+iClxgy/iJQVtpRANIHg9XZfEcz6EErxeXrIJzHQ5M6dQSuJcJxYjDbEc8
         +9SDHaDkIjiLDTOvw72ZkW9S8mRP9S64FvzlIGyqX7ULZa2dhyBFVa//r1QpsG9tMHl0
         4uoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284942; x=1715889742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/Pst5TQmmPDAJyMHgqtrqTxRb697RB0f9O6Gjfco/Q=;
        b=EXL+gNV0W36rt/25M6GACgUNRrzxMMqMxof8YTphY78JtKRtJHsPrC5w0nxSZX7lHf
         Mgfk9i2bwOw195FWrmG1+/uRblrJFZDM5p3jQ7RVMcVcPUTrxw/BbcJlFb6gsvkoXe5I
         TiN89fbG/vVfRM9mWBqI37skIYA73lblniX3ERhMA4wvmcXD73t5BPsxyYGbXX4T1aaM
         KBv/Cv9tDaRE3vk4ON7aBbdmaJdVv2vaV6YUeJDZW3UmfJEZhpJHF97YSJD6PZo1zvHK
         oZyGZj51hObV9olVDE3gBTVceJXrpwdsA/qtH0Bi281N0QoEY5eXcmY7y7BIHs/Kibdy
         7Oxw==
X-Forwarded-Encrypted: i=1; AJvYcCW5d6GkgO7Bt3UJjKqD6a9rSF8RrHyF+hIt2Oja7RajJhiRN7Y6WMTqEY/oLrGi9zdrvRZIB0nAL4uyd9aMZdZiktPv
X-Gm-Message-State: AOJu0Yx0UtvVjzFxTTaJZPEIjR6U+o5ta7MdKeqTDVqmS9HVgnYDZjXN
	VbV9Y558mH2TxX0WZ315oE7GW4gts8IBTYq8eSqPYqa+0tCCQ8JGrKVpNwKiU+U47cSO6pyY3cN
	0iA==
X-Google-Smtp-Source: AGHT+IGMbs/JaF926sFyfnviZMWe9jqmOtpPzNvsiWM98FusLZCSeXAn1EjPRZgQVmyQ81yz73NAnaM90ZA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:154a:b0:deb:88f5:fa0e with SMTP id
 3f1490d57ef6-dee4f1ca69dmr59044276.5.1715284942280; Thu, 09 May 2024 13:02:22
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:25 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-34-edliaw@google.com>
Subject: [PATCH v3 33/68] selftests/mount: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mount/nosymfollow-test.c          | 1 -
 tools/testing/selftests/mount/unprivileged-remount-test.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/mount/nosymfollow-test.c b/tools/testing/selftests/mount/nosymfollow-test.c
index 650d6d80a1d2..285453750ffc 100644
--- a/tools/testing/selftests/mount/nosymfollow-test.c
+++ b/tools/testing/selftests/mount/nosymfollow-test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
index d2917054fe3a..daffcf5c2f6d 100644
--- a/tools/testing/selftests/mount/unprivileged-remount-test.c
+++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdio.h>
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog


