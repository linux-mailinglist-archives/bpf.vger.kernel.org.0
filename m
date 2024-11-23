Return-Path: <bpf+bounces-45499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6FB9D694C
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 14:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A1F1615D9
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 13:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEAA17736;
	Sat, 23 Nov 2024 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Hy9SlGtr"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12504C97;
	Sat, 23 Nov 2024 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732368826; cv=none; b=OXZyWeG2+xZGH85AwIdsi3hljacn+s4LDUGdxhS5k4oZHPwXBu+pYwD1FhSP+C1yldnZAs7+BvMsxaMwN4L0/dduoS/i88HHQD6oWS3dn0PpX3RKCsMxUhFPfsCmiGDB9QsYja2pdwR7aHqsn+RXOItJbhKB1qr24/lP4DSyFkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732368826; c=relaxed/simple;
	bh=QubjNFdX217NlqW7CQI80P2rI7rS9Zd9/BBlXZBgtCM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=icatJNCtSjmByoVutpHR3sUj83mapa4vfq0UdBNBknmlKKTD/sTWyOz5I7Qu8OWki7yytFSYaimjg3J9gUTZUgoOmL0hLRoK4+TbxTQpgRHS9T3vK4a8kXV8G/KyjL8/1xsr4VjLE+tRu4F3SRaTV82075ofNud1fl5V59elKPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Hy9SlGtr; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732368822;
	bh=QubjNFdX217NlqW7CQI80P2rI7rS9Zd9/BBlXZBgtCM=;
	h=From:Subject:Date:To:Cc:From;
	b=Hy9SlGtr9emaXXrIc8ZoSQpoJZ6i3HVk/rLn8HdmFy9+HPGHovO+GKHZ2ZdDQA5CJ
	 IjBwJ9/ikKL18Klui9Zx7Mij5NchNfgY2sXzgmmc8EwGZz25iODiwZg+ChpomlnR8Z
	 jfUHr6BjKOSLjBngulkZiZWtGbeL7NsJz6l7mkNc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/3] kbuild: propagate CONFIG_WERROR to resolve_btfids
Date: Sat, 23 Nov 2024 14:33:36 +0100
Message-Id: <20241123-resolve_btfids-v1-0-927700b641d1@weissschuh.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALDZQWcC/x3MQQqAIBBA0avErBPUbGFXiYjUsQaiwgkJwrsnL
 d/i/xcYEyHD0LyQMBPTeVSotgG/LceKgkI1aKmNUroTCfncM87ujhRYoLO9t87oICXU6EoY6fm
 H41TKB7PEtkVgAAAA
X-Change-ID: 20241123-resolve_btfids-eb95c9b42d00
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732368820; l=961;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=QubjNFdX217NlqW7CQI80P2rI7rS9Zd9/BBlXZBgtCM=;
 b=pyhaXNi0xIiF7prH/ASswKAJnjgeYIadj5viNkBuO7kXVu0tsSuPKPrGKQuLDI4PcTP89ELH5
 Vlmgrq0nZkeD1GxOfSa7RrkC6HcEAWKmTcisqGN8i7abpjBf8REP7E7
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Use CONFIG_WERROR to also fail on warnings emitted by resolve_btfids.
Allow the CI bots to prevent the introduction of new warnings.

This series currently depends on
"[PATCH] bpf, lsm: Fix getlsmprop hooks BTF IDs" [0]

[0] https://lore.kernel.org/lkml/20241123-bpf_lsm_task_getsecid_obj-v1-1-0d0f94649e05@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      kbuild: add dependency from vmlinux to resolve_btfids
      tools/resolve_btfids: Add --fatal-warnings option
      kbuild: propagate CONFIG_WERROR to resolve_btfids

 scripts/Makefile.vmlinux        |  3 +++
 scripts/link-vmlinux.sh         |  6 +++++-
 tools/bpf/resolve_btfids/main.c | 12 ++++++++++--
 3 files changed, 18 insertions(+), 3 deletions(-)
---
base-commit: 228a1157fb9fec47eb135b51c0202b574e079ebf
change-id: 20241123-resolve_btfids-eb95c9b42d00

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


