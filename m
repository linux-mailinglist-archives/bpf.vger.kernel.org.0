Return-Path: <bpf+bounces-48653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D16A0A8B2
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 12:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A827A167697
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 11:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08591B393C;
	Sun, 12 Jan 2025 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVR7mBSy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B911A9B4E;
	Sun, 12 Jan 2025 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736681957; cv=none; b=bxBgpSF4NkDLTRnzLgLxsWfbJY+MZspPYR8C2xOh38kZwJTUerD/foY6JqRlzhLmj9/suQTDiLmByIr94p5KHI2AV/FdX0X4e0wuRZJuu6S/lbjKxC3nQNSQtXvXJfkae4R3NZaX/qX1Sp5twwxJWKkKdgNKM54dvW7FeIR0CsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736681957; c=relaxed/simple;
	bh=D6eygZ0r58bPXo5cBNoylp6xEqCzVP7Hpv38DoQPzo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jpSxH9TQbn9R9/xGiym4ai3LgCfhJkDqDLCFRrDdtyhWB2EjHMxVXpCaM61Wh7XOH2B4Plfh8FQ38hWXTipZv6y5bpWaXrjj609VVP/I4JMARsP2H4Gmqkjj+yNJlbQhVkCELFVKoQOyzWW0kR6B7DWt07dUYPeepdOHIsoyADI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVR7mBSy; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so5778918a91.3;
        Sun, 12 Jan 2025 03:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736681955; x=1737286755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqIIJkr1zLbPbBJUXgaDRdNWAJmvG4arTspiCJjcCiE=;
        b=VVR7mBSyaT5qhrdrS+qx1C1j3/0RgCqIRD9fCuf/D5WcqsxYgCvgHAkxhnmRRoRk/D
         R//j7OCOqk9coPcvYMOgSEYNwYQIk8YV6h7davSX9qbtOIaNsx4DhAnwzIi60oVOUtTy
         O3cj87yEQ5C2yNKWmWy5LirIswHyHdB05R5DEBW9YsXXx+53Z5kHlinRSisWV1jCWc6a
         Y/Vt50eFUztFNBulV61yXr1CJ35lo1LnwtKjzjSML481oFmokx8cCsCQf0uVXhYGHenK
         H35xlTbxEl6wREF5EItRXHQx3Q6DondMC3OCTcGwDH+MQI+k3htCPju+2F2FTAjuTSVU
         HU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736681955; x=1737286755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqIIJkr1zLbPbBJUXgaDRdNWAJmvG4arTspiCJjcCiE=;
        b=FyNccrMzMq8L4Ca/CsJKMB1eZqKarai/uMHLzjIedR+Ne4mzHmMlDGJ9yeNz/f4DT/
         KTj0EHEYy559P1dOTIdNCh/haLcnogDWwnKqXdFUUqumhyXmbQrsDsAmYd1RgPwINOVF
         tEi4ghLYuW9IhWXequfxtZYipgJYVmiW3pCosjJkNgq02fl76o2YEWC/9EI0AJY5Qkwz
         bWczJk0Y6xc6t4BadogPVqMkhxGiKs+FCDmj+akKwxHvprspokob/HdPfnJLJ58g4ZRE
         SS9f/qckByl1rOT1/I9OSOB8RSsZnKcSH3E7sCcigGInQpJhGyYDdXp4nOiZqeImYvGY
         dk9w==
X-Forwarded-Encrypted: i=1; AJvYcCUATAYRW3qeVt5GNPjqFvmNSDrJT1cF6DP5NohiajIsZXMDqBhhihV8KfuEccsSIE3z/6C4+fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNaGxe2QubFs8xZ3vVOje1oWyvYKgoetlEA7O2VP2mvI71Nn4t
	GREQo38v7Df6Y5/2mKhku/q+aDo942ymGpioZgHg/Hp/qrIA7ngy
X-Gm-Gg: ASbGncvlljwuCN4HX1SO0meEmW0w0EHvQoo7fearwId2ibz1K0NK3ZHuYgjcyftg9RS
	noIxhlOLGR42ZkQC0k7Ck+gDlAFABJbasO4mlFXMQc93oAMlwqMjj5z7EzViiGeKnCbs5vUq2UJ
	o4/WCRRVlo42qPgF07+Bjcr1iT7VDoS3WdE35WnACWRp+qGgU8CQoSYrknP7OSrcr+7jiE3pKm0
	xypvojgc8zYH2KdEMH2NB193bHefRKuwssXkRWfJ/fUXADP7R0/G4X16+yN7eYylahU2pPwF3vE
	psoBb6UA0xG2BhoTfhI=
X-Google-Smtp-Source: AGHT+IFEbka9OrWPnD2OtSEWpcXSD2+HpwdP+NbCpFWZG85Kc8cxf3MaX185an3EARWUFYSG9kAQfQ==
X-Received: by 2002:a17:90a:fc4f:b0:2ee:6d04:9dac with SMTP id 98e67ed59e1d1-2f548f7ed36mr21029876a91.32.1736681955520;
        Sun, 12 Jan 2025 03:39:15 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253a98sm37353765ad.224.2025.01.12.03.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 03:39:15 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	horms@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next v5 14/15] net-timestamp: introduce cgroup lock to avoid affecting non-bpf cases
Date: Sun, 12 Jan 2025 19:37:47 +0800
Message-Id: <20250112113748.73504-15-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250112113748.73504-1-kerneljasonxing@gmail.com>
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introducing the lock to avoid affecting the applications which
are not using timestamping bpf feature.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/skbuff.c     | 4 +++-
 net/ipv4/tcp.c        | 6 ++++--
 net/ipv4/tcp_input.c  | 3 ++-
 net/ipv4/tcp_output.c | 3 ++-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4bc7a424eb8a..ce445e49ddc1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5602,7 +5602,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 
 	if (!sk)
 		return;
-	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
+
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+	    skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
 		__skb_tstamp_tx_bpf(orig_skb, sk, tstype);
 
 	if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b6e0db5e4ead..07326f56cc42 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -493,7 +493,8 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc, u32 f
 			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
 	}
 
-	if (SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
 
@@ -1073,7 +1074,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 	long timeo;
 
 	flags = msg->msg_flags;
-	if (SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING)) {
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING)) {
 		first_write_seq = tp->write_seq;
 		bpf_skops_tx_timestamping(sk, NULL, BPF_SOCK_OPS_TS_TCP_SND_CB);
 	}
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 0f2e6e73de9f..5493bc911593 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3324,7 +3324,8 @@ static void tcp_ack_tstamp(struct sock *sk, struct sk_buff *skb,
 
 	/* Avoid cache line misses to get skb_shinfo() and shinfo->tx_flags */
 	if (likely(!TCP_SKB_CB(skb)->txstamp_ack &&
-		   !TCP_SKB_CB(skb)->txstamp_ack_bpf))
+		   !(cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+		     TCP_SKB_CB(skb)->txstamp_ack_bpf)))
 		return;
 
 	shinfo = skb_shinfo(skb);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index aa1da7c89383..2675540c4faf 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1556,7 +1556,8 @@ static void tcp_adjust_pcount(struct sock *sk, const struct sk_buff *skb, int de
 static bool tcp_has_tx_tstamp(const struct sk_buff *skb)
 {
 	return TCP_SKB_CB(skb)->txstamp_ack ||
-	       TCP_SKB_CB(skb)->txstamp_ack_bpf ||
+	       (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+		TCP_SKB_CB(skb)->txstamp_ack_bpf) ||
 		(skb_shinfo(skb)->tx_flags & SKBTX_ANY_TSTAMP);
 }
 
-- 
2.43.5


