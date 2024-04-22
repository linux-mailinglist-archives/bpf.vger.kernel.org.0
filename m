Return-Path: <bpf+bounces-27446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 041288AD327
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 19:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A9B281B2B
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 17:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956F2153BCD;
	Mon, 22 Apr 2024 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPI6wK4Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63622EB11
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805937; cv=none; b=lHzSkQFiA7oqZmjRsLDff15DapX+AdLyC+C1piV2aBdHf4vmXpwgoYse2ivrb3lyPf7n3isRqEV43olx74jNaIqwxW8VVSho9jRz/rOGJhfZy7vM9afDcwZDBSkOvkfJZxSYE2AsBagpaY7ZWnEOYtE3IF0U+nNVZZEq8Kmtw+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805937; c=relaxed/simple;
	bh=IT8EwMxf1GVwOGot+BS7GmAgau59uQ10uKzGyUb0uzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JyxtPt94guNS3gPvdo7z3JwWcs7N+2C2EOBGSnI92i6AfZ3z2JOCtbJVaFG49KgyicSviHe1TUv2ruKcW4McZ1KHmJJ26FnZPSguuPLOhlr5fW2uHT1kiGahtWodAHn+R5IYTl+ibm4mquPe2i8ljUz94NlQ26r7H33Z9Dg5rZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPI6wK4Y; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6eb8809a44eso2869579a34.0
        for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713805935; x=1714410735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6DTvRgXddA8sY1ASOLBG5L2ywyLy3xAViW6bClhAj1Q=;
        b=HPI6wK4Yop0SkHg7BkIIUGTu0wAlOZnN15ZCk50YZCPbd06OFWTDzvBHoIAe4kKR7/
         vmya4vTK6AmEKlVCJ/zBMqps1INs222+zxTIWmxkOpLs1o1IaVvR1n404TxEmcdPoQHe
         wPZivhWfEuvlN6SVmB3qkf6ulsDVR0cocbEzuWBi9gaHYGHBL1bHygEzLhU028vGgspA
         uLUoz0fYJswEHZFzqxT+S+vGczcv6oq3QJ4KYLsV0IMrTNU+b4hIGh4O0eokEbhragct
         iTqJrwCTlZc3YNeTDVIYMXY0FA32TExAX7PR7N3uU06VQ7VnvD6qWBv8/R43Qv8HifBK
         5QIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713805935; x=1714410735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DTvRgXddA8sY1ASOLBG5L2ywyLy3xAViW6bClhAj1Q=;
        b=e2t65CBoFG69s2cUPcAt4bbnWLqtuY0zcDgQP4KyPj0tFFSX7W97M5DJFahHr/gESd
         7rqRWxlqCxuKzjHxfyrGCEyvqrQO6JAqy5xq8uePWyIozsgJ2vI8Mkjkh4ZzizbsDz5o
         LJlngeWQqnVEJT//pEqFYBKlc5PmamG+dmh+1WFWlB/1hyrpZB2UwkAWMb1dofMXZZdb
         +/yI8S9ForwXrze/4x5fr+S9hxt58evzCYq7kiH2nJIsCgdorv33Xp/oCXNijQsJS4lE
         W9+HrIxKpM6p0Qwy7nLKPGcWlztH2NnU+AuTooQnjG4bpaM055l6Oa16IRDUKhqwbEwk
         vbQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWgfvE7CkBfQ/nu++NOYE7c3GtYsJCnikXAWwIC0wgAVnJFsdcYE0Eqy973DEykgfIAhoxhaivvknLghMcsi18uNoJ
X-Gm-Message-State: AOJu0YxDSCUQZslyAlq2F5/BVbX9wz5d9Y0uLhvmsoiBvO8jFOKBfMtM
	fNu8p48p+jdGYi4tctGgO3tO25TGRW1IfPta48MpUnTKD5R4mgxf
