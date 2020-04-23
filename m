Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19ED1B56A8
	for <lists+bpf@lfdr.de>; Thu, 23 Apr 2020 09:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgDWHvR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Apr 2020 03:51:17 -0400
Received: from condef-02.nifty.com ([202.248.20.67]:37758 "EHLO
        condef-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgDWHvQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Apr 2020 03:51:16 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-02.nifty.com with ESMTP id 03N7eXsq004974
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2020 16:40:33 +0900
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 03N7dV9Z000368;
        Thu, 23 Apr 2020 16:39:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 03N7dV9Z000368
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587627587;
        bh=hA9zKaYolCBXen9YqFKBxUtOtwyQMnhMjhiUYnYYBtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j3N5a4M/3pkD919qlPicRMxcgkvR8hut/hs/t+tK7ZIAr2tqSGDEr9LQDf087UNUR
         kj/A0Oini8KGUWlzLarA0l0peNzA3qLMP8a6KoY3Tr5+0pqBre3p3kajWxLZ23JlHR
         xEskoeVk0jMj+mBH/pQtpOJ42ck9CFmMP1cRZCUQCnUcAq1yiQum1gcsi7OfQzJJ1r
         eW+kNQ0WSYt6/1tJa1U3k+uWZiU5cjP5EsmNvhTiwm6aKYnZh7OQSek5cs5Es8BJIo
         hyG27PQOQ5vcdZHgctN1vhTRTA3naqLyRw6tU1O1kz+8/iVH7Th3hS8OL5jX0HRE28
         Pqwc7TTw11xEQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/16] samples: auxdisplay: use 'userprogs' syntax
Date:   Thu, 23 Apr 2020 16:39:27 +0900
Message-Id: <20200423073929.127521-15-masahiroy@kernel.org>
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

 samples/Kconfig             |  4 ++++
 samples/Makefile            |  1 +
 samples/auxdisplay/Makefile | 11 ++---------
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index b9dafee5d3af..cdb0091e4734 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -6,6 +6,10 @@ menuconfig SAMPLES
 
 if SAMPLES
 
+config SAMPLE_AUXDISPLAY
+	bool "auxdisplay sample"
+	depends on CC_CAN_LINK
+
 config SAMPLE_TRACE_EVENTS
 	tristate "Build trace_events examples -- loadable modules only"
 	depends on EVENT_TRACING && m
diff --git a/samples/Makefile b/samples/Makefile
index bdc168405452..0c43b5d34b15 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for Linux samples code
 
+subdir-$(CONFIG_SAMPLE_AUXDISPLAY)	+= auxdisplay
 obj-$(CONFIG_SAMPLE_ANDROID_BINDERFS)	+= binderfs/
 obj-$(CONFIG_SAMPLE_CONFIGFS)		+= configfs/
 obj-$(CONFIG_SAMPLE_CONNECTOR)		+= connector/
diff --git a/samples/auxdisplay/Makefile b/samples/auxdisplay/Makefile
index 0273bab27233..dbdf939af94a 100644
--- a/samples/auxdisplay/Makefile
+++ b/samples/auxdisplay/Makefile
@@ -1,10 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-CC := $(CROSS_COMPILE)gcc
-CFLAGS := -I../../usr/include
-
-PROGS := cfag12864b-example
-
-all: $(PROGS)
-
-clean:
-	rm -fr $(PROGS)
+userprogs := cfag12864b-example
+always-y := $(userprogs)
-- 
2.25.1

