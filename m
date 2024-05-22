Return-Path: <bpf+bounces-30232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EA58CB7F9
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C52D284D25
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90377155726;
	Wed, 22 May 2024 01:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kFl9/zMw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE2E15533F
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339720; cv=none; b=fev+I4pTZECNJ719bn1CDQDxybiNPJuS8hn31BzuMXx3th0sjUZevOMe5GEhz+6Vzq9tlIxqCaLuESP64lALP9ZakmmyamiKD9W7J+onrvusMIap5xubkkM+XeJXxoNd4z4x2D/DkbZtvFvLSD+pCjcLYkx9oc8YSS7ICNn8YXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339720; c=relaxed/simple;
	bh=GPntLq7+5p05K4Kj80a1ofx+IxdVyo2sAkOefotHnTM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FXfzBg9earwEHw7RA0BfHRcCUynPP61NCFXGd3NEh+STE5pQ4Ff9CUFeuuBF0MmDvFYtT6kM8AUestA5Z8TigVyCn5vEbJF1/v4LUpRW3W1icfi3RgKlQJrCiaqwLFHkdaDssc1U0eVK1PEOYZTazVVfbpuI23yverDM8fZkGW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kFl9/zMw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ee13ebef37so135804435ad.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339717; x=1716944517; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CdhZH2VylrS+6EeGuf6ae6S+DzMPS8o3sFjSdgWRyqU=;
        b=kFl9/zMwn5EI7b/RVWPpEtdc+LAfDjM+BKyAI0BIOqU+xCr6lCAjQQtryha6e+jKpU
         5XGSpoaegMaFwNMVdY7PKKkRh+DOC26jvMqNZNLJS/pl0oPvVG35UOvkCzv7tFnJEvEc
         tacqLzavXTVhhFRu/IRbEl5QsE/qTm7GMpM+BFxtViA6S2qmIcTQPDIITDnC4+Hsnb+P
         jPWkSar0nVDKVGEAoKcLURcAIqqDqDOovZfoEFDcPXlvrNBLDHDCMKiJQYskh4L0MNea
         nCy1plRH7hpADoDx00SqcroPueS32Os7SbxgElU4IhKKoYfD0+pYdXmHz/kHiRyLuKqJ
         2N3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339717; x=1716944517;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdhZH2VylrS+6EeGuf6ae6S+DzMPS8o3sFjSdgWRyqU=;
        b=gqysGSDrWZ8UaOxYvrtql9+ClXdbiylVjrW9ntT4zNsa6Q/wtHwxjgWdnXGSEilQE2
         Q+CQpAuAwzGLpPVGHam+JcDv1oGwbGXfzqlUQtp7vGADrW7PBgrmDGKKAStggk2AA6UY
         1dxk/vjLheV11y0+KgNexKSyTTGcA6QpZYHPgc66uDQ0vM4jl4LEiqGgf0/PE/G49AzP
         5oJ/B9LOsKypcca8yrvM74cyKQgmf+reJfwq+mgHjLi2JMVERcDNJumbX38wurjp/miO
         fWM4dw5JPNRbsRxEl9nfznjtdqPL2yj0uHg46lA2fd46WDHMKYWAm06sU5kBmWwgjGrl
         O1BA==
X-Forwarded-Encrypted: i=1; AJvYcCWVRVwg4HpPgqIndNK9mj7VKUeq0q7Pjn8UiGvW+b5TCaqluwR4J/nkU4mac/gkgFd8hcdqTzIktrUMjfGUsRNDSfUp
X-Gm-Message-State: AOJu0YzO+/hld0w9ofmeAJHmPV882FmeBeHMh1xlnm+rusE1/L8wSS34
	9mIOWg9IQhYEez5xhgtU3vFLL/PmrANw4z9DHsWcWVlZscbwB0x50ol/Zszw1R/4BAZY14Hixn+
	dkg==
X-Google-Smtp-Source: AGHT+IFXkW29jWSmXKYdgVJioCSYV7fU9D+QDgsIm3BIsuSFmV/S8sHX1eOFRDsg9MXg5XjDONxLYS9KAdU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:ea0b:b0:1f2:fb7a:19ac with SMTP id
 d9443c01a7336-1f31c9e7df6mr65215ad.12.1716339716964; Tue, 21 May 2024
 18:01:56 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:35 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-50-edliaw@google.com>
Subject: [PATCH v5 49/68] selftests/riscv: Drop define _GNU_SOURCE
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
 tools/testing/selftests/riscv/hwprobe/cbo.c        | 1 -
 tools/testing/selftests/riscv/hwprobe/which-cpus.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
index a40541bb7c7d..4de6f63fc537 100644
--- a/tools/testing/selftests/riscv/hwprobe/cbo.c
+++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
@@ -5,7 +5,6 @@
  * Run with 'taskset -c <cpu-list> cbo' to only execute hwprobe on a
  * subset of cpus, as well as only executing the tests on those cpus.
  */
-#define _GNU_SOURCE
 #include <stdbool.h>
 #include <stdint.h>
 #include <string.h>
diff --git a/tools/testing/selftests/riscv/hwprobe/which-cpus.c b/tools/testing/selftests/riscv/hwprobe/which-cpus.c
index 82c121412dfc..c3f080861c06 100644
--- a/tools/testing/selftests/riscv/hwprobe/which-cpus.c
+++ b/tools/testing/selftests/riscv/hwprobe/which-cpus.c
@@ -5,7 +5,6 @@
  * Test the RISCV_HWPROBE_WHICH_CPUS flag of hwprobe. Also provides a command
  * line interface to get the cpu list for arbitrary hwprobe pairs.
  */
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-- 
2.45.1.288.g0e0cd299f1-goog


