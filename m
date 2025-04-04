Return-Path: <bpf+bounces-55330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6899A7BF24
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 16:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA49F3B84A2
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1441F3FD0;
	Fri,  4 Apr 2025 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBxuu+I5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E877F1A238C;
	Fri,  4 Apr 2025 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743776800; cv=none; b=al/u2ybx6J/YrKymehWUtxnRO2uLmVr9s/shywvLvAc2IEBZeqLZYf55gprI4XuLxgSQoqRlXH1Mip2+OcjUC8pf4bmSm592fDeGEVdoRiQS7MYY3inOMwYqNRXb+J0STtVtUlgQuXY8fxN13ggXbtu3Mt9mkLkvJlu11Lnhyvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743776800; c=relaxed/simple;
	bh=nA1Lj0K3661YDK/rSNsChbOUDHRF9dxkodyz+HYKgEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bS7D/ozoNBfDicVkBvKrORcbv14gLW2WZ0VgXiI9uaVW+f9I7mAchrl9qWfwpdQDzoTlGxd9vl+YXxS5Y5U+5Irqw4pfWUZOJfxOL3S+fN6HQGn3YF2OLMuuoImQSTEgp01SbDqdrmJnVU8mYJoOx5OC80jBW4Ewfk1EpIgDWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBxuu+I5; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8ec399427so17118656d6.2;
        Fri, 04 Apr 2025 07:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743776798; x=1744381598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eWLT0YIRG2U1O3xgWZmy1VeZXYdcE2zcdet3pp4P0k=;
        b=aBxuu+I5blDoR2DXr1fqua+nIWj7gQ31chpb+cpN2blzmApVH9PCwUWoq/z+f87Jv4
         F7drxUGIcy5MqsgnVmkLTx+BD8kRSwP+hERnv8+pg6L9EfvkGxrHX/IgSDXBNZQ/nn1e
         0vDS4nOSs7CEECYxU7+8v55GD8ArOZbP//3aFr12O2VlKT1EH7tBXQqyOvrBIEQRszU6
         hfiOemgEoEcNgLeA+aLI54/euq5KKJ9NoHE1fZ2tXklHWUhHubEpWiP68j15FejlW/HL
         3QXE5xXd3fYI4h1bWiDD8EGlRm3HxEudieubhuTod5NFdwS7xfYtWi16rwStD+dblVwK
         RxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743776798; x=1744381598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eWLT0YIRG2U1O3xgWZmy1VeZXYdcE2zcdet3pp4P0k=;
        b=eWODh3yr8GG/7j0dZldtiHqcviF/A4Tc0HPpIM2dg3b1vAd+lS7nunhD+NICKxBfOM
         Pgv4LdCRNJdcJSx1+4Yxk4XrR00wv9fF7PmLORVQLalIAGykt5v0ZNb36BaHmN244eyN
         TP6xWncyeVDLFEV3DrQuW8YqMB715P2RAUeGQO6XQ43i4Zk9H3k7wx6wVs4CW/4j92+f
         MbZU1MeMyCh5XiEutnA7qrQLTF9IQn0u+0Vjg2pO+DJt7LZWiGI5msCRoRLIoMp8pEip
         dnCcMqGtRWzX6D7dHovpcX2uMjTMSoFm32SQKa5EY46hggE4XJOxHo3Ypz5e8vGcfED9
         hLTw==
X-Gm-Message-State: AOJu0Yw8/A86AvJgNyNx6OF7xbmKwuxoUphndB7iknAgGIOmFinywKO/
	P9r5kBNBT6Fjvh1f/QbQKYs0rz9NJzQlgg5dGAYAkQ7USQWAEq695BnSLg==
X-Gm-Gg: ASbGncvQ0ard1kwnkBEZ34r+WVxpuyjP/XqqAlUAhvLY5OgUILl1JGCiAdF0wjpVB9d
	Fnfn62msabkMwn1gieHJO3ToM+Y3w/jojBQCUznrcSHLAijyjc4yA7Q3eHtviNr/TCTDxE1TmRh
	dPPA0WYd/ehuFbgKcfpzNvqmBflSJx+DKEImuSEbVV1fMaiKUS0GgpMc+x1y/lZjigUCHvste2k
	EMGs9oi0J5L58Aw5408W/Lqhl8+FZT6sgCugfgCYHgWr9y3YMMWc/Aks3Yhzmd7U4r2rAHauDON
	+33a45hMSDs2BoTl6zYj4TdOQSxQqRN/Xs/hCzMoGGGhbqn/apNsiYrJVcG2Sqh4EzZqM7b5Fpy
	/xTkogitxUmIFq8lqTqbNZB88i0bvpwnnmljLPqVBFHZF
