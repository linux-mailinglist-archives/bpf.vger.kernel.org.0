Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF0C1BD334
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 05:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgD2DrR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 23:47:17 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30770 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgD2Dqa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 23:46:30 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 03T3jXlg020748;
        Wed, 29 Apr 2020 12:45:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 03T3jXlg020748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588131938;
        bh=KRoJ28fBPWwER6j/odgqbI8QrOokFQHx14JFyOUYWz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMvjoZ2LOKlbdRc9gV2DdmyU/9tMh+9Q1rM+Ppz4IroQikJj16OvSK4fx2cOBE4gt
         50vIGDXapLiTdSNt4yQ0pjM2Z8vjqHpUB0fUEeNJ0orMBgKn4hErFsUXX2NRoiqlss
         95RhplEHKUHu2As9Y4Bn6x1N4HRSOP2s2OpDU4dlitXetsHrrJx98nf53if6f9+Bkp
         ptjTF4rUsBj+Avvx3kMM9wkthMzWW8OqAZ7fPsSaGle5/UAH/6mjkVY9fHlNUVEnhH
         TOQfE3f2Wu1ozVVhb0BgfgHASEVju6uUYiFC/xHY9cu2uAuJ+d/tfAbsW8HYgG7I2M
         lZm3pFiJLzPug==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf <bpf@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 05/15] kbuild: doc: document the new syntax 'userprogs'
Date:   Wed, 29 Apr 2020 12:45:17 +0900
Message-Id: <20200429034527.590520-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200429034527.590520-1-masahiroy@kernel.org>
References: <20200429034527.590520-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kbuild now supports the syntax 'userprogs' to compile userspace
programs for the same architecture as the kernel.

Insert the section '5 Userspace Program support' to explain it.

