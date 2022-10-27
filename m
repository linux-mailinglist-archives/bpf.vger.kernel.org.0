Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCE8610682
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 01:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbiJ0Xqs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 19:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbiJ0Xqr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 19:46:47 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D450E22BD4
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 16:46:46 -0700 (PDT)
Message-ID: <4dbbbdf1-0253-9101-1fc7-a4685970f4d7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666914405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFxsJeRTl6qyUpqbWNEYpaZl8EK/rivJAX6WfMjG7aA=;
        b=rYPBn9BWXqlaALMtBB7BsanzArxjtQRqB6gfBhqBZt1jShRy90SGKBxkC6nqfyi6r9pddF
        YhZ/G0Cns0vAVJkXTsBfYDeMizSZ4OL5Ok9spF6ZysJRx6dDLqqkmt0NQgNqGJFbvRB1/0
        f+ixPQ2K++87N6CCTOH8Ax/re9gxgy0=
Date:   Thu, 27 Oct 2022 16:46:42 -0700
MIME-Version: 1.0
Subject: Re: [Question]: BPF_CGROUP_{GET,SET}SOCKOPT handling when optlen >
 PAGE_SIZE
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
References: <5c8b7d59-1f28-2284-f7b9-49d946f2e982@linux.dev>
 <CAEf4BzbsjBfFaf0M8_qLaEYAcUn4J9275tp0GEt5vb8hBg6Z9w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAEf4BzbsjBfFaf0M8_qLaEYAcUn4J9275tp0GEt5vb8hBg6Z9w@mail.gmail.com>
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

On 10/27/22 1:46 PM, Andrii Nakryiko wrote:
> On Wed, Oct 26, 2022 at 6:17 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> The cgroup-bpf {get,set}sockopt prog is useful to change the optname behavior.
>> The bpf prog usually just handles a few specific optnames and ignores most
>> others.  For the optnames that it ignores, it usually does not need to change
>> the optlen.  The exception is when optlen > PAGE_SIZE (or optval_end - optval).
>> The bpf prog needs to set the optlen to 0 for this case or else the kernel will
>> return -EFAULT to the userspace.  It is usually not what the bpf prog wants
>> because the bpf prog only expects error returning to userspace when it has
>> explicitly 'return 0;' or used bpf_set_retval().  If a bpf prog always changes
>> optlen for optnames that it does not care to 0,  it may risk if the latter bpf
>> prog in the same cgroup may want to change/look-at it.
>>
>> Would like to explore if there is an easier way for the bpf prog to handle it.
>> eg. does it make sense to track if the bpf prog has changed the ctx->optlen
>> before returning -EFAULT to the user space when ctx.optlen > max_optlen?
> 
> Maybe optlen + optval/optval_end could be replaced with dynptr? If we
> do a new type of dynptr (DYNPTR_CTXBUF or something like that), we can
> implement tracking of whether it was ever modified through
> bpf_dynptr_write() or if direct memory access was ever used (was
> bpf_dynptr_data() called). Not sure how you'd know if
> bpf_dynptr_data() was used to modify data, though (this is where
> bpf_dynptr_data_rdonly() vs bpf_dynptr_data() would be helpful,
> perhaps). But just a seed of an idea, maybe you guys can somehow fit
> it here?

Yep, dynptr can be used here.  May be one dynptr specifically for sockptr_t. The 
dynptr will have the __user pointer first to avoid a big (and potentially bogus) 
kernel buffer pre allocation.  Then only read and write it through the 
bpf_dynptr_read() and write().  Since it is __user pointer, it won't be directly 
accessible through data slice with bpf_dynptr_data().  It should not be a perf 
issue, most of the common optval is an integer.  The worst common case is the 16 
bytes tcp-cc name.   The bpf prog has to be sleepable first though which I think 
will be a useful thing to have.
