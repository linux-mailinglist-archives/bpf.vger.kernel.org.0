Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5E6674C62
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjATFaG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjATF2y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:28:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE4B518E4;
        Thu, 19 Jan 2023 21:23:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C355B82755;
        Fri, 20 Jan 2023 00:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEE6C433EF;
        Fri, 20 Jan 2023 00:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674173314;
        bh=ZII5T8PW4jDZyBdwaPUuY/oi4AIqimsLvi34L121owk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=scIOOCNvAlFJ7E4oCy5BjKgZMLnyP5bW9W44JGBCm6YvN1mi+nYinjtBQ6OKD+Jby
         iZ+9vE67EEKgthF8zxt9v4Ez9cuxcPINVQF9oRW+WvontASuzuij7ZDg8ROt+y6PVF
         VGgfjG5g5SrA3hJTB7cFD4Az4GMqRZlQpV7aZLClUEf5Gdu2SWMA6jMskj+o7Vn8aN
         Qk/WVtp7neWKUZnQ8qGJl3jscdLCG4t3LNlKMhmLykrnB6c2BOADiR1JTBVm6mt2ii
         suJEqfg8JXcKL4Uu70mvLIwksRjJsUrH/SUsQd+IfU+nZWF+vCqwLwjFqCLZfnHrCf
         3ViAqMn+otruw==
From:   KP Singh <kpsingh@kernel.org>
To:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, casey@schaufler-ca.com,
        song@kernel.org, revest@chromium.org, keescook@chromium.org,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH RESEND bpf-next 1/4] kernel: Add helper macros for loop unrolling
Date:   Fri, 20 Jan 2023 01:08:15 +0100
Message-Id: <20230120000818.1324170-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
In-Reply-To: <20230120000818.1324170-1-kpsingh@kernel.org>
References: <20230120000818.1324170-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/unroll.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 include/linux/unroll.h

diff --git a/include/linux/unroll.h b/include/linux/unroll.h
new file mode 100644
index 000000000000..e19aef95b94b
--- /dev/null
+++ b/include/linux/unroll.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2020 Google LLC.
+ */
+
+#ifndef __UNROLL_H
+#define __UNROLL_H
+
+#define __UNROLL_CONCAT(a, b) a ## _ ## b
+#define UNROLL(N, MACRO, args...) __UNROLL_CONCAT(__UNROLL, N)(MACRO, args)
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
2.39.0.246.g2a6d74b583-goog

