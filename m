Return-Path: <bpf+bounces-66440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C967B34B03
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 21:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC0A7A9137
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 19:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D96286881;
	Mon, 25 Aug 2025 19:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhAArXPX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D632857C7;
	Mon, 25 Aug 2025 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150766; cv=none; b=ZynGKigXIrY56vVmMWkjkm9pMMr+dapSHYw5pv0oNKMB3EKhYSd/TFFjcuz7wPdtWNMqs5x3j3jYKfHv5MwmcHhKcfuTnCjXIsqHSB3IfRyx+8k2B39+0E5On+xz3BVW5G7by4AnL3lOXi3buszCTn2OHdhho0GzXu9oxC6SfLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150766; c=relaxed/simple;
	bh=6eEItzaar5lF5alRWJVeDRKhG5mPTPYwFPbne2yoT74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaJqzMO7zR76B8VgvkwtW2e/9z87bfUi1FuarwDUIXKO1qS1Xj61PXhM0PmHy8Vu97O0Dfcssndmdxa4/1gmdfFBEhS/eKpWcLW+l0dep3VzZ8drdRK17ghuh7B/Lo1dbBReFImril6RatLVSDj9nqU2yjmJXcgUDegNBJ5hs5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhAArXPX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-771f3f89952so365490b3a.0;
        Mon, 25 Aug 2025 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756150764; x=1756755564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+Mvmxo6eg7gJjKeojv4RFxhWCkc9NsX3FQ0lzLHTGE=;
        b=bhAArXPXFywLb0wM91Dmc78YUGNLiUJa4WMxljif4kvPPBkUGXVwC/S7hwAKvn7t1q
         BMvc+oXzPYcNr1IA0lb5rPPfacMaLI1oOQ35mJ3AsSRlRyDwfNto7qCAU9ztZCEI4nhX
         PWF8ayL+0kPLS0hZSvuzjQyg3vzT6NeclmhMpAn9m+MwR0HHKfaXKS03tZg9vaTfwCCT
         rtt6yPD6FAdIV0Ojwzalpw7vJLTutgJzeQg+t4/00iwM6AQtCwBvgJcXTVw250kLl2KX
         wclLOdYvKGzFKi0vI0aHG6U/7S8xgEwlwYQFUYWODFKoPjuUyIBmHs/mzhpBvmjpFOLz
         Bhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756150764; x=1756755564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+Mvmxo6eg7gJjKeojv4RFxhWCkc9NsX3FQ0lzLHTGE=;
        b=lp01lgjRIkUOY4sSMy8CAjwOQMwvDpWKEr6Ob70JfG32ftuFJg13EvYMHvb5X/2smU
         lu9sbj8EXmiN3eySw2YmRpMSSLhPJ/y+SCnTtckDim8ggayMbvAu2qRgEUT/yO3Ib9Z6
         ARQr1ujs2T+Qic54s/wxedlD3HQLt9qnpCxdTPtNdMu672GgdH6Y9gI1GAw76dYoj4Dn
         Kr8+M2/x2rvyllpqaDGG4fw6OZuuB46/PkHj/QMrdCjB07B6zpCLTTyD8PV2EMA35I5c
         Adakbtm6zlsOdGvdOQsrhsAtsIT8CCOCiYr4qx0ZQ4WDJN8eTM2v0UxpvXZoKMx0S4VZ
         DE6w==
X-Gm-Message-State: AOJu0YwAgeaYHduK4JXsZB8Y7crcqTclVGwrQRHVycUP3ekeHgT33llK
	Fb4Ztw4r/hLWYNXhThhAnyaXCnUR9UgbKd3YWG9FDmdz7czauYi9ccOy6WPAmw==
