Return-Path: <bpf+bounces-57434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93271AAB006
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 05:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF1B1791A1
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 03:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA4D306CD6;
	Mon,  5 May 2025 23:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a68iXobL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B83B2F5E;
	Mon,  5 May 2025 23:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487251; cv=none; b=XC+uO5WDY4memGxLBwQLrJ4iWo0OHATypjWFILCgI2JLAXyoaji94oBt5YgHpB6WFy+lcwvfUdAlClynArvutAG3gPonEYoK7s1+zuf4aspNmyOZ+wRN9V1T5lvcc6QY2MWBq0MwkbISDj+mewDmamXuDm0SLHIkv0aanx7BD9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487251; c=relaxed/simple;
	bh=zpoTVQiX85g5nhJT5n21FN5LeRInX/Str/Fj3W4LElc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AAdMS6S3sNtJXfGxKN0BnTOj3YCyCLmXRq647dEzhQtp+FOobQ47mAY7B76x98RfjgDfnKNR31Y0D5nDxuQXiLU81FLIScsKNStuq1YrfQrwH6Z1XBhgXXuvfP5AWAzXM+OPqgoBl1Kfz4p13dL8Po59Y6eWOFxbhlPLww5VVbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a68iXobL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF799C4CEEF;
	Mon,  5 May 2025 23:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487249;
	bh=zpoTVQiX85g5nhJT5n21FN5LeRInX/Str/Fj3W4LElc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a68iXobLM5bIgaZz0I7p6hQl5hXgFci6B7yf0cYvHD2Q5nDZvaaD7PoI/EnmIpcmR
	 mP0tcYFHF/Nz7N53aGgRQ9Iqr+pMiwt1lWyowToMrvxndnJeRXANBQm05FTLdAd0kT
	 usAXgX9WjlpLXVIo0SNZGkynutb/nJBnhRW0V2xSMl7rpmhyobYqmxdPASpkPdNpH6
	 lRHRWypltdQATzVTtbt3I5jbZj7I3yVFbzTlCK0GqBmz74wyWrz8mNSgGJut98mW3B
	 iyVekVBEL5wzjP+kpEni85QWPWYGs2Vi307dfBM5ERO/JIVowBcOA8AsPZwKQNpfZU
	 HOFMSLrQqXyuA==
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
Subject: [PATCH AUTOSEL 5.10 079/114] eth: mlx4: don't try to complete XDP frames in netpoll
Date: Mon,  5 May 2025 19:17:42 -0400
Message-Id: <20250505231817.2697367-79-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 59b097cda3278..6c52ddef88a62 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -445,6 +445,8 @@ int mlx4_en_process_tx_cq(struct net_device *dev,
 
 	if (unlikely(!priv->port_up))
 		return 0;
+	if (unlikely(!napi_budget) && cq->type == TX_XDP)
+		return 0;
 
 	netdev_txq_bql_complete_prefetchw(ring->tx_queue);
 
-- 
2.39.5


