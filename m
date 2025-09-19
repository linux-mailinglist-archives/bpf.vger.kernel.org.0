Return-Path: <bpf+bounces-68950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB245B8ADE7
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91525168DC0
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91E026529B;
	Fri, 19 Sep 2025 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOgVsHAj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4DC25742F
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305372; cv=none; b=IBqqOCXUBmoz/kPJAwOzWIVlRivKcbkzmkW+f96AZSYzczSXabVCnpC5+kXUtcqig4XQTkHLTNlJ44hbcM6oqyA5rcL1XzWdRY+hZpzDZh55V6nV8ApAmAOo60Qm3RLQAwLt29eNXmh+kF5Yo5L1L467guz0sx+f5VlhdPZhYH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305372; c=relaxed/simple;
	bh=mOdqaIQDWGokgR6nAetO40xL2IYhPDADdHeev4bl8mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aeXXypIM9mRgGULohgttW3BRVLhimuUSeHVq6YU7UgZrG7wGxcdbhkMQ7x7wtlh7t4ttkP/FVgdoi6noFYqypVgp2teEdtTpukhZBG3wYQ1zgMatyqiIhZIbeyJhEzfUF9hCxNaUMeq7n2KM4mFDS1Gcv9MU+GGkkvPfqv0kf6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOgVsHAj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2445826fd9dso29091785ad.3
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758305370; x=1758910170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9wB4tgeF+7WSUk+APXIQdcXv6nxisAwKEv7VWjbrUU=;
        b=LOgVsHAjpfge0/NN2v1iy7Q/xWqG7lpceL17Vh3VrVqGkx10fGWyDVt3K77+1ebIdl
         UR/KqE1zmDjhWhpEOuyXqfqcTKKw6+2N1XMn6wvS/VvRIywmZgmvATfPlEn5YlExfytR
         nhvWJd8qcb8IUFSE0bFq7SfjwxnhvLKtfshndlGyQHtatQyIcIfTialEWuZqE2ss3h9k
         4rx+DxiWUE4HGY/8R6FGvvPHW5Oh4wWh71PdgnjTOzhu6LdTf6T6rHsk9pzbm3Ouu+uS
         MJksYFUjk0y9uF856k8ac1mmEaMo/dlvh+0Mb607F7msKPTLRbDjm+toUIh4zvzeX8nl
         9Wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305370; x=1758910170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9wB4tgeF+7WSUk+APXIQdcXv6nxisAwKEv7VWjbrUU=;
        b=gI0TmAy1ayRbiVwc2fv1f/1CGz4m+y/rlfzSq7RCFJFSOz/JGsjO7vRla8ME0RYL6B
         5G/GKMFR1drvi5mFzpUAixoFRZ+vgajYvOl0QER8gA7+SpPJwrl8iMmr/kjtfDFv7pSQ
         qKGmW3kL5ldlNEUuboMhFh9O/YPHhnTvLIYSxg/woxXXf2mW+Iccmjucqm4GpvzpHzCs
         KnCh1TB8C6+ldXSkfZJucdTXcTs+6tHBF5TubiRMugZ84Ia6cEQ+M+NRd2tE8Zjlqdgc
         59g65umDbINtWAdc5WKq+USEm/lEXwIxtWO1Fndv0Sm3HDkwhCzoz3/PmbxmWcatfGt9
         jfiA==
X-Gm-Message-State: AOJu0YwMnVQZkxpvSb7a/LvNwlGPbd35vTl6DnwB0z5NjXAagaB7VFeK
	//SlGruWHtqnvpNkrcfVQtM7/3Mcd5SLcz6UVIyFY/J36voDCu+dJHIxetji/w==
X-Gm-Gg: ASbGncucDvJAiq8e38x1h7BrAhFAd0aFcwQmcAqBJ+1YdviJI0DYstk/EJ5NasKO3rk
	bLT8+f8W0157hfo3aoQUoXeHpaiWnwuBDTqHMcpjsTx0WdVPXCJYZgYyX3uTVo+DpqZUkuLHM2r
	QxH13Ln19t/+YQJjLYi3qe6WZiX54BEmbCvZJzR6E96qEg/wSyiQ2VVMcRadoyCvR0JeMTNXEYA
	0FvIwZpA/vcwdJzDcP9vCoT9QtPPiNq+MWl5J5h06hIc0oUEUEbYBxwHrA41PbMWYjFFJpFatSf
	fIH/6w42gZGlzbG4gp/dG6JxK1JBOuz3OydR0JtAZZN9vnKRNs6FhEf9jpq5waiv3SqLiKcsCH6
	UEY2iKMNNRk54ug==
X-Google-Smtp-Source: AGHT+IGD1VuAGHTS06Q6aq9wXJAQe9bhRR8zbRcZswN3JbbdMYMnQNrARfzVoY1s4zUgjeYqRg5gQg==
X-Received: by 2002:a17:902:ec8e:b0:248:79d4:93be with SMTP id d9443c01a7336-269ba5161famr59087925ad.30.1758305369739;
        Fri, 19 Sep 2025 11:09:29 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802de979sm61438045ad.69.2025.09.19.11.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:09:29 -0700 (PDT)
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
Date: Fri, 19 Sep 2025 11:09:22 -0700
Message-ID: <20250919180926.1760403-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919180926.1760403-1-ameryhung@gmail.com>
References: <20250919180926.1760403-1-ameryhung@gmail.com>
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


