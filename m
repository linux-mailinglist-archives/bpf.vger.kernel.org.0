Return-Path: <bpf+bounces-36925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D65C94F64F
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 20:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96A528246C
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 18:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F4D189BB1;
	Mon, 12 Aug 2024 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd52km9m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B78F189B8C
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 18:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486221; cv=none; b=WNFzx6d8pOfFG2Q5krv+vgj0z88mPs+xsuYyV1gxGK7WBl5NHDh7xvuMghZ8f5kJ35KWIiWXPt1BMii4nY5qrxz3SJ3ZQl19I7jjYGxboCWLtt367m15Z3zZX4r5Hhugp6GFL7b4Of2xqd9C4yIcSUzR3nUs9QSn99UEs1VDOP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486221; c=relaxed/simple;
	bh=TjE4RVWScr4mf0L4+5aqS0T+bV7JNGa1PzeFilDfRBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C87HXiug0yiykfB+A7SBQgNTUoHmzCXnTpaom7z9mC6J4+ktrEt5ExzCmNNvO50NOsYgpv5CF/0FybRLilofdqXvo5LErAXvXVpWHxPybRvNpKHHE1E6nE446ZTUmot5TgilwVCC4H9jTmPJ9emimlsP4Wc7gR8hxeTFIayDM2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gd52km9m; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-690aabe2600so39740207b3.0
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 11:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723486218; x=1724091018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cOqv/f3A4+8Dq8rR3CuEW2im3GEcI2eT2eanCLIY9dw=;
        b=Gd52km9msgMFCxxoVOrR1IwQHhrPjVM/GzIQgpZZQ73hRTlT9/qOO798N0cuTijTSu
         AGBzF5GSp+dGuKrky8yvbbaIwQV2bbkkg7piVngHlZNtyfGfovPTVNuKH18FxXJ+aenr
         iYWFngFjQBLVDnHyvNZ9VmDoYSADMJOIKrv1acs6Hjez4SazLiv1Rk/iR8UxsHJHWT5T
         mDNpnrQ34aFwzr3/8KoJFrVgMiTCcatxfN5t1jcgSttUuAVCN02LxgaYLT9S2e5rgSG7
         WOQmrKgNhP4I3/sJJPqXLRtC7Z1kimJrijcRwIlTBgSo+JWd29wUR15xwFvgdZWubJIX
         XPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486218; x=1724091018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOqv/f3A4+8Dq8rR3CuEW2im3GEcI2eT2eanCLIY9dw=;
        b=bybK+2PN5aRzdRIQk/3BHXTV8sIx0aJHfRgrouAfHhYnMRLVchbkRDRUTGyiv8eAOm
         2YOpa3TOBaNNiPZ1NImExWtgJb1Vrmp3US/nXrrrwRkiLPpn2v6KIfYhv6HA1jDiABTk
         jkd1LN2fbtV8mga75wFNg9iqq4B4EzW8my2Vlw3RdHgC+gveGlTAMovDPKc6HSaeI+mI
         44Ur4GzuEbU/S+6e3zaZFM8zVcCF0CU9/5OJFuG4RUrV2Vl32mpTlkQ6md3YWkKcAyID
         a6a4f9pTtPuuiRvDLkOm8TpyZjRU92//mMj0FKQylvGCFdRGo+y8u6JkuO+wkLRTebya
         bL3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUx3Ep0+dOz/ecp3LSFLKoMGnrAy64jg2bThVewWYHeCv9zr2esI/eGwB0UxBDEr9uNveYzO3NYspDGow0fa+VFnXhm
X-Gm-Message-State: AOJu0YzmeVfhRYlnj2PVDSY2WaGYCXPd6lxEkz9wf5T4V0XJZ9GG8QCr
	k0Xe/B51rJHQUjMDKdVYdfEtXkKrW9LBQ4qeWve9D97VcErBsBvq
