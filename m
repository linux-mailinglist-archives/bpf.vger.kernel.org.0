Return-Path: <bpf+bounces-22986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B05B86BE23
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 02:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316F4285DEF
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA1A2E630;
	Thu, 29 Feb 2024 01:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZShi4OMM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E92E631
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 01:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709169292; cv=none; b=jJWrpwbamRPbglmG3O7dJSSmAFPnq9O+eUy87G835AneGkgnjyp1Yg3A8urwGAm2qIdCO7gTnM38G5joyTVH3qCNEbZSkIl0LZY1/OSOp7FHjsFdV2spJQ4N9Dt4jfuaryWjsENBRXCsh2Sl7QVnE3E1+bUCtCkEBSjCswRStT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709169292; c=relaxed/simple;
	bh=9XpiwHgSAL+h1PwDihErl8DMtckSbnY/7SGupEBEcWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsP4qmGZXduTqyyuqGVmnZc3sGQI+XVtT09/9VpP5tqlPcX1jdn8BU8LMbTIO2VCI4/odsViFAtD/FJr+AfrnDIHm9l2sKhT7OUwhUiI2EC1QCU0KUbfoHXmPVmD9LktblD/1QO9Cf7g1V9IqKv9RCHrx+sgJ9cLUSxFhYGEFaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZShi4OMM; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-607bfa4c913so4257297b3.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 17:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709169290; x=1709774090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ig/Wlgh/tTm8TNcGPrc4BznIBTeCihfIMX5pyEYtLUs=;
        b=ZShi4OMMR7suQiiHzx0pLWelETWbKpH9Jh01In6oDQU4mzt4KLoUW9O/vDfw9KeHED
         QlkCN09yRVumBSD4Ocup1+NyI3B3aYHIXbaSAfJrSp/nYNVrcNVsZTH44IPAz+1ZsKWn
         RndFkxbG7FUAlvC4cCYAzOnJpte6YLrsY22qmvpJ9KKxJhmMhVRBserwvr75j+qVZiGn
         EmDtSoUN5BaIV8biQ8BA8E4Q/347KYiq2eUyOoilq+xXVldCILT9HhaqCC7ybrBHXKCq
         tVDOmT/bs/QTBBJbryEtUTaxaq8BM8IwOCJ4/EHj3wjz95oAk62js/Ibq0QZSP0ZDgT6
         oiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709169290; x=1709774090;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ig/Wlgh/tTm8TNcGPrc4BznIBTeCihfIMX5pyEYtLUs=;
        b=QAIflgKbLlRVJ6UFMHlD9McoaARA7PJvDmrbEikaVvGYplhb3ZeGo3pP7ePyiiG7Ag
         Yn+TT97o1Fi22hn66ZGUxFScrckgZ46f3UL4LM9Wj9yDLsbBAA6FFWl81tCToMzgk7ny
         H3kkCgi5+xngp1J/jcs4yVIktlCX01mOc8NDGNgcv5zwNEh/IS4uLKRHE1HEVT1vyxLs
         2FDxdB0zR0S4Ji/XKoKLrivWZ6TpV7QDrGour1HEuHvfDFVYHdBTgSBfaQXUezJtudcq
         KSCPgr3bAnKv6M3Aj143uPTrITvNaWgITbivpeNHmLAJgT9DWo4MaHsCXUFFGPyiGR0I
         wt+g==
X-Forwarded-Encrypted: i=1; AJvYcCXh9e4Ubg/3loDAoVV8ghj9rix+9yNMzfq3PkhW81rWFCG3UgcTjfhNEf4YsfSxawHDhwqn2KZGPgZqotwRhJ+Le/Ko
X-Gm-Message-State: AOJu0YyxZpETvyF9pjjLo7v+MeurAglA+XHgumr23pEx/KNQ0446OiE9
	S/z+lezZQtKP53QiwBLXafK96o+Ar/im/WT7Y+R8Uhxu055OkxAF
