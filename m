Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6C5A195EB7
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 20:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgC0T3L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 15:29:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40675 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgC0T3G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 15:29:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id a81so13658271wmf.5
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 12:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S1NtOnWVnF5uCCnlKRUAz3+WOwjQjIXiq2kA46TrYQg=;
        b=DZ4sIz8SwlZrJdULFpyJcGPS2LHgGqD1lUgt7wjGxkV1+7aHCZHP82gJyJ/VeJj8dA
         uE/vO0zITAocYZsx5kutKtSkwd2zvvks+6TD3irXawZlXHxS6c9KLPmP8b/sgq5jLppG
         YH8+/szIjGq3peBsKFh4WN1zhRgDEIGvrWMmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S1NtOnWVnF5uCCnlKRUAz3+WOwjQjIXiq2kA46TrYQg=;
        b=iVEhg3pi8Dfw6Vg5oFCfgeiuFsBxPi8HdBcVMDFxazER9ujUBEUCBNhoCdFaARjOKH
         4YtIikY3MQfjE7jXoZuefP8jO6w/eG8NKRldX84GDtIqs9l7FPT6IFpunN0uwaVkL8O4
         1AjIYehmVMvd1ik75mM6b9BM42EZRzYpSOTENheOvABQ6jhY/X7kKiF5X2hcrXpIbQCV
         biCiV1d+jQFdstH/59ApxTrCm9p0/t4Jf6/bOrH5AdB6orCMWahjc4IRsRn5g4OLLqef
         4RGyL2UlB95iARXbeNKNffCxEaz4SjB7eTrsWDulqYEBKMbqGtsnWyby1MMoNDugy9x0
         X5dQ==
X-Gm-Message-State: ANhLgQ1VTh+kSkVbDJELPI1BSxHstEhF+OY+fxhW2PNbK5CRIM2MUoTW
        bGBargF9bD57ZqB9RlbG26fh+Q==
X-Google-Smtp-Source: ADFU+vuFDaBb2jI0dqeeKgY+WZlZmkADt4akCJG6TXhQimx8lez+YvmD4q7KS7dOnmq9u+sT/7TZ6w==
X-Received: by 2002:a1c:bad5:: with SMTP id k204mr192033wmf.162.1585337343526;
        Fri, 27 Mar 2020 12:29:03 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id h132sm9828537wmf.18.2020.03.27.12.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 12:29:03 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jamorris@linux.microsoft.com>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH bpf-next v8 5/8] bpf: lsm: Initialize the BPF LSM hooks
Date:   Fri, 27 Mar 2020 20:28:51 +0100
Message-Id: <20200327192854.31150-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327192854.31150-1-kpsingh@chromium.org>
References: <20200327192854.31150-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

* The hooks are initialized using the definitions in
  include/linux/lsm_hook_defs.h.
* The LSM can be enabled / disabled with CONFIG_BPF_LSM.

Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: James Morris <jamorris@linux.microsoft.com>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Florent Revest <revest@google.com>
---
 security/Kconfig      | 10 +++++-----
 security/Makefile     |  2 ++
 security/bpf/Makefile |  5 +++++
 security/bpf/hooks.c  | 26 ++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 5 deletions(-)
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
index 000000000000..32d32d485451
--- /dev/null
+++ b/security/bpf/hooks.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2020 Google LLC.
+ */
+#include <linux/lsm_hooks.h>
+#include <linux/bpf_lsm.h>
+
+static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
+	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
+	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
+	#include <linux/lsm_hook_defs.h>
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

