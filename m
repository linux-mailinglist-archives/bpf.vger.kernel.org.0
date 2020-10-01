Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EBE27FA75
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 09:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbgJAHpY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 03:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAHpY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 03:45:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95986C0613D0;
        Thu,  1 Oct 2020 00:45:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so4474283wrv.1;
        Thu, 01 Oct 2020 00:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xF7e0E8Lw4CA2Uq+qVpBw+cIQFKMIBUjuND9PoUrs5Y=;
        b=d/vQ+VVk+keNzkTfJSJxtcXpSwp2e7QCaBNQZVU4obREwDbvYR4ZOkBAIn6nZtjLrb
         3dRvKN+GZdP1oQFFW/WEgNG9Ppq4gVVv6NzUKiTksJwcvN9PabgGRW31N0rtN+ZwizBZ
         Ir7qV4dK/89jGgUAjfx/Dt5qCN9CBfJEHDXQ3wXfHiKFfYxmdygBYHRXbft2M6MJDZht
         8MsO994BspQhR23fIhIiWfa0x2AEEtJL394LV/ThsCeCMiTFdFm/rX53wswTwkK2O5Xj
         iJx9UD43hnd5M2L/jQHIj83U3txiSLHzEMovktlDwd72Doib8y20ewhC18AZ/A7VLimt
         CJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xF7e0E8Lw4CA2Uq+qVpBw+cIQFKMIBUjuND9PoUrs5Y=;
        b=r+gr5Iucm6an8QaDd2OH/4KKZ2LlWzlQHNhDfETH5cijOajO6q/8MIGxQXDxwRGSm1
         oaURRn74f3eiCTQ17zvjTf9HptVGXZIGxleD3mWghbHIGjjPA4hmZeVeZh6hcK3GGWAi
         X2hCNwanJG+HDPu8t+KNGZn34O5p0RXIEqlD7YxeYz5wxpSlMoartzuUM6tnoxmC9mmt
         7iShWOwlD1pTZNgTYGWFQzpvo7f61DxRnZxkHetcwSwILsoG38e4Jx9a5y+DbnZgr1HN
         JsSzSse4RosZ+J6+Ueybge1BiswOWPKLqcxLcfDE23WaXwb9j+0tfrcP5vQr6OLfaolk
         BbBQ==
X-Gm-Message-State: AOAM531F2xAqba33+NEvTlXO06LeFhVo3Min8AVHOPVSH98neCb4hzXI
        MypRk8vzYsuko9DxO55hh0w=
X-Google-Smtp-Source: ABdhPJxwv6BtYFAqC+AMaDOZb3qgtjlHwEicyt0p82kSHbH75ncrgFUe0TsFiNV7de54QZazE4hATA==
X-Received: by 2002:adf:dd44:: with SMTP id u4mr6973042wrm.22.1601538322276;
        Thu, 01 Oct 2020 00:45:22 -0700 (PDT)
Received: from ?IPv6:2001:a61:2479:6801:d8fe:4132:9f23:7e8f? ([2001:a61:2479:6801:d8fe:4132:9f23:7e8f])
        by smtp.gmail.com with ESMTPSA id u66sm7145534wmg.44.2020.10.01.00.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 00:45:21 -0700 (PDT)
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
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <8f20d586-9609-ef83-c85a-272e37e684d8@gmail.com>
Date:   Thu, 1 Oct 2020 09:45:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930230327.GA1260245@cisco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/1/20 1:03 AM, Tycho Andersen wrote:
> On Wed, Sep 30, 2020 at 10:34:51PM +0200, Michael Kerrisk (man-pages) wrote:
>> Hi Tycho,
>>
>> Thanks for taking time to look at the page!
>>
>> On 9/30/20 5:03 PM, Tycho Andersen wrote:
>>> On Wed, Sep 30, 2020 at 01:07:38PM +0200, Michael Kerrisk (man-pages) wrote:

[...]

>>>>        ┌─────────────────────────────────────────────────────┐
>>>>        │FIXME                                                │
>>>>        ├─────────────────────────────────────────────────────┤
>>>>        │Interestingly, after the event  had  been  received, │
>>>>        │the  file descriptor indicates as writable (verified │
>>>>        │from the source code and by experiment). How is this │
>>>>        │useful?                                              │
>>>
>>> You're saying it should just do EPOLLOUT and not EPOLLWRNORM? Seems
>>> reasonable.
>>
>> No, I'm saying something more fundamental: why is the FD indicating as
>> writable? Can you write something to it? If yes, what? If not, then
>> why do these APIs want to say that the FD is writable?
> 
> You can't via read(2) or write(2), but conceptually NOTIFY_RECV and
> NOTIFY_SEND are reading and writing events from the fd. I don't know
> that much about the poll interface though -- is it possible to
> indicate "here's a pseudo-read event"? It didn't look like it, so I
> just (ab-)used POLLIN and POLLOUT, but probably that's wrong.

I think the POLLIN thing is fine.

So, I think maybe I now understand what you intended with setting
POLLOUT: the notification has been received ("read") and now the
FD can be used to NOTIFY_SEND ("write") a response. Right?

If that's correct, I don't have a problem with it. I just wonder:
is it useful? IOW: are there situations where the process doing the
NOTIFY_SEND might want to test for POLLOUT because the it doesn't
know whether a NOTIFY_RECV has occurred? 

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
