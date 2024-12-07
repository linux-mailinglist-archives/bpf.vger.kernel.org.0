Return-Path: <bpf+bounces-46359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D054B9E815A
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 18:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBB631884EBA
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 17:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623B31547E2;
	Sat,  7 Dec 2024 17:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4RAHpdz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5F114A0BC;
	Sat,  7 Dec 2024 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733593139; cv=none; b=fc1DE3/Hp7juCmGJpixkb6vNNqVgW/EG7ddwi9L38egRY0fjdK/6JsN4V04rHo3ZwX2FNtPQP5GYOVUdR33W+IrFtZh/OYwlxmnXBvRQYnbNrH/6zDpDuvd+hRya3qnkinVNr/e5cF1SqWX5/m5/IwWpFqifPkAdDlDnziNeYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733593139; c=relaxed/simple;
	bh=r3LOFjhEbTq4r+uRIYVBLiP3l+dLV2JArHzNH/l+AU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o+nHc0fpSe/Q/Qoh7z/IC8kKjoi8rxWFkGRhXFWtc4oWNb+rT6NdXLUb0A5QuNIxGwu2D9nBMEqCtcsahvV9mMOOeZHwP8OEG1pBngrwX56OFatdgBjFiS7MeqptnEZ49/WwqoxCLuRmfoKe+S+gnbSVeiYDQbwVvM8QtKRZGEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4RAHpdz; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fc8f0598cdso3266962a12.1;
        Sat, 07 Dec 2024 09:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733593138; x=1734197938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjxXPbbbS+42waXThz8KjYgma8LLxeE4XqNSQe5q5io=;
        b=X4RAHpdz4YEsUal3AUPchwx3PPsz+TfsZIU4xFtaDjN42rcUh1kx2p+0Hrd5SmSJbq
         hpqGhuRhNDbokdWt76m41kdvk/MCcEVtL6XaiPYsbc9lTKMPetAaa9tt9CNQ41E+1FEY
         qT/aBCZ/CMnNBbYjHFBsOmVTIc88I9LmY6UUZHjd7Y7FzuCj/wkkqRH1vQe4xEWOBfWc
         JTr8KxZ07r3YGxaodhsO3lSQd/7LnozXuMs8s7ff5YvucO5EQBNrTE7CF1EIVPpqgscX
         lZqSYSVrPXBBozVo6FpMUUq3i5I03lhbhHyiZ10vEhHnLBW8S7G5SEks3GJSBmxdNWlm
         TYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733593138; x=1734197938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjxXPbbbS+42waXThz8KjYgma8LLxeE4XqNSQe5q5io=;
        b=VGIOVvYk0lKioniee2f7x7Fxqkn5WE/agZgp8/OPM7uYqCaJuNYa7BkmPaEzp3531u
         KS3TnM6/ofWE88zNrOh6jEhpZfrtJuFBFqupTVwioZRA3CimR2PQkSmMCw+Lc5TlJ/aV
         vXg4rdccyeNhejZ7mPywZyuP54XKwqbkQ8aYWdpDoC75wgY8KWZ1ztbfHowlHQLYqLG9
         epDa0+Nd628c68mlwR1h1MLFyaxKxrJw2DRILA5MCFQCuHvEWDDeUTGo7zQuheqfqhNf
         4Gcj8J55UQw0DdheSMNJhXFfoOImc3sDbXNtUcC2Xmw4A3pdrpfElQJ/rENFP9ogZJl3
         4DHw==
X-Forwarded-Encrypted: i=1; AJvYcCWfj85h8YbUjZq2gsCBcu+hdTTjw6Ta2MhJO9X9X4HAAByX3vPdk3WbMlpaRZw6E92f20dCzB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFsAzonCFbMqwndvLN7HBkh4I4JEkKqjtpMx+5pCBQwRVijkGp
	Lt7y3Rupr5+6AXnatLTodsP+b9kLhPdfCJPT5Rsns0iRL7U5EXzk
X-Gm-Gg: ASbGncspIaErJYFsmU6ejNOFW75bcDDDDEPYZ11qoTgxEGwPW1AInitg61U+yaWb5PD
	AGoXKjs4Bm1wylev0hIcz/uh3lNAiarsI5asZlD4NFAxzpCzdfJ3wM+SPqIrH9eD92NktvtZzza
	VUaHWOWUmszaLOxKgkmgTR9wPf6CUkTaCNwEGlvwtysSKRCqnQNfvoE9M/sRiJ4aHX0nIqwogPH
	c9KW5jARbyJZNS5VTsj+qE9vZXiwOeMQBQ52ZPVkGH1WW7cyAnHqyWnmomCLZuTPUkJsX0ouJio
	HCLNg6VNAXli
X-Google-Smtp-Source: AGHT+IEY6qr16IXO94HFSPFnuZsA2fTZuV6GmmLkdfL9JyStjmAq9ZlAcC0f8s2EV4W/xiZfQYYutg==
X-Received: by 2002:a17:90b:3a86:b0:2ee:c30f:33c9 with SMTP id 98e67ed59e1d1-2ef68e13ed3mr11785739a91.14.1733593138014;
        Sat, 07 Dec 2024 09:38:58 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2708b807sm6963793a91.43.2024.12.07.09.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 09:38:57 -0800 (PST)
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
Subject: [PATCH net-next v4 08/11] net-timestamp: make TCP tx timestamp bpf extension work
Date: Sun,  8 Dec 2024 01:38:00 +0800
Message-Id: <20241207173803.90744-9-kerneljasonxing@gmail.com>
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

Make the whole small feature work finally. After this, user can
fully use the bpf prog trace the tx path for TCP type.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..0a41006b10d1 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -492,6 +492,15 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
 			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
 	}
+
+	if (SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
+		struct skb_shared_info *shinfo = skb_shinfo(skb);
+		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
+
+		tcb->txstamp_ack_bpf = 1;
+		shinfo->tx_flags |= SKBTX_BPF;
+		shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+	}
 }
 
 static bool tcp_stream_is_readable(struct sock *sk, int target)
-- 
2.37.3


