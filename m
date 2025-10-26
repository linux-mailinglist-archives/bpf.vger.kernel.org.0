Return-Path: <bpf+bounces-72234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DD5C0A957
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 15:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C16B3B1013
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 14:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3382D9784;
	Sun, 26 Oct 2025 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YH3U2Ime"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3232561D4
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488324; cv=none; b=POE8Q/Ll7TCE9hgG8iuasaMh6vSvBHDdYjYdhFZ2ZENj3Ikxuk72JRXG/MIsHboTiq4j8VqWiwNEOXR+/O7IODUlxVs1n7e3nKBQaftupjfmOPUCSAmybOKyPEkA0DBDnZRa1mm+AJ+mEGMu/i4AvHybWuKOylzKq7gi6cVe8jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488324; c=relaxed/simple;
	bh=Q3MTKpFXBmeuHsk2LNigWyOZO/7FRjOOFC7vdk21HrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kKuqs99MhiOYpPWEtI67VqKcMh5yHZu1Gq7uuoE4rbD6eKms176QL3ngdLVvoYspin7Kui9fiUR/m7lsQdgJ2mv6nbqIku8Ylgzjhq9OndSaA5hIvN1fmY8HwDXnIjXzLVrHGgixB4gWO79iND5LxvDKdPPB/B8JKaFIsfKFrzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YH3U2Ime; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c4b41b38cso8187649a12.3
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 07:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488321; x=1762093121; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGYJhxrTJ68z2dk0/14b4PuvkhwRu3VHllEhyEgQEHE=;
        b=YH3U2Ime/bxV7jG4OkLERUuSKLydmv1pysjKp7xBHhC5y9Kyh9odHXgisf2QGixRU3
         /X0MS+t0MP9OaUQIE3DgHaCBj6muqriKhqfR3Af1ZLLKt+AidLfrdoDti1DYcgZCmCsd
         M4Hz9p2C8kVzfXtpmhbZv9V6CDr22j+Kgm+ZXGSgTDK7Jc5+rCoEU+2GBX9gmbcyCgp+
         fPlgPMf0+umgEgo8GSBKM7qD2cfZ3Kb+ziLZ+d/y7fP4zie7Il2vJsvF7TKl26HfM85b
         xzktxqzGo6hkc1YbkSXdcEH1ocVADa0mEdj0NXQUvZvItg5ihb2wnEL21ICQH4lmzTMl
         pQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488321; x=1762093121;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGYJhxrTJ68z2dk0/14b4PuvkhwRu3VHllEhyEgQEHE=;
        b=O/fYqUzzGtKTgiQQWqwYTrfAP5URaYVrEL610wUzBQTLnvHdyyH6MJD6IW8bZTjq1m
         O9lLkhRal3/Wi8bV9CWAMAD7IjDI6oPdyAazKDxYUnocj3Tnbi+s4/MfkfJNFzzLFKqm
         cGX9RdRBV+MmkYiERXUTv+eHoiJzzV/v22ldBQnefHoceF2zQgw8zFMrEylkYfhmSFV4
         zqvhMGVXKT32lAEdhswi8y+PaCa1l42WmQfaq2/RxI6kiHQvJPc6nJq60vxjPftylZGU
         AhjS7eQAwaakVdE71iIJyQ2xNRf658tH8/ajHsfoqLgAqhhhqXHIrGhorTDHoNciv03i
         J6Yw==
X-Gm-Message-State: AOJu0Yy7nuOQhZ1yv/2Yom5T2LP8VAyHPIE/YreWPejKqiCHfeti/b/1
	FDGhaQv5wPU2sbDou1Pw3tzF8wc37oazephMkcDdtb8zw8MawbIqDM3FOt6yAHJ72zk=
X-Gm-Gg: ASbGncsvQUnHvmBNE72G8y/rE/I8NvHlUC06QFTKbp3WLbPyQWlae6LPl34jH7UEQTm
	kB307M/NqwYRX7ihZpwKgA4JGNQzPat2ZWn76BS5oSOSqGHy0tAQg2/XsNt6D722YvJjNh1Ob48
	Sq+G2wcwv8jrVJgTkFTL+tYaQRgGB6R+2Kbmp7uHO0LXb/zkyhe/JpswEcy4gCBvz/bbR7f8OAv
	kqMzS4PcoAEJsjiIrm9geVM2w7NX2TvmUFUtdnMQuw2Ym8rp+uqJqF7dT4v6tsTGVEJoqKAFRq8
	BbyWB1gQOyXtwXGpy4WR00JuNaeD8P1TUFbgfZAM5e/nXarQnTli/vqQirnyZb3nBbTedd6ynjx
	NH9ZdHDDCeO1YbqhRQRUo04YN/1a5fjJMDjXdIpPjTThymloypAFM0xtMitWO/fSGyRFg9bbMdk
	TltAREM07PcYZn2Lm2JnSjTttO9BS18Rl1QQ5pcgmIsnHiNmJufDICaV+qOwcFyDg1LcU=
X-Google-Smtp-Source: AGHT+IGLDCtW+rkVJlDsTfobSmt/SX7OpF0NsbfxdsekDiotLq0v+xiOxU+o063u2gx5m3AtnAV+mA==
X-Received: by 2002:a05:6402:440a:b0:63b:6b46:a494 with SMTP id 4fb4d7f45d1cf-63e3e10eea6mr10711569a12.14.1761488320595;
        Sun, 26 Oct 2025 07:18:40 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd0c1fsm3981358a12.37.2025.10.26.07.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:40 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:23 +0100
Subject: [PATCH bpf-next v3 03/16] bpf: Unclone skb head on
 bpf_dynptr_write to skb metadata
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-3-37cceebb95d3@cloudflare.com>
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
index b9ec6ee21c94..f9cb026514db 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1838,10 +1838,8 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
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
index 9d67a34a6650..a64272957601 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12022,6 +12022,18 @@ void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
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
@@ -12049,9 +12061,6 @@ __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
  * XDP context with bpf_xdp_adjust_meta(). Serves as an alternative to
  * &__sk_buff->data_meta.
  *
- * If passed @skb_ is a clone which shares the data with the original, the
- * dynptr will be read-only. This limitation may be lifted in the future.
- *
  * Return:
  * * %0         - dynptr ready to use
  * * %-EINVAL   - invalid flags, dynptr set to null
@@ -12069,9 +12078,6 @@ __bpf_kfunc int bpf_dynptr_from_skb_meta(struct __sk_buff *skb_, u64 flags,
 
 	bpf_dynptr_init(ptr, skb, BPF_DYNPTR_TYPE_SKB_META, 0, skb_metadata_len(skb));
 
-	if (skb_cloned(skb))
-		bpf_dynptr_set_rdonly(ptr);
-
 	return 0;
 }
 

-- 
2.43.0


