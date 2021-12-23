Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A069647E304
	for <lists+bpf@lfdr.de>; Thu, 23 Dec 2021 13:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243391AbhLWMLY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Dec 2021 07:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbhLWMLW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Dec 2021 07:11:22 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F11C061401
        for <bpf@vger.kernel.org>; Thu, 23 Dec 2021 04:11:22 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u16so4207856plg.9
        for <bpf@vger.kernel.org>; Thu, 23 Dec 2021 04:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bJXTLCE5+mkrOh9E1wzna3LL0UOF7/ngC1SxKTKJVv4=;
        b=aJDfGvtDh6hEbv2nAUpOzhdgdcMgqsFz+FXx6dcoOUvXcMx2WLHqn0UhzeI+SFY/B0
         KmKJhuyqaGXRBkRdqcpaO0PORUaAbmWT8l6ztQXj/ftr3toW/rKgpSLvKDaYegKw2SLn
         uiiS1JsOkZnID+QEnjgW/caaOS+5WT7LorhQlJot0UPCskpzYb8xHs46iId0v9hN+rIN
         TKyAEBBBsQ3tcgmG2XyKvGvcAF2sXZsuPcJ1Yab4PmSupRC2KDRNrgeWj6eg5OEKL7AO
         6mav0YxPaxgqHhv8M13qqGv1IATXD/Ih1BozNOju+saszgDVzDA3N/2vG0dkedgqpCOO
         TwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bJXTLCE5+mkrOh9E1wzna3LL0UOF7/ngC1SxKTKJVv4=;
        b=oTRQd9bYPYdt7ShPOlqT1VvG1nf8hi++9TUZI4dPpqPTZRaA+QcXbia/gZwC0oCfGj
         WS5BfZ7KsdpdUlo6kIpc26qaJjfLmre39YgJt0L7DKjuejryVu3kieNZ3s33/GEk3W/O
         tgwG+BgtPxohe5UPbkercP59aa3RELPDwLZwsPK54MQu8+nkVN56G7oSPRdfh7kOzyF4
         XYgP+SQ9gw3LmwX1glvYSzHq3Pwz+CnsUqlRJYQ9qVnT5/+9tAcLMJfNHnkbDodGdPVO
         OE4PAqfJG5jeNTs1oGiEkJ9Sztb/xGrfjOy+f8xBuED9zCbWWozpkBqmP+ab6422/r4j
         arsg==
X-Gm-Message-State: AOAM531vA5s08YleJj+ez33hrTTau61j7alZtqcECGsW106db5MsbhNv
        SQt9LTpCfKsE/ucnZgpv03U=
X-Google-Smtp-Source: ABdhPJw7vwfWSXbuBLUm3IZa+uLQyaIBl66qqyeuZKoi99d4Hk3hstzv1FI+IeaL1D2yKAVipbQWIA==
X-Received: by 2002:a17:902:b084:b0:141:f5f8:1c5a with SMTP id p4-20020a170902b08400b00141f5f81c5amr1923575plr.40.1640261481773;
        Thu, 23 Dec 2021 04:11:21 -0800 (PST)
Received: from [192.168.255.10] ([203.205.141.118])
        by smtp.gmail.com with ESMTPSA id c19sm8583776pjv.39.2021.12.23.04.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 04:11:21 -0800 (PST)
Message-ID: <fdf24f25-256a-4254-a846-3d77d3d03601@gmail.com>
Date:   Thu, 23 Dec 2021 20:11:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH bpf-next 1/2] libbpf: Add
 BPF_KPROBE_SYSCALL/BPF_KRETPROBE_SYSCALL macros
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
References: <20211221055312.3371414-1-hengqi.chen@gmail.com>
 <20211221055312.3371414-2-hengqi.chen@gmail.com>
 <CAEf4BzZQy-KUd8D4jj0Th2Po4d8UbQL7xnywRcF3xwy99+127g@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <CAEf4BzZQy-KUd8D4jj0Th2Po4d8UbQL7xnywRcF3xwy99+127g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Andrii

On 2021/12/22 8:18 AM, Andrii Nakryiko wrote:
> On Mon, Dec 20, 2021 at 9:53 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> Add syscall-specific variants of BPF_KPROBE/BPF_KRETPROBE named
>> BPF_KPROBE_SYSCALL/BPF_KRETPROBE_SYSCALL ([0]). These new macros
>> hide the underlying way of getting syscall input arguments and
>> return values. With these new macros, the following code:
>>
>>     SEC("kprobe/__x64_sys_close")
>>     int BPF_KPROBE(do_sys_close, struct pt_regs *regs)
>>     {
>>         int fd;
>>
>>         fd = PT_REGS_PARM1_CORE(regs);
>>         /* do something with fd */
>>     }
>>
>> can be written as:
>>
>>     SEC("kprobe/__x64_sys_close")
>>     int BPF_KPROBE_SYSCALL(do_sys_close, int fd)
>>     {
>>         /* do something with fd */
>>     }
>>
>>   [0] Closes: https://github.com/libbpf/libbpf/issues/425
>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
> 
> As Yonghong mentioned, let's wait for PT_REGS_PARMx_SYSCALL macros to
> land and use those (due to 4th argument quirkiness on x86 arches).
> 

