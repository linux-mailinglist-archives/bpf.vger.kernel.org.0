Return-Path: <bpf+bounces-30433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1068CDADD
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 21:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5AE1C22B90
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 19:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60C383CBB;
	Thu, 23 May 2024 19:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC0jI+jg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D685383A0D
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716492509; cv=none; b=ddBbnIo7pHcUuVfu4HFYms2iP9vVB6HThewQ038JWMx2ooA1S/n6FgTZaMqFGT9IeusYs57YdDNHwQvbj/NXPEl77tio8cQGw4uTZDHpcSuJsoE6HgDxaRLKM5GQxVWxPjYeA4Pyxo1t+GuWy+VG25JlJqO4a/ur8gdFcdBkQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716492509; c=relaxed/simple;
	bh=X7AQYjBuGVqVeIAFCn84Oco5EETJD04DAkZ80kixKps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akXcWHcjOO4alGSX1II9P8Vlvz+WTW0rWPVz3/DT6XrM1wudGY9IFSXj7tVHV3nPRrtMlT0z13VEbR+6iWOF0WyPE7QjQFNlXPYOVGN1Csy+rpcut3fIbyhTkIbpt6MPnQSUEySmzp6IsV6F7svrju6HeRog8/QjQUg28RD7xCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PC0jI+jg; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6209e8a0386so23173807b3.0
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 12:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716492507; x=1717097307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QIpUGoTsviWnrqGg3GDc4BNW9t9i6ok6CaoesWlG7Bc=;
        b=PC0jI+jgpadvmxy6sPA6BGl0XKsYOlA9YWAu5r6QoBLF6jSegLkXj5Vi3j2OnxWNf0
         o0FHSaP0f9pNvcQzVjt2tVgbZXTlQgIcUqKd7KP7bUPvDcBVfSj5awO61wXnDYGKYusF
         +6Yr1amJxDxnqMweCPZ4gzjG0uCWX90X61hg1XFetpPQCHxSps70a0nLgnH0lAVFyx6T
         bwEbP/QPKPuseFplUV3ovJDW0p8PH3mIOpx0LFkNsKmbMlY0ErrFdwxDtk4htXEgBoJy
         XXHvydbnnFKzoBrX1a+vDVeer+0WCZcR63Dui+KL4X4WAEs1lC+qRNjGU4kPS3l2US+E
         v3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716492507; x=1717097307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIpUGoTsviWnrqGg3GDc4BNW9t9i6ok6CaoesWlG7Bc=;
        b=g5ASzw83Ucgs8bAwKwsMJsmIfTP53Knnm6rAmWxQ+MKk2JgnKWj31E/OgvqhyKBSal
         JjKWojbc+3QvEo+nMr7zuA8MRHm4j/t35D4Rv4UTO6os9L1D7/MgvzgWQJz1zagwx92d
         QKNKlqpnNgRqxXs86MFl0k+2fix3hA0MIpdffdsU6BSdKLaHJ4trdhzDz3RIsUVnRK5s
         grPmFjdYrmWvVbyGNuixjjAv3uXdApP8igMPp08QcjM00bqKRDCIZ0calqqhQcEZ0ZK3
         +l54KFmTF6rFJFuQ0yNVg5RwwXmQZqlyADVSdVB39lTH4v7wWO57RgjY1kH5B09tPVIX
         k6dQ==
X-Gm-Message-State: AOJu0YzjNE/WqFIZ1vJzPjOYdHhqO3VKpJqDRl6yHIS5pNLLliL+MPv/
	5YUzNMQaanHuKZ7pcU1m2ESTCQwWea8L95KRwecvtUYPoqunNAvGvGe7Zw==
X-Google-Smtp-Source: AGHT+IELycqZKF6yuwD2VIyLGleqIQsFkv+ZGTE4pVw1//PQ/v+Vpu/rKapsRCAXLa4fPV/P5OU/jQ==
X-Received: by 2002:a81:4e4e:0:b0:627:a917:bae7 with SMTP id 00721157ae682-62a08e6050amr1119377b3.30.1716492506670;
        Thu, 23 May 2024 12:28:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:a2b5:fcfb:857c:2908? ([2600:1700:6cf8:1240:a2b5:fcfb:857c:2908])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e379112sm63280017b3.107.2024.05.23.12.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 12:28:26 -0700 (PDT)
