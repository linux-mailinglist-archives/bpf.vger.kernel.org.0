Return-Path: <bpf+bounces-63125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5686B02B9C
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 17:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30C487B454B
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 15:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B852877CB;
	Sat, 12 Jul 2025 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpoY7MHs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0054620A5EB;
	Sat, 12 Jul 2025 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752332880; cv=none; b=YWRHv7vSbcQgP2lRDup30h1SbtwZyZFtzQUgFLrAcYzeSCVAkKpvctcJtiDKGnbpTSGaOZ8LdcpE+5Ci82Jp9b0/yRbYrsEaoYhMptSvDyvg2ZYnDQ2D1I8II0x5VF0ZtydG+3I+KuoBJKX0OUE3CkTiv56eKoSjHtjMUsnV3xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752332880; c=relaxed/simple;
	bh=Ml68cAZ0jrmTzQ/+zKW2XkASPBTqrniL7VHVr0ztAks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+bH4ueCj3Dld2JnNS/VEfNLk4syjL/h7GtCqLaK2v3Y4kpalA2Fi5F8wT+kxkGndZIfdTdQotlTUHdoKCcv3wsR5Ti5HuffcfNOGuCoGDbVh5FlhjtuXxOa/wRbRMFtoeeusbsnZHTxNnDVD7AsunDsbA6dWi7BchVyOC0A6fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpoY7MHs; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so5030755a12.3;
        Sat, 12 Jul 2025 08:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752332877; x=1752937677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LjapWLaKwEm+cnxI7mm3uoKAqQEsEg4Xa2RcYI/4Fpw=;
        b=XpoY7MHstf3afq5QlK2ZMo4P8MGb/WdWhtKT8ZBS4C2rwxMGptHL9E/j/ByKrlQgkR
         mnmm9ZbTpuE8CSlxj2bWaAy685OXBZp/W3gDXNcwuoJXTX/bePCS11asy+7olp7zSBPU
         jx+lh3vs5nmTMiu6R6ZBmdPS22Fnr20SgHtlvwLr7xC12qb7CbwAD+ADhyJa7N/cIowV
         asM7AWXy0n1mfQZbgFeTiR76HK/zeIVRrLPc0GZe+NZI3TlpLtrVov/PdcIoWn7kPQax
         MREQDSwmHjDsLCgZDpKJ97spoDNPS/mwqNNzP4ZmlY9x7askAiB3n+DX7A3b7y0gPhfe
         Wn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752332877; x=1752937677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjapWLaKwEm+cnxI7mm3uoKAqQEsEg4Xa2RcYI/4Fpw=;
        b=eXZIzt+5i2QwEhdjXRFrOtBA1a+8tCUaNvYawkIRoJC6yxNNuXb9FZq+p0YFmAe98D
         +takAWVjHsmBPDznzEJxH7ZQc2KDmMamA6NeCiWTT2UUIQat5F4v9xenC4/QsYUNyc29
         WE1ak6UxLnjjPejbVmKVNCtGcFxobkq0GNx68CLB2C/no/WDWAVhSQoO1iyCEVWYWm2v
         Topk+iRSc8zghH0mHZsQaFYddCXNpxBRelmlm4RB+foop++WXKAE19azF6e0TGF7t0CV
         Ge3WA/KVXFiXQebDZksl2NEtcpeOQE6cFO6rT2Drmru/93So5MwFplvt9ApjLYc+Z0Xr
         k8zw==
X-Forwarded-Encrypted: i=1; AJvYcCWFvQhnOlYAutOzBLI5nrqlXe1AHsFqB6JU9+gAxSdm9pr0o5V+KQga7QHOrfi1iKrTiDA=@vger.kernel.org, AJvYcCWbiBVwJXTTrQae0HjiAJi7+pwE/9E81fTvbySVgXDLHnEodZ9YRPmUHp59chQ8pzOcu3xmb2Y4iubaUw==@vger.kernel.org, AJvYcCXddcMW2xPnnymrgciB8L0+GvdUbGYkdCFltKZUAW/RS0o+SwND7bDYBNH6Y/SGNWFMRjGGCozM99U/+SvU@vger.kernel.org
X-Gm-Message-State: AOJu0YzdfTf/9h+H1pn2hRVmwPMa3QOgUlyWIR8DH45betSUNQZhbNWe
	4xPd4dmYlLdeT2VdtEPF0zJNPxOk2flfkXLv4IIP/wq7CjIpPYTS4WfT
