Return-Path: <bpf+bounces-69290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8667B93974
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C19481038
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 23:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7523303CB7;
	Mon, 22 Sep 2025 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgKShJtu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5162FC00D
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 23:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584043; cv=none; b=duDBVZVqbPXMkHpdT6GmTeDxXTmvGaCt8yplFqVRBrZWWc1q2x/HMRRVtIQFOiF+nL5xTLMP6dRgtd2ldc9/GBArZain4SUoimmkjj1CklZqkUkQFwTvVodwU2E2KL7+sah5SXgpa2nnt4EJNi73hX+ELiBiyw1s3C0oifnB3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584043; c=relaxed/simple;
	bh=+yQ2t/9d9UA/mVKr5d0OjMVjTE9IXyYN7Q4NbTHwiPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8I1TynRkb/Wsvdfrp+02gNWjtdMcK9jAe2LDz+KkSO0h3jpHPGYEkNEu8j/s01bcFWXeTZEhNOer7ttZD9zYrczM8YKZjVSFYqZg8gmQM7spzjiNQRO3v7FyYNL20W0jY013hsPVbSNTfTLCWM9o6hm6s8pwh/LB+ma9U+VuvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgKShJtu; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7761b83fd01so4625306b3a.3
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758584041; x=1759188841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLUY+Ej39kKeF/fRLSX0Y2NuiiPlaB3PPnfSYtai7d0=;
        b=mgKShJtuuadw3MneHqRlbpo29rPCMKOasmKgzEiLSha3hu1wYkbmU49Vjo+xasMfBP
         IlmUG0e0bjmG13JD6zBBlOpqzUKsJrCVwsUXz+a9aAh/i/TMgxX+2UX12LKceTF4TVUa
         HcyXplIl/cd8hePE6pejO37DzdUPusV7jogCN3qJLF5dMNMwvGxwyFPYVPXu4G9hp/KQ
         j4Q1OTwnuuITBTdX2a6919HKbMnu0i2mXka4pO8DEf0PtfGpQ+ulyoawrvHsAtl+sV07
         HlZQg8F5RVPpfWaJlnGulgtPV2UJfzsJFNFfoSmuKqvezy0oUkNlVRNGdl2GTPg2xutt
         0I0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758584041; x=1759188841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLUY+Ej39kKeF/fRLSX0Y2NuiiPlaB3PPnfSYtai7d0=;
        b=W+2vyXlJ36vyVmnXGy3RC8jwwKFRpB5O/SQaXd/O6FiHgLAfgaME6VQbZDW+tKGH3c
         iwESVP7GqFtlxJG+5cdJ3YnvzFzx8Ck87d5P09F85rTnxZaxxv6ZDL0CMfGj7p2catJl
         zDoTH4nqOZrIRvSxLECW7ZhqqjdoLdMQXl/aP86xQZN5Xj0l2zuScCgqoy+HnHszua+R
         TL/S9F88NPqd5VOOhbJKMfgkwxs/kfXgBpLDajyO12OpdblKPH4tYPjuzsJ9B88nzaO7
         Zuk02jq7wej4sIzTwOQJBosjgmj0ulQR2yaLKI9Jm5zgKdLYhrkUG5liIeIlVdkAK7+o
         R4IA==
X-Gm-Message-State: AOJu0YzMSSyMqYN5Yrb0SK47fNAhrMkf0LlXeHhps2UABY0ZqFPmoQyU
	KcTderScPkPPtTCCJd3rV7wtaLB2ZrKgYsX68U+4iF3x5oBDdfma605cmpaKUw==
X-Gm-Gg: ASbGnctLpbKgF4SUZvSquxns8LxhsX4fU8GJ2vsroJ/8LZ9z5kKrzp73XQJKF9PAlCW
	qdpyvfTTC3pr8gRE4VdKsQbbALuRcFrE+QMGPDXNcG2No4Jp0f1X4f3ZIS6fYDTZIUUgwO8gjS/
	z2oHMGEg6+OOdjXDtnmgfPYZ65Bytiml7Bl0sAM2BNzO8lZHelId5t7BlebXHTAvogExWWPFmHg
	zJ1WjNHHgE1Rl9kDvpkxQ35uMk+kvwieofh+n8/Avhw4Kh5gzO3umIj+qoLrPkbjmUZ1zbSQgaM
	zjmHJbgcqtm+yckRJTxozIiRDSV+Qd2F47VUskz9fGqCyKOF6RRyzaezV/tXFDgq9/SjUmfU4Or
	oE9K9Go2lasWL4wEHXRm3ytOK
X-Google-Smtp-Source: AGHT+IFoCtVuw/WPBDl4DK2nNMQ3ZRj29mq3ZQRbWqE5a+3AvTmRqEflYEPDoaAsi1i4AlgCH9Rs/g==
X-Received: by 2002:a05:6a00:23c6:b0:77f:1ef8:8ac3 with SMTP id d2e1a72fcca58-77f53a2e132mr605371b3a.16.1758584040672;
        Mon, 22 Sep 2025 16:34:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e87fb4698sm10438426b3a.96.2025.09.22.16.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:34:00 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 3/8] bpf: Support pulling non-linear xdp data
Date: Mon, 22 Sep 2025 16:33:51 -0700
Message-ID: <20250922233356.3356453-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922233356.3356453-1-ameryhung@gmail.com>
References: <20250922233356.3356453-1-ameryhung@gmail.com>
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


