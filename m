Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55E630E9EC
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 03:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhBDCFy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 21:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbhBDCFv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 21:05:51 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258F8C0613D6
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 18:05:11 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id y4so1601269ybk.12
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 18:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J6nV9z31Qe/sWNAkMO7TeCmZB73aGbczCMOwDF6DG7Y=;
        b=MVscLuOFLwC3sw1SCUq9XnxKwtJZ5bCIGPB0sHEMV6abgqhdVs/vhbiteDHWHwoyDW
         4U4bvqaqiM+NLF2rO2mb/0gOBQeWCTcK/GZhbAoAoV8gs7hWYmIEKAvqPdLnTr7swxuZ
         ao3fkLM3BP1YLtM7bKOsUOWFRVZKjl/rlPk5TRcpGbbyVDBwlAOHqYbhbeRXJ/Yn9YV4
         p0vIzPFr+rms+ktXocJGzkMFvrmKZKJ/7IVi392NKlZ3Q0Hje5/2bmqgDAQypJ1xZqbD
         Wsq+ksjwzifBw1+tVOUxFaKXZvQ7tkId9OW0sJ9mS1OdjPDaDwOTraaWtDTPPq9V/lMg
         30Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6nV9z31Qe/sWNAkMO7TeCmZB73aGbczCMOwDF6DG7Y=;
        b=AQhJ/HADp6utfNC5JKBJp6ehHAvMi26kxmxVsNb34Mm/jl2adh9cak17Z/RLHWcLks
         LOrrhURhHkqpXTdqKoEzS6uU6VK273xr0GSwgNsI3e2CEUWXixVemZE9Xc42XcAQNGyG
         KmkJcUJKUGIKlJCdSqzFqki/uk5IQvOMcsIAK4xS0LZlzdBN/xJlG/oI2ArPv4bSntIc
         CgOHfaIEzOmXfZdhkZLfUe5wjgk5WZ47ov5VnQUFbMXNLiI5XJqyxQN+JHi0EvpUKG9C
         N2lRLUQVmHWE6aSCjRAgcMtcg8p3e0BdZ45MdMu0PU2FOjz6HD1C8PKNRANpURU9wiYW
         73XA==
X-Gm-Message-State: AOAM5306HnJ2PV/qYEeJAwbYNNDm68X/r7cVXV9yL9iCSOOes592q2LG
        Jz6YlQ8cpj/qt+prik1qG70+VzK2sRKpIBeuUzk=
X-Google-Smtp-Source: ABdhPJxftw688UlJw5OO1/uWuxjSg2SPCNEMTChJkDD34A7IddPrSgVduBENxllddce9DKRHUpsp7qluhm0CEfld+XU=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr8821051ybd.230.1612404310499;
 Wed, 03 Feb 2021 18:05:10 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSQLc0VHqO4BY_-YB2OmCNNmHCS6fNdQKmMWGn2v=Jpdw@mail.gmail.com>
 <CAJCQCtRHOidM7Vps1JQSpZA14u+B5fR860FwZB=eb1wYjTpqDw@mail.gmail.com>
 <CAEf4BzZ4oTB0-JizHe1VaCk2V+Jb9jJoTznkgh6CjE5VxNVqbg@mail.gmail.com>
 <CAJCQCtRw6UWGGvjn0x__godYKYQXXmtyQys4efW2Pb84Q5q8Eg@mail.gmail.com>
 <20210204010038.GA854763@kernel.org> <CAJCQCtQfgRp78_WSrSHLNUUYNCyOCH=vo10nVZW_cyMjpZiNJg@mail.gmail.com>
In-Reply-To: <CAJCQCtQfgRp78_WSrSHLNUUYNCyOCH=vo10nVZW_cyMjpZiNJg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 Feb 2021 18:04:59 -0800
Message-ID: <CAEf4Bza4XQxpS7VTNWGk6Rz-iUwZemF6+iAVBA_yvrWnV0k8Qg@mail.gmail.com>
Subject: Re: 5:11: in-kernel BTF is malformed
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 3, 2021 at 5:21 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Wed, Feb 3, 2021 at 6:00 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Wed, Feb 03, 2021 at 05:46:48PM -0700, Chris Murphy escreveu:
> > > This is just the vmlinuz-5.11.0-0.rc6.141.fc34.x86_64 file
> > >
> > > https://drive.google.com/file/d/1G_2qLVRIy-ExaJI1-cTqDssrDu3sWo-m/view?usp=sharing
> >
> > Can you please provide the vmlinux for this file as well?
>
> Used this
> $ /usr/src/kernels/5.11.0-0.rc6.141.fc34.x86_64/scripts/extract-vmlinux
> /boot/vmlinuz-5.11.0-0.rc6.141.fc34.x86_64 > vmlinux
>
> https://drive.google.com/file/d/1h6cC9oZ16oLbR6NyPqKkVGaoUQ2u1UQz/view?usp=sharing
>
> I recompiled with gcc 10.2.1 and I'm not having these problems, so it
> might be that.
>

sched_reset_on_fork is a bitfield in task_struct. You don't see issue
on gcc 10.2, but see it on gcc 11. GCC 11 started emitting DWARF5 by
default, right? It's something that Arnaldo probably already fixed in
the latest pahole. Could you please try to build pahole from sources
and see if you run into the same problem again?

Verifier is catching a real issue with offsets going backwards. Here's
excerpt from BTF dump of task_struct:

        'pdeath_signal' type_id=17 bits_offset=18048
        'jobctl' type_id=1 bits_offset=18112
        'personality' type_id=6 bits_offset=18176
        'sched_reset_on_fork' type_id=6 bits_offset=0
        'sched_contributes_to_load' type_id=6 bits_offset=0
        'sched_migrated' type_id=6 bits_offset=0
        'sched_psi_wake_requeue' type_id=6 bits_offset=0

...

eventually we get to non-bitfield field

        'atomic_flags' type_id=1 bits_offset=18304

So it's a bitfield offset breakage that should be fixed in pahole 1.20.

>

>
> --
> Chris Murphy
