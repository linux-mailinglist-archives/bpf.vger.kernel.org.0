Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D20A6F4D91
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 01:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjEBXYm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 May 2023 19:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjEBXYl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 19:24:41 -0400
Received: from out-47.mta1.migadu.com (out-47.mta1.migadu.com [95.215.58.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5811E3591
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 16:24:40 -0700 (PDT)
Message-ID: <28b0c7b9-65e4-4721-ab1d-c6716d563317@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683069878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=82XCOisLGheRu19KH4b4LKiJKBnuB16fBbRL1h+5Fpc=;
        b=CCGmpygdoLfJ7STSyNaqZiB+26bPRL1xrRSBQibqm8ZoQV3z6xG7/+hYANaojc+cNjLmIK
        sjZFp7vNv1ixu3g9qxRLRjn/kG47AaFWBBzpts8vhZyb3KdQjupUWexb59vl5b49hAr5kB
        XQx1aZbuRhDEYOyR9FzTa5xM2Cw7TtI=
Date:   Tue, 2 May 2023 16:24:32 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v6 bpf-next 0/7] bpf: Add socket destroy capability
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Eric Dumazet <edumazet@google.com>, bpf@vger.kernel.org
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
 <76dcba72-4e52-9ea1-cabd-b4c9f431c556@linux.dev>
 <E6DB96AE-A7FA-4462-A0ED-4C53F3625BB1@isovalent.com>
 <FD812E8A-54FA-4ED9-82A4-0A257E92BFE7@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <FD812E8A-54FA-4ED9-82A4-0A257E92BFE7@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/1/23 4:37 PM, Aditi Ghag wrote:
> 
> 
>> On May 1, 2023, at 4:32 PM, Aditi Ghag <aditi.ghag@isovalent.com> wrote:
>>
>>
>>
>>> On Apr 24, 2023, at 3:15 PM, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>
>>> On 4/18/23 8:31 AM, Aditi Ghag wrote:
>>>> This patch adds the capability to destroy sockets in BPF. We plan to use
>>>> the capability in Cilium to force client sockets to reconnect when their
>>>> remote load-balancing backends are deleted. The other use case is
>>>> on-the-fly policy enforcement where existing socket connections prevented
>>>> by policies need to be terminated.
>>>
>>> If the earlier kfunc filter patch (https://lore.kernel.org/bpf/1ECC8AAA-C2E6-4F8A-B7D3-5E90BDEE7C48@isovalent.com/) looks fine to you, please include it into the next revision. This patchset needs it. Usual thing to do is to keep my sob (and author if not much has changed) and add your sob. The test needs to be broken out into a separate patch though. It needs to use the '__failure __msg("calling kernel function bpf_sock_destroy is not allowed")'. There are many examples in selftests, eg. the dynptr_fail.c.
>>>
>>
>> Yeah, ok. I was waiting for your confirmation. The patch doesn't need my sob though (maybe tested-by).
>> I've created a separate patch for the test.

I believe your sob is still needed since you will post the patch.

>>
> 
> Ah, looks like the patch is missing a proper description. While I can add something wrt sock_destroy use case, if you have a blurb, feel free to post it here.

Right, some of the RFC commit message is irrelevant. You can develop the 
description based on the useful part of the RFC commit message, like "... added 
a callback filter to 'struct btf_kfunc_id_set'. The filter has
access to the prog such that it can filter by other properties of a prog.
The prog->expected_attached_type is used in the tracing_iter_filter() ...". This 
is the how part. You need to explain why the patch is needed in the commit 
message also.

> 
>>
>>> Please also fix the subject in the patches. They are all missing the bpf-next and revision tag.
>>>
>>
>> Took me a few moments to realize that as I was looking at earlier series. Looks like I forgot to add the tags to subsequent patches in this series. I'll fix it up in the next push.
> 

