Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15C31B5665
	for <lists+bpf@lfdr.de>; Thu, 23 Apr 2020 09:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgDWHsx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Apr 2020 03:48:53 -0400
Received: from condef-07.nifty.com ([202.248.20.72]:24076 "EHLO
        condef-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgDWHsx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Apr 2020 03:48:53 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-07.nifty.com with ESMTP id 03N7eWvD004489
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2020 16:40:32 +0900
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 03N7dV9b000368;
        Thu, 23 Apr 2020 16:39:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 03N7dV9b000368
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587627589;
        bh=juTCQEGw4591P2lhPWalVsIydPeVDA5qp/agKloK7wE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A43dIexGcFvYP9YfNPNCCHF4w+RKeD+dIP2P21GFHkODTqk/oaIFyMUiktfLrYO4z
         1IpKMFNqHRps7/YzQ26CeKNPn7tL4wiUqTNyDwVlVQzx2MayLGaP4QbSaxhI+W8GyA
         0a5zRJ4jeGJ2HakH+TzBvdkc0vdgTdkqH1W34RWSg7i2ehjX6G4yFq4XgTQZBSEOmH
         RxL1K5eSpGzB1PW6/IAmSfD11OVuTTsuyGRtX2R84dZ9ns7QauXlu3A1iZV4QnTAem
         NTazxTFumXcWZGqdxKbWImEXd7vnlDuA1WXNApi521AM5A/It8K+JhNLRQaccX76uk
         xrP0tlIprm2aw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/16] samples: watchdog: use 'userprogs' syntax
Date:   Thu, 23 Apr 2020 16:39:29 +0900
Message-Id: <20200423073929.127521-17-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200423073929.127521-1-masahiroy@kernel.org>
References: <20200423073929.127521-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

 samples/Kconfig           |  3 +++
 samples/Makefile          |  1 +
 samples/watchdog/Makefile | 10 ++--------
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index 55548a487d3c..4aa89d24a19e 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -205,5 +205,8 @@ config SAMPLE_INTEL_MEI
 	help
 	  Build a sample program to work with mei device.
 
+config SAMPLE_WATCHDOG
+	bool "watchdog sample"
+	depends on CC_CAN_LINK
 
 endif # SAMPLES
diff --git a/samples/Makefile b/samples/Makefile
index 042208326689..29c66aadd954 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_VIDEO_PCI_SKELETON)	+= v4l/
 obj-y					+= vfio-mdev/
 subdir-$(CONFIG_SAMPLE_VFS)		+= vfs
 obj-$(CONFIG_SAMPLE_INTEL_MEI)		+= mei/
+subdir-$(CONFIG_SAMPLE_WATCHDOG)	+= watchdog
diff --git a/samples/watchdog/Makefile b/samples/watchdog/Makefile
index a9430fa60253..17384cfb387e 100644
--- a/samples/watchdog/Makefile
+++ b/samples/watchdog/Makefile
@@ -1,9 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-CC := $(CROSS_COMPILE)gcc
-PROGS := watchdog-simple
-
-all: $(PROGS)
-
-clean:
-	rm -fr $(PROGS)
-
+userprogs := watchdog-simple
+always-y := $(userprogs)
-- 
2.25.1

