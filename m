Return-Path: <bpf+bounces-27448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D548AD34E
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 19:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A851C21817
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 17:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FAC153BE2;
	Mon, 22 Apr 2024 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OckhkOHc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED8315218D
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713807051; cv=none; b=gEaTV5oKLNZUuEdohpCiVHAyoy76F0ZeZTUCVIJx61UPuos27Frs2k+F1YkHSVnbG3cP6/6/VAJG2kleU424B6K5rwRnoSVJOHhtLqMsRRoBRW4vFzvOCcwRf8QmWS563ikiN+Z/SwJsny4HkgT1upb40wRwI0Y3YYS7GTUuPC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713807051; c=relaxed/simple;
	bh=oPfiqS1UgB0MxdSKPPFZuauSyUK+DA2fij3nosmrqNc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bkExvPnk1cSYHEpRxSuG9bEkiCcLVh+NHwEToMvZl8mVMc+PVHMF8Lm5McnY4+3r/NvRFqMKSEAiG7Jctl6gQ7VzFn/UOBlVqOImBlT7XruWxJwvSBwCO7cGSNqltpz3X/1nWbHweQMy7+C0sjTAQaqahOoBVKZJzQPV9fe0Dz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OckhkOHc; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c75075ad30so1657452b6e.3
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 10:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713807049; x=1714411849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zY3NebIeH8RfrGiE3txFKanbhJ3rzfIjUngC+1kq5FA=;
        b=OckhkOHcITeg9145n7kZEITJufnJ55C4kkfl/BHii3Ck93a3SknOZ85ZMbNLPNghZa
         FXVCMWjLB5Qi5w0sjckWKSsfSzHHyTdZhyB5EWlrt32FDMuxWcD+lg9hB5c8rlP3ZYDl
         811eJ9JafZrJ9MFDA1WRR+W3XB1kLzgbWoOIqSqWfSi4s6bphed6SDuge8fqnKib8WCT
         hZGcGov9Pwac4LPlWQb/1WcFtJc8PEZG1u03lbCZZP5z3tAPI7068A3Esm7ORW4cMu8q
         QbB+SmcCk7DIBk1604RuJFpdMFdS9MDZ80KYGG0hz/iP1Hui1bfhYEVjdVkr/xn+PYg6
         SdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713807049; x=1714411849;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zY3NebIeH8RfrGiE3txFKanbhJ3rzfIjUngC+1kq5FA=;
        b=wJ3I9yYiEE3XrZUS/g+VcbM92uh0uFB4rzBDpbcvsx+6A67B6wvL0+HFhT86EhOduE
         FZ+OHWzwCdv7c+VpTtSUSU5yh7YmTWeyA3+DL5W+dUSl618iGJv5z+cmFROubDSoaQmd
         UQOv4DpcWW6TOQBM3vykLO/rmR9X6uuunh/PepQ0E5IDg/vsNgelP54bCxM1hUIywx5W
         To//9vexfw+Ezn6Aq5yvme+W4rUdjKtS9kMbcRmkPljZfgjcLKg5i/1z0Es1Y8dbuYFW
         TQ4ajY3V51cD6v75trhKtK7lRu6GMGtnLaott1ZayE7pVFSOQleOZEuXyIiYUSehep0C
         nrrA==
X-Forwarded-Encrypted: i=1; AJvYcCXoIlyhns62RivaPeFm9djsZL0TEF/uuVc6esI1yTC0ck8NLMXPrfPBlxpbN7mR5UsOFCTtjvHO0rQuznHEmV1HUAKz
X-Gm-Message-State: AOJu0Yx9SkJPOxFDMMgSU3tNsKW67kNrdpp6sk+2cE2xdhH2S5tMyPjH
	8wEn48B3r4FS+6pOJiDm8nVJuH30E6QWrmXkYIaTzhprkGqVG/64
X-Google-Smtp-Source: AGHT+IH/ZiQTFCKba/h2YLLZvmGD3AlQ0aZrVFEVuNemWGAwH5RfRm7CGHvWq1zzmuETfjmeMvITVQ==
X-Received: by 2002:a05:6870:4725:b0:22d:f859:2225 with SMTP id b37-20020a056870472500b0022df8592225mr17558035oaq.6.1713807048686;
        Mon, 22 Apr 2024 10:30:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:70f9:8463:f3b1:c282? ([2600:1700:6cf8:1240:70f9:8463:f3b1:c282])
        by smtp.gmail.com with ESMTPSA id nd25-20020a056871441900b0022f7268ec29sm2030133oab.54.2024.04.22.10.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 10:30:47 -0700 (PDT)
