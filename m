Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A417F1BD321
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 05:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgD2Dqr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 23:46:47 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30983 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgD2Dqh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 23:46:37 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 03T3jXll020748;
        Wed, 29 Apr 2020 12:45:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 03T3jXll020748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588131942;
        bh=ql9A5u0r309svDQxV0TZAKpz7MrANkT7/8YqyeG+d5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y5kDkxObJS0XPZp7CRKqCAe4Cy0Etp3uf+bfb6KxPGVlt0uVAweq8dXYVOW75FfCL
         HhBOm4PNLQjcidOCI27AUBWhLsh3idjio1GT7WwHU/3CwQSth3XXjkCDx19nOyhiF8
         dbCkW/01cv+kCQG8E+88V11Js7TSHbeXjeJSvZpRTn9kQBV072S+VTpA5zVWfZ11p8
         Fq0FaXcVD9ZyJ+X7OOfJLQ+PXXMV0r7c/xnZv8cvEmoFtJXC1J/+T9g7z3Wu5pMuQJ
         x+q2KU+tuk1M3Un8RkGCokmf0JyMitDNXoIqa8nVVpd/1q7qJcKMzphLjHvWQr9WD1
         RgWGRKRsPTPJg==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf <bpf@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 10/15] samples: vfs: build sample programs for target architecture
Date:   Wed, 29 Apr 2020 12:45:22 +0900
Message-Id: <20200429034527.590520-11-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200429034527.590520-1-masahiroy@kernel.org>
References: <20200429034527.590520-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These userspace programs include UAPI headers exported to usr/include/.
'make headers' always works for the target architecture (i.e. the same
architecture as the kernel), so the sample programs should be built for
the target as well. Kbuild now supports 'userprogs' for that.

I also guarded the CONFIG option by 'depends on CC_CAN_LINK' because
$(CC) may not provide libc.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v2: None

 samples/Kconfig      |  2 +-
 samples/vfs/Makefile | 11 +++--------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index 08f2d025ca05..831a7ecd3352 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -184,7 +184,7 @@ config SAMPLE_ANDROID_BINDERFS
 
 config SAMPLE_VFS
 	bool "Build example programs that use new VFS system calls"
-	depends on HEADERS_INSTALL
+	depends on CC_CAN_LINK && HEADERS_INSTALL
 	help
 	  Build example userspace programs that use new VFS system calls such
 	  as mount API and statx().  Note that this is restricted to the x86
diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
index 65acdde5c117..00b6824f9237 100644
--- a/samples/vfs/Makefile
+++ b/samples/vfs/Makefile
@@ -1,10 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-# List of programs to build
-hostprogs := \
-	test-fsmount \
-	test-statx
+userprogs := test-fsmount test-statx
+always-y := $(userprogs)
 
-always-y := $(hostprogs)
-
-HOSTCFLAGS_test-fsmount.o += -I$(objtree)/usr/include
-HOSTCFLAGS_test-statx.o += -I$(objtree)/usr/include
+userccflags += -I usr/include
-- 
2.25.1

