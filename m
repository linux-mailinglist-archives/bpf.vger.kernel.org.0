Return-Path: <bpf+bounces-11369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E03867B7FAB
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 14:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 8D448B20A29
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 12:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8E814005;
	Wed,  4 Oct 2023 12:48:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A34913FF9;
	Wed,  4 Oct 2023 12:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12F5C433C7;
	Wed,  4 Oct 2023 12:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696423726;
	bh=tDwOoIJ/B2p6zbJHMaqLiy/PTVxQiTe4yPxgshPYk9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L4uwjBukmVUGsEbMlX3f/oNaINq7CZiCraPRbLyVM9PS7UUToiaWhDIPmjRBEDw0k
	 7jNADEE4nVQwHp4tG+0PQozeKDGX7JebR6NBird+eR7p6fpD8c8o3EwUsXa0kUJA5r
	 wnNLBgsUkVkyquQdtPcQt+fystj9PkXA2nv6j6UOIF2bpmf/KSbsA1nHKxt3qG7wlL
	 CpJVzu8VRItV5Z5ZU9gQ1/ZRnjNPodeEda8ycNNV5jW/axwK06E/4CNQZi7hIZp7C+
	 cFJADpOZ8Bs6RcPp3FQvdyMWfLIpg4vF7mbXhvN10LabFORCvE2VaWmgxc6gsEaMkT
	 5FdZjwTCzquZw==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 1/2] kbuild: Let builtin have precedence over modules for kselftest-merge
Date: Wed,  4 Oct 2023 14:48:36 +0200
Message-Id: <20231004124837.56536-2-bjorn@kernel.org>
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

The kselftest-merge target walks all kselftests configs, and merges
them. However, builtin does not have precedence over modules. This
breaks some of the tests, e.g.:

$ grep CONFIG_NF_NAT tools/testing/selftests/{bpf,net}/config
tools/testing/selftests/bpf/config:CONFIG_NF_NAT=y
tools/testing/selftests/net/config:CONFIG_NF_NAT=m

Here, the net config will set NF_NAT to module, which makes it clunky
to run the BPF tests.

Add '-y' to scripts/kconfig/merge_config.sh.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 373649c7374e..170fb2f5e378 100644
--- a/Makefile
+++ b/Makefile
@@ -1368,7 +1368,7 @@ PHONY += kselftest-merge
 kselftest-merge:
 	$(if $(wildcard $(objtree)/.config),, $(error No .config exists, config your kernel first!))
 	$(Q)find $(srctree)/tools/testing/selftests -name config | \
-		xargs $(srctree)/scripts/kconfig/merge_config.sh -m $(objtree)/.config
+		xargs $(srctree)/scripts/kconfig/merge_config.sh -y -m $(objtree)/.config
 	$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 
 # ---------------------------------------------------------------------------
-- 
2.39.2


