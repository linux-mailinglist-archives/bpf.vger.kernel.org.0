Return-Path: <bpf+bounces-55402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C52FBA7E072
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 16:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630C33AFB2B
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 14:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191961C5D6C;
	Mon,  7 Apr 2025 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uX8XMhGb"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C2A1BD9C7
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034435; cv=none; b=SsBuHbk6D51XOhC+QBngrIyLhaLVRC1lmyF+p5FI+SfAg5SNsk2uv6HCzjXJ19ZiDwLgrcWUuGHY4BcsXwzyfEdcaFbRVT5XPhwnn61Tcm67QE0Z7K2GMOZHSJGMwB/SNY+RloyCr8UxzriUI0Xj7B875NHy8aFMI3w3t5uv3Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034435; c=relaxed/simple;
	bh=DgMnIFXtAvx1loyBh95GC/kcO1U1K7g6nvQfxWnY9lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWgIWCK35SwQE7St13VvCR93LvUcUvxceCq3gi1rhzJUNo2kTIQIIKZIXRaH9oIZtrKlv06KUT97jruZPSbX6ShCfRAr3UxLH0Q0ehdJm3RWJm99ejIMPU++IAv9HHUpVQw8ySZ+08iwh0sVg3QHPsxCeHofBsCWzI6Rt+Sqi9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uX8XMhGb; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744034430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9cbMwporEsi242xRzgMBwjUyFcDHJGIP25ud7IaC75Y=;
	b=uX8XMhGbrioPdgoNlB2Zx7hjtiyx2T12b79dMnJos2ACmrUakRYGA/v4hGCV4MwgAhKf6R
	xyVmjJNYzxmalWd/AItVmefT2v0snUGViLFJB6b4vPqTv9Yr8GE4Xh1JrdMsFyM7/ZZl2n
	3biBk4VoSevVZDiTt2VuG0A04xhnwwo=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antony Antony <antony.antony@secunet.com>,
	Christian Hopps <chopps@labn.net>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND net-next v3 1/2] tcp: add TCP_RFC7323_TW_PAWS drop reason
Date: Mon,  7 Apr 2025 21:59:50 +0800
Message-ID: <20250407140001.13886-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250407140001.13886-1-jiayuan.chen@linux.dev>
References: <20250407140001.13886-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

PAWS is a long-standing issue, especially when there are upstream network
devices, making it more prone to occur.

Currently, packet loss statistics for PAWS can only be viewed through MIB,
which is a global metric and cannot be precisely obtained through tracing
to get the specific 4-tuple of the dropped packet. In the past, we had to
use kprobe ret to retrieve relevant skb information from
tcp_timewait_state_process().

We add a drop_reason pointer, similar to what previous commit does:
commit e34100c2ecbb ("tcp: add a drop_reason pointer to tcp_check_req()")

This commit addresses the PAWSESTABREJECTED case and also sets the
corresponding drop reason.

We use 'pwru' to test.

Before this commit:
''''
./pwru 'port 9999'
2025/04/07 13:40:19 Listening for events..
TUPLE                                        FUNC
172.31.75.115:12345->172.31.75.114:9999(tcp) sk_skb_reason_drop(SKB_DROP_REASON_NOT_SPECIFIED)
'''

After this commit:
'''
./pwru 'port 9999'
2025/04/07 13:51:34 Listening for events..
TUPLE                                        FUNC
172.31.75.115:12345->172.31.75.114:9999(tcp) sk_skb_reason_drop(SKB_DROP_REASON_TCP_RFC7323_TW_PAWS)
'''

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/net/dropreason-core.h | 6 ++++++
 include/net/tcp.h             | 3 ++-
 net/ipv4/tcp_ipv4.c           | 3 ++-
 net/ipv4/tcp_minisocks.c      | 7 +++++--
 net/ipv6/tcp_ipv6.c           | 3 ++-
 5 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index e4fdc6b54cef..9701d7f936f6 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -40,6 +40,7 @@
 	FN(TCP_OFOMERGE)		\
 	FN(TCP_RFC7323_PAWS)		\
 	FN(TCP_RFC7323_PAWS_ACK)	\
+	FN(TCP_RFC7323_TW_PAWS)		\
 	FN(TCP_RFC7323_TSECR)		\
 	FN(TCP_LISTEN_OVERFLOW)		\
 	FN(TCP_OLD_SEQUENCE)		\
@@ -283,6 +284,11 @@ enum skb_drop_reason {
 	 * Corresponds to LINUX_MIB_PAWS_OLD_ACK.
 	 */
 	SKB_DROP_REASON_TCP_RFC7323_PAWS_ACK,
+	/**
+	 * @SKB_DROP_REASON_TCP_RFC7323_TW_PAWS: PAWS check, socket is in
+	 * TIME_WAIT state.
+	 */
+	SKB_DROP_REASON_TCP_RFC7323_TW_PAWS,
 	/**
 	 * @SKB_DROP_REASON_TCP_RFC7323_TSECR: PAWS check, invalid TSEcr.
 	 * Corresponds to LINUX_MIB_TSECRREJECTED.
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4450c384ef17..5078ad868fee 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -427,7 +427,8 @@ enum tcp_tw_status {
 enum tcp_tw_status tcp_timewait_state_process(struct inet_timewait_sock *tw,
 					      struct sk_buff *skb,
 					      const struct tcphdr *th,
-					      u32 *tw_isn);
+					      u32 *tw_isn,
+					      enum skb_drop_reason *drop_reason);
 struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			   struct request_sock *req, bool fastopen,
 			   bool *lost_race, enum skb_drop_reason *drop_reason);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 8cce0d5489da..d5b5c32115d2 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2417,7 +2417,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		goto csum_error;
 	}
 
-	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn);
+	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn,
+					       &drop_reason);
 	switch (tw_status) {
 	case TCP_TW_SYN: {
 		struct sock *sk2 = inet_lookup_listener(net,
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index fb9349be36b8..27511bf58c0f 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -97,7 +97,8 @@ static void twsk_rcv_nxt_update(struct tcp_timewait_sock *tcptw, u32 seq,
  */
 enum tcp_tw_status
 tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
-			   const struct tcphdr *th, u32 *tw_isn)
+			   const struct tcphdr *th, u32 *tw_isn,
+			   enum skb_drop_reason *drop_reason)
 {
 	struct tcp_timewait_sock *tcptw = tcp_twsk((struct sock *)tw);
 	u32 rcv_nxt = READ_ONCE(tcptw->tw_rcv_nxt);
@@ -245,8 +246,10 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 		return TCP_TW_SYN;
 	}
 
-	if (paws_reject)
+	if (paws_reject) {
+		*drop_reason = SKB_DROP_REASON_TCP_RFC7323_TW_PAWS;
 		__NET_INC_STATS(twsk_net(tw), LINUX_MIB_PAWSESTABREJECTED);
+	}
 
 	if (!th->rst) {
 		/* In this case we must reset the TIMEWAIT timer.
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index b03c223eda4f..7dcb33f879ee 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1970,7 +1970,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		goto csum_error;
 	}
 
-	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn);
+	tw_status = tcp_timewait_state_process(inet_twsk(sk), skb, th, &isn,
+					       &drop_reason);
 	switch (tw_status) {
 	case TCP_TW_SYN:
 	{
-- 
2.47.1


