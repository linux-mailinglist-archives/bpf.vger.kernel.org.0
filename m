Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCB842A7B0
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 16:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbhJLO4X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 10:56:23 -0400
Received: from www62.your-server.de ([213.133.104.62]:43836 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbhJLO4X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Oct 2021 10:56:23 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1maJAa-000DAb-87; Tue, 12 Oct 2021 16:54:20 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1maJAa-000PNt-2G; Tue, 12 Oct 2021 16:54:20 +0200
Subject: Re: [PATCH bpf-next 08/10] selftests/bpf: demonstrate use of custom
 .rodata/.data sections
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20211008000309.43274-1-andrii@kernel.org>
 <20211008000309.43274-9-andrii@kernel.org>
 <dfde174b-fff5-118b-b6c8-a2d4047ab2c1@iogearbox.net>
 <CAEf4BzYx7Ff6HYqE5mB9Nw84TkpyPrDOz5NSeERD1jpRH6OyWQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2d2260b6-53ae-bcf4-ab41-4b4744a09bd6@iogearbox.net>
Date:   Tue, 12 Oct 2021 16:54:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYx7Ff6HYqE5mB9Nw84TkpyPrDOz5NSeERD1jpRH6OyWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26320/Tue Oct 12 10:17:49 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/12/21 5:47 AM, Andrii Nakryiko wrote:
> On Mon, Oct 11, 2021 at 3:57 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 10/8/21 2:03 AM, andrii.nakryiko@gmail.com wrote:
>>> From: Andrii Nakryiko <andrii@kernel.org>
>>>
>>> Enhance existing selftests to demonstrate the use of custom
>>> .data/.rodata sections.
>>>
>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>
>> Just a thought, but wouldn't the actual demo / use case be better to show that we can
>> now have a __read_mostly attribute which implies SEC(".data.read_mostly") section?
>>
>> Would be nice to add a ...
>>
>>     #define __read_mostly    SEC(".data.read_mostly")
>>
>> ... into tools/lib/bpf/bpf_helpers.h along with the series for use out of BPF programs
>> as I think this should be a rather common use case. Thoughts?
> 
> But what's so special about the ".data.read_mostly" ELF section for
> BPF programs? It's just another data section with no extra semantics.
> So unclear why we need to have a dedicated #define for that?..

I mean semantics are implicit that only vars would be located there which are
by far more read than written to. Placing into separate .data.read_mostly would
help to reduce cache misses due to false sharing e.g. if they are otherwise placed
near vars which are written more often (silly example would be some counter in
the prog).

>>> ---
>>>    .../selftests/bpf/prog_tests/skeleton.c       | 25 +++++++++++++++++++
>>>    .../selftests/bpf/progs/test_skeleton.c       | 10 ++++++++
>>>    2 files changed, 35 insertions(+)
>> [...]
>>> diff --git a/tools/testing/selftests/bpf/progs/test_skeleton.c b/tools/testing/selftests/bpf/progs/test_skeleton.c
>>> index 441fa1c552c8..47a7e76866c4 100644
>>> --- a/tools/testing/selftests/bpf/progs/test_skeleton.c
>>> +++ b/tools/testing/selftests/bpf/progs/test_skeleton.c
>>> @@ -40,9 +40,16 @@ int kern_ver = 0;
>>>
>>>    struct s out5 = {};
>>>
>>> +const volatile int in_dynarr_sz SEC(".rodata.dyn");
>>> +const volatile int in_dynarr[4] SEC(".rodata.dyn") = { -1, -2, -3, -4 };
>>> +
>>> +int out_dynarr[4] SEC(".data.dyn") = { 1, 2, 3, 4 };
>>> +
>>>    SEC("raw_tp/sys_enter")
>>>    int handler(const void *ctx)
>>>    {
>>> +     int i;
>>> +
>>>        out1 = in1;
>>>        out2 = in2;
>>>        out3 = in3;
>>> @@ -53,6 +60,9 @@ int handler(const void *ctx)
>>>        bpf_syscall = CONFIG_BPF_SYSCALL;
>>>        kern_ver = LINUX_KERNEL_VERSION;
>>>
>>> +     for (i = 0; i < in_dynarr_sz; i++)
>>> +             out_dynarr[i] = in_dynarr[i];
>>> +
>>>        return 0;
>>>    }
>>>
>>>
>>
