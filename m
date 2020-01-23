Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEA2146C9D
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 16:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgAWPZN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 10:25:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42506 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbgAWPZM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 10:25:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so1685573pfz.9
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 07:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P5LBJaFDLztjq1pA7rdewN/YeJDD/aqWt25XqpUQugg=;
        b=PhO4IWnS7UTGNIhjsCNuAQ+vXoBbxnfY+FxDg5skR81zbdnTTrSt0u+XLNYUy6JfR5
         u1Z1SX8nflhnoYrAkWD7dAa2ImWhYnfxdG9acvMYHRvDCPlRxXwY8JCdfIk6kzayhhyS
         6iCh4YUlv9F5YJ1hWAhw23Z8ixI8P88gcoLUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P5LBJaFDLztjq1pA7rdewN/YeJDD/aqWt25XqpUQugg=;
        b=llgW3fyhWCos3WpjzT2E6rrhADAdZ8BY5pvzTbNSg7oppUbHwtLjWJE1bs/KYwoVIa
         u/TJt41SKuk2rYrpiWPgSvgKHNxQ0dwLdiMaFxbcUBPr1e1pBSO0ROthStr61NJkOf8E
         cly8+egVKa5Ou+Bh3OK2DF70IU8KOvKW7P0EyxnBJ9tq8vQWb2WkAAD0XgAugFlpd67N
         Znx5F8RdfBfDQHu8x+d2QsjNi87uf1HTI8a4T3b3szPDFdMgj7Guz1oan+bxtjb9O+Eh
         Jc4saIJLDf8BIgr2KOqfBFD0f1VBfhO7Xt7mTbZghumu+hkGVxgoFh97nhXFz7fKJ21L
         YzQw==
X-Gm-Message-State: APjAAAWFksfocfcpJ2i45gSkZTRbcEefz2tc6P/UNp9LP/PakwN29/wY
        lbjVEDJL5w3ObIVROIL3uhlvNw==
X-Google-Smtp-Source: APXvYqw0QVN0qvLEwTUy1TPANc2VCcjPVms57fAzqOQQLRM+xZ3uizYZNqMjSjC+H4QVb9gquyo5ZA==
X-Received: by 2002:a62:6805:: with SMTP id d5mr7923883pfc.125.1579793111792;
        Thu, 23 Jan 2020 07:25:11 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:122:bd8d:3f7b:87f7:16d1])
        by smtp.gmail.com with ESMTPSA id v5sm3108118pfn.122.2020.01.23.07.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 07:25:11 -0800 (PST)
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
Subject: [PATCH bpf-next v3 02/10] bpf: lsm: Add a skeleton and config options
Date:   Thu, 23 Jan 2020 07:24:32 -0800
Message-Id: <20200123152440.28956-3-kpsingh@chromium.org>
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

The LSM can be enabled by CONFIG_SECURITY_BPF.  Without
CONFIG_SECURITY_BPF_ENFORCE, the LSM will run the attached eBPF programs
but not enforce MAC policy based on the return value of the attached
programs.

The BPF LSM has two kinds of hooks:

- Statically defined hooks defined at init with __lsm_ro_after_init
  which are attached to the security_hook_heads defined in
  security/security.c similar to other LSMs.
- Mutable hooks that are attached to a separate security_hook_heads
  maintained by the BPF LSM (introduced in a subsequent patch).

The mutable hooks are always executed after all the static hooks
(irrespective of the position of "bpf" in the list of LSMs). Therefore,
the newly introduced LSM_ORDER_LAST represents the behaviour of this LSM
correctly

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
Reviewed-by: Thomas Garnier <thgarnie@google.com>
---
 MAINTAINERS               |  7 +++++++
 include/linux/lsm_hooks.h |  1 +
 security/Kconfig          | 11 ++++++-----
 security/Makefile         |  2 ++
 security/bpf/Kconfig      | 22 ++++++++++++++++++++++
 security/bpf/Makefile     |  5 +++++
 security/bpf/lsm.c        | 26 ++++++++++++++++++++++++++
 security/security.c       |  5 +++++
 8 files changed, 74 insertions(+), 5 deletions(-)
 create mode 100644 security/bpf/Kconfig
 create mode 100644 security/bpf/Makefile
 create mode 100644 security/bpf/lsm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 702382b89c37..e2b7f76a1a70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3203,6 +3203,13 @@ S:	Supported
 F:	arch/x86/net/
 X:	arch/x86/net/bpf_jit_comp32.c
 
