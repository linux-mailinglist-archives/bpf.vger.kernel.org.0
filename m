Return-Path: <bpf+bounces-37378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF866954E04
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 17:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9E21C210EF
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 15:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8E21BDABB;
	Fri, 16 Aug 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPHhmH+g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EF71DDF5;
	Fri, 16 Aug 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823002; cv=none; b=rMEr8MlF0Af+cR6QwDWHJRjOTUcPgpqowxxiPDsOhYtaQ3aLF1rhKCsuz+vsYWFAWsbylXRl+eGPqV7m+pT0LuRQ3x26Etjb94N8DiAxXEwVfIJj6aGXXuIF1mXbAHhWP3dcqaB8AjIm6WKb5tn7ScT40LwgGEUEDum0ELrnbsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823002; c=relaxed/simple;
	bh=XgUnwMlMJ0XDqTanAbtn9SgCVvowcZrVgqAmlv2XiIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIsTBuI7X9OM5Xjm46IaVvHF0zN73rXUsCgccgEeWheaG0/v/svEPmEigbPK0LohLJjl9fkHZL58Zh6X0OKmLwaXS3H37aDoQIROo7ZUP3fvXUvKIkqMSGKrI7JLKFbGlUfZ7vw20fujZYzreqJ79bFBuspBeD+cxscvdXUpb7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPHhmH+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B5CC4AF0C;
	Fri, 16 Aug 2024 15:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723823002;
	bh=XgUnwMlMJ0XDqTanAbtn9SgCVvowcZrVgqAmlv2XiIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mPHhmH+g48YnI0O5avY/XG0HwXgjj5cy1rrg6LExuOPXHPYq8WPEPjnHeJYE1ahEN
	 r2gJtWo5xOfaSN7wpDt7qfjLi417rNCWTLEsDFqiKCZ6oI34jEC7aOrCP2Ci6XVhXZ
	 VXDSVFGJnUw0wshSw7ubl9SXqZ3BhFCZDRBdh+rX93gZU2JIIykxlPLiABNjL25WOP
	 W2Gvx4RrYu1LnnBQm5xrejxN3VzXmpYA5BujULs4+e9mQojU2V5CnCnlT/eysQ0lP/
	 gPJU7ZCX8PfU+TDYI2DqGlYYDkRjQXpJdZgYMP5VMeB3SR/yWyBHPUeRjkbqZHdNYV
	 UPCnZwSjEFytQ==
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
	linux@roeck-us.net,
	Kui-Feng Lee <sinquersw@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	John Johansen <john.johansen@canonical.com>
Subject: [PATCH v15 3/4] lsm: count the LSMs enabled at compile time
Date: Fri, 16 Aug 2024 17:43:06 +0200
Message-ID: <20240816154307.3031838-4-kpsingh@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240816154307.3031838-1-kpsingh@kernel.org>
References: <20240816154307.3031838-1-kpsingh@kernel.org>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: KP Singh <kpsingh@kernel.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
[PM: subj tweaks]
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/args.h      |   6 +-
 include/linux/lsm_count.h | 128 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/lsm_count.h

diff --git a/include/linux/args.h b/include/linux/args.h
index 8ff60a54eb7d..2e8e65d975c7 100644
--- a/include/linux/args.h
+++ b/include/linux/args.h
@@ -17,9 +17,9 @@
  * that as _n.
  */
 
-/* This counts to 12. Any more, it will return 13th argument. */
-#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _n, X...) _n
-#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
+/* This counts to 15. Any more, it will return 16th argument. */
+#define __COUNT_ARGS(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _n, X...) _n
+#define COUNT_ARGS(X...) __COUNT_ARGS(, ##X, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
 
 /* Concatenate two parameters, but allow them to be expanded beforehand. */
 #define __CONCAT(a, b) a ## b
diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
new file mode 100644
index 000000000000..73c7cc81349b
--- /dev/null
+++ b/include/linux/lsm_count.h
@@ -0,0 +1,128 @@
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
+#if IS_ENABLED(CONFIG_SECURITY_SAFESETID)
+#define SAFESETID_ENABLED 1,
+#else
+#define SAFESETID_ENABLED
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
+#if IS_ENABLED(CONFIG_IMA)
+#define IMA_ENABLED 1,
+#else
+#define IMA_ENABLED
+#endif
+
+#if IS_ENABLED(CONFIG_EVM)
+#define EVM_ENABLED 1,
+#else
+#define EVM_ENABLED
+#endif
+
+/*
+ *  There is a trailing comma that we need to be accounted for. This is done by
+ *  using a skipped argument in __COUNT_LSMS
+ */
+#define __COUNT_LSMS(skipped_arg, args...) COUNT_ARGS(args...)
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
+		SAFESETID_ENABLED	\
+		BPF_LSM_ENABLED		\
+		LANDLOCK_ENABLED	\
+		IMA_ENABLED		\
+		EVM_ENABLED)
+
+#else
+
+#define MAX_LSM_COUNT 0
+
+#endif /* CONFIG_SECURITY */
+
+#endif  /* __LINUX_LSM_COUNT_H */
-- 
2.46.0.184.g6999bdac58-goog


