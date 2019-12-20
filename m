Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D545127F8C
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 16:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfLTPmJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 10:42:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38760 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfLTPmI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 10:42:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so9867549wrh.5
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2019 07:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6t1SoqwVuPN5RZrWbZ/JmprOHgDz/qxqketSjNkDxYQ=;
        b=Za0Ik+yT8Naldmi7JYTHp0+WuOF/mI5o4+6wTWn6WVqreRl0BuH5kZGrkAT65FqOhL
         ik4xff8Y0GYoREJjknBeExBw0poezt9BfP29XsTroIiGfvbmr3lTTPQvSc4q7cV48WMa
         JD9UHz8JdBAmhXmajPinQmLxnyjUaYDP/S4UE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6t1SoqwVuPN5RZrWbZ/JmprOHgDz/qxqketSjNkDxYQ=;
        b=PI4fU0inYpfRnH++C46jiH8UlHoB1d3T9g2swwUosTNTqiS60mGMSfCvj0ZdLBBBwc
         1ZVsHkDKmULMbF9OGd642QkL5oKxiPjdcUCiDNHxOP9puoVsU6OD5HOIzJ2qkdAX/Ylw
         8vUvz67L3OFxzqLNcU5Qv8CEMuHdKhGuFfhDf2jkSLNWj3MLFe+2tiVunSDLExJpz/7+
         8ryPfLOqjHr22Y/isHfAAvWSskW/mtlSlZTw3NoqKsFk0q19LQLeGrRx3cvkYOY2HaV4
         DOS2Qe+/lnf6B9jVJywQRQhsSgPUea7w+off9VX+UcMwg8pvFtrXV3HyD1f1UJHSna9L
         9KaQ==
X-Gm-Message-State: APjAAAWH11S5Q/ooFP3xcb32BTu3wt6b7rlrycQiPKAZ+s9itcOuBD8r
        YYeHVRABxlQZ9FtUyujfRaQXCQ==
X-Google-Smtp-Source: APXvYqzUw2zZWd01RnFUny0Ejrm3QP4gMWGxtDfpl5hA1PwIuv83c3ZBZMhLU1YB2ifHyAALBcDveA==
X-Received: by 2002:a5d:6349:: with SMTP id b9mr16641794wrw.346.1576856525938;
        Fri, 20 Dec 2019 07:42:05 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:c46b:b838:66cf:6204])
        by smtp.gmail.com with ESMTPSA id x11sm10118062wmg.46.2019.12.20.07.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:42:05 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
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
Subject: [PATCH bpf-next v1 02/13] bpf: lsm: Add a skeleton and config options
Date:   Fri, 20 Dec 2019 16:41:57 +0100
Message-Id: <20191220154208.15895-3-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220154208.15895-1-kpsingh@chromium.org>
References: <20191220154208.15895-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The LSM can be enabled by CONFIG_SECURITY_BPF.
Without CONFIG_SECURITY_BPF_ENFORCE, the LSM will run the
attached eBPF programs but not enforce MAC policy based
on the return value of the attached programs.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 MAINTAINERS           |  7 +++++++
 security/Kconfig      | 11 ++++++-----
 security/Makefile     |  2 ++
 security/bpf/Kconfig  | 25 +++++++++++++++++++++++++
 security/bpf/Makefile |  5 +++++
 security/bpf/lsm.c    | 28 ++++++++++++++++++++++++++++
 6 files changed, 73 insertions(+), 5 deletions(-)
 create mode 100644 security/bpf/Kconfig
 create mode 100644 security/bpf/Makefile
 create mode 100644 security/bpf/lsm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f075b866aaf..3b82d8ff21fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3175,6 +3175,13 @@ S:	Supported
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
index 000000000000..1aaa1340e795
--- /dev/null
+++ b/security/bpf/Kconfig
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright 2019 Google LLC.
+
+config SECURITY_BPF
+	bool "BPF-based MAC and audit policy"
+	depends on SECURITY
+	depends on SECURITYFS
+	depends on BPF
+	depends on BPF_SYSCALL
+	help
+	  This enables instrumentation of the security hooks with
+	  eBPF programs. The LSM creates per-hook files in securityfs to which
+	  eBPF programs can be attached.
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
index 000000000000..fe5c65bbdd45
--- /dev/null
+++ b/security/bpf/lsm.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2019 Google LLC.
+ */
+
+#include <linux/lsm_hooks.h>
+
+static int process_execution(struct linux_binprm *bprm)
+{
+	return 0;
+}
+
+static struct security_hook_list lsm_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(bprm_check_security, process_execution),
+};
+
+static int __init lsm_init(void)
+{
+	security_add_hooks(lsm_hooks, ARRAY_SIZE(lsm_hooks), "bpf");
+	pr_info("eBPF and LSM are friends now.\n");
+	return 0;
+}
+
+DEFINE_LSM(bpf) = {
+	.name = "bpf",
+	.init = lsm_init,
+};
-- 
2.20.1

