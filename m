Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB0967B92A
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 19:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbjAYSUD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 13:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbjAYSUC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 13:20:02 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1086599A5
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 10:19:35 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b24-20020a17090a551800b0022beefa7a23so2899057pji.5
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 10:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FHDIQ17x0FKZERks8siHaHXfudVAMekwp7ddsPtQJYQ=;
        b=FW3hV+adtqGfiWJzZcQnn6CEnRpetZEF1D5Ico3gErx3Nk/fAUBBFvn2j2bjHJolGX
         xDs3h3ZXgJkHNNxlx0MsKAoeejX6Tni4+WnjMzei88yZcF7Em+x4UQMEGpsEHasiSo0k
         jvtomXNx1Kg7OkeWwgJJTkqe1e/gBS4IANH9545PjA0E3OtNCxs6GGMb8mROw5Uxj5Z0
         S6dbj3PTyx4KCo1tyJnlbxEAsM/h0/K4Va078SoOr5DvH9Db/eqV5ffthAgy0Vh6a7Tt
         8ab0hjbaUKHlT08BiH7HZDVo+q2m2fQTe8GHCt4m2vU/hjzJbKYNlf2LQ/rh6LmYzSJV
         38gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHDIQ17x0FKZERks8siHaHXfudVAMekwp7ddsPtQJYQ=;
        b=nl0+fwdyoZ/i6qVuy60/W2xb5pdOYx9bHwOIKX4GTN8zMGJqgudBCU710ZfXsViUR+
         1+ic3IeUuBUgancBFC8KWmhyy+KbRAX2cMNboQguE6FV6ZlryG4c36S26F0DJuJU1X/v
         O4jSCz2gkA7maC9pnRdRmih7PIvZOLzx450YjUQrvjAZqiCBHo9Nt7cWa5zvvQsg/fLP
         H7ZwNI5I7OPgaGKmQE9oxBld2gM8lcuojk3hrxMtFUEuaWdADIv4lq3SE8fIpZiNTSkc
         NqkAGN22Zcwhd9/QcDWaK7QmAh/Prh5iRupggw0Ar3S0KBf9+4y9igD64YE9FSjwJ9H3
         zOxQ==
X-Gm-Message-State: AFqh2kr7dwCDnsPx5ZBltYf19DN2M2yRtz1xwnd3xkMA8pcSnmQVlzvF
        zqV2rZ/PAv//jer7FsWmUCFFF0tRADp7pg==
X-Google-Smtp-Source: AMrXdXudBivwhqnkCqBPkML/mMSUrUeTcSCx1fOMPJuj979sftArvrP5zScH7x437rm2m6D5LCBdFQ==
X-Received: by 2002:a17:902:ce82:b0:194:84ef:5f9c with SMTP id f2-20020a170902ce8200b0019484ef5f9cmr62111889plg.29.1674670775368;
        Wed, 25 Jan 2023 10:19:35 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21c8::1204? ([2620:10d:c090:400::5:5918])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c15300b00195f249e688sm3938699plj.248.2023.01.25.10.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 10:19:35 -0800 (PST)
Message-ID: <12c03601-f301-2df2-78d5-c0a243322e74@gmail.com>
Date:   Wed, 25 Jan 2023 10:19:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Calls bpf_setsockopt() on
 a ktls enabled socket.
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com
References: <20230124181220.2871611-1-kuifeng@meta.com>
 <20230124181220.2871611-3-kuifeng@meta.com>
 <41aec8de-1425-aaf7-0a2a-eac849e83eff@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <41aec8de-1425-aaf7-0a2a-eac849e83eff@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 1/25/23 10:09, Martin KaFai Lau wrote:
> On 1/24/23 10:12 AM, Kui-Feng Lee wrote: index 
> 9523333b8905..027d95755f9f 100644
.... skip ....
>> --- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
>> +++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
>> @@ -6,6 +6,8 @@
>>   #include <bpf/bpf_core_read.h>
>>   #include <bpf/bpf_helpers.h>
>>   #include <bpf/bpf_tracing.h>
>> +#define BPF_PROG_TEST_TCP_HDR_OPTIONS
>> +#include "test_tcp_hdr_options.h"
>
> Instead of having dependency on another test's header,
>
>>     #ifndef ARRAY_SIZE
>>   #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>> @@ -22,6 +24,7 @@ int nr_active;
>>   int nr_connect;
>>   int nr_binddev;
>>   int nr_socket_post_create;
>> +int nr_fin_wait1;
>>     struct sockopt_test {
>>       int opt;
>> @@ -386,6 +389,11 @@ int skops_sockopt(struct bpf_sock_ops *skops)
>>           nr_passive += !(bpf_test_sockopt(skops, sk) ||
>>                   test_tcp_maxseg(skops, sk) ||
>>                   test_tcp_saved_syn(skops, sk));
>> +        set_hdr_cb_flags(skops, BPF_SOCK_OPS_STATE_CB_FLAG);
>
> how about directly doing this:
>                 bpf_sock_ops_cb_flags_set(skops,
> skops->bpf_sock_ops_cb_flags |
> BPF_SOCK_OPS_STATE_CB_FLAG);


Sure! It makes sense.


>
>> +        break;
>> +    case BPF_SOCK_OPS_STATE_CB:
>> +        if (skops->args[1] == BPF_TCP_CLOSE_WAIT)
>> +            nr_fin_wait1 += !bpf_test_sockopt(skops, sk);
>>           break;
>>       }
>
