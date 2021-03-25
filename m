Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFB8349B7B
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 22:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhCYVNp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 17:13:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37677 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230389AbhCYVNl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Mar 2021 17:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616706820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gusjwqd76xLHRPl6x0L3inoDLfaPrhnDXisHaSG+zSM=;
        b=SqX9u6OJlFW6CJl1lBhQr3O6igesdHG/9/9E9NYbHJaT1Zdj3WartL7qILDk1O99MnvzD4
        pFE5l3K4/yzK+twGtmAftc2s2qH98wsQFi0+7kk/BXjxHtuKc7ol4VJJyVmAhV8kG4HK60
        vO1R5Q96fxYaIvqebHDqeXtZkV6lJZ4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-36odufV-OHCPkq0SwaltyA-1; Thu, 25 Mar 2021 17:13:36 -0400
X-MC-Unique: 36odufV-OHCPkq0SwaltyA-1
Received: by mail-ej1-f70.google.com with SMTP id r26so3181500eja.22
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 14:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Gusjwqd76xLHRPl6x0L3inoDLfaPrhnDXisHaSG+zSM=;
        b=gdVYLPwFx0Tr/p4w6uZ3Ffc6UnsN0ip6i4Jz+4SjdPLPztwYglE/JFBy+hekyRw8eo
         QTroTkWsQY5aoeW1RgnhS+nLJA5XXUA2mRjo0da62njHXD8cxCuSeRDr4bMQGWvcAaTu
         wwFw6g0VGpFuV+RJQUrq1cxDsznyubAU7JrVx0BqwCBsCmvD5dn6cTBa+LRHsLycfoHN
         y4Aju2pbik26ED159/bo554/7/lrbLWc/S3QnODAECrmBvzF5R2N9uwrcCDbrYYr/ZtH
         F5AcXb2upycpwTx9djhE3W36xEnXSjr/ZNYlKBNBHXpezPWuN798izry2WOC2HifcNP6
         HoEQ==
X-Gm-Message-State: AOAM530nYr5KSAIcTJYJT5BolfDV/5pa31IlUs6M1yL4tPxy7CIS3IxB
        TrMw8ZRlyk6qcv5Cq0IPPccpJDg0UIt+eI1DRgGhPgkYNmNXpQRGyQ4uPlWk6Y7MA8M+IN3cb5s
        PlSBLiynAPx7J
X-Received: by 2002:a17:907:36e:: with SMTP id rs14mr11467768ejb.42.1616706814201;
        Thu, 25 Mar 2021 14:13:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+h79RFLaxtN1RT/sVje+X87I3G9pQK9xhkGDnb2hfANB+HzGvmgy/owTyQdRhSMcOAVxaUA==
X-Received: by 2002:a17:907:36e:: with SMTP id rs14mr11467738ejb.42.1616706813813;
        Thu, 25 Mar 2021 14:13:33 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id w24sm3202882edt.44.2021.03.25.14.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 14:13:33 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C3EC41801A3; Thu, 25 Mar 2021 22:13:32 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     paulmck@kernel.org
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Subject: Re: BPF trampolines break because of hang in
 synchronize_rcu_tasks() on PREEMPT kernels
In-Reply-To: <20210325162819.GN2696@paulmck-ThinkPad-P72>
References: <20210323175716.GB2696@paulmck-ThinkPad-P72>
 <87y2ed645n.fsf@toke.dk>
 <CAEf4Bzap-8uTFS=dJjq7o+g=e=5PvyD3_1TpnhmmoVuP0SUjjQ@mail.gmail.com>
 <87r1k560p9.fsf@toke.dk> <20210323215247.GD2696@paulmck-ThinkPad-P72>
 <87lfad5xv7.fsf@toke.dk> <20210324024148.GG2696@paulmck-ThinkPad-P72>
 <87o8f8g50k.fsf@toke.dk> <20210324161149.GJ2696@paulmck-ThinkPad-P72>
 <87ft0kfjjk.fsf@toke.dk> <20210325162819.GN2696@paulmck-ThinkPad-P72>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 25 Mar 2021 22:13:32 +0100
