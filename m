Return-Path: <bpf+bounces-36193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C64943D3D
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 02:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1174D286201
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 00:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91DA1C37B8;
	Thu,  1 Aug 2024 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSxL6Xsf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298F91C37A1;
	Thu,  1 Aug 2024 00:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471855; cv=none; b=DjllQifuj9nPg1hMNpU7Z1L12udj50eGcCqGmLUKVGW6h276Ougkr4Osm/6zh7Wkpt0681L1vy8TTghcFspBWz9TXBYhQJnEwr60ITQo1jlV3btqEqYfj7z4x4x11cnOXzrcznqrkm0r9t4pHT3AB7Md9Qb+8+SFlg6fJFmaHXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471855; c=relaxed/simple;
	bh=EX/ZEti9WyGQseeolRjW5OUiCOr5mK7TgYaQeLPsqw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIzoc5Qb81+fDmboEOIebyPzxK9aTvxwqyCneUCBoO/TLOU5PPVaCI7JlIdbIYCZD+Kiv2zSyAumO9ZwyJEVqT9awWmHDORJbnEaogSLjCLpUrRcMUKWJ7M7uKIXH+mjDifruLBU2s8zBYtXtM9SggQjHwtDq6K+NtNPCrmpEKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSxL6Xsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31A0C116B1;
	Thu,  1 Aug 2024 00:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471854;
	bh=EX/ZEti9WyGQseeolRjW5OUiCOr5mK7TgYaQeLPsqw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oSxL6XsfzQE/m7jC2Z5jMmBq3GeX2zEzUMVx0Sw5DO30bZmy3mYtbzuolHG+0eVQ+
	 uJtJplbZ2WW20Us9D9gfjXcidntAiGujpnWAvLc5bL/TUFlTOCszHqsmR5zDIbbnMO
	 QUVrF8O3ySqLX0+g0sowNk0Hx7gRPajZG7PYrdeOEQuPfBz10iNCrEe27rGs9aIy3d
	 TFE+FkXcPKO0V3IJaQB2UBU3gMd/Ug/cmO19UyST3+3kbdUC4Mp4bXqAc7mcJJnskY
	 /30qNp6mzV2zTduYV6FeLNDRWWf8g1lPbUXOeIDKnFDvca6B7e6BIQZzrnsGv05vwx
	 FXVqWTwYEHkeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: yunshui <jiangyunshui@kylinos.cn>,
	syzbot <syzkaller@googlegroups.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 38/83] bpf, net: Use DEV_STAT_INC()
Date: Wed, 31 Jul 2024 20:17:53 -0400
Message-ID: <20240801002107.3934037-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: yunshui <jiangyunshui@kylinos.cn>

[ Upstream commit d9cbd8343b010016fcaabc361c37720dcafddcbe ]

syzbot/KCSAN reported that races happen when multiple CPUs updating
dev->stats.tx_error concurrently. Adopt SMP safe DEV_STATS_INC() to
update the dev->stats fields.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: yunshui <jiangyunshui@kylinos.cn>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20240523033520.4029314-1-jiangyunshui@kylinos.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index afe38b8dee024..86aac8ccd855e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2271,12 +2271,12 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 
 	err = bpf_out_neigh_v6(net, skb, dev, nh);
 	if (unlikely(net_xmit_eval(err)))
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 	else
 		ret = NET_XMIT_SUCCESS;
 	goto out_xmit;
 out_drop:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 out_xmit:
 	return ret;
@@ -2378,12 +2378,12 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 
 	err = bpf_out_neigh_v4(net, skb, dev, nh);
 	if (unlikely(net_xmit_eval(err)))
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 	else
 		ret = NET_XMIT_SUCCESS;
 	goto out_xmit;
 out_drop:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 out_xmit:
 	return ret;
-- 
2.43.0


