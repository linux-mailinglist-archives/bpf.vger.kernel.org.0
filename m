Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86A74355AB
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 00:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhJTWFp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 18:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229695AbhJTWFp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Oct 2021 18:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634767409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xgd3FQCMdqO99NzGxEL2PRh0GDf0lAaz8ZRlEr4U3+4=;
        b=FU3MM1nRbDaZcGEeq0V/qZFE4hHPipd9gW1RCfggxaca/OAFiDttLzQ7lo6JfIZBKdB10N
        T+CA0UmxEgbtGUnOT3ztOr/+M4OJCIi6q5E6+USLBA5V4orKIj7m5V6E9+P7YPGM2wVtYm
        hevwdECQmkJSGKygkfkfOpFwC4lpZKw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-kUSahOaWPK-iG8J20zhhfw-1; Wed, 20 Oct 2021 18:03:28 -0400
X-MC-Unique: kUSahOaWPK-iG8J20zhhfw-1
Received: by mail-ed1-f70.google.com with SMTP id u17-20020a50d511000000b003daa3828c13so22320994edi.12
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 15:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Xgd3FQCMdqO99NzGxEL2PRh0GDf0lAaz8ZRlEr4U3+4=;
        b=J7QMZgvN9YPAwyYuWbr52hQ2caMYrwcXEWLMKU7tBKJiTiFPZvH0JVz4C75hY9VXsn
         GnSQpJk9Knp5/uso0Rr54sXs8sTifBN8dM0DA9+yaTnCJOxVSMieN+nlW5N0YMWIcjjr
         WwMbQZfYSOrhngTl6VOief6NLmdEY6mzkWAAcvpffbycajNe0MrSa1niTKnmfBUkpEtZ
         Okq+eA+3d4c2ei4KNBOZAQunGGbQ2CDGGvJlr1S2QpFGkJSZsWaQpxABLk70IiF6AS3l
         HAjTqFE2iXq3EWvnZPwkSYec4W161+H+cLwqSPqUsQU3Oow7SzJMe4bCk0pjmbU9xVlr
         dj7Q==
X-Gm-Message-State: AOAM532GCgFPquU5Yqf7u9zL73WJlqWhBBitOxh+dw3LeIkjZpa9sTFp
        4PDX+33tu83dvr5gGVDkpKOuf8CkWhom+X07GYYBuRF96PwTBFJet57oCUxMbdzkV7GjGeLf83B
        jWKwDK4hcGTdX
X-Received: by 2002:a17:907:2d14:: with SMTP id gs20mr2288424ejc.415.1634767406530;
        Wed, 20 Oct 2021 15:03:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVSbWRYc/KcB7bbASnELaewMNt/oZmBhvB9f6Rd8nmGEsm39ZlyXZ2IId/XIIp9KlcVh7MWg==
X-Received: by 2002:a17:907:2d14:: with SMTP id gs20mr2288202ejc.415.1634767404447;
        Wed, 20 Oct 2021 15:03:24 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 90sm1808204edk.44.2021.10.20.15.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 15:03:23 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 97429180262; Thu, 21 Oct 2021 00:03:22 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 09/10] libbpf: simplify look up by name of
 internal maps
In-Reply-To: <CAEf4BzbhE0JMzap6OJf1vstyFi+qRTn1UjhUz+AoaUJYazA2BA@mail.gmail.com>
References: <20211008000309.43274-1-andrii@kernel.org>
 <20211008000309.43274-10-andrii@kernel.org> <87pmsfl8z0.fsf@toke.dk>
 <CAEf4Bzb+z365WCbfPYw5xqhTAqoaAo6y+-Lt-iXGAGeeaLHMOw@mail.gmail.com>
 <87r1cvjioa.fsf@toke.dk> <91b10579-61fc-3bc7-8349-0ff3228905ae@fb.com>
 <CAEf4BzYJj_R1V=OtQUmWGXiUh0Bd=kYXXFHOKwzafF=JRAaBfQ@mail.gmail.com>
 <CAKH8qBtiDLeJmp9GXNTCNBnWbGbu66o+CE7NGyeEKB8o1=9bgA@mail.gmail.com>
 <CAEf4BzYkrabS=7fpn01BesM06P9gNEreQLReQBhbbqhvW6dTzQ@mail.gmail.com>
 <CAKH8qBsazaRM+ACSJc69Tt9RXR95twtG-T+Sn8LmV9sKWkhu1Q@mail.gmail.com>
 <CAEf4BzbhE0JMzap6OJf1vstyFi+qRTn1UjhUz+AoaUJYazA2BA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 21 Oct 2021 00:03:22 +0200
