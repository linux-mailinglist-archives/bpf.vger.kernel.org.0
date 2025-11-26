Return-Path: <bpf+bounces-75527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6232C87B3E
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 02:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A51A4E5D4C
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 01:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F442FF65A;
	Wed, 26 Nov 2025 01:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dDTpMGSq"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FF12F83D8
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 01:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764120594; cv=none; b=B6PKzC6KD5VO+LWu7jq/A+z6GZ6m6wPNqggiY9JBQwGh0igxmtcC9ArtEa49LzR0oA1OMWivMt/Smu+ZpgX7xkg/+feS2nS145OrSs7NhlZUMzhlvt6Ev4hsQhwO+yXqgvFt4iId6PjhUyI6/A5cSjMqN7RkDdGUnjGdlNp4JeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764120594; c=relaxed/simple;
	bh=YwgShm4j2Q5W1IYLLkNrx9t+LBeGXChj+nW6RyJ2dsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTVQnLYD2/mRH5K8d3qz4UOwKPcq8zJKTGci8Kj7PIfdPJCNBM4juRXf+wrG5g2ZuW6drfXraJoZUvIIubhksM1IfJQVMlDjMLsEElAhe+pUKczRaEF8Gy8DhdAcIFYpnP/S7pg0+g5UiCZraBKuo9HUOPiJLPRdx6VTqu7fmGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dDTpMGSq; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764120589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McMjrjL60SjDk8vrsOfgt5kcZdJJBubZnhh/BKmREoY=;
	b=dDTpMGSqh4cRfHLt2DzNnb6TMVzcoEzUr48cUyGDQFXH0BEyZ1CDN4/X4fII08QX4MyxLa
	j74m30W2b8RF6chq728f8xBuFowRS6oD3skoOc00UdObpTdzTaUck3EK3s0E2UboyxW77Q
	55vbN/KKAMfMjFG+BqwR1E9//C/wsuk=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org,
	dwarves@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH bpf-next v1 4/4] resolve_btfids: change in-place update with raw binary output
Date: Tue, 25 Nov 2025 17:26:56 -0800
Message-ID: <20251126012656.3546071-5-ihor.solodrai@linux.dev>
In-Reply-To: <20251126012656.3546071-1-ihor.solodrai@linux.dev>
References: <20251126012656.3546071-1-ihor.solodrai@linux.dev>
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

This patch changes resolve_btfids behavior to enable BTF
transformations as part of its main operation. To achieve this
in-place ELF write in resolve_btfids is replaced with generation of
the following binaries:
  * ${1}.btf with .BTF section data
  * ${1}.distilled_base.btf with .BTF.base section data (for modules)
  * ${1}.btf_ids with .BTF_ids section data, if it exists in ${1}

The execution of resolve_btfids and consumption of its output is
orchestrated by scripts/gen-btf.sh introduced in this patch.

The rationale for this approach is that updating ELF in-place with
libelf API is complicated and bug-prone, especially in the context of
the kernel build. On the other hand applying objcopy to manipulate ELF
sections is simpler and more reliable.

There are two distinct paths for BTF generation and resolve_btfids
application in the kernel build: for vmlinux and for kernel modules.

For the vmlinux binary a .BTF section is added in a roundabout way to
ensure correct linking (details below). The patch doesn't change this
approach, only the implementation is a little different.

Before this patch it worked like follows:

  * pahole consumed .tmp_vmlinux1 [1] and added .BTF section with
    llvm-objcopy [2] to it
  * then everything except the .BTF section was stripped from .tmp_vmlinux1
    into a .tmp_vmlinux1.bpf.o object [1], later linked into vmlinux
  * resolve_btfids was executed later on vmlinux.unstripped [3],
    updating it in-place

After this patch gen-btf.sh implements the following:

  * pahole consumes .tmp_vmlinux1 and produces a **detached** file
    with raw BTF data
  * resolve_btfids consumes .tmp_vmlinux1 and detached BTF to produce
    (potentially modified) .BTF, and .BTF_ids sections data
  * a .tmp_vmlinux1.bpf.o object is then produced with objcopy copying
    BTF output of resolve_btfids
  * .BTF_ids data gets embedded into vmlinux.unstripped in
    link-vmlinux.sh by objcopy --update-section

