Return-Path: <bpf+bounces-70657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD443BC968B
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 16:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30A7189C76F
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11502E9759;
	Thu,  9 Oct 2025 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJtJa/kC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC516EB42
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018552; cv=none; b=i7fPFL3g8MjVwNHnoWH7lmDjyGeLsbW5/cy7bqSRkv/cIML10ZhB5mJmbVp/44krRJP7EWIVI38gQuxnPJZImSxwRSUqBoiB98tZVEi6lti3OUMOtndpaM5nwIyqAe2kSE5rbBad+v8dAkyi5w+zjB+xHIuBkO7vX2yBQksDCPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018552; c=relaxed/simple;
	bh=EADblMD3axsSq2+8swyZve20VzxVA/OW+40Q4zyWm3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0fF2zj1zo8cB8cKJzsiPbTmpAbliGbkanviMafrNUoEWLSWbz79C0M+BwbngBQsqHA1wBFBdXCSdIHH/OAfoR4MplfAcC+p4kKNKBlvG/yy0ploMI9UiV3lxqBFpnnsShFvRQbvsgxwNEwmpmQdJKmP/AkLDlvn/hVK+yFpPAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJtJa/kC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so5583295e9.2
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 07:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760018548; x=1760623348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RMHBFa+3hxjvZxp5G7tZtVK9yFyPHPM5m8EVrVrNl8s=;
        b=bJtJa/kCBkuHoGYsIvnh6VMiTNzTgObkcY1/TQ/XqHUJoNGAsXkysYWIPubT6SLZGX
         Qxnm+KK/bq/LralQDXr6wLGRW5s94uqONiH5CxCIr/OvsnLVcEjmDMksjUSyc4BtKVKF
         OIIfwhr+8Q7P616e+er2g9TsHTpeSU43ajJKyICM0BTDEFvzG2e9LLccbjTmCjHnHERy
         gz73jijcyjicCc01qwocKHnCEknLKMxUylIfFY+/IB4usX6SvnozZP+s6/Ike+kRVujS
         b/ViXoh1mjdfMsXnNgOkyLgYH0QYK9PR7Mj54tGA16v3ibWQmvURslACuEl9mb+ZPlZR
         0cXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760018548; x=1760623348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMHBFa+3hxjvZxp5G7tZtVK9yFyPHPM5m8EVrVrNl8s=;
        b=CY0mlw3RZ5SYKj8G7HIGKjNWrIs3Lx2Ae3uO6jsFjSsFdCMxLWYKTimm1GFZw9XgPb
         VyQFGrBhkg6GTNDOAqlUbNU04TIpYHAMSip4JEFuAqOlf9sH2oDJKLoWld0KwGN19vCz
         datTPB9E7YM5LpKEOkfdJ6P/glbM7BrMCqSiaPE/jqdVdAkSNMS/isGE03aEFmyCDnae
         +xLqnDOz0wRjJ4V3ETuyYGsPMgzWKbVG1bTBeqGJwBVJajW1VApdPpwTKzMeHGbsjLoV
         4fxwq3ssoY1INMXzN8r2VWz53Bqs5pNs7J0CkkqAQR7WikCJbRSsZgZvwF5YatPVuQZL
         VMYg==
X-Gm-Message-State: AOJu0Yx/6izd6fIMMnuFOEf5us1wU+/2s0nWXt19JypCbrGjIiMg2iBP
	m8XuAF5tvbT73aGh4qJ7f6CePQJZN8mmTGAgeCRGO+1M/WV4mqI3pDTX5vVFUg==
X-Gm-Gg: ASbGncvlpUHtyVnJoPyluc8eYehki7D0cBzOEorbfcPXPcMAoiHjqYdLR35ojworZ71
	Z0FAiPPENzAZKKBWxctvA3sd/R8hSPuwqK8tKsV2Vw+CgyIMfnRdmJCrMtC5OWuIhYSAO7s9em0
	4+2CLTrZittF+eKOOeUKAOkqMNM1KUp2CxTxt6GYLeAdTBezliW61VXFXBlRK8wjc4C49TtpbE8
	L/H06aAnWIxUIQPR8McaEepZ9Yt5H+LVmoHbXxN5LFitxxDZC4IcxH+fbgev/wVAhHECA9nHXt3
	kngpiHkcBJ74lQq8I2QDpyWtJqJR538sflnhDAlBmF8jO5NXTQxEEPWUDjkKtt9fCG1oaRcO1Do
	+DCqkzcQGZ92PkYxFIEfRth906AoACnvwklT3kptwMcMTkDDEZVGc/Dq1YWYsyiq4JlSj3h/ZUs
	3MBS2hAhaZ0Q9gAGToFMasmFU5hImBf27ptiOpRgHwWB1DujgyuSGcZuti
