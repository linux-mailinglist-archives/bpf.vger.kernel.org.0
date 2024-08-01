Return-Path: <bpf+bounces-36195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B498943DEE
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 03:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BCF28474D
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 01:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0CF193063;
	Thu,  1 Aug 2024 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaOq+d97"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6E81D0DDB;
	Thu,  1 Aug 2024 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472213; cv=none; b=dJDppkbLmK8OMIvVA1CmAZUSablsiMccC9QJufiYL1TBJcNOYYhyRtnyxqF0KYrb96sHE4O/CEUGn8DOvdt/ZcA+20u6Ve3WICqyAeuLpxfoWxFdBHkuUQHV1OklvoncjTlGuTXwwQta0Ay8WvySUJrDLlbJjXmn5d0UOuHfPKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472213; c=relaxed/simple;
	bh=YovlZDi/qfoqS2ninbdrhCuSzu1IwnHIWgUV8hhf4EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+mvsbo9Y49rdg6YONoYTcLE8ZQpcghO9/tWjr3foG/kWH4kFjRefTjhZ/scMLAyqa5yNKqid+wrXv9itQgbIomPFpO5/IETR5fFA9POfP1UqxQTx+xtlUZ4uaCSi2BroN+/F2sOQkoAWZwxL7w61QJ0SzR7m43QU5paoSTRGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaOq+d97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D413C32786;
	Thu,  1 Aug 2024 00:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472213;
	bh=YovlZDi/qfoqS2ninbdrhCuSzu1IwnHIWgUV8hhf4EA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qaOq+d97LF1wAnFS7FFFZUbNkH8kiBgGrNsdI4gEFt3cpuldLrmr2uqxRi9zHqtRq
	 DB5JkbRIWyDt+2575odvVlnXAmfvclKREnZFnmICbP35/NMeDDZsERzqPdK2UKXcNq
	 wsNDcuhuAReqVSRZFuokTW4AQujh5PO5Z66zIaLv70+XSCDwWtLojvWcaubE76dQT5
	 Bxefw4kuGXj5i3z7ROcO8RkoSx7PDk9qFAwUrNkp/6S6D5KV4p+lZzcEbpQbgeYpyC
	 F0uwJZMrhVJtK8uOuzdNS8UKpn4GV4Rpsf0wyyNAzBa8paUo0BVkfANi0/DZW+m+XR
	 IkAzXUpLelQpQ==
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
Subject: [PATCH AUTOSEL 6.1 29/61] bpf, net: Use DEV_STAT_INC()
Date: Wed, 31 Jul 2024 20:25:47 -0400
Message-ID: <20240801002803.3935985-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index dc89c34247187..6a04ea9199328 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2264,12 +2264,12 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 
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
@@ -2371,12 +2371,12 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 
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


