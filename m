Return-Path: <bpf+bounces-43272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6669B2486
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 06:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13C71C20F21
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 05:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133E218E34F;
	Mon, 28 Oct 2024 05:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wwaYkLlz"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B50418CBEC
	for <bpf@vger.kernel.org>; Mon, 28 Oct 2024 05:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730094145; cv=none; b=UQaEN9SNl3aFo0ePlJ+lLnVyjzOFIvpf3X+0yNQSO08sJY5AeHR3KnN5dvOHsxvBy77Dd9U/IxDm6GKdELEaBEy5rhTCqnKS1V9brPVVlbyVW89npRKGlSuJEsFpKouJnaUMj2sHbYMT7MvXktNLcXw5vspd12YqtnrtMPAouow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730094145; c=relaxed/simple;
	bh=iZJDBmewrqSqINIiyukj1T9906bliPxi/ce+MGLFIN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVXf+P3AaX0+OqiLy1mvNGYzDIRPqbpSPE3HiZe8XUI7VsrgzN+BGUoKWPsmLvo2yk3AKSLDeULAcg88mBCt1d7q4GGHdYjzZ42Xi+KCh29UwWC53X/kI6d033Ke0V8vPnWiYUPwr27tBQJMmV3Luw9yJ50MRXbDwk3wCx3bbt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wwaYkLlz; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c0e98969-a75e-45a0-803c-1d69bf02623b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730094140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T69UsbBUL523sfFP32uSh2+sUnNKiKJ6dIRsDgjuqrg=;
	b=wwaYkLlza+vQIXMqdX9AdzWvv0ci4ah34dpnpFgKG/gvinM0w7UWqmOIeuxU5HDX4y5hQ6
	TzpMPnjDnZBhoymR5n/GWzjn0p8lO72kZGIf/KL6XaUrS0RqVknNUsV7KkYbV2jFwWywOj
	V04hHDKQkJRmY2WqVs+E8cemAdcswh4=
Date: Sun, 27 Oct 2024 22:42:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] Drop packets with invalid headers to prevent KMSAN
 infoleak
Content-Language: en-GB
To: Daniel Yang <danielyangkang@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)"
 <bpf@vger.kernel.org>,
 "open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
References: <20241019071149.81696-1-danielyangkang@gmail.com>
 <c7d0503b-e20d-4a6d-aecf-2bd7e1c7a450@linux.dev>
 <CAGiJo8R2PhpOitTjdqZ-jbng0Yg=Lxu6L+6FkYuUC1M_d10U2Q@mail.gmail.com>
 <5c8fb835-b0cb-428b-ab07-e20f905eb19f@linux.dev>
 <CAGiJo8RJ+0K-JYtCq4ZLg_4eq7HDkib9iwE-UTnimgEQE8rgtg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAGiJo8RJ+0K-JYtCq4ZLg_4eq7HDkib9iwE-UTnimgEQE8rgtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/27/24 1:49 AM, Daniel Yang wrote:
> On Tue, Oct 22, 2024 at 11:14 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>> On 10/21/24 6:37 PM, Daniel Yang wrote:
>>>> A test in selftests/bpf is needed to reproduce and better understand this.
>>> I don't know much about self tests but I've just been using the syzbot
>>> repro and #syz test at the link in the patch:
>>> https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090. Testing
>>> the patch showed that the uninitialized memory was not getting written
>>> to memory.
>>>
>>>> Only bpf_clone_redirect() is needed to reproduce or other bpf_skb_*() helpers calls
>>>> are needed to reproduce?
>> If only bpf_clone_redirect() is needed, it should be simple to write a selftest
>> to reproduce it. It also helps to catch future regression.
>>
>> Please tag the next respin as "bpf" also.
> I have a problem. I can't seem to build the bpf kselftests for some
> reason. There is always a struct definition error:
> In file included from progs/profiler1.c:5:
> progs/profiler.inc.h:599:49: error: declaration of 'struct
> syscall_trace_enter' will not be visible outside of t]
>    599 | int tracepoint__syscalls__sys_enter_kill(struct
> syscall_trace_enter* ctx)
>        |                                                 ^
> progs/profiler.inc.h:604:15: error: incomplete definition of type
> 'struct syscall_trace_enter'
>    604 |         int pid = ctx->args[0];
>        |                   ~~~^
> progs/profiler.inc.h:599:49: note: forward declaration of 'struct
> syscall_trace_enter'
>    599 | int tracepoint__syscalls__sys_enter_kill(struct
> syscall_trace_enter* ctx)
>        |                                                 ^
> progs/profiler.inc.h:605:15: error: incomplete definition of type
> 'struct syscall_trace_enter'
>    605 |         int sig = ctx->args[1];
>        |                   ~~~^
> progs/profiler.inc.h:599:49: note: forward declaration of 'struct
> syscall_trace_enter'
>    599 | int tracepoint__syscalls__sys_enter_kill(struct
> syscall_trace_enter* ctx)
>
> I just run the following to build:
> $ cd tools/testing/selftests/bpf/
> $ make

It might be due to your .config file.
The 'struct syscall_trace_enter' is defined in kernel/trace/trace.h,
which is used in kernel/trace/trace_syscalls.c. Maybe your config
does not have CONFIG_FTRACE_SYSCALLS?

>
> I can't find anyone else encountering the same error.

