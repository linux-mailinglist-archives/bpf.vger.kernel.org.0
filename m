Return-Path: <bpf+bounces-15728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A30A7F56BB
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 04:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90872816E4
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 03:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3F36135;
	Thu, 23 Nov 2023 03:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE18CB
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 19:07:35 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vwxlpxc_1700708852;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0Vwxlpxc_1700708852)
          by smtp.aliyun-inc.com;
          Thu, 23 Nov 2023 11:07:33 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com,
	hengqi@linux.alibaba.com
Subject: [PATCH bpf-next] bpf: add sock_ops callbacks for data send/recv/acked events
Date: Thu, 23 Nov 2023 11:07:32 +0800
Message-Id: <20231123030732.111576-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 3 sock_ops operators, namely BPF_SOCK_OPS_DATA_SEND_CB,
BPF_SOCK_OPS_DATA_RECV_CB, and BPF_SOCK_OPS_DATA_ACKED_CB. A flag
BPF_SOCK_OPS_DATA_EVENT_CB_FLAG is provided to minimize the performance
impact. The flag must be explicitly set to enable these callbacks.

If the flag is enabled, bpf sock_ops program will be called every time a
tcp data packet is sent, received, and acked.
BPF_SOCK_OPS_DATA_SEND_CB: call bpf after a data packet is sent.
BPF_SOCK_OPS_DATA_RECV_CB: call bpf after a data packet is receviced.
BPF_SOCK_OPS_DATA_ACKED_CB: call bpf after a valid ack packet is
processed (some sent data are ackknowledged).

We use these callbacks for fine-grained tcp monitoring, which collects
and analyses every tcp request/response event information. The whole
system has been described in SIGMOD'18 (see
https://dl.acm.org/doi/pdf/10.1145/3183713.3190659 for details). To
achieve this with bpf, we require hooks for data events that call
sock_ops bpf (1) when any data packet is sent/received/acked, and (2)
after critical tcp state variables have been updated (e.g., snd_una,
snd_nxt, rcv_nxt). However, existing sock_ops operators cannot meet our
requirements.

Besides, these hooks also help to debug tcp when data send/recv/acked.

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 include/net/tcp.h        |  9 +++++++++
 include/uapi/linux/bpf.h | 14 +++++++++++++-
 net/ipv4/tcp_input.c     |  4 ++++
 net/ipv4/tcp_output.c    |  2 ++
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d2f0736b76b8..73eda03fdda5 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2660,6 +2660,15 @@ static inline void tcp_bpf_rtt(struct sock *sk)
 		tcp_call_bpf(sk, BPF_SOCK_OPS_RTT_CB, 0, NULL);
 }
 
+/* op must be one of BPF_SOCK_OPS_DATA_SEND_CB, BPF_SOCK_OPS_DATA_RECV_CB,
+ * or BPF_SOCK_OPS_DATA_ACKED_CB.
+ */
+static inline void tcp_bpf_data_event(struct sock *sk, int op)
+{
+	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_DATA_EVENT_CB_FLAG))
+		tcp_call_bpf(sk, op, 0, NULL);
+}
+
 #if IS_ENABLED(CONFIG_SMC)
 extern struct static_key_false tcp_have_smc;
 #endif
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7cf8bcf9f6a2..2154a6235901 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3016,6 +3016,7 @@ union bpf_attr {
  * 		* **BPF_SOCK_OPS_RETRANS_CB_FLAG** (retransmission)
  * 		* **BPF_SOCK_OPS_STATE_CB_FLAG** (TCP state change)
  * 		* **BPF_SOCK_OPS_RTT_CB_FLAG** (every RTT)
+ * 		* **BPF_SOCK_OPS_DATA_EVENT_CB_FLAG** (data packet send/recv/acked)
  *
  * 		Therefore, this function can be used to clear a callback flag by
  * 		setting the appropriate bit to zero. e.g. to disable the RTO
@@ -6755,8 +6756,10 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Call bpf when data send/recv/acked. */
+	BPF_SOCK_OPS_DATA_EVENT_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 /* List of known BPF sock_ops operators.
@@ -6869,6 +6872,15 @@ enum {
 					 * by the kernel or the
 					 * earlier bpf-progs.
 					 */
+	BPF_SOCK_OPS_DATA_SEND_CB,		/* Calls BPF program when a
+					 * data packet is sent. Pure ack is ignored.
+					 */
+	BPF_SOCK_OPS_DATA_RECV_CB,		/* Calls BPF program when a
+					 * data packet is received. Pure ack is ignored.
+					 */
+	BPF_SOCK_OPS_DATA_ACKED_CB,		/* Calls BPF program when sent
+					 * data are acknowledged.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bcb55d98004c..72c6192e7cd0 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -824,6 +824,8 @@ static void tcp_event_data_recv(struct sock *sk, struct sk_buff *skb)
 
 	now = tcp_jiffies32;
 
+	tcp_bpf_data_event(sk, BPF_SOCK_OPS_DATA_RECV_CB);
+
 	if (!icsk->icsk_ack.ato) {
 		/* The _first_ data packet received, initialize
 		 * delayed ACK engine.
@@ -3454,6 +3456,8 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 		flag |= FLAG_SET_XMIT_TIMER;  /* set TLP or RTO timer */
 	}
 
+	tcp_bpf_data_event(sk, BPF_SOCK_OPS_DATA_ACKED_CB);
+
 	if (icsk->icsk_ca_ops->pkts_acked) {
 		struct ack_sample sample = { .pkts_acked = pkts_acked,
 					     .rtt_us = sack->rate->rtt_us };
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index eb13a55d660c..ddd6a9c2150f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2821,6 +2821,8 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 		/* Send one loss probe per tail loss episode. */
 		if (push_one != 2)
 			tcp_schedule_loss_probe(sk, false);
+
+		tcp_bpf_data_event(sk, BPF_SOCK_OPS_DATA_SEND_CB);
 		return false;
 	}
 	return !tp->packets_out && !tcp_write_queue_empty(sk);
-- 
2.32.0.3.g01195cf9f


