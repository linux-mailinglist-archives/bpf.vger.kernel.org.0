Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5073415EB26
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2020 18:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391823AbgBNRSy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Feb 2020 12:18:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390405AbgBNQK4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Feb 2020 11:10:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B191A24695;
        Fri, 14 Feb 2020 16:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696656;
        bh=9QBWaElHKC0zBpOGCtZQxcNbGjkEOVXoSNV7W+soaiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iOfrwb5rJ/XOgt8vfoazqjCT6WCNcIEG3kVMzYF4BxoiHTg0n1kz+rvXzSUrhIYJJ
         6QNS4oxJGcLq8eohf6Fv3ojPGfHqJrzauN4PAdhzIwJRm9Vv7IbNh/ZNeAaBEGUkzq
         jE63JdDmsq91aRd5/YwMy3DuqwG/24r/nokeawDk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 430/459] powerpc: Do not consider weak unresolved symbol relocations as bad
Date:   Fri, 14 Feb 2020 11:01:20 -0500
Message-Id: <20200214160149.11681-430-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexandre Ghiti <alex@ghiti.fr>

[ Upstream commit 43e76cd368fbb67e767da5363ffeaa3989993c8c ]

Commit 8580ac9404f6 ("bpf: Process in-kernel BTF") introduced two weak
symbols that may be unresolved at link time which result in an absolute
relocation to 0. relocs_check.sh emits the following warning:

"WARNING: 2 bad relocations
c000000001a41478 R_PPC64_ADDR64    _binary__btf_vmlinux_bin_start
c000000001a41480 R_PPC64_ADDR64    _binary__btf_vmlinux_bin_end"

whereas those relocations are legitimate even for a relocatable kernel
compiled with -pie option.

relocs_check.sh already excluded some weak unresolved symbols explicitly:
remove those hardcoded symbols and add some logic that parses the symbols
using nm, retrieves all the weak unresolved symbols and excludes those from
the list of the potential bad relocations.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200118170335.21440-1-alex@ghiti.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/Makefile.postlink     |  4 ++--
 arch/powerpc/tools/relocs_check.sh | 20 ++++++++++++--------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/Makefile.postlink b/arch/powerpc/Makefile.postlink
index 134f12f89b92b..2268396ff4bba 100644
--- a/arch/powerpc/Makefile.postlink
+++ b/arch/powerpc/Makefile.postlink
@@ -17,11 +17,11 @@ quiet_cmd_head_check = CHKHEAD $@
 quiet_cmd_relocs_check = CHKREL  $@
 ifdef CONFIG_PPC_BOOK3S_64
       cmd_relocs_check =						\
-	$(CONFIG_SHELL) $(srctree)/arch/powerpc/tools/relocs_check.sh "$(OBJDUMP)" "$@" ; \
+	$(CONFIG_SHELL) $(srctree)/arch/powerpc/tools/relocs_check.sh "$(OBJDUMP)" "$(NM)" "$@" ; \
 	$(BASH) $(srctree)/arch/powerpc/tools/unrel_branch_check.sh "$(OBJDUMP)" "$@"
 else
       cmd_relocs_check =						\
-	$(CONFIG_SHELL) $(srctree)/arch/powerpc/tools/relocs_check.sh "$(OBJDUMP)" "$@"
+	$(CONFIG_SHELL) $(srctree)/arch/powerpc/tools/relocs_check.sh "$(OBJDUMP)" "$(NM)" "$@"
 endif
 
 # `@true` prevents complaint when there is nothing to be done
diff --git a/arch/powerpc/tools/relocs_check.sh b/arch/powerpc/tools/relocs_check.sh
index 7b9fe0a567cf3..014e00e74d2b6 100755
--- a/arch/powerpc/tools/relocs_check.sh
+++ b/arch/powerpc/tools/relocs_check.sh
@@ -10,14 +10,21 @@
 # based on relocs_check.pl
 # Copyright © 2009 IBM Corporation
 
-if [ $# -lt 2 ]; then
-	echo "$0 [path to objdump] [path to vmlinux]" 1>&2
+if [ $# -lt 3 ]; then
+	echo "$0 [path to objdump] [path to nm] [path to vmlinux]" 1>&2
 	exit 1
 fi
 
-# Have Kbuild supply the path to objdump so we handle cross compilation.
+# Have Kbuild supply the path to objdump and nm so we handle cross compilation.
 objdump="$1"
-vmlinux="$2"
+nm="$2"
+vmlinux="$3"
+
+# Remove from the bad relocations those that match an undefined weak symbol
+# which will result in an absolute relocation to 0.
+# Weak unresolved symbols are of that form in nm output:
+# "                  w _binary__btf_vmlinux_bin_end"
+undef_weak_symbols=$($nm "$vmlinux" | awk '$1 ~ /w/ { print $2 }')
 
 bad_relocs=$(
 $objdump -R "$vmlinux" |
@@ -26,8 +33,6 @@ $objdump -R "$vmlinux" |
 	# These relocations are okay
 	# On PPC64:
 	#	R_PPC64_RELATIVE, R_PPC64_NONE
-	#	R_PPC64_ADDR64 mach_<name>
-	#	R_PPC64_ADDR64 __crc_<name>
 	# On PPC:
 	#	R_PPC_RELATIVE, R_PPC_ADDR16_HI,
 	#	R_PPC_ADDR16_HA,R_PPC_ADDR16_LO,
@@ -39,8 +44,7 @@ R_PPC_ADDR16_HI
 R_PPC_ADDR16_HA
 R_PPC_RELATIVE
 R_PPC_NONE' |
-	grep -E -v '\<R_PPC64_ADDR64[[:space:]]+mach_' |
-	grep -E -v '\<R_PPC64_ADDR64[[:space:]]+__crc_'
+	([ "$undef_weak_symbols" ] && grep -F -w -v "$undef_weak_symbols" || cat)
 )
 
 if [ -z "$bad_relocs" ]; then
-- 
2.20.1

