Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75F75F56C7
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 16:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJEOy1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 10:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJEOyZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 10:54:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26BE7CB46;
        Wed,  5 Oct 2022 07:54:21 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MjHXv1LldzlVjH;
        Wed,  5 Oct 2022 22:49:51 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 22:54:16 +0800
Message-ID: <7f34d333-3b2a-aea5-f411-d53be2c46eee@huawei.com>
Date:   Wed, 5 Oct 2022 22:54:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v2 0/4] Add ftrace direct call for arm64
Content-Language: en-US
To:     Florent Revest <revest@chromium.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Xu Kuohai <xukuohai@huaweicloud.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20220913162732.163631-1-xukuohai@huaweicloud.com>
 <f1e14934-dc54-9bf7-501a-89affdb7371e@iogearbox.net>
 <YzG51Jyd5zhvygtK@arm.com> <YzHk1zRf1Dp8YTEe@FVFF77S0Q05N>
 <970a25e4-9b79-9e0c-b338-ed1a934f2770@huawei.com>
 <YzR5WSLux4mmFIXg@FVFF77S0Q05N>
 <2cb606b4-aa8b-e259-cdfd-1bfc61fd7c44@huawei.com>
 <CABRcYmKPchvtkkgWhOJ6o3pHVqTWeenGawHfZ2ug8Akdh6NfnQ@mail.gmail.com>
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <CABRcYmKPchvtkkgWhOJ6o3pHVqTWeenGawHfZ2ug8Akdh6NfnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/5/2022 12:06 AM, Florent Revest wrote:
> On Fri, Sep 30, 2022 at 6:07 AM Xu Kuohai <xukuohai@huawei.com> wrote:
>>
>> On 9/29/2022 12:42 AM, Mark Rutland wrote:
>>> On Tue, Sep 27, 2022 at 12:49:58PM +0800, Xu Kuohai wrote:
>>>> On 9/27/2022 1:43 AM, Mark Rutland wrote:
>>>>> On Mon, Sep 26, 2022 at 03:40:20PM +0100, Catalin Marinas wrote:
>>>>>> On Thu, Sep 22, 2022 at 08:01:16PM +0200, Daniel Borkmann wrote:
>>>>>>> On 9/13/22 6:27 PM, Xu Kuohai wrote:
>>>>>>>> This series adds ftrace direct call for arm64, which is required to attach
>>>>>>>> bpf trampoline to fentry.
>>>>>>>>
>>>>>>>> Although there is no agreement on how to support ftrace direct call on arm64,
>>>>>>>> no patch has been posted except the one I posted in [1], so this series
> 
> Hey Xu :) Sorry I wasn't more pro-active about communicating what i
> was experimenting with! A lot of conversations happened off-the-list
> at LPC and LSS so I was playing on the side with the ideas that got
> suggested to me. I start to have a little something to share.
> Hopefully if we work closer together now we can get quicker results.
> 
>>>>>>>> continues the work of [1] with the addition of long jump support. Now ftrace
>>>>>>>> direct call works regardless of the distance between the callsite and custom
>>>>>>>> trampoline.
>>>>>>>>
>>>>>>>> [1] https://lore.kernel.org/bpf/20220518131638.3401509-2-xukuohai@huawei.com/
>>>>>>>>
>>>>>>>> v2:
>>>>>>>> - Fix compile and runtime errors caused by ftrace_rec_arch_init
>>>>>>>>
>>>>>>>> v1: https://lore.kernel.org/bpf/20220913063146.74750-1-xukuohai@huaweicloud.com/
>>>>>>>>
>>>>>>>> Xu Kuohai (4):
>>>>>>>>       ftrace: Allow users to disable ftrace direct call
>>>>>>>>       arm64: ftrace: Support long jump for ftrace direct call
>>>>>>>>       arm64: ftrace: Add ftrace direct call support
>>>>>>>>       ftrace: Fix dead loop caused by direct call in ftrace selftest
>>>>>>>
>>>>>>> Given there's just a tiny fraction touching BPF JIT and most are around core arm64,
>>>>>>> it probably makes sense that this series goes via Catalin/Will through arm64 tree
>>>>>>> instead of bpf-next if it looks good to them. Catalin/Will, thoughts (Ack + bpf-next
>>>>>>> could work too, but I'd presume this just results in merge conflicts)?
>>>>>>
>>>>>> I think it makes sense for the series to go via the arm64 tree but I'd
>>>>>> like Mark to have a look at the ftrace changes first.
>>>>>
>>>>>>   From a quick scan, I still don't think this is quite right, and as it stands I
>>>>> believe this will break backtracing (as the instructions before the function
>>>>> entry point will not be symbolized correctly, getting in the way of
>>>>> RELIABLE_STACKTRACE). I think I was insufficiently clear with my earlier
>>>>> feedback there, as I have a mechanism in mind that wa a little simpler.
>>>>
>>>> Thanks for the review. I have some thoughts about reliable stacktrace.
>>>>
>>>> If PC is not in the range of literal_call, stacktrace works as before without
>>>> changes.
>>>>
>>>> If PC is in the range of literal_call, for example, interrupted by an
>>>> irq, I think there are 2 problems:
>>>>
>>>> 1. Caller LR is not pushed to the stack yet, so caller's address and name
>>>>      will be missing from the backtrace.
>>>>
>>>> 2. Since PC is not in func's address range, no symbol name will be found, so
>>>>      func name is also missing.
>>>>
>>>> Problem 1 is not introduced by this patchset, but the occurring probability
>>>> may be increased by this patchset. I think this problem should be addressed by
>>>> a reliable stacktrace scheme, such as ORC on x86.
>>>
>>> I agree problem 1 is not introduced by this patch set; I have plans fo how to
>>> address that for reliable stacktrace based on identifying the ftrace
>>> trampoline. This is one of the reasons I do not want direct calls, as
>>> identifying all direct call trampolines is going to be very painful and slow,
>>> whereas identifying a statically allocated ftrace trampoline is far simpler.
>>>
>>>> Problem 2 is indeed introduced by this patchset. I think there are at least 3
>>>> ways to deal with it:
>>>
>>> What I would like to do here, as mentioned previously in other threads, is to
>>> avoid direct calls, and implement "FTRACE_WITH_OPS", where we can associate
>>> each patch-site with a specific set of ops, and invoke that directly from the
>>> regular ftrace trampoline.
>>>
>>> With that, the patch site would look like:
>>>
>>>        pre_func_literal:
>>>                NOP             // Patched to a pointer to
>>>                NOP             // ftrace_ops
>>>        func:
>>>                < optional BTI here >
>>>                NOP             // Patched to MOV X9, LR
>>>                NOP             // Patched to a BL to the ftrace trampoline
>>>
>>> ... then in the ftrace trampoline we can recover the ops pointer at a negative
>>> offset from the LR based on the LR, and invoke the ops from there (passing a
>>> struct ftrace_regs with the saved regs).
>>>
>>> That way the patch-site is less significantly affected, and there's no impact
>>> to backtracing. That gets most of the benefit of the direct calls avoiding the
>>> ftrace ops list traversal, without having to do anything special at all. That
>>> should be much easier to maintain, too.
>>>
>>> I started implementing that before LPC (and you can find some branches on my
>>> kernel.org repo), but I haven't yet had the time to rebase those and sort out
>>> the remaining issues:
>>>
>>>     https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/ftrace/per-callsite-ops
>>>
>>
>> I've read this code before, but it doesn't run and since you haven't updated
> 
> I also tried to use this but indeed the "TODO: mess with protection to
> set this" in  5437aa788d needs to be addressed before we can use it.
> 
>> it, I assumed you dropped it :(
>>
>> This approach seems appropriate for dynamic ftrace trampolines, but I think
>> there are two more issues for bpf.
>>
>> 1. bpf trampoline was designed to be called directly from fentry (located in
>>      kernel function or bpf prog). So to make it work as ftrace_op, we may end
>>      up with two different bpf trampoline types on arm64, one for bpf prog and
>>      the other for ftrace.
>>
>> 2. Performance overhead, as we always jump to a static ftrace trampoline to
>>      construct execution environment for bpf trampoline, then jump to the bpf
>>      trampoline to construct execution environment for bpf prog, then jump to
>>      the bpf prog, so for some small bpf progs or hot functions, the calling
>>      overhead may be unacceptable.
> 
>>From the conversations I've had at LPC, Steven, Mark, Jiri and Masami
> (all in CC) would like to see an ftrace ops based solution (or rather,
> something that doesn't require direct calls) for invoking BPF tracing
> programs. I figured that the best way to move forward on the question
> of whether the performance impact of that would be acceptable or not
> is to just build it and measure it. I understand you're testing your
> work on real hardware (I work on an emulator at the moment) , would
> you be able to compare the impact of my proof of concept branch with
> your direct call based approach ?
> 
> https://github.com/FlorentRevest/linux/commits/fprobe-min-args
>

Tested on my pi4, here is the result.

1. test with dd

1.1 when no bpf prog attached to vfs_write

# dd if=/dev/zero of=/dev/null count=1000000
1000000+0 records in
1000000+0 records out
512000000 bytes (512 MB, 488 MiB) copied, 1.56858 s, 326 MB/s


1.2 attach bpf prog with kprobe, bpftrace -e 'kprobe:vfs_write {}'

# dd if=/dev/zero of=/dev/null count=1000000
1000000+0 records in
1000000+0 records out
512000000 bytes (512 MB, 488 MiB) copied, 2.33439 s, 219 MB/s


1.3 attach bpf prog with with direct call, bpftrace -e 'kfunc:vfs_write {}'

# dd if=/dev/zero of=/dev/null count=1000000
1000000+0 records in
1000000+0 records out
512000000 bytes (512 MB, 488 MiB) copied, 1.72973 s, 296 MB/s


1.4 attach bpf prog with with indirect call, bpftrace -e 'kfunc:vfs_write {}'

# dd if=/dev/zero of=/dev/null count=1000000
1000000+0 records in
1000000+0 records out
512000000 bytes (512 MB, 488 MiB) copied, 1.99179 s, 257 MB/s


2. test with bpf/bench

2.1 bench trig-base
Iter   0 ( 65.259us): hits    1.774M/s (  1.774M/prod), drops    0.000M/s, total operations    1.774M/s
Iter   1 (-17.075us): hits    1.790M/s (  1.790M/prod), drops    0.000M/s, total operations    1.790M/s
Iter   2 (  0.388us): hits    1.790M/s (  1.790M/prod), drops    0.000M/s, total operations    1.790M/s
Iter   3 ( -1.759us): hits    1.790M/s (  1.790M/prod), drops    0.000M/s, total operations    1.790M/s
Iter   4 (  1.980us): hits    1.790M/s (  1.790M/prod), drops    0.000M/s, total operations    1.790M/s
Iter   5 ( -2.222us): hits    1.790M/s (  1.790M/prod), drops    0.000M/s, total operations    1.790M/s
Iter   6 (  0.869us): hits    1.790M/s (  1.790M/prod), drops    0.000M/s, total operations    1.790M/s
Summary: hits    1.790 ± 0.000M/s (  1.790M/prod), drops    0.000 ± 0.000M/s, total operations    1.790 ± 0.000M/s

2.2 bench trig-kprobe
Iter   0 ( 50.703us): hits    0.765M/s (  0.765M/prod), drops    0.000M/s, total operations    0.765M/s
Iter   1 (-15.056us): hits    0.771M/s (  0.771M/prod), drops    0.000M/s, total operations    0.771M/s
Iter   2 (  2.981us): hits    0.771M/s (  0.771M/prod), drops    0.000M/s, total operations    0.771M/s
Iter   3 ( -3.834us): hits    0.771M/s (  0.771M/prod), drops    0.000M/s, total operations    0.771M/s
Iter   4 ( -1.964us): hits    0.771M/s (  0.771M/prod), drops    0.000M/s, total operations    0.771M/s
Iter   5 (  0.426us): hits    0.770M/s (  0.770M/prod), drops    0.000M/s, total operations    0.770M/s
Iter   6 ( -1.297us): hits    0.771M/s (  0.771M/prod), drops    0.000M/s, total operations    0.771M/s
Summary: hits    0.771 ± 0.000M/s (  0.771M/prod), drops    0.000 ± 0.000M/s, total operations    0.771 ± 0.000M/s

2.2 bench trig-fentry, with direct call
Iter   0 ( 49.981us): hits    1.357M/s (  1.357M/prod), drops    0.000M/s, total operations    1.357M/s
Iter   1 (  2.184us): hits    1.363M/s (  1.363M/prod), drops    0.000M/s, total operations    1.363M/s
Iter   2 (-14.167us): hits    1.358M/s (  1.358M/prod), drops    0.000M/s, total operations    1.358M/s
Iter   3 ( -4.890us): hits    1.362M/s (  1.362M/prod), drops    0.000M/s, total operations    1.362M/s
Iter   4 (  5.759us): hits    1.362M/s (  1.362M/prod), drops    0.000M/s, total operations    1.362M/s
Iter   5 ( -4.389us): hits    1.362M/s (  1.362M/prod), drops    0.000M/s, total operations    1.362M/s
Iter   6 ( -0.594us): hits    1.364M/s (  1.364M/prod), drops    0.000M/s, total operations    1.364M/s
Summary: hits    1.362 ± 0.002M/s (  1.362M/prod), drops    0.000 ± 0.000M/s, total operations    1.362 ± 0.002M/s

2.3 bench trig-fentry, with indirect call
Iter   0 ( 49.148us): hits    1.014M/s (  1.014M/prod), drops    0.000M/s, total operations    1.014M/s
Iter   1 (-13.816us): hits    1.021M/s (  1.021M/prod), drops    0.000M/s, total operations    1.021M/s
Iter   2 (  0.648us): hits    1.021M/s (  1.021M/prod), drops    0.000M/s, total operations    1.021M/s
Iter   3 (  3.370us): hits    1.021M/s (  1.021M/prod), drops    0.000M/s, total operations    1.021M/s
Iter   4 ( 11.388us): hits    1.021M/s (  1.021M/prod), drops    0.000M/s, total operations    1.021M/s
Iter   5 (-17.242us): hits    1.022M/s (  1.022M/prod), drops    0.000M/s, total operations    1.022M/s
Iter   6 (  1.815us): hits    1.021M/s (  1.021M/prod), drops    0.000M/s, total operations    1.021M/s
Summary: hits    1.021 ± 0.000M/s (  1.021M/prod), drops    0.000 ± 0.000M/s, total operations    1.021 ± 0.000M/s

> I first tried to implement this as an ftrace op myself but realized I
> was re-implementing a lot of the function graph tracer. So I then
> tried to use the function graph tracer API but realized I was missing
> some features which Steven had addressed in an RFC few years back. So
> I rebuilt on that until I realized Masami has been upstreaming the
> fprobe and rethook APIs as spiritual successors of Steven's RFC... So
> I've now rebuilt yet another proof of concept based on fprobe and
> rethook.
> 
> That branch is still very much WIP and there are a few things I'd like
> to address before sending even an RFC (when kretprobe is built on
> rethook for example, I construct pt_regs on the stack in which I copy
> the content of ftrace_regs... or program linking/unlinking is racy
> right now) but I think it's good enough for performance measurements
> already. (fentry_fexit and lsm tests pass)
> 
>>> Note that as a prerequisite for that I also want to reduce the set of registers
>>> we save/restore down to the set required by our calling convention, as the
>>> existing pt_regs is both large and generally unsound (since we can not and do
>>> not fill in many of the fields we only acquire at an exception boundary).
>>> That'll further reduce the ftrace overhead generally, and remove the needs for
>>> the two trampolines we currently have. I have a WIP at:
>>>
>>>     https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/ftrace/minimal-regs
> 
> Note that I integrated this work to my branch too. I extended it to
> also have fprobe and rethook save and pass ftrace_regs structures to
> their callbacks. Most performance improvements would come from your
> arm64/ftrace/per-callsite-ops branch but we'd need to fix the above
> TODO for it to work.
> 
>>> I intend to get back to both of those shortly (along with some related bits for
>>> kretprobes and stacktracing); I just haven't had much time recently due to
>>> other work and illness.
>>>
>>
>> Sorry for that, hope you getting better soon.
> 
> Oh, that sucks. Get better Mark!
> .

