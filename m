Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA10034694A
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 20:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhCWTuf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 15:50:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22236 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230048AbhCWTuU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Mar 2021 15:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616529020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJHNxW+wfKKDdCTdTsGva71JPjSwGp+J+pmy53U+qkQ=;
        b=Eajdk1OkhouJW6YSWEqB6LrF3ZeX97n9OrHR/6tJRdbo5gOUifDod5x70gu3hlj4FhPM1e
        K7/DCEdTQV/ZIlwVcWD8lys/jvJ5k2BfmPCqnhCXdHif66wnaJ2GbWVN4XwT9ZuIREdYJY
        4ghALpYN5TDmCCfA2N5ZXR3cFtdBUH8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-wHC-LQeKNGigBJQ5JdShRg-1; Tue, 23 Mar 2021 15:50:16 -0400
X-MC-Unique: wHC-LQeKNGigBJQ5JdShRg-1
Received: by mail-ej1-f70.google.com with SMTP id rl7so1532859ejb.16
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 12:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gJHNxW+wfKKDdCTdTsGva71JPjSwGp+J+pmy53U+qkQ=;
        b=c2w4fwMV068m5LNVQf/5UP257NxK28cAFvgo66PPitjtNMQsK7LyvPqcNUL4Xdj3Dd
         xopP2gyJTN9c/49GVpR7kf2GB1bmB6KFRiW2qsNsHAeh/X2o7sdqRepGR7HjgN6auUxd
         W0WnKPRS9ZvuKiZskhQ8uaRbsaTqJx/bHJ0H6aMjlJWMs76Nu2ACjiRZn60qH5FC4HYX
         tLb2Gz55QpXah5F+x60VRs1eyC8slckSCji3ojQKPRbXoPOIrqz4k2eGRQKLOmaOM8LA
         I9SJgm33CsW5YTLPPAjk5EX73jyGtHqK0yeWbObsdX16hxB3oe9QfARLRmW6UwTZCIlS
         uPjQ==
X-Gm-Message-State: AOAM532zqzu75Hw79xA+gp5oTckLEbUJoD/5hHON2mBU7jSbftVomXfE
        VxibMYAM3RqgXIJnXUY7bEH7s1+q+s2PnKq7IyiTSPcvjCnabztP0P84l6tMijOZCV+k4HrLqpw
        NYmpWTOoBL6Oq
X-Received: by 2002:a05:6402:1d33:: with SMTP id dh19mr6152914edb.362.1616529015498;
        Tue, 23 Mar 2021 12:50:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6YtRZcXtrEx5tyIdduCizlGXYMeJAVu6BiATYeGF9TU7f9FZvt6jbqnX1lDKDjrILDGle8w==
X-Received: by 2002:a05:6402:1d33:: with SMTP id dh19mr6152896edb.362.1616529015025;
        Tue, 23 Mar 2021 12:50:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k9sm13537030edn.68.2021.03.23.12.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 12:50:14 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5636B180281; Tue, 23 Mar 2021 20:50:12 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     paulmck@kernel.org
Cc:     bpf@vger.kernel.org, Magnus Karlsson <magnus.karlsson@intel.com>
Subject: Re: BPF trampolines break because of hang in
 synchronize_rcu_tasks() on PREEMPT kernels
In-Reply-To: <20210323175716.GB2696@paulmck-ThinkPad-P72>
References: <877dly6ooz.fsf@toke.dk>
 <20210323164315.GY2696@paulmck-ThinkPad-P72> <871rc57p8g.fsf@toke.dk>
 <20210323175716.GB2696@paulmck-ThinkPad-P72>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 23 Mar 2021 20:50:12 +0100
