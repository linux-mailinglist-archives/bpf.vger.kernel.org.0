Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC0E29A490
	for <lists+bpf@lfdr.de>; Tue, 27 Oct 2020 07:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506316AbgJ0GOI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Oct 2020 02:14:08 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:37565 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506314AbgJ0GOI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 02:14:08 -0400
Received: by mail-wm1-f41.google.com with SMTP id c16so219330wmd.2;
        Mon, 26 Oct 2020 23:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jfo31Pg0Y7mNoQfq9W2rm3LaBQTFU19PRMYhqK7FonA=;
        b=WHPoAqPE0Dd/RhKzTIxJwQH+MFeHpNXlvqU0h7kdlg1bE8i0aPbIeAZsk3hw1vgRip
         TQuBp4mC1gN35ZWzblEla1HJM8N6X7WKrWXST8kLDJqgH6QmT0N62BWUQc27l21rQZRq
         jVOKJjyoJdGIgtp4tJvmXDvChbS2xUqO8q3o+hpykn6hchir4SpuhRCH/uzoLfoqWsaG
         pd5iNEVN4FyK7ck56tlLqUQfijGNK6kBRDydA0jMzNA6pB0xG+y3qej+9mA6DVxDuJHR
         XaTtm5fjg8vmn1XStmo1KumJU/wBhVJ+ZDsH9Orr26Q+gTnUN4rpg5i67wjxI/966aDn
         lfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jfo31Pg0Y7mNoQfq9W2rm3LaBQTFU19PRMYhqK7FonA=;
        b=UprbWufSixD7nRQ/upOurjOOHKWXM37g1N5SGjjc3J20n7hUi/4fAk3ndq9AQ7Ou2t
         Bg+vLkDaa/c+Yiu0J5HYi5GyrXy9ItUTQgTT0GBntHMObNijZm+bVFQieVPlglhWGpYl
         qjjqTH2UGJgCCdgmUeEeKIkHP3/GLgPourbUS4koRVlHQBFwOPBBXoNrtFEMdAI/gxng
         sp2qTwACV2dcgk+TfAbO2SXTQCodD0DzDeoWwN0Ewq0Aym7szeD4hhSe+ln3Wqwv/UCt
         zvUiJJfBWOP9gONONy8UuG4Ul8qp3ZHDdK1f1dT1/h5VeEViR3oaWhkpKv/tzXmHm/y9
         sl9w==
X-Gm-Message-State: AOAM530LvzEEIFDIMTyDBP8UOlf4ht0fusVWrucIclgEzbzi3Wo1AuM1
        ExJ+symxDo4PusQVEwfjOds=
X-Google-Smtp-Source: ABdhPJyeBBAzzf4v0qJDy0pr93s4VjEbFAKQ9XmS93oq+JSHL537pXNmrsKz2g4mKxXCEYsD92OKYw==
X-Received: by 2002:a1c:b486:: with SMTP id d128mr813191wmf.164.1603779245705;
        Mon, 26 Oct 2020 23:14:05 -0700 (PDT)
Received: from ?IPv6:2001:a61:245a:d801:2e74:88ad:ef9:5218? ([2001:a61:245a:d801:2e74:88ad:ef9:5218])
        by smtp.gmail.com with ESMTPSA id v189sm622729wmg.14.2020.10.26.23.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 23:14:04 -0700 (PDT)
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
 <20200930150330.GC284424@cisco>
 <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
 <20200930230327.GA1260245@cisco>
 <CAG48ez1VOUEHVQyo-2+uO7J+-jN5rh7=KmrMJiPaFjwCbKR1Sg@mail.gmail.com>
 <20200930232456.GB1260245@cisco>
 <CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com>
 <CAG48ez3kpEDO1x_HfvOM2R9M78Ach9O_4+Pjs-vLLfqvZL+13A@mail.gmail.com>
 <656a37b5-75e3-0ded-6ba8-3bb57b537b24@gmail.com>
 <CAG48ez2Uy8=Tz9k1hcr0suLPHjbJi1qUviSGzDQ-XWEGsdNU+A@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <e2643168-b5d5-4d8c-947a-7895bcabc268@gmail.com>
Date:   Tue, 27 Oct 2020 07:14:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2Uy8=Tz9k1hcr0suLPHjbJi1qUviSGzDQ-XWEGsdNU+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/26/20 4:54 PM, Jann Horn wrote:
> On Sun, Oct 25, 2020 at 5:32 PM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
[...]
>> I tried applying the patch below to vanilla 5.9.0.
>> (There's one typo: s/ENOTCON/ENOTCONN).
>>
>> It seems not to work though; when I send a signal to my test
>> target process that is sleeping waiting for the notification
>> response, the process enters the uninterruptible D state.
>> Any thoughts?
> 
> Ah, yeah, I think I was completely misusing the wait API. I'll go change that.
> 
> (Btw, in general, for reports about hangs like that, it can be helpful
> to have the contents of /proc/$pid/stack. And for cases where CPUs are
> spinning, the relevant part from the output of the "L" sysrq, or
> something like that.)

Thanks for the tipcs!

> Also, I guess we can probably break this part of UAPI after all, since
> the only user of this interface seems to currently be completely
> broken in this case anyway? So I think we want the other
> implementation without the ->canceled_reqs logic after all.

Okay.

> I'm a bit on the fence now on whether non-blocking mode should use
> ENOTCONN or not... I guess if we returned ENOENT even when there are
> no more listeners, you'd have to disambiguate through the poll()
> revents, which would be kinda ugly?

I must confess, I'm not quite clear on which two cases you 
are trying to distinguish. Can you elaborate?

> I'll try to turn this into a proper patch submission...

Thank you!!

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
