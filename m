Return-Path: <bpf+bounces-66392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEE5B3428D
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 16:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5953A2666
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1232F6593;
	Mon, 25 Aug 2025 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nL3PAIPU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B055221FB2;
	Mon, 25 Aug 2025 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130072; cv=none; b=XOpKOmHTEE53v16+0BY/37KFR5yOy6VvNvytVeLuuGsTm/c1KuZ+vB0lG95uZ9yjN0Hn0PQLE5+xz+CMMqVPHURbHIZSHip/GErzx+ThH4iUR687E1SIDye1wf/4fDlQKx2L9tZQNhUl4sZUxc9Pz1xV1LY+nWhgBrvnX7W8b/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130072; c=relaxed/simple;
	bh=Cxc6/V3rmgNSM2iW1HRv0PPpFa/aPYUSVxFlscFJ50o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=upKTDV+YpuUUqaXhY02mG5Kz5UIfoAWfJnVtdcdBiZneM5jjv4+2QRLnGs9HFa4ty+OFvBnxCRuiUD3kIXukhqnFrYjUbjlkh9hwZDleCFjoz1URKvrU2YIReFwSWU3pe3bM34xkRD1wN7pbMnj+QaDtTeDBzs4vZgrapkpXtIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nL3PAIPU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-771e1e64fbbso1184724b3a.3;
        Mon, 25 Aug 2025 06:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756130066; x=1756734866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QueZFZT6kB+eyh+Rbx3TPWmptpQjZqbpLcd6/FCzEp8=;
        b=nL3PAIPUPHzDy/66LEJmfPDchVOeA18nF/KmsnisZ/LsvnAOrRgPywu+GbUgrlFtRz
         y4RfJmZTgG1jTQEz53d2RVSafbHCdUI7qbG96gNyGyazj/V49I5+SsSPy84HfacWTovB
         QCogD77EFRrvrzW+j7jdXs4+IKtMeXVRovIaOjo/sZFeeLxbkxRrPMZKnGEjodaVbtSo
         b5wcmA2eJXiP4AKN9HUoAU0XR4cb30IR3STE8bpZVa7/lju3DMl8nBl61z2C2Yw8ZBi8
         BgEgOTj4YIP96xtRJEW9eSbNnIbWlVMk8H0R6zXrKK9KOSodNodqi1NOMWbOzLDchLd2
         9/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756130066; x=1756734866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QueZFZT6kB+eyh+Rbx3TPWmptpQjZqbpLcd6/FCzEp8=;
        b=PWxc4GxCsTlahWsUR2f9Kk4DUG+wYt6Nn9HPFQ5r+zjLXbd5qyNbVrt7dc5p5GZDuo
         5R6TvXtzS776OZ/A5VSq117IZAnka6nySZ/BNqoxPo1lmgG1xoDD26m60v/68kdgkRlq
         CypH7uyQc5z2WOHS0QablDgwP28d9dJs8eKGPBGOSkVQgR6Mmsq0ARtACht2SrxP5cDj
         RJOD+a5DF1khneTlCBwogjziBk9jrkgwV7KZl71g75nEv6hZ8w7Wa3Ze8ldQPnhGfPc1
         DC5kvqER6Lx0Y2NIccP3HSPBEQ+9BoOO1jcinsKRhaw+0TP0rtoh5tZk8d67yRXxfRQT
         On2g==
X-Forwarded-Encrypted: i=1; AJvYcCXvZ4VZN84RHoWfpEFBvRYtKXFMgDwP+xeE/uTosDAifEZtgmzOkfjbBttz+ynKxO5bGW6b3DI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwENy9tBEr6J83vJCFdbqP/ujBbYiZ5DkGx9HRFYrppnxrZCe4n
	ps73nVaoMfu0TX+uyf6fIsb9yQXC3MEh/ucf2t7ZXAiYHOOg3SZjTx+V
