Return-Path: <bpf+bounces-27831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265238B274E
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 19:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904721F22949
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 17:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B2E14EC46;
	Thu, 25 Apr 2024 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKzcmQDy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF9614E2FF
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065086; cv=none; b=ONyZ4mwokuJHXLO1CliCfAo+FJUzULj90QoTPhPImfFJcjcWzUfeXEJ3TVSvlOCIyX6Vz+MvQhCEj6RWz1Toa30YjE8yEyH3lfXoPrKNYGXu+5s/x5ihJEVucC/RFefG1gESzi2D2hZjzwDZAsGgeYJIi48ExDNp1+0yfyy8M2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065086; c=relaxed/simple;
	bh=JMMmwrrOhhCfFJ6KLtClqx/CvhK6AvwRG+C8O70wHWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbexwhLIzf8ugco8iVWdM+mF2do1/zj85vm2I5efthfppK/sRCspDhdcyqNKCBke8W8p25RcnSk89nN4kdhv1bMKB2DlzaW4QQZ+KKDRazqGZ+OXr2/fGwPEb/5/NAztdkoH8ACZi58H5NqXSSMVAJagkoCFb24GlpA/IW8+FOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKzcmQDy; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61587aa9f4cso13908397b3.3
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714065084; x=1714669884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mf0J1PvSlBP5SVH+YOWD06JHEUZJUIDI6RLy3kR2tmA=;
        b=JKzcmQDyUH8VI1BtoXaiCqXuFGBwfMztTj/7D94IvGJA5o6vle5fFsZuIE3fMnM/UE
         wbZHcwEQtaZ7loDZbUSaAS6tTLry2HTEYcRy5o3tXsF5rRNves4ckfqH5I913qrt52J1
         JLVyBMfjHdtyDqlRvd5h79ic78vIl7gI0LiDuIYY1EZsiv3/iJyOfiXZv8R2wD4Pnzhm
         eU4VJSvbk7cJk0q2qurPMYPOmekoDQYe+pA9CdqFEM33unvQ772/DSOTaPOx7eK/u89H
         my/2v88S5dmfPUiGwdBjERcbAK9CVnrfhbcm44H+t/+YNmsNPKuFOdNO6lN85NQUJ5wR
         R8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714065084; x=1714669884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mf0J1PvSlBP5SVH+YOWD06JHEUZJUIDI6RLy3kR2tmA=;
        b=fF10kQiq6LbYDpHvygLnkhCjkcIWQW1qcHj+1V0kqnq0KMzhRgKQX7CQb0mqWPBNPW
         hO1LwFiz8hsgU1W42EOUpK6/hSnK12ifeVSmelCjYce7QxRDTEbVXPcK0OwUumTR/Faa
         Ylk0bsQEJmgaxAvZqUOEX1UwaJyNfeA5ZqYl5CChMUraoOnSYY8FC/RY8yv2wpJuzt5i
         gXfLoiyKClIkSwwtgKSsaeUa7pZEyAgxKbMZncInbWI0L6YbSkc+BfDohoTXjrpsW7Zs
         mKRAT07B6toqm8AnxKPj4JZAnvt6EdzS6JMP3xayh1xF6y+SYowOWuetBMDYWR4Gn2mS
         fB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbGjJKBDOQc2vW8MwTrhv7qPd8UBSLselksKpatW1rhBb2xZBK/yD8Z2u+nw3pjWpzr52aXC3+Jd+2wutGUFgyROn6
X-Gm-Message-State: AOJu0YzU3lz3z8YN6xio9HojL0tXd6U4ID7KVx+Mrca/l61Suz2i2Mzp
	qwJC0uUQzFpRoFjV0b967ug/DdIKcDyqwv7cF7a0Wp9p/tvYLl8S
X-Google-Smtp-Source: AGHT+IFlJ/1inUPVBHNNDDfuGzdoT+VBjQQgrVhKejO+UfhhRSnb28Cfmni1zPZmfBIGqR5c+baapg==
X-Received: by 2002:a05:690c:6f84:b0:60a:576:7b79 with SMTP id je4-20020a05690c6f8400b0060a05767b79mr93425ywb.41.1714065084054;
        Thu, 25 Apr 2024 10:11:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:ecc1:7924:c821:d1f5? ([2600:1700:6cf8:1240:ecc1:7924:c821:d1f5])
        by smtp.gmail.com with ESMTPSA id o4-20020a81ef04000000b00617c48add4csm3586017ywm.73.2024.04.25.10.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 10:11:23 -0700 (PDT)
Message-ID: <5cc41b30-86ff-4f44-aee7-05dd444574f6@gmail.com>
Date: Thu, 25 Apr 2024 10:11:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: enable the "open" operator on a pinned
 path of a struct_osp link.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, andrii@kernel.org, kuifeng@meta.com,
 bpf@vger.kernel.org, ast@kernel.org, song@kernel.org, kernel-team@meta.com
