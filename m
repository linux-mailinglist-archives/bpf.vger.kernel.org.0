Return-Path: <bpf+bounces-10641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E5B7AB435
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 16:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0C8BC28226C
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 14:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513A83D995;
	Fri, 22 Sep 2023 14:55:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7F73D984
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 14:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6600CC433CA;
	Fri, 22 Sep 2023 14:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695394516;
	bh=rVJOVrx26uyrnr/K51vgU4Grf9Xdl9VlKY5L5ZZfS0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=onGKxaCbRCffxAMhxDtJwNxyHpQ+m1IZ0xCuAMJJypMoH4dAIPO58lJhl/UgSRoRQ
	 M7ZTi3aqGNTeX9wCv+dYSXBNJL4DScl6XO0aIlJ9z1MywLLNlA63jTmLcRaAdraox/
	 6nJugVGaeR+NqzT6F+7RE+or5DL6ScqSugTFQ4IL9Naw1WvwT1nT0oXMcFLwa4y7Za
	 6QZFuyC5J0yw6jpZrAErYqNTxBAGBO9kTgJZX5foEj9AVTFxcgSoK7a4kjmBdqGGb4
	 yA+d2I0PqktOOqafCwWBW59VFmXVEc7s1sidqVWWwoxxpCY+HAxJjmaqM3bjSvCywa
	 nAeAPzPtLxTXQ==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: paul@paul-moore.com,
	keescook@chromium.org,
	casey@schaufler-ca.com,
	song@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	kpsingh@kernel.org,
	renauld@google.com,
	Kui-Feng Lee <sinquersw@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 2/5] security: Count the LSMs enabled at compile time
Date: Fri, 22 Sep 2023 16:55:02 +0200
Message-ID: <20230922145505.4044003-3-kpsingh@kernel.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230922145505.4044003-1-kpsingh@kernel.org>
References: <20230922145505.4044003-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These macros are a clever trick to determine a count of the number of
LSMs that are enabled in the config to ascertain the maximum number of
static calls that need to be configured per LSM hook.

Without this one would need to generate static calls for the total
number of LSMs in the kernel (even if they are not compiled) times the
number of LSM hooks which ends up being quite wasteful.

Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/lsm_count.h | 107 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 include/linux/lsm_count.h

diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
new file mode 100644
index 000000000000..4d6dac6efb75
--- /dev/null
+++ b/include/linux/lsm_count.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2023 Google LLC.
+ */
+
+#ifndef __LINUX_LSM_COUNT_H
+#define __LINUX_LSM_COUNT_H
+
+#include <linux/args.h>
+
+#ifdef CONFIG_SECURITY
+
+/*
+ * Macros to count the number of LSMs enabled in the kernel at compile time.
+ */
+
+/*
+ * Capabilities is enabled when CONFIG_SECURITY is enabled.
+ */
+#if IS_ENABLED(CONFIG_SECURITY)
+#define CAPABILITIES_ENABLED 1,
+#else
+#define CAPABILITIES_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_SELINUX)
+#define SELINUX_ENABLED 1,
+#else
+#define SELINUX_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_SMACK)
+#define SMACK_ENABLED 1,
+#else
+#define SMACK_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_APPARMOR)
+#define APPARMOR_ENABLED 1,
+#else
+#define APPARMOR_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_TOMOYO)
+#define TOMOYO_ENABLED 1,
+#else
+#define TOMOYO_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_YAMA)
+#define YAMA_ENABLED 1,
+#else
+#define YAMA_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_LOADPIN)
+#define LOADPIN_ENABLED 1,
+#else
+#define LOADPIN_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM)
+#define LOCKDOWN_ENABLED 1,
+#else
+#define LOCKDOWN_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_BPF_LSM)
+#define BPF_LSM_ENABLED 1,
+#else
+#define BPF_LSM_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_SECURITY_LANDLOCK)
+#define LANDLOCK_ENABLED 1,
+#else
+#define LANDLOCK_ENABLED
+#endif
+
+/*
+ *  There is a trailing comma that we need to be accounted for. This is done by
+ *  using a skipped argument in __COUNT_LSMS
+ */
+#define __COUNT_LSMS(skipped_arg, args...) COUNT_ARGS(args)
+#define COUNT_LSMS(args...) __COUNT_LSMS(args)
+
+#define MAX_LSM_COUNT			\
+	COUNT_LSMS(			\
+		CAPABILITIES_ENABLED	\
+		SELINUX_ENABLED		\
+		SMACK_ENABLED		\
+		APPARMOR_ENABLED	\
+		TOMOYO_ENABLED		\
+		YAMA_ENABLED		\
+		LOADPIN_ENABLED		\
+		LOCKDOWN_ENABLED	\
+		BPF_LSM_ENABLED		\
+		LANDLOCK_ENABLED)
+
+#else
+
+#define MAX_LSM_COUNT 0
+
+#endif /* CONFIG_SECURITY */
+
+#endif  /* __LINUX_LSM_COUNT_H */
-- 
2.42.0.515.g380fc7ccd1-goog


