Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A024E1BD332
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 05:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgD2Dqb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 23:46:31 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30769 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgD2Dq3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 23:46:29 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 03T3jXld020748;
        Wed, 29 Apr 2020 12:45:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 03T3jXld020748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588131936;
        bh=WBQb9o17jwks2q+W/7v/QOeyQ6f5Vl49pSP9RxSscFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qj4dcTxzA4cR1rfCMBDRwhvBsCoz2fV01j9pmFlKFPVsEZqqElGVW3gBenPwZud5m
         wvdIz21kl36mnoy8l7zIYL84hevwq2UAycuY16hLEuqCeZtMy5fT1vySUx5ztcsyws
         UHbRYV1eplt3JJh0OqzF1gAh2OyxdDjv96vJ0DCmCY6Yw/KS3TsiINndti7vDPqzYW
         3BOi6al6FiWcLDrUdMzorCeCE4/qNG9KHE/T5wEBITqA9mHD5LKzb3vkXxa2YNDFd0
         IFavpGOSAsWdq8yVrfUhkH426xe+FKJUkTvpk1r9KphZT2KSrOmfd8oKSmZyWo5Rgc
         JCHGXbXoQ0s8Q==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf <bpf@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 02/15] kbuild: add infrastructure to build userspace programs
Date:   Wed, 29 Apr 2020 12:45:14 +0900
Message-Id: <20200429034527.590520-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200429034527.590520-1-masahiroy@kernel.org>
References: <20200429034527.590520-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kbuild supports the infrastructure to build host programs, but there
was no support to build userspace programs for the target architecture
(i.e. the same architecture as the kernel).

