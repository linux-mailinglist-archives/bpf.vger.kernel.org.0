Return-Path: <bpf+bounces-76945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D81CC9E8C
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 01:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5301B3028FCF
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 00:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C506523185D;
	Thu, 18 Dec 2025 00:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n5AmJfNE"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE4921D3CD
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 00:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766018136; cv=none; b=W3IebFiQCHqMPM7YdcD6CqTL1U/Q9/ljVOkmVT0VMD/cTrdBlREQovaTwrFOlW2t2y24v3ku5QoJ12fC6Lz3hNVhJFZvPt+fO8UHDqMClsoHmyus390+xtyW30OwlLGZ+sWNU5ubHhlfrPFDakXPKw11k9Q0OJ3ZNToiFg6jPp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766018136; c=relaxed/simple;
	bh=oA8SvasnCfuPuQFotBCkwZ6tbneoozCTcWITfVa+3OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olavlvKjqjktvtuaNwBfhsU59wrEuvX/ewOKzy3jv8k5TiWP20oCBrYA8wKXhTRHqWIryRcMRByv+enfRhErbZhDLWfJmeLYi9H6BYaGCzva8zFSXI7n1HsFEo2JtJloh1hibllV6RcfAc45/RhfTanwP8B9A9oOSfKhGPv9jGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n5AmJfNE; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766018126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hg6c+99YvMcN9dWcNJBGsd9ljqc9EckgZFCGYae3QS4=;
	b=n5AmJfNEgSpoxzHhXCj3hy8MgZU1BJIa6XqgSOkcouXkEOEHTEpuED4uKehVxWRRzGJKyx
	aMWhcRaTAu1YO6mkYDNy4deCriVg+ope+n0PlmeL4Wy2OGBBaQIhIXCJsT4f8QH8tbuTkK
	bHfEONc9gVuoDx+8cLAEWNB/DYQXlGE=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Vernet <void@manifault.com>,
	Donglin Peng <dolinux.peng@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Nicolas Schier <nsc@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tejun Heo <tj@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,
	dwarves@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v4 8/8] resolve_btfids: Change in-place update with raw binary output
Date: Wed, 17 Dec 2025 16:33:14 -0800
Message-ID: <20251218003314.260269-9-ihor.solodrai@linux.dev>
In-Reply-To: <20251218003314.260269-1-ihor.solodrai@linux.dev>
References: <20251218003314.260269-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently resolve_btfids updates .BTF_ids section of an ELF file
in-place, based on the contents of provided BTF, usually within the
same input file, and optionally a BTF base.

Change resolve_btfids behavior to enable BTF transformations as part
of its main operation. To achieve this, in-place ELF write in
resolve_btfids is replaced with generation of the following binaries:
  * ${1}.BTF with .BTF section data
  * ${1}.BTF_ids with .BTF_ids section data if it existed in ${1}
  * ${1}.BTF.base with .BTF.base section data for out-of-tree modules

The execution of resolve_btfids and consumption of its output is
orchestrated by scripts/gen-btf.sh introduced in this patch.

The motivation for emitting binary data is that it allows simplifying
resolve_btfids implementation by delegating ELF update to the $OBJCOPY
tool [1], which is already widely used across the codebase.

There are two distinct paths for BTF generation and resolve_btfids
application in the kernel build: for vmlinux and for kernel modules.

For the vmlinux binary a .BTF section is added in a roundabout way to
ensure correct linking. The patch doesn't change this approach, only
the implementation is a little different.

Before this patch it worked as follows:

  * pahole consumed .tmp_vmlinux1 [2] and added .BTF section with
    llvm-objcopy [3] to it
  * then everything except the .BTF section was stripped from .tmp_vmlinux1
    into a .tmp_vmlinux1.bpf.o object [2], later linked into vmlinux
  * resolve_btfids was executed later on vmlinux.unstripped [4],
    updating it in-place

