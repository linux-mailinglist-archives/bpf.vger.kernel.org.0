Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD8D6D5630
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 03:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjDDBlK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 21:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjDDBlJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 21:41:09 -0400
Received: from out-13.mta0.migadu.com (out-13.mta0.migadu.com [91.218.175.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C4090
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 18:41:06 -0700 (PDT)
Message-ID: <4f5913d0-8271-5676-569b-366fc6def385@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680572464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GjgzfdB/3Dp7+l3S1qdpxx+E9M7XM93E/YR8WMyvYAU=;
        b=HHW8oJ8hP7dkYtrhUwqowCnhmV1uz2ENGI08Epyc2xgHw7kwMeQyEgt++jAWfiCTbe/dAa
        w50pBVVVBxl2hUuJmB+1ouRzAmqmJtqvmBwYooLvqG0jtn5G1niHWg2ASJGMh0i3cyTe9y
        8xT/6/gSzvtwoCzaLacntrPDF8RpiDo=
Date:   Mon, 3 Apr 2023 18:41:01 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 7/7] selftests/bpf: Test bpf_sock_destroy
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     bpf@vger.kernel.org, kafai@fb.com, edumazet@google.com,
        Stanislav Fomichev <sdf@google.com>
References: <20230330151758.531170-1-aditi.ghag@isovalent.com>
 <20230330151758.531170-8-aditi.ghag@isovalent.com>
 <ZCXY6mOY8pPLhdBF@google.com>
 <869f0a0f-0f43-73fb-a361-76009a21b81d@linux.dev>
 <B7A26EB4-55F4-4FAB-B7A2-D7EC37E1E0DC@isovalent.com>
 <1cad9be4-6c72-0520-8b5b-f6f5222a581b@linux.dev>
 <144D865C-07D6-4665-85F8-A5AF511ED44A@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <144D865C-07D6-4665-85F8-A5AF511ED44A@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/3/23 5:15 PM, Aditi Ghag wrote:
> 
> 
>> On Apr 3, 2023, at 10:35 AM, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 4/3/23 8:55 AM, Aditi Ghag wrote:
>>>> On Mar 31, 2023, at 3:32 PM, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>
>>>> On 3/30/23 11:46 AM, Stanislav Fomichev wrote:
>>>>>> +void test_sock_destroy(void)
>>>>>> +{
>>>>>> +    struct sock_destroy_prog *skel;
>>>>>> +    int cgroup_fd = 0;
>>>>>> +
>>>>>> +    skel = sock_destroy_prog__open_and_load();
>>>>>> +    if (!ASSERT_OK_PTR(skel, "skel_open"))
>>>>>> +        return;
>>>>>> +
>>>>>> +    cgroup_fd = test__join_cgroup("/sock_destroy");
>>>>
>>>> Please run this test in its own netns also to avoid affecting other tests as much as possible.
>>> Is it okay if I defer this nit to a follow-up patch? It's not conflicting with other tests at the moment.
>>
>> Is it sure it won't affect other tests when running in parallel (test -j)?
>> This test is iterating all in the current netns and only checks for port before aborting.
>>
>> It is easy to add. eg. ~10 lines of codes can be borrowed from prog_tests/mptcp.c which has recently done the same in commit 02d6a057c7be to run the test in its own netns to set a sysctl.
> 
> I haven't run the tests in parallel, but the tests are not using hard-coded ports anymore. Anyway I'm willing to run it in a separate netns as a follow-up for additional guards, but do you still think it's a blocker for this patch?

Testing port is not good enough. It is only like ~10 lines of codes that can be 
borrowed from other existing tests that I mentioned earlier. What is the reason 
to cut corners here? The time spent in replying on this topic is more than 
enough to add the netns support. I don't want to spend time to figure out why 
other tests running in parallel become flaky while waiting for the follow up,
so no.

Please run the test in its own netns. All new network tests must run in its own 
netns.

btw, since I don't hear any comment on patch 5 regarding to restricting the 
destroy kfunc to BPF_TRACE_ITER only. It is the major piece missing. I am 
putting some pseudo code that is more flexible than adding 
BTF_KFUNC_HOOK_TRACING_ITER that I mentioned earlier to see how it may look 
like. Will update that patch's thread soon.

