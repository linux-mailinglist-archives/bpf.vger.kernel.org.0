Return-Path: <bpf+bounces-70993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B419BDEE6B
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5ED219C7A83
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 14:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA76B27381F;
	Wed, 15 Oct 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="p8PP+8Wk"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A504C26B0AE;
	Wed, 15 Oct 2025 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536935; cv=none; b=Rr8irM11i8TlSmCEM2/JMKyKrU0Ojvb4PYuf8ukACP7ouSqKVXYZ6GGRNdGbXgC0w1/TXP8xSY18YuVgzFQuCDeJ5xdlC0bU+yz/7HrqC2ou9bAgpjMa5r/12QwgHDAfD5wYQ1TM26727CifVhF1sIlb5GFIPDUnvwhKUevVfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536935; c=relaxed/simple;
	bh=OdkcLCeD99XL5md1owpcPM+ldZS5obh3dUjtpEqzPgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTJjDwEKS8DQyoTziR7afTX9yIBwqh+HCWZrwjJdTnfRjdZ0mXMerPZFQYwrop6gciwgN/0XuspHap9fitmZ77lvhNxl9VCEhPn0qWSrP1d20uEiN1IDq9EPOKhNpKgwtPoEkl7HMFUiMfvW0jbSktIjA8FrBq7YqAdNtvmmc4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=p8PP+8Wk; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=VOU8YA/WLiVWqyna2qWF3IA/KUiduL+6BE5o8MojQjI=; b=p8PP+8Wk+B+FlSk2FnFYQFrZH3
	ceQAfVcLCBY8yyKk1YIQwPCaHdJjN5PsEmMbQKgZ/YlF5nJjQ5ZbKVQtjBQ33lgUrD0frdmLrEXvv
	ISCqaeTXCNfYsc+psTRboLckhUbzf8Q2frIorNZVMeAsYVonyZ7M0MD7jWqMMz5HvizwxakyQl12y
	M+86/SwQErZvpyvRM4HDRngIM/kAJ6dkx35GeLgQiIchGoOlsR64t/0CKKkbSpznM+uSMDHr1C0ds
	xj8S3acPUUmyMUkv+D6tMBvZb8s9Xa2YlFnalCp/cj8PqYgNy2J4SEyzdTBWUM/pLhCLB3I4tswYv
	9hZ15Q8g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1v924e-000H7x-1Y;
	Wed, 15 Oct 2025 16:01:52 +0200
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
Subject: [PATCH net-next v2 09/15] xsk: Change xsk_rcv_check to check netdev/queue_id from pool
Date: Wed, 15 Oct 2025 16:01:34 +0200
Message-ID: <20251015140140.62273-10-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015140140.62273-1-daniel@iogearbox.net>
References: <20251015140140.62273-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27793/Wed Oct 15 11:29:40 2025)

Change the xsk_rcv_check test for inbound packets to use the xs->pool->netdev
and xs->pool->queue_id of the bound socket rather than xs->dev and xs->queue_id
since the latter could point to a virtual device with mapped rxq rather than
the physical backing device of the pool.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 net/xdp/xsk.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 0e9a385f5680..985e0cac965d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -340,15 +340,13 @@ static int xsk_rcv_check(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 {
 	if (!xsk_is_bound(xs))
 		return -ENXIO;
-
-	if (xs->dev != xdp->rxq->dev || xs->queue_id != xdp->rxq->queue_index)
+	if (xs->pool->netdev   != xdp->rxq->dev ||
+	    xs->pool->queue_id != xdp->rxq->queue_index)
 		return -EINVAL;
-
 	if (len > xsk_pool_get_rx_frame_size(xs->pool) && !xs->sg) {
 		xs->rx_dropped++;
 		return -ENOSPC;
 	}
-
 	return 0;
 }
 
-- 
2.43.0