After this patch gen-btf.sh implements the following:

  * pahole consumes .tmp_vmlinux1 and produces a *detached* file with
    raw BTF data
  * resolve_btfids consumes .tmp_vmlinux1 and detached BTF to produce
    (potentially modified) .BTF, and .BTF_ids sections data
  * a .tmp_vmlinux1.bpf.o object is then produced with objcopy copying
    BTF output of resolve_btfids
  * .BTF_ids data gets embedded into vmlinux.unstripped in
    link-vmlinux.sh by objcopy --update-section

For kernel modules, creating a special .bpf.o file is not necessary,
and so embedding of sections data produced by resolve_btfids is
straightforward with objcopy.

With this patch an ELF file becomes effectively read-only within
resolve_btfids, which allows deleting elf_update() call and satellite
code (like compressed_section_fix [5]).

Endianness handling of .BTF_ids data is also changed. Previously the
"flags" part of the section was bswapped in sets_patch() [6], and then
Elf_Type was modified before elf_update() to signal to libelf that
bswap may be necessary. With this patch we explicitly bswap entire
data buffer on load and on dump.

[1] https://lore.kernel.org/bpf/131b4190-9c49-4f79-a99d-c00fac97fa44@linux.dev/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/link-vmlinux.sh?h=v6.18#n110
[3] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/btf_encoder.c?h=v1.31#n1803
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/link-vmlinux.sh?h=v6.18#n284
[5] https://lore.kernel.org/bpf/20200819092342.259004-1-jolsa@kernel.org/
[6] https://lore.kernel.org/bpf/cover.1707223196.git.vmalik@redhat.com/

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 MAINTAINERS                                   |   1 +
 scripts/Makefile.btf                          |  17 +-
 scripts/Makefile.modfinal                     |   5 +-
 scripts/Makefile.vmlinux                      |   2 +-
 scripts/gen-btf.sh                            | 157 +++++++++++++
 scripts/link-vmlinux.sh                       |  42 +---
 tools/bpf/resolve_btfids/main.c               | 222 +++++++++++-------
 tools/testing/selftests/bpf/.gitignore        |   3 +
 tools/testing/selftests/bpf/Makefile          |   9 +-
 .../selftests/bpf/prog_tests/resolve_btfids.c |   4 +-
 10 files changed, 331 insertions(+), 131 deletions(-)
 create mode 100755 scripts/gen-btf.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..cb1898a85b05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4766,6 +4766,7 @@ F:	net/sched/act_bpf.c
 F:	net/sched/cls_bpf.c
 F:	samples/bpf/
 F:	scripts/bpf_doc.py
+F:	scripts/gen-btf.sh
 F:	scripts/Makefile.btf
 F:	scripts/pahole-version.sh
 F:	tools/bpf/
diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index 840a55de42da..b8569d450ed9 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -1,5 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
+gen-btf-y				=
+gen-btf-$(CONFIG_DEBUG_INFO_BTF)	= $(srctree)/scripts/gen-btf.sh
+
+export GEN_BTF := $(gen-btf-y)
+
 pahole-ver := $(CONFIG_PAHOLE_VERSION)
 pahole-flags-y :=
 
@@ -18,13 +23,15 @@ pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=enc
 
 pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes
 
-ifneq ($(KBUILD_EXTMOD),)
-module-pahole-flags-$(call test-ge, $(pahole-ver), 128) += --btf_features=distilled_base
-endif
-
 endif
 
 pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
 
 export PAHOLE_FLAGS := $(pahole-flags-y)
-export MODULE_PAHOLE_FLAGS := $(module-pahole-flags-y)
+
+resolve-btfids-flags-y :=
+resolve-btfids-flags-$(CONFIG_WERROR) += --fatal_warnings
+resolve-btfids-flags-$(if $(KBUILD_EXTMOD),y) += --distill_base
+resolve-btfids-flags-$(if $(KBUILD_VERBOSE),y) += --verbose
+
+export RESOLVE_BTFIDS_FLAGS := $(resolve-btfids-flags-y)
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 149e12ff5700..422c56dc878e 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -42,9 +42,8 @@ quiet_cmd_btf_ko = BTF [M] $@
       cmd_btf_ko = 							\
 	if [ ! -f $(objtree)/vmlinux ]; then				\
 		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
