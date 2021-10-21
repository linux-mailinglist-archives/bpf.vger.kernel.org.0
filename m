Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76544360B8
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 13:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhJULuf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 07:50:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35437 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230342AbhJULue (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Oct 2021 07:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634816898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=84oXVL9OrFxG+c8fT1ipEBFUO0FwiCZMQdR7WVvHdhY=;
        b=idNtIGT17RlAWrbvEPoeQKJxBGnO6sEmqr3+TEjYBlKIEFrRv6Uj4XtdVCY36nh5FX+4wZ
        Xnz1Y6GvNRMBf1600/55SKF+Myic5QkRUqeObVeyIgWug4xaWSsJM5PuTbos5rvO2kiLy+
        3bididcBDrLG6oMfuOw7uo4EN6oxgQo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-S-LWM-qUO8SMpGjzd43j_w-1; Thu, 21 Oct 2021 07:48:17 -0400
X-MC-Unique: S-LWM-qUO8SMpGjzd43j_w-1
Received: by mail-ed1-f72.google.com with SMTP id v2-20020a50f082000000b003db24e28d59so58619edl.5
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 04:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=84oXVL9OrFxG+c8fT1ipEBFUO0FwiCZMQdR7WVvHdhY=;
        b=p/thCTJr9saejBNlXlgDr/w0ctiDKqQMkb5Xp/LlgqGUVDxyZfSNx8dhHef+gePFZ8
         gVM5R1Wc8TvO2AeW61UPOYsbt7s9FYiHz39GiF45PPx0A4GyrxJzCeY7riN510qmeNB2
         9LHPH0Bwc7556Y/8Dy/59m56HceI5SLXnFsp/3fDEHHwWfaMvhaA6tJCsLspibdHKn0u
         cMaTNyQUuQSe13EviOsrZb+HhB8WY7J8ejR3ccj/ISSysG1S1FUtBP77iXEVi25cF3Mm
         9jVAE7IAPPpEgMONJuO3zOWlWYNDWLNbsPLPNe7tQh0Gtki3immEX3YeTPR5BEF5hf8v
         kpyA==
X-Gm-Message-State: AOAM533EscWC9d34gl3Lxg25UZRTa9avpOf/q3ts31DAOsj2iLuxDCwB
        kWoLgZPCm5PbDWlQL2rITnkRydMVFiEsiPnCEa5qkgWKPx+Kbz6Wxpf3w5bYAQgRtS2jzccZYT4
        OwBU5uLM+J7Zt
X-Received: by 2002:a17:906:e011:: with SMTP id cu17mr6764233ejb.244.1634816895462;
        Thu, 21 Oct 2021 04:48:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5VsvocDoGb+0EPg98bOf5gFy00QZY1ZfHXNvlU/oD0vTq83EfptY/GEUYyh5Sc2OPHsf/XA==
X-Received: by 2002:a17:906:e011:: with SMTP id cu17mr6764080ejb.244.1634816894100;
        Thu, 21 Oct 2021 04:48:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v8sm2758789edj.7.2021.10.21.04.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 04:48:13 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1F256180262; Thu, 21 Oct 2021 13:39:18 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 09/10] libbpf: simplify look up by name of
 internal maps
In-Reply-To: <CAEf4BzbCqAoF_6+S6CirA=gsSX2iFKqrBUeNkuuG_PPr1zPuLA@mail.gmail.com>
References: <20211008000309.43274-1-andrii@kernel.org>
 <20211008000309.43274-10-andrii@kernel.org> <87pmsfl8z0.fsf@toke.dk>
 <CAEf4Bzb+z365WCbfPYw5xqhTAqoaAo6y+-Lt-iXGAGeeaLHMOw@mail.gmail.com>
 <87r1cvjioa.fsf@toke.dk> <91b10579-61fc-3bc7-8349-0ff3228905ae@fb.com>
 <CAEf4BzYJj_R1V=OtQUmWGXiUh0Bd=kYXXFHOKwzafF=JRAaBfQ@mail.gmail.com>
 <CAKH8qBtiDLeJmp9GXNTCNBnWbGbu66o+CE7NGyeEKB8o1=9bgA@mail.gmail.com>
 <CAEf4BzYkrabS=7fpn01BesM06P9gNEreQLReQBhbbqhvW6dTzQ@mail.gmail.com>
 <CAKH8qBsazaRM+ACSJc69Tt9RXR95twtG-T+Sn8LmV9sKWkhu1Q@mail.gmail.com>
 <CAEf4BzbhE0JMzap6OJf1vstyFi+qRTn1UjhUz+AoaUJYazA2BA@mail.gmail.com>
 <87cznze4lx.fsf@toke.dk>
 <CAEf4BzbCqAoF_6+S6CirA=gsSX2iFKqrBUeNkuuG_PPr1zPuLA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 21 Oct 2021 13:39:18 +0200
