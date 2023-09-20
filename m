Return-Path: <bpf+bounces-10500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA23A7A8FD8
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 01:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA5A1C20AC3
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 23:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D82405D3;
	Wed, 20 Sep 2023 23:27:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738D93F4D1;
	Wed, 20 Sep 2023 23:27:13 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2174C1;
	Wed, 20 Sep 2023 16:27:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2764b04dc5cso183163a91.3;
        Wed, 20 Sep 2023 16:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695252431; x=1695857231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zx3qu+ByGUH9pcUUpikSva3zSMilQmAKQ5htxmEO3QE=;
        b=cnPKXHsKCDEfQWZcUNMaWwYLljnmQuFjCx5SJYu3IbXhgPuOU156ORBomVtRwadRSd
         N93HlKNPPPan+PxTMRnT7TEX/1G7QXidg4WwG4vV+rypK1E7HuXLcz5IYzoDAj1/8znJ
         1l25N6xE6FOh2CF5s6K5RzMQS7D1DXUxSa76Czi5LhIgmuwjMIyOiGWxw4VgcwEAlerH
         jSQgrxYKzXcqojOW+0lPzWz/ali+Pjy7e6Aee+192ydzWYxyLtCXDHCW7+tY/arsU4lL
         0XS1fny60s9yp36mMQL/kgEhp6H6n7Bs9PdCX1yC1NYixtZXk2X6drfCqRqoVaxscyEk
         hjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695252431; x=1695857231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zx3qu+ByGUH9pcUUpikSva3zSMilQmAKQ5htxmEO3QE=;
        b=dxn4cxxR1pU/RIZ38XMDAWiO1IkbZJ6VcGMKlrGkgkbhA2DNH34H5IB2zxBUsVf9ra
         87vNeuOtqsRsQCa2DTRyi7dU/6L32PhECL/QAKH1+9HeF5P0K1JcFCAVuNyjKjceuDHc
         HDX1AA54XxAnkoWwzMC1aMytK0Ai6X+/q4OB0TfXQmyoy7Pa1gjNqjGjYlt16jrZofgd
         HP++oVwoAZBMHLZfa/8KnPdtp67XZyWYlT/s5s2jptjaM1usCnEG2ugfW87fwnU4NPBi
         k1TBnJ9KKtSHWOU0jC/x3ey4XhBM8/NBLxae65SderNb+jsCI7ltp0GNdjsPOkVkFWTZ
         o8Zw==
X-Gm-Message-State: AOJu0Ywava6u5kQbWV6EN+Cay8FWVM9vMd2YcOkIpCX9OeNaqa3zE0Q6
	YLZ6uRawrv7Viod6B/VhNf4=
X-Google-Smtp-Source: AGHT+IFd6qAvhoOM+gmLS2Fhdc/1q6C0mMH23tUeJWZupXNP+3MIlTwgzRY/VbThGmuT+FztZQbfNg==
X-Received: by 2002:a17:90a:694c:b0:274:4b04:392f with SMTP id j12-20020a17090a694c00b002744b04392fmr3672190pjm.24.1695252431302;
        Wed, 20 Sep 2023 16:27:11 -0700 (PDT)
Received: from john.lan ([98.97.37.198])
        by smtp.gmail.com with ESMTPSA id mz6-20020a17090b378600b0026b12768e46sm115362pjb.42.2023.09.20.16.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 16:27:10 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf 1/3] bpf: tcp_read_skb needs to pop skb regardless of seq
Date: Wed, 20 Sep 2023 16:27:04 -0700
Message-Id: <20230920232706.498747-2-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230920232706.498747-1-john.fastabend@gmail.com>
References: <20230920232706.498747-1-john.fastabend@gmail.com>
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
 net/ipv4/tcp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0c3040a63ebd..45e7f39e67bc 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1625,12 +1625,11 @@ int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	u32 seq = tp->copied_seq;
 	struct sk_buff *skb;
 	int copied = 0;
-	u32 offset;
 
 	if (sk->sk_state == TCP_LISTEN)
 		return -ENOTCONN;
 
-	while ((skb = tcp_recv_skb(sk, seq, &offset)) != NULL) {
+	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
 		u8 tcp_flags;
 		int used;
 
-- 
2.33.0


