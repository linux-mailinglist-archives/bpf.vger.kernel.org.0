Return-Path: <bpf+bounces-76052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A6BCA4BC4
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 18:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7235A3044E06
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 17:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A176530ACE3;
	Thu,  4 Dec 2025 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC729Wfd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C9F304BB3
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865056; cv=none; b=sYHd4qoiWERRy3wBiUVTi6pfARKlBX2/zcyJTaYjcjeEsixMJxE5AuPnw1ZmKzNmaMKyQtlUmMeU0ld3IZG2LT7ZlOE7bBuAXsWJ48E3gBXkxdgkqmcvSXXFEhJFIPs05Ej1Q8Fg3kILOh+IDFJsi9ZwHkAgP7c5uAWvtdMx5J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865056; c=relaxed/simple;
	bh=gzLs8cHkNcBOmjzqsUvEBw+4jkBx9B1WlBta8JzQ6x0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VwpSUC1z/wbZ7wYR4JMvbT101k1KJdyiwwy3Oars5kbI+96K8/xhQsrdXpe/wn1dNszwYcv5yqNAfj3YMkSqPETuueG16HrwHWIfRSiyQcXHzgpLdGvx00pOxl8lRJ1ew9ZGUnDY5H5yBewrdrOc8kCLzrpVWE/JeJWVOAW5FU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JC729Wfd; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-343f35d0f99so973395a91.0
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 08:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865054; x=1765469854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2C4Shuc2pUkek0loEVubh36sMLFCuTDFArc/gXySHxU=;
        b=JC729Wfd5L9BDOJQZsDM4iSthWv4Tx/pqJWxdTLw4IwOrhIncFI+v9a8P7uvHL8QXV
         fx/pH22faCHHrtNQhGZCt8j03fMNeNSMiU1xVMFnX6soMlKYCDZZvSv37CICepe5G/pd
         YPLlECotE7FH9ZWfzQaiaRm5IcaUSaFIYGjnlYmm2lEmTRFwZ6OsF9wsrnEwQbE7tIzN
         rn3sdJW7TatcYxgXsIGtxgQK203OpQdnO7gTZ54oHZjgx45T3OCwauKy/UFIL0JdA/ES
         k3pDMoZJmdPvFxHUUYL+RnJXzEbS+BuEo8dA0FPKd3kUgp+v1fPwYH55DvNfzHGRn8Xf
         BdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865054; x=1765469854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2C4Shuc2pUkek0loEVubh36sMLFCuTDFArc/gXySHxU=;
        b=IXraYtiZtLqx701T0Y7pSLV/xwaDAWvfAbJiNfC+kD6MQlSi7BJLhzmcjuiKj68igD
         b4BJ7JypL1EaBWKs3ZwIGY6eSgn7oA4jfJwOo6cS6QCocD9A3o3pahCtgHLV2zs8/Ire
         nrYdfta4XTDRlkk+zT7Jg4Jf6W0u59PCI/lHFHcL9gNUCxCjAhvSZPExHtX1laae9knW
         f80BZ74pEJTsQByBzLGPNMrTC3y9JfmvCQFx/3huNrcUXiAMAn4va0utAjGSj5nG8I+O
         /LCFm2EbV9C4IBK+tpixXIGfKsOskKN1zVyLyHKJbM7/w7oY05rDrrgkp5WtXcFMFD+p
         DNNA==
X-Forwarded-Encrypted: i=1; AJvYcCXp8xy4d24NLzlaQyEu82WcIwghBJLC9WyOP0/8F22IOhYKoomrsROIAP13JoQMF7WXsIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmp8IWjwBOVCGF8T/wXIxsl4mMu7f++UemWy3iMfQNbOichhQ/
	GF5gXAP2aPdSmUU6LBsiaawdSR3S57cPOdjDCQdTO8GIRHOijh91jjdn
