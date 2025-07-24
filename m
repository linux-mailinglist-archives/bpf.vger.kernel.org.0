Return-Path: <bpf+bounces-64226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586ECB0FDE0
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 02:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE4907B7179
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 00:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368E64A21;
	Thu, 24 Jul 2025 00:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A+cOvJk8"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67542A1AA
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 00:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315353; cv=none; b=vAlq3UZ1yJreIhD9cmY02SMxUvOoZrNMvu8RS9dk+R+slUMr53SxddVv7O/ptCFPWr7nhn0C3T29S9vLwBZrnGkOfOJ7d6f1Rkb8Q2LACK2wdgIde4Ibb4oQoGCcpMvHNpgjb6zez/yQbwxvKw1hvnN8Ry0JpjYENQK6zp/KPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315353; c=relaxed/simple;
	bh=J+8LovXMjaVKtXfRRKOysKHcba43WVuVkGD63zs9YFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlYcBqs5nP7uXTmcNAAIdn2cDIXI2Y4cYVHdjylIQux3LJl4yJureJvIX/+MeHk+YL4FnZ9/wT4/BgIkFAl+oGC4uLX1KfHUh6SidZH7rGfRm6KjPzoNEe1GXUpe0v7vLwUN3JqURAmkqvLeoHG0V5gT+pjQVu9hqm5zxVaDcTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A+cOvJk8; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ae17edd2-22af-4f0f-b130-bf2790bfd774@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753315337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hBKW/N3KYlX7g8DjQ4fAF3US0bl5UsuwjNH1kL3HfIA=;
	b=A+cOvJk8NYDdQ1OojHcwlmwg2lbuxEIVBMvyBJpGw5OPdDMb0Yq889lvi90RSCGcA+bTZ/
	g/vKbf1R6XYBJvc5C2Y/Y4Ax9sCOiYu3cy+yifde10n5UyKXCGnbB8zpApUo+69dEF5nuk
	FGzAe5Btn5Qd+aUsr+hLUrb754zLsHY=
Date: Wed, 23 Jul 2025 17:02:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Enable read/write access to skb
 metadata through a dynptr
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Arthur Fabre <arthur@arthurfabre.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Joanne Koong <joannelkoong@gmail.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <thoiland@redhat.com>, Yan Zhai <yan@cloudflare.com>,
 kernel-team@cloudflare.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 Stanislav Fomichev <sdf@fomichev.me>
References: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
 <20250723-skb-metadata-thru-dynptr-v4-2-a0fed48bcd37@cloudflare.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250723-skb-metadata-thru-dynptr-v4-2-a0fed48bcd37@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/23/25 10:36 AM, Jakub Sitnicki wrote:
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9552b32208c5..237fb5f9d625 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1781,7 +1781,7 @@ static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *s
>   	case BPF_DYNPTR_TYPE_XDP:
>   		return __bpf_xdp_load_bytes(src->data, src->offset + offset, dst, len);
>   	case BPF_DYNPTR_TYPE_SKB_META:
> -		return -EOPNOTSUPP; /* not implemented */
> +		return bpf_skb_meta_load_bytes(src->data, src->offset + offset, dst, len);
>   	default:
>   		WARN_ONCE(true, "bpf_dynptr_read: unknown dynptr type %d\n", type);
>   		return -EFAULT;
> @@ -1839,7 +1839,7 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
>   			return -EINVAL;
>   		return __bpf_xdp_store_bytes(dst->data, dst->offset + offset, src, len);
>   	case BPF_DYNPTR_TYPE_SKB_META:
> -		return -EOPNOTSUPP; /* not implemented */

It needs to check the flags here such that the flags can be used in the future:

		if (flags)
			return -EINVAL;

pw-bot: cr

> +		return bpf_skb_meta_store_bytes(dst->data, dst->offset + offset, src, len);
>   	default:
>   		WARN_ONCE(true, "bpf_dynptr_write: unknown dynptr type %d\n", type);
>   		return -EFAULT;
> @@ -2716,7 +2716,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
>   		return buffer__opt;
>   	}
>   	case BPF_DYNPTR_TYPE_SKB_META:
> -		return NULL; /* not implemented */
> +		return bpf_skb_meta_pointer(ptr->data, ptr->offset + offset, len);
>   	default:
>   		WARN_ONCE(true, "unknown dynptr type %d\n", type);
>   		return NULL;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 0755dfc0fc2f..cf095897d4c1 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11978,6 +11978,45 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   	return func;
>   }
>   
> +static void *skb_metadata_pointer(const struct sk_buff *skb, u32 off, u32 len)
> +{
> +	u32 meta_len = skb_metadata_len(skb);
> +
> +	if (len > meta_len || off > meta_len - len)

A nit.

After reading it again, I think this is a duplicated check. The 
bpf_dynptr_check_off_len() called in the kfunc should have already checked the 
same condition.

> +		return ERR_PTR(-E2BIG); /* out of bounds */
> +
> +	return skb_metadata_end(skb) - meta_len + off;
> +}
> +
> +int bpf_skb_meta_load_bytes(const struct sk_buff *src, u32 off, void *dst, u32 len)

Since it needs a respin, I have a few nit comments that will be useful for 
reading filter.c.

Change the "const struct sk_buff *src" to "const struct sk_buff *skb". It is how 
other places are naming the arg in filter.c.

> +{
> +	const void *p = skb_metadata_pointer(src, off, len);

Not sure if this variable is still needed if skb_metadata_pointer does not 
return err ptr.

If it is still needed, use "const void *ptr" instead of "const void *p". The 
bpf_xdp_pointer and skb_header_pointer callers in filter.c also use that naming.

> +
> +	if (IS_ERR(p))
> +		return PTR_ERR(p);
> +
> +	memmove(dst, p, len);
> +	return 0;
> +}
> +
> +int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 off, const void *src, u32 len)
> +{
> +	void *p = skb_metadata_pointer(dst, off, len);

Same for the "struct sk_buff *dst" and "void *p" in this function.

> +
> +	if (IS_ERR(p))
> +		return PTR_ERR(p);
> +
> +	memmove(p, src, len);
> +	return 0;
> +}

