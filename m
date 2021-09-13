Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD4B408305
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 05:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbhIMDCH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Sep 2021 23:02:07 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:38422 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236994AbhIMDCG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 12 Sep 2021 23:02:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Uo7.xPA_1631502047;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0Uo7.xPA_1631502047)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 13 Sep 2021 11:00:49 +0800
Subject: Re: [RFC PATCH] perf: fix panic by mark recursion inside
 perf_log_throttle
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <netdev@vger.kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>
References: <ff979a43-045a-dc56-64d1-2c31dd4db381@linux.alibaba.com>
 <20210910153839.GH4323@worktop.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <f38987a5-dc36-a20d-8c5e-81e8ead5b4dc@linux.alibaba.com>
Date:   Mon, 13 Sep 2021 11:00:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910153839.GH4323@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2021/9/10 下午11:38, Peter Zijlstra wrote:
> On Thu, Sep 09, 2021 at 11:13:21AM +0800, 王贇 wrote:
>> When running with ftrace function enabled, we observed panic
>> as below:
>>
>>   traps: PANIC: double fault, error_code: 0x0
>>   [snip]
>>   RIP: 0010:perf_swevent_get_recursion_context+0x0/0x70
>>   [snip]
>>   Call Trace:
>>    <NMI>
>>    perf_trace_buf_alloc+0x26/0xd0
>>    perf_ftrace_function_call+0x18f/0x2e0
>>    kernelmode_fixup_or_oops+0x5/0x120
>>    __bad_area_nosemaphore+0x1b8/0x280
>>    do_user_addr_fault+0x410/0x920
>>    exc_page_fault+0x92/0x300
>>    asm_exc_page_fault+0x1e/0x30
>>   RIP: 0010:__get_user_nocheck_8+0x6/0x13
>>    perf_callchain_user+0x266/0x2f0
>>    get_perf_callchain+0x194/0x210
>>    perf_callchain+0xa3/0xc0
>>    perf_prepare_sample+0xa5/0xa60
>>    perf_event_output_forward+0x7b/0x1b0
>>    __perf_event_overflow+0x67/0x120
>>    perf_swevent_overflow+0xcb/0x110
>>    perf_swevent_event+0xb0/0xf0
>>    perf_tp_event+0x292/0x410
>>    perf_trace_run_bpf_submit+0x87/0xc0
>>    perf_trace_lock_acquire+0x12b/0x170
>>    lock_acquire+0x1bf/0x2e0
>>    perf_output_begin+0x70/0x4b0
>>    perf_log_throttle+0xe2/0x1a0
>>    perf_event_nmi_handler+0x30/0x50
>>    nmi_handle+0xba/0x2a0
>>    default_do_nmi+0x45/0xf0
>>    exc_nmi+0x155/0x170
>>    end_repeat_nmi+0x16/0x55
> 
> kernel/events/Makefile has:
> 
> ifdef CONFIG_FUNCTION_TRACER
> CFLAGS_REMOVE_core.o = $(CC_FLAGS_FTRACE)
> endif
> 
> Which, afaict, should avoid the above, no?

I'm afraid it's not working for this case, the
start point of tracing is at lock_acquire() which
is not from 'kernel/events/core', the following PF
related function are also not from 'core', prevent
ftrace on 'core' can't prevent this from happen...

Regards,
Michael Wang

> 
