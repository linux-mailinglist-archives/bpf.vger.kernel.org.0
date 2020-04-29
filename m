Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8E11BD315
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 05:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgD2Dqa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 23:46:30 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30765 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgD2Dq3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 23:46:29 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 03T3jXlc020748;
        Wed, 29 Apr 2020 12:45:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 03T3jXlc020748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588131935;
        bh=a/8yLvdu6xS3Gj2bx6HeWvVtgMKV8ZR+HSeVW/CO80E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHXkufn8HbfXGioq28uVr88OWCXL5Rx7FVk0ASGpkAQE0zd9aZwVSjkgojnGDG5cp
         nPZhkMa9l9cy+RfgkE+Bx6MXNiSMCg5K9b77C7LgZyNNYV9ksEowrBzAJ25oCWRVMu
         e8QuXw573q+aw6j15TCxTkGULcogeT5smoP35iqyBsRN3ZvUSTuYQTe8HE+2mv2kZZ
         jTD4IqsTa0Xjkj6DuLjOGyUrmV0u2xQRfhEN2Y3rKOe7svt/GA9EinxUdns8fodC2f
         zFycDImm+xZyKhDwa8qNjYyRRN8WRJW3vhK5gESXaK8azIfLO2+uY7JgYb/lZCQn9E
         Z2xUkuYoEEmuQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf <bpf@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 01/15] bpfilter: match bit size of bpfilter_umh to that of the kernel
Date:   Wed, 29 Apr 2020 12:45:13 +0900
Message-Id: <20200429034527.590520-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200429034527.590520-1-masahiroy@kernel.org>
References: <20200429034527.590520-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpfilter_umh is built for the default machine bit of the compiler,
which may not match to the bit size of the kernel.

This happens in the scenario below:

You can use biarch GCC that defaults to 64-bit for building the 32-bit
kernel. In this case, Kbuild passes -m32 to teach the compiler to
produce 32-bit kernel space objects. However, it is missing when
building bpfilter_umh. It is built as a 64-bit ELF, and then embedded
into the 32-bit kernel.

The 32-bit kernel and 64-bit umh is a bad combination.

In theory, we can have 32-bit umh running on 64-bit kernel, but we do
not have a good reason to support such a usecase.

The best is to match the bit size between them.

Pass -m32 or -m64 to the umh build command if it is found in
$(KBUILD_CFLAGS). Evaluate CC_CAN_LINK against the kernel bit-size.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - New patch

 init/Kconfig          | 4 +++-
 net/bpfilter/Makefile | 5 +++--
 usr/include/Makefile  | 4 ++++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index a494212a3a79..57562a8e2761 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -45,7 +45,9 @@ config CLANG_VERSION
 	default $(shell,$(srctree)/scripts/clang-version.sh $(CC))
 
 config CC_CAN_LINK
-	def_bool $(success,$(srctree)/scripts/cc-can-link.sh $(CC))
+	bool
+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(m64-flag)) if 64BIT
+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(m32-flag))
 
 config CC_HAS_ASM_GOTO
 	def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
index 36580301da70..f6209e4827b9 100644
--- a/net/bpfilter/Makefile
+++ b/net/bpfilter/Makefile
@@ -5,14 +5,15 @@
 
 hostprogs := bpfilter_umh
 bpfilter_umh-objs := main.o
-KBUILD_HOSTCFLAGS += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi
+KBUILD_HOSTCFLAGS += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi \
+			$(filter -m32 -m64, $(KBUILD_CFLAGS))
 HOSTCC := $(CC)
 
 ifeq ($(CONFIG_BPFILTER_UMH), y)
 # builtin bpfilter_umh should be compiled with -static
 # since rootfs isn't mounted at the time of __init
 # function is called and do_execv won't find elf interpreter
-KBUILD_HOSTLDFLAGS += -static
+KBUILD_HOSTLDFLAGS += -static $(filter -m32 -m64, $(KBUILD_CFLAGS))
 endif
 
 $(obj)/bpfilter_umh_blob.o: $(obj)/bpfilter_umh
diff --git a/usr/include/Makefile b/usr/include/Makefile
index 5a7ee3e5ed86..55362f3ab393 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -8,6 +8,10 @@
 # We cannot go as far as adding -Wpedantic since it emits too many warnings.
 UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration
 
+# In theory, we do not care -m32 or -m64 for header compile tests.
+# It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m64.
+UAPI_CFLAGS += $(filter -m32 -m64, $(KBUILD_CFLAGS))
+
 override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
 
 # The following are excluded for now because they fail to build.
-- 
2.25.1

