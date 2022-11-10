Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAC2623B14
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 05:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiKJE7M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 23:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiKJE7L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 23:59:11 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD0F165A6
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 20:59:08 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so651807pjl.3
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 20:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XusO0JlinNw/fq2i6/nKia7eGrTN0IevFNyt+4YvPQA=;
        b=xYF+JhPfR1W8nnhThZP7aVc0ne8w7/DXH+jxsHwrhl4XP8K37F4e+bITlgTce4Us7I
         WOZrbkBdTuxE+/vzgBLMuun0QVfyHKjukvZpiu4VbvdXnssyhyDScBLdTqqUUoQFFfnf
         NmlMwPxD+vsjMmvsS2o3RkhvQidbchAsLX3MjdpNVHZ/0xooF1dTByiYtOeAR5E1v/GR
         RTLRhVot30r2OCbJiQCUwKEjrGbVoek6z8KoQMajZQoLshAcnKghjCFcyiONiMNXX5TE
         P1yM3y4bguvSD7kVR1gFwNb8zIc8IBkSfMtf2agmyQqrIZ/SRDet3nwmnr2pxZ1P9x1U
         StSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XusO0JlinNw/fq2i6/nKia7eGrTN0IevFNyt+4YvPQA=;
        b=tUD8sNbrXA+0ib/bST0yoeaYFkhm9VefIhNUYDlgMuzMG4SA1oNSS/+RclnFhi0KQb
         Laplblil5Ss0nqdyBDksQ81V/NU0IE6SxcBDI9Lt53ouoeKP01EVQsmaHqFL5pTg6upa
         T7bo2/xMy7o3iA2DINYwQn+tU9jXwco0wXLhSLSL/5BA0NUBymuZSC/S8fdAOhqQJtVI
         fEtpzhPtdGjOHSf0MK7t1Kgp1ESmoPdpiHWtBex9QozOslFunMaVSrTJmkGEy7rkSGvE
         LFFuGCLerM7snXd0Jvu1IbegcSFe/1VUpDvhhyh8uYMI9A3DEYPNyxAGPR5+GYybjurG
         x1NQ==
X-Gm-Message-State: ACrzQf3+GV5t8eXI0timNSFpgiTk4c9+Ausk7vKSnr8ENkVAvmr4Khmc
        fJgP8ISoQ4AZZMPboVJCkFvx3w==
X-Google-Smtp-Source: AMsMyM5nz6CdgSrMjRqzdcV0QA77/PPY2nwow4az34tvxntND5q4keQFCpNu0PncrilrCAmoa+4jUQ==
X-Received: by 2002:a17:90b:378f:b0:213:acf2:13ba with SMTP id mz15-20020a17090b378f00b00213acf213bamr63916080pjb.25.1668056347963;
        Wed, 09 Nov 2022 20:59:07 -0800 (PST)
Received: from [10.251.254.250] ([71.18.255.70])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709027e0900b00187033cc287sm9941947plm.190.2022.11.09.20.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 20:59:07 -0800 (PST)
Message-ID: <e4e74394-de03-cdce-63d7-f94f8e436b1b@bytedance.com>
Date:   Thu, 10 Nov 2022 12:58:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v2 0/4] Add ftrace direct call for arm64
Content-Language: en-US
To:     Florent Revest <revest@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Xu Kuohai <xukuohai@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Xu Kuohai <xukuohai@huaweicloud.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
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
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>
References: <20220913162732.163631-1-xukuohai@huaweicloud.com>
 <f1e14934-dc54-9bf7-501a-89affdb7371e@iogearbox.net>
 <YzG51Jyd5zhvygtK@arm.com> <YzHk1zRf1Dp8YTEe@FVFF77S0Q05N>
 <970a25e4-9b79-9e0c-b338-ed1a934f2770@huawei.com>
 <YzR5WSLux4mmFIXg@FVFF77S0Q05N>
 <2cb606b4-aa8b-e259-cdfd-1bfc61fd7c44@huawei.com>
 <CABRcYmKPchvtkkgWhOJ6o3pHVqTWeenGawHfZ2ug8Akdh6NfnQ@mail.gmail.com>
 <7f34d333-3b2a-aea5-f411-d53be2c46eee@huawei.com>
 <20221005110707.55bd9354@gandalf.local.home>
 <CABRcYmJGY6fp0CtUBYN8BjEDN=r42BPLSBcrxqu491bTRmfm7g@mail.gmail.com>
 <20221005113019.18aeda76@gandalf.local.home>
 <CABRcYmL0bDkgYP3tSwhZYaGUSbsUR3Gq85QCRiUAdXt65czzmg@mail.gmail.com>
 <20221006122922.53802a5c@gandalf.local.home>
 <CABRcYm+d=xY9nBCJo-6JW_=F41g4X32QM9WOPChaOTfs6d6KCA@mail.gmail.com>
 <20221021203158.4464ac19d8b19b6da6a40852@kernel.org>
 <CABRcYmKzwAFr_0NOxeWhXcCiT5wwi_qkm5Czc0C4CVCAs8stFw@mail.gmail.com>