X-Gm-Gg: ASbGncsJlNQfx/EJRPVzZ1RFYPVwOTzl0b2bo9N6IJevZrNSOTPFGGDrvi4ViiUpmtE
	QbWLyOKvMspfJT/ZbMuq3LnT2sGMQ2s9jPvpM4wzSTwo0c+LH4lH3986lCJ5iDdw9ht8OLw2iTc
	IS9Emkv6DsUiKqZR2CMfYuhHc+jX3N2JkztydGIAyw8jm5rLe7PE4+YEgSBTBcGjP7h8LK+MkWG
	7l6t05UCY4hj47QW4UlrnNqmUDJFOjZXXNp+iMJz36Kyv0JTIPs8D5UjmocfTEpbPwTd3LRtF7k
	Pp91GXUXn+C7bKdsQyktTjIFME9NJXwsV4JziBqVn6+SWn0yxZkAbs80ZAuci+vl+PtT6nPhlvT
	TdhFxalZZxA5rC0Ew0MeIj6dTjw95O74yPPCyDT58jzj2vCSPPnLviBwefPg=
X-Google-Smtp-Source: AGHT+IEQFDNKXU9L2T8w8z+R/r9nDgXxyT22KaPVT/w8R7P7A/9zM3jhTdgJ/wnhidHEsAQUf4D5gQ==
X-Received: by 2002:a05:6300:218c:b0:23f:facd:5bc5 with SMTP id adf61e73a8af0-24340bca266mr17611750637.25.1756130066308;
        Mon, 25 Aug 2025 06:54:26 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.28.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4a8b7b301csm3374073a12.35.2025.08.25.06.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:54:25 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 4/9] xsk: extend xsk_build_skb() to support passing an already allocated skb
Date: Mon, 25 Aug 2025 21:53:37 +0800
Message-Id: <20250825135342.53110-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250825135342.53110-1-kerneljasonxing@gmail.com>
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Batch xmit mode needs to allocate and build skbs at one time. To avoid
reinvent the wheel, use xsk_build_skb() as the second half process of
the whole initialization of each skb.

The original xsk_build_skb() itself allocates a new skb by calling
sock_alloc_send_skb whether in copy mode or zerocopy mode. Add a new
parameter allocated skb to let other callers to pass an already
allocated skb to support later xmit batch feature. At that time,
another building skb function will generate a new skb and pass it to
xsk_build_skb() to finish the rest of building process, like
initializing structures and copying data.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  4 ++++
 net/xdp/xsk.c          | 23 ++++++++++++++++-------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index c2b05268b8ad..cbba880c27c3 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -123,6 +123,10 @@ struct xsk_tx_metadata_ops {
 	void	(*tmo_request_launch_time)(u64 launch_time, void *priv);
 };
 
+
+struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
+			      struct sk_buff *allocated_skb,
+			      struct xdp_desc *desc);
 #ifdef CONFIG_XDP_SOCKETS
 
 int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 173ad49379c3..213d6100e405 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -605,6 +605,7 @@ static void xsk_drop_skb(struct sk_buff *skb)
 }
 
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
+					      struct sk_buff *allocated_skb,
 					      struct xdp_desc *desc)
 {
 	struct xsk_buff_pool *pool = xs->pool;
@@ -618,7 +619,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	if (!skb) {
 		hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(xs->dev->needed_headroom));
 
-		skb = sock_alloc_send_skb(&xs->sk, hr, 1, &err);
+		if (!allocated_skb)
+			skb = sock_alloc_send_skb(&xs->sk, hr, 1, &err);
+		else
+			skb = allocated_skb;
 		if (unlikely(!skb))
 			return ERR_PTR(err);
 
@@ -657,8 +661,9 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	return skb;
 }
 
-static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
-				     struct xdp_desc *desc)
+struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
+			      struct sk_buff *allocated_skb,
+			      struct xdp_desc *desc)
 {
 	struct xsk_tx_metadata *meta = NULL;
 	struct net_device *dev = xs->dev;
@@ -667,7 +672,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	int err;
 
 	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
-		skb = xsk_build_skb_zerocopy(xs, desc);
+		skb = xsk_build_skb_zerocopy(xs, allocated_skb, desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 			goto free_err;
@@ -683,8 +688,12 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			first_frag = true;
 
 			hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
-			tr = dev->needed_tailroom;
-			skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
+			if (!allocated_skb) {
+				tr = dev->needed_tailroom;
+				skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
+			} else {
+				skb = allocated_skb;
+			}
 			if (unlikely(!skb))
 				goto free_err;
 
@@ -818,7 +827,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 			goto out;
 		}
 
-		skb = xsk_build_skb(xs, &desc);
+		skb = xsk_build_skb(xs, NULL, &desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 			if (err != -EOVERFLOW)
-- 
2.41.3


