Return-Path: <bpf+bounces-51080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640E8A2FF16
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 01:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D581166BE8
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 00:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB86E3597B;
	Tue, 11 Feb 2025 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXimKAQK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4FB28F5;
	Tue, 11 Feb 2025 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233786; cv=none; b=mZEsY0pIpZELOL+PLmbcPYNU7G0zQ464+8vTO6CTEQw/IRqzGfvxD0IQeuqQtLt8hkKUCGR9QlPuP5Gng/xlw1W0OzqnabNQ5dRFKff4D3K0YuUiEHQ3QauNrRlfAk8LI4fIq4dKs/VAcBvFPLPx04J7gBS56MbTZC1sFmKOjRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233786; c=relaxed/simple;
	bh=TMgXkr3cTJRM3MaW/W4X97Rj0sxwJzv7gAxKX00QO1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HDIdP9XWjoo78VVPsbIFOp4htaQS4rIop0RipvhCcFVByK3Th+j8knk5lpV3bYE20Txq2vOQhlIIoIF8TeLCeAonUKDy8u/UykILaTGqjOfo6LvFQ9LUC1AvXmvkQTAT+f9xfMfUlTug6UPyhEI+JtlshfpQw25bkr/Qy+HCtwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXimKAQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08730C4CED1;
	Tue, 11 Feb 2025 00:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739233785;
	bh=TMgXkr3cTJRM3MaW/W4X97Rj0sxwJzv7gAxKX00QO1Y=;
	h=From:To:Cc:Subject:Date:From;
	b=AXimKAQK8gtKAqF7lap7m+Ntcb4qLWi68dQxwb0HERhJcKUxpSG2D5D7e2JKqrRbL
	 OydQbSj9RgWKPQxirB4rLTsB4mH7IYirz2Dmg1OAf6yfRP895vtTSq/drXwSP4W3xA
	 Z3T51AMKiOjD2UrpaaROYee4snilkqPvtzos/YW/u/fjlrpTWyRPY5c25mgApK/+UR
	 vmAcESqUeOn5VaX6uRnNFXh0D0RDt2dLCo3L1B8cr4aQ4ciG2R/Bujqimt5gHKU6QF
	 3CgihS2mwyoFgYEPrSCuzSZ2lvstbbZwAKac3ZMm0W8AeSUQA1DZkaWPXevsH0tHPT
	 g59OqFsgfFHgQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Borislav Petkov <bp@suse.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH] tools: fix annoying "mkdir -p ..." logs when building tools in parallel
Date: Tue, 11 Feb 2025 09:29:06 +0900
Message-ID: <20250211002930.1865689-1-masahiroy@kernel.org>
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