References: <20240417002513.1534535-1-thinker.li@gmail.com>
 <20240417002513.1534535-2-thinker.li@gmail.com>
 <8dadfcc9-1f6a-4b93-951b-548e4560ce5a@linux.dev>
 <0326d150-6b43-465c-ba43-7e7033b13408@gmail.com>
 <70bf97a6-19d8-4a26-8879-17db7c44a2cc@gmail.com>
 <54f32ade-ec17-4c35-b993-44907111e7ca@linux.dev>
 <696735aa-59e1-4750-814e-216b85fe934b@gmail.com>
 <68ae7e9c-3bd7-4370-ab06-6e787ca27340@linux.dev>
 <CAEf4BzbOgGVVcWhydbgSGAeDcPjuumMxVZgU_ak4JUFns_YwRQ@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzbOgGVVcWhydbgSGAeDcPjuumMxVZgU_ak4JUFns_YwRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/24/24 17:17, Andrii Nakryiko wrote:
> On Tue, Apr 23, 2024 at 5:29 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 4/23/24 10:16 AM, Kui-Feng Lee wrote:
>>>
>>>
>>> On 4/22/24 16:43, Martin KaFai Lau wrote:
>>>> On 4/22/24 10:30 AM, Kui-Feng Lee wrote:
>>>>>
>>>>>
>>>>> On 4/22/24 10:12, Kui-Feng Lee wrote:
>>>>>>
>>>>>>
>>>>>> On 4/19/24 17:05, Martin KaFai Lau wrote:
>>>>>>> On 4/16/24 5:25 PM, Kui-Feng Lee wrote:
>>>>>>>> +int bpffs_struct_ops_link_open(struct inode *inode, struct file *filp)
>>>>>>>> +{
>>>>>>>> +    struct bpf_struct_ops_link *link = inode->i_private;
>>>>>>>> +
>>>>>>>> +    /* Paired with bpf_link_put_direct() in bpf_link_release(). */
>>>>>>>> +    bpf_link_inc(&link->link);
>>>>>>>> +    filp->private_data = link;
>>>>>>>> +    return 0;
>>>>>>>> +}
>>>>>>>> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
>>>>>>>> index af5d2ffadd70..b020d761ab0a 100644
>>>>>>>> --- a/kernel/bpf/inode.c
>>>>>>>> +++ b/kernel/bpf/inode.c
>>>>>>>> @@ -360,11 +360,16 @@ static int bpf_mkmap(struct dentry *dentry, umode_t
>>>>>>>> mode, void *arg)
>>>>>>>>    static int bpf_mklink(struct dentry *dentry, umode_t mode, void *arg)
>>>>>>>>    {
>>>>>>>> +    const struct file_operations *fops;
>>>>>>>>        struct bpf_link *link = arg;
>>>>>>>> -    return bpf_mkobj_ops(dentry, mode, arg, &bpf_link_iops,
>>>>>>>> -                 bpf_link_is_iter(link) ?
>>>>>>>> -                 &bpf_iter_fops : &bpffs_obj_fops);
>>>>>>>> +    if (bpf_link_is_iter(link))
>>>>>>>> +        fops = &bpf_iter_fops;
>>>>>>>> +    else if (link->type == BPF_LINK_TYPE_STRUCT_OPS)
>>>>>>>
>>>>>>> Open a pinned link and then update should not be specific to struct_ops
>>>>>>> link. e.g. should be useful to the cgroup link also?
>>>>>>
>>>>>> It could be. Here, I played safe in case it creates any unwanted side
>>>>>> effect for links of unknown types.
>>>>>
>>>>> By the way, may I put it in a follow up patch if we want cgroup links?
>>>>
>>>> This does not feel right. It is not struct_ops specific.
>>>>
>>>> Before we dive in further, there is BPF_OBJ_GET which can get a fd of a pinned
>>>> bpf obj (prog, map, and link). Take a look at bpf_link__open() in libbpf. Does
>>>> it work for the use case that needs to update the link?
>>>>
>>> It should work.
>>> So, this patch is not necessary. However, it is still a nice and
>>> intuitive feature. WDYT?
>>
>> There is already BPF_OBJ_GET which works for all major bpf obj types (prog, map,
>> and link). Having open only works for link and only works for one link type
>> (struct_ops) is not very convincing.
>>
>> Beside, I am not sure how the file flags (e.g. rdonly...etc) should be handled.
>> I don't know enough in this area, so I will defer to others to comment in
>> general the usefulness and the approach.
>>
>>
> 
> Didn't see this discussion before replying on the other patch. But I
> agree with Martin, we already use the BPF_OBJ_GET method, and we don't
> support directly open()'ing progs/maps, so I don't think we should do
> this for links either.
> 
> pw-bot: cr

Understand! Let's drop this patch.