X-Google-Smtp-Source: AGHT+IEP4G7QHx8NJBQHlpT36hEnAs5TI/YoPD9vgM66XFnZvMZWKWxgOz1NXwIFxPtqTpZXZPiZrA==
X-Received: by 2002:a05:6214:f27:b0:6e6:684f:7f6f with SMTP id 6a1803df08f44-6f00de7fcb5mr61176166d6.7.1743776797656;
        Fri, 04 Apr 2025 07:26:37 -0700 (PDT)
Received: from willemb.c.googlers.com.com (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0efc060asm22043466d6.1.2025.04.04.07.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 07:26:37 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	Willem de Bruijn <willemb@google.com>,
	Matt Moeller <moeller.matt@gmail.com>,
	=?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
Subject: [PATCH bpf v2 1/2] bpf: support SKF_NET_OFF and SKF_LL_OFF on skb frags
Date: Fri,  4 Apr 2025 10:23:39 -0400
Message-ID: <20250404142633.1955847-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
In-Reply-To: <20250404142633.1955847-1-willemdebruijn.kernel@gmail.com>
References: <20250404142633.1955847-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Classic BPF socket filters with SKB_NET_OFF and SKB_LL_OFF fail to
read when these offsets extend into frags.

This has been observed with iwlwifi and reproduced with tun with
IFF_NAPI_FRAGS. The below straightforward socket filter on UDP port,
applied to a RAW socket, will silently miss matching packets.

    const int offset_proto = offsetof(struct ip6_hdr, ip6_nxt);
    const int offset_dport = sizeof(struct ip6_hdr) + offsetof(struct udphdr, dest);
    struct sock_filter filter_code[] = {
            BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_AD_OFF + SKF_AD_PKTTYPE),
            BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, PACKET_HOST, 0, 4),
            BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_NET_OFF + offset_proto),
            BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_UDP, 0, 2),
            BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, SKF_NET_OFF + offset_dport),

This is unexpected behavior. Socket filter programs should be
consistent regardless of environment. Silent misses are
particularly concerning as hard to detect.

Use skb_copy_bits for offsets outside linear, same as done for
non-SKF_(LL|NET) offsets.

Offset is always positive after subtracting the reference threshold
SKB_(LL|NET)_OFF, so is always >= skb_(mac|network)_offset. The sum of
the two is an offset against skb->data, and may be negative, but it
cannot point before skb->head, as skb_(mac|network)_offset would too.

This appears to go back to when frag support was introduced to
sk_run_filter in linux-2.4.4, before the introduction of git.

The amount of code change and 8/16/32 bit duplication are unfortunate.
But any attempt I made to be smarter saved very few LoC while
complicating the code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/netdev/20250122200402.3461154-1-maze@google.com/
Link: https://elixir.bootlin.com/linux/2.4.4/source/net/core/filter.c#L244
Reported-by: Matt Moeller <moeller.matt@gmail.com>
Co-developed-by: Maciej Żenczykowski <maze@google.com>
Signed-off-by: Maciej Żenczykowski <maze@google.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

v1->v2
  - introduce bfp_skb_load_helper_convert_offset to avoid open coding
---
 include/linux/filter.h |  3 --
 kernel/bpf/core.c      | 21 -----------
 net/core/filter.c      | 80 +++++++++++++++++++++++-------------------
 3 files changed, 44 insertions(+), 60 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5cf4d35d83e..708ac7e0cd36 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1496,9 +1496,6 @@ static inline u16 bpf_anc_helper(const struct sock_filter *ftest)
 	}
 }
 
