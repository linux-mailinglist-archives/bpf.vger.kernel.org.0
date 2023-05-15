Return-Path: <bpf+bounces-557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE97703525
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 18:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32501C208F1
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 16:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C7BFBFA;
	Mon, 15 May 2023 16:55:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BE1FBF0
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 16:55:53 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA347285
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 09:55:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30771c68a9eso12284924f8f.2
        for <bpf@vger.kernel.org>; Mon, 15 May 2023 09:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684169743; x=1686761743;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ryd2XuUTtCTZE/0WdYTs96h3cJ4tdizQ3n9bS7GhAmI=;
        b=dlfa3ZGjEGaCrxf907QCFTx1SXYssEwAqw6spdwq6uTfCnAOF+Mrvr+oTFwO6cR4g2
         64ZgOhCESXHvSZY447Wy3MvM+2dfBejZCnS/6rVsE7tFX3/Rnq4n1bNQCi8Pth/hxrB0
         +sKEU0fpR4kwVbciPBVh1Hp/T+RwJTovfUL83RK/PDO0PXSLJFfnYFZFxWeOzB5CSv/U
         IaMeYU2g2ARifC42ufQCiWUMs+81cB4ZjyeGrt+zjMV6sxXyEwstEV4cwX/IZ8AuI19a
         +M4zCCt1AqPXLmQAeMI7dxpybFcGTBitilkVa7A+9quYsmOf4QCC1SS3ajNMzQFa1D0N
         +z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169743; x=1686761743;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryd2XuUTtCTZE/0WdYTs96h3cJ4tdizQ3n9bS7GhAmI=;
        b=e0YgHACjvyuK+E9K5kMZHqrkA02Yul+lKzqtiuPKNfii9nQOKfyiO92Z7/jo8oj873
         +7WUhAhTgScnzjW09ksJedxmcj0eHyslDlX8gNWHx9xbHpBuRuwKABdd3bnYV83mvz4a
         LN1Ezx7mPvKK6knsbgkGsAOVgWSQVXO6sAuQEhYWQgilVD7sQBTKkzKCeAOgCuUsec3D
         Sj7M24CfFV50t3ikqNgyTx1pXFP7X8jG3mkY/FmuKvUyZ37RVQZyGf9JDmREGsyM6HwJ
         ym11O7B4cm82FVVnEGZmlPMERKFsgyVHufVT2qkN939w26pM0nnkVfF4XC72Iu0nbJoh
         BuAg==
X-Gm-Message-State: AC+VfDxvK25y46DOg1ktR3Z3mywSvGGY8mlSfZfU3kO2+zyTm57JOlCu
	GAso45jJhyzSCCuVwIsSGkVjzQ==
X-Google-Smtp-Source: ACHHUZ7wNcQDnO7VweE4lxfIGG5iAn5Ew1pMbwnzDqMCUXbOPa4SueI/k35X2ohcizEBHD1wiPxfkQ==
X-Received: by 2002:a5d:51c3:0:b0:2f6:bf04:c8cc with SMTP id n3-20020a5d51c3000000b002f6bf04c8ccmr21896932wrv.55.1684169743166;
        Mon, 15 May 2023 09:55:43 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:9cdc:e9dc:864d:1455? ([2a02:8011:e80c:0:9cdc:e9dc:864d:1455])
        by smtp.gmail.com with ESMTPSA id j17-20020adff551000000b003090cb7a9e6sm334293wrp.31.2023.05.15.09.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 09:55:42 -0700 (PDT)
Message-ID: <f804f5f2-1114-4aeb-2199-4dda597e1f5e@isovalent.com>
Date: Mon, 15 May 2023 17:55:42 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH bpf-next] bpftool: specify XDP Hints ifname when loading
 program
Content-Language: en-GB
To: =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@corigine.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Stanislav Fomichev <sdf@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230511151345.7529-1-larysa.zaremba@intel.com>
 <dd7a4bec-c0d0-4ffe-3bb8-e4d7ab4a01b8@isovalent.com>
 <ZF5A752Z4eu8FAw9@lincoln> <ZGJePGCkfuCITRxn@oden.dyn.berto.se>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <ZGJePGCkfuCITRxn@oden.dyn.berto.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-05-15 18:30 UTC+0200 ~ Niklas Söderlund <niklas.soderlund@corigine.com>
> On 2023-05-12 15:36:47 +0200, Larysa Zaremba wrote:
>> [You don't often get email from larysa.zaremba@intel.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> On Fri, May 12, 2023 at 11:23:00AM +0100, Quentin Monnet wrote:
>>> 2023-05-11 17:13 UTC+0200 ~ Larysa Zaremba <larysa.zaremba@intel.com>
>>>> Add ability to specify a network interface used to resolve
>>>> XDP Hints kfuncs when loading program through bpftool.
>>>>
>>>> Usage:
>>>> bpftool prog load <bpf_obj_path> <pin_path> dev xdpmeta <ifname>
>>>
>>> Thanks for this patch!
>>>
>>> Regarding the command-line syntax, I'm not a big fan of the optional
>>> sub-keyword for the device for XDP hints. I must admit I had not
>>> anticipated other another use for the "dev" keyword. Instead, have you
>>> considered one of the following:
>>>
>>> 1) Adding a different keyword ("xdpmeta_dev"?) and making it
>>> incompatible with "dev"
>>>
>>> 2) Another alternative would be adding a sub-keyword for offload too:
>>>
>>>     bpftool p l [...] dev <[offload <ifname> | xdpmeta <ifname>]>
>>>
>>> If the ifname is provided with no sub-keyword, we would consider it for
>>> offload for legacy support, possibly warn that the syntax is deprecated.
>>>
>>> What do you think?
>>>
>>
>> I think first option would look a little bit nicer, but I like the idea to
>> deprecate "dev <ifname>". In my current version, forgetting to add "xdpmeta"
>> resulted in not very descriptive errors, this may confuse new users. So what
>> about:
> 
> I agree the first option looks a little bit nicer, but I think both 
> options would work.
> 
>>
>> bpftool prog load [...] xdpmeta_dev/offload_dev <ifname>
>>
>> "dev <ifname>" syntax would still work, but with a big warning, like this:
>>
>>   'bpftool prog [...] dev <ifname>' syntax is deprecated. Going further, please
>>   use 'offload_dev <ifname>' to offload program to device. For XDP hints
>>   applications, use 'xdpmeta_dev <ifname>'.

OK let's go with this

Thanks,
Quentin