For the kernel modules creating special .bpf.o file is not necessary,
and so embedding of sections data produced by resolve_btfids is
straightforward with the objcopy.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/scripts/link-vmlinux.sh#n115
[2] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/btf_encoder.c#n1835
[3] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/scripts/link-vmlinux.sh#n285

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 MAINTAINERS                     |   1 +
 scripts/Makefile.modfinal       |   5 +-
 scripts/gen-btf.sh              | 166 ++++++++++++++++++++++++++++++++
 scripts/link-vmlinux.sh         |  42 ++------
 tools/bpf/resolve_btfids/main.c | 124 ++++++++++++++++++------
 5 files changed, 272 insertions(+), 66 deletions(-)
 create mode 100755 scripts/gen-btf.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 48aabeeed029..5cd34419d952 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4672,6 +4672,7 @@ F:	net/sched/act_bpf.c
 F:	net/sched/cls_bpf.c
 F:	samples/bpf/
 F:	scripts/bpf_doc.py
+F:	scripts/gen-btf.sh
 F:	scripts/Makefile.btf
 F:	scripts/pahole-version.sh
 F:	tools/bpf/
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 542ba462ed3e..86f843995556 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -38,9 +38,8 @@ quiet_cmd_btf_ko = BTF [M] $@
       cmd_btf_ko = 							\
 	if [ ! -f $(objtree)/vmlinux ]; then				\
 		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
-	else								\
-		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux $@; \
-		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $@;		\
+	else	\
+		$(objtree)/scripts/gen-btf.sh --btf_base $(objtree)/vmlinux $@; \
 	fi;
 
 # Same as newer-prereqs, but allows to exclude specified extra dependencies
diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
new file mode 100755
index 000000000000..102f8296ae9e
--- /dev/null
+++ b/scripts/gen-btf.sh
@@ -0,0 +1,166 @@
+#!/bin/sh
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
+#   - ${1}.btf_ids with .BTF_ids data blob
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
+if ! is_enabled CONFIG_DEBUG_INFO_BTF; then
+	exit 0
+fi
+
+gen_btf_data()
+{
+	info BTF "${ELF_FILE}"
+	btf1="${ELF_FILE}.btf.1"
+	${PAHOLE} -J ${PAHOLE_FLAGS}			\
+		${BTF_BASE:+--btf_base ${BTF_BASE}}	\
+		--btf_encode_detached=${btf1}		\
+		"${ELF_FILE}"
+
+	info BTFIDS "${ELF_FILE}"
+	RESOLVE_BTFIDS_OPTS=""
+	if is_enabled CONFIG_WERROR; then
+		RESOLVE_BTFIDS_OPTS+=" --fatal_warnings "
+	fi
+	if [ -n "${KBUILD_VERBOSE}" ]; then
+		RESOLVE_BTFIDS_OPTS+=" -v "
+	fi
+	${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_OPTS}	\
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
+	echo "" | ${CC} -c -x c -o ${btf_data} -
+	${OBJCOPY} --add-section .BTF=${ELF_FILE}.btf \
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
+	info OBJCOPY "${ELF_FILE}"
+
+	${OBJCOPY} \
+		--add-section .BTF=${ELF_FILE}.btf			\
+		--add-section .BTF.base=${ELF_FILE}.distilled_base.btf	\
+		${ELF_FILE}
+
+	# a module might not have a .BTF_ids section
+	if [ -f "${ELF_FILE}.btf_ids" ]; then
+		${OBJCOPY} --update-section .BTF_ids=${ELF_FILE}.btf_ids ${ELF_FILE}
+	fi
+}
+
+cleanup()
+{
+	rm -f "${ELF_FILE}.btf.1"
+	rm -f "${ELF_FILE}.btf"
+	if [ "${BTFGEN_MODE}" == "module" ]; then
+		rm -f "${ELF_FILE}.distilled_base.btf"
+		rm -f "${ELF_FILE}.btf_ids"
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
index 433849ff7529..728f82af24f6 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -105,34 +105,6 @@ vmlinux_link()
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
@@ -204,6 +176,7 @@ if is_enabled CONFIG_ARCH_WANTS_PRE_LINK_VMLINUX; then
 fi
 
 btf_vmlinux_bin_o=
+btfids_vmlinux=
 kallsymso=
 strip_debug=
 generate_map=
@@ -224,11 +197,13 @@ if is_enabled CONFIG_KALLSYMS || is_enabled CONFIG_DEBUG_INFO_BTF; then
 fi
 
 if is_enabled CONFIG_DEBUG_INFO_BTF; then
-	if ! gen_btf .tmp_vmlinux1; then
+	if ! scripts/gen-btf.sh .tmp_vmlinux1; then
 		echo >&2 "Failed to generate BTF for vmlinux"
 		echo >&2 "Try to disable CONFIG_DEBUG_INFO_BTF"
 		exit 1
 	fi
+	btf_vmlinux_bin_o=.tmp_vmlinux1.btf.o
+	btfids_vmlinux=.tmp_vmlinux1.btf_ids
 fi
 
 if is_enabled CONFIG_KALLSYMS; then
@@ -281,14 +256,9 @@ fi
 
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
index 7f5a9f7dde7f..4faf16b1ba6b 100644
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
@@ -429,14 +431,6 @@ static int elf_collect(struct object *obj)
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
 
 		if (compressed_section_fix(elf, scn, &sh))
@@ -570,6 +564,19 @@ static int load_btf(struct object *obj)
 	obj->base_btf = base_btf;
 	obj->btf = btf;
 
+	if (obj->base_btf) {
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
@@ -777,8 +784,6 @@ static int sets_patch(struct object *obj)
 
 static int symbols_patch(struct object *obj)
 {
-	off_t err;
-
 	if (__symbols_patch(obj, &obj->structs)  ||
 	    __symbols_patch(obj, &obj->unions)   ||
 	    __symbols_patch(obj, &obj->typedefs) ||
@@ -789,20 +794,67 @@ static int symbols_patch(struct object *obj)
 	if (sets_patch(obj))
 		return -1;
 
-	/* Set type to ensure endian translation occurs. */
-	obj->efile.idlist->d_type = ELF_T_WORD;
+	return 0;
+}
 
-	elf_flagdata(obj->efile.idlist, ELF_C_SET, ELF_F_DIRTY);
+static int dump_raw_data(const char *out_path, const void *data, u32 size)
+{
+	int fd, ret;
 
-	err = elf_update(obj->efile.elf, ELF_C_WRITE);
-	if (err < 0) {
-		pr_err("FAILED elf_update(WRITE): %s\n",
-			elf_errmsg(-1));
+	fd = open(out_path, O_WRONLY | O_CREAT | O_TRUNC, 0640);
+	if (fd < 0) {
+		pr_err("Couldn't open %s for writing\n", out_path);
+		return fd;
+	}
+
+	ret = write(fd, data, size);
+	if (ret < 0 || ret != size) {
+		pr_err("Failed to write data to %s\n", out_path);
+		close(fd);
+		unlink(out_path);
+		return -1;
+	}
+
+	close(fd);
+	pr_debug("Dumped %lu bytes of data to %s\n", size, out_path);
+
+	return 0;
+}
+
+static int dump_raw_btf_ids(struct object *obj, const char *out_path)
+{
+	Elf_Data *data = obj->efile.idlist;
+	int fd, err;
+
+	if (!data || !data->d_buf) {
+		pr_debug("%s has no BTF_ids data to dump\n", obj->path);
+		return 0;
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
+	int fd, err;
+
+	raw_btf_data = btf__raw_data(btf, &raw_btf_size);
+	if (raw_btf_data == NULL) {
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
 }
 
 static const char * const resolve_btfids_usage[] = {
@@ -823,12 +875,13 @@ int main(int argc, const char **argv)
 		.funcs    = RB_ROOT,
 		.sets     = RB_ROOT,
 	};
+	char out_path[PATH_MAX];
 	bool fatal_warnings = false;
 	struct option btfid_options[] = {
 		OPT_INCR('v', "verbose", &verbose,
 			 "be more verbose (show errors, etc)"),
 		OPT_STRING(0, "btf", &obj.btf_path, "BTF data",
-			   "BTF data"),
+			   "input BTF data"),
 		OPT_STRING('b', "btf_base", &obj.base_btf_path, "file",
 			   "path of file providing base BTF"),
 		OPT_BOOLEAN(0, "fatal_warnings", &fatal_warnings,
@@ -844,6 +897,9 @@ int main(int argc, const char **argv)
 
 	obj.path = argv[0];
 
+	if (load_btf(&obj))
+		goto out;
+
 	if (elf_collect(&obj))
 		goto out;
 
@@ -853,23 +909,37 @@ int main(int argc, const char **argv)
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
 
+	strcpy(out_path, obj.path);
+	strcat(out_path, ".btf_ids");
+	if (dump_raw_btf_ids(&obj, out_path))
+		goto out;
+
+dump_btf:
+	strcpy(out_path, obj.path);
+	strcat(out_path, ".btf");
+	if (dump_raw_btf(obj.btf, out_path))
+		goto out;
+
+	if (obj.base_btf) {
+		strcpy(out_path, obj.path);
+		strcat(out_path, ".distilled_base.btf");
+		if (dump_raw_btf(obj.base_btf, out_path))
+			goto out;
+	}
+
 	if (!(fatal_warnings && warnings))
 		err = 0;
 out:
-- 
2.52.0


