Return-Path: <bpf+bounces-7662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3448F77A25B
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 22:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C334A281059
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 20:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D358C13;
	Sat, 12 Aug 2023 20:14:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAAD7472;
	Sat, 12 Aug 2023 20:14:06 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB221CE;
	Sat, 12 Aug 2023 13:14:04 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 64F7A5C0041;
	Sat, 12 Aug 2023 16:14:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 12 Aug 2023 16:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1691871242; x=
	1691957642; bh=RQ3Xqsivr0DrTB+AWrtlmTNgnQOpoq3hiqDAxny7d0o=; b=R
	THNhuh1kIV8+POkhFtCI4iJOQMFdUX6nGtRLtIjMSvIQheH0zF4QMmoUqKp4wcj/
	cMCH2y+kC0FYUtRHTTVh2U6bPCg2+9/Y9f2HP0j97HJc/2vWTj/gcJbH9VxC8l68
	/UAc00/vcxtGpuftxbkslWCQWR3Ltvu3XJtDCjHLO9yRF87AVONpOKe+cmefhyPj
	Br47rnniC6Xu1CN9/yf7pE7RHEuZVam0Lb+nQd48l+kZA81oEtPqshFYvSq0aUM0
	//iUzNQPsY8FNw8QD/9RDfXGkbfKj1TmmDv7hiIc2+QPOHBbPknY+miw1UM9e9CG
	ukOqDi+CGe+N6dbs0KuEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1691871242; x=
	1691957642; bh=RQ3Xqsivr0DrTB+AWrtlmTNgnQOpoq3hiqDAxny7d0o=; b=t
	msmmC0VY69aVEAFdiu8aksT6K6p7IVW6slX+R1F/AeEHbCVIsXimUSwemwwsohJe
	+7N9H7riGLWhK8cey+Riuk+XOH2pgnpQHCOGRRV39Iy2pIwN6/962G290JQ0H8qu
	xBWSZ/A5MOSmvZOC3yGRTME55UThC2wi2nmLKZGNgYLM6OhXYaB8/g0BYQrTdJMF
	+1G/uNxo+946CnwRGMCjDJ53QztNOfF9qpNyIpFzXYx6pyS/I2OIWExgDHXWNq1X
	7o6h5FiQnCltYRdTdqrTXIRzcAXSYzoyxtNuBH3TiCquMD+xVLjeuHraHWqigfmU
	FhlkUqQ2Iu9Stp0K1I8GQ==
X-ME-Sender: <xms:CujXZBAxgsx9MmtYVtqv-7N0n31wA3LBqM69QE-MHdsb0cMf62Xo8g>
    <xme:CujXZPhfOW6Y4VFmMXSObW8ii5SA5Nz1rhTALj_OdiImtlCK2HsrP476JCU71I569
    Pk1jv42dxgcC9wRCr0>
X-ME-Received: <xmr:CujXZMkEp_rr9RnD_5N7he4C2orXF8meGIIBXimO0FMsAis7XZHPuqilpeYTeBT2JAXgMgInRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddttddgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepkghhvggrohcunfhiuceomhgvsehmrghnjhhushgrkhgr
    rdhmvgeqnecuggftrfgrthhtvghrnhepfeduueffhefgleeguedtgffgffegleejueevge
    ffveekfeeileduledujeevleeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepmhgvsehmrghnjhhushgrkhgrrdhmvg
X-ME-Proxy: <xmx:CujXZLwLmcMHpgV9NE3U88UfVrtLVnneTB4_WK5qzmyf0NshvIqs0w>
    <xmx:CujXZGSrSN6-r6lYeAx9PiRFTnD8PbiTrG7NhyAvJOHVVrJZni4D-w>
    <xmx:CujXZOZtAyi_xG0ezGdLmsoQ5BdVYn0f_9KMBzMxeDDIjtoIQcHeLQ>
    <xmx:CujXZCbGiHrHw8Vxbg34LQN_9x6AjQVyi5yXI6PLsAuwalclyzFZeQ>
Feedback-ID: i3ea9498d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Aug 2023 16:13:56 -0400 (EDT)
From: Zheao Li <me@manjusaka.me>
To: edumazet@google.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	me@manjusaka.me,
	mhiramat@kernel.org,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rostedt@goodmis.org
