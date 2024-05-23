Return-Path: <bpf+bounces-30431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC538CDA84
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 21:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BBE282E68
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 19:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B0782D68;
	Thu, 23 May 2024 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W46VWnTE"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74F98287D
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 19:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491463; cv=none; b=ScPt8F8tDoHWm1jzn233S5bH7rYeG1BRvwCERLP12BquHbPoERitqZm9JbbtQS6gzJvO6Drcjl2vnX6mhhpP8wjkOvPdhLme8zwWfqUofNdRrWeNmyhnQgF7IjJbGdn1hSrU/isxu+tjVoqQr51PI7EalYiCV2kiEl69S1WT+Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491463; c=relaxed/simple;
	bh=/DoGMWzC39/ujaOSe1X/y5goJVb/Vhkqlc+wccLKpPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9aIsy6VipWngzduPpqVMvT7MzfYz5cGChythoeRg17gD7YK7Mr89h3/amLd3XhMVLqH3ZkJsu5iXNIeNChS+SYC5U/+833zbPlsP1eOMs1CujXCuUoVW2nU12GhnrxKd0sVcWG4mxmaHD/hwtNsftRBVY09AYZPwT5nxCa3/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W46VWnTE; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: sinquersw@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716491459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eb9Sh7yjLyFk2f0utRhXrU70J88D+qWRGNg2RV186ws=;
	b=W46VWnTEE++RCb5jqtl3uoPXJKt2esgc858evl3HooNWBF1j+VNvdh40RzhRcPHsbqUR6L
	FnJcmZ96E9a6xNL3iQN766FpyIaw0cjfqa3n0W190UWTDE4zJevVxJsrk4lKGvVqwq635s
	Z8VvBn14JJJHw3BF2KWBD45TqQn8NRU=
X-Envelope-To: thinker.li@gmail.com
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: song@kernel.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: andrii@kernel.org
X-Envelope-To: kuifeng@meta.com
Message-ID: <6570e32c-c3fc-4c2d-8ebb-f0080644cd13@linux.dev>
Date: Thu, 23 May 2024 12:10:55 -0700
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
 <e03759c1-09bc-46ce-ba2d-47cff1471eff@linux.dev>
 <d51165a1-c85f-4216-bb12-9615aee5f857@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <d51165a1-c85f-4216-bb12-9615aee5f857@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/23/24 12:03 PM, Kui-Feng Lee wrote:
> 
> 
> On 5/23/24 11:34, Martin KaFai Lau wrote:
>> On 5/23/24 11:24 AM, Kui-Feng Lee wrote:
>>>
>>>
>>> On 5/23/24 10:23, Martin KaFai Lau wrote:
>>>> On 5/21/24 3:51 PM, Kui-Feng Lee wrote:
>>>>> +static __poll_t bpf_link_poll(struct file *file, struct poll_table_struct 
>>>>> *pts)
>>>>> +{
>>>>> +    struct bpf_link *link = file->private_data;
>>>>> +
>>>>> +    if (link->ops->poll)
>>>>> +        return link->ops->poll(file, pts);
>>>>> +
>>>>> +    return 0;
>>>>
>>>> The current bpf_link_fops.poll is NULL before this patch. From vfs_poll, it 
>>>> seems to be DEFAULT_POLLMASK for this case. Please double check.
>>>
>>>
>>> Yes, it returns DEFAULT_POLLMASK if file->f_op->epoll is NULL. But,
>>> before this patch, link can not be added to an epoll. See the
>>> explanation below.
>>
>> How about select() and poll() that do not need epoll_ctl() setup?
> 
> AFAIK, they just don't check it at all, calling vfs_poll() directly.

right, vfs_poll returns DEFAULT_POLLMASK which is not 0.

#define DEFAULT_POLLMASK (EPOLLIN | EPOLLOUT | EPOLLRDNORM | EPOLLWRNORM)

static inline __poll_t vfs_poll(struct file *file, struct poll_table_struct *pt)
{
	if (unlikely(!file->f_op->poll))
		return DEFAULT_POLLMASK;
	return file->f_op->poll(file, pt);
}

but this discussion is moot if another file_operations instance is used.

> 
>>
>>>
>>>>
>>>>> +}
>>>>> +
>>>>>   static const struct file_operations bpf_link_fops = {
>>>>>   #ifdef CONFIG_PROC_FS
>>>>>       .show_fdinfo    = bpf_link_show_fdinfo,
>>>>> @@ -3157,6 +3167,7 @@ static const struct file_operations bpf_link_fops = {
>>>>>       .release    = bpf_link_release,
>>>>>       .read        = bpf_dummy_read,
>>>>>       .write        = bpf_dummy_write,
>>>>> +    .poll        = bpf_link_poll,
>>>>
>>>> Same here. What does the epoll_ctl(EPOLL_CTL_ADD) currently expect for link 
>>>> (e.g. cgroup) that does not support poll?
>>>>
>>>
>>> epoll_ctl() always returns -EPERM for files not supporting poll.
>>> Should I add another instance of struct file_operations to keep the
>>> consistency for other types of links?
>>
>> imo, it makes sense to have another instance for link that supports poll such 
>> that epoll_ctl(EPOLL_CTL_ADD) can fail early for the unsupported links.
> 
> Ok! I will add another instance.


