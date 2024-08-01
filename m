Return-Path: <bpf+bounces-36200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0344943F37
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 03:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD3E1C20CB1
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 01:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD081BF337;
	Thu,  1 Aug 2024 00:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JN7YwjgT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5141BE87C;
	Thu,  1 Aug 2024 00:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472684; cv=none; b=jHfFqdfRdKF2s5cfX3sDwLVdyTZCBzK0AHImIrtxvi8J5woX8bL33PAbgH3Mq9fiCLXZGTbEpUu7iDp6pctDJglzcYF4gM1ARaky+FYAV6Rje62HEyylJ03KUIFiCOBWbsm5ku1nAaUX897TQG/8Hau/iNoZ2n3HgnG8sGpfbI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472684; c=relaxed/simple;
	bh=AD63yG5vTEoEuFTqe9zrz6n1nLcYLbIIyUjYULAzZjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OT+BqT9Xk0sayWvIQercm8uV+DxCshjzqaZ9cI6P5JDs1i4qjyniSB5zptcrgbJ/gm3YM7ONpXMht4r9QcIBYuDD0x8KHn9VqlSV8EnHmmKVOR908O1ADlQaoHYQ7VdUv8gi65Yn+tTdhm/DRW0UPz1PrK3Q+XLKvjA0wFtpggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JN7YwjgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92381C4AF0E;
	Thu,  1 Aug 2024 00:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472684;
	bh=AD63yG5vTEoEuFTqe9zrz6n1nLcYLbIIyUjYULAzZjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JN7YwjgTD5M8kHWo+m8elTcuwoUdmB6mOdMMMWksSDu67Bne3N9aXZR/Uwy4CCGeZ
	 Te2kHjT9dlZ+Qdxl3ORuGT3v/wIvP0PeYTA59jEVKLpOWHP5rFuyScyLiHUsLBFWSp
	 Oor1IQoRj1zy8FRdJdkr8jzFe3lhc+fLYMwgqRfdEc2GkqqDPqoBB7du7GKU5v9n+E
	 39gHZLAG9PM90VthjbS4a197uiCngdeHsemtPFHGiO4a/uHaGDyIOL8/ZyIKja/i2m
	 31VtNq96oh4RlBPg21asMXlzi1mPPC3uuzsQPyQty43LSAFkCKuqh+iwo31Liyd7oO
	 lQZ+wMb0uul+w==
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
Subject: [PATCH AUTOSEL 5.10 18/38] bpf, net: Use DEV_STAT_INC()
Date: Wed, 31 Jul 2024 20:35:24 -0400
Message-ID: <20240801003643.3938534-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index a3101cdfd47b9..001da7ccb7089 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2266,12 +2266,12 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 
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
@@ -2379,12 +2379,12 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 
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


