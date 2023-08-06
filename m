Return-Path: <bpf+bounces-7097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B911E7713E3
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 09:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97B41C20981
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 07:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0C223D5;
	Sun,  6 Aug 2023 07:52:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6291A1FAF;
	Sun,  6 Aug 2023 07:52:49 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CD31BD4;
	Sun,  6 Aug 2023 00:52:45 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 9D0ED5C0075;
	Sun,  6 Aug 2023 03:52:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 06 Aug 2023 03:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm3; t=1691308362; x=1691394762; bh=k+YpVT6VAo
	F7F80t6KXXgq3nfq+BBYr4oC0WOTx8568=; b=awHlM6U1PzHY/fbAnP9S6KyVrX
	ZGryZK6fH8MwBrytIk5Oe48O4WOsGZ33qUk6kXit1xX6/1HgT6xvd1R0yMf6H2qV
	s/AwL5kHELXvH50fgTxyI/OrIyuL9f/KeJ2EXqWH8CRnldIJynVz5fWVeEuztMrO
	W3H9emK7UGmA/DPWmUudSMs7N7GMjEYlstRkcHHfNT8n+rj4mkoQWzIumbeWmM+y
	XA/ZhijWJ1GJJU547Revt2oIrhE99Kf4Q83e8aRxy6IJ5Jvj86oceROovQ98iBBk
	wuFOdFqO9s+/MY7mu+Q0T5knq0QjxL2lClmTYOuH3BvDu90a/oDbDTBrdeXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1691308362; x=1691394762; bh=k+YpVT6VAoF7F
	80t6KXXgq3nfq+BBYr4oC0WOTx8568=; b=VkhKufPpRwzTrjWI5PNqXzFUTSPM+
	GqhOVHLpCc2n89Gqcd3m8erhcwKgkhHNzS9rFky0CJhE6rWpPxSk+UNwPlYGAV1g
	+AHn5hxi5IIlaZsB/K00JULQJ3T6Fa/TXaTNCQHIPrWq/SRai3m5U4mb8Gg06X8j
	uvXddhGyS6CtX4cLgYjUhbeQ1+NNTaesxxt6eS/81gQVZgdzf7Soj03A+tM8IhPk
	XO3BSjQe2S2lkNRUb9fW7LThOIh7UmGaNQiBywONs0pEvrncDN4ii3B871bziR0c
	YDrb+24co4dJLbFEQNWcbMmKt8FUgYWRuvm1odmSRaYHNPrhUBiJJqHCA==
X-ME-Sender: <xms:SlHPZAJmKGGS2Y11Du-X7HX0cTDrBFvXF09HomcZh-Wj2QPUjLMqmg>
    <xme:SlHPZAJXp7faK4L6g3Ltlm-Cvx2IDGlqGg04mWMvgChwdkhJ2JRoixEVrnghUQ6Qi
    dJRjkYUiDOunAPqsts>
X-ME-Received: <xmr:SlHPZAswpHMbNlVgndjgacRWEQLto3pq51rYuGUNNLipGJMQKZOiLPgRHg-RsosN_INxmEI7Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeejgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeforghnjhhushgrkhgruceomhgvsehmrghnjhhushgrkhgrrdhm
    vgeqnecuggftrfgrthhtvghrnhepvddujeetiefgheehvefhveetieeuudeutdehhedtue
    etueehjeffhefhueeutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehmrghnjhhushgrkhgrrdhmvg
X-ME-Proxy: <xmx:SlHPZNbCGdnJLSbRNyNXEvwTu-HwfGm9jyNbDOBEWRtPlPJHaJkkgg>
    <xmx:SlHPZHb9jwKkOgERgP1e5LuKgxJ4GIiesZ9K7D36_yRVmLK6BqSbAQ>
    <xmx:SlHPZJCLtfLRPRa4Z6gJYHmNqxuCU4spymqZUPpXy3Byzs49aUIeEQ>
    <xmx:SlHPZETZaHA1ktBka8jRiqotlKXU4V_YcprB-Ezx_p6H_oBDreSLWg>
Feedback-ID: i3ea9498d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Aug 2023 03:52:38 -0400 (EDT)
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
Subject: [PATCH] [RFC PATCH] tcp event: add new tcp:tcp_cwnd_restart event
Date: Sun,  6 Aug 2023 07:52:16 +0000
Message-Id: <20230806075216.13378-1-me@manjusaka.me>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The tcp_cwnd_restart function would be called if the user has enabled the
tcp_slow_start_after_idle configuration and would be triggered when the
connection is idle (like LONG RTO etc.). I think it would be great to
add a new trace event named 'tcp:tcp_cwnd_reset'; it would help people
to monitor the TCP state in a complicated network environment(like
overlay/underlay SDN in Kubernetes, etc)

Signed-off-by: Manjusaka <me@manjusaka.me>
---
 include/trace/events/tcp.h | 7 +++++++
 net/ipv4/tcp_output.c      | 1 +
 2 files changed, 8 insertions(+)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index bf06db8d2046..fa44191cc609 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -187,6 +187,13 @@ DEFINE_EVENT(tcp_event_sk, tcp_rcv_space_adjust,
 	TP_ARGS(sk)
 );
 
+DEFINE_EVENT(tcp_event_sk, tcp_cwnd_restart,
+
+	TP_PROTO(struct sock *sk),
+
+	TP_ARGS(sk)
+);
+
 TRACE_EVENT(tcp_retransmit_synack,
 
 	TP_PROTO(const struct sock *sk, const struct request_sock *req),
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 51d8638d4b4c..e902fa74303d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -141,6 +141,7 @@ static __u16 tcp_advertise_mss(struct sock *sk)
  */
 void tcp_cwnd_restart(struct sock *sk, s32 delta)
 {
+	trace_tcp_cwnd_restart(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 restart_cwnd = tcp_init_cwnd(tp, __sk_dst_get(sk));
 	u32 cwnd = tcp_snd_cwnd(tp);
-- 
2.34.1


