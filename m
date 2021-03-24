Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299E53481C2
	for <lists+bpf@lfdr.de>; Wed, 24 Mar 2021 20:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbhCXTS1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Mar 2021 15:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238046AbhCXTRm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Mar 2021 15:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616613460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+D+dE2rzCSfeQEahMhsNTMFucn9MdyRxd6rqjbBb4U=;
        b=O/U4w3YOqWU2vwgwS5y6OED6vtB3AX/ViPXMu19TO+n3xZx7wfMD1OyVJgELBXORejZn3P
        NgOWQ+v+MdjPXBkB00I0k7irLsbhHsbvP8N+KNo7lrxjRVE5bPLLkuB7uY0iCtOO9Xi9YU
        fxHRp+GEtPFwxidkpDf3ZboRMBrHW/Y=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-7UAI1NngPkqvHsdw5kMzew-1; Wed, 24 Mar 2021 15:17:37 -0400
X-MC-Unique: 7UAI1NngPkqvHsdw5kMzew-1
Received: by mail-ed1-f72.google.com with SMTP id y10so1507863edr.20
        for <bpf@vger.kernel.org>; Wed, 24 Mar 2021 12:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=T+D+dE2rzCSfeQEahMhsNTMFucn9MdyRxd6rqjbBb4U=;
        b=pJCfAxui22ImkLbluA0ZoSbhBToTEbCuVmIsm98zfJgt63ZT0CVWyP64CsJiH5aTjv
         bdZjxEOGDfLsjIGE8L8kxiYPyS7H7RS7YhqrCnqVdbq3hnO/RgtDdcWGADXZ3ZgAOSPP
         S8O/llRVvpl6stpcecKQArFbAOSAwZTCf7zYwt7EOxxcLVucqK4bFDrC7u7uFWBxsBfa
         mjydToKjsNRY5T1Z/2W1kHzISsur+EvszzF/tOtgNnY1/Ze/UycAlIS2Xz/tHHdwoRXN
         uetEKPbUtv3+y48xlCa3lThn+1o2sCGlQkJ+AMqzpi2xkhzLtQ+Tn68Ej9wataKEx1zo
         3ksw==
X-Gm-Message-State: AOAM533SZV/ZcposKE9+KP/VpLHqY8K9EjfvS5w+jiZv9YtXh4NzVhAV
        uaAyo3thHBZxY5WA3mPVsYCFStLkqPksJlG8U7wOihs/UtiOJP7zeC5U3QBttfsl3AqC3I86R5a
        irEaaHqKsAAdX
X-Received: by 2002:a05:6402:30a2:: with SMTP id df2mr5084554edb.29.1616613456495;
        Wed, 24 Mar 2021 12:17:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiCzL0VV6/aHrL7l/9Fci6FvmOTVCXuzdYOMsPKsFAqJpGowPoj4JyxaRm2Y5jzj4y4pnoNg==
X-Received: by 2002:a05:6402:30a2:: with SMTP id df2mr5084533edb.29.1616613456239;
        Wed, 24 Mar 2021 12:17:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z9sm1699325edr.75.2021.03.24.12.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 12:17:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 19AAB18028C; Wed, 24 Mar 2021 20:17:35 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     paulmck@kernel.org
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Subject: Re: BPF trampolines break because of hang in
 synchronize_rcu_tasks() on PREEMPT kernels
In-Reply-To: <20210324161149.GJ2696@paulmck-ThinkPad-P72>
References: <20210323164315.GY2696@paulmck-ThinkPad-P72>
 <871rc57p8g.fsf@toke.dk> <20210323175716.GB2696@paulmck-ThinkPad-P72>
 <87y2ed645n.fsf@toke.dk>
 <CAEf4Bzap-8uTFS=dJjq7o+g=e=5PvyD3_1TpnhmmoVuP0SUjjQ@mail.gmail.com>
 <87r1k560p9.fsf@toke.dk> <20210323215247.GD2696@paulmck-ThinkPad-P72>
 <87lfad5xv7.fsf@toke.dk> <20210324024148.GG2696@paulmck-ThinkPad-P72>
 <87o8f8g50k.fsf@toke.dk> <20210324161149.GJ2696@paulmck-ThinkPad-P72>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 24 Mar 2021 20:17:35 +0100
