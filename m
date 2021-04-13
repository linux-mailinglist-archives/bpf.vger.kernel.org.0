Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6FA35E879
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 23:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhDMVn7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 17:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345350AbhDMVn5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 17:43:57 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38CBC061574
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 14:43:35 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id x76so9802231ybe.5
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 14:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kcFlzNqAu39YayNllapyK0vi3XSnSkry/R7jzt3TQ/k=;
        b=Y84+Bg5Ej7PWm2JWLiYodchxZOLMccEqvqZ/3LXg7xv6WexcdIaaAWcDlNikAUpf5+
         ZtDLLCRSLyFM6756Sq1TEH3FR2zbOTHrihOAS1YzSvUgyfxJLD21hA0lb82yHCIGFcgD
         keo5xP9zt8K/63o+augfEPSIFmq/RIWnl6kQ9xA9voVy1ygHSvVk7jWoDVCttAfMuS0g
         +DW3qeK0Kpf+KCCFpIKqMm7dvB7XCAJhcP8WBoY24plkzPF84Mnees6PWUnFt6nQqVZU
         7mAlVG6AwDPaMGVY14I9GS/k08Uaqe0Q9GgeL//QX16FYJVmXlIgU78GmnCK3Uo/OMA8
         zszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kcFlzNqAu39YayNllapyK0vi3XSnSkry/R7jzt3TQ/k=;
        b=dvA70q9SOMtLwh4rV3oYF7ZK0tnI+Mt1YtW4ybQJI9ssTYrX8ZsDYXuuOLtGAuSVPP
         lVe2rB2Ocr4diY2xOOE3UCRkAVlMn8h6LJOhH70QbP6qbGow6Kv+yc1KnCNdAAx10cij
         ez/mwTBYhsCGhbBMdp2q6OZP+GQAvdRYY94hyY5aLOgONo6hmNEt1XlyT0LDbPsBd5Np
         Unxhu5sYqbSzRxdkCsP9qFoZ9TYMk4eV0xCwiU2eCubtGz34aoigUHfeGgsbKpVrNyA+
         GaoMuuBMP8XPsDE8Hsq8JRtIAznncN0RQ9VSDoW9BoZGThHAnUSMFQzdKW6v+rlpPEos
         qMiA==
X-Gm-Message-State: AOAM531qsb4SQIahRpimGNATHgoGQq8dsoq6tspjFgI9ivkAaqJY+ZDj
        NmusQ7gPdaYnb1ypG84zA933FEBMhyYS23vuDQc=
X-Google-Smtp-Source: ABdhPJzLHMwRnCcgVbsn0YAs8xMat3fYUpzinYP4tikG8fvRXmu974+7wHgPQVmEiCrgR/SoktPhJldcgmNJG9ftMyY=
X-Received: by 2002:a25:d70f:: with SMTP id o15mr36220700ybg.403.1618350214908;
 Tue, 13 Apr 2021 14:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <87blaozi20.fsf@toke.dk> <CAEf4Bzb4LDi1ZVrhNEojpWhxi33tkv4rv6F7Czj28Y0tHxXh0w@mail.gmail.com>
 <87im4qo9ey.fsf@toke.dk>
In-Reply-To: <87im4qo9ey.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Apr 2021 14:43:24 -0700
Message-ID: <CAEf4Bzahxw5-KTb2yOk8PHQmEyc6gDgTTR6znZjH2OhZ66wiUw@mail.gmail.com>
Subject: Re: Selftest failures related to kern_sync_rcu()
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 13, 2021 at 1:50 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Thu, Apr 8, 2021 at 12:34 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
> >>
> >> Hi Andrii
> >>
> >> I'm getting some selftest failures that all seem to have something to =
do
> >> with kern_sync_rcu() not being enough to trigger the kernel events tha=
t
> >> the selftest expects:
> >>
> >> $ ./test_progs | grep FAIL
> >> test_lookup_update:FAIL:map1_leak inner_map1 leaked!
> >> #15/1 lookup_update:FAIL
> >> #15 btf_map_in_map:FAIL
> >> test_exit_creds:FAIL:null_ptr_count unexpected null_ptr_count: actual =
0 =3D=3D expected 0
> >> #123/2 exit_creds:FAIL
> >> #123 task_local_storage:FAIL
> >> test_exit_creds:FAIL:null_ptr_count unexpected null_ptr_count: actual =
0 =3D=3D expected 0
> >> #123/2 exit_creds:FAIL
> >> #123 task_local_storage:FAIL
> >>
> >> They are all fixed by adding a sleep(1) after the call(s) to
> >> kern_sync_rcu(), so I'm guessing it's some kind of
> >> timing/synchronisation problem. Is there a particular kernel config
> >> that's needed for the membarrier syscall trick to work? I've tried wit=
h
> >> various settings of PREEMPT and that doesn't really seem to make any
> >> difference...
> >>
> >
> > If you check kern_sync_rcu(), it relies on membarrier() syscall
> > (passing cmd =3D MEMBARRIER_CMD_SHARED =3D=3D MEMBARRIER_CMD_GLOBAL).
> > Now, looking at kernel sources:
> >   - CONFIG_MEMBARRIER should be enabled for that syscall;
> >   - it has some extra conditions:
> >
> >            case MEMBARRIER_CMD_GLOBAL:
> >                 /* MEMBARRIER_CMD_GLOBAL is not compatible with nohz_fu=
ll. */
> >                 if (tick_nohz_full_enabled())
> >                         return -EINVAL;
> >                 if (num_online_cpus() > 1)
> >                         synchronize_rcu();
> >                 return 0;
> >
> > Could it be that one of those conditions is not satisfied?
>
> Aha, bingo! Found the membarrier syscall stuff, but for some reason
> didn't think to actually read the code of it; and I was running this in
> a VM with a single CPU, adding another fixed this. Thanks! :)
>
> Do you think we could detect this in the tests? I suppose the
> tick_nohz_full_enabled() check should already result in a visible
> failure since that makes the syscall fail; but the CPU thing is silent,
> so it would be nice with a hint. Could kern_sync_rcu() check the CPU
> count and print a warning or fail if it is 1? Or maybe just straight up
> fall back to sleep()'ing?

If membarrier() is unreliable, I guess we can just go back to the
previous way of triggering synchronize_rcu() (create and update
map-in-map element)? See 635599bace25 ("selftests/bpf: Sync RCU before
unloading bpf_testmod") that removed that in favor of membarrier()
syscall.

>
> -Toke
>
