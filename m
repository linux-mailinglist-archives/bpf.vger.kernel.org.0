Return-Path: <bpf+bounces-73703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7895C37AF0
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44E518C1C36
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11117346A05;
	Wed,  5 Nov 2025 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Zu6jXXKx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB56A347FE8
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373997; cv=none; b=aCjb1fwzlvWN4j9pD2jkJq9CyIrAtb5xKPhT6IdgfG0SxxzTOAKnPVlc6VLB+GsmZml58+HQGXr1iIul1EGliy418WueHNq7QYe2XwBH64Il82+X2zPlxhpajKmNFPRBoYFEfPqxzPjiIX2Rq9BSC86EfCZljyxBWbLYndo0iQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373997; c=relaxed/simple;
	bh=gYN6oQsJeTreIpISV5I2QoWCby8ALWACx8QsEt2OAeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e32E5JZ9OxkSsrH2vhBqEH7wnTGAUVTU6sbZWLZZRwtsR5F+oJL299VD2YzCaQQ1m3GdT/wT8TgiGmAb+SISDePBT+xMyvMu80naUizvVBUfaftLYx9rKbs5obK2QeXr9mJe8Jy/VnHcfSxlaVl/dYKCic4XnZsyJ5D9Vi8w0kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Zu6jXXKx; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso44898766b.3
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 12:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762373994; x=1762978794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpMzoQFkKhE0WWczd/SmuvEvZhzMypHVeCaCFMbefns=;
        b=Zu6jXXKxijLr3+12R1eXZZlB+ypL2LsfGqYRIEeyENK7ggX7UELHd5fNoUnR1rHZn8
         xDy6glGHzkFpksyoNt/wZreHbg8HeLu+JW//4zlK6x9nsgA1qZnSftDmGRQ8xEFxH+u8
         YTSmvhCTaucd6iq0ivq9Q4cTmEqJ7RAftOMDlylF0f6aWpxP+akic8F5SVq+58amNTUH
         NmXn8DeZSROSvquGwuozHWAwdRWmqVweeNy0kFrC2vl6aLmU9xIz5llj/L/42E9UP0Hi
         VCR/qvUtcxGP5visZXhJh3+RpuffSWh5SPN4p4by3SY5S1iviydJYj8BJgaC8JL/V8WR
         LCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373994; x=1762978794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpMzoQFkKhE0WWczd/SmuvEvZhzMypHVeCaCFMbefns=;
        b=snkUzlmQb9YjOMXMNQbM6LqbDV+E4zPrnir3H7YbeJvY50wj7ArsTVZbDjY2p5C90g
         Iz/figAiL8QaCjqqQwqeJmW3Z7/JEUGN3bAeHTUhNKU5vCnvuOAvj8VWVyaMe8nBRsPM
         fQ2oe8kl6vTklUXdax64ZDY2xsPAS7AI9PFEqLjoqMn80VIYJSrn0UJeDud+ISQjH18Q
         sLG9JTXIlumuRtY3rbTF3AvvEc6aV84xXRJVgwpBrTWdmKxJb1fmLdD2XYiRksD55h61
         PF0UcR8lz07CwkXrelQX8wtU2q7FFTHSgo9Pp2Hv+H16OeOy0NqOU9PJwhMDCMdlExDY
         B89g==
X-Gm-Message-State: AOJu0YzvuJDArqbiGiU8CYWCfCqNQXjzlO7ZPll57sMlYX8j8ZRLnu2w
	woorunZhHF0y2zngsQb/carGTkL0KIwJExugfQMQzK9AHCl6nWeAR5t3+9i2xUb+nM0=
X-Gm-Gg: ASbGncsxGTGFVMtQdVQTHiDZ8Q6ajibOdnwOLiRcj9nrCG6nbBzMGrnYGFlYSw4PpmU
	ll5BjN9KuFPErh6pZIb5Oo9wJzm1FeZ1tWmvemVAfoY+SCMvuoACuxNpy+rZ0TsaSjytidY6VTm
	2P18j3kcANhEx2shwBwea3a/UFIQJDuALBG3jYzNm5aQXYzTT1pjKnIJjsMscgoUy3Lmjsj0iow
	eHvC0Jgh34FFnrRlqTbaKew+vksRmAPZ41MLh7cTjWi021Wa3RwCGpZ2GZNTbGesHTukatnyXkI
	SdLvIZo9rTeMyXHzcPGNKtcV8E+5BoeLNBGK4UYzjb2ktV6bCH5on4JMscKLyxFWSDsv7hMfxR0
	aN8i5tbd/JUfl8pbzyfP5JGBbB+6dD6d78ZK74as9vV+ZYuUZBGSVMKCYL70JJ50K5i1Rw03vVS
	dABXs8V1w8N1bm6WLARkg85WmT0zn5nPS7w+rKkYmNRwtgT/CxOquy3mlq