-	else								\
-		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux $@; \
-		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $@;		\
+	else	\
+		$(srctree)/scripts/gen-btf.sh --btf_base $(objtree)/vmlinux $@; \
 	fi;
 
 # Same as newer-prereqs, but allows to exclude specified extra dependencies
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index cd788cac9d91..20a988f4fe0c 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -71,7 +71,7 @@ targets += vmlinux.unstripped .vmlinux.export.o
 vmlinux.unstripped: scripts/link-vmlinux.sh vmlinux.o .vmlinux.export.o $(KBUILD_LDS) FORCE
 	+$(call if_changed_dep,link_vmlinux)
 ifdef CONFIG_DEBUG_INFO_BTF
-vmlinux.unstripped: $(RESOLVE_BTFIDS)
+vmlinux.unstripped: $(RESOLVE_BTFIDS) $(srctree)/scripts/gen-btf.sh
 endif
 
 ifdef CONFIG_BUILDTIME_TABLE_SORT
diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
new file mode 100755
index 000000000000..06c6d8becaa2
--- /dev/null
+++ b/scripts/gen-btf.sh
@@ -0,0 +1,157 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
+#
+# This script generates BTF data for the provided ELF file.
+#
+# Kernel BTF generation involves these conceptual steps:
+#   1. pahole generates BTF from DWARF data
+#   2. resolve_btfids applies kernel-specific btf2btf
+#      transformations and computes data for .BTF_ids section
+#   3. the result gets linked/objcopied into the target binary
+#
+# How step (3) should be done differs between vmlinux, and
+# kernel modules, which is the primary reason for the existence
+# of this script.
+#
+# For modules the script expects vmlinux passed in as --btf_base.
+# Generated .BTF, .BTF.base and .BTF_ids sections become embedded
+# into the input ELF file with objcopy.
+#
+# For vmlinux the input file remains unchanged and two files are produced:
+#   - ${1}.btf.o ready for linking into vmlinux
+#   - ${1}.BTF_ids with .BTF_ids data blob
+# This output is consumed by scripts/link-vmlinux.sh
+
+set -e
+
+usage()
+{
+	echo "Usage: $0 [--btf_base <file>] <target ELF file>"
+	exit 1
+}
+
+BTF_BASE=""
+
+while [ $# -gt 0 ]; do
+	case "$1" in
+	--btf_base)
+		BTF_BASE="$2"
+		shift 2
+		;;
+	-*)
+		echo "Unknown option: $1" >&2
+		usage
+		;;
+	*)
+		break
+		;;
+	esac
+done
+
+if [ $# -ne 1 ]; then
+	usage
+fi
+
+ELF_FILE="$1"
+shift
+
+is_enabled() {
+	grep -q "^$1=y" ${objtree}/include/config/auto.conf
+}
+
+info()
+{
+	printf "  %-7s %s\n" "${1}" "${2}"
+}
+
+case "${KBUILD_VERBOSE}" in
+*1*)
+	set -x
+	;;
+esac
+
+
+gen_btf_data()
+{
+	info BTF "${ELF_FILE}"
+	btf1="${ELF_FILE}.BTF.1"
+	${PAHOLE} -J ${PAHOLE_FLAGS}			\
+		${BTF_BASE:+--btf_base ${BTF_BASE}}	\
+		--btf_encode_detached=${btf1}		\
+		"${ELF_FILE}"
+
+	info BTFIDS "${ELF_FILE}"
+	${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_FLAGS}	\
+		${BTF_BASE:+--btf_base ${BTF_BASE}}	\
+		--btf ${btf1} "${ELF_FILE}"
+}
+
+gen_btf_o()
+{
+	local btf_data=${ELF_FILE}.btf.o
+
+	# Create ${btf_data} which contains just .BTF section but no symbols. Add
+	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
+	# deletes all symbols including __start_BTF and __stop_BTF, which will
+	# be redefined in the linker script.
+	info OBJCOPY "${btf_data}"
+	echo "" | ${CC} ${CLANG_FLAGS} -c -x c -o ${btf_data} -
+	${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
+		--set-section-flags .BTF=alloc,readonly ${btf_data}
+	${OBJCOPY} --only-section=.BTF --strip-all ${btf_data}
+
+	# Change e_type to ET_REL so that it can be used to link final vmlinux.
+	# GNU ld 2.35+ and lld do not allow an ET_EXEC input.
+	if is_enabled CONFIG_CPU_BIG_ENDIAN; then
+		et_rel='\0\1'
+	else
+		et_rel='\1\0'
+	fi
+	printf "${et_rel}" | dd of="${btf_data}" conv=notrunc bs=1 seek=16 status=none
+}
+
+embed_btf_data()
+{
+	info OBJCOPY "${ELF_FILE}.BTF"
+	${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF ${ELF_FILE}
+
+	# a module might not have a .BTF_ids or .BTF.base section
+	local btf_base="${ELF_FILE}.BTF.base"
+	if [ -f "${btf_base}" ]; then
+		${OBJCOPY} --add-section .BTF.base=${btf_base} ${ELF_FILE}
+	fi
+	local btf_ids="${ELF_FILE}.BTF_ids"
+	if [ -f "${btf_ids}" ]; then
+		${OBJCOPY} --update-section .BTF_ids=${btf_ids} ${ELF_FILE}
+	fi
+}
+
+cleanup()
+{
+	rm -f "${ELF_FILE}.BTF.1"
+	rm -f "${ELF_FILE}.BTF"
+	if [ "${BTFGEN_MODE}" = "module" ]; then
+		rm -f "${ELF_FILE}.BTF.base"
+		rm -f "${ELF_FILE}.BTF_ids"
+	fi
+}
+trap cleanup EXIT
+
+BTFGEN_MODE="vmlinux"
+if [ -n "${BTF_BASE}" ]; then
+	BTFGEN_MODE="module"
+fi
+
+gen_btf_data
+
+case "${BTFGEN_MODE}" in
+vmlinux)
+	gen_btf_o
+	;;
+module)
+	embed_btf_data
+	;;
+esac
+
+exit 0
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 4ab44c73da4d..e2207e612ac3 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -106,34 +106,6 @@ vmlinux_link()
 		${kallsymso} ${btf_vmlinux_bin_o} ${arch_vmlinux_o} ${ldlibs}
 }
 
