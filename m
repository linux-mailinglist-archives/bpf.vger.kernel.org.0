Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE004373521
	for <lists+bpf@lfdr.de>; Wed,  5 May 2021 08:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhEEG4k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 May 2021 02:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhEEG4j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 May 2021 02:56:39 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A00C061574
        for <bpf@vger.kernel.org>; Tue,  4 May 2021 23:55:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id t4so1170534ejo.0
        for <bpf@vger.kernel.org>; Tue, 04 May 2021 23:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UcWpgxZF5ZX5UQ00Ioz0ZVTWucpn0MOFfGqU54veXFI=;
        b=RKGTB09CGhwWkJg1JtI0lfM4Tn77i0e7zGoxbV1chMfUwsVXBPHIS8SUnvHLY5mJ1o
         HDXZ0yradP3eLM4eX0KoXeRT6RjbP10pYtOzv8URjzddtsAlSesjO9fG0InuT8ht61Jx
         ano4h8aM+2GAYQb7rfhsTyH8hWtwprsBeRazE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UcWpgxZF5ZX5UQ00Ioz0ZVTWucpn0MOFfGqU54veXFI=;
        b=MQ4OSd3hp5Tdpvyw5rM7ilDKxeLCkd42ubA9+Q6EuwbtetdR5IIKk3kjyrpXWnPbKS
         cj7tyBcWsR7f77VS9NJ7yAunUw6jah2Vwsj/NBu/BYPfsgBPPBiW3C0tknI+XyYgO8/i
         YUkynAMCI3+nwA2YZVLNzS5nnV8dvyFr04gdB1C3YnM9fctMEXjeXXW0Jyo+N4YcpKse
         CMbp9zMGXW3ZNrPeIx5hJBHFjQEbxVXjt42BuwJiyQiGPlMNU3JY9siD9HwlIEwo2hyk
         pYT8lBRy+KkHkP4roDNPKoPqLueIybUbAmOQknhMqkW0N53hFy6T9otG1LQlYhkRPfdU
         Zc2g==
X-Gm-Message-State: AOAM533JHVBDC2fXlHOgJu1OxuchKDMiqolN6xrIOtTwVy+4I6wVWvFH
        G/wBSq1baLXuav4cWAssezT2Qw==
X-Google-Smtp-Source: ABdhPJxpv8VwGBkzlzGVvEsotr19c5syvUBduuZjs3WuZ2/gJRcc+M2mJozQzLmoGOWYZd3l8lQwyw==
X-Received: by 2002:a17:906:8693:: with SMTP id g19mr22654025ejx.270.1620197740883;
        Tue, 04 May 2021 23:55:40 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id z22sm2387789ejo.113.2021.05.04.23.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 23:55:40 -0700 (PDT)
Subject: Re: [PATCH bpf-next v5 6/6] selftests/bpf: Add a series of tests for
 bpf_snprintf
To:     Florent Revest <revest@chromium.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210419155243.1632274-1-revest@chromium.org>
 <20210419155243.1632274-7-revest@chromium.org>
 <CAEf4BzZUM4hb9owhompwARabRvRbCYxBrpgXSdXM8RRm42tU1A@mail.gmail.com>
 <CABRcYm+=XSt_U-19eYXU8+XwDUXoBGQMROMbm6xk9P9OHnUW_A@mail.gmail.com>
 <CAEf4BzZnkYDAm2R+5R9u4YEdZLj=C8XQmpT=iS6Qv0Ne7cRBGw@mail.gmail.com>
 <CABRcYmLn2S2g-QTezy8qECsU2QNSQ6wyjhuaHpuM9dzq97mZ7g@mail.gmail.com>
 <2db39f1c-cedd-b9e7-2a15-aef203f068eb@rasmusvillemoes.dk>
 <CABRcYmJdTZAhdD_2OVAu-hOnYX-bgvrrbnUjaV23tzp-c+9_8w@mail.gmail.com>
 <CAEf4BzaHqvxuosYP32WLSs_wxeJ9FfR2wGRKqsocXHCJUXVycw@mail.gmail.com>
 <CABRcYm+pO94dFW83SZCtKQE8x6PkRicr+exGD3CNwGwQUYmFcw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f0888d2a-3a31-e454-001c-e46cc21b1664@rasmusvillemoes.dk>