X-Google-Smtp-Source: AGHT+IELVjyXyuEUR7OZu5HzPlqNNvuzswMthMi8bhBNzA9KnpZ+efRzabinaHGpkrEhluW/IwWphQ==
X-Received: by 2002:a05:6870:724f:b0:22a:9edb:27f0 with SMTP id y15-20020a056870724f00b0022a9edb27f0mr13440103oaf.3.1713805933431;
        Mon, 22 Apr 2024 10:12:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:70f9:8463:f3b1:c282? ([2600:1700:6cf8:1240:70f9:8463:f3b1:c282])
        by smtp.gmail.com with ESMTPSA id pn2-20020a056871d30200b002336a4cc3basm2020588oac.21.2024.04.22.10.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 10:12:12 -0700 (PDT)
Message-ID: <0326d150-6b43-465c-ba43-7e7033b13408@gmail.com>
Date: Mon, 22 Apr 2024 10:12:11 -0700
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
 Kui-Feng Lee <thinker.li@gmail.com>, andrii@kernel.org
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com
References: <20240417002513.1534535-1-thinker.li@gmail.com>
 <20240417002513.1534535-2-thinker.li@gmail.com>
 <8dadfcc9-1f6a-4b93-951b-548e4560ce5a@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <8dadfcc9-1f6a-4b93-951b-548e4560ce5a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/19/24 17:05, Martin KaFai Lau wrote:
> On 4/16/24 5:25 PM, Kui-Feng Lee wrote:
>> +int bpffs_struct_ops_link_open(struct inode *inode, struct file *filp)
>> +{
>> +    struct bpf_struct_ops_link *link = inode->i_private;
>> +
>> +    /* Paired with bpf_link_put_direct() in bpf_link_release(). */
>> +    bpf_link_inc(&link->link);
>> +    filp->private_data = link;
>> +    return 0;
>> +}
>> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
>> index af5d2ffadd70..b020d761ab0a 100644
>> --- a/kernel/bpf/inode.c
>> +++ b/kernel/bpf/inode.c
>> @@ -360,11 +360,16 @@ static int bpf_mkmap(struct dentry *dentry, 
>> umode_t mode, void *arg)
>>   static int bpf_mklink(struct dentry *dentry, umode_t mode, void *arg)
>>   {
>> +    const struct file_operations *fops;
>>       struct bpf_link *link = arg;
>> -    return bpf_mkobj_ops(dentry, mode, arg, &bpf_link_iops,
>> -                 bpf_link_is_iter(link) ?
>> -                 &bpf_iter_fops : &bpffs_obj_fops);
>> +    if (bpf_link_is_iter(link))
>> +        fops = &bpf_iter_fops;
>> +    else if (link->type == BPF_LINK_TYPE_STRUCT_OPS)
> 
> Open a pinned link and then update should not be specific to struct_ops 
> link. e.g. should be useful to the cgroup link also?

It could be. Here, I played safe in case it creates any unwanted side
effect for links of unknown types.

> 
> Andrii, wdyt about supporting other link types also?
> 
>> +        fops = &bpf_link_fops;
>> +    else
>> +        fops = &bpffs_obj_fops;
>> +    return bpf_mkobj_ops(dentry, mode, arg, &bpf_link_iops, fops);
>>   }
>>   static struct dentry *
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 7d392ec83655..f66bc6215faa 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -3108,7 +3108,19 @@ static void bpf_link_show_fdinfo(struct 
>> seq_file *m, struct file *filp)
>>   }
>>   #endif
>> -static const struct file_operations bpf_link_fops = {
>> +/* Support opening pinned links */
>> +static int bpf_link_open(struct inode *inode, struct file *filp)
>> +{
>> +    struct bpf_link *link = inode->i_private;
>> +
>> +    if (link->type == BPF_LINK_TYPE_STRUCT_OPS)
>> +        return bpffs_struct_ops_link_open(inode, filp);
>> +
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +const struct file_operations bpf_link_fops = {
>> +    .open = bpf_link_open,
>>   #ifdef CONFIG_PROC_FS
>>       .show_fdinfo    = bpf_link_show_fdinfo,
>>   #endif
> 

