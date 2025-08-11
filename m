Return-Path: <bpf+bounces-65336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD85FB209CF
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 15:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A7607B4280
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 13:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7632DCF67;
	Mon, 11 Aug 2025 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BN7tiQyH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D384205AB6;
	Mon, 11 Aug 2025 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917974; cv=none; b=WBelITTf/Q/9MgQXbXimn5BmG8ivneUkmR5i54VR/WTWEqIshq4ot64b/eRE7wyaGPiJYvz4stC7VaW7dxnHnyAJfECmltkEJ0HYDALwGevyfG9pJnSaSiRg01dSxh++pUZPoL7lyS7o4wd5owQ17+eWTG1gMwrvSGCF2WEFG30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917974; c=relaxed/simple;
	bh=ifq5GCzMaEVv18tS4ZnzWF4UAHEUrydc4Ns4DKy1CGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=je+yqU54nKA/EqoDaOcJnDXToCpVeVO+BvqULwA/i2GwvFEtdpraKewlulhqP+UXIRdc02o37ElEJzccRTFDtaDFJDcNsUHeO/400R1CBAm4LShNM7PrAddi268i74Var8QxSZ1uTsC/TFdWuPCZOp7ob7u9ktDeVlZpKTULeiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BN7tiQyH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76a3818eb9bso3810844b3a.3;
        Mon, 11 Aug 2025 06:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754917972; x=1755522772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kihdph5IunZ7Lgmwz9SpB+fAmKlHzMg9+nvbBJuWeps=;
        b=BN7tiQyHDEAX8noM8haebtwmYR1kUBqzKO9ZnQak7WKY/2/F8TP0FNM30IOjHmNRGk
         kn7K56aPzAVUyaeQ2Uf4Fd76dNMhzEHSt1msp4H3W87WZdpskk92fcs2AjGp0wyPvfnV
         kAfzj7UHkZk8krDxNOBgrutMF6+xrXOiVcwwNWKvUDoGyeoO9i/haPa9zx+NqgLBHjvf
         /7PjazqpS3tdSUSgjnBrlOf30tJ06iQ4Hpj+THcsF+E3Y4uCuczBMSHVjAr7/giDUi1+
         4/IReVLuckLaNfTP3Fl/68ah5rGQQ5/RkzN8wf/a58RxY+/Rik9y1QbjzB9fQubMPdls
         PWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754917972; x=1755522772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kihdph5IunZ7Lgmwz9SpB+fAmKlHzMg9+nvbBJuWeps=;
        b=N46Lgn2PCLntwmT0jqgS4RXxc8WLh5EvvAgYkJKRp6VmZJ+SCSVc7dpUG1O7QEcjYC
         xeIMgzC+NPv4PpsJbWcZb4sJDnRgUX0ruFk5nHPZfxLAEiXIMRzLzs5f1AzzEXP9lQ2D
         ZXTuzBcSKqHr7aKRoXYfYwAyyZ0sU1fHI32pwiMlY3tg9+U07ncen891iRrM+AE9gqgs
         kDgI8f94hckcYFCc2UPO6DQfSENVVs3FuIXVmuGcIFj/hqO2J49f7RmU9uJxnPS/V+em
         /CAk/9BwKfeLK738wuePtLuaO6CojiKtY1ZcYyAknej2mPhefyTWffL2g9wAAx1s4hOy
         mryQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzNpjiDiGW91VVvZ8Xt7OcdZ3dZBBBj+mWDg4/lo5UzYN8k97kUv8TFp7lsgb7O6oPWqxHo/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIdoar8qCVeuwJq6LAoysCoCPzBW67ibLyv4sTOuNm+4PCCx1o
	+TGsZcrbcjzRMauJFGTAe1NBGaDmWlafCGYRen20uFgEpa07SUsfL/Dt