I see those patches, will wait.

>>  tools/lib/bpf/bpf_tracing.h | 45 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>
>> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
>> index db05a5937105..eb4b567e443f 100644
>> --- a/tools/lib/bpf/bpf_tracing.h
>> +++ b/tools/lib/bpf/bpf_tracing.h
>> @@ -489,4 +489,49 @@ typeof(name(0)) name(struct pt_regs *ctx)                              \
>>  }                                                                          \
>>  static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
>>
>> +#define ___bpf_syscall_args0() ctx, regs
>> +#define ___bpf_syscall_args1(x) \
>> +       ___bpf_syscall_args0(), (void *)PT_REGS_PARM1_CORE(regs)
>> +#define ___bpf_syscall_args2(x, args...) \
>> +       ___bpf_syscall_args1(args), (void *)PT_REGS_PARM2_CORE(regs)
>> +#define ___bpf_syscall_args3(x, args...) \
>> +       ___bpf_syscall_args2(args), (void *)PT_REGS_PARM3_CORE(regs)
>> +#define ___bpf_syscall_args4(x, args...) \
>> +       ___bpf_syscall_args3(args), (void *)PT_REGS_PARM4_CORE(regs)
>> +#define ___bpf_syscall_args5(x, args...) \
>> +       ___bpf_syscall_args4(args), (void *)PT_REGS_PARM5_CORE(regs)
>> +#define ___bpf_syscall_args(args...) \
>> +       ___bpf_apply(___bpf_syscall_args, ___bpf_narg(args))(args)
> 
> try keeping each definition on a single line, make them much more
> readable and I think still fits in 100 character limit
> 

This should be addressed by your patch, will build on top of it.

>> +
>> +/*
>> + * BPF_KPROBE_SYSCALL is a variant of BPF_KPROBE, which is intended for
>> + * tracing syscall functions. It hides the underlying platform-specific
> 
> let's add a simple example to explain what kind of tracing syscall
> functions we mean.
> 
> "tracing syscall functions, like __x64_sys_close." ?
> 
>> + * low-level way of getting syscall input arguments from struct pt_regs, and
>> + * provides a familiar typed and named function arguments syntax and
>> + * semantics of accessing syscall input paremeters.
> 
> typo: parameters
> 

Ack.

>> + *
>> + * Original struct pt_regs* context is preserved as 'ctx' argument. This might
>> + * be necessary when using BPF helpers like bpf_perf_event_output().
>> + */
>> +#define BPF_KPROBE_SYSCALL(name, args...)                                  \
>> +name(struct pt_regs *ctx);                                                 \
>> +static __attribute__((always_inline)) typeof(name(0))                      \
>> +____##name(struct pt_regs *ctx, struct pt_regs *regs, ##args);             \
>> +typeof(name(0)) name(struct pt_regs *ctx)                                  \
>> +{                                                                          \
>> +       _Pragma("GCC diagnostic push")                                      \
>> +       _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")              \
>> +       struct pt_regs *regs = PT_REGS_PARM1(ctx);                          \
> 
> please move it out of _Pragma region, no need to guard it
> 

Ack.

>> +       return ____##name(___bpf_syscall_args(args));                       \
>> +       _Pragma("GCC diagnostic pop")                                       \
>> +}                                                                          \
>> +static __attribute__((always_inline)) typeof(name(0))                      \
>> +____##name(struct pt_regs *ctx, struct pt_regs *regs, ##args)
> 
> I don't think we need to add another magical hidden argument "regs".
> Anyone who will need it for something can get it from the hidden ctx
> with PT_REGS_PARM1(ctx) anyways.
> 

Yes, this should be removed, otherwise it may conflict with user-defined args.

>> +
>> +/*
>> + * BPF_KRETPROBE_SYSCALL is just an alias to BPF_KRETPROBE,
>> + * it provides optional return value (in addition to `struct pt_regs *ctx`)
>> + */
>> +#define BPF_KRETPROBE_SYSCALL BPF_KRETPROBE
>> +
> 
> hm... do we even need BPF_KRETPROBE_SYSCALL then? Let's drop it, it
> doesn't provide much value, just creates a confusion.
> 

OK, will drop it.

> 
>>  #endif
>> --
>> 2.30.2

---
Hengqi
