Return-Path: <bpf+bounces-63114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DD4B02AB7
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 13:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A494E4A35B5
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 11:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4435275AED;
	Sat, 12 Jul 2025 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTW2ksTn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A6286348;
	Sat, 12 Jul 2025 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752321501; cv=none; b=Jfj03GZFbukBIHWjPh2E0dQfhXLF71RdF2uFMyGtZ4mhLAykPYTuSCoNV62/d8Y1XUBkY4/rmOn/fReB4yPJD5TeF5qawwPlNZPi6A7N5kGdS/3vXE98HSUYYSoWjMFdIQwJqFrU3TqMRmvFX2AoD0nLySr/d+NrUXdRm/34feE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752321501; c=relaxed/simple;
	bh=X6+u5pYaYs7J8ton0lozvF5hUo2CeCarJ6V7MpuNIFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TO+MuGJj6V4pK0hed1PFEFYJPgquySQihu0qwrBnIJmGewheEMa3TFjHUX+iROvga9TJkYRLJlBUC5J3yDyg65XoEI0OcemBiSLLak/2R3TP0Ulswghr9S3E4r626IUS2PAr30Z/ye0ol0fiRuC8Fz9f8yDapss7eea7d8nxF3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTW2ksTn; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so592494266b.2;
        Sat, 12 Jul 2025 04:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752321498; x=1752926298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hP+xr8zzqNCzMu2bRqX5AggMpbifXKPp5N+26RWR9n0=;
        b=aTW2ksTnPWSiM1HR8PlCPPmiKCiBtRZidJfXdhRMu5PpCTFlAIR22LeOxwCk/Xv37o
         zbsDw5UYqRyhkm4P65PqUvQJeTHgXiXNd2PpGVCetZ8G6gweKGss9SdrQ7mJEFvcnPpz
         Xm8NBoQxk3WNIpHFI6Eo5gigJYPY9j+2lc0cV0/TUcIqrD78J1x3m7T0Tk/Cp9wLNKPy
         Qp1Gi05BoWc5TIxM5rH8UubHOvj/8YWHnvBQpM5FW06lNJzUWNn+dZbkbaU5P8W4lbrS
         U6DgsKy618qsNeyYlxD9mTXibcGVCMpyuuOKR8cu/ybibgiO1/kK7Claqb5eSHE9ghSW
         BCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752321498; x=1752926298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hP+xr8zzqNCzMu2bRqX5AggMpbifXKPp5N+26RWR9n0=;
        b=DenY+Pet2tf7Q7Im4hYnKAikxOiOdlbrfNPAmxulCr2ejc1ETv+JtEa6kCacrMH8PP
         exfJj5il1hIHjPnk3aIqQupOdq9Ms9ajMYV7uuPetSS6Yi9KWnCtss4EGgj6N9vP4Uc6
         IxggcuGLQ3fR/1SDGMueFKs6N7iRwGmk8+v4aDRIn3ITcabi5ik495ZzHVfn2edHv0Cl
         xfOdjY8x9MORPd/40xKnJa8QiEfnJJXpXGPuBCrTFbt13FcEuh1FWJJIMytN+muL8EgC
         oEpF2gl0gEstyqC5dqhaMKOWiNJNDOfhM5/TfDiCeffKpNTV+1uxgC5ZHMjnywG+Hvd9
         xhgw==
X-Forwarded-Encrypted: i=1; AJvYcCV49OOEC2ur3z3HObfknmM8ceURCcoQXhFEFPNJAeUlkjXXe+7iWhgBH2AEa9trwvb0y30Im2+c@vger.kernel.org, AJvYcCXsYo24bKJf0py18Qj6jWKFYuhw6orypd/BSAlIEJOcaqGrN0mjzMp5ZxR6qIKErrjyXGs=@vger.kernel.org, AJvYcCXslo7+w/gILdiVI1e4I6+7BnsSTU1Sy2l3oxWilpHK/Eg4spXYIWfkzjVeVYgsVyihLQgP4MBGnZ2Glg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9cCLZ8N0PfObEvqFvsy4BT9BHpF+vpsEg6iuIzSvxDQlWQNv7
	RKkz8c1TCuXHQ/uiYyr/EKoZQwxZsfIcVu18UBKeveS6gEMMMhW/SmRW
