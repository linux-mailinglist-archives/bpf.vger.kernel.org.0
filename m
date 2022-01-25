Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0876149BD80
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 21:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbiAYUxA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 15:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiAYUwf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 15:52:35 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E87C06173B
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 12:52:34 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id c3-20020a9d6c83000000b00590b9c8819aso27616390otr.6
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 12:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=PvzqG4h94ppvSdlkSfH1P+xd/q0Dj9lB0zab/Dsobbw=;
        b=JZNAuz2b/qDMWIFDAahit0vitJ8Nx7gGu95owuUqwXXVeSKDQFB/q8tSeJKyOZuaFC
         N/GeXT21/m3RFQco/8bAlZMhuyfFJxuYNJEtJG/cNyvq0Iwuce3axyrAE/8lq6iUJA91
         dVRqreH2OmS/DNpGg1hJuJW0lNsO3MT5rmwRqRRn7CdLYDPK80Cr/KsLZfLnD+PT/K7n
         GIWYEVjKbpY13kDe/R23CusixTxkrtxUkRWhEskyaRscQ9uew82IVz/l8LzZySAF0hkQ
         0IWY0l6WhK+Qv0BZUy6mnmm/w/iyb7DyGh0O+d+YCrq5wpCNYF14cx7PLEyJkN35Gdwm
         l+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=PvzqG4h94ppvSdlkSfH1P+xd/q0Dj9lB0zab/Dsobbw=;
        b=Nw3fFbEY98zt7doY2WkkKtb6tdQY3T5pSGuiZDWk07lYzJNxCSSE4IAfKOD8i5+zvj
         skihx/HuJkVd7QzfWhJ/SAw8B1tLWaWO1Tqv7Muty3z+LX7TJ6cAR06oYZhK2d5ol34y
         2IP1t84cGKQwLJevilkjKZwicqmcex+O1EZMvwFQvghDkN43kmNpQGQxnHAN7wA8zOBF
         8Hpcv9daohM3WoxIBJjPJW+Ar3VB2AQVD4wE9UwZa6QzqcTzPIcZAD6U/HPaAbGKBCaA
         jGt8nz1eeDy+76y8pXovYBGEbknx4sixko0AwbONa8V9hdYjExxSU/e7nMBLaOyfmQNT
         Is2Q==
X-Gm-Message-State: AOAM532N9OrtM9FUZzpV1Mm9oV0Fy82fsRX73pyBLQ4VonZZgUl4n9yn
        rNndCKDo/PIIfqo2zUkczSk=
X-Google-Smtp-Source: ABdhPJxRCfbpCWoMuJ+V8hIJ7ZVFTldGzThg6vDfbSVOWfN0Caz4PUuoS0vfGbnbyOQyxSCtcsMu7Q==
X-Received: by 2002:a9d:7409:: with SMTP id n9mr15591336otk.80.1643143953976;
        Tue, 25 Jan 2022 12:52:33 -0800 (PST)
Received: from localhost ([99.197.200.79])
        by smtp.gmail.com with ESMTPSA id z4sm2141663ota.7.2022.01.25.12.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 12:52:33 -0800 (PST)
Date:   Tue, 25 Jan 2022 12:52:25 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        David Ahern <dsahern@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <61f06309dabcc_2e4c52085d@john.notmuch>
In-Reply-To: <87lez43tk4.fsf@toke.dk>
References: <20220120060529.1890907-1-andrii@kernel.org>
 <20220120060529.1890907-4-andrii@kernel.org>
 <87wniu7hss.fsf@toke.dk>
 <CAEf4BzYpwK+iPPSx7G2-fTSc8dO-4+ObVP72cmu46z+gzFT0Cg@mail.gmail.com>
 <87lez87rbm.fsf@toke.dk>
 <CAEf4BzYJ9_1OpfCe9KZnDUDvezbc=bLFjq78n4tjBh=p_WFb3Q@mail.gmail.com>
 <87lez43tk4.fsf@toke.dk>
Subject: Re: [PATCH v2 bpf-next 3/4] libbpf: deprecate legacy BPF map
 definitions
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> =

