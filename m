Return-Path: <bpf+bounces-64393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE88EB12469
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 20:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BD256475B
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 18:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A4025A34B;
	Fri, 25 Jul 2025 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOAaF8Ja"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACDF246BA7;
	Fri, 25 Jul 2025 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469752; cv=none; b=fC9U/EoLkJ0jzb1JBxsXFDYu0cCR2bOEE6P3BFEGc75velyjkijajjCVdlM9Wqt6D7/pi3dmlToVVaqJIXfjoUt/6GmlYY/D7jSizeG+5IrVuZdOHw5jETomFhTBP6g1sWL6XaXgLNoNXdZn5hYYR8AMfMrdjTs6ksDjCvmKr3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469752; c=relaxed/simple;
	bh=NFOgSnhWffWrZX8FrBFj28AxcRs4yHqlVKQ/Dmxu3T0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z7nu9/g4ww9GL0DYXqFnIUQbcZzywzlAkgj1hlUZWIvt2SIn45LvAoB7XiunEUg/dCtwZFf5/ycTCG0qpTYm3jERHKTk1rrLhtZ0NMux5P2fEvj7ED4iCdWrLBZj8NNpSKLMKsUQITLKkQFBQk6auhAxccpTJlXXJppoeIeuwZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOAaF8Ja; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b77673fd78so787752f8f.0;
        Fri, 25 Jul 2025 11:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753469749; x=1754074549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQpbll3w5pfASYo5OCw14NJ6BKOsZ4svkyx7C0I92c8=;
        b=DOAaF8JaXtvL+qOCk/hhWdy35p/1FbXaWGoBcHxprpXZalg9gMfVXMGtpVM079huLU
         1KYn3JZvl13wJxuloFLXXE9MP+bj6cZ7cCRC8DyAZP2r/PtWr05cWPKUFakxHl/QPEBE
         WCLuH9N6qn9z1Tg2FI3YL85U0frrbsWbfj3dZQepUenUYHj256AgJ8C276cp0Pa6tYPo
         lf9jI3rouwWWYRqOnpn4pd0g27yKhMVeDC8hnu6qqe54uJ/ETsOqvoy0tnK9SpBeixer
         3HQ5WA2r5esctZVwi90Xth1svCfxAqv43alskRQ3wu8g9jXF5fKrxq2XVO8DXV5YJ38Z
         gPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753469749; x=1754074549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQpbll3w5pfASYo5OCw14NJ6BKOsZ4svkyx7C0I92c8=;
        b=OFhikxNdcgYtk14nWJt8scwXli+F0PpV3tCAaSuvChaRBEs3IGX303encXrcuY22aw
         sSvCIl6FVMkcbSsWcI3CWe2WqjPo3QNZcxi6lv/doCFnPqpAGdmXf3loWCQ41bLidgvB
         bQRPxeP7frZTxbGuk6iqiE17cnzFtu5UvUbVMs/TnLPeNUy++3jDYiXpA1KWsj/xJVBF
         Z/LPnZwK87CVxN9zHrAxFaRrvnTWwuuCFkBMvh6pI7AHi8zdT0gGlEiAHRURVOPLMjy9
         MhulDcxTwvak3+XisFJT4g/aeoAgBaB369Bsm7GQBR2QpJVGYL9mSFp2lsz91eMa+gIG
         B1nA==
X-Forwarded-Encrypted: i=1; AJvYcCU9hVzi0gGGJEp274WnqQupDrU10xJPGPeZDkBOZflhA2kPjhoLUvy4hb3GXEQaE2Q6ivU=@vger.kernel.org, AJvYcCWVWsk0t66C0/cIWCVcWEcDTQquD/wyQEv5gEdjpXEbxry+nbhqiBGFnIiDzGiXx5jwWq2XlPl83pB6o3yvXKTu@vger.kernel.org, AJvYcCXOPbTX9NdP63P7HvT+c1Mdb9CCTQVtgnyBg0Ovv1ySKRFO9lhicUNbnWtmPs0zR+fOibCzEC+K@vger.kernel.org
X-Gm-Message-State: AOJu0YzOUSr+zyUljbtBruBcykjjPMLmRORLyi8J7IN6QsW5iwjY5xEA
	+sbmMb+qaqalgiPvSEyd7ZNREBuAaCRIi+1wtHEdwXihqQDQX6K5LqzAgVOz8tT0
X-Gm-Gg: ASbGncuqOQexHktVrwzre3TuhV0t2Hi6oloob291WBCSDzPdsORgxoKY8A+nkZihmsG
	JaiBem31h53cmv7qUPz7HDX5oiBxgVrscSkSaGIDxveeGjQM+Zj4AVpWljE3nJfeVRevyfcM03f
	SiA2jm/7P59thf/PGlK6eK0UJa0Mi+BwHaX2mCdigVKOLrrRULWOZ6Duo5grHqfo3KUJR9ChzGH
	lxcOhLk0558DAFuGfzCXkzmRnXp95tSmUi81rzHKASdLzEmHJxcubR15WDk2Zda30fpZinv0gXa
	C5mSAN5WRxtQIt535gsV8+8oKSti37E2AD0eJN+qX7WhWbu1K6sCuft1iFe4u7NmaakYJ5+vMOV
	VXIrufLL7WprqMe62iD36vY+Byj8Wm4WlIaUP9u2XR1oX7Tno
