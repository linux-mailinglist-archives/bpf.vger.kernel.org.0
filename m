Return-Path: <bpf+bounces-68981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EA6B8B583
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA245A7C7C
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 21:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642AF2D5951;
	Fri, 19 Sep 2025 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="X/TfwB0z"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550732BE051;
	Fri, 19 Sep 2025 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317530; cv=none; b=rPe6vT9VPdlptEod0wRsukoT9z43l/tK80ZunngrAL5KKx8jCfB0kLq79pR+LQpJZbbiATQ7u7rVMtuHU/B84j3WwfFiqn0DO2hm9Ymf6aGCo0D+XP66wc6XVjegamEOoe8NRj9CX0QYA72pm8OkxO9Va60cN++yk5WX68fBMKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317530; c=relaxed/simple;
	bh=/KGmccBEbD9e+Ru/qRtHgoDCRCZAG8J1k6KadeqMcXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npP3FBW3vGr5ASBscnFaGE7m6gIRIA0t2lQvbe1tI15c3/jedgkq6i/TpRq6Okon66aSkAIsYSK6y6CjfbbnGlbJAqx8KmXI2LYfiWIXytVVMOp1iq0o0sBajnOlcFsdS00FTziHC4exF+rRN4rhBDUGXyQBVKpOtP/B8WDHr8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=X/TfwB0z; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=wOsfpZJWwn45iOS1PcjYeXGCpH6y4Eyqy3BpRjkd/k0=; b=X/TfwB0zhshDNL/tTexrCp/iQb
	d+nw0rkhkr7+kQOlun9SC/NL6fqzaJf9TaDdjrxJC05NZ9QCeYHpKTXCAgA2jCZORj+cu6+6sr6YU
	qG80x3IHobj4prt4K5nKzlIeY/piKji12jZRn+ghEiM/K3wvtklfNp/QHkBCOoNF3dy2XABbleV99
	VdqgA0ym+o392SdxFbWc6DahJH28bWtNTFStHZZLpIph3rGVGvmak2rS0k+WitRHxxoJ8hdzYFi/q
	Ot7Oz+3ArsGMUif9YWOWD2YrB2LvaIyuBX5PLz+c3ZlKk557a9eodtoiWoKSbHTwOjcmCeULEp0Ib
	A9U0Ea6g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uzihx-000Npr-27;
	Fri, 19 Sep 2025 23:31:57 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next 03/20] net: Add ndo_queue_create callback
Date: Fri, 19 Sep 2025 23:31:36 +0200
Message-ID: <20250919213153.103606-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919213153.103606-1-daniel@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27767/Fri Sep 19 10:26:55 2025)

From: David Wei <dw@davidwei.uk>

Add ndo_queue_create() to netdev_queue_mgmt_ops that will create a new
rxq specifically for mapping to a real rxq. The intent is for only
virtual netdevs i.e. netkit and veth to implement this ndo. This will
be called from ynl netdev fam bind-queue op to atomically create a
mapped rxq and bind it to a real rxq.

Signed-off-by: David Wei <dw@davidwei.uk>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/net/netdev_queues.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index cd00e0406cf4..6b0d2416728d 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -149,6 +149,7 @@ struct netdev_queue_mgmt_ops {
 						  int idx);
 	struct device *		(*ndo_queue_get_dma_dev)(struct net_device *dev,
 							 int idx);
+	int			(*ndo_queue_create)(struct net_device *dev);
 };
 
 bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
-- 
2.43.0