X-Google-Smtp-Source: AGHT+IHS6abWd+Mj+HDXJCPis0TMuluBYFOrIX6T2yxCz0ez1/Q2BZceZSbUwOefz/toLuC+/O97sA==
X-Received: by 2002:a81:a157:0:b0:608:c8c3:ab7b with SMTP id y84-20020a81a157000000b00608c8c3ab7bmr807257ywg.23.1709169289754;
        Wed, 28 Feb 2024 17:14:49 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:8315:1f56:c755:e391? ([2600:1700:6cf8:1240:8315:1f56:c755:e391])
        by smtp.gmail.com with ESMTPSA id y78-20020a0dd651000000b005ffce9cee9fsm82214ywd.12.2024.02.28.17.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 17:14:49 -0800 (PST)
Message-ID: <7a214472-19f9-4fe3-9b27-d26a681adf0e@gmail.com>
Date: Wed, 28 Feb 2024 17:14:47 -0800
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
 <CAEf4BzZYeSCk+vO1GXYej3m7JzWrudojs7gRZTow6KVkOCY_UQ@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzZYeSCk+vO1GXYej3m7JzWrudojs7gRZTow6KVkOCY_UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/28/24 17:03, Andrii Nakryiko wrote:
> On Wed, Feb 28, 2024 at 4:44 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 2/28/24 16:09, Andrii Nakryiko wrote:
>>> On Wed, Feb 28, 2024 at 2:28 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2/28/24 13:21, Kui-Feng Lee wrote:
>>>>> Will fix most of issues.
>>>>>
>>>>> On 2/28/24 10:25, Andrii Nakryiko wrote:
>>>>>> On Mon, Feb 26, 2024 at 5:04 PM Kui-Feng Lee <thinker.li@gmail.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> + * type. Accessing them through the generated names may unintentionally
>>>>>>> + * corrupt data.
>>>>>>> + */
>>>>>>> +static int gen_st_ops_shadow_type(struct btf *btf, const char *ident,
>>>>>>> +                                 const struct bpf_map *map)
>>>>>>> +{
>>>>>>> +       int err;
>>>>>>> +
>>>>>>> +       printf("\t\tstruct {\n");
>>>>>>
>>>>>> would it be useful to still name this type? E.g., if it is `struct
>>>>>> bpf_struct_ops_tcp_congestion_ops in vmlinux BTF` we can name this one
>>>>>> as <skeleton-name>__bpf_struct_ops_tcp_congestion_ops. We have a
>>>>>> similar pattern for bss/data/rodata sections, having names is useful.
>>>>>
>>>>> If a user defines several struct_ops maps with the same name and type in
>>>>> different files, it can cause name conflicts. Unless we also prefix the
>>>>> name with the name of the skeleton. I am not sure if it is a good idea
>>>>> to generate such long names. If a user want to refer to the type, he
>>>>> still can use typeof(). WDYT?
>>>>
>>>> I misread your words. So, you were saying to prefix the skeleton name,
>>>> not map names. It is doable.
>>>
>>> I did say to prefix with skeleton name, but *that* actually can lead
>>> to a conflict if you have two struct_ops maps that use the same BTF
>>> type. On the other hand, map names are unique, they are forced to be
>>> global symbols, so there is no way for them to conflict (it would be
>>> link-time error).
>>
>> I avoided conflicts by checking if the definition of a type is already
>> generated.
>>
>> For example, if there are two maps with the same type, they would looks
>> like.
>> struct XXXSekelton {
>>       ...
>>       struct {
>>           struct struct_ops_type {
>>                ....
>>           } *map1;
>>           struct struct_ops_type *map2;
> 
> It's kind of non-uniform. I think we are overengineering this, let's
> just do <skel>__<map>__<type> and see how it goes? No checks, no
> nothing, pure string generation.

Got it

> 
>>       } struct_ops;
>>     ...
>> };
>>
>> WDYT?
>>
>>>
>>> How about we append both skeleton name, map name, and map's underlying
>>> BTF type? So:
>>>
>>> <skel>__<map>__bpf_struct_ops_tcp_congestion_ops
>>>
>>> ?
>>>
>>> Is there any problem with having a long name?
>>
>> No a big problem! Just not convenient to use.
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>> +
>>>>>>> +       err = walk_st_ops_shadow_vars(btf, ident, map);
>>>>>>> +       if (err)
>>>>>>> +               return err;
>>>>>>> +
>>>>>>> +       printf("\t\t} *%s;\n", ident);
>>>>>>> +
>>>>>>> +       return 0;
>>>>>>> +}
>>>>>>> +

