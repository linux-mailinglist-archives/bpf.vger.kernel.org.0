Return-Path: <bpf+bounces-55226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C35A7A4C8
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 16:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07C5176AB5
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 14:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7DE24F5B5;
	Thu,  3 Apr 2025 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+2OzKEm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AFA1F7904;
	Thu,  3 Apr 2025 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689334; cv=none; b=g9U+2uUTswXw1Me81aUQrPiOALtspeshLDmZxIBmqX3Wl3QEz0eDCFrrmH5Nt707JJGArxv+11RlwK/J/O1nuXR6cWbtfkCxsushxp7yJ7fk/cZeFm+Y7Y9NWKrM2L1okpLYw0nvMc9F7ZV/1jhA7OsbbDy/7z/2rTdIBwgD1g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689334; c=relaxed/simple;
	bh=T/U4FfUjXc11pB4SVp6kzwMcW/hzben4xS9LGpx7vog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6RcyPF2mOs2DYRlCuc+4yHRex3AxyCZ6CiNPBSmNFnCwDcnuUcvU9Rtw0k4z653ZgJsEOViFxWKgW0Kd/0phPzqrUv9V6MOlWGr3bOhbcYtY0xozfBV66pPBTyFpjCFu8KeoN7YomcpxtXtkVCqzfF0j7KERg8lXjcf4kDMGkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+2OzKEm; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8fca43972so10516186d6.1;
        Thu, 03 Apr 2025 07:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743689331; x=1744294131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8LoOtksMJ05+tcbaak6oIEwrH10sRQyogr42LI2cyM=;
        b=B+2OzKEmR2VlhqiHhJGlo1zqclZF8KoXqSebYoqLG61A4b4z2M4yu2wTirag0xAc8Y
         V1mRSjsTqPh7OoKie7ELE5Ss94HdigacLI9A6biE3yxHVuYiY9UoAsGi+MhI43I2SO0J
         ClVsrlLQvV6ui+ljuM0wLXQ2ZIZSyy2ssEl3YJwHu3vNQ83/awDVrKCHhIMXjIfLq/Cv
         jGiGG6BgkT1M0FHLC0bLu7fDhivaEirTENwwHslgewx6OEsjpnOqxyGkaJ6gnHFHPjtf
         vqKj81HRlmUkWCGyX1XSQwHihmw/6n6iDZBrFgvFdq13y8xj4BaA4g/h2BYsAaf7aPaF
         UAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743689331; x=1744294131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8LoOtksMJ05+tcbaak6oIEwrH10sRQyogr42LI2cyM=;
        b=UMQq+pGOOGqPUKjRitiPx/s/YxuD3L1Uw9kKSyQptYUjZmu71CVeIF2zmFXzxCM5xX
         5doSsxssDqvc/crA7A1aa2koa/f4cpoMVkhXPmstlppF3lLzjDdQpBr2IEXwV6TjnH6Z
         OWzTE9otCI+/djoTLAHKnvi1RtxmLDxqRMIhP9ZJhDmoE9FtAon2iX2cnQndOQ33u+7k
         CP9iOdHybE/Y1sPn3qaNPN2CTNqjrMZzg4eG6fo5TUNWHLbFgjukNxCA3OmSkbTBH7IX
         9DO8MHAIxsJym2as+fTRTEL7VA/M8FsBCAh7pTO0pRdUsW+EaL+NcFEqk1x3F9X+iz50
         VSJA==
X-Gm-Message-State: AOJu0Yy0c+irNql/1egTvAFPsL4XsW+WDRais86tErYDVL1TpRQN0v5N
	67LrOLCYcD7r/soA5A9lHeDnWcjpUZVxzKbG89QKTOwCoDROgcYLFWS1Kw==
