Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268B11B5666
	for <lists+bpf@lfdr.de>; Thu, 23 Apr 2020 09:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgDWHs5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Apr 2020 03:48:57 -0400
Received: from condef-07.nifty.com ([202.248.20.72]:24113 "EHLO
        condef-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgDWHs4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Apr 2020 03:48:56 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-07.nifty.com with ESMTP id 03N7eYTW004490
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2020 16:40:34 +0900
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 03N7dV9a000368;
        Thu, 23 Apr 2020 16:39:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 03N7dV9a000368
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587627588;
        bh=E2jjP8KPNwvqL0zZwwd3YhfAuKyupQ9yeab/h3FTNEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6cu9Enpq+CiCsgRzuKUsbYJAE/NkdzIiiG3eC8D1AK+4ekKSWgVQxk8yPSZ6DCs7
         5lY97SjxsY77w3uqmDERaSGyw79uBewjPYTd1VtsM12VYgy9fWPHekRWgnaozoQOA9
         /txHor2s8dxdaCPFXweNbWrK+8FKOSH0rcKMw/dW06CmjpulUejvgF8ylM4LSdfJi9
         1D/EV78kSCKwg7o1z9fZg98l63n7ySX0Yub4IsdZWOGkI5TnqO11yTV+LwdakdNRYi
         b1YoNDMqri0o2izM+areu2uEOioxz6ubEoCSBKjeuupYUASWEJSvjsPN1t9LQBcV+S
         dVFkoMt1ta1rg==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/16] samples: timers: use 'userprogs' syntax
Date:   Thu, 23 Apr 2020 16:39:28 +0900
Message-Id: <20200423073929.127521-16-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200423073929.127521-1-masahiroy@kernel.org>
References: <20200423073929.127521-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kbuild now supports the 'userprogs' syntax to describe the build rules
of userspace programs for the target architecture (i.e. the same
architecture as the kernel).

Add the entry to samples/Makefile to put this into the build bot
coverage.

I also added the CONFIG option guarded by 'depends on CC_CAN_LINK'
because $(CC) may not necessarily provide libc.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 samples/Kconfig         |  4 ++++
 samples/Makefile        |  1 +
 samples/timers/Makefile | 17 +++--------------
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index cdb0091e4734..55548a487d3c 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -135,6 +135,10 @@ config SAMPLE_SECCOMP
 	  Build samples of seccomp filters using various methods of
 	  BPF filter construction.
 
+config SAMPLE_TIMER
+	bool "Build timer sample code"
+	depends on CC_CAN_LINK && HEADERS_INSTALL
+
 config SAMPLE_UHID
 	bool "Build UHID sample code"
 	depends on CC_CAN_LINK && HEADERS_INSTALL
diff --git a/samples/Makefile b/samples/Makefile
index 0c43b5d34b15..042208326689 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -16,6 +16,7 @@ subdir-$(CONFIG_SAMPLE_PIDFD)		+= pidfd
 obj-$(CONFIG_SAMPLE_QMI_CLIENT)		+= qmi/
 obj-$(CONFIG_SAMPLE_RPMSG_CLIENT)	+= rpmsg/
 subdir-$(CONFIG_SAMPLE_SECCOMP)		+= seccomp
+subdir-$(CONFIG_SAMPLE_TIMER)		+= timers
 obj-$(CONFIG_SAMPLE_TRACE_EVENTS)	+= trace_events/
 obj-$(CONFIG_SAMPLE_TRACE_PRINTK)	+= trace_printk/
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT)	+= ftrace/
diff --git a/samples/timers/Makefile b/samples/timers/Makefile
index f9fa07460802..c5f46e8caa80 100644
--- a/samples/timers/Makefile
+++ b/samples/timers/Makefile
@@ -1,16 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef CROSS_COMPILE
-uname_M := $(shell uname -m 2>/dev/null || echo not)
-ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+userprogs := hpet_example
+always-y := $(userprogs)
 
-ifeq ($(ARCH),x86)
-CC := $(CROSS_COMPILE)gcc
-PROGS := hpet_example
-
-all: $(PROGS)
-
-clean:
-	rm -fr $(PROGS)
-
-endif
-endif
+user-ccflags += -I usr/include
-- 
2.25.1

