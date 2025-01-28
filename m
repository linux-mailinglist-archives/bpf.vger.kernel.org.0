Return-Path: <bpf+bounces-49942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D663AA20683
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 09:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C9A188A708
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 08:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976641F2365;
	Tue, 28 Jan 2025 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM+YGB2B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39CB1DF738;
	Tue, 28 Jan 2025 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738054056; cv=none; b=pAUlzkB39E3Sp6ykRyBPGWy9JvapDh+z0zoL1tRZiHoX8qI3kTQfMPZ9lxV8mQ8B3v45rd6++ScqKrU5bczIAQnTIZiL/QmOtMeCf1dmFUhWMz0bx1K3Mlio0Zoc8JxLizcN2Z1SBH7foqCL7vu07bJ3+tUDkC6UewYDI7TXYGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738054056; c=relaxed/simple;
	bh=aNb8u7WdCXGl59VHWWfhDdMK5wqD7qDrJJnP35x5Hvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CSnGRHWW/p8tj9RNrO9gyHAF9u0+it918lGND7oQp0PR72OeMPqUdpd8Xl+FffvRXDphvtZ0VoqASmtHqoh6CIwgpK3xzXpWMplUaEJ12N260VEF5sKi6ry9/DB48CPuoDvCSqotMyTbvzshrNNK8AemYwzzesmSdS3jiMMGwEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lM+YGB2B; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2164b662090so103812355ad.1;
        Tue, 28 Jan 2025 00:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738054054; x=1738658854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60jA2uSFXnbKbsU07z2IqYkTW4O6QVW5Lrq9IN0HxbY=;
        b=lM+YGB2BU1WEbN8ycBawS4AByovzmcwv5tVK7vUnqb7blGEHC8OXejsD+yRnp9tl2v
         FMTrwSUhUY7jANFuMl/BupXst/maQiSkSf1yIsMizWtq2VVQQ3YuOg7525BpJT7PjDxW
         IkTZe83oGkduELsS4VW+eoc14fzBNgxsxLKJYEEhMEuR78CHz0Fsro8krqkh7Bza7UuD
         tmqcFkMH0NW0ZVG4OBk4tcwfD1zWO5krmRoIuSkWprvTO/Sg7rPRccArpNnPbAGBTZIA
         tCDsQDh9MnmAk5uC8AjFtMoXY3bl/iZRNKjBxV8H1sw9NKI2RVfCPlFNjtJ18CKRJp9T
         mPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738054054; x=1738658854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60jA2uSFXnbKbsU07z2IqYkTW4O6QVW5Lrq9IN0HxbY=;
        b=SCdZLryGi2cwcC4EXQn2enUT07meoiDWZzvTu3mOd28rkltfemCQzIz0h3aSjXf9Co
         zeqqzMyH/y5Ll9sstV7yd3jK1eUA/Z7kDsEo2dIOXRmSoOy6Yrmb2KpoWKnjh+DdwJdH
         VHZdqCwy1MvgOFKQVl34fHFSkPZdVYX6MXe0o+zofEI99+NrkWQHTcJgeD24BwRvSRDC
         LMKN39mf9MFC7MAg2I58F0llWuSDte7bTvhT7pqJyUTdxI/P/FdKaJn5mIfBG+ncFLMK
         9hpHbiSOV8nfAhmchNFQaxIm7no3qttzzoBLaaBPt6SSbMWyInNm3Hkry7XtIb3KVu0B
         TD6w==
X-Forwarded-Encrypted: i=1; AJvYcCUBxpuoAj7VFc5ShHUHdchsK00WQd91XZlg27qGpZXR9hvkFs0xOI4uP0pbeNHvX7nKzhRPJ74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5f9N1ls1/qN7uLAgMyRKbl5IZSNsoRlIBCur5pNZbFQq/rt/O
	YCDCCURrZ529N3kDJ+g9cgpHmpE3xGv0xFgCwyP5NiPsKWXr3YPz
X-Gm-Gg: ASbGncu05cQ9d7VC6q6Yvh7gYhyUzClbR0rmRiD5mRiNyGdqNwdDfHlAiovvlQ+WMIf
	oMLVuD3ZszTjpwh3QaF4h0VX1NIRd/rmOxIyFao5j9zRcrpGNSxD8jICtcYq1kvKb6SY9NOBeE/
	XbZSvF5CWtq/5AaEotdshbSTFCGaZijSKbHoaAuDT+4RF8JNun87HG05yhPRON+jGp3mCnHdVrt
	BPNiEfpiF7aXWh+x9PTF0ZPPojIgpy04lGST294CYpyE6pYXct0fXW7dka/Fy+La+B7lIJFUa8N
	zTOmG8PUCUwi5QR0caSx3PMc3ivfivxClNDY3WKK4dqYqSNkqg00Ow==
X-Google-Smtp-Source: AGHT+IEWl/dzQtDB8tEnoABnbUkYynUMTwx7kv3c9y2hpEh+t3iCo8rtNWpyeIRlAwhePHFK38UYjA==
X-Received: by 2002:a17:903:703:b0:216:31aa:1308 with SMTP id d9443c01a7336-21c355e35c9mr538630815ad.34.1738054053867;
        Tue, 28 Jan 2025 00:47:33 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414e2b8sm75873275ad.205.2025.01.28.00.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 00:47:33 -0800 (PST)
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
Subject: [PATCH bpf-next v7 11/13] net-timestamp: add a new callback in tcp_tx_timestamp()
Date: Tue, 28 Jan 2025 16:46:18 +0800
Message-Id: <20250128084620.57547-12-kerneljasonxing@gmail.com>
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

Introduce the callback to correlate tcp_sendmsg timestamp with other
points, like SND/SW/ACK. We can let bpf trace the beginning of
tcp_sendmsg_locked() and fetch the socket addr, so that in
tcp_tx_timestamp() we can correlate the tskey with the socket addr.
It is accurate since they are under the protect of socket lock.
More details can be found in the selftest.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/uapi/linux/bpf.h       | 7 +++++++
 net/ipv4/tcp.c                 | 1 +
 tools/include/uapi/linux/bpf.h | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 800122a8abe5..accb3b314fff 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7052,6 +7052,13 @@ enum {
 					 * when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_SND_CB,		/* Called when every sendmsg syscall
+					 * is triggered. For TCP, it stays
+					 * in the last send process to
+					 * correlate with tcp_sendmsg timestamp
+					 * with other timestamping callbacks,
+					 * like SND/SW/ACK.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0a41006b10d1..b2f1fd216df1 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -500,6 +500,7 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 		tcb->txstamp_ack_bpf = 1;
 		shinfo->tx_flags |= SKBTX_BPF;
 		shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+		bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TS_SND_CB);
 	}
 }
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 06e68d772989..384502996cdd 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7045,6 +7045,13 @@ enum {
 					 * when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_SND_CB,		/* Called when every sendmsg syscall
+					 * is triggered. For TCP, it stays
+					 * in the last send process to
+					 * correlate with tcp_sendmsg timestamp
+					 * with other timestamping callbacks,
+					 * like SND/SW/ACK.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


