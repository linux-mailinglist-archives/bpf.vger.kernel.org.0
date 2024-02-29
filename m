Return-Path: <bpf+bounces-22981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F30C86BD01
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262522861B6
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1333F1DDDB;
	Thu, 29 Feb 2024 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lP4Lf6+H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30109620
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 00:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167908; cv=none; b=U/YleCpyLSN5B7aKAsgDC9oJSG5U50z3FQ5XONnjipfZIgPNySo15vkni76pbHtTCeuxc1o+YgvlV4x5d1PbXu6eKgOL2+mn7qpQQH3J57wVGiqaaOgOiK+RzNEf6QaDhrg5KpaqOHwbrF8IjamsWrZGfkhedI8q+IRyLKLcHLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167908; c=relaxed/simple;
	bh=P8k/pD98agQRHDRpoEUKI6kdfzyanbSciTmrQB738vI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ClS5jv+m0heEeP5uVzd+vhYQvGL1gSp7Uf6ovBLhsdM3sMwP3Pz38gT+rd/VfA88umGZdLYBHdz2UteIUeoYc193EoDuE7RwQlTJZw9yXVv+N/Ki2qyFHM0O/NFsOhGAhr+fFQl6fSNhex2bSF79VrWkktRdNwh1C5Q8oHSE6NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lP4Lf6+H; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-607cd210962so3881197b3.2
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 16:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709167905; x=1709772705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zuArNSccVokWwgTDEaVTudxXH+n1frQuErycOjhauqs=;
        b=lP4Lf6+HQcjsVP+o2EdHDWYdFdjN1qIH7ENRI3yg+tQWQaJqMvl4Bsf+wr0petqb70
         e0UxMYf5DK8cpSEw3YvttviOy0C/7R4Z9ch5Ms+OLCIH9Zk4GcA4qmqwThoTWmsapsvV
         /SGh0wn2oDDHl9wqGphjM60DEFK9HhTO99pXq/E1tPL1a/vIWUnkq+eCqlVeb5B+j0tH
         DfN6f06Vy+TvmdSA10eaF9N15QG6k7t8jWHsAu+fJvFEILIu7dcGwrIuxj1NMbF6lx5p
         j2bagra969kCRBeBGgLDOcbmNMiuxwihxIB2UK7XlsSbxM3BwusWiMJueSxYSx+SRC5W
         6wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709167905; x=1709772705;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zuArNSccVokWwgTDEaVTudxXH+n1frQuErycOjhauqs=;
        b=FFel6ZsI5Hzr53XwY/OUhC8l5ot6UL7s+4gwitG910cosB2rzXoSLnjC4e92pee2C4
         d4DLZNaSmI3sNGi6eA8jBzR9dKJvpnvZJre02g7JJZy2m9IfjHx/Mocnk1T+oakAdI4t
         mv98S937BERwhJs8/fnDjs3Gi2wxl4ocMK8/rOA9OBmP1p7P96Ae34SAhwGDsKxvtM67
         YlpzKSSg//V618/j5glZx27lDwrOedNy26FcEfO0G3T1NO5eVQAun+XKdYRncElNsBew
         efl5zZ7i1vZjO4vCfH/p16qlq7z2EKbOZ/QwKta5hU3X6eL8xItURiOj3ogplQDrGC6t
         cjOA==
X-Forwarded-Encrypted: i=1; AJvYcCVfuwQV939LPb9U+/RydgdCGo+U273LGVoWJjFOHg1st/5ZqDHEtv7LJnsoWzjmpnSx15l/+rsJMDtQ9iA5eaQ9ZY9X
X-Gm-Message-State: AOJu0YxMYtsSMkvnGrh4TzVJVBej3k2OOiwBe/D9lbo9RdxJRMOxbHXa
	P7jF/WPvE3Vhy8bzM2E7GxclUrHznFTDTVdTCnOg3AESOdElMSEjyEyrS1IS
X-Google-Smtp-Source: AGHT+IHHFki7WtFL/wTF7ozGjGj2JYFwUSaBlUPnOYFhAQ3FxeQIIVAOWnFqDftueQDYPArhFnmTaQ==
X-Received: by 2002:a81:490f:0:b0:609:3958:7121 with SMTP id w15-20020a81490f000000b0060939587121mr857767ywa.0.1709167905171;
        Wed, 28 Feb 2024 16:51:45 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:8315:1f56:c755:e391? ([2600:1700:6cf8:1240:8315:1f56:c755:e391])
        by smtp.gmail.com with ESMTPSA id r10-20020a0de80a000000b00608d62071f4sm72186ywe.8.2024.02.28.16.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 16:51:44 -0800 (PST)
