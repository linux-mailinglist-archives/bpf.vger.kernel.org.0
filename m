Return-Path: <bpf+bounces-38295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93867962E2F
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 19:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4D11F213FE
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 17:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C221A4F3E;
	Wed, 28 Aug 2024 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UN9rpdLZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49181993AF;
	Wed, 28 Aug 2024 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864837; cv=none; b=MCHK/jHbbjJm8b4QBnGn4I4CMP3hfIQeN32LOD6dQD9XI69dr9XZSG/roEc5zEYD2ahpUuwydI/MtdBjT9zExfcbTZ8tH9Hqe9LZq1miPFyqj1VpWzLszKWiGgj0Wy1+agvxYTtuo2GtkP63v0OfZ2SOucSB7R8hsr6FYG52YLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864837; c=relaxed/simple;
	bh=pCwkuxIA/PL1fSIcCkDcOGMRAvj0Tl2aZe1GItitm5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2VBcKI3/SBXQOyf/hnLVhE/Sm5hiB3XCII/x911ui1l4knZ0SnCvFgOEkJ+c5nPUXokgryju/sviPEptT9EjcfMRHtrF0/w5YxLc4tLN+t75SU4rIow0kfT6SzKuojNB1OvdXWuckzuVdT1GNBAnbLZlWTPSMd6ClYf73KBG7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UN9rpdLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82149C4CEC0;
	Wed, 28 Aug 2024 17:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724864837;
	bh=pCwkuxIA/PL1fSIcCkDcOGMRAvj0Tl2aZe1GItitm5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UN9rpdLZ3GsczB05NtpzdSuz/MbY+ht3rI73v5Kg3Sls/Q1R8/qQipI1OiFGX/2mw
	 3Jg7XObfNxSVN0vO+PqN/77bxLz9XTNnJQq0gxdW9lBWgS2nMbgtRNdIE2NY8qO0Uw
	 yBhzJoNaOLGYcEbBJEBaTF3Tm7hIZrXxdR/PE5dBhF8oyQN6A7USP0x89wYEY+10G3
	 gU9zJXQFBg5ssoN2Y/8pwfphKIrcnTqG1qImgOGmtng3xWnY+tBqXyK3jL9e/XK1Oi
	 H4gVVflLXrm6PRkteTDG45GwGHqnX9KdyEEKGfAw1ZplE68l1P+h27mNQRDuYENoQ/
	 o0jM6KbKC9akw==
From: Alexey Gladkov <legion@kernel.org>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v2] bpf: Remove custom build rule
Date: Wed, 28 Aug 2024 19:06:35 +0200
Message-ID: <20240828170635.4112907-1-legion@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <CAK7LNAQju8OeqW_8JtNXAQWow8Ho8778Rq-Y_v22PSrbB39L0g@mail.gmail.com>
References: <CAK7LNAQju8OeqW_8JtNXAQWow8Ho8778Rq-Y_v22PSrbB39L0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the documentation, when building a kernel with the C=2
parameter, all source files should be checked. But this does not happen
for the kernel/bpf/ directory.

$ touch kernel/bpf/core.o
$ make C=2 CHECK=true kernel/bpf/core.o

Outputs:

  CHECK   scripts/mod/empty.c
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  CC      kernel/bpf/core.o

As can be seen the compilation is done, but CHECK is not executed. This
happens because kernel/bpf/Makefile has defined its own rule for
compilation and forgotten the macro that does the check.

There is no need to duplicate the build code, and this rule can be
removed to use generic rules.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 kernel/bpf/Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 0291eef9ce92..9b9c151b5c82 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -52,9 +52,3 @@ obj-$(CONFIG_BPF_PRELOAD) += preload/
 obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_relocate.o
-
-# Some source files are common to libbpf.
-vpath %.c $(srctree)/kernel/bpf:$(srctree)/tools/lib/bpf
-
-$(obj)/%.o: %.c FORCE
-	$(call if_changed_rule,cc_o_c)
-- 
2.46.0


