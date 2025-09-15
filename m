Return-Path: <bpf+bounces-68449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1436AB587CF
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 00:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226DD485BB0
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D922DCF43;
	Mon, 15 Sep 2025 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBdNYCNa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B8C27280E
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976488; cv=none; b=U97SW+985RpaLBFUKexXffUGK1cHtTQQAnhw+SRXNIe+MnNuZ+Wi3Lj+qyO+Np4aksflmI8NwuhiIvszfYdfW7/AtP1y8u0otLuZjyUeYDZZwHZrEh4lHj3WiStSqqcW39ylwGqcRZksWGIkZLSimX4NuvSR80AdXzt+naB1dNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976488; c=relaxed/simple;
	bh=a25z9lWHwSLwEwVO7UXaBCZlb38BPen7xABJy8siw3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q78XZLmPRq0NZ91D7/fy8yb+Az79F5z8gkz5QsJiJbl0hJeVFC3Jk+HskBaVhzoZlZ+sAQZgIxQfCUmXjqGcOAK9+q+zHTDBWOL9K8Ap2neHj5QbtgXyGY31SK58XhhwW8EWScMPGq38SA0Jn/ZvUNE9prslXjV9UutLnq60Xsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBdNYCNa; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so3776269b3a.3
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 15:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757976486; x=1758581286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KG/V8VI1NvEDj89ozrGU5xrPqPt/CmsQnzTihAWPWg4=;
        b=DBdNYCNaSsCbb7N8uksaFrmFgzufGiay4eGGRjQAQy9ON3rF87C2pES+SoY/9QmPHu
         Il5j3/t0qfXssHchWSd/DKSDsPZg9UoWBcDbg6CghNmIn613tb6W+IDYoRM/1uMDXFeo
         ZQF5l2j6TA8xKU70m0nyk6UvAt6CQqsfsaPpEfiXmN1f2eKXCl3On0NkZduV92xHr93x
         +6ds00clODlHu0OVYnhFHIJ/NqAp3AZQxht+S0JUd4qOXdULeyFDB3/rNUBV2FjI/0tk
         VV51aYo6g/gB0c9kKc3YldClnLrYr/lT36G7d8liOvWZB3BGuDauWpGED8x44zo0QSoZ
         zl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976486; x=1758581286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KG/V8VI1NvEDj89ozrGU5xrPqPt/CmsQnzTihAWPWg4=;
        b=wZJO7FXjkghLpHAMOJI8bdP3h+hdNolAdbf4t0cv8H4WcavSIUZbVkBu4bIn/9rL0w
         vNqr/MBo+apVANsObrF3wQZK4EgRdIOaZO9/JIBmp7xSDb1BqxgzJO+j8Mod/srxfTgE
         AckLNPlnRUvzM+zUIMgN03irCc/olNt31AmwFYRIw6dyWg/1JmP2tCgoebIpUlX1Wp+P
         7u5KEJjExpzuZIcTJlZrTAhk3gXLZ8Zbqcu/KxkXuz4nzV0VopluGQGTz+J8xeOrfL7n
         ZeFn9TKvXo+tnSiw7hpnMAUk6MIBkx6ff3sVnZzn2/IgJ4PRGdddL6vNOSGanrfK6PM2
         o2RQ==
X-Gm-Message-State: AOJu0YwictNrsEq+Nimzu0wyba8GFSKOsMHosavvDBqryWIN2KpELWH+
	4as6cLqcLcMXkVFZacnChPgB0bV39Tl2Y5KP9Y56g5YdRxdvkDgI5T/nITrf5Q==
X-Gm-Gg: ASbGnctPTluBG8riqLPxY+nHoP8N54nwHbpVfETj+NxKsMBoUYrGbzULyCCMYeEUVh4
	VJbvaXi1YkgTpf1VrLtXohorRBzMYw/2CmNVGtogfIkktPowD3QBXebxCOrlPS/KZDeeBDcKmT4
	VybArym+5ln8+j/JLBmY9OSpfzcDrZawl7FGSob3Ooyrmo8DAsixyGccfYaerBUcd8hMHqZNffz
	aY/mYIpfe1+WuBTlRrEImUgjcOh/N+z8Fr354kNmcPqUbzbO095Jty5oxPjSoUVmv8ohJdxfBlG
	0yK19/cVTn3UUkZ7Qxj26ndzYvloV9/1CGxJ66a2W6eVTifqRlnk3r5ELTI+DvnPx1snuyGG81/
	BuVCbB9nWQI0objdjcBE1soUv
X-Google-Smtp-Source: AGHT+IF4oPFVHHsqemlF3ZVB7aYy+y/ly0Bgs0DmiSr6yGWNENiWtDSGMTEPMblAbxpY5niaackglQ==
X-Received: by 2002:a05:6a00:139a:b0:774:2274:a555 with SMTP id d2e1a72fcca58-77612167d2fmr17691933b3a.15.1757976486186;
        Mon, 15 Sep 2025 15:48:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c474ccsm14385183b3a.100.2025.09.15.15.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:48:05 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 4/6] bpf: Support specifying linear xdp packet data size for BPF_PROG_TEST_RUN
Date: Mon, 15 Sep 2025 15:47:59 -0700
Message-ID: <20250915224801.2961360-5-ameryhung@gmail.com>
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

