Return-Path: <bpf+bounces-10769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227FA7AE048
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 22:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1789F281B63
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 20:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73E1241E8;
	Mon, 25 Sep 2023 20:24:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BB623745;
	Mon, 25 Sep 2023 20:24:53 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B2110F;
	Mon, 25 Sep 2023 13:24:52 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bdf4752c3cso49712685ad.2;
        Mon, 25 Sep 2023 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695673492; x=1696278292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdpSeygtOSjj+3E6PMEZpW/nfaq9Hsth846hxO+B4ZE=;
        b=EoxCc4JLXW7otauAzhE31Smf5nWAHUqKX1oI+grVYWcl+Ce+5PCJ0zgaL+rLBzXLfT
         0/I0srH+vpVjV4uxpM5q0UPkE18GivPvKxGbnGprxR9P1mqNWHq5NNfGbkO6VYEmNTQ/
         Y2hTJ7VhAcETArOwL84R24zTiTEek4BrEKin2i5cShVHknuRsHxeftSVJbR76/Ho/+um
         fwxNV8daWaXZ7n0pV1Zo5b6U+CQ8pMzyvnsGG2sP5Ny+C4Q02BInP5sMuNGHej4Gl4oU
         9FV+u/bUWxwv4ajXJYHmmn/1/ulcv2XiCE799yocprNecMRzYyVJELw6ZI+NiQXOQD/k
         /k5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695673492; x=1696278292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdpSeygtOSjj+3E6PMEZpW/nfaq9Hsth846hxO+B4ZE=;
        b=kNEM7CS/nmzQRCxeVj6zvznpnKTWqyjNbbwilRuZhmnEtxtAwPBweT6Yfd/kpgSz7+
         Lyd3nJmwAOWJeHQrKSWVzqA7JAulPh7wrhIx70J1GTnaIicBQNJPhUcofCgXPtsglPAH
         5mkYFLlbI+93hTfoc/2TmIZXbrra3YsTaeGqRTScLjLCKwUQt0/g6cIje9J1TDLmWwCN
         zSRqsf1iZ4hZCWDQ0n4J30s2wckxebOPj5qqk7DZ1sDQBM+bla1uzK4VeJNyEx5KC+Gx
         4ga3gjC4Njhrpk4cTa4XkMnVceceZSYMmtrW/WgPfpgRSTNknS0/qesoYrwJxmricNmh
         B97g==
X-Gm-Message-State: AOJu0Yzh8k/i2GDkHHJFrK2LkmfpVwTyDxagtv26Q4jaaUf20E2US3Pq
	5pVXcB1VtBYFizpesWhpG1o=
X-Google-Smtp-Source: AGHT+IEIY/jhdhIwh69/vZrZC11CfTREgOTtxWJi4zJ4oUq88N8Eey6SHrjbt6r/hewTBfZ6ADqOQg==
X-Received: by 2002:a17:902:6bc3:b0:1c3:6724:db6f with SMTP id m3-20020a1709026bc300b001c36724db6fmr4706446plt.29.1695673492142;
        Mon, 25 Sep 2023 13:24:52 -0700 (PDT)
Received: from john.lan ([2605:59c8:148:ba00:51e:699c:e63:c15a])
        by smtp.gmail.com with ESMTPSA id jg6-20020a17090326c600b001c61df93afdsm2254040plb.59.2023.09.25.13.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 13:24:51 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com
Subject: [PATCH bpf v2 1/3] bpf: tcp_read_skb needs to pop skb regardless of seq
Date: Mon, 25 Sep 2023 13:24:46 -0700
Message-Id: <20230925202448.100920-2-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230925202448.100920-1-john.fastabend@gmail.com>
References: <20230925202448.100920-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 net/ipv4/tcp.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0c3040a63ebd..235d77af3177 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1622,15 +1622,13 @@ EXPORT_SYMBOL(tcp_read_sock);
 int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
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
 
@@ -1643,13 +1641,10 @@ int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
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


