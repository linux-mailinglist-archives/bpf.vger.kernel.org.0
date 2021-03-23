Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F82346ABB
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 22:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhCWVFO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 17:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53241 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233513AbhCWVE6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Mar 2021 17:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616533498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0u4AOiCFav7tVloz609NB0IqC1wW9zQuwg4Yc6Ozt9I=;
        b=aUXsdVYA5r0jMRzRTw/Pxee5jWLw01Ee4pst+ZxH3qcJ3qtf8Q2UX2/9/HQrODLAB3GH8O
        BG0fDeAH4puR0yVIVqd5sgcxNBAiaPNo/JMz4AxsledzQNLu8qWWk6b5Bl+ySEzcaCN8LE
        dDsTNSQOYn5kfiRylhLECN5rQ/Y45d4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-M1X078y-MyC-BAZ2VVguSA-1; Tue, 23 Mar 2021 17:04:54 -0400
X-MC-Unique: M1X078y-MyC-BAZ2VVguSA-1
Received: by mail-ej1-f70.google.com with SMTP id e13so1601445ejd.21
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 14:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0u4AOiCFav7tVloz609NB0IqC1wW9zQuwg4Yc6Ozt9I=;
        b=dsA+dGMnnjfo0kOprXQUjzkuNpQE0iwl6ffBLCbCwanOWhTeXBnGDb/5niXKoKoBsg
         6iHEPHiqK4NaoblW1X/K8VugzPMeLXjWwWcisexF0V4nWM6j0lDy3pEwTukHw21jmNXc
         GJ46+839JoTtGhwu+sZkezuvj1dD+NZasmO7f4GgIhYdBPqkQtVLEYtUBG0Xgd1GY9uz
         21NMbQ1HaWRF5rEr+YvY9CrkkWfolXMZG6ZP3BoRLnxBvXBGz6+Lgb3cN7sVdFu7fqBR
         Db6QbUDACzvJTua96oIOF/YxMHRqcvf3LxZaNSWs16hIMnE0j4aHqD7l79ToemilINYh
         fMmw==
X-Gm-Message-State: AOAM533TiInE9evHTxD9osEYxWlPCeH3n2BaJz0uXaF9+6T03nAHTDKp
        ZXeBGdtTTd33L/XHGfyPPDlRKAQWt/albsnGwufQR/VgfpcrLozJ0qRQknWmHtvgQj4GcnAohWG
        876I/oUNIgjuF
X-Received: by 2002:a50:f747:: with SMTP id j7mr6291253edn.338.1616533493480;
        Tue, 23 Mar 2021 14:04:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd7R+yrWafvP2VeD/cyEopuV4f3+t3zankaTLunjtD9I4s8DaG3NaRbASiqGzSMxJK8KXxYg==
X-Received: by 2002:a50:f747:: with SMTP id j7mr6291231edn.338.1616533493305;
        Tue, 23 Mar 2021 14:04:53 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r24sm82966edw.11.2021.03.23.14.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 14:04:52 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E6146180281; Tue, 23 Mar 2021 22:04:50 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Subject: Re: BPF trampolines break because of hang in
 synchronize_rcu_tasks() on PREEMPT kernels
In-Reply-To: <CAEf4Bzap-8uTFS=dJjq7o+g=e=5PvyD3_1TpnhmmoVuP0SUjjQ@mail.gmail.com>
References: <877dly6ooz.fsf@toke.dk>
 <20210323164315.GY2696@paulmck-ThinkPad-P72> <871rc57p8g.fsf@toke.dk>
 <20210323175716.GB2696@paulmck-ThinkPad-P72> <87y2ed645n.fsf@toke.dk>
 <CAEf4Bzap-8uTFS=dJjq7o+g=e=5PvyD3_1TpnhmmoVuP0SUjjQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 23 Mar 2021 22:04:50 +0100
