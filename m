Return-Path: <bpf+bounces-50132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72345A232A7
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 18:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF4C1884A16
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 17:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C552D1EE7DF;
	Thu, 30 Jan 2025 17:16:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25977136337;
	Thu, 30 Jan 2025 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738257412; cv=none; b=ROcxvMksIB9u75zs5m7hQKKSqd7WgRNsjAvLBfeKzTHB7b//WHk60GkA67ZxaD8jUekXxdVJAH5lmijR3jbc6ZDYtaUNq0jOleNZzv0FPfOSj5v9qxMhHyn4kxcz9t7BFQ+qWnqjpUS6bjSkjV1Q7d+PgVB2gjEDaKNBPVqgl0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738257412; c=relaxed/simple;
	bh=kbY96610c4qVJ1a/s9BCQ8VCCiT6RH+hUk7H/IHX74c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZrqGot41bj+mAWUUt4Qk0w9DEbBSIrpBlbssSVMIyOIVUKMHLMI1pdmBtskDw5SJxpS493MESe9oZacxXhdrBOvCxUhPAcZXedH6/70yaECDHqKU31apZ0Ey4gp7bOFl/i9jH/V89T8J9FmWOE9Z9WdORDLPr2w0jmhOCgs0co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tdY9Q-000OMO-5L; Thu, 30 Jan 2025 18:16:24 +0100
Received: from [2a0d:3344:1523:1f10:f118:b2d4:edbb:54af] (helo=marcus-worktop.lohne.int.wichelmann.cloud)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tdY9P-000163-2i;
	Thu, 30 Jan 2025 18:16:23 +0100
From: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Subject: [PATCH 1/1] net: tun: add XDP metadata support
Date: Thu, 30 Jan 2025 18:16:14 +0100
Message-ID: <20250130171614.1657224-2-marcus.wichelmann@hetzner-cloud.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130171614.1657224-1-marcus.wichelmann@hetzner-cloud.de>
References: <20250130171614.1657224-1-marcus.wichelmann@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27534/Thu Jan 30 10:34:41 2025)

Enable the support for bpf_xdp_adjust_meta for XDP buffers initialized
by the tun driver. This is useful to pass metadata from an XDP program
that's attached to a tap device to following XDP/TC programs.

When used together with vhost_net, the batched XDP buffers were already
initialized with metadata support by the vhost_net driver, but the
metadata was not yet passed to the skb on XDP_PASS. So this also adds
the required skb_metadata_set calls.

Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
---
 drivers/net/tun.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index e816aaba8..d3cfea40a 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1600,7 +1600,8 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 
 static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
 				       struct page_frag *alloc_frag, char *buf,
-				       int buflen, int len, int pad)
+				       int buflen, int len, int pad,
+				       int metasize)
 {
 	struct sk_buff *skb = build_skb(buf, buflen);
 
@@ -1609,6 +1610,8 @@ static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
 
 	skb_reserve(skb, pad);
 	skb_put(skb, len);
+	if (metasize)
+		skb_metadata_set(skb, metasize);
 	skb_set_owner_w(skb, tfile->socket.sk);
 
 	get_page(alloc_frag->page);
@@ -1668,6 +1671,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	char *buf;
 	size_t copied;
 	int pad = TUN_RX_PAD;
+	int metasize = 0;
 	int err = 0;
 
 	rcu_read_lock();
@@ -1695,7 +1699,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	if (hdr->gso_type || !xdp_prog) {
 		*skb_xdp = 1;
 		return __tun_build_skb(tfile, alloc_frag, buf, buflen, len,
-				       pad);
+				       pad, metasize);
 	}
 
 	*skb_xdp = 0;
@@ -1709,7 +1713,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		u32 act;
 
 		xdp_init_buff(&xdp, buflen, &tfile->xdp_rxq);
-		xdp_prepare_buff(&xdp, buf, pad, len, false);
+		xdp_prepare_buff(&xdp, buf, pad, len, true);
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 		if (act == XDP_REDIRECT || act == XDP_TX) {
@@ -1730,12 +1734,16 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 
 		pad = xdp.data - xdp.data_hard_start;
 		len = xdp.data_end - xdp.data;
+
+		metasize = xdp.data - xdp.data_meta;
+		metasize = metasize > 0 ? metasize : 0;
 	}
 	bpf_net_ctx_clear(bpf_net_ctx);
 	rcu_read_unlock();
 	local_bh_enable();
 
-	return __tun_build_skb(tfile, alloc_frag, buf, buflen, len, pad);
+	return __tun_build_skb(tfile, alloc_frag, buf, buflen, len, pad,
+			       metasize);
 
 out:
 	bpf_net_ctx_clear(bpf_net_ctx);
@@ -2452,6 +2460,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	struct sk_buff_head *queue;
 	u32 rxhash = 0, act;
 	int buflen = hdr->buflen;
+	int metasize = 0;
 	int ret = 0;
 	bool skb_xdp = false;
 	struct page *page;
@@ -2467,7 +2476,6 @@ static int tun_xdp_one(struct tun_struct *tun,
 		}
 
 		xdp_init_buff(xdp, buflen, &tfile->xdp_rxq);
-		xdp_set_data_meta_invalid(xdp);
 
 		act = bpf_prog_run_xdp(xdp_prog, xdp);
 		ret = tun_xdp_act(tun, xdp_prog, xdp, act);
@@ -2507,6 +2515,11 @@ static int tun_xdp_one(struct tun_struct *tun,
 	skb_reserve(skb, xdp->data - xdp->data_hard_start);
 	skb_put(skb, xdp->data_end - xdp->data);
 
+	metasize = xdp->data - xdp->data_meta;
+	metasize = metasize > 0 ? metasize : 0;
+	if (metasize)
+		skb_metadata_set(skb, metasize);
+
 	if (virtio_net_hdr_to_skb(skb, gso, tun_is_little_endian(tun))) {
 		atomic_long_inc(&tun->rx_frame_errors);
 		kfree_skb(skb);
-- 
2.48.1