X-Gm-Gg: ASbGncsQyb2/REs5xwWpsOuknZvI6v4sHhrVoZZDL5ryAK/WUNq21ohnigZpraALAMK
	OhoQGhFHGpo/tUoYsYL3P8yqjlm90hrMdJccZ6UypIgh14V9rk+vRB+Gte8gWIUUsM7A8a3gFdq
	fyo++I3CEEIVadl/uy2N4mJODuVqmtfeOk63MZXsrYezmf60RCURXv/Y4zXBKRn3S/zMTZesd0g
	sMHgkJ/5kcIs9HrHBeDDZVTL0gUevp0HvgMF88eUcV2KKHVLx2ZTD6Gu8slAh98MGwT9RTDm0k1
	+/COf4TbCFsjrJFfpRqkQE2pMs1NsHPSx/r+vLM0gP0l1z2Kp5UPnwiDq/JfMRABi1Vr3TYBmKJ
	sSk+7nZv3dvs6d9+zAZ7c2FHJBmEU/vlHgSILm2psf8T7vBheLtAz8bRbeJcy0TSddkMHxqONFz
	KkSWqOftxSoQKRARAYd8jgUjoFFblZqlU6qw==
X-Google-Smtp-Source: AGHT+IGUb5OCyLlu/xRJZk4tuT9BSuBNLmXZkJmmtQJN4OxIZEiB2Z/OnHD/QTUXMM+QYl2sFQTNCQ==
X-Received: by 2002:a17:90b:2e46:b0:349:30b4:6365 with SMTP id 98e67ed59e1d1-34947f1afb6mr3587048a91.27.1764865053868;
        Thu, 04 Dec 2025 08:17:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494f38a27asm2278321a91.4.2025.12.04.08.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 00/13] selftests: Fix problems seen when building with -Werror
Date: Thu,  4 Dec 2025 08:17:14 -0800
Message-ID: <20251204161729.2448052-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes build errors observed when trying to build selftests
with -Werror.

----------------------------------------------------------------
Guenter Roeck (13):
      clone3: clone3_cap_checkpoint_restore: Fix build errors seen with -Werror
      selftests: ntsync: Fix build errors -seen with -Werror
      selftests/filesystems: fclog: Fix build errors seen with -Werror
      selftests/filesystems: file_stressor: Fix build error seen with -Werror
      selftests/filesystems: anon_inode_test: Fix build error seen with -Werror
      selftest: af_unix: Support compilers without flex-array-member-not-at-end support
      selftest/futex: Comment out test_futex_mpol
      selftests: net: netlink-dumps: Avoid uninitialized variable error
      selftests/seccomp: Fix build error seen with -Werror
      selftests: net: Work around build error seen with -Werror
      selftests/fs/mount-notify: Fix build failure seen with -Werror
      selftests/fs/mount-notify-ns: Fix build failures seen with -Werror
      selftests: net: tfo: Fix build error seen with -Werror

 tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c      | 4 ----
 tools/testing/selftests/drivers/ntsync/ntsync.c                     | 4 ++--
 tools/testing/selftests/filesystems/anon_inode_test.c               | 1 +
 tools/testing/selftests/filesystems/fclog.c                         | 1 +
 tools/testing/selftests/filesystems/file_stressor.c                 | 2 --
 .../testing/selftests/filesystems/mount-notify/mount-notify_test.c  | 3 ++-
 .../selftests/filesystems/mount-notify/mount-notify_test_ns.c       | 3 ++-
 tools/testing/selftests/futex/functional/futex_numa_mpol.c          | 2 ++
 tools/testing/selftests/net/af_unix/Makefile                        | 2 +-
 tools/testing/selftests/net/lib/ksft.h                              | 6 ++++--
 tools/testing/selftests/net/netlink-dumps.c                         | 2 +-
 tools/testing/selftests/net/tfo.c                                   | 3 ++-
 tools/testing/selftests/seccomp/seccomp_bpf.c                       | 3 ++-
 13 files changed, 20 insertions(+), 16 deletions(-)

