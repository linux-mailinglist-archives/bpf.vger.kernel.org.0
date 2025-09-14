Return-Path: <bpf+bounces-68317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CD8B56A0C
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 17:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D90857A80F2
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 15:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B322C375E;
	Sun, 14 Sep 2025 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaTPi9zz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A565212574
	for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757862654; cv=none; b=TF0leY+ZwQWCEDPmBQ+nlgsFJCTsCsnb8FnInfWGzobiRenj9TlEISvI9By1mChXQJ0i+IvMf/sW606aT2d5iVXPi0yeh4qr+uSDXDyc6nLok+l6MaRgayXwsmJ4e47uG6tckQYXqj23pWX+9k1scofEDg/m0sNSt6vJG+InASY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757862654; c=relaxed/simple;
	bh=m8xeImhbqx5rH5sf/MJFUAVSGTArtq+dzaFYyzmuOHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nF+B5g5Anu6rq9LrzB9yBDReB9QtIvPTHo/zaR6DdjXuyKK3zO4vBv35AEvRHe3kvB/yiaFmNl0g6bKA52rXYlNbWyZTsk0dr/68DgtDY8eLYVc/u0bmJE6rnAzBwgDL6vAILnfcDMvmkKirGpCH75tSKgyE303BGIgTjyXSWxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaTPi9zz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45ed646b656so25349455e9.3
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 08:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757862650; x=1758467450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CgRChoBqSQukp8uSA6MQKWtS8i7PGX7Rat8ofNMim8g=;
        b=KaTPi9zzm/gu7r/D6MyabULh1YDzQsqOOQ/jFnyRprZMCE0DakBkfDN49gZ+/pZqfc
         IIIzojBmEs4WMb6KkO7SfZYPHfYTBHMJp/rr/JFjmt40oym74R6ZACQ08joyyaGhHkr2
         46bhF1nKGFW8YQ0DTAZKGce0sXRVfoCuowUF07NhWCDJDhNd1RkIMZ7hUhpX3jO7bS2o
         9qEcLcRfpsegWrC3pBBxCbvdx8S8qK+yHzcckWSbwxQFyNni+sxjchJgenSN1JsDvFBq
         vQoe7Kim5iviEvfQ3Z3UxcMAhmdd2rIhJqejW+XXc3KiMKLmgi4DwLZqeV+FSXJRCpyB
         pytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757862650; x=1758467450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgRChoBqSQukp8uSA6MQKWtS8i7PGX7Rat8ofNMim8g=;
        b=PV1yYi/Qt5NHwN/ECdqWPLm6Bjuo0YAm2hiRYiN1zjxFd/SMo+0NuTJ9TjygDCMfGi
         0quK0VNU7Nog9vQHZGl2WVPtYsUnsq4yR39USIknVk6+tIDov/vuTNYTM3Fl76XhBTZO
         32cS/G9WatP3Xk3KBSk23XlsGXzRyoCmdHSyKCOwy4iNzPw7aCoX1AI/8TXNed9bOxSC
         UwN3Yat3WXA8hoBNFRCd7LLVV0eprYtsCAUyOfPLWlZNzgmMfLrPJ+RRfbxH0GAyOe5z
         Q5ofgLVzZoDFBf1wqiXNoAuJmW4VfQvmF7NGScJVmXKu3kWOVw3O+yy8Gy99XYHCEAOQ
         ZWyQ==
X-Gm-Message-State: AOJu0YxyMIptdoCujFASNPbtYwNm+9ynwOR+mwB2w2vZuPTPuIQUoCBm
	YsgJbRvnAuKq0wwldLWTHAChKhm/Yq3rMtGHl8CmyNMi/9oUMTqufyTjhtsI6goV
X-Gm-Gg: ASbGnct/fVU+pYw5x+hMlXVYjhs+boVRUACL9cU0Ntrn9ZHYEh8wfVbPMsfBtjCJVtK
	9Qi69m6OMihmQVBXJFpJRhBmlVVGy2UG51unhGAVowxZSBj0sBdMpBKZTgNn/nh1nDG2MEomWdw
	Ndw08KiHK5H3SLVXivZmzmxPLyd7XMuDDm3483zdwge/hikf7/MCicsmpQsKJxubUykNIdPnWT9
	VAs4bpghq9rmecpE8fcV5P1AqveGrLDrsumPAsgJXSLbNuFfUU5WnS+KKiWpoKNfs9d1X3awBdZ
	K7mPt2i45NpZi1+Atp8FgU8bM2g5APQlD/+yNxzcLZNKGFvmLuRJVt4q69RquoY+OFZJa96M2tF
	3EQFvawBg/2SYXulWBdqcm0KcGEOjvLQgvCUrExK7KlIrNcrlfM/SsalcsND/nXLi30YfYaupdB
	L0cMTcmp0Mjucmy6UyBaOeln8K/WeiIA==
