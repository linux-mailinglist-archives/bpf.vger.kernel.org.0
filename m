Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F414B1387
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 17:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244840AbiBJQwc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 11:52:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244842AbiBJQwb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 11:52:31 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E32CF9
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 08:52:32 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id a39so10438034pfx.7
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 08:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KYFPzgYbktJjID+MKr1ZhGOHsy2/XzdTJL4JW1vqATk=;
        b=HQ+MFfEChQcxUbKmdNCGcZtqr1cZb1o/dCeBoITZFgA7vTZu+r2E9v76pWePBVaObi
         FxAp3QITnw/FKsS6J87YYd+wdoGUUHMXnydnfqkN2GZ4qCvlEsGZWTj5DwJqhNgEGagh
         M6AxfXStnqBEXXjBMgK+yjWJcrFK4MtjXS0ZfGzbZuvwf45Wqg2NyZCExnMRnonrQOQB
         CwpeAYkoSZsHqIg1QneFwspyhfvBQjaC0iEexv+J/oL7JyHVdBmYnob8vksI+vP0dJ9P
         XEjZCQPZcwvGwilZG+uINhEZMHcsBVN54av/XTUvol/HsrqRayUedF0YxLzf+Z1ji2+s
         T1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KYFPzgYbktJjID+MKr1ZhGOHsy2/XzdTJL4JW1vqATk=;
        b=MgRllaCXvshsztNjYzrdtmTJFo7Y6LHBb7sAzy6FDP0pcTa2RWdwJXhJyFsbqiS3ll
         L97jwjhg8m3CUkecP9RSQtIJTGWko05fAMJnHuBXJgp8S+SeJ9/S0FRJWd9dqK7aYqEp
         /sDiESldUyYysKIZWYxrN7zMUkjO4fs7bavJDBe95vsWjJzoCROxAtwycWAPSt08tpbc
         Mit7OZfgXxcqrj+ffqLDN+gJTYt5Mprv3UbW1V7vKzMoteOXxduurXFOGuQeFoXEBZwo
         /i4rhtYAK5YHmJHFIM6IRyi5pVhnImVMHk0b3yjpH27ao/ytLxKrubnWIn9bBRBMJD7d
         GGvQ==
X-Gm-Message-State: AOAM531al0qRy3IZxeYzk3YlSfO2r+mUUzjFkmj7S7fHD6x7xYzVQDhW
        e/DoGj4nmHpk1QgmjeFd53g=
X-Google-Smtp-Source: ABdhPJwLR81lRZl7qNAqnaZry15NabYZwpGSmO/R9KjrUTDt27zcv3qoEKWjW/QTv0dP4ORfg1lMow==
X-Received: by 2002:a63:257:: with SMTP id 84mr6767118pgc.121.1644511951753;
        Thu, 10 Feb 2022 08:52:31 -0800 (PST)
Received: from [0.0.0.0] ([150.109.126.7])
        by smtp.gmail.com with ESMTPSA id j23sm17507251pgb.75.2022.02.10.08.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 08:52:31 -0800 (PST)
Subject: Re: [PATCH bpf-next v3 1/2] libbpf: Add BPF_KPROBE_SYSCALL macro
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
References: <20220207143134.2977852-1-hengqi.chen@gmail.com>
 <20220207143134.2977852-2-hengqi.chen@gmail.com>
 <CAEf4BzaQvpS+Zh3zEmxqPC0nADXdjPV8UoWW90UJ8F7ZBFhQDQ@mail.gmail.com>
 <CAEf4BzZM_HWA3keM=0FPk2j7G0AVcfCNfBXRx0BJj91uC5g21A@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <830e26cc-1897-579c-3714-36c918edf016@gmail.com>
Date:   Fri, 11 Feb 2022 00:52:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZM_HWA3keM=0FPk2j7G0AVcfCNfBXRx0BJj91uC5g21A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/9/22 1:53 PM, Andrii Nakryiko wrote:
> On Mon, Feb 7, 2022 at 1:58 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Mon, Feb 7, 2022 at 6:31 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>>

...

>>
> 
> Now that Ilya's fixes are in again, added a small note about reliance
> on BPF CO-RE and pushed to bpf-next, thanks.
> 
> 

Thanks.

> On a relevant note. The whole __x64_sys_close vs sys_close depending
> on architecture and kernel version was always super annoying. BCC
> makes this transparent to users (AFAIK) and it always bothered me a

BCC does this by 'guessing' the syscall prefix ([0]).

  [0]: https://github.com/iovisor/bcc/blob/v0.24.0/src/python/bcc/__init__.py#L787-L794

> little, but I didn't see a clean solution that fits libbpf.
> 
> I think I finally found it, though. Instead of guessing whether the
> kprobe function is a syscall or not based on "sys_" prefix of a kernel
> function, we can use libbpf SEC() handling to do this transparently.
> What if we define two new SEC() definitions:
> 
> SEC("ksyscall/write") and SEC("kretsyscall/write") (or maybe
> SEC("kprobe.syscall/write") and SEC("kretprobe.syscall/write"), not
> sure which one is better, voice your opinion, please). And for such

ksyscall/kretsyscall is more succinct and in the same vein as kfunc/kretfunc.

> special kprobes, libbpf will perform feature detection of this
> ARCH_SYSCALL_WRAPPER (we'll need to see the best way to do this in a
> simple and fast way, preferably without parsing kallsyms) and

By detecting special structs like struct cpuinfo_x86/cpuinfo_arm64 in BTF ?

In a word, I like the idea and it would make libbpf-based tools more portable. :)

> depending on it substitute either sys_write (or should it be
> __se_sys_write, according to Naveen) or __<arch>_sys_write. You get
> the idea.
> 
> I like that this is still explicit and in the spirit of libbpf, but
> offloads the burden of knowing these intricate differences from users.
> 
> Thoughts?
> 
> 
>> Unfortunately we had to back out Ilya's patches with
>> PT_REGS_SYSCALL_REGS() and PT_REGS_PARMx_CORE_SYSCALL(), so we'll need
>> to wait a bit before merging this.
>>
>>
>>> +#define BPF_KPROBE_SYSCALL(name, args...)                                  \
>>> +name(struct pt_regs *ctx);                                                 \
>>> +static __attribute__((always_inline)) typeof(name(0))                      \
>>> +____##name(struct pt_regs *ctx, ##args);                                   \
>>> +typeof(name(0)) name(struct pt_regs *ctx)                                  \
>>> +{                                                                          \
>>> +       struct pt_regs *regs = PT_REGS_SYSCALL_REGS(ctx);                   \
>>> +       _Pragma("GCC diagnostic push")                                      \
>>> +       _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")              \
>>> +       return ____##name(___bpf_syscall_args(args));                       \
>>> +       _Pragma("GCC diagnostic pop")                                       \
>>> +}                                                                          \
>>> +static __attribute__((always_inline)) typeof(name(0))                      \
>>> +____##name(struct pt_regs *ctx, ##args)
>>> +
>>>  #endif
>>> --
>>> 2.30.2

--
Hengqi