-void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb,
-					   int k, unsigned int size);
-
 static inline int bpf_tell_extensions(void)
 {
 	return SKF_AD_MAX;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ba6b6118cf50..0e836b5ac9a0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -68,27 +68,6 @@
 struct bpf_mem_alloc bpf_global_ma;
 bool bpf_global_ma_set;
 
-/* No hurry in this branch
- *
- * Exported for the bpf jit load helper.
- */
-void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb, int k, unsigned int size)
-{
-	u8 *ptr = NULL;
-
-	if (k >= SKF_NET_OFF) {
-		ptr = skb_network_header(skb) + k - SKF_NET_OFF;
-	} else if (k >= SKF_LL_OFF) {
-		if (unlikely(!skb_mac_header_was_set(skb)))
-			return NULL;
-		ptr = skb_mac_header(skb) + k - SKF_LL_OFF;
-	}
-	if (ptr >= skb->head && ptr + size <= skb_tail_pointer(skb))
-		return ptr;
-
-	return NULL;
-}
-
 /* tell bpf programs that include vmlinux.h kernel's PAGE_SIZE */
 enum page_size_enum {
 	__PAGE_SIZE = PAGE_SIZE
diff --git a/net/core/filter.c b/net/core/filter.c
index bc6828761a47..79cab4d78dc3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -218,24 +218,36 @@ BPF_CALL_3(bpf_skb_get_nlattr_nest, struct sk_buff *, skb, u32, a, u32, x)
 	return 0;
 }
 
+static int bpf_skb_load_helper_convert_offset(const struct sk_buff *skb, int offset)
+{
+	if (likely(offset >= 0))
+		return offset;
+
+	if (offset >= SKF_NET_OFF)
+		return offset - SKF_NET_OFF + skb_network_offset(skb);
+
+	if (offset >= SKF_LL_OFF && skb_mac_header_was_set(skb))
+		return offset - SKF_LL_OFF + skb_mac_offset(skb);
+
+	return INT_MIN;
+}
+
 BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	u8 tmp, *ptr;
+	u8 tmp;
 	const int len = sizeof(tmp);
 
-	if (offset >= 0) {
-		if (headlen - offset >= len)
-			return *(u8 *)(data + offset);
-		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
-			return tmp;
-	} else {
-		ptr = bpf_internal_load_pointer_neg_helper(skb, offset, len);
-		if (likely(ptr))
-			return *(u8 *)ptr;
-	}
+	offset = bpf_skb_load_helper_convert_offset(skb, offset);
+	if (offset == INT_MIN)
+		return -EFAULT;
 
-	return -EFAULT;
+	if (headlen - offset >= len)
+		return *(u8 *)(data + offset);
+	if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
+		return tmp;
+	else
+		return -EFAULT;
 }
 
 BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
@@ -248,21 +260,19 @@ BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
 BPF_CALL_4(bpf_skb_load_helper_16, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	__be16 tmp, *ptr;
+	__be16 tmp;
 	const int len = sizeof(tmp);
 
-	if (offset >= 0) {
-		if (headlen - offset >= len)
-			return get_unaligned_be16(data + offset);
-		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
-			return be16_to_cpu(tmp);
-	} else {
-		ptr = bpf_internal_load_pointer_neg_helper(skb, offset, len);
-		if (likely(ptr))
-			return get_unaligned_be16(ptr);
-	}
+	offset = bpf_skb_load_helper_convert_offset(skb, offset);
+	if (offset == INT_MIN)
+		return -EFAULT;
 
-	return -EFAULT;
+	if (headlen - offset >= len)
+		return get_unaligned_be16(data + offset);
+	if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
+		return be16_to_cpu(tmp);
+	else
+		return -EFAULT;
 }
 
 BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, skb,
@@ -275,21 +285,19 @@ BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, skb,
 BPF_CALL_4(bpf_skb_load_helper_32, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	__be32 tmp, *ptr;
+	__be32 tmp;
 	const int len = sizeof(tmp);
 
-	if (likely(offset >= 0)) {
-		if (headlen - offset >= len)
-			return get_unaligned_be32(data + offset);
-		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
-			return be32_to_cpu(tmp);
-	} else {
-		ptr = bpf_internal_load_pointer_neg_helper(skb, offset, len);
-		if (likely(ptr))
-			return get_unaligned_be32(ptr);
-	}
+	offset = bpf_skb_load_helper_convert_offset(skb, offset);
+	if (offset == INT_MIN)
+		return -EFAULT;
 
-	return -EFAULT;
+	if (headlen - offset >= len)
+		return get_unaligned_be32(data + offset);
+	if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
+		return be32_to_cpu(tmp);
+	else
+		return -EFAULT;
 }
 
 BPF_CALL_2(bpf_skb_load_helper_32_no_cache, const struct sk_buff *, skb,
-- 
2.49.0.504.g3bcea36a83-goog


