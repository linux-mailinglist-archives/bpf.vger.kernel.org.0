Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2B66CF3EF
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 22:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjC2UAL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 16:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjC2T76 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 15:59:58 -0400
Received: from out-57.mta1.migadu.com (out-57.mta1.migadu.com [IPv6:2001:41d0:203:375::39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D06C4200
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 12:59:44 -0700 (PDT)
Message-ID: <2b5b56bb-7160-41ac-1fb8-4dbc6ad67d9f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680119982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Os+7RuK6ZGlp2yPj88onJbVaQh82EMG9UaZrfYwztNk=;
        b=XzvY4uyxsMcy33DnglOxzLvJyok6ek7VwhCperNZx7xQbwpACtalon3BOrVA/1v4AGBXsu
        1zu5haaqVljVlDLu1DI4CwqYZ+X9uhWlUPQQ4nYgu/XhgdVJ3j2v94Vy4tCALIuiYP9AQ0
        4+vd/VrooeXEvvRRF1TfcfbZLp9K+K4=
Date:   Wed, 29 Mar 2023 12:59:38 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 5/5] selftests/bpf: Add bench for task storage
 creation
Content-Language: en-US
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        David Faust <david.faust@oracle.com>
References: <20230322215246.1675516-1-martin.lau@linux.dev>
 <20230322215246.1675516-6-martin.lau@linux.dev>
 <CADvTj4rP3kPODxARVTEs2HsNFOof-BZtr8OsEKdjgcGVOTqKaA@mail.gmail.com>
 <456bcd47-efa2-7e3d-78c0-5f41ecba477c@linux.dev>
 <CADvTj4ouGHvPHEgZobUewY2ZjHZhTzJ96oCBAV8VO2xT2bPC0Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CADvTj4ouGHvPHEgZobUewY2ZjHZhTzJ96oCBAV8VO2xT2bPC0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/29/23 12:12 PM, James Hilliard wrote:
> On Wed, Mar 29, 2023 at 11:03 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 3/27/23 8:51 PM, James Hilliard wrote:
>>>> diff --git a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
>>>> index 2814bab54d28..7c851c9d5e47 100644
>>>> --- a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
>>>> +++ b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
>>>> @@ -22,6 +22,13 @@ struct {
>>>>           __type(value, struct storage);
>>>>    } sk_storage_map SEC(".maps");
>>>>
>>>> +struct {
>>>> +       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
>>>> +       __uint(map_flags, BPF_F_NO_PREALLOC);
>>>> +       __type(key, int);
>>>> +       __type(value, struct storage);
>>>> +} task_storage_map SEC(".maps");
>>>> +
>>>>    SEC("raw_tp/kmalloc")
>>>>    int BPF_PROG(kmalloc, unsigned long call_site, const void *ptr,
>>>>                size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags,
>>>> @@ -32,6 +39,24 @@ int BPF_PROG(kmalloc, unsigned long call_site, const void *ptr,
>>>>           return 0;
>>>>    }
>>>>
>>>> +SEC("tp_btf/sched_process_fork")
>>>> +int BPF_PROG(fork, struct task_struct *parent, struct task_struct *child)
>>>
>>> Apparently fork is a built-in function in bpf-gcc:
>>
>> It is also failing in a plain C program
>>
>> #>  gcc -Werror=builtin-declaration-mismatch -o test test.c
>> test.c:14:35: error: conflicting types for built-in function ‘fork’; expected
>> ‘int(void)’ [-Werror=builtin-declaration-mismatch]
>>      14 | int __attribute__((__noinline__)) fork(long x, long y)
>>         |                                   ^~~~
>> cc1: some warnings being treated as errors
>>
>> #> clang -o test test.c
>> succeed
>>
>> I am not too attached to the name but it seems something should be addressed in
>> the gcc instead.
> 
> Hmm, so it looks like it's marked as a builtin here:
> https://github.com/gcc-mirror/gcc/blob/releases/gcc-12.1.0/gcc/builtins.def#L875
> 
> The macro for that is here:
> https://github.com/gcc-mirror/gcc/blob/releases/gcc-12.1.0/gcc/builtins.def#L104-L111
> 
> Which has this comment:
> /* Like DEF_LIB_BUILTIN, except that the function is not one that is
> specified by ANSI/ISO C. So, when we're being fully conformant we
> ignore the version of these builtins that does not begin with
> __builtin. */
> 
> Looks like this builtin was originally added here:
> https://github.com/gcc-mirror/gcc/commit/d1c38823924506d389ca58d02926ace21bdf82fa
> 
> Based on this issue it looks like fork is treated as a builtin for
> libgcov support:
> https://gcc.gnu.org/bugzilla//show_bug.cgi?id=82457
> 
> So from my understanding fork is a gcc builtin when building with -std=gnu11
> but is not a builtin when building with -std=c11.

That sounds like there is a knob to turn this behavior on and off. Do the same 
for the bpf target?

> 
> So it looks like fork is translated to __gcov_fork when -std=gnu* is set which
> is why we get this error.
> 
> As this appears to be intended behavior for gcc I think the best option is
> to just rename the function so that we don't run into issues when building
> with gnu extensions like -std=gnu11.

Is it sure 'fork' is the only culprit? If not, it is better to address it 
properly because this unnecessary name change is annoying when switching bpf 
prog from clang to gcc. Like changing the name in this .c here has to make 
another change to the .c in the prog_tests/ directory.

> 
>>
>>>
>>> In file included from progs/bench_local_storage_create.c:6:
>>> progs/bench_local_storage_create.c:43:14: error: conflicting types for
>>> built-in function 'fork'; expected 'int(void)'
>>> [-Werror=builtin-declaration-mismatch]
>>>      43 | int BPF_PROG(fork, struct task_struct *parent, struct
>>> task_struct *child)
>>>         |              ^~~~
>>>
>>> I haven't been able to find this documented anywhere however.
>>

