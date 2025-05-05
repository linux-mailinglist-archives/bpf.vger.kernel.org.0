Return-Path: <bpf+bounces-57424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A69AAAB10
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 03:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF224A0E70
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 01:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427393A91CC;
	Mon,  5 May 2025 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wunqb2To"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF67286423;
	Mon,  5 May 2025 23:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486184; cv=none; b=lLOr620+iK7pDc6l9aWpFEZLG7E7j3/jUIxWVuY7h+v6ezdnuKa1BjhRarPcpcnKNesSilzbXv7ucA1UZlUTd2xRijaOexsx55rvkM8C+vsgIeXyXAvUx/gmgH07bcMLHFcTw1SvTHOVNv7P9NEHKWNyQi9egvjb3XlvUp11wpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486184; c=relaxed/simple;
	bh=epos424aK9x9LhxqU7GJMC9sbp5GjGE5n+DQWUwkP5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mjpdo0ivQ4jYOJM/eEr8YrnDZiuASY8vYMRgS4YNamX+9vDlTaE5Ylv1EXeLnf0D+31zCvkLQkrQoDf5/e4hmOdNM8FgP1tKX/HB5sKdkqa3YSogCK2P8S8FLKbIsyEzo76PMIYers1Sr0uUrtrDWBctCASCCplQu8UzG9mT70E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wunqb2To; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4124AC4CEED;
	Mon,  5 May 2025 23:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486183;
	bh=epos424aK9x9LhxqU7GJMC9sbp5GjGE5n+DQWUwkP5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wunqb2ToS9CikcwhmdpmmcoRGNIuYz/t5KzFPqTRnOXM80DbYzMqWXTs1X2/nJ+0W
	 IyXe2k6n7PvJ0L2GY6gf8f9wsIIUgkCSnSRmOecH757ardCUN2RvJ2IkOx072U6IkP
	 8JY+34gWAFLOnCKotMamZDtftFpbi1tqfmrduNqC/OXyT7Q/7M/OYHr8v7r+8ckUhM
	 f3y7RKInHtpdNmYaHb/hyp07MrzYe1aqhC491CQ0slgf4RffD5gzSUAAShxmQLJV78
	 O9CcYUVH2LSsNM+9O8jeOPbtDWsdE6YOnzdazLkTlp6t4CrmdIfoxovRbIdMkXviJu
	 WKOcOCqvaNbJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 191/294] eth: mlx4: don't try to complete XDP frames in netpoll
Date: Mon,  5 May 2025 18:54:51 -0400
Message-Id: <20250505225634.2688578-191-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 8fdeafd66edaf420ea0063a1f13442fe3470fe70 ]

mlx4 doesn't support ndo_xdp_xmit / XDP_REDIRECT and wasn't
using page pool until now, so it could run XDP completions
in netpoll (NAPI budget == 0) just fine. Page pool has calling
context requirements, make sure we don't try to call it from
what is potentially HW IRQ context.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20250213010635.1354034-3-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index 65cb63f6c4658..61a0fd8424a2c 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -450,6 +450,8 @@ int mlx4_en_process_tx_cq(struct net_device *dev,
 
 	if (unlikely(!priv->port_up))
 		return 0;
+	if (unlikely(!napi_budget) && cq->type == TX_XDP)
+		return 0;
 
 	netdev_txq_bql_complete_prefetchw(ring->tx_queue);
 
-- 
2.39.5


