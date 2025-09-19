Return-Path: <bpf+bounces-68960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAE8B8AE5C
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 20:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9CC77BB4B4
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE61277023;
	Fri, 19 Sep 2025 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doIQmsy7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FCC2701D9
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306067; cv=none; b=NWJaqsNszlmXqYHQDxEzQP41qNa9/v1CnQqaiFPh/z+x1Cu0p7K/gzDPwXQJAlVg/9uYjErzIy1s2cudEit1FC5Q3qGkhja3AEvP+Hb5oyzQQXvrsVPIMqwlufOXDuPaZBF5XSWJRk3l58TPmePO2jDXQnFDLp9NuHQX2OiwVoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306067; c=relaxed/simple;
	bh=+yQ2t/9d9UA/mVKr5d0OjMVjTE9IXyYN7Q4NbTHwiPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmM44d2d7OJukfLX/+Dx9b+UameOIAqQFKO55Y1uYxMGyPlOUe+YzKyYXTELAzCZIlneCNDyWT4Oue/GFZzoBAPSlw+Oq1NWWDrKhTIwfaBojsYUacch/mV+g5+oWxiLidzVue45g+s0IRON2LnHLYCX7+HX/kAlQ2FUXTmHPB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doIQmsy7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7725de6b57dso3239664b3a.0
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 11:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758306064; x=1758910864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLUY+Ej39kKeF/fRLSX0Y2NuiiPlaB3PPnfSYtai7d0=;
        b=doIQmsy7kJEQS8pYYz503CKwjo8pK5buJzEAdqrpKalFymJfV8bGnVFmsB4gYgtFq+
         3bUPnzLyUe6xaEGwk+nA4lu1eisvhPhhwoTRyif/y1QNQnCLGO7XseTLM/in2IAND9qh
         /THPKtQQR2GVBbKqy9Joed4bdK42DRgCrx8IFNXkR+/p7iu3qr/PVFdRRNoGcQrDnSjC
         0K20u+tR2L/nGiGc6Q0OFCxRgAGNTt/plqBtTdrzGozVtK1X3MRLMb+Cw46874rt0kdh
         PfbRy9pp8e0Y6jjjoy4FgfDznIShewc0Rn/cytd/rihEIxqsC83OQNdKU5RGnFGfJ+Ks
         6LDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306064; x=1758910864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLUY+Ej39kKeF/fRLSX0Y2NuiiPlaB3PPnfSYtai7d0=;
        b=IScnv+KIKQEFhZ/YOlTbtGmizr8uocQ7r4GSbCG9VJdmLIhxh48OGNWJLTWMBjqpcR
         d590oH0Oa6yVIrtTqK1KJCKH0DXbP2G/00IQcIrh2vbda8+65cpFHNSs6xh53B68lC2r
         GLOzEOVQORgYDLQ2pw1xhixemFckkhtx01uQjy4wbRb3I65GGKYcPbwDxnqFqE+PGOmD
         mFLytlwUlKfAETWlMSYtd0Ng0GczXzFNFbFlQJmp81QVfq/hBdDcM/p4MQBPzWzkL9za
         6EuirZsdcbsSCB+8Eqn63Kl4mu+3QFW/03pSHVX/0ntRbjTjaCpIFnxtCt4izmJSmdxN
         xd0Q==
X-Gm-Message-State: AOJu0Yxe68XMCyg+gaaVSsy5OvTMNEFxiyH85WU331HTJxv6zZ7tK8pO
	8tZJLk5YAJGoDsAD9I5w74Xxc/Ev6npoOOFTUCdS2BUwWio484bDDEIDhLjReA==
X-Gm-Gg: ASbGncsXi81CSIf9KwH3L5ccVI3cuNx8cNCmfDH5Bdaz45ym4XZ2YgG5HrHtLEtdZNV
	94RUcgnjB3OFWfIUOiyzo3XAYqnva9wcYn9JvJJO+zxD3mdWUJLeVAYFQQa/t8ocAvxeSZMOI+w
	tmQ2LwDks6yNXamGYifL9xE43yYkpqOGDMLsmS3O0F5BT4HkwMaDHodCiel3XJZkQz4411eDt7B
	YPJgMOD1ozgs1RoNZwlfCv7w06iw64BwRshGwDleOO6gz6/FNrzDMK0/FQrJvEXCGRMtAA246v4
	tqcY8TFyb9taLgyxIEKmBiFOd+sKZHjQZ1Px8o1mZQhpiJMX3yNN5PgRUTqgTLmu/TZ9xj8irfD
	DodK1vM3GP96zkA==
X-Google-Smtp-Source: AGHT+IEYaOA20KhjMsHsjMtuHQAMAdokkkrc3swy5czADIcRVp2P5wjdfzxkpw5Gazj28/7q7qOjsw==
X-Received: by 2002:a05:6a00:9088:b0:77e:9ae8:c7d0 with SMTP id d2e1a72fcca58-77e9ae8c98bmr4324703b3a.1.1758306064389;
        Fri, 19 Sep 2025 11:21:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4d::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc72d3e3sm5877220b3a.45.2025.09.19.11.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:21:04 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 3/7] bpf: Support pulling non-linear xdp data
Date: Fri, 19 Sep 2025 11:20:56 -0700
Message-ID: <20250919182100.1925352-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919182100.1925352-1-ameryhung@gmail.com>
References: <20250919182100.1925352-1-ameryhung@gmail.com>
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
 net/core/filter.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 8cae575ad437..6c8a075a3016 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12214,6 +12214,98 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
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
+		if (!sinfo->nr_frags) {
+			xdp_buff_clear_frags_flag(xdp);
+			xdp_buff_clear_frag_pfmemalloc(xdp);
+		}
+	}
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12241,6 +12333,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
+BTF_ID_FLAGS(func, bpf_xdp_pull_data)
 BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
-- 
2.47.3


