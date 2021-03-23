Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D29434696A
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 21:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhCWUAI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 16:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbhCWUAD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 16:00:03 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2FBC061763
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 13:00:02 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id m132so11626587ybf.2
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 13:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XTtFIfLgkSlIUqtkAVG4Fc9gNSefRC6nWh69X6UjI4c=;
        b=SVtFoP0OyKg+Ysndc4vEJiwscdrslnSRDAtf2+B1sBzpiKrP6g54RFFlLGKXkvaMOy
         lf4if/TKz6SdoU5pavtonv0/z7DK7Fdd5Nzzy8leUSWzEv+hUS9iVsyUerQkAJbqOSk+
         jVqUGUa6b7Hb0hzLQ3hBsHoaTAG9ug1scqSWGUXSLGAKTzh40yUTdqUtdwRKFMeKopj0
         BSwPujMaBnS5WYKMwPK/uutdflFzm2XZ4UDc8x+nVM7FIyly5n+WgBloZYcPEp89flJM
         NX2e+AULpsYbDBka+/7Crw0r/OyMTHDSLuhmY6yByKFVLM8DzeetcTuysOZrM/I3nLS/
         IZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XTtFIfLgkSlIUqtkAVG4Fc9gNSefRC6nWh69X6UjI4c=;
        b=Yv12RAcEmvWR640Wt/3L/kBNFdqp+5RzsP4MznRDExC21gjdvivMOQaa+BPQXzHwY7
         /fmD7z1Ng+EJvaZZtyXCS5eCoGU2tzeLOpOuoS39h/yx7tJ2efxDwc/UWFEwqxzjGxmA
         D81Xrye9NARkvgGVc6qsLwkC9OYoI25IwDhkhWnN634lIqZT7wlMiF98qS3l08wPY/fo
         P1BseZJbAySswcvKu6ImhypdR2bVC6OV3pv8AXatERGWE2hkgLhDVQlgx4BEvPtIT0Ox
         aWqwsRr+5y/7foyTvvNDjCxN0A8qFjWCei+PkytaHuunWY96aIRw0Yl9vQLOFFRggZiT
         WLSw==
X-Gm-Message-State: AOAM530tc9H3Tuu9sgreqV1ZXT90RhoZ24b4RXiTHYoZYjXdpcmQwgVF
        Pds4j12n9I5nhnxfHSo0J6sFqZFHqBjkT1ODdIk=
X-Google-Smtp-Source: ABdhPJypvsXn+8rWJpj81W/kWY3xhzh5VhEDG3SoTEbnfcLkJ4RPMUon3Ec97gvOTqhMZhiH4RQyYFuICcdVticig6U=
X-Received: by 2002:a25:74cb:: with SMTP id p194mr7627661ybc.347.1616529602022;
 Tue, 23 Mar 2021 13:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <877dly6ooz.fsf@toke.dk> <20210323164315.GY2696@paulmck-ThinkPad-P72>
 <871rc57p8g.fsf@toke.dk> <20210323175716.GB2696@paulmck-ThinkPad-P72> <87y2ed645n.fsf@toke.dk>
