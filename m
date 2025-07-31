Return-Path: <bpf+bounces-64794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7263DB16F83
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 12:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319C63B94EB
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 10:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F282BE7B8;
	Thu, 31 Jul 2025 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="d21qpCf9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A642BE649
	for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957719; cv=none; b=EhJOh0VEwH83Hnp4ogXD0pDTa08BieO9ZgjBdh7wJ5rFI4pO+SVXr0zFCZH2WJgLYlm4hos2gchGTL5sYaqZYPBLuuHxQ7JEfbLNb8ZlB0A1Gow806RKYoKE0vBrjN3klhtGUuCCtdOT2JYDRfwM7Odgz4XNFqfGZqe7XB1D0sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957719; c=relaxed/simple;
	bh=RXk+qk+s6UQY7yvKq/I4XiJoyR3sBQyLwqHlSsOM5mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=brjQRzLpyLaDyZaYCsGBZyPVnnQcv92cpMiim8ZJAWSxJLD1vUb60GTTEwOFPaCAuwhichHuUo+erLWWXIL5eU37dnbebJ3BPdSUWt4sIaRMPNfWQMtxkaS8l0uOO1nX+fWhRgdO+SI2K2Mvp4DzoT4z4hnv/jKKrXQN6PPQrAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=d21qpCf9; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-615c29fc31eso168991a12.0
        for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 03:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753957714; x=1754562514; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8Dy00T6GZIA8aYOf2PXZe1Qcn9nzk9Nw4gH7seFRug=;
        b=d21qpCf997g+0raxJ7dgbI01lCwRzaRONFxnwkkwcZMc8hDzmaYwgL1nLBw52E4yc2
         d02O4rvISUQzMLlFK4347YV50xH9Fuaz5TZ/+0OEArDgzeEnzo2NPFEQN06ecMwWa2B4
         xJBrpBrZMHiO88MPpXaf4ei+MzSReA2IfVoxDVDuAfeOAYV8h0cA+ySVEw/FU1hdskE8
         YuVWI3Drk0iP+Yx/BwLkTu32RRczMuqTucYkNTp0fRRD9+g+CLW2NzJVDDKCniWO4dPh
         SYwCWanB3IhMctIVHRKgfAUbUo2wFCSrLxW6iSR9LRmNx/rE6oQpyDYZrC3UjBWv6uqy
         HzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753957714; x=1754562514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8Dy00T6GZIA8aYOf2PXZe1Qcn9nzk9Nw4gH7seFRug=;
        b=QYbO9kbjJHEKJzhTlJJgfuisBN+wZOOFjeOBFYQhg0gm/9Q2bj3c43POfszbIR1//F
         /lTK6cC92kHNwk0yPFerHPs1at6+GmYemN3QALeILiwFYIH2rlbN0xNnqiDhkb2KszEH
         dj5YjA9A6fBSpe6S5XOFA220OeTGeUXEOrN6aWNRQ8pXDVQDNwzRjeMCiqgoBSRmf8MI
         RHCKFZyv34xX9bDG9mcxnnjvTp/uq6blfaX+KW7vh5QDk/8fRUrOOFEYWAerwFrNR8gD
         a0A0zPBNhOetdDEj4e3jvsxm34dAbz2jP5Dhtf15LRMmIto79rbpy5U+StjNY6STw2MQ
         uVzg==
X-Gm-Message-State: AOJu0YwppVzLbAB6j1e23b/nPx7zibF3BryF611oONPZd4cDzGD7umiz
	6WqunBVJ0EAtLoR/US0l9YjrVNQoAS49s5F/wQDOZpXUJOhba0ruQ5oigAAny+0p+b0=
X-Gm-Gg: ASbGnct+PgWm7tq7rynUcf0WiLmarBbQ3p3dCt/uKdk+t8SoD9NA8S+wKPrrNmo/EKh
	dauVDiqX6xRtGPBUHbpFkHWZqm/l0mibuzd4KXHwuAu2qy1pk+/MHD8rs/VBPPk9wDFOfVscoVG
	rjN8gqPGgxn+I83AEBp12+f/TFMTpDqpu7RV6qiMhkEykJJaCEXrVT1w+WGVRyesWbViZd9rRdv
	5nrSyU2CSZTR2mgkCxHyB2cey71ZQwChivi0NNaGAY8iYqF9n9g7+jgK5zXVTldyLTsVnVbeBUi
	1DQWvXmerW90aaMp7G0JSYfeKl0cy+lubKAmSqeZ1GFojst4pBZ+MykVQAExnTnDvxwjGL6pwwG
	kVK712y3Re0mUGMw=