Message-ID: <87y2ed645n.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Tue, Mar 23, 2021 at 06:29:35PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> "Paul E. McKenney" <paulmck@kernel.org> writes:
>>=20
>> > On Tue, Mar 23, 2021 at 01:26:36PM +0100, Toke H=C3=B8iland-J=C3=B8rge=
nsen wrote:
>> >> Hi Paul
>> >>=20
>> >> Magnus and I have been debugging an issue where close() on a bpf_link
>> >> file descriptor would hang indefinitely when the system was under load
>> >> on a kernel compiled with CONFIG_PREEMPT=3Dy, and it seems to be rela=
ted
>> >> to synchronize_rcu_tasks(), so I'm hoping you can help us with it.
>> >>=20
>> >> The issue is triggered reliably by loading up a system with network
>> >> traffic (causing 100% softirq CPU load on one or more cores), and then
>> >> attaching an freplace bpf_link and closing it again. The close() will
>> >> hang until the network traffic load is lowered.
>> >>=20
>> >> Digging further, it appears that the hang happens in
>> >> synchronize_rcu_tasks(), as seen by running a bpftrace script like:
>> >>=20
>> >> bpftrace -e 'kprobe:synchronize_rcu_tasks { @start =3D nsecs; printf(=
"enter\n"); } kretprobe:synchronize_rcu_tasks { printf("exit after %d ms\n"=
, (nsecs - @start) / 1000000); }'
>> >> Attaching 2 probes...
>> >> enter
>> >> exit after 54 ms
>> >> enter
>> >> exit after 3249 ms
>> >>=20
>> >> (the two enter/exit pairs are, respectively, from an unloaded system,
>> >> and from a loaded system where I stopped the network traffic after a
>> >> couple of seconds).
>> >>=20
>> >> The call to synchronize_rcu_tasks() happens in bpf_trampoline_put():
>> >>=20
>> >> https://elixir.bootlin.com/linux/latest/source/kernel/bpf/trampoline.=
c#L376
>> >>=20
>> >> And because it does this while holding trampoline_mutex, even deferri=
ng
>> >> the put to a worker (as a previously applied-then-reverted patch did[=
0])
>> >> doesn't help: that'll fix the initial hang on close(), but any
>> >> subsequent use of BPF trampolines will then be blocked because of the
>> >> mutex.
>> >>=20
>> >> Also, if I just keep the network traffic running I will eventually ge=
t a
>> >> kernel panic with:
>> >>=20
>> >> kernel:[44348.426312] Kernel panic - not syncing: hung_task: blocked =
tasks
>> >>=20
>> >> I've created a reproducer for the issue here:
>> >> https://github.com/xdp-project/bpf-examples/tree/master/bpf-link-hang
>> >>=20
>> >> To compile simply do this (needs a recent llvm/clang for compiling th=
e BPF program):
>> >>=20
>> >> $ git clone --recurse-submodules https://github.com/xdp-project/bpf-e=
xamples
>> >> $ cd bpf-examples/bpf-link-hang
>> >> $ make
>> >> $ ./sudo bpf-link-hang
>> >>=20
>> >> you'll need to load up the system to trigger the hang; I'm using pktg=
en
>> >> from a separate machine to do this.
>> >>=20
>> >> My question is, of course, as ever, What Is To Be Done? Is it expected
>> >> that synchronize_rcu_tasks() can hang indefinitely on a PREEMPT syste=
m,
>> >> or can this be fixed? And if it is expected, how can the BPF code be
>> >> fixed so it doesn't deadlock because of this?
>> >>=20
>> >> Hoping you can help us with this - many thanks in advance! :)
>> >
>> > Let me start with the usual question...  Is the network traffic intense
>> > enough that one of the CPUs might remain in a loop handling softirqs
>> > indefinitely?
>>=20
>> Yup, I'm pegging all CPUs in softirq:
>>=20
>> $ mpstat -P ALL 1
>> [...]
>> 18:26:52     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal=
  %guest  %gnice   %idle
>> 18:26:53     all    0.00    0.00    0.00    0.00    0.00  100.00    0.00=
    0.00    0.00    0.00
>> 18:26:53       0    0.00    0.00    0.00    0.00    0.00  100.00    0.00=
    0.00    0.00    0.00
>> 18:26:53       1    0.00    0.00    0.00    0.00    0.00  100.00    0.00=
    0.00    0.00    0.00
>> 18:26:53       2    0.00    0.00    0.00    0.00    0.00  100.00    0.00=
    0.00    0.00    0.00
>> 18:26:53       3    0.00    0.00    0.00    0.00    0.00  100.00    0.00=
    0.00    0.00    0.00
>> 18:26:53       4    0.00    0.00    0.00    0.00    0.00  100.00    0.00=
    0.00    0.00    0.00
>> 18:26:53       5    0.00    0.00    0.00    0.00    0.00  100.00    0.00=
    0.00    0.00    0.00
>>=20
>> > If so, does the (untested, probably does not build) patch below help?
>>=20
>> Doesn't appear to, no. It builds fine, but I still get:
>>=20
>> Attaching 2 probes...
>> enter
>> exit after 8480 ms
>>=20
>> (that was me interrupting the network traffic again)
>
> Is your kernel properly shifting from back-of-interrupt softirq processing
> to ksoftirqd under heavy load?  If not, my patch will not have any
> effect.

Seems to be - this is from top:

     12 root      20   0       0      0      0 R  99.3   0.0   0:43.64 ksof=
tirqd/0=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
     24 root      20   0       0      0      0 R  99.3   0.0   0:43.62 ksof=
tirqd/2=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
     34 root      20   0       0      0      0 R  99.3   0.0   0:43.64 ksof=
tirqd/4=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
     39 root      20   0       0      0      0 R  99.3   0.0   0:43.65 ksof=
tirqd/5=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
     19 root      20   0       0      0      0 R  99.0   0.0   0:43.63 ksof=
tirqd/1=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
     29 root      20   0       0      0      0 R  99.0   0.0   0:43.63 ksof=
tirqd/3=20=20=20=20=20

Any other ideas? :)

(And thanks for taking a look, BTW!)

-Toke

