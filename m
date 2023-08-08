Return-Path: <bpf+bounces-7231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3D1773B6F
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 17:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099701C20755
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 15:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D98A14F8A;
	Tue,  8 Aug 2023 15:42:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A4614F6B;
	Tue,  8 Aug 2023 15:42:56 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338C94C38;
	Tue,  8 Aug 2023 08:42:34 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 044825C01BA;
	Tue,  8 Aug 2023 01:59:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 08 Aug 2023 01:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1691474362; x=
	1691560762; bh=DViu5+0VvFfaGHH4bzT/NrPHRN0WXpyoHKoK6Q4aOkI=; b=k
	5wQGPWUw4F7d0kNcULOsKRRvNERd+x8S3N/Gzh/ouKapiXE8gTWvy6iPORO0R1ho
	8Vk5IeLuF6xTYi+QAIZXJFf2j9a9ygFnOVGnVAn+WgEfNwlSVXfgo39kJEjvf5Xa
	jCdqj306zdf1JecU7gm5Htq93lNVnhpEUCQBL4CWiRAf2d7s3g9FAQXh5BJXpUJn
	MMVo1l+yk4KBUF+Qfcl2i0a3ELjijJQKd1fOPdQjplLRm2vnvAmER9MBZjnMq2+2
	I69EJmofA4RDgcOpatHODOn6zMgK33Mvd3cGZWRsO+ElIR7REV8GNXFPEdM2SmUY
	e5IbrVupJpClUXi1KIiQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1691474362; x=
	1691560762; bh=DViu5+0VvFfaGHH4bzT/NrPHRN0WXpyoHKoK6Q4aOkI=; b=k
	Ovmb2E8ZAuPC+h1pMiB3lK4QJ5WhxflTLs+Ad4JUxasXzZQzvrteJzw60xPyZncT
	lSLiiaFsz3A/0fOVEupPP/mgpuQNzPWVuVMkUGYzUGDp8GN/o0SyOwYepo8K5XQ+
	lFFQFDaNmlJtd8KUUeGrIi6d0866WigMF339l/i5jM3Bkt9nToQwQJRcfCBr6RCN
	e01tOKfudxUsxf7qfAGPiCakk3sx5cdTLneCUs5zfqEUZ8fIMz3W454TaMXag0CW
	1ZCzE2D61SC/xrfb/DhcUtbR4jzzRblGmM7vZ27ruEBt/7FaZzJH/4xpzcOZbGxt
	N0lqpl13oBdHlMQVKz7zw==
X-ME-Sender: <xms:utnRZBmAiPKwNTgpZEZiHeDu_knbVl_F6AxC-nV0NzKcqdkprMbEJw>
    <xme:utnRZM0cN_Q8uiG3EhaEoVjnGMwULTzlUJtBz1sbste0oH5l2ZWy-0fKYS3Mb2hnb
    v51mPxpVf3H_ExfpHY>
X-ME-Received: <xmr:utnRZHrJs8luwdOd8P7K-5CamtmRUWj5Iv2eR_voaHWFGOeITBw3StjPVH4gbMHhT4qFgO0mcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledugdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepofgrnhhjuhhsrghkrgcuoehmvgesmhgrnhhjuhhsrghkrgdr
    mhgvqeenucggtffrrghtthgvrhhnpeeuhfejieefgedvvdeuhffhvedvjeegkeejveeihf
    egueethfevfeeikedvvdffgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehmvgesmhgrnhhjuhhsrghkrgdrmhgv
X-ME-Proxy: <xmx:utnRZBnR6zWGVBJ4I24iveAG8ubLjxMsI3XVUxTs3XefEuuAHefDNw>
    <xmx:utnRZP1BlID-dPisFNsBApjThwf_hUZxY68W-YYJfs5Dkqs8YguGOg>
    <xmx:utnRZAsDjK6aOnLmSFgAzG0tBG0dB5LNeWFmAdebYyBXY27SE5z8Yw>
    <xmx:utnRZIvuJCkm_lRvHB9jIqSW6ohjUnYcqHiqmOOdkPh_E8atcK-0JQ>
Feedback-ID: i3ea9498d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 01:59:18 -0400 (EDT)
From: Manjusaka <me@manjusaka.me>
To: ncardwell@google.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	me@manjusaka.me,
	mhiramat@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rostedt@goodmis.org
Subject: [PATCH v2] tracepoint: add new `tcp:tcp_ca_event` trace event
Date: Tue,  8 Aug 2023 05:58:18 +0000
Message-Id: <20230808055817.3979-1-me@manjusaka.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CADVnQyn3UMa3Qx6cC1Rx97xLjQdG0eKsiF7oY9UR=b9vU4R-yA@mail.gmail.com>
References: <CADVnQyn3UMa3Qx6cC1Rx97xLjQdG0eKsiF7oY9UR=b9vU4R-yA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In normal use case, the tcp_ca_event would be changed in high frequency.

It's a good indicator to represent the network quanlity.

So I propose to add a `tcp:tcp_ca_event` trace event
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
index bf06db8d2046..b374eb636af9 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -416,6 +416,51 @@ TRACE_EVENT(tcp_cong_state_set,
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


