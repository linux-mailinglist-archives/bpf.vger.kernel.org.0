Return-Path: <bpf+bounces-29369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B93388C1AD6
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685F11F2471F
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2AC130E35;
	Fri, 10 May 2024 00:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U5fH2WnU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01FD130A5C
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299823; cv=none; b=h6AV4DBjMQSSkYlBbctc5TrAdVhAkATj5bxiLDgNyCPsomzsjPucEnqOITLTnJLohvWJdvJ2uc33C4DH6jP9VBmCyOeffD7FYtFUMtKWp4vJxkZTwQADTvldZmjP3dYXcUFoc6+VGLikCJEZMS4TZKYI0o7ld8XU2q8S6ph1+bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299823; c=relaxed/simple;
	bh=WSbmL0LnuDKSdtiQc6/wE0rgYnIRiaY1PmMLEAON1gc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CJVLKDtbyK47pl+DvaaIsQe9P+0rCYxdBoV5W8X/XioeLwkK1QQ0TYDz8fUVbIAqPQWwONBFg3IVvkce5yYSbxze+H2wPioVpl0XdxcrEK9z67BtoBfckEJRL8HQYlfUpcNzwNTVDgsHWNms1U0fOHVX0rZM0KELkdngTN+Y0tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U5fH2WnU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be5d44307so22542967b3.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299821; x=1715904621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CIHvn5ASgOV//V6BNzY0OrviieFVRwnd5gLwyJxh1+U=;
        b=U5fH2WnUq06ltRxs1Ir8ZSipfeb5k5NmAGWtW+q0tA3x43RiaFctL50LH53hqL3zAZ
         ddqhMBnZ02dIPYF+8jpj15ZjP7z3vD9er/W8v5+ymGPR4uGPWjwKRyAEY10bpIKl0LOX
         W9jQ3d6c50PtnLNlJ4TuMQAE6SYozuDppx96TlDhaOxci/4zHmsmWr8yolG0Q0b6aoNY
         86kF/Pd1/pyLYLA3pUR8x0g1qbLS3/eDEp+nXnZBvjUjo5squnLRJWvCMLG2TXWJd044
         YfemPbJiI6HTTEW/xVsIhMcCpXebgU5roVOjTGUVJ3EEdF2g2Ji1rRN8/NOFxGM12A6u
         ulaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299821; x=1715904621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIHvn5ASgOV//V6BNzY0OrviieFVRwnd5gLwyJxh1+U=;
        b=AKD3XEYxPjGkO7U3fi8JWTQer4Jz+4uDt4gTC2rA9OJLOHF0AFVi8Wqjdz67s9CVL9
         eeZ76wyir+Bu0X8vdBxhNo9Dsi6JjatVSnzKrNtJyUtxtFRALrQ/PVxrlf26d1Vm0dJI
         ldlfUOsAfvEZ8zLs745+59AnoK61bQc1Cbrv70eqk7ZxEC78zk7D4OCXRMZEshUEaR1g
         Rfsa5avSPjWwk/8DBcQzJj3ejFQ7cMjim0siq8dK9bi9j59f3bwreyKXVNJE8HUHVs7M
         BEjkgJHFivz9AUkffA8ZTJM24wJissDDvtvnQDh3W1FhdxGyMb1UsNzVvo7uys4g2jGr
         6/zw==
X-Forwarded-Encrypted: i=1; AJvYcCU3f6ZDY5fu1XsTFcZIxsW6LbCwzUZRtGS6RPuVaHRvXSuMFefaRNPbayUBk0jdgrLlKQpk2fiuOrKJLHCLb0zYX+78
X-Gm-Message-State: AOJu0YwT5mxTf5HvdCfAmtwNa2QgQg0R+zX23JpkFiXhSQkYemxygwHZ
	6NRPzAEayZfO2pbaXU/izKpU/51PrBdaiY6tbZZvJF4cfSFVpeWuFTno2/TQgPKd/fbRSBj+v0U
	axA==
X-Google-Smtp-Source: AGHT+IEN/ClfY6d0zLv4bo9ANzz+JtSyd/QLYeBdMlNaP9/cMcvp47wQjGpGOEr+YL62OUgs3v0T3C2jYqM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:4b0e:b0:61d:4701:5e65 with SMTP id
 00721157ae682-622aff90344mr2703587b3.2.1715299821016; Thu, 09 May 2024
 17:10:21 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:45 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-29-edliaw@google.com>
Subject: [PATCH v4 28/66] selftests/memfd: Drop define _GNU_SOURCE
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
 tools/testing/selftests/memfd/common.c     | 1 -
 tools/testing/selftests/memfd/fuse_test.c  | 2 --
 tools/testing/selftests/memfd/memfd_test.c | 1 -
 3 files changed, 4 deletions(-)

diff --git a/tools/testing/selftests/memfd/common.c b/tools/testing/selftests/memfd/common.c
index 8eb3d75f6e60..879d4f4c66fa 100644
--- a/tools/testing/selftests/memfd/common.c
+++ b/tools/testing/selftests/memfd/common.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
 #include <stdio.h>
diff --git a/tools/testing/selftests/memfd/fuse_test.c b/tools/testing/selftests/memfd/fuse_test.c
index dbc171a3806d..e35c6909f0bb 100644
--- a/tools/testing/selftests/memfd/fuse_test.c
+++ b/tools/testing/selftests/memfd/fuse_test.c
@@ -12,8 +12,6 @@
  * the read() syscall with our memory-mapped memfd object as receive buffer to
  * force the kernel to write into our memfd object.
  */
-
-#define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
 #include <errno.h>
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 95af2d78fd31..ee019b57bb98 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog


