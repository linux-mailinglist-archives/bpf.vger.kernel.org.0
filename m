Return-Path: <bpf+bounces-27572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C5E8AF52E
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 19:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506C6281BE9
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235D613D8BA;
	Tue, 23 Apr 2024 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elufQmti"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5402713C9C9
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892614; cv=none; b=ElQfkMZfhZPqBCa0f8ISHFarS6fZO1BEML76v6O6OzCkZmUV6x+TrNc+ae/YdWv1n0Gnmtp9Nv2OzTpe1VKGIM5kCm0sRWqTw1VSken64LIBszKcfZ9aBQfTk57SJeiT/EhUhRg8pgkvVNiBzDOo6WXO7bLzNobyYHUSjQq4aOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892614; c=relaxed/simple;
	bh=xmJdlRHKnThGouCAIyFQ5F2WaKiz2UA9lz/IuF+Cvlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZthIuyJJ+zE2z3YweCEW42nXGbhwJUkYe37ac21E1o19mH1ZP18ac3FlFAZ37HVekSZ3ai9IHieryyU3hjJ0dBV1q0UHFrZlcqR/4y2UR4htLxBhhgZv5lkpF7YHRU1lRUHR+Cc+Crt3CoV3pUPFbu6NoZc3Ke628WW8722WYGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elufQmti; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61ab6faf179so61248067b3.1
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 10:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713892612; x=1714497412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z0oQoSwVgu3Ob+H8pOHWyIHN830icqZ/22A0Z344Oho=;
        b=elufQmti42609aTMZLwP2OKQLqlAuQOBuVLW1Lyv23BKC34GD0UgHW/wK8heE0rX/P
         hYmLhOdaEGdusUWvmmWWOGj4xmyzHtayEjaLHlEsD19TkTSoYLZpHOflGvKZ3MWQKuh+
         y8uC/xCtL2uSMGrHWcBfudjkxau5JNey0/EWbMiz++O4ayMhH0xqVGyvNZcBhlDHlVuZ
         zJ0tQbfVFny9a7Z4pJbilq3B/QeuPa4W/16jaNSIJ2FtwPxwoSiJRTB7fpCcxfel6TTJ
         UtF0YZIcNJI+uyL9WTdrLqpiuEu2jeQPwaPOqOMeoIMUYKrpezU7WFKGMnwEBZvs269g
         GZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713892612; x=1714497412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0oQoSwVgu3Ob+H8pOHWyIHN830icqZ/22A0Z344Oho=;
        b=lcz6kp5R3kLA3NLio6wQOQdZq0s7SXhrltyDXhHLAMRyxyy5uxyOnt26fbhVECx/9Y
         krihyvvyteYuEKUi7NhibWOFhfsm1gPNm2GwikdTQ9lVEBLx1ftzUmOJ+30DgcEEhZES
         RDMAKtHpLsSDdCsg5xkGDFPgj9DnloUnHthbQDze+zqIgiCO/IJQP9xOhuvrGd4ouFIt
         GF9eZyW5uVRFEG5NJJ8O/+zB8FuJcWaoRNNhsdZDM0wymz/7W+kkkJQnnOwZ+3sQDcvz
         1d/RKuipO2kP/EouWhkWkAw+VML/+NT2LqC2QwUn/M/mlrRJqVs1Q5Q0Jg+j9lq0LFu8
         KQRg==
X-Forwarded-Encrypted: i=1; AJvYcCUzzNQ2yZN2imWbtqNRux0SLldZtUUvVu7q9qxzZ6eIRlwwGP3oX6Cb9GjNnRDSi2YC5aT2DhbqIGKYtvCWMGR3zr3C
X-Gm-Message-State: AOJu0YyBd0vLNqZHejAsZSjC+duRIvvxAXHe40Rg6kg02I68vCUj2d/b
	g0Qa9vKKqLFYlRk+QInKES7CpEzDZgXXwBLP0rhBMaDvsIl6fcns
