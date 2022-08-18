Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59481598924
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 18:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344853AbiHRQkK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 12:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344850AbiHRQkI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 12:40:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA6591080
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 09:40:07 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n4so2343710wrp.10
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 09:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=GexUlF4ShsbvM/5+FHZTW5WNt/VoSURza5qmXJXUOss=;
        b=4Bt5Ng7gp6Cz4HNi5h74gAu47EzSTvO8GPxcrnNA5KcEfSGM/+mkSOLTpT1KHtQmQC
         nyc05lkJswlBcFQrpM3M8pLq1p+AdsQuczSs55nYJUb7czQgXTxvZU64Noz6YK6XBgoE
         0Z/9zVwOHSa4XgjHnm7r1OjEdyqYgGnu2KO81Ha8K1LrsIopy9tp+GGlRfraLtyGas0B
         5vo935PmV/vJII+nvOKg5lnfdLa8fD0bdQA5fsLrG2XZi/MyTy663jF8ZT8guGOOsOlT
         YOY21xNRWC1iKX+68AYjhhif8lICvVvVWqn60jXhSWK/wDxeZxUdQxqQF8dPHB8jLztN
         xtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=GexUlF4ShsbvM/5+FHZTW5WNt/VoSURza5qmXJXUOss=;
        b=pa5UmxNyXH5GhM0wo2RGWYWRri223wRGBxnKTfFAruc4hVuuF2dY1i6oDoqJwrxYkL
         gpNb44PA9baLBdvuRXrPZ7QCtvVa6taWRmSmwCvbQVZJcmUxGen8eAX4rj9xBff8Lckb
         q/yxKGMQ47Ka9ZGf51vea6Ly+hPxFDmB1pZwbLA2aipUUcm9HLcjnygksYE5sSOPI7ti
         aSvOAwBU5DxhDPoG38Opn3edNHzh+4TS8XOEs15UiclB5/1H63hOnToo7Ng4yFJeUdGO
         50U4GhXmZr0ibh2nMOz85ezpRarbSibYf9f56UEiBTVQlN09vDjsY7mZqb43LlgAH3Hc
         I/zQ==
X-Gm-Message-State: ACgBeo3wfMUtwSYZvhSrgYsO/jzF//Di7zeYFKTPHoRIQK3N8FBYGCV0
        rE0kbkA4dVc2uGKeUuxMNMM8BQ==
X-Google-Smtp-Source: AA6agR4OebAoKoxymPHgrWb1d98AXrHPQ3vhI+HZKG4LtXNDBBpK4goEN7GMVn6C5YBzSQl+F4e3mQ==
X-Received: by 2002:adf:fa81:0:b0:224:f260:2523 with SMTP id h1-20020adffa81000000b00224f2602523mr2075676wrr.26.1660840805703;
        Thu, 18 Aug 2022 09:40:05 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id i20-20020a1c5414000000b003a327f19bf9sm6621432wmb.14.2022.08.18.09.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 09:40:05 -0700 (PDT)
Message-ID: <23da162e-1018-9bfa-bc5c-ec09eba9428b@isovalent.com>
Date:   Thu, 18 Aug 2022 17:40:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 3/3] tools/build: Display logical OR of a feature flavors
Content-Language: en-GB
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20220818120957.319995-1-roberto.sassu@huaweicloud.com>
 <20220818120957.319995-3-roberto.sassu@huaweicloud.com>
 <Yv46EW6KbUe9zjur@kernel.org>
 <71544d2970e246e1f0d5f5ec065ea2437df58cd9.camel@huaweicloud.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <71544d2970e246e1f0d5f5ec065ea2437df58cd9.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 18/08/2022 14:25, Roberto Sassu wrote:
> On Thu, 2022-08-18 at 10:09 -0300, Arnaldo Carvalho de Melo wrote:
>> Em Thu, Aug 18, 2022 at 02:09:57PM +0200, 
>> roberto.sassu@huaweicloud.com escreveu:
>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>
>>> Sometimes, features are simply different flavors of another
>>> feature, to
>>> properly detect the exact dependencies needed by different Linux
>>> distributions.
>>>
>>> For example, libbfd has three flavors: libbfd if the distro does
>>> not
>>> require any additional dependency; libbfd-liberty if it requires
>>> libiberty;
>>> libbfd-liberty-z if it requires libiberty and libz.
>>>
>>> It might not be clear to the user whether a feature has been
>>> successfully
>>> detected or not, given that some of its flavors will be set to OFF,
>>> others
>>> to ON.
>>>
>>> Instead, display only the feature main flavor if not in verbose
>>> mode
>>> (VF != 1), and set it to ON if at least one of its flavors has been
>>> successfully detected (logical OR), OFF otherwise. Omit the other
>>> flavors.
>>>
>>> Accomplish that by declaring a FEATURE_GROUP_MEMBERS-<feature main
>>> flavor>
>>> variable, with the list of the other flavors as variable value. For
>>> now, do
>>> it just for libbfd.
>>>
>>> In verbose mode, of if no group is defined for a feature, show the
>>> feature
>>> detection result as before.
>>
>> Looks cool, tested and added this to the commit log message here in
>> my
>> local branch, that will go public after further tests for the other
>> csets in it:
>>
>> Committer testing:
>>
>> Collecting the output from:
>>
>>   $ make -C tools/bpf/bpftool/ clean
>>   $ make -C tools/bpf/bpftool/ |& grep "Auto-detecting system
>> features" -A10
>>
>>   $ diff -u before after
>>   --- before    2022-08-18 10:06:40.422086966 -0300
>>   +++ after     2022-08-18 10:07:59.202138282 -0300
>>   @@ -1,6 +1,4 @@
>>    Auto-detecting system features:
>>    ...                                  libbfd: [ on  ]
>>   -...                          libbfd-liberty: [ on  ]
>>   -...                        libbfd-liberty-z: [ on  ]
>>    ...                                  libcap: [ on  ]
>>    ...                         clang-bpf-co-re: [ on  ]
>>   $
>>
>> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>
>> Thanks for working on this!
> 
> Thanks for testing and for adapting/pushing the other patches!
> 
> Roberto
> 

Tested locally for bpftool and I also observe "libbfd: [ on  ]" only.
This looks much better, thank you Roberto for following up on this!

Quentin
