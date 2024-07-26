Return-Path: <bpf+bounces-35695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482593CCCE
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 04:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A301F2199D
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 02:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A508200DB;
	Fri, 26 Jul 2024 02:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUaMeHgT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA1F1BC5C;
	Fri, 26 Jul 2024 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721962655; cv=none; b=TH63DTkOf8C2FjCsGjkm83wbnjdKPKCax2px/A18rb/hWDEV/QnomMVZ6RYBtSEUBIWEZKFixBhYIGRzC3XfGRol96DEfwOAzhDNMkx59KCNvB5bIB6DQrdVWHO+N9IfjzG1HBTcxR6BB5S2Mt1EVgTvyPyDUkxZRg+dXQkqsAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721962655; c=relaxed/simple;
	bh=wGbrG9I+rAfR9fkkLWpgpHgZ3pvqZggaRxdWtH6LKSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bneUSebVCaJLk2Up5cqWwsmyVu7nR/dEX24rpVwoReDrt6Ac98tRfT1l4MVyIjAmJmgv1foPdlZ5wL7zU5srKLTr+kcpJJxmUQa+ynGknD21xCdBqWw0LOk8fqg7WARB92G71Z5y0z1CjCe+AJWgPzZ2zFyXKXI4RnjmJWtozFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUaMeHgT; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so485285b3a.1;
        Thu, 25 Jul 2024 19:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721962653; x=1722567453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7i2ycivzd773ExQsyXmXrnk/g5ZhR9q/rZDF9LqbABA=;
        b=OUaMeHgT01RbNprih2rpcsGLucttnIcbmgVZCU8TP7CRJheH6XKaRd8d6vUUeQsZ5W
         6k3K2cU5+fvlS4CDmhrPvCmJDqsKsyd8f5yKPQXL00R+QJzDOhTbOMMmMdITeeo7d9NE
         BpFrFB2gfmQ3CZ6VZJkgF8lIQvsXyBeQs8kk4Z4C8MbXamK45RKc/yfFBxcbvBWIhKAc
         hj973p9nbsZ40L5pEbvoMLR4TEg+haBmKBl3iMqFD8oRW57VdY+RQVwAL+U2rSbxwnhz
         YPpg5GZCrbW3h2cv91maZq2iaCM/mgwWRQWuMhKkvihLkL1Qf7YRWQuCOgLq0023avOt
         zhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721962653; x=1722567453;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7i2ycivzd773ExQsyXmXrnk/g5ZhR9q/rZDF9LqbABA=;
        b=hkF/9gH41eoSn2sz1vpo8d3hPEUskWgRvqqJXzgsHUdDlDFV2pb4ajm2JE+Ra7ctSZ
         nYzwBjE35WXOSXn2phGFl4p2dPfIebk2ghR5F70cpvfPtKteXy60oVZ21SASg5wPz8ox
         GV7Qj0FNAs7lxsgQtUJkEF9xKuFntlBqwTqbADT+uSI6tFjApqwDRNUzlvySd7zcAFt7
         38GI2ln/lUIdzGRN5PxP1BF5pFOo7lP/HFLqAMOI7EE+e7Pmtq2upJinarHD3NzMD5OH
         36XMbnuA5Ou+4s7FimkX5Y0frgKaajQGz3Cm+TjhHDwETqZpdyzMZQ2b6UsOxKZVerbu
         ZeDw==
X-Forwarded-Encrypted: i=1; AJvYcCUDj3W725okFpIasojPK8xhhciwhSa0dFfS3tAElw4PpPURp7XupQQz9E8fbOQRxFyN+xk1kRf6ndEgF7ahepyGL0ga27Cxmx6B3SLtjPqG4uj6RDpaRDlrS7sJzsEs6gQs
X-Gm-Message-State: AOJu0Yz52JfKEaDfzSBT/aBUORreRU44i7CYQL6tZ79lkeTYQpZjaUnP
	CvPT31fTIV8cO4Zqh2I1uDZ0geGL6JqdVVXE5djcEErMKr1CAtVUkYH1xg==
X-Google-Smtp-Source: AGHT+IGd+moBXLrG7vHdN/TFN7N9o0qz0fyzO6TrdqHAqNqB1M/r3rbR+Qm70yXxm+rpuOel6X4Bdg==
X-Received: by 2002:a05:6a00:3922:b0:70d:3420:9309 with SMTP id d2e1a72fcca58-70eae90800bmr5245353b3a.17.1721962652773;
        Thu, 25 Jul 2024 19:57:32 -0700 (PDT)
