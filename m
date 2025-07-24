Return-Path: <bpf+bounces-64242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1524AB106DC
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 11:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475503AB3FF
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A9524113D;
	Thu, 24 Jul 2025 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WdgOiEgd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9489623BD1A
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350247; cv=none; b=Qzm7O5hKLu2V9tbr9rFCmA2Ip9q/6lg130QPhWjpF8el65RREBstGaoHCS4NY3BRqOXJqRO+d7ZYt9vHAimNjLQO31aZJ7E4cAGiYqiePG7zNvRKz5pYWtn8szmtlWjum+naxABNnYnvBOhSmbUrDAqeyzsB0UCJQ0ulEpeVJn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350247; c=relaxed/simple;
	bh=n4kPT2lMhhPzcCkG4U6PjzmcQhrdQnWqLAwRLY5V6Uw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PLnno74DMN/F6M5PiI+BprjBjF/4Kbint5IhsPHBFYx3oe9GGsKWGAthjPGuLEfPfQt2HEHGCtO8abouZInU+C8hfhIjT2guXq7xsjJLIGe2FHmCEqCx+yIrg+hvHs0CUC8JIhD9USfPUiU5GHPKoUxyB3/q0Yy4fZSqkroYN4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WdgOiEgd; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so1708146a12.1
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 02:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753350243; x=1753955043; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZSeXQeK+KeRphR5bKM8dbnHyn+N3u8iAzXxo9jDsmY=;
        b=WdgOiEgd3optoNxYLA4C/aZeIiEJJqzJr5EUJ2mWAE+mzxt2G1DXc4XzJvu46PNklF
         /1SQbTkCt1EmXATIIXawUKK2OGWzurjfM3pFXHgSl9LGL95xc+txP2qLBKbWb+tjthnl
         HFB/NkIAOxAv76bg84eL0HZ9J6fp9sQboICnhiK/bxopthUh9R/Rri8vGw8a9AqBzBwB
         4iEggxEm9AVWC4Td6dpUbL+BRjitgB/GfK3ROdP33tV/u9Pf7NIu7VW6YKF6xkmix6Pm
         AaNSb78teHAoutSfmPAdpDC22NrEAbxPV6YP3joi5q9Zg7B4FmJ0OUqaeN4WSjLGbMTQ
         icZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753350243; x=1753955043;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZSeXQeK+KeRphR5bKM8dbnHyn+N3u8iAzXxo9jDsmY=;
        b=REJ1oL/xN7nH8USlD5GSeqZ42t34qNb8ccFKlt/8zhYJS22UyU83i9a6h/o/uOwPFJ
         NxMcl4SPPfdmLOptNcbNSrsFLr7XYKFkMayvGqBueDOXgy2uL1RmKcixFpnbk1Y8rufM
         9kkg0OWqI2c4Huvt9o6bsDci+LHt8nsufdOZ47gFSWAIeT0Y1kHTw17sAE+BhWHyNB0i
         W8ocuPF5soWX5+ZwVk4qgm7XIDavlqaTSM+i01c1VGgi/d7Dj0MB9MW0NtQ8w8n8/PAH
         Pc9uQKUXwbEh6uYlDIS6UmRsuLEh72zJczI0BV6ZxfcVAxOK5pZOpCoiy7v8wQ+Tt+RU
         Lp7w==
X-Forwarded-Encrypted: i=1; AJvYcCVnM91PjR7jSXL/n21MGCZf29qR/yQK85nZVzI8Z7w1BCQlM6fO+/oQh860bDLo0pK3VH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFyh9/wVjGBJ6Vm+ED30zlokD7l1Uvh9EPYkPBpv0JmMgsLsSl
	UJwv+6W7iMUmQAkXeESZsc7X3rpqK2+5CG9hGMF5f7J6l8LUSDd9Lt7L9s/UGFJd5AM=
X-Gm-Gg: ASbGncvIbnpO8TAdcZ01YyyR4DGvnSaDNP7fyjXNBlqqQjpC3qO+prjLjGQTSQw8+nE
	9IThAOfBnFPvOV5Ogb58GEkpwhQ2qZa4GPDzYfZDxn8B6GXhKSvBY86ZOHMrwlxpzbkrCmGAexo
	dlpdxoH9oU+LsDEpZn6JFhX2aORvtplZB0DpgD18WyV0ck5fuZjFLaqoQCjAKZRUIaPcGGt2Omn
	FY0/3z5qDh5w35EbK+CJLPKQT+ailzy8a0W3klEspKU2NX3bskO9tEhy9FMkJWsBoxkmLPXDV61
	Qe4Gd2bqAVeCc2CTuC3WBD7cDJrVeyLx/oyPwvLsIuVGPdZCzkqtFtEaxxPrT0gzTGHxODlB7qH
	/vioMMXEznyck3cUIhg4qvPPx3w==
X-Google-Smtp-Source: AGHT+IGmnQW87FYmxr9VudKFpz4QPagJwaPdqyp5ax6llJPHOb8xIpSlRALa8/JhQPnvlYD30ucpCg==
X-Received: by 2002:a05:6402:3591:b0:614:a23b:4959 with SMTP id 4fb4d7f45d1cf-614a23b4e03mr5195438a12.10.1753350242789;
        Thu, 24 Jul 2025 02:44:02 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:6b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd0d1babsm642227a12.2.2025.07.24.02.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 02:44:02 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,  Andrii Nakryiko
 <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Eduard Zingerman <eddyz87@gmail.com>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Jesper Dangaard Brouer <hawk@kernel.org>,  Jesse Brandeburg
 <jbrandeburg@cloudflare.com>,  Joanne Koong <joannelkoong@gmail.com>,
  Lorenzo Bianconi <lorenzo@kernel.org>,  Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen?=
 <thoiland@redhat.com>,  Yan Zhai <yan@cloudflare.com>,
  kernel-team@cloudflare.com,  netdev@vger.kernel.org,
  bpf@vger.kernel.org,  Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Enable read/write access to skb
 metadata through a dynptr
