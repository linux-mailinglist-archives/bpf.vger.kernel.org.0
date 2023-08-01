Return-Path: <bpf+bounces-6595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ECB76BB45
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 19:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D75281B59
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 17:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C9C23581;
	Tue,  1 Aug 2023 17:31:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231812150D
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 17:31:46 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8883B2100
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 10:31:45 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-585fd99ed8bso589497b3.1
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690911104; x=1691515904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7V7CgizA+S2dSYy4LSY1aCPUl85QOPvPuXH36/47e04=;
        b=JQ97lIZRetLkU8P4bcvJaX+9iW1IBy6AYzhNxPx1xIvR1BXZjg30NweeTOCw/k5GbT
         sdN55E6jr3AT/dSxocR2qVn1ov9zDh92xpo9drku7Du18NxEfNyhdnuwK5uovky0aI1M
         vaW8KgdWpCJj0bGW0Io4B0SEYSFgGb0RAABbsWVlpE4YTHhmY8R1RkK1fiHHnafP6JI2
         9cLKiATypbd7+91+NZ7hrLKIUsCWs0n9hdaftOXai5yds04yyiVGFhZQfLqJg+vBWkET
         6jFuuVB7wxSoy9BrfcnCv3WHeeZC/XRYmhiMidTYYMU/ueibVfSJ3Z1SozRkWYFGcavo
         3daA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690911104; x=1691515904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7V7CgizA+S2dSYy4LSY1aCPUl85QOPvPuXH36/47e04=;
        b=jNP6e7HrGWYp+6EhPa4z+trr0sC6TsCqAUQt7I5M0N2dPcjpWOe6bNFm37PgJW8ANN
         Vwt5bLaoZLXzMPAPMqmM1Bmu1KK/SIRsDlWT9e/xwGZIiSM2aK/TeexGg8OpmQi8LygX
         H9tJTXqkdMYTUpJdFdUCgT7DdPXzGJM7ITRxH65p40q8b7Ef+Hb+qjJQkyAi0H+keAEB
         QkeJpOMrCOlYaOufz+/z8uMwEMQOmQ8dVUuKz60hIkyFlHknlr+x4MI4ZWp2eoJlzD+J
         wejef6gHxa5sktGp0LG24BARefNZaDgCb3KdLTtywBlJc32fwzLs9ITAVGFmcTtfDu0X
         rKmA==
X-Gm-Message-State: ABy/qLaJ7GLzmeSwk6hAW7XX12TCpAgU0u3kfBzHU/vyDxY+MccIEpTw
	u5J7izQ1qr4xfpj6lUeuhEkFrbQULGs=
X-Google-Smtp-Source: APBJJlE1do7Rh80b1u1U9iX2RS0dsFYkAVp5PBTlhBA+PIHn+vGoxJ2xhGeC+Zes5iY51rnD1qHwBg==
X-Received: by 2002:a0d:dd11:0:b0:579:dfc5:20cc with SMTP id g17-20020a0ddd11000000b00579dfc520ccmr15439559ywe.17.1690911104630;
        Tue, 01 Aug 2023 10:31:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:b827:13ed:6fde:4670? ([2600:1700:6cf8:1240:b827:13ed:6fde:4670])
        by smtp.gmail.com with ESMTPSA id h13-20020a816c0d000000b00579e8c7e478sm3907407ywc.43.2023.08.01.10.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 10:31:44 -0700 (PDT)
Message-ID: <bf361930-7d39-531f-d21a-a4e436b2a544@gmail.com>
Date: Tue, 1 Aug 2023 10:31:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC bpf-next 1/5] bpf: enable sleepable BPF programs attached to
 cgroup/{get,set}sockopt.
To: Stanislav Fomichev <sdf@google.com>
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
References: <20230722052248.1062582-1-kuifeng@meta.com>
 <20230722052248.1062582-2-kuifeng@meta.com> <ZL7Ery1lzqj4as7N@google.com>
 <00dbd930-5ec2-7fb6-202b-38d09e13eb0b@gmail.com>
 <CAKH8qBvcD7r0e-0oZryLHyGnsNnZ66w6tHj5t4Qi1SzONnwN+w@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAKH8qBvcD7r0e-0oZryLHyGnsNnZ66w6tHj5t4Qi1SzONnwN+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/31/23 16:35, Stanislav Fomichev wrote:
> On Mon, Jul 31, 2023 at 3:02 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>> Sorry for the late reply! I just backed from a vacation.
>>
>>
>> On 7/24/23 11:36, Stanislav Fomichev wrote:
>>> On 07/21, kuifeng@meta.com wrote:
>>>> From: Kui-Feng Lee <kuifeng@meta.com>
>>>>
>>>> Enable sleepable cgroup/{get,set}sockopt hooks.
>>>>
>>>> The sleepable BPF programs attached to cgroup/{get,set}sockopt hooks may
>>>> received a pointer to the optval in user space instead of a kernel
>>>> copy. ctx->user_optval and ctx->user_optval_end are the pointers to the
>>>> begin and end of the user space buffer if receiving a user space
>>>> buffer. ctx->optval and ctx->optval_end will be a kernel copy if receiving
>>>> a kernel space buffer.
>>>>
>>>> A program receives a user space buffer if ctx->flags &
>>>> BPF_SOCKOPT_FLAG_OPTVAL_USER is true, otherwise it receives a kernel space
>>>> buffer.  The BPF programs should not read/write from/to a user space buffer
>>>> dirrectly.  It should access the buffer through bpf_copy_from_user() and
>>>> bpf_copy_to_user() provided in the following patches.
>>>>
>>>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>>>> ---
>>>>    include/linux/filter.h         |   3 +
>>>>    include/uapi/linux/bpf.h       |   9 ++
>>>>    kernel/bpf/cgroup.c            | 189 ++++++++++++++++++++++++++-------
>>>>    kernel/bpf/verifier.c          |   7 +-
>>>>    tools/include/uapi/linux/bpf.h |   9 ++
>>>>    tools/lib/bpf/libbpf.c         |   2 +
>>>>    6 files changed, 176 insertions(+), 43 deletions(-)
>>>>
>>>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>>>> index f69114083ec7..301dd1ba0de1 100644
>>>> --- a/include/linux/filter.h
>>>> +++ b/include/linux/filter.h
>>>> @@ -1345,6 +1345,9 @@ struct bpf_sockopt_kern {
>>>>       s32             level;
>>>>       s32             optname;
>>>>       s32             optlen;
>>>> +    u32             flags;
>>>> +    u8              *user_optval;
>>>> +    u8              *user_optval_end;
>>>>       /* for retval in struct bpf_cg_run_ctx */
>>>>       struct task_struct *current_task;
>>>>       /* Temporary "register" for indirect stores to ppos. */
>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>>> index 739c15906a65..b2f81193f97b 100644
>>>> --- a/include/uapi/linux/bpf.h
>>>> +++ b/include/uapi/linux/bpf.h
>>>> @@ -7135,6 +7135,15 @@ struct bpf_sockopt {
>>>>       __s32   optname;
>>>>       __s32   optlen;
>>>>       __s32   retval;
>>>> +
>>>> +    __bpf_md_ptr(void *, user_optval);
>>>> +    __bpf_md_ptr(void *, user_optval_end);
>>>
>>> Can we re-purpose existing optval/optval_end pointers
>>> for the sleepable programs? IOW, when the prog is sleepable,
>>> pass user pointers via optval/optval_end and require the programs
>>> to do copy_to/from on this buffer (even if the backing pointer might be
>>> in kernel memory - we can handle that in the kfuncs?).
>>>
>>> The fact that the program now needs to look at the flag
>>> (BPF_SOCKOPT_FLAG_OPTVAL_USER) and decide which buffer to
>>> use makes the handling even more complicated; and we already have a
>>> bunch of hairy stuff in these hooks. (or I misreading the change?)
>>>
>>> Also, regarding sleepable and non-sleepable co-existence: do we really need
>>> that? Can we say that all the programs have to be sleepable
>>> or non-sleepable? Mixing them complicates the sharing of that buffer.
>>
>> I considered this approach as well. This is an open question for me.
>> If we go this way, it means we can not attach a BPF program of a type
>> if any program of the other type has been installed.
> 
> If we pass two pointers (kernel copy buffer + real user mem) to the
> sleepable program, we'll make it even more complicated by inheriting
> all existing warts of the non-sleepable version :-(
> IOW, feels like we should try to see if we can have some
> copy_to/from_user kfuncs in the sleepable version that transparently
> support either kernel or user memory (and prohibit direct access to
> user_optval in the sleepable version).
> And then, if we have one non-sleepable program in the chain, we can
> fallback everything to the kernel buffer (maybe).
> This way seems like we can support both versions in the same chain and
> have a more sane api?

Basically, you are saying to move cp_from_optval() and cp_to_optval() in
the testcase to kfuncs. This can cause unnecessary copy. We can add
an API to make a dynptr from the ctx to avoid unnecessary copies.

