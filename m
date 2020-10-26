Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99248298A19
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 11:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1747255AbgJZJsN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 05:48:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37009 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1768394AbgJZJr5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Oct 2020 05:47:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id h7so11642286wre.4;
        Mon, 26 Oct 2020 02:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RofcZGS865XP0CJeBO4BVg251gRgyllrJGC9dSHvpIE=;
        b=WoCW0nte1VKuBFW+DHpEF0q3TEBLAhrJniB+2cR1R+Jym+5miy+0H/59Ej7Vjqtxwb
         ELgbqDxczlFqvvYWd8ff9ZpMax8dxulwgEb1e77IFnFxNY4JpCAP6xqtkqhVlzlzVG8o
         vlrc5Az5GD92t07MyuT+H7QSj4ZXWteaG4DwFkAtauPZK+AyssIbtz4ZvGDcIRqegBvN
         TevURipvJPTUC1XVL8+GKYXn3/R2fDOqaIgZWAlrLCih/6rV4s6SDrSUzbJNrappu6dV
         ACB2Y9Ep9LODGceWQF8Ecux1Iku3oC05D9cAcJFirykh7rDoIKayOA+EZ5tP75GFUb5x
         zvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RofcZGS865XP0CJeBO4BVg251gRgyllrJGC9dSHvpIE=;
        b=PvmipAakAqVWGgJHzdhsiD+PKWdpFs1nn1CSSxpKpXtE6JtY21hq8YnS5UPvbpu7UL
         dLmjUBH4veziyzQNdgVyqJr8fDnN5eSrM0z+up/T0blSVU/fwNq3QU0f/N+g06bsWIQu
         foD5HpaYrUJdKM/JewxjkZmo3Kd/ThMwSe+iq4EMmKUW4fAHGl4iw35K1j4Sr9Ukuwow
         PS8gd+1ZOgdmocvl5iKHqNr2PgA9hMnXhGcDueZDcdpQmE1jUkJbZngVafNv+0Rk4LqN
         SFEZ9Q07rTKKjUR0itYIgsUd4g8SO+hxsH3HGb43KNBceAyDf9D+PoTRf4uNO/xX5c36
         ocug==
X-Gm-Message-State: AOAM530qX6w0AgE9nceDxrQwheRQXvzxmzkLxzIq/fLsfOhOJKVGbGZ4
        mn9/RCfQ3nvRec8VmeQcRn0=
X-Google-Smtp-Source: ABdhPJyFM3wn+IiQLQzz50kHLaqHXhKfK4cG0OvqF6sLtSsTrVOcYiUso1oxM/L+lHez4anrJ8+EQw==
X-Received: by 2002:adf:e4ca:: with SMTP id v10mr17870768wrm.53.1603705675151;
        Mon, 26 Oct 2020 02:47:55 -0700 (PDT)
Received: from ?IPv6:2001:a61:245a:d801:2e74:88ad:ef9:5218? ([2001:a61:245a:d801:2e74:88ad:ef9:5218])
        by smtp.gmail.com with ESMTPSA id u15sm22285531wrm.77.2020.10.26.02.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 02:47:54 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Tycho Andersen <tycho@tycho.pizza>,
        Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     Jann Horn <jannh@google.com>
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <CAG48ez3aqLs_-xgU0bThOLqRiiDWGObxcg-X9iFe6D5RDnLVJg@mail.gmail.com>
 <5647b94a-4693-dad0-6e0d-ed178b495d65@gmail.com>
 <CAG48ez1PtJPQLrQ54P+uuuxbt6mri9wcP=1m1wgVuMWOSDMazg@mail.gmail.com>
 <0f41f776-9379-9ee6-df4b-e7538f69313e@gmail.com>
 <CAG48ez1e-xKoJ_1v0DGMZ62WQCG7o7AUw+89DYEVbDpHWrdweA@mail.gmail.com>
 <887d5a29-edaa-2761-1512-370c1f5c3a6f@gmail.com>
 <CAG48ez2TcWb6SQ86XRJDdN-Ab_gO9-sXgpFnJODMXH60mCkBJQ@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <a1921621-6656-c440-2117-2e5f1d31dafd@gmail.com>
Date:   Mon, 26 Oct 2020 10:47:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2TcWb6SQ86XRJDdN-Ab_gO9-sXgpFnJODMXH60mCkBJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jann,

On 10/26/20 10:32 AM, Jann Horn wrote:
> On Sat, Oct 24, 2020 at 2:53 PM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>> On 10/17/20 2:25 AM, Jann Horn wrote:
>>> On Fri, Oct 16, 2020 at 8:29 PM Michael Kerrisk (man-pages)
>>> <mtk.manpages@gmail.com> wrote:
> [...]
>>>> I'm not sure if I should write anything about this small UAPI
>>>> breakage in BUGS, or not. Your thoughts?
>>>
>>> Thinking about it a bit more: Any code that relies on pause() or
>>> epoll_wait() not restarting is buggy anyway, right? Because a signal
>>> could also arrive directly before entering the syscall, while
>>> userspace code is still executing? So one could argue that we're just
>>> enlarging a preexisting race. (Unless the signal handler checks the
>>> interrupted register state to figure out whether we already entered
>>> syscall handling?)
>>
>> Yes, that all makes sense.
>>
>>> If userspace relies on non-restarting behavior, it should be using
>>> something like epoll_pwait(). And that stuff only unblocks signals
>>> after we've already past the seccomp checks on entry.
>>
>> Thanks for elaborating that detail, since as soon as you talked
>> about "enlarging a preexisting race" above, I immediately wondered
>> sigsuspend(), pselect(), etc.
>>
>> (Mind you, I still wonder about the effect on system calls that
>> are normally nonrestartable because they have timeouts. My
>> understanding is that the kernel doesn't restart those system
>> calls because it's impossible for the kernel to restart the call
>> with the right timeout value. I wonder what happens when those
>> system calls are restarted in the scenario we're discussing.)
> 
> Ah, that's an interesting edge case...

I'm going to drop a FIXME into the page source so that
there's a reminder of this issue in the next draft of 
the page, which I'm about to send out.

[...]

Thanks for checking the other pieces, Jann.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
