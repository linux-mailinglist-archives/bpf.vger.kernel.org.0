Return-Path: <bpf+bounces-36197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70576943F33
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 03:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1A2CB27735
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 01:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C61F1A4F32;
	Thu,  1 Aug 2024 00:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xcdi9qaf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029131BCA15;
	Thu,  1 Aug 2024 00:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472485; cv=none; b=Ia9tN48CIJwX/EeouQarvKbspPpTesGCF3AaNHJCDW6QieZgYcbkO4d9nUHdc1p7ufPcx7A6S81nPjvwg58GXrALzcuLOG4HVD1tYUmNQ1VyXPYW0P47VNjyQDANsQwiaJ1tnalUbUqIXftnqrJV6XlOC1sH/wslKTidk1iqupU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472485; c=relaxed/simple;
	bh=km1kyPuQCg6b9+f8PDgeOOuq/ANH2FFgoPhawgwGQmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAqiCHptuDWw4VN2uezgtKpSbgPqgzA539aSzg/icL2mYizcLTkYIeYUPS5Zo2ILY+JcgZmIOHhK93soQBvrijkzPvBfLdJv1PtFKhDocMq3KCpa828AtS32KPXvqHikIXjr5TTX+sEJfvLfXqx8XLE2F7QY315brPhSZc4q4og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xcdi9qaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21230C116B1;
	Thu,  1 Aug 2024 00:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472484;
	bh=km1kyPuQCg6b9+f8PDgeOOuq/ANH2FFgoPhawgwGQmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xcdi9qafuC9zYT1sG9AOGtXL6u47MaFr1L3Nutwi/YKf2CmVnf3Nbe0lkk3NjGtrn
	 1fmGsHyq053T58FZF5n788YK3ap4eYf2axKUP2g8iF43y8I9rgiRMriiw+27RhWdRV
	 tsV9AbbXr6wrF2RJfchyHFLejafglAO0YTUpMEZicffa/oud7rzKTuWMz040qcd5SG
	 5NlLUop0aXGBaV5NoY/yYaod4jYvjCGrSxPPLIZGRl8fCjgwtwYhdQBNoV4smnxURq
	 2diXbb7qz10G1LbV2SheKOIK0n+6qjXadajHRpHoxMxf/KU9DYAIH5QrGoVUOEnv5q
	 zDVqQJlMAaMKw==
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
Subject: [PATCH AUTOSEL 5.15 24/47] bpf, net: Use DEV_STAT_INC()
Date: Wed, 31 Jul 2024 20:31:14 -0400
Message-ID: <20240801003256.3937416-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index a873c8fd51b67..c5bc9fd3e9275 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2255,12 +2255,12 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 
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
@@ -2360,12 +2360,12 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 
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