X-Gm-Gg: ASbGncvTWmOirRzYvDeNJOVaP9Wqq2iuB4e072utPi4Dda45f23q65Q7W35g07ZUBmh
	BoNsFsLBpetUM9D9HmZD7T5WffJwZzGdB7mKti0vkADsdPHEOuxzMG4JkJyKvEr0DkjJblTdUwF
	HtEUGf3ojNIevnVkFxf0Fwt1QmeY5bcO7lSu9CuHKJ3HdF2Wi7VHWlIGH1w0mJEvVEyjLbLefHn
	9l0xJgmv26pYcuY6C3TsEzSSw8Lh88EjpMHs7NkPB5KzFqNrXIBbAh6cdYy9K3DqyhCew3fs/a8
	4gLShfMuM6G7VbK+Zqzd6snZtqp8JnkO1kF1OTliQ1ONb19781ifOjVe/2LSl4AjBwxYbxWmwv4
	ROpAzbcfmV/KdcA==
X-Google-Smtp-Source: AGHT+IHZ1NHDNFR9OhK6zWpT/yVDvB18dfZxwDQTcgj5z/1V7MDTr+PB/AcFDXKsMVJsE+tmUKWIQw==
X-Received: by 2002:a05:6a00:14d1:b0:73b:ac3d:9d6b with SMTP id d2e1a72fcca58-771f58c5da0mr698004b3a.4.1756150764138;
        Mon, 25 Aug 2025 12:39:24 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7704025a46dsm8053393b3a.106.2025.08.25.12.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 12:39:23 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kuba@kernel.org,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [RFC bpf-next v1 3/7] bpf: Support pulling non-linear xdp data
Date: Mon, 25 Aug 2025 12:39:14 -0700
Message-ID: <20250825193918.3445531-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250825193918.3445531-1-ameryhung@gmail.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
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
data in fragments will be copied to the linear region when there
is enough room between xdp->data_end and xdp_data_hard_end(xdp),
which is subject to driver implementation.

A use case of the kfunc is to decapsulate headers residing in xdp
fragments. It is possible for a NIC driver to place headers in xdp
fragments. To keep using direct packet access for parsing and
decapsulating headers, users can pull headers into the linear data
area by calling bpf_xdp_pull_data() and then pop the header with
bpf_xdp_adjust_head().

An unused argument, flags is reserved for future extension (e.g.,
tossing the data instead of copying it to the linear data area).

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/core/filter.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index f0ee5aec7977..82d953e077ac 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12211,6 +12211,57 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
 	return 0;
 }
 
+__bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len, u64 flags)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)x;
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	void *data_end, *data_hard_end = xdp_data_hard_end(xdp);
+	int i, delta, buff_len, n_frags_free = 0, len_free = 0;
+
+	buff_len = xdp_get_buff_len(xdp);
+
+	if (unlikely(len > buff_len))
+		return -EINVAL;
+
+	if (!len)
+		len = xdp_get_buff_len(xdp);
+
+	data_end = xdp->data + len;
+	delta = data_end - xdp->data_end;
+
+	if (delta <= 0)
+		return 0;
+
+	if (unlikely(data_end > data_hard_end))
+		return -EINVAL;
+
+	for (i = 0; i < sinfo->nr_frags && delta; i++) {
+		skb_frag_t *frag = &sinfo->frags[i];
+		u32 shrink = min_t(u32, delta, skb_frag_size(frag));
+
+		memcpy(xdp->data_end + len_free, skb_frag_address(frag), shrink);
+
+		len_free += shrink;
+		delta -= shrink;
+		if (bpf_xdp_shrink_data(xdp, frag, shrink, false))
+			n_frags_free++;
+	}
+
+	for (i = 0; i < sinfo->nr_frags - n_frags_free; i++) {
+		memcpy(&sinfo->frags[i], &sinfo->frags[i + n_frags_free],
+		       sizeof(skb_frag_t));
+	}
+
+	sinfo->nr_frags -= n_frags_free;
+	sinfo->xdp_frags_size -= len_free;
+	xdp->data_end = data_end;
+
+	if (unlikely(!sinfo->nr_frags))
+		xdp_buff_clear_frags_flag(xdp);
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12238,6 +12289,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
+BTF_ID_FLAGS(func, bpf_xdp_pull_data)
 BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
-- 
2.47.3


