Return-Path: <bpf+bounces-30249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43338CB851
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B64B282110
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8D715D5AE;
	Wed, 22 May 2024 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CSJPvDfm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EF215D5AD
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339763; cv=none; b=BF+0wjlyYpQhC4sOowI+VpndLYxTWVoW+Tw+1HxEnPMQs+/xjxVD8uFjafq5/IqOqOcdRorXfm5Fg22Sa3InDdnSVmn2ns+3tAn+h6TM4853tk+LMN0bEMv4bqNvwCfM47mepFCcZa7XNbgfwPlxpVeOW8WSWEPjNhiPIWDtb3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339763; c=relaxed/simple;
	bh=6uq+6nFiN+WYMciAtwfyDufHvmS4S3lOm//KRDv7Qhs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hZXZI6OROmrbLA+zttjLhmZEzDK/eVgGt10+YKopB5pkRpf6bZ30GvbiTt9tFBjNtsK9T9OVYYyDqSNpCGlIW7uGZx+KemXnBIjG+Z+pVVxIdBeZZdlquBQfxZYPJsq/xUa2YT/3IPL/FpeHPpZbuD+ND0NsYPtx/rNhTbQya3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CSJPvDfm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ecd9a80d84so3105255ad.0
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339761; x=1716944561; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7mo4/yLDmfOkTNt7Zkt8yFpoQggSa48jheWSJnXsenE=;
        b=CSJPvDfmqPW0596i+DwpVPs1BAZ83VZpLxZdLsytlnQs9j4K4X2Vcm+izE0xN+CGFj
         nqgJkIOZDqVIBZr4DLB9SzgYdbBWNUoIVkhK5Z87LaAlr5FmQvRNkk9xeCzYiZgWBpEC
         pGHv9s7nbh+kL0sxFqWLFQJGP2SKgsGZAtVqJmP2pN+WBvtOY63yIuKnGhRoKrNjFN3+
         poJRT4sIbHWnIbSrlFme+SprZCfJlT+AAlJN9cCr2VrUBWRSvsf/BZDlRSmwz0o28ENb
         BNchr4zD9v3WnazKIuvJ4RhsfH5nm8vN5ps3bSjrb11w+IsmepELwydYT/w6QCKBahd2
         WNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339761; x=1716944561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7mo4/yLDmfOkTNt7Zkt8yFpoQggSa48jheWSJnXsenE=;
        b=rgMPa67RTeDriphdRd0Z8CCwQMvETI9w656imID7EkvSq6lV40WDqp3uYxIT4Ea0QL
         yMJXXfMrcHeJY0u6mZ2IRVpXHg4f07eFqE/ltVv4u44SCurPdkvf4XtyCiw/IuLE/5Rk
         6S3PugW5TX+nob0rYybG8n08JCC8t1JVl9VEqwOGlTZv1ZRkH2BzrRdwOboI4oUL188X
         Jg3kJqiFRoQ07FyEjIS9okv/Bzhbx6Hsi7COTGMJGPBGRNco5is8Hq2KFPhB/eg7HkLN
         6clL86qgPuXboAiqxGCvkKx33MuEnP5koIB8l5Yp02Uh/NjtN1DJFujQhlCejO+gI4hy
         jLqw==
X-Forwarded-Encrypted: i=1; AJvYcCWoOm08HpOBUGo6ZGu9gTrPQxP5y6ofqLK7kKbyk86js/LO+KAo3zI29f3yfHDoUQR89wRprFEDA816unIjzhWtFhGB
X-Gm-Message-State: AOJu0Yyao3/q5IofEK+dc4MsMfDYlitESZiHom0ZTO7hmMskP/LOFmVk
	cpo8/HOTpRIx41FM1jWJ+ZRPhcEeLA/aJ4FD+qhcbjJSivY5HQt1dWJBx+V3yBdpB0k+tZJ6sWf
	Bhw==
X-Google-Smtp-Source: AGHT+IHvHptwu96UPU1jruYsJ05usROficf41w1ArAsId6Pnpj0UoVYTI+LNCGXzh+YwI4pYDWG0QxwbPfA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:d482:b0:1f3:c14:968b with SMTP id
 d9443c01a7336-1f31acfacffmr231515ad.2.1716339760811; Tue, 21 May 2024
 18:02:40 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:52 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-67-edliaw@google.com>
Subject: [PATCH v5 66/68] selftests/vDSO: Drop define _GNU_SOURCE
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
2.45.1.288.g0e0cd299f1-goog


