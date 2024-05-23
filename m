Return-Path: <bpf+bounces-30427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CDB8CDA04
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 20:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 720E4B20B86
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 18:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1091A537FF;
	Thu, 23 May 2024 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YYYJXeVY"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEBB187F
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 18:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716489282; cv=none; b=RSJQOHWYkpqP1r9CEU/YTteNdkrT1JrOvqrj9fA+/KqJ8ZYePA+CCS7hfUMm7aagpVyXe8qHY4j7TmO67VeyD7UWxZk+ELgtjU8yjK80L5Mi44Rr1N+mHbY8KNL0ufnKfXkQ50MOSrZrmdO/9fi+PMDFaX6kLBGAUvhGldfZ+4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716489282; c=relaxed/simple;
	bh=9JEPqtwzGJPdoN549kW6zVHj7oHo3E7htBSRvBJcOyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VaX7eEntnJqqeFu4Eh5hk88w8tgqzI2kYzs8s489JbsbiNCoyfnckCRqhoJdfK6553Yzxa17QWkncquM42FuAopOTGcegCYBiYboIdZg8T8n/VQtvi/XhvbMSdGn9N3Qjao6cwn6sZ73A89KFH0W28uZ/6PcLIt0EbMv5w2cXds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YYYJXeVY; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: sinquersw@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716489277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFGz3NC4BLUUZvi/mrdIrIUNJCdNGxG+b3MeyH3azgU=;
	b=YYYJXeVYeJxYM2ikjq7VX62HI23AKQpYKZOe5DkOVcIhNviR4ptGHBzUfsBphU+rR51XH8
	9rorpowOpxEoivN63Svt91janyqKVYk4ndmLDLVg75+faOyqpwCCwG0YKHIQtDfBNkkNYV
	25Qed9fEBkwu4LAdaVsroHpBedyS0Ow=
X-Envelope-To: thinker.li@gmail.com
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: song@kernel.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: andrii@kernel.org
X-Envelope-To: kuifeng@meta.com
Message-ID: <e03759c1-09bc-46ce-ba2d-47cff1471eff@linux.dev>
Date: Thu, 23 May 2024 11:34:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 3/7] bpf: support epoll from bpf struct_ops
 links.
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240521225121.770930-1-thinker.li@gmail.com>
 <20240521225121.770930-4-thinker.li@gmail.com>
 <a04e275d-4b29-4a6a-b142-dec5b376f2b9@linux.dev>
 <787e0274-5592-4b74-8a7f-3d1962d41d35@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <787e0274-5592-4b74-8a7f-3d1962d41d35@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/23/24 11:24 AM, Kui-Feng Lee wrote:
> 
> 
> On 5/23/24 10:23, Martin KaFai Lau wrote:
>> On 5/21/24 3:51 PM, Kui-Feng Lee wrote:
>>> +static __poll_t bpf_link_poll(struct file *file, struct poll_table_struct *pts)
>>> +{
>>> +    struct bpf_link *link = file->private_data;
>>> +
>>> +    if (link->ops->poll)
>>> +        return link->ops->poll(file, pts);
>>> +
>>> +    return 0;
>>
>> The current bpf_link_fops.poll is NULL before this patch. From vfs_poll, it 
>> seems to be DEFAULT_POLLMASK for this case. Please double check.
> 
> 
> Yes, it returns DEFAULT_POLLMASK if file->f_op->epoll is NULL. But,
> before this patch, link can not be added to an epoll. See the
> explanation below.

How about select() and poll() that do not need epoll_ctl() setup?

> 
>>
>>> +}
>>> +
>>>   static const struct file_operations bpf_link_fops = {
>>>   #ifdef CONFIG_PROC_FS
>>>       .show_fdinfo    = bpf_link_show_fdinfo,
>>> @@ -3157,6 +3167,7 @@ static const struct file_operations bpf_link_fops = {
>>>       .release    = bpf_link_release,
>>>       .read        = bpf_dummy_read,
>>>       .write        = bpf_dummy_write,
>>> +    .poll        = bpf_link_poll,
>>
>> Same here. What does the epoll_ctl(EPOLL_CTL_ADD) currently expect for link 
>> (e.g. cgroup) that does not support poll?
>>
> 
> epoll_ctl() always returns -EPERM for files not supporting poll.
> Should I add another instance of struct file_operations to keep the
> consistency for other types of links?

imo, it makes sense to have another instance for link that supports poll such 
that epoll_ctl(EPOLL_CTL_ADD) can fail early for the unsupported links.

> 
>>>   };
>>