Message-ID: <70bf97a6-19d8-4a26-8879-17db7c44a2cc@gmail.com>
Date: Mon, 22 Apr 2024 10:30:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: enable the "open" operator on a pinned
 path of a struct_osp link.
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>, andrii@kernel.org
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com
References: <20240417002513.1534535-1-thinker.li@gmail.com>
 <20240417002513.1534535-2-thinker.li@gmail.com>
 <8dadfcc9-1f6a-4b93-951b-548e4560ce5a@linux.dev>
 <0326d150-6b43-465c-ba43-7e7033b13408@gmail.com>
Content-Language: en-US
In-Reply-To: <0326d150-6b43-465c-ba43-7e7033b13408@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/22/24 10:12, Kui-Feng Lee wrote:
> 
> 
> On 4/19/24 17:05, Martin KaFai Lau wrote:
>> On 4/16/24 5:25 PM, Kui-Feng Lee wrote:
>>> +int bpffs_struct_ops_link_open(struct inode *inode, struct file *filp)
>>> +{
>>> +    struct bpf_struct_ops_link *link = inode->i_private;
>>> +
>>> +    /* Paired with bpf_link_put_direct() in bpf_link_release(). */
>>> +    bpf_link_inc(&link->link);
>>> +    filp->private_data = link;
>>> +    return 0;
>>> +}
>>> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
>>> index af5d2ffadd70..b020d761ab0a 100644
>>> --- a/kernel/bpf/inode.c
>>> +++ b/kernel/bpf/inode.c
>>> @@ -360,11 +360,16 @@ static int bpf_mkmap(struct dentry *dentry, 
>>> umode_t mode, void *arg)
>>>   static int bpf_mklink(struct dentry *dentry, umode_t mode, void *arg)
>>>   {
>>> +    const struct file_operations *fops;
>>>       struct bpf_link *link = arg;
>>> -    return bpf_mkobj_ops(dentry, mode, arg, &bpf_link_iops,
>>> -                 bpf_link_is_iter(link) ?
>>> -                 &bpf_iter_fops : &bpffs_obj_fops);
>>> +    if (bpf_link_is_iter(link))
>>> +        fops = &bpf_iter_fops;
>>> +    else if (link->type == BPF_LINK_TYPE_STRUCT_OPS)
>>
>> Open a pinned link and then update should not be specific to 
>> struct_ops link. e.g. should be useful to the cgroup link also?
> 
> It could be. Here, I played safe in case it creates any unwanted side
> effect for links of unknown types.

By the way, may I put it in a follow up patch if we want cgroup links?

> 
>>
>> Andrii, wdyt about supporting other link types also?
>>
>>> +        fops = &bpf_link_fops;
>>> +    else
>>> +        fops = &bpffs_obj_fops;
>>> +    return bpf_mkobj_ops(dentry, mode, arg, &bpf_link_iops, fops);
>>>   }
>>>   static struct dentry *
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index 7d392ec83655..f66bc6215faa 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -3108,7 +3108,19 @@ static void bpf_link_show_fdinfo(struct 
>>> seq_file *m, struct file *filp)
>>>   }
>>>   #endif
>>> -static const struct file_operations bpf_link_fops = {
>>> +/* Support opening pinned links */
>>> +static int bpf_link_open(struct inode *inode, struct file *filp)
>>> +{
>>> +    struct bpf_link *link = inode->i_private;
>>> +
>>> +    if (link->type == BPF_LINK_TYPE_STRUCT_OPS)
>>> +        return bpffs_struct_ops_link_open(inode, filp);
>>> +
>>> +    return -EOPNOTSUPP;
>>> +}
>>> +
>>> +const struct file_operations bpf_link_fops = {
>>> +    .open = bpf_link_open,
>>>   #ifdef CONFIG_PROC_FS
>>>       .show_fdinfo    = bpf_link_show_fdinfo,
>>>   #endif
>>

