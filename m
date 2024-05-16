Return-Path: <bpf+bounces-29813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 795748C6F8F
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 02:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF8A1F22761
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 00:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5C51366;
	Thu, 16 May 2024 00:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXzrA39B"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B810E6;
	Thu, 16 May 2024 00:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715819735; cv=none; b=tShZ2MrUtfBml5qWU55l2GO4svsjjzTS2TiUBEhylYoIx+GbQZOg9KWWi4ETePGO3Dm+v9JNorzhFUsjcGkSh/HG9ccOtCdmIrUZSTdoXgEn8BLwAesoSaNJPYsYDlH5wVXr+X7LIGGSqfpxz1fQ1YVbEtOF6mUgSeLBnqmk2AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715819735; c=relaxed/simple;
	bh=K+lADN8+8te0U6GGFL5Z7aSuGApQDoMThtNo4JVVGeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fW01ENifL5qulFqBt9/H9ePBfwhAXBYRW+IcD96PgCCbBdmCnUNZZ7XRPjErRx9TwhOwhQGmdInz7yUCm0ut0riQkLXoImbTVMqSNo/Tscd8bYWbbpv839XQscjnG5h94c634RllIa8qUcHrCqK9QC4j8D8nexlqk6lNrBgmiEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXzrA39B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED30C116B1;
	Thu, 16 May 2024 00:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715819735;
	bh=K+lADN8+8te0U6GGFL5Z7aSuGApQDoMThtNo4JVVGeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pXzrA39BYoDUcBdwhe9qkMo9gvbb0vIcNx8wamVUjn7a+YDOXBkkMIZi2SNoa+FB/
	 VK+3H1LEdxs9w9SEx4qLES+dTdWHEenEyinYeJJegN+fv6Std9yg5HiztGBP6el+01
	 dptbvt1cwBuA+vWcoQ75YgGvxZj23+vdN3oaVhux8YZwtjlWITw0FCBPIEIqcVqGf6
	 mwcsbV40id683Fur8cABEGIP5ZHVXVD00kXRGM7/F3XRyp7fPY32+mM/aP1AG7rMIw
	 x1Fgbhe34rIW+mbupB1+gqEYnjFaiDiTgldRECd91PZvIJ4/csmx8FytNSPhGCS3Dn
	 FMp95dJZ81HQw==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	andrii@kernel.org,
	keescook@chromium.org,
	daniel@iogearbox.net,
	renauld@google.com,
	revest@chromium.org,
	song@kernel.org,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH v12 1/5] kernel: Add helper macros for loop unrolling
Date: Thu, 16 May 2024 02:35:20 +0200
Message-ID: <20240516003524.143243-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240516003524.143243-1-kpsingh@kernel.org>
References: <20240516003524.143243-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This helps in easily initializing blocks of code (e.g. static calls and
keys).

UNROLL(N, MACRO, __VA_ARGS__) calls MACRO N times with the first
argument as the index of the iteration. This allows string pasting to
create unique tokens for variable names, function calls etc.

As an example:

	#include <linux/unroll.h>

	#define MACRO(N, a, b)            \
		int add_##N(int a, int b) \
		{                         \
			return a + b + N; \
		}

	UNROLL(2, MACRO, x, y)

expands to:

	int add_0(int x, int y)
	{
		return x + y + 0;
	}

	int add_1(int x, int y)
	{
		return x + y + 1;
	}

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/unroll.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 include/linux/unroll.h

diff --git a/include/linux/unroll.h b/include/linux/unroll.h
new file mode 100644
index 000000000000..d42fd6366373
--- /dev/null
+++ b/include/linux/unroll.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2023 Google LLC.
+ */
+
+#ifndef __UNROLL_H
+#define __UNROLL_H
+
+#include <linux/args.h>
+
+#define UNROLL(N, MACRO, args...) CONCATENATE(__UNROLL_, N)(MACRO, args)
+
+#define __UNROLL_0(MACRO, args...)
+#define __UNROLL_1(MACRO, args...)  __UNROLL_0(MACRO, args)  MACRO(0, args)
+#define __UNROLL_2(MACRO, args...)  __UNROLL_1(MACRO, args)  MACRO(1, args)
+#define __UNROLL_3(MACRO, args...)  __UNROLL_2(MACRO, args)  MACRO(2, args)
+#define __UNROLL_4(MACRO, args...)  __UNROLL_3(MACRO, args)  MACRO(3, args)
+#define __UNROLL_5(MACRO, args...)  __UNROLL_4(MACRO, args)  MACRO(4, args)
+#define __UNROLL_6(MACRO, args...)  __UNROLL_5(MACRO, args)  MACRO(5, args)
+#define __UNROLL_7(MACRO, args...)  __UNROLL_6(MACRO, args)  MACRO(6, args)
+#define __UNROLL_8(MACRO, args...)  __UNROLL_7(MACRO, args)  MACRO(7, args)
+#define __UNROLL_9(MACRO, args...)  __UNROLL_8(MACRO, args)  MACRO(8, args)
+#define __UNROLL_10(MACRO, args...) __UNROLL_9(MACRO, args)  MACRO(9, args)
+#define __UNROLL_11(MACRO, args...) __UNROLL_10(MACRO, args) MACRO(10, args)
+#define __UNROLL_12(MACRO, args...) __UNROLL_11(MACRO, args) MACRO(11, args)
+#define __UNROLL_13(MACRO, args...) __UNROLL_12(MACRO, args) MACRO(12, args)
+#define __UNROLL_14(MACRO, args...) __UNROLL_13(MACRO, args) MACRO(13, args)
+#define __UNROLL_15(MACRO, args...) __UNROLL_14(MACRO, args) MACRO(14, args)
+#define __UNROLL_16(MACRO, args...) __UNROLL_15(MACRO, args) MACRO(15, args)
+#define __UNROLL_17(MACRO, args...) __UNROLL_16(MACRO, args) MACRO(16, args)
+#define __UNROLL_18(MACRO, args...) __UNROLL_17(MACRO, args) MACRO(17, args)
+#define __UNROLL_19(MACRO, args...) __UNROLL_18(MACRO, args) MACRO(18, args)
+#define __UNROLL_20(MACRO, args...) __UNROLL_19(MACRO, args) MACRO(19, args)
+
+#endif /* __UNROLL_H */
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


