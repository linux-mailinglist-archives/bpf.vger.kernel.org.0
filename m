Return-Path: <bpf+bounces-67437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED782B43B28
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 14:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E495E620D
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 12:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767142D3720;
	Thu,  4 Sep 2025 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mq5H4ZOC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D82C21D8
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987875; cv=none; b=mX7KxNzYkADY+HfLBdBJYU2tr9rEoeHvis/zPBzuJZztaTDBiVYAUtTq07aUhOOnhltKuYDsX5PqG1lrlAe2xkARS0xrb2SUJ/xUyJ1iY3JYWxUDAUYUK+PFj841XJdT0RHGU2patxdCnAEax5KOT6K/9GKp/A0dl55KKLP1EfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987875; c=relaxed/simple;
	bh=8bWQJqgrZFomkF3ios8Q4MBNVmePw/zLWxAe/7RPV8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOfUntZc7GsIJYlse8APfoEwgtP9qOTS0/PIqPMqF1pnavmFCmSKH6KhuAsdg4D+AjoZ4ICEUtOlRZW6MMPpkALf1VvJ+EE4rLHlGBvuwItqhTRv+AKmxTOc+ofMcCbQvmM/CwvygHDpCi9Vco076uLPBjjAi+aDbi3oo9HYeoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mq5H4ZOC; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3df2f4aedc7so581726f8f.2
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 05:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756987871; x=1757592671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=96aWoL2EyQ5XT7dLTbfi7TiLaaZnuE1QxuiitVbAis4=;
        b=mq5H4ZOC4nk0OjfmOYaLJ6d20ThWdrGWFN86uaooAA+BdUqCuteG4LIOh7THhFYVF/
         g+YT0Xk5r06WeBcgQTdUyauJE3XQWNVfe2uVx1H2aWCDPD4BCO/h3KiW2uFNu8KowOUp
         lVQOSEyELmGgGxhCp+1PwpnFdXj+xFmDTgAL+z1dNocbsXOctw5ZKizczIfeNwNYuztV
         gSYeHabsqED/cN7jKhPQT9t8T20mfL2WYzrwS2jmkZ9unuFJKY+1HUIAiIzL+Ojp3GJi
         H3xcB4Kx0AH11DKTZMbk5PsaNehJBTaLDtxc6WxZtTPhq34uQ95m1HWrmxLc2PBeBfiX
         d0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756987871; x=1757592671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96aWoL2EyQ5XT7dLTbfi7TiLaaZnuE1QxuiitVbAis4=;
        b=hmWhGKD3+g/WcgQnC1qRAJw1AemCxeQKEIf9/iOCgIm6IWhoCLywGuJr7DZQx1T97w
         t5UAqqFpcjNgH9gekXR1xJy6BTVIFdYrjw7M2HAhfM/jOWcanKSCXI/4IuPALp3cPFAL
         Yody7NqN5f8pj1IbkrawzUu3pMw5lctVNVDZOfcOuY2rOx2QkNUwAyKQMay2+c60VCd2
         YJYAuN5WckLqZCDHWntclmLYulh0zkVvSSxHqLEZUHIdI36blcmQ2uLNV9N23jK31ZVz
         yLlLN+BSGqoeRZoa2hueTePvziqh5hvV2InlyH8dq3iizp3ZO/4dOMb+DFCd6QEonBjs
         HJOQ==
X-Gm-Message-State: AOJu0YwvhL5ErxuGDk3sjZdltJfI2CNBrjki3hz0o1GnIwzo5pygHT7K
	v3JC/OjeguXsPvNa6wTgijTyio08jjWoGeo/uM2K/oUPDbv3aPn7qewGVXOvoh/pjeA=
X-Gm-Gg: ASbGnctKYExkOWhIjpnBJ5IsV8jJR8jB0xwQIgycINH+RwLfAIvVgubncmuicjwflrF
	E7GhtN6miOiGDVhPoWNOp5wNHY2gpteSx3ccuhLyQoCrYWR9w6war4DQDnZcwEcED9JZ6ZRV8jp
	XCCZFtB876v5qAej0R1uY1/g8J8f6NoilHXis9eix3QyppODTC7zaZR6RiMzt3L4IkZ/DyNWHcU
	Pumyp9P8P3xJY91B+TxfRXgZ29x7D4b4/UIkCZPDSVd23TPpTXGxlmV9HBgQE5RZtd9igzeKcBr
	onE3irx/y0CVHRMkpP9WYW5JmYb65zbJR5tdDqyvFco8nTVagH39JxwEpbglyEhIWrYyoBy/1SN
	FyDsOIT1V5pgyPxlT61QDsOBuWuJLjjfMvq2imiuZZMK3KsJ8T4psB5dvndsRYmlgFJBqyLojC2
	q6sV214To1GHDZ1cPvZFel5mRW6stJ68w=
