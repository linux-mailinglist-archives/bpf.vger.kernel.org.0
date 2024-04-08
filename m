Return-Path: <bpf+bounces-26142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6253289B70B
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 07:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A880CB2132D
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 05:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567967482;
	Mon,  8 Apr 2024 05:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XHK7olPG"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6D6FB9
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 05:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712552487; cv=none; b=SG+9g9iu3Rb4HuLu1cyZGVz42MPn08S0DDW+a9h+bEfV5oIGYyweLmSOhzfsKvBJhR4n+NxYRuni47orwGhWYxebdbPSPn2rGRgk5ohVPC5CYQTHAhnE5EbjtzSri1IygLy9pvjvYJGtZ5iClo2FKNhwPM6su34iD7Sni+yL5Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712552487; c=relaxed/simple;
	bh=xr8LKXo/pDjYkksQivBSDUwO6hvIQV0v0w/HcWkkzws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zc+qOpb+CJGONFLx2u2pOTd7FbHObWDeC0sSF86xACZAtrpFsA9nHHKzgTfE3RceIBA+BVfnT3HPF+402OftbNiEaW2k4QGo0mMc/UB3WfiLatO8KT3ZYeuxlxTKavDzl1AZTWjOkAKPE55Qwg+QrJHkDGTJUCYRwAEKGURTwGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XHK7olPG; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6c0da109-c0f2-4819-806a-15e944908ebe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712552483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bssN3TC329Pz5FNKo+keX0GkHceV7Oe9TogWX6A1sZo=;
	b=XHK7olPG7UlAp0GuoOkAnIvQDHC1pO8dX89phjp4WQ+WqkSbPZVDL8qoXPvAfdDLlCqQCo
	maRJYdP8ipBlL4o+jAIxHGwseh09OW+9sRjphg0x88F6OGBn5+NlS/dRJwT3/oOCHKHf4P
	uiAv52o4V4x/PT+neOgQbQ68Pay2xBI=
Date: Sun, 7 Apr 2024 22:01:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 1/5] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jakub Sitnicki
 <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240406160359.176498-1-yonghong.song@linux.dev>
 <20240406160404.177055-1-yonghong.song@linux.dev>
 <7ade50c68b204816224f9eb51cdcb9ec53a4ff31.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <7ade50c68b204816224f9eb51cdcb9ec53a4ff31.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/6/24 4:18 PM, Eduard Zingerman wrote:
