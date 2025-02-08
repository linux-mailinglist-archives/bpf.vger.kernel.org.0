Return-Path: <bpf+bounces-50858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8C6A2D588
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 11:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8013B188D6A3
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 10:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B1B1B4222;
	Sat,  8 Feb 2025 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVaN5jFY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312F6192D8E;
	Sat,  8 Feb 2025 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739010777; cv=none; b=InG1Y9F1mPoEFmoifjlXwyq2NI4elzyjIp9KqrQ9sjX//82fLHBmwk2KalJ1graRa23fZU+MZ9X1s5rIXUf/JxJtjkLRsTehwSAm6MS83AbPShUmB6h4aaMhOKEyfWPibdP5ZPd/TKJG+VE5j1Xy+Dx8TUonGa8YT3y0zM0rMUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739010777; c=relaxed/simple;
	bh=2yACaHlYU3DQCar4Rg/fj5s7Lo6Jqz4AAg09SpiT4RQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TNPK3BQdT2I3V9aaLbeRaJd9jl8JaeVoh94MFdmnatEfIVzgbbCbOdjIp0ilvjiLl02NCGgWSKw9hBQZrUAFWj4eiZQBNo6WwtZOcIgGu+UYErp2k5T3/E8Ak8C+p9fSGuUhuZqO7R1uHg9u6MnZzsogLzDtD9CEvECpvnaWdTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVaN5jFY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f6d2642faso8568715ad.1;
        Sat, 08 Feb 2025 02:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739010775; x=1739615575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6ICXH97ERqVQSJEE7W5tq5n4W9Xmuun5ioNK6Zh9pI=;
        b=OVaN5jFYxZis610SYznlYoes1X41/0cWRXfX3ABDSITgWTKtTyHUsA08V9lgH2obbM
         XsiH0OSjcwChocc8xUwCF8u6AS/GnRQsuaLhaa9C0IvwiFmIMBf+Ea/koimBLFv5KbpK
         To+RjelPJ6PghfWnoVm9POKN7NEGlTfyjJPQLanSxeEagoPTpV3pf3hxCMx/aKD+ej7g
         e0lNpJrPWW9oah08RAxDkxVjkjjcl8D9U2H6RAOZt2FLOVme3sl4xhIVSMkndETm/u2m
         C0OV/1Kj4cExJm4zCusiIqV4tcL3qlRhgqcKFubP7SV24FdS317dW6aQfKsGUYhTONge
         YEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739010775; x=1739615575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6ICXH97ERqVQSJEE7W5tq5n4W9Xmuun5ioNK6Zh9pI=;
        b=BtDR8raB0/e+sY/LDG4cE8C4BYBOeD8Nay5tqczgM6xCBHleTKrDi0m6MVeIpLHvl0
         9ktZnV5DBcM/SYN0Jp3jYXNeiP/2e09I42ZsOzW/Cjz84UDhuWbRm/QBPvIRGo2C6uU1
         b5P3e+wd95N+9vDN+rrzULy3UXwYBoOR+Zanq/lFqw9aJ4MpAPTa+VQrowrv/qFT6dtX
         53wWzPvaAL9Q43UEIzyBoV8oaPxbis7zL4KEZbOfYMnsjbKRWkbZMWmsLGJQWbRMOaRk
         v0vPHJ6EoWroNA4P64R3t/0wWlY9sCAIZlnG1A0ZRPGSx/tV9VTdccwM1nbxJVb/XMqK
         0lRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSTiPRk7ofng/7kfpqPhBXPs36vwH1vimlB57JC5etvXESs2RefzE1dpSROdWJUbXUg0H2Qio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9UZtmAgyCUZ+dnVYryEwYyEH5HzcZIe62dXQkv+peDKM3YIY9
	zcUbH+MYEqm/cp6zudyGXFv0O0qkyHPx2gr1MGRAXOilPjJNXJ24
X-Gm-Gg: ASbGncuRWc5VLwFizlTdkzfzU2YTWh6+KHbNVgO5RGQH287YXvgEh/fN5VK1pxm2LcQ
	k1ShSc8m6nKWwKZUMmlWbP4gL37TBmjbvg/bSSbPW7Q6kglXpS7ikuLdRaNm3V9n2xIzNiTLUm9
	2x7ubyJdlaf9Yvgks/2bn2VN+JypLXXOkyLBvqJ8KCeecTNJ1kNfBEf/f0WO53broCRe8skltrx
	6crQrrMGGBhMnlJSgEB6c0sZuEfBmxSnhweoFA6Rdzftj+bTX7LjqsIOk6K5xr9T8QB96vYqAzd
	h1JlriPka4MxzupFH88dcJwNPldEdjfes+iYVUMv/B8AQdSLlgyyfw==
X-Google-Smtp-Source: AGHT+IEzIEXBtWj7Ks3TOd0MzUbQ2JmJQsw75N8176HVgyWuQVnUOS94wD7a+aXnXKM4nh/qHe0vWg==
X-Received: by 2002:a17:902:f541:b0:21f:49bd:4bbf with SMTP id d9443c01a7336-21f4e7dced2mr94707315ad.50.1739010775439;
        Sat, 08 Feb 2025 02:32:55 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af58sm44527835ad.70.2025.02.08.02.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 02:32:55 -0800 (PST)
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
Subject: [PATCH bpf-next v9 05/12] net-timestamp: prepare for isolating two modes of SO_TIMESTAMPING
Date: Sat,  8 Feb 2025 18:32:13 +0800
Message-Id: <20250208103220.72294-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250208103220.72294-1-kerneljasonxing@gmail.com>
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes here, only add test to see if the orig_skb
matches the usage of application SO_TIMESTAMPING. And it's good to
support two modes in parallel later in this series.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/skbuff.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a441613a1e6c..46530d516909 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5539,18 +5539,37 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
 
+static bool skb_tstamp_tx_report_so_timestamping(struct sk_buff *skb,
+						 int tstype, bool sw)
+{
+	switch (tstype) {
+	case SCM_TSTAMP_SCHED:
+		return skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP;
+	case SCM_TSTAMP_SND:
+		return skb_shinfo(skb)->tx_flags & (sw ? SKBTX_SW_TSTAMP :
+						    SKBTX_HW_TSTAMP);
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
 		     struct sock *sk, int tstype)
 {
+	bool tsonly, opt_stats = false, sw = hwtstamps ? false : true;
 	struct sk_buff *skb;
-	bool tsonly, opt_stats = false;
 	u32 tsflags;
 
 	if (!sk)
 		return;
 
+	if (!skb_tstamp_tx_report_so_timestamping(orig_skb, tstype, sw))
+		return;
+
 	tsflags = READ_ONCE(sk->sk_tsflags);
 	if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
 	    skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
-- 
2.43.5


