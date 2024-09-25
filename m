Return-Path: <bpf+bounces-40300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B95B7985BFA
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 14:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0D5284C82
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 12:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7B01CB539;
	Wed, 25 Sep 2024 11:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWMSD9HZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFB818592A;
	Wed, 25 Sep 2024 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265209; cv=none; b=PfOi9O/epGDYvM461r2ChKutORcNONxU31UbXqAafImSE+Ea9FIPISpr1TlqIqoZUMrh1KoTdiYEgmE172N3xIykpeLnh7YcybzGzZze8OzLrWYnkycGFo/Ix7aaX/p8qsXilwHIuR5hL/aFCFCRlphDpD7+RiCGoJplUi87yk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265209; c=relaxed/simple;
	bh=5ipd+6i1vmYzbqSVixtByEgWCPbCf8XMcpZSqw510BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OelDybOieQitrOZxDt7qj6UgdcUEfSVFFKXV5uYz1yNqX75t7wl/wCGAy3oQlIg+tgN/isMJ6N73zhEIQi5mzYAuDemxx+kq/jf5F8qFxvY8rX0FfuA10RCgA3SFsfAZ0zJ8vAv0x0W4wcm1EZUOKpIe0IWdtiOC0Nh/3g45868=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWMSD9HZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1228C4CEC3;
	Wed, 25 Sep 2024 11:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265208;
	bh=5ipd+6i1vmYzbqSVixtByEgWCPbCf8XMcpZSqw510BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWMSD9HZD1EiO7GrBr7/M94FwJt/VGjg+/6dLySI/sC4Yv9UoJCc+q+tNwFGY69Dv
	 gfrcF/mKTO604OFuaND2ma6hVzCadOdmtM0/6S4n1zGRSrMaIIWUzXQDndNwIZFFtq
	 4TFIM5lssNJayrvnAKEYfYxFgwSj974iDT4SZa5/AHlI8wsnAdO6iWL5U1wHPKoySa
	 zD7S+rs+wJ+TSYw5DQF77QYvxEPrxfNvC9RvSEm8TNl+NL9yiQu992bRAPrSN5mEU+
	 nzcD5EDiIB6e/9XmDK3mEagbqyVFug4ji3LQxPkGtnerGRfdi6pEAXni0FlxYdFHPc
	 EUHCXLvN5agxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 241/244] bpftool: Fix undefined behavior caused by shifting into the sign bit
Date: Wed, 25 Sep 2024 07:27:42 -0400
Message-ID: <20240925113641.1297102-241-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Kuan-Wei Chiu <visitorckw@gmail.com>

[ Upstream commit 4cdc0e4ce5e893bc92255f5f734d983012f2bc2e ]

Replace shifts of '1' with '1U' in bitwise operations within
__show_dev_tc_bpf() to prevent undefined behavior caused by shifting
into the sign bit of a signed integer. By using '1U', the operations
are explicitly performed on unsigned integers, avoiding potential
integer overflow or sign-related issues.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Quentin Monnet <qmo@kernel.org>
Link: https://lore.kernel.org/bpf/20240908140009.3149781-1-visitorckw@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 968714b4c3d45..ad2ea6cf2db11 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -482,9 +482,9 @@ static void __show_dev_tc_bpf(const struct ip_devname_ifindex *dev,
 		if (prog_flags[i] || json_output) {
 			NET_START_ARRAY("prog_flags", "%s ");
 			for (j = 0; prog_flags[i] && j < 32; j++) {
-				if (!(prog_flags[i] & (1 << j)))
+				if (!(prog_flags[i] & (1U << j)))
 					continue;
-				NET_DUMP_UINT_ONLY(1 << j);
+				NET_DUMP_UINT_ONLY(1U << j);
 			}
 			NET_END_ARRAY("");
 		}
@@ -493,9 +493,9 @@ static void __show_dev_tc_bpf(const struct ip_devname_ifindex *dev,
 			if (link_flags[i] || json_output) {
 				NET_START_ARRAY("link_flags", "%s ");
 				for (j = 0; link_flags[i] && j < 32; j++) {
-					if (!(link_flags[i] & (1 << j)))
+					if (!(link_flags[i] & (1U << j)))
 						continue;
-					NET_DUMP_UINT_ONLY(1 << j);
+					NET_DUMP_UINT_ONLY(1U << j);
 				}
 				NET_END_ARRAY("");
 			}
-- 
2.43.0


