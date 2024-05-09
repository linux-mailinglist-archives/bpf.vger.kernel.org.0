Return-Path: <bpf+bounces-29272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FD48C16B6
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86B828C3BB
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9DD13DDD4;
	Thu,  9 May 2024 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zZ3G/l5Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBB013DDD3
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284973; cv=none; b=dx14sFxwdPR+WQKCWn9ph/V7UONYAvXkWTI+YtnZ64Z3RbnsUmsv9RZupWB1r7twnhYwWIMzIsaoA6lstFPWHMNBI1YJmC4ztCIN/zqiLPEzCnorZHtLhSFkOCmRPXR16wWTMU5y7g3/c4NDmbs17yeuIXOvXzy9rvj35qmFfFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284973; c=relaxed/simple;
	bh=Gk9O9KznRK2sS7j8Er9nsL5OsozcdlefoHZ3QPUhY2g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dzfeDErZlqWzuGrHnJS6Vjn39v48lbOybfKX+L4sPM9D54auQrBpfxdcXNXp3JSSis1ApM/25FomfThnXRz+LQ1Z6yic1PaSqJyAyGAxL/8N/I0NxE6t7SMhL/jf2Njey8HqYZdgSmQgCZtHTmc/qG/88dfXHaiX/K5qnc+/BHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zZ3G/l5Z; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f46acb3537so916889b3a.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284971; x=1715889771; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OdNEpQ1G1MITOV+6oevaHyGJgkLn2dsRDWPkXuUTfgQ=;
        b=zZ3G/l5Z/Iw4gnqIee/8BQWzwZ2jPeX3yAFl+xlJd+hatszWGv4lmJ6Ja9BtrGXIyp
         XrplJvhIy2anfan8137Vq1r0WvHbKh9HR6+MtaaSmuZeEnY86JXTsjFZyR74GqRXzrx7
         2JtTkDhLZZBXAEp+jbpyrKL/1pFf8rdAF62bIQvccyqz5PMiuiktn2QWyduxKqOWdOco
         6Sq9Ioiek0ZxMc3nAabdy+Zjh48QlaPe49lrlqgu+OoiHo8v9mZX5W102oxebAOglJla
         dKb7GLw66S5l8Z/8ZYBMplo8SrzWYIA5jeQDdPvhhnckewVTEphtNXSqA28a4ljvp1/e
         06Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284971; x=1715889771;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OdNEpQ1G1MITOV+6oevaHyGJgkLn2dsRDWPkXuUTfgQ=;
        b=JemPub2xnp4bjGjgG9JoU90OaWkrVAvVN2SR7zShC969WAfKZ16YWcNTlvALtwQWrw
         adTwUnNBlrVwvc37MDuIxK1lOSSdZIK2JGaxZfuC8j+Sl8h1IInopYN1PH1X0CEAyaWa
         kk6LkYbU3Aq3WxzJ/Sinqb5xckM4zfXJWuDRbYJqa/m9kVbURp17vkt07YVETqN1g9bE
         nMZrUmkxXlDpAZ3BqifUguv96grfyLlWJKjoxQGhUlqXqXdFL1uBa9mEgNJNx8UYUWPa
         5jr1NMwEYtib9zAk78bsVsq/V4aUuCEOHpsnMRu+N6f7WESukO/c4wyl+vPdQ4snMvBt
         jz5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6nnQd0Lz0hKQD7pa64VssNlkjiqFjuI9TehjD7CDjLqmSYa0iVnksgHoVKenpmLGchr1gcVnSKQrq0ZmrSPyakiln
X-Gm-Message-State: AOJu0Yy+RazpO1OKO6hY4ut0WpMSt2juxR6DpU7IdCRsW/stG/0NkXiN
	7LdT8JE6yHyj5UPJ73K0aI+4QgIJpeeaBlCrsLg+kMdnwuYEfRD8hYkF1zBO1dD1Rhxi56SXNsi
	GBQ==
X-Google-Smtp-Source: AGHT+IGFUaZkpJJch5RJqd8VEYWv40cir4R81AsilEen6q5Sb/HjCesG1cHRjqEpB4w+v8rVE142bFNevYU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3c83:b0:6ec:f400:95a7 with SMTP id
 d2e1a72fcca58-6f4df44d0e5mr44259b3a.3.1715284970758; Thu, 09 May 2024
 13:02:50 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:34 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-43-edliaw@google.com>
Subject: [PATCH v3 42/68] selftests/perf_events: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
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
2.45.0.118.g7fe29c98d7-goog