X-Google-Smtp-Source: AGHT+IG4aKLJyLdF1DLkuf6IQDvGdNtH17PdXAkBFEcZC50OQLXlORh649HGlnkynJ5M3A76K28g5w==
X-Received: by 2002:a05:690c:3343:b0:615:5ae:b362 with SMTP id fk3-20020a05690c334300b0061505aeb362mr139878ywb.33.1713892612061;
        Tue, 23 Apr 2024 10:16:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:134d:11be:8d42:b68d? ([2600:1700:6cf8:1240:134d:11be:8d42:b68d])
        by smtp.gmail.com with ESMTPSA id f2-20020a81c102000000b0061b695761b6sm886911ywi.88.2024.04.23.10.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 10:16:51 -0700 (PDT)
Message-ID: <696735aa-59e1-4750-814e-216b85fe934b@gmail.com>
Date: Tue, 23 Apr 2024 10:16:49 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: enable the "open" operator on a pinned
 path of a struct_osp link.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: andrii@kernel.org, kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org,
 song@kernel.org, kernel-team@meta.com
References: <20240417002513.1534535-1-thinker.li@gmail.com>
 <20240417002513.1534535-2-thinker.li@gmail.com>
 <8dadfcc9-1f6a-4b93-951b-548e4560ce5a@linux.dev>
 <0326d150-6b43-465c-ba43-7e7033b13408@gmail.com>
 <70bf97a6-19d8-4a26-8879-17db7c44a2cc@gmail.com>
 <54f32ade-ec17-4c35-b993-44907111e7ca@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <54f32ade-ec17-4c35-b993-44907111e7ca@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/22/24 16:43, Martin KaFai Lau wrote:
> On 4/22/24 10:30 AM, Kui-Feng Lee wrote:
>>
>>
>> On 4/22/24 10:12, Kui-Feng Lee wrote:
>>>
>>>
>>> On 4/19/24 17:05, Martin KaFai Lau wrote:
>>>> On 4/16/24 5:25 PM, Kui-Feng Lee wrote:
>>>>> +int bpffs_struct_ops_link_open(struct inode *inode, struct file 
>>>>> *filp)
>>>>> +{
>>>>> +    struct bpf_struct_ops_link *link = inode->i_private;
>>>>> +
>>>>> +    /* Paired with bpf_link_put_direct() in bpf_link_release(). */
>>>>> +    bpf_link_inc(&link->link);
>>>>> +    filp->private_data = link;
>>>>> +    return 0;
>>>>> +}
>>>>> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
>>>>> index af5d2ffadd70..b020d761ab0a 100644
>>>>> --- a/kernel/bpf/inode.c
>>>>> +++ b/kernel/bpf/inode.c
>>>>> @@ -360,11 +360,16 @@ static int bpf_mkmap(struct dentry *dentry, 
>>>>> umode_t mode, void *arg)
>>>>>   static int bpf_mklink(struct dentry *dentry, umode_t mode, void 
>>>>> *arg)
>>>>>   {
>>>>> +    const struct file_operations *fops;
>>>>>       struct bpf_link *link = arg;
>>>>> -    return bpf_mkobj_ops(dentry, mode, arg, &bpf_link_iops,
>>>>> -                 bpf_link_is_iter(link) ?
>>>>> -                 &bpf_iter_fops : &bpffs_obj_fops);
>>>>> +    if (bpf_link_is_iter(link))
>>>>> +        fops = &bpf_iter_fops;
>>>>> +    else if (link->type == BPF_LINK_TYPE_STRUCT_OPS)
>>>>
>>>> Open a pinned link and then update should not be specific to 
>>>> struct_ops link. e.g. should be useful to the cgroup link also?
>>>
>>> It could be. Here, I played safe in case it creates any unwanted side
>>> effect for links of unknown types.
>>
>> By the way, may I put it in a follow up patch if we want cgroup links?
> 
> This does not feel right. It is not struct_ops specific.
> 
> Before we dive in further, there is BPF_OBJ_GET which can get a fd of a 
> pinned bpf obj (prog, map, and link). Take a look at bpf_link__open() in 
> libbpf. Does it work for the use case that needs to update the link?
> 
It should work.
So, this patch is not necessary. However, it is still a nice and
intuitive feature. WDYT?

