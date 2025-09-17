Return-Path: <bpf+bounces-68720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE1BB82358
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 00:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993CD189666B
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 22:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBB2311599;
	Wed, 17 Sep 2025 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX2lbw6b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332273101C0
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149718; cv=none; b=TVvqlhGbxQXEHSm84TTd9f4nFvqTeh4j+aLeMHe/OrZRw2Zuu2TK91GIlTAtR7b5dOHvH7DRH/JoMzYYxgjvHS2mNOFx77+hJL4FWPfHwVbJFn7MvZM3mbUdv2HFXX36xi+7CslfJKHqC5PbRnKhAGc89LsBmoZP9HNrZQsjgxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149718; c=relaxed/simple;
	bh=mOdqaIQDWGokgR6nAetO40xL2IYhPDADdHeev4bl8mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHPN3LgZbUfD7jDhYr0tjEVeZibIO7A0bn80F6QomgqN2W5tloJGERluft/K/DUeMuGdh4CL6FODurNPG2grevlhxIcpjmPQl+AyHbTuipbcp0AqvVhIuqtjnxdl9deAW5wzKJuaeB0Juo5icAKVjn64PIGftTOnJLLvaVvZdAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FX2lbw6b; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-772301f8a4cso522916b3a.3
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 15:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758149716; x=1758754516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9wB4tgeF+7WSUk+APXIQdcXv6nxisAwKEv7VWjbrUU=;
        b=FX2lbw6bc0zuAS/JUjA3q0QLTV8HHCRBUvs89Ct0UNHTt38CDMnINLSoKvMyQgVMbs
         3u8eibP6tyMn+WLuHmtrDGFtuCK3TGKMk8BDwGDwhek6GepC51ef3pkEp1rCEf0nN6hf
         sXM+n/wF5kV3G1FXQLuTQDHPN01jP/005cErhTzj8oUdWVVUBDOWIFstjpGX6kO/zSqD
         DdKLOvIRQS9B/jbv1rqbEkswiRUnSlo7LFsDQr32xLQ+RH+hRQI4oD3qyyehIVRBUVgW
         tNBeBBfoBkmyKz/4RApWOxVneszfqcK12hT8aWa6XOo9B8X8OhfB/5C68M3iQ+mZYBzS
         eEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758149716; x=1758754516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9wB4tgeF+7WSUk+APXIQdcXv6nxisAwKEv7VWjbrUU=;
        b=ZCejviaMVPgfcDY95sF60QCCJw6JxlA5RLIVmFn4dchxRkQyFNvgRhIy7GoegVPsT+
         dg77QWXlSCpDXn9pr4azj6YAfkGryexrlDSWRrs+bRkWa/TrFN53ENb7BZurARfZ7zMk
         8GaL3pNzSSAp0sWlgOSicV/yX8mVBUToYZ3MYQtuygEkV3pyBcFFoHNZWmLzG+bdpLiS
         SCMd8hR2lB278QvV4w5v31quot6qQLduUH1V3nu1r5uOqqsq5w1vyqUKnkY4hQTAU2YX
         neuJbZ1ym7DX5KbtSOS4Zcvj6m3pIqQBHV6kwF4bL7ZDGgXI5kVBZnYka7LWYNd2ssmj
         3R0g==
X-Gm-Message-State: AOJu0Yyug7Ycqa7k+7788YSj1cywz2ffuGoQC31JmkN5c8JDjCdfGZwG
	7jt1wi6hStwj0jHbOtjDTFgHzVkCjkS4K/KBWUOoug22eVXBdhKK2KshUFI/FA==
X-Gm-Gg: ASbGncvVvHCmnyFQx2I0Pxp4+8kpwJKZCkfzzmxIjQTINyZtHnw+CbMXxa/y+w46uCA
	71S4NiJMKTMxgYCYjtb32rtB9ayfIliQ7/rRp6aUWxyYk+jI1M36D+O2yaAN13wdM8tZ6Z6pwdc
	NuYdfSwmiUCj1VYJW0RbsXT2ydcZ3XuzT1NB2i3RvRDnAoS50XOIvHH0Q7gLgvfNXfRHgNObi5D
	4CNNo7yVShDJdFFG1wSkheVcCYDOOe8K9ET2NKccx3GN9vrdZYT0Fepi2diV0c6X/DGloFiIAoG
	n8kuDYqRWViO6VJrgsN6Ee6B5fSrrJME7r73e4/qwWPSskMMJPTrsVbGHOq0lZ2XrNuGlzyeLEW
	KW6bGXMB9f081ESlzPOrBQ0J5xJQ+429nfvfMyl4CbtE=
X-Google-Smtp-Source: AGHT+IFgFab2Sodefu3xIAvtEF1S//NTIKW/0vGVsTZEgvcYt9ZUc6JHqxU+DXDGaagJN9yg5aVpPw==
X-Received: by 2002:a05:6a21:3391:b0:263:8788:f09e with SMTP id adf61e73a8af0-27a8ca90e92mr4983242637.4.1758149716390;
        Wed, 17 Sep 2025 15:55:16 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfec3f454sm439654b3a.75.2025.09.17.15.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:55:16 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	paul.chaignon@gmail.com,
	kuba@kernel.org,
	stfomichev@gmail.com,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 2/6] bpf: Support pulling non-linear xdp data
