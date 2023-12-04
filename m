Return-Path: <bpf+bounces-16573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E878031B1
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 12:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF23AB20A3E
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE3C22F18;
	Mon,  4 Dec 2023 11:43:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEE3107;
	Mon,  4 Dec 2023 03:43:26 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vxp1Hac_1701690202;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0Vxp1Hac_1701690202)
          by smtp.aliyun-inc.com;
          Mon, 04 Dec 2023 19:43:24 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	martin.lau@linux.dev,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com,
	hengqi@linux.alibaba.com
Subject: [PATCH net-next] tcp: add tracepoints for data send/recv/acked
Date: Mon,  4 Dec 2023 19:43:22 +0800
Message-Id: <20231204114322.9218-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 3 tracepoints, namely tcp_data_send/tcp_data_recv/tcp_data_acked,
which will be called every time a tcp data packet is sent, received, and
acked.
tcp_data_send: called after a data packet is sent.
tcp_data_recv: called after a data packet is receviced.
tcp_data_acked: called after a valid ack packet is processed (some sent
data are ackknowledged).

We use these callbacks for fine-grained tcp monitoring, which collects
and analyses every tcp request/response event information. The whole
system has been described in SIGMOD'18 (see
https://dl.acm.org/doi/pdf/10.1145/3183713.3190659 for details). To
achieve this with bpf, we require hooks for data events that call bpf
prog (1) when any data packet is sent/received/acked, and (2) after
critical tcp state variables have been updated (e.g., snd_una, snd_nxt,
rcv_nxt). However, existing bpf hooks cannot meet our requirements.
Besides, these tracepoints help to debug tcp when data send/recv/acked.

Though kretprobe/fexit can also be used to collect these information,
they will not work if the kernel functions get inlined. Considering the
stability, we prefer tracepoint as the solution.

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/trace/events/tcp.h | 21 +++++++++++++++++++++
 net/ipv4/tcp_input.c       |  4 ++++
 net/ipv4/tcp_output.c      |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 7b1ddffa3dfc..1423f7cb73f9 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -113,6 +113,13 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_send_reset,
 	TP_ARGS(sk, skb)
 );
 
+DEFINE_EVENT(tcp_event_sk_skb, tcp_data_recv,
+
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+
+	TP_ARGS(sk, skb)
+);
+
 /*
  * tcp event with arguments sk
  *
@@ -187,6 +194,20 @@ DEFINE_EVENT(tcp_event_sk, tcp_rcv_space_adjust,
 	TP_ARGS(sk)
 );
 
+DEFINE_EVENT(tcp_event_sk, tcp_data_send,
+
+	TP_PROTO(struct sock *sk),
+
+	TP_ARGS(sk)
+);
+
+DEFINE_EVENT(tcp_event_sk, tcp_data_acked,
+
+	TP_PROTO(struct sock *sk),
+
+	TP_ARGS(sk)
+);
+
 TRACE_EVENT(tcp_retransmit_synack,
 
 	TP_PROTO(const struct sock *sk, const struct request_sock *req),
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bcb55d98004c..edb1e24a3423 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -824,6 +824,8 @@ static void tcp_event_data_recv(struct sock *sk, struct sk_buff *skb)
 
 	now = tcp_jiffies32;
 
+	trace_tcp_data_recv(sk, skb);
+
 	if (!icsk->icsk_ack.ato) {
 		/* The _first_ data packet received, initialize
 		 * delayed ACK engine.
@@ -3486,6 +3488,8 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 		}
 	}
 #endif
+
+	trace_tcp_data_acked(sk);
 	return flag;
 }
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index eb13a55d660c..cb6f2af55ce2 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2821,6 +2821,8 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 		/* Send one loss probe per tail loss episode. */
 		if (push_one != 2)
 			tcp_schedule_loss_probe(sk, false);
+
+		trace_tcp_data_send(sk);
 		return false;
 	}
 	return !tp->packets_out && !tcp_write_queue_empty(sk);
-- 
2.32.0.3.g01195cf9f


