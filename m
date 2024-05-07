Return-Path: <bpf+bounces-28975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E84C8BEFAB
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 00:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 267E8B213CA
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 22:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD4816D4D0;
	Tue,  7 May 2024 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xm6sR5Tg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AE816C863;
	Tue,  7 May 2024 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715119864; cv=none; b=qojmKYSE5XCubVZdfUiBuudrX8q3311q/aGsnz8fpAlDzhet/rz6G18QcqiLShtJTllhjSgrOKiZQXSm0NfZGdJPZqdUwLNVlP6MrhorwbSltOaIqs2yHPiphdFczTBr1KpfS14J8tAcHrJkMYNDHwRtkLBr7ATtIZSQClGf1h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715119864; c=relaxed/simple;
	bh=r4cg5VUD8iAwMp9KapEk/JEUXd3eusbua9cj8lM+IBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAdhptQvlKrPpJ67BJ0e/CkCtE30h/cEuJlQRcNM5h1wKZCsQ+cISud0Y8jXZ2VdeimjtmPMXPh0hmppKYB7jmZccZpEkld+akY/obRkFTHCuYUKPTk6Ifg6UF+zuZSmlM1vS15RX0BmytnSapZWTpZ7RsrImoOP5V1jk/Z+qW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xm6sR5Tg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA3DC4AF67;
	Tue,  7 May 2024 22:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715119864;
	bh=r4cg5VUD8iAwMp9KapEk/JEUXd3eusbua9cj8lM+IBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xm6sR5Tg1K4Wk+h+teS+lMVeLQ+2NdpCuPaMoDVWS6eCNU1f6vejSsBAyi2/+SivZ
	 2g/8K0CW+DgiAuhC9uj5e1Sr0bkLjw5krSPcIUwtka0i/yjkyHRFAk7Ld2p6JQ76l8
	 qhP/fbtY4/jepQUl1B+L9obkRrQaNTJk3pXr5NhWhoMQxQ+mNSDgOMTecqGkWoY64z
	 3kHYf33L36cc1p+43NCGl2igam0P86gTQuxKI1jafP3eboYkXxJffJsu5qEq+gINRM
	 RBMtfDnRaJHFwNaRRfMDp9hWAspqQr1A8SLpuZ9w40MJ+oVkZYmKQ6l3UFo4aVYyUt
	 QwxuTkon3iY7A==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	jackmanb@google.com,
	renauld@google.com,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	song@kernel.org,
	revest@chromium.org,
	keescook@chromium.org,
	Kui-Feng Lee <sinquersw@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next v10 2/5] security: Count the LSMs enabled at compile time
Date: Wed,  8 May 2024 00:10:42 +0200
Message-ID: <20240507221045.551537-3-kpsingh@kernel.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240507221045.551537-1-kpsingh@kernel.org>
References: <20240507221045.551537-1-kpsingh@kernel.org>
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
Signed-off-by: KP Singh <kpsingh@kernel.org>
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
2.45.0.rc1.225.g2a3ae87e7f-goog


