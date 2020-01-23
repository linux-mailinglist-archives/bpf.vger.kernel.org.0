Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B50E146CB0
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 16:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAWPZR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 10:25:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36966 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgAWPZQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 10:25:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so1694000pfn.4
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 07:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kEB1oX080wywjgXCBoRyFYkLoSte5dO4/3ZyhaJZ/DE=;
        b=nlavn8NdsmMI/q2XsA201oha0BXlUuH8RnGkC1BIvxU403LFzrSYkpBdqmL3QP/HTg
         hmYPDD25eHCCrhylXhKl4AqllKqkhGr+kydyTUxzm/YTbpiH3v7h6pnMKkmEUPOfn8WR
         wovnuUevfvCtC4wl20Qh1U6dB5Tp5kdO+y0s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kEB1oX080wywjgXCBoRyFYkLoSte5dO4/3ZyhaJZ/DE=;
        b=hg87P2TmgkZnvbsZv+yTfjz7KZ39shkJvEEq/Cxov4Y5bK5EVR7hppf8qLz4gNod0Y
         MyrAoecfBe8yuGbY07OPtokgPXwMkwsxFSxp95nbf0+QrkkyXHL2QRQxRb/djHeGaq7i
         7rnCbPl9GTwzqWnyKEN6nVVnpslR772UV8g4mFnRY/Yg5LPikw10lIJ369A9BEM8CAyh
         VWjBFcoA7yxmis+0qc4ckmt3U37V8WDS+b6iuZsr76X+/DZFTJpj3oinv8At3Wwi7LfH
         5V63u+6he6G4vp6ksmeAozpt/aHZIttq6s/5jpmihPBONm4Wll6bYpx7fgnmnYdDnaTY
         61dg==
X-Gm-Message-State: APjAAAUJo3j2OeD7J2N+FWXj6UMKXMkGzr46Q+RUbiqfVOQWYBa9vmvO
        1HyObrLCR5t4CNg0is0WttJnWg==
X-Google-Smtp-Source: APXvYqyDy+BxhvzMVB/S5GcwfkjVUhyJGmRoPL38Q027yNhB3kWo2FGgPYIbfK9kYgU36qt3FQW0zw==
X-Received: by 2002:aa7:82d5:: with SMTP id f21mr8045338pfn.245.1579793115460;
        Thu, 23 Jan 2020 07:25:15 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:122:bd8d:3f7b:87f7:16d1])
        by smtp.gmail.com with ESMTPSA id v5sm3108118pfn.122.2020.01.23.07.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 07:25:14 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: [PATCH bpf-next v3 04/10] bpf: lsm: Add mutable hooks list for the BPF LSM
Date:   Thu, 23 Jan 2020 07:24:34 -0800
Message-Id: <20200123152440.28956-5-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123152440.28956-1-kpsingh@chromium.org>
References: <20200123152440.28956-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

- The list of hooks registered by an LSM is currently immutable as they
  are declared with __lsm_ro_after_init and they are attached to a
  security_hook_heads struct.
- For the BPF LSM we need to de/register the hooks at runtime. Making
  the existing security_hook_heads mutable broadens an
  attack vector, so a separate security_hook_heads is added for only
  those that ~must~ be mutable.
- These mutable hooks are run only after all the static hooks have
  successfully executed.

This is based on the ideas discussed in:

  https://lore.kernel.org/lkml/20180408065916.GA2832@ircssh-2.c.rugged-nimbus-611.internal

Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Thomas Garnier <thgarnie@google.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 MAINTAINERS             |  1 +
 include/linux/bpf_lsm.h | 72 +++++++++++++++++++++++++++++++++++++++++
 security/bpf/Kconfig    |  1 +
 security/bpf/Makefile   |  2 +-
 security/bpf/hooks.c    | 20 ++++++++++++
 security/bpf/lsm.c      |  7 ++++
 security/security.c     | 25 +++++++-------
 7 files changed, 116 insertions(+), 12 deletions(-)
 create mode 100644 include/linux/bpf_lsm.h
 create mode 100644 security/bpf/hooks.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e2b7f76a1a70..c606b3d89992 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3209,6 +3209,7 @@ L:	linux-security-module@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	security/bpf/
