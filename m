Return-Path: <bpf+bounces-73701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4724C37AEA
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7703B4B30
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7965C347BBE;
	Wed,  5 Nov 2025 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ih1BllT5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6EB341677
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373994; cv=none; b=DqPrpVNB2BeaN6l01EaHJx1gfkhrW8wHkTXxGOvnM64MSdi3RmAtODb13iHE1AlMKimlE9sCeMAeAcaj+lXlTW3+b8jbv6XkIBSi6KsiDvMCqYvfK/oPhMPbvR5H21VFs+YrllqVtosJCK+5ZO+mu+CKqSyAHUMuz92B/8dza08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373994; c=relaxed/simple;
	bh=+IZsv8bUzvX+j8yZwjOvjPLG0t53WwZ9DVonja+axmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VjoVBy045pFgA4FjR4rQS+uiDJJ8K9HDMNJW9s5HqgeNRbfsggucdNKspmDlXGHwAkK73XBZEH+hkVyrRmjqJ5dSuTeAgGvFCBNKC1jjfVRloXtrdbLZcZkyXbTlKCzd/4yekTSNnbUJzER836RYT0zaIcxDsAhT9ZK+KcfgoNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Ih1BllT5; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b710601e659so42797866b.1
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 12:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762373992; x=1762978792; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSCMhlQItRnMpGfsZXReXH0rCegBE+8tz6Hg/XHfL5M=;
        b=Ih1BllT5wLEbvT9JxJ14tIJo+8K0vq3+EGL6O5oHwgjgO9U6+U9C/djnOaTauiGVj3
         5WxXT+iEuY/j3ggGY2UBmZG2kN8VJpDXSmQYQ009hF1NURI+dMnbuSdMT2tEY4243twV
         3yfCNUwUakOhnVKcNEbYkwAzeaeLLAVzfoNKtzk5IRe/g7f7Ml0SK5FeQMOyM4glatsj
         OD+ZhkYbRU3ilsneX6SvtHmWyfA2S8uvjuBfAX2VHp8OjslpXlMRZ+3zPLfpNwO6ijJX
         h0AhB584wUDziZhLX9g+JI2O24LHRQeOq9Nnk4ZfR6MxV4tB/wK/16Uir5VOejGNaV4d
         snEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373992; x=1762978792;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSCMhlQItRnMpGfsZXReXH0rCegBE+8tz6Hg/XHfL5M=;
        b=ZMUu7vwktd1DLrs3opWaVhaQ/0l8PSUPRQ6eqtrIqcMA/S2emHDGLFuVSW9lPAtlZj
         Pqvl7KK1xny6kJpY9zwb95Sk3+/u4GZyQcVKFbeRaXgdh60lwI5zoKqglDk5KEbvD2kr
         6VNpR43nf5TspQEG2e0GJ/SoXnS+9j9+JaCZhMD+Z2RYA7RTiUm7h3g7bAB4ZEo5muxs
         aIq2XmwKdB1f3Jmojz1jaPuw6VKBnrn1d+51dRruslZpyvvSqyYWZgnz5UeH9faJbcjY
         X4+qUM+SvpZGxrnVmPKzFe13Po6lYLlJrgr8VJqb2XRppKGvoyDvZmAbyiY5xdAXfMlW
         uAQA==
X-Gm-Message-State: AOJu0Yzo1gC/604HIyPD64xPw+d22d2jbHNKycxjgOmldhnxtWu+26KC
	BmUuq14ln0d9Pu38HObG1SNIjXFz4NDidLo55mPW4UEfQ+78qDMPioJMyuS+iQJPwBE=
X-Gm-Gg: ASbGnct+RNzbDVT9I2e2x9Ldk0GXKO6mCh2Fg0bJiNa9mp79iv4fx0kTSnXvX7wXhfe
	W12Kk4+3NDkfpGnkfNro8ilMFC4qWBvbAwrfdgAgG0YfDmQRNxvy4cRI2QtbhzAbXDhpYRH7vGw
	5w5U04lAAH3OxUbGzex5OX/ntnXxOjv2i5JRLulNJxATTNIvHZWeCmqH2fyY6+UKvCMSE5hA/9Q
	4p4UhieWSAO4JyNmtyLDYhfpDnEu332LODSvz8p0s881dnJeQznEXrg1++VbjUug6ACvYR6FJDY
	Y1DjHnTG2DFcL+xLu2dRtNopkiWmKLCJDsFRwEtT5nvnYp9ZBxucYZ7CyyPxiKpbI8iHEN1y4Rn
	1vMvV/giDb4cKgH1hjAW9TiKoE1T7HNm2f9JEp8SlshFNuJmP3rIqkH4aOO6mrIu29PM/IUgciF
	0tMUGpkoUOF9+jCxNZuGvmCEywoyBu+7empDpv2ebLoM05dg==
X-Google-Smtp-Source: AGHT+IF07Dx5GtpeNwUcjPFYssQmnTuQ66L0fUjFMKdIx+JvJ9KtyYBgJgkLcezItt5mgTrctrPjjw==
X-Received: by 2002:a17:907:72d1:b0:b45:b078:c52d with SMTP id a640c23a62f3a-b72654d737bmr426268666b.35.1762373991556;
        Wed, 05 Nov 2025 12:19:51 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289645397sm45920066b.41.2025.11.05.12.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:19:51 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:38 +0100
Subject: [PATCH bpf-next v4 01/16] net: Helper to move packet data and
 metadata after skb_push/pull
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-1-5ceb08a9b37b@cloudflare.com>
References: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
In-Reply-To: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
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
index a7cc3d1f4fd1..ff90281ddf90 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4564,6 +4564,81 @@ static inline void skb_metadata_clear(struct sk_buff *skb)
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