Date: Wed, 17 Sep 2025 15:55:09 -0700
Message-ID: <20250917225513.3388199-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250917225513.3388199-1-ameryhung@gmail.com>
References: <20250917225513.3388199-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kfunc, bpf_xdp_pull_data(), to support pulling data from xdp
fragments. Similar to bpf_skb_pull_data(), bpf_xdp_pull_data() makes
the first len bytes of data directly readable and writable in bpf
programs. If the "len" argument is larger than the linear data size,
data in fragments will be copied to the linear data area when there
is enough room. Specifically, the kfunc will try to use the tailroom
first. When the tailroom is not enough, metadata and data will be
shifted down to make room for pulling data.

A use case of the kfunc is to decapsulate headers residing in xdp
fragments. It is possible for a NIC driver to place headers in xdp
fragments. To keep using direct packet access for parsing and
decapsulating headers, users can pull headers into the linear data
area by calling bpf_xdp_pull_data() and then pop the header with
bpf_xdp_adjust_head().

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/core/filter.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 0b82cb348ce0..0e8d63bf1d30 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12212,6 +12212,96 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
 	return 0;
 }
 
+/**
+ * bpf_xdp_pull_data() - Pull in non-linear xdp data.
+ * @x: &xdp_md associated with the XDP buffer
+ * @len: length of data to be made directly accessible in the linear part
+ *
+ * Pull in data in case the XDP buffer associated with @x is non-linear and
+ * not all @len are in the linear data area.
+ *
+ * Direct packet access allows reading and writing linear XDP data through
+ * packet pointers (i.e., &xdp_md->data + offsets). The amount of data which
+ * ends up in the linear part of the xdp_buff depends on the NIC and its
+ * configuration. When a frag-capable XDP program wants to directly access
+ * headers that may be in the non-linear area, call this kfunc to make sure
+ * the data is available in the linear area. Alternatively, use dynptr or
+ * bpf_xdp_{load,store}_bytes() to access data without pulling.
+ *
+ * This kfunc can also be used with bpf_xdp_adjust_head() to decapsulate
+ * headers in the non-linear data area.
+ *
+ * A call to this kfunc may reduce headroom. If there is not enough tailroom
+ * in the linear data area, metadata and data will be shifted down.
+ *
+ * A call to this kfunc is susceptible to change the buffer geometry.
+ * Therefore, at load time, all checks on pointers previously done by the
+ * verifier are invalidated and must be performed again, if the kfunc is used
+ * in combination with direct packet access.
+ *
+ * Return:
+ * * %0         - success
+ * * %-EINVAL   - invalid len
+ */
+__bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)x;
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	int i, delta, shift, headroom, tailroom, n_frags_free = 0;
+	void *data_hard_end = xdp_data_hard_end(xdp);
+	int data_len = xdp->data_end - xdp->data;
+	void *start;
+
+	if (len <= data_len)
+		return 0;
+
+	if (unlikely(len > xdp_get_buff_len(xdp)))
+		return -EINVAL;
+
+	start = xdp_data_meta_unsupported(xdp) ? xdp->data : xdp->data_meta;
+
+	headroom = start - xdp->data_hard_start - sizeof(struct xdp_frame);
+	tailroom = data_hard_end - xdp->data_end;
+
+	delta = len - data_len;
+	if (unlikely(delta > tailroom + headroom))
+		return -EINVAL;
+
+	shift = delta - tailroom;
+	if (shift > 0) {
+		memmove(start - shift, start, xdp->data_end - start);
+
+		xdp->data_meta -= shift;
+		xdp->data -= shift;
+		xdp->data_end -= shift;
+	}
+
+	for (i = 0; i < sinfo->nr_frags && delta; i++) {
+		skb_frag_t *frag = &sinfo->frags[i];
+		u32 shrink = min_t(u32, delta, skb_frag_size(frag));
+
+		memcpy(xdp->data_end, skb_frag_address(frag), shrink);
+
+		xdp->data_end += shrink;
+		sinfo->xdp_frags_size -= shrink;
+		delta -= shrink;
+		if (bpf_xdp_shrink_data(xdp, frag, shrink, false))
+			n_frags_free++;
+	}
+
+	if (unlikely(n_frags_free)) {
+		memmove(sinfo->frags, sinfo->frags + n_frags_free,
+			(sinfo->nr_frags - n_frags_free) * sizeof(skb_frag_t));
+
+		sinfo->nr_frags -= n_frags_free;
+
+		if (!sinfo->nr_frags)
+			xdp_buff_clear_frags_flag(xdp);
+	}
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12239,6 +12329,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
+BTF_ID_FLAGS(func, bpf_xdp_pull_data)
 BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
-- 
2.47.3


