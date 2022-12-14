Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CFB64C220
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 03:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbiLNCHZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 21:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbiLNCHW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 21:07:22 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67613233A6
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 18:07:20 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id x2so550079plb.13
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 18:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9tFGD6ohuupNWyTi4yRpR9rQncYAz/CLsSQD15g3DQw=;
        b=NliDi9V1wIp5C7LB/ObD6Uv7lbJ7y+4PjzSth8LUPOV8973LldRUaTGu4bpgeY9Awx
         x7kiYJmpHtPYsO7tK1YCODusXfIPvnRS+o6AC8TQeNUpSvfuSEcjv8krWbIHCpuDMCfh
         AGknCk2PJOLqeIKZZF4FccpcD5OgS6beuGjtrR17w8KYK0JqBxugBcGAi/G++QBN1JGd
         0Q9FTqT1pZIJJuW3yLH3TIV35p6vK7D4e0RHNvmLSsxyuSZmIU1hmsKiQNRbBqHzsJEO
         1hnIdK1hs6KLZT1llTC0GtVDH2VaWmoV5c2SNEhFClAoAbIGXZJ8obzHI6hm3E35uHSi
         lrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tFGD6ohuupNWyTi4yRpR9rQncYAz/CLsSQD15g3DQw=;
        b=0c4eT6jzoS17lmP6SNYM+4vUVD6ctV2V8nQke6WWdzhhjquxSsLWVm1TZaDhsHuUOK
         t4bawqw/3hWO2HSJoFTP95itQwO/xMdS67hcUtA0ibnF+k+cgUYe71Tg7l1BNEj29q0t
         mlJOPA4Rlo9fObFvjYlsb9wwx0i49SRnqXVK+DkO+3ENy1rl6uA+wHeK0Pn5tHcX+RGN
         SppJQTk1GD0vwojYEcEozEaKcIPqsHaZWpiea4e4ca61POzKkWUfmFoSDUB+PFuGyAAL
         e2nXl++QKDQLw+P8jV5MAgeNJh2/j7RrMRs8blx1VNrTv63XllWGwG3h2zaB49eWhH+Z
         0Gfw==
X-Gm-Message-State: ANoB5pmvcfAoxLh6O2eiO5IL8No+Q9zr0MxQvOlJP7HGgjRgYHT96chC
        L2ndSqMTaiLdI2BZXz5ZQcs=
X-Google-Smtp-Source: AA0mqf7OehWlVEvh/i8SYO7cBSbXM+r8reMgG4kvmCyMjtdSxcCNCAkU3CILsMdPQqL5JaTsyNPgpw==
X-Received: by 2002:a17:90a:6ac9:b0:219:53fd:2cb9 with SMTP id b9-20020a17090a6ac900b0021953fd2cb9mr22838385pjm.7.1670983639869;
        Tue, 13 Dec 2022 18:07:19 -0800 (PST)
Received: from [192.168.255.10] ([43.132.98.40])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090abf8500b0020b2082e0acsm198254pjs.0.2022.12.13.18.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 18:07:19 -0800 (PST)
Message-ID: <d610919b-816d-a9af-d8f4-ce524ae9540b@gmail.com>
Date:   Wed, 14 Dec 2022 10:07:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next] libbpf: Add LoongArch support to bpf_tracing.h
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, yangtiezhu@loongson.cn
References: <20221212091136.969960-1-hengqi.chen@gmail.com>
 <CAEf4BzaxYmBxYx=rfAyOn0kBHf3qOt6mPCPsyfrM+3rYcQ8MMQ@mail.gmail.com>
 <CAEf4BzbX-DCvjvJsHgZC+TbLnru5R-0Oy3GfVkw7rjdtSR8e8g@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <CAEf4BzbX-DCvjvJsHgZC+TbLnru5R-0Oy3GfVkw7rjdtSR8e8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/12/14 06:09, Andrii Nakryiko wrote:
> On Mon, Dec 12, 2022 at 4:17 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Mon, Dec 12, 2022 at 1:11 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>>
>>> Add PT_REGS macros for LoongArch64.
>>>
>>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>>> ---
>>>  tools/lib/bpf/bpf_tracing.h | 21 +++++++++++++++++++++
>>>  1 file changed, 21 insertions(+)
>>>
>>> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
>>> index 2972dc25ff72..2d7da1caa961 100644
>>> --- a/tools/lib/bpf/bpf_tracing.h
>>> +++ b/tools/lib/bpf/bpf_tracing.h
>>> @@ -32,6 +32,9 @@
>>>  #elif defined(__TARGET_ARCH_arc)
>>>         #define bpf_target_arc
>>>         #define bpf_target_defined
>>> +#elif defined(__TARGET_ARCH_loongarch)
>>> +       #define bpf_target_loongarch
>>> +       #define bpf_target_defined
>>>  #else
>>>
>>>  /* Fall back to what the compiler says */
>>> @@ -62,6 +65,9 @@
>>>  #elif defined(__arc__)
>>>         #define bpf_target_arc
>>>         #define bpf_target_defined
>>> +#elif defined(__loongarch__) && __loongarch_grlen == 64
>>> +       #define bpf_target_loongarch
>>> +       #define bpf_target_defined
>>>  #endif /* no compiler target */
>>>
>>>  #endif
>>> @@ -258,6 +264,21 @@ struct pt_regs___arm64 {
>>>  /* arc does not select ARCH_HAS_SYSCALL_WRAPPER. */
>>>  #define PT_REGS_SYSCALL_REGS(ctx) ctx
>>>
>>> +#elif defined(bpf_target_loongarch)
>>> +
>>> +#define __PT_PARM1_REG regs[5]
>>> +#define __PT_PARM2_REG regs[6]
>>> +#define __PT_PARM3_REG regs[7]
>>> +#define __PT_PARM4_REG regs[8]
>>> +#define __PT_PARM5_REG regs[9]
>>> +#define __PT_RET_REG regs[1]
>>> +#define __PT_FP_REG regs[22]
>>> +#define __PT_RC_REG regs[4]
>>> +#define __PT_SP_REG regs[3]
>>> +#define __PT_IP_REG csr_era
>>> +/* loongarch does not select ARCH_HAS_SYSCALL_WRAPPER. */
>>> +#define PT_REGS_SYSCALL_REGS(ctx) ctx
>>
>> Is there some online documentation explaining this architecture's
>> calling conventions? It would be useful to include that as a comment
>> to be able to refer back to it. On a related note, are there any
>> syscall specific calling convention differences, similar to
>> PT_REGS_PARM1_SYSCALL for arm64 or PT_REGS_PARM4_SYSCALL for x86-64?
>>
> 
> Ok, I think [0] would be a good resource, please add a link to it in
> the comment. But also it seems like PARM1-5 should map to regs[6]
> through regs[10] (not regs[5] - regs[9] that you have here). And BTW,
> seems like architecture supports passing more than five, PARM6 would
> be regs[11]. I've been wanting to add 6th+ argument to libbpf macros'
> for a while (it came up in x86-64 world for uprobes as well), so if
> you have cycles, please consider helping with that as well.
> 

I've seen this on GitHub. Let me have a try.

> Also I see orig_a0 in struct pt_regs, which seems suspiciously similar
> to arm64's PT_REGS_PARM1_SYSCALL's use of orig_x0, please check about
> that as well. As I said, syscalls usually have some additional quirks.
> 
> 
>   [0] https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-EN.html
> 
> 
>>> +
>>>  #endif
>>>
>>>  #if defined(bpf_target_defined)
>>> --
>>> 2.31.1

Thanks, Andrii.

After some investigation, I do find some quirks on syscalls. Will update this patch.