X-Google-Smtp-Source: AGHT+IGl4y8H8c1Wi3IPSOKPyMvXNslw0cMaid7x3nTfnV4PIDGBuzhUxUexLMDB1e3slqDl4UJOTg==
X-Received: by 2002:a05:6402:42cb:b0:615:b9cf:ef65 with SMTP id 4fb4d7f45d1cf-615b9cff470mr862949a12.1.1753957714096;
        Thu, 31 Jul 2025 03:28:34 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:eb])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffa3c4sm898841a12.46.2025.07.31.03.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:28:33 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 31 Jul 2025 12:28:16 +0200
Subject: [PATCH bpf-next v5 2/9] bpf: Enable read/write access to skb
 metadata through a dynptr
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-skb-metadata-thru-dynptr-v5-2-f02f6b5688dc@cloudflare.com>
References: <20250731-skb-metadata-thru-dynptr-v5-0-f02f6b5688dc@cloudflare.com>
In-Reply-To: <20250731-skb-metadata-thru-dynptr-v5-0-f02f6b5688dc@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Eduard Zingerman <eddyz87@gmail.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

Now that we can create a dynptr to skb metadata, make reads to the metadata
area possible with bpf_dynptr_read() or through a bpf_dynptr_slice(), and
make writes to the metadata area possible with bpf_dynptr_write() or
through a bpf_dynptr_slice_rdwr().

Reviewed-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/filter.h |  6 ++++++
 kernel/bpf/helpers.c   | 10 +++++++---
 net/core/filter.c      | 10 ++++++++++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 1e7fd3ee759e..9ed21b65e2e9 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1784,6 +1784,7 @@ int __bpf_xdp_store_bytes(struct xdp_buff *xdp, u32 offset, void *buf, u32 len);
 void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len);
 void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
 		      void *buf, unsigned long len, bool flush);
+void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset);
 #else /* CONFIG_NET */
 static inline int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset,
 				       void *to, u32 len)
@@ -1818,6 +1819,11 @@ static inline void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off, voi
 				    unsigned long len, bool flush)
 {
 }
+
+static inline void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
+{
+	return NULL;
+}
 #endif /* CONFIG_NET */
 
 #endif /* __LINUX_FILTER_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9552b32208c5..cdffd74ddbe6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1781,7 +1781,8 @@ static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *s
 	case BPF_DYNPTR_TYPE_XDP:
 		return __bpf_xdp_load_bytes(src->data, src->offset + offset, dst, len);
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return -EOPNOTSUPP; /* not implemented */
+		memmove(dst, bpf_skb_meta_pointer(src->data, src->offset + offset), len);
+		return 0;
 	default:
 		WARN_ONCE(true, "bpf_dynptr_read: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -1839,7 +1840,10 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
 			return -EINVAL;
 		return __bpf_xdp_store_bytes(dst->data, dst->offset + offset, src, len);
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return -EOPNOTSUPP; /* not implemented */
+		if (flags)
+			return -EINVAL;
+		memmove(bpf_skb_meta_pointer(dst->data, dst->offset + offset), src, len);
+		return 0;
 	default:
 		WARN_ONCE(true, "bpf_dynptr_write: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -2716,7 +2720,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
 		return buffer__opt;
 	}
 	case BPF_DYNPTR_TYPE_SKB_META:
-		return NULL; /* not implemented */
+		return bpf_skb_meta_pointer(ptr->data, ptr->offset + offset);
 	default:
 		WARN_ONCE(true, "unknown dynptr type %d\n", type);
 		return NULL;
diff --git a/net/core/filter.c b/net/core/filter.c
index 83df346b474e..6cce89bef456 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11987,6 +11987,16 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	return func;
 }
 
+/**
+ * bpf_skb_meta_pointer() - Gets a mutable pointer within the skb metadata area.
+ * @skb: socket buffer carrying the metadata
+ * @offset: offset into the metadata area, must be <= skb_metadata_len()
+ */
+void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
+{
+	return skb_metadata_end(skb) - skb_metadata_len(skb) + offset;
+}
+
 __bpf_kfunc_start_defs();
 __bpf_kfunc int bpf_dynptr_from_skb(struct __sk_buff *s, u64 flags,
 				    struct bpf_dynptr *ptr__uninit)

-- 
2.43.0


