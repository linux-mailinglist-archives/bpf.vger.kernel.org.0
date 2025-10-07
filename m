Return-Path: <bpf+bounces-70520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80263BC24FB
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 19:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D4819A3B1C
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 18:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCF92E8B9A;
	Tue,  7 Oct 2025 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iPoS6xWP"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE53710A1E
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759859981; cv=none; b=W8gUxgetGtD4z8ecbRnZ5kdna8VEdD2Df+3hkprhUsgoWKD7aG3FLsJDEtwbJwKB9GuiHF8NjGXnjknQYX7l9NKUm4TiFfdRm7fYFEsPuX1SynT2b8llilckOvwPPzcOnm+1orcq6cRchrebA7gS3uxSkcHDmMAtvmPThhc6ZEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759859981; c=relaxed/simple;
	bh=bGWr2KCxr4t4cvNOaOGF5v+aAc2pJpaGLg9qHtLQgf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ogYH3JjxE8lbZ5/t8aQWBOZ33jErX00uBxBQrr3AekJx8/jmg3cKAlksnDY27UIPWn+WdaG5SWAVdd+4Ei9EDk+3Z3qDbuzTvRuyMtnLX3vnHHouMijnW9B8L85N4ZaERCIkbnL9vYAM+r0iqNHpvmjwmSVDZiA9/1o7eXV2is4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iPoS6xWP; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a7a12dcc-4fc4-4c1a-aceb-bb4ce2815a36@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759859976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2PgrELYGS2fWTQJ+d3kgvuZIDxKzs4UXd64korIL4uY=;
	b=iPoS6xWPRlphFxtMXHE1zRglLNftxbFK9Gh3TQGFJshRe8uwp8zlNbDiKKjVkL1Pp35Q49
	J58cwcGl+kEmHj4AFSVKRqr+glxBOVnbpS+VW4bkYw5bWo4VHNyPij/2Lzrc6uoN03pmyk
	IJbI0m/AYiYf6iXXIl37crDK4POOENM=
Date: Tue, 7 Oct 2025 10:59:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 3/5] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Amery Hung <ameryhung@gmail.com>
References: <cover.1759843268.git.paul.chaignon@gmail.com>
 <8347068dc4ee9030be13e886c05d59d3ef1ce949.1759843268.git.paul.chaignon@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <8347068dc4ee9030be13e886c05d59d3ef1ce949.1759843268.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/7/25 6:38 AM, Paul Chaignon wrote:
