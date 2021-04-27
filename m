Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A494E36BDFE
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 05:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhD0DvT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Apr 2021 23:51:19 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:17917 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhD0DvS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Apr 2021 23:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1619495437; x=1651031437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V8UGnFpf8bTuF7lpZY4qc80ssPB3dSUpmiMIja9fnOs=;
  b=ayMr+wWlINu6uJ7PjfcfvuYdrO1Bkgi/Fzmb2ciut6WWSwCZ0xaGw4J9
   LwikIIEaXVaO/9LZqIoN6wY+/Jk/Hkk/7OvUhTXKmAqWUMuEwMZ4NwS8i
   aXmhvxgmbw6SYowK0FcNSOIoy/9n7JGoyHFrYPDw1JeHDLQ4v7oJl2rWf
   g=;
X-IronPort-AV: E=Sophos;i="5.82,254,1613433600"; 
   d="scan'208";a="104127304"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-4101.iad4.amazon.com with ESMTP; 27 Apr 2021 03:48:34 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id 0A385A1CC5;
        Tue, 27 Apr 2021 03:48:32 +0000 (UTC)
Received: from EX13D04ANC001.ant.amazon.com (10.43.157.89) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 27 Apr 2021 03:48:32 +0000
Received: from 88665a182662.ant.amazon.com (10.43.162.93) by
 EX13D04ANC001.ant.amazon.com (10.43.157.89) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 27 Apr 2021 03:48:27 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.co.jp>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
CC:     Benjamin Herrenschmidt <benh@amazon.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Kuniyuki Iwashima <kuni1840@gmail.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 bpf-next 06/11] tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.
Date:   Tue, 27 Apr 2021 12:46:18 +0900
Message-ID: <20210427034623.46528-7-kuniyu@amazon.co.jp>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210427034623.46528-1-kuniyu@amazon.co.jp>
References: <20210427034623.46528-1-kuniyu@amazon.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.93]
X-ClientProxiedBy: EX13D18UWC002.ant.amazon.com (10.43.162.88) To
 EX13D04ANC001.ant.amazon.com (10.43.157.89)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As with the preceding patch, this patch changes reqsk_timer_handler() to
call reuseport_migrate_sock() and reqsk_clone() to migrate in-flight
requests at retransmitting SYN+ACKs. If we can select a new listener and
clone the request, we resume setting the SYN+ACK timer for the new req. If
we can set the timer, we call inet_ehash_insert() to unhash the old req and
put the new req into ehash.

The noteworthy point here is that by unhashing the old req, another CPU
processing it may lose the "own_req" race in tcp_v[46]_syn_recv_sock() and
drop the final ACK packet. However, the new timer will recover this
situation.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
---
 net/core/request_sock.c         |  1 +
 net/ipv4/inet_connection_sock.c | 76 +++++++++++++++++++++++++++++----
 2 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/net/core/request_sock.c b/net/core/request_sock.c
index 82cf9fbe2668..08c37ecd923b 100644
--- a/net/core/request_sock.c
+++ b/net/core/request_sock.c
@@ -151,6 +151,7 @@ struct request_sock *reqsk_clone(struct request_sock *req, struct sock *sk)
 	memcpy(&nreq_sk->sk_dontcopy_end, &req_sk->sk_dontcopy_end,
 	       req->rsk_ops->obj_size - offsetof(struct sock, sk_dontcopy_end));
 
+	sk_node_init(&nreq_sk->sk_node);
 	nreq_sk->sk_tx_queue_mapping = req_sk->sk_tx_queue_mapping;
 #ifdef CONFIG_XPS
 	nreq_sk->sk_rx_queue_mapping = req_sk->sk_rx_queue_mapping;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 851992405826..dc984d1f352e 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -695,10 +695,20 @@ int inet_rtx_syn_ack(const struct sock *parent, struct request_sock *req)
 }
 EXPORT_SYMBOL(inet_rtx_syn_ack);
 
+static void reqsk_queue_migrated(struct request_sock_queue *queue,
+				 const struct request_sock *req)
+{
+	if (req->num_timeout == 0)
+		atomic_inc(&queue->young);
+	atomic_inc(&queue->qlen);
+}
+
 static void reqsk_migrate_reset(struct request_sock *req)
 {
+	req->saved_syn = NULL;
+	inet_rsk(req)->ireq_opt = NULL;
 #if IS_ENABLED(CONFIG_IPV6)
-	inet_rsk(req)->ipv6_opt = NULL;
+	inet_rsk(req)->pktopts = NULL;
 #endif
 }
 
