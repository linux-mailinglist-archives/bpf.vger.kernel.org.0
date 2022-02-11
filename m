Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D374B2C1C
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 18:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352356AbiBKRwu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 12:52:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241935AbiBKRwu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 12:52:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2D361AF
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 09:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644601967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l23HZHTFBL0IPdh3ovUgxu1B4pTxjdBfAyrfDNSwZ/0=;
        b=XOClCa8q3D4k3h4pKLXjpD+j/BQBtelE+kgFOXgnN936aWn0k5QANqw5eiTTiEsr5Ius9p
        thnZRRA0bI66SLwE+BF9gHBRAnnC+V2ynx3WymC89oM3nUgVN49ZnMxcVy3+NMg0pANDd/
        mee/rHs0Q2igBnmvDTdu3S5f8Vdubfg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-7bgdHLSYMrqjBo5r-ZhITQ-1; Fri, 11 Feb 2022 12:52:47 -0500
X-MC-Unique: 7bgdHLSYMrqjBo5r-ZhITQ-1
Received: by mail-ed1-f69.google.com with SMTP id z8-20020a05640240c800b0041003c827edso4131664edb.0
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 09:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l23HZHTFBL0IPdh3ovUgxu1B4pTxjdBfAyrfDNSwZ/0=;
        b=6gorTVx+OXdwZGjJ7p9qaJd2oenWfa7sXXiTGegNwq3cXq4ZvHB9tUoeOyIp+tAXhO
         biWZ84pgsd53mGrXMl/S8huWoHVpWJpKeSV6rQ0gfM4Dziobn3oadqPVOY1B6tuVCeVI
         p80bfpVhTmnMzBJiUJ+WsSVGuy3+HG3BjYTBj+nfalDVjxzNT12Dh6ZWHJRhuNRatB7v
         8TvfPX2KZWeSGTnCb2WwWnNCssjh4FDUYjtFojsSP7kJvTji/eUjts50D51ltfg1Gu3D
         Bhu18ZW8CV8SKU/134iQNSnPmQeF7kwyzB9K6cnaCapaYiYeB7OKCyleyJq7US2xoZDX
         epLw==
X-Gm-Message-State: AOAM531t1udrLWCPjHELUKE3gqys1+ratrlxzv5q6yyVmg/rnAH8WsEw
        xuGbW0d4Fuucd+uV7MyYtP/keUazOtddvjTtn5qbMJVBkB5GOy0thR1bD8fDIH/s/uZsJwS5rHO
        6maq44nbgp+WN
X-Received: by 2002:a17:907:6d17:: with SMTP id sa23mr2257277ejc.551.1644601964814;
        Fri, 11 Feb 2022 09:52:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEnQ+7Bk1ytAgIc7ypJcdQuZFnmUrPKdELhG/wG5SXOeaTTvQJg/TUeOapXYRJhdIQ8wILPA==
X-Received: by 2002:a17:907:6d17:: with SMTP id sa23mr2257259ejc.551.1644601964552;
        Fri, 11 Feb 2022 09:52:44 -0800 (PST)
Received: from ?IPV6:2a00:fb8:34ae:a500:65d6:dbfd:b5fb:c46e? ([2a00:fb8:34ae:a500:65d6:dbfd:b5fb:c46e])
        by smtp.gmail.com with ESMTPSA id t10sm6445359ejf.79.2022.02.11.09.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 09:52:44 -0800 (PST)
Message-ID: <a2665ecd-12b0-e520-2061-ec8caf1d076a@redhat.com>
Date:   Fri, 11 Feb 2022 18:52:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH bpf-next v2] bpf: Do not try bpf_msg_push_data with len 0
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org
References: <df69012695c7094ccb1943ca02b4920db3537466.1644421921.git.fmaurer@redhat.com>
 <cd545202-d948-2ce5-dfae-362822766f90@fb.com>
 <f18b9e66-8494-f335-13cc-a9b30a90e32e@redhat.com>
 <22d98cc5-26fa-8023-3a85-a082a9e08147@fb.com>
