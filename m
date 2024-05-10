Return-Path: <bpf+bounces-29356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50DE8C1A99
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E3B1C21EEE
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF966E5FD;
	Fri, 10 May 2024 00:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wxlrpjd/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692D55E4B
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299795; cv=none; b=Tih7SGZja2b0ejWokHcihOk1PvNXTVeRTaBvybJ04EhVKGAAz/RFkZ9/6Id4kf6NIw0NJ8PawQObFSUbl6E7UB7Pnb6cGaQUW0uo7f5qVr2vuV8+gjahPSoMe8wz9ek0KRenrldMArejiFBCvDvJHtxT4UoQSK5HrhsqYHwfYoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299795; c=relaxed/simple;
	bh=WDtREi3NV1ph43HtRoTGL/PgxME/3JGpKxVhjvEJiaQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nnHs1w+5Yq5LPImT0K0AAzrsczUcM0F5bW1RhfQuw2ce0b2AlKqyTis+MCGkHSfG2HVNsET74IubHUHKlIPpNRYA5TFbeitigp1v6tFeWyxKTyLXV7h4du4ZOTli+Z2nBdb8Bsb7ojwrRnJxNtBpgeH4vPNcJGntCKNkqvnoGhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wxlrpjd/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b34facb83aso1424344a91.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299792; x=1715904592; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tuMq0VwTGU6ryY2Jy9N3vXpEbju3toV+EO4EgzSUctQ=;
        b=Wxlrpjd/pxC178N/VpQW/GkKbu6m4GewVaYJWlIwbo0jVuEMEp5P+C2xJdOw4PKRIy
         0noQgu6VY3G495/f8/dg/2kyQ9CZCKExHqyKZLJxHyJrQQWvY70sp0IzXgWlSAt2IskL
         esUMotttxMKUZDHb2myl64IPnywwRl19UhAXnrMNvb922LgC9xJjPdg+R4afPRqItsOP
         nniGUKCtzGGxpfCnrvoglpryfLfmX4egYXf+fbiZDnSy/pRsQpmNRK8I4vtOMMt16lmG
         LEoGvD3h+4SRtVrqjpy21oeL0fbI/FtUiKUulmLUVwDsCem6Qv6dfsRWt1dRuCKtiqxO
         NFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299792; x=1715904592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuMq0VwTGU6ryY2Jy9N3vXpEbju3toV+EO4EgzSUctQ=;
        b=tjgWKEVme9a1NoQS/Bxe/2+rxRStpnK55s9PTCi9AcHY+cXJ/Ha2wxFaDwXl4QNB1G
         2bOmaWcF30ICLa9A8OYt2HmmYScvHEm5LF8U/ztNGwLIv9WXmuHKuFJUUJic9WiqdefX
         YIXIETGC/pou8VdCEQseiBS6dcsUpX+b9+ATwdoPgwBu8Vziwdh0wMbsyJWcI+P86DJL
         go5Nk9QRpPSaSGi7vch01Y9vHQTFrkuPNtJAjijJth/7oYffQZvE3OpvNPmZIC4FaerH
         kMPlX2C0WY0LrVm4VGDGFGxygnj3eRF0kT9OoBNU5NeEhAuCjd/K7uq9uTpJKlUQSpGG
         8QGg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Jf/dEeK3NPPimndhu8GobSk9CbeukQTUdhsNWsvjdVVQze4CXFDzQ4PxA6hivmERnhOJgYR1sP+JFSrZueCa5o5F
X-Gm-Message-State: AOJu0YxzMv7KTJcWhRXo/t0DCNdAoqCe4Yu8R7cxtj/zVsRWcHOoDBEL
	4zbaiQMWdmFuMBv+lIFuuSJNr9apFumX6QW48cKcW3EGTxRy471MmlxyiRzg8oZXvEdzvoq4xgl
	k9Q==
X-Google-Smtp-Source: AGHT+IGy3rjskMzZhJoc6HJMFO9JT1FQP2T4mP9KVEwgoBctPBXhbpLR3qUquXuPkPY8i9uH3imRrzXSEyI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:a082:b0:2b3:c26d:4589 with SMTP id
 98e67ed59e1d1-2b6ccef6e35mr2868a91.6.1715299791671; Thu, 09 May 2024 17:09:51
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:33 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-17-edliaw@google.com>
Subject: [PATCH v4 16/66] selftests/filesystems: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
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
 tools/testing/selftests/filesystems/binderfs/binderfs_test.c   | 2 --
 tools/testing/selftests/filesystems/devpts_pts.c               | 1 -
 tools/testing/selftests/filesystems/dnotify_test.c             | 1 -
 tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c  | 2 --
 tools/testing/selftests/filesystems/eventfd/eventfd_test.c     | 2 --
 tools/testing/selftests/filesystems/fat/rename_exchange.c      | 2 --
 tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c    | 2 --
 tools/testing/selftests/filesystems/statmount/statmount_test.c | 3 ---
 8 files changed, 15 deletions(-)

diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 5f362c0fd890..fca693db1b09 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <pthread.h>
diff --git a/tools/testing/selftests/filesystems/devpts_pts.c b/tools/testing/selftests/filesystems/devpts_pts.c
index b1fc9b916ace..73766447eeb0 100644
--- a/tools/testing/selftests/filesystems/devpts_pts.c
+++ b/tools/testing/selftests/filesystems/devpts_pts.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
diff --git a/tools/testing/selftests/filesystems/dnotify_test.c b/tools/testing/selftests/filesystems/dnotify_test.c
index c0a9b2d3302d..05367a70b963 100644
--- a/tools/testing/selftests/filesystems/dnotify_test.c
+++ b/tools/testing/selftests/filesystems/dnotify_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE	/* needed to get the defines */
 #include <fcntl.h>	/* in glibc 2.2 this has the needed
 				   values defined */
 #include <signal.h>
diff --git a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
index 65ede506305c..9bc2ddad7e92 100644
--- a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
+++ b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <asm/unistd.h>
 #include <linux/time_types.h>
 #include <poll.h>
diff --git a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
index f142a137526c..17935f42fbc9 100644
--- a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
+++ b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <asm/unistd.h>
diff --git a/tools/testing/selftests/filesystems/fat/rename_exchange.c b/tools/testing/selftests/filesystems/fat/rename_exchange.c
index e488ad354fce..56cf3ad8640d 100644
--- a/tools/testing/selftests/filesystems/fat/rename_exchange.c
+++ b/tools/testing/selftests/filesystems/fat/rename_exchange.c
@@ -6,8 +6,6 @@
  * Copyright 2022 Red Hat Inc.
  * Author: Javier Martinez Canillas <javierm@redhat.com>
  */
-
-#define _GNU_SOURCE
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
index 759f86e7d263..b58a80bde95a 100644
--- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
+++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <inttypes.h>
 #include <unistd.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
index e6d7c4f1c85b..c8944effb780 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
@@ -1,7 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-
-#define _GNU_SOURCE
-
 #include <assert.h>
 #include <stddef.h>
 #include <stdint.h>
-- 
2.45.0.118.g7fe29c98d7-goog


