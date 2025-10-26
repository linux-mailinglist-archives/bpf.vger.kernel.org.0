Return-Path: <bpf+bounces-72232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98147C0A940
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 15:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DA454E0F23
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 14:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1004253F1D;
	Sun, 26 Oct 2025 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="S0bWq4I2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ADA225A3B
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488321; cv=none; b=Z+RPE9tBbeeXBEamaNXw48C06YEAjOjqBr3/fNwtbijb+mZI9r4hvUUkqohIUaC8qrvk6Q76WUFFsDIvY/4Tf4UfJFgKJdR5buMH3s9X1BMx/POH3tBx6sp5OjJEBjCy+zTH7SmymIx/REJ0mwtJQMFUuD0EIvqtvf3wl8NkUpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488321; c=relaxed/simple;
	bh=puwuN/Wm+9ws2J5jMOulWH7buNQWkmoJAGMjHTjmyqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eu5KujGBP3Eq7B6FIxNyp0is3nYWPD2dVYHKZtlB4mCo5CgK6fPeMRIbtNTLPFBDSFLkbq22NICSm2joVgLbq3Xjx+VMgr1xzU7aI2H3U+e0iNvyDXoXRFjM2OnZy6ZziQKxIMcMTwzUDKrjvEqzO5yGwD28X9U+hgm+ddWTbYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=S0bWq4I2; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c11011e01so5709220a12.2
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 07:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488318; x=1762093118; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZS2m9PH1jf2Rl9p44A60lnBh0lHTg8/bjjESom0sKvQ=;
        b=S0bWq4I20A8r6FZ+luv3NUcnLL3JOpHzw+ZNeuZTUiPfg/9H3grs6jLxTCmtGXHr+S
         yGIJR5DrJWtcwUwE/B/3PhHYuZvYiHY5UqQrOciphx0ZRgGdoRK1+De+/xqdkd1c3mZj
         b1tYhscLrRCVGukgk9UH5NhaUGkF1oNJqpUWWYVm28ASlUJwVGR2HbkQf675xqvjbCk9
         +7Ewfm92pUn4HTOrRkQz+5KfSn0fsq94AzNsizzoVgvuiAeFp7uyM54ODm00Pz8KEcrz
         6dTpC6mpINTQgSDp8vmLWbygBkwj5toPZ//2WM0uI0HhcMRp3jk4NQhaGY3tdt/dFkUu
         p6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488318; x=1762093118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZS2m9PH1jf2Rl9p44A60lnBh0lHTg8/bjjESom0sKvQ=;
        b=oij3iYInURa4Wofg9XIoW+KJaiF4zN3wzo41R9sSRVtQvq7mwf+osiEfT+0FaqH2C9
         3qqVmp6cCGbI9dH4jilbW7cTrt3ptOsiJ0r6doanqf8c5y6cWXOXNtwnbpprnPNIyezU
         DzRFt+ttreJ/ArlYT0fZjrXe51RI3ffSbnssp7Cb3u+tRHYkHQKWOhzhXztyLfZqd/NN
         4gIk+NtZ+iIqrP4ihDP1Ppmn9yl+4uKFu2XZGx2RbImP8CqINBYBwxqyfAXamWmi0Kuy
         uH8Y7UDRtMQwUyjgkXemT1nu6vv0ApJJUcCqPRPxCLzZsRLnKQt3bouFvP7UiacYui4M
         FFWA==
X-Gm-Message-State: AOJu0YwAMHcQ7IFfDKLmGVMAQDfUNHHkYRfO/snxemSJ2Ckk5YhDqbib
	E9O0jVwJl5hHJ8LSQQK0zaoRrzv3v51J2IjEy3Y7TLMfMdqzqXLkjKQPohKcKKYrkl8=
X-Gm-Gg: ASbGncu4HfQ5mmXNNxC1YL/pN9TiIM5SjuAQ9RhEovNFgTpUj15JnYFGCOnUXfXPA1v
	gGaIgMDbYKS8/pZRMYH9DDjLg4Vs1mF5oOgTlhB4OKDSpCZq56pWMC9cAdMX6yPp3WQxxxNOs8I
	JmL96ewfF4IWbvXSFoejZWd3/aI0ybLVKKLarMGH+wwvMOX3b608yVEhQAy9SCETRmEcK+s4w8A
	wvf9PcGB5Hui/uNQWD2XA5xOL9T8kL7nISCCrFnsKFAPordydAD7qscTqEJ+ueH1DlG+uPJavyn
	f6NmTAhcJDC+9RnSU0w4mjiO8v5JUWJumgMYsmEFRDiz7RbtlCpczCqim5dUOTwf0rr59FwZZZl
	WKQvu8MW4XDs7W0SR+22Ix2ZSijfVt4C+MMuULnM/EsE/rvvmnbZV/WYq2mzTVQIMG4MfYDcLI9
	fdqYzvSmtOskj0CpLmfwiGRVtq4tmcGla4DaTF2w15AkcC/NmWsq9guN3uKdBmHLP0eGU=