@@ -741,16 +751,37 @@ EXPORT_SYMBOL(inet_csk_reqsk_queue_drop_and_put);
 
 static void reqsk_timer_handler(struct timer_list *t)
 {
-	struct request_sock *req = from_timer(req, t, rsk_timer);
-	struct sock *sk_listener = req->rsk_listener;
-	struct net *net = sock_net(sk_listener);
-	struct inet_connection_sock *icsk = inet_csk(sk_listener);
-	struct request_sock_queue *queue = &icsk->icsk_accept_queue;
+	struct request_sock *req = from_timer(req, t, rsk_timer), *nreq = NULL, *oreq = req;
+	struct sock *sk_listener = req->rsk_listener, *nsk = NULL;
+	struct inet_connection_sock *icsk;
+	struct request_sock_queue *queue;
+	struct net *net;
 	int max_syn_ack_retries, qlen, expire = 0, resend = 0;
 
-	if (inet_sk_state_load(sk_listener) != TCP_LISTEN)
-		goto drop;
+	if (inet_sk_state_load(sk_listener) != TCP_LISTEN) {
+		nsk = reuseport_migrate_sock(sk_listener, req_to_sk(req), NULL);
+		if (!nsk)
+			goto drop;
+
+		nreq = reqsk_clone(req, nsk);
+		if (!nreq)
+			goto drop;
+
+		/* The new timer for the cloned req can decrease the 2
+		 * by calling inet_csk_reqsk_queue_drop_and_put(), so
+		 * hold another count to prevent use-after-free and
+		 * call reqsk_put() just before return.
+		 */
+		refcount_set(&nreq->rsk_refcnt, 2 + 1);
+		timer_setup(&nreq->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
+		reqsk_queue_migrated(&inet_csk(nsk)->icsk_accept_queue, req);
+
+		req = nreq;
+		sk_listener = nsk;
+	}
 
+	icsk = inet_csk(sk_listener);
+	net = sock_net(sk_listener);
 	max_syn_ack_retries = icsk->icsk_syn_retries ? : net->ipv4.sysctl_tcp_synack_retries;
 	/* Normally all the openreqs are young and become mature
 	 * (i.e. converted to established socket) for first timeout.
@@ -769,6 +800,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 	 * embrions; and abort old ones without pity, if old
 	 * ones are about to clog our table.
 	 */
+	queue = &icsk->icsk_accept_queue;
 	qlen = reqsk_queue_len(queue);
 	if ((qlen << 1) > max(8U, READ_ONCE(sk_listener->sk_max_ack_backlog))) {
 		int young = reqsk_queue_len_young(queue) << 1;
@@ -793,10 +825,36 @@ static void reqsk_timer_handler(struct timer_list *t)
 			atomic_dec(&queue->young);
 		timeo = min(TCP_TIMEOUT_INIT << req->num_timeout, TCP_RTO_MAX);
 		mod_timer(&req->rsk_timer, jiffies + timeo);
+
+		if (!nreq)
+			return;
+
+		if (!inet_ehash_insert(req_to_sk(nreq), req_to_sk(oreq), NULL)) {
+			/* delete timer */
+			inet_csk_reqsk_queue_drop(sk_listener, nreq);
+			goto drop;
+		}
+
+		reqsk_migrate_reset(oreq);
+		reqsk_queue_removed(&inet_csk(oreq->rsk_listener)->icsk_accept_queue, oreq);
+		reqsk_put(oreq);
+
+		reqsk_put(nreq);
 		return;
 	}
+
 drop:
-	inet_csk_reqsk_queue_drop_and_put(sk_listener, req);
+	/* Even if we can clone the req, we may need not retransmit any more
+	 * SYN+ACKs (nreq->num_timeout > max_syn_ack_retries, etc), or another
+	 * CPU may win the "own_req" race so that inet_ehash_insert() fails.
+	 */
+	if (nreq) {
+		reqsk_migrate_reset(nreq);
+		reqsk_queue_removed(queue, nreq);
+		__reqsk_free(nreq);
+	}
+
+	inet_csk_reqsk_queue_drop_and_put(oreq->rsk_listener, oreq);
 }
 
 static void reqsk_queue_hash_req(struct request_sock *req,
-- 
2.30.2

