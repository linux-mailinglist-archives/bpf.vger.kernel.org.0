Return-Path: <bpf+bounces-10839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79307AE44E
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 05:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 504EC1F253AB
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 03:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E521C08;
	Tue, 26 Sep 2023 03:53:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522B97F;
	Tue, 26 Sep 2023 03:53:08 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC6FDF;
	Mon, 25 Sep 2023 20:53:06 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c5c91bec75so54096545ad.3;
        Mon, 25 Sep 2023 20:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695700385; x=1696305185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JczkQqyjvbmONdfSb7+32cq+PF9W34IrY/qRu2iyGPw=;
        b=cpreYhigLnsyABIxzWIqZndgFppxJ5zubpYiJzHBkqwyF6cuzpSnwk2lCdTZWQiun1
         zIBc8wgSz9FjXsqZGr6/yJb+D10qs4JdUI3xi9WxyjmmwZCcauU8qN8UlfhvVWe0mS5H
         o+TQN06JTLsM4NTw4LjAydKuVx/TY+PEKo/XDzfzha2IrGNYMM0s+jc1VjX79+wakASv
         2FyzqWnmDFMlHqtF+zsxbV71H3YorjnfknbIsl9nvNhoInMDUMh3Ld+wjUgoqKaXUMwp
         KlSjyXJvG9N3qn7HQEv6p+L8HqYgVUN5cLM45ym5vbTKff7xmm1vxHyDcuWXnrgbZx8O
         8lqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695700385; x=1696305185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JczkQqyjvbmONdfSb7+32cq+PF9W34IrY/qRu2iyGPw=;
        b=eJUufKD7otDg8DMfRM0/g6XnN3LTWdxWtUuqbvr9i4RV3iALVRfIBvbvgN8nelWL3S
         2tkaL/g0I4bRufsaqNyFmKRMMZUzNYQzZKxoHlLjpj2Q7BdaIYrQT+FffvMubpHBSstB
         Wkk9QvmVTToRRB+wLCbXp0W5vh2w+mqoQN3AbHCkeBWeq4rV5HGL6C/JUDWmBH0Og0w3
         zg4yrrMSGEBAAIDIBpj42eqeItj8zsVXvD4wrAz37QkvgCtEf2OKbwsoSm7jgXuBxqpY
         2U1xwvRqcAluSzf/7dvb2Tra9wcOuxjAylCy/x9uZyPyXcSsVR2BvDf+gIy0uB96H2vR
         QNhg==
X-Gm-Message-State: AOJu0Ywo4X1pmT4NL+f6gw8VEti4FUNyYLHMMT0ERkdsA+mJ1kYZG2FR
	KQ6h642wEaMsmlCdHb97JR8=
X-Google-Smtp-Source: AGHT+IE8huCdkc1BY3hAVrDUH/gxQKmcK1kP6UsLX/uOMlOqEz+Y/wpKJ35spo3zhY9FlGI8Wc5pbw==
X-Received: by 2002:a17:902:d503:b0:1c0:e6e1:4a11 with SMTP id b3-20020a170902d50300b001c0e6e14a11mr7457393plg.54.1695700385595;
        Mon, 25 Sep 2023 20:53:05 -0700 (PDT)
Received: from john.lan ([2605:59c8:148:ba00:650a:2e28:f286:c10b])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b001c3e732b8dbsm9755723plg.168.2023.09.25.20.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 20:53:05 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com
Subject: [PATCH bpf v3 1/3] bpf: tcp_read_skb needs to pop skb regardless of seq
Date: Mon, 25 Sep 2023 20:52:58 -0700
Message-Id: <20230926035300.135096-2-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230926035300.135096-1-john.fastabend@gmail.com>
References: <20230926035300.135096-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Before fix e5c6de5fa0258 tcp_read_skb() would increment the tp->copied-seq
value. This (as described in the commit) would cause an error for apps
because once that is incremented the application might believe there is no
data to be read. Then some apps would stall or abort believing no data is
available.

However, the fix is incomplete because it introduces another issue in
the skb dequeue. The loop does tcp_recv_skb() in a while loop to consume
as many skbs as possible. The problem is the call is,

  tcp_recv_skb(sk, seq, &offset)

Where 'seq' is

  u32 seq = tp->copied_seq;

Now we can hit a case where we've yet incremented copied_seq from BPF side,
but then tcp_recv_skb() fails this test,

 if (offset < skb->len || (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN))

so that instead of returning the skb we call tcp_eat_recv_skb() which frees
the skb. This is because the routine believes the SKB has been collapsed
per comment,

 /* This looks weird, but this can happen if TCP collapsing
  * splitted a fat GRO packet, while we released socket lock
  * in skb_splice_bits()
  */

This can't happen here we've unlinked the full SKB and orphaned it. Anyways
it would confuse any BPF programs if the data were suddenly moved underneath
it.

To fix this situation do simpler operation and just skb_peek() the data
of the queue followed by the unlink. It shouldn't need to check this
condition and tcp_read_skb() reads entire skbs so there is no need to
handle the 'offset!=0' case as we would see in tcp_read_sock().

Fixes: e5c6de5fa0258 ("bpf, sockmap: Incorrectly handling copied_seq")
Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/ipv4/tcp.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0c3040a63ebd..3f66cdeef7de 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1621,16 +1621,13 @@ EXPORT_SYMBOL(tcp_read_sock);
 
 int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
-	struct tcp_sock *tp = tcp_sk(sk);
-	u32 seq = tp->copied_seq;
 	struct sk_buff *skb;
 	int copied = 0;
-	u32 offset;
 
 	if (sk->sk_state == TCP_LISTEN)
 		return -ENOTCONN;
 
-	while ((skb = tcp_recv_skb(sk, seq, &offset)) != NULL) {
+	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
 		u8 tcp_flags;
 		int used;
 
@@ -1643,13 +1640,10 @@ int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 				copied = used;
 			break;
 		}
-		seq += used;
 		copied += used;
 
-		if (tcp_flags & TCPHDR_FIN) {
-			++seq;
+		if (tcp_flags & TCPHDR_FIN)
 			break;
-		}
 	}
 	return copied;
 }
-- 
2.33.0


