Return-Path: <bpf+bounces-63455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4083AB07AF4
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 18:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EAE91760F7
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 16:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A462F5C52;
	Wed, 16 Jul 2025 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SMWG6Xm6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293D32F5326
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682679; cv=none; b=DE3mRmPuyhy/YhmLzII6CSQ5Vpjpo6fInXMIwMQM+xI8jKZWjNDgzlRDr38LzFkWhMUFSw4F/wUYmA/Nc5Fon1py6ixK3LTxxvhlDYB7ZdaTDDfqnfezbvTNMqyqU+TPia5UmbyKQLt0LiKD561G3cP+fysnUCEEqYTpMeLdPfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682679; c=relaxed/simple;
	bh=ewNf/yPyalb1C4TBp8pHMc0BV1sFO7SHvBFjDhYkbro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U3vloyC94hFDfB8eZ4DciQDxfBvndA4y7JKF1yQyA/GkzaspyVDKelHqNfVF0JhDVvlAZwPDMSX4G3P8csyo0iilAcUwpHJGeQpFCLZHO99UUKLw6DzKbQSuujZmsovnHTSXue3EaIbLKV/EUlZPFU1VRzA6mYOJ6lMeKpxSSvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SMWG6Xm6; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-558f7472d64so1034063e87.0
        for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752682675; x=1753287475; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bl7XwzUExtDfNh5T4XxzNX3UfEJKH3S69WMxYHoR2+8=;
        b=SMWG6Xm65B81XIynBnIOWy/mdKPbTme7q8p2NshfB3pUBXvsTH3UfL5JklN5l3MS3f
         gmPKk6UIhCwq+8hbokYNBwW5DdC8uePrCCAboaMhzvBw6bwQD//sXt4HG/bcQ+37BLqu
         /jLKMtBbPnjARhhjfi11CiY9geSX/+FSvw1fnfUHC8PJRYAMgMzYg5p86hKMtiewAIdF
         peURXgrIApsmyWOrbgN0+UdU6O0eeccC14v7wLVymRs78rSIZWoL5SpwjoA6/poRMskc
         y/zslxhU3/+cjOos5gBlJXNWuHAfw+5zhO6WcyV4kGzHaqVFEFtibCLO8zen7evmzfn6
         +9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682675; x=1753287475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bl7XwzUExtDfNh5T4XxzNX3UfEJKH3S69WMxYHoR2+8=;
        b=JG0Hr390BQyz4YY2JTp4zeS5eOPRPaEnUxXdv3giLEqlVIRplRrR8YH2kHYRi89Kch
         XR+RCOMwiQNepmzgYQY98oSD5KX4Qc4rlj+mUSIREvX18St07BJGS6z7LY0yduq/AfVe
         ixw3RTJ0Gb8H1ueN58Z+3TMUGcXgovj0sR/I0WpqPSUhHNlJJKPsmgV9fnjtlBpok1o0
         d4Pw2riwSYjhuDyaLBITMejnBHgL4RucsovVbs+j/7CI5Au7BLdRJYhpZlcSwjYOlzAP
         TRJrRRJmMB4emgdbg1uygKfWB6YRGA2oXCy9uFQ35OtWMjv5SVOdL1GkAr/x4zM3mdzb
         hXJA==
X-Gm-Message-State: AOJu0YzYga/dmzs5OJd+tpCX0d29+GoyNmtpQsNnXQnP6Qgfyh6NRLet
	KWJ1y50w+tfzeuwQynBOqQfsj0nya1JB9GooLrOAtIBzInThIpdNYXqCnXNcVflIGEQ=
X-Gm-Gg: ASbGncta+BAhsrOcc6pmRhk3EdTPmPrGLHdEmkv3l6Ga2EmFCZbJjdpUBzFLwGr/u/q
	aNuxGUxfLH528Gk5j5Ai2yCrI7IFKUV4PZ+jQLGupkhiYMUPpraHZ5Y5O9smje8KeBd2LZAaY6x
	9TGHpulLKCBmFF+bMqf23O0P770WpEml3axoZJB1yx3D9sLDrhH9RwY9HvV7Vx2BmtjmN9x+eOA
	oJH9p624BZcVJMnI8XRBTVbrTQd/wzwtPQhPdM7BqSe+acKdjQac2LHU2uud4CcZu0tLg0lJZOg
	yMSs2P8dEJwIg0n10oTkkU/0pm89oD4bKRQm3umvmHtsBsnj2Dq6foLZKZBLQLuzuBrRjgGl8yc
	PLq3dNKKHnk2OW6wYyUowx10H5xIz9DdPjccMFftvQe0oCQJIzKvi6JLmYhxXv/4EWP51
X-Google-Smtp-Source: AGHT+IHT+yoSwkaf6TogUHQSXHE4d+/03H76idGOIyP7T+08yIuaBRthlv71/3rA3dTNKmenJ2M65w==
X-Received: by 2002:ac2:51ce:0:b0:553:9d73:cb15 with SMTP id 2adb3069b0e04-55a28b1f15cmr7942e87.15.1752682675173;
        Wed, 16 Jul 2025 09:17:55 -0700 (PDT)
Received: from cloudflare.com (79.184.150.73.ipv4.supernova.orange.pl. [79.184.150.73])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b72f3bsm2696567e87.208.2025.07.16.09.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:17:53 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 16 Jul 2025 18:16:48 +0200
Subject: [PATCH bpf-next v2 04/13] bpf: Enable read-write access to skb
 metadata with dynptr slice
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-skb-metadata-thru-dynptr-v2-4-5f580447e1df@cloudflare.com>
References: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
In-Reply-To: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Make it possible to read from or write to skb metadata area using the
dynptr slices creates with bpf_dynptr_slice() or bpf_dynptr_slice_rdwr().

This prepares ground for access to skb metadata from all BPF hooks
which operate on __sk_buff context.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/filter.h |  6 ++++++
 kernel/bpf/helpers.c   |  2 +-
 net/core/filter.c      | 10 ++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7709e30ce2bb..a28c3a1593c9 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1776,6 +1776,7 @@ int bpf_skb_meta_load_bytes(const struct sk_buff *src, u32 offset,
 			    void *dst, u32 len);
 int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 offset,
 			     const void *src, u32 len);
+void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset, u32 len);
 #else /* CONFIG_NET */
 static inline int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset,
 				       void *to, u32 len)
@@ -1822,6 +1823,11 @@ static inline int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 offset,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset, u32 len)
+{
+	return NULL;
+}
 #endif /* CONFIG_NET */
 
 #endif /* __LINUX_FILTER_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a264a6a3b4e4..f599a254b284 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2711,7 +2711,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
 		return buffer__opt;
 	}
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return NULL; /* not implemented */
+		return bpf_skb_meta_pointer(ptr->data, ptr->offset + offset, len);
 	default:
 		WARN_ONCE(true, "unknown dynptr type %d\n", type);
 		return NULL;
diff --git a/net/core/filter.c b/net/core/filter.c
index 86b1572e8424..d9cd73b70b2a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12002,6 +12002,16 @@ int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 offset,
 	return 0;
 }
 
+void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset, u32 len)
+{
+	u32 meta_len = skb_metadata_len(skb);
+
+	if (len > meta_len || offset > meta_len - len)
+		return NULL; /* out of bounds */
+
+	return skb_metadata_end(skb) - meta_len + offset;
+}
+
 static int dynptr_from_skb_meta(struct __sk_buff *skb_, u64 flags,
 				struct bpf_dynptr *ptr_, bool rdonly)
 {

-- 
2.43.0


