Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE6B4355D6
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 00:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJTW0n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 18:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJTW0m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 18:26:42 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A73C06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 15:24:28 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id z24so4459948qtv.9
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 15:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wSCS3nQF3J5XYJ/ETONMRyI+ntCUmc5vD7iqzjG3OVo=;
        b=H3ly5PzNTc6+aOsge27b4L2B/UNNv3fNOYZmynTCgxsG1f+XEhAGZK8RtZ5xwaAWgG
         9B7Dwza24gE/6/dvdtDwK43wFXd4v3uv1cxV+s1aEAEuWkz/5ZF4OI2+ay2ePDXhYnZv
         sonO3cVcnRF/jW4cBacAJTGH6WBLIRIHdZQPhDeH2sbviP7tXDyavnqiP0dLj3YSFAWG
         dueU8SVrZDJmplXY4rLOEb6nXJVaVNOPGcgsPlegzCuSlcjOZgQha/lN8LwQBEmRS+ek
         bonDeH5LtkUdLLKQL1iNDnEm2G825nJAAjZ4oBkgTKF3HifM5FqdCIdMzu5kxfZOcWUZ
         XKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wSCS3nQF3J5XYJ/ETONMRyI+ntCUmc5vD7iqzjG3OVo=;
        b=3rUkeW5gRJIEcOSE4i1MbKfoAj7sEMLPM+G6CkVftSkCUgle2oDb29yrFcadYLoaQE
         JG3+fKx8hFu9H3b+meqH6ZAZDyomFSf7Ul2S4DhDQYl62u0u6BSTmlitcKK98DWV0EfE
         I17PmtGEhG78l7jgCEnAlCz+b7Nh+79L/I34xJZCHo0DJEw9HLbxUqs5BkWVLPdyjclC
         a1znbbjL1mTFuy3yyfdczKnSiWLpRixB3iXIFUDaqur4qS42hVQuT/viGuVMmY7QK8r2
         VEtIjDQicLp8TxMg0l6gj2G1dLv+ibg5GNntQLBPZdYJSeoUyRYzYZ/7LTSt+Es5JGp6
         8NGw==
X-Gm-Message-State: AOAM5318VFoevD1fJixDSOLfLsnsW508OgcaV43QC1N8CnM+jj3qFRWR
        CN3JKWkbgQDt2XYenbLlIdG651oSQS9BowkJjYqFzQ==
X-Google-Smtp-Source: ABdhPJy1Q5YyTLp4GnVP0MO0MglhZ47tKagr123bYwt3mBF+nx2vsCfedQpx/FYt5B7vOmJUMMUKvbOCyshPe2bKKms=
X-Received: by 2002:ac8:5cd0:: with SMTP id s16mr2034838qta.287.1634768667017;
 Wed, 20 Oct 2021 15:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <20211008000309.43274-10-andrii@kernel.org>
 <87pmsfl8z0.fsf@toke.dk> <CAEf4Bzb+z365WCbfPYw5xqhTAqoaAo6y+-Lt-iXGAGeeaLHMOw@mail.gmail.com>
 <87r1cvjioa.fsf@toke.dk> <91b10579-61fc-3bc7-8349-0ff3228905ae@fb.com>
 <CAEf4BzYJj_R1V=OtQUmWGXiUh0Bd=kYXXFHOKwzafF=JRAaBfQ@mail.gmail.com>
 <CAKH8qBtiDLeJmp9GXNTCNBnWbGbu66o+CE7NGyeEKB8o1=9bgA@mail.gmail.com>
 <CAEf4BzYkrabS=7fpn01BesM06P9gNEreQLReQBhbbqhvW6dTzQ@mail.gmail.com>
 <CAKH8qBsazaRM+ACSJc69Tt9RXR95twtG-T+Sn8LmV9sKWkhu1Q@mail.gmail.com>
 <CAEf4BzbhE0JMzap6OJf1vstyFi+qRTn1UjhUz+AoaUJYazA2BA@mail.gmail.com> <87cznze4lx.fsf@toke.dk>
