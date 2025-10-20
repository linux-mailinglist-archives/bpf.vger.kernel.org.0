Return-Path: <bpf+bounces-71417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80101BF2650
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 18:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DD418A7AD8
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0667628CF6F;
	Mon, 20 Oct 2025 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="WS8ZlLzq"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B8E28504F;
	Mon, 20 Oct 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977459; cv=none; b=RXDr3veOse3/s+h1JB3elyMd4yT/2i0WSMIUHw3TkhvuzUahnjsMuKMfydTlLGgx656KIANVefDPSegmo6MCrdPkZZ7P4DoksQIlmtw+/XAzsYozzhJR30izqTT3JfHjsVYBi8A1dkb7b+Ka5EtB6s7zcDEuCm2FgTPqj0IWKvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977459; c=relaxed/simple;
	bh=WD2n69XZR58OEhICnjwP/shHQLduaiisQ0RidQldT/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4sEq0voW951Ur2HGkEF95IiPJH1voMFRTbg/SCNayqz/zWpkwcDcK48PXGZoDrQ0Ohgro1vKMSxbTsauwAQlt/r7tMlOowGlFi8exEZ5sFkBXgYuVbCx2nCCi7cjqtqcZgEoL+mhRr3imaKfbZZgkxwhxNZurNvDrWikEGj8fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=WS8ZlLzq; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=iQep+LJD+MoD+/Z8nqH0V4AMAyaAfYgmLkpNaHp8z48=; b=WS8ZlLzqnvL6DULf+7woYwDEDc
	IdKvip1sooP+lBdvE70CBVilOWjxKsIqu1Mr6juHWSdFBTNDBU86+VQqKBrA5bTRjM09Aq/UCrXWC
	QjHYI2jBvevcOYJbNSgN5JHaJGerVnbJibmOjOkFWvFiODs7xfDF4WNeUM22qkXT6qui2DsKFG/j5
	PFn+3KaoU0PMOPYypiSsi+FvcotoqxSCpnaoRYqz11XcdvPxDovfT9GW0UtlgUELytBY448hpOtfr
	qOf5k3ddfJTDbTIgmLJIvRjbYt0mljiQT2mddTEpdeLAg3idI3OEbmT0Ie2uG1S0qrfotcsMp0e+n
	P5SlQ8Gw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vAsg0-000JkY-2C;
	Mon, 20 Oct 2025 18:24:04 +0200
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
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v3 07/15] xsk: Move pool registration into single function
Date: Mon, 20 Oct 2025 18:23:47 +0200
Message-ID: <20251020162355.136118-8-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020162355.136118-1-daniel@iogearbox.net>
References: <20251020162355.136118-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27798/Mon Oct 20 11:37:28 2025)

Small refactor to move the pool registration into xsk_reg_pool_at_qid,
such that the netdev and queue_id can be registered there. No change
in functionality.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/xdp/xsk.c           | 5 +++++
 net/xdp/xsk_buff_pool.c | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7b0c68a70888..0e9a385f5680 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -141,6 +141,11 @@ int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
 			      dev->real_num_rx_queues,
 			      dev->real_num_tx_queues))
 		return -EINVAL;
+	if (xsk_get_pool_from_qid(dev, queue_id))
+		return -EBUSY;
+
+	pool->netdev = dev;
+	pool->queue_id = queue_id;
 
 	if (queue_id < dev->real_num_rx_queues)
 		dev->_rx[queue_id].pool = pool;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 26165baf99f4..62a176996f02 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -173,11 +173,6 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	if (force_zc && force_copy)
 		return -EINVAL;
 
-	if (xsk_get_pool_from_qid(netdev, queue_id))
-		return -EBUSY;
-
-	pool->netdev = netdev;
-	pool->queue_id = queue_id;
 	err = xsk_reg_pool_at_qid(netdev, pool, queue_id);
 	if (err)
 		return err;
-- 
2.43.0


