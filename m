Return-Path: <bpf+bounces-34317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6567792C6DE
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 02:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A061C22410
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 00:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B9E15CB;
	Wed, 10 Jul 2024 00:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImhkUPoM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BA410FF;
	Wed, 10 Jul 2024 00:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720569931; cv=none; b=eUqVNFLm4EouUMwc/oO1PABr+dBNJ/IlD9zWIeRLGLWQJbXktlC0th7ifiqe3mFsHlH9lqS551RoIfo7TkGtA/5sa3j8iFC0LJupRWNcIU1h67IPs41lx6P8ZE3++fGTBN6oaFg3M75MgVbtDcOAzDYF9cDdISJxYC9ULsPZhr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720569931; c=relaxed/simple;
	bh=hzkTRNL0yH8hJQz0aQmeB/BDH18/T05HKiqAEZXYhFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TN4Y4N96nkzXTspYYVAPL40qa4XmtfbWqkKBRsTOiJV4d4grJCW8N6VgQhtepixahPEzg+HVauJ0Aq3jBCkXlbZWsYPC4PDqaM9ADw/bg13naoGnojGUoKWufZiWmrN0ddtAPdt9rTDY9sTnNxCY5YiGZv5JFUAaiPkLgilxPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImhkUPoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51274C32786;
	Wed, 10 Jul 2024 00:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720569931;
	bh=hzkTRNL0yH8hJQz0aQmeB/BDH18/T05HKiqAEZXYhFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ImhkUPoMw1JnwEYSQU4mn4/Yedssvr6FmAGuGtbvv3YDk/vwFr6jNStvPcBL+9uQ5
	 k8T+e2X1SavzkoK4Z/+y+FTjq5r27sVgpsXk8xYLhg5FLPxXOnyCUyPq+9uwd5KroB
	 GO8/LAhvwnFmzqanGegU+teUTXDlCzv2+IqHrdNL89qcX419zOc2MW3J+23F/UD0eJ
	 Fo0mJp1MWL0RG2Ha5VBEuD2ab3tNHxY1pYby8e4vvi+sUilIxyEjsiZg27T6Cu2vv7
	 L9nTH3hR4/5tJynuQB9Y46j8tdlC/yQetgsSKGPQ42YygztTSjhK5Jv38Xl1yb7z48
	 JD1FiQchD9ugw==
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
Subject: [PATCH v14 1/3] kernel: Add helper macros for loop unrolling
Date: Wed, 10 Jul 2024 02:04:58 +0200
Message-ID: <20240710000500.208154-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240710000500.208154-1-kpsingh@kernel.org>
References: <20240710000500.208154-1-kpsingh@kernel.org>
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
2.45.2.803.g4e1b14247a-goog


