Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22070347773
	for <lists+bpf@lfdr.de>; Wed, 24 Mar 2021 12:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhCXLeZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Mar 2021 07:34:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230104AbhCXLdz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Mar 2021 07:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616585634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KfpqiqLB108cW2ovZLrJIMVN26n51v0GVvqZzVDTjZc=;
        b=fptedm/TmbKoIIqlxJfOJJql8Z2XrqCg+wfFcs186eIlp0U8Cl+90aCc8vrtC1eBFDdJuI
        mNn+50dIQuAw3FqGrWncFCKX6y6A7v11SSDabe+N7YNQKDkHeKfLP0N+HkNtJhsdTceUwM
        hWN+I9bnvaFWXuOMCmuen4x4JiBHrUY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-rKDbtTkFMpSUKdECJEtvyA-1; Wed, 24 Mar 2021 07:33:51 -0400
X-MC-Unique: rKDbtTkFMpSUKdECJEtvyA-1
Received: by mail-ed1-f72.google.com with SMTP id a2so876981edx.0
        for <bpf@vger.kernel.org>; Wed, 24 Mar 2021 04:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=KfpqiqLB108cW2ovZLrJIMVN26n51v0GVvqZzVDTjZc=;
        b=DxG3dd1D5iawdPViCfU25rlW30qFxaKPOgEivrhqsqVOyNUUwdSmZ1Xv1cl4c2siq0
         2+HcIesmwU2yU06oXeaLsWG8KeykJ8MsjyDm2TMdNjjAb/1MXl62+y0kFDjqZG1LdNiL
         2oEhn60V8qUXPDg1jFIocv0vbG2MR44FdbS7LtXKx7UWSD9cK8qEC4JJ5RWwaR/4W3ZZ
         dZRJ8mjI8XU67UfgQ8ad0LQO3gYZdn4R7Phbyr2h6uKJgfb/a8Yx396XwRWTz1pIORen
         r0ajGBN3WCYDLVQAEcp8vQV3vEqw48b66QxtJPSQfdUom1WbBf895BPhL3Up8EhmgYyN
         XaTA==
X-Gm-Message-State: AOAM533zgbGCLsx5IockE12UKvIsIB6RnAOidn/0oxMc6FT5Ncg0bzID
        NSvw60uiXlJYEprHu32qWvTMF8/rVzhAhwFwulCsib6Ln0NMyS1lC1rswiPcgsbhxHYGoUn5UHj
        DOXGGZHLLg1gM
X-Received: by 2002:a50:fd83:: with SMTP id o3mr3047046edt.90.1616585629762;
        Wed, 24 Mar 2021 04:33:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7RFoT8jAon5UrIdtX+pDxHCv+65CGHFNdvI59fN2p4L3zUxgeMgMpkAHW2TsPp64zdbyo5w==
X-Received: by 2002:a50:fd83:: with SMTP id o3mr3047027edt.90.1616585629516;
        Wed, 24 Mar 2021 04:33:49 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r17sm984853edm.89.2021.03.24.04.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 04:33:48 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9CA9218028C; Wed, 24 Mar 2021 12:33:47 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     paulmck@kernel.org
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Subject: Re: BPF trampolines break because of hang in
 synchronize_rcu_tasks() on PREEMPT kernels
In-Reply-To: <20210324024148.GG2696@paulmck-ThinkPad-P72>
References: <877dly6ooz.fsf@toke.dk>
 <20210323164315.GY2696@paulmck-ThinkPad-P72> <871rc57p8g.fsf@toke.dk>
 <20210323175716.GB2696@paulmck-ThinkPad-P72> <87y2ed645n.fsf@toke.dk>
 <CAEf4Bzap-8uTFS=dJjq7o+g=e=5PvyD3_1TpnhmmoVuP0SUjjQ@mail.gmail.com>
 <87r1k560p9.fsf@toke.dk> <20210323215247.GD2696@paulmck-ThinkPad-P72>
 <87lfad5xv7.fsf@toke.dk> <20210324024148.GG2696@paulmck-ThinkPad-P72>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 24 Mar 2021 12:33:47 +0100
