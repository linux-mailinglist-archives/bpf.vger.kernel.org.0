Return-Path: <bpf+bounces-75564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D41EC88E4D
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 10:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6FF3A8DB0
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CF92D6619;
	Wed, 26 Nov 2025 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j29BKnQZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C233993
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148529; cv=none; b=WEmbKl3zQcicKYM2yhf7HxTSk/l4RorNqR0QtReP4idDfLkdoEgr9umSzgfnsMzThm/cUDMv8Ioq5qNh28bm3w+37NYZ6E6LvK8oMHnTvLBSV7f5BLN1Q5XZd8xdelTnV5qlm0ESr7hBZl8T6pF5/UNUUSh5qu4wTANb1DQcGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148529; c=relaxed/simple;
	bh=bUV7mxVhHk6EWz8l29l7obsjLcdiG5t2lplUibz9r6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCdhgYHa+WASdaamVt+x9C5b56C3Q4RJNqRBUEZ5fwihDXVbq0YZJ0T05bQxtERg4mJ3f4fusQhA3xJw+8NlbgwlQArobiqIEsTwpa/E5HGruVz3dJQs7jHc2C6cqhRvWqnRoNxsQxGBDJ0pp1r0rPnEiZQp599uZmoGD1kKQwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j29BKnQZ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ff4be1ef-ef02-471e-b8f0-8e9cdb312794@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764148524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Xyuy5c0DSlZ1jPXXoXxKYgyeLh64+aIUh7bnkEKIR8=;
	b=j29BKnQZG2vaEd5Z58RsqhANxWF1bpa0wfAf0CeFYU35j2ueYP4TLAoniliNiFlkb8qcTb
	UtR7lpzgnjzh31TLk7wXHzDdoMMzhpeeGX397qb2D8R04NIBbOEDUonTmbvfNUb9t22P6E
	dTzO+QiF3jKSGXSLlGM8GEDKYywtn/k=
Date: Wed, 26 Nov 2025 17:15:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_get_task_cmdline kfunc
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20251118125802.385503-1-chen.dylane@linux.dev>
 <CAADnVQJ0MDMwrmsUoM1xt_1bMQ2d-Eer7ynD3GVSCuwcpZouLg@mail.gmail.com>
 <CAEf4BzaXozVSTsC7XZ8Ojkju1szk65nAg8Zc5Y_2OVewKV4heA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzaXozVSTsC7XZ8Ojkju1szk65nAg8Zc5Y_2OVewKV4heA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/11/26 07:32, Andrii Nakryiko 写道:
> On Fri, Nov 21, 2025 at 5:17 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Tue, Nov 18, 2025 at 4:58 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>>
>>> Add the bpf_get_task_cmdline kfunc. One use case is as follows: In
>>> production environments, there are often short-lived script tasks executed,
>>> and sometimes these tasks may cause stability issues. It is desirable to
>>> detect these script tasks via eBPF. The common approach is to check
>>> the process name, but it can be difficult to distinguish specific
>>> tasks in some cases. Take the shell as an example: some tasks are
>>> started via bash xxx.sh – their process name is bash, but the script
>>> name of the task can be obtained through the cmdline. Additionally,
>>> myabe this is helpful for security auditing purposes.
>>
>> maybe
>>
>>>
>>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>>> ---
>>>   kernel/bpf/helpers.c | 22 ++++++++++++++++++++++
>>>   1 file changed, 22 insertions(+)
>>>
>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>> index 865b0dae38d..7cac17d58d5 100644
>>> --- a/kernel/bpf/helpers.c
>>> +++ b/kernel/bpf/helpers.c
>>> @@ -2685,6 +2685,27 @@ __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
>>>          return p;
>>>   }
>>>
>>> +/*
>>> + * bpf_get_task_cmdline - Get the cmdline to a buffer
>>> + *
>>> + * @task: The task whose cmdline to get.
>>> + * @buffer: The buffer to save cmdline info.
>>> + * @len: The length of the buffer.
>>> + *
>>> + * Return: the size of the cmdline field copied. Note that the copy does
>>> + * not guarantee an ending NULL byte. A negative error code on failure.
>>> + */
>>> +__bpf_kfunc int bpf_get_task_cmdline(struct task_struct *task, char *buffer, size_t len)
>>
>> 'size_t len' doesn't make the verifier track the size of the buffer.
>> while 'char *buffer' tells the verifier to check that _one_ byte is available.
>> So this is buggy.
>>
>> In general the kfunc seems useful, but selftest in patch 2 is just bad
>>
> 
> Besides that mm->arg_lock spinlock (which I don't think matters all
> that much for BPF programs), is there anything special in
> get_cmdline() that BPF program cannot just implemented? Ultimately,
> it's just copying mm->arg_start and mm->env_start zero-separated
> strings, no? We have bpf_copy_from_user_task_str() and also
> dynptr-based equivalent of it for even more variable-length
> flexibility. That should be all one needs, no?
> 

 From a quick look at how both are implemented, it seems that way.
Hold off on this patch for now. I will move forward if we find something 
new.

>> + ret = bpf_get_task_cmdline(task, buf, sizeof(buf));
>> + if (ret < 0)
>> +    err = 1;
>> +
>> + return 0;
>> +}
>>
>> it's not testing much.
>>
>> Also you must explain the true motivation for the kfunc.
>> "maybe helpful for security" is too vague.
>> Do you have a proprietary bpf-lsm that needs it?
>> What is the exact use case?
>>
>> pw-bot: cr


-- 
Best Regards
Tao Chen