X-Google-Smtp-Source: AGHT+IHTDc9D0rJoQVv4nSlx4nS0IduBI1i2/ZQoeEZcgjsHE6j+mVytykQQtOLq4apRY0fb5yl3+A==
X-Received: by 2002:a05:6000:2207:b0:3a4:ead4:5ea4 with SMTP id ffacd0b85a97d-3b7765f59e1mr2634933f8f.24.1753469748951;
        Fri, 25 Jul 2025 11:55:48 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b778eb276esm607743f8f.6.2025.07.25.11.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:55:48 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: alexei.starovoitov@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	mahe.tardy@gmail.com,
	martin.lau@linux.dev,
	fw@strlen.de,
	netfilter-devel@vger.kernel.org,
	pablo@netfilter.org,
	netdev@vger.kernel.org,
	coreteam@netfilter.org
Subject: [PATCH bpf-next v2 1/4] net: move netfilter nf_reject_fill_skb_dst to core ipv4
Date: Fri, 25 Jul 2025 18:53:39 +0000
Message-Id: <20250725185342.262067-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725185342.262067-1-mahe.tardy@gmail.com>
References: <CAADnVQKq_-=N7eJoup6AqFngoocT+D02NF0md_3mi2Vcrw09nQ@mail.gmail.com>
 <20250725185342.262067-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move and rename nf_reject_fill_skb_dst from
ipv4/netfilter/nf_reject_ipv4 to ip_route_reply_fetch_dst in
ipv4/route.c so that it can be reused in the following patches by BPF
kfuncs.

Netfilter uses nf_ip_route that is almost a transparent wrapper around
ip_route_output_key so this patch inlines it.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 include/net/route.h                 |  1 +
 net/ipv4/netfilter/nf_reject_ipv4.c | 19 ++-----------------
 net/ipv4/route.c                    | 15 +++++++++++++++
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index 8e39aa822cf9..1f032f768d52 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -173,6 +173,7 @@ struct rtable *ip_route_output_flow(struct net *, struct flowi4 *flp,
 				    const struct sock *sk);
 struct dst_entry *ipv4_blackhole_route(struct net *net,
 				       struct dst_entry *dst_orig);
+int ip_route_reply_fetch_dst(struct sk_buff *skb);

 static inline struct rtable *ip_route_output_key(struct net *net, struct flowi4 *flp)
 {
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 87fd945a0d27..76beb78f556a 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -220,21 +220,6 @@ void nf_reject_ip_tcphdr_put(struct sk_buff *nskb, const struct sk_buff *oldskb,
 }
 EXPORT_SYMBOL_GPL(nf_reject_ip_tcphdr_put);

-static int nf_reject_fill_skb_dst(struct sk_buff *skb_in)
-{
-	struct dst_entry *dst = NULL;
-	struct flowi fl;
-
-	memset(&fl, 0, sizeof(struct flowi));
-	fl.u.ip4.daddr = ip_hdr(skb_in)->saddr;
-	nf_ip_route(dev_net(skb_in->dev), &dst, &fl, false);
-	if (!dst)
-		return -1;
-
-	skb_dst_set(skb_in, dst);
-	return 0;
-}
-
 /* Send RST reply */
 void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		   int hook)
@@ -248,7 +233,7 @@ void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		return;

 	if ((hook == NF_INET_PRE_ROUTING || hook == NF_INET_INGRESS) &&
-	    nf_reject_fill_skb_dst(oldskb) < 0)
+	    ip_route_reply_fetch_dst(oldskb) < 0)
 		return;

 	if (skb_rtable(oldskb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
@@ -322,7 +307,7 @@ void nf_send_unreach(struct sk_buff *skb_in, int code, int hook)
 		return;

 	if ((hook == NF_INET_PRE_ROUTING || hook == NF_INET_INGRESS) &&
-	    nf_reject_fill_skb_dst(skb_in) < 0)
+	    ip_route_reply_fetch_dst(skb_in) < 0)
 		return;

 	if (skb_csum_unnecessary(skb_in) ||
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index fccb05fb3a79..59b8fc3c01c0 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2934,6 +2934,21 @@ struct rtable *ip_route_output_flow(struct net *net, struct flowi4 *flp4,
 }
 EXPORT_SYMBOL_GPL(ip_route_output_flow);

+int ip_route_reply_fetch_dst(struct sk_buff *skb)
+{
+	struct rtable *rt;
+	struct flowi4 fl4 = {
+		.daddr = ip_hdr(skb)->saddr
+	};
+
+	rt = ip_route_output_key(dev_net(skb->dev), &fl4);
+	if (IS_ERR(rt))
+		return PTR_ERR(rt);
+	skb_dst_set(skb, &rt->dst);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ip_route_reply_fetch_dst);
+
 /* called with rcu_read_lock held */
 static int rt_fill_info(struct net *net, __be32 dst, __be32 src,
 			struct rtable *rt, u32 table_id, dscp_t dscp,
--
2.34.1


