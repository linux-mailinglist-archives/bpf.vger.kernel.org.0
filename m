Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8048C1BD313
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 05:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgD2Dqa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 23:46:30 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30777 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgD2Dq3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 23:46:29 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 03T3jXlf020748;
        Wed, 29 Apr 2020 12:45:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 03T3jXlf020748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588131937;
        bh=r0ApJvTUQqdiwCwVmjqPXR9YcqLdN3Uq3b73eGZxmw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KEqe3QK+R6INyBwdvUQsDfE97eXkBSzP572rVxsAkwTchj/QZAkBUC8ZPM4AFhDxa
         jmiNA7urCiRW+4L8+HzBOj4C502HprAKDvl2w7H8IX5gcouWiSyPVttXL9xgUpTh4t
         IwFNzW2D0vBc31jNeQBqEgU/d4fxDdhPvH6SjzXi7Nry+ninTc6b3eqVM/Tk39swgM
         Lz+c3RfavIVCfn5jEOtm2iTfuqe4ICU9raqGD1RoFLkrNur3qL1pSyoz6x7nt8/5BT
         oCnQMpWUYgcdNvhe3r2BWOdIw85+dE2tECFcuLFoV8Unq7/HHbDVbCRS1aX1P61fRk
         OIHsVEEqjJ2pg==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf <bpf@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 04/15] samples: seccomp: build sample programs for target architecture
Date:   Wed, 29 Apr 2020 12:45:16 +0900
Message-Id: <20200429034527.590520-5-masahiroy@kernel.org>
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

The 'ifndef CROSS_COMPILE' is no longer needed.

BTW, the -m31 for s390 is left-over code. Commit 5a79859ae0f3 ("s390:
remove 31 bit support") killed it.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v2: None

 samples/Kconfig          |  2 +-
 samples/seccomp/Makefile | 42 +++-------------------------------------
 2 files changed, 4 insertions(+), 40 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index 9d236c346de5..8949e9646125 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -126,7 +126,7 @@ config SAMPLE_PIDFD
 
 config SAMPLE_SECCOMP
 	bool "Build seccomp sample code"
-	depends on SECCOMP_FILTER && HEADERS_INSTALL
+	depends on SECCOMP_FILTER && CC_CAN_LINK && HEADERS_INSTALL
 	help
 	  Build samples of seccomp filters using various methods of
 	  BPF filter construction.
diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
index 89279e8b87df..75916c23e416 100644
--- a/samples/seccomp/Makefile
+++ b/samples/seccomp/Makefile
@@ -1,44 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef CROSS_COMPILE
-hostprogs := bpf-fancy dropper bpf-direct user-trap
+userprogs := bpf-fancy dropper bpf-direct user-trap
 
-HOSTCFLAGS_bpf-fancy.o += -I$(objtree)/usr/include
-HOSTCFLAGS_bpf-fancy.o += -idirafter $(objtree)/include
-HOSTCFLAGS_bpf-helper.o += -I$(objtree)/usr/include
-HOSTCFLAGS_bpf-helper.o += -idirafter $(objtree)/include
 bpf-fancy-objs := bpf-fancy.o bpf-helper.o
 
-HOSTCFLAGS_dropper.o += -I$(objtree)/usr/include
-HOSTCFLAGS_dropper.o += -idirafter $(objtree)/include
-dropper-objs := dropper.o
+userccflags += -I usr/include
 
-HOSTCFLAGS_bpf-direct.o += -I$(objtree)/usr/include
-HOSTCFLAGS_bpf-direct.o += -idirafter $(objtree)/include
-bpf-direct-objs := bpf-direct.o
-
-HOSTCFLAGS_user-trap.o += -I$(objtree)/usr/include
-HOSTCFLAGS_user-trap.o += -idirafter $(objtree)/include
-user-trap-objs := user-trap.o
-
-# Try to match the kernel target.
-ifndef CONFIG_64BIT
-
-# s390 has -m31 flag to build 31 bit binaries
-ifndef CONFIG_S390
-MFLAG = -m32
-else
-MFLAG = -m31
-endif
-
-HOSTCFLAGS_bpf-direct.o += $(MFLAG)
-HOSTCFLAGS_dropper.o += $(MFLAG)
-HOSTCFLAGS_bpf-helper.o += $(MFLAG)
-HOSTCFLAGS_bpf-fancy.o += $(MFLAG)
-HOSTCFLAGS_user-trap.o += $(MFLAG)
-HOSTLDLIBS_bpf-direct += $(MFLAG)
-HOSTLDLIBS_bpf-fancy += $(MFLAG)
-HOSTLDLIBS_dropper += $(MFLAG)
-HOSTLDLIBS_user-trap += $(MFLAG)
-endif
-always-y := $(hostprogs)
-endif
+always-y := $(userprogs)
-- 
2.25.1