X-Google-Smtp-Source: AGHT+IF3z8cB3zEQG40jpxQo+TyOKfyW0SrzxSp/nkLpq5G5tLUT4174VBgbqUNIWF0ZaNlRSHoEeg==
X-Received: by 2002:a05:6000:290f:b0:3b8:bb8b:6b05 with SMTP id ffacd0b85a97d-3d1dfc071f9mr14660480f8f.29.1756987871175;
        Thu, 04 Sep 2025 05:11:11 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0084ffa21ee1457b9b.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:84ff:a21e:e145:7b9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f306c22sm370358845e9.13.2025.09.04.05.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 05:11:10 -0700 (PDT)
Date: Thu, 4 Sep 2025 14:11:08 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 2/4] bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN
Message-ID: <a3f372a017489ae75545f42a903b12710c2836ca.1756983952.git.paul.chaignon@gmail.com>
References: <cover.1756983951.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756983951.git.paul.chaignon@gmail.com>

This patch adds support for crafting non-linear skbs in BPF test runs
for tc programs, via a new flag BPF_F_TEST_SKB_NON_LINEAR. When this
flag is set, only the L2 header is pulled in the linear area.

This is particularly useful to test support for non-linear skbs in large
codebases such as Cilium. We've had multiple bugs in the past few years
where we were missing calls to bpf_skb_pull_data(). This support in
BPF_PROG_TEST_RUN would allow us to automatically cover this case in our
BPF tests.

In addition to the selftests introduced later in the series, this patch
was tested by setting BPF_F_TEST_SKB_NON_LINEAR for all tc selftests
programs and checking test failures were expected.

Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 include/uapi/linux/bpf.h       |  2 +
 net/bpf/test_run.c             | 88 ++++++++++++++++++++++++----------
 tools/include/uapi/linux/bpf.h |  2 +
 3 files changed, 66 insertions(+), 26 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382..d77c8bf4b131 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1448,6 +1448,8 @@ enum {
 #define BPF_F_TEST_XDP_LIVE_FRAMES	(1U << 1)
 /* If set, apply CHECKSUM_COMPLETE to skb and validate the checksum */
 #define BPF_F_TEST_SKB_CHECKSUM_COMPLETE	(1U << 2)
+/* If set, skb will be non-linear */
+#define BPF_F_TEST_SKB_NON_LINEAR	(1U << 3)
 
 /* type for BPF_ENABLE_STATS */
 enum bpf_stats_type {
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 4e595b7ad94f..645b7b5af08f 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -660,20 +660,29 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_memb_release, KF_RELEASE)
 BTF_KFUNCS_END(test_sk_check_kfunc_ids)
 
 static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
-			   u32 size, u32 headroom, u32 tailroom)
+			   u32 size, u32 headroom, u32 tailroom, bool nonlinear)
 {
 	void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
-	void *data;
+	void *data, *dst;
 
 	if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - tailroom)
 		return ERR_PTR(-EINVAL);
 
-	size = SKB_DATA_ALIGN(size);
-	data = kzalloc(size + headroom + tailroom, GFP_USER);
+	/* In non-linear case, data_in is copied to the paged data */
+	if (nonlinear) {
+		data = alloc_page(GFP_USER);
+	} else {
+		size = SKB_DATA_ALIGN(size);
+		data = kzalloc(size + headroom + tailroom, GFP_USER);
+	}
 	if (!data)
 		return ERR_PTR(-ENOMEM);
 
