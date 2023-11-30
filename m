Return-Path: <bpf+bounces-16242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 393437FEB90
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 10:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7FA2822F5
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 09:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAC2374E4;
	Thu, 30 Nov 2023 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Va+m6oJn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA7C2F86F;
	Thu, 30 Nov 2023 09:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C763C433C9;
	Thu, 30 Nov 2023 09:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701335527;
	bh=Fzf/yexj2sPu+FiKzEa1Jm51iH7MRWM534hM/erAGl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Va+m6oJn+t7tIZMK31q4udkysMnr8KopYHyhYQc47nZMLrE5AiKN5WoLYaG+jET4t
	 s+IwouKWLsZNYSIog0RyTY5/sYKaeZ59MJT2Ujg7UUoyRJg/FWMNnHnfoelv+CLpbB
	 YugzSF5Vej72/thobXT0snGXh/tmxe8isNDbhpZvnDm6iDZ50TC+muLkYae/FI6URG
	 gRxM5QiPfMIo7uHo3a70SvyJO8AQpuH7chR5hiVhFdXZq+Gtt3Y9gF0oIR/KvM/iZw
	 gpHbGCl9iqT/bk9d0flaydR/K9yGkOFdLYCfDpnc+I0bSS0LNiZcu9mBJfAPCl+SfK
	 8Pdv9JP6r02Vw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lorenzo.bianconi@redhat.com,
	bpf@vger.kernel.org,
	hawk@kernel.org,
	toke@redhat.com,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com
Subject: [PATCH v2 net-next 1/2] xdp: rely on skb pointer reference in do_xdp_generic and netif_receive_generic_xdp
Date: Thu, 30 Nov 2023 10:11:48 +0100
Message-ID: <4c96068d965baf3ec40fdc0e98102c1077dbeb07.1701334869.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701334869.git.lorenzo@kernel.org>
References: <cover.1701334869.git.lorenzo@kernel.org>
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
index 998c7aaa98b8..c3fafe0ead44 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3925,7 +3925,7 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 			     struct bpf_prog *xdp_prog);
 void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog);
-int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb);
+int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb);
 int netif_rx(struct sk_buff *skb);
 int __netif_rx(struct sk_buff *skb);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 3950ced396b5..4df68d7f04a2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4915,10 +4915,11 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
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
@@ -4999,24 +5000,24 @@ void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog)
 
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
@@ -5024,7 +5025,7 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb)
 	}
 	return XDP_PASS;
 out_redir:
-	kfree_skb_reason(skb, SKB_DROP_REASON_XDP);
+	kfree_skb_reason(*pskb, SKB_DROP_REASON_XDP);
 	return XDP_DROP;
 }
 EXPORT_SYMBOL_GPL(do_xdp_generic);
@@ -5347,7 +5348,8 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 		int ret2;
 
 		migrate_disable();
-		ret2 = do_xdp_generic(rcu_dereference(skb->dev->xdp_prog), skb);
+		ret2 = do_xdp_generic(rcu_dereference(skb->dev->xdp_prog),
+				      &skb);
 		migrate_enable();
 
 		if (ret2 != XDP_PASS) {
-- 
2.43.0


