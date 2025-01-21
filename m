Return-Path: <bpf+bounces-49325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C629BA175BF
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 02:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A7316AD49
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 01:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE044689;
	Tue, 21 Jan 2025 01:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krG367B/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955295028C;
	Tue, 21 Jan 2025 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737423020; cv=none; b=UBEo2kIS5upaLXqmtfBsKWsDBSKDyoD3kfsxVXJbE/nPsWPdhBVWgFN3namVGXkZouy1zQsKRyjH0ldCX7rpgOeJBNbZgvcWIMq3yAso/M5KKkmsNXVB5LX8ZS48q7ni4Tzqmv4aepqlxn1zBGpezitkJsy6FqHf7CIst1MOx8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737423020; c=relaxed/simple;
	bh=cdAZTukbPBCnDY0N2KiqkxNh942E06ybv5DIcwFSuUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ukf2hs2FvRCWZdW+GOHy63vV9MLeCJtoAW/jP79Q8OxR1PfqnEoLuP7D5EyKGcP5AR6mhRExZfZW/ewXx5Lc0sS1oWijlOjdt6kPMBjKRLRnHMBtz4iPqLeeQWQ31WnDylAZAQNHmp2yzghwfsYqZSia4SX6e429VY6l0EsUJaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krG367B/; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso8670589a91.0;
        Mon, 20 Jan 2025 17:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737423015; x=1738027815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYBgrBe5aOqcvb6kjytL4u8rCsj35g7Iyees/SszcWQ=;
        b=krG367B/VLWOBA1x0yOD3m6jkKaMo1JVZO9Cd4PEzlyI7mOrnh7u77DJsntu3ZxHHw
         ztB9+u5xFmkScZr1dQmlKcIPsg7W5bt43IPDdAqnKPiMfcbUzQR+hp/LMUarWLxAIrHz
         z6UQ+naR80BhJm14TJzPjTDkNX1XJDUenB1JP6mIijc4jG7Jvx6/1la47Kg1UerHSwpN
         EQDHKKVjYjtE64jCbLlliuO1ZZua0b9Yc+uliO9s4upyMYR0E84OojeRfq8p7GGinwhm
         lRzRIxRmrYecrov+w1+NM1Ifil2t5QEKJR4pGEGQ4y74EGNAiL1ffOnaPzST6FwqP4Du
         ddfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737423015; x=1738027815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYBgrBe5aOqcvb6kjytL4u8rCsj35g7Iyees/SszcWQ=;
        b=VjRZGKt9tSLlNH6wmXBXE6kLWlQk8aa3ETEfjz3+tSysZVjYoDCH6rVVpaTejaIIIC
         yL4qnuPDMTb2HMWF6vnKiZjBCbvRmxdgv40FQCEL7qXwm0zBCexIqWMC89FD9jGYhbB0
         i3gT2LX5kkN8izZQ/x8LwZpuxF7zG4wnWsuEWv2puqyH3jUhb+jC5RASPqXafkv/PobF
         WFPURi6O6ORs0DuriXStkb4O/AaUYavnFAT7M8jMxX8QQ1mySSGxaG4EAuEnJGpyTaSp
         JgxjuHmyYzhcv+bSINaeopcb9brrVJT4h6+ICL9v05En9BawtxOOU6HdGVxAwsAfO02d
         5ZvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX60C9BlXYOj5oIvcfe5NHGHuYeA6iz5B9YeN0bHIGsiL5a/xc59pFXtwFGruCMiGybqcV19+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6S5lXDSaPiXwWs4wI7pJ8oX2RGdUB/9MfzvAoPpKTigflLwCP
	mlSxgKcVsl+7OxfwzXh+Y49ryPoZ6d4MApA8BZ7nhqf0gCtdjLGq
X-Gm-Gg: ASbGncvp3TyUOOxUqA+OROIzTR7cVTIDaU5LziqktpwYv9vQqrPoBP7hr14X/TCtW6j
	UUjJI15W5tj/sfBhZ7pMijc4KWQW7C+33vsVphbmsvgejV5bq7Ig1PaecKuunMKGQPD8C9YeRF0
	tlz91BPjPzs2nQWT9p/057qUgJ5J7dsoZoBqnUz1i9wcDre2+Em5zEWSj2qZ/Hil9WIZnSbmcBJ
	tmF1SX5lfX7AvbOR+YJ8URMkh3JgTT6da0INprDYm3WmHbt1kExPpjwBE5PDiTI6LL+6RZ0X/MF
	r7II2OIYdJowosRUFNqP8CG9AhJRx8A+
X-Google-Smtp-Source: AGHT+IGaGM7CIz3m0+e10Vs8zgk6GkS1V9XYzHPFC6/ENy7zmTtxpvXyVwc8+hGexLXiybIQHDfNBw==
X-Received: by 2002:a05:6a00:369a:b0:726:f7c9:7b28 with SMTP id d2e1a72fcca58-72daf9bec24mr25714114b3a.8.1737423014602;
        Mon, 20 Jan 2025 17:30:14 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba55c13sm7702059b3a.129.2025.01.20.17.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 17:30:14 -0800 (PST)
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
Subject: [RFC PATCH net-next v6 11/13] net-timestamp: add a new callback in tcp_tx_timestamp()
Date: Tue, 21 Jan 2025 09:28:59 +0800
Message-Id: <20250121012901.87763-12-kerneljasonxing@gmail.com>
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

Introduce the callback to correlate tcp_sendmsg timestamp with other
three points (SND/SW/ACK). We can let bpf trace the beginning of
tcp_sendmsg_locked() and fetch the socket addr, so that in
tcp_tx_timestamp() we can correlate the tskey with the socket addr.
It is accurate since they are under the protect of socket lock.
More details can be found in the selftest.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/uapi/linux/bpf.h       | 3 +++
 net/ipv4/tcp.c                 | 1 +
 tools/include/uapi/linux/bpf.h | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3b9bfc88345c..55c74fa18163 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7042,6 +7042,9 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_TCP_SND_CB,	/* Called when every tcp_sendmsg
+					 * syscall is triggered
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0a41006b10d1..49e489c346ea 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -500,6 +500,7 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 		tcb->txstamp_ack_bpf = 1;
 		shinfo->tx_flags |= SKBTX_BPF;
 		shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+		bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TS_TCP_SND_CB);
 	}
 }
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b463aa9c27da..38fc04a7ac20 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7035,6 +7035,9 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_TCP_SND_CB,	/* Called when every tcp_sendmsg
+					 * syscall is triggered
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