Date:   Wed, 5 May 2021 08:55:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CABRcYm+pO94dFW83SZCtKQE8x6PkRicr+exGD3CNwGwQUYmFcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 28/04/2021 16.59, Florent Revest wrote:
> On Tue, Apr 27, 2021 at 8:03 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Tue, Apr 27, 2021 at 2:51 AM Florent Revest <revest@chromium.org> wrote:
>>>
>>> On Tue, Apr 27, 2021 at 8:35 AM Rasmus Villemoes
>>> <linux@rasmusvillemoes.dk> wrote:
>>>>         u64 args[MAX_TRACE_PRINTK_VARARGS] = { arg1, arg2, arg3 };
>>>> -       enum bpf_printf_mod_type mod[MAX_TRACE_PRINTK_VARARGS];
>>>> +       u32 *bin_args;
>>>>         static char buf[BPF_TRACE_PRINTK_SIZE];
>>>>         unsigned long flags;
>>>>         int ret;
>>>>
>>>> -       ret = bpf_printf_prepare(fmt, fmt_size, args, args, mod,
>>>> -                                MAX_TRACE_PRINTK_VARARGS);
>>>> +       ret = bpf_bprintf_prepare(fmt, fmt_size, args, &bin_args,
>>>> +                                 MAX_TRACE_PRINTK_VARARGS);
>>>>         if (ret < 0)
>>>>                 return ret;
>>>>
>>>> -       ret = snprintf(buf, sizeof(buf), fmt, BPF_CAST_FMT_ARG(0, args, mod),
>>>> -               BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod));
>>>> -       /* snprintf() will not append null for zero-length strings */
>>>> -       if (ret == 0)
>>>> -               buf[0] = '\0';
>>>> +       ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);
>>>>
>>>>         raw_spin_lock_irqsave(&trace_printk_lock, flags);
>>>>         trace_bpf_trace_printk(buf);
>>>>         raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
>>>>
>>>> Why isn't the write to buf[] protected by that spinlock? Or put another
>>>> way, what protects buf[] from concurrent writes?
>>>
>>> You're right, that is a bug, I missed that buf was static and thought
>>> it was just on the stack. That snprintf call should be after the
>>> raw_spin_lock_irqsave. I'll send a patch. Thank you Rasmus. (before my
>>> snprintf series, there was a vsprintf after the raw_spin_lock_irqsave)
> 
> Solved now
> 
>> Can you please also clean up unnecessary ()s you added in at least a
>> few places. Thanks.
> 
> Alexei said he took care of this .:)
> 
>>>> Probably the test cases are not run in parallel, but this is the kind of
>>>> thing that would give those symptoms.
>>>
>>> I think it's a separate issue from what Andrii reported though because
>>> the flaky test exercises the bpf_snprintf helper and this buf spinlock
>>> bug you just found only affects the bpf_trace_printk helper.
>>>
>>> That being said, it does smell a little bit like a concurrency issue
>>> too, indeed. The bpf_snprintf test program is a raw_tp/sys_enter so it
>>> attaches to all syscall entries and most likely gets executed many
>>> more times than necessary and probably on parallel CPUs. The "pad_out"
>>> buffer they write to is unique and not locked so maybe the test's
>>> userspace reads pad_out while another CPU is writing on it and if the
>>> string output goes through a stage where it is "    4 0000" before
>>> being "    4 000", we might read at the wrong time. That being said, I
>>> would find it weird that this happens as much as 50% of the time and
>>> always specifically on that test case.
>>>
>>> Andrii could you maybe try changing the prog type to
>>> "tp/syscalls/sys_enter_nanosleep" on the machine where you can
>>> reproduce this bug ?
>>
>> Yes, it helps. I can't repro it easily anymore.
> 
> Good, so it does sound like a concurrency issue indeed
> 
>> I think the right fix, though, should be to filter by tid, not change the tracepoint.
> 
> Agreed, I'll send a patch for that today. :)
> 
>> I think what's happening is we see the string right before bstr_printf
>> does zero-termination with end[-1] = '\0'; So in some cases we see
>> truncated string, in others we see untruncated one.
> 
> Makes sense but I still wonder why it happens so often (50% of the
> time is really a lot) and why it is consistently that one test case
> that fails and not the "overflow" case for example. But I'm confident
> that this is not a bug in the helper now and that the tid filter will
> fix the test.
> 

If the caller, or one of its sibling threads, inspects the buffer before
(v)snprintf has returned it's very obviously a bug in the caller. As for
why that particular case exposes the race: It seems to be the only one
that "expects" an insanely long result, and it takes a very very long
time (several cycles per byte I'd assume) for the vsnprintf code to very
carefully go through the

  if (buf < end)
     *buf = /* '0' or ' ' or whatever it is it is emitting here */
  buf++;

900k times. So there's simply a very large window where the buffer
contents is "    4 0000" while number() is still 'emitting' 0s until
control returns to vsnprintf() which does that final end[-1] = '\0'.

Rasmus