+F:	include/linux/bpf_lsm.h
 
 BROADCOM B44 10/100 ETHERNET DRIVER
 M:	Michael Chan <michael.chan@broadcom.com>
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
new file mode 100644
index 000000000000..57c20b2cd2f4
--- /dev/null
+++ b/include/linux/bpf_lsm.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright 2019 Google LLC.
+ */
+
+#ifndef _LINUX_BPF_LSM_H
+#define _LINUX_BPF_LSM_H
+
+#include <linux/bpf.h>
+#include <linux/lsm_hooks.h>
+
+#ifdef CONFIG_SECURITY_BPF
+
+/* Mutable hooks defined at runtime and executed after all the statically
+ * defined LSM hooks.
+ */
+extern struct security_hook_heads bpf_lsm_hook_heads;
+
+int bpf_lsm_srcu_read_lock(void);
+void bpf_lsm_srcu_read_unlock(int idx);
+
+#define CALL_BPF_LSM_VOID_HOOKS(FUNC, ...)			\
+	do {							\
+		struct security_hook_list *P;			\
+		int _idx;					\
+								\
+		if (hlist_empty(&bpf_lsm_hook_heads.FUNC))	\
+			break;					\
+								\
+		_idx = bpf_lsm_srcu_read_lock();		\
+		hlist_for_each_entry(P, &bpf_lsm_hook_heads.FUNC, list) \
+			P->hook.FUNC(__VA_ARGS__);		\
+		bpf_lsm_srcu_read_unlock(_idx);			\
+	} while (0)
+
+#define CALL_BPF_LSM_INT_HOOKS(FUNC, ...) ({			\
+	int _ret = 0;						\
+	do {							\
+		struct security_hook_list *P;			\
+		int _idx;					\
+								\
+		if (hlist_empty(&bpf_lsm_hook_heads.FUNC))	\
+			break;					\
+								\
+		_idx = bpf_lsm_srcu_read_lock();		\
+								\
+		hlist_for_each_entry(P,				\
+			&bpf_lsm_hook_heads.FUNC, list) {	\
+			_ret = P->hook.FUNC(__VA_ARGS__);		\
+			if (_ret && IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE)) \
+				break;				\
+		}						\
+		bpf_lsm_srcu_read_unlock(_idx);			\
+	} while (0);						\
+	IS_ENABLED(CONFIG_SECURITY_BPF_ENFORCE) ? _ret : 0;	\
+})
+
+#else /* !CONFIG_SECURITY_BPF */
+
+#define CALL_BPF_LSM_INT_HOOKS(FUNC, ...) (0)
+#define CALL_BPF_LSM_VOID_HOOKS(...)
+
+static inline int bpf_lsm_srcu_read_lock(void)
+{
+	return 0;
+}
+static inline void bpf_lsm_srcu_read_unlock(int idx) {}
+
+#endif /* CONFIG_SECURITY_BPF */
+
+#endif /* _LINUX_BPF_LSM_H */
diff --git a/security/bpf/Kconfig b/security/bpf/Kconfig
index a5f6c67ae526..595e4ad597ae 100644
--- a/security/bpf/Kconfig
+++ b/security/bpf/Kconfig
@@ -6,6 +6,7 @@ config SECURITY_BPF
 	bool "BPF-based MAC and audit policy"
 	depends on SECURITY
 	depends on BPF_SYSCALL
+	depends on SRCU
 	help
 	  This enables instrumentation of the security hooks with
 	  eBPF programs.
diff --git a/security/bpf/Makefile b/security/bpf/Makefile
index c78a8a056e7e..c526927c337d 100644
--- a/security/bpf/Makefile
+++ b/security/bpf/Makefile
@@ -2,4 +2,4 @@
 #
 # Copyright 2019 Google LLC.
 
-obj-$(CONFIG_SECURITY_BPF) := lsm.o ops.o
+obj-$(CONFIG_SECURITY_BPF) := lsm.o ops.o hooks.o
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
new file mode 100644
index 000000000000..b123d9cb4cd4
--- /dev/null
+++ b/security/bpf/hooks.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2019 Google LLC.
+ */
+
+#include <linux/bpf_lsm.h>
+#include <linux/srcu.h>
+
+DEFINE_STATIC_SRCU(security_hook_srcu);
+
+int bpf_lsm_srcu_read_lock(void)
+{
+	return srcu_read_lock(&security_hook_srcu);
+}
+
+void bpf_lsm_srcu_read_unlock(int idx)
+{
+	return srcu_read_unlock(&security_hook_srcu, idx);
+}
diff --git a/security/bpf/lsm.c b/security/bpf/lsm.c
index dc9ac03c7aa0..a25a068e1781 100644
--- a/security/bpf/lsm.c
+++ b/security/bpf/lsm.c
@@ -4,6 +4,7 @@
  * Copyright 2019 Google LLC.
  */
 
+#include <linux/bpf_lsm.h>
 #include <linux/lsm_hooks.h>
 
 /* This is only for internal hooks, always statically shipped as part of the
@@ -12,6 +13,12 @@
  */
 static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {};
 
+/* Security hooks registered dynamically by the BPF LSM and must be accessed
+ * by holding bpf_lsm_srcu_read_lock and bpf_lsm_srcu_read_unlock. The mutable
+ * hooks dynamically allocated by the BPF LSM are appeneded here.
+ */
+struct security_hook_heads bpf_lsm_hook_heads;
+
 static int __init bpf_lsm_init(void)
 {
 	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
diff --git a/security/security.c b/security/security.c
index 30a8aa700557..95a46ca25dcd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -27,6 +27,7 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <linux/msg.h>
+#include <linux/bpf_lsm.h>
 #include <net/flow.h>
 
 #define MAX_LSM_EVM_XATTR	2
@@ -657,20 +658,22 @@ static void __init lsm_early_task(struct task_struct *task)
 								\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
 			P->hook.FUNC(__VA_ARGS__);		\
+		CALL_BPF_LSM_VOID_HOOKS(FUNC, __VA_ARGS__);	\
 	} while (0)
 
-#define call_int_hook(FUNC, IRC, ...) ({			\
-	int RC = IRC;						\
-	do {							\
-		struct security_hook_list *P;			\
-								\
+#define call_int_hook(FUNC, IRC, ...) ({				\
+	int RC = IRC;							\
+	do {								\
+		struct security_hook_list *P;				\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
-			RC = P->hook.FUNC(__VA_ARGS__);		\
-			if (RC != 0)				\
-				break;				\
-		}						\
-	} while (0);						\
-	RC;							\
+			RC = P->hook.FUNC(__VA_ARGS__);			\
+			if (RC != 0)					\
+				break;					\
+		}							\
+		if (RC == 0)						\
+			RC = CALL_BPF_LSM_INT_HOOKS(FUNC, __VA_ARGS__);	\
+	} while (0);							\
+	RC;								\
 })
 
 /* Security operations */
-- 
2.20.1