I copy-pasted '4 Host Program support' and fixed it up.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v2: None

 Documentation/kbuild/makefiles.rst | 183 +++++++++++++++++++++--------
 1 file changed, 135 insertions(+), 48 deletions(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index b80257a03830..234492351031 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -29,31 +29,37 @@ This document describes the Linux kernel Makefiles.
 	   --- 4.4 Controlling compiler options for host programs
 	   --- 4.5 When host programs are actually built
 
-	=== 5 Kbuild clean infrastructure
-
-	=== 6 Architecture Makefiles
-	   --- 6.1 Set variables to tweak the build to the architecture
-	   --- 6.2 Add prerequisites to archheaders:
-	   --- 6.3 Add prerequisites to archprepare:
-	   --- 6.4 List directories to visit when descending
-	   --- 6.5 Architecture-specific boot images
-	   --- 6.6 Building non-kbuild targets
-	   --- 6.7 Commands useful for building a boot image
-	   --- 6.8 Custom kbuild commands
-	   --- 6.9 Preprocessing linker scripts
-	   --- 6.10 Generic header files
-	   --- 6.11 Post-link pass
-
-	=== 7 Kbuild syntax for exported headers
-		--- 7.1 no-export-headers
-		--- 7.2 generic-y
-		--- 7.3 generated-y
-		--- 7.4 mandatory-y
-
-	=== 8 Kbuild Variables
-	=== 9 Makefile language
-	=== 10 Credits
-	=== 11 TODO
+	=== 5 Userspace Program support
+	   --- 5.1 Simple Userspace Program
+	   --- 5.2 Composite Userspace Programs
+	   --- 5.3 Controlling compiler options for userspace programs
+	   --- 5.4 When userspace programs are actually built
+
+	=== 6 Kbuild clean infrastructure
+
+	=== 7 Architecture Makefiles
+	   --- 7.1 Set variables to tweak the build to the architecture
+	   --- 7.2 Add prerequisites to archheaders:
+	   --- 7.3 Add prerequisites to archprepare:
+	   --- 7.4 List directories to visit when descending
+	   --- 7.5 Architecture-specific boot images
+	   --- 7.6 Building non-kbuild targets
+	   --- 7.7 Commands useful for building a boot image
+	   --- 7.8 Custom kbuild commands
+	   --- 7.9 Preprocessing linker scripts
+	   --- 7.10 Generic header files
+	   --- 7.11 Post-link pass
+
+	=== 8 Kbuild syntax for exported headers
+		--- 8.1 no-export-headers
+		--- 8.2 generic-y
+		--- 8.3 generated-y
+		--- 8.4 mandatory-y
+
+	=== 9 Kbuild Variables
+	=== 10 Makefile language
+	=== 11 Credits
+	=== 12 TODO
 
 1 Overview
 ==========
@@ -732,7 +738,88 @@ Both possibilities are described in the following.
 	This will tell kbuild to build lxdialog even if not referenced in
 	any rule.
 
-5 Kbuild clean infrastructure
+5 Userspace Program support
+===========================
+
+Just like host programs, Kbuild also supports building userspace executables
+for the target architecture (i.e. the same architecture as you are building
+the kernel for).
+
+The syntax is quite similar. The difference is to use "userprogs" instead of
+"hostprogs".
+
+5.1 Simple Userspace Program
+----------------------------
+
+	The following line tells kbuild that the program bpf-direct shall be
+	built for the target architecture.
+
+	Example::
+
+		userprogs := bpf-direct
+
+	Kbuild assumes in the above example that bpf-direct is made from a
+	single C source file named bpf-direct.c located in the same directory
+	as the Makefile.
+
+5.2 Composite Userspace Programs
+--------------------------------
+
+	Userspace programs can be made up based on composite objects.
+	The syntax used to define composite objects for userspace programs is
+	similar to the syntax used for kernel objects.
+	$(<executable>-objs) lists all objects used to link the final
+	executable.
+
+	Example::
+
+		#samples/seccomp/Makefile
+		userprogs      := bpf-fancy
+		bpf-fancy-objs := bpf-fancy.o bpf-helper.o
+
+	Objects with extension .o are compiled from the corresponding .c
+	files. In the above example, bpf-fancy.c is compiled to bpf-fancy.o
+	and bpf-helper.c is compiled to bpf-helper.o.
+
+	Finally, the two .o files are linked to the executable, bpf-fancy.
+	Note: The syntax <executable>-y is not permitted for userspace programs.
+
+5.3 Controlling compiler options for userspace programs
+-------------------------------------------------------
+
+	When compiling userspace programs, it is possible to set specific flags.
+	The programs will always be compiled utilising $(CC) passed
+	the options specified in $(KBUILD_USERCFLAGS).
+	To set flags that will take effect for all userspace programs created
+	in that Makefile, use the variable userccflags.
+
+	Example::
+
+		# samples/seccomp/Makefile
+		userccflags += -I usr/include
+
+	To set specific flags for a single file the following construction
+	is used:
+
+	Example::
+
+		bpf-helper-ccflags += -I user/include
+
+	It is also possible to specify additional options to the linker.
+
+	Example::
+
+		# net/bpfilter/Makefile
+		bpfilter_umh-ldflags += -static
+
+	When linking bpfilter_umh, it will be passed the extra option -static.
+
+5.4 When userspace programs are actually built
+----------------------------------------------
+
+	Same as "When host programs are actually built".
+
+6 Kbuild clean infrastructure
 =============================
 
 "make clean" deletes most generated files in the obj tree where the kernel
@@ -790,7 +877,7 @@ is not operational at that point.
 Note 2: All directories listed in core-y, libs-y, drivers-y and net-y will
 be visited during "make clean".
 
-6 Architecture Makefiles
+7 Architecture Makefiles
 ========================
 
 The top level Makefile sets up the environment and does the preparation,
@@ -820,7 +907,7 @@ When kbuild executes, the following steps are followed (roughly):
    - Preparing initrd images and the like
 
 
-6.1 Set variables to tweak the build to the architecture
+7.1 Set variables to tweak the build to the architecture
 --------------------------------------------------------
 
     LDFLAGS
@@ -967,7 +1054,7 @@ When kbuild executes, the following steps are followed (roughly):
 	KBUILD_VMLINUX_LIBS together specify all the object files used to
 	link vmlinux.
 
-6.2 Add prerequisites to archheaders
+7.2 Add prerequisites to archheaders
 ------------------------------------
 
 	The archheaders: rule is used to generate header files that
@@ -977,7 +1064,7 @@ When kbuild executes, the following steps are followed (roughly):
 	architecture itself.
 
 
-6.3 Add prerequisites to archprepare
+7.3 Add prerequisites to archprepare
 ------------------------------------
 
 	The archprepare: rule is used to list prerequisites that need to be
@@ -995,7 +1082,7 @@ When kbuild executes, the following steps are followed (roughly):
 	generating offset header files.
 
 
-6.4 List directories to visit when descending
+7.4 List directories to visit when descending
 ---------------------------------------------
 
 	An arch Makefile cooperates with the top Makefile to define variables
@@ -1030,7 +1117,7 @@ When kbuild executes, the following steps are followed (roughly):
 		drivers-$(CONFIG_OPROFILE)  += arch/sparc64/oprofile/
 
 
-6.5 Architecture-specific boot images
+7.5 Architecture-specific boot images
 -------------------------------------
 
 	An arch Makefile specifies goals that take the vmlinux file, compress
@@ -1085,7 +1172,7 @@ When kbuild executes, the following steps are followed (roughly):
 
 	When "make" is executed without arguments, bzImage will be built.
 
-6.6 Building non-kbuild targets
+7.6 Building non-kbuild targets
 -------------------------------
 
     extra-y
@@ -1108,7 +1195,7 @@ When kbuild executes, the following steps are followed (roughly):
 	In this example, extra-y is used to list object files that
 	shall be built, but shall not be linked as part of built-in.a.
 
-6.7 Commands useful for building a boot image
+7.7 Commands useful for building a boot image
 ---------------------------------------------
 
     Kbuild provides a few macros that are useful when building a
@@ -1211,7 +1298,7 @@ When kbuild executes, the following steps are followed (roughly):
 		targets += $(dtb-y)
 		DTC_FLAGS ?= -p 1024
 
-6.8 Custom kbuild commands
+7.8 Custom kbuild commands
 --------------------------
 
 	When kbuild is executing with KBUILD_VERBOSE=0, then only a shorthand
@@ -1241,7 +1328,7 @@ When kbuild executes, the following steps are followed (roughly):
 	will be displayed with "make KBUILD_VERBOSE=0".
 
 
-6.9 Preprocessing linker scripts
+7.9 Preprocessing linker scripts
 --------------------------------
 
 	When the vmlinux image is built, the linker script
@@ -1274,7 +1361,7 @@ When kbuild executes, the following steps are followed (roughly):
 	The kbuild infrastructure for `*lds` files is used in several
 	architecture-specific files.
 
-6.10 Generic header files
+7.10 Generic header files
 -------------------------
 
 	The directory include/asm-generic contains the header files
@@ -1283,7 +1370,7 @@ When kbuild executes, the following steps are followed (roughly):
 	to list the file in the Kbuild file.
 	See "7.2 generic-y" for further info on syntax etc.
 
-6.11 Post-link pass
+7.11 Post-link pass
 -------------------
 
 	If the file arch/xxx/Makefile.postlink exists, this makefile
@@ -1299,7 +1386,7 @@ When kbuild executes, the following steps are followed (roughly):
 	For example, powerpc uses this to check relocation sanity of
 	the linked vmlinux file.
 
-7 Kbuild syntax for exported headers
+8 Kbuild syntax for exported headers
 ------------------------------------
 
 The kernel includes a set of headers that is exported to userspace.
@@ -1319,14 +1406,14 @@ A Kbuild file may be defined under arch/<arch>/include/uapi/asm/ and
 arch/<arch>/include/asm/ to list asm files coming from asm-generic.
 See subsequent chapter for the syntax of the Kbuild file.
 
-7.1 no-export-headers
+8.1 no-export-headers
 ---------------------
 
 	no-export-headers is essentially used by include/uapi/linux/Kbuild to
 	avoid exporting specific headers (e.g. kvm.h) on architectures that do
 	not support it. It should be avoided as much as possible.
 
-7.2 generic-y
+8.2 generic-y
 -------------
 
 	If an architecture uses a verbatim copy of a header from
@@ -1356,7 +1443,7 @@ See subsequent chapter for the syntax of the Kbuild file.
 
 			#include <asm-generic/termios.h>
 
-7.3 generated-y
+8.3 generated-y
 ---------------
 
 	If an architecture generates other header files alongside generic-y
@@ -1370,7 +1457,7 @@ See subsequent chapter for the syntax of the Kbuild file.
 			#arch/x86/include/asm/Kbuild
 			generated-y += syscalls_32.h
 
-7.4 mandatory-y
+8.4 mandatory-y
 ---------------
 
 	mandatory-y is essentially used by include/(uapi/)asm-generic/Kbuild
@@ -1380,7 +1467,7 @@ See subsequent chapter for the syntax of the Kbuild file.
 	in arch/$(ARCH)/include/(uapi/)/asm, Kbuild will automatically generate
 	a wrapper of the asm-generic one.
 
-8 Kbuild Variables
+9 Kbuild Variables
 ==================
 
 The top Makefile exports the following variables:
@@ -1438,8 +1525,8 @@ The top Makefile exports the following variables:
 	command.
 
 
-9 Makefile language
-===================
+10 Makefile language
+====================
 
 The kernel Makefiles are designed to be run with GNU Make.  The Makefiles
 use only the documented features of GNU Make, but they do use many
@@ -1458,7 +1545,7 @@ time the left-hand side is used.
 There are some cases where "=" is appropriate.  Usually, though, ":="
 is the right choice.
 
-10 Credits
+11 Credits
 ==========
 
 - Original version made by Michael Elizabeth Chastain, <mailto:mec@shout.net>
@@ -1466,7 +1553,7 @@ is the right choice.
 - Updates by Sam Ravnborg <sam@ravnborg.org>
 - Language QA by Jan Engelhardt <jengelh@gmx.de>
 
-11 TODO
+12 TODO
 =======
 
 - Describe how kbuild supports shipped files with _shipped.
-- 
2.25.1

