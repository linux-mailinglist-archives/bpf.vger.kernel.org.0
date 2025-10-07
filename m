Return-Path: <bpf+bounces-70506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DD1BC1890
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 15:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BDD94F63F1
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 13:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CBD2E1737;
	Tue,  7 Oct 2025 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYfOL4o2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F7919755B
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844300; cv=none; b=TX3hwK0X4gfIM5nkUgG57nohZsZPBHMzOZC+y77s8wUErAzh96w1wHKn2FBj8NGzerZBL6OnB+99ejeoWoWNx7excrxDZ5T8e8rPd67kzL0aGH10yxHT/1E5kM80v+twxAMa/YweB+FMxsCQpCwNoAATrFCCdCrLVxDRcEi1NhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844300; c=relaxed/simple;
	bh=H43nY8Pezz3wueotZRHqRJG5DOYHY1gpApWftSTnBww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUHRyA9IY6NCkOvi6/u3d+9Xz3iClXVRIwkrFz0l+sUbW/dPbnlg8zX4fQQ+qBeTGCQxHIw8VvMdX5IJnyeAmz2HZtut/BwllgGex6GGpMTRMoUJ5FDFSaW4xnFwAR7WsfWU0XBQwO9Oj/mmko6ThObpBHlneHobcm7egaF0pCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYfOL4o2; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f44000626bso4048507f8f.3
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 06:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759844296; x=1760449096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A9rp+yjRrMywKbiM0Wx6YLvEQdEziOs4NoZkWEUPV3E=;
        b=LYfOL4o26qoXUCGxD23WG1r/UX61frzQS56JQr+ywdFzzPF2rW3CQMaBJ55NtwUGwN
         ZGDlYdTqr5GD578Ijb6zMdzeGnImWJUVhNXExTMmxIy04Mm3cr0MXiWhMlAGjiIuHWFk
         U+AgH/hoWRltg8TBX58cECMWD9YbINadO2bz5FZg4cQ/vy35cZniEJo4a3NQH8BH06T4
         c2AZV1tcmtCarv5H2Pj7keUmoceHgD3jxvJRoe0TKFnDQObCZ/nlV2zJ3XIMx/+924UG
         pqHBf9px1qE4dE6W/VYk1dfzPwYbdPpxucSrIUgO3kKbH2uYtPL2ZU+PrgU4+Y73QiJY
         iQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844296; x=1760449096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9rp+yjRrMywKbiM0Wx6YLvEQdEziOs4NoZkWEUPV3E=;
        b=XU1MDp9PGp5V8fYUgcLmEMdOmak4VqXGGLPGl6o4YWcwX3DsEx0j9UT4VUlGqfNC0c
         VOcgcm3VC2YN+v91ae+YTEVxpKFYN3Ybg8CKoX7gSZy9l3fI8CpNsoJQu4Mnwoc8CxGR
         KbrowRpwH4Q5cORz5dW6azGpqrEjODQXD7mc99O3Pu479dgdaN9lL37qVujevG3F5PYe
         I1WafIVqM2QhSrSlSs0ZsTY03iIZMIre27kMV+CDvBs9Xgwsu6DKhbOLCWax5ou2QlHK
         VBG2h/KvCg8DKFLx5j5Tqgnmjrxo3eVina0F+zeaN6sN2b/vYiSVEl5f1D6RIC7PhgfK
         URvQ==
X-Gm-Message-State: AOJu0Ywut6pNsldO83irvQeL68MawR2JC45wFsAf3OzL/Gq9k5qp2bVV
	8NMRrwc2zz7HfpPCJCsOwrO8VqKrK6fVyT7F/J6ehdFnjaTqQwCwduwgVzfNJbRw
X-Gm-Gg: ASbGncsGvRJD4YlgJWQDnNcij6jzEqIbt7/dcxPrYRuc4OXTrAeQC05buFd+WfK7hQm
	MHdsK0O7XIuAD2iUlzmm59xfL61VRw2us5Z7C197bUjlzJuKk+np79C56Z5mOswHwvio/xWNrdB
	qHbFuqRSkXj77WpJzDLfNn9EtrGLCGyVTFh/6LBHGH4gozv6PQ2U3Qz8Q3B8nz2FOFnqlG6RAXG
	Fp1p9yHD+8WFfUzs8HZZMyKTKrbulvO5tM1Bn3eyEQ0PMSrEzUXWYSwHqHsrT5iGz2q3Q24J5oh
	mH/5PFrDfDqHNZBf76hIwYCeAZUxqrIz5mKWSxNyWVOlRi6UbuH03xKsrC3IfDO1ItIjQXcCn+r
	2rK3dO3X0LVGdLBTPXWlhOgngDOd70DN7N0Y8qplSV0/P2+csXTQpyOfXPbEUjeM3rpxZMRTpN7
	CPEkjygd4M7ynZqzEdmsoSf8RjSAYS80s3hzYTmYJQxFXw+w==
X-Google-Smtp-Source: AGHT+IHaBIFw4emFolb6J5A3iPzmOZ92sVUme0pZmQbil5ueOGQFzWGIEO+vazKPn62M03Q05GXTqg==
X-Received: by 2002:a05:6000:420d:b0:425:8bc2:9c4b with SMTP id ffacd0b85a97d-4258bc29dc8mr508399f8f.6.1759844296310;
        Tue, 07 Oct 2025 06:38:16 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0079f574fca42e1d7a.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:79f5:74fc:a42e:1d7a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8b0068sm25614378f8f.26.2025.10.07.06.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:38:15 -0700 (PDT)
Date: Tue, 7 Oct 2025 15:38:14 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v6 3/5] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
Message-ID: <8347068dc4ee9030be13e886c05d59d3ef1ce949.1759843268.git.paul.chaignon@gmail.com>
References: <cover.1759843268.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759843268.git.paul.chaignon@gmail.com>

