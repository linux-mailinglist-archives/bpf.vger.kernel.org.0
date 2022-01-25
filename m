Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A25849BDFD
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 22:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbiAYVwu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 16:52:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55616 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233398AbiAYVwr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Jan 2022 16:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643147566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2pULtRu4NjPRQfGLs4fIjAN35wYykXc4MGUj2yFsReI=;
        b=FipVCwCXE06Av9sUZ6LoXvbsq1ejy51iXaM+c6bpRFaaBDtd6FyCGu8hePLhqluFwht9F9
        K9Q+uZxkIBYXeQxMvkn3m0E943Lq1LBmGVge92/RIsXNzbGboEDAvbAyRrYKFpeO6AEz5G
        gvv5Jfkw2qqFWSada1uWYNFNhvSrYLY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-oAC2dAtvOx2LkbZ8vMJPsQ-1; Tue, 25 Jan 2022 16:52:45 -0500
X-MC-Unique: oAC2dAtvOx2LkbZ8vMJPsQ-1
Received: by mail-ej1-f69.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso4005645eje.20
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 13:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=2pULtRu4NjPRQfGLs4fIjAN35wYykXc4MGUj2yFsReI=;
        b=eGG2YC+pyZN95LGv/wT+zRc+Ln+AZ5rL1OArU/SCT267kJ1olZckGi8aqBS/hbCqor
         fd/ujgksCApoBZziwfsusRc5kPEJ7nkh3VDXCx2kz3NjRVl9qIZnVlTEVOUP0NIetNHe
         1jcKzl5yV40c0/LbndfZWSna8BMYNS9AckqKPh7km2GT8DBUcA06nSN/ynJnaskOzo8i
         m8Uzq+n3/ey89JiCRHj8zVSYnE1vmha0EKZ4TVZPfBc+L6Zy2CUj0cB4nS2YvCP9uTtk
         l6BVxGhCtSx1kP7Fy/7gKKFcETA7lmbvWYojSTydaGvFnLEY5d2Jd2BYoUZWfN2xHaxb
         3OXw==
X-Gm-Message-State: AOAM532JNc2JojQklEHq7VN/q0JRX1mhTldpDcMwDTx4BVd1H6baSEnp
        6JsElXtVuWT2f35AVNvv6fLQ8jhHQu5HQGVZlro8xLMHotoxcCswf4cXYdquwaGHI4HEHQaWbKg
        KyCX9BwA3X27N
X-Received: by 2002:a17:906:d045:: with SMTP id bo5mr17761561ejb.92.1643147562614;
        Tue, 25 Jan 2022 13:52:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1OzAPlMKkMHS2dtyDQqFf48K01np91iA3S2ItR/PDP8cICPX2gD5U3oUJmf3KpqoijNUFaA==
X-Received: by 2002:a17:906:d045:: with SMTP id bo5mr17761505ejb.92.1643147561183;
        Tue, 25 Jan 2022 13:52:41 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id dc24sm6613271ejb.201.2022.01.25.13.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 13:52:40 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9B7401805FA; Tue, 25 Jan 2022 22:52:39 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        David Ahern <dsahern@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v2 bpf-next 3/4] libbpf: deprecate legacy BPF map
 definitions
In-Reply-To: <61f06309dabcc_2e4c52085d@john.notmuch>
References: <20220120060529.1890907-1-andrii@kernel.org>
 <20220120060529.1890907-4-andrii@kernel.org> <87wniu7hss.fsf@toke.dk>
 <CAEf4BzYpwK+iPPSx7G2-fTSc8dO-4+ObVP72cmu46z+gzFT0Cg@mail.gmail.com>
 <87lez87rbm.fsf@toke.dk>
 <CAEf4BzYJ9_1OpfCe9KZnDUDvezbc=bLFjq78n4tjBh=p_WFb3Q@mail.gmail.com>
 <87lez43tk4.fsf@toke.dk> <61f06309dabcc_2e4c52085d@john.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 25 Jan 2022 22:52:39 +0100
Message-ID: <87pmof32l4.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend <john.fastabend@gmail.com> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>=20
>> > On Fri, Jan 21, 2022 at 12:43 PM Toke H=C3=B8iland-J=C3=B8rgensen <tok=
e@redhat.com> wrote:
>> >>
>> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>> >>
>> >> > On Thu, Jan 20, 2022 at 3:44 AM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>> >> >>
>> >> >> Andrii Nakryiko <andrii@kernel.org> writes:
>> >> >>
>> >> >> > Enact deprecation of legacy BPF map definition in SEC("maps") ([=
0]). For
>> >> >> > the definitions themselves introduce LIBBPF_STRICT_MAP_DEFINITIO=
NS flag
>> >> >> > for libbpf strict mode. If it is set, error out on any struct
>> >> >> > bpf_map_def-based map definition. If not set, libbpf will print =
out
>> >> >> > a warning for each legacy BPF map to raise awareness that it goes
>> >> >> > away.
>> >> >>
>> >> >> We've touched upon this subject before, but I (still) don't think =
it's a
>> >> >> good idea to remove this support entirely: It makes it impossible =
to
>> >> >> write a loader that can handle both new and old BPF objects.
>> >> >>
>> >> >> So discourage the use of the old map definitions, sure, but please=
 don't