Message-ID: <87cznze4lx.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Oct 20, 2021 at 11:09 AM Stanislav Fomichev <sdf@google.com> wrot=
e:
>>
>> On Wed, Oct 20, 2021 at 10:59 AM Andrii Nakryiko
>> <andrii.nakryiko@gmail.com> wrote:
>> >
>> > On Tue, Oct 12, 2021 at 8:29 AM Stanislav Fomichev <sdf@google.com> wr=
ote:
>> > >
>> > > On Mon, Oct 11, 2021 at 8:45 PM Andrii Nakryiko
>> > > <andrii.nakryiko@gmail.com> wrote:
>> > > >
>> > > > On Mon, Oct 11, 2021 at 11:24 PM Alexei Starovoitov <ast@fb.com> w=
rote:
>> > > > >
>> > > > > On 10/8/21 2:44 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > > > > >
>> > > > > > Hmm, so introduce a new 'map_name_long' field, and on query th=
e kernel
>> > > > > > will fill in the old map_name with a truncated version, and pu=
t the full
>> > > > > > name in the new field? Yeah, I guess that would work too!
>> > > > >
>> > > > > Let's start storing full map names in BTF instead.
>> > > > > Like we do already for progs.
>> > > > > Some tools already fetch full prog names this way.
>> > > >
>> > > > We do have those names in BTF. Each map has either corresponding V=
AR
>> > > > or DATASEC. The problem is that we don't know which.
>> > > >
>> > > > Are you proposing to add some extra "btf_def_type_id" field to spe=
cify
>> > > > BTF type ID of what "defines" the map (VAR or DATASEC)? That would
>> > > > work. Would still require UAPI and kernel changes, of course.
>> > > >
>> > > > The reason Toke and others were asking to preserve that object name
>> > > > prefix for .rodata/.data maps was different though, and won't be
>> > > > addressed by the above. Even if you know the BTF VAR/DATASEC, you
>> > > > don't know the "object name" associated with the map. And the kern=
el
>> > > > doesn't know because it's purely libbpf's abstraction. And sometim=
es
>> > > > that abstraction doesn't make sense (e.g., if we create a map that=
's
>> > > > pinned and reused from multiple BPF apps/objects).
>> > >
>> > > [..]
>> > >
>> > > > We do have BPF metadata that Stanislav added a while ago, so maybe=
 we
>> > > > should just punt that problem to that? I'd love to have clean
>> > > > ".rodata" and ".data" names, of course.
>> > >
>> > > Are you suggesting we add some option to associate the metadata with
>> > > the maps (might be an option)? IIRC, the metadata can only be
>> > > associated with the progs right now.
>> >
>> > Well, maps have associated BTF fd, when they are created, no? So you
>> > can find all the same metadata for the map, no?
>>
>> I guess that's true, we can store this metadata in the map itself
>> using something like existing bpf_metadata_ prefix.
>
> We had a discussion during the inaugural BSC meeting about having a
> small set of "standardized" metadata strings. "owner" and
> "description" (or maybe "app" for "application name") were two that
> were clearly useful and generally useful. So if we update bpftool and
> other tooling to recognize bpf_metadata_owner and bpf_metadata_app and
> print them in some nice and meaningful way in bpftool output (in
> addition to general btf_metadata dump), it would be great.

I like the idea of specifying some well-known metadata names, especially
if libbpf can auto-populate them if the user doesn't.

Also, couldn't bpftool just print out all bpf_metadata_* fields? At
least in a verbose mode...

-Toke