X-Gm-Gg: ASbGncsseodbZEwlJ87bkhMSHGigyuhqMNgS1Uwly3/2qWfZWoJgCXdT82RZLwDI5nJ
	TaDVUnPZ1AfkXzTXGYNov//VGs208maMXxT816xuQa8LWADNBz2u5dJL8hLRSh16G28vvLHCTYs
	PSh7pR+m9fvlu18tSJZhs5wH0VCGmghxj9SHxAMI3H/wuMkiIWS03TtFBJ41/mw8CTr88gkdoEM
	nfyM7gK8T8Fbgk86uxDzcoWlKTgFApjOqDZd3PZixNzAlENfUp40tREx76FGmal3828Pt++tKDx
	rrp6oFzyEcs0jXzpCsAcNlr4E/UhQtclHnAaO6sjXhoIk+XZqTSf/vHjrbJiqRDrbrPK6qAC96I
	0tb04EWMThXCMClV2gAmvplkgoyxyYY6bxFx1FuyA7lhv
X-Google-Smtp-Source: AGHT+IFhlyCrNpVpozyI8tGD8fSrl6D0978V2VC5KqjdoE5alKtWstIdlxR8E3jZCBkWhwzWdL46xg==
X-Received: by 2002:a05:6214:dcc:b0:6e4:2e12:3a0c with SMTP id 6a1803df08f44-6ef0dd1c648mr34013796d6.39.1743689330718;
        Thu, 03 Apr 2025 07:08:50 -0700 (PDT)
Received: from willemb.c.googlers.com.com (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f16535bsm7895946d6.123.2025.04.03.07.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:08:50 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	Willem de Bruijn <willemb@google.com>,
	Matt Moeller <moeller.matt@gmail.com>,
	=?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
Subject: [PATCH bpf 1/2] bpf: support SKF_NET_OFF and SKF_LL_OFF on skb frags
Date: Thu,  3 Apr 2025 10:07:45 -0400
Message-ID: <20250403140846.1268564-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
In-Reply-To: <20250403140846.1268564-1-willemdebruijn.kernel@gmail.com>
References: <20250403140846.1268564-1-willemdebruijn.kernel@gmail.com>
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
 include/linux/filter.h |  3 --
 kernel/bpf/core.c      | 21 ------------
 net/core/filter.c      | 75 +++++++++++++++++++++++-------------------
 3 files changed, 42 insertions(+), 57 deletions(-)

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
index bc6828761a47..b232b70dd10d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -221,21 +221,24 @@ BPF_CALL_3(bpf_skb_get_nlattr_nest, struct sk_buff *, skb, u32, a, u32, x)
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
+	if (offset < 0) {
+		if (offset >= SKF_NET_OFF)
+			offset += skb_network_offset(skb) - SKF_NET_OFF;
+		else if (offset >= SKF_LL_OFF && skb_mac_header_was_set(skb))
+			offset += skb_mac_offset(skb) - SKF_LL_OFF;
+		else
+			return -EFAULT;
 	}
 
-	return -EFAULT;
+	if (headlen - offset >= len)
+		return *(u8 *)(data + offset);
+	if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
+		return tmp;
+	else
+		return -EFAULT;
 }
 
 BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
@@ -248,21 +251,24 @@ BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
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
+	if (offset < 0) {
+		if (offset >= SKF_NET_OFF)
+			offset += skb_network_offset(skb) - SKF_NET_OFF;
+		else if (offset >= SKF_LL_OFF && skb_mac_header_was_set(skb))
+			offset += skb_mac_offset(skb) - SKF_LL_OFF;
+		else
+			return -EFAULT;
 	}
 
-	return -EFAULT;
+	if (headlen - offset >= len)
+		return get_unaligned_be16(data + offset);
+	if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
+		return be16_to_cpu(tmp);
+	else
+		return -EFAULT;
 }
 
 BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, skb,
@@ -275,21 +281,24 @@ BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, skb,
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
+	if (offset < 0) {
+		if (offset >= SKF_NET_OFF)
+			offset += skb_network_offset(skb) - SKF_NET_OFF;
+		else if (offset >= SKF_LL_OFF && skb_mac_header_was_set(skb))
+			offset += skb_mac_offset(skb) - SKF_LL_OFF;
+		else
+			return -EFAULT;
 	}
 
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
2.49.0.472.ge94155a9ec-goog