Subject: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
Date: Sat, 12 Aug 2023 20:12:50 +0000
Message-Id: <20230812201249.62237-1-me@manjusaka.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
References: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In normal use case, the tcp_ca_event would be changed in high frequency.

The developer can monitor the network quality more easier by tracing
TCP stack with this TP event.

So I propose to add a `tcp:tcp_ca_event` trace event
like `tcp:tcp_cong_state_set` to help the people to
trace the TCP connection status

Signed-off-by: Zheao Li <me@manjusaka.me>
---
 include/net/tcp.h          |  9 ++----
 include/trace/events/tcp.h | 60 ++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_cong.c        | 10 +++++++
 3 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0ca972ebd3dd..a68c5b61889c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1154,13 +1154,8 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
 }
 
-static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
-{
-	const struct inet_connection_sock *icsk = inet_csk(sk);
-
-	if (icsk->icsk_ca_ops->cwnd_event)
-		icsk->icsk_ca_ops->cwnd_event(sk, event);
-}
+/* from tcp_cong.c */
+void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event);
 
 /* From tcp_cong.c */
 void tcp_set_ca_state(struct sock *sk, const u8 ca_state);
diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 7b1ddffa3dfc..993eb00403ea 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -41,6 +41,18 @@
 	TP_STORE_V4MAPPED(__entry, saddr, daddr)
 #endif
 
+/* The TCP CA event traced by tcp_ca_event*/
+#define tcp_ca_event_names    \
+		EM(CA_EVENT_TX_START)     \
+		EM(CA_EVENT_CWND_RESTART) \
+		EM(CA_EVENT_COMPLETE_CWR) \
+		EM(CA_EVENT_LOSS)         \
+		EM(CA_EVENT_ECN_NO_CE)    \
+		EMe(CA_EVENT_ECN_IS_CE)
+
+#define show_tcp_ca_event_names(val) \
+	__print_symbolic(val, tcp_ca_event_names)
+
 /*
  * tcp event with arguments sk and skb
  *
@@ -419,6 +431,54 @@ TRACE_EVENT(tcp_cong_state_set,
 		  __entry->cong_state)
 );
 
+TRACE_EVENT(tcp_ca_event,
+
+	TP_PROTO(struct sock *sk, const u8 ca_event),
+
+	TP_ARGS(sk, ca_event),
+
+	TP_STRUCT__entry(
+		__field(const void *, skaddr)
+		__field(__u16, sport)
+		__field(__u16, dport)
+		__field(__u16, family)
+		__array(__u8, saddr, 4)
+		__array(__u8, daddr, 4)
+		__array(__u8, saddr_v6, 16)
+		__array(__u8, daddr_v6, 16)
+		__field(__u8, ca_event)
+	),
+
+	TP_fast_assign(
+		struct inet_sock *inet = inet_sk(sk);
+		__be32 *p32;
+
+		__entry->skaddr = sk;
+
+		__entry->sport = ntohs(inet->inet_sport);
+		__entry->dport = ntohs(inet->inet_dport);
+		__entry->family = sk->sk_family;
+
+		p32 = (__be32 *) __entry->saddr;
+		*p32 = inet->inet_saddr;
+
+		p32 = (__be32 *) __entry->daddr;
+		*p32 =  inet->inet_daddr;
+
+		TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_daddr,
+			   sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
+
+		__entry->ca_event = ca_event;
+	),
+
+	TP_printk("family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c ca_event=%s",
+		  show_family_name(__entry->family),
+		  __entry->sport, __entry->dport,
+		  __entry->saddr, __entry->daddr,
+		  __entry->saddr_v6, __entry->daddr_v6,
+		  show_tcp_ca_event_names(__entry->ca_event))
+);
+
 #endif /* _TRACE_TCP_H */
 
 /* This part must be outside protection */
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index 1b34050a7538..fb7ec6ebbbd0 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -34,6 +34,16 @@ struct tcp_congestion_ops *tcp_ca_find(const char *name)
 	return NULL;
 }
 
+void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	trace_tcp_ca_event(sk, (u8)event);
+
+	if (icsk->icsk_ca_ops->cwnd_event)
+		icsk->icsk_ca_ops->cwnd_event(sk, event);
+}
+
 void tcp_set_ca_state(struct sock *sk, const u8 ca_state)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
-- 
2.34.1


