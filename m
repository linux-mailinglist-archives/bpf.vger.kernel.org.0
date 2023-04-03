Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8976D4F04
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 19:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjDCRfw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 13:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDCRfv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 13:35:51 -0400
Received: from out-28.mta0.migadu.com (out-28.mta0.migadu.com [91.218.175.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FCA1BE4
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 10:35:50 -0700 (PDT)
Message-ID: <1cad9be4-6c72-0520-8b5b-f6f5222a581b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680543349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BaZluLBsHFjfz/5d5tpViu0WbBGDADGWfA/quCL5+Cs=;
        b=abfItFQBU/GSv6FXc+xMMDFW9KOrQl1gWmvDZ0Xw7/rRQ/kpep3xQ2DIAhClO54Xi9fXWN
        MuNaLby5wngdOhNzyO3B6jKsMM3XZCIc9mMzAmEeV34XOpc8ntRpkgxPX0or2m6D07APfP
        fRKHVNCM+ecEug/PV8E+4ao/B3XqYFU=
Date:   Mon, 3 Apr 2023 10:35:46 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <B7A26EB4-55F4-4FAB-B7A2-D7EC37E1E0DC@isovalent.com>
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

On 4/3/23 8:55 AM, Aditi Ghag wrote:
> 
> 
>> On Mar 31, 2023, at 3:32 PM, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 3/30/23 11:46 AM, Stanislav Fomichev wrote:
>>>> +void test_sock_destroy(void)
>>>> +{
>>>> +    struct sock_destroy_prog *skel;
>>>> +    int cgroup_fd = 0;
>>>> +
>>>> +    skel = sock_destroy_prog__open_and_load();
>>>> +    if (!ASSERT_OK_PTR(skel, "skel_open"))
>>>> +        return;
>>>> +
>>>> +    cgroup_fd = test__join_cgroup("/sock_destroy");
>>
>> Please run this test in its own netns also to avoid affecting other tests as much as possible.
> 
> Is it okay if I defer this nit to a follow-up patch? It's not conflicting with other tests at the moment.

Is it sure it won't affect other tests when running in parallel (test -j)?
This test is iterating all in the current netns and only checks for port before 
aborting.

It is easy to add. eg. ~10 lines of codes can be borrowed from 
prog_tests/mptcp.c which has recently done the same in commit 02d6a057c7be to 
run the test in its own netns to set a sysctl.

