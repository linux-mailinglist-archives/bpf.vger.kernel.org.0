Return-Path: <bpf+bounces-51494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B6DA35359
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 02:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3001890714
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330B61EB3E;
	Fri, 14 Feb 2025 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlXBNi+x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFB5CA64;
	Fri, 14 Feb 2025 01:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739494860; cv=none; b=rb8ianNOcBcCRajeQ2tIXPjT/UhDextVqXuB4kREzsfplmz86rmmt4TeyzM4/2bDEhP5sR+JyfCddWsb+ZjGaFSVV9Hn8833v10tJsbD/ogpPvO1wqNnz2ZMMzK5r1Azff/439VQdJbxZ0muwtdo90GBrH0oJR5/pDvd2aPSCDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739494860; c=relaxed/simple;
	bh=xKbudb0FUrth0r9fVulR0YQSW9YlrDYUxAjIB9W3r94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FbhQp0s937KFm13xnPGJFozlEOhExw5huPgAOzMk+dLRRQXQMuGNo29fuH4D62HqGilOVT+NJE96Nu8mVQlWU2vk1ISQFiYmQkygptw+HfxalTXVDfel3kmhbAMQtlmWgSZQrNRFkDHLxeCBXWqA3ZSzfEly7I6Pp/Fe6xlnw9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlXBNi+x; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f48ebaadfso30440745ad.2;
        Thu, 13 Feb 2025 17:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739494858; x=1740099658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCClYBX4dv1juFzLnShvLFoS82zgt+5gs+BbDuAzfbU=;
        b=IlXBNi+x1zTqvEsL9BbQmbiC2H5eS5KMrEAXeHEtIcap29tgiPLE8mqLbBhMs6LMWK
         LO7LbPzrNUCxVXQxi0Hb39jawlcAd6I8uQy2uNX/01vHE5Snzi8lHIy8trh9xUxVAP6Z
         HbsQlFT7N8VnuV4dSDtdsxHjGqxbpXRuJF/Hajt11GgbKrmwwg22FAg5oRJMBuSmKzPY
         NlfbrlbkQJcccc0qQF2HT4EfzImLe2897wplkkWTntJHY34fXsYDjPAKMKgQdilWv5A+
         e1bMKtxC8QNxSOI6WT3IBXgqDf1mNO/lHP1QxV8NWqaLJkGzNor5vja1VXjhpXxQHmWw
         OAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739494858; x=1740099658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCClYBX4dv1juFzLnShvLFoS82zgt+5gs+BbDuAzfbU=;
        b=qweyYz31IUc8dIwkbBtClaANFJr1jcgELnE4Wa9jIL/S915yLpt4yn7zj1FedjaXQh
         t7IylFDGnUNGPFe6InBBcB/RXK1wYteUWNFkvYg/45Izr8qQ+UcEOenszMtOJyprVuFB
         hS/oc0d2alImj+5QG91xPT4NwVZLgtt7o0jynLWebkgo0JGA0oPv3O2d7f5bIr9Yz9ur
         zdfdnuxakA4ijn2WqTdNXC4ij0xUILcpv4B3F7ochCw0Vw3XI3xHWhTgFHuml8LTOh5q
         yUEtWaLcGB3NUy5CKGh+pbEmJgADMAhydNS1OuA2GT11IDMyqtvy5KIk1FqiXHBExMZo
         g4+w==
X-Forwarded-Encrypted: i=1; AJvYcCVLJYMaiQ+dA+8Sfqrj7ZVz4v2NEXmUo/qNxso+qcD2d2YFlIjLBrx6ZRywkPXSd245w+Vmz7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEGSfe8YroM4xJE5q/4hGvHpEfpafF03eTCEJ9bC0ojlOQr5eP
	INUOwzdVBehJWXsziD2INTiqSUo0MX/ewcO1Djjh6avNcyGdVqw5
X-Gm-Gg: ASbGncv6YdE2MVUZO1Sh9vq5nZUwqi+PIIy8WEIusrxN90dzFrP8X57uylYX+Dm0yNQ
	rw3PUs6epkJiXqhaB3XjqKYDnatIkJ9qW1gZrFcLSsXJWcu41o6BVzd1qvyoCeGad+ydNpuYpLE
	0QlOcijHYnzMKmM3HMg89wGh1Q6oSc1QTb2tMkSZFbaCnUiIXdVz1aJmFHnNnNOZ4rd01qZc5bG
	M2LElWYkJJYA0CZS8wSoicqHadbYmKXjl7OOU+2g6/ThAxcBPQL/zsUEoBl8FNnkIMy5pjCACs7
	xlmbyzKQpEchIFxCU7bZ+CJzMLLxHL40JkrdqRP0u2QRIr60ntq4kQ==
X-Google-Smtp-Source: AGHT+IEmS11KJO6MagPx5ppvE64ZxX7FB3Nz/gEwyW1xlu+HMmuy1LexlAi7TmmBzp+4x8x7KT0lAw==
X-Received: by 2002:a17:902:d502:b0:206:9a3f:15e5 with SMTP id d9443c01a7336-220bbc67fbemr159852775ad.32.1739494858580;
        Thu, 13 Feb 2025 17:00:58 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534db68sm18629565ad.39.2025.02.13.17.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 17:00:58 -0800 (PST)
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
Subject: [PATCH bpf-next v11 02/12] bpf: prepare the sock_ops ctx and call bpf prog for TX timestamping
Date: Fri, 14 Feb 2025 09:00:28 +0800
Message-Id: <20250214010038.54131-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250214010038.54131-1-kerneljasonxing@gmail.com>
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a new bpf_skops_tx_timestamping() function
that prepares the "struct bpf_sock_ops" ctx and then executes the
sockops BPF program.

The subsequent patch will utilize bpf_skops_tx_timestamping() at
the existing TX timestamping kernel callbacks (__sk_tstamp_tx
specifically) to call the sockops BPF program. Later, four callback
points to report information to user space based on this patch will
be introduced.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/net/sock.h |  7 +++++++
 net/core/sock.c    | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 7916982343c6..6f4d54faba92 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2923,6 +2923,13 @@ int sock_set_timestamping(struct sock *sk, int optname,
 			  struct so_timestamping timestamping);
 
 void sock_enable_timestamps(struct sock *sk);
+#if defined(CONFIG_CGROUP_BPF)
+void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op);
+#else
+static inline void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
+{
+}
+#endif
 void sock_no_linger(struct sock *sk);
 void sock_set_keepalive(struct sock *sk);
 void sock_set_priority(struct sock *sk, u32 priority);
diff --git a/net/core/sock.c b/net/core/sock.c
index eae2ae70a2e0..bde45569d4da 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -948,6 +948,20 @@ int sock_set_timestamping(struct sock *sk, int optname,
 	return 0;
 }
 
+#if defined(CONFIG_CGROUP_BPF)
+void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op)
+{
+	struct bpf_sock_ops_kern sock_ops;
+
+	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
+	sock_ops.op = op;
+	sock_ops.is_fullsock = 1;
+	sock_ops.sk = sk;
+	bpf_skops_init_skb(&sock_ops, skb, 0);
+	__cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
+}
+#endif
+
 void sock_set_keepalive(struct sock *sk)
 {
 	lock_sock(sk);
-- 
2.43.5


