Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C2260FF4D
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 19:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbiJ0R3G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 13:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbiJ0R3G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 13:29:06 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228BC18D83D
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 10:29:04 -0700 (PDT)
Message-ID: <1d37564e-cf00-a1ea-a0b2-817b439734a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666891741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ku7w3mUlj0d63KG2099yZLGhb2v8lHZO5lOiyQo4xbo=;
        b=J+xosR8AZL0/oMmx/toQf6fZmHSCDE3/DP63tBRYbOXAbtiAytnHOpHB/5pKuEpeR2x8dt
        vvv8n8jBsWRaT2mPXj6s79VsCbS6CKD3n3ZSdGr8QI0A+z2+015pN6RpqsfU4GlOo/xlyU
        3APLSeHASaPj3J/JcD+JKUgQC1Pj9zs=
Date:   Thu, 27 Oct 2022 10:28:52 -0700
MIME-Version: 1.0
Subject: Re: [Question]: BPF_CGROUP_{GET,SET}SOCKOPT handling when optlen >
 PAGE_SIZE
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <5c8b7d59-1f28-2284-f7b9-49d946f2e982@linux.dev>
 <CAKH8qBu7OXptKF46SQSEfueKXRUkBxix3K0qmucgREP4h_rQJQ@mail.gmail.com>
 <41284964-123d-704b-2802-24a857a7a989@linux.dev>
 <CAKH8qBsNZL0YrML5duNebqjMXtBDnB6L05zsMHCe==-UcRa9JA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAKH8qBsNZL0YrML5duNebqjMXtBDnB6L05zsMHCe==-UcRa9JA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/27/22 9:23 AM, Stanislav Fomichev wrote:
> On Wed, Oct 26, 2022 at 11:15 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 10/26/22 7:03 PM, Stanislav Fomichev wrote:
>>> On Wed, Oct 26, 2022 at 6:14 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>
>>>> The cgroup-bpf {get,set}sockopt prog is useful to change the optname behavior.
>>>> The bpf prog usually just handles a few specific optnames and ignores most
>>>> others.  For the optnames that it ignores, it usually does not need to change
>>>> the optlen.  The exception is when optlen > PAGE_SIZE (or optval_end - optval).
>>>> The bpf prog needs to set the optlen to 0 for this case or else the kernel will
>>>> return -EFAULT to the userspace.  It is usually not what the bpf prog wants
>>>> because the bpf prog only expects error returning to userspace when it has
>>>> explicitly 'return 0;' or used bpf_set_retval().  If a bpf prog always changes
>>>> optlen for optnames that it does not care to 0,  it may risk if the latter bpf
>>>> prog in the same cgroup may want to change/look-at it.
>>>>
>>>> Would like to explore if there is an easier way for the bpf prog to handle it.
>>>> eg. does it make sense to track if the bpf prog has changed the ctx->optlen
>>>> before returning -EFAULT to the user space when ctx.optlen > max_optlen?
>>>
>>> Good point on chaining being broken because of this requirement :-/
>>>
>>> With tracking, we need to be careful, because the following situation
>>> might be problematic:
>>> Suppose setsockopt is larger than 4k, the program can rewrite some
>>> byte in the first 4k, not touch optlen and expect this to work.
>>
>> If the bpf prog rewrites the first 4k, it must change the ctx.optlen to get it
>> work.  Otherwise, the kernel will return -EFAULT because the ctx.optlen is
>> larger than the max_optlen (or optval_end - optval).
>>
>>> Currently, optlen=0 explicitly means "ignore whatever is in the bpf
>>> buffer and use the original one" > If we can have a tracking that catches situations like this - we
>>> should be able to drop that optlen=0 requirement.
>>> IIRC, that's the only tricky part.
>>
>> Ah, I meant, in __cgroup_bpf_run_filter_setsockopt, use "!ctx.optlen_changed &&
>> ctx.optlen > max_optlen" test to imply "ignore whatever is in the bpf
>> buffer and use the original one".  Add 'bool optlen_changed' to 'struct
>> bpf_sockopt_kern' and set ctx.optlen_changed to true in
>> cg_sockopt_convert_ctx_access() whenever there is BPF_WRITE to ctx.optlen.
>> Would it work or may be I am still missing something in the writing first 4k
>> case above?
> 
> What if the program wants to keep optlen as is? Here is the
> hypothetical case: ctx->optlen is 8k, we allocate/expose only the
> first 4k, the program does ctx->optval[0] = 0xff and doesn't change
> the optlen. It wants the rest of the payload to be passed as is with
> only the first byte changed.

I think we are talking about the same case but we may have different 
understanding on how the current __cgroup_bpf_run_filter_setsockopt() is 
handling it.

I don't see the current kernel supports this now.  If the bpf prog does not 
change the ctx->optlen from 8k to something that is <= 4k, the kernel will just 
return -EFAULT in here, no?
	else if (ctx.optlen /* 8k */ > max_optlen /* 4k */ || ctx.optlen < -1) {
		/* optlen is out of bounds */
                 ret = -EFAULT;
         }

or you meant the future change needs to consider this new case and also support 
gluing the first 4k (that was exposed to the bpf prog) with the second 4k (that 
was not exposed to the bpf prog)?

> The condition "!ctx.optlen_changed && ctx.optlen > max_optlen" is
> true, so, if we treat this as explicit optlen=0, we ignore the
> program's changes.
> But this is not what the program has intended, right? It wants to
> amend something and pass the rest as is.
> 
> It seems like we need to have both optlen_changed and optval_changed.
> If both are false, we should be able to safely do optlen=0 equivalent.
> Tracking only optlen seems to be problematic?

