Return-Path: <bpf+bounces-27109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8AF8A9217
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 06:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70941F21A30
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 04:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20133249ED;
	Thu, 18 Apr 2024 04:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHXp9nhd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5105AEDF
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 04:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713414683; cv=none; b=C+9pcT/B6CBfDAu+C5rilD9frIl+uhjI0jnZTJRT5uvxUa1YPR94KPf7lp5w1c7d2SXNTvxeBq1nCHUfCRP0CidzKTkMB/8yxK1ZGXDH9iVasPW+pPBkBIOyxpYRRxc1pOhlaub8+b8IIn260ySE69PujqM1m3I29BAK9vpaT6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713414683; c=relaxed/simple;
	bh=6PtW6MiUZbS6tUci//qu5pDrb+Qktfs355FwlJR4ZnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dw+yKp2wLwr4lI/d4ejDRvu05YyZBSekXUftJvcyL4RUIi/0q1p9dt+o5QEJGUwp3MbJ7rtlbCJFLhLXYkWGUBUMMADsbqOdsQrl86bp/DQT7qkeS4T/kFqQrKTaAjfDWb3SZgoKyMATFKPOadrgEDAaZqG9MBUkZNzImXAgoHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHXp9nhd; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5aa2bd6f651so308300eaf.0
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 21:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713414681; x=1714019481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tcB73t0vsgU5SOv7jHXvAkKkh1cRuiMt4OV7vQ09dN4=;
        b=BHXp9nhdda6FhxpYCgLiwmtrQ0hrOU7R0nzAyjOa2FuXYYVp7pNU3ueqxjM42BAkaq
         KRVtlKYLgWB5n//KqrLok2JSDtwqDoSlMbZUl/Lrh34zKus/xk3mvncrlxP1+xM3VHly
         IbfPpBqW+10SHaqP7jKc2c2nnDnVCFfT1A/gXijqQqkgEV58CJJuOaj1w8UALGN+ZnKJ
         T1rGcAHFjX7bcO7ZpD2jBWQSPKokTU5YoOE/yt1Dy2WOsfwzV6HWekEOXCBa94y4RVNQ
         NjcekhcbOsVynGwkgnzJi5xcnNuViBzYtGEjX54l1VvadCSWJtHwULv8yRBYGTBRNhoK
         DGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713414681; x=1714019481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tcB73t0vsgU5SOv7jHXvAkKkh1cRuiMt4OV7vQ09dN4=;
        b=t7XDi0RX60cypYcd21soPzgLrfn1iqGtChSlJEesYheHQJ03RShIVlI/gcP7h5dv55
         P67BGO6lpETWxnt1kVbbyo0TqMAIiD55YznojAsfS9yakx6usYe1KCnhagoRb8TK4Y4z
         AbwgKVTPNwjY8SfldGuJMtnxdCXY2a8tElGCLgK5wkxTzp+wwk4vYnn14ln0YKfvV+yQ
         SD3mcmenEe4sZKXgJMg6DvFvJIAmxF2L30CYbObH98U3P208hFicZqtYmEohWcD3j2x6
         PLPvW0co4PDvhl2TDqMYP7YEo3CQFSHW1kWmBO+UFYhAdrvGkAywvNk9EpWJ2VVCVmo/
         FkEw==
X-Gm-Message-State: AOJu0YyWjd6JTa0ZOTbkuCYrasiCuAw3v4KoRA4XybZUihrB3C/mfiQb
	AwbvKtHpkLk0zTGf4fLpQQRGkJOqhs6pFhwhqx5t1MZVBCDtKm/2
