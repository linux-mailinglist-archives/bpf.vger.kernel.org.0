Return-Path: <bpf+bounces-30429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5948CDA5F
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 21:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C192DB22F97
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 19:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB29B82D9A;
	Thu, 23 May 2024 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq88AgYh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150F762DC
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491022; cv=none; b=i2T6Vh/xgznLw6+E2GnwMdApWb8z5yMVKbqqm+msHNzlK65wII65OPcPv+3WdwxVy/Sm9JPduEEUV4vb/DQxcm9EKIQKJQKNbr07uYig6dVmPzQ4p6gK2F0FzloHkOSUCu8M2YrzoB30LMg9UUf1ev5z2092ZD7Egc+Gnj4vJU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491022; c=relaxed/simple;
	bh=7xUohBlGBsb61Ko3LeMnSvZhUrhXb9vWMwxZekEUIqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqEhFtalvjGtd4P4E8HeR7cVTBby+QVVKYBfXPnkKz4yTNkPTJCAuxBdGfJhG0sstBwo3vsOZz9TeugpIJts5tJkCwxQfYcTEA3Uw/S+Q2+Ln86cPpyFR5lL/RnCFduw+kIWTgiG0/D0cZxCRIrBuWX5e4vb6/ur9By03q/pPgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fq88AgYh; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-62a08099115so1165247b3.0
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 12:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716491020; x=1717095820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iy+4y+zNQHyusobkROUZgBI7D+CSHPX6lKYfU2YxTnk=;
        b=fq88AgYhsFo0ma2YICwPstqCgGT6nRDuA75WwBAnN+QBLwDhhxaSI51tFJzUhaMEBj
         JK2wmSCJrl6YxaIDJfC2EuyA2nGbDh1dItG56KRWCJ4uahk6bxrTGOhiXfxMPzWN9FnI
         4k4MTn+DQtXQZ/0olRR20IL8dYNRLPUO4w4CmxsZ6g/ihe8X/1jylEtb8VpN8mCdQ3xL
         aOp7VQCt2lxdIdKkzUD2nU/f1Wj/xWiyE1Vo4oRxN9aVCU9Zkar98+rQCaO+mEkofxkj
         jZEIDvLVQ3x4mjyneRw3YkHpz7AlFwfDK5Mu2A/7StvqEZxHe1+eF5tSl4td47nRMhDW
         S+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716491020; x=1717095820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iy+4y+zNQHyusobkROUZgBI7D+CSHPX6lKYfU2YxTnk=;
        b=uScceA43Zkt2/rB7y6QKno2iT4LJ19I4MgF/gNBTr+JdDL5JU+xLY9nTLyIT5i5BTH
         YkrV7zfmA27mOjwlMIbFQjox4lnu+KZH1Kx52gezHQ+9TjeWsZ+HptErqO8kcQhsW9jw
         +9TXOBkopszOgNdw7N818JJZ21LQss6ZzUXYW/2u3g+sKEQglP0G1tOAarciQ315+BDH
         2/EZFht7MOUWRQNmIo67Z28GxqY8jO90TERdbiwIJRu20MYMcixvD2U6fZAfjHUZarkD
         CkTWuVbPYY4uaavJIqk5uZ+4Iss+kpug6BN6kv6grl82G/bMNB5OqAIQOMUILLwZrtv0
         0h9g==
X-Gm-Message-State: AOJu0YzPaEh3G/C1cnDkMdxfpqLDYWEXgjfze/pv1jJxngo9O/wULhjP
	S7krN0UkfOerRBZ8VkuSMyDgTieMfUHN35btY0Lcgf1Ev82b1dYu
X-Google-Smtp-Source: AGHT+IHZLViTurEstQ5Mw0f1waUF8+JdTHpPh8uIGPW+GIslFCgQV2R3lD3ZktNekq8gxOVDvryiPA==
X-Received: by 2002:a81:4314:0:b0:61b:1f0d:838b with SMTP id 00721157ae682-62a08d8a0ddmr238517b3.14.1716491019335;
        Thu, 23 May 2024 12:03:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:a2b5:fcfb:857c:2908? ([2600:1700:6cf8:1240:a2b5:fcfb:857c:2908])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-627f2438b10sm5110367b3.97.2024.05.23.12.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 12:03:38 -0700 (PDT)
Message-ID: <d51165a1-c85f-4216-bb12-9615aee5f857@gmail.com>
Date: Thu, 23 May 2024 12:03:37 -0700
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
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <e03759c1-09bc-46ce-ba2d-47cff1471eff@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/23/24 11:34, Martin KaFai Lau wrote:
> On 5/23/24 11:24 AM, Kui-Feng Lee wrote:
>>
>>
>> On 5/23/24 10:23, Martin KaFai Lau wrote:
>>> On 5/21/24 3:51 PM, Kui-Feng Lee wrote:
>>>> +static __poll_t bpf_link_poll(struct file *file, struct 
>>>> poll_table_struct *pts)
>>>> +{
>>>> +    struct bpf_link *link = file->private_data;
>>>> +
>>>> +    if (link->ops->poll)
>>>> +        return link->ops->poll(file, pts);
>>>> +
>>>> +    return 0;
>>>
>>> The current bpf_link_fops.poll is NULL before this patch. From 
>>> vfs_poll, it seems to be DEFAULT_POLLMASK for this case. Please 
>>> double check.
>>
>>
>> Yes, it returns DEFAULT_POLLMASK if file->f_op->epoll is NULL. But,
>> before this patch, link can not be added to an epoll. See the
>> explanation below.
> 
> How about select() and poll() that do not need epoll_ctl() setup?

AFAIK, they just don't check it at all, calling vfs_poll() directly.

> 
>>
>>>
>>>> +}
>>>> +
>>>>   static const struct file_operations bpf_link_fops = {
>>>>   #ifdef CONFIG_PROC_FS
>>>>       .show_fdinfo    = bpf_link_show_fdinfo,
>>>> @@ -3157,6 +3167,7 @@ static const struct file_operations 
>>>> bpf_link_fops = {
>>>>       .release    = bpf_link_release,
>>>>       .read        = bpf_dummy_read,
>>>>       .write        = bpf_dummy_write,
>>>> +    .poll        = bpf_link_poll,
>>>
>>> Same here. What does the epoll_ctl(EPOLL_CTL_ADD) currently expect 
>>> for link (e.g. cgroup) that does not support poll?
>>>
>>
>> epoll_ctl() always returns -EPERM for files not supporting poll.
>> Should I add another instance of struct file_operations to keep the
>> consistency for other types of links?
> 
> imo, it makes sense to have another instance for link that supports poll 
> such that epoll_ctl(EPOLL_CTL_ADD) can fail early for the unsupported 
> links.

Ok! I will add another instance.

> 
>>
>>>>   };
>>>
> 

