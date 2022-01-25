Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5F849BE99
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 23:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbiAYWft (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 17:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiAYWfr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 17:35:47 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120CAC06173B
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 14:35:47 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id q19-20020a056830441300b0059a54d66106so282052otv.0
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 14:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=6B644vLABBekOGfabtA3qwqcl62fDsye3or5I+O449U=;
        b=kBtvdBHK0180+6mM5jtdKl4E0PxDPGXkVAIWDkDw24URUSjgkFV3sOL9k+uBW+xZN+
         1K+/3QWG0JUrxwWqj2RG5/SaGgltf8BhMGlH7XmuzS07Uyizez3TMjlFcc4HaQnHP10N
         ZarIELK69tMtROGbRwGmdXD5sv2qC/ClLxYSz3M6+9nktgVbx0Y1Mh/FUgJNGPCSiWyB
         UQ050Y+8yY+xRX54C+btS2Vh+VvZ44UBowgX9cfWUTN6IlfhHOBOGaXbrfLpIcZBWIUq
         3scS0UtsSQ+dAwaeTwbaMG8ihZ/HzwG6H1XC0tjTDzNZYTR6yXO+Mocb2K/gh1NeK9Zs
         OCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=6B644vLABBekOGfabtA3qwqcl62fDsye3or5I+O449U=;
        b=owI8Y9TTafrQ6AoBKriTJPjX5jxvM624ctSQHx00n+dh59FOtSynpCgJGlHGz3EAWG
         oTw3BTqNSZt07elUxZoM4JVOAMnxu2g/ZYnff62DCLyBknXafB9VFb984hgFXfN2EASr
         fEQK7+D3yKopKSprSQLlgPtceMV5Ijhky86aiDhOrt03KYBKzUK/uZro3/bjztFiMK46
         GTH/JN2Hq3H0EZGXFdmCXbgRDxk0VkcIO5gbNcWY+eAnoKXKBvi2TJl2E+vDaOw6rhdm
         EQY94Zvsi04iE/6dETeBCfs72vLV8RtuRFVbsK/vLO6cchR3rl2kexPI9QZIIVQUZkIF
         GUyg==
X-Gm-Message-State: AOAM533fJydtlGyNfhxIRqNmYjKxqtwJ77Xj+6dGliFbgTWjHOhMdbtQ
        ezrKSGHknITvwf+p2gr4ttT0Tu/YIU1WQA==
X-Google-Smtp-Source: ABdhPJx0hPTh/4SG+dl1hTUugyrl9phu2euYOL2tvEogFnczLUHT81yR7v5QkMHotyzr1geSICJaSg==
X-Received: by 2002:a05:6830:2aa5:: with SMTP id s37mr15681110otu.285.1643150146245;
        Tue, 25 Jan 2022 14:35:46 -0800 (PST)
Received: from localhost ([99.197.200.79])
        by smtp.gmail.com with ESMTPSA id r24sm1733882otc.29.2022.01.25.14.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:35:45 -0800 (PST)
Date:   Tue, 25 Jan 2022 14:35:38 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        David Ahern <dsahern@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <61f07b3ac6bbb_30a5920833@john.notmuch>
In-Reply-To: <87pmof32l4.fsf@toke.dk>
References: <20220120060529.1890907-1-andrii@kernel.org>
 <20220120060529.1890907-4-andrii@kernel.org>
 <87wniu7hss.fsf@toke.dk>
 <CAEf4BzYpwK+iPPSx7G2-fTSc8dO-4+ObVP72cmu46z+gzFT0Cg@mail.gmail.com>
 <87lez87rbm.fsf@toke.dk>
 <CAEf4BzYJ9_1OpfCe9KZnDUDvezbc=bLFjq78n4tjBh=p_WFb3Q@mail.gmail.com>
 <87lez43tk4.fsf@toke.dk>
 <61f06309dabcc_2e4c52085d@john.notmuch>
 <87pmof32l4.fsf@toke.dk>
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
> John Fastabend <john.fastabend@gmail.com> writes:
> =

> > Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >> =

> >> > On Fri, Jan 21, 2022 at 12:43 PM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
> >> >>
> >> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >> >>
> >> >> > On Thu, Jan 20, 2022 at 3:44 AM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
> >> >> >>
> >> >> >> Andrii Nakryiko <andrii@kernel.org> writes:
> >> >> >>
> >> >> >> > Enact deprecation of legacy BPF map definition in SEC("maps"=
) ([0]). For
> >> >> >> > the definitions themselves introduce LIBBPF_STRICT_MAP_DEFIN=
ITIONS flag
> >> >> >> > for libbpf strict mode. If it is set, error out on any struc=
t
> >> >> >> > bpf_map_def-based map definition. If not set, libbpf will pr=
int out
> >> >> >> > a warning for each legacy BPF map to raise awareness that it=
 goes
> >> >> >> > away.
> >> >> >>
> >> >> >> We've touched upon this subject before, but I (still) don't th=
ink it's a
> >> >> >> good idea to remove this support entirely: It makes it impossi=
ble to
> >> >> >> write a loader that can handle both new and old BPF objects.
> >> >> >>
> >> >> >> So discourage the use of the old map definitions, sure, but pl=
ease don't
> >> >> >> make it completely impossible to load such objects.
> >> >> >
> >> >> > BTF-defined maps have been around for quite a long time now and=
 only
> >> >> > have benefits on top of the bpf_map_def way. The source code
> >> >> > translation is also very straightforward. If someone didn't get=
 around
> >> >> > to update their BPF program in 2 years, I don't think we can do=
 much
> >> >> > about that.
> >> >> >
> >> >> > Maybe instead of trying to please everyone (especially those th=
at
> >> >> > refuse to do anything to their BPF programs), let's work togeth=
er to
> >> >> > nudge laggards to actually modernize their source code a little=
 bit
> >> >> > and gain some benefits from that along the way?
> >> >>
> >> >> I'm completely fine with nudging people towards the newer feature=
s, and
> >> >> I think the compile-time deprecation warning when someone is usin=
g the
> >> >> old-style map definitions in their BPF programs is an excellent w=
ay to
> >> >> do that.
> >> >>
> >> >> I'm also fine with libbpf *by default* refusing to load programs =
that
> >> >> use the old-style map definitions, but if the code is removed com=
pletely
> >> >> it becomes impossible to write general-purpose loaders that can h=
andle
> >> >> both old and new programs. The obvious example of such a loader i=
s
> >> >> iproute2, the loader in xdp-tools is another.
> >> >
> >> > This is because you want to deviate from underlying BPF loader's
> >> > behavior and feature set and dictate your own extended feature set=
 in
> >> > xdp-tools/iproute2/etc. You can technically do that, but with a lo=
t of
> >> > added complexity and headaches. But demanding libbpf to maintain
> >> > deprecated and discouraged features/APIs/practices for 10+ years a=
nd
> >> > accumulate all the internal cruft and maintenance burden isn't a g=
reat
> >> > solution either.
> >> =

> >> Right, so work with me to find a solution? I already suggested sever=
al
> >> ideas, and you just keep repeating "just use the old library", which=
 is
> >> tantamount to saying "take a hike".
> >
> > I'll just throw my $.02 here as I'm reviewing. On major versions its
> > fairly common to not force API compat with the libs I'm used to worki=
ng
> > with. Most recent example that comes to my mind (just did this yester=
day
> > for example) was porting code into openssl3.x from older version. I
> > mumbled a bit, but still did it so that I could get my tools working =
on
> > latest and greatest.
> >
> > Going from 0.x -> 1.0 seems reasonable to break compat, users don't
> > need to update immediately right? They can linger around on 0.x relea=
se
> > until they have some time or reason to jump onto 1.0? Distro's can
> > carry all versions for as long as necessary. Thats the value add of
> > distributions in my mind anyways. And a 0.x version somewhat implies
> > its not stable yet imo.
> =

> I'm fine with breaking compatibility of the library. We already handle
> that in xdp-tools via standard configure probing. The problem here is
> with breaking compatibility the data file format (i.e., BPF ELF files);=

> in your openssl example that would correspond to new versions of openss=
l
> refusing to read certificate files that were issued before the upgrade.=

> =

> I really don't get why this distinction is so hard to explain? Is there=

> some mental model disconnect here somewhere, or something?

Ah I think the difference is, in my mental model a BPF Program is the
BPF object file, the loader code, user space components to manage BPF
maps/perf-rings/objects, and a bunch of other user space code to do
something useful with whatever is showing up in maps, perf ring, etc.
These are one program in my model. A BPF object on its own has little
value in my model. (A BPF lib on the other hand implementing common
functionality is very useful though) Even if the BPF object files are
coming from a different team we have to work closely together because
map value/keys have an API, perf-ring events have an API and so on.

I don't see it as a paticularly major problem if we break old things
here because the only things in my model that get loaded over these
loaders are debug progs and experimental code. Super useful stuff
by the way, but something I would expect a human to go 'oh it didn't
load' I guess I shouldn't have ignored the warning for the last
year and then they fix it. Or if it is a program shell'ing out to
the tool they manage the versions carefully so wouldn't upgrade
to latest version until their system is ready. I'm not seeing how
this would end up breaking a deployed production system.

So my mental model doesn't seem to have the same issues here of some
long lived/unmaintained and isolated BPF object file that doesn't have
close ties to the loader. A bit curious how you get these
BPF programs that are not changeable and don't control the loader.

> =

> >> I'm perfectly fine with having to jump through some more hoops to lo=
ad
> >> old programs, and moving the old maps section parsing out of libbpf =
and
> >> into the caller is fine as well; but then we'd need to add some hook=
s to
> >> libbpf to create the maps inside the bpf_object. I can submit patche=
s to
> >> do this, but I'm not going to bother if you're just going to reject =
them
> >> because you don't want to accommodate anything other than your way o=
f
> >> doing things :/
> >
> > Can't xdp-tools run on 0.x for as long as wanted and flip over when
> > it is ready? Same for iproute2 'tc' loader? I'm not seeing what would=

> > break except for random people trying to use tools in debug or
> > experiments.
> =

> New stuff would break. I.e., then xdp-tools / tc would be stuck on that=

> version forever, and wouldn't be able to load any BPF programs that rel=
y
> on features added to libbpf after 1.0.
> =

> > FWIW the dumb netlink based loader I wrote to attach create qdiscs an=
d
> > attach filters is <100 lines of code so its not a huge lift if you en=
d
> > up having to roll your own here.
> =

> We're not just talking about "creating qdiscs and attaching filters"
> here, we're talking about the loading of BPF object files. "Rolling my
> own" means writing code that parses elf files, populates maps, creates
> them in the kernel, does the relocations etc. That's essentially a
> rewrite / fork of libbpf, which is what I'm trying to avoid...

In practice I just forked/wrote my own loader code where needed and
libbpf didn't have what was needed. The thinking being my use case was so=

niche it didn't make much sense to put in a general purpose lib and
burden everyone with the support/maintenance/cluter cost. I
think its ok for a library to not support all possible use cases.

.John

> =

> -Toke
> =
