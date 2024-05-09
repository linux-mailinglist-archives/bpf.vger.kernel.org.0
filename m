Return-Path: <bpf+bounces-29234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6595A8C15E6
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD182B23E31
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B36486240;
	Thu,  9 May 2024 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fgcn8ZXK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86085C41
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284855; cv=none; b=GlLoYDups62QW/FX5xqA4M530bK7p9Ud5N+PgUbZUNeoirwEoriKnxhmftTnDgpJIirGY2sn7zY2YwAQC9F/f77A3ok9Kd5rgX+uK1xi8+66p5zVV8bthv9E6WnyXK/A0AO0jJ5mVvxzHHv7wQmRX4HSyTc+Y8QwYYAtCntxPtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284855; c=relaxed/simple;
	bh=qEmquAtOnIajUCIET+4FOjSPPjhOeil/rXAtjnxBHGo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eMTn06DLbNbII9IOg2cUuz6Chk+pDbrmdLVsRJbC5mcoTLx1s3nHSm2megVmYtBk3FuClyZyS47SFIJae65cwO1KT/z2F3vlF0zIIKWwPzHSpWX6T64+yXcxyJnXKhzQpXDTKBntVgK99otx1vcHZAaRdfRX8zJMO8GQX3XFFjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fgcn8ZXK; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f468ae6a5eso1208458b3a.2
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284853; x=1715889653; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7RwMbcr7bd11lSZk8czpu4eBIOH2u27Jnq3T4Cop/ko=;
        b=fgcn8ZXKFlaZG2KQ3OSswpwXu9mSW/mWZj7A92DIMX3iUxojpiicNREJ25TMAFu1Mm
         ZmDE/GU4se3PJoaVLuO1KGWKhamn8C7y0hhg344rCVQ6BKgTFuJGrrTnww+ItQfSkMtu
         h81CyjcWVnVh3sBYzxTZj8Fm7PF7fwWqifKqvILceUpBp0m5iuw3e5ZSHOREYR1UdySJ
         B8CHBs6Q5sFTcYeCzGiCjRqf/FkjBo9Nyjv2ww2uHpWXahp7Ki8XkMtQOPeNttS2w6Xv
         y37g5e8vp4wAkXqhl2WHNKLLds+b/FsVfQd/MtDmaCBPDwtrPemeMo86UQ29pltPnDb/
         8Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284853; x=1715889653;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RwMbcr7bd11lSZk8czpu4eBIOH2u27Jnq3T4Cop/ko=;
        b=aTv3eteA/Ty9TNurnXDdQzGc6fobUhlLfyu3SUMZx7WDaX/EPI8jPdio505v/sZwZS
         ebTfxngO0LQkR0LY1TuMCHeB+mDC7ITnaDn1ampNV6H6FvAteF+SFV2IVShDfbLeRutW
         zd/QCnRVGO9lpn8bFwomRJeXLYTv7u3KrfkT9KyWVs6b3OqTAtxvnL4IjKqNdeViiPhw
         i0254N92FqOnoqLOjWXZWwrBLcbzDWmqeDUp+Llb4SKLVKtvJHHAwHbHQekLZsQNRv8y
         Y24pVpBTkj+JGfgEHBpQNgf/uhL9XcxoqSDGd3ehoSge7cBMw+94F3IDTzd3b9sQQ4Jx
         Q7ng==
X-Forwarded-Encrypted: i=1; AJvYcCW60blYQ/XnTxR/t3ULzBIe7OhiCnHNOLhNpESTs937ydyvTZuomX0iX5eLzkJ8ofxmeuTAqGQELSrBqIgEcdRWRDdB
X-Gm-Message-State: AOJu0Yxq498xnvMaU4+SD9l93AW8pQFRmcvazZQOFW9RvsSwO+e5fnRq
	8wWw3BZSNlB9a9uSkijN9rr94F5Sp1Yumagbx+thQ7gG09I+6c91m9M5TL1801J0fX8yFD9hpQR
	/tw==
X-Google-Smtp-Source: AGHT+IGmISzn3sOtqsFKSvxwdELjvMW4ApeP/SAyXNazvTMS8izkwq3WVotcYYgYNquUC063YUcWVoMXVGs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:2d11:b0:6ec:f407:ec0c with SMTP id
 d2e1a72fcca58-6f4e02aed8fmr1374b3a.2.1715284852715; Thu, 09 May 2024 13:00:52
 -0700 (PDT)