In-Reply-To: <87cznze4lx.fsf@toke.dk>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 20 Oct 2021 15:24:16 -0700
Message-ID: <CAKH8qBu80UHExk79QbYsYoVS2Pd2EMW0UKr9ekGLSmMvDHoSsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/10] libbpf: simplify look up by name of
 internal maps
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 20, 2021 at 3:03 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Wed, Oct 20, 2021 at 11:09 AM Stanislav Fomichev <sdf@google.com> wr=
ote:
> >>
> >> On Wed, Oct 20, 2021 at 10:59 AM Andrii Nakryiko
> >> <andrii.nakryiko@gmail.com> wrote:
> >> >
> >> > On Tue, Oct 12, 2021 at 8:29 AM Stanislav Fomichev <sdf@google.com> =
wrote:
> >> > >
> >> > > On Mon, Oct 11, 2021 at 8:45 PM Andrii Nakryiko
> >> > > <andrii.nakryiko@gmail.com> wrote:
> >> > > >
> >> > > > On Mon, Oct 11, 2021 at 11:24 PM Alexei Starovoitov <ast@fb.com>=
 wrote:
> >> > > > >
> >> > > > > On 10/8/21 2:44 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> > > > > >
> >> > > > > > Hmm, so introduce a new 'map_name_long' field, and on query =
the kernel
> >> > > > > > will fill in the old map_name with a truncated version, and =
put the full
> >> > > > > > name in the new field? Yeah, I guess that would work too!
> >> > > > >
> >> > > > > Let's start storing full map names in BTF instead.
> >> > > > > Like we do already for progs.
> >> > > > > Some tools already fetch full prog names this way.
> >> > > >
> >> > > > We do have those names in BTF. Each map has either corresponding=
 VAR
> >> > > > or DATASEC. The problem is that we don't know which.
> >> > > >
> >> > > > Are you proposing to add some extra "btf_def_type_id" field to s=
pecify
> >> > > > BTF type ID of what "defines" the map (VAR or DATASEC)? That wou=
ld
> >> > > > work. Would still require UAPI and kernel changes, of course.
> >> > > >
> >> > > > The reason Toke and others were asking to preserve that object n=
ame
> >> > > > prefix for .rodata/.data maps was different though, and won't be
> >> > > > addressed by the above. Even if you know the BTF VAR/DATASEC, yo=
u
> >> > > > don't know the "object name" associated with the map. And the ke=
rnel
> >> > > > doesn't know because it's purely libbpf's abstraction. And somet=
imes
> >> > > > that abstraction doesn't make sense (e.g., if we create a map th=
at's
> >> > > > pinned and reused from multiple BPF apps/objects).
> >> > >
> >> > > [..]
> >> > >
> >> > > > We do have BPF metadata that Stanislav added a while ago, so may=
be we
> >> > > > should just punt that problem to that? I'd love to have clean
> >> > > > ".rodata" and ".data" names, of course.
> >> > >
> >> > > Are you suggesting we add some option to associate the metadata wi=
th
> >> > > the maps (might be an option)? IIRC, the metadata can only be
> >> > > associated with the progs right now.
> >> >
> >> > Well, maps have associated BTF fd, when they are created, no? So you
> >> > can find all the same metadata for the map, no?
> >>
> >> I guess that's true, we can store this metadata in the map itself
> >> using something like existing bpf_metadata_ prefix.
> >
> > We had a discussion during the inaugural BSC meeting about having a
> > small set of "standardized" metadata strings. "owner" and
> > "description" (or maybe "app" for "application name") were two that
> > were clearly useful and generally useful. So if we update bpftool and
> > other tooling to recognize bpf_metadata_owner and bpf_metadata_app and
> > print them in some nice and meaningful way in bpftool output (in
> > addition to general btf_metadata dump), it would be great.
>
> I like the idea of specifying some well-known metadata names, especially
> if libbpf can auto-populate them if the user doesn't.

Yeah, I'd +1 that. I was exploring the idea of adding process's
cmdline into map/prog info a while ago. That's where this whole
metadata came out, but I've yet to add something to libbpf that's
"standardized".

> Also, couldn't bpftool just print out all bpf_metadata_* fields? At
> least in a verbose mode...

It already prints everything, but it prints them in a plain list.
Maybe we can integrate some of the data more nicely.