Message-ID: <c1387f44-0eea-4b65-b184-53f9b974a7bc@gmail.com>
Date: Wed, 28 Feb 2024 16:51:43 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 4/6] bpftool: generated shadow variables for
 struct_ops maps.
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, quentin@isovalent.com, kuifeng@meta.com
References: <20240227010432.714127-1-thinker.li@gmail.com>
 <20240227010432.714127-5-thinker.li@gmail.com>
 <CAEf4BzZFdyq1U2wNP4oZJy8MZrNPhp8zXFoC7mJwu=WYx_hCkg@mail.gmail.com>
 <7c5359e7-737d-495b-b96b-22134776d3db@gmail.com>
 <e72f726f-b815-4dee-b5da-63ee97082df6@gmail.com>
 <CAEf4BzZSx7XJ4gmq=omjuw0u=CZpQFS=u1iHipOHg+PQN899Xw@mail.gmail.com>
 <63fb7cb7-e884-472f-a81f-182d5867d1d4@gmail.com>
In-Reply-To: <63fb7cb7-e884-472f-a81f-182d5867d1d4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/28/24 16:44, Kui-Feng Lee wrote:
> 
> 
> On 2/28/24 16:09, Andrii Nakryiko wrote:
>> On Wed, Feb 28, 2024 at 2:28 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>>
>>>
>>>
>>> On 2/28/24 13:21, Kui-Feng Lee wrote:
>>>> Will fix most of issues.
>>>>
>>>> On 2/28/24 10:25, Andrii Nakryiko wrote:
>>>>> On Mon, Feb 26, 2024 at 5:04 PM Kui-Feng Lee <thinker.li@gmail.com>
>>>>> wrote:
>>>>>>
>>>>>> + * type. Accessing them through the generated names may 
>>>>>> unintentionally
>>>>>> + * corrupt data.
>>>>>> + */
>>>>>> +static int gen_st_ops_shadow_type(struct btf *btf, const char 
>>>>>> *ident,
>>>>>> +                                 const struct bpf_map *map)
>>>>>> +{
>>>>>> +       int err;
>>>>>> +
>>>>>> +       printf("\t\tstruct {\n");
>>>>>
>>>>> would it be useful to still name this type? E.g., if it is `struct
>>>>> bpf_struct_ops_tcp_congestion_ops in vmlinux BTF` we can name this one
>>>>> as <skeleton-name>__bpf_struct_ops_tcp_congestion_ops. We have a
>>>>> similar pattern for bss/data/rodata sections, having names is useful.
>>>>
>>>> If a user defines several struct_ops maps with the same name and 
>>>> type in
>>>> different files, it can cause name conflicts. Unless we also prefix the
>>>> name with the name of the skeleton. I am not sure if it is a good idea
>>>> to generate such long names. If a user want to refer to the type, he
>>>> still can use typeof(). WDYT?
>>>
>>> I misread your words. So, you were saying to prefix the skeleton name,
>>> not map names. It is doable.
>>
>> I did say to prefix with skeleton name, but *that* actually can lead
>> to a conflict if you have two struct_ops maps that use the same BTF
>> type. On the other hand, map names are unique, they are forced to be
>> global symbols, so there is no way for them to conflict (it would be
>> link-time error).
> 
> I avoided conflicts by checking if the definition of a type is already
> generated.
> 
> For example, if there are two maps with the same type, they would looks 
> like.
> struct XXXSekelton {
>      ...
>      struct {
>          struct struct_ops_type {
>               ....
>          } *map1;
>          struct struct_ops_type *map2;
>      } struct_ops;
>    ...
> };
> 
> WDYT?

Sorry! It should be "<skeleton-type>_bpf_struct_ops_tcp_congestion_ops"
instead of "struct_ops_type".

> 
>>
>> How about we append both skeleton name, map name, and map's underlying
>> BTF type? So:
>>
>> <skel>__<map>__bpf_struct_ops_tcp_congestion_ops
>>
>> ?
>>
>> Is there any problem with having a long name?
> 
> No a big problem! Just not convenient to use.
> 
>>
>>>
>>>>
>>>>>
>>>>>> +
>>>>>> +       err = walk_st_ops_shadow_vars(btf, ident, map);
>>>>>> +       if (err)
>>>>>> +               return err;
>>>>>> +
>>>>>> +       printf("\t\t} *%s;\n", ident);
>>>>>> +
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +

