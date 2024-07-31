Return-Path: <bpf+bounces-36191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EB6943B6C
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 02:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776FC1C20B1A
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 00:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5942B187FE4;
	Thu,  1 Aug 2024 00:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXgrVyfk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96FC14882D;
	Thu,  1 Aug 2024 00:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471278; cv=none; b=QXBtEKAYpwjlwVehhPR3rZyb+kx3cuJN07/mwoKkpGmWgjHFUuiqlcBGZjeT5klTnfHcWB3sxKEabFt8M/Z2BhdNIiRbdmqOhd+Q1rwccZ0JokCkqe6CzXxK74vAY9RMceN2am45bAN/0T68dNoTrsFvUL/Nohv2jth2Gmkok5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471278; c=relaxed/simple;
	bh=eXx+fKJKXest4nlAVASo2A3GPzpSbmH7UoTRWS4j2VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouOAy4eVhgPj1kkimTP+SQ5Bo1rLE1ONDpLv5IKHI2PUrN6yGSpFR4byhek+wEREW+glAwVWAhddgz9GaD20bDiyQ8GB2zEyl1wi279j1EtLX1PZO5/8JRMrZhosC5zKeLM1tpQUnmA3yc50FMUSGpw3QGOj+iUuTlKQfj9XvTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXgrVyfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB1BC4AF0C;
	Thu,  1 Aug 2024 00:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471278;
	bh=eXx+fKJKXest4nlAVASo2A3GPzpSbmH7UoTRWS4j2VE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IXgrVyfkLbbsgmm3HybF7QwmePyzJCfzrhKBlNsRqmhttZFpp6/ct8EOQlRV89s5f
	 HZ3vOBCqyRQ+pzwJ3ZkAIL52HuNks2XBR03I25GdoEceTOtoI9sMRGZWV7MWWtBoDP
	 MCjJkOalqYOqpSQGecnPNptBPIvlyJ1OediJyuq3P5X/HkQp3ZwZxQ4Z/kdlSO+iUS
	 fwm0DZ2D7Wc8RxUFCr1s7O4ys/JxP2SJq/+w9LZoZ6TwCMPmc5pxusOYpThXx0Bx/4
	 BGA0pruvCajP8ZIQXQUKpo90KYoLAltmgvcLaWnAIehVmD9kwFjCAiI356ih6FUhNW
	 HuCCwfJ4DedwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: yunshui <jiangyunshui@kylinos.cn>,
	syzbot <syzkaller@googlegroups.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>,
	martin.lau@linux.dev,
	ast@kernel.org,
	andrii@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 055/121] bpf, net: Use DEV_STAT_INC()
Date: Wed, 31 Jul 2024 19:59:53 -0400
Message-ID: <20240801000834.3930818-55-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 9933851c685e7..ed8b582c21b97 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2279,12 +2279,12 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 
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
@@ -2385,12 +2385,12 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 
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


