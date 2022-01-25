Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F03249BFB6
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 00:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiAYXqm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 18:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbiAYXql (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 18:46:41 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46337C06173B
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 15:46:41 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id n17so9822453iod.4
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 15:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1b/uLvSRLDyePx4KMXlKmFT6YPRke3tAynjkTkI7G7s=;
        b=QcVYvPogfjQkDxi6xOoOIA/8w+Vs7Ql6ZcgAPHDQUAd7DNSUoMRB3U5074QBGihpZw
         5fcOssN30VMNHzc2K6ekgDQDq1Hx2pRUysPdZkbFp6jcOjaPoixetUMuoP0mOky7LuEN
         hMj9Kworf8pihu4Tnt90UNeqzSK3tf9RJ031cggWg0DqjPFYv767tdgJcr68OSHrr81j
         QEhefmq8vGfR8XZyI/gS6Q14e4lk9S5cwrXyZGcO2zsgRIvNvZtDir/ftDZkBJDZJZA3
         otxgvElSxHZAAG8If2TaGxOh6S7XxQoCjoG/aV4k04+8cjCTgQAYVSAvoyyWuSB+3Jzr
         ta9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1b/uLvSRLDyePx4KMXlKmFT6YPRke3tAynjkTkI7G7s=;
        b=CAwEKqNVVBvwi6T9W1+ELBxus7zNva+BtGG/fRsfEIdH1KlMP0IKBWSk6W8cHYd3ec
         Jr/B4FQuVcvV/3cCHFYyg/yFsMhdJyOjg25klKsY0SN6dTY3ZKVoxrGC1u7K8iTOqSl9
         P9tFSHZA7HbOZI/NMbs4VOsCtqHDc5GqCz2QUQkwxPGKANdW41ITxXTfdsX164IBG1fO
         iiX7niPBxmrei60axpPEZCVb+w4+Zh6q2BVdw3Ba4YSI2KphTj2aAjH+hOYE/gnv+Svv
         ys0spJn/IJvZtDuyWmBR6qigQuTPtsB9UQBHlncZ0S1vYC/z9FfHaeHYIW/1Coz499C7
         300w==
X-Gm-Message-State: AOAM532oYlteaNQpvtJQPcWryVKPO1y+4XJF/pCJ6v5/zMhnqPocskxB
        NSFC9dcGBjZ3X00o3oqPC04kkvdK9LnxUG6pkEo=
X-Google-Smtp-Source: ABdhPJybkyswcfYCwEeZQMkn8ly2X+FZhl1LHwKoOeAtYaf8RH25jEIh/UybJxnIt+1Z6sv6Rj6oByaMpUPHBv2P4b8=
X-Received: by 2002:a05:6638:1212:: with SMTP id n18mr7316576jas.93.1643154400619;
 Tue, 25 Jan 2022 15:46:40 -0800 (PST)
MIME-Version: 1.0
References: <20220120060529.1890907-1-andrii@kernel.org> <20220120060529.1890907-4-andrii@kernel.org>
 <87wniu7hss.fsf@toke.dk> <CAEf4BzYpwK+iPPSx7G2-fTSc8dO-4+ObVP72cmu46z+gzFT0Cg@mail.gmail.com>
 <87lez87rbm.fsf@toke.dk> <CAEf4BzYJ9_1OpfCe9KZnDUDvezbc=bLFjq78n4tjBh=p_WFb3Q@mail.gmail.com>
 <87lez43tk4.fsf@toke.dk>
In-Reply-To: <87lez43tk4.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 25 Jan 2022 15:46:29 -0800
Message-ID: <CAEf4BzbPzDn-f-jZh4fDdjPo+ek7qSjMCzMFekGAfY4kuL1dMw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/4] libbpf: deprecate legacy BPF map definitions
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        David Ahern <dsahern@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 25, 2022 at 4:10 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Fri, Jan 21, 2022 at 12:43 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke=
@redhat.com> wrote:
> >>
> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >>
> >> > On Thu, Jan 20, 2022 at 3:44 AM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
> >> >>
> >> >> Andrii Nakryiko <andrii@kernel.org> writes:
> >> >>
> >> >> > Enact deprecation of legacy BPF map definition in SEC("maps") ([0=
]). For
> >> >> > the definitions themselves introduce LIBBPF_STRICT_MAP_DEFINITION=
S flag
> >> >> > for libbpf strict mode. If it is set, error out on any struct
> >> >> > bpf_map_def-based map definition. If not set, libbpf will print o=
ut
> >> >> > a warning for each legacy BPF map to raise awareness that it goes
> >> >> > away.
> >> >>
> >> >> We've touched upon this subject before, but I (still) don't think i=
t's a
> >> >> good idea to remove this support entirely: It makes it impossible t=
o
> >> >> write a loader that can handle both new and old BPF objects.
> >> >>
> >> >> So discourage the use of the old map definitions, sure, but please =
don't
> >> >> make it completely impossible to load such objects.
> >> >
> >> > BTF-defined maps have been around for quite a long time now and only
> >> > have benefits on top of the bpf_map_def way. The source code
> >> > translation is also very straightforward. If someone didn't get arou=
nd
> >> > to update their BPF program in 2 years, I don't think we can do much
> >> > about that.
> >> >
> >> > Maybe instead of trying to please everyone (especially those that
> >> > refuse to do anything to their BPF programs), let's work together to
> >> > nudge laggards to actually modernize their source code a little bit
> >> > and gain some benefits from that along the way?
> >>
> >> I'm completely fine with nudging people towards the newer features, an=
d
> >> I think the compile-time deprecation warning when someone is using the
> >> old-style map definitions in their BPF programs is an excellent way to
> >> do that.
> >>
> >> I'm also fine with libbpf *by default* refusing to load programs that
> >> use the old-style map definitions, but if the code is removed complete=
ly
> >> it becomes impossible to write general-purpose loaders that can handle
> >> both old and new programs. The obvious example of such a loader is
> >> iproute2, the loader in xdp-tools is another.
> >
> > This is because you want to deviate from underlying BPF loader's
> > behavior and feature set and dictate your own extended feature set in
> > xdp-tools/iproute2/etc. You can technically do that, but with a lot of
> > added complexity and headaches. But demanding libbpf to maintain
> > deprecated and discouraged features/APIs/practices for 10+ years and
> > accumulate all the internal cruft and maintenance burden isn't a great
> > solution either.
>
> Right, so work with me to find a solution? I already suggested several
> ideas, and you just keep repeating "just use the old library", which is
> tantamount to saying "take a hike".

I also proposed a solution: log warning, so that your users will be
aware and can modernize their code base and be ready for libbpf 1.0.
You also keep ignoring this.

Adding more obscure APIs and callbacks to let libxdp or iproute2
emulate old libbpf map definition syntax is not a good solution from
my point of view.

>
> I'm perfectly fine with having to jump through some more hoops to load
> old programs, and moving the old maps section parsing out of libbpf and
> into the caller is fine as well; but then we'd need to add some hooks to
> libbpf to create the maps inside the bpf_object. I can submit patches to
> do this, but I'm not going to bother if you're just going to reject them
> because you don't want to accommodate anything other than your way of
> doing things :/

It's not just parsing the definition. We'll need to define an entire
new protocol to dynamically add new custom BPF maps, and tie them
together to BPF program code, adding/resolving relocations, etc. It's
an overkill and not a good solution.

You keep fighting hard to let users not do anything and use BPF object
files generated years ago without recompilation and any source code
changes. I so far haven't seen any *user* actually complain about
this, only "middleman" libxdp and iproute2 are complaining right now.
Did you check with your users how much of a problem it really is?

In practice I've seen BPF users are quite willing to accommodate much
more radical changes to their code with no problem. And John's reply
just adds to that case.

>
> -Toke
>
