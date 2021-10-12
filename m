Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F9C42A840
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 17:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhJLPbh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 11:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237144AbhJLPbg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Oct 2021 11:31:36 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD890C061570
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 08:29:34 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id a16so13103222qvm.2
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 08:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YmuvJYN4xcPl4+lEFy8WWDPuMR4iMD4l8N4agqMXVb0=;
        b=mcltXB/13cPQ0gCbODAZRoGFlINjR5quPdXMnBXAc16fs92jIxRwe0pAbeC8nT4tLI
         da8F41xhp6e/tyIsA2eNENN5l0B8HavLNSCt7QjwjlKv5bOkwadL/2vtnLBrBYaskZQd
         Cbeqt3lbc1ihMfevbEjJVwgcfHDcK31At2iMLPQhmO2awkfzPPUIFhI3zTG/NMZWcDNc
         v1G2SkJ8vYSrR92N8OvAlr9aJxdrQ9HgHBiFr46pnDGLSzythetZW12jL+nNghqqC5+Z
         QuYPyHJdQOMTtl8CWC8mB4Pe5q2aqklKFmkCMYJoo30gQLaHwUdQnhXEQ7D9Q2U6ZtZa
         opeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YmuvJYN4xcPl4+lEFy8WWDPuMR4iMD4l8N4agqMXVb0=;
        b=7/MLC9vHPoTHiKEfAEB2WLewiMNPgvCZo5AZehwz2GPKFdpR2MiUPyvJzTiLqN4Tcv
         xU+c2NjmLzA6xJeu7uALHOZ3Q8g3n2m7LK8yzwmUiSM6udgrJ638Eyj0hpRLm/tbire+
         f4GAbs/IYaLsJGm4bNWbBEk7n054IatkIGqWXBIbwRvVMzfA29B6Ixlnuy1tLNvwA1XP
         fuqRWsyTWGyG0oz1VdnmzWkB4FrkofmmVslGS+EWDswCeQ30rjPEYQP/HfEBbfRrrfU4
         zGBO/ghGC1fvsFE4F/TlQVvP5HfRrdL7PBq9Lzhx41bV3N83A3sGg6mm0zz5iHCecttF
         5Ydw==
X-Gm-Message-State: AOAM5324LCEblTVyGATLnSct5IhcJxU0lCdXSI6NFqqFzxhpMvFGMKxY
        BwLTegJkUp3q6QInwamsGGaHcKLQd1fhqDKqaAENaQ==
X-Google-Smtp-Source: ABdhPJzCeQ3nEGU9mtFzJrYxgoK8P0mQFVwPiYAdvzi4lsbznYBHlK+AaibuP7rgkNsteMZ2f7ZPMa5nEzOgFqHnALI=
X-Received: by 2002:a05:6214:1c8d:: with SMTP id ib13mr30379326qvb.10.1634052573846;
 Tue, 12 Oct 2021 08:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <20211008000309.43274-10-andrii@kernel.org>
 <87pmsfl8z0.fsf@toke.dk> <CAEf4Bzb+z365WCbfPYw5xqhTAqoaAo6y+-Lt-iXGAGeeaLHMOw@mail.gmail.com>
 <87r1cvjioa.fsf@toke.dk> <91b10579-61fc-3bc7-8349-0ff3228905ae@fb.com> <CAEf4BzYJj_R1V=OtQUmWGXiUh0Bd=kYXXFHOKwzafF=JRAaBfQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYJj_R1V=OtQUmWGXiUh0Bd=kYXXFHOKwzafF=JRAaBfQ@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 12 Oct 2021 08:29:22 -0700
Message-ID: <CAKH8qBtiDLeJmp9GXNTCNBnWbGbu66o+CE7NGyeEKB8o1=9bgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/10] libbpf: simplify look up by name of
 internal maps
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 11, 2021 at 8:45 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 11, 2021 at 11:24 PM Alexei Starovoitov <ast@fb.com> wrote:
> >
> > On 10/8/21 2:44 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > >
> > > Hmm, so introduce a new 'map_name_long' field, and on query the kerne=
l
> > > will fill in the old map_name with a truncated version, and put the f=
ull
> > > name in the new field? Yeah, I guess that would work too!
> >
> > Let's start storing full map names in BTF instead.
> > Like we do already for progs.
> > Some tools already fetch full prog names this way.
>
> We do have those names in BTF. Each map has either corresponding VAR
> or DATASEC. The problem is that we don't know which.
>
> Are you proposing to add some extra "btf_def_type_id" field to specify
> BTF type ID of what "defines" the map (VAR or DATASEC)? That would
> work. Would still require UAPI and kernel changes, of course.
>
> The reason Toke and others were asking to preserve that object name
> prefix for .rodata/.data maps was different though, and won't be
> addressed by the above. Even if you know the BTF VAR/DATASEC, you
> don't know the "object name" associated with the map. And the kernel
> doesn't know because it's purely libbpf's abstraction. And sometimes
> that abstraction doesn't make sense (e.g., if we create a map that's
> pinned and reused from multiple BPF apps/objects).

[..]

> We do have BPF metadata that Stanislav added a while ago, so maybe we
> should just punt that problem to that? I'd love to have clean
> ".rodata" and ".data" names, of course.

Are you suggesting we add some option to associate the metadata with
the maps (might be an option)? IIRC, the metadata can only be
associated with the progs right now.
