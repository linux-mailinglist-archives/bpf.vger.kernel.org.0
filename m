Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB365348E9
	for <lists+bpf@lfdr.de>; Thu, 26 May 2022 04:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbiEZCkr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 May 2022 22:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiEZCkq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 May 2022 22:40:46 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEF5663CD
        for <bpf@vger.kernel.org>; Wed, 25 May 2022 19:40:44 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g184so284622pgc.1
        for <bpf@vger.kernel.org>; Wed, 25 May 2022 19:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=3dcMthtH7n4TL6BIfw9bc4YTWwWt9+20GSo8lo+80/c=;
        b=YSnvd/xBBjIaxlXFb0s10PkGNLbeKtQPnLmvbbv4th7RWppo1PXvzYnly4MaRlgtbr
         tCRCFQf9HguH5PJ5GPqxArrHVpYbWsuCtcmn1Gu1C2TzPK10D2qAS3Wiz7aFBTJrFMpI
         Q1TXH2/KpBT2GxzOXqfTzHqNC91YGACXVCfUfZYsLBV49xy82O5hM3BPzFWz9Q9LQeUM
         4d/JInLN4q2y0d0Qt9e35H0El3O51aY2cxexkapsMdcucTw3rW/I+oyJCOKwbYki/5kO
         XqvVsnx//7w2WhZlUOkLNFZePW/8W0EbPhclH87WMkJexlQ3ytRdOdrtNf9J0bD3xUfz
         DB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3dcMthtH7n4TL6BIfw9bc4YTWwWt9+20GSo8lo+80/c=;
        b=pqXika4V28NT+WZAdtCb787kP9p/bcLicO9ksWvZCY4150OBwYVaeIhCu0mM9/opN6
         SsQd+3n6ON2phInbJLM+WQ9DWUlV8zNfHUiIqcuUh6/9lh6dM1asQRhoocfMtPdXZapz
         VyQFcJKeT8uFG/CNcDpZrhW4wIJP62LEzCFho5jwwbAzSfnsuSWEUnWu0lUGRR871yf8
         iPzheL7s7GqRKB2MVO1sL1omZUYycQsrRJjNrWVbVHBlEPJMiSGUtJJaQMpWMXZVVDIR
         YfYZEJTm7mNKFShzJh5xARU+rsNbrd3O9eYZdN2pSnz916m2/6QXVsotImNQbiXRnauo
         FLJg==
X-Gm-Message-State: AOAM5328qvxNDsxeHdwn3ntIb7XyG6jEjelaiNeFTZlnzPXnRDkohXtd
        w4AOlt+qccT/wbdAPEf57/+7j41/GXMmgA4w
X-Google-Smtp-Source: ABdhPJx4sDh1hjAhH0HjoZGXlpVLVnS66LfWbCvM5ds3M9BNoWahOpAQWnt8Ct0R3/VLVOGe4nPfWg==
X-Received: by 2002:a65:6cc3:0:b0:3f6:26e9:5c1 with SMTP id g3-20020a656cc3000000b003f626e905c1mr30801215pgw.28.1653532844127;
        Wed, 25 May 2022 19:40:44 -0700 (PDT)
Received: from [10.71.57.194] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090a5e4300b001e0abbc3a74sm222108pji.5.2022.05.25.19.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 19:40:43 -0700 (PDT)
Message-ID: <d71f2351-af17-7e20-7f99-d628b7ab5765@bytedance.com>
Date:   Thu, 26 May 2022 10:40:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [External] Re: [PATCH v2 2/2] selftest/bpf/benchs: Add bpf_map
 benchmark
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Dongdong Wang <wangdongdong.6@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20220524075306.32306-1-zhoufeng.zf@bytedance.com>
 <20220524075306.32306-3-zhoufeng.zf@bytedance.com>
 <CAADnVQL-RQqGcfqn9kTsH=UWAG4ZKduG+zNaptiqwjECTqR37Q@mail.gmail.com>
From:   Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <CAADnVQL-RQqGcfqn9kTsH=UWAG4ZKduG+zNaptiqwjECTqR37Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

在 2022/5/25 上午8:13, Alexei Starovoitov 写道:
> On Tue, May 24, 2022 at 12:53 AM Feng zhou <zhoufeng.zf@bytedance.com> wrote:
>> +static void setup(void)
>> +{
>> +       struct bpf_link *link;
>> +       int map_fd, i, max_entries;
>> +
>> +       setup_libbpf();
>> +
>> +       ctx.skel = bpf_map_bench__open_and_load();
>> +       if (!ctx.skel) {
>> +               fprintf(stderr, "failed to open skeleton\n");
>> +               exit(1);
>> +       }
>> +
>> +       link = bpf_program__attach(ctx.skel->progs.benchmark);
>> +       if (!link) {
>> +               fprintf(stderr, "failed to attach program!\n");
>> +               exit(1);
>> +       }
>> +
>> +       //fill hash_map
>> +       map_fd = bpf_map__fd(ctx.skel->maps.hash_map_bench);
>> +       max_entries = bpf_map__max_entries(ctx.skel->maps.hash_map_bench);
>> +       for (i = 0; i < max_entries; i++)
>> +               bpf_map_update_elem(map_fd, &i, &i, BPF_ANY);
>> +}
> ...
>   +SEC("fentry/" SYS_PREFIX "sys_getpgid")
>> +int benchmark(void *ctx)
>> +{
>> +       u32 key = bpf_get_prandom_u32();
>> +       u64 init_val = 1;
>> +
>> +       bpf_map_update_elem(&hash_map_bench, &key, &init_val, BPF_ANY);
>> +       return 0;
>> +}
> This benchmark is artificial at its extreme.
> First it populates the map till max_entries and then
> constantly bounces off the max_entries limit in a bpf prog.
> Sometimes random_u32 will be less than max_entries
> and map_update_elem will hit a fast path,
> but most of the time it will fail to alloc_htab_elem()
> and will fail to map_update_elem.
>
> It does demonstrate that percpu_free_list is inefficient
> when it's empty, but there is no way such a microbenchmark
> justifies optimizing this corner case.
>
> If there is a production use case please code it up in
> a benchmark.

This corner case is not easy to reproduce. In the scenario of a surge in 
network traffic,
the map is full, and there are still a large number of update operations.
Just like Yonghong Song says
'''
in your use case, you have lots of different keys and your intention is 
NOT to capture all the keys in
the hash table. So given a hash table, it is possible that the hash
will become full even if you increase the hashtable size.
Maybe you will occasionally delete some keys which will free some
space but the space will be quickly occupied by the new updates.
'''

>
> Also there is a lot of other overhead: syscall and atomic-s.
> To stress map_update_elem please use a for() loop inside bpf prog.

Ok, I will modify the way the test case is tested.
And add this benchmark just to reproduce the case. As for whether to 
optimize this case, I use ftrace
'''
cd /sys/kernel/debug/tracing/
echo > trace
echo htab_map_update_elem > set_graph_function
echo function_graph > current_tracer
cat per_cpu/cpu0/trace
echo nop > current_tracer
'''
To confirm whether the update operation will continue to grab the 
spin-lock of each cpu when the map is full.
Then close ftrace, check the time-consuming update and whether there is 
any improvement before patching.



