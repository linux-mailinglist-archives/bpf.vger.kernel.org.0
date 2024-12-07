Return-Path: <bpf+bounces-46360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A8E9E8156
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 18:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF59F16685D
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 17:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEA715278E;
	Sat,  7 Dec 2024 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkaaBA/N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B15D1465BE;
	Sat,  7 Dec 2024 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733593146; cv=none; b=qR3ORIICziywn8OL81n3Lv/tJB3o3hWmxu/+/CX8YsriP071ZJ1RCVSzAaeToI+AeDHuy1HGqqdSL3c82OeQeiagguKVBfZOAMVZ2cV6b2GkDs08LfNoKMVUyVJW581BAGUDw2EXz+Gi8FzlR1nugYix1YqhwdY5FKKQRc1baDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733593146; c=relaxed/simple;
	bh=v1NzzH3DjFZs+ZzA4pj7Bdv7TWqLw04lg7tTiHBkyMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tV0Pv8WDMOAUv3Kfy1F37Mo+stiAqGBHNAXsmN++RgRxJjpDrkRRSgwc+no5Lljf1Q/xyCQ69tQzuLX8DwO2wKYa6G5uKrRPGeh1IyyIUa37xQsqkdkDPhsyE+aoLO6OgPi/4A+HyQXG5igUQIQR2+7cfYa9A04zv65QSshi064=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkaaBA/N; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee86a1a92dso2261784a91.1;
        Sat, 07 Dec 2024 09:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733593144; x=1734197944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/S0+LhGiwleozkbaHcObZn5Jxmy+ODM3cHqYa7OK71g=;
        b=IkaaBA/N/8HSbRzjRg2I6H+ApEn8AitQgnNV3wv2fG0ElWr0lgOuThqoF4BtBERDzY
         SG9IBVxTOGLtWf62dCc+jF8BvM/z/FR3H56o9NwlMkpES/5oqdgenOwuTNmVUKoqJOUX
         kNc+T6ilW++7WV3ecKddy/z16+bnv2CmO76Z4hLHKirzYSbqspdK8rsZJX4bWgToydBS
         QaTe4ovZzKHPlS6269juUNu/mC4CbMdpHo2J8eIpIMjWiMe3h6N+DAYq+pSFvKjAMFpn
         j1VQXsVXpoIASW46yREdsY+fVmD8mLvN7KKwDRZipqFIHbLnT2XMVw/eRPa4vjf0D3Qx
         3HTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733593144; x=1734197944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/S0+LhGiwleozkbaHcObZn5Jxmy+ODM3cHqYa7OK71g=;
        b=BxD/4yXlDBVdVpP9xbSon2TOktZFrKQ2uBdpnTzEh7zBanB67JTZqHQ41qOZont9ar
         46A6Pw2UbeUpGImtRbiTRvaaRpILzY0kD6mxOXffXyDzqZt6z4YWquG0NdOO+IzxVj7W
         de2erRIAZhPOgaavoEDpUB0bnUKqgk4msZN4vf02n3GC70rtZgAvFGF0KZ0nx9w2/9ZE
         R/BVOETrFWDFcOZHK1oNCfkRg58VfWoQ56l93JnTND5gbM1JARIz/FIl3nDni7rCEpXX
         KeC4qag5Szhx1/bUXrkBCYPsBXba/tvx4XQbT9LxSyrFklfTeIpAg/RqUm9eMZwRIjwJ
         R1TQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1880WxC28VDhkIuS4OtqqmO9f/+hb8EPMNFcdNDCR0JMa0yr88Xfu4EYX9eBTnAlFAXVz7uI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh7Yj//fODaDawg72+YDTfiPRb2MWVpjo9pEnIm/T4cUzdMhs5
	Utlf7H0ZRYP/i7/l+IG2MT+bhBBmP8O5rZDRLCPsi4x6apPEXphl
X-Gm-Gg: ASbGnctmWnnIYVngNbM0J47F4kPXIQwuIcM7c91Y3xixp1hpbErcrzId6lY6SHhBobx
	x0wwjEKjNTcEv8nXLsBloVN3vjwXSIqQoMM5z3ewygSDiquhCGCLBH7NSKIBV58bwXBtOhPipC+
	5XOqqyHEK47NUV00nplLBs9DyuNMFGdrMKbfNuaLmmrvpo0zPUBT+qtviaVD6sDffwdCbysFhzd
	5jEVJqZlEvDpks3ngHWkLUfpz0LRkWGK/rUw1IhulJZBXraI8ayGejujoCyG97Ikt6w7N1tHV+z
	KIMH4imUDHOl
X-Google-Smtp-Source: AGHT+IH+5+ouIusL+kfmox1fGZtxMT0SLVufO3HnYpfNwpxS0Hm1MC4vxmancwxYbf99dTTASjR1BQ==
X-Received: by 2002:a17:90a:d448:b0:2ee:5958:86d with SMTP id 98e67ed59e1d1-2ef6994916cmr12139675a91.9.1733593143838;
        Sat, 07 Dec 2024 09:39:03 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708b807sm6963793a91.43.2024.12.07.09.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 09:39:03 -0800 (PST)
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 09/11] net-timestamp: introduce cgroup lock to avoid affecting non-bpf cases
Date: Sun,  8 Dec 2024 01:38:01 +0800
Message-Id: <20241207173803.90744-10-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241207173803.90744-1-kerneljasonxing@gmail.com>
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Introducing the lock to avoid affecting the applications which
are not using timestamping bpf feature.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/skbuff.c | 6 ++++--
 net/ipv4/tcp.c    | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 182a44815630..7c59ef501c74 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5659,7 +5659,8 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 {
 	if (unlikely(skb_tstamp_is_set(orig_skb, tstype, false)))
 		skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, tstype);
-	if (unlikely(skb_tstamp_is_set(orig_skb, tstype, true)))
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+	    unlikely(skb_tstamp_is_set(orig_skb, tstype, true)))
 		__skb_tstamp_tx_bpf(sk, orig_skb, hwtstamps, tstype);
 }
 EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
@@ -5670,7 +5671,8 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
 	int tstype = SCM_TSTAMP_SND;
 
 	skb_tstamp_tx_output(orig_skb, NULL, hwtstamps, orig_skb->sk, tstype);
-	if (unlikely(skb_tstamp_is_set(orig_skb, tstype, true)))
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+	    unlikely(skb_tstamp_is_set(orig_skb, tstype, true)))
 		__skb_tstamp_tx_bpf(orig_skb->sk, orig_skb, hwtstamps, tstype);
 }
 EXPORT_SYMBOL_GPL(skb_tstamp_tx);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0a41006b10d1..3df802410ebf 100644
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
 
-- 
2.37.3