X-Gm-Gg: ASbGncvN0qzmp3S1pdVejCiVhwZh5J3dHrfAw6aavEH7FXjXQ0nd6zHaF21wDNCwlgb
	7sDLdGjzIICfeZCsLh0eugj1qvhjB/2/dIDY8xhhjsSyzDn1kVR0oc9/T40y6sdnnDV8d0XslXo
	elFadAzDu5RrhNUMcQz3yGKT1LyLwQDzqqxnC9HNGV7mhr3sUDhq67tboEdzI4e+1hQuK1d6eXT
	+M8S/UL5QHYdwMpz4zypOweaeKgA2YmVdYAZ2wmMN6PL72v7umU7ERkKifnxyDlCIco1r/6mmaV
	/ca7uo6VknzEi7pE8DWgvqB6d/iRgazJqJODHcPdthG6mam9CGarbL1eMDjQn0nptT9/OO60b5f
	QBMilSFPKQeDOnnAgMNQZGGC8+hkdWeGKwI3R4MAM7PVwQ7ru04SYU666CfQ=
X-Google-Smtp-Source: AGHT+IEm05i6Rn8Yfxc/MgoLtCW4CJ8wy2x2sT521QYEv97EIl3/VhX5n0EFxCsDHhnOpoQuHi5PiA==
X-Received: by 2002:a05:6a00:cc5:b0:74c:efae:fd8f with SMTP id d2e1a72fcca58-76c4611ccf0mr17183342b3a.15.1754917972480;
        Mon, 11 Aug 2025 06:12:52 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.28.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c46a05464sm8227069b3a.96.2025.08.11.06.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:12:52 -0700 (PDT)
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
Subject: [PATCH net-next 2/2] xsk: support generic batch xmit in copy mode
Date: Mon, 11 Aug 2025 21:12:36 +0800
Message-Id: <20250811131236.56206-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250811131236.56206-1-kerneljasonxing@gmail.com>
References: <20250811131236.56206-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Zerocopy mode has a good feature named multi buffer while copy mode has
to transmit skb one by one like normal flows. The latter might lose the
bypass power to some extent because of grabbing/releasing the same tx
queue lock and disabling/enabling bh and stuff on a packet basis.
Contending the same queue lock will bring a worse result.

This patch supports batch feature by permitting owning the queue lock to
send the generic_xmit_batch number of packets at one time. To further
achieve a better result, some codes[1] are removed on purpose from
xsk_direct_xmit_batch() as referred to __dev_direct_xmit().

[1]
1. advance the device check to granularity of sendto syscall.
2. remove validating packets because of its uselessness.
3. remove operation of softnet_data.xmit.recursion because it's not
   necessary.
4. remove BQL flow control. We don't need to do BQL control because it
   probably limit the speed. An ideal scenario is to use a standalone and
   clean tx queue to send packets only for xsk. Less competition shows
   better performance results.

Experiments:
1) Tested on virtio_net:
With this patch series applied, the performance number of xdpsock[2] goes
up by 33%. Before, it was 767743 pps; while after it was 1021486 pps.
If we test with another thread competing the same queue, a 28% increase
(from 405466 pps to 521076 pps) can be observed.
2) Tested on ixgbe:
The results of zerocopy and copy mode are respectively 1303277 pps and
1187347 pps. After this socket option took effect, copy mode reaches
1472367 which was higher than zerocopy mode impressively.

[2]: ./xdpsock -i eth1 -t  -S -s 64

It's worth mentioning batch process might bring high latency in certain
cases. The recommended value is 32.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/linux/netdevice.h |   2 +
 net/core/dev.c            |  18 +++++++
 net/xdp/xsk.c             | 103 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5e5de4b0a433..27738894daa7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3352,6 +3352,8 @@ u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
 
 int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev);
 int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
+int xsk_direct_xmit_batch(struct sk_buff **skb, struct net_device *dev,
+			  struct netdev_queue *txq, u32 max_batch, u32 *cur);
 
 static inline int dev_queue_xmit(struct sk_buff *skb)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index 68dc47d7e700..7a512bd38806 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4742,6 +4742,24 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 }
 EXPORT_SYMBOL(__dev_queue_xmit);
 
+int xsk_direct_xmit_batch(struct sk_buff **skb, struct net_device *dev,
+			  struct netdev_queue *txq, u32 max_batch, u32 *cur)
+{
+	int ret = NETDEV_TX_BUSY;
+
+	local_bh_disable();
+	HARD_TX_LOCK(dev, txq, smp_processor_id());
+	for (; *cur < max_batch; (*cur)++) {
+		ret = netdev_start_xmit(skb[*cur], dev, txq, false);
+		if (ret != NETDEV_TX_OK)
+			break;
+	}
+	HARD_TX_UNLOCK(dev, txq);
+	local_bh_enable();
+
+	return ret;
+}
+
 int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 {
 	struct net_device *dev = skb->dev;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7a149f4ac273..92ad82472776 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -780,9 +780,102 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return ERR_PTR(err);
 }
 
