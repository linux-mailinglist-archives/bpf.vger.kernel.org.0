Return-Path: <bpf+bounces-67592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42090B4603F
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 19:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E08A1BC8DF8
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 17:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DF3374266;
	Fri,  5 Sep 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRA1cHUS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAAC370582;
	Fri,  5 Sep 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093638; cv=none; b=PRWxk1Bjdft/L6VNHylfa1F+t92gREw2YpOgXqll/vnC73EnaWJ5SgL9vHiOWbptX9P29T8WmxL2Ai1aPbUHZYG7t6CLb9RDxQAXmtdR58D8005DxMMTlpWHjQNJV1SI3oyD/0Xq3LeDxOp9/4outMgv3LbcOxRjuv5ev6NTMXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093638; c=relaxed/simple;
	bh=LzQy0pVG8jDpSVSsshjjYAGUrg5xTH5hL32Y5iNJ/dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8zun5tReNN7WAzGVIWpOeb6HfaWN18FDNWftys8sZSE9C11tJNsqZ1NONXYIAEX5ZUzXno++IzHfqRrtwl+zWIZ4M2L3VoI/fFtk4vcBclHmIKNLMIfclIBilwa0vxaZEVwnH/rFtA/iR6rRRw74umH5BlEcMjuQ5KNhNJ0P28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRA1cHUS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24cb39fbd90so22084365ad.3;
        Fri, 05 Sep 2025 10:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757093636; x=1757698436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlQOKqxeR7woeUk2ysnlHWTeH6hXIr2UsxbN7U6VrVw=;
        b=bRA1cHUSFRN3hJkpFiMKj9MCPN9iEvPSnGf4a+i+KMEed1uLMwb25Sy5CjYCUlK8IX
         4bkGREUsHBbqxHB24bnWDRNRD2H7HGS6FIQ/J58wu4kA77QtfPxcoKzx1n6dtlMmCKLB
         BcTcqQkZBmhh1jN9N4udhcJQJlpKGOb2GP/B7872N21ujymB0iy6DdkSGbRKe3v/eG8w
         G2HMGuyADfW0dZmbOmizaF5pDKZR/bmsGm0Q8Sw5cdePEpaSvABYONlOpOK3Gc7oRkGs
         Z1Vf2b5/Ahp510rwNMHRpneDrdveUWorWdE9ZIwYSIWhK77MnCcaMpQh8c21TX4l6r1U
         IxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757093636; x=1757698436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlQOKqxeR7woeUk2ysnlHWTeH6hXIr2UsxbN7U6VrVw=;
        b=tyVFlbWyQsrSP/Aw4sroXmLZMLxucJHJB8fCVic9S/OoIlZmArqXve+2DKu3NCKaxQ
         TEBsjc+GJJKucnnaWoFN5IDRH+jpCriJFO/ZQBOajS4e+WN9qFdYKkoy9kvcUNJwjB1T
         kSxnBp0MArwJPgdevi7pFhWBBtFwJ44F3t+azx4qJOYny64s2TPust2MhcrlbjJqGxjy
         xwDGlDhqB5SqDZeH2fSy54lZYVdoDO9Katn7QNqfKs1vOwpG/7c305vmUkmCBzHUmGvB
         RGUO37Hvss+MBPNt2uPpMl+b7CVxhPC/aacXwpC68JPuYnCptk6zEp60jaN1q/uc/u5Y
         Sc2g==
X-Gm-Message-State: AOJu0Yy19nh9S1iQk2KYCZ8qDHzaauP7qARl73bvC7LlhfC08qPEg2Fl
	EG9jzFCfo5whchIJy2hneTYW+c+EKgEfdwcmKa4Xook9hypX7q3D8J842Os6lA==
X-Gm-Gg: ASbGnct9uD6DwBF0F7WN55tSV8zJrYuTTp3OfpbDD0o3bw/GqSgS+9bymjmVm6sxBmu
	U52ZnYn7LI7swqoLyhxr2TtmKqdbeqZ9EY6RMo3qmb7DqB3VdNaUh7HSUg6gpZKA+zFUh2be2mK
	gbZOItCN2DqdyHLlHMYjF+qwxwLIyUybMT+d7FTpDJaU6HOjpfsEVCw1v9saynGcpn8Y0ZnagaX
	pvSQgY/1XIlyo1O4WOCQGTnCs26fB9r8jL+bgPJiApdu87MRBxUJEfGk7qGilJyb6LGJx5jTRr9
	9HWiBL8DwAV5NLkT6n4PwZGf6vtsxrlZIX6C2XbG+2jaP34hMZUz+Amyu5FgIdYRLw6nSwRMQIM
	Z3MidImo7+LcGtA==
X-Google-Smtp-Source: AGHT+IFYHXjF7AiAW2NGS4uharmTP6y6Ny47+guTe9B6JHDplNgebrEaCFhrL9xbu1hxAPljLWtpcw==
X-Received: by 2002:a17:902:ce06:b0:24c:caab:dfd2 with SMTP id d9443c01a7336-24ccaabe07emr78251965ad.61.1757093636405;
        Fri, 05 Sep 2025 10:33:56 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b11833a47sm109831605ad.53.2025.09.05.10.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:33:56 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
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
Subject: [PATCH bpf-next v2 3/7] bpf: Support pulling non-linear xdp data
Date: Fri,  5 Sep 2025 10:33:47 -0700
Message-ID: <20250905173352.3759457-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250905173352.3759457-1-ameryhung@gmail.com>
References: <20250905173352.3759457-1-ameryhung@gmail.com>
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
 net/core/filter.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 0b82cb348ce0..0b161106debd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12212,6 +12212,81 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
 	return 0;
 }
 
+/**
+ * bpf_xdp_pull_data() - Pull in non-linear xdp data.
+ * @x: &xdp_md associated with the XDP buffer
+ * @len: length of data to be made directly accessible in the linear part
+ * @flags: future use, must be zero
+ *
+ * Pull in non-linear data in case the XDP buffer associated with @x is
+ * non-linear and not all @len are in the linear data area.
+ *
+ * Direct packet access allows reading and writing linear XDP data through
+ * packet pointers (i.e., &xdp_md->data + offsets). When an eBPF program wants
+ * to directly access data that may be in the non-linear area, call this kfunc
+ * to make sure the data is available in the linear area.
+ *
+ * This kfunc can also be used with bpf_xdp_adjust_head() to decapsulate
+ * headers in the non-linear data area.
+ *
+ * A call to this kfunc is susceptible to change the underlying packet buffer.
+ * Therefore, at load time, all checks on pointers previously done by the
+ * verifier are invalidated and must be performed again, if the kfunc is used
+ * in combination with direct packet access.
+ *
+ * Return:
+ * * %0         - success
+ * * %-EINVAL   - invalid len or flags
+ */
+__bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len, u64 flags)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)x;
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	void *data_hard_end = xdp_data_hard_end(xdp);
+	void *data_end = xdp->data + len;
+	int i, delta, n_frags_free = 0, len_free = 0;
+
+	if (flags)
+		return -EINVAL;
+
+	if (unlikely(len > xdp_get_buff_len(xdp)))
+		return -EINVAL;
+
+	if (unlikely(data_end < xdp->data || data_end > data_hard_end))
+		return -EINVAL;
+
+	delta = data_end - xdp->data_end;
+	if (delta <= 0)
+		return 0;
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
+	sinfo->xdp_frags_size -= len_free;
+	xdp->data_end = data_end;
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12239,6 +12314,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
+BTF_ID_FLAGS(func, bpf_xdp_pull_data)
 BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
-- 
2.47.3


