Return-Path: <bpf+bounces-39846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F52A9786F7
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 19:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCB51F26634
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 17:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BDE12D1E9;
	Fri, 13 Sep 2024 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3LacK4h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6D012C54D;
	Fri, 13 Sep 2024 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249096; cv=none; b=iV7eIahCaEomiwWj3tYDNwUC5ztHzTLyq/CHeg1QRjSOQLGaG4xI8XUuIvYRmSKf8w7lOmkIOO0iI0am9i3wPrXkEXC/+kPb08pwkW+cTj8j/tQwqS4HjEjuP8QT4Mhj1FehBaBYjvcjBJSjl5bMXpVe3w+1clFCMlUcYV/X9z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249096; c=relaxed/simple;
	bh=0MDGLcEES7upXwbT6pNUF4Xe7hi4bWsaGE2BeoUuB0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1kEqhg/dWfgwavF2eIWXl2o9IhV6FAlpPMBupHP54laqen7OTtgct+xondaVbkTi1mUVA9M3AVaDvx56Cq8NGf5/jfWtbOUaASxPaVrbRRecWg3i2XNNXQYFOhh9QaiOPPNNTlv60y1IVKY27ibvML4tTFgvyov5YHaQywff/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3LacK4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A894C4CEC7;
	Fri, 13 Sep 2024 17:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726249096;
	bh=0MDGLcEES7upXwbT6pNUF4Xe7hi4bWsaGE2BeoUuB0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n3LacK4hMgt3Sy/JcwZY3aLpzxURukX1PxjrHQGpIwKKZ24h/B99/cmfSXuAApNGJ
	 ISNDwM7ssHW1zE2snlqsjFjCE4FhafhLjvrII5ar/tLRwEiSAwS5M1lQNnZOX5nZjw
	 rDP+jaNqmLfuDwfVEE7CgTEAPr39Gh9EroELccquCwPXPOteVJ9d3YNfGOQfAEemml
	 xQi7xHX67X2OxNXcg7d+5emZLkPxhcRpDvOve3unIH5S8pPj1y/q/t4GmJsZ27oMF4
	 VZq8B/g/mqMZJKR7fW0mx8xhcpWH8u89ojwxM9ZIMddaiC7k2YMjYh+AUaoKE+0Fob
	 Bn0vgO2N7nWSA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 3/3] btf: require pahole 1.21+ for DEBUG_INFO_BTF with default DWARF version
Date: Sat, 14 Sep 2024 02:37:54 +0900
Message-ID: <20240913173759.1316390-3-masahiroy@kernel.org>
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

As described in commit 42d9b379e3e1 ("lib/Kconfig.debug: Allow BTF +
DWARF5 with pahole 1.21+"), the combination of CONFIG_DEBUG_INFO_BTF
and CONFIG_DEBUG_INFO_DWARF5 requires pahole 1.21+.

GCC 11+ and Clang 14+ default to DWARF 5 when the -g flag is passed.
For the same reason, the combination of CONFIG_DEBUG_INFO_BTF and
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is also likely to require
pahole 1.21+ these days. (At least, it is uncertain whether the actual
requirement is pahole 1.16+ or 1.21+.)

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
---

(no changes since v1)

 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index bdf822bc1bab..e24c4caaa067 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -380,7 +380,7 @@ config DEBUG_INFO_BTF
 	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
 	depends on BPF_SYSCALL
 	depends on PAHOLE_VERSION >= 116
-	depends on !DEBUG_INFO_DWARF5 || PAHOLE_VERSION >= 121
+	depends on DEBUG_INFO_DWARF4 || PAHOLE_VERSION >= 121
 	# pahole uses elfutils, which does not have support for Hexagon relocations
 	depends on !HEXAGON
 	help
-- 
2.43.0