Message-ID: <875z1fdjib.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Wed, Mar 24, 2021 at 08:17:35PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> "Paul E. McKenney" <paulmck@kernel.org> writes:
>>=20
>> > On Wed, Mar 24, 2021 at 12:33:47PM +0100, Toke H=C3=B8iland-J=C3=B8rge=
nsen wrote:
>> >> "Paul E. McKenney" <paulmck@kernel.org> writes:
>> >>=20
>> >> > On Tue, Mar 23, 2021 at 11:06:04PM +0100, Toke H=C3=B8iland-J=C3=B8=
rgensen wrote:
>> >> >> "Paul E. McKenney" <paulmck@kernel.org> writes:
>> >> >>=20
>> >> >> > On Tue, Mar 23, 2021 at 10:04:50PM +0100, Toke H=C3=B8iland-J=C3=
=B8rgensen wrote:
>> >> >> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>> >> >> >>=20
>> >> >> >> > On Tue, Mar 23, 2021 at 12:52 PM Toke H=C3=B8iland-J=C3=B8rge=
nsen <toke@redhat.com> wrote:
>> >> >> >> >>
>> >> >> >> >> "Paul E. McKenney" <paulmck@kernel.org> writes:
>> >> >> >> >>
>> >> >> >> >> > On Tue, Mar 23, 2021 at 06:29:35PM +0100, Toke H=C3=B8ilan=
d-J=C3=B8rgensen wrote:
>> >> >> >> >> >> "Paul E. McKenney" <paulmck@kernel.org> writes:
>> >> >> >> >> >>
>> >> >> >> >> >> > On Tue, Mar 23, 2021 at 01:26:36PM +0100, Toke H=C3=B8i=
land-J=C3=B8rgensen wrote:
>> >> >> >> >> >> >> Hi Paul
>> >> >> >> >> >> >>
>> >> >> >> >> >> >> Magnus and I have been debugging an issue where close(=
) on a bpf_link
>> >> >> >> >> >> >> file descriptor would hang indefinitely when the syste=
m was under load
>> >> >> >> >> >> >> on a kernel compiled with CONFIG_PREEMPT=3Dy, and it s=
eems to be related
>> >> >> >> >> >> >> to synchronize_rcu_tasks(), so I'm hoping you can help=
 us with it.
>> >> >> >> >> >> >>
>> >> >> >> >> >> >> The issue is triggered reliably by loading up a system=
 with network
>> >> >> >> >> >> >> traffic (causing 100% softirq CPU load on one or more =
cores), and then
>> >> >> >> >> >> >> attaching an freplace bpf_link and closing it again. T=
he close() will
>> >> >> >> >> >> >> hang until the network traffic load is lowered.
>> >> >> >> >> >> >>
>> >> >> >> >> >> >> Digging further, it appears that the hang happens in
>> >> >> >> >> >> >> synchronize_rcu_tasks(), as seen by running a bpftrace=
 script like:
>> >> >> >> >> >> >>
>> >> >> >> >> >> >> bpftrace -e 'kprobe:synchronize_rcu_tasks { @start =3D=
 nsecs; printf("enter\n"); } kretprobe:synchronize_rcu_tasks { printf("exit=
 after %d ms\n", (nsecs - @start) / 1000000); }'
>> >> >> >> >> >> >> Attaching 2 probes...
>> >> >> >> >> >> >> enter
>> >> >> >> >> >> >> exit after 54 ms
>> >> >> >> >> >> >> enter
>> >> >> >> >> >> >> exit after 3249 ms
>> >> >> >> >> >> >>
>> >> >> >> >> >> >> (the two enter/exit pairs are, respectively, from an u=
nloaded system,
>> >> >> >> >> >> >> and from a loaded system where I stopped the network t=
raffic after a
>> >> >> >> >> >> >> couple of seconds).
>> >> >> >> >> >> >>
>> >> >> >> >> >> >> The call to synchronize_rcu_tasks() happens in bpf_tra=
mpoline_put():
>> >> >> >> >> >> >>
>> >> >> >> >> >> >> https://elixir.bootlin.com/linux/latest/source/kernel/=
bpf/trampoline.c#L376
>> >> >> >> >> >> >>
>> >> >> >> >> >> >> And because it does this while holding trampoline_mute=
x, even deferring
>> >> >> >> >> >> >> the put to a worker (as a previously applied-then-reve=
rted patch did[0])
>> >> >> >> >> >> >> doesn't help: that'll fix the initial hang on close(),=
 but any
>> >> >> >> >> >> >> subsequent use of BPF trampolines will then be blocked=
 because of the
>> >> >> >> >> >> >> mutex.
>> >> >> >> >> >> >>
>> >> >> >> >> >> >> Also, if I just keep the network traffic running I wil=
l eventually get a
>> >> >> >> >> >> >> kernel panic with:
>> >> >> >> >> >> >>
>> >> >> >> >> >> >> kernel:[44348.426312] Kernel panic - not syncing: hung=
_task: blocked tasks
>> >> >> >> >> >> >>
>> >> >> >> >> >> >> I've created a reproducer for the issue here:
>> >> >> >> >> >> >> https://github.com/xdp-project/bpf-examples/tree/maste=
r/bpf-link-hang
>> >> >> >> >> >> >>
>> >> >> >> >> >> >> To compile simply do this (needs a recent llvm/clang f=
or compiling the BPF program):
>> >> >> >> >> >> >>
>> >> >> >> >> >> >> $ git clone --recurse-submodules https://github.com/xd=
p-project/bpf-examples
>> >> >> >> >> >> >> $ cd bpf-examples/bpf-link-hang
>> >> >> >> >> >> >> $ make
>> >> >> >> >> >> >> $ ./sudo bpf-link-hang
>> >> >> >> >> >> >>
>> >> >> >> >> >> >> you'll need to load up the system to trigger the hang;=
 I'm using pktgen
>> >> >> >> >> >> >> from a separate machine to do this.
>> >> >> >> >> >> >>
>> >> >> >> >> >> >> My question is, of course, as ever, What Is To Be Done=
? Is it expected
>> >> >> >> >> >> >> that synchronize_rcu_tasks() can hang indefinitely on =
a PREEMPT system,
>> >> >> >> >> >> >> or can this be fixed? And if it is expected, how can t=
he BPF code be
>> >> >> >> >> >> >> fixed so it doesn't deadlock because of this?
>> >> >> >> >> >> >>
>> >> >> >> >> >> >> Hoping you can help us with this - many thanks in adva=
nce! :)
>> >> >> >> >> >> >
>> >> >> >> >> >> > Let me start with the usual question...  Is the network=
 traffic intense
>> >> >> >> >> >> > enough that one of the CPUs might remain in a loop hand=
ling softirqs
>> >> >> >> >> >> > indefinitely?
>> >> >> >> >> >>
>> >> >> >> >> >> Yup, I'm pegging all CPUs in softirq:
>> >> >> >> >> >>
>> >> >> >> >> >> $ mpstat -P ALL 1
>> >> >> >> >> >> [...]
>> >> >> >> >> >> 18:26:52     CPU    %usr   %nice    %sys %iowait    %irq =
  %soft  %steal  %guest  %gnice   %idle
>> >> >> >> >> >> 18:26:53     all    0.00    0.00    0.00    0.00    0.00 =
 100.00    0.00    0.00    0.00    0.00
>> >> >> >> >> >> 18:26:53       0    0.00    0.00    0.00    0.00    0.00 =
 100.00    0.00    0.00    0.00    0.00
>> >> >> >> >> >> 18:26:53       1    0.00    0.00    0.00    0.00    0.00 =
 100.00    0.00    0.00    0.00    0.00
>> >> >> >> >> >> 18:26:53       2    0.00    0.00    0.00    0.00    0.00 =
 100.00    0.00    0.00    0.00    0.00
>> >> >> >> >> >> 18:26:53       3    0.00    0.00    0.00    0.00    0.00 =
 100.00    0.00    0.00    0.00    0.00
>> >> >> >> >> >> 18:26:53       4    0.00    0.00    0.00    0.00    0.00 =
 100.00    0.00    0.00    0.00    0.00
>> >> >> >> >> >> 18:26:53       5    0.00    0.00    0.00    0.00    0.00 =
 100.00    0.00    0.00    0.00    0.00
>> >> >> >> >> >>
>> >> >> >> >> >> > If so, does the (untested, probably does not build) pat=
ch below help?
>> >> >> >> >> >>
>> >> >> >> >> >> Doesn't appear to, no. It builds fine, but I still get:
>> >> >> >> >> >>
>> >> >> >> >> >> Attaching 2 probes...
>> >> >> >> >> >> enter
>> >> >> >> >> >> exit after 8480 ms
>> >> >> >> >> >>
>> >> >> >> >> >> (that was me interrupting the network traffic again)
>> >> >> >> >> >
>> >> >> >> >> > Is your kernel properly shifting from back-of-interrupt so=
ftirq processing
>> >> >> >> >> > to ksoftirqd under heavy load?  If not, my patch will not =
have any
>> >> >> >> >> > effect.
>> >> >> >> >>
>> >> >> >> >> Seems to be - this is from top:
>> >> >> >> >>
>> >> >> >> >>      12 root      20   0       0      0      0 R  99.3   0.0=
   0:43.64 ksoftirqd/0
>> >> >> >> >>      24 root      20   0       0      0      0 R  99.3   0.0=
   0:43.62 ksoftirqd/2
>> >> >> >> >>      34 root      20   0       0      0      0 R  99.3   0.0=
   0:43.64 ksoftirqd/4
>> >> >> >> >>      39 root      20   0       0      0      0 R  99.3   0.0=
   0:43.65 ksoftirqd/5
>> >> >> >> >>      19 root      20   0       0      0      0 R  99.0   0.0=
   0:43.63 ksoftirqd/1
>> >> >> >> >>      29 root      20   0       0      0      0 R  99.0   0.0=
   0:43.63 ksoftirqd/3
>> >> >> >> >>
>> >> >> >> >> Any other ideas? :)
>> >> >> >> >
>> >> >> >> > bpf_trampoline_put() got significantly changed by e21aa341785=
c ("bpf:
>> >> >> >> > Fix fexit trampoline. "), it doesn't do synchronize_rcu_tasks=
()
>> >> >> >> > anymore. Please give it a try. It's in bpf tree.
>> >> >> >>=20
>> >> >> >> Ah! I had missed that patch, and only tested this on bpf-next. =
Yes, that
>> >> >> >> indeed works better; awesome!
>> >> >> >>=20
>> >> >> >> And sorry for bothering you with this, Paul; guess I should hav=
e looked
>> >> >> >> harder for fixes first... :/
>> >> >> >
>> >> >> > Glad it is now working!
>> >> >> >
>> >> >> > And in any case, my patch needed an s/true/false/.  :-/
>> >> >> >
>> >> >> > Hey, I did say "untested"!  ;-)
>> >> >>=20
>> >> >> Haha, right, well at least you run afoul of the 'truth in advertis=
ing'
>> >> >> committee ;)
>> >> >
>> >> > If you get a chance, could you please test the (hopefully) corrected
>> >> > patch shown below?  This issue might affect other use cases.
>> >>=20
>> >> Yup, that does seem to help:
>> >>=20
>> >> Attaching 2 probes...
>> >> enter
>> >> exit after 136 ms
>> >
>> > Thank you very much!  May I please apply your Tested-by?
>>=20
>> Sure!
>>=20
>> Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> Applied, and thank you!

Awesome! You're welcome, and thank you for the fix (and the quick turnaroun=
d)! :)

-Toke

