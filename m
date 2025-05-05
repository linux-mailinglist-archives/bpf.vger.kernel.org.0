Return-Path: <bpf+bounces-57451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07174AAB492
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 07:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802413B0DA0
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 05:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674DF4793D8;
	Tue,  6 May 2025 00:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRDQ+KR9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506F0283C87;
	Mon,  5 May 2025 23:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486683; cv=none; b=lGURXuU2CosvtTkumPF1dWdxxhrMks84vRffrTMCqPVWzyiWHwgI+7RvVM2q/aShzVjLufSfZ2uiPKoyFE4+Df0D0nKo3ZedMFc/bfm77U8uMbz1Bn+F1YtuWr3U5v0l0jGpEfx2fCXCs1/8NQXfI45Q7Foxr7VLQ6LOt7Kjqn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486683; c=relaxed/simple;
	bh=03AKzvn2TQE81Zw15swWqMnLTPF7HbWUjCZB2G51KCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u6pI1OZrMlwVL3V85Wsgqh3htvNs2/eJ3WtpOPVF1TDllD25zoVbQ+LaNkfZWtm1ewqRJSkQDn81lmwdu65iP5bcy4jWUNreK/n7/JSN2CwJcakwBd0IRBHTVTqg+X6D8pgu5vhJ2FL0eokiZboC4jCJc41UghQ8zNVl4JaRFkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRDQ+KR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80542C4CEE4;
	Mon,  5 May 2025 23:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486682;
	bh=03AKzvn2TQE81Zw15swWqMnLTPF7HbWUjCZB2G51KCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nRDQ+KR98s62FbYbO2BheQiQEqgdO9cQH1+JDxt8K2ZEqeIfeABUxPz5056ImGlzR
	 mACjCG0/FXmnZnSpcIlp5Lz3ffpA+egmbxa2F9nyjz6Iq/zhQPt+IDMKZni7J1/V4J
	 YJlUDhhFlJMOnS7M68lLhJHZRu91ateq80wCUrMCWFXeIH0Pf4wt+ODedU/4UXDome
	 g6rdVwbg3rYiOha/rvnRlGsuVaI2qw5uAyHGKVsk1CTLFCvSHH3KbA6Qx5FuUSyaOu
	 ut5mvkBx87SqUd+rYBEhz1svm0aTCLvfJkmUbrEIFln1DTcURQLm3lyFWKsVt1G8Hd
	 aHq9pvPE8dzaw==
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
Subject: [PATCH AUTOSEL 6.1 148/212] eth: mlx4: don't try to complete XDP frames in netpoll
Date: Mon,  5 May 2025 19:05:20 -0400
Message-Id: <20250505230624.2692522-148-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 7fccf1a79f09b..95eae224bbb4a 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -446,6 +446,8 @@ int mlx4_en_process_tx_cq(struct net_device *dev,
 
 	if (unlikely(!priv->port_up))
 		return 0;
+	if (unlikely(!napi_budget) && cq->type == TX_XDP)
+		return 0;
 
 	netdev_txq_bql_complete_prefetchw(ring->tx_queue);
 
-- 
2.39.5