> > On Fri, Jan 21, 2022 at 12:43 PM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
> >>
> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >>
> >> > On Thu, Jan 20, 2022 at 3:44 AM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
> >> >>
> >> >> Andrii Nakryiko <andrii@kernel.org> writes:
> >> >>
> >> >> > Enact deprecation of legacy BPF map definition in SEC("maps") (=
[0]). For
> >> >> > the definitions themselves introduce LIBBPF_STRICT_MAP_DEFINITI=
ONS flag
> >> >> > for libbpf strict mode. If it is set, error out on any struct
> >> >> > bpf_map_def-based map definition. If not set, libbpf will print=
 out
> >> >> > a warning for each legacy BPF map to raise awareness that it go=
es
> >> >> > away.
> >> >>
> >> >> We've touched upon this subject before, but I (still) don't think=
 it's a
> >> >> good idea to remove this support entirely: It makes it impossible=
 to
> >> >> write a loader that can handle both new and old BPF objects.
> >> >>
> >> >> So discourage the use of the old map definitions, sure, but pleas=
e don't
> >> >> make it completely impossible to load such objects.
> >> >
> >> > BTF-defined maps have been around for quite a long time now and on=
ly
> >> > have benefits on top of the bpf_map_def way. The source code
> >> > translation is also very straightforward. If someone didn't get ar=
ound
> >> > to update their BPF program in 2 years, I don't think we can do mu=
ch
> >> > about that.
> >> >
> >> > Maybe instead of trying to please everyone (especially those that
> >> > refuse to do anything to their BPF programs), let's work together =
to
> >> > nudge laggards to actually modernize their source code a little bi=
t
> >> > and gain some benefits from that along the way?
> >>
> >> I'm completely fine with nudging people towards the newer features, =
and
> >> I think the compile-time deprecation warning when someone is using t=
he
> >> old-style map definitions in their BPF programs is an excellent way =
to
> >> do that.
> >>
> >> I'm also fine with libbpf *by default* refusing to load programs tha=
t
> >> use the old-style map definitions, but if the code is removed comple=
tely
> >> it becomes impossible to write general-purpose loaders that can hand=
le
> >> both old and new programs. The obvious example of such a loader is
> >> iproute2, the loader in xdp-tools is another.
> >
> > This is because you want to deviate from underlying BPF loader's
> > behavior and feature set and dictate your own extended feature set in=

> > xdp-tools/iproute2/etc. You can technically do that, but with a lot o=
f
> > added complexity and headaches. But demanding libbpf to maintain
> > deprecated and discouraged features/APIs/practices for 10+ years and
> > accumulate all the internal cruft and maintenance burden isn't a grea=
t
> > solution either.
> =

> Right, so work with me to find a solution? I already suggested several
> ideas, and you just keep repeating "just use the old library", which is=

> tantamount to saying "take a hike".

I'll just throw my $.02 here as I'm reviewing. On major versions its
fairly common to not force API compat with the libs I'm used to working
with. Most recent example that comes to my mind (just did this yesterday
for example) was porting code into openssl3.x from older version. I
mumbled a bit, but still did it so that I could get my tools working on
latest and greatest.

Going from 0.x -> 1.0 seems reasonable to break compat, users don't
need to update immediately right? They can linger around on 0.x release
until they have some time or reason to jump onto 1.0? Distro's can
carry all versions for as long as necessary. Thats the value add of
distributions in my mind anyways. And a 0.x version somewhat implies
its not stable yet imo.

> =

> I'm perfectly fine with having to jump through some more hoops to load
> old programs, and moving the old maps section parsing out of libbpf and=

> into the caller is fine as well; but then we'd need to add some hooks t=
o
> libbpf to create the maps inside the bpf_object. I can submit patches t=
o
> do this, but I'm not going to bother if you're just going to reject the=
m
> because you don't want to accommodate anything other than your way of
> doing things :/

Can't xdp-tools run on 0.x for as long as wanted and flip over when
it is ready? Same for iproute2 'tc' loader? I'm not seeing what would
break except for random people trying to use tools in debug or experiment=
s.
I would think most production use cases are not shelling out to tc
or xdp loaders and if so they must be managing the versioning
somehow for new/old features.

FWIW the dumb netlink based loader I wrote to attach create qdiscs
and attach filters is <100 lines of code so its not a huge lift if
you end up having to roll your own here.

The series is an ACK for me.

> =

> -Toke
> =
