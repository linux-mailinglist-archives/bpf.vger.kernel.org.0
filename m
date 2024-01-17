Return-Path: <bpf+bounces-19732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C57830727
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 14:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B9C1F25C6A
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411781F604;
	Wed, 17 Jan 2024 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqpTIOHS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5EC1EB51;
	Wed, 17 Jan 2024 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705498535; cv=none; b=bzQU5WGkqbEszxHyq7gs1AUcBlTvKapGj6iRj23+LPhse5+q8ZzLy3Qo3S3XVyycS3gngQhkX9o2KWp4+QSgg16SXeKAHFXe1eD1VY1z4CxBnvCTkd7AEFy1RG/OJnL28IOPl9FlVabe5v2dKurQjt9dGkhenFdpfhvbusgt1Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705498535; c=relaxed/simple;
	bh=+pRbt9Nr5LCUqE4QMBTg7OOKBFZygk5shn9rzPWmbpo=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=t6PWiC/EtRhqUU5nw5DbvDtv8cBmOohOoBNMugIAnZbBBsVSFjF+z/+XK++ZAnvJ2niXKuVicOI+TU0lon9+U6y7nQcZZocG3NxUYE8yNAMUZE2Kxe1dUYL7RRC+lzf5Iu9pT1WUcDw+7SqwvZrLvhWHtqQeRzt+HW+AMpKDaUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqpTIOHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB69C433F1;
	Wed, 17 Jan 2024 13:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705498535;
	bh=+pRbt9Nr5LCUqE4QMBTg7OOKBFZygk5shn9rzPWmbpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DqpTIOHSbsHfHA3xAn9gES6V4X8i12M7t1iTONP/LH9flVrbeFH8yEGHoFHDqSi2L
	 ldyBJ2F8xn5sRXTY7pQqdCCt+KO/ZroflKaQoMwrVUzjR00/eCcKlqHR7uQJadgVEX
	 8hgnoHRwL2wrDqpiWNCD5F4qV5mJIeYQ3yDFlMQM8fipHiAXPnki0Qp/6UKBu1cVF0
	 eioGG7QL8CKIvK/thejT/QmuV8muP3x9DghBpxXdxyjrHtB6nzCEV+9Gsgkf4Utzkn
	 KTOBFhmQphmTjt+SWGVanftty+FIy4HnzcbDI9ICKj2vTDfyitpVUQUYRVVpEQTRsB
	 guXY+HsjV8I4g==
From: Jiri Olsa <jolsa@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Curtin <ecurtin@redhat.com>,
	Neal Gompa <neal@gompa.dev>,
	Miguel Ojeda <ojeda@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCHv2 stable 6.1 1/2] btf, scripts: Exclude Rust CUs with pahole
Date: Wed, 17 Jan 2024 14:35:19 +0100
Message-ID: <20240117133520.733288-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117133520.733288-1-jolsa@kernel.org>
References: <20240117133520.733288-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

commit c1177979af9c616661a126a80dd486ad0543b836 upstream.

Version 1.24 of pahole has the capability to exclude compilation units (CUs)
of specific languages [1] [2]. Rust, as of writing, is not currently supported
by pahole and if it's used with a build that has BTF debugging enabled it
results in malformed kernel and module binaries [3]. So it's better for pahole
to exclude Rust CUs until support for it arrives.

Co-developed-by: Eric Curtin <ecurtin@redhat.com>
Signed-off-by: Eric Curtin <ecurtin@redhat.com>
Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Eric Curtin <ecurtin@redhat.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=49358dfe2aaae4e90b072332c3e324019826783f [1]
Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=8ee363790b7437283c53090a85a9fec2f0b0fbc4 [2]
Link: https://github.com/Rust-for-Linux/linux/issues/735 [3]
Link: https://lore.kernel.org/bpf/20230111152050.559334-1-yakoyoku@gmail.com
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 init/Kconfig            | 2 +-
 lib/Kconfig.debug       | 9 +++++++++
 scripts/pahole-flags.sh | 4 ++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index de255842f5d0..148704640252 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1914,7 +1914,7 @@ config RUST
 	depends on !MODVERSIONS
 	depends on !GCC_PLUGINS
 	depends on !RANDSTRUCT
-	depends on !DEBUG_INFO_BTF
+	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
 	select CONSTRUCTORS
 	help
 	  Enables Rust support in the kernel.
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4db0199651f5..95541b99aa8e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -364,6 +364,15 @@ config PAHOLE_HAS_BTF_TAG
 	  btf_decl_tag) or not. Currently only clang compiler implements
 	  these attributes, so make the config depend on CC_IS_CLANG.
 
+config PAHOLE_HAS_LANG_EXCLUDE
+	def_bool PAHOLE_VERSION >= 124
+	help
+	  Support for the --lang_exclude flag which makes pahole exclude
+	  compilation units from the supplied language. Used in Kbuild to
+	  omit Rust CUs which are not supported in version 1.24 of pahole,
+	  otherwise it would emit malformed kernel and module binaries when
+	  using DEBUG_INFO_BTF_MODULES.
+
 config DEBUG_INFO_BTF_MODULES
 	def_bool y
 	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
index 0d99ef17e4a5..1f1f1d397c39 100755
--- a/scripts/pahole-flags.sh
+++ b/scripts/pahole-flags.sh
@@ -19,5 +19,9 @@ fi
 if [ "${pahole_ver}" -ge "122" ]; then
 	extra_paholeopt="${extra_paholeopt} -j"
 fi
+if [ "${pahole_ver}" -ge "124" ]; then
+	# see PAHOLE_HAS_LANG_EXCLUDE
+	extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
+fi
 
 echo ${extra_paholeopt}
-- 
2.43.0


