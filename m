Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935A35EDC04
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 13:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiI1Ltm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 07:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiI1Ltl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 07:49:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B685754D
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 04:49:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r7so19418399wrm.2
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 04:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=fWDMCXpnAfjDT7I4eLSEMf8LBxEBSuGnJUdVGdwtOS0=;
        b=0xgJ/85XU+N9hhsD/OVSDNoVqJ1UsOSrS/+CRbA3BUnn3gxFMcHOaqE5BTOjpFtJc9
         /aEfi/cIv5Jki3Fzp+VYouU3hW7ylKW5MxU5Purmw0AM6W2Y+LmAJPvE0vGpDmix/7oZ
         YtrphK3ediFgogWe7G4mq3XzJDtj7CDemRpZHIMajwE6VKwp/MQ6z0qv73+4xQQ44xNM
         fjmUeYiSWdfU/mYg6dHTS9MwideMhMgXvEAxaPgjrUGDC6E6w9Swdp6C7RQtUKo9R29A
         0FQLLbAMqGUHnw3KV1VTMCtwrf7awmmW+KLFHDf6TpPCXSpFaOfRX3ZkxwzcaKztnJ5d
         nbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fWDMCXpnAfjDT7I4eLSEMf8LBxEBSuGnJUdVGdwtOS0=;
        b=BUglfPu7KXZ16LzZyusRQzYJyO4umTDdNPhaVc590ww5dMnkP7y9VeP1/+4iCsWfOV
         pRhgykdRlmUPhpFblRxqcbykfAK33FV1ax7NHE8DwFvLLwpYRgfVAKjyolU6Zk2d3irD
         fr8JRK5R72HmTy9NWPA49uOY40M43RIYw3rKZa8tRDzbs+2UTNbYAoEmr1e+PcU88T9E
         BWVrZBNwyeQo5/RAA8EbgIM0bDfEy782S2x/5DigJiKNqt4D+lUtOwAqZnxERIelOqte
         cD4ghdhUW6g7NAsSDE71a2CUxRI6R1J3JyuJPpr16Nu4Ii6ZgLPE4iLjM8NshY8pgeAD
         x/Vw==
X-Gm-Message-State: ACrzQf20/Qr3qOaLkX6cn2eKNlbGZOEy9fuXkxc8la1uTYKxuAJmjph/
        CpeBOfq68ZaOKiS1WZKXipS4iEjQUrTSaw3V
X-Google-Smtp-Source: AMsMyM5IPOAifBDjMY9h7FeYVvE82JCyz0qI9KS0m7Yrh0Npiw8UNzapvDdEW5itjLR5+HZhYzE1KA==
X-Received: by 2002:a05:6000:15ce:b0:226:f2ab:516d with SMTP id y14-20020a05600015ce00b00226f2ab516dmr20477399wry.264.1664365769996;
        Wed, 28 Sep 2022 04:49:29 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c154b00b003a3442f1229sm1567638wmg.29.2022.09.28.04.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 04:49:29 -0700 (PDT)
Message-ID: <225f8555-086d-ec84-23c7-6d8bbed3d499@isovalent.com>
Date:   Wed, 28 Sep 2022 12:49:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf-next v2 08/13] bpftool: Add support for qp-trie map
Content-Language: en-GB
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, houtao1@huawei.com
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
 <20220924133620.4147153-9-houtao@huaweicloud.com>
 <896ae326-125b-5d23-2870-aeaa95341c64@isovalent.com>
 <f46cefeb-2572-ec8a-f5ee-82dc1988137e@huaweicloud.com>
 <0fa70b47-5d06-d99a-c3cf-635a33f3f38d@isovalent.com>
 <a68a07b9-063d-e83f-b6cf-5cdc86d77d97@huaweicloud.com>
 <e6aadeaf-b73b-c277-5801-0fdaf57e51b6@isovalent.com>
 <3df24978-7d53-68cd-0bee-7db886af8471@huaweicloud.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <3df24978-7d53-68cd-0bee-7db886af8471@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Wed Sep 28 2022 11:54:39 GMT+0100 (British Summer Time) ~ Hou Tao
<houtao@huaweicloud.com>
> Hi,
> 
> On 9/28/2022 5:23 PM, Quentin Monnet wrote:
>> Wed Sep 28 2022 10:05:55 GMT+0100 (British Summer Time) ~ Hou Tao
>> <houtao@huaweicloud.com>
>>> Hi,
>>>
>>> On 9/28/2022 4:40 PM, Quentin Monnet wrote:
>>>> Wed Sep 28 2022 05:14:45 GMT+0100 (British Summer Time) ~ Hou Tao
>>>> <houtao@huaweicloud.com>
>>>>> Hi,
>>>>>
>>>>> On 9/27/2022 7:24 PM, Quentin Monnet wrote:
>>>>>> Sat Sep 24 2022 14:36:15 GMT+0100 (British Summer Time) ~ Hou Tao
>>>>>> <houtao@huaweicloud.com>
>>>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>>>
>>>>>>> Support lookup/update/delete/iterate/dump operations for qp-trie in
>>>>>>> bpftool. Mainly add two functions: one function to parse dynptr key and
>>>>>>> another one to dump dynptr key. The input format of dynptr key is:
>>>>>>> "key [hex] size BYTES" and the output format of dynptr key is:
>>>>>>> "size BYTES".
>>> SNIP
>>>>>> The bpftool patch looks good, thanks! I have one comment on the syntax
>>>>>> for the keys, I don't find it intuitive to have the size as the first
>>>>>> BYTE. It makes it awkward to understand what the command does if we read
>>>>>> it in the wild without knowing the map type. I can see two alternatives,
>>>>>> either adding a keyword (e.g., "key_size 4 key 0 0 0 1"), or changing
>>>>>> parse_bytes() to make it able to parse as much as it can then count the
>>>>>> bytes, when we don't know in advance how many we get.
>>>>> The suggestion is reasonable, but there is also reason for the current choice (
>>>>> I should written it down in commit message). For dynptr-typed key, these two
>>>>> proposed suggestions will work. But for key with embedded dynptrs as show below,
>>>>> both explict key_size keyword and implicit key_size in BYTEs can not express the
>>>>> key correctly.
>>>>>
>>>>> struct map_key {
>>>>> unsigned int cookie;
>>>>> struct bpf_dynptr name;
>>>>> struct bpf_dynptr addr;
>>>>> unsigned int flags;
>>>>> };
>>>> I'm not sure I follow. I don't understand the difference for dealing
>>>> internally with the key between "key_size N key BYTES" and "key N BYTES"
>>>> (or for parsing then counting). Please could you give an example telling
>>>> how you would you express the key from the structure above, with the
>>>> syntax you proposed?
>>> In my understand, if using "key_size N key BYTES" to represent map_key, it can
>>> not tell the exact size of "name" and "addr" and it only can tell the total size
>>> of name and addr. If using "key BYTES" to do that, it has the similar problem.
>>> But if using "key size BYTES" format, map_key can be expressed as follows:
>>>
>>> key c c c c [name_size] n n n [addr_size] a a  f f f f
>> OK thanks I get it now, you can have multiple sizes within the key, one
>> for each field. Yes, let's use a new keyword in that case please. Can
>> you also provide more details in the man page, and ideally add a new
>> example to the list?
> Forget to mention that the map key with embedded dynptr is not supported yet and
> now only support using dynptr as the map key. So will add a new keyword "dynkey"
> in v3 to support operations on qp-trie.

Sounds good thank you, let's do that and ideally mention it in the
commit log for context.

