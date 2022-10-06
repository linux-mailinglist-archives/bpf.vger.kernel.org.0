Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D586D5F6425
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 12:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiJFKJw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 06:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiJFKJv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 06:09:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85031BC0E;
        Thu,  6 Oct 2022 03:09:48 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MjnB64ZwCzlXKL;
        Thu,  6 Oct 2022 18:05:18 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 18:09:44 +0800
Message-ID: <fb3973b6-c65e-fb98-7cdf-46c8a4cf0c4d@huawei.com>
Date:   Thu, 6 Oct 2022 18:09:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v2 0/4] Add ftrace direct call for arm64
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
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
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
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
From:   Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <20221005113019.18aeda76@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 10/5/2022 11:30 PM, Steven Rostedt wrote:
> On Wed, 5 Oct 2022 17:10:33 +0200
> Florent Revest <revest@chromium.org> wrote:
> 
>> On Wed, Oct 5, 2022 at 5:07 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>>>
>>> On Wed, 5 Oct 2022 22:54:15 +0800
>>> Xu Kuohai <xukuohai@huawei.com> wrote:
>>>   
>>>> 1.3 attach bpf prog with with direct call, bpftrace -e 'kfunc:vfs_write {}'
>>>>
>>>> # dd if=/dev/zero of=/dev/null count=1000000
>>>> 1000000+0 records in
>>>> 1000000+0 records out
>>>> 512000000 bytes (512 MB, 488 MiB) copied, 1.72973 s, 296 MB/s
>>>>
>>>>
>>>> 1.4 attach bpf prog with with indirect call, bpftrace -e 'kfunc:vfs_write {}'
>>>>
>>>> # dd if=/dev/zero of=/dev/null count=1000000
>>>> 1000000+0 records in
>>>> 1000000+0 records out
>>>> 512000000 bytes (512 MB, 488 MiB) copied, 1.99179 s, 257 MB/s
>>
>> Thanks for the measurements Xu!
>>
>>> Can you show the implementation of the indirect call you used?
>>
>> Xu used my development branch here
>> https://github.com/FlorentRevest/linux/commits/fprobe-min-args
> 
> That looks like it could be optimized quite a bit too.
> 
> Specifically this part:
> 
> static bool bpf_fprobe_entry(struct fprobe *fp, unsigned long ip, struct ftrace_regs *regs, void *private)
> {
> 	struct bpf_fprobe_call_context *call_ctx = private;
> 	struct bpf_fprobe_context *fprobe_ctx = fp->ops.private;
> 	struct bpf_tramp_links *links = fprobe_ctx->links;
> 	struct bpf_tramp_links *fentry = &links[BPF_TRAMP_FENTRY];
> 	struct bpf_tramp_links *fmod_ret = &links[BPF_TRAMP_MODIFY_RETURN];
> 	struct bpf_tramp_links *fexit = &links[BPF_TRAMP_FEXIT];
> 	int i, ret;
> 
> 	memset(&call_ctx->ctx, 0, sizeof(call_ctx->ctx));
> 	call_ctx->ip = ip;
> 	for (i = 0; i < fprobe_ctx->nr_args; i++)
> 		call_ctx->args[i] = ftrace_regs_get_argument(regs, i);
> 
> 	for (i = 0; i < fentry->nr_links; i++)
> 		call_bpf_prog(fentry->links[i], &call_ctx->ctx, call_ctx->args);
> 
> 	call_ctx->args[fprobe_ctx->nr_args] = 0;
> 	for (i = 0; i < fmod_ret->nr_links; i++) {
> 		ret = call_bpf_prog(fmod_ret->links[i], &call_ctx->ctx,
> 				      call_ctx->args);
> 
> 		if (ret) {
> 			ftrace_regs_set_return_value(regs, ret);
> 			ftrace_override_function_with_return(regs);
> 
> 			bpf_fprobe_exit(fp, ip, regs, private);
> 			return false;
> 		}
> 	}
> 
> 	return fexit->nr_links;
> }
> 
> There's a lot of low hanging fruit to speed up there. I wouldn't be too
> fast to throw out this solution if it hasn't had the care that direct calls
> have had to speed that up.
> 
> For example, trampolines currently only allow to attach to functions with 6
> parameters or less (3 on x86_32). You could make 7 specific callbacks, with
> zero to 6 parameters, and unroll the argument loop.
> 
> Would also be interesting to run perf to see where the overhead is. There
> may be other locations to work on to make it almost as fast as direct
> callers without the other baggage.
> 

There is something wrong with my pi4 perf, I'll send the perf report after
I fix it.

> -- Steve
> 
>>
>> As it stands, the performance impact of the fprobe based
>> implementation would be too high for us. I wonder how much Mark's idea
>> here https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/ftrace/per-callsite-ops
>> would help but it doesn't work right now.
> 
> 
> .

