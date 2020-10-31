Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABAC2A143B
	for <lists+bpf@lfdr.de>; Sat, 31 Oct 2020 09:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgJaIv6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 31 Oct 2020 04:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgJaIv5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 31 Oct 2020 04:51:57 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D7FC0613D5;
        Sat, 31 Oct 2020 01:51:57 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b8so8922597wrn.0;
        Sat, 31 Oct 2020 01:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+69KEmce40v1epkbBxC+EGokBd+WLifMbLXb2C4t/lA=;
        b=tQB+6tZP3FxHXK7vRjRjl/DIqF0zdN8CH995uIGjnRYMeb7zfG3AnSikMcEhoErZ7L
         aeZ26T5pUjYsPq/DvXOWuE4qkkvHAROor6YF7IH8C6ibRohhhXEeOJfqgrO2+rFK1Twx
         y2uzRz7LyHoBOmO0eg1H+WhIW+DHKLEA3QP6eSYvxBPSQvLm+UAsFrOz5plzIA38Cs0z
         /NOmTMk8SsuKG6JRVKssbaZy9i+TTP/1j3sn8fQ7CTcGwfemBuIrXF0hfxdJDs/8EWSp
         pd3YD52nz5BO+nxcIFQ5TZ1Lu153VJI0TbvtpZFPXPg4YG8Dqfg6Dc1xeWccNOM/nzE8
         g0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+69KEmce40v1epkbBxC+EGokBd+WLifMbLXb2C4t/lA=;
        b=Hl0XZtDTzk26+3dk5SFVUcxG7pEFVt3jFIj8OD0NgFnwV5YeeBvsxM36B6lrcmK1YB
         FTepLPbgRpaOrgAWbTCryiM889FIINj1P5xNpoEADHxlHMXYdLWpbsjkzDAu+b8P7bp0
         IyPtx4He6VMZh/B94PjhxP0qA7M3aoZogDSKtmpwosqqItxuDI07QZ4QDmdmgab4/UjG
         6anX+yobed4Pseayd+v+v38aGXh4sVHHecGDerhfLLjQ36RPRQe3n0WgjLDdC5sthHFB
         CcDb519Qq9v9MlSY1NwFVuifLFOwYNdU7dXxG1a5OTzREQzrPxGjc2KvBFe8+irFwNLU
         CY1Q==
X-Gm-Message-State: AOAM531ojCOfHY/SwZ42XXtyZD4c8hIEAo+bn0NTGiebvtjk23N1tTZ2
        iQIoTpTTjZTb/DrR5LJmQu4hNwiimCE=
X-Google-Smtp-Source: ABdhPJxD1Wl7Aoo5KK/QUcpzK+vCCHNuYnBktAz8VMEEa+l0I3PpBYpYhQz5VAv2fBzlLxAc8NGsCA==
X-Received: by 2002:adf:fd82:: with SMTP id d2mr8149160wrr.304.1604134316071;
        Sat, 31 Oct 2020 01:51:56 -0700 (PDT)
Received: from ?IPv6:2001:a61:245a:d801:2e74:88ad:ef9:5218? ([2001:a61:245a:d801:2e74:88ad:ef9:5218])
        by smtp.gmail.com with ESMTPSA id v6sm7438264wmj.6.2020.10.31.01.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2020 01:51:55 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Kees Cook <keescook@chromium.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Robert Sesek <rsesek@google.com>,
        Containers <containers@lists.linux-foundation.org>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: For review: seccomp_user_notif(2) manual page [v2]
To:     Jann Horn <jannh@google.com>
References: <63598b4f-6ce3-5a11-4552-cdfe308f68e4@gmail.com>
 <CAG48ez0fBE6AJfWh0in=WKkgt98y=KjAen=SQPyTYtvsUbF1yA@mail.gmail.com>
 <93cfdc79-4c48-bceb-3620-4c63e9f4822e@gmail.com>
 <CAG48ez3nH2Oiz9wMSpvUxxX_TRYTT98d3Nj1vnCuJOj9CCXH8Q@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <b43b50a2-fa5c-419d-ad24-3fd40bc26dba@gmail.com>
