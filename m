Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FAF6C3E43
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 00:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjCUXFU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 19:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjCUXFQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 19:05:16 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F52C4FF3A
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 16:05:12 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso21957920pjb.0
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 16:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679439912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tg3pqYGBtBzXQ27Ku7VWZnB32G5bsoI2JMdu/k6Ppc8=;
        b=dJdCnanvv/9mdxMPADdbVz8IRxFxCKJgiNGC8E9ab0hG1XXtDjtiDwTL7/tjNtNp78
         j6/FzzyzeVur4xihnnvei9NSDVrSyXoU+ibga/+SudL9zLzsLvf6EQxMmRdZooQ8lORX
         L6zxqLnoeLMDqcO7HcCz5y/YHvi2hnveLuIXeMQevLeZ+IF/K9kwTMt6qtkkFixX09yx
         3RnNCG+nw9gaH37Tfv9cVKIGFMGSX0LovTntRtUHY6EbKuzS2s3q1/s75fdlAvTT3RMk
         hnPhEbPKi9vXaNy3tvjoa1bkF1f5hj0mnPwYesIGNwjps2Qaoof7mHCBocuF84ufKyzZ
         ublw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679439912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tg3pqYGBtBzXQ27Ku7VWZnB32G5bsoI2JMdu/k6Ppc8=;
        b=seG2eOo0JKRZDeVkZ6nWum6JWErrxuOANy/EWFt3AWf2vn0Ust52tvA0NfJwHkysGd
         BEkpFTBX8m6Uq3KQOY6R+FVymaCRtlRbkbKKPB/6UcoBtqD2jAvEjgzAwH5Wtu8M0AM0
         HhBjHtJBXyTQhP6mf1u2L2pK5QnG5gBLHDU3ck4tYy8H1B8FLsnv0zYPhurWeAeC5c7D
         l6eDvsmsWuCOIDhwNEVVjWRjnTII98fXrJ+y4YmHCZEDU03UWLzs3IgQsXO5aMBUGgtt
         ruSCbfYe+ZqdwAbt2QLYQwTBWaJVVtlZxjuvhdLd88r9/9uP7oFFt1/DZrLROifE5/l5
         DlLQ==
X-Gm-Message-State: AO0yUKVqxa173U4oq3OIFBa0sY4+PslYozObgmy3kPBXGpWhuWpRbzHs
        LahODc9B4ZrABMJ9RS5LzNM=
X-Google-Smtp-Source: AK7set+qZpXrnggLDEKkhE32xi/oeLEjPS4oJr2xvCnOb0pQ/wwNb7iMT7ELIwHXBkIALoUG9WS+7A==
X-Received: by 2002:a05:6a20:6a91:b0:d9:27f7:5ee1 with SMTP id bi17-20020a056a206a9100b000d927f75ee1mr3685814pzb.51.1679439912399;
        Tue, 21 Mar 2023 16:05:12 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:7b5b:78a7:738b:7b20? ([2620:10d:c090:500::7:e86])
        by smtp.gmail.com with ESMTPSA id f12-20020aa782cc000000b006255a16be2fsm8742717pfn.132.2023.03.21.16.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 16:05:12 -0700 (PDT)
Message-ID: <ef602c94-2978-e4e3-02e8-1ce9bbc2e1c9@gmail.com>
Date:   Tue, 21 Mar 2023 16:05:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v9 8/8] selftests/bpf: Test switching TCP
 Congestion Control algorithms.
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230320195644.1953096-1-kuifeng@meta.com>
 <20230320195644.1953096-9-kuifeng@meta.com>
 <b7738b11-0260-eb60-7788-791a070c30a0@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <b7738b11-0260-eb60-7788-791a070c30a0@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/21/23 14:05, Martin KaFai Lau wrote:
> On 3/20/23 12:56 PM, Kui-Feng Lee wrote:
>> Create a pair of sockets that utilize the congestion control algorithm
>> under a particular name. Then switch up this congestion control
>> algorithm to another implementation and check whether newly created
>> connections using the same cc name now run the new implementation.
>>
>> Also, try to update a link with a struct_ops that is without
>> BPF_F_LINK or with a wrong or different name.  These cases should fail
>> due to the violation of assumptions.  To update a bpf_link of a
>> struct_ops, it must be replaced with another struct_ops that is
>> identical in type and name and has the BPF_F_LINK flag.
>>
>> The other test case is to create links from the same struct_ops more
>> than once.  It makes sure a struct_ops can be used repeatly.
> 
> Test for BPF_F_REPLACE is needed.
> 
Sure!
