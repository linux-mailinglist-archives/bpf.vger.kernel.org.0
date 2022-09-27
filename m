Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985925EC13D
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 13:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiI0L1E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 07:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiI0L0l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 07:26:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44110151010
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 04:24:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h7so2105936wru.10
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 04:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=M5jzKo1Y6yI8r6q8Sre+cxDLdD/2A2kaYMD25zdlE5Y=;
        b=wY0y/gjDHN0kyfvnbXiYP1LJWlasB9eHWujUMSjiBEt1tVtKsFWxqZCosRJ2FEyitc
         rcwP5o7zIXVkpPWjB5+JKDgDYsKJPvxySRdElxlJ3UicgGCRaXMMMO40KDgBNXMNAhwk
         uR6DbnYzzqeBNhFcl/BGOA2okT8591/ST+yaDc9naDI1rh56kyT442rbsCWfmdmA/qYN
         2zqOjW8tpoBe5N97UhplymbT15S39fMe99SuUVc/kY18KDGbWYVOtw04KdWVoSWPQE1l
         Cvq9FPIv880ZYltFD/m5PPlfRNdclm/luwQxe9HQN8IW1L9Sa2qchR7ctoLQ8KdRA+Pa
         ompA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=M5jzKo1Y6yI8r6q8Sre+cxDLdD/2A2kaYMD25zdlE5Y=;
        b=z/g72sowfbPDMprqchvKOTiSSQRzOIe5gha2tIW84vex3j6SnCOVUa2CCvTDn1kyYZ
         123FAOtBu1wWaBzbT+n+2T+5voto8gQ2Z9T9HA59lEfOnDtuxbI+94V8XsCnnDmqVf7C
         25n5nfbbTPNWxyi0YZy4M+oXu2vuMqKyWkzI49qJDwq9G84L8Pe4FYBdFU1BBRETKEZb
         iDB6jpCSDJeR0cYx0NyZe+ulEFaqZeySSLd1DWE1+T7KYJXWjX9NHDQNrh+RD2wfwUYg
         EEeChy9zxtp3o28aCdVMkemBijqLCGwNbFnCA7+M0vggRh3jCtdRkwdkFWTNoLOszU2y
         e9eg==
X-Gm-Message-State: ACrzQf27u6EqH6kSRp5aoggSM+GGIItptWXP1d2bAE3/+rRGh78Y05mP
        H8o54qnIQVQB6U5KlPsyYAjtaw==
X-Google-Smtp-Source: AMsMyM7hdNgWKg7o40V9KPh9IqnsmYOoGY4isSQArZdor/24G3ERCBhxkIfKfwq8gTq4l5ezW5oW8A==
X-Received: by 2002:a5d:54cd:0:b0:22c:8df8:62c6 with SMTP id x13-20020a5d54cd000000b0022c8df862c6mr11862797wrv.276.1664277859672;
        Tue, 27 Sep 2022 04:24:19 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id p9-20020adfe609000000b0022add5a6fb1sm1614648wrm.30.2022.09.27.04.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 04:24:19 -0700 (PDT)
Message-ID: <896ae326-125b-5d23-2870-aeaa95341c64@isovalent.com>
Date:   Tue, 27 Sep 2022 12:24:18 +0100
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
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220924133620.4147153-9-houtao@huaweicloud.com>
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

Sat Sep 24 2022 14:36:15 GMT+0100 (British Summer Time) ~ Hou Tao
<houtao@huaweicloud.com>
> From: Hou Tao <houtao1@huawei.com>
> 
> Support lookup/update/delete/iterate/dump operations for qp-trie in
> bpftool. Mainly add two functions: one function to parse dynptr key and
> another one to dump dynptr key. The input format of dynptr key is:
> "key [hex] size BYTES" and the output format of dynptr key is:
> "size BYTES".
> 
> The following is the output when using bpftool to manipulate
> qp-trie:
> 
>   $ bpftool map pin id 724953 /sys/fs/bpf/qp
>   $ bpftool map show pinned /sys/fs/bpf/qp
>   724953: qp_trie  name qp_trie  flags 0x1
>           key 16B  value 4B  max_entries 2  memlock 65536B  map_extra 8
>           btf_id 779
>           pids test_qp_trie.bi(109167)
>   $ bpftool map dump pinned /sys/fs/bpf/qp
>   [{
>           "key": {
>               "size": 4,
>               "data": ["0x0","0x0","0x0","0x0"
>               ]
>           },
>           "value": 0
>       },{
>           "key": {
>               "size": 4,
>               "data": ["0x0","0x0","0x0","0x1"
>               ]
>           },
>           "value": 2
>       }
>   ]
>   $ bpftool map lookup pinned /sys/fs/bpf/qp key 4 0 0 0 1
>   {
>       "key": {
>           "size": 4,
>           "data": ["0x0","0x0","0x0","0x1"
>           ]
>       },
>       "value": 2
>   }

The bpftool patch looks good, thanks! I have one comment on the syntax
for the keys, I don't find it intuitive to have the size as the first
BYTE. It makes it awkward to understand what the command does if we read
it in the wild without knowing the map type. I can see two alternatives,
either adding a keyword (e.g., "key_size 4 key 0 0 0 1"), or changing
parse_bytes() to make it able to parse as much as it can then count the
bytes, when we don't know in advance how many we get.

Thanks,
Quentin

