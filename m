Return-Path: <bpf+bounces-68826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC000B86180
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1BD1894395
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 16:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7308923D7F2;
	Thu, 18 Sep 2025 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnSSbZw5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225231C4A2D
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214075; cv=none; b=AvjxOy4sYEHkSjz6fuvz1Yx6QOHNXhupmPfnzlohqDBC+GjFLpt+G+haEPpzsjiPOMvAUJkojNoptKVSRsEbyktTjvpdoJ9whkKVVoKi2AefmSfHT9yj5Y9cFuJSsPzXVqnJXa9jxAlrP2OYAIsHdp2MUKOnnT8VzWl1fQpPAqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214075; c=relaxed/simple;
	bh=SPSPMwsJ9Vw19BV9jU353Zkqd10N2lKTqXkbKkOMdNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xl53M7hVQDOQWn0uETKioAA/W82qPeZEHsufQqO4i3teuq3aX0Vvh3Q8MEo5r2RIqSj98TohKNPFv4KJM7gp3RkwfKnTdmEVt5/Z416X2A+m4CHp+ddAdyNz5DeEmJt7F7jf2EFKL3d2rDxFcLtpSt3qRg36RPceJmfwXUyYTbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnSSbZw5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso1420025f8f.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 09:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758214071; x=1758818871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jAn7qWPqkjor1qiPyS0LC2EsgQlnkUKlOQmepwcN63w=;
        b=WnSSbZw5zu1ZxFSHk6TDeBCgt+wgniG64p0RI8+JVh18PxNN6O6c/dCanaN/ZUE+Ly
         hnSjTtd1b3aOlOpF6Rv1Y+BUa5I7pKXVUL8ll5IymcVHdUGYVDe81sonjuCVMHi5GalX
         hDic/JD/+XgYeWvWCgiiXjLQ/ODMyeJbjjMNkYP/aDUuwLhD58YsBDlUrY8mAZsSkRms
         nntx8HI4giQFH8Bl90vIk/OFPxnYSCrz3GZ0VzAOtZZD2VDK263lQJqzuiHaJ2CffZ/R
         KpdJisqJthTs8l7htr/0sp3dnD5hCApGqaR29psqlVzKYvUnW/XGR5C3893bJn+EPqSR
         2RVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758214071; x=1758818871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAn7qWPqkjor1qiPyS0LC2EsgQlnkUKlOQmepwcN63w=;
        b=lmrAYAlpeC9EQFnQpSma0DPX0krIlOUxMlbWzzX0z5TOdK3rFJgQk6153anyVePEMJ
         kJrI5OfOaecvTMyBL1CQsBhLZVAPwvsSaG/2+EQ9x7UQph2a7OqUvZbiQj5QGTdRYbF2
         4vtTEUcUJciw2K4IkqZOqFlw9WZGTYJQilKxUx1fsVoVaWb+xrwsIPvkdsJUgvujualG
         oWRk69pnFHCjMt8xCes8Fkm4PzvS3cDNV80gv5BAX7O4Oo0YgxPOAHJvU7xed0zd/8Xp
         W1RFaYeC54/CPLuynnHn/DWlmTd0rDRfrM1qKIw+2GBwdArL7fMWYLx4jQjQsjwPlJap
         XQHQ==
X-Gm-Message-State: AOJu0YxMp8nLaNfxujz+jdLQi9WJaHQqu5nNIG/f4Ez82GIm/+a0F8Tg
	fH/UbhnEBOk6j5LRaTu+WoAHhGYBGSW8bh6hvWbu4oU3sa+oeCLIdDtGVSNhB9m3
X-Gm-Gg: ASbGncufs6aus4uroG9/5aEoh5A5arNjKyvJEmNv7T1YHP6bCy4r39732t66SSfJMR3
	y5r/XAQhbqUfl26nHwBe3FaEi1/jWNfVE+VdJzM4UcNF3ut1J1ddJ4cx7p6zwk/fMe1NDZ/nObr
	oEPhuWcf1tt5WVc3JvymtJD/6Ds604pAe0ptDFFSOjbNn+74+H7bgshwx+Npk7teTbVDlVwuH+E
	J0kV9QZJfpPQOhg1DFMNOTWkF2naqRMKbwRNf5MttHm29asAu6gyvAD7UJPAbwouSnHiBPJ2N9F
	JMTmHaIHpo5bM1y/tZaurfxJxn9qo7EEoxuIEgop17XGWqear8ssxe2SEjuP7FImmiwjDMfwF9K
	pnoXUxMOcGn38USaLuV3N9KpBOCBWA4FhnuUGhoe2+LvngEXWjTjxhZIgugJp/YXXUdMrurHbB9
	hb6H03pqCLMz376qLF7G3JZ/I67LgPEGLBufxgBA==
