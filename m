Return-Path: <bpf+bounces-27829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64CB8B2731
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 19:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD061F252D8
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 17:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C635E14D70B;
	Thu, 25 Apr 2024 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9/CdTAP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BC0149E0E
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064908; cv=none; b=Bo23XEbCVvqok7DhgsxpxeLnDeOEL2munTXLJrUHU7TzvVHroFKjq3T972APREn0PZXVunl+Rqqc0vH+JLAQPMDSNcJNPU1PoyrBcYusswQHA8kLFqb2ppbye6xzeoqzkxaW97QaqwZOcnIL6utqmlvEZ44jzgFuXFD/SR3sLbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064908; c=relaxed/simple;
	bh=+ZchHe39VnwHdswxKJGO1+zFArU+wA4BN6D/VFGCG7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ea8qK/+7iURiHxzwCS0aeReCwxpYXNhaNmPf2uq+lFpZYrKXMDpe7DEP9xbb+qWn8o32HeL7yR8LvwIUj7w18Ffgba3od1WQiTgIHV7jFHiujLXLyFk14GrytppSOrLgFeyPO/MYsVU6qDadNj1u4pocPTXl3E1M6eTtPeCKC1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9/CdTAP; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61b3be24dd9so10955907b3.0
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 10:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714064906; x=1714669706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tdcTMDb/1BdsKsAO8h84W12w1colJ4IWkW36gCsbjEw=;
        b=S9/CdTAPXk+v1LgYUd7qwXfOeQfizg/6ZVnxs1pU3jU/GhmdGM/WZLOo3u63ykhsM7
         8tpidRW2BK34qpMQi5K4OrK6JUEaSIdxZ01P8tbM6nU8Cab4X+yhxpRojijCyO9uZjbh
         tgLwC+Kx9gN9VdiLNubMhObMkkRF/8BGicbnV34oYpmlD+K6FwjLNoxca/YgGDyiGYZj
         9EMGTOsDgrW4UX1XLYC3p7gqvR3Q7Y5UqeuNvw0WNnaO6s0H3ycHd7XrctODtrRbBfoK
         +3Z8hEEDcZPfcYTj5hakukoP3FWxGpqAWorpT3z8D07mBxJs9A7EYQzGb6CTxuZZgfLh
         8XjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714064906; x=1714669706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdcTMDb/1BdsKsAO8h84W12w1colJ4IWkW36gCsbjEw=;
        b=U1XK2vccxOedFYoZbyN2xJwxcedwS7grsuR0aGsvrtmN2UZtUM1jmGnybyoKkjwvnj
         uNWrk4XoynwrPvhDdJVhj4AIhRmfMOQkYiUrFrPIC/5hiu83PWaQlKnmgK1AN1/KuJQ5
         B8M/k3Huq6p5ANPDoP4JpWihOP3Kzv3lxs24/yz90hRqcHnncyISKwjsfVA4tyEhcR7b
         FF4NlaoJmILwSsLuoBU6C+3IuA6/tU/28NBw89OKFA/F/22vT9NNBy9jtCTcgM/iPuKD
         MMSzLnU5l/lxaWGbjtecPEPzbzxbqA0tK3mbcy22sI2HfDvjLnGWZ8NGanzwgP8o2jBg
         rO7w==
X-Forwarded-Encrypted: i=1; AJvYcCW+OdOsC7a3jqv4ZoDViyyrdjYJdF9Wnk8HCmrmEqci5X+pBUz+Eco+AqKJ8IJbcHYbIDeaNckYiQq16+q9kzDxfVrY
X-Gm-Message-State: AOJu0YyZ4POqn+dh9bQ55Q2BmEpUppgeb3Rib2sJGim07c8NnaQ4n8HL
	4xFbp60ctP28EsU16SHurwxEhUUGGe2Y94C21/oOZHBxp2Slicof
X-Google-Smtp-Source: AGHT+IF1dDDNsvcDx7VerojCsVJ3pQNOSijrrMhNOGz39VkEtHy6vzKCgDWhysBdHgpsUroGpH0sAQ==
X-Received: by 2002:a81:dd04:0:b0:61a:e59f:2f98 with SMTP id e4-20020a81dd04000000b0061ae59f2f98mr2714636ywn.5.1714064905843;
        Thu, 25 Apr 2024 10:08:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:ecc1:7924:c821:d1f5? ([2600:1700:6cf8:1240:ecc1:7924:c821:d1f5])
        by smtp.gmail.com with ESMTPSA id v78-20020a814851000000b0061855e3332dsm3627407ywa.120.2024.04.25.10.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 10:08:25 -0700 (PDT)