> On Sat, 2024-04-06 at 09:04 -0700, Yonghong Song wrote:
>
> [...]
>
>> @@ -1454,55 +1466,95 @@ static struct sk_psock_progs *sock_map_progs(struct bpf_map *map)
>>   	return NULL;
>>   }
>>   
>> -static int sock_map_prog_lookup(struct bpf_map *map, struct bpf_prog ***pprog,
>> -				u32 which)
>> +static int sock_map_prog_link_lookup(struct bpf_map *map, struct bpf_prog ***pprog,
>> +				     struct bpf_link ***plink, struct bpf_link *link,
>> +				     bool skip_link_check, u32 which)
>>   {
>>   	struct sk_psock_progs *progs = sock_map_progs(map);
>> +	struct bpf_prog **cur_pprog;
>> +	struct bpf_link **cur_plink;
>>   
>>   	if (!progs)
>>   		return -EOPNOTSUPP;
>>   
>>   	switch (which) {
>>   	case BPF_SK_MSG_VERDICT:
>> -		*pprog = &progs->msg_parser;
>> +		cur_pprog = &progs->msg_parser;
>> +		cur_plink = &progs->msg_parser_link;
>>   		break;
>>   #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
>>   	case BPF_SK_SKB_STREAM_PARSER:
>> -		*pprog = &progs->stream_parser;
>> +		cur_pprog = &progs->stream_parser;
>> +		cur_plink = &progs->stream_parser_link;
>>   		break;
>>   #endif
>>   	case BPF_SK_SKB_STREAM_VERDICT:
>>   		if (progs->skb_verdict)
>>   			return -EBUSY;
>> -		*pprog = &progs->stream_verdict;
>> +		cur_pprog = &progs->stream_verdict;
>> +		cur_plink = &progs->stream_verdict_link;
>>   		break;
>>   	case BPF_SK_SKB_VERDICT:
>>   		if (progs->stream_verdict)
>>   			return -EBUSY;
>> -		*pprog = &progs->skb_verdict;
>> +		cur_pprog = &progs->skb_verdict;
>> +		cur_plink = &progs->skb_verdict_link;
>>   		break;
>>   	default:
>>   		return -EOPNOTSUPP;
>>   	}
>>   
>> +	/* The link check will be skipped for link_detach case. */
>> +	if (!skip_link_check) {
>> +		/* for prog_attach/prog_detach/link_attach, return error if a bpf_link
>> +		 * exists for that prog.
>> +		 */
>> +		if (!link && *cur_plink)
>> +			return -EBUSY;
>> +
>> +		/* for bpf_link based prog_update, return error if the stored bpf_link
>> +		 * does not match the incoming bpf_link.
>> +		 */
>> +		if (link && link != *cur_plink)
>> +			return -EBUSY;
>> +	}
> I still think that this check should be factored out to callers,
> this allows to reduce the number of function parameters,
> and better separate unrelated logical error conditions.
> E.g. like in the patch at the end of this email
> (applied on top of the current patch).

Thanks Eduard. I also bothered with too many arguments for
the function. I guess your suggested change below indeed
better as we still keep the attach type enum in the function
and factored following code in different situations.
Will make the change in the next revision!

>
> [...]
>
> ---
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 4af44277568e..a642215faa20 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -1467,8 +1467,7 @@ static struct sk_psock_progs *sock_map_progs(struct bpf_map *map)
>   }
>   
>   static int sock_map_prog_link_lookup(struct bpf_map *map, struct bpf_prog ***pprog,
> -				     struct bpf_link ***plink, struct bpf_link *link,
> -				     bool skip_link_check, u32 which)
> +				     struct bpf_link ***plink, u32 which)
>   {
>   	struct sk_psock_progs *progs = sock_map_progs(map);
>   	struct bpf_prog **cur_pprog;
> @@ -1504,21 +1503,6 @@ static int sock_map_prog_link_lookup(struct bpf_map *map, struct bpf_prog ***ppr
>   		return -EOPNOTSUPP;
>   	}
>   
> -	/* The link check will be skipped for link_detach case. */
> -	if (!skip_link_check) {
> -		/* for prog_attach/prog_detach/link_attach, return error if a bpf_link
> -		 * exists for that prog.
> -		 */
> -		if (!link && *cur_plink)
> -			return -EBUSY;
> -
> -		/* for bpf_link based prog_update, return error if the stored bpf_link
> -		 * does not match the incoming bpf_link.
> -		 */
> -		if (link && link != *cur_plink)
> -			return -EBUSY;
> -	}
> -
>   	*pprog = cur_pprog;
>   	if (plink)
>   		*plink = cur_plink;
> @@ -1539,9 +1523,14 @@ static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
>   	struct bpf_link **plink;
>   	int ret;
>   
> -	ret = sock_map_prog_link_lookup(map, &pprog, &plink, NULL, link && !prog, which);
> +	ret = sock_map_prog_link_lookup(map, &pprog, &plink, which);
>   	if (ret)
> -		goto out;
> +		return ret;
> +	/* for prog_attach/prog_detach/link_attach, return error if a bpf_link
> +	 * exists for that prog.
> +	 */
> +	if ((!link || prog) && *plink)
> +		return -EBUSY;
>   
>   	if (old) {
>   		ret = psock_replace_prog(pprog, prog, old);
> @@ -1553,8 +1542,7 @@ static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
>   			*plink = link;
>   	}
>   
> -out:
> -	return ret;
> +	return 0;
>   }
>   
>   int sock_map_bpf_prog_query(const union bpf_attr *attr,
> @@ -1579,7 +1567,7 @@ int sock_map_bpf_prog_query(const union bpf_attr *attr,
>   
>   	rcu_read_lock();
>   
> -	ret = sock_map_prog_link_lookup(map, &pprog, NULL, NULL, true, attr->query.attach_type);
> +	ret = sock_map_prog_link_lookup(map, &pprog, NULL, attr->query.attach_type);
>   	if (ret)
>   		goto end;
>   
> @@ -1770,10 +1758,15 @@ static int sock_map_link_update_prog(struct bpf_link *link,
>   		goto out;
>   	}
>   
> -	ret = sock_map_prog_link_lookup(sockmap_link->map, &pprog, &plink, link, false,
> +	ret = sock_map_prog_link_lookup(sockmap_link->map, &pprog, &plink,
>   					sockmap_link->attach_type);
>   	if (ret)
>   		goto out;
> +	/* for bpf_link based prog_update, return error if the stored bpf_link
> +	 * does not match the incoming bpf_link.
> +	 */
> +	if (link != *plink)
> +		return -EBUSY;
>   
>   	if (old) {
>   		ret = psock_replace_prog(pprog, prog, old);

