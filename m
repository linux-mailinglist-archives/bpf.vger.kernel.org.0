Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175936ED96D
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 02:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjDYA4m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 20:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDYA4l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 20:56:41 -0400
Received: from out-6.mta0.migadu.com (out-6.mta0.migadu.com [IPv6:2001:41d0:1004:224b::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1532E93E6
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 17:56:40 -0700 (PDT)
Message-ID: <f68fc5d8-9bd7-19b2-0e57-8ba746295d37@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682384196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T4C5/282Cd1EMw/eqRdgnNJCbHSogeBz1mCx5TESAV0=;
        b=pO94G5kTIpxwbxWa2W7I9C3Lns64hXckkfxkS//2UEtYpdHKIf98ARnmZGOqG4RILuvmrg
        w1wZFa8Gq6FLQVISgnK3ET0nXYnLE2TQH0n7IzMk2mZLHsHyfa4MB1wzOxRFFhq7ZwFcEu
        Ic+e4f4ngL5A5hXD9CG2ISMDXR+ofEY=
Date:   Mon, 24 Apr 2023 17:56:32 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAKH8qBshg+bF59LUXypxvPX1Gek2AASL+DQydVLMgqGT4ONfGQ@mail.gmail.com>
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

On 4/21/23 9:09 AM, Stanislav Fomichev wrote:
> On Fri, Apr 21, 2023 at 8:24 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 4/19/23 12:53 AM, Stanislav Fomichev wrote:
>>> Over time, we've found out several special socket option cases which need
>>> special treatment. And if BPF program doesn't handle them correctly, this
>>> might EFAULT perfectly valid {g,s}setsockopt calls.
>>>
>>> The intention of the EFAULT was to make it apparent to the
>>> developers that the program is doing something wrong.
>>> However, this inadvertently might affect production workloads
>>> with the BPF programs that are not too careful.
>>
>> Took in the first two for now. It would be good if the commit description
>> in here could have more details for posterity given this is too vague.
> 
> Thanks! Will try to repost next week with more details.
> 
>>> Let's try to minimize the chance of BPF program screwing up userspace
>>> by ignoring the output of those BPF programs (instead of returning
>>> EFAULT to the userspace). pr_info_ratelimited those cases to
>>> the dmesg to help with figuring out what's going wrong.
>>>
>>> Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
>>> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
>>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
>>> ---
>>>    kernel/bpf/cgroup.c | 8 ++++++--
>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>>> index a06e118a9be5..af4d20864fb4 100644
>>> --- a/kernel/bpf/cgroup.c
>>> +++ b/kernel/bpf/cgroup.c
>>> @@ -1826,7 +1826,9 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
>>>                ret = 1;
>>>        } else if (ctx.optlen > max_optlen || ctx.optlen < -1) {
>>>                /* optlen is out of bounds */
>>> -             ret = -EFAULT;
>>> +             pr_info_ratelimited(
>>> +                     "bpf setsockopt returned unexpected optlen=%d (max_optlen=%d)\n",
>>> +                     ctx.optlen, max_optlen);
>>
>> Does it help any regular user if this log message is seen? I kind of doubt it a bit,
>> it might create more confusion if log gets spammed with it, imo.
> 
> Agreed, but we need some way to let the users know that their bpf
> program is doing the wrong thing (if they set the optlen too high for
> example).

imo, I also think a printk here will be a noise in dmesg most of the time (but 
much better than an unexpected -EFAULT).

> Any other better alternatives to expose those events?

Is it possible to only -EFAULT when the bpf prog setting a ctx.optlen larger 
than the "original" user provided optlen?
Ignore for all other cases that is due to the current PAGE_SIZE limitation?

> 
>>>        } else {
>>>                /* optlen within bounds, run kernel handler */
>>>                ret = 0;
>>> @@ -1922,7 +1924,9 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>>>                goto out;
>>>
>>>        if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
>>> -             ret = -EFAULT;
>>> +             pr_info_ratelimited(
>>> +                     "bpf getsockopt returned unexpected optlen=%d (max_optlen=%d)\n",
>>> +                     ctx.optlen, max_optlen);
>>>                goto out;
>>>        }
>>>
>>>
>>