Received: from [10.22.68.119] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e1a89sm1790734b3a.30.2024.07.25.19.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 19:57:32 -0700 (PDT)
Message-ID: <0f5b7717-fad3-4c89-bacf-7a11baf7a9df@gmail.com>
Date: Fri, 26 Jul 2024 10:57:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: Add bpf_check_attach_target_with_klog
 method to output failure logs to kernel
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Zheao Li <me@manjusaka.me>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240725051511.57112-1-me@manjusaka.me>
 <08e180da-e841-427d-bed6-3ba8d73e8519@linux.dev>
 <c7952df9-5830-45d3-89bb-b45f2b030e24@gmail.com>
 <6511ce2a-1c7d-497c-aeb6-d4f0b17271ed@linux.dev>
 <2c6b1737-0a96-44ed-afe9-655444121984@gmail.com>
 <CAEf4BzbL0xfdCEYmzfQ4qCWQxKJAK=TwsdS3k=L58AoVyObL3Q@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAEf4BzbL0xfdCEYmzfQ4qCWQxKJAK=TwsdS3k=L58AoVyObL3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/7/24 05:27, Andrii Nakryiko wrote:
> On Thu, Jul 25, 2024 at 12:33 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>>
>> On 25/7/24 14:09, Yonghong Song wrote:
>>>
>>> On 7/24/24 11:05 PM, Leon Hwang wrote:
>>>>
>>>> On 25/7/24 13:54, Yonghong Song wrote:
>>>>> On 7/24/24 10:15 PM, Zheao Li wrote:
>>>>>> This is a v2 patch, previous Link:
>>>>>> https://lore.kernel.org/bpf/20240724152521.20546-1-me@manjusaka.me/T/#u
>>>>>>

[SNI]

>>>>> More importantly, Andrii has implemented retsnoop, which intends to
>>>>> locate
>>>>> precise location in the kernel where err happens. The link is
>>>>>    https://github.com/anakryiko/retsnoop
>>>>>
>>>>> Maybe you want to take a look and see whether it can resolve your issue.
>>>>> We should really avoid putting more stuff in dmesg whenever possible.
>>>>>
>>>> retsnoop is really cool.
>>>>
>>>> However, when something wrong in bpf_check_attach_target(), retsnoop
>>>> only gets its return value -EINVAL, without any bpf_log() in it. It's
>>>> hard to figure out the reason why bpf_check_attach_target() returns
>>>> -EINVAL.
>>>
>>> It should have line number like below in
>>> https://github.com/anakryiko/retsnoop
>>>
>>> |$ sudo ./retsnoop -e '*sys_bpf' -a ':kernel/bpf/*.c' Receiving data...
>>> 20:19:36.372607 -> 20:19:36.372682 TID/PID 8346/8346 (simfail/simfail):
>>> entry_SYSCALL_64_after_hwframe+0x63 (arch/x86/entry/entry_64.S:120:0)
>>> do_syscall_64+0x35 (arch/x86/entry/common.c:80:7) . do_syscall_x64
>>> (arch/x86/entry/common.c:50:12) 73us [-ENOMEM] __x64_sys_bpf+0x1a
>>> (kernel/bpf/syscall.c:5067:1) 70us [-ENOMEM] __sys_bpf+0x38b
>>> (kernel/bpf/syscall.c:4947:9) . map_create (kernel/bpf/syscall.c:1106:8)
>>> . find_and_alloc_map (kernel/bpf/syscall.c:132:5) ! 50us [-ENOMEM]
>>> array_map_alloc !* 2us [NULL] bpf_map_alloc_percpu Could you double
>>> check? It does need corresponding kernel source though. |
>>>
>>
>> I have a try on an Ubuntu 24.04 VM, whose kernel is 6.8.0-39-generic.
>>
>> $ sudo retsnoop -e '*sys_bpf' -a ':kernel/bpf/*.c' -T
>> Receiving data...
>> 07:18:38.643643 -> 07:18:38.643728 TID/PID 6042/6039 (freplace/freplace):
>>
>> FUNCTION CALL TRACE                                   RESULT
>>    DURATION
>> ---------------------------------------------------
>> --------------------  --------
>> → __x64_sys_bpf
>>
>>     → __sys_bpf
>>
>>         ↔ bpf_check_uarg_tail_zero                    [0]
>>     2.376us
>>         → link_create
>>
>>             ↔ __bpf_prog_get
>> [0xffffb55f40db3000]   2.796us
>>             ↔ bpf_prog_attach_check_attach_type       [0]
>>     2.260us
>>             → bpf_tracing_prog_attach
>>
>>                 ↔ __bpf_prog_get
>> [0xffffb55f40d71000]   9.455us
>>                 → bpf_check_attach_target
>>
>>                     → btf_check_type_match
>>
>>                         → btf_check_func_type_match
>>
>>                             ↔ bpf_log                 [void]
>>     2.578us
>>                         ← btf_check_func_type_match   [-EINVAL]
>>     7.659us
>>                     ← btf_check_type_match            [-EINVAL]
>>    15.950us
>>                 ← bpf_check_attach_target             [-EINVAL]
>>    22.397us
>>                 ↔ __bpf_prog_put                      [void]
>>     2.323us
>>             ← bpf_tracing_prog_attach                 [-EINVAL]
>>    45.509us
>>             ↔ __bpf_prog_put                          [void]
>>     2.182us
>>         ← link_create                                 [-EINVAL]
>>    66.445us
>>     ← __sys_bpf                                       [-EINVAL]
>>    77.347us
>> ← __x64_sys_bpf                                       [-EINVAL]
>>    81.979us
>>
>>                     entry_SYSCALL_64_after_hwframe+0x78
>> (arch/x86/entry/entry_64.S:130:0)
>>                     do_syscall_64+0x7f
>> (arch/x86/entry/common.c:83:7)
>>                     . do_syscall_x64
>> (arch/x86/entry/common.c:52:12)
>>                     x64_sys_call+0x1936
>> (arch/x86/entry/syscall_64.c:33:1)
>>     81us [-EINVAL]  __x64_sys_bpf+0x1a
>> (kernel/bpf/syscall.c:5588:1)
>>     77us [-EINVAL]  __sys_bpf+0x4ae
>> (kernel/bpf/syscall.c:5556:9)
>> !   66us [-EINVAL]  link_create
>>
>> !*  45us [-EINVAL]  bpf_tracing_prog_attach
>>
>> !*  22us [-EINVAL]  bpf_check_attach_target
>>
>> !*  15us [-EINVAL]  btf_check_type_match
>>
>> !*   7us [-EINVAL]  btf_check_func_type_match
>>
>> P.S. Check
>> https://gist.github.com/Asphaltt/883fd7362968f7747e820d63a9519971 to
>> have a better view of this output.
>>
>> When attach freplace prog to a static-noline subprog, there is a
>> bpf_log() in btf_check_func_type_match(). However, I don't know what
>> bpf_log() logs.
> 
> If you build the very latest retsnoop from Github (this functionality
> hasn't been released just yet, I added it literally two days ago), you
> will be able to capture bpf_log's format string. vararg arguments
> themselves are not (yet) captured, but I'm going to play with that.
> 
> Try something like this:
> 
> sudo ./retsnoop -e verbose -e bpf_log -e bpf_verifier_vlog -e
> bpf_verifier_log_write -STA -v
> 
> And you might see something like:
> 
> FUNCTION CALLS   RESULT  DURATION  ARGS
> --------------   ------  --------  ----
> ↔ bpf_log        [void]   2.555us  log=&{} fmt='func '%s' arg%d has
> btf_id %d type %s '%s' ' =(vararg)
> 
> or
> 
> FUNCTION CALLS   RESULT  DURATION  ARGS
> --------------   ------  --------  ----
> ↔ bpf_log        [void]   5.729us  log=&{} fmt='arg#%d reference
> type('%s %s') size cannot be determined: %ld ' =(vararg)
> 
> 
> So you'll get a general understanding from format string (but yeah,
> actual arguments would be good to have).
> 

