Return-Path: <bpf+bounces-63619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519D4B0909E
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7914A5912
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 15:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800E82F9498;
	Thu, 17 Jul 2025 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aftFJiu0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FD42F7D18
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766209; cv=none; b=Yu8tQdvDGo0Imw+3cW19yCCQvtImqRws1/4lOuxCghfq8yS/E05NiEPKWOaEwDkqCb3oAk/XKP8f88z1TSU1YjzKX2+qDJHA9UsbsB2PKYDVecLeraiNgeb+FmHbT/jB4G8w9GuHMjMprZoZGnshoIfUq4lOMI3JJot/1FK96yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766209; c=relaxed/simple;
	bh=ivGyxO5/FzzneWYKhe9HVCCV8zlBIPDB6XFdFiJfM34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/wuF4hwVMAsLfobgknXe2eNf1cc5YdsaF20xAROvltVFSaz3Vwo9DeftWVwV8Me7pR1HRKqXpTBxgpiWvK/o+j3oK6wq45L2QTF9riMnp6nBsv/mOML8yoNJcKaG89j5cIRSSB0F0jDdTCdQmLDHGoeAheMWrEPPyVcZmVvdas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aftFJiu0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so2171211a12.1
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 08:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752766205; x=1753371005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vsrgol1TK/+ocMyVX1rhmkelYUr4jt07AkKai6atjpc=;
        b=aftFJiu0jlqPXBmOiJ4yS6ghrwWvEwvyJsfTNvovBg8tF6Vcu0Irh+QlxxPxYnOxNu
         qTYDlzpGe2XxBOUJ5Yb6Tn2QPWyctgCzlRqPPdGJFsMlNMsoGoBsYkwES2nU5ivff/o9
         H7y7U33syJxoonbBaLaZhHVQNSzJJMi1yPssKvfp6uP+N7cnJnJx5TC71Z0wWbMpI1OC
         YPbrbzTRpyeiXwLnanhr5IjJcdd02HKjG+hRENLgAyuYvfneZOM8hBzSukMYrcKPbTMn
         HAuxepQvKDKbpxAZiidiv29aSGaP3JNZxnAawQavDjcSUjP6Ui1l+PETQ3rRopE9dhzI
         GNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752766205; x=1753371005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vsrgol1TK/+ocMyVX1rhmkelYUr4jt07AkKai6atjpc=;
        b=n+eDmYeAVlHeZWBpoFXL206VpHfrnddemdQNq7EELS3EHMzir6ig/tK4UDIXD8TH0V
         +o/VlAAdqVUlHUtMsux/uaX6BsX+m+3zhhoVammeqx6yhku87yYOiQ096KtESXuVF3QQ
         vPus0+u+uXiYRUjqWhp9zKTdqkZs781FLaux1xnz1lgcKQXDXsIwTW0tMEvpKG1oEa7x
         wcLGtKWn34kSWal2I4UL2jw3YSn1RcarF50nn5xNNLirRm8j09LkO9pq5NTVHDerqCJy
         AB8AT7DWOKBh9buiGlW+k5tcPevrjaKNqQ80vUDJNGZ9N4ojefvB57Qpy5ohzTXn4Kir
         E4Yw==
X-Gm-Message-State: AOJu0YzxsDE+FL+4lGEGTzn48R6zB4+DEfDOWMap7WQCKF0HLOFGY7pv
	4+qLTdKMzo3BARksC6WSIVigyUWmXouN0W87r3xMTVJWH3GXy5hviZe3
X-Gm-Gg: ASbGncuj3VLVCrsgq6hayAkrWuKKFX/TF2ZX21sAaHqipcbEqVlHI9rHo8z8Lh0kxaL
	Vo/5ygft4TGYoPMvQf4fC/c2kw/J8TSdx9/BB3utFptrdqGhiCXJV1h//TN6lpD246T32nTfefP
	XIsPwvzvvlX7oF/1PqkR9nurXFDEZCeUeCLwDWHOrZ0eRy+iLAmRjUo9POtmiFmA1Qp9X9iVurp
	9cU5wNTaM/CjdTrPvdZp9eIzSc3zSav4+MCSqbqytnI5Bujmhjx2z8/C881TJJnpwUqf4yfy8An
	3WvPQXmJnPDgbmY0LuTyEDdME8jPkLMlBE6+a25p8V8d1tAHqMQzBbwvDPawJlvLGMqnnzOqDE7
	gRHv71o5WwTO0P/qcqRyVCqhPZXj6aQNeyB2XGVA0dBEoth5yXfzMboTobRsw9S+xnko7160=
