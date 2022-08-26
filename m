Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CABA5A2609
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 12:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343763AbiHZKpP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 06:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243426AbiHZKpO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 06:45:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E245014097
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 03:45:11 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b5so1326393wrr.5
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 03:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ltgjDvlH9K1IsHO6TAzxb2549gKy1tpf6mupeDK7CCo=;
        b=rZCYrdz1j/hG6ebw7dgwnsJsMCV5Tme1pEwpAkr8m/We4mt52F3ReQ2XEm/BvywVw6
         1VfrimFdU/O3XS7eOZeUKzZ91g5xSI+j5z36enp0HFwAFdNL8BojW5MBLTJgggDhrj6j
         h1ilmeBQt96xdlJyhHHbFjdIXR634HSNydclgkGqznZ+D5TO2vaDkoCSAmZLMf56o48l
         btd1QJQD7t5ADK8yIW++Yvu0iQxKc5Eiz6BnHvzD8YsEe1iifCZoRb+97VgHLBxfuXUj
         FNArqTP9c4NJv9b991lRHFxYKqn0eL31KTLw2P59tJ7pVWMT7bQvBXL1AbaXr/pW3M5v
         7q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ltgjDvlH9K1IsHO6TAzxb2549gKy1tpf6mupeDK7CCo=;
        b=dvrOyGNnX9y60bK8W5WSt3fPrntpSgqlQh0mXlCcrR88mMpm04IP0F2I4fKOAlaV/I
         Psa5QV77jbsRj+u063hqccMYZ0xNbVlrw5mbjximZ2APqhyFHUoCaTkU7g3AfX92FuSB
         vzF4wArk93r4XbXG8Nm1WcyrgsgmCu0KlMuBgJuHFDvrfj4rLs4ypSKZR5FFcpwf1LEY
         e1oHfCpO+ZVhR2khWTRQJ+mRWfbZZUEBuBUPt/SkbxORCuPHjk2ujIFXel7A7mt05lVC
         EIUsREzcCcgmJZJ9Dmad8EFcYHRPf6SZNUPaYsI8iYOGCuLbulVIf8Hnfzss3+wHqrTc
         +xXg==
X-Gm-Message-State: ACgBeo3ANAw+F3mroY+eDDFk9bedIw1d29XjxU4JTGRY9CWOLGZDbhhR
        4X+7fxvrbsJ64V5xsdclTNNzpA==
X-Google-Smtp-Source: AA6agR6xxUsxFFu1Zo14iWiZUQxQZkUrOB53Tx/DcZiy2YhexkAK1xh8Q5V/8dYF6l31VsAvrvb4+A==
X-Received: by 2002:adf:e109:0:b0:225:4ca5:80d5 with SMTP id t9-20020adfe109000000b002254ca580d5mr4458639wrz.465.1661510710217;
        Fri, 26 Aug 2022 03:45:10 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id p7-20020a5d4587000000b0022586045c89sm1541433wrq.69.2022.08.26.03.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 03:45:09 -0700 (PDT)
Message-ID: <ee620e99-dc04-aa2c-f53b-b875dba79feb@isovalent.com>
Date:   Fri, 26 Aug 2022 11:45:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH bpf-next v2] bpftool: implement perf attach command
Content-Language: en-GB
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20220824033837.458197-1-weiyongjun1@huawei.com>
 <b942bf8f-204b-6bf1-7847-ec5f11c50ca0@isovalent.com>
 <CAEf4BzafSAZfhkun5PBGODw6v1s10Nh4JeH8azdqZY-62kBCKg@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4BzafSAZfhkun5PBGODw6v1s10Nh4JeH8azdqZY-62kBCKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

On 25/08/2022 19:37, Andrii Nakryiko wrote:
> On Thu, Aug 25, 2022 at 8:28 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> Hi Wei,
>>
>> Apologies for failing to answer to your previous email and for the delay
>> on this one, I just found out GMail had classified them as spam :(.
>>
>> So as for your last message, yes: your understanding of my previous
>> answer was correct. Thanks for the patch below! Some comments inline.
>>
> 
> Do we really want to add such a specific command to bpftool that would
> attach BPF object files with programs of only RAW_TRACEPOINT and
> RAW_TRACEPOINT_WRITABLE type?
> 
> I could understand if we added something that would be equivalent of
> BPF skeleton's auto-attach method. That would make sense in some
> contexts, especially for some quick testing and validation, to avoid
> writing (a rather simple) user-space loading code.

Do you mean loading and attaching in a single step, or keeping the
possibility to load first as in the current proposal?

> 
> But "perf attach" for raw_tp programs only? Seem way too limited and
> specific, just adding bloat to bpftool, IMO.

We already support attaching some kinds of program types through
"prog|cgroup|net attach". Here I thought we could add support for other
types as a follow-up, but thinking again, you're probably right, it
would be best if all the types were supported from the start. Wei, have
you looked into how much work it would be to add support for
tracepoints, k(ret)probes, u(ret)probes as well? The code should be
mostly identical?

Quentin

