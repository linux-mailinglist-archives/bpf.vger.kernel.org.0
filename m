Return-Path: <bpf+bounces-51084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8A4A2FF3D
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 01:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D3F3A649E
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 00:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294098615A;
	Tue, 11 Feb 2025 00:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxfIxgxv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2DD524F;
	Tue, 11 Feb 2025 00:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234361; cv=none; b=twjRde47JFh05Cv5PlT2/WjCB4zxhg+Xb7GnOBX2NY9plyth71DOgXureUvVpfQyYN9FU2iX9goaj0P2AH3nJS0G7WxUSyMiLoPSLOPX3dNNEkw0KT1KA2OYo1OkAM5pI+xAYuZ6rRGxldjfY5idTBMKBmobjJGtXqRV1wSzkCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234361; c=relaxed/simple;
	bh=TMgXkr3cTJRM3MaW/W4X97Rj0sxwJzv7gAxKX00QO1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UgmBh+G9KekBgvf2p/dkw5zxwakG3KQHtTDBfwD0HGOPwDAG8IXh6pQQNk5GRczLFUvk+/MQ9B2xVx5TCm/TOs3zQf3bqeI1DwPo+CfKV0N8EWqqlP6Ih9kplJdbVPMUyzC/WJ61p6i2QsvjidXioCsogNYzBCNVn1sPU/ixhTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxfIxgxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B1FC4CED1;
	Tue, 11 Feb 2025 00:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739234361;
	bh=TMgXkr3cTJRM3MaW/W4X97Rj0sxwJzv7gAxKX00QO1Y=;
	h=From:To:Cc:Subject:Date:From;
	b=sxfIxgxvhA8w8i81tp/pr+hr3QM2+JGG1brPpQ3oP5nMA2sqjuo8hQ4wpvw2GX3tq
	 p98c5dLO6f6cU0SCIsTWPckGZP3IiMbgrK90cpaL7gBYbfdmfTR0paX+uYBUAJote3
	 HOhzFZVfMaVhUYtAukx7TCojSWQcrq87DyrYIUMQvT3wSDYtYdPVI//j1pdIkTlgOs
	 gSnYGyFegbt5T3nI2Tp37BsPCtN1BrIk734CSdNzOKKO+cxp6FpceAMfVeiNx8ZrUe
	 JAPdw/5qf29tzhSP1e7eXdM/exH/G/yu7x9D5iIAkal3V89MONweyyD7dG5eZFj3Nq
	 CY0ls6jhoNw7w==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Borislav Petkov <bp@suse.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	bpf@vger.kernel.org
Subject: [PATCH] tools: fix annoying "mkdir -p ..." logs when building tools in parallel
Date: Tue, 11 Feb 2025 09:39:12 +0900
Message-ID: <20250211003914.1866689-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_OBJTOOL=y or CONFIG_DEBUG_INFO_BTF=y, parallel builds
show awkward "mkdir -p ..." logs.

  $ make -j16
    [ snip ]
  mkdir -p /home/masahiro/ref/linux/tools/objtool && make O=/home/masahiro/ref/linux subdir=tools/objtool --no-print-directory -C objtool
  mkdir -p /home/masahiro/ref/linux/tools/bpf/resolve_btfids && make O=/home/masahiro/ref/linux subdir=tools/bpf/resolve_btfids --no-print-directory -C bpf/resolve_btfids

Defining MAKEFLAGS=<value> on the command line wipes out command line
switches from the resultant MAKEFLAGS definition, even though the command
line switches are active. [1]

The first word of $(MAKEFLAGS) is a possibly empty group of characters
representing single-letter options that take no argument. However, this
breaks if MAKEFLAGS=<value> is given on the command line.

The tools/ and tools/% targets set MAKEFLAGS=<value> on the command
line, which breaks the following code in tools/scripts/Makefile.include:

    short-opts := $(firstword -$(MAKEFLAGS))

If MAKEFLAGS really needs modification, it should be done through the
environment variable, as follows:

    MAKEFLAGS=<value> $(MAKE) ...

That said, I question whether modifying MAKEFLAGS is necessary here.
The only flag we might want to exclude is --no-print-directory, as the
tools build system changes the working directory. However, people might
find the "Entering/Leaving directory" logs annoying.

I simply removed the offending MAKEFLAGS=.

[1]: https://savannah.gnu.org/bugs/?62469

Fixes: a50e43332756 ("perf tools: Honor parallel jobs")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 89628e354ca7..52207bcb1a9d 100644
--- a/Makefile
+++ b/Makefile
@@ -1421,18 +1421,13 @@ ifneq ($(wildcard $(resolve_btfids_O)),)
 	$(Q)$(MAKE) -sC $(srctree)/tools/bpf/resolve_btfids O=$(resolve_btfids_O) clean
 endif
 
-# Clear a bunch of variables before executing the submake
-ifeq ($(quiet),silent_)
-tools_silent=s
-endif
-
 tools/: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))" O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/
+	$(Q)$(MAKE) LDFLAGS= O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/
 
 tools/%: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))" O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
+	$(Q)$(MAKE) LDFLAGS= O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
 
 # ---------------------------------------------------------------------------
 # Kernel selftest
-- 
2.43.0


