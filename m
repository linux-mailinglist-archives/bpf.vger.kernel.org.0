Return-Path: <bpf+bounces-70154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7D2BB1DB0
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 23:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7B917CCEE
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 21:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659FB311969;
	Wed,  1 Oct 2025 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8znvAkO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6D828489B
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759354244; cv=none; b=R5vu5GfOW8mQvScI5uU39y1wbKn1sG917eSbzCTpFC6Uw3fsiINUR5Mw6i6ensRtO0ZjsEmFYmBUlC833AUq58Ei6FjtwBgJjzQQcx3qHuuy6Hfs6Qb7mGmy9dw1tQ9muL9O8/Ylll5fAkvSrEsMT3B6drmFu/tgmPBdcAlyzyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759354244; c=relaxed/simple;
	bh=1oHSBc0mt/+ZxoyFomWkLxEk5BOfpD2AXD6hpzLFKkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQw8+hlwxmV7KERLEiHtRsf0UICmpwoD5IS0K7pd2Tqohw8T2V1xy7riyAGNH79z1evDRfSmMtOde694dI6u52glGgTNPrSj2tIZBnWpU7zwjAOkDzEpfFNyOcF0yXeTi33j2Ap7xsxHnBP9xPm5S6DucHKHHxf2txn8KSRVbUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8znvAkO; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f44000626bso149921f8f.3
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 14:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759354241; x=1759959041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kx26ja6DOHdLHTt2eq85LQfPEagjNk/tuNpe2VjSVgg=;
        b=L8znvAkOn09kGsi/O0enxgKC5npKfnMRJtRLq8tdnV7YYXrhh2vmwhMNAPHxN3fBle
         DqOa4nQ9Wqp79VljV92iYF7EEEBu4xPYCDNGAfd38Hfkwf4O0f9MiVUeVIlBuoqi9bG2
         sLxNgeHLJMqjenI1rz1IBVxIsLCXYH+iMQvM8rzhoS3Nlb7n3tEpz2b4QXevOGFMGvXV
         UBrDiegebKgi+HMG5xcyg2V1HXciI5UwIets9TNeYrRjy+p62feW6xnr0myAcSAYB1rl
         7Up5Mhwv/zy4mK+dReoVVzWu5KUco1Uo5VwINrR6jFiP+UhjroHwltmTFCfE4paR1ku6
         YXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759354241; x=1759959041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kx26ja6DOHdLHTt2eq85LQfPEagjNk/tuNpe2VjSVgg=;
        b=UVYhZJWkZWe28EGPrl7Aad4id2Gr6C428lpKzg9BNZwNZycM5k1hCaWxTMXC0GVGfg
         mkE07Ws17UpmqRro6RQXkNnKCplmllp4VDlwJQoCNZbYAEtAF3EE2vTiEIBRQhvBrI6r
         8cCQcgdY015oGwngZ64DDwkXcvCkSiA2Yn8mzDeFKo4EWyer3tfhg6MxskWHTHnKLAkk
         XNpIufVTefRYWMp3rPC4ZdXLN6xbN4GwKWnu78vHOehvfb5w2vzBNcEEvIo2nbPg822B
         PGSsAR5xJGU85tRD6/NZuOzNAKHQz61AlMT44azQF9i32OwJVGjTVGGCtN0YO6ccgAS+
         k7Ig==
X-Gm-Message-State: AOJu0YyD3SJePrxnZyz51x4fpQMLOQIcAVMMAVIQj7f/k0z9skFxgMwW
	dMSJAP8U642nQTBptOixkn43LOoKRzVzef8V0kEha0XdkcjxOr7BoJ/KIjLtOtfQ
X-Gm-Gg: ASbGncuYgh+VjkDTFCKu8sOLqbN1OfuDwBKjGFtOXCOeMdl6HUeQ+3Y/r/JXW1Bzkf2
	n+2EN/B9hKOZF3pkdZcUcjmJpogN/d/+jpyqP4QldG4MXdzceMfbKl3Vt8+S5TjlDHKqb8JIKaw
	Uo/yK5FNfH11+xP2oRYc05nNCPVrDbYnkfoXb9I+W6JFB0rrhnSi9ueu8bBm9/gGltmeYPPWL/z
	aBT0QPinVCoxd1g8E96X13CsuOsTYgW5nZQuc0b5FQKGnAwCcnHR1Dcml4DC5+i1b8S/pVU8NwQ
	Iertg4jvEyXduKFQUcQ5LK3YEusVMRqnNLXNnT+yQUPRsIE+YjKDuBDWF3e0dYpB5rE5P/uz3ML
	KsrshvSjVcNqzm3yQVIDQjb5V26qL5baqNDS3snjLVuM+FQDpTFZjJorAylOTu5A4ARkEBwEOpZ
	ef0+p5Owjqq6gEkkDsiZrIPNyYS35xC8yZhrktTGy4jaYiMOjUHKpdQs8=
X-Google-Smtp-Source: AGHT+IFWzJRZWM0ugVFK1sb8oyoyjj6Bjp8CWkb4UO7pvoHLPj73xgeTtIiX2v/N8EwpEbObO1VsvA==
X-Received: by 2002:a05:6000:40c9:b0:3f5:453:77e3 with SMTP id ffacd0b85a97d-425577ed808mr3149692f8f.6.1759354241192;
        Wed, 01 Oct 2025 14:30:41 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e006ac507786c22ef92.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:6ac5:778:6c22:ef92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a16e13sm56288225e9.15.2025.10.01.14.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 14:30:40 -0700 (PDT)
Date: Wed, 1 Oct 2025 23:30:39 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v4 3/5] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
Message-ID: <13079868d46f5bef31b90ae08dbf33ced1e2e144.1759341538.git.paul.chaignon@gmail.com>
References: <cover.1759341538.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759341538.git.paul.chaignon@gmail.com>

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
index d420a657fb54..90cc990f3685 100644
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
 
 	if (ctx && ctx->ifindex > 1) {
 		dev = dev_get_by_index(net, ctx->ifindex);
@@ -1128,9 +1181,11 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
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


