Return-Path: <bpf+bounces-57402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D57AAA593
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 01:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52590188D7B6
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 23:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEA53120B7;
	Mon,  5 May 2025 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLM7vya/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434153120C0;
	Mon,  5 May 2025 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484224; cv=none; b=hDsz3XAwOf8BTgiYQ1pxwVY7l6LQ6TbIOu6PcKs3V6RNvu5huu3MZ+Pg/QO2mX0mocECVkNup6Ngc/HLHqpTdpoNOWhaX2zcJz/1u4zH1HtoVJt6Duo6tmFZfLmuexw1VTabWzEbOwmy1oYgF7KjrIBFbrrRzyMB+3Df/XK0uNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484224; c=relaxed/simple;
	bh=MdrJnSTl2GoD+ObNrqreZP6yMBRewaoB71vuYFeA3Rw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u9zf9fpjUImr+A+8N5b5xgynaYwalGN4WPX9s7AjqIwcc25aAi9kCMAuenuEQh1eflB7SDh21o6Kk59ysZXq7XA5pk0vSdOPWzENiRUjl5bSaXzanAouX7e7+ZuLOtrsAwdJx1Oi9zxbP0ueN/0ZpGNMEL4zSI1DmcngIp8oVQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLM7vya/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11792C4CEEE;
	Mon,  5 May 2025 22:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484223;
	bh=MdrJnSTl2GoD+ObNrqreZP6yMBRewaoB71vuYFeA3Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TLM7vya/8fx/uiQVYSrSkfs9trkED2WFaXMeLYJpMgVKoNeOr/ABJ1R76pVlc3BQl
	 NblHHxpZdiZnssvowxFsIXG7959k9F9n6DkPvjBvyAWx1w1OSefZ2XEP/lXV3cZwgY
	 3J2OMNiQyvRGov+Rx+/vaXQQ+CuQf5Uxrq0prG49w+ZFGhYqLf7x/ADV/kODqdRtUg
	 m2iOf7XYfnoQZ+c0Pd8DPFlh3O6gKgkgCOmCptu8K4UymGc72p7fU8gW/6axA5SuYH
	 deT8m4URY/TWcqjfsoBAqnWFnK8gPgknj4OA7yuI1cUSO9AERNAyFlU1LDKlpf/yer
	 c6iBz+krbwdNA==
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
Subject: [PATCH AUTOSEL 6.14 396/642] eth: mlx4: don't try to complete XDP frames in netpoll
Date: Mon,  5 May 2025 18:10:12 -0400
Message-Id: <20250505221419.2672473-396-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 1ddb11cb25f91..6e077d202827a 100644
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


