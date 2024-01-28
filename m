Return-Path: <bpf+bounces-20520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D035983F5D1
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 15:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0201C2275B
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 14:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7C3241E7;
	Sun, 28 Jan 2024 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDxF+UOI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B37288DD;
	Sun, 28 Jan 2024 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706451733; cv=none; b=qnNveL+zqSzKYhq4kIUjMtjyvvPYOEpGtclVYOuuFG4xRDZtcCxkSdNgbUEA225Nf9VyffdB+yExAlW6C7K2x5pA9whb3VCcNAGGcws0Xi97JDxIJQ5iyunws1YSD36Du5NxbtOkBELPHgQSh3pZJcBM2XiocdBlbo8O/zYg7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706451733; c=relaxed/simple;
	bh=1OOLH7js8NjWz3tp7HldxyWc6SbFLgrAhGUX0VKyIR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5+Lu/9tpcN3EzNawlT6kZuYctre0nXsq/SFI7Pg+gyEh1UzLpmCOyC2WG5kqJP9JdcL3FBdMqQKnCKfSc9VmY4QKmzlzJTuVwJPzTIO2NU8QgGdJG/d6EhpNP6QS6nns4e8fds7TqXgJ9ZyevYixQRwh0lDCxVRkAFWFWylpb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDxF+UOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D8CC433F1;
	Sun, 28 Jan 2024 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706451732;
	bh=1OOLH7js8NjWz3tp7HldxyWc6SbFLgrAhGUX0VKyIR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IDxF+UOIdot/9RrXtq7eDDZAkdeGXztpVGZEhG6PrNJM/8LCr92A+PSy/7xeH08qR
	 dVrc0A3mO0vcP3rdxwiQWMv1IGkP5YbWqxyP/8B30GxfQqJJqaX1FCaALIQDpEs7ty
	 9bhoI5dNzbTYaWFD09FIQCMWdQ1TICz/l8YJOzEgNMKJqTU1JdgnNQs3eBbs6mXZzx
	 uGpm9UqxEp6QOXRT0qOvzEYcKAz8hqrG4WsvvhD16Uii6Ot5SRn2M/nOvdtTq88ufs
	 Tfr83uDb6UybMVsns4Bib8hK3i4oENtpCFPpSmHg2PMjeZbE35Eb5hn1lXhK6BcbEY
	 nwLqrOfD+f7dA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	toke@redhat.com,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	sdf@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org
Subject: [PATCH v6 net-next 2/5] xdp: rely on skb pointer reference in do_xdp_generic and netif_receive_generic_xdp
Date: Sun, 28 Jan 2024 15:20:38 +0100
Message-ID: <7fd76e88e2aadc03f14b040ffc762e88d05afc8c.1706451150.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706451150.git.lorenzo@kernel.org>
References: <cover.1706451150.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rely on skb pointer reference instead of the skb pointer in do_xdp_generic and
netif_receive_generic_xdp routine signatures. This is a preliminary patch to add
multi-buff support for xdp running in generic mode.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/tun.c         |  4 ++--
 include/linux/netdevice.h |  2 +-
 net/core/dev.c            | 16 +++++++++-------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 4a4f8c8e79fa..5bd98bdaddf2 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1927,7 +1927,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		rcu_read_lock();
 		xdp_prog = rcu_dereference(tun->xdp_prog);
 		if (xdp_prog) {
-			ret = do_xdp_generic(xdp_prog, skb);
+			ret = do_xdp_generic(xdp_prog, &skb);
 			if (ret != XDP_PASS) {
 				rcu_read_unlock();
 				local_bh_enable();
@@ -2517,7 +2517,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	skb_record_rx_queue(skb, tfile->queue_index);
 
 	if (skb_xdp) {
-		ret = do_xdp_generic(xdp_prog, skb);
+		ret = do_xdp_generic(xdp_prog, &skb);
 		if (ret != XDP_PASS) {
 			ret = 0;
 			goto out;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 118c40258d07..7eee99a58200 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3958,7 +3958,7 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 			     struct bpf_prog *xdp_prog);
 void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog);
-int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb);
+int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb);
 int netif_rx(struct sk_buff *skb);
 int __netif_rx(struct sk_buff *skb);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index bf9ec740b09a..960f39ac5e33 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4924,10 +4924,11 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	return act;
 }
 
-static u32 netif_receive_generic_xdp(struct sk_buff *skb,
+static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
 				     struct xdp_buff *xdp,
 				     struct bpf_prog *xdp_prog)
 {
+	struct sk_buff *skb = *pskb;
 	u32 act = XDP_DROP;
 
 	/* Reinjected packets coming from act_mirred or similar should
@@ -5008,24 +5009,24 @@ void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog)
 
 static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
 
-int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb)
+int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
 {
 	if (xdp_prog) {
 		struct xdp_buff xdp;
 		u32 act;
 		int err;
 
-		act = netif_receive_generic_xdp(skb, &xdp, xdp_prog);
+		act = netif_receive_generic_xdp(pskb, &xdp, xdp_prog);
 		if (act != XDP_PASS) {
 			switch (act) {
 			case XDP_REDIRECT:
-				err = xdp_do_generic_redirect(skb->dev, skb,
+				err = xdp_do_generic_redirect((*pskb)->dev, *pskb,
 							      &xdp, xdp_prog);
 				if (err)
 					goto out_redir;
 				break;
 			case XDP_TX:
-				generic_xdp_tx(skb, xdp_prog);
+				generic_xdp_tx(*pskb, xdp_prog);
 				break;
 			}
 			return XDP_DROP;
@@ -5033,7 +5034,7 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb)
 	}
 	return XDP_PASS;
 out_redir:
-	kfree_skb_reason(skb, SKB_DROP_REASON_XDP);
+	kfree_skb_reason(*pskb, SKB_DROP_REASON_XDP);
 	return XDP_DROP;
 }
 EXPORT_SYMBOL_GPL(do_xdp_generic);
@@ -5356,7 +5357,8 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 		int ret2;
 
 		migrate_disable();
-		ret2 = do_xdp_generic(rcu_dereference(skb->dev->xdp_prog), skb);
+		ret2 = do_xdp_generic(rcu_dereference(skb->dev->xdp_prog),
+				      &skb);
 		migrate_enable();
 
 		if (ret2 != XDP_PASS) {
-- 
2.43.0


