Return-Path: <bpf+bounces-64131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DEAB0E7A3
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 02:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1291C23ACF
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 00:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A4C2F43;
	Wed, 23 Jul 2025 00:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MrSMwD9h"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ACC23A6
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753231043; cv=none; b=LmfhE9zNzhi2qps42STGEpfKXwn2AwbYFK0qipfRci3Z0gIU68uqAh9g5xEQrfZ9QENKnFkGFT7jVvhRnlk5zVIL2pIVVfVvQRCx3pDX+UfI6Fp/QmrNcwMTY6NSktHIK9GKBhV2IxEN0HWckjCAj/Sg7xegbfSFvbA2b1g3eHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753231043; c=relaxed/simple;
	bh=E0UPxY2Bh56RvJMoF0lZQ2lcY0O5+XW+alctZh4qnTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UrXptIHiE0Tn5yBqGVAKihx4bs9aFuwA1QVp2vDb2O+qSMdHjAKJJgvz7lagcuS0JUmzb0OwSLfp1h3tdXVR8DxPenhIM/Lk90UzZ/wtB78+91rkqygfoE/E3bVS9pR+k7tOg6lW1M+hxWeQXZXwlUj7gMlGSDfEOqiWL1cyU/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MrSMwD9h; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5a43d42d-375d-4a90-b5ee-8e8ed239cefd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753231039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j9HSIZ+/nil3w0TqqXcDvUAZwBf7JWFXYE5kn6ZSk3c=;
	b=MrSMwD9hcHVHJriA0ySI/rTHkR0IePOHmAqYhQM0dBUeOd8rWYUWnZCsedxuolkSc41H/J
	PxidM35k8jKnMorNYzKAK7jsk4GnYnBqDuwPB7dDUKyaqXESYGPbwIrJkMgmD54MKJeBXz
	Y8GUhJQPomjpqyoyxoz1EnMXsAgJUkI=
Date: Tue, 22 Jul 2025 17:37:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 01/10] bpf: Add dynptr type for skb metadata
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Arthur Fabre <arthur@arthurfabre.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Joanne Koong <joannelkoong@gmail.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <thoiland@redhat.com>, Yan Zhai <yan@cloudflare.com>,
 kernel-team@cloudflare.com, netdev@vger.kernel.org,
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org
References: <20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
 <20250721-skb-metadata-thru-dynptr-v3-1-e92be5534174@cloudflare.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250721-skb-metadata-thru-dynptr-v3-1-e92be5534174@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/21/25 3:52 AM, Jakub Sitnicki wrote:
> @@ -21788,12 +21798,17 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
>   	if (offset)
>   		return;
>   
> -	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
> +	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb] ||
> +	    func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta]) {

I don't think this check is needed. The skb_meta is writable to tc.

>   		seen_direct_write = env->seen_direct_write;
>   		is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);

is_rdonly is always false here.

>   
> -		if (is_rdonly)
> -			*addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
> +		if (is_rdonly) {
> +			if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb])
> +				*addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
> +			else if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta])
> +				*addr = (unsigned long)bpf_dynptr_from_skb_meta_rdonly;
> +		}

[ ... ]

> +int bpf_dynptr_from_skb_meta_rdonly(struct __sk_buff *skb, u64 flags,

so I suspect this is never used and not needed now. Please check.
It can be revisited in the future when other hooks are supported. It will be a 
useful comment in the commit message.

> +				    struct bpf_dynptr *ptr__uninit)
> +{
> +	return dynptr_from_skb_meta(skb, flags, ptr__uninit, true);
> +}