X-Google-Smtp-Source: AGHT+IGt8Jp90U3aL/aj7Js1z3yxAOMUQBQw4ALvvLm66kM76Lqq2oRSwFTNLtBLUbLe4duxylKEhw==
X-Received: by 2002:a05:690c:448f:b0:660:56fb:7f00 with SMTP id 00721157ae682-6a976955a89mr11595687b3.46.1723486218478;
        Mon, 12 Aug 2024 11:10:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:9b6c:23b8:ec8:40fd? ([2600:1700:6cf8:1240:9b6c:23b8:ec8:40fd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a96d48cacfsm1234277b3.26.2024.08.12.11.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 11:10:17 -0700 (PDT)
Message-ID: <e5562084-ca3f-4afb-8337-25bd44872bb7@gmail.com>
Date: Mon, 12 Aug 2024 11:10:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 5/5] selftests/bpf: test __kptr_user on the value
 of a task storage map.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 Kui-Feng Lee <kuifeng@meta.com>
References: <20240807235755.1435806-1-thinker.li@gmail.com>
 <20240807235755.1435806-6-thinker.li@gmail.com>
 <CAADnVQ+B1oB2Ct+n0PrWnb5zJ2SEBS1ZmREqR_sK=tQys6y3zQ@mail.gmail.com>
 <e136e024-8949-4836-be02-fb1a1ca75f16@gmail.com>
 <CAADnVQJSt3Xqgs-jK3-yOD4=E=0roS+35g-tVqxdm6fYk8rJEQ@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAADnVQJSt3Xqgs-jK3-yOD4=E=0roS+35g-tVqxdm6fYk8rJEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/12/24 10:31, Alexei Starovoitov wrote:
> On Mon, Aug 12, 2024 at 10:15 AM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 8/12/24 09:58, Alexei Starovoitov wrote:
>>> On Wed, Aug 7, 2024 at 4:58 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>>> +
>>>> +       user_data_mmap = mmap(NULL, sizeof(*user_data_mmap), PROT_READ | PROT_WRITE,
>>>> +                             MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>>> +       if (!ASSERT_NEQ(user_data_mmap, MAP_FAILED, "mmap"))
>>>> +               return;
>>>> +
>>>> +       memcpy(user_data_mmap, &user_data_mmap_v, sizeof(*user_data_mmap));
>>>> +       value.udata_mmap = user_data_mmap;
>>>> +       value.udata = &user_data;
>>>
>>> There shouldn't be a need to do mmap(). It's too much memory overhead.
>>> The user should be able to write:
>>> static __thread struct user_data udata;
>>> value.udata = &udata;
>>> bpf_map_update_elem(map_fd, my_task_fd, &value)
>>> and do it once.
>>> Later multi thread user code will just access "udata".
>>> No map lookups.
>>
>> mmap() is not necessary here. There are two pointers here.
>> udata_mmap one is used to test the case crossing page boundary although
>> in the current RFC it fails to do it. It will be fixed later.
>> udata one works just like what you have described, except user_data is a
>> local variable.
> 
> Hmm. I guess I misread the code.
> But then:
> +       struct user_data user_data user_data = ...;
> +       value.udata = &user_data;
> 
> how is that supposed to work when the address points to the stack?
> I guess the kernel can still pin that page, but it will be junk
> as soon as the function returns.

You are right! It works only for this test case since the map will be
destroyed before leaving this function. I will move it to a static variable.

> 
>>>
>>> If sizeof(udata) is small enough the kernel will pin either
>>> one or two pages (if udata crosses page boundary).
>>>
>>> So no extra memory consumption by the user process while the kernel
>>> pins a page or two.
>>> In a good case it's one page and no extra vmap.
>>> I wonder whether we should enforce that one page case.
>>> It's not hard for users to write:
>>> static __thread struct user_data udata __attribute__((aligned(sizeof(udata))));
>>
>> With one page restriction, the implementation would be much simpler. If
>> you think it is a reasonable restriction, I would enforce this rule.
> 
> I'm worried about vmap(). Doing it for every map elemen (same as every
> task) might add substantial kernel side overhead.
> On my devserver:
> sudo cat /proc/vmallocinfo |grep vmap|wc -l
> 105
> sudo cat /proc/vmallocinfo |wc -l
> 17608
> 
> I believe that the mechanism scales to millions, but adding one more
> vmap per element feels like a footgun.
> To avoid that the user would need to make sure their user_data doesn't
> cross the page, so imo we can make this mandatory.

If the memory block that is pointed by a uptr takes only one page,
vmap() is not called. vmap() is called only for the cases that take two
or more pages. Without the one page restriction, there is a chance to
have additional vmaps even for small memory blocks, but not every uptr
having that extra vmap.

Users can accidentally create a new vmap. But, with current
implementation, they can also avoid it by aligning memory properly. The
trade-off is between supporting big chunks of memory and idiot-proof.
However, in my opinion, big chunks are very unlikely for task local storage.

So, I will make this restriction mandatory.

