Return-Path: <bpf+bounces-55455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12120A80C83
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 15:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF61188054D
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 13:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCB0194AEC;
	Tue,  8 Apr 2025 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXSm3Gsi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DB582899;
	Tue,  8 Apr 2025 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118920; cv=none; b=CaQPWbqNSbgq36UmE6DKRxOwQRth9WmIx/MpbjQTte5/0jtw2WEbg6p2TN1xf4QrL+xTT6YYWaqofoCgmxGt4uuLUXBlFuyRkNW7xP2gBwFRTQy5+r/Ju24rQ7CGrzKPA1IKHHZ+ektaVZZnxdsQTCbEaBXDN+4fGKHrdanE0T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118920; c=relaxed/simple;
	bh=8IOpFcr4VrXQIlFN7chTHk3vem2Fs+EjAF+7ucQzU/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kK3BiQI3ElWPR+TzUzQ838ug1WtiVfWkVb9tH8+T2X+tzTumbGAmHqCtz/0Q6Olz2f8HB3ilMc7KF003CM1SEVaXEGmL81apY4m7oG9d+el9+zJfvY51NcmPK3bYRFnerH8UJhWHhLgdvx3ASGjHOO44u4cphyuxBHC7H/QdWLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXSm3Gsi; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476b4c9faa2so64608681cf.3;
        Tue, 08 Apr 2025 06:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744118918; x=1744723718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWs35VskZnxc3MIS4BJnLGHBbictJFvwDyNgSC+LeGM=;
        b=CXSm3GsiZPkxmGEbv+Q6Xxzo66G0EL4GBIn9dTk/YZdS3ELtuS2bAndqkCLtyTdEV5
         V+DmzlTpJzein6docnIN+5yS3+wM+1I7ECn+yI3EPY1viETvAiVmywB3SUtGgUNbZFru
         17WQHWB95XWqC0paKOfZLH/xd29+hgismkTYCUaAO90X+JCT9TKU0g/iFdx/U5k68izt
         TS+hAy64ER2+GeL/QvRpY+RAssfHKqha8wexZY39R4z5BwJcYq1NaaXOlH/TQhRDFbEZ
         /3EYw59lxmqezOXjW/jFHNzT+etWRCe29uEU0zO0yBup25po6vUDBOX3tLC19qMLYAGM
         KGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744118918; x=1744723718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWs35VskZnxc3MIS4BJnLGHBbictJFvwDyNgSC+LeGM=;
        b=snRBqIFDvKX6MkGOrKv5fCRa7rquFrQy5bzNK7fMCHr9imYpL2BvsC/qiVdK5+Z+jz
         6C4o/aH/jttemGbw7qDRwVHDwgLO29WTKsrRFpEhkleMecLPduJZzIGbquVLAnghvch9
         lpJ+e+0LDwURE9cigcsIzrm6cpTrrxKVALOUT1ZZr+cVk+/WWcMtugW1faZCH7k1kArR
         M7sCPgAl9+H7kJT9Y6/LMWHFypZ/tYG4bQYTXIdigwtVf7fC6eoCFF7g/YV44XuJgTMr
         PPVDe+iU5z+8fhXwURrbVBm7oiKMqyVPn5mbJFx3rydelmiaxEQN4ld8tsVIUUbBJRet
         IlBQ==
X-Gm-Message-State: AOJu0YzRf2jKcgOggePw0qqqpMDunq4dfl5Lb56nLjQKF7dP9QwaKHqr
	wME9pIZWhx/K+q+YtN1Nr5KdcZTjdHUZFN5y0GS4pSEwdSFcimLeKFbPRQ==
X-Gm-Gg: ASbGnctzvUFJoO3no2QBirUjBf4iUqG61oypkx3xU7IjCLVhRIHBCCUSYU1MZ8MIFkV
	7wGsF3jpfQ31rK3Y6py4IgeSiet08ONwfKo8MkkWkPDbECepmlkLS2SUS6vyGubg9nuqtyTXc9X
	jkRj0WEHyMfBIHhZ9hlirLYwNQ5a+jQnSE8hBijJPx5Lk7B1N4UMDnG74IEJWdAu6h6GUu0np1g
	9qGRbRpaXdmw6bF3azpYM31Uz1Ql822fj14fejsH6zVsE8gOv/cYXufqjD+sgSMDmj1aWQNkrZI
	b7dzgAZrNk6kbBeqtsEPTe5LqDYaxXl884ThA4R0VCW3oxlnhBYfg+2JlSb5z9933A3AZiRZqr3
	pkbZ0QivYXwNX86ua8MabooN4j6KjmHG41rRNwH66/3Th
X-Google-Smtp-Source: AGHT+IGhxB38yzXAmWgYYNahCYIqPIfYfpHyFPqK85Yj0uTsZKYemwdfBmdD3wy+TpYxDXPeHXzdGA==
X-Received: by 2002:ac8:7e87:0:b0:476:9f3e:1806 with SMTP id d75a77b69052e-47925a75b91mr289476771cf.46.1744118917761;
        Tue, 08 Apr 2025 06:28:37 -0700 (PDT)
Received: from willemb.c.googlers.com.com (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b07125asm77413551cf.20.2025.04.08.06.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 06:28:37 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	Willem de Bruijn <willemb@google.com>,
	Matt Moeller <moeller.matt@gmail.com>,
	=?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
Subject: [PATCH bpf v3 1/2] bpf: support SKF_NET_OFF and SKF_LL_OFF on skb frags
Date: Tue,  8 Apr 2025 09:27:48 -0400
Message-ID: <20250408132833.195491-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
In-Reply-To: <20250408132833.195491-1-willemdebruijn.kernel@gmail.com>
References: <20250408132833.195491-1-willemdebruijn.kernel@gmail.com>
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

v2->v3
  - do not remove bpf_internal_load_pointer_neg_helper, because it is
    still used in the sparc32 JIT
v1->v2
  - introduce bfp_skb_load_helper_convert_offset to avoid open coding
---
 net/core/filter.c | 80 ++++++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 36 deletions(-)

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


