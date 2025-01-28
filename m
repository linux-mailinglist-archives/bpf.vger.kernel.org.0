Return-Path: <bpf+bounces-49941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8681EA20689
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 09:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B6047A634F
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 08:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D9F1F12FA;
	Tue, 28 Jan 2025 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Os+ezm76"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC671DE4E3;
	Tue, 28 Jan 2025 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738054050; cv=none; b=NJFrlmAFJFlPTPfGpOlACzIG+7Aq/7E4Xp6Cag0p148wJGcZk+uL7hqR3ginArOIL0scQgws/hvXcdNnwwLHVfvqX4W8Z4yWiqm/mnsXa74aWIdcdY/CjUZb463wTTvf7LfnHuqT8QYsf7wxgneAxCAVjt/MkqZAfynlA3KpqPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738054050; c=relaxed/simple;
	bh=qgLgc+vtWhxd3wDw4kFYbDMlFJVL1MhDz8zW3gWKabs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SqZ0nVp9AGg68rDuGg8N1ARP7LMAPMAtiZGQoxn6tSngKSkm+xMiiFla304BAk1xBsiugZHohdUFRAB5QpZ2eYpZ913WEA67Sg9UE5EOyA0dRNg3xaiLWGWf2nTL9oYIGuCITmXIGzpmyCISYqiy5tHPwDxWyM9QBG7NCFgd9eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Os+ezm76; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216395e151bso68161735ad.0;
        Tue, 28 Jan 2025 00:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738054048; x=1738658848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KivH3GOTURvpBe4gz30uCxSbbTX4Z4qxExfXxl7mwmc=;
        b=Os+ezm76gyzffeguTHujn0IxilGZFzdq9/VN6GWG+r7RAIr1O9E0wyhRDmTjGBGj44
         V7Q8w/GkbZS1C28osEABoUVNBSzbkkXdjegUlNVvq2+wTp82DUUOA0anBSqUP736IrV6
         69un6dg4X1xrO87tjPAloI05/g+gMm4fPFu2k6LCOLzBmhBUZo+vVPS5K7HHX942kp3a
         i6Ga/UF7H1KDJ2vNgLGLwTgAiJT6q8NXC8BjMBQr405WDraUzpVu5SRhmgDzzeZdLY2b
         RWz4tecZGG9ugd21YeuYzDpJugAIyuu7GkXnHc727VvI4TFViHwzoUAwczOW6j4Z0dVL
         uOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738054048; x=1738658848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KivH3GOTURvpBe4gz30uCxSbbTX4Z4qxExfXxl7mwmc=;
        b=r6hmCS5Y0Mc6zxxLFKaIcPQFF7WjDyDyoQFz8/2LfSvSOFn7pTMQTbHG+XsOTRLXy9
         RW7It0Nan/PfQpWrXLohpDdfcMXQ403e0irISEn2XDag0ZaEfzHMJyVyCXVxs+e3P82T
         X79/ebueI22kaARcMzYdfeI9esDLnxTpof/i/7bLPsFbqxHoNmyV2dTx12Lf5uxtJLDJ
         mqfze3LymXHrEdR742y8EM3gbMsFHdxiR0mePeaFTs/tnNsticTqFJRMHlDdBd4dru5x
         p0WA79H4LcHT3D/NJCeI0TnQF/ESVvh9yjw0KMYvg5cA14FGb1tsWm5NuS+2j1a0k6+s
         lBUA==
X-Forwarded-Encrypted: i=1; AJvYcCXmziBdLnZsi1KLkonROQyWTnzzyFu5yTI62t34E4r4EMFsW2+Cdkok3Sxowq4GCzAcrOzKOJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAQVuQ7u8bc0C0OB2Zo/kSeWRgw9zLLnfao77kiVl9OcAJxf5n
	kh3Rnn+ej+bYyzT0eQiI/YK2wST3TzOGqVk10+vIbp72SSaf3e++
X-Gm-Gg: ASbGncueO72qipOKpJr90A04NwhZt6VMBzqfPwfdxi2QBwkEKQ6lHX7gFCUa6CF945L
	+Tadc9YkS/QuE+0Iwf9bgQFU3iNPhVFQErNPdpizNbH4pRJPZqXxghwvEvu97zxZ1thaIWFpBX0
	f5eLkYLRmIoEs8p2DiiCeWqZcVY0i2P8TBhevXFciBDjCQVWPIn1LneF5Nggkw20guI2mNhHj62
	W1r/3Jpng65DDdHRa5t/nmWyH33LR8P3byWuenlBR9+5eF+rwQMeZJU87pxIwha3FVIgGqQhmdP
	Nmw81QD/RjOAhz72Y1QuumYmDCvrj5PcroB/hPHKh3ZY1XL/HxGzVQ==
X-Google-Smtp-Source: AGHT+IEepHaPQF3Lq7vjMgHI8gu1HtaC3+TluzYakou8W3Z/w4XOR+IN0pFo8+36poE6BHZURKGWaw==
X-Received: by 2002:a17:902:f687:b0:216:4b6f:dde5 with SMTP id d9443c01a7336-21dcc4a500bmr37897205ad.13.1738054048399;
        Tue, 28 Jan 2025 00:47:28 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414e2b8sm75873275ad.205.2025.01.28.00.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 00:47:28 -0800 (PST)
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
Subject: [PATCH bpf-next v7 10/13] net-timestamp: make TCP tx timestamp bpf extension work
Date: Tue, 28 Jan 2025 16:46:17 +0800
Message-Id: <20250128084620.57547-11-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250128084620.57547-1-kerneljasonxing@gmail.com>
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make partial of the feature work finally. After this, user can
fully use the bpf prog to trace the tx path for TCP type.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
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
2.43.5


