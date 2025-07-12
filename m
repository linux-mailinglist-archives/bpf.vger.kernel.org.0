Return-Path: <bpf+bounces-63116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9DFB02AC5
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 14:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D76D1BC6EC7
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 12:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDA5275AF2;
	Sat, 12 Jul 2025 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diA/4wEz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257C517736;
	Sat, 12 Jul 2025 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752322540; cv=none; b=Av6PxzpBIMWCXtsEuvVshiYMQAu2dBH6ZqQS3CXnhhEaYncIj27jrvetD6WnE8Y5yokv1BoyljSV/KImuTMVvA2ZYSzRrvXDsod/uy6zKIX7tkkJa2t84WYYJQk7W6pOqDr2G+px8hl7w8XeaYL0msSH0/ly6h5ExKWPco59Djw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752322540; c=relaxed/simple;
	bh=e249KYaU+hoKbPcL1wLijwAJT4diyJ6i4sNLlMppY0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ybi58mZFr7KqkH53OnD1Gw2lPwlRv0WtPk31YZTTsF4Fxt49YOWmrZ+MlUJQko0lCcs/Cs7hBXAs9MECvLE9bNImgGbKu1urs3zQaD76Twz9WVpkkYmubpzYXdHBHO/tKicj//nCwSvAtmvQBBtOuoXkkFxrwPo7ItTeNs87boM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diA/4wEz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so594383666b.2;
        Sat, 12 Jul 2025 05:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752322537; x=1752927337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lIlBxNsjrpmodh9tkNQitFEn68o43sL9ZK7c1JYdDH8=;
        b=diA/4wEz64m3DCUl/ev2eysLA3N27pcDRoVfgHMAnJjXeoCmnEV5R+c67TwbZbDYNH
         jCy7+j1SyQIeI9vYqHrUeXDw4jixK3gLBFNgtS482kp5QdtUZ2xwkbK+mOFnYIw66+Ik
         Mgr9/UBmLvi5iobvWe7Xtm1zRPWGnm2hLonXVd4Sx1hnh09BAkpEnWXAATqJKB4p7kXn
         psjWR9DfweJAMl8JgCAg8zz8NGbJUn76HXtv0wtu/rA1Fp9TLPW3rsLqlT9BXQbdSlrB
         7zwsnv2l10RnxR1Q9H25hUyOGG+d/B3P/8g20YhAkkCOkMJlqUomAqdg+hFuKK2NrFet
         cNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752322537; x=1752927337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIlBxNsjrpmodh9tkNQitFEn68o43sL9ZK7c1JYdDH8=;
        b=IYqzTwcumzc7m3coykSYHl1Ky0Jz+QkhV3W9GzvtxZDSMvHLBWsIncHn4x4dOIOMhQ
         XvZJi/Mgg3BOOXntO8lt22XiQPq9G1MbZL+ArKnSxTstGvbR15nk3ZqqkbZxEdmTjex4
         7I2NEZJAteD55daP7FIqk5VmwzyXJ+O1JnxG5BrROvd/ugiQiiKrcI6rPTRQ6Ztwl0TJ
         wgu10CRH493UoUfLKVJaeXXbLykTF0OPjl02nDwETEfo4iUOvPd0AwzSKuZPFJ2gE4AN
         voIbZRKwKRosf9VIwKQe5NNtw3a2jO7R0ti8jWWq2sRjyt2rwo77NYFmIRF0NgEW8Ang
         /Neg==
X-Forwarded-Encrypted: i=1; AJvYcCUWW0Sn3xaVWNVDNw8q75Cjijuw8MCKx2Dk+lXLzKVD/ZBns4afOl8X2jEU1deJfFjEgVE=@vger.kernel.org, AJvYcCUnXu/cPd1po4GNLOn4ElA22iobuMOBpNZy1PbBLNTesTEsYf2WE1I0E+STtM4wuGhirQVyvT45IrC93Q==@vger.kernel.org, AJvYcCV56ZhMykFuo9uFEgXbCMTrjijgzAZRv0V83+8KrtYKJoN2DNMB5+8DlXSP+dK7yKyD2V60909bIn/B96VN@vger.kernel.org, AJvYcCXBqscBNHpZvxrdYUzJ5SZo4ubEr+fcJbCXWbnPi3owG//536rbuQjG0DoiAzYF61K8wesoE7n8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1PX2HnrgbCQPw1yGhVtyc36ZNF1eNDegUy1UKxs3dq9MvRlX3
	ipF6RU0663Ps0lbiLxJQBq8hccXsRDuMaTICbOf0oLsYl3oKeXwHuMXyDDWve8AT