Date: Thu,  9 May 2024 19:57:56 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-5-edliaw@google.com>
Subject: [PATCH v3 04/68] selftests/arm64: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Edward Liaw <edliaw@google.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/arm64/fp/fp-ptrace.c              | 3 ---
 tools/testing/selftests/arm64/fp/fp-stress.c              | 2 --
 tools/testing/selftests/arm64/fp/vlset.c                  | 1 -
 tools/testing/selftests/arm64/mte/check_buffer_fill.c     | 3 ---
 tools/testing/selftests/arm64/mte/check_child_memory.c    | 3 ---
 tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c | 3 ---
 tools/testing/selftests/arm64/mte/check_ksm_options.c     | 3 ---
 tools/testing/selftests/arm64/mte/check_mmap_options.c    | 3 ---
 tools/testing/selftests/arm64/mte/check_tags_inclusion.c  | 3 ---
 tools/testing/selftests/arm64/mte/check_user_mem.c        | 3 ---
 tools/testing/selftests/arm64/pauth/pac.c                 | 3 ---
 11 files changed, 30 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace.c b/tools/testing/selftests/arm64/fp/fp-ptrace.c
index c7ceafe5f471..eb1f14047361 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace.c
@@ -3,9 +3,6 @@
  * Copyright (C) 2023 ARM Limited.
  * Original author: Mark Brown <broonie@kernel.org>
  */
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <stdbool.h>
 #include <stddef.h>
diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index dd31647b00a2..042f736970c2 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -2,8 +2,6 @@
 /*
  * Copyright (C) 2022 ARM Limited.
  */
-
-#define _GNU_SOURCE
 #define _POSIX_C_SOURCE 199309L
 
 #include <errno.h>
diff --git a/tools/testing/selftests/arm64/fp/vlset.c b/tools/testing/selftests/arm64/fp/vlset.c
index 76912a581a95..e572c0483c3a 100644
--- a/tools/testing/selftests/arm64/fp/vlset.c
+++ b/tools/testing/selftests/arm64/fp/vlset.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015-2019 ARM Limited.
  * Original author: Dave Martin <Dave.Martin@arm.com>
  */
-#define _GNU_SOURCE
 #include <assert.h>
 #include <errno.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/arm64/mte/check_buffer_fill.c b/tools/testing/selftests/arm64/mte/check_buffer_fill.c
index 1dbbbd47dd50..c0d91f0c7a4d 100644
--- a/tools/testing/selftests/arm64/mte/check_buffer_fill.c
+++ b/tools/testing/selftests/arm64/mte/check_buffer_fill.c
@@ -1,8 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2020 ARM Limited
-
-#define _GNU_SOURCE
-
 #include <stddef.h>
 #include <stdio.h>
 #include <string.h>
diff --git a/tools/testing/selftests/arm64/mte/check_child_memory.c b/tools/testing/selftests/arm64/mte/check_child_memory.c
index 7597fc632cad..ef69abc7c82d 100644
--- a/tools/testing/selftests/arm64/mte/check_child_memory.c
+++ b/tools/testing/selftests/arm64/mte/check_child_memory.c
@@ -1,8 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2020 ARM Limited
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <signal.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c b/tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c
index 325bca0de0f6..aaa5519c6bbd 100644
--- a/tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c
+++ b/tools/testing/selftests/arm64/mte/check_gcr_el1_cswitch.c
@@ -1,8 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2020 ARM Limited
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <pthread.h>
 #include <stdint.h>
diff --git a/tools/testing/selftests/arm64/mte/check_ksm_options.c b/tools/testing/selftests/arm64/mte/check_ksm_options.c
index 88c74bc46d4f..76357f914125 100644
--- a/tools/testing/selftests/arm64/mte/check_ksm_options.c
+++ b/tools/testing/selftests/arm64/mte/check_ksm_options.c
@@ -1,8 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2020 ARM Limited
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <fcntl.h>
 #include <signal.h>
diff --git a/tools/testing/selftests/arm64/mte/check_mmap_options.c b/tools/testing/selftests/arm64/mte/check_mmap_options.c
index 17694caaff53..66bddc8fe385 100644
--- a/tools/testing/selftests/arm64/mte/check_mmap_options.c
+++ b/tools/testing/selftests/arm64/mte/check_mmap_options.c
@@ -1,8 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2020 ARM Limited
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <fcntl.h>
 #include <signal.h>
diff --git a/tools/testing/selftests/arm64/mte/check_tags_inclusion.c b/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
index 2b1425b92b69..e66d8b8d5bdc 100644
--- a/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
+++ b/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
@@ -1,8 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2020 ARM Limited
-
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <signal.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/arm64/mte/check_user_mem.c b/tools/testing/selftests/arm64/mte/check_user_mem.c
index f4ae5f87a3b7..220a8795d889 100644
--- a/tools/testing/selftests/arm64/mte/check_user_mem.c
+++ b/tools/testing/selftests/arm64/mte/check_user_mem.c
@@ -1,8 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2020 ARM Limited
-
-#define _GNU_SOURCE
-
 #include <assert.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/arm64/pauth/pac.c b/tools/testing/selftests/arm64/pauth/pac.c
index b743daa772f5..b5205c2fc652 100644
--- a/tools/testing/selftests/arm64/pauth/pac.c
+++ b/tools/testing/selftests/arm64/pauth/pac.c
@@ -1,8 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2020 ARM Limited
-
-#define _GNU_SOURCE
-
 #include <sys/auxv.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-- 
2.45.0.118.g7fe29c98d7-goog


