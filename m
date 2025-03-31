Return-Path: <bpf+bounces-54968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCA7A767A2
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 16:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4D81693D9
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 14:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327B3211484;
	Mon, 31 Mar 2025 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Npxf20l8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34552116FB
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743430780; cv=none; b=ZSXWi1nqOUO5VoCdfqA+hR6nzIWS33Fv59mXF9UhKT4FalMOmoSkXd9U4kqqeNSEhkMsbM3lbs9eT4D/G3uVnRRrON17zXDNUxnJmq75IBBS35qyYTYZBwJdogD6A1r/viY/a956nxUeCvCMb+Ot1FqiAz7uEGFylBncLZXGutA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743430780; c=relaxed/simple;
	bh=+t488dEmHQJAO3jFfrt8V7/UCzMav5WFnaBdBdPDxaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tApyipb6arWWmC4m62eGjkFQlAEBmd8MV8hM0rLmFRaNPmJqc0uBnR7EstaJiRh5NZM86mHSsgIk5LZzWwfo+qBLfm/2ccMS+MJilnbHg3ojxr70c+M5ytJ/yxeoELu3/UDyeJ4yKcxa7uTtUl0igxs4qnYsVOqo4WUS0lh1Fvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Npxf20l8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743430778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYj0pUIwEANUtr1SIrZWSom30G8/htq+S+uugiq5mDU=;
	b=Npxf20l8YbWyQpsxekouNvP9q3BCjwQZ+xji+LjfePNNaqx2oe88dLDEoTUX2q3wvxLKku
	FsUocKa7yWBzzoBQJ4q8J7KelYW0u5WzuT9csFXmSROBVhsAq+6kYsbu9LXTyP0JmK3u0R
	5cZIM/AbFc3ZTVH9jhk80xpWxyPDg4s=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-JFH36RHuMUCUYT8sMUUcQg-1; Mon, 31 Mar 2025 10:19:36 -0400
X-MC-Unique: JFH36RHuMUCUYT8sMUUcQg-1
X-Mimecast-MFC-AGG-ID: JFH36RHuMUCUYT8sMUUcQg_1743430776
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85b5875e250so458569839f.0
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 07:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743430776; x=1744035576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYj0pUIwEANUtr1SIrZWSom30G8/htq+S+uugiq5mDU=;
        b=aNAkkvPe70uhclxGcFor947Pk0cjMo2vghEMcVnuJMsb1RHGry7P/tiMFm4M1S7zbH
         dfQqvt97NlE1eaGl6OCLtqV2cG8cmje3WVJMicBy1VOhmi/yPrOPeyI1rdB3/CRS++fQ
         0BVgajqM86vBBIw3BJ9FPFwjYzEohpRuwuok9sda3YXu0rmE7dyvroEweAO14AkdqPKv
         XJmP7TjeZnKlSk4jzao1olmfk5gf32OeEjSXST/DSHGFii4awd+++nBMvaAQMyCgn+ko
         DVeAD4/HuzUd8EoXUzIhGESFy73NgEJAlShJMByp+cVwUurmWzYxwfqIoKarM3rfHvvh
         CMww==
X-Forwarded-Encrypted: i=1; AJvYcCXwD1DiG+Fy5rY7m1pmm1YB8+JglLR7+U+oWmjuf6nNnEWH1zhP9o20J1FcG+hrbKVcadY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/nnh3ZHqbd0OPTDPbELuqv6SDV4n1K6K4oBJ7it2R1DF9bETH
	HxiR5noDQoibz5CO2JOOyIVn+0HT8nc9q0UEzh/Ruod71ALEBVw7D49Cx6lrLBpGOR/yN7hyAdF
	q5EvLcO9sD2gmYLGaR7JHyLzD+5DcxDljxyrC4NAQwwlseFtASA==
