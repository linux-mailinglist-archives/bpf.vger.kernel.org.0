Return-Path: <bpf+bounces-11370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28BB7B7FB4
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 14:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CD09628220A
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 12:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4840F14010;
	Wed,  4 Oct 2023 12:48:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DB413FE0;
	Wed,  4 Oct 2023 12:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C65C433C9;
	Wed,  4 Oct 2023 12:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696423728;
	bh=GCXPtG2gS4xIl3E4smfsoQMIyJon1TmicxEyAyK0wVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cXzreQBMuuF74CBgHzSwEN2XP6h0oZD0m2xCM0zXXfhTbBayi7b7BfShjv/w/GuwX
	 dcleLXW/kTjBlrlwrCkSAwOnrkrUMQ8ZPR+MPv8maO0c5cpLYMSxcSCA3hTnnBG3fx
	 FpSawKI8+A2WhDqTGl1Sqqb7u0eQJa82fgEHccU6kdfKq3uCPVskQmzIqGFrXPeZgE
	 Tl0+U0BvwXOvIl0LC2W7igEasQ2LnMESCOjarMQOSEaItwmZXGox9RenhfWE5waGQq
	 5Bys358TN2G57KT8cRrUbO9E8U3MPS1t45ikV712Dys5mBOly9cdjewrOSjsULg9Zv
	 VWHL+PeaBg7Hw==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 2/2] kbuild: Merge per-arch config for kselftest-merge target
Date: Wed,  4 Oct 2023 14:48:37 +0200
Message-Id: <20231004124837.56536-3-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004124837.56536-1-bjorn@kernel.org>
References: <20231004124837.56536-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

Some kselftests has a per-arch config,
e.g. tools/testing/selftests/bpf/config.s390x.

Make sure these configs are picked up by the kselftest-merge target.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 170fb2f5e378..0303acb311cc 100644
--- a/Makefile
+++ b/Makefile
@@ -1367,7 +1367,7 @@ kselftest-%: headers FORCE
 PHONY += kselftest-merge
 kselftest-merge:
 	$(if $(wildcard $(objtree)/.config),, $(error No .config exists, config your kernel first!))
-	$(Q)find $(srctree)/tools/testing/selftests -name config | \
+	$(Q)find $(srctree)/tools/testing/selftests -name config -o -name config.$(UTS_MACHINE) | \
 		xargs $(srctree)/scripts/kconfig/merge_config.sh -y -m $(objtree)/.config
 	$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 
-- 
2.39.2