X-Google-Smtp-Source: AGHT+IHxiyFk2Dj8+sO018m8rAOwCaX949godfDhrxXw6Yc2s1DOKm1KUN1gxh4383q141EyRGHqPw==
X-Received: by 2002:a05:600c:1384:b0:46e:45f7:34f3 with SMTP id 5b1f17b1804b1-46fa9a863cfmr47311125e9.8.1760018547314;
        Thu, 09 Oct 2025 07:02:27 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b81184fd69385167.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b811:84fd:6938:5167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab8fdsm34455468f8f.15.2025.10.09.07.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:02:26 -0700 (PDT)
Date: Thu, 9 Oct 2025 16:02:23 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v7 3/5] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
Message-ID: <8bf24a59c3cfc7cc70c6bc272a039149cc8202b7.1760015985.git.paul.chaignon@gmail.com>
References: <cover.1760015985.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760015985.git.paul.chaignon@gmail.com>

This patch adds support for crafting non-linear skbs in BPF test runs
for tc programs. The size of the linear area is given by ctx->data_end,
with a minimum of ETH_HLEN always pulled in the linear area. If ctx or
ctx->data_end are null, a linear skb is used.

This is particularly useful to test support for non-linear skbs in large
codebases such as Cilium. We've had multiple bugs in the past few years
where we were missing calls to bpf_skb_pull_data(). This support in
BPF_PROG_TEST_RUN would allow us to automatically cover this case in our
BPF tests.

LWT program types are currently excluded in this patch. Allowing
non-linear skbs for these programs would require a bit more care because
they are able to call helpers (ex., bpf_clone_redirect, bpf_redirect)
that themselves call eth_type_trans(). eth_type_trans() assumes there
are at least ETH_HLEN bytes in the linear area. That may not be true
for LWT programs as we already pulled the L2 header via the
eth_type_trans() call in bpf_prog_test_run_skb().

In addition to the selftests introduced later in the series, this patch
was tested by enabling non-linear skbs for all tc selftests programs
and checking test failures were expected.

