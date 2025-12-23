Return-Path: <bpf+bounces-77353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B5DCD85B6
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 08:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98308305D437
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 07:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2D730E855;
	Tue, 23 Dec 2025 07:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GggDd38O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u90Z0mYU"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C4530BBA0;
	Tue, 23 Dec 2025 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473462; cv=none; b=WpQEBKWMw3tyI1vFzfDfOrflqLE93bxt9Ox4EarAc6NzpNejTMzp0Y98KhopuBfzTIkXjsFCpkwT7B7fbprBXS8+s+g07BEmkwDqVFCENtE4ap+fIV41Dx7K2pB6kE4K945LBw+cEerc5VhPguee4w0Hycsv1ETfDvce/v39rJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473462; c=relaxed/simple;
	bh=JvThK3D0po6Go7rwk2+OL/2B8Ulbte9q+20HJXRZ7kw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GrLGlwvNWD1cDP2VaPjscgdq7bT+hWOPkFEsUdVQfS6wIRUUDlWG93SxEsCryP5Q2JLUXgvrzYT+hGAKp7sN216oxml5w/wSevyWnrK7ZlCiLjpc/zGl0e52Y67BXj6a2FoW+MDxWXb4GysDcOjAVkCmzJxRJ27jmwNmjGPoy2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GggDd38O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u90Z0mYU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766473459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hTn+nCaMtLNpZ9M4ZQw3UrVsBJeVi0MyHz1cx+b02SY=;
	b=GggDd38OxhzhjfSLAPm9m4DCbFOwre3cTY2fuxZTTjjIHkl5PGEgd8gKohFp8lI4V0wsHx
	8kfo9Z0GXUcM4NtqUiSRpkvkyldtGvHRhXNGLLLNPFfo9sxsle5quey3M/HoaMhMF07FTc
	9X7RekB7/o3FyB4alyZdcs2rH9v0qzWSpOz4e+2SSPRbmqWivg2FdmDxTycYk8ONmKOx1/
	CzKem85lEmd++nM2+oq8NUF8sqR43C6ALXIBCSllLDIeVzZ7H0ZB90y30dCU1F9zJAWnty
	9EuHjcZkTy4AfUmTiJWG3ktY997pLNkN4AsaMNZKBqTCcYjtCHt3q4ihZDD/yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766473459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hTn+nCaMtLNpZ9M4ZQw3UrVsBJeVi0MyHz1cx+b02SY=;
	b=u90Z0mYUrEf8PCGb1IDvcG/3i2uieUhFYzSnLxxUayTNYJSQTMaljANymhZuu4osGgN+bh
	8pDOE9E8VoDEY/BA==
Date: Tue, 23 Dec 2025 08:04:12 +0100
Subject: [PATCH 5/5] kbuild: uapi: drop dependency on CC_CAN_LINK
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251223-uapi-nostdinc-v1-5-d91545d794f7@linutronix.de>
References: <20251223-uapi-nostdinc-v1-0-d91545d794f7@linutronix.de>
In-Reply-To: <20251223-uapi-nostdinc-v1-0-d91545d794f7@linutronix.de>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Brian Cain <bcain@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766473456; l=1988;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=JvThK3D0po6Go7rwk2+OL/2B8Ulbte9q+20HJXRZ7kw=;
 b=GtixPB7n5P/Q1KtZNZscrAVFYfCRtRXEWGZstURVep+3cMTg6UVzi/tC2cpY+8XSad9oNfD6G
 4oLfl8346cBDsIMwjOfFyAlLW0Y6RaUdjB4UBh8mNNud3m4RBBrSSWZ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The header tests try to compile each header. Some UAPI headers depend on
libc headers so they need a full userspace toolchain to build. This
dependency is expressed in kconfig as a dependency on CC_CAN_LINK.
Many kernel builds do not satisfy CC_CAN_LINK as they only use a
minimal kernel (cross-) compiler. In those configurations the UAPI
headers are not tested at all.

However most UAPI headers do not even depend on any libc headers,
and such dependencies are undesired in any case. Also the static
analysis performed by headers_check.pl does not need CC_CAN_LINK.

Drop the hard dependency on CC_CAN_LINK and instead skip the affected
compilation step for exactly those headers which require libc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 init/Kconfig         | 2 +-
 usr/include/Makefile | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index fa79feb8fe57..4e7ae65683ee 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -247,7 +247,7 @@ config WERROR
 
 config UAPI_HEADER_TEST
 	bool "Compile test UAPI headers"
-	depends on HEADERS_INSTALL && CC_CAN_LINK
+	depends on HEADERS_INSTALL
 	help
 	  Compile test headers exported to user-space to ensure they are
 	  self-contained, i.e. compilable as standalone units.
diff --git a/usr/include/Makefile b/usr/include/Makefile
index fa01bcda21f5..6d86a53c6f0a 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -151,7 +151,8 @@ endif
 always-y := $(patsubst $(obj)/%.h,%.hdrtest, $(shell find $(obj) -name '*.h' 2>/dev/null))
 
 target-no-libc = $(filter-out $(uses-libc), $*.h)
-target-can-compile = $(filter-out $(no-header-test), $*.h)
+target-can-compile = $(and $(filter-out $(no-header-test), $*.h), \
+                           $(or $(CONFIG_CC_CAN_LINK), $(target-no-libc)))
 
 # Include the header twice to detect missing include guard.
 quiet_cmd_hdrtest = HDRTEST $<

-- 
2.52.0


