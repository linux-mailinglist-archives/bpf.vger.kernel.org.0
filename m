Return-Path: <bpf+bounces-68447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DE8B587CB
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 00:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E825516AC25
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EF52DBF48;
	Mon, 15 Sep 2025 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS8XHuwQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7A12D47F1
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976486; cv=none; b=LBAMicE8sGIY7vWUuH4B3NEUoCMARXToCLfnm/8dvYouS597wqclW+Xw5b1Ig3Jyt9aIMbmIW3twkgz9oZ2h4pA/lzcpzxVP8oCsUD5ucSwyMWtoveXtXECgy26l80HabYmP13mnN7Evq0etvSZM85PwauxuaLkZyNC/1EB07M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976486; c=relaxed/simple;
	bh=PqADVuytLCSFixjsgre0NuqnLXWbEqGLC5ZW3nvlK6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6eca7ry6HOSK2DW4Om4gZ3BhSE15nYCuz1u4/oMkbLzRr4g8LGkEOdLZ9XFN5JiV7E0d1ZOzHNuf7hTCKdyXq5yLLGmXGai15DQjmu22zILCRxU0IHnCXF9710PvCNQmvhtoa0aD1iujnwefveAPazSqT3+Kgixu2PfW3QuTKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GS8XHuwQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-264417f3a26so14187375ad.0
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 15:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757976484; x=1758581284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZATemqB7xyfzlXpuzPYv9jqgsTKcWFN1RS3zoew7LIs=;
        b=GS8XHuwQ6N4NLPnoI3FiTlhiGiwf+yYtcHyq5LNtGpQr/Hmdtn5Fr9z7qze0mlGP4b
         4K3JCisOc0VAWe0V1/kSpr9uYpn1pGyn589hOattW+o/4KrPNPjzj4MGUFqho/hL3C5Z
         R63OAy85ZcAEtXSygDxEisHAncLIdf6A6LLm+vg9kZWnTedfHeJYO8NKwDsAyncdg/99
         uuV8ukl0Wdno39t2d+BTXKQjVR1eOHHmNE/C8WOtf8n2tiLl1X9bD1a5PUtqOM05vlYu
         i70xTyiandZqZj7nzCA37fRpC3GCOAcHIaTuMuogGz8JEFyP7jQygjWQdhWXnLMzMl0o
         yzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976484; x=1758581284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZATemqB7xyfzlXpuzPYv9jqgsTKcWFN1RS3zoew7LIs=;
        b=tOxaNSU+NZVqpWLfWNFSjZ6zMhLl2yBSLexJ3HODfiM2rgj65c6v8OKhBdzLt3aBi1
         HAITQBX0Ij3ZSSVtkg4krCTVU4EmejH3JrwfOwWII0pgBwOJn9MRvFkJ6ESk0915Sq/f
         OEHtqvtMb0bXRbON7aop19hqBbNZ9Q9itT47SnLZ3GI2bnv+7aDh5LYMFq50QppPnuHB
         vMKPuFbnPB6t5yeydcfzHohmHVGCVWm57YZmrH/XfkiJnBFsiJuPeJvc6iixJYWIvpGE
         DSSlD9ZgZ8E+jBHG0a6oDvD9RMJ3Cf/P+pBei8tRJA5hNQPomLROcPNvf5Lq3aRMKcID
         flhw==
X-Gm-Message-State: AOJu0YyHyx1kFzk85V7FZ9ZAQsKfI1m5k1HGd+yEdtE+ChbqxQkzxElc
	uZSzSNfjoV2LRKSY2+zTlkhM9z2PyMUCRktiXVqUPDiQMMwMrOpEIzwqayOTeQ==
X-Gm-Gg: ASbGncuGOlN2dBSFVBsxwKhU09dOWfSkdE6UrVCmO0j50Rb3ORdrVlUtj42vSb32qIN
	XTugpGAmXfHVVjFaJOCqHNxMxOLtVuvnUMNqY5MzAFzucBxg3cgqGAH0E8Z8KNn2HuLqGqHAjzm
	gpnIhf5U27Yo8LTS/7RqnrYqaOqYFcdP+jL3DdGI/erHsMAFNqCJpyy4j9iVjtjfxLm1dWXkmnm
	yB+1ienS4BUcNUlAqLv+iOiCnZeDv+wZcmXyPgcPlU1VtWbzzVYhAQYtO1xVhhcnMiyHaigh4p2
	/kKyQW/W2AsAaHbzRSLM70bu2+Z8W2DnbjM04ReIzq0mubmhvPM+bX5FYzJCWErpLGK6P5x2aos
	rj+M+izIo3+3U5Edn5WPgyq7a
X-Google-Smtp-Source: AGHT+IFXN3/ckPvLsJL6xQ4zrXgiAV8E2rtnlNd8kU63QP/WEhESIpkUBgDk5raYysiF+uUTf/U6FA==
X-Received: by 2002:a17:902:dac2:b0:24b:1625:5fa5 with SMTP id d9443c01a7336-25d242f2f21mr190289945ad.11.1757976484358;
        Mon, 15 Sep 2025 15:48:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a7a0sm142004205ad.89.2025.09.15.15.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:48:04 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/6] bpf: Support pulling non-linear xdp data
Date: Mon, 15 Sep 2025 15:47:57 -0700
Message-ID: <20250915224801.2961360-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915224801.2961360-1-ameryhung@gmail.com>
References: <20250915224801.2961360-1-ameryhung@gmail.com>
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

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/core/filter.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 0b82cb348ce0..3a24c4db46f9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12212,6 +12212,100 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
 	return 0;
 }
 
+/**
+ * bpf_xdp_pull_data() - Pull in non-linear xdp data.
+ * @x: &xdp_md associated with the XDP buffer
+ * @len: length of data to be made directly accessible in the linear part
+ *
+ * Pull in non-linear data in case the XDP buffer associated with @x is
+ * non-linear and not all @len are in the linear data area.
+ *
+ * Direct packet access allows reading and writing linear XDP data through
+ * packet pointers (i.e., &xdp_md->data + offsets). The amount of data which
+ * ends up in the linear part of the xdp_buff depends on the NIC and its
+ * configuration. When an eBPF program wants to directly access headers that
+ * may be in the non-linear area, call this kfunc to make sure the data is
+ * available in the linear area. Alternatively, use dynptr or
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
+	int i, delta, shift, headroom, tailroom, n_frags_free = 0, len_free = 0;
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	void *data_hard_end = xdp_data_hard_end(xdp);
+	int data_len = xdp->data_end - xdp->data;
+	void *start, *new_end = xdp->data + len;
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
+
+		new_end = data_hard_end;
+	}
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
+	xdp->data_end = new_end;
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12239,6 +12333,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
 BTF_ID_FLAGS(func, bpf_dynptr_from_xdp)
+BTF_ID_FLAGS(func, bpf_xdp_pull_data)
 BTF_KFUNCS_END(bpf_kfunc_check_set_xdp)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
-- 
2.47.3


