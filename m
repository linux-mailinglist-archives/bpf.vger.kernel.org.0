Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDCB520B67
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 04:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbiEJCpw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 22:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiEJCpv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 22:45:51 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E7D27E68E
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 19:41:54 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r192so9351151pgr.6
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 19:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=3CHnTRVSx7EiMqE3gXZruy28LmKpNUBw2gGOVHAk0qc=;
        b=vbrYyQzxhp0kzXpHDjd4wnZjFNvSziTNaM92BL227G6XaufuQvxBCpQBYZWCqhtupK
         7iBzTlFhTJ5mlWdCJDkdKiuiTGpwFEsc0og6zLqo7bugE6bqIkxKxaaWdr4UZn+cJjHk
         yT3fz3YSmbH4rYVKVAfzMw4TU/KFYVi7q76uXJa5RZ3W3ntqdmm4q6S77p8G7z0R31cI
         3BLscLUWVKecV5dqMBP/S1xGPvjKZjR+t48UyeJkKaIu4YmKRUYhbWJO407hL6vH8cF6
         dt5ey17+oeBMwfXeULIiYBiqKp3UWUKFgcvT6MuKQ38mBL7iHqtsm4MtS0GMAEbUIfg0
         6y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3CHnTRVSx7EiMqE3gXZruy28LmKpNUBw2gGOVHAk0qc=;
        b=O07db9glscVG2DIrZi6SX8x7UlOULs5AgOFl2StLaChuFW6XWoTR/dTcYtElmXZWfR
         PFqWDosxdy0Xe74Uy9ODuuUiP2L1lOMxyI0xaxxO0wgCw5kHjtyoDZXu3Od7mpcx43RW
         CK9rhK+9fHkk2vzTZ0F1ma5iCrEWH7WqFTXudAjqqJzNO+cViiEKELlE9NFH1NdWYGu+
         GWMwgesAXGlRPlLo1we0EnVEGjvZCifU16rYVyINP0OuKtpkWvHZ6pegCkTAEhs0x/yZ
         S4uyLm/tnnSxleZUQidfYk2JyHeGNlLFnoPQ92SfWOo/Z7keHiV0PQWLw+71CDArc8EQ
         NAIw==
X-Gm-Message-State: AOAM532aDWMAQEZ2q/V4LEjyNpRfnbzUQ+pdWy+8u0E0m7PzwM+QiIuk
        ZTsUqld7rPGAk0htjFwvItl3tA==
X-Google-Smtp-Source: ABdhPJx1xry35nft2YoS3KHdxR6l5KuGykU/aL3okpA2DFlPwq9E3ctRStt5hElJmWDNarMTMl9LnA==
X-Received: by 2002:a62:d10b:0:b0:50d:a238:75d4 with SMTP id z11-20020a62d10b000000b0050da23875d4mr18377014pfg.78.1652150514074;
        Mon, 09 May 2022 19:41:54 -0700 (PDT)
Received: from [10.86.119.184] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902d5d800b0015e8d4eb2e2sm566338plh.300.2022.05.09.19.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 19:41:53 -0700 (PDT)
Message-ID: <d20aef2a-273a-3183-0923-bde9657d4418@bytedance.com>
Date:   Tue, 10 May 2022 10:41:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [External] Re: [PATCH bpf-next] bpf: add
 bpf_map_lookup_percpu_elem for percpu map
To:     Yosry Ahmed <yosryahmed@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joanne Koong <joannekoong@fb.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Dongdong Wang <wangdongdong.6@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        zhouchengming@bytedance.com
References: <20220507024840.42662-1-zhoufeng.zf@bytedance.com>
 <CAEf4BzZD5q2j229_gL_nDFse2v=k2Ea0nfguH+sOA2O1Nm5sQw@mail.gmail.com>
 <CAJD7tkbd8qA-4goUCVW6Tf0xGpj2OSBXncpWhrWFn5y010oBMw@mail.gmail.com>
From:   Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <CAJD7tkbd8qA-4goUCVW6Tf0xGpj2OSBXncpWhrWFn5y010oBMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

在 2022/5/10 上午9:04, Yosry Ahmed 写道:
> On Mon, May 9, 2022 at 5:34 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>> On Fri, May 6, 2022 at 7:49 PM Feng zhou <zhoufeng.zf@bytedance.com> wrote:
>>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>
>>> Trace some functions, such as enqueue_task_fair, need to access the
>>> corresponding cpu, not the current cpu, and bpf_map_lookup_elem percpu map
>>> cannot do it. So add bpf_map_lookup_percpu_elem to accomplish it for
>>> percpu_array_map, percpu_hash_map, lru_percpu_hash_map.
>>>
>>> The implementation method is relatively simple, refer to the implementation
>>> method of map_lookup_elem of percpu map, increase the parameters of cpu, and
>>> obtain it according to the specified cpu.
>>>
>> I don't think it's safe in general to access per-cpu data from another
>> CPU. I'd suggest just having either a ARRAY_OF_MAPS or adding CPU ID
>> as part of the key, if you need such a custom access pattern.
> I actually just sent an RFC patch series containing a similar patch
> for the exact same purpose. There are instances in the kernel where
> per-cpu data is accessed from other cpus (e.g.
> mem_cgroup_css_rstat_flush()). I believe, like any other variable,
> percpu data can be safe or not safe to access, based on the access
> pattern. It is up to the user to coordinate accesses to the variable.
>
> For example, in my use case, one of the accessors only reads percpu
> values of different cpus, so it should be safe. If a user accesses
> percpu data of another cpu without guaranteeing safety, they corrupt
> their own data. I understand that the main purpose of percpu data is
> lockless (and therefore fast) access, but in some use cases the user
> may be able to safely (and locklessly) access the data concurrently.
>

Regarding data security, I think users need to consider before using it, 
such
as hook enqueue_task_fair, the function itself takes the rq lock of the
corresponding cpu, there is no problem, and the kernel only provides a 
method,
like bpf_per_cpu_ptr and bpf_this_cpu_ptr, data security needs to be 
guaranteed
by users in different scenarios, such as using bpf_spin_lock.


>>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>>> ---
>>>   include/linux/bpf.h            |  2 ++
>>>   include/uapi/linux/bpf.h       |  9 +++++++++
>>>   kernel/bpf/arraymap.c          | 15 +++++++++++++++
>>>   kernel/bpf/core.c              |  1 +
>>>   kernel/bpf/hashtab.c           | 32 ++++++++++++++++++++++++++++++++
>>>   kernel/bpf/helpers.c           | 18 ++++++++++++++++++
>>>   kernel/bpf/verifier.c          | 17 +++++++++++++++--
>>>   kernel/trace/bpf_trace.c       |  2 ++
>>>   tools/include/uapi/linux/bpf.h |  9 +++++++++
>>>   9 files changed, 103 insertions(+), 2 deletions(-)
>>>
>> [...]