Message-ID: <bec6bdf5-14c8-43ca-a3de-d05da97b3290@gmail.com>
Date: Thu, 23 May 2024 12:28:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 3/7] bpf: support epoll from bpf struct_ops
 links.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240521225121.770930-1-thinker.li@gmail.com>
 <20240521225121.770930-4-thinker.li@gmail.com>
 <a04e275d-4b29-4a6a-b142-dec5b376f2b9@linux.dev>
 <787e0274-5592-4b74-8a7f-3d1962d41d35@gmail.com>
 <e03759c1-09bc-46ce-ba2d-47cff1471eff@linux.dev>
 <d51165a1-c85f-4216-bb12-9615aee5f857@gmail.com>
 <6570e32c-c3fc-4c2d-8ebb-f0080644cd13@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <6570e32c-c3fc-4c2d-8ebb-f0080644cd13@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/23/24 12:10, Martin KaFai Lau wrote:
> On 5/23/24 12:03 PM, Kui-Feng Lee wrote:
>>
>>
>> On 5/23/24 11:34, Martin KaFai Lau wrote:
>>> On 5/23/24 11:24 AM, Kui-Feng Lee wrote:
>>>>
>>>>
>>>> On 5/23/24 10:23, Martin KaFai Lau wrote:
>>>>> On 5/21/24 3:51 PM, Kui-Feng Lee wrote:
>>>>>> +static __poll_t bpf_link_poll(struct file *file, struct 
>>>>>> poll_table_struct *pts)
>>>>>> +{
>>>>>> +    struct bpf_link *link = file->private_data;
>>>>>> +
>>>>>> +    if (link->ops->poll)
>>>>>> +        return link->ops->poll(file, pts);
>>>>>> +
>>>>>> +    return 0;
>>>>>
>>>>> The current bpf_link_fops.poll is NULL before this patch. From 
>>>>> vfs_poll, it seems to be DEFAULT_POLLMASK for this case. Please 
>>>>> double check.
>>>>
>>>>
>>>> Yes, it returns DEFAULT_POLLMASK if file->f_op->epoll is NULL. But,
>>>> before this patch, link can not be added to an epoll. See the
>>>> explanation below.
>>>
>>> How about select() and poll() that do not need epoll_ctl() setup?
>>
>> AFAIK, they just don't check it at all, calling vfs_poll() directly.
> 
> right, vfs_poll returns DEFAULT_POLLMASK which is not 0.
> 
> #define DEFAULT_POLLMASK (EPOLLIN | EPOLLOUT | EPOLLRDNORM | EPOLLWRNORM)
> 
> static inline __poll_t vfs_poll(struct file *file, struct 
> poll_table_struct *pt)
> {
>      if (unlikely(!file->f_op->poll))
>          return DEFAULT_POLLMASK;
>      return file->f_op->poll(file, pt);
> }
> 
> but this discussion is moot if another file_operations instance is used.

Sure! I am adding another instance.

> 
>>
>>>
>>>>
>>>>>
>>>>>> +}
>>>>>> +
>>>>>>   static const struct file_operations bpf_link_fops = {
>>>>>>   #ifdef CONFIG_PROC_FS
>>>>>>       .show_fdinfo    = bpf_link_show_fdinfo,
>>>>>> @@ -3157,6 +3167,7 @@ static const struct file_operations 
>>>>>> bpf_link_fops = {
>>>>>>       .release    = bpf_link_release,
>>>>>>       .read        = bpf_dummy_read,
>>>>>>       .write        = bpf_dummy_write,
>>>>>> +    .poll        = bpf_link_poll,
>>>>>
>>>>> Same here. What does the epoll_ctl(EPOLL_CTL_ADD) currently expect 
>>>>> for link (e.g. cgroup) that does not support poll?
>>>>>
>>>>
>>>> epoll_ctl() always returns -EPERM for files not supporting poll.
>>>> Should I add another instance of struct file_operations to keep the
>>>> consistency for other types of links?
>>>
>>> imo, it makes sense to have another instance for link that supports 
>>> poll such that epoll_ctl(EPOLL_CTL_ADD) can fail early for the 
>>> unsupported links.
>>
>> Ok! I will add another instance.
> 

