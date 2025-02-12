Return-Path: <bpf+bounces-51212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECD6A31E93
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 07:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA4C3A9748
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 06:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696271FC7D4;
	Wed, 12 Feb 2025 06:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFMvR5ZM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909EF1FBC99;
	Wed, 12 Feb 2025 06:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341175; cv=none; b=B/+6ylNJl13+2mPMWijxL1IAIkMNeCtXkYOYLMbUIT1OPqk+pkshOvmhe8M6rBiDoRZORA1Z4yHQr7NR/SValSAeMmITVoEyiwg8/bG+jFJ4lQI9aujNKd+KztzhM5t969IKCWCv+6Eppyy9oh/vavSjGGvLgUPtxuz+HPoKBe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341175; c=relaxed/simple;
	bh=O3ewNHQMmq8ihMVIdLkV6fION7H+CMSo23yEWzxyFKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fzCMNS1C1d0g5VrFDi0zXo8lJ8Te4uBsl2KoCZhOK8svbfT5kNqt/L7bo9wcmeZ3JKWesKTv3Pmgw5Gs91+h3rbAQ/6S0pOg/QLvHBtonHbJJz81LjN/wZy1LZZJr792bf/CEq/+jvI5fMXfIKA0hJ+dsBAvbvY23c+WZaLYccw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFMvR5ZM; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f9d627b5fbso12079452a91.2;
        Tue, 11 Feb 2025 22:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739341173; x=1739945973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8ArJj4rDFiuMrsHZk5Qg/e8fPxrR+WCMZTOoq+hv+0=;
        b=MFMvR5ZMQyKQ4rpsFomoTVTP/R8nNZs7kVlc4seTCg69+BdeJAmc8VzyIMBYbOCK2Y
         MzcivtqHBZSWRUC9EGKaOELxThQk1ZgRZLr2zxYA8MLdxVCjS/MQ2daIBK0PMms8KOtL
         KdrakldQwdfJWjiZ9dqCt0wlwfqry0nDwtvLpt6KrL0r5M2Dof+EkEdU1lVbCYMP6Zxi
         YtayDdUhKLzgM2JrLfLntZ5RCoQkHjlCyAZtZ7dL4BNB0s2fUjgQEz1hoOYwGVlSGeaj
         1J6pt7QP2c/tn/dF1x8SprwHOOgNIzPhI3Ple4EUccb5IOhs84EzqGR2EB3oFJyaTRCw
         srdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341173; x=1739945973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8ArJj4rDFiuMrsHZk5Qg/e8fPxrR+WCMZTOoq+hv+0=;
        b=OdJG12eDJ54u/6i7igbDmdK3KRouEbPblk6tUiSM4GT8olYdQOh2T8ewR2oBALwBLe
         5HU1WFYC32mn4CdZ7Cx8PLY8WKmEYeIpB2r25nFpMpmERv3RbYfTaMA4OjH8StfTJjxf
         SJuS4xVmmdC5wUmySu1iPULIkFrzyS3mLmuBSOTb9CfJKpBZv8bJRHplOynum3PwZU0v
         gOX/8fnamSanHHg+/JS8wOrdt9ddjz4QSrcM0kOyPNiF8QNLVTW9I14NCpilf2mBjDfH
         ne+5c5j8D9xsDDnHZftX59WlhcE4K3cOJ2xop7jhPYPKyGk3X+qtYRX4Tlqm0P54H/3e
         4imQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEw3AEIVGuyk6aBxEYm+A2f5mEaoQ73S+i+MZwaNWRx4oIdS6gd3qz9aKm74Sz2UNcJA1Fkxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+6UV8vzpL5xhhRjH/6PbBCbBmmbhR9sDJtB04cZlCDXT/9X06
	4m6gCUtknspnM01zykoegvOmvoczskCs4wqBY+VYL0H2Ujexi2D+
X-Gm-Gg: ASbGncvzER+E+ERA3Q9OFJdwputSPRlQPJEpWudV5XsyqROUVdrXMQaUflqMzfTEg8E
	IYX6Np6u0EJiQf7/usPGgQSMAxRgY0jy11POOUfD09Kz0qIO33wq9zaI5fAM1aKNxPJjubEv5ZI
	9+sFKhz7tfEL3ONiYWHzEpxnGzG/vHDzhrrqZ6RCxS5gpVMX++WeI9fNfVftNU2vQJxGEWmS4zk
	vPiDrmJYhbi0sMuzBsnfhXxniXeuwGK1HJseJdH2pGVzv1P+FhjI/bUX4MsYnpeaBeqM0D1URzH
	BwvGca5eNJbB5uMTr/QdH3AmIxDzTXi6K/m7C8U2eRWMfuayAHlqavUwwgbT2Pg=
X-Google-Smtp-Source: AGHT+IFsUI1qfsQuS1/EkZ9N0JL/nNWJBYt0KafqBXTB7iCJQGCsVWorH8SJ8QSGgAC+MEkThj0Btg==
X-Received: by 2002:a17:90a:c884:b0:2ee:d63f:d77 with SMTP id 98e67ed59e1d1-2fbf5bf495emr3276515a91.9.1739341172899;
        Tue, 11 Feb 2025 22:19:32 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683dac7sm105277835ad.142.2025.02.11.22.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:19:32 -0800 (PST)
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
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v10 05/12] net-timestamp: prepare for isolating two modes of SO_TIMESTAMPING
Date: Wed, 12 Feb 2025 14:18:48 +0800
Message-Id: <20250212061855.71154-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250212061855.71154-1-kerneljasonxing@gmail.com>
References: <20250212061855.71154-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes here. Only add test to see if the orig_skb
matches the usage of application SO_TIMESTAMPING.

In this series, bpf timestamping and previous socket timestamping
are implemented in the same function __skb_tstamp_tx(). To test
the socket enables socket timestamping feature, this function
skb_tstamp_tx_report_so_timestamping() is added.

In the next patch, another check for bpf timestamping feature
will be introduced just like the above report function, namely,
skb_tstamp_tx_report_bpf_timestamping(). Then users will be able
to know the socket enables either or both of features.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/skbuff.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a441613a1e6c..cd742dcad052 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5539,6 +5539,23 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
 
+static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
+						 struct skb_shared_hwtstamps *hwts,
+						 int tstype)
+{
+	switch (tstype) {
+	case SCM_TSTAMP_SCHED:
+		return skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP;
+	case SCM_TSTAMP_SND:
+		return skb_shinfo(skb)->tx_flags & (hwts ? SKBTX_HW_TSTAMP :
+						    SKBTX_SW_TSTAMP);
+	case SCM_TSTAMP_ACK:
+		return TCP_SKB_CB(skb)->txstamp_ack;
+	}
+
+	return false;
+}
+
 void __skb_tstamp_tx(struct sk_buff *orig_skb,
 		     const struct sk_buff *ack_skb,
 		     struct skb_shared_hwtstamps *hwtstamps,
@@ -5551,6 +5568,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (!sk)
 		return;
 
+	if (!skb_tstamp_tx_report_so_timestamping(orig_skb, hwtstamps, tstype))
+		return;
+
 	tsflags = READ_ONCE(sk->sk_tsflags);
 	if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
 	    skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
-- 
2.43.5