+BPF SECURITY MODULE
+M:	KP Singh <kpsingh@chromium.org>
+L:	linux-security-module@vger.kernel.org
+L:	bpf@vger.kernel.org
+S:	Maintained
+F:	security/bpf/
+
 BROADCOM B44 10/100 ETHERNET DRIVER
 M:	Michael Chan <michael.chan@broadcom.com>
 L:	netdev@vger.kernel.org
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 20d8cf194fb7..5f744fcb2275 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2121,6 +2121,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 enum lsm_order {
 	LSM_ORDER_FIRST = -1,	/* This is only for capabilities. */
 	LSM_ORDER_MUTABLE = 0,
+	LSM_ORDER_LAST = 1,
 };
 
 struct lsm_info {
diff --git a/security/Kconfig b/security/Kconfig
index 2a1a2d396228..6f1aab195e7d 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -236,6 +236,7 @@ source "security/tomoyo/Kconfig"
 source "security/apparmor/Kconfig"
 source "security/loadpin/Kconfig"
 source "security/yama/Kconfig"
+source "security/bpf/Kconfig"
 source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
 
@@ -277,11 +278,11 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor" if DEFAULT_SECURITY_SMACK
-	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo" if DEFAULT_SECURITY_APPARMOR
-	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo" if DEFAULT_SECURITY_TOMOYO
-	default "lockdown,yama,loadpin,safesetid,integrity" if DEFAULT_SECURITY_DAC
-	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
+	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
+	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
+	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
+	default "lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
+	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
diff --git a/security/Makefile b/security/Makefile
index be1dd9d2cb2f..50e6821dd7b7 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -12,6 +12,7 @@ subdir-$(CONFIG_SECURITY_YAMA)		+= yama
 subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
 subdir-$(CONFIG_SECURITY_SAFESETID)    += safesetid
 subdir-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown
+subdir-$(CONFIG_SECURITY_BPF)		+= bpf
 
 # always enable default capabilities
 obj-y					+= commoncap.o
@@ -29,6 +30,7 @@ obj-$(CONFIG_SECURITY_YAMA)		+= yama/
 obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
 obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
 obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
+obj-$(CONFIG_SECURITY_BPF)		+= bpf/
 obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
 
 # Object integrity file lists
diff --git a/security/bpf/Kconfig b/security/bpf/Kconfig
new file mode 100644
index 000000000000..a5f6c67ae526
--- /dev/null
+++ b/security/bpf/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright 2019 Google LLC.
+
+config SECURITY_BPF
+	bool "BPF-based MAC and audit policy"
+	depends on SECURITY
+	depends on BPF_SYSCALL
+	help
+	  This enables instrumentation of the security hooks with
+	  eBPF programs.
+
+	  If you are unsure how to answer this question, answer N.
+
+config SECURITY_BPF_ENFORCE
+	bool "Deny operations based on the evaluation of the attached programs"
+	depends on SECURITY_BPF
+	help
+	  eBPF programs attached to hooks can be used for both auditing and
+	  enforcement. Enabling enforcement implies that the evaluation result
+	  from the attached eBPF programs will allow or deny the operation
+	  guarded by the security hook.
diff --git a/security/bpf/Makefile b/security/bpf/Makefile
new file mode 100644
index 000000000000..26a0ab6f99b7
--- /dev/null
+++ b/security/bpf/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright 2019 Google LLC.
+
+obj-$(CONFIG_SECURITY_BPF) := lsm.o
diff --git a/security/bpf/lsm.c b/security/bpf/lsm.c
new file mode 100644
index 000000000000..dc9ac03c7aa0
--- /dev/null
+++ b/security/bpf/lsm.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2019 Google LLC.
+ */
+
+#include <linux/lsm_hooks.h>
+
+/* This is only for internal hooks, always statically shipped as part of the
+ * BPF LSM. Statically defined hooks are appended to the security_hook_heads
+ * which is common for LSMs and R/O after init.
+ */
+static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {};
+
+static int __init bpf_lsm_init(void)
+{
+	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
+	pr_info("LSM support for eBPF active\n");
+	return 0;
+}
+
+DEFINE_LSM(bpf) = {
+	.name = "bpf",
+	.init = bpf_lsm_init,
+	.order = LSM_ORDER_LAST,
+};
diff --git a/security/security.c b/security/security.c
index cd2d18d2d279..30a8aa700557 100644
--- a/security/security.c
+++ b/security/security.c
@@ -264,6 +264,11 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		}
 	}
 
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->order == LSM_ORDER_LAST)
+			append_ordered_lsm(lsm, "last");
+	}
+
 	/* Disable all LSMs not in the ordered list. */
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 		if (exists_ordered_lsm(lsm))
-- 
2.20.1