In-Reply-To: <ae17edd2-22af-4f0f-b130-bf2790bfd774@linux.dev> (Martin KaFai
	Lau's message of "Wed, 23 Jul 2025 17:02:11 -0700")
References: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
	<20250723-skb-metadata-thru-dynptr-v4-2-a0fed48bcd37@cloudflare.com>
	<ae17edd2-22af-4f0f-b130-bf2790bfd774@linux.dev>
Date: Thu, 24 Jul 2025 11:44:01 +0200
Message-ID: <87y0sdx6se.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 23, 2025 at 05:02 PM -07, Martin KaFai Lau wrote:
> On 7/23/25 10:36 AM, Jakub Sitnicki wrote:
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 9552b32208c5..237fb5f9d625 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -1781,7 +1781,7 @@ static int __bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr_kern *s
>>   	case BPF_DYNPTR_TYPE_XDP:
>>   		return __bpf_xdp_load_bytes(src->data, src->offset + offset, dst, len);
>>   	case BPF_DYNPTR_TYPE_SKB_META:
>> -		return -EOPNOTSUPP; /* not implemented */
>> +		return bpf_skb_meta_load_bytes(src->data, src->offset + offset, dst, len);
>>   	default:
>>   		WARN_ONCE(true, "bpf_dynptr_read: unknown dynptr type %d\n", type);
>>   		return -EFAULT;
>> @@ -1839,7 +1839,7 @@ int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, void *src,
>>   			return -EINVAL;
>>   		return __bpf_xdp_store_bytes(dst->data, dst->offset + offset, src, len);
>>   	case BPF_DYNPTR_TYPE_SKB_META:
>> -		return -EOPNOTSUPP; /* not implemented */
>
> It needs to check the flags here such that the flags can be used in the future:
>
> 		if (flags)
> 			return -EINVAL;
>

Missed that. Thanks.

> pw-bot: cr
>
>> +		return bpf_skb_meta_store_bytes(dst->data, dst->offset + offset, src, len);
>>   	default:
>>   		WARN_ONCE(true, "bpf_dynptr_write: unknown dynptr type %d\n", type);
>>   		return -EFAULT;
>> @@ -2716,7 +2716,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr *p, u32 offset,
>>   		return buffer__opt;
>>   	}
>>   	case BPF_DYNPTR_TYPE_SKB_META:
>> -		return NULL; /* not implemented */
>> +		return bpf_skb_meta_pointer(ptr->data, ptr->offset + offset, len);
>>   	default:
>>   		WARN_ONCE(true, "unknown dynptr type %d\n", type);
>>   		return NULL;
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 0755dfc0fc2f..cf095897d4c1 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -11978,6 +11978,45 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>>   	return func;
>>   }
>>   +static void *skb_metadata_pointer(const struct sk_buff *skb, u32 off, u32
>> len)
>> +{
>> +	u32 meta_len = skb_metadata_len(skb);
>> +
>> +	if (len > meta_len || off > meta_len - len)
>
> A nit.
>
> After reading it again, I think this is a duplicated check. The
> bpf_dynptr_check_off_len() called in the kfunc should have already checked the
> same condition.

I took a better-safe-than-sorry approach. Can skb_metadata_len() change
after the call to bpf_dynptr_from_skb_meta()? Today it can't, but what
if we let TC BPF resize the metadata area in the future?

But you're right. It's duplicated code for now and can be dropped.

>
>> +		return ERR_PTR(-E2BIG); /* out of bounds */
>> +
>> +	return skb_metadata_end(skb) - meta_len + off;
>> +}
>> +
>> +int bpf_skb_meta_load_bytes(const struct sk_buff *src, u32 off, void *dst, u32 len)
>
> Since it needs a respin, I have a few nit comments that will be useful for
> reading filter.c.
>
> Change the "const struct sk_buff *src" to "const struct sk_buff *skb". It is how
> other places are naming the arg in filter.c.

No problem. I will unify it with:

int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 offset, void *to, u32 len);
int __bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void *from,
			  u32 len, u64 flags);

>
>> +{
>> +	const void *p = skb_metadata_pointer(src, off, len);
>
> Not sure if this variable is still needed if skb_metadata_pointer does not
> return err ptr.
>
> If it is still needed, use "const void *ptr" instead of "const void *p". The
> bpf_xdp_pointer and skb_header_pointer callers in filter.c also use that naming.
>

Will do.

>> +
>> +	if (IS_ERR(p))
>> +		return PTR_ERR(p);
>> +
>> +	memmove(dst, p, len);
>> +	return 0;
>> +}
>> +
>> +int bpf_skb_meta_store_bytes(struct sk_buff *dst, u32 off, const void *src, u32 len)
>> +{
>> +	void *p = skb_metadata_pointer(dst, off, len);
>
> Same for the "struct sk_buff *dst" and "void *p" in this function.
>

Will change.

>> +
>> +	if (IS_ERR(p))
>> +		return PTR_ERR(p);
>> +
>> +	memmove(p, src, len);
>> +	return 0;
>> +}

Thanks for reviewing.

