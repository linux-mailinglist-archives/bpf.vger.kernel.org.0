Return-Path: <bpf+bounces-43284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7919B2E6C
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 12:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABFF8B21ED8
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 11:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D931DF24D;
	Mon, 28 Oct 2024 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiDkd6fh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0795D1DF24A;
	Mon, 28 Oct 2024 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113576; cv=none; b=pu64mGOYegNzQbVaKYShTYfIN9xY5fhIntbTdpOOoWyS1mPoXhUUuJLvHqpn3vl92TBv1e42BsBetFU6I/t1X5u51zQ0r7iSQxyypcSJ4HOTJrYQstNt1iFG+acUxwODkPp12liL780aZXFXkhLwuK+HzT3dO0alENQVhWMC3sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113576; c=relaxed/simple;
	bh=62HK8H2mMs+dN3ji2VLsJY2q1xrmdVQuqXAUCKWSZGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jAD7N4P1IKb7yceRtkuNHwOA1mBvJGrdIDzKeUiovZsjuHdcFjop7y54tjnq2sqrNC9F5cXvZxpXkoZK4YTqTIg/UXg7xKf43Mpoxzimjs1k+Cz5GzqlavutAzTRYfm1GvujlezA8L2jTfCD4SQ1Wtlb+HwM1ZI8po+VWofCtMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiDkd6fh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cb7139d9dso35829175ad.1;
        Mon, 28 Oct 2024 04:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730113574; x=1730718374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wWRn1rcALp58jystE9RjEhjL8+m9tZaufvSsaBQQlA=;
        b=AiDkd6fhJ8mLZ338OPFlilaRc/uB2otLK20dC4JOzHFmhiUrYQp+gbDREVDpscnTLO
         VK47KEc3dK/WDLg0Lo6LIeh8THZWzaukZ6Er+Rn3bN/4ik7iG/CY2DAr3I6m1BL01nU2
         Fv1kUUbE2aqhdxOeS+Nohnw1744t100JZ4vUBNUuNUBCpAWeOlD4Tye7kpnmXuyJGdsZ
         v7z7ObHFHamr96NU7QlcQytmDLlCenkrRWdG0qvocsZWVwpMvAgolLfqGC1bFam7YRHl
         Ro2XUiGdk2oTf8pUveuGYmnLDzWALWbhx2R6ObQ6ix+eqh73hVrceATvvqtWRr3jBA7N
         SzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730113574; x=1730718374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wWRn1rcALp58jystE9RjEhjL8+m9tZaufvSsaBQQlA=;
        b=uz+EjC46t9o/rSnM1e5ClH7s8eZHNcV/hTEKNGXBTuiPHKIOWJWi1NO0TDAQE3C4IP
         bnKd6DY6iaB9rrecI7otBPQl1tRwKPAmuA57mqW3cCR04ItegJ3TBKmTFUYHgTrQElXq
         09VwrH8Y943LVjCyoyWKStSPzf9pWTyzTD3Bm1V9XfZC3SJgmuWbCkJkG3djvqh+iBAp
         SNslksGREgVyKSqDB1IpbhhwjjjIR4FEhCIaohqVHSKOtjHm7KwFv7qTp04WQHiENxzC
         BwjAL0YAXCA8KFJx9fNQ/WSFkzFfmmq1b2khIBjLvIb9ha0ray2xg1W01vZ1q7PEqtva
         uf+A==
X-Forwarded-Encrypted: i=1; AJvYcCVfydQ0EIgof6T6ykOyrK/jXxqObpQan0b8VpDir5CigxdMzOAGwav+XofpIdiXotABsdWYfDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKn6uMvUtXZouIwDqkJsBDlMvL3t4ECgs3o3bNFcu2QzGXgjoM
	Zq/ES4o2yB3Lh8PhKalT98tbthQmtp06QA7fxFpKP/mfkcLVy7ti
X-Google-Smtp-Source: AGHT+IG8vJ7e1Oljyqg6Zq+5+sPx2T/5w9lZDnqrQexJ+MJoh0leVkWZVxJiWYqZTF1B3VZBtTKODw==
X-Received: by 2002:a17:902:cecd:b0:20c:a97d:cc7f with SMTP id d9443c01a7336-210c6c3ec78mr112080825ad.41.1730113574171;
        Mon, 28 Oct 2024 04:06:14 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04bdb6sm48130905ad.255.2024.10.28.04.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:06:13 -0700 (PDT)
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
	shuah@kernel.org,
	ykolal@fb.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 01/14] net-timestamp: reorganize in skb_tstamp_tx_output()
Date: Mon, 28 Oct 2024 19:05:22 +0800
Message-Id: <20241028110535.82999-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241028110535.82999-1-kerneljasonxing@gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

It's a prep for bpf print function later. This patch only puts the
original generating logic into one function, so that we integrate
bpf print easily. No functional changes here.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/skbuff.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 00afeb90c23a..1cf8416f4123 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5539,18 +5539,15 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
 
-void __skb_tstamp_tx(struct sk_buff *orig_skb,
-		     const struct sk_buff *ack_skb,
-		     struct skb_shared_hwtstamps *hwtstamps,
-		     struct sock *sk, int tstype)
+static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
+				 const struct sk_buff *ack_skb,
+				 struct skb_shared_hwtstamps *hwtstamps,
+				 struct sock *sk, int tstype)
 {
 	struct sk_buff *skb;
 	bool tsonly, opt_stats = false;
 	u32 tsflags;
 
-	if (!sk)
-		return;
-
 	tsflags = READ_ONCE(sk->sk_tsflags);
 	if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
 	    skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
@@ -5594,6 +5591,17 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 
 	__skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
 }
+
+void __skb_tstamp_tx(struct sk_buff *orig_skb,
+		     const struct sk_buff *ack_skb,
+		     struct skb_shared_hwtstamps *hwtstamps,
+		     struct sock *sk, int tstype)
+{
+	if (!sk)
+		return;
+
+	skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, tstype);
+}
 EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
 
 void skb_tstamp_tx(struct sk_buff *orig_skb,
-- 
2.37.3


