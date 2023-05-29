Return-Path: <bpf+bounces-1378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E4871490C
	for <lists+bpf@lfdr.de>; Mon, 29 May 2023 14:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8971C209C9
	for <lists+bpf@lfdr.de>; Mon, 29 May 2023 12:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962E76FD2;
	Mon, 29 May 2023 12:05:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3400A6AB6;
	Mon, 29 May 2023 12:05:15 +0000 (UTC)
X-Greylist: delayed 1081 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 29 May 2023 05:05:13 PDT
Received: from mx6.didiglobal.com (mx6.didiglobal.com [111.202.70.123])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 82764C7;
	Mon, 29 May 2023 05:05:12 -0700 (PDT)
Received: from mail.didiglobal.com (unknown [10.79.65.12])
	by mx6.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id C8E571100AD03B;
	Mon, 29 May 2023 19:38:50 +0800 (CST)
Received: from didi-ThinkCentre-M920t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 19:38:50 +0800
Date: Mon, 29 May 2023 19:38:42 +0800
X-MD-Sfrom: fuyuanli@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From: fuyuanli <fuyuanli@didiglobal.com>
To: Eric Dumazet <edumazet@google.com>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Neal Cardwell
	<ncardwell@google.com>
CC: <netdev@vger.kernel.org>, Jason Xing <kerneljasonxing@gmail.com>,
	zhangweiping <zhangweiping@didiglobal.com>, tiozhang
	<tiozhang@didiglobal.com>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: [PATCH net] tcp: introduce a compack timer handler in sack
 compression
Message-ID: <20230529113804.GA20300@didi-ThinkCentre-M920t-N000>
Mail-Followup-To: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>,
	zhangweiping <zhangweiping@didiglobal.com>,
	tiozhang <tiozhang@didiglobal.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.79.64.101]
X-ClientProxiedBy: ZJY01-PUBMBX-01.didichuxing.com (10.79.64.32) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We've got some issues when sending a compressed ack is deferred to
release phrase due to the socket owned by another user:
1. a compressed ack would not be sent because of lack of ICSK_ACK_TIMER
flag.
2. the tp->compressed_ack counter should be decremented by 1.
3. we cannot pass timeout check and reset the delack timer in
tcp_delack_timer_handler().
4. we are not supposed to increment the LINUX_MIB_DELAYEDACKS counter.
...

The reason why it could happen is that we previously reuse the delayed
ack logic when handling the sack compression. With this patch applied,
the sack compression logic would go into the same function
(tcp_compack_timer_handler()) whether we defer sending ack or not.
Therefore, those two issued could be easily solved.

Here are more details in the old logic:
When sack compression is triggered in the tcp_compressed_ack_kick(),
if the sock is owned by user, it will set TCP_DELACK_TIMER_DEFERRED and
then defer to the release cb phrase. Later once user releases the sock,
tcp_delack_timer_handler() should send a ack as expected, which, however,
cannot happen due to lack of ICSK_ACK_TIMER flag. Therefore, the receiver
would not sent an ack until the sender's retransmission timeout. It
definitely increases unnecessary latency.

This issue happens rarely in the production environment. I used kprobe
to hook some key functions like tcp_compressed_ack_kick, tcp_release_cb,
tcp_delack_timer_handler and then found that when tcp_delack_timer_handler
was called, value of icsk_ack.pending was 1, which means we only had
flag ICSK_ACK_SCHED set, not including ICSK_ACK_TIMER. It was against
our expectations.

In conclusion, we chose to separate the sack compression from delayed
ack logic to solve issues only happening when the process is deferred.

Fixes: 5d9f4262b7ea ("tcp: add SACK compression")
Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/linux/tcp.h   |  2 ++
 include/net/tcp.h     |  1 +
 net/ipv4/tcp_output.c |  4 ++++
 net/ipv4/tcp_timer.c  | 28 +++++++++++++++++++---------
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index b4c08ac86983..cd15a9972c48 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -461,6 +461,7 @@ enum tsq_enum {
 	TCP_MTU_REDUCED_DEFERRED,  /* tcp_v{4|6}_err() could not call
 				    * tcp_v{4|6}_mtu_reduced()
 				    */
+	TCP_COMPACK_TIMER_DEFERRED, /* tcp_compressed_ack_kick() found socket was owned */
 };
 
 enum tsq_flags {
@@ -470,6 +471,7 @@ enum tsq_flags {
 	TCPF_WRITE_TIMER_DEFERRED	= (1UL << TCP_WRITE_TIMER_DEFERRED),
 	TCPF_DELACK_TIMER_DEFERRED	= (1UL << TCP_DELACK_TIMER_DEFERRED),
 	TCPF_MTU_REDUCED_DEFERRED	= (1UL << TCP_MTU_REDUCED_DEFERRED),
+	TCPF_COMPACK_TIMER_DEFERRED     = (1UL << TCP_DELACK_TIMER_DEFERRED),
 };
 
 #define tcp_sk(ptr) container_of_const(ptr, struct tcp_sock, inet_conn.icsk_inet.sk)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 18a038d16434..e310d7bf400c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -342,6 +342,7 @@ void tcp_release_cb(struct sock *sk);
 void tcp_wfree(struct sk_buff *skb);
 void tcp_write_timer_handler(struct sock *sk);
 void tcp_delack_timer_handler(struct sock *sk);
+void tcp_compack_timer_handler(struct sock *sk);
 int tcp_ioctl(struct sock *sk, int cmd, unsigned long arg);
 int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index cfe128b81a01..1703caab6632 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1110,6 +1110,10 @@ void tcp_release_cb(struct sock *sk)
 		tcp_delack_timer_handler(sk);
 		__sock_put(sk);
 	}
+	if (flags & TCPF_COMPACK_TIMER_DEFERRED) {
+		tcp_compack_timer_handler(sk);
+		__sock_put(sk);
+	}
 	if (flags & TCPF_MTU_REDUCED_DEFERRED) {
 		inet_csk(sk)->icsk_af_ops->mtu_reduced(sk);
 		__sock_put(sk);
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index b839c2f91292..069f6442069b 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -318,6 +318,23 @@ void tcp_delack_timer_handler(struct sock *sk)
 	}
 }
 
+/* Called with BH disabled */
+void tcp_compack_timer_handler(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)))
+		return;
+
+	if (tp->compressed_ack) {
+		/* Since we have to send one ack finally,
+		 * subtract one from tp->compressed_ack to keep
+		 * LINUX_MIB_TCPACKCOMPRESSED accurate.
+		 */
+		tp->compressed_ack--;
+		tcp_send_ack(sk);
+	}
+}
 
 /**
  *  tcp_delack_timer() - The TCP delayed ACK timeout handler
@@ -757,16 +774,9 @@ static enum hrtimer_restart tcp_compressed_ack_kick(struct hrtimer *timer)
 
 	bh_lock_sock(sk);
 	if (!sock_owned_by_user(sk)) {
-		if (tp->compressed_ack) {
-			/* Since we have to send one ack finally,
-			 * subtract one from tp->compressed_ack to keep
-			 * LINUX_MIB_TCPACKCOMPRESSED accurate.
-			 */
-			tp->compressed_ack--;
-			tcp_send_ack(sk);
-		}
+		tcp_compack_timer_handler(sk);
 	} else {
-		if (!test_and_set_bit(TCP_DELACK_TIMER_DEFERRED,
+		if (!test_and_set_bit(TCP_COMPACK_TIMER_DEFERRED,
 				      &sk->sk_tsq_flags))
 			sock_hold(sk);
 	}
-- 
2.17.1


