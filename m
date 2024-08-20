Return-Path: <bpf+bounces-37609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8209C95818D
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 11:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398841F217FF
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 09:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AE918A95F;
	Tue, 20 Aug 2024 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZthiMqGW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E4118A6D1;
	Tue, 20 Aug 2024 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724144397; cv=none; b=K4EBRKR3zHbCkbCGmfU4xqM/Dk5t1S/OgVLwtp5gMWdMDj/WwW6ybPLw5GEDfd6QwIE/ZtYDIBKXIA/djYmznm5YOeuWQMZLkEr/N7TaErOB9zepvJELm0FnuCU2GVCJ23EwD5pd2Uf1/x+rPXG/KbomAibxhRZ25SMyWOBg6S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724144397; c=relaxed/simple;
	bh=wSNdF+SjzZ7RV153zgojfhRsAmxbLbtfAarPoswiZxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P3ggugxrlvzJmHbmj0PnfrdHqm18FeHKBkIssHExmIVPD6651J76o7VJtYmhvKLgeNDtQQQs6Zw26rMEoNrGDq7quHAvOxEK5pEFp6PW34zw2b3KnqDrqG4iggPLJIwAUELjCsj62ZBrad2nbiieNDrR1wT+glSXqOTBLtCVe+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZthiMqGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803FBC4AF0B;
	Tue, 20 Aug 2024 08:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724144396;
	bh=wSNdF+SjzZ7RV153zgojfhRsAmxbLbtfAarPoswiZxY=;
	h=From:To:Cc:Subject:Date:From;
	b=ZthiMqGWeomRokKjYa9g7I+/4p64moE3ehEnPKD6XyzdPYu8ZGlRKcnf4Ej0jgOO1
	 pxBoAg9ONjHJ0btQGq4vkIJAcwtxqWGZukTXGk5TsSZoi7IUZm8+LxVJ65qHcjgi4G
	 UkeKADXIrBqYHiSCprSQ8b35qiiacAPASW2A/Rd7dAQASTr3OANeZBtWGSIG3zjRji
	 fq4qJLakgXGpjATuvRSZSucFQFrNPoMDPPs8HizfkBCp0226r4tKELvQkbTiO8QiyX
	 JbEOlFP96pRZ3Mtc6QOVd57xw2ouXPfqCedLT/762g+rFGj6oCNI0i/C7x0Is+USw+
	 zd++0VAYpOGJg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Alexei Starovoitov <ast@kernel.org>,
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
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	shung-hsi.yu@suse.com,
	msuchanek@suse.com
Subject: [RFC] kbuild: bpf: Do not run pahole with -j on 32bit userspace
Date: Tue, 20 Aug 2024 10:59:50 +0200
Message-ID: <20240820085950.200358-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Slaby <jslaby@suse.cz>

== WARNING ==
This is only a PoC. There are deficiencies like CROSS_COMPILE or LLVM
are completely unhandled.

The simple version is just do there:
  ifeq ($(CONFIG_64BIT,y)
but it has its own deficiencies, of course.

So any ideas, inputs?
== WARNING ==

When pahole is run with -j on 32bit userspace (32bit pahole in
particular), it randomly fails with OOM:
> btf_encoder__tag_kfuncs: Failed to get ELF section(62) data: out of memory.
> btf_encoder__encode: failed to tag kfuncs!

or simply SIGSEGV (failed to allocate the btf encoder).

It very depends on how many threads are created.

So do not invoke pahole with -j on 32bit.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Fixes: b4f72786429c ("scripts/pahole-flags.sh: Parse DWARF and generate BTF with multithreading.")
Closes: https://bugzilla.suse.com/show_bug.cgi?id=1229450
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: shung-hsi.yu@suse.com
Cc: msuchanek@suse.com
---
 init/Kconfig            |  4 ++++
 scripts/Makefile.btf    |  2 ++
 scripts/pahole-class.sh | 21 +++++++++++++++++++++
 3 files changed, 27 insertions(+)
 create mode 100644 scripts/pahole-class.sh

diff --git a/init/Kconfig b/init/Kconfig
index f36ca8a0e209..f5e80497eef0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -113,6 +113,10 @@ config PAHOLE_VERSION
 	int
 	default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
 
+config PAHOLE_CLASS
+	string
+	default $(shell,$(srctree)/scripts/pahole-class.sh $(PAHOLE))
+
 config CONSTRUCTORS
 	bool
 
diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index b75f09f3f424..f7de8e922bce 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -12,7 +12,9 @@ endif
 
 pahole-flags-$(call test-ge, $(pahole-ver), 121)	+= --btf_gen_floats
 
+ifeq ($(CONFIG_PAHOLE_CLASS),ELF64)
 pahole-flags-$(call test-ge, $(pahole-ver), 122)	+= -j
+endif
 
 pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
 
diff --git a/scripts/pahole-class.sh b/scripts/pahole-class.sh
new file mode 100644
index 000000000000..d15a92077f76
--- /dev/null
+++ b/scripts/pahole-class.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Usage: $ ./pahole-class.sh pahole
+#
+# Prints pahole's ELF class, such as ELF64
+
+if [ ! -x "$(command -v "$@")" ]; then
+	echo 0
+	exit 1
+fi
+
+PAHOLE="$(which "$@")"
+CLASS="$(readelf -h "$PAHOLE" 2>/dev/null | sed -n 's/.*Class: *// p')"
+
+# Scripts like scripts/dummy-tools/pahole
+if [ -n "$CLASS" ]; then
+	echo "$CLASS"
+else
+	echo ELF64
+fi
-- 
2.46.0


