Return-Path: <bpf+bounces-62305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6526AF7D3A
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 18:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93605821AF
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 16:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF242E2EFD;
	Thu,  3 Jul 2025 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iUwkEbhj"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9762023BF83
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558628; cv=none; b=EliyGXRH2FdFnj7WdjqhPO7+ouvbiW94rqFsQMnIAhwVp8zrRVIZ+iTQlMiZaY+aEk6YoX5tvsDzZQpRv9IQu6/g8Q2+A3lwiydKV11ZHR9Q4TOm4ZoPg0I2/nZ/9qeR0Nq0Zg0V1PFh5O5bgU5RdTGKopOi8APCUOZICEiW4DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558628; c=relaxed/simple;
	bh=45no1ZSRP9ZgISPSug/hQGZSvkJCKpkWro/E23xCXnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGCQjJr3gNCMCklVsG6Tj0tI829u3VUVZP9WKoxX65VyKb47SfjtEgFjOLrNI423J2G2xKADdcnGSgA8q6aP3Eo1LVV9kFO1CuFwKsTdXKPzE5bSQ1rd+uU1D/2Xl7WO/Yh0qQknzmo03ScMnRTXFXFx7G+/kMserjmErzCBrLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iUwkEbhj; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9447cc50-03be-4eba-809d-f9e3381654fa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751558624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tcnfgrgLziJsJtGNHM11WwOgZeqfNsbwcjttOSUdxs8=;
	b=iUwkEbhjj7s7uRc1RrA/nf302Yc52VWq8yVDQ7fVYOj7dkpR3K/iX5y2IelMvzQ6qgPOhR
	zD5BRsL2JmZKNiTUV+xmfN5iu+r8rS/HnhcQOdDMvnrpCSvEmjqzVO+VQlW32BpX6lb5zv
	AycfcLxmEmwqcO8FFj7cQJlkQnZoheY=
Date: Fri, 4 Jul 2025 00:03:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Clean code with bpf_copy_to_user
To: Yonghong Song <yonghong.song@linux.dev>, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250703124336.672416-1-chen.dylane@linux.dev>
 <b4925bd4-8169-47c2-9cff-5a4023f07a32@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <b4925bd4-8169-47c2-9cff-5a4023f07a32@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/3 23:35, Yonghong Song 写道:
> 
> 
> On 7/3/25 5:43 AM, Tao Chen wrote:
>> No logic change, just use bpf_copy_to_user to clean code.
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/bpf/syscall.c | 17 +++--------------
>>   1 file changed, 3 insertions(+), 14 deletions(-)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index e6eea594f1c..ca152d36312 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -5208,21 +5208,10 @@ static int bpf_task_fd_query_copy(const union 
>> bpf_attr *attr,
>>               if (put_user(zero, ubuf))
>>                   return -EFAULT;
>> -        } else if (input_len >= len + 1) {
>> -            /* ubuf can hold the string with NULL terminator */
>> -            if (copy_to_user(ubuf, buf, len + 1))
>> -                return -EFAULT;
>>           } else {
>> -            /* ubuf cannot hold the string with NULL terminator,
>> -             * do a partial copy with NULL terminator.
>> -             */
>> -            char zero = '\0';
>> -
>> -            err = -ENOSPC;
>> -            if (copy_to_user(ubuf, buf, input_len - 1))
>> -                return -EFAULT;
>> -            if (put_user(zero, ubuf + input_len - 1))
>> -                return -EFAULT;
>> +            err = bpf_copy_to_user(ubuf, buf, input_len, len);
>> +            if (err)
>> +                return err;
>>           }
>>       }
> 
> Actually, there is a return value change with this patch.
> bpf_copy_to_user() return returns -ENOSPC while the original
> implementation may return -EFAULT due to following code.
> 
>          if (put_user(prog_id, &uattr->task_fd_query.prog_id) ||
>              put_user(fd_type, &uattr->task_fd_query.fd_type) ||
>              put_user(probe_offset, &uattr->task_fd_query.probe_offset) ||
>              put_user(probe_addr, &uattr->task_fd_query.probe_addr))
>                  return -EFAULT;
> 
>          return err;
> 

You are right, maybe we can just use:
	err = bpf_copy_to_user(ubuf, buf, input_len, len);
and no return check
or move these put_user code to the front.

-- 
Best Regards
Tao Chen

