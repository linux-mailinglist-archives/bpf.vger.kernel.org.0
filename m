Return-Path: <bpf+bounces-29301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE198C1757
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F86286439
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BC085620;
	Thu,  9 May 2024 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2d4LsmW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EE884FD2;
	Thu,  9 May 2024 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285671; cv=none; b=j5L/xx1BZCGm8a6GxS+WKVgVL4nAngJSqEN3TgfMkvtB3wSlViNBZK2VlRlPh+DCqf4gpke80hPEcWSbxDGquGpG6pMRc34DgqAHEmVVvIqb0spvTiXQ2Hy6QoVmd6sscfWvij0ZLUH8eJuYFdes6AEAKoGToYTkWdqC3hJ5BbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285671; c=relaxed/simple;
	bh=u9VWzyeOIqRiIKKJTzfTAo2aXaYZLbw7r/2i56abYhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6Bn1n02O0eHLKOU/cP8Xrig+OxxHtieZ67TBzu9jfGqXF4alpJSr83gcGRbdLyb3Iz7MjSfZw1qbOrjUpgdVXbtEkzKl0U1LvSowY2iD4H8NpF30six675+qqSb5qNfoomoORhwAUhZGnTNkjg1EgQUmMARNO9miVb9lLMNiDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2d4LsmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489FFC2BD11;
	Thu,  9 May 2024 20:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715285670;
	bh=u9VWzyeOIqRiIKKJTzfTAo2aXaYZLbw7r/2i56abYhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I2d4LsmWkcXkBR06rkvigPynNppKBbyYj5U/rnKwGklAyWkG5F1BIUkmf8MT5IziA
	 7O9TeXf3fFvbxOwDWe3p5wlYWzu3PgdpH4eUKN2r6YJYJ4FnkleV20eqBIK6xvRPEQ
	 PiQSyeDUV4jNmFh/M/2ZRDY6xXoYGHKlWo7y48xn+eATmLx7UswNU8254gjt+L3+uV
	 KQMwOdmgSjoNsunb/auliojKojKKAF7ibO9QO/ddhnaivLpu7ZPPHVBA/OhTi4DNYb
	 zznJ5RBV08X50PPDyiH3Bm1VvhQWTNeOOMTR9EM1j3p4pSbH6fOu2nC5Tq2fNVIoWz
	 DfMCn8z3Z6Seg==
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
Subject: [PATCH v11 1/5] kernel: Add helper macros for loop unrolling
Date: Thu,  9 May 2024 22:14:17 +0200
Message-ID: <20240509201421.905965-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
In-Reply-To: <20240509201421.905965-1-kpsingh@kernel.org>
References: <20240509201421.905965-1-kpsingh@kernel.org>
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
2.45.0.118.g7fe29c98d7-goog