X-Gm-Gg: ASbGncsaEd2tXlVeLYMA4Z5qCukrk45i7MygKbfiISWRfKH+29gynC+fOWgv2uDYlUT
	Kbf1gmpGgd7LlZDT1NmoJnUVV215ziB7SQLb2rtf4CSseAq2vYNufM1Du+MOa+K/63OgkXltB4H
	xA9Hnyebwisn5Oo9wplQM1MaZckFHrM/LzqpWwl1IG+MvaHRs4srM4F6AW3r/GuyDH22Th0YYaL
	bNbJJg0CW90H00+MyFgQWglhsVy2F6VF3aYwTutM1MEGAJUM3/gfvgEJQi/iLjMWav9Wtd64Mfi
	3hwdPFFO3BWHbzZ6cv1YWQL/ijcpvmBG7E1Jo68GJu4WeiEa6EfdXe0UzFabLA65Uyo424V42HV
	+rWJamFtKEKBPq/T8uV/3ATvGi3psYI9bmTs=
X-Google-Smtp-Source: AGHT+IGIng8Jp0aA3rpk3u1fXyOC8/wF9+m2XwqL2YDV2mg0DsuWIhpzPrj/i3XlLVi8Cw4TUs0HjQ==
X-Received: by 2002:a17:906:9f90:b0:ae0:d4f2:dff3 with SMTP id a640c23a62f3a-ae6fc219a7bmr636252966b.58.1752321497701;
        Sat, 12 Jul 2025 04:58:17 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:b2ad])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294bf2sm467992366b.122.2025.07.12.04.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jul 2025 04:58:16 -0700 (PDT)
Message-ID: <4a8b0a45-b829-462c-a655-af0bda10a246@gmail.com>
Date: Sat, 12 Jul 2025 12:59:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/8] netmem: introduce utility APIs to use
 struct netmem_desc
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com,
 hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-3-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250710082807.27402-3-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/25 09:28, Byungchul Park wrote:
...> +
>   static inline struct net_iov *netmem_to_net_iov(netmem_ref netmem)
>   {
>   	if (netmem_is_net_iov(netmem))
> @@ -314,6 +340,21 @@ static inline netmem_ref netmem_compound_head(netmem_ref netmem)
>   	return page_to_netmem(compound_head(netmem_to_page(netmem)));
>   }
>   
> +#define nmdesc_to_page(nmdesc)		(_Generic((nmdesc),		\
> +	const struct netmem_desc * :	(const struct page *)(nmdesc),	\
> +	struct netmem_desc * :		(struct page *)(nmdesc)))

Considering that nmdesc is going to be separated from pages and
accessed through indirection, and back reference to the page is
not needed (at least for net/), this helper shouldn't even exist.
And in fact, you don't really use it ...

> +static inline struct netmem_desc *page_to_nmdesc(struct page *page)
> +{
> +	VM_BUG_ON_PAGE(PageTail(page), page);
> +	return (struct netmem_desc *)page;
> +}
> +
> +static inline void *nmdesc_address(struct netmem_desc *nmdesc)
> +{
> +	return page_address(nmdesc_to_page(nmdesc));
> +}

... That's the only caller, and nmdesc_address() is not used, so
just nuke both of them. This helper doesn't even make sense.

Please avoid introducing functions that you don't use as a general
rule.

> +
>   /**
>    * __netmem_address - unsafely get pointer to the memory backing @netmem
>    * @netmem: netmem reference to get the pointer for

-- 
Pavel Begunkov


