Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110111B56B8
	for <lists+bpf@lfdr.de>; Thu, 23 Apr 2020 09:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgDWHxO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Apr 2020 03:53:14 -0400
Received: from condef-05.nifty.com ([202.248.20.70]:28337 "EHLO
        condef-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgDWHxO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Apr 2020 03:53:14 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-05.nifty.com with ESMTP id 03N7eahl026905
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2020 16:40:36 +0900
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 03N7dV9T000368;
        Thu, 23 Apr 2020 16:39:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 03N7dV9T000368
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587627582;
        bh=o9sBp4j0KqjJcbGaUiGsj+dJQnRhbxdTQjnG5XWSjQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SvqVj8FDE575F/ryTgEiKX+nZWGnHNljoUL3kVlWrpvi591++s5VTcqS5QC7HxeZM
         Que0i8ndSrFgwENSqr0IUw3ua5t3FLTbGDsJMnlVNza96GAdoqL0oixhagL6N6pjns
         fhtHu1gjQ97jo9weF7sEgvVi81bBIHZG726tesgF8N33IzoDGzwyGNsgz6eymtqvmS
         Ylolfeurn6JNG5lhE7ctrxhGRATP2XdkYU0oReEYWaTeGg8/JhKPU+zMoOEE8onNfo
         /ly885V39uu74d1Z0p0oPo0roEJJ7zES6PRk6Qca/W6Rc/nkzUEiOig5g8jqBwwunx
         irBA3rubBhGwQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/16] samples: uhid: build sample program for target architecture
Date:   Thu, 23 Apr 2020 16:39:21 +0900
Message-Id: <20200423073929.127521-9-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200423073929.127521-1-masahiroy@kernel.org>
References: <20200423073929.127521-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This userspace program includes UAPI headers exported to usr/include/.
'make headers' always works for the target architecture (i.e. the same
architecture as the kernel), so the sample program must be built for
the target as well. Kbuild now supports the 'userprogs' syntax to
describe it cleanly.

Add the entry to samples/Makefile to put this into the build bot
coverage.

I also added the CONFIG option guarded by 'depends on CC_CAN_LINK'
because $(CC) may not necessarily provide libc.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 samples/Kconfig         | 6 ++++++
 samples/Makefile        | 1 +
 samples/uhid/.gitignore | 2 ++
 samples/uhid/Makefile   | 9 +++------
 4 files changed, 12 insertions(+), 6 deletions(-)
 create mode 100644 samples/uhid/.gitignore

diff --git a/samples/Kconfig b/samples/Kconfig
index 8949e9646125..ff9126ef1c79 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -131,6 +131,12 @@ config SAMPLE_SECCOMP
 	  Build samples of seccomp filters using various methods of
 	  BPF filter construction.
 
+config SAMPLE_UHID
+	bool "Build UHID sample code"
+	depends on CC_CAN_LINK && HEADERS_INSTALL
+	help
+	  Build UHID sample program.
+
 config SAMPLE_VFIO_MDEV_MTTY
 	tristate "Build VFIO mtty example mediated device sample code -- loadable modules only"
 	depends on VFIO_MDEV_DEVICE && m
diff --git a/samples/Makefile b/samples/Makefile
index 5ce50ef0f2b2..bdc168405452 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_SAMPLE_TRACE_EVENTS)	+= trace_events/
 obj-$(CONFIG_SAMPLE_TRACE_PRINTK)	+= trace_printk/
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT)	+= ftrace/
 obj-$(CONFIG_SAMPLE_TRACE_ARRAY)	+= ftrace/
+subdir-$(CONFIG_SAMPLE_UHID)		+= uhid
 obj-$(CONFIG_VIDEO_PCI_SKELETON)	+= v4l/
 obj-y					+= vfio-mdev/
 subdir-$(CONFIG_SAMPLE_VFS)		+= vfs
diff --git a/samples/uhid/.gitignore b/samples/uhid/.gitignore
new file mode 100644
index 000000000000..0e0a5a929f5d
--- /dev/null
+++ b/samples/uhid/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+/uhid-example
diff --git a/samples/uhid/Makefile b/samples/uhid/Makefile
index 5f44ea40d6d5..1dc58c40298c 100644
--- a/samples/uhid/Makefile
+++ b/samples/uhid/Makefile
@@ -1,8 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-# List of programs to build
-hostprogs := uhid-example
+userprogs := uhid-example
+always-y := $(userprogs)
 
-# Tell kbuild to always build the programs
-always-y := $(hostprogs)
-
-HOSTCFLAGS_uhid-example.o += -I$(objtree)/usr/include
+user-ccflags += -I usr/include
-- 
2.25.1

