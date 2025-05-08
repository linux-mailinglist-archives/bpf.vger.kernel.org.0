Return-Path: <bpf+bounces-57788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 598D0AB0295
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 20:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1411B6180C
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 18:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF76288517;
	Thu,  8 May 2025 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sHcj5pQL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9D72882D5
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746728456; cv=none; b=kMQAw5anHV7tQEe6gTN/Y5Xn7Im1RXEJUXYR5cux7/OGcAjmg+BNiCG0b6MnLD35IWE8B+daLcgTZmWDMgsn5281W82ePeMu8SjCcAcQY4+BMQFrdNouJy35z6LTHMadW5DQb7IMUpbNv/VG6PPoTkPYlyIei8+3eX22+nx4+8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746728456; c=relaxed/simple;
	bh=zGEqoJsnLxoyqxrZghaDObefQCOgPWpmlTZqfwBdN/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YVYD8yveCvr18Cap+IOeSiEKlkjkYdBEwdUiO8wuUfbND3tCJtTaUmk0JPvsnOHGNUCLWWPZTWdqM7Wgx0IrTC6mhRYTodLAQnOC8DKW3S2IrbXP2//IKP7mqi4ZYHvMwHjjWvz5odJ0iVkCICDPAZ860ANe/1t/qCt7WkF8fFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sHcj5pQL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22e68e50f80so9760755ad.1
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 11:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746728453; x=1747333253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OWA0exWT2PF9Bwdd6zODqvQVYBXl/Ht/Vugb+Sflr70=;
        b=sHcj5pQL90NiaMSQxm4Ay9AwYM3eTir31wG1WCHGxQ5+lEOOcAbpdmnSKLYei6KyNA
         2Mb9b8SgUuvFgN8hJjxNSC9Vr0CZqlpVzBmBz6Eo5piMeI42nMLPPVb49d2GyqhirwVd
         f+LXP8qu6JiwxViF4kUcE5r7nrFhcyP2sXqOJZ46jED1XJUeUW00Toq82czLD5eO++ek
         BDlI6Bj8mFOXz2cZdkxlZPyf1I5zR87q3TwQF7JITYkHpJSZvbYIvy5WEeeT0ue0PKhD
         A1SsZxO6q7Oi7ehEV78t+3OMmYOoCVv9tlIQe838fXOSLe4HzK9sfyJ5dLRrw0P6NUyj
         ITHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746728453; x=1747333253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWA0exWT2PF9Bwdd6zODqvQVYBXl/Ht/Vugb+Sflr70=;
        b=o3RozMD9FcyZh1j8C4pfiFRDxCZqGQhAIJUMyMH/cK8PMEaLof3Q/2I+7Vmcc9O6w/
         TONAIHYVDexypbJ8pa6v10Zmsozz9epaVRjBJac9SqYPrhgNwdh4at35satjNaoA7QjQ
         seq4AAt2rAerJlZdO1c3K5DLcbDw4jQXIRFeht58RJYsaKsHFAtaSm1bC3pE9VK+Gi9L
         9ev/t4SyxoQDq9PB+FIWSJi+pgGwmaqkQr+sXYIuYIY1WTJr0q03FCxu1F+PW+6u9Wwo
         IoOLSvvCliWCMWYkd6A4eJlq+hAlb36YhfsC5PqfDg0InHGixMwLyS2amcBW+C0eLqZb
         3Dnw==
X-Forwarded-Encrypted: i=1; AJvYcCUNbzFTrIaAH3xJ0EW14DrLIjUmWQOvPnlYEl2YBkhHLO04nW11VeOAZkSGcoxDw6l8D5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YykhEYsTTMr5uH+xpV7xQq+bmrCUoAGD39Ja+ZynJGSXgzKboD+
	R5wflmH5/yZuZaPKJnQUwNcN7QQv3AVIRHuHZhH5u8szyK6shnarv3BV1Fu+v2RKd8ETgy06QOE
	Ms9Sy62kZlDw3JA==
X-Google-Smtp-Source: AGHT+IEeAsbdgzwNcuStC5o0lsQE+GcpWguKPjE5+maPyPUAIOXS6rnVv8L8CoEgWNh3XZFUrNpQz3jUw6fJs5g=
X-Received: from plb16.prod.google.com ([2002:a17:903:4410:b0:22f:b333:1bd9])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ecc2:b0:211:e812:3948 with SMTP id d9443c01a7336-22fc8946f85mr6138175ad.0.1746728453022;
 Thu, 08 May 2025 11:20:53 -0700 (PDT)
Date: Thu,  8 May 2025 18:20:22 +0000
In-Reply-To: <20250508182025.2961555-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250508182025.2961555-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250508182025.2961555-4-tjmercier@google.com>
Subject: [PATCH bpf-next v4 3/5] bpf: Add open coded dmabuf iterator
From: "T.J. Mercier" <tjmercier@google.com>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org, song@kernel.org, 
	"T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"

This open coded iterator allows for more flexibility when creating BPF
programs. It can support output in formats other than text. With an open
coded iterator, a single BPF program can traverse multiple kernel data
structures (now including dmabufs), allowing for more efficient analysis
of kernel data compared to multiple reads from procfs, sysfs, or
multiple traditional BPF iterator invocations.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 kernel/bpf/dmabuf_iter.c | 47 ++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c     |  5 +++++
 2 files changed, 52 insertions(+)

diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
index 96b4ba7f0b2c..8049bdbc9efc 100644
--- a/kernel/bpf/dmabuf_iter.c
+++ b/kernel/bpf/dmabuf_iter.c
@@ -100,3 +100,50 @@ static int __init dmabuf_iter_init(void)
 }
 
 late_initcall(dmabuf_iter_init);
+
+struct bpf_iter_dmabuf {
+	/* opaque iterator state; having __u64 here allows to preserve correct
+	 * alignment requirements in vmlinux.h, generated from BTF
+	 */
+	__u64 __opaque[1];
+} __aligned(8);
+
+/* Non-opaque version of bpf_iter_dmabuf */
+struct bpf_iter_dmabuf_kern {
+	struct dma_buf *dmabuf;
+} __aligned(8);
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it)
+{
+	struct bpf_iter_dmabuf_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
+	BUILD_BUG_ON(__alignof__(*kit) != __alignof__(*it));
+
+	kit->dmabuf = NULL;
+	return 0;
+}
+
+__bpf_kfunc struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *it)
+{
+	struct bpf_iter_dmabuf_kern *kit = (void *)it;
+
+	if (kit->dmabuf)
+		kit->dmabuf = dma_buf_iter_next(kit->dmabuf);
+	else
+		kit->dmabuf = dma_buf_iter_begin();
+
+	return kit->dmabuf;
+}
+
+__bpf_kfunc void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it)
+{
+	struct bpf_iter_dmabuf_kern *kit = (void *)it;
+
+	if (kit->dmabuf)
+		dma_buf_put(kit->dmabuf);
+}
+
+__bpf_kfunc_end_defs();
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 78cefb41266a..39fe63016868 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3346,6 +3346,11 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_local_irq_save)
 BTF_ID_FLAGS(func, bpf_local_irq_restore)
+#ifdef CONFIG_DMA_SHARED_BUFFER
+BTF_ID_FLAGS(func, bpf_iter_dmabuf_new, KF_ITER_NEW | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
+#endif
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.49.0.1015.ga840276032-goog