Message-ID: <5b6f154e-3317-4ba0-af50-6d48ae08be19@gmail.com>
Date: Thu, 25 Apr 2024 10:08:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 00/11] Enable BPF programs to declare arrays
 of kptr, bpf_rb_root, and bpf_list_head.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 Kui-Feng Lee <kuifeng@meta.com>
References: <20240412210814.603377-1-thinker.li@gmail.com>
 <CAADnVQKP4HESABxxjKXqkyAEC4i_yP7_CT+L=+vzOhnMr5LiXg@mail.gmail.com>
 <1ce45df0-4471-4c0c-b37e-3e51b77fa5b5@gmail.com>
 <CAADnVQKjGFdiy4nYTsbfH5rm7T9gt_VhHd3R+0s4yS9eqTtSaA@mail.gmail.com>
 <6d25660d-103a-4541-977f-525bd2d38cd0@gmail.com>
 <CAADnVQ+hGv0oVx4_uPs2yr=vWC80OEEXLm_FcZLBfsthu0yFbA@mail.gmail.com>
 <57b4d1ca-a444-4e28-9c22-9b81c352b4cb@gmail.com>
 <90652139-f541-4a99-837e-e5857c901f61@gmail.com>
 <CAADnVQJFtRwwGm=zEa=CgskY57gXPsG240FA66xZFBONqPTYTg@mail.gmail.com>
 <c00b8c69-deb6-414c-a7ed-7f4a3c1ab83b@gmail.com>
 <CAADnVQ+v7HPSxKV0f-BiwF3DntcYmpstyTDmnHuBsXN=GfB1Fg@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAADnVQ+v7HPSxKV0f-BiwF3DntcYmpstyTDmnHuBsXN=GfB1Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/24/24 17:49, Alexei Starovoitov wrote:
> On Wed, Apr 24, 2024 at 3:32 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>> struct map_value {
>>>      struct {
>>>         struct task __kptr *p1;
>>>         struct thread __kptr *p2;
>>>      } arr[10];
>>> };
>>>
>>> won't be able to be represented as BPF_REPEAT_FIELDS?
>>
>>
>> BPF_REPEAT_FIELDS can handle it. With this case, bpf_parse_fields() will
>> create a list of btf_fields like this:
>>
>>       [ btf_field(type=BPF_KPTR_..., offset=0, ...),
>>         btf_field(type=BPF_KPTR_..., offset=8, ...),
>>         btf_field(type=BPF_REPEAT_FIELDS, offset=16, repeated_fields=2,
>> nelems=9, size=16)]
>>
>> You might miss the explanation in [1].
>>
>> btf_record_find() is still doing binary search. Looking for p2 in
>> obj->arr[1], the offset will be 24.  btf_record_find() will find the
>> BPF_REPEATED_FIELDS one, and redirect the offset to
>>
>>     (field->offset - field->size + (16 - field->offset) % field->size) == 8
>>
>> Then, it will return the btf_field whose offset is 8.
>>
>>
>> [1]
>> https://lore.kernel.org/all/4d3dc24f-fb50-4674-8eec-4c38e4d4b2c1@gmail.com/
> 
> I somehow completely missed that email.
> Just read it and tbh it looks very unnatural and convoluted.
> 
>> [kptr_a, kptr_b, repeated_fields(nelems=3, repeated_cnt=2),
>>     repeated_fields(nelems=9, repeated_cnt=3)]
> 
> is kinda an inverted array description where elements come first
> and then array type. I have a hard time imagining how search
> in such thing will work.

About searching, it will find the elements if index is 0. For index >=
1, it will find repeated_fields(), and redirect to the offset to an
offset at index 0. The pseudo code looks like

   field = bsearch(all_fields, offset..);
   while (field && is_repeated_fields(field)) {
      offset = redirect_offset(offset, field);
      field = 
bsearch(&all_fields[field.index-field.repeated_cnt..field.index], offset);
   }


> 
> Also consider that arrays won't be huge, since bpf prog
> can only access them with a constant offset.
> Even array[NR_CPUS] is unlikely, since indexing into it
> with a variable index won't be possible.

I also got a similar opinion from Andrii in another message.
So, I will move to flatten solution.
Thank you for your feedback.

