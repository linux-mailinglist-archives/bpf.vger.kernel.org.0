Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31285ED814
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 10:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiI1IpG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 04:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiI1Ioq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 04:44:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25BBAE855
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 01:41:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r7so18663079wrm.2
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 01:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=LflrRGYViklv/EX2lQ4/UJsQkhBFRZZ990ea9ua8cXE=;
        b=lMNkMY1AQJSHNimifD1X+0E77pm6arhjFeqlHLWwvaVlGIL9vkNFZWPnt2YG+5Bnqg
         bA3coxPO4g5chy9f5H1wq3yn97uOZ+tHepKa3I3qTfHXz1X2t1vF665rmNtES1zVXyp2
         RgR3O1i8x2Ig+48RQIT1ru3R2mEkNC8I2v6lajHNIWc4uZjGI/136RmWj055UNObNvxQ
         kY5XTZViKh6oGJf5EB052An/EEPVAcqGxyvZl5AluxVrtat4LyXoioATfSFDicQ0kfcf
         prV1W44mrXYKeudS4nSBSWjKLESiXGaLHRdNQsroXYCtlVEK9HQFXTolR908sJ33bXB0
         W51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LflrRGYViklv/EX2lQ4/UJsQkhBFRZZ990ea9ua8cXE=;
        b=iVEgbhSV58Md9M+A36c/qavwEfE5pqV1qb1frvBmvh2Pg6tDXlFtsl6qvhxMpvlrCt
         45UIB2KLT38mQoXmOJ0ffmP9qBQK0hL5iucUUvKoh5ByFJLOIlnB/vPZECPtJ8w+YKjJ
         xFv/TRpD/NfDECETB5Q0z5oXVpfqZARlZPjW2AB9bOG+moti71uPiCo5/CBpTt/D6KPH
         IzMkrjn0fYQeca9a4OvcTw2n/etpQzRb72zEEgxn5SQY3e8bc4XDkdnON5VDkz/ts4u4
         vkrnBDkrQdfyfKkyalsPH7CmPLqCHdFyNKwV1QRLP7bX+DcFM3yBnOaqqnk7HmLPRTUF
         dl/Q==
X-Gm-Message-State: ACrzQf2xz4R5YaZHXRjty4EMVrXLg56a4nv6Yx65RchPrXFDoM6J0ftQ
        vCjO8FkM7Ylzo6ftYSJNMvPhew==
X-Google-Smtp-Source: AMsMyM52wdCaowbl0i2WV1DXQ3+o6PrN+aTMUIHauZqzDcj4SmOrbGIUn5oaV9arfBGGifD2M8JB4A==
X-Received: by 2002:a5d:6da1:0:b0:22b:773:a99b with SMTP id u1-20020a5d6da1000000b0022b0773a99bmr19257860wrs.600.1664354459950;
        Wed, 28 Sep 2022 01:40:59 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id u7-20020adfdd47000000b00228655a5c8fsm3784030wrm.28.2022.09.28.01.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 01:40:59 -0700 (PDT)
Message-ID: <0fa70b47-5d06-d99a-c3cf-635a33f3f38d@isovalent.com>
Date:   Wed, 28 Sep 2022 09:40:58 +0100
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
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <f46cefeb-2572-ec8a-f5ee-82dc1988137e@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Wed Sep 28 2022 05:14:45 GMT+0100 (British Summer Time) ~ Hou Tao
<houtao@huaweicloud.com>
> Hi,
> 
> On 9/27/2022 7:24 PM, Quentin Monnet wrote:
>> Sat Sep 24 2022 14:36:15 GMT+0100 (British Summer Time) ~ Hou Tao
>> <houtao@huaweicloud.com>
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> Support lookup/update/delete/iterate/dump operations for qp-trie in
>>> bpftool. Mainly add two functions: one function to parse dynptr key and
>>> another one to dump dynptr key. The input format of dynptr key is:
>>> "key [hex] size BYTES" and the output format of dynptr key is:
>>> "size BYTES".
>>>
>>> The following is the output when using bpftool to manipulate
>>> qp-trie:
>>>
>>>   $ bpftool map pin id 724953 /sys/fs/bpf/qp
>>>   $ bpftool map show pinned /sys/fs/bpf/qp
>>>   724953: qp_trie  name qp_trie  flags 0x1
>>>           key 16B  value 4B  max_entries 2  memlock 65536B  map_extra 8
>>>           btf_id 779
>>>           pids test_qp_trie.bi(109167)
>>>   $ bpftool map dump pinned /sys/fs/bpf/qp
>>>   [{
>>>           "key": {
>>>               "size": 4,
>>>               "data": ["0x0","0x0","0x0","0x0"
>>>               ]
>>>           },
>>>           "value": 0
>>>       },{
>>>           "key": {
>>>               "size": 4,
>>>               "data": ["0x0","0x0","0x0","0x1"
>>>               ]
>>>           },
>>>           "value": 2
>>>       }
>>>   ]
>>>   $ bpftool map lookup pinned /sys/fs/bpf/qp key 4 0 0 0 1
>>>   {
>>>       "key": {
>>>           "size": 4,
>>>           "data": ["0x0","0x0","0x0","0x1"
>>>           ]
>>>       },
>>>       "value": 2
>>>   }
>> The bpftool patch looks good, thanks! I have one comment on the syntax
>> for the keys, I don't find it intuitive to have the size as the first
>> BYTE. It makes it awkward to understand what the command does if we read
>> it in the wild without knowing the map type. I can see two alternatives,
>> either adding a keyword (e.g., "key_size 4 key 0 0 0 1"), or changing
>> parse_bytes() to make it able to parse as much as it can then count the
>> bytes, when we don't know in advance how many we get.
> The suggestion is reasonable, but there is also reason for the current choice (
> I should written it down in commit message). For dynptr-typed key, these two
> proposed suggestions will work. But for key with embedded dynptrs as show below,
> both explict key_size keyword and implicit key_size in BYTEs can not express the
> key correctly.
> 
> struct map_key {
> unsigned int cookie;
> struct bpf_dynptr name;
> struct bpf_dynptr addr;
> unsigned int flags;
> };

I'm not sure I follow. I don't understand the difference for dealing
internally with the key between "key_size N key BYTES" and "key N BYTES"
(or for parsing then counting). Please could you give an example telling
how you would you express the key from the structure above, with the
syntax you proposed?

> I also had thought about adding another key word "dynptr_key" (or "dyn_key") to
> support dynptr-typed key or key with embedded dynptr, and the format will still
> be: "dynptr_key size [BYTES]". But at least we can tell it is different with
> "key" which is fixed size. What do you think ?
If the other suggestions do not work, then yes, using a dedicated
keyword (Just "dynkey"? We can detail in the docs) sounds better to me.