> This patch adds support for crafting non-linear skbs in BPF test runs
> for tc programs. The size of the linear area is given by ctx->data_end,
> with a minimum of ETH_HLEN always pulled in the linear area. If ctx or
> ctx->data_end are null, a linear skb is used.
> 
> This is particularly useful to test support for non-linear skbs in large
> codebases such as Cilium. We've had multiple bugs in the past few years
> where we were missing calls to bpf_skb_pull_data(). This support in
> BPF_PROG_TEST_RUN would allow us to automatically cover this case in our
> BPF tests.
> 
> In addition to the selftests introduced later in the series, this patch
> was tested by setting enabling non-linear skbs for all tc selftests
> programs and checking test failures were expected.
> 
> Tested-by: syzbot@syzkaller.appspotmail.com
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
>   net/bpf/test_run.c | 82 +++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 74 insertions(+), 8 deletions(-)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index b9b49d0c7014..0cdf894c1d05 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -910,6 +910,12 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
>   	/* cb is allowed */
>   
>   	if (!range_is_zero(__skb, offsetofend(struct __sk_buff, cb),
> +			   offsetof(struct __sk_buff, data_end)))
> +		return -EINVAL;
> +
> +	/* data_end is allowed, but not copied to skb */
> +
> +	if (!range_is_zero(__skb, offsetofend(struct __sk_buff, data_end),
>   			   offsetof(struct __sk_buff, tstamp)))
>   		return -EINVAL;
>   
> @@ -984,9 +990,12 @@ static struct proto bpf_dummy_proto = {
>   int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   			  union bpf_attr __user *uattr)
>   {
> -	bool is_l2 = false, is_direct_pkt_access = false;
> +	bool is_l2 = false, is_direct_pkt_access = false, is_lwt = false;
> +	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>   	struct net *net = current->nsproxy->net_ns;
>   	struct net_device *dev = net->loopback_dev;
> +	u32 headroom = NET_SKB_PAD + NET_IP_ALIGN;
> +	u32 linear_sz = kattr->test.data_size_in;
>   	u32 size = kattr->test.data_size_in;
>   	u32 repeat = kattr->test.repeat;
>   	struct __sk_buff *ctx = NULL;
> @@ -1007,11 +1016,14 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   	switch (prog->type) {
>   	case BPF_PROG_TYPE_SCHED_CLS:
>   	case BPF_PROG_TYPE_SCHED_ACT:
> +		is_direct_pkt_access = true;
>   		is_l2 = true;
> -		fallthrough;
> +		break;
>   	case BPF_PROG_TYPE_LWT_IN:
>   	case BPF_PROG_TYPE_LWT_OUT:
>   	case BPF_PROG_TYPE_LWT_XMIT:
> +		is_lwt = true;> +		fallthrough;
>   	case BPF_PROG_TYPE_CGROUP_SKB:
>   		is_direct_pkt_access = true;
>   		break;
> @@ -1023,9 +1035,24 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   	if (IS_ERR(ctx))
>   		return PTR_ERR(ctx);
>   
> -	data = bpf_test_init(kattr, kattr->test.data_size_in,
> -			     size, NET_SKB_PAD + NET_IP_ALIGN,
> -			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
> +	if (ctx) {
> +		if (ctx->data_end > kattr->test.data_size_in || ctx->data || ctx->data_meta) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		if (ctx->data_end) {
> +			/* Non-linear LWT test_run is unsupported for now. */

Please add some details in the commit message on what may break in the lwt prog.

> +			if (is_lwt) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			linear_sz = max(ETH_HLEN, ctx->data_end);
> +		}
> +	}
> +
> +	linear_sz = min_t(u32, linear_sz, PAGE_SIZE - headroom - tailroom);
> +
> +	data = bpf_test_init(kattr, linear_sz, linear_sz, headroom, tailroom);
>   	if (IS_ERR(data)) {
>   		ret = PTR_ERR(data);
>   		data = NULL;
> @@ -1044,12 +1071,49 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   		ret = -ENOMEM;
>   		goto out;
>   	}
> +
nit. unnecessary newline change.

>   	skb->sk = sk;
>   
>   	data = NULL; /* data released via kfree_skb */
>   
>   	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
> -	__skb_put(skb, size);
> +	__skb_put(skb, linear_sz);
> +
> +	if (unlikely(kattr->test.data_size_in > linear_sz)) {
> +		void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
> +		struct skb_shared_info *sinfo = skb_shinfo(skb);
> +
> +		size = linear_sz;

nit. I find the "size" variable confusing to follow. The "size" is overloaded 
with different meanings in this function.

Define a "u32 copied = linear_sz;" for this purpose (number of bytes copied so 
far) here.

The same should be done for test_run_xdp() also in the future (not asking in 
this set).

> +		while (size < kattr->test.data_size_in) {
> +			struct page *page;
> +			u32 data_len;> +
> +			if (sinfo->nr_frags == MAX_SKB_FRAGS) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +
> +			page = alloc_page(GFP_KERNEL);
> +			if (!page) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +
> +			data_len = min_t(u32, kattr->test.data_size_in - size,
> +					 PAGE_SIZE);
> +			skb_fill_page_desc(skb, sinfo->nr_frags, page, 0, data_len);
> +
> +			if (copy_from_user(page_address(page), data_in + size,
> +					   data_len)) {
> +				ret = -EFAULT;
> +				goto out;
> +			}
> +			skb->data_len += data_len;
> +			skb->truesize += PAGE_SIZE;
> +			skb->len += data_len;
> +			size += data_len;
> +		}
> +	}
>   
>   	if (ctx && ctx->ifindex > 1) {
>   		dev = dev_get_by_index(net, ctx->ifindex);
> @@ -1130,9 +1194,11 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   	convert_skb_to___skb(skb, ctx);
>   
>   	size = skb->len;
Remove this assignment. iiuc, skb_headlen(skb) can be directly used.

> -	/* bpf program can never convert linear skb to non-linear */
> -	if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
> +	if (skb_is_nonlinear(skb)) {
> +		/* bpf program can never convert linear skb to non-linear */
> +		WARN_ON_ONCE(linear_sz == size);
I don't think I understand this WARN. Do you mean "WARN_ON_ONCE(linear_sz ==
kattr->test.data_size_in)" instead?

>   		size = skb_headlen(skb);

Remove this assignment also. Directly use skb_headlen(skb) instead.

The remaining "u32 size" usage should be at the very beginning "if (size < 
ETH_HLEN)" check. Directly used "kattr->test.data_size_in" there also. Then the 
"u32 size" can be removed.

> +	}
>   	ret = bpf_test_finish(kattr, uattr, skb->data, NULL, size, retval,

What does it take to have bpf_test_finish support the skb's shinfo instead of 
passing NULL?

>   			      duration);
>   	if (!ret)


