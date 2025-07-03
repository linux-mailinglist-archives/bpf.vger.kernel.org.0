Return-Path: <bpf+bounces-62308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6457DAF7D89
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 18:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C59077B0E22
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 16:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFB32E267B;
	Thu,  3 Jul 2025 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a8gsKSM2"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45A11EF1D
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751559280; cv=none; b=KSkYm3jhPvmDP0rD1JxaAMjRyqWy2ZB2WIPXgcX6t+DwHzOolLgf+zrMr4tCsDHDeygp/Razt1hBZeLyDPxJGRYOTuOoZBVZecHcZU147xiLW4rLhcQkyPQNZal/REUA4NDaCVUN09XRy4h9a+aZ5u2VOUfJHkoJkJtbKEIN33A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751559280; c=relaxed/simple;
	bh=PpuNOz20PExVvuUMx+Y9esXMMhGEbMJsedc5HUA8aPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bINeksedb03awNxK91Cx/I+kZnkjmY82qHcVMcGKp0eQUkKHzAEp81CXXM48smrW5iNtuiBhxW14v5ZmPnMAkTTU3pSXQZoaEOtlELjV2qJqx2w0JdXINomJ8bYwhAu0RuybmK0vDIEnZV0IXSzN3ffH6/6FOrhJcAPMcvYtB1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a8gsKSM2; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d9c78add-d2e0-4d7c-a5a3-2355417cf9a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751559264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RjsWgbXGX7RbaYX+gdvDlZSlsMmT+hKRuaCsvLWPrJo=;
	b=a8gsKSM2BLripXrjCuby3gGqtuZwn3AkGMLZveOG4DHWQmOwcgevJPhlQuIig1trDAs7LH
	K1RCdFxXzHxN5BASbGdZXX2hztbahbvQ3zZZCeOr/5xWK9dzaf4m+xVtP/Pg0WigybHqlW
	Waqrou+24uenLQ+3aC4JYUGMnTgqX20=
Date: Thu, 3 Jul 2025 09:14:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Clean code with bpf_copy_to_user
Content-Language: en-GB
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250703124336.672416-1-chen.dylane@linux.dev>
 <b4925bd4-8169-47c2-9cff-5a4023f07a32@linux.dev>
 <9447cc50-03be-4eba-809d-f9e3381654fa@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <9447cc50-03be-4eba-809d-f9e3381654fa@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/3/25 9:03 AM, Tao Chen wrote:
> 在 2025/7/3 23:35, Yonghong Song 写道:
>>
>>
>> On 7/3/25 5:43 AM, Tao Chen wrote:
>>> No logic change, just use bpf_copy_to_user to clean code.
>>>
>>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>>> ---
>>>   kernel/bpf/syscall.c | 17 +++--------------
>>>   1 file changed, 3 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index e6eea594f1c..ca152d36312 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -5208,21 +5208,10 @@ static int bpf_task_fd_query_copy(const 
>>> union bpf_attr *attr,
>>>               if (put_user(zero, ubuf))
>>>                   return -EFAULT;
>>> -        } else if (input_len >= len + 1) {
>>> -            /* ubuf can hold the string with NULL terminator */
>>> -            if (copy_to_user(ubuf, buf, len + 1))
>>> -                return -EFAULT;
>>>           } else {
>>> -            /* ubuf cannot hold the string with NULL terminator,
>>> -             * do a partial copy with NULL terminator.
>>> -             */
>>> -            char zero = '\0';
>>> -
>>> -            err = -ENOSPC;
>>> -            if (copy_to_user(ubuf, buf, input_len - 1))
>>> -                return -EFAULT;
>>> -            if (put_user(zero, ubuf + input_len - 1))
>>> -                return -EFAULT;
>>> +            err = bpf_copy_to_user(ubuf, buf, input_len, len);
>>> +            if (err)
>>> +                return err;
>>>           }
>>>       }
>>
>> Actually, there is a return value change with this patch.
>> bpf_copy_to_user() return returns -ENOSPC while the original
>> implementation may return -EFAULT due to following code.
>>
>>          if (put_user(prog_id, &uattr->task_fd_query.prog_id) ||
>>              put_user(fd_type, &uattr->task_fd_query.fd_type) ||
>>              put_user(probe_offset, 
>> &uattr->task_fd_query.probe_offset) ||
>>              put_user(probe_addr, &uattr->task_fd_query.probe_addr))
>>                  return -EFAULT;
>>
>>          return err;
>>
>
> You are right, maybe we can just use:
>     err = bpf_copy_to_user(ubuf, buf, input_len, len);
> and no return check
> or move these put_user code to the front.

Maybe do the following?

    err = bpf_copy_to_user(ubuf, buf, input_len, len);
    if (err && err != -ENOSPC)
      return err;


