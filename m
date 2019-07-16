Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5966A71C
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2019 13:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387619AbfGPLN0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Jul 2019 07:13:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41965 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387618AbfGPLN0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Jul 2019 07:13:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id q4so9279274pgj.8
        for <bpf@vger.kernel.org>; Tue, 16 Jul 2019 04:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E2i/udg2w3wrGveXxZ0CfGzob3tFFx0rfm+JzVT0Ufc=;
        b=jHKzaY6922Yu28T9Bff5NZORO93a7cXFLmiZuwi4qLfbemKA5hga13MQN3haCO8ena
         q/ri2Qg7dE7VL8A1Kl2QztmGDv+YCLGTjyZpEIFPN9KWjOxdu5RE9PZMsFjxXTV5ds8V
         NN/qh4zAHXZCvvb17yStTthsdlNay9Z2Kstc4El8pGQcaPZ5aSDbtMG/j1GQJp8vuIU5
         4hP+vogcQvMmDhOSAmBxXLAPCOCXH2gIuKG8Aq1pRi9aYQC6LcbpNS/drPm6r1XW3T9e
         VUR3ZRnPGlAfN/jbriW+1ll6DXsv5rVCEXrNEz7ww2hwuKQXLbY3wow52xMceZB0oK7W
         Y3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E2i/udg2w3wrGveXxZ0CfGzob3tFFx0rfm+JzVT0Ufc=;
        b=gNZphhPcp4XTywaycoWdy+DmVyD9V0bSV9Z0Q3g9oBNfPF49/TS/4rLSjPivo4GqJ7
         8w6MbzOIL5SwEME/7HOe17fW/x7PksQTRwEdcK/N/UoiTA0LsMqPCeCyH7HXQHgPnwbV
         1qC4lg2dnNkXgnjNpN0dhXADKMlS6FNU/KqCDH0zyyYeV2tmkvGWFjHnY6ZBXyGrp/lw
         FYkySYmQdGkVcQm2kD4zReQT9Mh2BaB/haLSZJI9tBLE/nLnGin+bpUhJ0MlTVOr+tfE
         ObeGg4ed7orNodgkxO7oZ7T1HMLY2esVfKx3Z/+ObqPNVcXSs2eKQa1eUJEkHiDjG2j5
         fnaQ==
X-Gm-Message-State: APjAAAUrHdvX68TJsWLxkiUn6YPv0sGB+WVevkviiZVxt6+LkuhkJguG
        ksDNDTGl/nBO+vSku+Y1ZrpE3g==
X-Google-Smtp-Source: APXvYqxH/LGB+HIDp3yR3h8D9gmqijBTeEMxlQPvdHS35dIb8U6g8YLCFVj2tj/OrIFeqjNGQFTSsA==
X-Received: by 2002:a63:d315:: with SMTP id b21mr8418386pgg.326.1563275605529;
        Tue, 16 Jul 2019 04:13:25 -0700 (PDT)
Received: from localhost.localdomain (li1433-81.members.linode.com. [45.33.106.81])
        by smtp.gmail.com with ESMTPSA id 21sm19324907pjh.25.2019.07.16.04.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 04:13:25 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Justin He <Justin.He@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 1/2] arm64: Add support for function error injection
Date:   Tue, 16 Jul 2019 19:13:00 +0800
Message-Id: <20190716111301.1855-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190716111301.1855-1-leo.yan@linaro.org>
References: <20190716111301.1855-1-leo.yan@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch implement regs_set_return_value() and
override_function_with_return() to support function error injection
for arm64.

In the exception flow, arm64's general register x30 contains the value
for the link register; so we can just update pt_regs::pc with it rather
than redirecting execution to a dummy function that returns.

This patch is heavily inspired by the commit 7cd01b08d35f ("powerpc:
Add support for function error injection").

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/Kconfig                       |  1 +
 arch/arm64/include/asm/error-injection.h | 13 +++++++++++++
 arch/arm64/include/asm/ptrace.h          |  5 +++++
 arch/arm64/lib/Makefile                  |  2 ++
 arch/arm64/lib/error-inject.c            | 19 +++++++++++++++++++
 5 files changed, 40 insertions(+)
 create mode 100644 arch/arm64/include/asm/error-injection.h
 create mode 100644 arch/arm64/lib/error-inject.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 697ea0510729..a6d9e622977d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -142,6 +142,7 @@ config ARM64
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
+	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
diff --git a/arch/arm64/include/asm/error-injection.h b/arch/arm64/include/asm/error-injection.h
new file mode 100644
index 000000000000..da057e8ed224
--- /dev/null
+++ b/arch/arm64/include/asm/error-injection.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __ASM_ERROR_INJECTION_H_
+#define __ASM_ERROR_INJECTION_H_
+
+#include <linux/compiler.h>
+#include <linux/linkage.h>
+#include <asm/ptrace.h>
+#include <asm-generic/error-injection.h>
+
+void override_function_with_return(struct pt_regs *regs);
+
+#endif /* __ASM_ERROR_INJECTION_H_ */
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index dad858b6adc6..3aafbbe218a2 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -294,6 +294,11 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
 	return regs->regs[0];
 }
 
+static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
+{
+	regs->regs[0] = rc;
+}
+
 /**
  * regs_get_kernel_argument() - get Nth function argument in kernel
  * @regs:	pt_regs of that context
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 33c2a4abda04..f182ccb0438e 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -33,3 +33,5 @@ UBSAN_SANITIZE_atomic_ll_sc.o	:= n
 lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
 
 obj-$(CONFIG_CRC32) += crc32.o
+
+obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
diff --git a/arch/arm64/lib/error-inject.c b/arch/arm64/lib/error-inject.c
new file mode 100644
index 000000000000..35661c2de4b0
--- /dev/null
+++ b/arch/arm64/lib/error-inject.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/error-injection.h>
+#include <linux/kprobes.h>
+
+void override_function_with_return(struct pt_regs *regs)
+{
+	/*
+	 * 'regs' represents the state on entry of a predefined function in
+	 * the kernel/module and which is captured on a kprobe.
+	 *
+	 * 'regs->regs[30]' contains the the link register for the probed
+	 * function and assign it to 'regs->pc', so when kprobe returns
+	 * back from exception it will override the end of probed function
+	 * and drirectly return to the predefined function's caller.
+	 */
+	regs->pc = regs->regs[30];
+}
+NOKPROBE_SYMBOL(override_function_with_return);
-- 
2.17.1

