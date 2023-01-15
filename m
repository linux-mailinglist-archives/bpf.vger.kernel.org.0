Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97D266B461
	for <lists+bpf@lfdr.de>; Sun, 15 Jan 2023 23:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjAOWwF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 15 Jan 2023 17:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjAOWwE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 15 Jan 2023 17:52:04 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114091E9C3
        for <bpf@vger.kernel.org>; Sun, 15 Jan 2023 14:52:02 -0800 (PST)
Message-ID: <bfa2b221-9ed7-2791-08e2-2e5b29e21dee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673823121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+/+Dl/ffhAYQAOWMtWO5yTqV8lc0WJllAA0Smoo7zw=;
        b=LNtnvL87cLn7kMKovy1vFVRkJ1awBCS8NeAHsj4s6r5DhoOAoEFp+t7WR995e4u+9kWyf2
        KGsGTjPMBMPML8VIJ3HeIxhU9ACC+ZMwKYbe5vmYoqPxcVWaJN6p4Ed//D2Wkr6mrLPdJW
        opdG8BlfCg2GpP3gvoj4BAeeVtam+nQ=
Date:   Sun, 15 Jan 2023 14:51:47 -0800
MIME-Version: 1.0
Subject: Re: [bpf-next v5 3/3] bpf: hash map, suppress false lockdep warning
Content-Language: en-US
To:     Tonghao Zhang <tong@infragraf.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>, bpf@vger.kernel.org
References: <20230111092903.92389-1-tong@infragraf.org>
 <20230111092903.92389-3-tong@infragraf.org>
 <7e6d02ea-f9f7-2d09-bf10-ccd41b16a671@linux.dev>
 <EE4608EF-84F5-4E4C-967F-37B96D680D2E@infragraf.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <EE4608EF-84F5-4E4C-967F-37B96D680D2E@infragraf.org>
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

On 1/13/23 1:15 AM, Tonghao Zhang wrote:
> 
> 
>> On Jan 13, 2023, at 9:53 AM, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 1/11/23 1:29 AM, tong@infragraf.org wrote:
>>> +	/*
>>> +	 * The lock may be taken in both NMI and non-NMI contexts.
>>> +	 * There is a false lockdep warning (inconsistent lock state),
>>> +	 * if lockdep enabled. The potential deadlock happens when the
>>> +	 * lock is contended from the same cpu. map_locked rejects
>>> +	 * concurrent access to the same bucket from the same CPU.
>>> +	 * When the lock is contended from a remote cpu, we would
>>> +	 * like the remote cpu to spin and wait, instead of giving
>>> +	 * up immediately. As this gives better throughput. So replacing
>>> +	 * the current raw_spin_lock_irqsave() with trylock sacrifices
>>> +	 * this performance gain. atomic map_locked is necessary.
>>> +	 * lockdep_off is invoked temporarily to fix the false warning.
>>> +	 */
>>> +	lockdep_off();
>>>   	raw_spin_lock_irqsave(&b->raw_lock, flags);
>>> -	*pflags = flags;
>>> +	lockdep_on();
>>
>> I am not very sure about the lockdep_off/on. Other than the false warning when using the very same htab map by both NMI and non-NMI context, I think the lockdep will still be useful to catch other potential issues. The commit c50eb518e262 ("bpf: Use separate lockdep class for each hashtab") has already solved this false alarm when NMI happens on one map and non-NMI happens on another map.
>>
>> Alexei, what do you think? May be only land the patch 1 fix for now.
> Hi Martin
> Patch 2 is used for patch 1 to test whether there is a deadlock. We should apply this two patches.

It is too noisy for test_progs that developers routinely run. Lets continue to 
explore other ways (or a different test) without this false positive splat. 
Patch 1 was applied as already mentioned in the earlier reply.
