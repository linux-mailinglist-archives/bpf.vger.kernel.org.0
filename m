Return-Path: <bpf+bounces-29349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0522A8C1A75
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689121F21C94
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D984AECB;
	Fri, 10 May 2024 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U198Oimm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8842D481D7
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299776; cv=none; b=YC49Ry4q3b4dDUAudefvjl89wNAdAdbVAHnU9zOegTE+rCxSXc8kBEC4UzgGO3f7jxiuK+53rjC3M3pHNLlsrd1RNmf+g6cUUg8DgTZP1Usj25GW0ljkBcm6U0UyjigJxNtZlf7jxsS+nElXEg3Al5okLzD11K/M1oZU7dvn0u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299776; c=relaxed/simple;
	bh=YVixhmZhRjWn1UW1/nLeC3BNMDVFeI4H6J07JcP3lQI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BPfisj2jwY/CWJpJ9PDewc4blKfOC551Kl8/gtLuVYIcPc8zZitvL/L4ZLntqS0ZCLX1Wcsaa9iLOq9vBw82p0nctxOFjHKjikOvsqxQ0yuvP2rhroHLihjLZeGQdTyPFBXWb3/SzoCMj1+DslwmW092+WDhH4zQyiebkdurzKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U198Oimm; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f454878580so1370943b3a.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299774; x=1715904574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PW3mfjkgd+MZlh3nBATuOvH+NDY42sIa+VAHDQCo4gg=;
        b=U198OimmtKWlCUAo+vQQpwjg+nNJNYdumRKta3qPFf0VQbl/ovFKgaCbN6GR9Zi9Vo
         LsYfKw0TlWBVc9Uk5ehy9VaGKsacw1q7fN5ezRldOJtyfpSyUierBRqNBrchPj/PHCzA
         05hkSzYzgAiNcqAHc2qIgqRO6jdSeBWrfZ0esti4GYUiYaIFvhsElSgd4H5Staqw5xoz
         F6N6jQ57J606nlHiuagf42V86Nuc9MpZOX3PH82tbpQxvlE/Qd6+I/6jvMCiGqfcMz8f
         yneh5z4xIqpC4muPbyDFT8hP53+wjft+zpQgYj5TL3G0FdGq0q8L//vhjf5YyOCP713x
         ZvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299774; x=1715904574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PW3mfjkgd+MZlh3nBATuOvH+NDY42sIa+VAHDQCo4gg=;
        b=V1U9AOI2K32+if7FZBa4plYy41NVZdpUtr81fNc7sPWsDfXQNL4MzR3t7a4egMjVVo
         67z/yXvS/UyzGG3sv2WdJaMpGJwuv2FdrQjHj6hkgWoCYl69d5H5mtEiwEvgxYmajVoC
         0tAH8f7NH6M00U4oV+7MmWGi8B35ic6DSFQzY17gRqNA1NcjsokBurP6EcB+3pzW/63M
         vns6YkGF836faOMKcaNRE7CpJnSF9lFBL1Arz74c1OCEooZRHvcwMI+O/mmzEQpzc/8V
         Af+45o868vxN8oLatqlEnIbk8UTrAe2hbHhqvNCEA6NRssX0NqWpdXOiUVcur1rlIzA0
         JW/A==
X-Forwarded-Encrypted: i=1; AJvYcCWI0WJFmmMmZtC/8Q/4Z3B8Bbjn+5nFjn8l5ziy9/K6Z0eycDyTATLgzV2zh2cbF7NfnDqAGNNmOia/9vO7Sxk+jgrS
X-Gm-Message-State: AOJu0Yzwi5B/gWxCpSkhd4Dwy4coZAPYvn01DtwWDgnxw6MnYGMv54zw
	znOxd7vwjgLCnlo3dgCwxfS46AVBWrtZf7FWWMjEkxbeGr7i4FiVTOh9TwDVR94wQBf7nGJc8l1
	10Q==
X-Google-Smtp-Source: AGHT+IG+56tzsbyva1ZUQtPuRI+DlskjPnyTRIt8RkIrDnkpdAUoEV1Ksd4/O0D6pcKIPC/4JuC4Gkgv66o=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3a0f:b0:6ea:88cd:67e9 with SMTP id
 d2e1a72fcca58-6f4e0376006mr68314b3a.4.1715299773958; Thu, 09 May 2024
 17:09:33 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:26 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-10-edliaw@google.com>
Subject: [PATCH v4 09/66] selftests/clone3: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/clone3/clone3.c                        | 2 --
 tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c | 2 --
 tools/testing/selftests/clone3/clone3_clear_sighand.c          | 2 --
 tools/testing/selftests/clone3/clone3_selftests.h              | 1 -
 tools/testing/selftests/clone3/clone3_set_tid.c                | 2 --
 5 files changed, 9 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index e61f07973ce5..ce2c149dab46 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Based on Christian Brauner's clone3() example */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <inttypes.h>
 #include <linux/types.h>
diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
index 31b56d625655..bb99ea20f7d5 100644
--- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
+++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
@@ -7,8 +7,6 @@
  */
 
 /* capabilities related code based on selftests/bpf/test_verifier.c */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <linux/types.h>
 #include <linux/sched.h>
diff --git a/tools/testing/selftests/clone3/clone3_clear_sighand.c b/tools/testing/selftests/clone3/clone3_clear_sighand.c
index ce0426786828..8ee24da7aea8 100644
--- a/tools/testing/selftests/clone3/clone3_clear_sighand.c
+++ b/tools/testing/selftests/clone3/clone3_clear_sighand.c
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <sched.h>
 #include <signal.h>
diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index 3d2663fe50ba..172e19d5515f 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -3,7 +3,6 @@
 #ifndef _CLONE3_SELFTESTS_H
 #define _CLONE3_SELFTESTS_H
 
-#define _GNU_SOURCE
 #include <sched.h>
 #include <linux/sched.h>
 #include <linux/types.h>
diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index bfb0da2b4fdd..a6df528341bb 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -5,8 +5,6 @@
  * These tests are assuming to be running in the host's
  * PID namespace.
  */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <linux/types.h>
 #include <linux/sched.h>
-- 
2.45.0.118.g7fe29c98d7-goog


