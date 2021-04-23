Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BDA3694C4
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 16:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhDWOcd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Apr 2021 10:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhDWOcd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Apr 2021 10:32:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26D2C061574
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 07:31:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r20so24465404ejo.11
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Po06NcnT9yNS5y0Tdw+z+LUZj1goxErV8JsQ4hnl1f8=;
        b=h2sigU193ei7wlls3OtQxPVANPWHCDuUQdHwG9ltnN//J0Y+dgEP64zStBizdjw7B+
         c5XCST0dVO3wfJIGUSRxXtvohSa1ELxPpXtNky0BGp5I5bLY15sX/zsnmFYx71TGvTZU
         0tNlwjM31HwVyWv/Gwt19ZBLR1YKBsNQT8VUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Po06NcnT9yNS5y0Tdw+z+LUZj1goxErV8JsQ4hnl1f8=;
        b=jYra9d/VOl//2b4puB7X7jLO4znG0IJrEVCROzDTJDKCt7Iz5Fykv4CBbWmkdUDs0i
         wShGIFiWUWVHLQ5ex9bzHmsCXBCGtk3Pwf8I9A5xFW/MvuoQ+O32RANnWoqIU9NkAi6X
         gy3yY74sKhdxVzCu7Tp1qfC1sLyeVs8jPiLtmrB5yu434brQupB2KESaxvV8mx/bPy91
         +PTaX+2sEjuuNc2HYK8J3OJWA6ooCrgfp754AH+JMI8sUGnnSLBYDRgQ3wDSyXAStjaO
         kPlBHcyDHdxFCGJeDX/1z7Vr+HBHVYiP7zNsP3nT994El+3bNy6ppf+A3qynUcsfL0QK
         MdtA==
X-Gm-Message-State: AOAM532cefUzsI5RudWceWjgjg8krafJoe3LX8QmI75AZ0UkFR6+C+WR
        9fi/IIeaD5q2BzaknuuSdocqiQ==
X-Google-Smtp-Source: ABdhPJzxo07/NknLqD5JUK4v3yRS/SIjczGsIh8TkIp5c36iA9BoNwxl5nrsA9zdEXJV0KvkNa0Hjw==
X-Received: by 2002:a17:906:1101:: with SMTP id h1mr4686184eja.179.1619188315737;
        Fri, 23 Apr 2021 07:31:55 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id s9sm4602492edd.16.2021.04.23.07.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 07:31:55 -0700 (PDT)
Subject: Re: [PATCH bpf-next 0/2] Implement BPF formatted output helpers with
 bstr_printf
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20210423011517.4069221-1-revest@chromium.org>
 <8f89faf1-d7e6-ebe0-fb7d-c5b8243d140a@rasmusvillemoes.dk>
 <CABRcYmLDBfoM8rOwPf+SdqkmJgtFRLYF94S4Fv2eU=Uwg4asTQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8ef7319d-7692-0067-bb86-a0d5465e997f@rasmusvillemoes.dk>
Date:   Fri, 23 Apr 2021 16:31:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CABRcYmLDBfoM8rOwPf+SdqkmJgtFRLYF94S4Fv2eU=Uwg4asTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23/04/2021 15.26, Florent Revest wrote:
> On Fri, Apr 23, 2021 at 10:50 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>

>>> This solves a bug reported by Rasmus Villemoes that would mangle
>>> arguments on 32 bit machines.
>>
>> That's not entirely accurate. The arguments are also mangled on x86-64,
>> it's just that in a few cases that goes unnoticed. That's why I
>> suggested you try and take your test case (which I assume had been
>> passing with flying colours on x86-64) and rearrange the specifiers,
>> arguments and expected output string so that the (morally) 32 bit
>> arguments end up beyond those-that-end-up-in-the-reg_save_area.
>>
>> IOWs, it is the 32 bit arguments that are mangled (because they get
>> passed as-if they were actually 64 bits), and that applies on all
>> architectures; nothing to do with sizeof(long).
> 
> Mh, yes, I get your point and I agree that my description does not
> really fit what you reported.
> 
> I tried what you suggested though, with the current bpf-next/master on x86_64:
> BPF_SNPRINTF(out, sizeof(out),
> "%u %d %u %d %u %d %u %d %u %d %u %d",
> 1, -2, 3, -4, 5, -6, 7, -8, 9, -10, 11, -12);
> 
> And out is "1 -2 3 -4 5 -6 7 -8 9 -10 11 -12" so i can't seem to be
> able to produce the bug you described.
> Do you think I'm missing something? Would you try it differently ?
> 

Nah, sorry, I must have misremembered the x86-64 ABI. Re-reading it, it
clearly says as the very first thing "The size of each argument gets
rounded up to eightbytes". So each of the ints that get passed on the
stack do indeed occupy 8 bytes (i.e., the overflow_area pointer gets
adjusted by 8 bytes, for both va_arg(ap, int) and va_arg(ap, long)). So
it will indeed work on x86-64. And probably other 64 bit ABIs behave the
same way (it would make sense) - at least ppc64 and arm64 seem to behave
like that.

So in a round-about way it's probably true that the bug would only be
seen on 32 bit machines, but only because all (relevant) 64 bit arches
seem to, on the ABI level, effectively do argument promotion to u64 anyway.

Rasmus
