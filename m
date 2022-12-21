Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ADF652AA8
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 01:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbiLUA4g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 19:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiLUA4f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 19:56:35 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80AA6462
        for <bpf@vger.kernel.org>; Tue, 20 Dec 2022 16:56:33 -0800 (PST)
Message-ID: <34389727-b9ee-4745-debf-935292bdaf3a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671584191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A3SiZ13Nx/z8OPmernc7LFar6dQMYNTP0V9EtPg1KFI=;
        b=VSbgeLo7QvDcmZNz7GG8SIgbUrs5oCV+Uxy485mScgB+hO1/ExeAZHKHYUCzrZ9CUlf7S9
        CdBlBVmV/dLQktyKd9uJgSb8UkiTYg/p42PChfWUZDA66D/yITdKyjIZOW+JU9Pnfa8elA
        xTQ+LT/SJQrrvUJp4PUAhPx+UQ0kKms=
Date:   Tue, 20 Dec 2022 16:56:29 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Reduce smap->elem_size
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@meta.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        bpf <bpf@vger.kernel.org>
References: <20221216232951.3575596-1-martin.lau@linux.dev>
 <e68b892a-c688-f266-3819-0282ba5a1ac9@meta.com>
 <844f94a4-a003-55da-dc29-adf9f448fc45@linux.dev>
 <CAEf4BzbJGpkhyio9+S1U=bnYycaknw0SNada6orzNV_+VfPwGw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAEf4BzbJGpkhyio9+S1U=bnYycaknw0SNada6orzNV_+VfPwGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[ Cc: the bpf list back.  I dropped it by mistake in my last reply. ]

On 12/20/22 3:43 PM, Andrii Nakryiko wrote:
> On Mon, Dec 19, 2022 at 11:47 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 12/16/22 5:23 PM, Yonghong Song wrote:
>>>
>>>
>>> On 12/16/22 3:29 PM, Martin KaFai Lau wrote:
>>>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>>>
>>>> 'struct bpf_local_storage_elem' has a 56 bytes padding at the end
>>>> which can be used for attr->value_size.  The current smap->elem_size
>>>
>>> 'can be' => 'will be'?
>>
>> I used 'can be' to describe the current situation that the padding is not used
>> for the map's value.  I may have used the wrong tense?
>>
>> I can rephrase it to something like,
>>
>> 'struct bpf_local_storage_elem' has a 56 bytes padding at the end which is
>> currently not used for the attr->value_size.
> 
> I actually found the use of attr->value_size to mean "value content"
> more confusing than can vs will be.
> 
> As a suggestion something like the below?
> 
> 
> 'struct bpf_local_storage_elem' has an unused 56 byte padding at the
> end due to struct's cache-line alignment requirement. This padding
> space is overlapped by storage value contents, so if we use sizeof()
> to calculate the total size, we overinflate it by 56 bytes. Use
> offsetof() instead to calculate more exact memory use.

SGTM.

> 
> 
> btw, I think you can calculate the same arguably a bit more
> straightforwardly as:
> 
> smap->elem_size = offsetofend(struct bpf_local_storage_elem, sdata) +
> attr->value_size;

Sure. will change.

> 
> right?
> 
> but TIL that offsetof(struct bpf_local_storage_data,
> data[attr->value_size]) does the right thing

Yeah, I think I have seen other places using it also.  I found it more intuitive 
to read with array[size] to tell there is a flexible array at the end.  I am not 
super attached to it and will change to the way above.

