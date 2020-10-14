Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970F828DB19
	for <lists+bpf@lfdr.de>; Wed, 14 Oct 2020 10:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgJNIT7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Oct 2020 04:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbgJNITg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Oct 2020 04:19:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC607C041E72;
        Tue, 13 Oct 2020 21:40:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l15so829001wmh.1;
        Tue, 13 Oct 2020 21:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ePLsU1bdkJB4g+ijegYS+YZS8jNr19HgFUEeDCk3fzc=;
        b=cmNE/jD7DOye2TOzxQuV4PDYobqxn1oClxVW2ooNBNH2m4IqaSydPrSSYaE08ZKg41
         1rujSTUhVqvG9wyzOSipSeQ6fQhUHQQKqrDL2dcS+J7IJK/oAQoLJQd/DyoCjexRR49U
         JeZRo9oOXjltwQyIKzcahz97cpAv76Mw8/oLI0U/ebF/xhz3gRfZ3bQ6dXG/pMRGIJhU
         5PT3+NherQaYcx+xZRW197NNzDvaU1Fp8CbthviPh+GQxkRCxJVUZQJkq7i+21PMcOTP
         1CreIEO8fb5v7sbUuxk8c5b4OnWyPzlKQeTAAr/Bso9hBBvGE1Hj5gKQH8BsACVBzFDe
         sHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ePLsU1bdkJB4g+ijegYS+YZS8jNr19HgFUEeDCk3fzc=;
        b=rC/04KbiTaJ2y0em7zJE7UIZ9tdqC0eXfUeqvGFbsNG9Ox24lc2YqDnd9iYhbvZ/d0
         R0YDAeuaH5iMyh/0+Lb9AUIrY0UqepqIJ/6D8yNMS9pBdS+5+US0oNetcV2qltmfeL/L
         EhNbPcbB+jkxD2bd5zkLBWy1+VXZloqccRktwUa9Rwv+rl3lHvTiS/pK41bMHZ+UrdIM
         wEnZ6W5AB2vtQbNhJpwdlFjGEYEi9g/4oETG0P9BHLgP0G8svRs7+qv+ubpkq9CpXoXY
         M6vuwHQzp+luY4saQkFmfOhmf8w4CmQ2bFN2NlF0VVhNl8ylR0B6prN84Ii3ZhBbMhWh
         Z/QQ==
X-Gm-Message-State: AOAM5328CqCyTKD0qGTGA3ffQgpEh0WkWffKsT8Bj9Jk23Ey6F6o4DmK
        IKI/zKSPGQ3LJPXNmyipaio=
X-Google-Smtp-Source: ABdhPJy4ORXNMf8bxAsICCzIRlJSAI1SsU+l/svl536z0jTzmcGeSYTrB8eiui5z2m7KNYGayMb+WQ==
X-Received: by 2002:a05:600c:210f:: with SMTP id u15mr1494200wml.53.1602650439436;
        Tue, 13 Oct 2020 21:40:39 -0700 (PDT)
Received: from [192.168.1.10] (static-176-175-73-29.ftth.abo.bbox.fr. [176.175.73.29])
        by smtp.gmail.com with ESMTPSA id o6sm2726672wrm.69.2020.10.13.21.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 21:40:38 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>, wad@chromium.org,
        bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     Tycho Andersen <tycho@tycho.pizza>
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco>
 <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
 <20200930230327.GA1260245@cisco>
 <8f20d586-9609-ef83-c85a-272e37e684d8@gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <7a4497ad-e595-f328-e0e1-9577dfdbd895@gmail.com>
Date:   Wed, 14 Oct 2020 06:40:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8f20d586-9609-ef83-c85a-272e37e684d8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Tycho,

Ping on the question below!

Thanks,

Michael

On 10/1/20 9:45 AM, Michael Kerrisk (man-pages) wrote:
> On 10/1/20 1:03 AM, Tycho Andersen wrote:
>> On Wed, Sep 30, 2020 at 10:34:51PM +0200, Michael Kerrisk (man-pages) wrote:
>>> Hi Tycho,
>>>
>>> Thanks for taking time to look at the page!
>>>
>>> On 9/30/20 5:03 PM, Tycho Andersen wrote:
>>>> On Wed, Sep 30, 2020 at 01:07:38PM +0200, Michael Kerrisk (man-pages) wrote:
> 
> [...]
> 
>>>>>        ┌─────────────────────────────────────────────────────┐
>>>>>        │FIXME                                                │
>>>>>        ├─────────────────────────────────────────────────────┤
>>>>>        │Interestingly, after the event  had  been  received, │
>>>>>        │the  file descriptor indicates as writable (verified │
>>>>>        │from the source code and by experiment). How is this │
>>>>>        │useful?                                              │
>>>>
>>>> You're saying it should just do EPOLLOUT and not EPOLLWRNORM? Seems
>>>> reasonable.
>>>
>>> No, I'm saying something more fundamental: why is the FD indicating as
>>> writable? Can you write something to it? If yes, what? If not, then
>>> why do these APIs want to say that the FD is writable?
>>
>> You can't via read(2) or write(2), but conceptually NOTIFY_RECV and
>> NOTIFY_SEND are reading and writing events from the fd. I don't know
>> that much about the poll interface though -- is it possible to
>> indicate "here's a pseudo-read event"? It didn't look like it, so I
>> just (ab-)used POLLIN and POLLOUT, but probably that's wrong.
> 
> I think the POLLIN thing is fine.
> 
> So, I think maybe I now understand what you intended with setting
> POLLOUT: the notification has been received ("read") and now the
> FD can be used to NOTIFY_SEND ("write") a response. Right?
> 
> If that's correct, I don't have a problem with it. I just wonder:
> is it useful? IOW: are there situations where the process doing the
> NOTIFY_SEND might want to test for POLLOUT because the it doesn't
> know whether a NOTIFY_RECV has occurred? 
> 
> Thanks,
> 
> Michael
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
