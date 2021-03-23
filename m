Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08BA346BB0
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 23:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbhCWWGb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 18:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44798 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233750AbhCWWGY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Mar 2021 18:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616537173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gcFRc4wSxJLHsYPR+ETXZS3sxkve4J8hcHKv52Do7/E=;
        b=VTKu+OqrFzktNc2yROiRNU1XHB7SXJh7o25mAkocSeskn+6sIeGF+K/qd7LsulcerA57JI
        wm3i3Bay7RI+tGJqCyKcF9fjs67XY6aMZfkW4660jjRKKjmPVj4obrUBwnLSUG2XVwyjHd
        nS9BD2FHRF30LNf/h85MwZQHdUX/UXw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-aB4TpDrnMteziupkFu3JwQ-1; Tue, 23 Mar 2021 18:06:08 -0400
X-MC-Unique: aB4TpDrnMteziupkFu3JwQ-1
Received: by mail-ej1-f69.google.com with SMTP id a22so34944ejx.10
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 15:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gcFRc4wSxJLHsYPR+ETXZS3sxkve4J8hcHKv52Do7/E=;
        b=C7XdYAHRvQB0NswyZQUpYILtJKR/ue6oACU9gT6QU9Xrnk2h3uiRbjF/ZLvXi244zl
         1HVnu/LJu3HyDNOUn2lXPsvlxG4MIQm9ff+U2u31keCvq50vGkQC+ipufkkkFHXD2x+A
         Go3zpDdL2he6QbCrpqDGiwbuC/Wrpap5zYnZsV0zI94UhyHX1/DfLmgC3US8/KYXJDDV
         dQdBULVWQSnkta6NR7bjDi3teXAYGuRHLb3JbIiRjEQACafFT7AdvVto18z+Yu3zFISe
         zuWtamx2BQKa+F28XjyEZ8RWP7OQNLucXO63ewnQl2ZEZYrK//cXzMhtAASZfSyXgNYV
         RQ4w==
X-Gm-Message-State: AOAM5318DUDP1/EfXEF5ZneHTWHm3voHNMkniURvg7L2r+tLd84mq7XR
        AlGRScC3VG3pmXICgUzoIF2Scj9nUFxKuuoy08sM2d/cmpjAFDxCH88NB6X9FkEi3Os7/SpUoz8
        Fn3mSt4NXfibK
X-Received: by 2002:a17:907:3d01:: with SMTP id gm1mr357607ejc.214.1616537166476;
        Tue, 23 Mar 2021 15:06:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKPFkUkkXGd/AgKmAmB3zK8Lw2mfk7kgt2wR2Ue2+thTJAkQU8YLIwFDQrr4yY79W7x62mQw==
X-Received: by 2002:a17:907:3d01:: with SMTP id gm1mr357588ejc.214.1616537166253;
        Tue, 23 Mar 2021 15:06:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v15sm145591edw.28.2021.03.23.15.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 15:06:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 10024180290; Tue, 23 Mar 2021 23:06:05 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     paulmck@kernel.org
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Subject: Re: BPF trampolines break because of hang in
 synchronize_rcu_tasks() on PREEMPT kernels
In-Reply-To: <20210323215247.GD2696@paulmck-ThinkPad-P72>
References: <877dly6ooz.fsf@toke.dk>
 <20210323164315.GY2696@paulmck-ThinkPad-P72> <871rc57p8g.fsf@toke.dk>
 <20210323175716.GB2696@paulmck-ThinkPad-P72> <87y2ed645n.fsf@toke.dk>
 <CAEf4Bzap-8uTFS=dJjq7o+g=e=5PvyD3_1TpnhmmoVuP0SUjjQ@mail.gmail.com>
 <87r1k560p9.fsf@toke.dk> <20210323215247.GD2696@paulmck-ThinkPad-P72>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 23 Mar 2021 23:06:04 +0100