X-Google-Smtp-Source: AGHT+IGlx3rbsuq+nL/SaJ46N2cOuD62QoWnZX0GxpICh2UGpkF0o2hSaWeFKG1IRov4cJ3kBG3EZA==
X-Received: by 2002:a4a:8c11:0:b0:5aa:3c6a:c5f3 with SMTP id u17-20020a4a8c11000000b005aa3c6ac5f3mr1831481ooj.9.1713414681260;
        Wed, 17 Apr 2024 21:31:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:f03d:b488:be92:3bc9? ([2600:1700:6cf8:1240:f03d:b488:be92:3bc9])
        by smtp.gmail.com with ESMTPSA id e30-20020a056820061e00b005a4694c37a8sm203243oow.20.2024.04.17.21.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 21:31:20 -0700 (PDT)
Message-ID: <1ce45df0-4471-4c0c-b37e-3e51b77fa5b5@gmail.com>
Date: Wed, 17 Apr 2024 21:31:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 00/11] Enable BPF programs to declare arrays
 of kptr, bpf_rb_root, and bpf_list_head.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 Kui-Feng Lee <kuifeng@meta.com>
References: <20240412210814.603377-1-thinker.li@gmail.com>
 <CAADnVQKP4HESABxxjKXqkyAEC4i_yP7_CT+L=+vzOhnMr5LiXg@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAADnVQKP4HESABxxjKXqkyAEC4i_yP7_CT+L=+vzOhnMr5LiXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/17/24 20:30, Alexei Starovoitov wrote:
> On Fri, Apr 12, 2024 at 2:08 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> The arrays of kptr, bpf_rb_root, and bpf_list_head didn't work as
>> global variables. This was due to these types being initialized and
>> verified in a special manner in the kernel. This patchset allows BPF
>> programs to declare arrays of kptr, bpf_rb_root, and bpf_list_head in
>> the global namespace.
>>
>> The main change is to add "nelems" to btf_fields. The value of
>> "nelems" represents the number of elements in the array if a btf_field
>> represents an array. Otherwise, "nelem" will be 1. The verifier
>> verifies these types based on the information provided by the
>> btf_field.
>>
>> The value of "size" will be the size of the entire array if a
>> btf_field represents an array. Dividing "size" by "nelems" gives the
>> size of an element. The value of "offset" will be the offset of the
>> beginning for an array. By putting this together, we can determine the
>> offset of each element in an array. For example,
>>
>>      struct bpf_cpumask __kptr * global_mask_array[2];
> 
> Looks like this patch set enables arrays only.
> Meaning the following is supported already:
> 
> +private(C) struct bpf_spin_lock glock_c;
> +private(C) struct bpf_list_head ghead_array1 __contains(foo, node2);
> +private(C) struct bpf_list_head ghead_array2 __contains(foo, node2);
> 
> while this support is added:
> 
> +private(C) struct bpf_spin_lock glock_c;
> +private(C) struct bpf_list_head ghead_array1[3] __contains(foo, node2);
> +private(C) struct bpf_list_head ghead_array2[2] __contains(foo, node2);
> 
> Am I right?
> 
> What about the case when bpf_list_head is wrapped in a struct?
> private(C) struct foo {
>    struct bpf_list_head ghead;
> } ghead;
> 
> that's not enabled in this patch. I think.
> 
> And the following:
> private(C) struct foo {
>    struct bpf_list_head ghead;
> } ghead[2];
> 
> 
> or
> 
> private(C) struct foo {
>    struct bpf_list_head ghead[2];
> } ghead;
> 
> Won't work either.

No, they don't work.
We had a discussion about this in the other day.
I proposed to have another patch set to work on struct types.
Do you prefer to handle it in this patch set?

> 
> I think eventually we want to support all such combinations and
> the approach proposed in this patch with 'nelems'
> won't work for wrapper structs.
> 
> I think it's better to unroll/flatten all structs and arrays
> and represent them as individual elements in the flattened
> structure. Then there will be no need to special case array with 'nelems'.
> All special BTF types will be individual elements with unique offset.
> 
> Does this make sense?

That means it will creates 10 btf_field(s) for an array having 10
elements. The purpose of adding "nelems" is to avoid the repetition. Do
you prefer to expand them?


> 
> pw-bot: cr

