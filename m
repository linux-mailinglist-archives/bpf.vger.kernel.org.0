Return-Path: <bpf+bounces-70191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1EFBB38CA
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 12:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A17189EE1E
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 10:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EA4307AD6;
	Thu,  2 Oct 2025 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctgHd5+9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6528118EB0
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399648; cv=none; b=kPPvFPvhzCxcx4rlbb1NvW2d3M+1DhuymExvELXKxdAVeBHWfQuLrJ8P0yHDlUdIVol6gTiLTizPSS73FBkAKGMOLnD1YPVy5SjC97eIpnnZTqMhc7QvOSjC5TBBZkGsiTVK+dOu70vdO2hI0BEjB/kO/+VNPgCnI9uRD9l3b6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399648; c=relaxed/simple;
	bh=tOtj0d3SmJwyJvNohGWbSnnHmLIJ5oGeUNGSX7x22PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Udx3k8sgLIEONNgcBdlx4xY5z3sM5CWGCAWruQNfV0iGM2VBKqALeckaGX/HULYl8IlqoYr+JxzPhZ1ZmMyPYkhc6MKuCYi4s8ku+lbMaRixDniZELXPxikIOgNFJgf/dBseA0WpasgoC0YW3rIC+YXzlK5E8i9LaOoksc5gjrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctgHd5+9; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42420c7de22so495037f8f.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 03:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759399645; x=1760004445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kzAQl1aNmHqkQ77hwufUeNMIMKRXwg/v4gNWEnTz8sk=;
        b=ctgHd5+9J2L+rUbGQ64doImhYBXn1umN75UCT5Jg9kkjSjzIADleSIfTkaFOpNZhb2
         JBydh3I93r4AYA7RicH7GB0QUpii22j/pJmq7SVC27gI3WdhwMu7JrWBwFKpNH1v8PAP
         K/65uloU5xrLJH/x9hdqOEoj3pzGveHQySd85dfkDTXVXbB+WqzT/21uJaU5vWFwZUCD
         fSclk+FvIJRnkSN06YEEy9LfiqLIDgGkwyybFuajj9yHcD0wZFKq5BX3yKz26/DzgEvk
         gA/4SH2sbYDu36Db02yohvRYZUFBntkgL7qbJSOchNvSbA7GXA6ZFBJYNBqyzELW7ZtF
         9vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399645; x=1760004445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzAQl1aNmHqkQ77hwufUeNMIMKRXwg/v4gNWEnTz8sk=;
        b=sQ6Onivj9hOMZP/QedCEIbtG6W522UNLD6Z82/bE1m8vUKu+99pKf9+Ci0PUbcTs0D
         S/a59aWVfJ5Bu3LGtkIDuczZAz6khAjruA2o+zF7H1FUrq91YllPyA7s1qN0aCs4szmR
         i5wAaBIcZC0xiA+p/YR2eMNjAk81xuNQYOT6Hmjy10mxeORh5HK7/z5232ZRI6N2O9+U
         r2aKonix9rQcgFV7D1mRQvVBr9g7t6aBd9wOf77sew91luaNI0p5U3Q/L0NZMG2nBqH5
         ScDO/iS90MZzZEkkKb/FM+Pcpv19W5BBO/8CBQ0pqV8d0xGNv53zRorertuot8/TGrdC
         Zgmg==
X-Gm-Message-State: AOJu0YzZS+Q7juchVIVfRm9koV46vbOnP+sOlOrp9z4m+e36trYNsyb8
	VEudW0bCjGvAzx5IK/6MTubjY7klxkQ0cNun7DDHYvSofV2u1Cyt0y3+ZZQy2WKB
X-Gm-Gg: ASbGnctqXWsTrm2H6k0RmoiICJ8RL8cgLOVj/+0pL4cJXrizbgeP/eqRfoGnJgdtTG+
	PFKIDUfiWt9yEP5ZZ8RIoek8imZVemKbuksa98DHA7NdwSPHeP0jxJ5F9zPkiEyX849JmIFWSmY
	n1l5k9MWi8If0OTCtkob4ihgIz6kPZl5MhsdR0LJlJP2tJI97X0SoqEzQDUJ5/DofaY97Z/fFR4
	6JtSR6u98MQtsXd7kSycCjSAksr5PX/b/d+sNbqtLeicz4EpPwpm6bbu8NgbAaHGTjTwlIi30P0
	YtVbQHmUtT3BU8tC8GmhnqiRlcmBYBSqp5t3ObRzh7HWmDyuw9roBstMnYb0E0dlW9BubTkPm9r
	GJmwsKhjxk/N9VApf1sOQFtG4qMFSb0cT7TGhIEgva+eW4JnNy/zvRupNfAd/9rOJ0HKNXRsleE
	QztJzEBWiJQItvEAP7jor1Xc7NHDGgJAU6fhqLbsYPrY8=
X-Google-Smtp-Source: AGHT+IEg/h8/uwSm9wH9yEPah4TnwX+2fxLW7WwHpcz7AcYSE/p3ntxgT3eVtUQ4uzTNCYaUhGwdFg==
X-Received: by 2002:a5d:588b:0:b0:3e7:610b:85f6 with SMTP id ffacd0b85a97d-42557824eecmr5263585f8f.39.1759399644596;
        Thu, 02 Oct 2025 03:07:24 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e000a5ae04ae4e6e63e.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:a5a:e04a:e4e6:e63e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e970esm2951649f8f.35.2025.10.02.03.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:07:24 -0700 (PDT)
Date: Thu, 2 Oct 2025 12:07:22 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v5 3/5] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
Message-ID: <10502e40a894fc60abf625ec631eadc5ad78e311.1759397354.git.paul.chaignon@gmail.com>
References: <cover.1759397353.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759397353.git.paul.chaignon@gmail.com>

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
 net/bpf/test_run.c | 67 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 6 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 3425100b1e8c..e4f4b423646a 100644
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
+	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	bool is_l2 = false, is_direct_pkt_access = false;
 	struct net *net = current->nsproxy->net_ns;
 	struct net_device *dev = net->loopback_dev;
+	u32 headroom = NET_SKB_PAD + NET_IP_ALIGN;
+	u32 linear_sz = kattr->test.data_size_in;
 	u32 size = kattr->test.data_size_in;
 	u32 repeat = kattr->test.repeat;
 	struct __sk_buff *ctx = NULL;
@@ -1023,9 +1032,16 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	data = bpf_test_init(kattr, kattr->test.data_size_in,
-			     size, NET_SKB_PAD + NET_IP_ALIGN,
-			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
+	if (ctx) {
+		if (!is_l2 || ctx->data_end > kattr->test.data_size_in) {
+			ret = -EINVAL;
+			goto out;
+		}
+		if (ctx->data_end)
+			linear_sz = max(ETH_HLEN, ctx->data_end);
+	}
+
+	data = bpf_test_init(kattr, linear_sz, size, headroom, tailroom);
 	if (IS_ERR(data)) {
 		ret = PTR_ERR(data);
 		data = NULL;
@@ -1044,10 +1060,47 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		ret = -ENOMEM;
 		goto out;
 	}
+
 	skb->sk = sk;
 
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
 
 	data = NULL; /* data released via kfree_skb */
 
@@ -1130,9 +1183,11 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
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