Message-ID: <87ft0kfjjk.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Wed, Mar 24, 2021 at 12:33:47PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> "Paul E. McKenney" <paulmck@kernel.org> writes:
>>=20
>> > On Tue, Mar 23, 2021 at 11:06:04PM +0100, Toke H=C3=B8iland-J=C3=B8rge=
nsen wrote:
>> >> "Paul E. McKenney" <paulmck@kernel.org> writes:
>> >>=20
>> >> > On Tue, Mar 23, 2021 at 10:04:50PM +0100, Toke H=C3=B8iland-J=C3=B8=
rgensen wrote:
>> >> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>> >> >>=20
>> >> >> > On Tue, Mar 23, 2021 at 12:52 PM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
>> >> >> >>
>> >> >> >> "Paul E. McKenney" <paulmck@kernel.org> writes:
>> >> >> >>
>> >> >> >> > On Tue, Mar 23, 2021 at 06:29:35PM +0100, Toke H=C3=B8iland-J=
=C3=B8rgensen wrote:
>> >> >> >> >> "Paul E. McKenney" <paulmck@kernel.org> writes:
>> >> >> >> >>
>> >> >> >> >> > On Tue, Mar 23, 2021 at 01:26:36PM +0100, Toke H=C3=B8ilan=
d-J=C3=B8rgensen wrote:
>> >> >> >> >> >> Hi Paul
>> >> >> >> >> >>
>> >> >> >> >> >> Magnus and I have been debugging an issue where close() o=
n a bpf_link
>> >> >> >> >> >> file descriptor would hang indefinitely when the system w=
as under load
>> >> >> >> >> >> on a kernel compiled with CONFIG_PREEMPT=3Dy, and it seem=
s to be related
>> >> >> >> >> >> to synchronize_rcu_tasks(), so I'm hoping you can help us=
 with it.
