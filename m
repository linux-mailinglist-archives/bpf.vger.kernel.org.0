Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CEE1BD33D
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 05:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgD2DrW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 23:47:22 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30764 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgD2Dq2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 23:46:28 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 03T3jXlj020748;
        Wed, 29 Apr 2020 12:45:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 03T3jXlj020748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588131940;
        bh=qf2+zEQEuF8SgfIntsv9BASpYGvM27L/RyYRNFP16ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NXKxpfSe9kB+g4C67Az4wxu36qpOc8qpOtcsL0g+ZRS/P/ixie8D9uVse6AuJJXsA
         qa7dNkL2mckFc7xBby8GzkxRxm93iwDu6Rs0Z/iqYqugA9HbmmXjGk2YO1yMdCavla
         zdarbHX5lWuIohhHY1anZ0LDNE1k8ZK4Hx1n90qjsc0gil2XlHaJxShpW4EBP0aVxI
         J80qFa56U1l76Xd5Vlt5exNhOTh60XwCUp/Mty3pyESyRhhS5if2I95EVr5H21MkN0
         smLpKyz7upZp3XXKv5ABv19YXVSJVrl/BqLKv7pKPkmKkZzlPb7u6Eb25XIETmDvMu
         ISnDJU/+vCgEw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf <bpf@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 08/15] samples: hidraw: build sample program for target architecture
Date:   Wed, 29 Apr 2020 12:45:20 +0900
Message-Id: <20200429034527.590520-9-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200429034527.590520-1-masahiroy@kernel.org>
References: <20200429034527.590520-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This userspace program includes UAPI headers exported to usr/include/.
'make headers' always works for the target architecture (i.e. the same
architecture as the kernel), so the sample program should be built for
the target as well. Kbuild now supports 'userprogs' for that.

I also guarded the CONFIG option by 'depends on CC_CAN_LINK' because
$(CC) may not provide libc.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v2: None

 samples/Kconfig         | 2 +-
 samples/hidraw/Makefile | 9 +++------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index 2560e87c9cae..08f2d025ca05 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -118,7 +118,7 @@ config SAMPLE_CONNECTOR
 
 config SAMPLE_HIDRAW
 	bool "hidraw sample"
-	depends on HEADERS_INSTALL
+	depends on CC_CAN_LINK && HEADERS_INSTALL
 
 config SAMPLE_PIDFD
 	bool "pidfd sample"
diff --git a/samples/hidraw/Makefile b/samples/hidraw/Makefile
index 8bd25f77671f..d2c77ed60b39 100644
--- a/samples/hidraw/Makefile
+++ b/samples/hidraw/Makefile
@@ -1,8 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-# List of programs to build
-hostprogs := hid-example
-always-y := $(hostprogs)
+userprogs := hid-example
+always-y := $(userprogs)
 
-HOSTCFLAGS_hid-example.o += -I$(objtree)/usr/include
-
-all: hid-example
+userccflags += -I usr/include
-- 
2.25.1

