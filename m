Return-Path: <bpf+bounces-7193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F29772DE8
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 20:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7AF51C20CFF
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 18:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C845115AEA;
	Mon,  7 Aug 2023 18:33:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B27716410;
	Mon,  7 Aug 2023 18:33:37 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31602171A;
	Mon,  7 Aug 2023 11:33:33 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id C79B65C0159;
	Mon,  7 Aug 2023 14:33:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 07 Aug 2023 14:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm3; t=1691433210; x=1691519610; bh=DRvg+yWrex
	nAnSV98wMNJk8fdPpNOtRsOx0xI68DJjk=; b=qiAHe5FdIJqaYwx0rcigl6dBud
	Rg2tnNy20s+bA2ayPEf84TCsT++DsA6Ohc4YoEXNuNWXqjUILFScLDVeIvrLwj9+
	NZXDNzA1Zg1Dvx/B+Dj0vGUxTlUYDpd1f9H7PqQ9M7giGZOz59Gz5pzqDzTXkRqd
	2xomMXvY6Y3px0A818c6ab0j6X9cE3ms3AwRm66q8ZLkUGwn64ev5mFyODm4po/g
	Iic1oyGsHv93MaL3sRPooybgsv+W+Tpu2B1gJ82iVdg7kTbkiVeVKWDkqFXVkGrY
	LhY5rCAHP7vqBvdLvsCJqmVjKlBG5LBaTbx8TXUZh71MXuwUzImYZWdQX0XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1691433210; x=1691519610; bh=DRvg+yWrexnAn
	SV98wMNJk8fdPpNOtRsOx0xI68DJjk=; b=AKJlkPbH6czuweAxLwLh3HzQzCBvo
	Mx73WEW4EzMNmuIkcLBVcaMjDSHlN8v6utwiS1Zrd0i4HJIJfQsc0XB4DEwUJYo3
	PpQ0Q/b69La76ZlB7IhXbh470+k519iLWziFJM9XdNH353UrwLkRwo1hdAXQ4j5h
	IDHgp/wXP+OwyDC9f2IjO5m2JP28Xm6jpnP51zxD/cAMBeOes48im56LoRizZcy8
	spZdnb10nbJwEsGAU1kJrTFXNx9+pZpn8dH3PAulDY4aeGPc/lbiFUFbL1TOXSF2
	/VlHG25PGVrLfXe3OCjxzpDFje+qqpm6JIoYsYRW/l2jCymhynSbA8fSw==
X-ME-Sender: <xms:-jjRZIPzCPFLgOdmelOScrtvbBb_tzbQK6hXEo9KaaOSg11lB1Nmdg>
    <xme:-jjRZO98UQpsUTc8jlLvDVfA6xYeSDWfraG1BOCRW6x1EMJWa_SNzmtm81LVHefjf
    nW32_0HEoErtjMcEEI>
X-ME-Received: <xmr:-jjRZPRDpQACdtLHE0LOphcaA5CpxXX9q10Gh4N1tUDD69GiI3O4nTHR-u_ECNxkZvHcipUV_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledtgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeforghnjhhushgrkhgruceomhgvsehmrghnjhhushgrkhgrrdhm
    vgeqnecuggftrfgrthhtvghrnhepvddujeetiefgheehvefhveetieeuudeutdehhedtue
    etueehjeffhefhueeutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehmrghnjhhushgrkhgrrdhmvg
X-ME-Proxy: <xmx:-jjRZAuTPkND5FlrRHANWKN3_eh9pLUyPXtxwBsOjObXfHOUU9GQ9g>
    <xmx:-jjRZAdCKC4JDSdXrq8l8DNvcj2mWMRyi8YheAU521x-3aC9_erm9g>
    <xmx:-jjRZE0D0UMTqpOiOHA1exvvdB0YdzK3_nj6uGF5f10vDNjO56RGLQ>
    <xmx:-jjRZBVkTyRBPnIVc3JPMab5sE1QlXYs7E4B4WWiPeDx2vFRZNfdsw>
Feedback-ID: i3ea9498d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Aug 2023 14:33:26 -0400 (EDT)
From: Manjusaka <me@manjusaka.me>
To: edumazet@google.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Manjusaka <me@manjusaka.me>
Subject: [PATCH] tracepoint: add new `tcp:tcp_ca_event_set` trace event
Date: Mon,  7 Aug 2023 18:33:08 +0000
Message-Id: <20230807183308.9015-1-me@manjusaka.me>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In normal use case, the tcp_ca_event would be changed in high frequency.

It's a good indicator to represent the network quanlity.

So I propose to add a `tcp:tcp_ca_event_set` trace event
like `tcp:tcp_cong_state_set` to help the people to
trace the TCP connection status

Signed-off-by: Manjusaka <me@manjusaka.me>
---
 include/net/tcp.h          |  9 ++------
 include/trace/events/tcp.h | 45 ++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_cong.c        | 10 +++++++++
 3 files changed, 57 insertions(+), 7 deletions(-)

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
index bf06db8d2046..38415c5f1d52 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -416,6 +416,51 @@ TRACE_EVENT(tcp_cong_state_set,
 		  __entry->cong_state)
 );
 
+TRACE_EVENT(tcp_ca_event_set,
+
+	TP_PROTO(struct sock *sk, const u8 ca_event),
+
+	TP_ARGS(sk, ca_event),
+
+	TP_STRUCT__entry(
+		__field(const void *, skaddr)
+		__field(__u16, sport)
+		__field(__u16, dport)
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
+	TP_printk("sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c ca_event=%u",
+		  __entry->sport, __entry->dport,
+		  __entry->saddr, __entry->daddr,
+		  __entry->saddr_v6, __entry->daddr_v6,
+		  __entry->ca_event)
+);
+
 #endif /* _TRACE_TCP_H */
 
 /* This part must be outside protection */
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index 1b34050a7538..08e02850d3de 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -34,6 +34,16 @@ struct tcp_congestion_ops *tcp_ca_find(const char *name)
 	return NULL;
 }
 
+void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	trace_tcp_ca_event_set(sk, (u8)event);
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


