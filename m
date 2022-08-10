Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A272558E86F
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 10:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiHJIKc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 04:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiHJIKb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 04:10:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA220422C1;
        Wed, 10 Aug 2022 01:10:28 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M2jGW6VKgzfZ4q;
        Wed, 10 Aug 2022 16:07:31 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 10 Aug 2022 16:10:23 +0800
Message-ID: <e8c82119-e443-2557-a7e9-bf6a5d5a7ea9@huawei.com>
Date:   Wed, 10 Aug 2022 16:10:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v5 1/6] arm64: ftrace: Add ftrace direct call
 support
Content-Language: en-US
To:     Florent Revest <revest@chromium.org>
CC:     Mark Rutland <mark.rutland@arm.com>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Steven Price <steven.price@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Mark Brown <broonie@kernel.org>,
        Delyan Kratunov <delyank@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <liwei391@huawei.com>
References: <Yo4xb2w+FHhUtJNw@FVFF77S0Q05N>
 <0f8fe661-c450-ccd8-761f-dbfff449c533@huawei.com>
 <Yo9REdx3nsgbZunE@FVFF77S0Q05N>
 <40fda0b0-0efc-ea1b-96d5-e51a4d1593dd@huawei.com>
 <Yp4s7eNGvb2CNtPp@FVFF77S0Q05N.cambridge.arm.com>
 <55c1b9d6-1d53-9752-fb03-00f60ed15db7@huawei.com>
 <CABRcYmKEn7eajowROwZKerngf0eo0jddNzYgFp82tAqgu0BAxg@mail.gmail.com>
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <CABRcYmKEn7eajowROwZKerngf0eo0jddNzYgFp82tAqgu0BAxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/10/2022 1:03 AM, Florent Revest wrote:
> On Thu, Jun 9, 2022 at 6:27 AM Xu Kuohai <xukuohai@huawei.com> wrote:
>> On 6/7/2022 12:35 AM, Mark Rutland wrote:
>>> On Thu, May 26, 2022 at 10:48:05PM +0800, Xu Kuohai wrote:
>>>> On 5/26/2022 6:06 PM, Mark Rutland wrote:
>>>>> On Thu, May 26, 2022 at 05:45:03PM +0800, Xu Kuohai wrote:
>>>>>> On 5/25/2022 9:38 PM, Mark Rutland wrote:
>>>>>>> On Wed, May 18, 2022 at 09:16:33AM -0400, Xu Kuohai wrote:
>>>>>>>> As noted in that thread, I have a few concerns which equally apply here:
>>>>>>>
>>>>>>> * Due to the limited range of BL instructions, it's not always possible to
>>>>>>>    patch an ftrace call-site to branch to an arbitrary trampoline. The way this
>>>>>>>    works for ftrace today relies upon knowingthe set of trampolines at
>>>>>>>    compile-time, and allocating module PLTs for those, and that approach cannot
>>>>>>>    work reliably for dynanically allocated trampolines.
>>>>>>
>>>>>> Currently patch 5 returns -ENOTSUPP when long jump is detected, so no
>>>>>> bpf trampoline is constructed for out of range patch-site:
>>>>>>
>>>>>> if (is_long_jump(orig_call, image))
>>>>>>     return -ENOTSUPP;
>>>>>
>>>>> Sure, my point is that in practice that means that (from the user's PoV) this
>>>>> may randomly fail to work, and I'd like something that we can ensure works
>>>>> consistently.
>>>>>
>>>>
>>>> OK, should I suspend this work until you finish refactoring ftrace?
>>>
>>> Yes; I'd appreciate if we could hold on this for a bit.
>>>
>>> I think with some ground work we can avoid most of the painful edge cases and
>>> might be able to avoid the need for custom trampolines.
>>>
>>
>> I'v read your WIP code, but unfortunately I didn't find any mechanism to
>> replace bpf trampoline in your code, sorry.
>>
>> It looks like bpf trampoline and ftrace works can be done at the same
>> time. I think for now we can just attach bpf trampoline to bpf prog.
>> Once your ftrace work is done, we can add support for attaching bpf
>> trampoline to regular kernel function. Is this OK?
> 
> Hey Mark and Xu! :)
> 
> I'm interested in this feature too and would be happy to help.
> 
> I've been trying to understand what you both have in mind to figure out a way
> forward, please correct me if I got anything wrong! :)
> 
> 
> It looks like, currently, there are three places where an indirection to BPF is
> technically possible. Chronologically these are:
> 
> - the function's patchsite (currently there are 2 nops, this could become 4
>    nops with Mark's series on per call-site ops)
> 
> - the ftrace ops (currently called by iterating over a global list but could be
>    called more directly with Mark's series on per-call-site ops or by
>    dynamically generated branches with Wang's series on dynamic trampolines)
> 
> - a ftrace trampoline tail call (currently, this is after restoring a full
>    pt_regs but this could become an args only restoration with Mark's series on
>    DYNAMIC_FTRACE_WITH_ARGS)
> 
> 
> If we first consider the situation when only a BPF program is attached to a
> kernel function:
> - Using the patchsite for indirection (proposed by Xu, same as on x86)
>     Pros:
>     - We have BPF trampolines anyway because they are required for orthogonal
>       features such as calling BPF programs as functions, so jumping into that
>       existing JITed code is straightforward
>     - This has the minimum overhead (eg: these trampolines only save the actual
>       number of args used by the function in ctx and avoid indirect calls)
>     Cons:
>     - If the BPF trampoline is JITed outside BL's limits, attachment can
>       randomly fail
> 
> - Using a ftrace op for indirection (proposed by Mark)
>    Pros:
>    - BPF doesn't need to care about BL's range, ftrace_caller will be in range
>    Cons:
>    - The ftrace trampoline would first save all args in an ftrace_regs only for
>      the BPF op to then re-save them in a BPF ctx array (as per BPF calling
>      convention) so we'd effectively have to do the work of saving args twice
>    - BPF currently uses DYNAMIC_FTRACE_WITH_DIRECT_CALLS APIs. Either arm64
>      should implement DIRECT_CALLS with... an indirect call :) (that is, the
>      arch_ftrace_set_direct_caller op would turn back its ftrace_regs into
>      arguments for the BPF trampoline) or BPF would need to use a different
>      ftrace API just on arm64 (to define new ops, which, unless if they would be
>      dynamically JITed, wouldn't be as performant as the existing BPF
>      trampolines)
> 
> - Using a ftrace trampoline tail call for indirection (not discussed yet iiuc)
>    Pros:
>    - BPF also doesn't need to care about BL's range
>    - This also leverages the existing BPF trampolines
>    Cons:
>    - This also does the work of saving/restoring arguments twice
>    - DYNAMIC_FTRACE_WITH_DIRECT_CALLS depends on DYNAMIC_FTRACE_WITH_REGS now
>      although in practice the registers kept by DYNAMIC_FTRACE_WITH_ARGS
>      should be enough to call BPF trampolines
> 
> If we consider the situation when both ftrace ops and BPF programs are attached
> to a kernel function:
> - Using the patchsite for indirection can't solve this
> 
> - Using a ftrace op for indirection (proposed by Mark) or using a ftrace
>    trampoline tail call as an indirection (proposed by Xu, same as on x86) have
>    the same pros & cons as in the BPF only situation except that this time we
>    pay the cost of registers saving twice for good reasons (we need args in both
>    ftrace_regs and the BPF ctx array formats anyway)
> 
> 
> Unless I'm missing something, it sounds like the following approach would work:
> - Always patch patchsites with calls to ftrace trampolines (within BL ranges)
> - Always go through ops and have arch_ftrace_set_direct_caller set
>    ftrace_regs->direct_call (instead of pt_regs->orig_x0 in this patch)
> - If ftrace_regs->direct_call != 0 at the end of the ftrace trampoline, tail
>    call it
> 
> Once Mark's series on DYNAMIC_FTRACE_WITH_ARGS is merged, we would need to have
> DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>    depend on DYNAMIC_FTRACE_WITH_REGS || DYNAMIC_FTRACE_WITH_ARGS
> BPF trampolines (the only users of this API now) only care about args to the
> attachment point anyway so I think this would work transparently ?
> 
> Once Mark's series on per-callsite ops is merged, the second step (going
> through ops) would be significantly faster in the situation where only one
> program is used, therefore one arch_ftrace_set_direct_caller op.
> 
> Once Wang's series on dynamic trampolines is merged, the second step (going
> through ops) would also be significantly faster in the case when multiple ops
> are attached.
> 
> 
> What are your thoughts? If this sounds somewhat sane, I'm happy to help out
> with the implementation as well :)
> 

Hi Florent,

I'm struggling with how to attach bpf trampoline to regular kernel functions. I
think your suggestion is fine. Thanks for the help!

> Thanks!
> Florent
> .

