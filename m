Return-Path: <bpf+bounces-29342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEF58C1A50
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BF36B2167E
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF9517548;
	Fri, 10 May 2024 00:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZltmngK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D10EAF1
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299748; cv=none; b=W5Hs3gdH4Q3ZecxGPNdWLMlfkeVjNCPJimNlXTQmV0ILKpGpFmuf6wShiUmuxTdoQfAgoI8uUIN/NIaSk+tSAVQ0ioR54lPr3zTP9nncTFVQ1LxzZiGw+53gEJKjw9AitzPh4MASC7S35cKGR2XTVO9IT/k1Ti6z0TMHp5CTZw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299748; c=relaxed/simple;
	bh=yFeGaq2CXG4DeBF3o2h2e5sDZVCCgYUHacvCQoyK0W4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XOV/XpIyJ64wZOOdIb71qJ34DQitSYSJVMb35tG2Q5D/kqnSz0nvnjKXD1eek+pJ3r6WAXdQdUE+6WrcINqzqEh2l3eqkN5uOXpjHGhRVea8w3bz0S63mnEU978FLglat8Hh6/CeOci0egNjIqSTotMb5dj0/SlrTaY640KnzCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZltmngK; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5c670f70a37so1211998a12.2
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299746; x=1715904546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tXggadKKCK6MVIJRJtEM2QQicrU97LLqONZv8Oqcmks=;
        b=AZltmngKUK0RNmdzuxPomwNa9pY7ILNP54SkZAzhQuIa7lNqJOlhHgSIX5N2iTlRmJ
         HmZsfH2BTLb/U1+4uU5ha2qzHBh+Ry8wMGnbgXWzUAtkKqkxATwgQvnSLqQgK2ZgD6eJ
         1uZKT3hrhDxq4r4AdlnPV6P0nt6pMK3EdCNi636RWVE6gNIvNaKDiGPs1sdiWJSDgRzs
         6kWbKjzhWmZhW73eioQalWx1rreWrqTG5DhVJ9atQEjrKeMwVNDOziU8xVj/GIAm2IIa
         haooh9/Ly9bAU1bZjc1O25Hli7VR6VyGT9h093HEVpP2kUiGZgj0v6XqbNJEwUXmHDTW
         7gYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299746; x=1715904546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXggadKKCK6MVIJRJtEM2QQicrU97LLqONZv8Oqcmks=;
        b=j2sPQM48zr/cZ+gV8HcrtsypWWTe2u3/82b/ILl8B6NavqgOebzhXzCYys+Ec062ps
         CnvJgTbm+LGV45aeNBrCrmHslOtXjK1I4dwsc88En4i/QlAG6baWyh9R7zljQUTxPO7l
         Aei5skNgcG2Qk7ywb5G/2cV8st1uLpHTp1Q3VGojFbrbcVrau5gdYXVWnuswp6UWqTzZ
         /Z0D8JRkXn4jjDn7kqWSZu6dSDXGRDmqFa0UZogxsxTPbRDQE4ZwOr4ljAGR5Rzeu/Wh
         aQ+Yv1pPU8EvWm1ousQCTyPHWYmUrGGef7bL/XKR8Ep9pRVW0lTJKCf4zHDl6QL0e8Sq
         oPrw==
X-Forwarded-Encrypted: i=1; AJvYcCU/qa8TUU1AcUwPygE3HbrbbFJMUUpm9FHoO/Da0H2lLWFQUEbl3iiG/Fs+mOGBOegMf/MCSELREyBDTyclQbQcbBY6
X-Gm-Message-State: AOJu0YxtH6cAIq3rGabdMFZjpRV2tC0ESmWpRNJbGnlyR+KX9MLEz01C
	RFU7H5pjvDcyF2x7g74yj/ND6Y2A/e9AJ4F6wI8AHxpjslWZa/OenMV03cfbmaAE1sC955ZIxJR
	Ndw==
X-Google-Smtp-Source: AGHT+IH/4J8CPlJQivHdZD4ORSDr8VuDv1sGosfNXuvMsaU3Mx5nF/LYxoOqEnJxYZlCRSOl/f7n75EPBvs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:6f0e:0:b0:5ff:bf83:21d7 with SMTP id
 41be03b00d2f7-637416535a9mr2330a12.8.1715299745871; Thu, 09 May 2024 17:09:05
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:19 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-3-edliaw@google.com>
Subject: [PATCH v4 02/66] selftests/arm64: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

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


