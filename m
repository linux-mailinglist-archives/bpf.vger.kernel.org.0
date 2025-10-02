Return-Path: <bpf+bounces-70227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B00EBB4DE9
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 20:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49CC91C55EE
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 18:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7248274B2F;
	Thu,  2 Oct 2025 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sG68995W"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09A517A2E1
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759429681; cv=none; b=HlOsJpZe4enpqO68Y+ROuxR488rJtRSiHDbvW8mf1fZOpcp2IzhdaTG6EsMp9DXm+fkUxS85ohk5VgQjqRW0El4MpK2b42ZB5uy1wrgJJ9qb/TlOqI+6kASR0C2RawMAuaDYaPVmvCd3TUkUlxQce3cWUkBVxHilO/7lKy144vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759429681; c=relaxed/simple;
	bh=L2TqwgG3JLYRu5iX30Zk4ViWKn+PUFSD2VOUIO5d25M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZUUCgmPeZ9QNXlqYYdI9c6BZ3MwUeU/u8r9uOaqjBDuNAHUVbvE9Z7M1GkhgDAxbNo6EvtdWKEAj/e07DqsdsVnKdc9U/MrYJXaqwGwyzaiN9Gpk/gp8qj62X/bnl21iusu0VR7RGTOFvmQpjVEPUxd4ePYrWMgMmudPrcucIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sG68995W; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <943df0e0-358e-4361-81a0-ec7a4118cf29@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759429676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fK8GGRSENA9+TPX4eUJlkTdEr6vhGVSijj41DYpywuU=;
	b=sG68995W0JiFGuEASfZ9vN5Dz0JUVtdY4elwN9+tdWvY1NendV0nMaS2lDhCT5p6taOKRS
	Kv2s9y3q+otvTbX/rafplmjmTxZJBlDRXTSDX3/b5Y8uSKhFd/C6cZ+4gCGayAqP15V2vV
	TdzdptQesQCZN7/TkIH7JcVot/DYG7o=
Date: Thu, 2 Oct 2025 11:27:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 3/5] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org
References: <cover.1759397353.git.paul.chaignon@gmail.com>
 <10502e40a894fc60abf625ec631eadc5ad78e311.1759397354.git.paul.chaignon@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <10502e40a894fc60abf625ec631eadc5ad78e311.1759397354.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/2/25 3:07 AM, Paul Chaignon wrote:
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
>   net/bpf/test_run.c | 67 +++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 61 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 3425100b1e8c..e4f4b423646a 100644
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
> +	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>   	bool is_l2 = false, is_direct_pkt_access = false;
>   	struct net *net = current->nsproxy->net_ns;
>   	struct net_device *dev = net->loopback_dev;
> +	u32 headroom = NET_SKB_PAD + NET_IP_ALIGN;
> +	u32 linear_sz = kattr->test.data_size_in;
>   	u32 size = kattr->test.data_size_in;
>   	u32 repeat = kattr->test.repeat;
>   	struct __sk_buff *ctx = NULL;
> @@ -1023,9 +1032,16 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   	if (IS_ERR(ctx))
>   		return PTR_ERR(ctx);
>   
> -	data = bpf_test_init(kattr, kattr->test.data_size_in,
> -			     size, NET_SKB_PAD + NET_IP_ALIGN,
> -			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
> +	if (ctx) {
> +		if (!is_l2 || ctx->data_end > kattr->test.data_size_in) {

What is the need for the "!is_l2" test?

> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		if (ctx->data_end)
> +			linear_sz = max(ETH_HLEN, ctx->data_end);
> +	}
> +
> +	data = bpf_test_init(kattr, linear_sz, size, headroom, tailroom);

Instead of passing "size", should linear_sz be passed instead? Unlike xdp, 
allocating exactly linear_sz should be enough considering bpf_skb_pull_data can 
allocate new data if needed.

Should linear_sz be limited to "PAGE_SIZE - headroom..." like how test_run_xdp() 
does it ?

>   	if (IS_ERR(data)) {
>   		ret = PTR_ERR(data);
>   		data = NULL;
> @@ -1044,10 +1060,47 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   		ret = -ENOMEM;
>   		goto out;
>   	}
> +
>   	skb->sk = sk;
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
> +		while (size < kattr->test.data_size_in) {
> +			struct page *page;
> +			u32 data_len;
> +
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
>   	data = NULL; /* data released via kfree_skb */
>   
> @@ -1130,9 +1183,11 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>   	convert_skb_to___skb(skb, ctx);
>   
>   	size = skb->len;
> -	/* bpf program can never convert linear skb to non-linear */
> -	if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
> +	if (skb_is_nonlinear(skb)) {
> +		/* bpf program can never convert linear skb to non-linear */
> +		WARN_ON_ONCE(linear_sz == size);
>   		size = skb_headlen(skb);
> +	}
>   	ret = bpf_test_finish(kattr, uattr, skb->data, NULL, size, retval,
>   			      duration);
>   	if (!ret)