X-Google-Smtp-Source: AGHT+IFKOU8g6wpirWuWQMHW3413z9v+4YiUIqEJ5zj54J/vQUrGm04np4/erv/xPmOpbqCvy7gC5A==
X-Received: by 2002:a17:907:7f0f:b0:b6d:7f68:7874 with SMTP id a640c23a62f3a-b726553b051mr444132766b.44.1762373994308;
        Wed, 05 Nov 2025 12:19:54 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72896c93b6sm43126266b.69.2025.11.05.12.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:19:53 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:40 +0100
Subject: [PATCH bpf-next v4 03/16] bpf: Unclone skb head on
 bpf_dynptr_write to skb metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-3-5ceb08a9b37b@cloudflare.com>
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

Currently bpf_dynptr_from_skb_meta() marks the dynptr as read-only when
the skb is cloned, preventing writes to metadata.

Remove this restriction and unclone the skb head on bpf_dynptr_write() to
metadata, now that the metadata is preserved during uncloning. This makes
metadata dynptr consistent with skb dynptr, allowing writes regardless of
whether the skb is cloned.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/filter.h |  9 +++++++++
 kernel/bpf/helpers.c   |  6 ++----
 net/core/filter.c      | 18 ++++++++++++------
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5c859b8131a..2ff4fc1c2386 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1781,6 +1781,8 @@ int __bpf_xdp_store_bytes(struct xdp_buff *xdp, u32 offset, void *buf, u32 len);
 void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len);
 void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
 		      void *buf, unsigned long len, bool flush);
+int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 offset,
+			       const void *from, u32 len, u64 flags);
 void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset);
 #else /* CONFIG_NET */
 static inline int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset,
@@ -1817,6 +1819,13 @@ static inline void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off, voi
 {
 }
 
+static inline int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 offset,
+					     const void *from, u32 len,
+					     u64 flags)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
 {
 	return ERR_PTR(-EOPNOTSUPP);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 865b0dae38d1..050783245c0f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1890,10 +1890,8 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u64 offset, void *src,
 			return -EINVAL;
 		return __bpf_xdp_store_bytes(dst->data, dst->offset + offset, src, len);
 	case BPF_DYNPTR_TYPE_SKB_META:
-		if (flags)
-			return -EINVAL;
-		memmove(bpf_skb_meta_pointer(dst->data, dst->offset + offset), src, len);
-		return 0;
+		return __bpf_skb_meta_store_bytes(dst->data, dst->offset + offset, src,
+						  len, flags);
 	default:
 		WARN_ONCE(true, "bpf_dynptr_write: unknown dynptr type %d\n", type);
 		return -EFAULT;
diff --git a/net/core/filter.c b/net/core/filter.c
index 1efec0d70d78..96714eab9c91 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12023,6 +12023,18 @@ void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
 	return skb_metadata_end(skb) - skb_metadata_len(skb) + offset;
 }
 
+int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 offset,
+			       const void *from, u32 len, u64 flags)
+{
+	if (unlikely(flags))
+		return -EINVAL;
+	if (unlikely(bpf_try_make_writable(skb, 0)))
+		return -EFAULT;
+
+	memmove(bpf_skb_meta_pointer(skb, offset), from, len);
+	return 0;
+}
+
 __bpf_kfunc_start_defs();
 __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 				    struct bpf_dynptr *ptr__uninit)
@@ -12050,9 +12062,6 @@ __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
  * XDP context with bpf_xdp_adjust_meta(). Serves as an alternative to
  * &__sk_buff->data_meta.
  *
- * If passed @skb_ is a clone which shares the data with the original, the
- * dynptr will be read-only. This limitation may be lifted in the future.
- *
  * Return:
  * * %0         - dynptr ready to use
  * * %-EINVAL   - invalid flags, dynptr set to null
@@ -12070,9 +12079,6 @@ __bpf_kfunc int bpf_dynptr_from_skb_meta(struct __sk_buff *skb_, u64 flags,
 
 	bpf_dynptr_init(ptr, skb, BPF_DYNPTR_TYPE_SKB_META, 0, skb_metadata_len(skb));
 
-	if (skb_cloned(skb))
-		bpf_dynptr_set_rdonly(ptr);
-
 	return 0;
 }
 

-- 
2.43.0


