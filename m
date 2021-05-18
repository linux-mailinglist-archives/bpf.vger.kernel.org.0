Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5DA3882F3
	for <lists+bpf@lfdr.de>; Wed, 19 May 2021 01:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhERXGL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 May 2021 19:06:11 -0400
Received: from www62.your-server.de ([213.133.104.62]:49344 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhERXGK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 May 2021 19:06:10 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lj8la-0006Yw-SR; Wed, 19 May 2021 01:04:46 +0200
Received: from [85.7.101.30] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lj8la-000G5z-Nc; Wed, 19 May 2021 01:04:46 +0200
Subject: Re: [PATCH v6 bpf-next 00/21] bpf: syscall program, FD array, loader
 program, light skeleton.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
 <4a843738-4eb1-d993-6b64-7f36144d2456@iogearbox.net>
 <CAADnVQ+1enHX1wgh7yj=2Kh6pScWcnxV_oqz+526Es7N3-FtYA@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bae4b37c-4783-c506-a9d3-a642ba1f7441@iogearbox.net>
Date:   Wed, 19 May 2021 01:04:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+1enHX1wgh7yj=2Kh6pScWcnxV_oqz+526Es7N3-FtYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26174/Tue May 18 13:09:02 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/18/21 11:17 PM, Alexei Starovoitov wrote:
> On Tue, May 18, 2021 at 12:54 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 5/14/21 2:36 AM, Alexei Starovoitov wrote:
>> [...]
>>> This is a first step towards signed bpf programs and the third approach of that kind.
>>> The first approach was to bring libbpf into the kernel as a user-mode-driver.
>>> The second approach was to invent a new file format and let kernel execute
>>> that format as a sequence of syscalls that create maps and load programs.
>>> This third approach is using new type of bpf program instead of inventing file format.
>>> 1st and 2nd approaches had too many downsides comparing to this 3rd and were discarded
>>> after months of work.
>>>
>>> To make it work the following new concepts are introduced:
>>> 1. syscall bpf program type
>>> A kind of bpf program that can do sys_bpf and sys_close syscalls.
>>> It can only execute in user context.
>>>
>>> 2. FD array or FD index.
>>> Traditionally BPF instructions are patched with FDs.
>>> What it means that maps has to be created first and then instructions modified
>>> which breaks signature verification if the program is signed.
>>> Instead of patching each instruction with FD patch it with an index into array of FDs.
>>> That makes the program signature stable if it uses maps.
>>>
>>> 3. loader program that is generated as "strace of libbpf".
>>> When libbpf is loading bpf_file.o it does a bunch of sys_bpf() syscalls to
>>> load BTF, create maps, populate maps and finally load programs.
>>> Instead of actually doing the syscalls generate a trace of what libbpf
>>> would have done and represent it as the "loader program".
>>> The "loader program" consists of single map and single bpf program that
>>> does those syscalls.
>>> Executing such "loader program" via bpf_prog_test_run() command will
>>> replay the sequence of syscalls that libbpf would have done which will result
>>> the same maps created and programs loaded as specified in the elf file.
>>> The "loader program" removes libelf and majority of libbpf dependency from
>>> program loading process.
>>
>> More of a general question since afaik from prior discussion it didn't came up.
>> I think conceptually, it's rather weird to only being able to execute the loader
>> program which is later also supposed to do signing through the BPF_PROG_TEST_RUN
>> aka our _testing_ infrastructure. Given it's not mentioned in future steps, is
>> there anything planned before it becomes uapi and fixed part of skeleton (in
>> particular the libbpf bpf_load_and_run() helper officially calling into the
>> skel_sys_bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr))) on this regard or is the
>> BPF_PROG_TEST_RUN really supposed to be the /main/ interface going forward;
>> what's the plan on this?
> 
> Few things here:
> 1. using TEST_RUN command beyond testing.
> That ship already sailed. The perf using this command to trigger
> prog execution not in a testing environment. See bperf_trigger_reading().
> In the past we agreed not to rename commands whose purpose
> doesn't strictly fit the name any more. Like RAW_TP_OPEN does a lot more
> than just attaching raw_tracepoints.
> TEST_RUN command is also no longer for testing only.
> That's one of the reasons why bpf_load_and_run() helper is
> called such instead of bpf_load_and_test_run().
> It's running the program and not testing it.
> The kernel cmd is unfortunately misnamed.

It definitely is, and from an UAPI pov it just looks super odd to users as in 'what
does the loader have to do with TEST_RUN?!'. I do think this begs a one-time refactor
inside the kernel as well as an exception for alias-mapping that BPF_PROG_TEST_RUN
enum into something more sane (w/ adding an explanation that BPF_PROG_TEST_RUN was
used in the past but it outgrew testing-only), maybe just BPF_PROG_RUN. I generally
agree that we typically shouldn't go for it, but this otherwise looks way too obscure
for something that fundamental.

> The skeleton is not cast in stone.
> Quite the opposite.
> It will change as loader prog will support more features.
> The bpf_load_and_run() helper may change as well.
> That's why it's in skel_internal.h and not part of libbpf api.
> Essentially all C code in skel_internal.h are internal to lskel.
> They are just as good as being auto-generated by bpftool
> during light skeleton creation.
> The bpftool could have emitted skel_internal.h just as well.
> But it's kinda ugly to let it emit the whole .h file that could be
> shared by multiple light skels.
> Since it's a .h file it's not a static or shared library. It's not a .c file.
> It's guaranteed to be compiled into whatever app that is using light skel.
> So there are no backward compat concerns when skel_internal.h
> will inevitably change in next revs of lskel.
> Same thing with struct bpf_map/prog_desc. They are part of skel_internal.h
> and match to what loader prog and lskel gen are doing.
> Not only their layout will change, but depending on bpftool
> cmdline flags that generated lskel might use different bpf_map_desc.
> For example when lskel user needs more or less debuggability from the
> loader prog the generated bpf prog will be different and will use
> different contract between loader prog and auto-generated light skel .h

Ah true, that makes sense. Good we're flexible here. I've pushed the current bits
out to bpf-next thus far & resolved conflicts on libbpf side.

Thanks,
Daniel