-static int __xsk_generic_xmit(struct sock *sk)
+static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
+{
+	u32 max_batch = READ_ONCE(xs->generic_xmit_batch);
+	struct sk_buff **skb = xs->skb_batch;
+	struct net_device *dev = xs->dev;
+	struct netdev_queue *txq;
+	bool sent_frame = false;
+	struct xdp_desc desc;
+	u32 i = 0, j = 0;
+	u32 max_budget;
+	int err = 0;
+
+	mutex_lock(&xs->mutex);
+
+	/* Since we dropped the RCU read lock, the socket state might have changed. */
+	if (unlikely(!xsk_is_bound(xs))) {
+		err = -ENXIO;
+		goto out;
+	}
+
+	if (xs->queue_id >= dev->real_num_tx_queues)
+		goto out;
+
+	if (unlikely(!netif_running(dev) ||
+		     !netif_carrier_ok(dev)))
+		goto out;
+
+	max_budget = READ_ONCE(xs->max_tx_budget);
+	txq = netdev_get_tx_queue(dev, xs->queue_id);
+	do {
+		for (; i < max_batch && xskq_cons_peek_desc(xs->tx, &desc, xs->pool); i++) {
+			if (max_budget-- == 0) {
+				err = -EAGAIN;
+				break;
+			}
+			/* This is the backpressure mechanism for the Tx path.
+			 * Reserve space in the completion queue and only proceed
+			 * if there is space in it. This avoids having to implement
+			 * any buffering in the Tx path.
+			 */
+			err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
+			if (err) {
+				err = -EAGAIN;
+				break;
+			}
+
+			skb[i] = xsk_build_skb(xs, &desc);
+			if (IS_ERR(skb[i])) {
+				err = PTR_ERR(skb[i]);
+				break;
+			}
+
+			xskq_cons_release(xs->tx);
+
+			if (xp_mb_desc(&desc))
+				xs->skb = skb[i];
+		}
+
+		if (i) {
+			err = xsk_direct_xmit_batch(skb, dev, txq, i, &j);
+			if  (err == NETDEV_TX_BUSY) {
+				err = -EAGAIN;
+			} else if (err == NET_XMIT_DROP) {
+				j++;
+				err = -EBUSY;
+			}
+
+			sent_frame = true;
+			xs->skb = NULL;
+		}
+
+		if (err)
+			goto out;
+		i = j = 0;
+	} while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool));
+
+	if (xskq_has_descs(xs->tx)) {
+		if (xs->skb)
+			xsk_drop_skb(xs->skb);
+		xskq_cons_release(xs->tx);
+	}
+
+out:
+	for (; j < i; j++) {
+		xskq_cons_cancel_n(xs->tx, xsk_get_num_desc(skb[j]));
+		xsk_consume_skb(skb[j]);
+	}
+	if (sent_frame)
+		__xsk_tx_release(xs);
+
+	mutex_unlock(&xs->mutex);
+	return err;
+}
+
+static int __xsk_generic_xmit(struct xdp_sock *xs)
 {
-	struct xdp_sock *xs = xdp_sk(sk);
 	bool sent_frame = false;
 	struct xdp_desc desc;
 	struct sk_buff *skb;
@@ -871,11 +964,15 @@ static int __xsk_generic_xmit(struct sock *sk)
 
 static int xsk_generic_xmit(struct sock *sk)
 {
+	struct xdp_sock *xs = xdp_sk(sk);
 	int ret;
 
 	/* Drop the RCU lock since the SKB path might sleep. */
 	rcu_read_unlock();
-	ret = __xsk_generic_xmit(sk);
+	if (READ_ONCE(xs->generic_xmit_batch))
+		ret = __xsk_generic_xmit_batch(xs);
+	else
+		ret = __xsk_generic_xmit(xs);
 	/* Reaquire RCU lock before going into common code. */
 	rcu_read_lock();
 
-- 
2.41.3


