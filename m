Return-Path: <bpf+bounces-49326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148EBA175C2
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 02:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A8016B1BC
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 01:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0E314EC73;
	Tue, 21 Jan 2025 01:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew/i1sSj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1CF1494A8;
	Tue, 21 Jan 2025 01:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737423022; cv=none; b=UBOG1WrmEI2I/39xbKGhG381T4OAHOQw14Bb7DeH6d4sh7F1o2oYVXLu0LP6SlcnZPF8UFdgzMVmLowdEXLUGy4bRDT7VUWs8KYWkaIewYMKq+ykV9G5PnFGhnr0OurTqW1qYVFPRNaYIyO/k9Oi7l0IKyRzR8OIuHwPI5fsJXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737423022; c=relaxed/simple;
	bh=KWRASBLMeysksbkTL7LZdVFE/xU9QBN33MSumJPlG70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jUfpAQlqtTP/S5GVwdf9ZNMzq1YAQQQG1VspRXoA7UHZeUET0tHwdrkjyWCEtlBqqcyMqe1g9SaU7XaGz5kk+iFcq5pls6W1c7JsdOg20igkldpde1ldQhDlovMenzuWkiZXTfXXH1hnohR3/gNpBkqH5AtEbmD60TisO9V7K6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew/i1sSj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21669fd5c7cso88737795ad.3;
        Mon, 20 Jan 2025 17:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737423020; x=1738027820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaS2bELcjjFkI+HdicRbh+5OP70kiwiRW86TF/UdM6M=;
        b=Ew/i1sSjKE+6NyRYo25F/1On/Xl7+BAmh4O2BJ/Fv/ZQEhhoZRd3UW0+us5wUcpbhd
         OGd8Pz0mFKkvqiaEU8oWpB6fAjIvLejMrw7Yip2DXwLdAicE8/vTYsFA4zlyk8KHU/qb
         22g84iWSFs2ru8Iukh6ZIniHosSjaDBdrO348MUR+ODgnmK5BLjkkImXuRz67Dh3RiTQ
         MCdQnNeZ4odNgaQMTPFAUj3iDBeJtGo79WyTQ0RNoLFXPazWLndzx58Oxbqr7tYdwej9
         J2BOabIfwJwkMZwwvDUIFLG0BIHlxWbZougVAjh1u80kBg7rmubx7EoM+MPnqxOXRMa5
         /ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737423020; x=1738027820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaS2bELcjjFkI+HdicRbh+5OP70kiwiRW86TF/UdM6M=;
        b=TP3O95olhMpAWUQqs8b9Ui/oo4/ABYZamF/g6gl3C42RadtCFUcVzSXwEI4AJofVz4
         LxXZLgWQtcgs046sJuLj3frHeIk+lA7EUfQsx+97KHwyr4ZvOMXuwx3FgTeVDhsMoqJg
         zBKA7zi5Xc+nwY1N3MBlDjC1UWrKnGoK8/FkXm8ipvkgpk+5+prQpWBQIGIAyUf3ADF4
         3rJCjBd5c37yaVkFypJLz1realbTEo+KB5AtuKRbAmV8hCxGTT52WW1+P94q7xPGucyJ
         REbB+7J1nrgc2+TJDNNLMC3gC1/kzSwjaZKYjcyEJ5cK6UAip5ykmsd4JU556r5Ckt88
         nBhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV31Byekcu49Zgjz2TOimA46KYJcercovONfgZlZ/Ws6LblFqlaj/lG5eIaoQX76ta3lQK+BS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHCuHQJO5HgmzeEfcVxX8ciym0ixCwJbQsRkxj+toreA5zDSQq
	2bdBZhXQRcLQ5aqGvuSShpTN92ZJZOL20Kw/bpJDN3ZeSs7G7jNp
X-Gm-Gg: ASbGncuyiOIlnmzO9HuUXpZKANe6rrVCZKj0eKANX4Z7In9vLbphIa6LehEcR+2KTlU
	7MUh/8SFZk+VIQwgSS1fV4YIT5Q00El5WGMOfGvLtce/7Kc6tbKLFnpotNa0thB5AZKPyjbpwSc
	IK9pRZYvNLXO+zbwN0HOM1QTB9pWSZBRb+/lC9ogOgjrof8SFlZR5QjCfW/mK5g9KDLt93WafrN
	sqzW5wdmndQfg1LjwLWX1aC1WX2AAuTQszFzhYJ9wcYCitSVog80selkxZPePpKVaq2hQeSV1cP
	7IDNoLNnkInPTLnN8vXL9dIyMcxqEUuy
X-Google-Smtp-Source: AGHT+IGgaaNdPylrH1fr9gVs19WE1/ysApCmoMdoUXWPSFWLGg1ysxNs2Jvk7bFG7auWYp8+hMdfNA==
X-Received: by 2002:a05:6a20:9150:b0:1e1:1d7c:4cff with SMTP id adf61e73a8af0-1eb215df0a7mr24336858637.37.1737423020283;
        Mon, 20 Jan 2025 17:30:20 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba55c13sm7702059b3a.129.2025.01.20.17.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 17:30:19 -0800 (PST)
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
Subject: [RFC PATCH net-next v6 12/13] net-timestamp: introduce cgroup lock to avoid affecting non-bpf cases
Date: Tue, 21 Jan 2025 09:29:00 +0800
Message-Id: <20250121012901.87763-13-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250121012901.87763-1-kerneljasonxing@gmail.com>
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
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
 net/core/skbuff.c     | 6 ++++--
 net/ipv4/tcp.c        | 3 ++-
 net/ipv4/tcp_input.c  | 3 ++-
 net/ipv4/tcp_output.c | 3 ++-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 33340e0b094f..db5b4b653351 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5605,11 +5605,13 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 		return;
 
 	/* bpf extension feature entry */
-	if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+	    skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
 		skb_tstamp_tx_bpf(orig_skb, sk, tstype, sw, hwtstamps);
 
 	/* application feature entry */
-	if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+	    !skb_enable_app_tstamp(orig_skb, tstype, sw))
 		return;
 
 	tsflags = READ_ONCE(sk->sk_tsflags);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 49e489c346ea..d88160af00c4 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -493,7 +493,8 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
 	}
 
-	if (SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c8945f5be31b..e30607ba41e5 100644
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
index fc84ca669b76..483f19c2083e 100644
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


