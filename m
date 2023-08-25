Return-Path: <bpf+bounces-8580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CBB7888D3
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 15:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8ACB1C20FD5
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 13:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D717DF5C;
	Fri, 25 Aug 2023 13:43:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C72ADDD0;
	Fri, 25 Aug 2023 13:43:17 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C658D1FDE;
	Fri, 25 Aug 2023 06:43:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id B2A9032009B7;
	Fri, 25 Aug 2023 09:43:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 25 Aug 2023 09:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm1; t=1692970990; x=1693057390; bh=cWLyjRrcaS
	NB2Tn0G3Iyc+2TU5mhy5OdRlgEedNUqgs=; b=Wlt0EPZhRt18+4hLp+cTyABmV/
	rcA8OjZR2phU7nOpBGDFJ0xMqSsQY1B73abOqxNz5/lp9jwn2CTf36Pt+IOTgOmD
	9QpEcAf/bxNqTMP3uziR4d4WrjjGV1GL4FjD/c3+m/PeXjhY2nOvyyGYNS6zqTke
	eoBsY+PPQHL27lUvJdxv8cTtaOUOfzqVLlqxbx9pdIHPYjkGj7uvukBPaKkJ3mzn
	ed6QLpwS+Nbo8Paj4BBF+Z8VzGkIl7SnO0rMTkZc7Of0IUDWDBJMMxD/1CGY/FhA
	u2rJzkevGbTRDz+k/otnKQrdVj2yz7z9i3V6IMkT8mXF3iz69UFMiuuG7Q6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1692970990; x=1693057390; bh=cWLyjRrcaSNB2
	Tn0G3Iyc+2TU5mhy5OdRlgEedNUqgs=; b=19faRVhuP58P5mFZUAw6KY9kqcKLH
	86Ni0yIxChPTrD6BHjpINDq+UD8PK4TOyocGC8qzDqa5KhRB55H7b8lQY0Dpcac1
	LvcftJLg34QeHtI8/5iG+EdmJq/xHkaFs0LeAgHDKTgUKuADg2ssCK5kL2KNbDkh
	lyEq6/9lgUArHL0PfuPmRl/Gm9dglykWthRbjYKPdRRNImzW6+qUzJSxDE7GuO2J
	U2fu38jaaWsd94L2agyFkIc9VkNJJwLvE2GNe59BjHvpIXSJRxxHQUVDa88ozGcU
	ydg6hJ/9Akcl1NnzHIMD8jOHIvhyAgybyIENuSiQr/vwLtn6JhXW7MaCg==
X-ME-Sender: <xms:7a_oZJ6VG1pjVuorpyoCUUjoGgIDzRcI0o7CxVDOLIHUa_HnhDaSBg>
    <xme:7a_oZG7EyF_54juxEvm9RTjrd-qGX3wfk3GXqfcPmkMf3Zi_E890Zp5KTeeDR38Sl
    f_pF5FfJXiwKc38nak>
X-ME-Received: <xmr:7a_oZAfPvpmC4r9QdgqOUaNjtGDn-xkgs-Z-QM39pYvfM44ApgWktz-xAEBzgyVx52GHmxpkhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvkedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpegkhhgvrghoucfnihcuoehmvgesmhgrnhhjuhhsrghkrgdrmhgv
    qeenucggtffrrghtthgvrhhnpeffgeeluddvveekueettdeiffefffdvhfevhffgkeelte
    egieetfeffheffudekteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehmrghnjhhush
    grkhgrrdhmvg
X-ME-Proxy: <xmx:7a_oZCLclRUEbiVb1slwRlFGWocrjfx_NGm5r6F_oSFM84m_Ckx8lA>
    <xmx:7a_oZNIKMXxwj_IH9fnvM6haE-fOvaMOyrlCtoBM2A6LrsHl5Vbl-g>
    <xmx:7a_oZLzjGIclSULVr44ozt8oEcrBAeN9FIL6lqHeaX_63skPH22wIQ>
    <xmx:7q_oZKD1FyLSLttSIGolxpoLubSTy_NMuRE8pGbnkjQMLwmm6xJgIw>
Feedback-ID: i3ea9498d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Aug 2023 09:43:05 -0400 (EDT)
From: Zheao Li <me@manjusaka.me>
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
	Zheao Li <me@manjusaka.me>
Subject: [PATCH v4] tracepoint: add new `tcp:tcp_ca_event` trace event
Date: Fri, 25 Aug 2023 13:32:47 +0000
Message-Id: <20230825133246.344364-1-me@manjusaka.me>
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

Hello 

This the 4th version of the patch, the previous discusstion is here

https://lore.kernel.org/linux-trace-kernel/20230807183308.9015-1-me@manjusaka.me/

In this version of the code, here's some different:

1. The event name has been changed from `tcp_ca_event_set` to
`tcp_ca_event`

2. Output the current protocol family in TP_printk

3. Show the ca_event symbol instead of the original number

But the `./scripts/checkpatch.pl` has been failed to check this patch,
because we sill have some code error in ./scripts/checkpatch.pl(in
another world, the test would be failed when we use the 
scripts/checkpatch.pl to check the events/tcp.h

Feel free to ask me if you have have any issues and ideas.

Thanks

---

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


