Return-Path: <bpf+bounces-78667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD9ED16C46
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 07:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C59E300F691
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 06:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE401368267;
	Tue, 13 Jan 2026 06:10:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B973366DCA
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 06:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284643; cv=none; b=tlnYNb95OpfHrnjGWUo5y0+DK+U1tdKT4kx5sEZiSYYBP2FfQR8jBIEoDj/QIaj0hcW22hAE/zNOjaifs71Z/LF7PxmNSqULyVNGff03e7+C06urumTzRSoRCe4LO/RrTRkL49dBGwhd9nCh5EaruungOh9w31a8rgImQviqj+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284643; c=relaxed/simple;
	bh=RNI2lRSgUKTM9meRsbU0oSHHyangqOFD0Rg1GiGRLXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/BIOqvTHWmBbsBEuRkMaT1JgW3orD8wQUDf083GcUWhvVjCujdrTgBgkyXvAm6K7+oesotzBFg5BLhsbr7+U1t6AN9hJGmFwVE+3zw1vsj2UH4sopea2i/6IpIU23QxWZ6eKNCjMlbrITTZQfx3h6Nd9sf17+E0jwT+3bMxmV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 9A90518C4C61E; Mon, 12 Jan 2026 22:10:28 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: Fix sk_bypass_prot_mem failure with 64K page
Date: Mon, 12 Jan 2026 22:10:28 -0800
Message-ID: <20260113061028.3798326-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113061018.3797051-1-yonghong.song@linux.dev>
References: <20260113061018.3797051-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current selftest sk_bypass_prot_mem only supports 4K page.
When running with 64K page on arm64, the following failure happens:
  ...
  check_bypass:FAIL:no bypass unexpected no bypass: actual 3 <=3D expecte=
d 32
  ...
  #385/1   sk_bypass_prot_mem/TCP  :FAIL
  ...
  check_bypass:FAIL:no bypass unexpected no bypass: actual 4 <=3D expecte=
d 32
  ...
  #385/2   sk_bypass_prot_mem/UDP  :FAIL
  ...

Adding support to 64K page as well fixed the failure.

Cc: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/sk_bypass_prot_mem.c  | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_bypass_prot_mem.c =
b/tools/testing/selftests/bpf/prog_tests/sk_bypass_prot_mem.c
index e4940583924b..e2c867fd5244 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_bypass_prot_mem.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_bypass_prot_mem.c
@@ -5,9 +5,14 @@
 #include "sk_bypass_prot_mem.skel.h"
 #include "network_helpers.h"
=20
+#ifndef PAGE_SIZE
+#include <unistd.h>
+#define PAGE_SIZE getpagesize()
+#endif
+
 #define NR_PAGES	32
 #define NR_SOCKETS	2
-#define BUF_TOTAL	(NR_PAGES * 4096 / NR_SOCKETS)
+#define BUF_TOTAL	(NR_PAGES * PAGE_SIZE / NR_SOCKETS)
 #define BUF_SINGLE	1024
 #define NR_SEND		(BUF_TOTAL / BUF_SINGLE)
=20
--=20
2.47.3


