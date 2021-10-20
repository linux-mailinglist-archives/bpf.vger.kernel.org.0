Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6588B43528E
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 20:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhJTSW7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 14:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhJTSW6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 14:22:58 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321D2C06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 11:20:44 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id l201so3474921ybl.9
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 11:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0CKP0CsygVqT/EvbIZUHDeLYLfSOVs9gSD/2EnUXyp8=;
        b=jAFcN1R6pjIqoNmYRLci9mp2v1B2lWXLgcz6G1kGBY5hobXpTLG4GsIlw32dKKC2tw
         5tocnMks6okDnvlfZ4vBBporPwuTWf3VzoemBr2mlu5RNhsCIcbOT51zsz6xptCrE5cg
         NQLW2ktRsprLGpaHUIg+C3ZKOvaV82CWuyK4v/gVBREJ2MZSBwsuJVujhwbaII56UoHw
         CxUA2HYUu/7JUqbpElKLvcF/U4cf9nAxs/BNCpfDoUN/fM97gWQfNikU8M53GoaoCmaM
         GPkzKfS+MQJrYv8ZS8S6BTi1n3JvKU3TDHlYIEMBGKpZuo1XqE3hdKlyJ8oCy+kiwIgy
         6ITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0CKP0CsygVqT/EvbIZUHDeLYLfSOVs9gSD/2EnUXyp8=;
        b=0PkRZARbINjY3FJCBunzl03pil4CLhcXcE+PwSVIzJU1ebxs63aAcWtLSubt5H0pmJ
         DPYGmQybOpqwD6mhFWo/LST38xcXPgPDxruZ2afFaoJiOTZmdUpyM+e9SO/+o8AsdB/b
         iv84je/alYSQQwfLTPbwN9n1VS4zCyajTAn9G78jESbO76E7PQYPlmvmRUM8HrW5R2+1
         RbxUIUfwv9pGk0zR7u754dQrlBQG68+Zmbz+HN6jmcWZJF+WB4g9WEvldlO4mg6YDqnr
         UzVRXpBjP3ogQXlMO+jFOnFCMAzB1sfNrdAN5at9YuQbFat6G53AyUz7tVvidhtv0az9
         OnAg==
X-Gm-Message-State: AOAM533TXkIpav+dFcOHNLP1Zc0Pr9hOs9btJQvTy1jWtvu2teqGpn4W
        8njBTkZ+TGNt4pTlLDovOMYYFogCIKwLw7BveLE=
X-Google-Smtp-Source: ABdhPJxm0BFART7fEZAgvPmGFB7+5HgUPcHr78NSU2LSRhDuuvhvUPTwzl8be/bczrQvNO5iAK+NvYjJ/gen9FURKCQ=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr717265ybj.504.1634754043504;
 Wed, 20 Oct 2021 11:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211008000309.43274-1-andrii@kernel.org> <20211008000309.43274-10-andrii@kernel.org>
 <87pmsfl8z0.fsf@toke.dk> <CAEf4Bzb+z365WCbfPYw5xqhTAqoaAo6y+-Lt-iXGAGeeaLHMOw@mail.gmail.com>
 <87r1cvjioa.fsf@toke.dk> <91b10579-61fc-3bc7-8349-0ff3228905ae@fb.com>
 <CAEf4BzYJj_R1V=OtQUmWGXiUh0Bd=kYXXFHOKwzafF=JRAaBfQ@mail.gmail.com>
 <CAKH8qBtiDLeJmp9GXNTCNBnWbGbu66o+CE7NGyeEKB8o1=9bgA@mail.gmail.com>
 <CAEf4BzYkrabS=7fpn01BesM06P9gNEreQLReQBhbbqhvW6dTzQ@mail.gmail.com> <CAKH8qBsazaRM+ACSJc69Tt9RXR95twtG-T+Sn8LmV9sKWkhu1Q@mail.gmail.com>
In-Reply-To: <CAKH8qBsazaRM+ACSJc69Tt9RXR95twtG-T+Sn8LmV9sKWkhu1Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Oct 2021 11:20:32 -0700
Message-ID: <CAEf4BzbhE0JMzap6OJf1vstyFi+qRTn1UjhUz+AoaUJYazA2BA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/10] libbpf: simplify look up by name of
 internal maps
To:     Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin@isovalent.com>
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

On Wed, Oct 20, 2021 at 11:09 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Wed, Oct 20, 2021 at 10:59 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Oct 12, 2021 at 8:29 AM Stanislav Fomichev <sdf@google.com> wro=
te:
> > >
> > > On Mon, Oct 11, 2021 at 8:45 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Mon, Oct 11, 2021 at 11:24 PM Alexei Starovoitov <ast@fb.com> wr=
ote:
> > > > >
> > > > > On 10/8/21 2:44 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > > > > >
> > > > > > Hmm, so introduce a new 'map_name_long' field, and on query the=
 kernel
> > > > > > will fill in the old map_name with a truncated version, and put=
 the full
> > > > > > name in the new field? Yeah, I guess that would work too!
> > > > >
> > > > > Let's start storing full map names in BTF instead.
> > > > > Like we do already for progs.
> > > > > Some tools already fetch full prog names this way.
> > > >
> > > > We do have those names in BTF. Each map has either corresponding VA=
R
> > > > or DATASEC. The problem is that we don't know which.
> > > >
> > > > Are you proposing to add some extra "btf_def_type_id" field to spec=
ify
> > > > BTF type ID of what "defines" the map (VAR or DATASEC)? That would
> > > > work. Would still require UAPI and kernel changes, of course.
> > > >
> > > > The reason Toke and others were asking to preserve that object name
> > > > prefix for .rodata/.data maps was different though, and won't be
> > > > addressed by the above. Even if you know the BTF VAR/DATASEC, you
> > > > don't know the "object name" associated with the map. And the kerne=
l
> > > > doesn't know because it's purely libbpf's abstraction. And sometime=
s
> > > > that abstraction doesn't make sense (e.g., if we create a map that'=
s
> > > > pinned and reused from multiple BPF apps/objects).
> > >
> > > [..]
> > >
> > > > We do have BPF metadata that Stanislav added a while ago, so maybe =
we
> > > > should just punt that problem to that? I'd love to have clean
> > > > ".rodata" and ".data" names, of course.
> > >
> > > Are you suggesting we add some option to associate the metadata with
> > > the maps (might be an option)? IIRC, the metadata can only be
> > > associated with the progs right now.
> >
> > Well, maps have associated BTF fd, when they are created, no? So you
> > can find all the same metadata for the map, no?
>
> I guess that's true, we can store this metadata in the map itself
> using something like existing bpf_metadata_ prefix.

We had a discussion during the inaugural BSC meeting about having a
small set of "standardized" metadata strings. "owner" and
"description" (or maybe "app" for "application name") were two that
were clearly useful and generally useful. So if we update bpftool and
other tooling to recognize bpf_metadata_owner and bpf_metadata_app and
print them in some nice and meaningful way in bpftool output (in
addition to general btf_metadata dump), it would be great.

Which is a long way to say that once we have bpf_metadat_app, you
already have associated bpf_object name (or whatever user will decide
to name their BPF application). Which solves this map naming problem
as well (with tooling support, of course).

cc Quentin also. Thoughts?
