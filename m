Return-Path: <bpf+bounces-30294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A788CC090
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 13:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56F81F2389A
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C4613D613;
	Wed, 22 May 2024 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Io03li2v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE413D603;
	Wed, 22 May 2024 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716378487; cv=none; b=cIBTYsgMhjRA+DksSY5CjIYuw05lUYGXleXtTt5H8xVGK5labkf5Z4K+3j40KV99KI5q98Yn5h+Hky8ldUyngQYdR5N/xBtw6Or0V3LUCi70LuRbAczHtI8ktQBrbSuX3auc7r1E0XJvpKd7zu2kEklcnfudUS37F9N5D1JFF7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716378487; c=relaxed/simple;
	bh=lzIbvF3gIVq9T/Px5pSVLJh5s4Do0AkEJBg/Djx/IT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nR0WpVcDlwFflcrwPQCcJO1UTcV993w4qIJlJY+7tXrxu2o0Z/KU3YzxnLhmGcNh33dR7xJE9ml+ZkH7OQHOffsS5++9xIDdUaNVjMRzDnaaOK/dZsuMkozu8HIYKxIr+xAJhnmXn8CxsWYLk5AB564dcpSpN0tKb79pkk/5kjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Io03li2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51847C32782;
	Wed, 22 May 2024 11:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716378486;
	bh=lzIbvF3gIVq9T/Px5pSVLJh5s4Do0AkEJBg/Djx/IT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Io03li2vndpRai2B2w81A9r1/7/HmnXSRzph6/swmGT3gk3x6hZomrV2RhmJRVkHG
	 cRECv72bDbFw/xNvWytQd/+A6yJZsj7CBtaWd0KYHJ0TgPiwYVCI8M80p0VwV68OBh
	 xdQsrDkVlSED2wjAKp0Qy/iJOvh7b6qTi6uICpoY8fAZ4yUtf9YtDdlAmzZZQYY/96
	 8kCCnyKpoIyceSEZHZ7CckqyWGI6CDRBJOhOTQaFGfibvHI7yyAud+lLXa/nQBaIOr
	 yf7aUIPWBB/dB3kS6bzOOQcyepAToACpWPvizd7TSwomWAjGrMK5fbQWUhNHYNVtbp
	 Nio0fgh856jAw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 1/3] kbuild: refactor variables in scripts/link-vmlinux.sh
Date: Wed, 22 May 2024 20:47:53 +0900
Message-Id: <20240522114755.318238-2-masahiroy@kernel.org>
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

Clean up the variables in scripts/link-vmlinux.sh

 - Specify the extra objects directly in vmlinux_link()
 - Move the AS rule to kallsyms()
 - Set kallsymso and btf_vmlinux_bin_o where they are generated
 - Remove unneeded variable, kallsymso_prev

No functional change intended.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/link-vmlinux.sh | 48 +++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 46ce5d04dbeb..b16967d33f1c 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -45,7 +45,6 @@ info()
 
 # Link of vmlinux
 # ${1} - output file
-# ${2}, ${3}, ... - optional extra .o files
 vmlinux_link()
 {
 	local output=${1}
@@ -101,7 +100,7 @@ vmlinux_link()
 	${ld} ${ldflags} -o ${output}					\
 		${wl}--whole-archive ${objs} ${wl}--no-whole-archive	\
 		${wl}--start-group ${libs} ${wl}--end-group		\
-		$@ ${ldlibs}
+		${kallsymso} ${btf_vmlinux_bin_o} ${ldlibs}
 }
 
 # generate .BTF typeinfo from DWARF debuginfo
@@ -142,9 +141,11 @@ gen_btf()
 		et_rel='\1\0'
 	fi
 	printf "${et_rel}" | dd of=${2} conv=notrunc bs=1 seek=16 status=none
+
+	btf_vmlinux_bin_o=${2}
 }
 
-# Create ${2} .S file with all symbols from the ${1} object file
+# Create ${2}.o file with all symbols from the ${1} object file
 kallsyms()
 {
 	local kallsymopt;
@@ -165,27 +166,25 @@ kallsyms()
 		kallsymopt="${kallsymopt} --lto-clang"
 	fi
 
-	info KSYMS ${2}
-	scripts/kallsyms ${kallsymopt} ${1} > ${2}
+	info KSYMS "${2}.S"
+	scripts/kallsyms ${kallsymopt} "${1}" > "${2}.S"
+
+	info AS "${2}.o"
+	${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} \
+	      ${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL} -c -o "${2}.o" "${2}.S"
+
+	kallsymso=${2}.o
 }
 
 # Perform one step in kallsyms generation, including temporary linking of
 # vmlinux.
 kallsyms_step()
 {
-	kallsymso_prev=${kallsymso}
 	kallsyms_vmlinux=.tmp_vmlinux.kallsyms${1}
-	kallsymso=${kallsyms_vmlinux}.o
-	kallsyms_S=${kallsyms_vmlinux}.S
 
-	vmlinux_link ${kallsyms_vmlinux} "${kallsymso_prev}" ${btf_vmlinux_bin_o}
-	mksysmap ${kallsyms_vmlinux} ${kallsyms_vmlinux}.syms
-	kallsyms ${kallsyms_vmlinux}.syms ${kallsyms_S}
-
-	info AS ${kallsymso}
-	${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} \
-	      ${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL} \
-	      -c -o ${kallsymso} ${kallsyms_S}
+	vmlinux_link "${kallsyms_vmlinux}"
+	mksysmap "${kallsyms_vmlinux}" "${kallsyms_vmlinux}.syms"
+	kallsyms "${kallsyms_vmlinux}.syms" "${kallsyms_vmlinux}"
 }
 
 # Create map file with all symbols from ${1}
@@ -223,19 +222,17 @@ fi
 
 ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init init/version-timestamp.o
 
-btf_vmlinux_bin_o=""
+kallsymso=
+btf_vmlinux_bin_o=
+
 if is_enabled CONFIG_DEBUG_INFO_BTF; then
-	btf_vmlinux_bin_o=.btf.vmlinux.bin.o
-	if ! gen_btf .tmp_vmlinux.btf $btf_vmlinux_bin_o ; then
+	if ! gen_btf .tmp_vmlinux.btf .btf.vmlinux.bin.o ; then
 		echo >&2 "Failed to generate BTF for vmlinux"
 		echo >&2 "Try to disable CONFIG_DEBUG_INFO_BTF"
 		exit 1
 	fi
 fi
 
-kallsymso=""
-kallsymso_prev=""
-kallsyms_vmlinux=""
 if is_enabled CONFIG_KALLSYMS; then
 
 	# kallsyms support
@@ -262,10 +259,9 @@ if is_enabled CONFIG_KALLSYMS; then
 	#     ${kallsymso}.
 
 	kallsyms_step 1
-	kallsyms_step 2
+	size1=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" ${kallsymso})
 
-	# step 3
-	size1=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" ${kallsymso_prev})
+	kallsyms_step 2
 	size2=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" ${kallsymso})
 
 	if [ $size1 -ne $size2 ] || [ -n "${KALLSYMS_EXTRA_PASS}" ]; then
@@ -273,7 +269,7 @@ if is_enabled CONFIG_KALLSYMS; then
 	fi
 fi
 
-vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o}
+vmlinux_link vmlinux
 
 # fill in BTF IDs
 if is_enabled CONFIG_DEBUG_INFO_BTF && is_enabled CONFIG_BPF; then
-- 
2.40.1


