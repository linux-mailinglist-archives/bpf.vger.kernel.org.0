Return-Path: <bpf+bounces-30296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC238CC098
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 13:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319BA1F2379D
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 11:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD3D13DDA5;
	Wed, 22 May 2024 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfl0hj3R"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC3413D527;
	Wed, 22 May 2024 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716378491; cv=none; b=D9MoFM5P2xfmdbT26RKXh9066TJhzqRgz5mfd4XmKEbGgp0lIKn0/CA4ZonW4ihTsOpjChUouihuQrSxvEo6eN5Vq1qFTiVfPRylxQfxL81sK7WuqmrRxWHsBExM6EbnTY3BZn+TwsUT7/SvFcAZhvC09woxeQR5J0vnlD3ZMkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716378491; c=relaxed/simple;
	bh=JhSsoxg2OnXowswdGxhNRnAS5xMCOcv54bgZanDVXKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hDpdxpaXFWDYzLZdIUdBuA6EDz7PkgJfngK3MgSOSSTBleko6jFvb5dPMadNVkxJrwal+GTH8z66yG18pwhhNR0Udv6+XCPWJ905kZcVohRatRqFJU2MpJ286ln1AhnCn5rGE22i2/46piz4i5nIgC03kUawM9wcrkexWg9rSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfl0hj3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A91FC4AF08;
	Wed, 22 May 2024 11:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716378490;
	bh=JhSsoxg2OnXowswdGxhNRnAS5xMCOcv54bgZanDVXKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mfl0hj3RfpjA19v73hu4iaH4EPTujvIlYiKndOFyuITde7PyQPwgKpf6zg8rW7OEN
	 yQAUd3VKViNe+uJf6OeFbl3WmlTlHA20l6SRgJ31xBtlGTjxy6mAI11Wy/lvLzBv/w
	 Jdx3AoudUEG/on82ClJ40FlncF2yrCJ5s4E4eruTJkZoWtWvQG66F8xoRwD0wO1xLe
	 tTM5LVvaD/ED45o4El8HUVh7GTz4M1kdTJtAG6AP7FOrQHBYxln3ZkYRcYkdAj3b/h
	 17S/R0SwLZlv7rRFdwYOugmCafCHNzdY1eEyuCdQ8f8Luj5uOEKKknSvKMONhyOr6y
	 sid1rZLz8oHTw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 3/3] kbuild: merge temp vmlinux for CONFIG_DEBUG_INFO_BTF and CONFIG_KALLSYMS
Date: Wed, 22 May 2024 20:47:55 +0900
Message-Id: <20240522114755.318238-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240522114755.318238-1-masahiroy@kernel.org>
References: <20240522114755.318238-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_DEBUG_INFO_BTF=y requires one additional link step.
(.tmp_vmlinux.btf)

CONFIG_KALLSYMS=y requires two additional link steps.
(.tmp_vmlinux.kallsyms1 and .tmp_vmlinux.kallsyms2)

Enabling both requires three additional link steps.

When CONFIG_DEBUG_INFO_BTF=y and CONFIG_KALLSYMS=y, the build step looks
as follows:

    KSYMS   .tmp_vmlinux.kallsyms0.S
    AS      .tmp_vmlinux.kallsyms0.o
    LD      .tmp_vmlinux.btf             # temp vmlinux for BTF
    BTF     .btf.vmlinux.bin.o
    LD      .tmp_vmlinux.kallsyms1       # temp vmlinux for kallsyms step 1
    NM      .tmp_vmlinux.kallsyms1.syms
    KSYMS   .tmp_vmlinux.kallsyms1.S
    AS      .tmp_vmlinux.kallsyms1.o
    LD      .tmp_vmlinux.kallsyms2       # temp vmlinux for kallsyms step 2
    NM      .tmp_vmlinux.kallsyms2.syms
    KSYMS   .tmp_vmlinux.kallsyms2.S
    AS      .tmp_vmlinux.kallsyms2.o
    LD      vmlinux                      # final vmlinux

This is redundant because the BTF generation and the kallsyms step 1 can
be performed against the same temporary vmlinux.

When both CONFIG_DEBUG_INFO_BTF and CONFIG_KALLSYMS are enabled, we can
reduce the number of link steps.

The build step will look as follows:

    KSYMS   .tmp_vmlinux0.kallsyms.S
    AS      .tmp_vmlinux0.kallsyms.o
    LD      .tmp_vmlinux1                # temp vmlinux for BTF and kallsyms step 1
    BTF     .tmp_vmlinux1.btf.o
    NM      .tmp_vmlinux1.syms
    KSYMS   .tmp_vmlinux1.kallsyms.S
    AS      .tmp_vmlinux1.kallsyms.o
    LD      .tmp_vmlinux2                # temp vmlinux for kallsyms step 2
    NM      .tmp_vmlinux2.syms
    KSYMS   .tmp_vmlinux2.kallsyms.S
    AS      .tmp_vmlinux2.kallsyms.o
    LD      vmlinux                      # final link

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/link-vmlinux.sh | 45 +++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index fe7db9a265ca..ea004aae6ce5 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -105,10 +105,10 @@ vmlinux_link()
 
 # generate .BTF typeinfo from DWARF debuginfo
 # ${1} - vmlinux image
