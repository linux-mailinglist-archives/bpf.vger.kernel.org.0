Return-Path: <bpf+bounces-45541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E099D7591
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 16:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7A46B3A9DD
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 15:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D71D241A6B;
	Sun, 24 Nov 2024 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKSy2tbg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDCC1B3F3D;
	Sun, 24 Nov 2024 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456461; cv=none; b=ufmeRCc24dEPGp4zXC1ye192ZZcZ27Kxz4z5k40uabjzC7yC/wlFGR2ZXo1YAupvLL5InSG4SYFWjPQyJKlv0+EzFSQmHKNV9XNmsrDhLLAOVo9QgcKX8MJg4DP/rJg+/Q+9nMHYLzoXVQW8MZ5uqsP0L2RtRtNXUgrRtPnJvD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456461; c=relaxed/simple;
	bh=UfvA3jp7HA7D1xdiFW8nzCh+DbA83drGo8aRe/3mfk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPjlcb303WlFlo8fgSGzX8GCIW2TTR5m53rdT9SWzjG8AtoRt9pkJRKri7olsSlzkEd4A/V5k4YQ8StAmpXsIH9YzRbc8XSIjgLXhdRpHvNCZbqH0giTZZafhpnTi1FDNW3Ld4G8zg4bKJpMx4Tcq+LC2cfRIj5lBTepJvMAh8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKSy2tbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9A0C4CED3;
	Sun, 24 Nov 2024 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456461;
	bh=UfvA3jp7HA7D1xdiFW8nzCh+DbA83drGo8aRe/3mfk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKSy2tbg73kKQOovr7yYv7xa2wwcN3ymrNhBJmkh1n6qytPaOh1tGNMk00dhWS/UF
	 zDTSB5dykgG6G2dkQMllMv7kozhGxIeQ2YDtsutL8jVzdgCLCD1K93tg78+HmfYNMp
	 Uw0f991ACLjWBzBjxYdCfhsI/k4lcByi9DZwX4+iWiwcriwYN7tB7QT1dQO/zNC3Hm
	 bYsiHpEGhIbpOJbUssMB2nc03Kvu049lWoay52Yx8toDwPvzhzrAUeRXc5I3lmtDDt
	 ideyTgNHIysHPFPtbENlcgbQXQLOGXW/H9JGTanqF0C8KCoEQrUvmQTOc2joPy24kw
	 de7sodxVI0ULA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 06/33] samples/bpf: Fix a resource leak
Date: Sun, 24 Nov 2024 08:53:18 -0500
Message-ID: <20241124135410.3349976-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135410.3349976-1-sashal@kernel.org>
References: <20241124135410.3349976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
Content-Transfer-Encoding: 8bit

From: Zhu Jun <zhujun2@cmss.chinamobile.com>

[ Upstream commit f3ef53174b23246fe9bc2bbc2542f3a3856fa1e2 ]

The opened file should be closed in show_sockopts(), otherwise resource
leak will occur that this problem was discovered by reading code

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20241010014126.2573-1-zhujun2@cmss.chinamobile.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/test_cgrp2_sock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/test_cgrp2_sock.c b/samples/bpf/test_cgrp2_sock.c
index b0811da5a00f3..3f56519a1ccd7 100644
--- a/samples/bpf/test_cgrp2_sock.c
+++ b/samples/bpf/test_cgrp2_sock.c
@@ -174,8 +174,10 @@ static int show_sockopts(int family)
 		return 1;
 	}
 
-	if (get_bind_to_device(sd, name, sizeof(name)) < 0)
+	if (get_bind_to_device(sd, name, sizeof(name)) < 0) {
+		close(sd);
 		return 1;
+	}
 
 	mark = get_somark(sd);
 	prio = get_priority(sd);
-- 
2.43.0