X-Gm-Gg: ASbGncsHAwzd8ZqDaQpUL4/k3cojbIRGNCAvo6bpm5Uzpsx9NXiuOKn/ud0P8Q7Cgkl
	vdZduBRR/Vxy+/Letophh8OkHTpfosyxUnt54F+4eTKegi/MyJKCX6j8MG4c4l5HBU3aeHZuYtR
	Z4NDiHhLCLyCld6qNmVjDhdbW37NzwKyAF1GQZRKaNOFrRAjUWjJDrjAd14f1hDeEdgaEyfP2HH
	YdXl7jw/BnB1BX1WDLH02QSBSv8U0iPDGIU89Eqxk+6qM82sKHPax3TLKDQMjPcvq+kCc7KStoy
	UuMTu8VH6hYICqXP8uIBud2yLUDjJ1+WovI/FJThRYBCPHx4tX9mf/Ur6ihlyO3MUBXK5/WJVHw
	Hg7pO8wf3XvdzrEwq/Ey1VeaKexgIgoShceI=
X-Google-Smtp-Source: AGHT+IGEWzsOMo077sRXBsSB87WRFAej1CYNdPdtGOYOxUbDnztKlTxvP80Dv1WoqEx6QTThQTV7hg==
X-Received: by 2002:a17:907:1b1e:b0:ae3:bb0a:1cc6 with SMTP id a640c23a62f3a-ae6fbdc90e9mr664046366b.16.1752322537176;
        Sat, 12 Jul 2025 05:15:37 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:b2ad])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e90388sm485231566b.16.2025.07.12.05.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jul 2025 05:15:36 -0700 (PDT)
Message-ID: <db996d5b-056e-4331-b141-11aede7d7dde@gmail.com>
Date: Sat, 12 Jul 2025 13:16:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/8] netmem: introduce utility APIs to use
 struct netmem_desc
To: Byungchul Park <byungchul@sk.com>, Mina Almasry <almasrymina@google.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 kuba@kernel.org, ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net,
 john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
 tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
 jackmanb@google.com
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-3-byungchul@sk.com>
 <CAHS8izO0mgDBde57fxuN3ko38906F_C=pxxrSEnFA=_9ECO8oQ@mail.gmail.com>
 <20250711010253.GB40145@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250711010253.GB40145@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/25 02:02, Byungchul Park wrote:
> On Thu, Jul 10, 2025 at 11:11:51AM -0700, Mina Almasry wrote:
...>>> +#define nmdesc_to_page(nmdesc)         (_Generic((nmdesc),             \
>>> +       const struct netmem_desc * :    (const struct page *)(nmdesc),  \
>>> +       struct netmem_desc * :          (struct page *)(nmdesc)))
>>> +
>>> +static inline struct netmem_desc *page_to_nmdesc(struct page *page)
>>> +{
>>> +       VM_BUG_ON_PAGE(PageTail(page), page);
>>> +       return (struct netmem_desc *)page;
>>> +}
>>> +
>>
>> It's not safe to cast a page to netmem_desc, without first checking if
>> it's a pp page or not, otherwise you may be casting random non-pp
>> pages to netmem_desc...

I'd suggest to rename it to sth like pp_page_to_nmdesc() and add:

DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(page));

...

> Agree, but page_to_nmdesc() will be used in page_pool_page_is_pp() to
> check if it's a pp page or not:
> 
>     static inline bool page_pool_page_is_pp(struct page *page)
>     {
> 	struct netmem_desc *desc = page_to_nmdesc(page);
> 
> 	return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
>     }
> 
> Hm.. maybe, it'd be better to resore the original code and remove this
> page_to_nmdesc() helper.  FYI, the original code was:
> 
>     static inline bool page_pool_page_is_pp(struct page *page)
>     {
> 	struct netmem_desc *desc = (struct netmem_desc *)page;
> 
> 	return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
>     }

... And use this version. It's supposed to be temporary anyway.
It'd be great to add a build check that the page still has space
to alias with for now.

-- 
Pavel Begunkov


