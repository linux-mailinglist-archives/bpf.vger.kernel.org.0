Return-Path: <bpf+bounces-66644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B76D0B38047
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 12:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6551F980E1C
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 10:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD5734DCCA;
	Wed, 27 Aug 2025 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JrwxX8bL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8C43469E6
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291733; cv=none; b=mUkhyWKCoNUXmsJP3yu4O6RWVtUhBVwjAsIm6qR45HolHzpaswnN2kC/vOpYhN4H4AiXDYWQCVyTYRo5DeZzRp4E0pEdaRIysnDeQMxe63lHPnUKIu2lOYsFIKnthUV3ICl4HL7tU7PIbLmgJsbNfEaKa+1UA5QdDn6TYQhjpZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291733; c=relaxed/simple;
	bh=hUoasQnCGasuL2bHEECdPbjoocMmyF4EX7JMYC3YOH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OEiaTEy2DbitpyOUZDnt1GaIoRchnOh6bp7DCdJ6bYgLk0Sx7zW8TP2//mUWPx12vERvVKFECr3lbilUdsG/72LKVvjgaP9z3zKnLGuuh2HqQSRHsq4Cfipj1OWgNdd4m6EEijcQg2el/modP9LuEXeQVwsUe23MR849e/6T+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JrwxX8bL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb72d5409so1114277866b.0
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 03:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1756291728; x=1756896528; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lL19xfHMBfEDs48X3K+oV8VPfeHvbok1+JBxYOZS28U=;
        b=JrwxX8bL2YcdBz5x0AOh+CA+Ane56S2aUbd+YdY3PyY7Ikj2v/RHA0O2bwTvwc000c
         G40Y57Mb6WpeZ6c+fzTNsqHhM5zZCjqMxOjYMhPNIrFpVCPoFU3uKWtBktiPj0h6qjB8
         hnvnuyrtjrnjJuYHGyFKo352O20VH74oD4S2B5jgGYgKCrtotEipd27Yww4t8GUOHRIN
         v5o3FIxbriFx/IZ0iFT0Re5tm03s7nw8OD2ZWtiVysOa49mh5YJZJigU4pQTyHb2Ya3e
         B1b81sp1g4NTjYSPAzcMMStq+oIVLgf0wXI9geBI8WAuOkfQuXN2A5jtCCA1BdN6KqtN
         GU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756291728; x=1756896528;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lL19xfHMBfEDs48X3K+oV8VPfeHvbok1+JBxYOZS28U=;
        b=C6yTD4a05QYrMegNm3pqwP3UeqoOF6rrwNysEkiA/kqqv0d1b97mQ5KKE7mL2awL7E
         a5TNKEibr3VhUFJWs86bUzhMroKwWwg4X/5+oNiK/uPt1ZHvzBW8FckWuzzeNWdERkj/
         h4kQK9ZtQPEfQHIAIwIRrzxeSIW1BBuRKhhXGpnPYiUpAuAxkzv4VMhh1YNIwCbkZo69
         vapqkJkbuDqsrGxqa15OwTdEC+7xMkXKjPEJw5LWNuO3oa3URhyNzrspq0q+Mts/jTHq
         SOFc58pvlp6i4xNE07HjE3OFBca2pGJt41oXoLVAiobs9uw9VZr8Yk5khqIHFqdpURl7
         4q7g==
X-Gm-Message-State: AOJu0Yyhvi43u+50AlIJxvsSut8NuwybKMps60XALxY/CAnMGAR+apdA
	xNzD/W2VkwkLPaTcfjn3qsRSBcLbHZVLPRarypxeJMpsKABNutDuqG6eRyccZpSq6eE=
X-Gm-Gg: ASbGncv73hqvBnIs6bMja1Uv0o1a+BDmn7Dv5pI0kUNGzA6bTw4enANxeqgwI6nbNgY
	8BgMnViO1Cj/mDZ4bY3wJwOYBqGYtOJro5jmXYWVSSiHYAzcpVHzbPgD4b1sk8ZHJjyfkfo8C/K
	I4zQTPn4sFqhwqabGPAkbY/k9rY5ktEQt+yvexG9nRNL6SvIuPjhhT21ZXug0UiDOK8Kc1YTjBr
	5T6EAy66OhtdPlNQotbyPQj+w2f0WYv3h4FoWfdUML0zlGsN79HxsH3hpNaGiuiQj55bppfUXnP
	UikqKx9sY1n4GwFkxS9+8nsBq0FzaPWyrDoF8S2Dxjzq4G5H/5P2e5SU766QjMt+yREYEJTVEfq
	89J4p8168oyV+yI1+S/+MoeQm6auHjsR3mIs79AGYQ1ThLTZtZZHSu/j+nPGaaJ1t9T85
