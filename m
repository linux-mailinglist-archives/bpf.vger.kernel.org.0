Return-Path: <bpf+bounces-64007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2905BB0D5DD
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 11:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FDE8189ACB0
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 09:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E9718FC91;
	Tue, 22 Jul 2025 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnpr+OvF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBCB1D5CD4;
	Tue, 22 Jul 2025 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176237; cv=none; b=YPUOFVJxhOW54hkpCdSH5EJnzxgBerVxBdaWUh9w/XAURZWIjjlx840GIdVyE0E5UG0rBYlR30kE/w6pSvGujOnn1QK+0eFITfAWs/n4fGAQWv/YNWLsEh95yeVEY4LE+1SVpyt1N/BN6kUkkKCxByXIUTDTYt8Q6RS2lJLWIRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176237; c=relaxed/simple;
	bh=a+8E4SAu1ib+nNJy6o6lE6mpCzXJ/lWhWHoAp+XIqMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qj3rhWKNK+zMr8F9FFDdg7U6nYLTV/eJp4WhhJs4BmI5cpiBLgJiTLFX2y+9RDyoJHMo70rbT0jogZEheS9deMi/wQSEmy4PvJMDRWdKy/UFnWYrwsBK4BtmLJC9+7Jx5RGJ7y5eePshcBlwJHZXoWme9AdXtpp0Tv9E96uLMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnpr+OvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4B7C4CEEB;
	Tue, 22 Jul 2025 09:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753176237;
	bh=a+8E4SAu1ib+nNJy6o6lE6mpCzXJ/lWhWHoAp+XIqMQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hnpr+OvFQrLwa9kjrXjGWutJC5Mk7eTwdSFAzB04Y0W/gneYBFZu6N+XiTI1FhnJ9
	 fasF4G353RSl1Zv7ZsgcE623tPIDs3J7bvNvCSe254Ucr2PWxfr1O0G+PeMRR/VfDv
	 mgbBc9cvhWwm5LfvExkE1vAKzuP6EiAd0RFZB8iGt5nbVLkS9CovoHGT9Ixr1rCUJ0
	 xBvvI9fQ57+uvh7g7l6EceitjKj/idoXSHxs2xa8UJ6d4KefJ27L7eTkuwSgroGHfK
	 yTH2wRCISnEZ02CCi/yfj8N3VREIOTE7u9M5pZ4zvzcUReNHeqqqPlf41r1L+G7Q3u
	 G6/a/k/3b4t+w==
Message-ID: <f956664e-24a2-410a-be9b-4d90e08c7c64@kernel.org>
Date: Tue, 22 Jul 2025 10:23:53 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpftool: Add bpf_token show
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250720173310.1334483-1-chen.dylane@linux.dev>
 <6b0669fd-fef6-4f4e-b80d-512769e86938@kernel.org>
 <06387128-8d34-49fd-a409-d35f5d60b094@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <06387128-8d34-49fd-a409-d35f5d60b094@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025-07-22 13:48 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
> 在 2025/7/22 00:23, Quentin Monnet 写道:
>> Thanks a lot for this!
>>
> 
> Hi Quenin,
> 
>>
>> 2025-07-21 01:33 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
>>> Add `bpftool token show` command to get token info
>>> from bpf fs in /proc/mounts.
>>>
>>> Example plain output for `token show`:
>>> token_info:
>>>          /sys/fs/bpf/token
>>>
>>> allowed_cmds:
>>>          map_create          prog_load
>>>
>>> allowed_maps:
>>>
>>> allowed_progs:
>>>          kprobe
>>>
>>> allowed_attachs:
>>>          xdp
>>>
>>> Example json output for `token show`:
>>> {
>>>      "token_info": "/sys/fs/bpf/token",
>>>      "allowed_cmds": ["map_create","prog_load"
>>>      ],
>>>      "allowed_maps":
>>
>>
>> This is not valid JSON. You're missing a value for "allowed_maps" (here
>> it should likely be an empty array), and the comma:
>>
>>     "allowed_maps": [],
>>
>>
>>>      "allowed_progs": ["kprobe"
>>>      ],
>>>      "allowed_attachs": ["xdp"
>>>      ]
>>> }
>>>
>>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>>> ---
>>>   tools/bpf/bpftool/main.c  |   3 +-
>>>   tools/bpf/bpftool/main.h  |   1 +
>>>   tools/bpf/bpftool/token.c | 229 ++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 232 insertions(+), 1 deletion(-)
>>>   create mode 100644 tools/bpf/bpftool/token.c
>>>

[...]

>>> diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
>>> new file mode 100644
>>> index 00000000000..2fcaff4f2ba
>>> --- /dev/null
>>> +++ b/tools/bpf/bpftool/token.c

[...]

>>> +            if (has_delegate_options(ent->mnt_opts)) {
>>> +                hit = true;
>>> +                break;
>>
>>
>> Apologies, my knowledge of BPF tokens is limited. Can you have only one
>> token exposed through a bpffs at a time? Asking because I know you can
>> have several bpffs on your system, if each can have delegate options
>> then why stop after the first bpffs mount point you find?
>>
> 
> Yes it is, only the first bpffs with token info will be showed above.
> Actually, it will not be limited how many bpffs ceated in kernel, it
> depends on the user scenarios. In most cases, only one will be created.
> But, maybe it's better to show all. I will change it in v2.

Yes please. If there are several tokens available, bpftool should "list"
them all, as the command name implies. The user scenarios don't really
count here, we should just dump all token info we can see. In the
future, we could then add the possibility to take an argument (likely a
path to a bpffs) to show info for a particular mountpoint; a bit like
you can list all existing programs with "bpftool prog show" but can also
chose to pick one with "bpftool prog show id ...".

If we print info for several mountpoint, I'd suggest adjusting the
format for the plain output slightly: I'd remove the blank lines between
the different sections to get something more compact, maybe play with
the indent as well, like when we list programs or maps.

Thanks,
Quentin

