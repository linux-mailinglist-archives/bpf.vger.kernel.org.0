Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E957587C6F
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 14:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbiHBM2r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 08:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236442AbiHBM2q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 08:28:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8204751408;
        Tue,  2 Aug 2022 05:28:44 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LxvNS5gwYzlVnH;
        Tue,  2 Aug 2022 20:26:00 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 20:28:42 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 2 Aug
 2022 20:28:42 +0800
Message-ID: <e3993e00-9346-9e0d-7490-76ffb713f343@huawei.com>
Date:   Tue, 2 Aug 2022 20:28:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v3] kprobes: Forbid probing on trampoline and bpf prog
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <mhiramat@kernel.org>,
        <peterz@infradead.org>, <mingo@kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>
References: <20220801033719.228248-1-chenzhongjin@huawei.com>
 <Yug6bx7T4GzqUf2a@krava> <20220801165146.26fdeca2@gandalf.local.home>
 <YujpFUB8KlkOgzyb@krava>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <YujpFUB8KlkOgzyb@krava>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2022/8/2 17:06, Jiri Olsa wrote:
> On Mon, Aug 01, 2022 at 04:51:46PM -0400, Steven Rostedt wrote:
>> On Mon, 1 Aug 2022 22:41:19 +0200
>> Jiri Olsa <olsajiri@gmail.com> wrote:
>>
>>> LGTM cc-ing Steven because it affects ftrace as well
>> Thanks for the Cc, but I don't quite see how it affects ftrace.
>>
>> Unless you are just saying how it can affect kprobe_events?
> nope, I just saw the 'ftrace' in changelog ;-)
>
> anyway the patch makes check_kprobe_address_safe to fail
> on ftrace trampoline address.. but not sure you could make
> kprobe on ftrace trampoline before, probably not
>
> jirka

In fact with CONFIG_KPROBE_EVENTS_ON_NOTRACE=y it can happen.

But I think ftrace has no responsibility to promise the address safety 
when this option open.


Best,

Chen

>> -- Steve
>>
>>
>>> jirka
>>>
>>>> v1 -> v2:
>>>> Check core_kernel_text and is_module_text_address rather than
>>>> only kprobe_insn.
>>>> Also fix title and commit message for this. See old patch at [1].
>>>> ---
>>>>   kernel/kprobes.c | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>>>> index f214f8c088ed..80697e5e03e4 100644
>>>> --- a/kernel/kprobes.c
>>>> +++ b/kernel/kprobes.c
>>>> @@ -1560,7 +1560,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
>>>>   	preempt_disable();
>>>>   
>>>>   	/* Ensure it is not in reserved area nor out of text */
>>>> -	if (!kernel_text_address((unsigned long) p->addr) ||
>>>> +	if (!(core_kernel_text((unsigned long) p->addr) ||
>>>> +	    is_module_text_address((unsigned long) p->addr)) ||
>>>>   	    within_kprobe_blacklist((unsigned long) p->addr) ||
>>>>   	    jump_label_text_reserved(p->addr, p->addr) ||
>>>>   	    static_call_text_reserved(p->addr, p->addr) ||
>>>> -- 
>>>> 2.17.1
>>>>    