Build and run, sudo ./retsnoop -e verbose -e bpf_log -e
bpf_verifier_vlog -e bpf_verifier_log_write -STA -v, here's the output:


FUNCTION CALLS   RESULT  DURATION  ARGS
--------------   ------  --------  ----
↔ bpf_log        [void]   1.350us  log=NULL fmt='%s() is not a global
function ' =(vararg)

It's great to show arguments.

> 
> This is not really a solution, but definitely useful for debugging.

I try another way with following bpf code:

#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>

SEC("kprobe/bpf_log")
int k_bpf_log(struct pt_regs *ctx)
{
    const char *arg2 = (const char *) PT_REGS_PARM2(ctx);
    void *arg3 = (void *) PT_REGS_PARM3(ctx);
    void *arg4 = (void *) PT_REGS_PARM4(ctx);
    void *arg5 = (void *) PT_REGS_PARM5(ctx);
    char buf[30];

    bpf_probe_read_kernel_str(buf, 30, arg2);
    bpf_trace_printk(buf, 30, arg3, arg4, arg5);

    return BPF_OK;
}

It is able to print the log message:
<...>-6212    [003] ...21  3585.117121: bpf_trace_printk:
stub_handler_static() is not a global function

But it's not generic enough to inspect the log.

> 
> Is there some simple way for me to reproduce your specific issue, I'd
> like to use that as one motivating example to see how far retsnoop can
> be pushed.

Sure, here's my example to reproduce the issue:
https://github.com/Asphaltt/learn-by-example/tree/main/ebpf/freplace,
which relies on Go, clang and llvm-strip.

Reproduce the issue by:

git clone https://github.com/Asphaltt/learn-by-example.git
cd learn-by-example/ebpf/freplace
go generate
go build
./freplace --freplace-failed

Then, it will output something like:
2024/07/26 01:45:43 Failed to freplace(stub_handler_static): create
link: invalid argument

> 
> P.S. I do think that putting any logging like this into dmesg is
> definitely wrong, btw.
> 

Understand.

Is it OK to add a tracepoint here? I think tracepoint is more generic
than retsnoop-like way.

Thanks,
Leon



