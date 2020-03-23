Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A79E318FA2E
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 17:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgCWQoh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 12:44:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40514 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbgCWQog (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Mar 2020 12:44:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id f3so17941933wrw.7
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2020 09:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zSkW27zNSTC4Fc8TCI5UW+0DrKRV7Bu83mzAYD1k77Q=;
        b=eqUEy4dBM9mRAZt0PUr5927OFcXnR7WrVJyYuAyLEwz7/Oz+EeSXeU03igSPYZE5pj
         zco57O5wqYcErl/jIG/o8G3dmrPl+Xz2M+dKj0Kwx3IjrzQrax9uPqGbywBsiv7h09Gt
         Uu7uHZRasHOIfhuzXsfyCtXoB5fy5t2e/dp58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSkW27zNSTC4Fc8TCI5UW+0DrKRV7Bu83mzAYD1k77Q=;
        b=Hj+3UYzpFpD9sh3rpXDkKJIJXVDj8u4toZd1i/7KJIRfjl6MMaHqZL32B7ycMjvmhX
         ndjpDYuXkVAh+NkM1JVS03J4vg6GaVz9JqvXsT1qalBOK6LhJkTU9jumsQLAk89q9PJJ
         8o1vRTREgewKdZWBlK8qtF1mHNKraw0yYZR++gpIEdMIUmsdxWXU6KDbiYN1YnC1RcgV
         SWNW+UyYNm8rFeVtf4/EYLH/ILfmonNLzqlq94qRMgVnnMpzaagJLjXAeaUSFW3Z7pQA
         Xn+eSb/TTkqlAUarnNintHL86KLq2RRz0Ws97kpZ8TgBr7q+nWdG8nd+KLkzpnGfYImg
         DxIA==
X-Gm-Message-State: ANhLgQ25F1deVrZ6knXVAGrjpZSaJ75lkLmflmTzkHvt7cqiUZz1FkmK
        HAaz1+wkRPxyFRHTaodFBJL7mw==
X-Google-Smtp-Source: ADFU+vuaOEVixoBFIafSkJToy3DhcTsnaZY/ka6brQHMO25rWVX1mKJKlzZLribRBVB0JfJ8a5Rpgw==
X-Received: by 2002:adf:db41:: with SMTP id f1mr32595515wrj.247.1584981874952;
        Mon, 23 Mar 2020 09:44:34 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id l8sm199874wmj.2.2020.03.23.09.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:44:34 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v5 5/7] bpf: lsm: Initialize the BPF LSM hooks
Date:   Mon, 23 Mar 2020 17:44:13 +0100
Message-Id: <20200323164415.12943-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323164415.12943-1-kpsingh@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The bpf_lsm_ nops are initialized into the LSM framework like any other
LSM.  Some LSM hooks do not have 0 as their default return value. The
__weak symbol for these hooks is overridden by a corresponding
definition in security/bpf/hooks.c

The LSM can be enabled / disabled with CONFIG_LSM.

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
---
 security/Kconfig      | 10 ++++----
 security/Makefile     |  2 ++
 security/bpf/Makefile |  5 ++++
 security/bpf/hooks.c  | 55 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 5 deletions(-)
 create mode 100644 security/bpf/Makefile
 create mode 100644 security/bpf/hooks.c

diff --git a/security/Kconfig b/security/Kconfig
index 2a1a2d396228..cd3cc7da3a55 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -277,11 +277,11 @@ endchoice
 
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
index 746438499029..22e73a3482bd 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -12,6 +12,7 @@ subdir-$(CONFIG_SECURITY_YAMA)		+= yama
 subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
 subdir-$(CONFIG_SECURITY_SAFESETID)    += safesetid
 subdir-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown
+subdir-$(CONFIG_BPF_LSM)		+= bpf
 
 # always enable default capabilities
 obj-y					+= commoncap.o
@@ -30,6 +31,7 @@ obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
 obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
 obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
 obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
+obj-$(CONFIG_BPF_LSM)			+= bpf/
 
 # Object integrity file lists
 subdir-$(CONFIG_INTEGRITY)		+= integrity
diff --git a/security/bpf/Makefile b/security/bpf/Makefile
new file mode 100644
index 000000000000..c7a89a962084
--- /dev/null
+++ b/security/bpf/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2020 Google LLC.
+
+obj-$(CONFIG_BPF_LSM) := hooks.o
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
new file mode 100644
index 000000000000..68e5824868f9
--- /dev/null
+++ b/security/bpf/hooks.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2020 Google LLC.
+ */
+#include <linux/lsm_hooks.h>
+#include <linux/bpf_lsm.h>
+
+/* Some LSM hooks do not have 0 as their default return values. Override the
+ * __weak definitons generated by default for these hooks
+ */
+noinline int bpf_lsm_inode_getsecurity(struct inode *inode, const char *name,
+				       void **buffer, bool alloc)
+{
+	return -EOPNOTSUPP;
+}
+
+noinline int bpf_lsm_inode_setsecurity(struct inode *inode, const char *name,
+				       const void *value, size_t size,
+				       int flags)
+{
+	return -EOPNOTSUPP;
+}
+
+noinline int bpf_lsm_task_prctl(int option, unsigned long arg2,
+				unsigned long arg3, unsigned long arg4,
+				unsigned long arg5)
+{
+	return -ENOSYS;
+}
+
+noinline int bpf_lsm_xfrm_state_pol_flow_match(struct xfrm_state *x,
+					       struct xfrm_policy *xp,
+					       const struct flowi *fl)
+{
+	return 1;
+}
+
+static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
+	#define LSM_HOOK(RET, NAME, ...) LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
+	#include <linux/lsm_hook_names.h>
+	#undef LSM_HOOK
+};
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
+};
-- 
2.20.1