Message-ID: <87lfad5xv7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Tue, Mar 23, 2021 at 10:04:50PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>=20
>> > On Tue, Mar 23, 2021 at 12:52 PM Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@redhat.com> wrote:
>> >>
>> >> "Paul E. McKenney" <paulmck@kernel.org> writes:
>> >>
>> >> > On Tue, Mar 23, 2021 at 06:29:35PM +0100, Toke H=C3=B8iland-J=C3=B8=
rgensen wrote:
>> >> >> "Paul E. McKenney" <paulmck@kernel.org> writes:
>> >> >>
>> >> >> > On Tue, Mar 23, 2021 at 01:26:36PM +0100, Toke H=C3=B8iland-J=C3=
=B8rgensen wrote:
>> >> >> >> Hi Paul
>> >> >> >>
>> >> >> >> Magnus and I have been debugging an issue where close() on a bp=
f_link
>> >> >> >> file descriptor would hang indefinitely when the system was und=
er load
>> >> >> >> on a kernel compiled with CONFIG_PREEMPT=3Dy, and it seems to b=
e related
>> >> >> >> to synchronize_rcu_tasks(), so I'm hoping you can help us with =
it.
>> >> >> >>
>> >> >> >> The issue is triggered reliably by loading up a system with net=
work
>> >> >> >> traffic (causing 100% softirq CPU load on one or more cores), a=
nd then
>> >> >> >> attaching an freplace bpf_link and closing it again. The close(=
) will
>> >> >> >> hang until the network traffic load is lowered.
>> >> >> >>
>> >> >> >> Digging further, it appears that the hang happens in
>> >> >> >> synchronize_rcu_tasks(), as seen by running a bpftrace script l=
ike:
>> >> >> >>
>> >> >> >> bpftrace -e 'kprobe:synchronize_rcu_tasks { @start =3D nsecs; p=
rintf("enter\n"); } kretprobe:synchronize_rcu_tasks { printf("exit after %d=
 ms\n", (nsecs - @start) / 1000000); }'
>> >> >> >> Attaching 2 probes...
>> >> >> >> enter
>> >> >> >> exit after 54 ms
>> >> >> >> enter
>> >> >> >> exit after 3249 ms
>> >> >> >>
>> >> >> >> (the two enter/exit pairs are, respectively, from an unloaded s=
ystem,
>> >> >> >> and from a loaded system where I stopped the network traffic af=
ter a
>> >> >> >> couple of seconds).
>> >> >> >>
>> >> >> >> The call to synchronize_rcu_tasks() happens in bpf_trampoline_p=
ut():
>> >> >> >>
>> >> >> >> https://elixir.bootlin.com/linux/latest/source/kernel/bpf/tramp=
oline.c#L376
>> >> >> >>
>> >> >> >> And because it does this while holding trampoline_mutex, even d=
eferring
>> >> >> >> the put to a worker (as a previously applied-then-reverted patc=
h did[0])
>> >> >> >> doesn't help: that'll fix the initial hang on close(), but any
>> >> >> >> subsequent use of BPF trampolines will then be blocked because =
of the
>> >> >> >> mutex.
>> >> >> >>
>> >> >> >> Also, if I just keep the network traffic running I will eventua=
lly get a
>> >> >> >> kernel panic with:
>> >> >> >>
>> >> >> >> kernel:[44348.426312] Kernel panic - not syncing: hung_task: bl=
ocked tasks
>> >> >> >>
>> >> >> >> I've created a reproducer for the issue here:
>> >> >> >> https://github.com/xdp-project/bpf-examples/tree/master/bpf-lin=
k-hang
>> >> >> >>
>> >> >> >> To compile simply do this (needs a recent llvm/clang for compil=
ing the BPF program):
>> >> >> >>
>> >> >> >> $ git clone --recurse-submodules https://github.com/xdp-project=
/bpf-examples
>> >> >> >> $ cd bpf-examples/bpf-link-hang
>> >> >> >> $ make
>> >> >> >> $ ./sudo bpf-link-hang
>> >> >> >>
>> >> >> >> you'll need to load up the system to trigger the hang; I'm usin=
g pktgen
>> >> >> >> from a separate machine to do this.
>> >> >> >>
>> >> >> >> My question is, of course, as ever, What Is To Be Done? Is it e=
xpected
>> >> >> >> that synchronize_rcu_tasks() can hang indefinitely on a PREEMPT=
 system,
>> >> >> >> or can this be fixed? And if it is expected, how can the BPF co=
de be
>> >> >> >> fixed so it doesn't deadlock because of this?
>> >> >> >>
>> >> >> >> Hoping you can help us with this - many thanks in advance! :)
>> >> >> >
>> >> >> > Let me start with the usual question...  Is the network traffic =
intense
>> >> >> > enough that one of the CPUs might remain in a loop handling soft=
irqs
>> >> >> > indefinitely?
>> >> >>
>> >> >> Yup, I'm pegging all CPUs in softirq:
>> >> >>
>> >> >> $ mpstat -P ALL 1
>> >> >> [...]
>> >> >> 18:26:52     CPU    %usr   %nice    %sys %iowait    %irq   %soft  =
%steal  %guest  %gnice   %idle
>> >> >> 18:26:53     all    0.00    0.00    0.00    0.00    0.00  100.00  =
  0.00    0.00    0.00    0.00
>> >> >> 18:26:53       0    0.00    0.00    0.00    0.00    0.00  100.00  =
  0.00    0.00    0.00    0.00
>> >> >> 18:26:53       1    0.00    0.00    0.00    0.00    0.00  100.00  =
  0.00    0.00    0.00    0.00
>> >> >> 18:26:53       2    0.00    0.00    0.00    0.00    0.00  100.00  =
  0.00    0.00    0.00    0.00
>> >> >> 18:26:53       3    0.00    0.00    0.00    0.00    0.00  100.00  =
  0.00    0.00    0.00    0.00
>> >> >> 18:26:53       4    0.00    0.00    0.00    0.00    0.00  100.00  =
  0.00    0.00    0.00    0.00
>> >> >> 18:26:53       5    0.00    0.00    0.00    0.00    0.00  100.00  =
  0.00    0.00    0.00    0.00
>> >> >>
>> >> >> > If so, does the (untested, probably does not build) patch below =
help?
>> >> >>
>> >> >> Doesn't appear to, no. It builds fine, but I still get:
>> >> >>
>> >> >> Attaching 2 probes...
>> >> >> enter
>> >> >> exit after 8480 ms
>> >> >>
>> >> >> (that was me interrupting the network traffic again)
>> >> >
>> >> > Is your kernel properly shifting from back-of-interrupt softirq pro=
cessing
>> >> > to ksoftirqd under heavy load?  If not, my patch will not have any
>> >> > effect.
>> >>
>> >> Seems to be - this is from top:
>> >>
>> >>      12 root      20   0       0      0      0 R  99.3   0.0   0:43.6=
4 ksoftirqd/0
>> >>      24 root      20   0       0      0      0 R  99.3   0.0   0:43.6=
2 ksoftirqd/2
>> >>      34 root      20   0       0      0      0 R  99.3   0.0   0:43.6=
4 ksoftirqd/4
>> >>      39 root      20   0       0      0      0 R  99.3   0.0   0:43.6=
5 ksoftirqd/5
>> >>      19 root      20   0       0      0      0 R  99.0   0.0   0:43.6=
3 ksoftirqd/1
>> >>      29 root      20   0       0      0      0 R  99.0   0.0   0:43.6=
3 ksoftirqd/3
>> >>
>> >> Any other ideas? :)
>> >
>> > bpf_trampoline_put() got significantly changed by e21aa341785c ("bpf:
>> > Fix fexit trampoline. "), it doesn't do synchronize_rcu_tasks()
>> > anymore. Please give it a try. It's in bpf tree.
>>=20
>> Ah! I had missed that patch, and only tested this on bpf-next. Yes, that
>> indeed works better; awesome!
>>=20
>> And sorry for bothering you with this, Paul; guess I should have looked
>> harder for fixes first... :/
>
> Glad it is now working!
>
> And in any case, my patch needed an s/true/false/.  :-/
>
> Hey, I did say "untested"!  ;-)

Haha, right, well at least you run afoul of the 'truth in advertising'
committee ;)

-Toke

