Return-Path: <bpf+bounces-54897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD985A75A11
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 14:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CC43A8AC4
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 12:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E448A1D54E9;
	Sun, 30 Mar 2025 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="SZOFCeTq"
X-Original-To: bpf@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B26158A13;
	Sun, 30 Mar 2025 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743337451; cv=pass; b=dlrl2WxYj233x/1tCyfjBjCqK9wysg+I072enzD0xFn6vipWN3rdKWJY1gsajgdVjwZ07d+PmDyHuVA/K6M3s2XgjzPCGcsiVlu/OSGzxVoXuNPa9FUQftq+hljtWe5efkJQZthlTJcMJnvnP5R0jyhIKdWztC5pp0f4CYe5PnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743337451; c=relaxed/simple;
	bh=oVeFAI7piMnHF4YnHOy1gBLcP24XFytf+ah6CTXpPow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uo+4k7VJaBqp4CfQhJQO9MHIao7RW8uGaneX/1ijJkAhYOacO1n3nRUaZQzwKzWxceLHVRhnVbKVKJ74P0LvlImGaD0DH+IoKHzWjVETNec9wepVgRMPoEoYp5V2B1zYdCk0zwEHO/yZfv3IXh+FqaeqThhwsl/2XK8NcItlF7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=SZOFCeTq; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZQYN306Gxz49QBV;
	Sun, 30 Mar 2025 15:24:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1743337445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHgOmlyF/u0xf4oOA2xxDbXezfoxwB3V0WUM3ag/w6o=;
	b=SZOFCeTqaD9WbHsIlahmE9wx7V1Dy63Zp/DLSfH3wsAibJgvTLKn9B1/p/0n2h4jKCN+vr
	zxUP3ddM29BhWmw5r/0WyJRZiZQKH0N2rA+ZSAQqv2j5QTz5guJblNfsE+3HL3rvauKHeE
	0in5Zbfb+NcR5moz+MTpOk8YljWDyjoFr1TIAo2JqqLj3I4JmUxW2r23TyoOjQvGio1RV7
	RBvdj2xrlZx4kLcwEgy4nM7NwG54XOWXGhvD7vaIMOscY5rqk1Wsj21s41pPDXLC66rUuh
	PhyRZclE7UCGra32aGTNvk+wHmDc4WLR3w8Mh6N0s0D2qmRCCSZOfRAzG5mnTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1743337445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHgOmlyF/u0xf4oOA2xxDbXezfoxwB3V0WUM3ag/w6o=;
	b=aDxyEPs7AL/tSGS+d8CjNUBrTb9IMtOCzxOkzM0nd0QEMc3sYh1g/YypQo/USPJAaOsA/A
	ux63oUQDM03S60Kqxhy00MbRCWWMTEyrTIuD2hUeRndnexiJjPDxKQKbeHqQ1kvNuX4XsT
	DAWXmj5JYpLby1rnHmS1PyLqQqt11npw3X8lKYGB2GG7JeNCK2cp8vJJqgdWYeeqdCw0c2
	4S+wRfCIiGfe/FaQuiRMB5bb0SsVDlOqq7gSUDWEWMRhhg7PQZNZ2ZmHdRIoPLyIyMsF8r
	Si+iJlvdNYHZBDfve0fQXXs2cIqskE09HT1tJhwD5r9pY9wgXkh9Tcv9IsUaiQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1743337445; a=rsa-sha256;
	cv=none;
	b=imgpFEQt4GqDcpuQanSOzOr76SDpkn+k7zyDUFwjLvPnMqBQfSpjfTErCyBiPRnmA7QRKy
	M8kbxq9qv8ZEwEgKSXn+Y9OIFQ9NPdsShUBS1/fFPicApNvD5iAa4UVB61OHA5uE/raXq9
	gnztNkfLPTOHUIGDNKQ3B+illNZMLrziGege2B0rkhe2mogjies2MlGxgTqhLhAio8JvRP
	uCPXwfBoB32pUsi3BJ6qdB6BSrypT1WfjbQ2McgMsQ0zGa7oEahCG5AYwjWLOwP7jUaV3o
	a0DQe7+JvofQ4TWsM0dZuubih/d5ZlC8W8lSLM1uiYX1OD1RMQSIZ93KXuf1KA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	kerneljasonxing@gmail.com
Subject: [PATCH 3/3] [RFC] Bluetooth: enable bpf TX timestamping
Date: Sun, 30 Mar 2025 15:23:38 +0300
Message-ID: <bbd7fa454ed03ebba9bfe79590fb78a75d4f07db.1743337403.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743337403.git.pav@iki.fi>
References: <cover.1743337403.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emit timestamps also for BPF timestamping.

***

The tskey management here is not quite right: see cover letter.
---
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/hci_conn.c          | 21 +++++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index bbefde319f95..3b2e59cedd2d 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -383,6 +383,7 @@ struct bt_sock {
 	struct list_head accept_q;
 	struct sock *parent;
 	unsigned long flags;
+	atomic_t bpf_tskey;
 	void (*skb_msg_name)(struct sk_buff *, void *, int *);
 	void (*skb_put_cmsg)(struct sk_buff *, struct msghdr *, struct sock *);
 };
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 95972fd4c784..7430df1c5822 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -28,6 +28,7 @@
 #include <linux/export.h>
 #include <linux/debugfs.h>
 #include <linux/errqueue.h>
+#include <linux/bpf-cgroup.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -3072,6 +3073,7 @@ void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
 			    const struct sockcm_cookie *sockc)
 {
 	struct sock *sk = skb ? skb->sk : NULL;
+	bool have_tskey = false;
 
 	/* This shall be called on a single skb of those generated by user
 	 * sendmsg(), and only when the sendmsg() does not return error to
@@ -3096,6 +3098,20 @@ void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
 
 			skb_shinfo(skb)->tskey = key - 1;
 		}
+		have_tskey = true;
+	}
+
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING)) {
+		struct bt_sock *bt_sk = container_of(sk, struct bt_sock, sk);
+		int key = atomic_inc_return(&bt_sk->bpf_tskey);
+
+		if (!have_tskey)
+			skb_shinfo(skb)->tskey = key - 1;
+
+		bpf_skops_tx_timestamping(sk, skb,
+					  BPF_SOCK_OPS_TSTAMP_SENDMSG_CB);
+
 	}
 }
 
@@ -3105,7 +3121,7 @@ void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb)
 	bool track = false;
 
 	/* Emit SND now, ie. just before sending to driver */
-	if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
+	if (skb_shinfo(skb)->tx_flags & (SKBTX_SW_TSTAMP | SKBTX_BPF))
 		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SND);
 
 	/* COMPLETION tstamp is emitted for tracked skb later in Number of
@@ -3127,7 +3143,8 @@ void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb)
 		return;
 	}
 
-	if (skb->sk && (skb_shinfo(skb)->tx_flags & SKBTX_COMPLETION_TSTAMP))
+	if (skb->sk && (skb_shinfo(skb)->tx_flags &
+			(SKBTX_COMPLETION_TSTAMP | SKBTX_BPF)))
 		track = true;
 
 	/* If nothing is tracked, just count extra skbs at the queue head */
-- 
2.49.0