Message-ID: <87r1k560p9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Mar 23, 2021 at 12:52 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>>
>> "Paul E. McKenney" <paulmck@kernel.org> writes:
>>
>> > On Tue, Mar 23, 2021 at 06:29:35PM +0100, Toke H=C3=B8iland-J=C3=B8rge=
nsen wrote:
>> >> "Paul E. McKenney" <paulmck@kernel.org> writes:
>> >>
>> >> > On Tue, Mar 23, 2021 at 01:26:36PM +0100, Toke H=C3=B8iland-J=C3=B8=
rgensen wrote:
>> >> >> Hi Paul
>> >> >>
>> >> >> Magnus and I have been debugging an issue where close() on a bpf_l=
ink
>> >> >> file descriptor would hang indefinitely when the system was under =
load
>> >> >> on a kernel compiled with CONFIG_PREEMPT=3Dy, and it seems to be r=
elated
>> >> >> to synchronize_rcu_tasks(), so I'm hoping you can help us with it.
>> >> >>
>> >> >> The issue is triggered reliably by loading up a system with network
>> >> >> traffic (causing 100% softirq CPU load on one or more cores), and =
then
>> >> >> attaching an freplace bpf_link and closing it again. The close() w=
ill
>> >> >> hang until the network traffic load is lowered.
>> >> >>
>> >> >> Digging further, it appears that the hang happens in
>> >> >> synchronize_rcu_tasks(), as seen by running a bpftrace script like:
>> >> >>
>> >> >> bpftrace -e 'kprobe:synchronize_rcu_tasks { @start =3D nsecs; prin=
tf("enter\n"); } kretprobe:synchronize_rcu_tasks { printf("exit after %d ms=
\n", (nsecs - @start) / 1000000); }'
>> >> >> Attaching 2 probes...
>> >> >> enter
>> >> >> exit after 54 ms
>> >> >> enter
>> >> >> exit after 3249 ms
>> >> >>
>> >> >> (the two enter/exit pairs are, respectively, from an unloaded syst=
em,
>> >> >> and from a loaded system where I stopped the network traffic after=
 a
>> >> >> couple of seconds).
>> >> >>
>> >> >> The call to synchronize_rcu_tasks() happens in bpf_trampoline_put(=
):
>> >> >>
>> >> >> https://elixir.bootlin.com/linux/latest/source/kernel/bpf/trampoli=
ne.c#L376
>> >> >>
>> >> >> And because it does this while holding trampoline_mutex, even defe=
rring
>> >> >> the put to a worker (as a previously applied-then-reverted patch d=
id[0])
>> >> >> doesn't help: that'll fix the initial hang on close(), but any
>> >> >> subsequent use of BPF trampolines will then be blocked because of =
the
>> >> >> mutex.
>> >> >>
>> >> >> Also, if I just keep the network traffic running I will eventually=
 get a
>> >> >> kernel panic with:
>> >> >>
>> >> >> kernel:[44348.426312] Kernel panic - not syncing: hung_task: block=
ed tasks
>> >> >>
>> >> >> I've created a reproducer for the issue here:
>> >> >> https://github.com/xdp-project/bpf-examples/tree/master/bpf-link-h=
ang
>> >> >>
>> >> >> To compile simply do this (needs a recent llvm/clang for compiling=
 the BPF program):
>> >> >>
>> >> >> $ git clone --recurse-submodules https://github.com/xdp-project/bp=
f-examples
>> >> >> $ cd bpf-examples/bpf-link-hang
>> >> >> $ make
>> >> >> $ ./sudo bpf-link-hang
>> >> >>
>> >> >> you'll need to load up the system to trigger the hang; I'm using p=
ktgen
>> >> >> from a separate machine to do this.
>> >> >>
>> >> >> My question is, of course, as ever, What Is To Be Done? Is it expe=
cted
>> >> >> that synchronize_rcu_tasks() can hang indefinitely on a PREEMPT sy=
stem,
>> >> >> or can this be fixed? And if it is expected, how can the BPF code =
be
>> >> >> fixed so it doesn't deadlock because of this?
>> >> >>
>> >> >> Hoping you can help us with this - many thanks in advance! :)
>> >> >
>> >> > Let me start with the usual question...  Is the network traffic int=
ense
>> >> > enough that one of the CPUs might remain in a loop handling softirqs
>> >> > indefinitely?
>> >>
>> >> Yup, I'm pegging all CPUs in softirq:
>> >>
>> >> $ mpstat -P ALL 1
>> >> [...]
>> >> 18:26:52     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %st=
eal  %guest  %gnice   %idle
>> >> 18:26:53     all    0.00    0.00    0.00    0.00    0.00  100.00    0=
.00    0.00    0.00    0.00
>> >> 18:26:53       0    0.00    0.00    0.00    0.00    0.00  100.00    0=
.00    0.00    0.00    0.00
>> >> 18:26:53       1    0.00    0.00    0.00    0.00    0.00  100.00    0=
.00    0.00    0.00    0.00
>> >> 18:26:53       2    0.00    0.00    0.00    0.00    0.00  100.00    0=
.00    0.00    0.00    0.00
>> >> 18:26:53       3    0.00    0.00    0.00    0.00    0.00  100.00    0=
.00    0.00    0.00    0.00
>> >> 18:26:53       4    0.00    0.00    0.00    0.00    0.00  100.00    0=
.00    0.00    0.00    0.00
>> >> 18:26:53       5    0.00    0.00    0.00    0.00    0.00  100.00    0=
.00    0.00    0.00    0.00
>> >>
>> >> > If so, does the (untested, probably does not build) patch below hel=
p?
>> >>
>> >> Doesn't appear to, no. It builds fine, but I still get:
>> >>
>> >> Attaching 2 probes...
>> >> enter
>> >> exit after 8480 ms
>> >>
>> >> (that was me interrupting the network traffic again)
>> >
>> > Is your kernel properly shifting from back-of-interrupt softirq proces=
sing
>> > to ksoftirqd under heavy load?  If not, my patch will not have any
>> > effect.
>>
>> Seems to be - this is from top:
>>
>>      12 root      20   0       0      0      0 R  99.3   0.0   0:43.64 k=
softirqd/0
>>      24 root      20   0       0      0      0 R  99.3   0.0   0:43.62 k=
softirqd/2
>>      34 root      20   0       0      0      0 R  99.3   0.0   0:43.64 k=
softirqd/4
>>      39 root      20   0       0      0      0 R  99.3   0.0   0:43.65 k=
softirqd/5
>>      19 root      20   0       0      0      0 R  99.0   0.0   0:43.63 k=
softirqd/1
>>      29 root      20   0       0      0      0 R  99.0   0.0   0:43.63 k=
softirqd/3
>>
>> Any other ideas? :)
>
> bpf_trampoline_put() got significantly changed by e21aa341785c ("bpf:
> Fix fexit trampoline. "), it doesn't do synchronize_rcu_tasks()
> anymore. Please give it a try. It's in bpf tree.

Ah! I had missed that patch, and only tested this on bpf-next. Yes, that
indeed works better; awesome!

And sorry for bothering you with this, Paul; guess I should have looked
harder for fixes first... :/

-Toke

