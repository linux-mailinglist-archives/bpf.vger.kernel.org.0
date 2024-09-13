Return-Path: <bpf+bounces-39845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1EA9786F5
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 19:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD9C1F265E9
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 17:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B7984FA0;
	Fri, 13 Sep 2024 17:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKNexT7r"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE551127E37;
	Fri, 13 Sep 2024 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249095; cv=none; b=ZMsurs8MHkOudHeUAs0sNp5+ytCLMt2xumH2KVU3F5WeIip13SpXQrcmWmgoOqURcyn9zjy+vUm78hhNYKkS1tfWZssteN/mn2rTSiQuQxssuG9PvPrvQnskZZrRq+FJ4hca1+COggo0tlguSMxZDTD3lJypITbOO0GnbqXU2KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249095; c=relaxed/simple;
	bh=TBH2wsToIsF16KSPe6aeBkrv6pQbn74kXUUgJaabJ7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZA7MFH/TE3QBrGrgOGJ6QdRjalgIzkSO2Iu6jhlipLjvyLkbBdGE7Q9cJANzi3c75HZLVCZQhoYgseQFNaYRpJuoz1OKFCYeeICCEfF6XucAy2ioLUrf4mZ5ez6qi35l9eM87cuy9vdlhJ0qXMfQb6Wsevv+LFe6usiuU7i+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKNexT7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBB1C4CECC;
	Fri, 13 Sep 2024 17:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726249094;
	bh=TBH2wsToIsF16KSPe6aeBkrv6pQbn74kXUUgJaabJ7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vKNexT7r1Q9BSFs/Cpz5zAJwysd7XYglQupaYhPj+ijeN/2t4DDJNU37bW1J3kw4+
	 ji5W46u0nyPk0CWhodEIdf6+dXEgw37IPQeHDtzBvwzrgWJ/myn5Z1obPQmcxJGtvH
	 JtAFtxB8uHIoCmRyqony2ebafcPlUxTsaEey97pHv/IF81VBcy0SwoS1p9Pl9soIbH
	 Bsc5idvEDkjpqRiB6L9wLWTSAxxpJfejP6dZ7LG+rHR8zOR9saJJhMb5eaKiAA+f0G
	 SAcdCotKKsz6elxUOXphhADvEmE73zW6835gxtQxaqqSD0nzkGinS0veCb1DSBj7Dy
	 f0E/AGfaQBnEA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 2/3] btf: move pahole check in scripts/link-vmlinux.sh to lib/Kconfig.debug
Date: Sat, 14 Sep 2024 02:37:53 +0900
Message-ID: <20240913173759.1316390-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240913173759.1316390-1-masahiroy@kernel.org>
References: <20240913173759.1316390-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When DEBUG_INFO_DWARF5 is selected, pahole 1.21+ is required to enable
DEBUG_INFO_BTF.

When DEBUG_INFO_DWARF4 or DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is selected,
DEBUG_INFO_BTF can be enabled without pahole installed, but a build error
will occur in scripts/link-vmlinux.sh:

    LD      .tmp_vmlinux1
  BTF: .tmp_vmlinux1: pahole (pahole) is not available
  Failed to generate BTF for vmlinux
  Try to disable CONFIG_DEBUG_INFO_BTF

We did not guard DEBUG_INFO_BTF by PAHOLE_VERSION when previously
discussed [1].

However, commit 613fe1692377 ("kbuild: Add CONFIG_PAHOLE_VERSION")
added CONFIG_PAHOLE_VERSION after all. Now several CONFIG options, as
well as the combination of DEBUG_INFO_BTF and DEBUG_INFO_DWARF5, are
guarded by PAHOLE_VERSION.

The remaining compile-time check in scripts/link-vmlinux.sh now appears
to be an awkward inconsistency.

This commit adopts Nathan's original work.

[1]: https://lore.kernel.org/lkml/20210111180609.713998-1-natechancellor@gmail.com/

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
---

Changes in v2:
  - Reword the help message per Alan

 lib/Kconfig.debug       |  6 ++++--
 scripts/link-vmlinux.sh | 12 ------------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5e2f30921cb2..bdf822bc1bab 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -379,13 +379,15 @@ config DEBUG_INFO_BTF
 	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
 	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
 	depends on BPF_SYSCALL
+	depends on PAHOLE_VERSION >= 116
 	depends on !DEBUG_INFO_DWARF5 || PAHOLE_VERSION >= 121
 	# pahole uses elfutils, which does not have support for Hexagon relocations
 	depends on !HEXAGON
 	help
 	  Generate deduplicated BTF type information from DWARF debug info.
-	  Turning this on expects presence of pahole tool, which will convert
-	  DWARF type info into equivalent deduplicated BTF type info.
+	  Turning this on requires pahole v1.16 or later (v1.21 or later to
+	  support DWARF 5), which will convert DWARF type info into equivalent
+	  deduplicated BTF type info.
 
 config PAHOLE_HAS_SPLIT_BTF
 	def_bool PAHOLE_VERSION >= 119
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index cfffc41e20ed..53bd4b727e21 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -111,20 +111,8 @@ vmlinux_link()
 # ${1} - vmlinux image
 gen_btf()
 {
-	local pahole_ver
 	local btf_data=${1}.btf.o
 
-	if ! [ -x "$(command -v ${PAHOLE})" ]; then
-		echo >&2 "BTF: ${1}: pahole (${PAHOLE}) is not available"
-		return 1
-	fi
-
-	pahole_ver=$(${PAHOLE} --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/')
-	if [ "${pahole_ver}" -lt "116" ]; then
-		echo >&2 "BTF: ${1}: pahole version $(${PAHOLE} --version) is too old, need at least v1.16"
-		return 1
-	fi
-
 	info BTF "${btf_data}"
 	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
 
-- 
2.43.0