Date:   Sat, 31 Oct 2020 09:51:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez3nH2Oiz9wMSpvUxxX_TRYTT98d3Nj1vnCuJOj9CCXH8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/30/20 8:20 PM, Jann Horn wrote:
> On Thu, Oct 29, 2020 at 8:14 PM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>> On 10/29/20 2:42 AM, Jann Horn wrote:
>>> As discussed at
>>> <https://lore.kernel.org/r/CAG48ez0m4Y24ZBZCh+Tf4ORMm9_q4n7VOzpGjwGF7_Fe8EQH=Q@mail.gmail.com>,
>>> we need to re-check checkNotificationIdIsValid() after reading remote
>>> memory but before using the read value in any way. Otherwise, the
>>> syscall could in the meantime get interrupted by a signal handler, the
>>> signal handler could return, and then the function that performed the
>>> syscall could free() allocations or return (thereby freeing buffers on
>>> the stack).
>>>
>>> In essence, this pread() is (unavoidably) a potential use-after-free
>>> read; and to make that not have any security impact, we need to check
>>> whether UAF read occurred before using the read value. This should
>>> probably be called out elsewhere in the manpage, too...
>>>
>>> Now, of course, **reading** is the easy case. The difficult case is if
>>> we have to **write** to the remote process... because then we can't
>>> play games like that. If we write data to a freed pointer, we're
>>> screwed, that's it. (And for somewhat unrelated bonus fun, consider
>>> that /proc/$pid/mem is originally intended for process debugging,
>>> including installing breakpoints, and will therefore happily write
>>> over "readonly" private mappings, such as typical mappings of
>>> executable code.)
>>>
>>> So, uuuuh... I guess if anyone wants to actually write memory back to
>>> the target process, we'd better come up with some dedicated API for
>>> that, using an ioctl on the seccomp fd that magically freezes the
>>> target process inside the syscall while writing to its memory, or
>>> something like that? And until then, the manpage should have a big fat
>>> warning that writing to the target's memory is simply not possible
>>> (safely).
>>
>> Thank you for your very clear explanation! It turned out to be
>> trivially easy to demonstrate this issue with a slightly modified
>> version of my program.
>>
>> As well as the change to the code example that I already mentioned
>> my reply of a few hours ago, I've added the following text to the
>> page:
>>
>>    Caveats regarding the use of /proc/[tid]/mem
>>        The discussion above noted the need to use the
>>        SECCOMP_IOCTL_NOTIF_ID_VALID ioctl(2) when opening the
>>        /proc/[tid]/mem file of the target to avoid the possibility of
>>        accessing the memory of the wrong process in the event that the
>>        target terminates and its ID is recycled by another (unrelated)
>>        thread.  However, the use of this ioctl(2) operation is also
>>        necessary in other situations, as explained in the following
>>        pargraphs.
> 
> (nit: paragraphs)

I spotted that one also already. But thanks for reading carefully!

>>        Consider the following scenario, where the supervisor tries to
>>        read the pathname argument of a target's blocked mount(2) system
>>        call:
> [...]
>> Seem okay?
> 
> Yeah, sounds good.
> 
>> By the way, is there any analogous kind of issue concerning
>> pidfd_getfd()? I'm thinking not, but I wonder if I've missed
>> something.
> 
> When it is used by a seccomp supervisor, you mean? I think basically
> the same thing applies - when resource identifiers (such as memory
> addresses or file descriptors) are passed to a syscall, it generally
> has to be assumed that those identifiers may become invalid and be
> reused as soon as the syscall has returned.

I probably needed to be more explicit. Would the following (i.e., a
single cookie check) not be sufficient to handle the above scenario.
Here, the target is making a syscall a system call that employs the
file descriptor 'tfd':

T: makes syscall that triggers notification
S: Get notification
S: pidfd = pidfd_open(T, 0);
S: sfd = pifd_getfd(pidfd, tfd, 0)
S: check that the cookie is still valid
S: do operation with sfd [*]

By contrast, I can see that we might want to do multiple cookie
checks in the /proc/PID/mem case, since the supervisor might do
multiple reads.

Or, do you mean: there really needs to be another cookie check after
the point [*], since, if the the target's syscall was interrupted
and 'tfd' was closed/resused, then the supervisor would be operating
with a file descriptor that refers to an open file description
(a "struct file") that is no longer meaningful in the target?
(Thinking about it, I think this probably is what you mean, but 
I want to confirm.)

Thanks,

Michael
-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