Sam Ravnborg worked on this in 2014 (https://lkml.org/lkml/2014/7/13/154),
but it was not merged. One problem at that time was, there was no good way
to know whether $(CC) can link standalone programs. In fact, pre-built
kernel.org toolchains [1] are often used for building the kernel, but they
do not provide libc.

Now, we can handle this cleanly because the compiler capability is
evaluated at the Kconfig time. If $(CC) cannot link standalone programs,
the relevant options are hidden by 'depends on CC_CAN_LINK'.

The implementation just mimics scripts/Makefile.host

The userspace programs are compiled with the same flags as the host
programs. In addition, it uses -m32 or -m64 if it is found in
$(KBUILD_CFLAGS).

This new syntax has two usecases.

- Sample programs

  Several userspace programs under samples/ include UAPI headers
  installed in usr/include. Most of them were previously built for
  the host architecture just to use the 'hostprogs' syntax.

  However, 'make headers' always works for the target architecture.
  This caused the arch mismatch in cross-compiling. To fix this
  distortion, sample code should be built for the target architecture.

- Bpfilter

  net/bpfilter/Makefile compiles bpfilter_umh as the user mode helper,
  and embeds it into the kernel. Currently, it overrides HOSTCC with
  CC to use the 'hostprogs' syntax. This hack should go away.

[1]: https://mirrors.edge.kernel.org/pub/tools/crosstool/
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v2:
  - Rename 'user-ccflags' to 'userccflags'
    We use '<base-filename>-ccflags' for the per-file flag.
    'user-ccflags' would have a

 Makefile                   | 13 ++++++++---
 scripts/Makefile.build     |  6 +++++
 scripts/Makefile.clean     |  2 +-
 scripts/Makefile.userprogs | 45 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 4 deletions(-)
 create mode 100644 scripts/Makefile.userprogs

diff --git a/Makefile b/Makefile
index ee7773d5f4c9..9ff00bfe0575 100644
--- a/Makefile
+++ b/Makefile
@@ -406,9 +406,12 @@ else
 HOSTCC	= gcc
 HOSTCXX	= g++
 endif
-KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
-		-fomit-frame-pointer -std=gnu89 $(HOST_LFS_CFLAGS) \
-		$(HOSTCFLAGS)
+
+export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
+			      -O2 -fomit-frame-pointer -std=gnu89
+export KBUILD_USERLDFLAGS :=
+
+KBUILD_HOSTCFLAGS   := $(KBUILD_USERCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
 KBUILD_HOSTCXXFLAGS := -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
 KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
 KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
@@ -937,6 +940,10 @@ ifeq ($(CONFIG_RELR),y)
 LDFLAGS_vmlinux	+= --pack-dyn-relocs=relr
 endif
 
+# Align the bit size of userspace programs with the kernel
+KBUILD_USERCFLAGS  += $(filter -m32 -m64, $(KBUILD_CFLAGS))
+KBUILD_USERLDFLAGS += $(filter -m32 -m64, $(KBUILD_CFLAGS))
+
 # make the checker run with the right architecture
 CHECKFLAGS += --arch=$(ARCH)
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9fcbfac15d1d..3665b1a0bc8e 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -50,6 +50,12 @@ ifneq ($(hostprogs)$(hostcxxlibs-y)$(hostcxxlibs-m),)
 include scripts/Makefile.host
 endif
 
+# Do not include userprogs rules unless needed.
+userprogs := $(sort $(userprogs))
+ifneq ($(userprogs),)
+include scripts/Makefile.userprogs
+endif
+
 ifndef obj
 $(warning kbuild: Makefile.build is included improperly)
 endif
diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
index 075f0cc2d8d7..e2c76122319d 100644
--- a/scripts/Makefile.clean
+++ b/scripts/Makefile.clean
@@ -29,7 +29,7 @@ subdir-ymn	:= $(addprefix $(obj)/,$(subdir-ymn))
 
 __clean-files	:= $(extra-y) $(extra-m) $(extra-)       \
 		   $(always) $(always-y) $(always-m) $(always-) $(targets) $(clean-files)   \
-		   $(hostprogs) $(hostprogs-y) $(hostprogs-m) $(hostprogs-) \
+		   $(hostprogs) $(hostprogs-y) $(hostprogs-m) $(hostprogs-) $(userprogs) \
 		   $(hostcxxlibs-y) $(hostcxxlibs-m)
 
 __clean-files   := $(filter-out $(no-clean-files), $(__clean-files))
diff --git a/scripts/Makefile.userprogs b/scripts/Makefile.userprogs
new file mode 100644
index 000000000000..ebde030e7dd0
--- /dev/null
+++ b/scripts/Makefile.userprogs
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Build userspace programs for the target system
+#
+
+# Executables compiled from a single .c file
+user-csingle	:= $(foreach m, $(userprogs), $(if $($(m)-objs),,$(m)))
+
+# Executables linked based on several .o files
+user-cmulti	:= $(foreach m, $(userprogs), $(if $($(m)-objs),$(m)))
+
+# Objects compiled from .c files
+user-cobjs	:= $(sort $(foreach m, $(userprogs), $($(m)-objs)))
+
+user-csingle	:= $(addprefix $(obj)/, $(user-csingle))
+user-cmulti	:= $(addprefix $(obj)/, $(user-cmulti))
+user-cobjs	:= $(addprefix $(obj)/, $(user-cobjs))
+
+user_ccflags	= -Wp,-MMD,$(depfile) $(KBUILD_USERCFLAGS) $(userccflags) \
+			$($(target-stem)-ccflags)
+user_ldflags	= $(KBUILD_USERLDFLAGS) $(userldflags) $($(target-stem)-ldflags)
+
+# Create an executable from a single .c file
+quiet_cmd_user_cc_c = CC [U]  $@
+      cmd_user_cc_c = $(CC) $(user_ccflags) $(user_ldflags) -o $@ $< \
+		      $($(target-stem)-ldlibs)
+$(user-csingle): $(obj)/%: $(src)/%.c FORCE
+	$(call if_changed_dep,user_cc_c)
+
+# Link an executable based on list of .o files
+quiet_cmd_user_ld = LD [U]  $@
+      cmd_user_ld = $(CC) $(user_ldflags) -o \
+		    $@ $(addprefix $(obj)/, $($(target-stem)-objs)) \
+		    $($(target-stem)-ldlibs)
+$(user-cmulti): FORCE
+	$(call if_changed,user_ld)
+$(call multi_depend, $(user-cmulti), , -objs)
+
+# Create .o file from a .c file
+quiet_cmd_user_cc_o_c = CC [U]  $@
+      cmd_user_cc_o_c = $(CC) $(user_ccflags) -c -o $@ $<
+$(user-cobjs): $(obj)/%.o: $(src)/%.c FORCE
+	$(call if_changed_dep,user_cc_o_c)
+
+targets += $(user-csingle) $(user-cmulti) $(user-cobjs)
-- 
2.25.1