Message-ID: <871r4eeheh.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Oct 20, 2021 at 3:03 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Wed, Oct 20, 2021 at 11:09 AM Stanislav Fomichev <sdf@google.com> w=
rote:
>> >>
>> >> On Wed, Oct 20, 2021 at 10:59 AM Andrii Nakryiko
>> >> <andrii.nakryiko@gmail.com> wrote:
>> >> >
>> >> > On Tue, Oct 12, 2021 at 8:29 AM Stanislav Fomichev <sdf@google.com>=
 wrote:
>> >> > >
>> >> > > On Mon, Oct 11, 2021 at 8:45 PM Andrii Nakryiko
>> >> > > <andrii.nakryiko@gmail.com> wrote:
>> >> > > >
>> >> > > > On Mon, Oct 11, 2021 at 11:24 PM Alexei Starovoitov <ast@fb.com=
> wrote:
>> >> > > > >
>> >> > > > > On 10/8/21 2:44 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> > > > > >
>> >> > > > > > Hmm, so introduce a new 'map_name_long' field, and on query=
 the kernel
>> >> > > > > > will fill in the old map_name with a truncated version, and=
 put the full
>> >> > > > > > name in the new field? Yeah, I guess that would work too!
>> >> > > > >
>> >> > > > > Let's start storing full map names in BTF instead.
>> >> > > > > Like we do already for progs.
>> >> > > > > Some tools already fetch full prog names this way.
>> >> > > >
>> >> > > > We do have those names in BTF. Each map has either correspondin=
g VAR
>> >> > > > or DATASEC. The problem is that we don't know which.
>> >> > > >
>> >> > > > Are you proposing to add some extra "btf_def_type_id" field to =
specify
>> >> > > > BTF type ID of what "defines" the map (VAR or DATASEC)? That wo=
uld
>> >> > > > work. Would still require UAPI and kernel changes, of course.
>> >> > > >
>> >> > > > The reason Toke and others were asking to preserve that object =
name
>> >> > > > prefix for .rodata/.data maps was different though, and won't be
>> >> > > > addressed by the above. Even if you know the BTF VAR/DATASEC, y=
ou
>> >> > > > don't know the "object name" associated with the map. And the k=
ernel
>> >> > > > doesn't know because it's purely libbpf's abstraction. And some=
times
>> >> > > > that abstraction doesn't make sense (e.g., if we create a map t=
hat's
>> >> > > > pinned and reused from multiple BPF apps/objects).
>> >> > >
>> >> > > [..]
>> >> > >
>> >> > > > We do have BPF metadata that Stanislav added a while ago, so ma=
ybe we
>> >> > > > should just punt that problem to that? I'd love to have clean
>> >> > > > ".rodata" and ".data" names, of course.
>> >> > >
>> >> > > Are you suggesting we add some option to associate the metadata w=
ith
>> >> > > the maps (might be an option)? IIRC, the metadata can only be
>> >> > > associated with the progs right now.
>> >> >
>> >> > Well, maps have associated BTF fd, when they are created, no? So you
>> >> > can find all the same metadata for the map, no?
>> >>
>> >> I guess that's true, we can store this metadata in the map itself
>> >> using something like existing bpf_metadata_ prefix.
>> >
>> > We had a discussion during the inaugural BSC meeting about having a
>> > small set of "standardized" metadata strings. "owner" and
>> > "description" (or maybe "app" for "application name") were two that
>> > were clearly useful and generally useful. So if we update bpftool and
>> > other tooling to recognize bpf_metadata_owner and bpf_metadata_app and
>> > print them in some nice and meaningful way in bpftool output (in
>> > addition to general btf_metadata dump), it would be great.
>>
>> I like the idea of specifying some well-known metadata names, especially
>> if libbpf can auto-populate them if the user doesn't.
>>
>> Also, couldn't bpftool just print out all bpf_metadata_* fields? At
>> least in a verbose mode...
>
> Yes, bpftool dumps all bpf_metadata_* fields already. The point of
> converging on few common ones (say, bpf_metadata_owner and
> bpf_metadata_app) would allow all the tools to use consistent subset
> to display meaningful short info about a prog or map. Dumping all
> metadata fields for something like "bpf top" doesn't make sense.
>
> re: libbpf auto-populating some of them. It can populate "app"
> metadata from bpf_object's name, but we need to think through all the
> logistics carefully (e.g., not setting if user already specified that
> explicitly, etc). There is no way libbpf can know "owner" meta,
> though.

Right, I was mostly thinking about the "app" name; just so there's a
default if users don't set anything themselves, like there is today with
the prefix...

-Toke

