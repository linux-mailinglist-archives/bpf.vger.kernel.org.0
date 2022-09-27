Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB215EB954
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 06:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiI0EuH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 00:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiI0EuG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 00:50:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C7392585;
        Mon, 26 Sep 2022 21:50:02 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mc6WX6QJBzlVx0;
        Tue, 27 Sep 2022 12:45:44 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 12:49:58 +0800
Message-ID: <970a25e4-9b79-9e0c-b338-ed1a934f2770@huawei.com>
Date:   Tue, 27 Sep 2022 12:49:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v2 0/4] Add ftrace direct call for arm64
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Xu Kuohai <xukuohai@huaweicloud.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Florent Revest <revest@chromium.org>,
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
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <YzHk1zRf1Dp8YTEe@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/27/2022 1:43 AM, Mark Rutland wrote:
> On Mon, Sep 26, 2022 at 03:40:20PM +0100, Catalin Marinas wrote:
>> On Thu, Sep 22, 2022 at 08:01:16PM +0200, Daniel Borkmann wrote:
>>> On 9/13/22 6:27 PM, Xu Kuohai wrote:
>>>> This series adds ftrace direct call for arm64, which is required to attach
>>>> bpf trampoline to fentry.
>>>>
>>>> Although there is no agreement on how to support ftrace direct call on arm64,
>>>> no patch has been posted except the one I posted in [1], so this series
>>>> continues the work of [1] with the addition of long jump support. Now ftrace
>>>> direct call works regardless of the distance between the callsite and custom
>>>> trampoline.
>>>>
>>>> [1] https://lore.kernel.org/bpf/20220518131638.3401509-2-xukuohai@huawei.com/
>>>>
>>>> v2:
>>>> - Fix compile and runtime errors caused by ftrace_rec_arch_init
>>>>
>>>> v1: https://lore.kernel.org/bpf/20220913063146.74750-1-xukuohai@huaweicloud.com/
>>>>
>>>> Xu Kuohai (4):
>>>>     ftrace: Allow users to disable ftrace direct call
>>>>     arm64: ftrace: Support long jump for ftrace direct call
>>>>     arm64: ftrace: Add ftrace direct call support
>>>>     ftrace: Fix dead loop caused by direct call in ftrace selftest
>>>
>>> Given there's just a tiny fraction touching BPF JIT and most are around core arm64,
>>> it probably makes sense that this series goes via Catalin/Will through arm64 tree
>>> instead of bpf-next if it looks good to them. Catalin/Will, thoughts (Ack + bpf-next
>>> could work too, but I'd presume this just results in merge conflicts)?
>>
>> I think it makes sense for the series to go via the arm64 tree but I'd
>> like Mark to have a look at the ftrace changes first.
> 
>>From a quick scan, I still don't think this is quite right, and as it stands I
> believe this will break backtracing (as the instructions before the function
> entry point will not be symbolized correctly, getting in the way of
> RELIABLE_STACKTRACE). I think I was insufficiently clear with my earlier
> feedback there, as I have a mechanism in mind that wa a little simpler.
> 

Thanks for the review. I have some thoughts about reliable stacktrace.

If PC is not in the range of literal_call, stacktrace works as before without
changes.

If PC is in the range of literal_call, for example, interrupted by an
irq, I think there are 2 problems:

1. Caller LR is not pushed to the stack yet, so caller's address and name
    will be missing from the backtrace.

2. Since PC is not in func's address range, no symbol name will be found, so
    func name is also missing.

Problem 1 is not introduced by this patchset, but the occurring probability
may be increased by this patchset. I think this problem should be addressed by
a reliable stacktrace scheme, such as ORC on x86.

Problem 2 is indeed introduced by this patchset. I think there are at least 3
ways to deal with it:

1. Add a symbol name for literal_call.

2. Hack the backtrace routine, if no symbol name found for a PC during backtrace,
    we can check if the PC is in literal_call, then adjust PC and try again.

3. Move literal_call to the func's address range, for example:

         a. Compile with -fpatchable-function-entry=7
         func:
                 BTI C
                 NOP
                 NOP
                 NOP
                 NOP
                 NOP
                 NOP
                 NOP
         func_body:
                 ...


         b. When disabled, patch it to
         func:
                 BTI C
                 B func_body
         literal:
                 .quad dummy_tramp
         literal_call:
                 LDR X16, literal
                 MOV X9, LR
                 BLR X16
         func_body:
                 ...


         c. When enabled and target is out-of-range, patch it to
         func:
                 BTI C
                 B literal_call
         literal:
                 .quad custom_trampoline
         literal_call:
                 LDR X16, literal
                 MOV X9, LR
                 BLR X16
         func_body:
                 ...


         d. When enabled and target is in range, patch it to
         func:
                 BTI C
                 B direct_call
         literal:
                 .quad dummy_tramp
                 LDR X16, literal
         direct_call:
                 MOV X9, LR
                 BL custom_trampoline
         func_body:
                 ...


> I'll try to reply with some more detail tomorrow, but I don't think this is the
> right approach, and as mentioned previously (and e.g. at LPC) I'd strongly
> prefer to *not* implement direct calls, so that we can have more consistent
> entry/exit handling.
> 
> Thanks,
> Mark.
> .