This patch adds support for crafting non-linear skbs in BPF test runs
for tc programs. The size of the linear area is given by ctx->data_end,
with a minimum of ETH_HLEN always pulled in the linear area. If ctx or
ctx->data_end are null, a linear skb is used.

This is particularly useful to test support for non-linear skbs in large
codebases such as Cilium. We've had multiple bugs in the past few years
where we were missing calls to bpf_skb_pull_data(). This support in
BPF_PROG_TEST_RUN would allow us to automatically cover this case in our
BPF tests.

In addition to the selftests introduced later in the series, this patch
was tested by setting enabling non-linear skbs for all tc selftests
programs and checking test failures were expected.

Tested-by: syzbot@syzkaller.appspotmail.com
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 net/bpf/test_run.c | 82 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 8 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index b9b49d0c7014..0cdf894c1d05 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -910,6 +910,12 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
 	/* cb is allowed */
 
 	if (!range_is_zero(__skb, offsetofend(struct __sk_buff, cb),
+			   offsetof(struct __sk_buff, data_end)))
+		return -EINVAL;
+
+	/* data_end is allowed, but not copied to skb */
+
+	if (!range_is_zero(__skb, offsetofend(struct __sk_buff, data_end),
 			   offsetof(struct __sk_buff, tstamp)))
 		return -EINVAL;
 
@@ -984,9 +990,12 @@ static struct proto bpf_dummy_proto = {
 int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 			  union bpf_attr __user *uattr)
 {
-	bool is_l2 = false, is_direct_pkt_access = false;
+	bool is_l2 = false, is_direct_pkt_access = false, is_lwt = false;
+	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	struct net *net = current->nsproxy->net_ns;
 	struct net_device *dev = net->loopback_dev;
+	u32 headroom = NET_SKB_PAD + NET_IP_ALIGN;
+	u32 linear_sz = kattr->test.data_size_in;
 	u32 size = kattr->test.data_size_in;
 	u32 repeat = kattr->test.repeat;
 	struct __sk_buff *ctx = NULL;
@@ -1007,11 +1016,14 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	switch (prog->type) {
 	case BPF_PROG_TYPE_SCHED_CLS:
 	case BPF_PROG_TYPE_SCHED_ACT:
+		is_direct_pkt_access = true;
 		is_l2 = true;
-		fallthrough;
+		break;
 	case BPF_PROG_TYPE_LWT_IN:
 	case BPF_PROG_TYPE_LWT_OUT:
 	case BPF_PROG_TYPE_LWT_XMIT:
+		is_lwt = true;
+		fallthrough;
 	case BPF_PROG_TYPE_CGROUP_SKB:
 		is_direct_pkt_access = true;
 		break;
@@ -1023,9 +1035,24 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	data = bpf_test_init(kattr, kattr->test.data_size_in,
-			     size, NET_SKB_PAD + NET_IP_ALIGN,
-			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
+	if (ctx) {
+		if (ctx->data_end > kattr->test.data_size_in || ctx->data || ctx->data_meta) {
+			ret = -EINVAL;
+			goto out;
+		}
+		if (ctx->data_end) {
+			/* Non-linear LWT test_run is unsupported for now. */
+			if (is_lwt) {
+				ret = -EINVAL;
+				goto out;
+			}
+			linear_sz = max(ETH_HLEN, ctx->data_end);
+		}
+	}
+
+	linear_sz = min_t(u32, linear_sz, PAGE_SIZE - headroom - tailroom);
+
+	data = bpf_test_init(kattr, linear_sz, linear_sz, headroom, tailroom);
 	if (IS_ERR(data)) {
 		ret = PTR_ERR(data);
 		data = NULL;
@@ -1044,12 +1071,49 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		ret = -ENOMEM;
 		goto out;
 	}
+
 	skb->sk = sk;
 
 	data = NULL; /* data released via kfree_skb */
 
 	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
-	__skb_put(skb, size);
+	__skb_put(skb, linear_sz);
+
+	if (unlikely(kattr->test.data_size_in > linear_sz)) {
+		void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
+		struct skb_shared_info *sinfo = skb_shinfo(skb);
+
+		size = linear_sz;
+		while (size < kattr->test.data_size_in) {
+			struct page *page;
+			u32 data_len;
+
+			if (sinfo->nr_frags == MAX_SKB_FRAGS) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			page = alloc_page(GFP_KERNEL);
+			if (!page) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			data_len = min_t(u32, kattr->test.data_size_in - size,
+					 PAGE_SIZE);
+			skb_fill_page_desc(skb, sinfo->nr_frags, page, 0, data_len);
+
+			if (copy_from_user(page_address(page), data_in + size,
+					   data_len)) {
+				ret = -EFAULT;
+				goto out;
+			}
+			skb->data_len += data_len;
+			skb->truesize += PAGE_SIZE;
+			skb->len += data_len;
+			size += data_len;
+		}
+	}
 
 	if (ctx && ctx->ifindex > 1) {
 		dev = dev_get_by_index(net, ctx->ifindex);
@@ -1130,9 +1194,11 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	convert_skb_to___skb(skb, ctx);
 
 	size = skb->len;
-	/* bpf program can never convert linear skb to non-linear */
-	if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
+	if (skb_is_nonlinear(skb)) {
+		/* bpf program can never convert linear skb to non-linear */
+		WARN_ON_ONCE(linear_sz == size);
 		size = skb_headlen(skb);
+	}
 	ret = bpf_test_finish(kattr, uattr, skb->data, NULL, size, retval,
 			      duration);
 	if (!ret)
-- 
2.43.0