Message-ID: <87o8f8g50k.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Tue, Mar 23, 2021 at 11:06:04PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> "Paul E. McKenney" <paulmck@kernel.org> writes:
>>=20
>> > On Tue, Mar 23, 2021 at 10:04:50PM +0100, Toke H=C3=B8iland-J=C3=B8rge=
nsen wrote:
>> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>> >>=20
>> >> > On Tue, Mar 23, 2021 at 12:52 PM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>> >> >>
>> >> >> "Paul E. McKenney" <paulmck@kernel.org> writes:
>> >> >>
>> >> >> > On Tue, Mar 23, 2021 at 06:29:35PM +0100, Toke H=C3=B8iland-J=C3=
=B8rgensen wrote:
>> >> >> >> "Paul E. McKenney" <paulmck@kernel.org> writes:
>> >> >> >>
>> >> >> >> > On Tue, Mar 23, 2021 at 01:26:36PM +0100, Toke H=C3=B8iland-J=
=C3=B8rgensen wrote:
>> >> >> >> >> Hi Paul
>> >> >> >> >>
>> >> >> >> >> Magnus and I have been debugging an issue where close() on a=
 bpf_link
>> >> >> >> >> file descriptor would hang indefinitely when the system was =
under load
>> >> >> >> >> on a kernel compiled with CONFIG_PREEMPT=3Dy, and it seems t=
o be related
>> >> >> >> >> to synchronize_rcu_tasks(), so I'm hoping you can help us wi=
th it.
>> >> >> >> >>
>> >> >> >> >> The issue is triggered reliably by loading up a system with =
network
>> >> >> >> >> traffic (causing 100% softirq CPU load on one or more cores)=
, and then
>> >> >> >> >> attaching an freplace bpf_link and closing it again. The clo=
se() will
>> >> >> >> >> hang until the network traffic load is lowered.
>> >> >> >> >>
>> >> >> >> >> Digging further, it appears that the hang happens in
>> >> >> >> >> synchronize_rcu_tasks(), as seen by running a bpftrace scrip=
t like:
>> >> >> >> >>
>> >> >> >> >> bpftrace -e 'kprobe:synchronize_rcu_tasks { @start =3D nsecs=
; printf("enter\n"); } kretprobe:synchronize_rcu_tasks { printf("exit after=
 %d ms\n", (nsecs - @start) / 1000000); }'
>> >> >> >> >> Attaching 2 probes...
>> >> >> >> >> enter
>> >> >> >> >> exit after 54 ms
>> >> >> >> >> enter
>> >> >> >> >> exit after 3249 ms
>> >> >> >> >>
>> >> >> >> >> (the two enter/exit pairs are, respectively, from an unloade=
d system,
>> >> >> >> >> and from a loaded system where I stopped the network traffic=
 after a
>> >> >> >> >> couple of seconds).
>> >> >> >> >>
>> >> >> >> >> The call to synchronize_rcu_tasks() happens in bpf_trampolin=
e_put():
>> >> >> >> >>
>> >> >> >> >> https://elixir.bootlin.com/linux/latest/source/kernel/bpf/tr=
ampoline.c#L376
>> >> >> >> >>
>> >> >> >> >> And because it does this while holding trampoline_mutex, eve=
n deferring
>> >> >> >> >> the put to a worker (as a previously applied-then-reverted p=
atch did[0])
>> >> >> >> >> doesn't help: that'll fix the initial hang on close(), but a=
ny
>> >> >> >> >> subsequent use of BPF trampolines will then be blocked becau=
se of the
>> >> >> >> >> mutex.
>> >> >> >> >>
>> >> >> >> >> Also, if I just keep the network traffic running I will even=
tually get a
>> >> >> >> >> kernel panic with:
>> >> >> >> >>
>> >> >> >> >> kernel:[44348.426312] Kernel panic - not syncing: hung_task:=
 blocked tasks
>> >> >> >> >>
>> >> >> >> >> I've created a reproducer for the issue here:
>> >> >> >> >> https://github.com/xdp-project/bpf-examples/tree/master/bpf-=
link-hang
>> >> >> >> >>
>> >> >> >> >> To compile simply do this (needs a recent llvm/clang for com=
piling the BPF program):
>> >> >> >> >>
>> >> >> >> >> $ git clone --recurse-submodules https://github.com/xdp-proj=
ect/bpf-examples
>> >> >> >> >> $ cd bpf-examples/bpf-link-hang
>> >> >> >> >> $ make
>> >> >> >> >> $ ./sudo bpf-link-hang
>> >> >> >> >>
>> >> >> >> >> you'll need to load up the system to trigger the hang; I'm u=
sing pktgen
>> >> >> >> >> from a separate machine to do this.
>> >> >> >> >>
>> >> >> >> >> My question is, of course, as ever, What Is To Be Done? Is i=
t expected
>> >> >> >> >> that synchronize_rcu_tasks() can hang indefinitely on a PREE=
MPT system,
>> >> >> >> >> or can this be fixed? And if it is expected, how can the BPF=
 code be
>> >> >> >> >> fixed so it doesn't deadlock because of this?
>> >> >> >> >>
>> >> >> >> >> Hoping you can help us with this - many thanks in advance! :)
>> >> >> >> >
>> >> >> >> > Let me start with the usual question...  Is the network traff=
ic intense
>> >> >> >> > enough that one of the CPUs might remain in a loop handling s=
oftirqs
>> >> >> >> > indefinitely?
>> >> >> >>
>> >> >> >> Yup, I'm pegging all CPUs in softirq:
>> >> >> >>
>> >> >> >> $ mpstat -P ALL 1
>> >> >> >> [...]
>> >> >> >> 18:26:52     CPU    %usr   %nice    %sys %iowait    %irq   %sof=
t  %steal  %guest  %gnice   %idle
>> >> >> >> 18:26:53     all    0.00    0.00    0.00    0.00    0.00  100.0=
0    0.00    0.00    0.00    0.00
>> >> >> >> 18:26:53       0    0.00    0.00    0.00    0.00    0.00  100.0=
0    0.00    0.00    0.00    0.00
>> >> >> >> 18:26:53       1    0.00    0.00    0.00    0.00    0.00  100.0=
0    0.00    0.00    0.00    0.00
>> >> >> >> 18:26:53       2    0.00    0.00    0.00    0.00    0.00  100.0=
0    0.00    0.00    0.00    0.00
>> >> >> >> 18:26:53       3    0.00    0.00    0.00    0.00    0.00  100.0=
0    0.00    0.00    0.00    0.00
>> >> >> >> 18:26:53       4    0.00    0.00    0.00    0.00    0.00  100.0=
0    0.00    0.00    0.00    0.00
>> >> >> >> 18:26:53       5    0.00    0.00    0.00    0.00    0.00  100.0=
0    0.00    0.00    0.00    0.00
>> >> >> >>
>> >> >> >> > If so, does the (untested, probably does not build) patch bel=
ow help?
>> >> >> >>
>> >> >> >> Doesn't appear to, no. It builds fine, but I still get:
>> >> >> >>
>> >> >> >> Attaching 2 probes...
>> >> >> >> enter
>> >> >> >> exit after 8480 ms
>> >> >> >>
>> >> >> >> (that was me interrupting the network traffic again)
>> >> >> >
>> >> >> > Is your kernel properly shifting from back-of-interrupt softirq =
processing
>> >> >> > to ksoftirqd under heavy load?  If not, my patch will not have a=
ny
>> >> >> > effect.
>> >> >>
>> >> >> Seems to be - this is from top:
>> >> >>
>> >> >>      12 root      20   0       0      0      0 R  99.3   0.0   0:4=
3.64 ksoftirqd/0
>> >> >>      24 root      20   0       0      0      0 R  99.3   0.0   0:4=
3.62 ksoftirqd/2
>> >> >>      34 root      20   0       0      0      0 R  99.3   0.0   0:4=
3.64 ksoftirqd/4
>> >> >>      39 root      20   0       0      0      0 R  99.3   0.0   0:4=
3.65 ksoftirqd/5
>> >> >>      19 root      20   0       0      0      0 R  99.0   0.0   0:4=
3.63 ksoftirqd/1
>> >> >>      29 root      20   0       0      0      0 R  99.0   0.0   0:4=
3.63 ksoftirqd/3
>> >> >>
>> >> >> Any other ideas? :)
>> >> >
>> >> > bpf_trampoline_put() got significantly changed by e21aa341785c ("bp=
f:
>> >> > Fix fexit trampoline. "), it doesn't do synchronize_rcu_tasks()
>> >> > anymore. Please give it a try. It's in bpf tree.
>> >>=20
>> >> Ah! I had missed that patch, and only tested this on bpf-next. Yes, t=
hat
>> >> indeed works better; awesome!
>> >>=20
>> >> And sorry for bothering you with this, Paul; guess I should have look=
ed
>> >> harder for fixes first... :/
>> >
>> > Glad it is now working!
>> >
>> > And in any case, my patch needed an s/true/false/.  :-/
>> >
>> > Hey, I did say "untested"!  ;-)
>>=20
>> Haha, right, well at least you run afoul of the 'truth in advertising'
>> committee ;)
>
> If you get a chance, could you please test the (hopefully) corrected
> patch shown below?  This issue might affect other use cases.

Yup, that does seem to help:

Attaching 2 probes...
enter
exit after 136 ms

-Toke