X-Google-Smtp-Source: AGHT+IE4qTGLq5Z4fxkQQ+eg9JaE1rKwUstMnMbWg4OaU6GBIMg1s2THunD0cCiLtVMqiguYqyIraQ==
X-Received: by 2002:a05:6000:4011:b0:3ea:9042:e682 with SMTP id ffacd0b85a97d-3ea9042ec5bmr682983f8f.11.1757862649469;
        Sun, 14 Sep 2025 08:10:49 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00829f05581a33a178.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:829f:558:1a33:a178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0156b0a8sm141591225e9.3.2025.09.14.08.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 08:10:48 -0700 (PDT)
Date: Sun, 14 Sep 2025 17:10:47 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v2 2/4] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
Message-ID: <6bed34f91f4624c45fd7f31079246d3b3751a31f.1757862238.git.paul.chaignon@gmail.com>
References: <cover.1757862238.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1757862238.git.paul.chaignon@gmail.com>

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

Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 include/uapi/linux/bpf.h       |   4 ++
 net/bpf/test_run.c             | 102 ++++++++++++++++++++++++---------
 tools/include/uapi/linux/bpf.h |   4 ++
 3 files changed, 82 insertions(+), 28 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382..34272cd07dd2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1448,6 +1448,10 @@ enum {
 #define BPF_F_TEST_XDP_LIVE_FRAMES	(1U << 1)
 /* If set, apply CHECKSUM_COMPLETE to skb and validate the checksum */
 #define BPF_F_TEST_SKB_CHECKSUM_COMPLETE	(1U << 2)
+/* If set, skb will be non-linear with the size of the linear area given
+ * by ctx.data_end or at least ETH_HLEN.
+ */
+#define BPF_F_TEST_SKB_NON_LINEAR	(1U << 3)
 
 /* type for BPF_ENABLE_STATS */
 enum bpf_stats_type {
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index a9c81fec3290..aaa8f93d2fdb 100644
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
 
@@ -984,7 +999,7 @@ static struct proto bpf_dummy_proto = {
 int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 			  union bpf_attr __user *uattr)
 {
-	bool is_l2 = false, is_direct_pkt_access = false;
+	bool is_l2 = false, is_direct_pkt_access = false, is_nonlinear = false;
 	struct net *net = current->nsproxy->net_ns;
 	struct net_device *dev = net->loopback_dev;
 	u32 size = kattr->test.data_size_in;
@@ -994,25 +1009,14 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	struct sock *sk = NULL;
 	u32 retval, duration;
 	int hh_len = ETH_HLEN;
+	int linear_size, ret;
 	void *data;
-	int ret;
 
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
-		ctx = NULL;
-		goto out;
-	}
+	is_nonlinear = kattr->test.flags & BPF_F_TEST_SKB_NON_LINEAR;
 
 	switch (prog->type) {
 	case BPF_PROG_TYPE_SCHED_CLS:
@@ -1029,6 +1033,27 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
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
+		ctx = NULL;
+		goto out;
+	}
+
+	linear_size = hh_len;
+	if (is_nonlinear && ctx && ctx->data_end > linear_size)
+		linear_size = ctx->data_end;
+
 	sk = sk_alloc(net, AF_UNSPEC, GFP_USER, &bpf_dummy_proto, 1);
 	if (!sk) {
 		ret = -ENOMEM;
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
@@ -1139,7 +1183,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (dev && dev != net->loopback_dev)
 		dev_put(dev);
 	kfree_skb(skb);
-	kfree(data);
+	if (data)
+		is_nonlinear ? __free_page(data) : kfree(data);
 	if (sk)
 		sk_free(sk);
 	kfree(ctx);
@@ -1265,7 +1310,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 		size = max_data_sz;
 	}
 
-	data = bpf_test_init(kattr, size, max_data_sz, headroom, tailroom);
+	data = bpf_test_init(kattr, size, max_data_sz, headroom, tailroom, false);
 	if (IS_ERR(data)) {
 		ret = PTR_ERR(data);
 		goto free_ctx;
@@ -1388,7 +1433,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	if (size < ETH_HLEN)
 		return -EINVAL;
 
-	data = bpf_test_init(kattr, kattr->test.data_size_in, size, 0, 0);
+	data = bpf_test_init(kattr, kattr->test.data_size_in, size, 0, 0, false);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
@@ -1661,7 +1706,8 @@ int bpf_prog_test_run_nf(struct bpf_prog *prog,
 
 	data = bpf_test_init(kattr, kattr->test.data_size_in, size,
 			     NET_SKB_PAD + NET_IP_ALIGN,
-			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
+			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
+			     false);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 233de8677382..34272cd07dd2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1448,6 +1448,10 @@ enum {
 #define BPF_F_TEST_XDP_LIVE_FRAMES	(1U << 1)
 /* If set, apply CHECKSUM_COMPLETE to skb and validate the checksum */
 #define BPF_F_TEST_SKB_CHECKSUM_COMPLETE	(1U << 2)
+/* If set, skb will be non-linear with the size of the linear area given
+ * by ctx.data_end or at least ETH_HLEN.
+ */
+#define BPF_F_TEST_SKB_NON_LINEAR	(1U << 3)
 
 /* type for BPF_ENABLE_STATS */
 enum bpf_stats_type {
-- 
2.43.0