To test bpf_xdp_pull_data(), an xdp packet containing fragments as well
as free linear data area after xdp->data_end needs to be created.
However, bpf_prog_test_run_xdp() always fills the linear area with
data_in before creating fragments, leaving no space to pull data. This
patch will allow users to specify the linear data size through
ctx->data_end.

Currently, ctx_in->data_end must match data_size_in and will not be the
final ctx->data_end seen by xdp programs. This is because ctx->data_end
is populated according to the xdp_buff passed to test_run. The linear
data area available in an xdp_buff, max_data_sz, is alawys filled up
before copying data_in into fragments.

This patch will allow users to specify the size of data that goes into
the linear area. When ctx_in->data_end is different from data_size_in,
only ctx_in->data_end bytes of data will be put into the linear area when
creating the xdp_buff.

While ctx_in->data_end will be allowed to be different from data_size_in,
it cannot be larger than the data_size_in as there will be no data to
copy from user space. If it is larger than the maximum linear data area
size, the layout suggested by the user will not be honored. Data beyond
max_data_sz bytes will still be copied into fragments.

Finally, since it is possible for a NIC to produce a xdp_buff with empty
linear data area, allow it when calling bpf_test_init() from
bpf_prog_test_run_xdp() so that we can test XDP kfuncs with such
xdp_buff.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/bpf/test_run.c                            | 26 ++++++++++++-------
 .../bpf/prog_tests/xdp_context_test_run.c     |  4 +--
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 4a862d605386..558126bbd180 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -660,12 +660,15 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_memb_release, KF_RELEASE)
 BTF_KFUNCS_END(test_sk_check_kfunc_ids)
 
 static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
-			   u32 size, u32 headroom, u32 tailroom)
+			   u32 size, u32 headroom, u32 tailroom, bool is_xdp)
 {
 	void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
 	void *data;
 
-	if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - tailroom)
+	if (!is_xdp && user_size < ETH_HLEN)
+		return ERR_PTR(-EINVAL);
+
+	if (user_size > PAGE_SIZE - headroom - tailroom)
 		return ERR_PTR(-EINVAL);
 
 	size = SKB_DATA_ALIGN(size);
@@ -1003,7 +1006,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	data = bpf_test_init(kattr, kattr->test.data_size_in,
 			     size, NET_SKB_PAD + NET_IP_ALIGN,
-			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
+			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
+			     false);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
@@ -1207,8 +1211,8 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 {
 	bool do_live = (kattr->test.flags & BPF_F_TEST_XDP_LIVE_FRAMES);
 	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	u32 retval = 0, duration, max_data_sz, data_sz;
 	u32 batch_size = kattr->test.batch_size;
-	u32 retval = 0, duration, max_data_sz;
 	u32 size = kattr->test.data_size_in;
 	u32 headroom = XDP_PACKET_HEADROOM;
 	u32 repeat = kattr->test.repeat;
@@ -1246,7 +1250,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	if (ctx) {
 		/* There can't be user provided data before the meta data */
-		if (ctx->data_meta || ctx->data_end != size ||
+		if (ctx->data_meta || ctx->data_end > size ||
 		    ctx->data > ctx->data_end ||
 		    unlikely(xdp_metalen_invalid(ctx->data)) ||
 		    (do_live && (kattr->test.data_out || kattr->test.ctx_out)))
@@ -1256,14 +1260,15 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	}
 
 	max_data_sz = PAGE_SIZE - headroom - tailroom;
-	if (size > max_data_sz) {
+	data_sz = (ctx && ctx->data_end < max_data_sz) ? ctx->data_end : max_data_sz;
+	if (size > data_sz) {
 		/* disallow live data mode for jumbo frames */
 		if (do_live)
 			goto free_ctx;
-		size = max_data_sz;
+		size = data_sz;
 	}
 
-	data = bpf_test_init(kattr, size, max_data_sz, headroom, tailroom);
+	data = bpf_test_init(kattr, size, max_data_sz, headroom, tailroom, true);
 	if (IS_ERR(data)) {
 		ret = PTR_ERR(data);
 		goto free_ctx;
@@ -1386,7 +1391,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	if (size < ETH_HLEN)
 		return -EINVAL;
 
-	data = bpf_test_init(kattr, kattr->test.data_size_in, size, 0, 0);
+	data = bpf_test_init(kattr, kattr->test.data_size_in, size, 0, 0, false);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
@@ -1659,7 +1664,8 @@ int bpf_prog_test_run_nf(struct bpf_prog *prog,
 
 	data = bpf_test_init(kattr, kattr->test.data_size_in, size,
 			     NET_SKB_PAD + NET_IP_ALIGN,
-			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
+			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
+			     false);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index 46e0730174ed..178292d1251a 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -97,9 +97,7 @@ void test_xdp_context_test_run(void)
 	/* Meta data must be 255 bytes or smaller */
 	test_xdp_context_error(prog_fd, opts, 0, 256, sizeof(data), 0, 0, 0);
 
-	/* Total size of data must match data_end - data_meta */
-	test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32),
-			       sizeof(data) - 1, 0, 0, 0);
+	/* Total size of data must be data_end - data_meta or larger */
 	test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32),
 			       sizeof(data) + 1, 0, 0, 0);
 
-- 
2.47.3


