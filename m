Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169AB35F880
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 18:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhDNPyj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 11:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbhDNPyi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 11:54:38 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA50C061574
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 08:54:16 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id n138so34091775lfa.3
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mAxO4he0HuNzEqBf+z/YkOk/rK/vA9d3HPP1mfnKePs=;
        b=MOVoxFgQiataYd2qHzfmnlr+R+d1jlmo/N2HSt0vI8QeQeW4nFB+ELH7b6mKjXtpqS
         aHoT4gNiUEnlSnpATVkq2Y/1qNaM4L9ZoCS6AP5VSk4+aMZuZ0GSXQ/fJ3c2a8pYBmfL
         sNzHcRM7Zn7GU5Ngw7zhmeNX5NWH4b85IyEnII2sslbSCvZeFrG7tISBq8zbBIMYbJYo
         /dIS8eLp95Y7CyVGOn8hDTWQ7Oj/BaGOLnfDhNZLxLKfXfvzTgVSeX7nqa866py+8fVO
         T0XS5zW1honEIfK77dIUI5zPHZXRJlUn09jvlIfaAevdu5olCmlHItF5XgergOEjMmRI
         gezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mAxO4he0HuNzEqBf+z/YkOk/rK/vA9d3HPP1mfnKePs=;
        b=eMuNRen9XQDsKDEAhO+8s1ixZXTH/BRz4GTCgrRpXyr5R8D0nkDtjQ3Cd3KTxHm9k6
         AnYQ03CyC1mmrrZ+OQdE2oBs5k143WpzAb7kQTVNQBcYIDOjcO5HAkJqLOAesTf6bFWu
         6zZ1sog00/hava/UjCubR6pbrEPhDh45D5oufdGj8Ju+0p/B6r74dvtD1s6/oXT+hypB
         hCOEibOlFHDJ0Yq78IdEO6Ge25Qhm7A6yXdJHugfO9lVopbuVQGPu+YigF3PQCyG5r4r
         1y312EXfUUSCnBwsMtRlb81j5SmXXMkHyDlG0Ymz+D0CTyrtGRWWy911N9jTk6OHDXJ+
         +j/A==
X-Gm-Message-State: AOAM532Oz5/dJ+wAVe9/M+MNGJ9FSUXBJxyX5COnbzpxpO/5hn0Na95k
        jgOCG0KvJpBM+u2QbOPANd69SUGVFI9su7n1FQs=
X-Google-Smtp-Source: ABdhPJyUvxKyI2PyyXconc9f/8TmGHLqpN2+b4nNLm7powofOmD+rbYzQPwFF4MXBtSEXjFOPVQL0eUIfg6jL7TGH5g=
X-Received: by 2002:a05:6512:2026:: with SMTP id s6mr475114lfs.214.1618415654784;
 Wed, 14 Apr 2021 08:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <87blaozi20.fsf@toke.dk> <CAEf4Bzb4LDi1ZVrhNEojpWhxi33tkv4rv6F7Czj28Y0tHxXh0w@mail.gmail.com>
 <87im4qo9ey.fsf@toke.dk> <CAEf4Bzahxw5-KTb2yOk8PHQmEyc6gDgTTR6znZjH2OhZ66wiUw@mail.gmail.com>
In-Reply-To: <CAEf4Bzahxw5-KTb2yOk8PHQmEyc6gDgTTR6znZjH2OhZ66wiUw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 14 Apr 2021 08:54:03 -0700
Message-ID: <CAADnVQ+6xoBaD1GSSm=U3n67ooHvjGgxXPAHmFD6AhksrM8BoQ@mail.gmail.com>
Subject: Re: Selftest failures related to kern_sync_rcu()
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 13, 2021 at 11:58 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Apr 13, 2021 at 1:50 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
> >
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >
> > > On Thu, Apr 8, 2021 at 12:34 PM Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@redhat.com> wrote:
> > >>
> > >> Hi Andrii
> > >>
> > >> I'm getting some selftest failures that all seem to have something t=
o do
> > >> with kern_sync_rcu() not being enough to trigger the kernel events t=
hat
> > >> the selftest expects:
> > >>
> > >> $ ./test_progs | grep FAIL
> > >> test_lookup_update:FAIL:map1_leak inner_map1 leaked!
> > >> #15/1 lookup_update:FAIL
> > >> #15 btf_map_in_map:FAIL
> > >> test_exit_creds:FAIL:null_ptr_count unexpected null_ptr_count: actua=
l 0 =3D=3D expected 0
> > >> #123/2 exit_creds:FAIL
> > >> #123 task_local_storage:FAIL
> > >> test_exit_creds:FAIL:null_ptr_count unexpected null_ptr_count: actua=
l 0 =3D=3D expected 0
> > >> #123/2 exit_creds:FAIL
> > >> #123 task_local_storage:FAIL
> > >>
> > >> They are all fixed by adding a sleep(1) after the call(s) to
> > >> kern_sync_rcu(), so I'm guessing it's some kind of
> > >> timing/synchronisation problem. Is there a particular kernel config
> > >> that's needed for the membarrier syscall trick to work? I've tried w=
ith
> > >> various settings of PREEMPT and that doesn't really seem to make any
> > >> difference...
> > >>
> > >
> > > If you check kern_sync_rcu(), it relies on membarrier() syscall
> > > (passing cmd =3D MEMBARRIER_CMD_SHARED =3D=3D MEMBARRIER_CMD_GLOBAL).
> > > Now, looking at kernel sources:
> > >   - CONFIG_MEMBARRIER should be enabled for that syscall;
> > >   - it has some extra conditions:
> > >
> > >            case MEMBARRIER_CMD_GLOBAL:
> > >                 /* MEMBARRIER_CMD_GLOBAL is not compatible with nohz_=
full. */
> > >                 if (tick_nohz_full_enabled())
> > >                         return -EINVAL;
> > >                 if (num_online_cpus() > 1)
> > >                         synchronize_rcu();
> > >                 return 0;
> > >
> > > Could it be that one of those conditions is not satisfied?
> >
> > Aha, bingo! Found the membarrier syscall stuff, but for some reason
> > didn't think to actually read the code of it; and I was running this in
> > a VM with a single CPU, adding another fixed this. Thanks! :)
> >
> > Do you think we could detect this in the tests? I suppose the
> > tick_nohz_full_enabled() check should already result in a visible
> > failure since that makes the syscall fail; but the CPU thing is silent,
> > so it would be nice with a hint. Could kern_sync_rcu() check the CPU
> > count and print a warning or fail if it is 1? Or maybe just straight up
> > fall back to sleep()'ing?
>
> If membarrier() is unreliable, I guess we can just go back to the
> previous way of triggering synchronize_rcu() (create and update
> map-in-map element)? See 635599bace25 ("selftests/bpf: Sync RCU before
> unloading bpf_testmod") that removed that in favor of membarrier()
> syscall.

maybe create+free socket_local_storage map ? Few syscalls less.
I guess map_in_map is fine too.

Paul,
What do you suggest to trigger synchronize_rcu() from user space?