X-Google-Smtp-Source: AGHT+IEVADrPJMUJPey3grHp2K9MK686lufQkO5QVcW/tIjMAy10SkXHsy6F5Gw27EFMbLCTtMlK5w==
X-Received: by 2002:a17:907:d06:b0:af9:6065:fc84 with SMTP id a640c23a62f3a-afe29437cafmr2078631166b.27.1756291728550;
        Wed, 27 Aug 2025 03:48:48 -0700 (PDT)
Received: from cloudflare.com (79.191.55.218.ipv4.supernova.orange.pl. [79.191.55.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe8c74194dsm534171166b.35.2025.08.27.03.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:48:47 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 27 Aug 2025 12:48:29 +0200
Subject: [PATCH bpf-next] bpf: stub out skb metadata dynptr read/write ops
 when CONFIG_NET=n
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-dynptr-skb-meta-no-net-v1-1-42695c402b16@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAHzirmgC/x2MQQqEMAwAvyI5G9CAWvcr4kHbqEE2lrYsLuLfL
 R4HZuaCyEE4wqe4IPBPohyaoS4LsNukK6O4zEAVNZWhDt1ffQoY9xm/nCbUA5UT2o4s2dYY1zP
 k2Ade5HzHA8x+ydKZYLzvB4W+AihyAAAA
X-Change-ID: 20250827-dynptr-skb-meta-no-net-c72c2c688d9e
To: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 kernel-team@cloudflare.com, netdev@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.15-dev-07fe9

Kernel Test Robot reported a compiler warning - a null pointer may be
passed to memmove in __bpf_dynptr_{read,write} when building without
networking support.

The warning is correct from a static analysis standpoint, but not actually
reachable. Without CONFIG_NET, creating dynptrs to skb metadata is
impossible since the constructor kfunc is missing.

Fix this the same way as for skb and xdp data dynptrs. Add wrappers for
loading and storing bytes to skb metadata, and stub them out to return an
error when CONFIG_NET=n.

Fixes: 6877cd392bae ("bpf: Enable read/write access to skb metadata through a dynptr")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508212031.ir9b3B6Q-lkp@intel.com/
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/filter.h | 26 ++++++++++++++++++++++++++
 kernel/bpf/helpers.c   |  6 ++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 9092d8ea95c8..5b0d7c5824ac 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1779,6 +1779,20 @@ void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len);
 void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
 		      void *buf, unsigned long len, bool flush);
 void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset);
+
+static inline int __bpf_skb_meta_load_bytes(struct sk_buff *skb,
+					    u32 offset, void *to, u32 len)
+{
+	memmove(to, bpf_skb_meta_pointer(skb, offset), len);
+	return 0;
+}
+
+static inline int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 offset,
+					     const void *from, u32 len)
+{
+	memmove(bpf_skb_meta_pointer(skb, offset), from, len);
+	return 0;
+}
 #else /* CONFIG_NET */
 static inline int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset,
 				       void *to, u32 len)
@@ -1818,6 +1832,18 @@ static inline void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
 {
 	return NULL;
 }
+
+static inline int __bpf_skb_meta_load_bytes(struct sk_buff *skb, u32 offset,
+					    void *to, u32 len)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 offset,
+					     const void *from, u32 len)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_NET */
 
 #endif /* __LINUX_FILTER_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 401b4932cc49..85761e347190 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1778,8 +1778,7 @@ static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *s
 	case BPF_DYNPTR_TYPE_XDP:
 		return __bpf_xdp_load_bytes(src->data, src->offset + offset, dst, len);
 	case BPF_DYNPTR_TYPE_SKB_META:
-		memmove(dst, bpf_skb_meta_pointer(src->data, src->offset + offset), len);
-		return 0;
+		return __bpf_skb_meta_load_bytes(src->data, src->offset + offset, dst, len);
 	default:
 		WARN_ONCE(true, "bpf_dynptr_read: unknown dynptr type %d\n", type);
 		return -EFAULT;
@@ -1839,8 +1838,7 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
 	case BPF_DYNPTR_TYPE_SKB_META:
 		if (flags)
 			return -EINVAL;
-		memmove(bpf_skb_meta_pointer(dst->data, dst->offset + offset), src, len);
-		return 0;
+		return __bpf_skb_meta_store_bytes(dst->data, dst->offset + offset, src, len);
 	default:
 		WARN_ONCE(true, "bpf_dynptr_write: unknown dynptr type %d\n", type);
 		return -EFAULT;




