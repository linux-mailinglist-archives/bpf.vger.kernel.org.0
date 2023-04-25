Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D506EE788
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 20:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjDYSbg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 14:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbjDYSbf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 14:31:35 -0400
Received: from out-59.mta0.migadu.com (out-59.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502BB161A1
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 11:31:33 -0700 (PDT)
Message-ID: <4d5e33ff-9e0a-aa2b-0482-49bda0d7fade@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682447491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BUDNJiL6fQIp3RyWEh1t+at2tgfnMw4rvfIALFEsrvo=;
        b=oVnwsCG+d+vvm9DP518Tr1Hwxn0GP/7fWaKalmoHhp17P9nxeLZ6cqX25HE6GoClUveShQ
        A+1AJdra9aYqYq8Ldb2taMg66Vfh1OEew6ptCqnoHxFwUKo+ICDHE+jSI1UKmlr4KHRmyL
        b0GAQWVH7JyUun3xY/9Vg0Z0nYfhC7E=
Date:   Tue, 25 Apr 2023 11:31:27 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/6] bpf: Don't EFAULT for {g,s}setsockopt with
 wrong optlen
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20230418225343.553806-1-sdf@google.com>
 <20230418225343.553806-4-sdf@google.com>
 <4a2e1b70-9055-f5d9-c286-3e5760f06811@iogearbox.net>
 <CAKH8qBshg+bF59LUXypxvPX1Gek2AASL+DQydVLMgqGT4ONfGQ@mail.gmail.com>
 <f68fc5d8-9bd7-19b2-0e57-8ba746295d37@linux.dev>
 <CAKH8qBsVw=my-pB5Mnmyq-Cp0a1by-nS_=Fyu7cZTmiKk8niXw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAKH8qBsVw=my-pB5Mnmyq-Cp0a1by-nS_=Fyu7cZTmiKk8niXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/25/23 10:12 AM, Stanislav Fomichev wrote:
> On Mon, Apr 24, 2023 at 5:56 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 4/21/23 9:09 AM, Stanislav Fomichev wrote:
>>> On Fri, Apr 21, 2023 at 8:24 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>>
>>>> On 4/19/23 12:53 AM, Stanislav Fomichev wrote:
>>>>> Over time, we've found out several special socket option cases which need
>>>>> special treatment. And if BPF program doesn't handle them correctly, this
>>>>> might EFAULT perfectly valid {g,s}setsockopt calls.
>>>>>
>>>>> The intention of the EFAULT was to make it apparent to the
>>>>> developers that the program is doing something wrong.
>>>>> However, this inadvertently might affect production workloads
>>>>> with the BPF programs that are not too careful.
>>>>
>>>> Took in the first two for now. It would be good if the commit description
>>>> in here could have more details for posterity given this is too vague.
>>>
>>> Thanks! Will try to repost next week with more details.
>>>
>>>>> Let's try to minimize the chance of BPF program screwing up userspace
>>>>> by ignoring the output of those BPF programs (instead of returning
>>>>> EFAULT to the userspace). pr_info_ratelimited those cases to
>>>>> the dmesg to help with figuring out what's going wrong.
>>>>>
>>>>> Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
>>>>> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
>>>>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
>>>>> ---
>>>>>     kernel/bpf/cgroup.c | 8 ++++++--
>>>>>     1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>>>>> index a06e118a9be5..af4d20864fb4 100644
>>>>> --- a/kernel/bpf/cgroup.c
>>>>> +++ b/kernel/bpf/cgroup.c
>>>>> @@ -1826,7 +1826,9 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
>>>>>                 ret = 1;
>>>>>         } else if (ctx.optlen > max_optlen || ctx.optlen < -1) {
>>>>>                 /* optlen is out of bounds */
>>>>> -             ret = -EFAULT;
>>>>> +             pr_info_ratelimited(
>>>>> +                     "bpf setsockopt returned unexpected optlen=%d (max_optlen=%d)\n",
>>>>> +                     ctx.optlen, max_optlen);
>>>>
>>>> Does it help any regular user if this log message is seen? I kind of doubt it a bit,
>>>> it might create more confusion if log gets spammed with it, imo.
>>>
>>> Agreed, but we need some way to let the users know that their bpf
>>> program is doing the wrong thing (if they set the optlen too high for
>>> example).
>>
>> imo, I also think a printk here will be a noise in dmesg most of the time (but
>> much better than an unexpected -EFAULT).
> 
> I was thinking for a v2, maybe print it at least once? Similar to
> current bpf_warn_invalid_xdp_action?
> 
> 
>>> Any other better alternatives to expose those events?
>>
>> Is it possible to only -EFAULT when the bpf prog setting a ctx.optlen larger
>> than the "original" user provided optlen?

Nevermind the "ctx.optlen larger than the original user provided optlen" part. I 
mis-read something in __cgroup_bpf_run_filter_getsockopt(). max_optlen is the 
right limit that the kernel needs to bound the ctx.optlen written by bpf prog.

>> Ignore for all other cases that is due to the current PAGE_SIZE limitation?
> 
> Should be possible. That "ctx.optlen > PAGE_SIZE && ctx.optlen <
> original_optlen" is the condition where we'd silently ignore BPF
> output.

and should the -ve ctx.optlen be treated separately? like in 
__cgroup_bpf_run_filter_getsockopt():

	if (ctx.optlen < 0) {
		ret = -EFAULT;
		goto out;
	}
	
	if (optval && ctx.optlen > max_optlen) {
		ret = original_optlen > PAGE_SIZE ? 0 : -EFAULT;
		goto out;
	}

> As per above, I'll stick a line to the dmest (similar
> bpf_warn_invalid_xdp_action), at least to record that this has
> happened once.
> LMK if you or Danial still don't see a value in printing this..

pr_info_once? hmm... I think it is ok-ish. At least not a warning.

I think almost all of the time the bpf prog forgets to set it to 0 for the long 
optval that it has no interest in. However, to suppress this pr_info_once, 
setting optlen to 0 will disable the following cgroup-bpf prog from using the 
optval as read-only. The case that the printk that may flag is that the bpf prog 
did indeed want to change the long optval?