From:   wuqiang <wuqiang.matt@bytedance.com>
In-Reply-To: <CABRcYmKzwAFr_0NOxeWhXcCiT5wwi_qkm5Czc0C4CVCAs8stFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2022/10/22 00:49, Florent Revest wrote:
> On Fri, Oct 21, 2022 at 1:32 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>> On Mon, 17 Oct 2022 19:55:06 +0200
>> Florent Revest <revest@chromium.org> wrote:
>>> Mark finished an implementation of his per-callsite-ops and min-args
>>> branches (meaning that we can now skip the expensive ftrace's saving
>>> of all registers and iteration over all ops if only one is attached)
>>> - https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64-ftrace-call-ops-20221017
>>>
>>> And Masami wrote similar patches to what I had originally done to
>>> fprobe in my branch:
>>> - https://github.com/mhiramat/linux/commits/kprobes/fprobe-update
>>>
>>> So I could rebase my previous "bpf on fprobe" branch on top of these:
>>> (as before, it's just good enough for benchmarking and to give a
>>> general sense of the idea, not for a thorough code review):
>>> - https://github.com/FlorentRevest/linux/commits/fprobe-min-args-3
>>>
>>> And I could run the benchmarks against my rpi4. I have different
>>> baseline numbers as Xu so I ran everything again and tried to keep the
>>> format the same. "indirect call" refers to my branch I just linked and
>>> "direct call" refers to the series this is a reply to (Xu's work)
>>
>> Thanks for sharing the measurement results. Yes, fprobes/rethook
>> implementation is just porting the kretprobes implementation, thus
>> it may not be so optimized.
>>
>> BTW, I remember Wuqiang's patch for kretprobes.
>>
>> https://lore.kernel.org/all/20210830173324.32507-1-wuqiang.matt@bytedance.com/T/#u
> 
> Oh that's a great idea, thanks for pointing it out Masami!
> 
>> This is for the scalability fixing, but may possible to improve
>> the performance a bit. It is not hard to port to the recent kernel.
>> Can you try it too?
> 
> I rebased it on my branch
> https://github.com/FlorentRevest/linux/commits/fprobe-min-args-3
> 
> And I got measurements again. Unfortunately it looks like this does not help :/
> 
> New benchmark results: https://paste.debian.net/1257856/
> New perf report: https://paste.debian.net/1257859/
> 
> The fprobe based approach is still significantly slower than the
> direct call approach.

FYI, a new version was released, basing on ring-array, which brings a 6.96%
increase in throughput of 1-thread case for ARM64.

https://lore.kernel.org/all/20221108071443.258794-1-wuqiang.matt@bytedance.com/

Could you share more details of the test ? I'll give it a try.

>> Anyway, eventually, I would like to remove the current kretprobe
>> based implementation and unify fexit hook with function-graph
>> tracer. It should make more better perfromance on it.
> 
> That makes sense. :) How do you imagine the unified solution ?
> Would both the fgraph and fprobe APIs keep existing but under the hood
> one would be implemented on the other ? (or would one be gone ?) Would
> we replace the rethook freelist with the function graph's per-task
> shadow stacks ? (or the other way around ?))

How about a private pool designate for local cpu ? If the fprobed routine
sticks to the same CPU when returning, the object allocation and reclaim
can go a quick path, that should bring same performance as shadow stack.
Otherwise the return of an object will go a slow path (slow as current
freelist or objpool).

>>> Note that I can't really make sense of the perf report with indirect
>>> calls. it always reports it spent 12% of the time in
>>> rethook_trampoline_handler but I verified with both a WARN in that
>>> function and a breakpoint with a debugger, this function does *not*
>>> get called when running this "bench trig-fentry" benchmark. Also it
>>> wouldn't make sense for fprobe_handler to call it so I'm quite
>>> confused why perf would report this call and such a long time spent
>>> there. Anyone know what I could be missing here ?
> 
> I made slight progress on this. If I put the vmlinux file in the cwd
> where I run perf report, the reports no longer contain references to
> rethook_trampoline_handler. Instead, they have a few
> 0xffff800008xxxxxx addresses under fprobe_handler. (like in the
> pastebin I just linked)
> 
> It's still pretty weird because that range is the vmalloc area on
> arm64 and I don't understand why anything under fprobe_handler would
> execute there. However, I'm also definitely sure that these 12% are
> actually spent getting buffers from the rethook memory pool because if
> I replace rethook_try_get and rethook_recycle calls with the usage of
> a dummy static bss buffer (for the sake of benchmarking the
> "theoretical best case scenario") these weird perf report traces are
> gone and the 12% are saved. https://paste.debian.net/1257862/
> 
> This is why I would be interested in seeing rethook's memory pool
> reimplemented on top of something like
> https://lwn.net/Articles/788923/ If we get closer to the performance
> of the the theoretical best case scenario where getting a blob of
> memory is ~free (and I think it could be the case with a per task
> shadow stack like fgraph's), then a bpf on fprobe implementation would
> start to approach the performances of a direct called trampoline on
> arm64: https://paste.debian.net/1257863/