X-Gm-Gg: ASbGncuMX2EMeQtL2n29KmmHSWVuvA+F+haNb6QY5QP6W/5wXffTcMc01kdlItIs2Jd
	bv0Fk71vwJ3pbdu+w7QdS/G77l+gbRk5cBGBiyKWdpU65r+0kMIQq9Y+98BoHepe480v6pq3H8y
	mvf58QChtQpjB4pIlQ8358KyX2QU1VCfqFmY15jCIgVJRknrpL0V5E3rugpkP3CzdY5AnyCixIA
	yxzAf1mZe+/lV6pZiyKWSH7ndoFEEBXY13vw+bh4yfY4ckok5VjrpSc5xkcQfJM+EdaVFJ+dBre
	5Q3Az+8+lJEXhednDyWXB81PIek1nACuBHpXEbxE1DKJL4086N4D8bIX52MZ0dzR5URbgpFWu0K
	KbKqK2g==
X-Received: by 2002:a05:6602:7510:b0:85b:3f8e:f186 with SMTP id ca18e2360f4ac-85e9e86ba74mr916824639f.6.1743430775804;
        Mon, 31 Mar 2025 07:19:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5pTCoJhS0f0R2nEGIYPWp4mq7Cak4xheeVR+42CL4J7sT1W2wZ0prBJdDzgXZr37+OQwcbg==
X-Received: by 2002:a05:6602:7510:b0:85b:3f8e:f186 with SMTP id ca18e2360f4ac-85e9e86ba74mr916821639f.6.1743430775499;
        Mon, 31 Mar 2025 07:19:35 -0700 (PDT)
Received: from [192.168.2.110] (bras-base-aylmpq0104w-grc-20-70-53-200-211.dsl.bell.ca. [70.53.200.211])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f464751ea2sm1831919173.52.2025.03.31.07.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 07:19:35 -0700 (PDT)
Message-ID: <7e816e0f-19af-4ef2-bf84-fc762ecbae26@redhat.com>
Date: Mon, 31 Mar 2025 10:19:34 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the bpf-next tree with the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250311120422.1d9a8f80@canb.auug.org.au>
 <20250331102749.205e92cc@canb.auug.org.au>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20250331102749.205e92cc@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-03-30 19:27, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 11 Mar 2025 12:04:22 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Today's linux-next merge of the bpf-next tree got a conflict in:
>>
>>    mm/page_owner.c
>>
>> between commit:
>>
>>    a5bc091881fd ("mm: page_owner: use new iteration API")
>>
>> from the mm-unstable branch of the mm tree and commit:
>>
>>    8c57b687e833 ("mm, bpf: Introduce free_pages_nolock()")
>>
>> from the bpf-next tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>
>>
>> diff --cc mm/page_owner.c
>> index 849d4a471b6c,90e31d0e3ed7..000000000000
>> --- a/mm/page_owner.c
>> +++ b/mm/page_owner.c
>> @@@ -297,11 -293,17 +297,17 @@@ void __reset_page_owner(struct page *pa
>>    
>>    	page_owner = get_page_owner(page_ext);
>>    	alloc_handle = page_owner->handle;
>>   +	page_ext_put(page_ext);
>>    
>> - 	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
>> + 	/*
>> + 	 * Do not specify GFP_NOWAIT to make gfpflags_allow_spinning() == false
>> + 	 * to prevent issues in stack_depot_save().
>> + 	 * This is similar to try_alloc_pages() gfp flags, but only used
>> + 	 * to signal stack_depot to avoid spin_locks.
>> + 	 */
>> + 	handle = save_stack(__GFP_NOWARN);
>>   -	__update_page_owner_free_handle(page_ext, handle, order, current->pid,
>>   +	__update_page_owner_free_handle(page, handle, order, current->pid,
>>    					current->tgid, free_ts_nsec);
>>   -	page_ext_put(page_ext);
>>    
>>    	if (alloc_handle != early_handle)
>>    		/*
> 
> This is now a conflict between the mm-stable tree and Linus' tree.

What's the best way to resolve this? Should I post again or can we just use your fix?


