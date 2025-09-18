Return-Path: <bpf+bounces-68851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A554B86956
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 20:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84CF624EB1
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5540C2D5C76;
	Thu, 18 Sep 2025 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mx9YlbmX"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937B02D3EC7
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221434; cv=none; b=cXrgYuS3JiV/0lh96YswYi66SkNTY+hKk74vK9V1ujNwMnPdtB4lt2ZR4KU9I8Q4Okt0kPLKCw/iHuVusTt4QDu4M35IGL4lADRDtDdOC7pbdKOLoeKctfswvbHdvAHw/7g364ImV80yuSrZyBAxrpEezdhdNDpluyaZ+MS7m6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221434; c=relaxed/simple;
	bh=8uR41uzAbxb1AaA6XPxUCusZ+o0H4MnEFxI+B5cCGOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6WMIcckZlH5dZ/Xes40NS9SYwDYmgDd4G48ifZhoUo5buO5lbcomMJYkavRkMEUqklUGyfcc4U2YE32gCpBBQ4AO1dXz5dp8nHKKlapBWNdLL23wxd2wDTbnDqasUVg7nHTMDLeYo9q4Da+iGmdHMB40ANz9ZsLKjp1Thak+tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mx9YlbmX; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <85545d76-1177-408e-8224-2fb98ffe8a2f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758221427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pMSWt/YcQwAL7Wd0YmP8v5LJ66OG19j0p9OMxDS6Vko=;
	b=mx9YlbmXxsu1sDPc754A1Y+YQwkXJzE5k7YFLj/H7+bSpP5uMg7MD+oflglsGja/TQq0hO
	XUry+IdGTte+AbWHNnJJw4zuc4xy1mTT52mj/LByLruEqTrTPAPdfyUfi11e6/BZa2ELZG
	rL25KtjqvVocT++KF+5SBT6rII2FeUY=
Date: Thu, 18 Sep 2025 11:50:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/5] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Amery Hung <ameryhung@gmail.com>
References: <cover.1758213407.git.paul.chaignon@gmail.com>
 <41b200d749ff0c1171b7f2ea60531126ba5e7a62.1758213407.git.paul.chaignon@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <41b200d749ff0c1171b7f2ea60531126ba5e7a62.1758213407.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/18/25 9:47 AM, Paul Chaignon wrote:
> This patch adds support for crafting non-linear skbs in BPF test runs

I think it is useful. Thanks for working on it.

> for tc programs, via a new flag BPF_F_TEST_SKB_NON_LINEAR. When this
This commit message needs to be updated.

> flag is set, the size of the linear area is given by ctx->data_end, with
> a minimum of ETH_HLEN always pulled in the linear area.
> 
> This is particularly useful to test support for non-linear skbs in large
> codebases such as Cilium. We've had multiple bugs in the past few years
> where we were missing calls to bpf_skb_pull_data(). This support in
> BPF_PROG_TEST_RUN would allow us to automatically cover this case in our
> BPF tests.
> 
> In addition to the selftests introduced later in the series, this patch
> was tested by setting BPF_F_TEST_SKB_NON_LINEAR for all tc selftests
> programs and checking test failures were expected.
> 
> Tested-by: syzbot@syzkaller.appspotmail.com> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
>   net/bpf/test_run.c | 82 ++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 65 insertions(+), 17 deletions(-)
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 00b12d745479..222a54c24c70 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -660,21 +660,30 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_memb_release, KF_RELEASE)
>   BTF_KFUNCS_END(test_sk_check_kfunc_ids)
>   
>   static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
> -			   u32 size, u32 headroom, u32 tailroom)
> +			   u32 size, u32 headroom, u32 tailroom, bool nonlinear)

test_run_xdp() already has support for multi-frag/buf and doesn't need "bool 
nonlinear". It also does not have the one-page limitation. Is there a reason 
that test_run_skb() cannot follow what the test_run_xdp() does?

>   {
>   	void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
> -	void *data;
> +	void *data, *dst;
>   
>   	if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - tailroom)
>   		return ERR_PTR(-EINVAL);
>   
> -	size = SKB_DATA_ALIGN(size);
> -	data = kzalloc(size + headroom + tailroom, GFP_USER);
> +	/* In non-linear case, data_in is copied to the paged data */
> +	if (nonlinear) {
> +		data = alloc_page(GFP_USER);
> +	} else {
> +		size = SKB_DATA_ALIGN(size);
> +		data = kzalloc(size + headroom + tailroom, GFP_USER);
> +	}
>   	if (!data)
>   		return ERR_PTR(-ENOMEM);
>   
> -	if (copy_from_user(data + headroom, data_in, user_size)) {
> -		kfree(data);
> +	if (nonlinear)
> +		dst = page_address(data);
> +	else
> +		dst = data + headroom;
> +	if (copy_from_user(dst, data_in, user_size)) {
> +		nonlinear ? __free_page(data) : kfree(data);
>   		return ERR_PTR(-EFAULT);
>   	}

