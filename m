Return-Path: <bpf+bounces-29296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0C18C1732
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EDFA1F21A78
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7547149DFA;
	Thu,  9 May 2024 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XCORQWUc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51D148FF9
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285039; cv=none; b=Q+CCNygvZ8ASN/EpFzzVIuTwTVeOWaOt7edHPRDuoNmyZXBX97gAhnOs5GpLoljil3zf2vqI7Zycz0SCToJb/VofATPGLqRAhng/PZDiIcln/mwKJTE7uSqxpSWObdiCS1DBVi/0uoP7xmrmpiMQ7LrgOjjvUczbbkS0Cozl/zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285039; c=relaxed/simple;
	bh=YGdUWwnBUwtAPSGnv0RCxLjda7Rt/VoZWS4Vf/iu688=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bjpssFXROyxR9KZNk+Y3O6amJ4UjC0/nGX1GstE+dOQ1jG6iwMrQefOZU6g8lOx7bbTycx4Je6/Iu2oUec/NCTLKUhQMcKUwb0rVShOa4kzlZocH6SP+vq4v/P/yF3UmiwT9IZZiFh+zCvqE4OJ9ijWisvoopUuOKf0Ai7E2Gd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XCORQWUc; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f46acb3537so917669b3a.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285037; x=1715889837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CpR2fXzwrU5rpm47H0npQ28GT7MWJnlw5HNOpJYAkd4=;
        b=XCORQWUcXmszvPUYNj2T9+FZvDLLqqvNGl1O5aQ15WjMruZKuZBVqA7IjloyVtLG5Z
         Cy4uq1J+/oy2HoEmfuqwDJM6fPORb/n3/+soGlVqf0uYFD6T7j7gQkNnfagz+4USGQ6H
         bLgHm0zbVyWtDMgVzKNFDVxB9di5yaVzdraFKDvzNnTwBQCGXax/8uE8ZmCa7Ja3efM9
         Bz0Qhh3iE4hYwyIpEBEV2Zrbx3DaJQ5kgcpgZ7DFU6xvKRDp43KY7valBw0mlMfKOPlf
         oY9uuo63jx9osPLBk61bbpbYjoyUSBFnltkC4VA7KMeNAABo/b/LvD9OJD9q1j2b+/d9
         mmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285037; x=1715889837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpR2fXzwrU5rpm47H0npQ28GT7MWJnlw5HNOpJYAkd4=;
        b=F6kCjawERStNYr4kWNtKGxrzGCfb09ObFs6CDVAAFfrnqPj6w/MvWlu4DZ7FpmyU3Y
         2v92hkC3KxULLFJl+04uAiQuN1LLnEAf3VXuXetE9yBeaLzafI4YDFZ1DiKF2s5oBGeI
         JDml5SAM2//waeRL7GPpyO7mbRMlZx2FjZIxvuOJpjbPxXpENBR2yL1oEbQx4ux7zMoF
         k1lj+QUpjwChzvIL0q45UbVUO9zoLXWCQKWeC6yKysDjpl/zL9+xk5R9oyuyzMSl6lNY
         ST15FVHDyMDnIFB37rRFNhzR2KW+1Pmky6uA4HMxoS0WcK5uTvNupRpCL3izpw8i5jcb
         27Pw==
X-Forwarded-Encrypted: i=1; AJvYcCV1DHWTRp2BPbu1Og/HaWSXdXHx73l2KILhxZkRvzBmQYIdnlmmByyzjUy11rboLgMcJbVvDp2T/2SsUwScpJhwwTRQ
X-Gm-Message-State: AOJu0YymJ+TUPir7GMQkotfO9eBP2lfPS5LotB9S2S0eHOHLBTl9U4G7
	qdB45sIXoEWD5sg9OijBfvS67V06qEIwUGXDbeV4afB0paojSaWZ46w8B0spckx7ZT8uGfIesdX
	o1A==
X-Google-Smtp-Source: AGHT+IFI874f+n8iDrukMUj0e5vTHsv4XlA10buWf+xTINM7U+orl2HvrgNvuh4I0S6pYnKJpWbZKr4P2nA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:2289:b0:6ea:f425:dba2 with SMTP id
 d2e1a72fcca58-6f4df2c7942mr54587b3a.0.1715285037144; Thu, 09 May 2024
 13:03:57 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:58 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-67-edliaw@google.com>
Subject: [PATCH v3 66/68] selftests/vDSO: Drop define _GNU_SOURCE
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
 tools/testing/selftests/vDSO/vdso_test_abi.c          | 1 -
 tools/testing/selftests/vDSO/vdso_test_clock_getres.c | 2 --
 tools/testing/selftests/vDSO/vdso_test_correctness.c  | 3 ---
 3 files changed, 6 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index 96d32fd65b42..fb01e6ffb9a0 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -14,7 +14,6 @@
 #include <time.h>
 #include <sys/auxv.h>
 #include <sys/time.h>
-#define _GNU_SOURCE
 #include <unistd.h>
 #include <sys/syscall.h>
 
diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
index 38d46a8bf7cb..f0adb906c8bd 100644
--- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
+++ b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
@@ -10,8 +10,6 @@
  * Power (32-bit and 64-bit), S390x (32-bit and 64-bit).
  * Might work on other architectures.
  */
-
-#define _GNU_SOURCE
 #include <elf.h>
 #include <err.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index e691a3cf1491..c435b7a5b38d 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -3,9 +3,6 @@
  * ldt_gdt.c - Test cases for LDT and GDT access
  * Copyright (c) 2011-2015 Andrew Lutomirski
  */
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <sys/time.h>
 #include <time.h>
-- 
2.45.0.118.g7fe29c98d7-goog


