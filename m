Return-Path: <bpf+bounces-20432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A2F83E4D3
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 23:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A9DAB2272D
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 22:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAC6286B8;
	Fri, 26 Jan 2024 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obruB+jY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2C42869B
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306990; cv=none; b=pWak/AOJlaGamsi5UXNuQZH1WNbhtozc4H0QCbW9XMezpgKh6XlitcuSnQiCTBMaQ+H4jtbsXtuoZXA9ZAsEnGHm+KQK8ex/dyEsTvvmyQ6nyrSO4r1gq6H+SuNITNi5ee0yVOjFb+m0uG8IkjJ2fcN7V02LYw6ouK/QJtrjyoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306990; c=relaxed/simple;
	bh=xmbf1cMm5d+OMY5BSs9mse8466umokP5V6R+klGbJxE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=trFFZRiEeGHEzNUBB6vNzduvPMeadtPA6gC+v2ruepsru3v9RpBC6xYm1ajYTLOjem5jHqrZMjiwmMvpPhAf3ViGLIVApV9+q6rEOXsbiK/oP+niMpBf0/jf45T220jjMxlLEmr51aBWM6KiByT6Tj8S1i91ZZ/GhpPSHow7nmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obruB+jY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF099C433C7;
	Fri, 26 Jan 2024 22:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706306989;
	bh=xmbf1cMm5d+OMY5BSs9mse8466umokP5V6R+klGbJxE=;
	h=From:To:Cc:Subject:Date:From;
	b=obruB+jYPlqvaWbqZUbEZGhAlTc6TttNdxDw2k6Wv+S+hiGh9K7v8P96u8SRD9aQz
	 ynp1T4iAqsh/4PfD+ThjJ86WcGwnPHBhKmb22G5o5iYtyuTfWSXW4Ym1xg9g3pHtkP
	 p9TXUqe8pBkZfgwuQhBssBATJsN7BlqxkYAb/UUb+vdd1wtPA0MenwBHFqGuoQ6FMf
	 iFy4EPv12E1QQMR/fK9J9rdcF9qDupz5TjkWaRm5JwTv2uOlTDfDB62aFT5KPaWmTY
	 kxQolcMDDIhLcTAbXAe2vTq9SgaXzrwl8hWLpogwWEIgdR1Lf+bK5X7lp/8aPWG8YX
	 lLcU/CdVHVAfQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] libbpf: fix faccessat() usage on Android
Date: Fri, 26 Jan 2024 14:09:44 -0800
Message-Id: <20240126220944.2497665-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Android implementation of libc errors out with -EINVAL in faccessat() if
passed AT_EACCESS ([0]), this leads to ridiculous issue with libbpf
refusing to load /sys/kernel/btf/vmlinux on Androids ([1]). Fix by
detecting Android and redefining AT_EACCESS to 0, it's equivalent on
Android.

  [0] https://android.googlesource.com/platform/bionic/+/refs/heads/android13-release/libc/bionic/faccessat.cpp#50
  [1] https://github.com/libbpf/libbpf-bootstrap/issues/250#issuecomment-1911324250

Fixes: 6a4ab8869d0b ("libbpf: Fix the case of running as non-root with capabilities")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf_internal.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 930cc9616527..5b30f3b67a02 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -19,6 +19,20 @@
 #include <libelf.h>
 #include "relo_core.h"
 
+/* Android's libc doesn't support AT_EACCESS in faccessat() implementation
+ * ([0]), and just returns -EINVAL even if file exists and is accessible.
+ * See [1] for issues caused by this.
+ *
+ * So just redefine it to 0 on Android.
+ *
+ * [0] https://android.googlesource.com/platform/bionic/+/refs/heads/android13-release/libc/bionic/faccessat.cpp#50
+ * [1] https://github.com/libbpf/libbpf-bootstrap/issues/250#issuecomment-1911324250
+ */
+#ifdef __ANDROID__
+#undef AT_EACCESS
+#define AT_EACCESS 0
+#endif
+
 /* make sure libbpf doesn't use kernel-only integer typedefs */
 #pragma GCC poison u8 u16 u32 u64 s8 s16 s32 s64
 
-- 
2.34.1