-# ${2} - file to dump raw BTF data into
 gen_btf()
 {
 	local pahole_ver
+	local btf_data=${1}.btf.o
 
 	if ! [ -x "$(command -v ${PAHOLE})" ]; then
 		echo >&2 "BTF: ${1}: pahole (${PAHOLE}) is not available"
@@ -121,18 +121,16 @@ gen_btf()
 		return 1
 	fi
 
-	vmlinux_link ${1}
-
-	info "BTF" ${2}
+	info BTF "${btf_data}"
 	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
 
-	# Create ${2} which contains just .BTF section but no symbols. Add
+	# Create ${btf_data} which contains just .BTF section but no symbols. Add
 	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
 	# deletes all symbols including __start_BTF and __stop_BTF, which will
 	# be redefined in the linker script. Add 2>/dev/null to suppress GNU
 	# objcopy warnings: "empty loadable segment detected at ..."
 	${OBJCOPY} --only-section=.BTF --set-section-flags .BTF=alloc,readonly \
-		--strip-all ${1} ${2} 2>/dev/null
+		--strip-all ${1} "${btf_data}" 2>/dev/null
 	# Change e_type to ET_REL so that it can be used to link final vmlinux.
 	# GNU ld 2.35+ and lld do not allow an ET_EXEC input.
 	if is_enabled CONFIG_CPU_BIG_ENDIAN; then
@@ -140,9 +138,9 @@ gen_btf()
 	else
 		et_rel='\1\0'
 	fi
-	printf "${et_rel}" | dd of=${2} conv=notrunc bs=1 seek=16 status=none
+	printf "${et_rel}" | dd of="${btf_data}" conv=notrunc bs=1 seek=16 status=none
 
-	btf_vmlinux_bin_o=${2}
+	btf_vmlinux_bin_o=${btf_data}
 }
 
 # Create ${2}.o file with all symbols from the ${1} object file
@@ -176,15 +174,13 @@ kallsyms()
 	kallsymso=${2}.o
 }
 
-# Perform one step in kallsyms generation, including temporary linking of
-# vmlinux.
-kallsyms_step()
+# Perform kallsyms for the given temporary vmlinux.
+sysmap_and_kallsyms()
 {
-	kallsyms_vmlinux=.tmp_vmlinux.kallsyms${1}
+	mksysmap "${1}" "${1}.syms"
+	kallsyms "${1}.syms" "${1}.kallsyms"
 
-	vmlinux_link "${kallsyms_vmlinux}"
-	mksysmap "${kallsyms_vmlinux}" "${kallsyms_vmlinux}.syms"
-	kallsyms "${kallsyms_vmlinux}.syms" "${kallsyms_vmlinux}"
+	kallsyms_sysmap=${1}.syms
 }
 
 # Create map file with all symbols from ${1}
@@ -226,12 +222,15 @@ kallsymso=
 btf_vmlinux_bin_o=
 
 if is_enabled CONFIG_KALLSYMS; then
-	# kallsyms step 0
-	kallsyms /dev/null .tmp_vmlinux.kallsyms0
+	kallsyms /dev/null .tmp_vmlinux0.kallsyms
+fi
+
+if is_enabled CONFIG_KALLSYMS || is_enabled CONFIG_DEBUG_INFO_BTF; then
+	vmlinux_link .tmp_vmlinux1
 fi
 
 if is_enabled CONFIG_DEBUG_INFO_BTF; then
-	if ! gen_btf .tmp_vmlinux.btf .btf.vmlinux.bin.o ; then
+	if ! gen_btf .tmp_vmlinux1; then
 		echo >&2 "Failed to generate BTF for vmlinux"
 		echo >&2 "Try to disable CONFIG_DEBUG_INFO_BTF"
 		exit 1
@@ -264,14 +263,16 @@ if is_enabled CONFIG_KALLSYMS; then
 	# a)  Verify that the System.map from vmlinux matches the map from
 	#     ${kallsymso}.
 
-	kallsyms_step 1
+	sysmap_and_kallsyms .tmp_vmlinux1
 	size1=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" ${kallsymso})
 
-	kallsyms_step 2
+	vmlinux_link .tmp_vmlinux2
+	sysmap_and_kallsyms .tmp_vmlinux2
 	size2=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" ${kallsymso})
 
 	if [ $size1 -ne $size2 ] || [ -n "${KALLSYMS_EXTRA_PASS}" ]; then
-		kallsyms_step 3
+		vmlinux_link .tmp_vmlinux3
+		sysmap_and_kallsyms .tmp_vmlinux3
 	fi
 fi
 
@@ -295,7 +296,7 @@ fi
 
 # step a (see comment above)
 if is_enabled CONFIG_KALLSYMS; then
-	if ! cmp -s System.map ${kallsyms_vmlinux}.syms; then
+	if ! cmp -s System.map ${kallsyms_sysmap}; then
 		echo >&2 Inconsistent kallsyms data
 		echo >&2 'Try "make KALLSYMS_EXTRA_PASS=1" as a workaround'
 		exit 1
-- 
2.40.1