Tested-by: syzbot@syzkaller.appspotmail.com
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 net/bpf/test_run.c | 101 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 81 insertions(+), 20 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index b9b49d0c7014..6ac393c95962 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -447,7 +447,7 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 
 static int bpf_test_finish(const union bpf_attr *kattr,
 			   union bpf_attr __user *uattr, const void *data,
-			   struct skb_shared_info *sinfo, u32 size,
+			   struct skb_shared_info *sinfo, u32 size, u32 frag_size,
 			   u32 retval, u32 duration)
 {
 	void __user *data_out = u64_to_user_ptr(kattr->test.data_out);
@@ -464,7 +464,7 @@ static int bpf_test_finish(const union bpf_attr *kattr,
 	}
 
 	if (data_out) {
-		int len = sinfo ? copy_size - sinfo->xdp_frags_size : copy_size;
+		int len = sinfo ? copy_size - frag_size : copy_size;
 
 		if (len < 0) {
 			err = -ENOSPC;
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
 
@@ -984,10 +990,12 @@ static struct proto bpf_dummy_proto = {
 int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 			  union bpf_attr __user *uattr)
 {
-	bool is_l2 = false, is_direct_pkt_access = false;
+	bool is_l2 = false, is_direct_pkt_access = false, is_lwt = false;
+	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	struct net *net = current->nsproxy->net_ns;
 	struct net_device *dev = net->loopback_dev;
-	u32 size = kattr->test.data_size_in;
+	u32 headroom = NET_SKB_PAD + NET_IP_ALIGN;
+	u32 linear_sz = kattr->test.data_size_in;
 	u32 repeat = kattr->test.repeat;
 	struct __sk_buff *ctx = NULL;
 	struct sk_buff *skb = NULL;
@@ -1001,17 +1009,20 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	    kattr->test.cpu || kattr->test.batch_size)
 		return -EINVAL;
 
-	if (size < ETH_HLEN)
+	if (kattr->test.data_size_in < ETH_HLEN)
 		return -EINVAL;
 
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
@@ -1023,9 +1034,24 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
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
@@ -1049,7 +1075,43 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	data = NULL; /* data released via kfree_skb */
 
 	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
-	__skb_put(skb, size);
+	__skb_put(skb, linear_sz);
+
+	if (unlikely(kattr->test.data_size_in > linear_sz)) {
+		void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
+		struct skb_shared_info *sinfo = skb_shinfo(skb);
+		u32 copied = linear_sz;
+
+		while (copied < kattr->test.data_size_in) {
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
+			data_len = min_t(u32, kattr->test.data_size_in - copied,
+					 PAGE_SIZE);
+			skb_fill_page_desc(skb, sinfo->nr_frags, page, 0, data_len);
+
+			if (copy_from_user(page_address(page), data_in + copied,
+					   data_len)) {
+				ret = -EFAULT;
+				goto out;
+			}
+			skb->data_len += data_len;
+			skb->truesize += PAGE_SIZE;
+			skb->len += data_len;
+			copied += data_len;
+		}
+	}
 
 	if (ctx && ctx->ifindex > 1) {
 		dev = dev_get_by_index(net, ctx->ifindex);
@@ -1129,12 +1191,11 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	convert_skb_to___skb(skb, ctx);
 
-	size = skb->len;
-	/* bpf program can never convert linear skb to non-linear */
-	if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
-		size = skb_headlen(skb);
-	ret = bpf_test_finish(kattr, uattr, skb->data, NULL, size, retval,
-			      duration);
+	if (skb_is_nonlinear(skb))
+		/* bpf program can never convert linear skb to non-linear */
+		WARN_ON_ONCE(linear_sz == kattr->test.data_size_in);
+	ret = bpf_test_finish(kattr, uattr, skb->data, skb_shinfo(skb), skb->len,
+			      skb->data_len, retval, duration);
 	if (!ret)
 		ret = bpf_ctx_finish(kattr, uattr, ctx,
 				     sizeof(struct __sk_buff));
@@ -1342,7 +1403,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 		goto out;
 
 	size = xdp.data_end - xdp.data_meta + sinfo->xdp_frags_size;
-	ret = bpf_test_finish(kattr, uattr, xdp.data_meta, sinfo, size,
+	ret = bpf_test_finish(kattr, uattr, xdp.data_meta, sinfo, size, sinfo->xdp_frags_size,
 			      retval, duration);
 	if (!ret)
 		ret = bpf_ctx_finish(kattr, uattr, ctx,
@@ -1433,7 +1494,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 		goto out;
 
 	ret = bpf_test_finish(kattr, uattr, &flow_keys, NULL,
-			      sizeof(flow_keys), retval, duration);
+			      sizeof(flow_keys), 0, retval, duration);
 	if (!ret)
 		ret = bpf_ctx_finish(kattr, uattr, user_ctx,
 				     sizeof(struct bpf_flow_keys));
@@ -1534,7 +1595,7 @@ int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kat
 		user_ctx->cookie = sock_gen_cookie(ctx.selected_sk);
 	}
 
-	ret = bpf_test_finish(kattr, uattr, NULL, NULL, 0, retval, duration);
+	ret = bpf_test_finish(kattr, uattr, NULL, NULL, 0, 0, retval, duration);
 	if (!ret)
 		ret = bpf_ctx_finish(kattr, uattr, user_ctx, sizeof(*user_ctx));
 
@@ -1734,7 +1795,7 @@ int bpf_prog_test_run_nf(struct bpf_prog *prog,
 	if (ret)
 		goto out;
 
-	ret = bpf_test_finish(kattr, uattr, NULL, NULL, 0, retval, duration);
+	ret = bpf_test_finish(kattr, uattr, NULL, NULL, 0, 0, retval, duration);
 
 out:
 	kfree(user_ctx);
-- 
2.43.0