X-Gm-Gg: ASbGnctvvB6S++rKKh5Tl59RRqft3qGRp7FIurQn2zh9vcXFuoImhTaMG5/yX761QbH
	0JQocWdmJgOY8gMS/7RBh9AfFyaTKdVip3F25SwrK4s3bosCHytVCFfsnVp+XUZ1RP0cCDNPHSo
	BDhTWA9O5tTPW5Obl6l+eNdVO3hB0Ml56ALZdCw1Eyo4kS1IiYUZG9LLMLBkPod+hORXnmbTShH
	x+m4UhE9QmW7iI+3mQVNLcKQTM6ERtVeNB1IukSW2QaS3BnCr5R//srgSsgy5HUUSjKaXNUopP9
	UJWqmdFfqOu1M50Xl1s+8xfX9gekCvTcUOOiMijh1Z4T47gRFG9vyhBdkBB3dmnSXGe3SS18MmQ
	wv25+gZ1N5xsZzpB+L67uu5LE4Ew9bOEtejQ=
X-Google-Smtp-Source: AGHT+IH0ccXxEaV+aqcSaAvnAzt/69VcEQFX7DWBxvFbG4EKn7IpAxKQyRxv0Ia+9U1NVY8obQDJ0A==
X-Received: by 2002:a05:6402:2553:b0:607:f31f:26de with SMTP id 4fb4d7f45d1cf-611e760ac17mr5513207a12.1.1752332876715;
        Sat, 12 Jul 2025 08:07:56 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:3e2a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611ee1716fcsm2181067a12.7.2025.07.12.08.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jul 2025 08:07:55 -0700 (PDT)
Message-ID: <7c8b9d7f-545c-4e37-8d0e-39b1d525a949@gmail.com>
Date: Sat, 12 Jul 2025 16:09:13 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 3/8] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
To: David Hildenbrand <david@redhat.com>, Byungchul Park <byungchul@sk.com>,
 Mina Almasry <almasrymina@google.com>,
 "willy@infradead.org" <willy@infradead.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, ilias.apalodimas@linaro.org,
 harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com,
 hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-4-byungchul@sk.com>
 <CAHS8izMXkyGvYmf1u6r_kMY_QGSOoSCECkF0QJC4pdKx+DOq0A@mail.gmail.com>
 <20250711011435.GC40145@system.software.com>
 <582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com>
 <3acd967e-30b3-4e76-9e1b-41c1e19d4f31@redhat.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <3acd967e-30b3-4e76-9e1b-41c1e19d4f31@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/12/25 15:52, David Hildenbrand wrote:
> On 12.07.25 15:58, Pavel Begunkov wrote:
>> On 7/11/25 02:14, Byungchul Park wrote:
>> ...>>> +#ifdef CONFIG_PAGE_POOL
>>>>> +/* XXX: This would better be moved to mm, once mm gets its way to
>>>>> + * identify the type of page for page pool.
>>>>> + */
>>>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>>>> +{
>>>>> +       struct netmem_desc *desc = page_to_nmdesc(page);
>>>>> +
>>>>> +       return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
>>>>> +}
>>>>
>>>> pages can be pp pages (where they have pp fields inside of them) or
>>>> non-pp pages (where they don't have pp fields inside them, because
>>>> they were never allocated from the page_pool).
>>>>
>>>> Casting a page to a netmem_desc, and then checking if the page was a
>>>> pp page doesn't makes sense to me on a fundamental level. The
>>>> netmem_desc is only valid if the page was a pp page in the first
>>>> place. Maybe page_to_nmdesc should reject the cast if the page is not
>>>> a pp page or something.
>>>
>>> Right, as you already know, the current mainline code already has the
>>> same problem but we've been using the werid way so far, in other words,
>>> mm code is checking if it's a pp page or not by using ->pp_magic, but
>>> it's ->lur, ->buddy_list, or ->pcp_list if it's not a pp page.
>>>
>>> Both the mainline code and this patch can make sense *only if* it's
>>> actually a pp page.  It's unevitable until mm provides a way to identify
>>> the type of page for page pool.  Thoughts?
>> Question to mm folks, can we add a new PGTY for page pool and use
>> that to filter page pool originated pages? Like in the incomplete
>> and untested diff below?
> 
> https://lore.kernel.org/all/77c6a6dd-0e03-4b81-a9c7-eaecaa4ebc0b@redhat.com/

Great, then it'll be the right thing to do here. I somehow missed
the post, will add your suggested-by.

-- 
Pavel Begunkov