-# generate .BTF typeinfo from DWARF debuginfo
-# ${1} - vmlinux image
-gen_btf()
-{
-	local btf_data=${1}.btf.o
-
-	info BTF "${btf_data}"
-	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
-
-	# Create ${btf_data} which contains just .BTF section but no symbols. Add
-	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
-	# deletes all symbols including __start_BTF and __stop_BTF, which will
-	# be redefined in the linker script. Add 2>/dev/null to suppress GNU
-	# objcopy warnings: "empty loadable segment detected at ..."
-	${OBJCOPY} --only-section=.BTF --set-section-flags .BTF=alloc,readonly \
-		--strip-all ${1} "${btf_data}" 2>/dev/null
-	# Change e_type to ET_REL so that it can be used to link final vmlinux.
-	# GNU ld 2.35+ and lld do not allow an ET_EXEC input.
-	if is_enabled CONFIG_CPU_BIG_ENDIAN; then
-		et_rel='\0\1'
-	else
-		et_rel='\1\0'
-	fi
-	printf "${et_rel}" | dd of="${btf_data}" conv=notrunc bs=1 seek=16 status=none
-
-	btf_vmlinux_bin_o=${btf_data}
-}
-
 # Create ${2}.o file with all symbols from the ${1} object file
 kallsyms()
 {
@@ -205,6 +177,7 @@ if is_enabled CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX; then
 fi
 
 btf_vmlinux_bin_o=
+btfids_vmlinux=
 kallsymso=
 strip_debug=
 generate_map=
@@ -232,11 +205,13 @@ if is_enabled CONFIG_KALLSYMS || is_enabled CONFIG_DEBUG_INFO_BTF; then
 fi
 
 if is_enabled CONFIG_DEBUG_INFO_BTF; then
-	if ! gen_btf .tmp_vmlinux1; then
+	if ! ${srctree}/scripts/gen-btf.sh .tmp_vmlinux1; then
 		echo >&2 "Failed to generate BTF for vmlinux"
 		echo >&2 "Try to disable CONFIG_DEBUG_INFO_BTF"
 		exit 1
 	fi
+	btf_vmlinux_bin_o=.tmp_vmlinux1.btf.o
+	btfids_vmlinux=.tmp_vmlinux1.BTF_ids
 fi
 
 if is_enabled CONFIG_KALLSYMS; then
@@ -289,14 +264,9 @@ fi
 
 vmlinux_link "${VMLINUX}"
 
-# fill in BTF IDs
 if is_enabled CONFIG_DEBUG_INFO_BTF; then
-	info BTFIDS "${VMLINUX}"
-	RESOLVE_BTFIDS_ARGS=""
-	if is_enabled CONFIG_WERROR; then
-		RESOLVE_BTFIDS_ARGS=" --fatal_warnings "
-	fi
-	${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_ARGS} "${VMLINUX}"
+	info OBJCOPY ${btfids_vmlinux}
+	${OBJCOPY} --update-section .BTF_ids=${btfids_vmlinux} ${VMLINUX}
 fi
 
 mksysmap "${VMLINUX}" System.map
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index da8c7d127632..3e88dc862d87 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -71,9 +71,11 @@
 #include <fcntl.h>
 #include <errno.h>
 #include <linux/btf_ids.h>
+#include <linux/kallsyms.h>
 #include <linux/rbtree.h>
 #include <linux/zalloc.h>
 #include <linux/err.h>
+#include <linux/limits.h>
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
 #include <subcmd/parse-options.h>
@@ -124,6 +126,7 @@ struct object {
 
 	struct btf *btf;
 	struct btf *base_btf;
+	bool distill_base;
 
 	struct {
 		int		 fd;
@@ -324,42 +327,16 @@ static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
 	return btf_id__add(root, id, BTF_ID_KIND_SYM);
 }
 
-/* Older libelf.h and glibc elf.h might not yet define the ELF compression types. */
-#ifndef SHF_COMPRESSED
-#define SHF_COMPRESSED (1 << 11) /* Section with compressed data. */
-#endif
-
-/*
- * The data of compressed section should be aligned to 4
- * (for 32bit) or 8 (for 64 bit) bytes. The binutils ld
- * sets sh_addralign to 1, which makes libelf fail with
- * misaligned section error during the update:
- *    FAILED elf_update(WRITE): invalid section alignment
- *
- * While waiting for ld fix, we fix the compressed sections
- * sh_addralign value manualy.
- */
-static int compressed_section_fix(Elf *elf, Elf_Scn *scn, GElf_Shdr *sh)
+static void bswap_32_data(void *data, u32 nr_bytes)
 {
-	int expected = gelf_getclass(elf) == ELFCLASS32 ? 4 : 8;
-
-	if (!(sh->sh_flags & SHF_COMPRESSED))
-		return 0;
-
-	if (sh->sh_addralign == expected)
-		return 0;
+	u32 cnt, i;
+	u32 *ptr;
 
-	pr_debug2(" - fixing wrong alignment sh_addralign %u, expected %u\n",
-		  sh->sh_addralign, expected);
+	cnt = nr_bytes / sizeof(u32);
+	ptr = data;
 
-	sh->sh_addralign = expected;
-
-	if (gelf_update_shdr(scn, sh) == 0) {
-		pr_err("FAILED cannot update section header: %s\n",
-			elf_errmsg(-1));
-		return -1;
-	}
-	return 0;
+	for (i = 0; i < cnt; i++)
+		ptr[i] = bswap_32(ptr[i]);
 }
 
 static int elf_collect(struct object *obj)
@@ -380,7 +357,7 @@ static int elf_collect(struct object *obj)
 
 	elf_version(EV_CURRENT);
 
-	elf = elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
+	elf = elf_begin(fd, ELF_C_READ_MMAP_PRIVATE, NULL);
 	if (!elf) {
 		close(fd);
 		pr_err("FAILED cannot create ELF descriptor: %s\n",
@@ -443,21 +420,20 @@ static int elf_collect(struct object *obj)
 			obj->efile.symbols_shndx = idx;
 			obj->efile.strtabidx     = sh.sh_link;
 		} else if (!strcmp(name, BTF_IDS_SECTION)) {
+			/*
+			 * If target endianness differs from host, we need to bswap32
+			 * the .BTF_ids section data on load, because .BTF_ids has
+			 * Elf_Type = ELF_T_BYTE, and so libelf returns data buffer in
+			 * the target endianness. We repeat this on dump.
+			 */
+			if (obj->efile.encoding != ELFDATANATIVE) {
+				pr_debug("bswap_32 .BTF_ids data from target to host endianness\n");
+				bswap_32_data(data->d_buf, data->d_size);
+			}
 			obj->efile.idlist       = data;
 			obj->efile.idlist_shndx = idx;
 			obj->efile.idlist_addr  = sh.sh_addr;
-		} else if (!strcmp(name, BTF_BASE_ELF_SEC)) {
-			/* If a .BTF.base section is found, do not resolve
-			 * BTF ids relative to vmlinux; resolve relative
-			 * to the .BTF.base section instead.  btf__parse_split()
-			 * will take care of this once the base BTF it is
-			 * passed is NULL.
-			 */
-			obj->base_btf_path = NULL;
 		}
-
-		if (compressed_section_fix(elf, scn, &sh))
-			return -1;
 	}
 
 	return 0;
@@ -587,6 +563,19 @@ static int load_btf(struct object *obj)
 	obj->base_btf = base_btf;
 	obj->btf = btf;
 
+	if (obj->base_btf && obj->distill_base) {
+		err = btf__distill_base(obj->btf, &base_btf, &btf);
+		if (err) {
+			pr_err("FAILED to distill base BTF: %s\n", strerror(errno));
+			goto out_err;
+		}
+
+		btf__free(obj->btf);
+		btf__free(obj->base_btf);
+		obj->btf = btf;
+		obj->base_btf = base_btf;
+	}
+
 	return 0;
 
 out_err:
@@ -760,24 +749,6 @@ static int sets_patch(struct object *obj)
 			 */
 			BUILD_BUG_ON((u32 *)set8->pairs != &set8->pairs[0].id);
 			qsort(set8->pairs, set8->cnt, sizeof(set8->pairs[0]), cmp_id);
-
-			/*
-			 * When ELF endianness does not match endianness of the
-			 * host, libelf will do the translation when updating
-			 * the ELF. This, however, corrupts SET8 flags which are
-			 * already in the target endianness. So, let's bswap
-			 * them to the host endianness and libelf will then
-			 * correctly translate everything.
-			 */
-			if (obj->efile.encoding != ELFDATANATIVE) {
-				int i;
-
-				set8->flags = bswap_32(set8->flags);
-				for (i = 0; i < set8->cnt; i++) {
-					set8->pairs[i].flags =
-						bswap_32(set8->pairs[i].flags);
-				}
-			}
 			break;
 		default:
 			pr_err("Unexpected btf_id_kind %d for set '%s'\n", id->kind, id->name);
@@ -793,8 +764,6 @@ static int sets_patch(struct object *obj)
 
 static int symbols_patch(struct object *obj)
 {
-	off_t err;
-
 	if (__symbols_patch(obj, &obj->structs)  ||
 	    __symbols_patch(obj, &obj->unions)   ||
 	    __symbols_patch(obj, &obj->typedefs) ||
@@ -805,20 +774,90 @@ static int symbols_patch(struct object *obj)
 	if (sets_patch(obj))
 		return -1;
 
-	/* Set type to ensure endian translation occurs. */
-	obj->efile.idlist->d_type = ELF_T_WORD;
+	return 0;
+}
 
-	elf_flagdata(obj->efile.idlist, ELF_C_SET, ELF_F_DIRTY);
+static int dump_raw_data(const char *out_path, const void *data, u32 size)
+{
+	size_t written;
+	FILE *file;
 
-	err = elf_update(obj->efile.elf, ELF_C_WRITE);
-	if (err < 0) {
-		pr_err("FAILED elf_update(WRITE): %s\n",
-			elf_errmsg(-1));
+	file = fopen(out_path, "wb");
+	if (!file) {
+		pr_err("Couldn't open %s for writing\n", out_path);
+		return -1;
+	}
+
+	written = fwrite(data, 1, size, file);
+	if (written != size) {
+		pr_err("Failed to write data to %s\n", out_path);
+		fclose(file);
+		unlink(out_path);
+		return -1;
+	}
+
+	fclose(file);
+	pr_debug("Dumped %lu bytes of data to %s\n", size, out_path);
+
+	return 0;
+}
+
+static int dump_raw_btf_ids(struct object *obj, const char *out_path)
+{
+	Elf_Data *data = obj->efile.idlist;
+	int err;
+
+	if (!data || !data->d_buf) {
+		pr_debug("%s has no BTF_ids data to dump\n", obj->path);
+		return 0;
+	}
+
+	/*
+	 * If target endianness differs from host, we need to bswap32 the
+	 * .BTF_ids section data before dumping so that the output is in
+	 * target endianness.
+	 */
+	if (obj->efile.encoding != ELFDATANATIVE) {
+		pr_debug("bswap_32 .BTF_ids data from host to target endianness\n");
+		bswap_32_data(data->d_buf, data->d_size);
+	}
+
+	err = dump_raw_data(out_path, data->d_buf, data->d_size);
+	if (err)
+		return -1;
+
+	return 0;
+}
+
+static int dump_raw_btf(struct btf *btf, const char *out_path)
+{
+	const void *raw_btf_data;
+	u32 raw_btf_size;
+	int err;
+
+	raw_btf_data = btf__raw_data(btf, &raw_btf_size);
+	if (!raw_btf_data) {
+		pr_err("btf__raw_data() failed\n");
+		return -1;
 	}
 
-	pr_debug("update %s for %s\n",
-		 err >= 0 ? "ok" : "failed", obj->path);
-	return err < 0 ? -1 : 0;
+	err = dump_raw_data(out_path, raw_btf_data, raw_btf_size);
+	if (err)
+		return -1;
+
+	return 0;
+}
+
+static inline int make_out_path(char *buf, u32 buf_sz, const char *in_path, const char *suffix)
+{
+	int len = snprintf(buf, buf_sz, "%s%s", in_path, suffix);
+
+	if (len < 0 || len >= buf_sz) {
+		pr_err("Output path is too long: %s%s\n", in_path, suffix);
+		return -E2BIG;
+	}
+
+	return 0;
 }
 
 static const char * const resolve_btfids_usage[] = {
@@ -840,6 +879,8 @@ int main(int argc, const char **argv)
 		.sets     = RB_ROOT,
 	};
 	bool fatal_warnings = false;
+	char out_path[PATH_MAX];
+
 	struct option btfid_options[] = {
 		OPT_INCR('v', "verbose", &verbose,
 			 "be more verbose (show errors, etc)"),
@@ -849,6 +890,8 @@ int main(int argc, const char **argv)
 			   "path of file providing base BTF"),
 		OPT_BOOLEAN(0, "fatal_warnings", &fatal_warnings,
 			    "turn warnings into errors"),
+		OPT_BOOLEAN(0, "distill_base", &obj.distill_base,
+			    "distill --btf_base and emit .BTF.base section data"),
 		OPT_END()
 	};
 	int err = -1;
@@ -860,6 +903,9 @@ int main(int argc, const char **argv)
 
 	obj.path = argv[0];
 
+	if (load_btf(&obj))
+		goto out;
+
 	if (elf_collect(&obj))
 		goto out;
 
@@ -869,23 +915,37 @@ int main(int argc, const char **argv)
 	 */
 	if (obj.efile.idlist_shndx == -1 ||
 	    obj.efile.symbols_shndx == -1) {
-		pr_debug("Cannot find .BTF_ids or symbols sections, nothing to do\n");
-		err = 0;
-		goto out;
+		pr_debug("Cannot find .BTF_ids or symbols sections, skip symbols resolution\n");
+		goto dump_btf;
 	}
 
 	if (symbols_collect(&obj))
 		goto out;
 
-	if (load_btf(&obj))
-		goto out;
-
 	if (symbols_resolve(&obj))
 		goto out;
 
 	if (symbols_patch(&obj))
 		goto out;
 
+	err = make_out_path(out_path, sizeof(out_path), obj.path, BTF_IDS_SECTION);
+	err = err ?: dump_raw_btf_ids(&obj, out_path);
+	if (err)
+		goto out;
+
+dump_btf:
+	err = make_out_path(out_path, sizeof(out_path), obj.path, BTF_ELF_SEC);
+	err = err ?: dump_raw_btf(obj.btf, out_path);
+	if (err)
+		goto out;
+
+	if (obj.base_btf && obj.distill_base) {
+		err = make_out_path(out_path, sizeof(out_path), obj.path, BTF_BASE_ELF_SEC);
+		err = err ?: dump_raw_btf(obj.base_btf, out_path);
+		if (err)
+			goto out;
+	}
+
 	if (!(fatal_warnings && warnings))
 		err = 0;
 out:
diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 19c1638e312a..b8bf51b7a0b0 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -45,3 +45,6 @@ xdp_synproxy
 xdp_hw_metadata
 xdp_features
 verification_cert.h
+*.BTF
+*.BTF_ids
+*.BTF.base
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ffd0a4c354c7..f28a32b16ff0 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -4,6 +4,7 @@ include ../../../scripts/Makefile.arch
 include ../../../scripts/Makefile.include
 
 CXX ?= $(CROSS_COMPILE)g++
+OBJCOPY ?= $(CROSS_COMPILE)objcopy
 
 CURDIR := $(abspath .)
 TOOLSDIR := $(abspath ../../..)
@@ -653,9 +654,10 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 		      | $(TRUNNER_OUTPUT)/%.test.d
 	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
 	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)
-	$$(if $$(TEST_NEEDS_BTFIDS),					\
-		$$(call msg,BTFIDS,$(TRUNNER_BINARY),$$@)		\
-		$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@)
+	$$(if $$(TEST_NEEDS_BTFIDS),						\
+		$$(call msg,BTFIDS,$(TRUNNER_BINARY),$$@)			\
+		$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@;	\
+		$(OBJCOPY) --update-section .BTF_ids=$$@.BTF_ids $$@)
 
 $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_TESTS_DIR)/%.c			\
@@ -894,6 +896,7 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
 	feature bpftool $(TEST_KMOD_TARGETS)				\
 	$(addprefix $(OUTPUT)/,*.o *.d *.skel.h *.lskel.h *.subskel.h	\
+			       *.BTF *.BTF_ids *.BTF.base		\
 			       no_alu32 cpuv4 bpf_gcc			\
 			       liburandom_read.so)			\
 	$(OUTPUT)/FEATURE-DUMP.selftests				\
diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index 51544372f52e..41dfaaabb73f 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -101,9 +101,9 @@ static int resolve_symbols(void)
 	int type_id;
 	__u32 nr;
 
-	btf = btf__parse_elf("btf_data.bpf.o", NULL);
+	btf = btf__parse_raw("resolve_btfids.test.o.BTF");
 	if (CHECK(libbpf_get_error(btf), "resolve",
-		  "Failed to load BTF from btf_data.bpf.o\n"))
+		  "Failed to load BTF from resolve_btfids.test.o.BTF\n"))
 		return -1;
 
 	nr = btf__type_cnt(btf);
-- 
2.52.0