X-Google-Smtp-Source: AGHT+IGVxFeB7bDJ6L/cFesCIdj8Kq2Pjf0065vAWgr7Ek6+yRjgJnzTEbJldRxOPc92FyqhTFK1KA==
X-Received: by 2002:a05:6402:50d4:b0:608:3b9d:a1b with SMTP id 4fb4d7f45d1cf-612823bb089mr6623895a12.19.1752766205233;
        Thu, 17 Jul 2025 08:30:05 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::7:8a92])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6121606a19dsm7055507a12.37.2025.07.17.08.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 08:30:04 -0700 (PDT)
Message-ID: <90ef1e37-4d76-4714-9071-51c33e315fa5@gmail.com>
Date: Thu, 17 Jul 2025 16:30:01 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/5] mm, thp: add bpf thp hook to determine thp
 allocator
To: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-mm@kvack.org
References: <20250608073516.22415-1-laoar.shao@gmail.com>
 <20250608073516.22415-3-laoar.shao@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250608073516.22415-3-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/06/2025 08:35, Yafang Shao wrote:
> A new hook bpf_thp_allocator() is added to determine if the THP is
> allocated by khugepaged or by the current task.

I would add in the summary why we need this. I am assuming I will find out
when reviewing the next few patches, but would be good to know here.

> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/linux/huge_mm.h | 10 ++++++++++
>  mm/khugepaged.c         |  2 ++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2f190c90192d..db2eadd3f65b 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -190,6 +190,14 @@ static inline bool hugepage_global_always(void)
>  			(1<<TRANSPARENT_HUGEPAGE_FLAG);
>  }
>  
> +#define THP_ALLOC_KHUGEPAGED (1 << 1)
> +#define THP_ALLOC_CURRENT (1 << 2)
> +static inline int bpf_thp_allocator(unsigned long vm_flags,
> +				     unsigned long tva_flags)
> +{
> +	return THP_ALLOC_KHUGEPAGED | THP_ALLOC_CURRENT;

You dont use either vm_flags or tva_flags in this function?
I am guessing you wanted to check if these bits are set here?


But you dont seem to be setting these flags anywhere? I am guessing
its in a future patch. If it is, I would move the setting of these bits
here as its confusing to only see the check without knowing where its  

I feel this patch is broken and needs to be rewritten.
> +}
> +
>  static inline int highest_order(unsigned long orders)
>  {
>  	return fls_long(orders) - 1;
> @@ -290,6 +298,8 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>  	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
>  		unsigned long mask = READ_ONCE(huge_anon_orders_always);
>  
> +		if (!(bpf_thp_allocator(vm_flags, tva_flags) & THP_ALLOC_CURRENT))
> +			return 0;

I am assuming that this is the point to check for allocation, but thp_vma_allowable_orders
is not just used for allocation, its used for in other places as well, like hugepage_vma_revalidate
and swap.

>  		if (vm_flags & VM_HUGEPAGE)
>  			mask |= READ_ONCE(huge_anon_orders_madvise);
>  		if (hugepage_global_always() ||
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 79e208999ddb..18f800fe7335 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -472,6 +472,8 @@ void __khugepaged_enter(struct mm_struct *mm)
>  void khugepaged_enter_vma(struct vm_area_struct *vma,
>  			  unsigned long vm_flags)
>  {
> +	if (!(bpf_thp_allocator(vm_flags, 0) & THP_ALLOC_KHUGEPAGED))
> +		return;
>  	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
>  	    hugepage_pmd_enabled()) {
>  		if (__thp_vma_allowable_orders(vma, vm_flags, TVA_ENFORCE_SYSFS,


