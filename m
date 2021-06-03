Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0934399F5F
	for <lists+bpf@lfdr.de>; Thu,  3 Jun 2021 12:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhFCLBO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Jun 2021 07:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51606 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229840AbhFCLBL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Jun 2021 07:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622717966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u2TaQuoIhZrPBRfmHby+sF4oKD6qihDcCy7za/Xxrrg=;
        b=VlOrdzo8Ht1KxsCenvk5QeXViz3pA58mbPuKrKPsHjrRSFsy3M7XYXN8fT2tu7z5OwWaS/
        eAnWTgHpFrkhatUacFmQmyBWo/WjrXIWmrZ0PAPXtgy0d6Nx8Y57x0v8AQCLYzspEuAsjq
        u5qlVq6aWoarL6DHKswi5rd5Nq3/PEY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-HH4WxDqoPtqFETzzoE8-iA-1; Thu, 03 Jun 2021 06:59:25 -0400
X-MC-Unique: HH4WxDqoPtqFETzzoE8-iA-1
Received: by mail-ed1-f72.google.com with SMTP id c21-20020a0564021015b029038c3f08ce5aso3072866edu.18
        for <bpf@vger.kernel.org>; Thu, 03 Jun 2021 03:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=u2TaQuoIhZrPBRfmHby+sF4oKD6qihDcCy7za/Xxrrg=;
        b=uAhXlEE9ptxHgmT5YbDrPU+o7o+my2cxj1lFa5KZLoo+QiZ7bmBvCQH/6xJWn7phtA
         e6ho835Ew5k6pAjl8n1bfN4m7Q4UyZvW1TS9flcWTAjI74mXkPSw5ZKjxcQ38SVRwO7A
         YPPCUk+FiLNnVKplnIJ5yZZsurcsu0KdWhgOWAewXSNq0pZXljWc8FMZ+srlfsxF8FMH
         UYgd3s7RAjTt4XsTsaant70UvHTY9glSnjNLJSxm2lp2fmS5noviqK9pbW6R0evnDUP9
         TKD0RPANUx5fmcgj5TZrkpJFMsT3sAnIXAFA0Zqrjz69lwG8mjIffmmFL0NBzW7v+qb+
         ICWg==
X-Gm-Message-State: AOAM532N6/pfV3KP962wun9XNRD+IkMD/mMCEqt7BzYJF7qRGA0ZSWHS
        HKUuFRaNxqZZwYiqcx/BbtnlbNfShzsdN43CX80uK04ZeRwxrCC4wMpVz3pYlW0i7PWRe3s1FZR
        l9eSsxeSjDPBy
X-Received: by 2002:a17:906:7f07:: with SMTP id d7mr4551126ejr.240.1622717964208;
        Thu, 03 Jun 2021 03:59:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8o64PVj7ozjTvVNJYZ2Wc+z0I8VFEZoidK/PpIuRD64hx7kkUZrQYTSN1UBLi5qhQnyGwGQ==
X-Received: by 2002:a17:906:7f07:: with SMTP id d7mr4551106ejr.240.1622717963835;
        Thu, 03 Jun 2021 03:59:23 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k21sm1374270ejp.23.2021.06.03.03.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 03:59:23 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 576771802AA; Thu,  3 Jun 2021 12:59:22 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/3] bpf: Introduce bpf_timer
In-Reply-To: <20210603015809.l2dez754vzxjueew@ast-mbp.dhcp.thefacebook.com>
References: <20210527040259.77823-1-alexei.starovoitov@gmail.com>
 <20210527040259.77823-2-alexei.starovoitov@gmail.com>
 <87r1hsgln6.fsf@toke.dk>
 <20210602014608.wxzfsgzuq7rut4ra@ast-mbp.dhcp.thefacebook.com>
 <87a6o7aoxa.fsf@toke.dk>
 <20210603015809.l2dez754vzxjueew@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 03 Jun 2021 12:59:22 +0200