In-Reply-To: <87y2ed645n.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 Mar 2021 12:59:51 -0700
Message-ID: <CAEf4Bzap-8uTFS=dJjq7o+g=e=5PvyD3_1TpnhmmoVuP0SUjjQ@mail.gmail.com>
Subject: Re: BPF trampolines break because of hang in synchronize_rcu_tasks()
 on PREEMPT kernels
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 23, 2021 at 12:52 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>
> "Paul E. McKenney" <paulmck@kernel.org> writes:
>
> > On Tue, Mar 23, 2021 at 06:29:35PM +0100, Toke H=C3=B8iland-J=C3=B8rgen=
sen wrote:
> >> "Paul E. McKenney" <paulmck@kernel.org> writes:
> >>
> >> > On Tue, Mar 23, 2021 at 01:26:36PM +0100, Toke H=C3=B8iland-J=C3=B8r=
gensen wrote:
> >> >> Hi Paul
> >> >>
> >> >> Magnus and I have been debugging an issue where close() on a bpf_li=
nk
> >> >> file descriptor would hang indefinitely when the system was under l=
oad
> >> >> on a kernel compiled with CONFIG_PREEMPT=3Dy, and it seems to be re=
lated
> >> >> to synchronize_rcu_tasks(), so I'm hoping you can help us with it.
> >> >>
> >> >> The issue is triggered reliably by loading up a system with network
> >> >> traffic (causing 100% softirq CPU load on one or more cores), and t=
hen
> >> >> attaching an freplace bpf_link and closing it again. The close() wi=
ll
> >> >> hang until the network traffic load is lowered.
> >> >>
> >> >> Digging further, it appears that the hang happens in
> >> >> synchronize_rcu_tasks(), as seen by running a bpftrace script like:
> >> >>
> >> >> bpftrace -e 'kprobe:synchronize_rcu_tasks { @start =3D nsecs; print=
f("enter\n"); } kretprobe:synchronize_rcu_tasks { printf("exit after %d ms\=
n", (nsecs - @start) / 1000000); }'
> >> >> Attaching 2 probes...
> >> >> enter
> >> >> exit after 54 ms
> >> >> enter
> >> >> exit after 3249 ms
> >> >>
> >> >> (the two enter/exit pairs are, respectively, from an unloaded syste=
m,
> >> >> and from a loaded system where I stopped the network traffic after =
a
> >> >> couple of seconds).
> >> >>
> >> >> The call to synchronize_rcu_tasks() happens in bpf_trampoline_put()=
:
> >> >>
> >> >> https://elixir.bootlin.com/linux/latest/source/kernel/bpf/trampolin=
e.c#L376
> >> >>
> >> >> And because it does this while holding trampoline_mutex, even defer=
ring
> >> >> the put to a worker (as a previously applied-then-reverted patch di=
d[0])
> >> >> doesn't help: that'll fix the initial hang on close(), but any
> >> >> subsequent use of BPF trampolines will then be blocked because of t=
he
> >> >> mutex.
> >> >>
> >> >> Also, if I just keep the network traffic running I will eventually =
get a
> >> >> kernel panic with:
> >> >>
> >> >> kernel:[44348.426312] Kernel panic - not syncing: hung_task: blocke=
d tasks
> >> >>
> >> >> I've created a reproducer for the issue here:
> >> >> https://github.com/xdp-project/bpf-examples/tree/master/bpf-link-ha=
ng
> >> >>
> >> >> To compile simply do this (needs a recent llvm/clang for compiling =
the BPF program):
> >> >>
> >> >> $ git clone --recurse-submodules https://github.com/xdp-project/bpf=
-examples
> >> >> $ cd bpf-examples/bpf-link-hang
> >> >> $ make
> >> >> $ ./sudo bpf-link-hang
> >> >>
> >> >> you'll need to load up the system to trigger the hang; I'm using pk=
tgen
> >> >> from a separate machine to do this.
> >> >>
> >> >> My question is, of course, as ever, What Is To Be Done? Is it expec=
ted
> >> >> that synchronize_rcu_tasks() can hang indefinitely on a PREEMPT sys=
tem,
> >> >> or can this be fixed? And if it is expected, how can the BPF code b=
e
> >> >> fixed so it doesn't deadlock because of this?
> >> >>
> >> >> Hoping you can help us with this - many thanks in advance! :)
> >> >
> >> > Let me start with the usual question...  Is the network traffic inte=
nse
> >> > enough that one of the CPUs might remain in a loop handling softirqs
> >> > indefinitely?
> >>
> >> Yup, I'm pegging all CPUs in softirq:
> >>
> >> $ mpstat -P ALL 1
> >> [...]
> >> 18:26:52     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %ste=
al  %guest  %gnice   %idle
> >> 18:26:53     all    0.00    0.00    0.00    0.00    0.00  100.00    0.=
00    0.00    0.00    0.00
> >> 18:26:53       0    0.00    0.00    0.00    0.00    0.00  100.00    0.=
00    0.00    0.00    0.00
> >> 18:26:53       1    0.00    0.00    0.00    0.00    0.00  100.00    0.=
00    0.00    0.00    0.00
> >> 18:26:53       2    0.00    0.00    0.00    0.00    0.00  100.00    0.=
00    0.00    0.00    0.00
> >> 18:26:53       3    0.00    0.00    0.00    0.00    0.00  100.00    0.=
00    0.00    0.00    0.00
> >> 18:26:53       4    0.00    0.00    0.00    0.00    0.00  100.00    0.=
00    0.00    0.00    0.00
> >> 18:26:53       5    0.00    0.00    0.00    0.00    0.00  100.00    0.=
00    0.00    0.00    0.00
> >>
> >> > If so, does the (untested, probably does not build) patch below help=
?
> >>
> >> Doesn't appear to, no. It builds fine, but I still get:
> >>
> >> Attaching 2 probes...
> >> enter
> >> exit after 8480 ms
> >>
> >> (that was me interrupting the network traffic again)
> >
> > Is your kernel properly shifting from back-of-interrupt softirq process=
ing
> > to ksoftirqd under heavy load?  If not, my patch will not have any
> > effect.
>
> Seems to be - this is from top:
>
>      12 root      20   0       0      0      0 R  99.3   0.0   0:43.64 ks=
oftirqd/0
>      24 root      20   0       0      0      0 R  99.3   0.0   0:43.62 ks=
oftirqd/2
>      34 root      20   0       0      0      0 R  99.3   0.0   0:43.64 ks=
oftirqd/4
>      39 root      20   0       0      0      0 R  99.3   0.0   0:43.65 ks=
oftirqd/5
>      19 root      20   0       0      0      0 R  99.0   0.0   0:43.63 ks=
oftirqd/1
>      29 root      20   0       0      0      0 R  99.0   0.0   0:43.63 ks=
oftirqd/3
>
> Any other ideas? :)

bpf_trampoline_put() got significantly changed by e21aa341785c ("bpf:
Fix fexit trampoline. "), it doesn't do synchronize_rcu_tasks()
anymore. Please give it a try. It's in bpf tree.

>
> (And thanks for taking a look, BTW!)
>
> -Toke
>