X-Google-Smtp-Source: AGHT+IH0lNx8hgk6kXM/l2MgDKPHdFfZHwziKyBtr6PJUJx0NURqn6NnHki8bVFyGpbuAcxilrf10g==
X-Received: by 2002:adf:f7c6:0:b0:3e3:e7a0:1fec with SMTP id ffacd0b85a97d-3ecdf9bb0c5mr4265822f8f.16.1758214071279;
        Thu, 18 Sep 2025 09:47:51 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00c3e9035ed76de3f3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:c3e9:35e:d76d:e3f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f16272e4sm55829255e9.9.2025.09.18.09.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:47:50 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:47:49 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v3 3/5] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
Message-ID: <41b200d749ff0c1171b7f2ea60531126ba5e7a62.1758213407.git.paul.chaignon@gmail.com>
References: <cover.1758213407.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758213407.git.paul.chaignon@gmail.com>

This patch adds support for crafting non-linear skbs in BPF test runs
for tc programs, via a new flag BPF_F_TEST_SKB_NON_LINEAR. When this
flag is set, the size of the linear area is given by ctx->data_end, with
a minimum of ETH_HLEN always pulled in the linear area.

This is particularly useful to test support for non-linear skbs in large
codebases such as Cilium. We've had multiple bugs in the past few years
where we were missing calls to bpf_skb_pull_data(). This support in
BPF_PROG_TEST_RUN would allow us to automatically cover this case in our
BPF tests.

In addition to the selftests introduced later in the series, this patch
was tested by setting BPF_F_TEST_SKB_NON_LINEAR for all tc selftests
programs and checking test failures were expected.

Tested-by: syzbot@syzkaller.appspotmail.com
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 net/bpf/test_run.c | 82 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 17 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 00b12d745479..222a54c24c70 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -660,21 +660,30 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_memb_release, KF_RELEASE)
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
-		kfree(data);
+	if (nonlinear)
+		dst = page_address(data);
+	else
+		dst = data + headroom;
+	if (copy_from_user(dst, data_in, user_size)) {
+		nonlinear ? __free_page(data) : kfree(data);
 		return ERR_PTR(-EFAULT);
 	}
 
@@ -910,6 +919,12 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
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
 
@@ -984,7 +999,8 @@ static struct proto bpf_dummy_proto = {
 int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 			  union bpf_attr __user *uattr)
 {
-	bool is_l2 = false, is_direct_pkt_access = false;
+	bool is_l2 = false, is_direct_pkt_access = false, is_nonlinear = false;
+	int hh_len = ETH_HLEN, linear_size = ETH_HLEN;
 	struct net *net = current->nsproxy->net_ns;
 	struct net_device *dev = net->loopback_dev;
 	u32 size = kattr->test.data_size_in;
@@ -993,7 +1009,6 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	struct sk_buff *skb = NULL;
 	struct sock *sk = NULL;
 	u32 retval, duration;
-	int hh_len = ETH_HLEN;
 	void *data;
 	int ret;
 
@@ -1020,9 +1035,19 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
+	if (ctx && ctx->data_end && ctx->data_end < kattr->test.data_size_in) {
+		if (!is_l2) {
+			ret = -EINVAL;
+			goto out;
+		}
+		linear_size = max(ETH_HLEN, ctx->data_end);
+		is_nonlinear = true;
+	}
+
 	data = bpf_test_init(kattr, kattr->test.data_size_in,
 			     size, NET_SKB_PAD + NET_IP_ALIGN,
-			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
+			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
+			     is_nonlinear);
 	if (IS_ERR(data)) {
 		ret = PTR_ERR(data);
 		data = NULL;
@@ -1036,15 +1061,32 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
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
+		__pskb_pull_tail(skb, linear_size);
+	} else {
+		__skb_put(skb, size);
+	}
 
 	data = NULL; /* data released via kfree_skb */
 
@@ -1127,9 +1169,11 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
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
@@ -1139,7 +1183,10 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (dev && dev != net->loopback_dev)
 		dev_put(dev);
 	kfree_skb(skb);
-	kfree(data);
+	if (!is_nonlinear)
+		kfree(data);
+	else if (data)
+		__free_page(data);
 	if (sk)
 		sk_free(sk);
 	kfree(ctx);
@@ -1265,7 +1312,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 		size = max_data_sz;
 	}
 
-	data = bpf_test_init(kattr, size, max_data_sz, headroom, tailroom);
+	data = bpf_test_init(kattr, size, max_data_sz, headroom, tailroom, false);
 	if (IS_ERR(data)) {
 		ret = PTR_ERR(data);
 		goto free_ctx;
@@ -1388,7 +1435,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	if (size < ETH_HLEN)
 		return -EINVAL;
 
-	data = bpf_test_init(kattr, kattr->test.data_size_in, size, 0, 0);
+	data = bpf_test_init(kattr, kattr->test.data_size_in, size, 0, 0, false);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
@@ -1661,7 +1708,8 @@ int bpf_prog_test_run_nf(struct bpf_prog *prog,
 
 	data = bpf_test_init(kattr, kattr->test.data_size_in, size,
 			     NET_SKB_PAD + NET_IP_ALIGN,
-			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
+			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
+			     false);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-- 
2.43.0