>> >> >> make it completely impossible to load such objects.
>> >> >
>> >> > BTF-defined maps have been around for quite a long time now and only
>> >> > have benefits on top of the bpf_map_def way. The source code
>> >> > translation is also very straightforward. If someone didn't get aro=
und
>> >> > to update their BPF program in 2 years, I don't think we can do much
>> >> > about that.
>> >> >
>> >> > Maybe instead of trying to please everyone (especially those that
>> >> > refuse to do anything to their BPF programs), let's work together to
>> >> > nudge laggards to actually modernize their source code a little bit
>> >> > and gain some benefits from that along the way?
>> >>
>> >> I'm completely fine with nudging people towards the newer features, a=
nd
>> >> I think the compile-time deprecation warning when someone is using the
>> >> old-style map definitions in their BPF programs is an excellent way to
>> >> do that.
>> >>
>> >> I'm also fine with libbpf *by default* refusing to load programs that
>> >> use the old-style map definitions, but if the code is removed complet=
ely
>> >> it becomes impossible to write general-purpose loaders that can handle
>> >> both old and new programs. The obvious example of such a loader is
>> >> iproute2, the loader in xdp-tools is another.
>> >
>> > This is because you want to deviate from underlying BPF loader's
>> > behavior and feature set and dictate your own extended feature set in
>> > xdp-tools/iproute2/etc. You can technically do that, but with a lot of
>> > added complexity and headaches. But demanding libbpf to maintain
>> > deprecated and discouraged features/APIs/practices for 10+ years and
>> > accumulate all the internal cruft and maintenance burden isn't a great
>> > solution either.
>>=20
>> Right, so work with me to find a solution? I already suggested several
>> ideas, and you just keep repeating "just use the old library", which is
>> tantamount to saying "take a hike".
>
> I'll just throw my $.02 here as I'm reviewing. On major versions its
> fairly common to not force API compat with the libs I'm used to working
> with. Most recent example that comes to my mind (just did this yesterday
> for example) was porting code into openssl3.x from older version. I
> mumbled a bit, but still did it so that I could get my tools working on
> latest and greatest.
>
> Going from 0.x -> 1.0 seems reasonable to break compat, users don't
> need to update immediately right? They can linger around on 0.x release
> until they have some time or reason to jump onto 1.0? Distro's can
> carry all versions for as long as necessary. Thats the value add of
> distributions in my mind anyways. And a 0.x version somewhat implies
> its not stable yet imo.

I'm fine with breaking compatibility of the library. We already handle
that in xdp-tools via standard configure probing. The problem here is
with breaking compatibility the data file format (i.e., BPF ELF files);
in your openssl example that would correspond to new versions of openssl
refusing to read certificate files that were issued before the upgrade.

I really don't get why this distinction is so hard to explain? Is there
some mental model disconnect here somewhere, or something?

>> I'm perfectly fine with having to jump through some more hoops to load
>> old programs, and moving the old maps section parsing out of libbpf and
>> into the caller is fine as well; but then we'd need to add some hooks to
>> libbpf to create the maps inside the bpf_object. I can submit patches to
>> do this, but I'm not going to bother if you're just going to reject them
>> because you don't want to accommodate anything other than your way of
>> doing things :/
>
> Can't xdp-tools run on 0.x for as long as wanted and flip over when
> it is ready? Same for iproute2 'tc' loader? I'm not seeing what would
> break except for random people trying to use tools in debug or
> experiments.

New stuff would break. I.e., then xdp-tools / tc would be stuck on that
version forever, and wouldn't be able to load any BPF programs that rely
on features added to libbpf after 1.0.

> FWIW the dumb netlink based loader I wrote to attach create qdiscs and
> attach filters is <100 lines of code so its not a huge lift if you end
> up having to roll your own here.

We're not just talking about "creating qdiscs and attaching filters"
here, we're talking about the loading of BPF object files. "Rolling my
own" means writing code that parses elf files, populates maps, creates
them in the kernel, does the relocations etc. That's essentially a
rewrite / fork of libbpf, which is what I'm trying to avoid...

-Toke