Message-ID: <874kef9pth.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Jun 03, 2021 at 12:21:05AM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>=20
>> > On Thu, May 27, 2021 at 06:57:17PM +0200, Toke H=C3=B8iland-J=C3=B8rge=
nsen wrote:
>> >> >     if (val) {
>> >> >         bpf_timer_init(&val->timer, timer_cb2, 0);
>> >> >         bpf_timer_start(&val->timer, 1000 /* call timer_cb2 in 1 ms=
ec */);
>> >>=20
>> >> nit: there are 1M nanoseconds in a millisecond :)
>> >
>> > oops :)
>> >
>> >> >     }
>> >> > }
>> >> >
>> >> > This patch adds helper implementations that rely on hrtimers
>> >> > to call bpf functions as timers expire.
>> >> > The following patch adds necessary safety checks.
>> >> >
>> >> > Only programs with CAP_BPF are allowed to use bpf_timer.
>> >> >
>> >> > The amount of timers used by the program is constrained by
>> >> > the memcg recorded at map creation time.
>> >> >
>> >> > The bpf_timer_init() helper is receiving hidden 'map' and 'prog' ar=
guments
>> >> > supplied by the verifier. The prog pointer is needed to do refcntin=
g of bpf
>> >> > program to make sure that program doesn't get freed while timer is =
armed.
>> >> >
>> >> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> >>=20
>> >> Overall this LGTM, and I believe it will be usable for my intended use
>> >> case. One question:
>> >>=20
>> >> With this, it will basically be possible to create a BPF daemon, won't
>> >> it? I.e., if a program includes a timer and the callback keeps re-arm=
ing
>> >> itself this will continue indefinitely even if userspace closes all r=
efs
>> >> to maps and programs? Not saying this is a problem, just wanted to ch=
eck
>> >> my understanding (i.e., that there's not some hidden requirement on
>> >> userspace keeping a ref open that I'm missing)...
>> >
>> > That is correct.
>> > Another option would be to auto-cancel the timer when the last referen=
ce
>> > to the prog drops. That may feel safer, since forever
>> > running bpf daemon is a certainly new concept.
>> > The main benefits of doing prog_refcnt++ from bpf_timer_start are ease
>> > of use and no surprises.
>> > Disappearing timer callback when prog unloads is outside of bpf prog c=
ontrol.
>> > For example the tracing bpf prog might collect some data and periodica=
lly
>> > flush it to user space. The prog would arm the timer and when callback
>> > is invoked it would send the data via ring buffer and start another
>> > data collection cycle.
>> > When the user space part of the service exits it doesn't have
>> > an ability to enforce the flush of the last chunk of data.
>> > It could do prog_run cmd that will call the timer callback,
>> > but it's racy.
>> > The solution to this problem could be __init and __fini
>> > sections that will be invoked when the prog is loaded
>> > and when the last refcnt drops.
>> > It's a complementary feature though.
>> > The prog_refcnt++ from bpf_timer_start combined with a prog
>> > explicitly doing bpf_timer_cancel from __fini
>> > would be the most flexible combination.
>> > This way the prog can choose to be a daemon or it can choose
>> > to cancel its timers and do data flushing when the last prog
>> > reference drops.
>> > The prog refcnt would be split (similar to uref). The __fini callback
>> > will be invoked when refcnt reaches zero, but all increments
>> > done by bpf_timer_start will be counted separately.
>> > The user space wouldn't need to do the prog_run command.
>> > It would detach the prog and close(prog_fd).
>> > That will trigger __fini callback that will cancel the timers
>> > and the prog will be fully unloaded.
>> > That would make bpf progs resemble kernel modules even more.
>>=20
>> I like the idea of a "destructor" that will trigger on refcnt drop to
>> zero. And I do think a "bpf daemon" is potentially a useful, if novel,
>> concept.
>
> I think so too. Long ago folks requested periodic bpf progs to
> do sampling in tracing. All these years attaching bpf prog
> to a perf_event was a workaround for such feature request.
> perf_event bpf prog can be pinned in perf_event array,
> so "bpf daemon" kinda exist today. Just more convoluted.

Right, agreed - triggering periodic sampling directly from BPF does seem
like the right direction.

>> The __fini thing kinda supposes a well-behaved program, though, right?
>> I.e., it would be fairly trivial to write a program that spins forever
>> by repeatedly scheduling the timer with a very short interval (whether
>> by malice or bugginess).
>
> It's already possible without bpf_timer.

Hmm, fair point.

>> So do we need a 'bpfkill' type utility to nuke
>> buggy programs, or how would resource constraints be enforced?
>
> That is possible without 'bpfkill'.
> bpftool can delete map element that contains bpf_timer and
> that will cancel it. I'll add tests to make sure it's the case.

Ah, right, of course! Thanks, LGTM then :)

-Toke