-	if (copy_from_user(data + headroom, data_in, user_size)) {
+	if (nonlinear)
+		dst = page_address(data);
+	else
+		dst = data + headroom;
+	if (copy_from_user(dst, data_in, user_size)) {
 		kfree(data);
 		return ERR_PTR(-EFAULT);
 	}
@@ -984,7 +993,7 @@ static struct proto bpf_dummy_proto = {
 int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 			  union bpf_attr __user *uattr)
 {
-	bool is_l2 = false, is_direct_pkt_access = false;
+	bool is_l2 = false, is_direct_pkt_access = false, is_nonlinear = false;
 	struct net *net = current->nsproxy->net_ns;
 	struct net_device *dev = net->loopback_dev;
 	u32 size = kattr->test.data_size_in;
@@ -997,21 +1006,11 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	void *data;
 	int ret;
 
-	if ((kattr->test.flags & ~BPF_F_TEST_SKB_CHECKSUM_COMPLETE) ||
+	if ((kattr->test.flags & ~(BPF_F_TEST_SKB_CHECKSUM_COMPLETE | BPF_F_TEST_SKB_NON_LINEAR)) ||
 	    kattr->test.cpu || kattr->test.batch_size)
 		return -EINVAL;
 
-	data = bpf_test_init(kattr, kattr->test.data_size_in,
-			     size, NET_SKB_PAD + NET_IP_ALIGN,
-			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
-	if (IS_ERR(data))
-		return PTR_ERR(data);
-
-	ctx = bpf_ctx_init(kattr, sizeof(struct __sk_buff));
-	if (IS_ERR(ctx)) {
-		ret = PTR_ERR(ctx);
-		goto out;
-	}
+	is_nonlinear = kattr->test.flags & BPF_F_TEST_SKB_NON_LINEAR;
 
 	switch (prog->type) {
 	case BPF_PROG_TYPE_SCHED_CLS:
@@ -1028,6 +1027,22 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		break;
 	}
 
+	if (is_nonlinear && !is_l2)
+		return -EINVAL;
+
+	data = bpf_test_init(kattr, kattr->test.data_size_in,
+			     size, NET_SKB_PAD + NET_IP_ALIGN,
+			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
+			     is_nonlinear);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	ctx = bpf_ctx_init(kattr, sizeof(struct __sk_buff));
+	if (IS_ERR(ctx)) {
+		ret = PTR_ERR(ctx);
+		goto out;
+	}
+
 	sk = sk_alloc(net, AF_UNSPEC, GFP_USER, &bpf_dummy_proto, 1);
 	if (!sk) {
 		ret = -ENOMEM;
@@ -1035,15 +1050,32 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	}
 	sock_init_data(NULL, sk);
 
-	skb = slab_build_skb(data);
+	if (is_nonlinear)
+		skb = alloc_skb(NET_SKB_PAD + NET_IP_ALIGN + size +
+				SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
+				GFP_USER);
+	else
+		skb = slab_build_skb(data);
 	if (!skb) {
 		ret = -ENOMEM;
 		goto out;
 	}
+
 	skb->sk = sk;
 
 	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
-	__skb_put(skb, size);
+
+	if (is_nonlinear) {
+		skb_fill_page_desc(skb, 0, data, 0, size);
+		skb->truesize += PAGE_SIZE;
+		skb->data_len = size;
+		skb->len = size;
+
+		/* eth_type_trans expects the Ethernet header in the linear area. */
+		__pskb_pull_tail(skb, ETH_HLEN);
+	} else {
+		__skb_put(skb, size);
+	}
 
 	data = NULL; /* data released via kfree_skb */
 
@@ -1126,9 +1158,11 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	convert_skb_to___skb(skb, ctx);
 
 	size = skb->len;
-	/* bpf program can never convert linear skb to non-linear */
-	if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
+	if (skb_is_nonlinear(skb)) {
+		/* bpf program can never convert linear skb to non-linear */
+		WARN_ON_ONCE(!is_nonlinear);
 		size = skb_headlen(skb);
+	}
 	ret = bpf_test_finish(kattr, uattr, skb->data, NULL, size, retval,
 			      duration);
 	if (!ret)
@@ -1138,7 +1172,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (dev && dev != net->loopback_dev)
 		dev_put(dev);
 	kfree_skb(skb);
-	kfree(data);
+	if (data)
+		is_nonlinear ? __free_page(data) : kfree(data);
 	if (sk)
 		sk_free(sk);
 	kfree(ctx);
@@ -1264,7 +1299,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 		size = max_data_sz;
 	}
 
-	data = bpf_test_init(kattr, size, max_data_sz, headroom, tailroom);
+	data = bpf_test_init(kattr, size, max_data_sz, headroom, tailroom, false);
 	if (IS_ERR(data)) {
 		ret = PTR_ERR(data);
 		goto free_ctx;
@@ -1387,7 +1422,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	if (size < ETH_HLEN)
 		return -EINVAL;
 
-	data = bpf_test_init(kattr, kattr->test.data_size_in, size, 0, 0);
+	data = bpf_test_init(kattr, kattr->test.data_size_in, size, 0, 0, false);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
@@ -1660,7 +1695,8 @@ int bpf_prog_test_run_nf(struct bpf_prog *prog,
 
 	data = bpf_test_init(kattr, kattr->test.data_size_in, size,
 			     NET_SKB_PAD + NET_IP_ALIGN,
-			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
+			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
+			     false);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 233de8677382..d77c8bf4b131 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1448,6 +1448,8 @@ enum {
 #define BPF_F_TEST_XDP_LIVE_FRAMES	(1U << 1)
 /* If set, apply CHECKSUM_COMPLETE to skb and validate the checksum */
 #define BPF_F_TEST_SKB_CHECKSUM_COMPLETE	(1U << 2)
+/* If set, skb will be non-linear */
+#define BPF_F_TEST_SKB_NON_LINEAR	(1U << 3)
 
 /* type for BPF_ENABLE_STATS */
 enum bpf_stats_type {
-- 
2.43.0


