Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E411F34665C
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 18:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhCWR36 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 13:29:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28771 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230262AbhCWR3o (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Mar 2021 13:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616520583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ffYIDrEd85aYEnoqVMK/ec3UfpS+EL/PInrdg2QSDwI=;
        b=Hohi5oUj+xk3jKA3gzRKKZRBpzNj56eEDRwdgcAmaUvvezpIHd01E24FmSdgPpvTagBTFk
        LK3lcdhUzqSIJaOaX5ukB3ERTOfIoncUHBiAUqil9T9KujKj7sP9SfL7tE3CwD7C+O2eU/
        kyfBLm8Korg6Rxxcpo5C4q6QgHTqmYM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-MUuTVomtNzaBqZgFRMdNnw-1; Tue, 23 Mar 2021 13:29:40 -0400
X-MC-Unique: MUuTVomtNzaBqZgFRMdNnw-1
Received: by mail-ej1-f71.google.com with SMTP id kx22so1382417ejc.17
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 10:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ffYIDrEd85aYEnoqVMK/ec3UfpS+EL/PInrdg2QSDwI=;
        b=KDdAqdYnqBrrmWQWj79vuFPFL6KnML3MNf8PF6KIuVoGNon0b4svAkpnBVbeCpqZ0D
         cD5hXbWaD0st3eVCwCSIwhpYYiAFUnjnD5LY6dXst4h2ZmACQwdmHZi8OD/v17O02+n0
         KVkBMQybhqQTxvmsG/loyNf1Qg9PW3XmhH3kl4vgxawo27X3v3xuAiiuwJzbizQR82OL
         IfB+bKEm3128C2OauK++PMe6EEZDrhqfd8JiDquqCgCkEM2djhQWnGREzxQ663OSjNff
         paTM3WmZue2we6OSRY5fTXUvrVgFZYfecbbE6+bNFaFwmyo2ifjerQ78vEOziEi7svH+
         +sCQ==
X-Gm-Message-State: AOAM533Ngh2RMedO20OxpVyWUhNubD3HoRdUazkVHvlGtSYBP1RlRntN
        IdRHNTkWuMeOshc/Fz10yFFz1S+3tdaEqhtz5/124MIGzHIMknfUomKR9kWHtUg6FonOGasAPbS
        HSYmGYr6Iscbv
X-Received: by 2002:aa7:c386:: with SMTP id k6mr5580959edq.224.1616520577640;
        Tue, 23 Mar 2021 10:29:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxMZjwAYPPZufePXn5rfXAA9KtaRYTFzWwB3sfagGY7oyF65JZmJ0Gv5woOckMBI/kpk2/zg==
X-Received: by 2002:aa7:c386:: with SMTP id k6mr5580916edq.224.1616520577039;
        Tue, 23 Mar 2021 10:29:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id c19sm13458843edu.20.2021.03.23.10.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 10:29:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B5E0C180281; Tue, 23 Mar 2021 18:29:35 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     paulmck@kernel.org
Cc:     bpf@vger.kernel.org, Magnus Karlsson <magnus.karlsson@intel.com>
Subject: Re: BPF trampolines break because of hang in
 synchronize_rcu_tasks() on PREEMPT kernels
In-Reply-To: <20210323164315.GY2696@paulmck-ThinkPad-P72>
References: <877dly6ooz.fsf@toke.dk>
 <20210323164315.GY2696@paulmck-ThinkPad-P72>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 23 Mar 2021 18:29:35 +0100
Message-ID: <871rc57p8g.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Tue, Mar 23, 2021 at 01:26:36PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Hi Paul
>>=20
>> Magnus and I have been debugging an issue where close() on a bpf_link
>> file descriptor would hang indefinitely when the system was under load
>> on a kernel compiled with CONFIG_PREEMPT=3Dy, and it seems to be related
>> to synchronize_rcu_tasks(), so I'm hoping you can help us with it.
>>=20
>> The issue is triggered reliably by loading up a system with network
>> traffic (causing 100% softirq CPU load on one or more cores), and then
>> attaching an freplace bpf_link and closing it again. The close() will
>> hang until the network traffic load is lowered.
>>=20
>> Digging further, it appears that the hang happens in
>> synchronize_rcu_tasks(), as seen by running a bpftrace script like:
>>=20
>> bpftrace -e 'kprobe:synchronize_rcu_tasks { @start =3D nsecs; printf("en=
ter\n"); } kretprobe:synchronize_rcu_tasks { printf("exit after %d ms\n", (=
nsecs - @start) / 1000000); }'
>> Attaching 2 probes...
>> enter
>> exit after 54 ms
>> enter
>> exit after 3249 ms
>>=20
>> (the two enter/exit pairs are, respectively, from an unloaded system,
>> and from a loaded system where I stopped the network traffic after a
>> couple of seconds).
>>=20
>> The call to synchronize_rcu_tasks() happens in bpf_trampoline_put():
>>=20
>> https://elixir.bootlin.com/linux/latest/source/kernel/bpf/trampoline.c#L=
376
>>=20
>> And because it does this while holding trampoline_mutex, even deferring
>> the put to a worker (as a previously applied-then-reverted patch did[0])
>> doesn't help: that'll fix the initial hang on close(), but any
>> subsequent use of BPF trampolines will then be blocked because of the
>> mutex.
>>=20
>> Also, if I just keep the network traffic running I will eventually get a
>> kernel panic with:
>>=20
>> kernel:[44348.426312] Kernel panic - not syncing: hung_task: blocked tas=
ks
>>=20
>> I've created a reproducer for the issue here:
>> https://github.com/xdp-project/bpf-examples/tree/master/bpf-link-hang
>>=20
>> To compile simply do this (needs a recent llvm/clang for compiling the B=
PF program):
>>=20
>> $ git clone --recurse-submodules https://github.com/xdp-project/bpf-exam=
ples
>> $ cd bpf-examples/bpf-link-hang
>> $ make
>> $ ./sudo bpf-link-hang
>>=20
>> you'll need to load up the system to trigger the hang; I'm using pktgen
>> from a separate machine to do this.
>>=20
>> My question is, of course, as ever, What Is To Be Done? Is it expected
>> that synchronize_rcu_tasks() can hang indefinitely on a PREEMPT system,
>> or can this be fixed? And if it is expected, how can the BPF code be
>> fixed so it doesn't deadlock because of this?
>>=20
>> Hoping you can help us with this - many thanks in advance! :)
>
> Let me start with the usual question...  Is the network traffic intense
> enough that one of the CPUs might remain in a loop handling softirqs
> indefinitely?

Yup, I'm pegging all CPUs in softirq:

$ mpstat -P ALL 1
[...]
18:26:52     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %=
guest  %gnice   %idle
18:26:53     all    0.00    0.00    0.00    0.00    0.00  100.00    0.00   =
 0.00    0.00    0.00
18:26:53       0    0.00    0.00    0.00    0.00    0.00  100.00    0.00   =
 0.00    0.00    0.00
18:26:53       1    0.00    0.00    0.00    0.00    0.00  100.00    0.00   =
 0.00    0.00    0.00
18:26:53       2    0.00    0.00    0.00    0.00    0.00  100.00    0.00   =
 0.00    0.00    0.00
18:26:53       3    0.00    0.00    0.00    0.00    0.00  100.00    0.00   =
 0.00    0.00    0.00
18:26:53       4    0.00    0.00    0.00    0.00    0.00  100.00    0.00   =
 0.00    0.00    0.00
18:26:53       5    0.00    0.00    0.00    0.00    0.00  100.00    0.00   =
 0.00    0.00    0.00

> If so, does the (untested, probably does not build) patch below help?

Doesn't appear to, no. It builds fine, but I still get:

Attaching 2 probes...
enter
exit after 8480 ms

(that was me interrupting the network traffic again)

-Toke