X-Google-Smtp-Source: AGHT+IFMz9VMb3f7c2S9sB6lTjdewN9JnYdRFWbluXFMOjMfaaAFF5t6nqYbCsokgBVSZfwUomLvLQ==
X-Received: by 2002:a05:6402:350b:b0:63e:405d:579c with SMTP id 4fb4d7f45d1cf-63e405d57c9mr11074815a12.29.1761488318072;
        Sun, 26 Oct 2025 07:18:38 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef6c061sm4172035a12.0.2025.10.26.07.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:37 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:21 +0100
Subject: [PATCH bpf-next v3 01/16] net: Helper to move packet data and
 metadata after skb_push/pull
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-1-37cceebb95d3@cloudflare.com>
References: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
In-Reply-To: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Lay groundwork for fixing BPF helpers available to TC(X) programs.

When skb_push() or skb_pull() is called in a TC(X) ingress BPF program, the
skb metadata must be kept in front of the MAC header. Otherwise, BPF
programs using the __sk_buff->data_meta pseudo-pointer lose access to it.

Introduce a helper that moves both metadata and a specified number of
packet data bytes together, suitable as a drop-in replacement for
memmove().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skbuff.h | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index fb3fec9affaa..41365de55e69 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4561,6 +4561,81 @@ static inline void skb_metadata_clear(struct sk_buff *skb)
 	skb_metadata_set(skb, 0);
 }
 
+/**
+ * skb_data_move - Move packet data and metadata after skb_push() or skb_pull().
+ * @skb: packet to operate on
+ * @len: number of bytes pushed or pulled from &sk_buff->data
+ * @n: number of bytes to memmove() from pre-push/pull &sk_buff->data
+ *
+ * Moves @n bytes of packet data, can be zero, and all bytes of skb metadata.
+ *
+ * Assumes metadata is located immediately before &sk_buff->data prior to the
+ * push/pull, and that sufficient headroom exists to hold it after an
+ * skb_push(). Otherwise, metadata is cleared and a one-time warning is issued.
+ *
+ * Prefer skb_postpull_data_move() or skb_postpush_data_move() to calling this
+ * helper directly.
+ */
+static inline void skb_data_move(struct sk_buff *skb, const int len,
+				 const unsigned int n)
+{
+	const u8 meta_len = skb_metadata_len(skb);
+	u8 *meta, *meta_end;
+
+	if (!len || (!n && !meta_len))
+		return;
+
+	if (!meta_len)
+		goto no_metadata;
+
+	meta_end = skb_metadata_end(skb);
+	meta = meta_end - meta_len;
+
+	if (WARN_ON_ONCE(meta_end + len != skb->data ||
+			 meta_len > skb_headroom(skb))) {
+		skb_metadata_clear(skb);
+		goto no_metadata;
+	}
+
+	memmove(meta + len, meta, meta_len + n);
+	return;
+
+no_metadata:
+	memmove(skb->data, skb->data - len, n);
+}
+
+/**
+ * skb_postpull_data_move - Move packet data and metadata after skb_pull().
+ * @skb: packet to operate on
+ * @len: number of bytes pulled from &sk_buff->data
+ * @n: number of bytes to memmove() from pre-pull &sk_buff->data
+ *
+ * See skb_data_move() for details.
+ */
+static inline void skb_postpull_data_move(struct sk_buff *skb,
+					  const unsigned int len,
+					  const unsigned int n)
+{
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+	skb_data_move(skb, len, n);
+}
+
+/**
+ * skb_postpush_data_move - Move packet data and metadata after skb_push().
+ * @skb: packet to operate on
+ * @len: number of bytes pushed onto &sk_buff->data
+ * @n: number of bytes to memmove() from pre-push &sk_buff->data
+ *
+ * See skb_data_move() for details.
+ */
+static inline void skb_postpush_data_move(struct sk_buff *skb,
+					  const unsigned int len,
+					  const unsigned int n)
+{
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+	skb_data_move(skb, -len, n);
+}
+
 struct sk_buff *skb_clone_sk(struct sk_buff *skb);
 
 #ifdef CONFIG_NETWORK_PHY_TIMESTAMPING

-- 
2.43.0


