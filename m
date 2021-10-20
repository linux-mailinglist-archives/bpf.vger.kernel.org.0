Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D259C4355D7
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 00:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJTW1q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 18:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJTW1q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 18:27:46 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B77AC06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 15:25:31 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id s64so18541259yba.11
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 15:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pTDm9UhgfgKEkLEiIDJgzu+AD3/ZBBqqky/WIB9Zp5A=;
        b=gW8Ro9O3uZMTFq3mCGzYVqZphbXxaFK2ZBEHXLeeIBLQcrzfDiGNA+EL2safiVh3dP
         UqdC+Xj+kOEUFJT5//sYc2ggdpXDJ6i8wAAmwZ9IWyMT+4GSzPieGAibYONB6QJNmpFf
         ETYYIax96x+DP+vJGswpyHwzCVA70zeGh4cdox+xl05Y8u9QYpUGaYQbzIiZUq2pSLOc
         BcFC2xPA6yGOOSvNTaFRWU1GIprKlWXCeBVQaYK/OGKLqo92PxErR8FjklwCHRHNAMrn
         8a9RrMzuHt6MyBT6cmD5HviNFS2qIO4BOL7WGbLeBjAHOq22ENpmpfQ+saPSaZCgVIzK
         Ky6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pTDm9UhgfgKEkLEiIDJgzu+AD3/ZBBqqky/WIB9Zp5A=;
        b=oALySajlYygjqor5jRfwcby5CWF9wC0s0aiKsXYXHGCt6axeLYv9oBPAXvLgnG/hMt
         d6xwu/mUhAXZOAmhsIQl0BFV9HjjeRl6eM4BeVfXH2Dg5F/lAI0dqQD9WIShGondfb+x
         lkvSI6BEqUCRRJjAnvOohuHcewJwr9oUA9mqgGGlxi8YEcPxigPoXEWJTWU5jc8BtGNW
         +eTOHzC+koPdFHZpw7G7AH58wBSRCi3xdjwOCnCs603kiYXVPpI1WhKo/0KN63nxJ8MD
         2SJAvzoTgtyuqbyMJH1rL3cJJH1xYl80qZSH+BRB6MKM4LGBluuNaL0djps27r3GZeq5
         qxPw==
X-Gm-Message-State: AOAM533SCvLG5DG/mkz1158ss/ZZt1BzoH+bH4XgRqn4rj0gBNjrxDFm
        yUjJlNpYF1QP1SCeQ7wUn1QLmB0Pq4h1kCsa0lk=
X-Google-Smtp-Source: ABdhPJwO7wEpCvV3sVZCTwTa0u4j8NX2q48/9UT0wcK5WRlhbe+m2Nyec1yqCVv2li07Ds6ATzzrlAYhHQKsAFMzik8=
X-Received: by 2002:a25:5606:: with SMTP id k6mr1872117ybb.51.1634768730309;
 Wed, 20 Oct 2021 15:25:30 -0700 (PDT)
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
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Oct 2021 15:25:19 -0700
Message-ID: <CAEf4BzbCqAoF_6+S6CirA=gsSX2iFKqrBUeNkuuG_PPr1zPuLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/10] libbpf: simplify look up by name of
 internal maps
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
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
>
> Also, couldn't bpftool just print out all bpf_metadata_* fields? At
> least in a verbose mode...

Yes, bpftool dumps all bpf_metadata_* fields already. The point of
converging on few common ones (say, bpf_metadata_owner and
bpf_metadata_app) would allow all the tools to use consistent subset
to display meaningful short info about a prog or map. Dumping all
metadata fields for something like "bpf top" doesn't make sense.

re: libbpf auto-populating some of them. It can populate "app"
metadata from bpf_object's name, but we need to think through all the
logistics carefully (e.g., not setting if user already specified that
explicitly, etc). There is no way libbpf can know "owner" meta,
though.

>
> -Toke
>
