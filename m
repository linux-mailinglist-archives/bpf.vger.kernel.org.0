Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE906F0023
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 06:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239605AbjD0EUK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 00:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242680AbjD0EUF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 00:20:05 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEF330CA
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 21:20:03 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b46186c03so9305239b3a.3
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 21:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682569202; x=1685161202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7JcDqVlZRaVk0slNIHGqHr7vj7InB9xHBZxncx31Fz8=;
        b=F6MXaByzy6ZXA3h9SgY3Up0XJSstr33f2QWR9Oc0K7yDhDoUPdJefS4yuhfCi3uddw
         siX3y/VyyQ/sdbvf44JwCmd8aQNdkjtnEqE/S/j7dcvxDyXG2gyBpy7hjkly2/6dwwK/
         GVUZpuR/aBeY8TVgVEIjg8pZ26JQ/TuAEFZXaeYbY/7hmx9AWEFnMga0j4lPU5yOitzG
         V31yVTyaorPdi0VQBliZaMJTUiW+Ai04JdObj7fD5+gbRxGsuy2kLxGECRPkdUZ+lMKN
         yAyqHQPGwNZ+BOHR/r/LOtaaqDZ/dZVJeEGHMzSStWwMgSZuCQKvPglauQXMPj95KgQh
         wbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682569202; x=1685161202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7JcDqVlZRaVk0slNIHGqHr7vj7InB9xHBZxncx31Fz8=;
        b=DQylsaoOqmstyqhUysDWD9w0tsrqvcuZwiX/qsZ5fnXcyPsizRhblZzoui1ecN8mu6
         /+onp0yWIzHwGtcz1/H5NjY/qLFfWGRYs/Hufae8HEinL/e4Moa5hOUJR67TTGJHaEEw
         HM9+eqI3AsnQpeAHw+K1Fp2/PB8Gi7QSmxz2/qpV9MU3GIhHyQk7yCfOcycKCT69G1hl
         D7eUsLqZZmIx2I3+w/6eZ1oc1hosTvEDLv5GCs9Z4D483JNSTRD94B+odrzlUPu3o8K5
         O1IIk2SFrG8aPq2w7j2MGPg04Xm82UlZncG5vCBz4gMxu2jhIH7awfhsqeNm4/dE4YQj
         updw==
X-Gm-Message-State: AC+VfDwUZrhmOcOIc45NWQRAx9haFcP86YahGi7yt+Up+TS+XojvOYAY
        efwLGrI+Xe6/V2+A4d/+nGw=
X-Google-Smtp-Source: ACHHUZ6+pYyfh6BnSBX0dHqnq6hz6kgILyVvV6Tb1Kd2ftjY3mJJFrhSznpTNjZwffreMxv5TDWSuQ==
X-Received: by 2002:a05:6a00:21cf:b0:63d:368b:76b4 with SMTP id t15-20020a056a0021cf00b0063d368b76b4mr585606pfj.17.1682569202495;
        Wed, 26 Apr 2023 21:20:02 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.111])
        by smtp.gmail.com with ESMTPSA id v2-20020a62c302000000b0063b54ccc123sm10548747pfg.196.2023.04.26.21.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 21:20:02 -0700 (PDT)
Message-ID: <c2a5cb6d-8779-4197-d491-d2249bb49635@gmail.com>
Date:   Thu, 27 Apr 2023 12:19:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [HELP] failed to resolve CO-RE relocation
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>
References: <20230427001425.563232-1-namhyung@kernel.org>
 <CAEf4BzYs6iD+iE4RZnXTKHhBHCOr9r7AdhsBWWDpivy7sshPKw@mail.gmail.com>
 <CAM9d7ci3xAcnqdkpb-J4rv7yfiB2Trb-e2h7gfj6Wu5N_V7a-Q@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <CAM9d7ci3xAcnqdkpb-J4rv7yfiB2Trb-e2h7gfj6Wu5N_V7a-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Namhyung

On 2023/4/27 10:21, Namhyung Kim wrote:
> Hello Andrii,
> 
> On Wed, Apr 26, 2023 at 6:19 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Wed, Apr 26, 2023 at 5:14 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>>
>>> Hello,
>>>
>>> I'm having a problem of loading perf lock contention BPF program [1]
>>> on old kernels.  It has collect_lock_syms() to get the address of each
>>> CPU's run-queue lock.  The kernel 5.14 changed the name of the field
>>> so there's bpf_core_field_exists to check the name like below.
>>>
>>>         if (bpf_core_field_exists(rq_new->__lock))
>>>                 lock_addr = (__u64)&rq_new->__lock;
>>>         else
>>>                 lock_addr = (__u64)&rq_old->lock;
>>
>> I suspect compiler rewrites it to something like
>>
>>    lock_addr = (__u64)&rq_old->lock;
>>    if (bpf_core_field_exists(rq_new->__lock))
>>         lock_addr = (__u64)&rq_new->__lock;
>>
>> so rq_old relocation always happens and ends up being not guarded
>> properly. You can try adding barrier_var(rq_new) and
>> barrier_var(rq_old) around if and inside branches, that should
>> pessimize compiler
>>
>> alternatively if you do
>>
>> if (bpf_core_field_exists(rq_new->__lock))
>>     lock_addr = (__u64)&rq_new->__lock;
>> else if (bpf_core_field_exists(rq_old->lock))
>>     lock_addr = (__u64)&rq_old->lock;
>> else
>>     lock_addr = 0; /* or signal error somehow */
>>
>> It might work as well.
> 
> Thanks a lot for your comment!
> 
> I've tried the below code but no luck. :(
> 
>         barrier_var(rq_old);
>         barrier_var(rq_new);
> 
>         if (bpf_core_field_exists(rq_old->lock)) {
>             barrier_var(rq_old);
>             lock_addr = (__u64)&rq_old->lock;

Have you tried `BPF_CORE_READ(rq_old, lock)` ?

>         } else if (bpf_core_field_exists(rq_new->__lock)) {
>             barrier_var(rq_new);
>             lock_addr = (__u64)&rq_new->__lock;
>         } else
>             lock_addr = 0;
> 
> 
> ; int BPF_PROG(collect_lock_syms)
> 0: (b7) r8 = 0                        ; R8_w=0
> 1: (b7) r7 = 1                        ; R7_w=1
> 2: <invalid CO-RE relocation>
> failed to resolve CO-RE relocation <byte_off> [381] struct
> rq___old.lock (0:0 @ offset 0)
> processed 3 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read
> 
> Thanks,
> Namhyung

Cheers,
Hengqi
