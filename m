Return-Path: <bpf+bounces-17502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B7A80E89F
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 11:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363691C20B65
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 10:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901BE5953E;
	Tue, 12 Dec 2023 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkWhTWDN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CD359175;
	Tue, 12 Dec 2023 10:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E690C433C8;
	Tue, 12 Dec 2023 10:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702375607;
	bh=8yxBH7ElWulx1XK0GqVtyWXdcZv5SLr+N/vmutjrKSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QkWhTWDNiibfqodIP0PZea6lClMztGIO6Rt4k8Ayw9z/EqgS2d4XlV/gsgidtSo2d
	 zbUv6vYGU+HHCscAqW5s6ZvxZrOP5r25hfjfVvsbVb8SvXY1FJPfXOof5v4v1vEkly
	 q/9LY1IcVyXMhycAKwViyCDUG4pFS0iJGB7oKvBLFLCoduQIt/FgSH91DnDjb26XQw
	 qA/x9C5DaNq00FFz41JGUczakgVYd2NHv4Zgcl5x7h7+TT/tDpfqdihw56qMavAMQe
	 DA/7n59OVK+5xUkfY0xdNw2sbXEWVWInF7YpVANvC29Wo5Q1dTDOuYv7GW+okeeydO
	 boL2Uz5k2ZZ4Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	hawk@kernel.org,
	toke@redhat.com,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	sdf@google.com
Subject: [PATCH v4 net-next 2/3] xdp: rely on skb pointer reference in do_xdp_generic and netif_receive_generic_xdp
Date: Tue, 12 Dec 2023 11:06:14 +0100
Message-ID: <6541222bbc1ee4a7d2da09a95effde99cef04c17.1702375338.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702375338.git.lorenzo@kernel.org>
References: <cover.1702375338.git.lorenzo@kernel.org>
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
index afa5497f7c35..206adddff699 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1921,7 +1921,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		rcu_read_lock();
 		xdp_prog = rcu_dereference(tun->xdp_prog);
 		if (xdp_prog) {
-			ret = do_xdp_generic(xdp_prog, skb);
+			ret = do_xdp_generic(xdp_prog, &skb);
 			if (ret != XDP_PASS) {
 				rcu_read_unlock();
 				local_bh_enable();
@@ -2511,7 +2511,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	skb_record_rx_queue(skb, tfile->queue_index);
 
 	if (skb_xdp) {
-		ret = do_xdp_generic(xdp_prog, skb);
+		ret = do_xdp_generic(xdp_prog, &skb);
 		if (ret != XDP_PASS) {
 			ret = 0;
 			goto out;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 30b6a3f601fe..d850ead7f9cd 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3953,7 +3953,7 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 			     struct bpf_prog *xdp_prog);
 void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog);
-int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb);
+int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb);
 int netif_rx(struct sk_buff *skb);
 int __netif_rx(struct sk_buff *skb);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 4c3d82fcf5b5..14554698b1fa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4916,10 +4916,11 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
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
@@ -5000,24 +5001,24 @@ void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog)
 
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
@@ -5025,7 +5026,7 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb)
 	}
 	return XDP_PASS;
 out_redir:
-	kfree_skb_reason(skb, SKB_DROP_REASON_XDP);
+	kfree_skb_reason(*pskb, SKB_DROP_REASON_XDP);
 	return XDP_DROP;
 }
 EXPORT_SYMBOL_GPL(do_xdp_generic);
@@ -5348,7 +5349,8 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 		int ret2;
 
 		migrate_disable();
-		ret2 = do_xdp_generic(rcu_dereference(skb->dev->xdp_prog), skb);
+		ret2 = do_xdp_generic(rcu_dereference(skb->dev->xdp_prog),
+				      &skb);
 		migrate_enable();
 
 		if (ret2 != XDP_PASS) {
-- 
2.43.0