>> >> >> >> >> >>
>> >> >> >> >> >> The issue is triggered reliably by loading up a system wi=
th network
>> >> >> >> >> >> traffic (causing 100% softirq CPU load on one or more cor=
es), and then
>> >> >> >> >> >> attaching an freplace bpf_link and closing it again. The =
close() will
>> >> >> >> >> >> hang until the network traffic load is lowered.
>> >> >> >> >> >>
>> >> >> >> >> >> Digging further, it appears that the hang happens in
>> >> >> >> >> >> synchronize_rcu_tasks(), as seen by running a bpftrace sc=
ript like:
>> >> >> >> >> >>
>> >> >> >> >> >> bpftrace -e 'kprobe:synchronize_rcu_tasks { @start =3D ns=
ecs; printf("enter\n"); } kretprobe:synchronize_rcu_tasks { printf("exit af=
ter %d ms\n", (nsecs - @start) / 1000000); }'
>> >> >> >> >> >> Attaching 2 probes...
>> >> >> >> >> >> enter
>> >> >> >> >> >> exit after 54 ms
>> >> >> >> >> >> enter
>> >> >> >> >> >> exit after 3249 ms
>> >> >> >> >> >>
>> >> >> >> >> >> (the two enter/exit pairs are, respectively, from an unlo=
aded system,
>> >> >> >> >> >> and from a loaded system where I stopped the network traf=
fic after a
>> >> >> >> >> >> couple of seconds).
>> >> >> >> >> >>
>> >> >> >> >> >> The call to synchronize_rcu_tasks() happens in bpf_trampo=
line_put():
>> >> >> >> >> >>
>> >> >> >> >> >> https://elixir.bootlin.com/linux/latest/source/kernel/bpf=
/trampoline.c#L376
>> >> >> >> >> >>
>> >> >> >> >> >> And because it does this while holding trampoline_mutex, =
even deferring
>> >> >> >> >> >> the put to a worker (as a previously applied-then-reverte=
d patch did[0])
>> >> >> >> >> >> doesn't help: that'll fix the initial hang on close(), bu=
t any
>> >> >> >> >> >> subsequent use of BPF trampolines will then be blocked be=
cause of the
>> >> >> >> >> >> mutex.
>> >> >> >> >> >>
>> >> >> >> >> >> Also, if I just keep the network traffic running I will e=
ventually get a
>> >> >> >> >> >> kernel panic with:
>> >> >> >> >> >>
>> >> >> >> >> >> kernel:[44348.426312] Kernel panic - not syncing: hung_ta=
sk: blocked tasks
>> >> >> >> >> >>
>> >> >> >> >> >> I've created a reproducer for the issue here:
>> >> >> >> >> >> https://github.com/xdp-project/bpf-examples/tree/master/b=
pf-link-hang
>> >> >> >> >> >>
>> >> >> >> >> >> To compile simply do this (needs a recent llvm/clang for =
compiling the BPF program):
>> >> >> >> >> >>
>> >> >> >> >> >> $ git clone --recurse-submodules https://github.com/xdp-p=
roject/bpf-examples
>> >> >> >> >> >> $ cd bpf-examples/bpf-link-hang
>> >> >> >> >> >> $ make
>> >> >> >> >> >> $ ./sudo bpf-link-hang
>> >> >> >> >> >>
>> >> >> >> >> >> you'll need to load up the system to trigger the hang; I'=
m using pktgen
>> >> >> >> >> >> from a separate machine to do this.
>> >> >> >> >> >>
>> >> >> >> >> >> My question is, of course, as ever, What Is To Be Done? I=
s it expected
>> >> >> >> >> >> that synchronize_rcu_tasks() can hang indefinitely on a P=
REEMPT system,
>> >> >> >> >> >> or can this be fixed? And if it is expected, how can the =
BPF code be
>> >> >> >> >> >> fixed so it doesn't deadlock because of this?
>> >> >> >> >> >>
>> >> >> >> >> >> Hoping you can help us with this - many thanks in advance=
! :)
>> >> >> >> >> >
>> >> >> >> >> > Let me start with the usual question...  Is the network tr=
affic intense
>> >> >> >> >> > enough that one of the CPUs might remain in a loop handlin=
g softirqs
>> >> >> >> >> > indefinitely?
>> >> >> >> >>
>> >> >> >> >> Yup, I'm pegging all CPUs in softirq:
>> >> >> >> >>
>> >> >> >> >> $ mpstat -P ALL 1
>> >> >> >> >> [...]
>> >> >> >> >> 18:26:52     CPU    %usr   %nice    %sys %iowait    %irq   %=
soft  %steal  %guest  %gnice   %idle
>> >> >> >> >> 18:26:53     all    0.00    0.00    0.00    0.00    0.00  10=
0.00    0.00    0.00    0.00    0.00
>> >> >> >> >> 18:26:53       0    0.00    0.00    0.00    0.00    0.00  10=
0.00    0.00    0.00    0.00    0.00
>> >> >> >> >> 18:26:53       1    0.00    0.00    0.00    0.00    0.00  10=
0.00    0.00    0.00    0.00    0.00
>> >> >> >> >> 18:26:53       2    0.00    0.00    0.00    0.00    0.00  10=
0.00    0.00    0.00    0.00    0.00
>> >> >> >> >> 18:26:53       3    0.00    0.00    0.00    0.00    0.00  10=
0.00    0.00    0.00    0.00    0.00
>> >> >> >> >> 18:26:53       4    0.00    0.00    0.00    0.00    0.00  10=
0.00    0.00    0.00    0.00    0.00
>> >> >> >> >> 18:26:53       5    0.00    0.00    0.00    0.00    0.00  10=
0.00    0.00    0.00    0.00    0.00
>> >> >> >> >>
>> >> >> >> >> > If so, does the (untested, probably does not build) patch =
below help?
>> >> >> >> >>
>> >> >> >> >> Doesn't appear to, no. It builds fine, but I still get:
>> >> >> >> >>
>> >> >> >> >> Attaching 2 probes...
>> >> >> >> >> enter
>> >> >> >> >> exit after 8480 ms
>> >> >> >> >>
>> >> >> >> >> (that was me interrupting the network traffic again)
>> >> >> >> >
>> >> >> >> > Is your kernel properly shifting from back-of-interrupt softi=
rq processing
>> >> >> >> > to ksoftirqd under heavy load?  If not, my patch will not hav=
e any
>> >> >> >> > effect.
>> >> >> >>
>> >> >> >> Seems to be - this is from top:
>> >> >> >>
>> >> >> >>      12 root      20   0       0      0      0 R  99.3   0.0   =
0:43.64 ksoftirqd/0
>> >> >> >>      24 root      20   0       0      0      0 R  99.3   0.0   =
0:43.62 ksoftirqd/2
>> >> >> >>      34 root      20   0       0      0      0 R  99.3   0.0   =
0:43.64 ksoftirqd/4
>> >> >> >>      39 root      20   0       0      0      0 R  99.3   0.0   =
0:43.65 ksoftirqd/5
>> >> >> >>      19 root      20   0       0      0      0 R  99.0   0.0   =
0:43.63 ksoftirqd/1
>> >> >> >>      29 root      20   0       0      0      0 R  99.0   0.0   =
0:43.63 ksoftirqd/3
>> >> >> >>
>> >> >> >> Any other ideas? :)
>> >> >> >
>> >> >> > bpf_trampoline_put() got significantly changed by e21aa341785c (=
"bpf:
>> >> >> > Fix fexit trampoline. "), it doesn't do synchronize_rcu_tasks()
>> >> >> > anymore. Please give it a try. It's in bpf tree.
>> >> >>=20
>> >> >> Ah! I had missed that patch, and only tested this on bpf-next. Yes=
, that
>> >> >> indeed works better; awesome!
>> >> >>=20
>> >> >> And sorry for bothering you with this, Paul; guess I should have l=
ooked
>> >> >> harder for fixes first... :/
>> >> >
>> >> > Glad it is now working!
>> >> >
>> >> > And in any case, my patch needed an s/true/false/.  :-/
>> >> >
>> >> > Hey, I did say "untested"!  ;-)
>> >>=20
>> >> Haha, right, well at least you run afoul of the 'truth in advertising'
>> >> committee ;)
>> >
>> > If you get a chance, could you please test the (hopefully) corrected
>> > patch shown below?  This issue might affect other use cases.
>>=20
>> Yup, that does seem to help:
>>=20
>> Attaching 2 probes...
>> enter
>> exit after 136 ms
>
> Thank you very much!  May I please apply your Tested-by?

Sure!

Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

