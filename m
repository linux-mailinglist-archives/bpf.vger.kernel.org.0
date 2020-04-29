Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD5F1BD326
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 05:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgD2Dqs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 23:46:48 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:31325 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgD2Dqs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 23:46:48 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 03T3jXlo020748;
        Wed, 29 Apr 2020 12:45:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 03T3jXlo020748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588131944;
        bh=dLmTyR8PbYHKBJ+qBPitmqWoM4dT1Bxw91nAgF/GfEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqGnmpX/Pvk8aMX9m8Z5cx3ULpXwvI3Nq1XZuKOEISHUtLVaGH146hh97lciC+aSF
         D0ZSAHqRk+RDpFoHkQeKXfuD/q/ieP0ts+dn4AzrbFjbqCov4dARLYfMrYPl5CPcJq
         uyoNESUWOIUhNVl5dy+YNl5JbPDpOb8kmJGY8vwhasDTuQdOHgWgwiD3xKft7d5bLF
         l7Ry5AlMvpjtt9h6se7VvQsi/kBQkHrG9ZWdJEoMAnVzSHndQVgeriTiM0AIhP9DvY
         ySVIda7S0FvW4VGyr4paWpPu0/xx0nJG9C79A9zaZttPdT9VOkKMYFgfZuzT/oGK8j
         lMxJ0QXw1xMTA==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf <bpf@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH v2 13/15] samples: auxdisplay: use 'userprogs' syntax
Date:   Wed, 29 Apr 2020 12:45:25 +0900
Message-Id: <20200429034527.590520-14-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200429034527.590520-1-masahiroy@kernel.org>
References: <20200429034527.590520-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kbuild now supports the 'userprogs' syntax to compile userspace
programs for the same architecture as the kernel.

Add the entry to samples/Makefile to put this into the build bot
coverage.

I also added the CONFIG option guarded by 'depends on CC_CAN_LINK'
because $(CC) may not provide libc.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v2: None

 samples/Kconfig             |  4 ++++
 samples/Makefile            |  1 +
 samples/auxdisplay/Makefile | 11 ++---------
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index 69699db49675..2322e11e8b80 100644
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

