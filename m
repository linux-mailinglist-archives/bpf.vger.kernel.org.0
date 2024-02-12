Return-Path: <bpf+bounces-21727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3905E851009
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 10:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDBB1B2396D
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 09:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5F417C6E;
	Mon, 12 Feb 2024 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKXms/93"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4BE848D;
	Mon, 12 Feb 2024 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731511; cv=none; b=utU3qafF6aVQHDew2MVjq6SDnl6J+AyXfdPweSC82OGLmiW+MRpqBMrjw17ErDZkrlTya1NR0UqLm2b/fEjLHyHoCEJT5zrxgIP56dCyyZxHaGyaCibxaS/0MNV6xUKHFlEV4jBSU9HbrIgj1Ut72SxaTdW45m+9yMbnGNqoYXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731511; c=relaxed/simple;
	bh=KOkRHpWIxeEyHwTg9diZ+2iktqnzXiKsioIJQI5Py7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYC6mgkXE1qCZYd9SGB7HYaM7AxJQVuGJEINlCw0Up3kpaxJtn/GzfQzC4pQ6gf3vQDsLz/7NsbaJbpvhjqXyRpeT9W4gXjTHmiW2hiFde+JCqOIj1Uw4FZyFMnCPiP2/Pnpq+94CMeGvsdGDch6Eoy7HwH1OaawhwHps/XL2Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKXms/93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF35C433C7;
	Mon, 12 Feb 2024 09:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707731510;
	bh=KOkRHpWIxeEyHwTg9diZ+2iktqnzXiKsioIJQI5Py7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pKXms/93WTSAD7hbCxUw8RrFwfcgGMV03IGUW6JxRtbrHLRnUCYfWXG/+WeglhZR5
	 o56pP6Od+z2uHQ3fFMwm/nGs4ShDoiHnTt+apH0Z/bgIFXY31x66WL3lfmYJngEeAB
	 Q0sdmq0cILZzPD3ng7roLf8dG7QrymqKZP8MQCZS5SYThb66IVFHrRNxkjtcBBfdtP
	 yovyijeE73HuPGqQKWES2kKhDQlznqDZOJRdpwIg+5dy7dGQpZH4QbKhDbQxbwKE/7
	 RqvpFoQLB7IGPncW5lotdlMn6ZDokwYzYWgb/5IG9ExVavMrgYeKvBwVzxctwilDo8
	 zIwdUKI8mf3WQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	toke@redhat.com,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	sdf@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com
Subject: [PATCH v9 net-next 2/4] xdp: rely on skb pointer reference in do_xdp_generic and netif_receive_generic_xdp
Date: Mon, 12 Feb 2024 10:50:55 +0100
Message-ID: <c09415b1f48c8620ef4d76deed35050a7bddf7c2.1707729884.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707729884.git.lorenzo@kernel.org>
References: <cover.1707729884.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rely on skb pointer reference instead of the skb pointer in do_xdp_generic
and netif_receive_generic_xdp routine signatures.
This is a preliminary patch to add multi-buff support for xdp running in
generic mode where we will need to reallocate the skb to avoid
linearization and we will need to make it visible to do_xdp_generic()
caller.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Reviewed-by: Toke Hoiland-Jorgensen <toke@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/tun.c         |  4 ++--
 include/linux/netdevice.h |  2 +-
 net/core/dev.c            | 16 +++++++++-------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index b472f2c972d8..bc80fc1d576e 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1926,7 +1926,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		rcu_read_lock();
 		xdp_prog = rcu_dereference(tun->xdp_prog);
 		if (xdp_prog) {
-			ret = do_xdp_generic(xdp_prog, skb);
+			ret = do_xdp_generic(xdp_prog, &skb);
 			if (ret != XDP_PASS) {
 				rcu_read_unlock();
 				local_bh_enable();
@@ -2516,7 +2516,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 	skb_record_rx_queue(skb, tfile->queue_index);
 
 	if (skb_xdp) {
-		ret = do_xdp_generic(xdp_prog, skb);
+		ret = do_xdp_generic(xdp_prog, &skb);
 		if (ret != XDP_PASS) {
 			ret = 0;
 			goto out;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 07cefa32eafa..a3f9c95da51e 100644
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
index e403cb44b26b..1482c3058fc2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4936,10 +4936,11 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
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
@@ -5020,24 +5021,24 @@ void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog)
 
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
@@ -5045,7 +5046,7 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb)
 	}
 	return XDP_PASS;
 out_redir:
-	kfree_skb_reason(skb, SKB_DROP_REASON_XDP);
+	kfree_skb_reason(*pskb, SKB_DROP_REASON_XDP);
 	return XDP_DROP;
 }
 EXPORT_SYMBOL_GPL(do_xdp_generic);
@@ -5368,7 +5369,8 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 		int ret2;
 
 		migrate_disable();
-		ret2 = do_xdp_generic(rcu_dereference(skb->dev->xdp_prog), skb);
+		ret2 = do_xdp_generic(rcu_dereference(skb->dev->xdp_prog),
+				      &skb);
 		migrate_enable();
 
 		if (ret2 != XDP_PASS) {
-- 
2.43.0