From:   Felix Maurer <fmaurer@redhat.com>
In-Reply-To: <22d98cc5-26fa-8023-3a85-a082a9e08147@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10.02.22 19:04, Yonghong Song wrote:
> On 2/10/22 7:45 AM, Felix Maurer wrote:
>> On 09.02.22 18:06, Yonghong Song wrote:
>>> On 2/9/22 7:55 AM, Felix Maurer wrote:
>>>> If bpf_msg_push_data is called with len 0 (as it happens during
>>>> selftests/bpf/test_sockmap), we do not need to do anything and can
>>>> return early.
>>>>
>>>> Calling bpf_msg_push_data with len 0 previously lead to a wrong ENOMEM
>>>> error: we later called get_order(copy + len); if len was 0, copy + len
>>>> was also often 0 and get_order returned some undefined value (at the
>>>> moment 52). alloc_pages caught that and failed, but then
>>>> bpf_msg_push_data returned ENOMEM. This was wrong because we are most
>>>> probably not out of memory and actually do not need any additional
>>>> memory.
>>>>
>>>> v2: Add bug description and Fixes tag
>>>>
>>>> Fixes: 6fff607e2f14b ("bpf: sk_msg program helper bpf_msg_push_data")
>>>> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
>>>
>>> LGTM. I am wondering why bpf CI didn't catch this problem. Did you
>>> modified the test with length 0 in order to trigger that? If this
>>> is the case, it would be great you can add such a test to the
>>> test_sockmap.
>>
>> I did not modify the tests to trigger that. The state of the selftests
>> around that is unfortunately not very good. There is no explicit test
>> with length 0 but bpf_msg_push_data is still called with length 0,
>> because of what I consider to be bugs in the test. On the other hand,
>> explicit tests with other lengths are sometimes not called as well. I'll
>> elaborate on that in a bit.
>>
>> Something easy to fix is that the tests do not check the return value of
>> bpf_msg_push_data which they probably should. That may have helped find
>> the problem earlier.
>>
>> Now to the issue mentioned in the beginning: Only some of the BPF
>> programs used in test_sockmap actually call bpf_msg_push_data. However,
>> they are not always attached, just for particular scenarios:
>> txmsg_pass==1, txmsg_redir==1, or txmsg_drop==1. If none of those apply,
>> bpf_msg_push_data is never called. This happens for example in
>> test_txmsg_push. Out of the four defined tests only one actually calls
>> the helper.
>>
>> But after a test, the parameters in the map are reset to 0 (instead of
>> being removed). Therefore, when the maps are reused in a subsequent test
>> which is one of the scenarios above, the values are present and
>> bpf_msg_push_data is called, albeit with the parameters set to 0. This
>> is also what triggered the wrong behavior fixed in the patch.
>>
>> Unfortunately, I do not have the time to fix these issues in the test at
>> the moment.
> 
> Thanks for detailed explanation. Maybe for the immediate case, can you
> just fix this in the selftest,
> 
>   > Something easy to fix is that the tests do not check the return
> value of
>   > bpf_msg_push_data which they probably should. That may have helped find
>   > the problem earlier.
> 
> This will be enough to verify your kernel change as without it the
> test will fail.

I just send a patch checking the return values of the bpf_msg_push_data
usages in the test [1]. Passing the errors to userspace by dropping
packets is not very nice, but a straightforward way in the current test
program.

I did try the same checks of the return values of bpf_msg_pull_data, but
then the tests fail. So there might be something hidden here as well.

[1]:https://lore.kernel.org/bpf/89f767bb44005d6b4dd1f42038c438f76b3ebfad.1644601294.git.fmaurer@redhat.com/

> The rest of test improvements can come later.
> 
>>
>>> Acked-by: Yonghong Song <yhs@fb.com>
>>
>> Thanks!
>>
> 

