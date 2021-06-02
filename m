Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B626E3995D5
	for <lists+bpf@lfdr.de>; Thu,  3 Jun 2021 00:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhFBWWx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Jun 2021 18:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229552AbhFBWWx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Jun 2021 18:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622672469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RgialvujE2IQv+SugokXVwsHSlLdZ3m+KxhMDMNe7gM=;
        b=LFgUYm4IOz6EYukWECeMg7pESeJ5EuMRUnmDsf85U3tRtO4F9HzVcLpI+oFUL7Ss3Q31B3
        5B/1FTOfDZTGQXUDmybrDYG1zxZ0e7B8WmfhPJ3teCjdyhoqxqWTqW8mlKcFNoo6u/mpov
        4KrzLwe8J/mCfrGz08JMALDmjtA+lyo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-KmrD5N64Oqq-DVM3SRgCyg-1; Wed, 02 Jun 2021 18:21:08 -0400
X-MC-Unique: KmrD5N64Oqq-DVM3SRgCyg-1
Received: by mail-ed1-f71.google.com with SMTP id a16-20020aa7cf100000b0290391819a774aso143303edy.8
        for <bpf@vger.kernel.org>; Wed, 02 Jun 2021 15:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RgialvujE2IQv+SugokXVwsHSlLdZ3m+KxhMDMNe7gM=;
        b=ZhgpZLFgOl5RORs1W9TGD6OK+cnkAm67pumSyVjt/bL6aLaxCcvABYdYZUIyii2pVW
         EXNUSNFpihhWPnJeeDAtIb7UduWK3vuYFnImRZS7/RdYw/hjRcOLD4MJwzS1Ymopb6A+
         o/3jyxGZ2u8qbhY2IwYMWFSM/ItTGAiBLemM5wah2Q3f/BhLVZ7GLE9xj3I4HiFOZx28
         ++vj4dKaG0WgHkq//VD402x+JSv7xXojm82emlBKoCDLRjOutRdOD5XehohTt2iWnTDL
         Q2UxIK+Q4WfWGyfPj7VBHwZahOk4nCQKqAUCdewUfEfgd/9dRUSqncKHb4zNPnCsqI/o
         +0kA==
X-Gm-Message-State: AOAM533sn9mB4igVwNw0AUh+jO6Iw/nHQOYh69RCWhwjmZoazC5Akwqr
        7d4FIy1iZbtUVZd5l/qHQ17V8LDPwXFZvq6bcVg+W2Uc93F06pIu7cufZ1hTaCFigjYmCMIzhxG
        pooKQDprZOb1f
X-Received: by 2002:a17:906:7052:: with SMTP id r18mr35841521ejj.449.1622672467094;
        Wed, 02 Jun 2021 15:21:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwedY77oQfixLLqYKLuPdPi7yR/uG/J7+XCwAWp+feZG0lRs0qu+QL67BohDveXkZW51niEjg==
X-Received: by 2002:a17:906:7052:: with SMTP id r18mr35841503ejj.449.1622672466855;
        Wed, 02 Jun 2021 15:21:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id e22sm685237edv.57.2021.06.02.15.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 15:21:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9DF72180722; Thu,  3 Jun 2021 00:21:05 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/3] bpf: Introduce bpf_timer
In-Reply-To: <20210602014608.wxzfsgzuq7rut4ra@ast-mbp.dhcp.thefacebook.com>
References: <20210527040259.77823-1-alexei.starovoitov@gmail.com>
 <20210527040259.77823-2-alexei.starovoitov@gmail.com>
 <87r1hsgln6.fsf@toke.dk>
 <20210602014608.wxzfsgzuq7rut4ra@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 03 Jun 2021 00:21:05 +0200
Message-ID: <87a6o7aoxa.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, May 27, 2021 at 06:57:17PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> >     if (val) {
>> >         bpf_timer_init(&val->timer, timer_cb2, 0);
>> >         bpf_timer_start(&val->timer, 1000 /* call timer_cb2 in 1 msec =
*/);
>>=20
>> nit: there are 1M nanoseconds in a millisecond :)
>
> oops :)
>
>> >     }
>> > }
>> >
>> > This patch adds helper implementations that rely on hrtimers
>> > to call bpf functions as timers expire.
>> > The following patch adds necessary safety checks.
>> >
>> > Only programs with CAP_BPF are allowed to use bpf_timer.
>> >
>> > The amount of timers used by the program is constrained by
>> > the memcg recorded at map creation time.
>> >
>> > The bpf_timer_init() helper is receiving hidden 'map' and 'prog' argum=
ents
>> > supplied by the verifier. The prog pointer is needed to do refcnting o=
f bpf
>> > program to make sure that program doesn't get freed while timer is arm=
ed.
>> >
>> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>=20
>> Overall this LGTM, and I believe it will be usable for my intended use
>> case. One question:
>>=20
>> With this, it will basically be possible to create a BPF daemon, won't
>> it? I.e., if a program includes a timer and the callback keeps re-arming
>> itself this will continue indefinitely even if userspace closes all refs
>> to maps and programs? Not saying this is a problem, just wanted to check
>> my understanding (i.e., that there's not some hidden requirement on
>> userspace keeping a ref open that I'm missing)...
>
> That is correct.
> Another option would be to auto-cancel the timer when the last reference
> to the prog drops. That may feel safer, since forever
> running bpf daemon is a certainly new concept.
> The main benefits of doing prog_refcnt++ from bpf_timer_start are ease
> of use and no surprises.
> Disappearing timer callback when prog unloads is outside of bpf prog cont=
rol.
> For example the tracing bpf prog might collect some data and periodically
> flush it to user space. The prog would arm the timer and when callback
> is invoked it would send the data via ring buffer and start another
> data collection cycle.
> When the user space part of the service exits it doesn't have
> an ability to enforce the flush of the last chunk of data.
> It could do prog_run cmd that will call the timer callback,
> but it's racy.
> The solution to this problem could be __init and __fini
> sections that will be invoked when the prog is loaded
> and when the last refcnt drops.
> It's a complementary feature though.
> The prog_refcnt++ from bpf_timer_start combined with a prog
> explicitly doing bpf_timer_cancel from __fini
> would be the most flexible combination.
> This way the prog can choose to be a daemon or it can choose
> to cancel its timers and do data flushing when the last prog
> reference drops.
> The prog refcnt would be split (similar to uref). The __fini callback
> will be invoked when refcnt reaches zero, but all increments
> done by bpf_timer_start will be counted separately.
> The user space wouldn't need to do the prog_run command.
> It would detach the prog and close(prog_fd).
> That will trigger __fini callback that will cancel the timers
> and the prog will be fully unloaded.
> That would make bpf progs resemble kernel modules even more.

I like the idea of a "destructor" that will trigger on refcnt drop to
zero. And I do think a "bpf daemon" is potentially a useful, if novel,
concept.

The __fini thing kinda supposes a well-behaved program, though, right?
I.e., it would be fairly trivial to write a program that spins forever
by repeatedly scheduling the timer with a very short interval (whether
by malice or bugginess). So do we need a 'bpfkill' type utility to nuke
buggy programs, or how would resource constraints be enforced?

-Toke

