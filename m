Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010886E9DFF
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 23:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjDTVjj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 17:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjDTVjh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 17:39:37 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C4C5FF7;
        Thu, 20 Apr 2023 14:39:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94eff00bcdaso129839966b.1;
        Thu, 20 Apr 2023 14:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682026770; x=1684618770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIUhJg/o1kg26v4N3N8o3wHSNmVHxtruVCT1WBrc5Uo=;
        b=bsvQzBXNP0rpRF8koXO9rREN3E+ZG4fSUYzjyEGy45z3+8Wcy650zx8H2yY2ZCytQz
         Od18sriYyNtdbjeQY2RwUO7gb3zVt1r4VS8YSQwob04W4iO3NI7vgHe3/PBHaAMkNUsL
         inm5oaP7EeZ8yI02z5J8ML1AnR0rHzgRcXbm3t4REaI6vNY8vuzZ9IGfWyGdmMPVpgOg
         7iPJuf0X4+RQAmdgTKMYcWcM7KWZqEs/rncwGHrBL6NAvSI62Tzu/09/0GIZqj1R6WIb
         mZHbHFTk3DAgc3cT2PK8/K/sPLSpwpJa4ZXzenacASEnIp66bJG1mtte0+nM+WVI4LyC
         Stsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682026770; x=1684618770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIUhJg/o1kg26v4N3N8o3wHSNmVHxtruVCT1WBrc5Uo=;
        b=KHt11OVjdT8h/De3wQe3GLBniCY9LMbWfck9i89aNmkJy4bHnlewu6fl8su+rGKlf9
         cmWU2DTprwxC8+QsyXzRQtZGSKtY87vgS4DCpIw1jWR1+PF4Opi6umzWSKj6THfwpQMK
         3Q68dCqQ5RVPpjSgqjg1jf9Z49u1isl+FUCxahE0MeDCUXmU1zZFqQv3AZpE6C+aoTan
         3GXrXstgoyxoMgTgMxb9K5QvbY/HSjgSQLQ5rx/Q2v7YNvj/TehYGB5IerLIZbcKb8Jq
         b41aH0XneSRaez0XWAIHvpZjlLQmYUXYLLXLyQ7OhUgYswsHFbFn0/xTttqrHWWFQCWj
         gCSw==
X-Gm-Message-State: AAQBX9fEkjlX8wU3NxXJHiRVxCZ9mH9R46es2vdpOfoxfLo2cpW/DMyD
        ioSIMTdkrQLr5GT0Z41aDfDWauTOJ1XDQWJ2Y4s=
X-Google-Smtp-Source: AKy350Y2aOQQ/OC2Xcfj/lffBuc+TH4Hgd+FNoAjAsDbZ4pfelG7Qa/XgMOQVVgqRzvKA2k06e1Melx/vELx88TMCBE=
X-Received: by 2002:a17:906:495a:b0:94e:e9c1:1932 with SMTP id
 f26-20020a170906495a00b0094ee9c11932mr340654ejt.43.1682026769822; Thu, 20 Apr
 2023 14:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <ZDfKBPXDQxH8HeX9@syu-laptop> <CACdoK4L5A-qdUyQwVbe-KE+0NBPbgqYC1v0uf0i1U_S7KSnmuw@mail.gmail.com>
 <20230414095007.GF63923@kunlun.suse.cz> <b933fad3-7759-00d4-94cb-f20dd363b794@isovalent.com>
 <20230414161520.GJ63923@kunlun.suse.cz> <CAEf4Bzaw6DBHn=S9zKCXTSh7jW8xL9K6bzi1Q-e8j93thi2hmg@mail.gmail.com>
 <20230418112454.GA15906@kitsune.suse.cz> <CAEf4BzZf50fX7T9k47u+9YQrMbSLxLeA1qWwrdWToCZkMhynjg@mail.gmail.com>
 <20230418174132.GE15906@kitsune.suse.cz> <ZD/3Ll7UPucyOYkk@syu-laptop.lan>
 <CAEf4BzZfGewUgYsNNqCgES5Y5-pqbSRDbhtKiuSC7=G_83tyig@mail.gmail.com>
 <87zg73tvm1.fsf@toke.dk> <CAEf4BzY9Hr2M7dZXaTZCP4SRat+KpN42c89LG1Msn4PB+1O1YA@mail.gmail.com>
 <878remtxvs.fsf@toke.dk>
In-Reply-To: <878remtxvs.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 20 Apr 2023 14:39:17 -0700
Message-ID: <CAEf4BzafdhjjxxW-7ovbO9vpGa3KVTV4iESe+gjRk7UyJtg6aA@mail.gmail.com>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Tony Jones <tonyj@suse.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>,
        Mahe Tardy <mahe.tardy@gmail.com>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 20, 2023 at 7:46=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> >> >> > > > > By switching up actual libbpf used to compile with bpftool,=
 you are
> >> >> > > > > potentially introducing subtle problems that your users wil=
l be quite
> >> >> > > > > unhappy about, if they run into them. Let's work together t=
o make it
> >> >> > > > > easier for you to package bpftool properly. We can't switch=
 bpftool to
> >> >> > > > > reliably use system-wide libbpf (either static or shared, d=
oesn't
> >> >> > > > > matter) because of dependency on internal functionality.
> >> >> > > > >
> >> >> > > > >
> >> >> > > > >   [0] https://github.com/libbpf/veristat/releases/tag/v0.1
> >> >> > > >
> >> >> > > > So how many copies of libbpf do I need for having a CO-RE too=
lchain?
> >> >> > >
> >> >> > > What do you mean by "CO-RE toolchain"? bpftool, veristat, retsn=
oop,
> >> >> > > etc are tools. The fact they are using statically linked libbpf
> >> >> > > through Git submodule is irrelevant to end users. You need one =
libbpf
> >> >> > > in the system (for those who link dynamically against libbpf), =
the
> >> >> > > rest are just tools.
> >> >> > >
> >> >> > > >
> >> >> > > > Will different tools have different view of the kernel becaus=
e they each
> >> >> > > > use different private copy of libbpf with different features?
> >> >> > >
> >> >> > > That's up to tools, not libbpf. You are over pivoting on libbpf=
 here.
> >> >> > > There is one view of the kernel, it depends on what features th=
e
> >> >> > > kernel supports. If the tool requires some specific functionali=
ty of
> >> >> > > libbpf, it will update its Git submodule reference to get a ver=
sion of
> >> >> > > libbpf that provides that feature. That's the point, an
> >> >> > > application/tool is in control of what kind of features it gets=
 from
> >> >> > > libbpf.
> >> >>
> >> >> Since libbpf has a stable API & ABI, is it theoretically possible f=
or
> >> >> bpftool, veristat, retsnoop, etc. all share the same version of lib=
bpf?
> >> >
> >> > No, because libbpf is not just a set of APIs. Newer libbpf versions
> >> > support more BPF-side features, more kernel features, etc, etc. Libb=
pf
> >> > is not a typical user-space library, it is a BPF loader, and even if
> >> > user-visible API doesn't change, libbpf's support for various BPF-si=
de
> >> > features is extended. Which is important for tools like bpftool,
> >> > retsnoop, veristat which rely on loading and working with BPF object
> >> > files.
> >>
> >> The converse of this is also true: if your system is upgraded to a new
> >> kernel version with new BPF features, the libbpf version should follow
> >> it, and all applications linked against it will automatically take
> >> advantage of any bugfixes regardless without having to wait for each
> >> application to be updated.
> >
> > No, if my application was not developed to take advantage of a new
> > kernel feature, newer libbpf will do nothing for me. If my application
> > wants to support that feature, I'll update my application and
> > correspondingly update libbpf embedded in it. If my application is
> > affected by some bug fix, I'll update libbpf even faster than distros
> > will get to it.
>
> You may do that, but you're also someone who is following the
> development of libbpf closely and pay attention to when bugs appear. Not
> all applications developers have the same vigilance for all the
> libraries they rely on. Which is the reason distros generally take on
> the responsibility of ensuring their users receive timely library
> updates.

The discussion was about bpftool, veristat, and retsnoop. "You may do
that" applies to all of them. I'm not forcing anyone else to follow
the same approach (e.g., I'm not forcing perf to vendor libbpf, for
example), I'm just opposing someone else forcing us (bpftool,
veristat, retsnoop) to not vendor libbpf.

>
> > I've heard all such arguments over the last few years. They are not
> > convincing and my own practical experience shows irrelevance of the
> > above argument.
>
> I don't doubt your personal experience, I'm just objecting to you
> dismissing other points of view just because you haven't experienced
> them yourself.

I acknowledged the security argument. And disagreeing and dismissing
are two big differences. So yes, I don't think the security argument
outweighs all the downsides of not controlling the exact libbpf
version my application relies on. And specifically for libbpf-related
use cases, libbpf-using applications are running under root. They are
not supposed to accept untrusted ELF files. So even if there is some
bug leading to crashes or some malfunction, I don't buy the
"emergency, we need to update all libbpf-using apps ASAP" argument,
sorry.

>
> >> Libbpf is really no different from any other library here, and I reall=
y
> >> don't get why you keep insisting it's "special"...
> >
> > It's special in the sense that it provides two sets of APIs -- for
> > user-space (typical libraries) and BPF object files. Besides that, for
> > BPF-side it's not even a set of APIs (headers, helpers, etc), it also
> > provides some set of functionality that can improve or be extended
> > over time. E.g., libbpf used to not support non-inlined BPF
> > subprograms, and then it started supporting them. In terms of API/ABI
> > -- nothing changed. Yet the change is very important.
>
> Lots of libraries do that. File format libraries support new format
> features without changing their API, networking libraries support new
> protocol features, etc. So again, libbpf is not special in this
> respect.

I didn't mean to start a "which library is the most special" contest.
The original point was about libbpf 1.0 stability of API, and that was
my objection, because it's not just about available APIs and their
stability. And libbpf is not used for the sake of using libbpf, it is
used with (usually embedded) BPF object file(s) that application is
expected to work, including any new SEC() support, global variables,
etc, etc.

>
> > Now, I build a tool that is using libbpf and some BPF functionality,
> > e.g., retsnoop. Libbpf just got SEC("ksyscall") support. Retsnoop
> > wants to take advantage of it. I just go and use SEC("ksyscall")
> > programs in .bpf.c files that are embedded inside retsnoop.
> > I don't have to *and don't want to* do feature detection of whether a
> > particular libbpf version that happens to be installed/packaged on the
> > system supports this version. I *know* it does, because I control it,
> > through a submodule. That's what I care about.
>
> Right, so just require a minimum version of the library where the API
> you want to use is available. That is pretty standard and distros deal
> with this all the time. This is not an argument for static linking or
> vendoring...

bpftool can't do that due to use of internal APIs. For others
(retsnoop, veristat), I don't want to be restricted by the released
libbpf version, or by expecting that the target system has new enough
libbpf installed.

>
> > Whether some distro insists on libbpf being shared across any
> > libbpf-using application or not is none of my concern. Libbpf is an
> > implementation detail of my application (retsnoop), it's not for the
> > packager to decide how I develop and structure my tool.
>
> Right, well, you don't *have* to be cooperative with the wider
> ecosystem, of course. Just as packagers don't have to follow your
> recommendations if they have good reasons not to. I believe we've had
> this discussion before, and I don't think we're going to agree this time
> around either, so let's not waste any more virtual ink on rehashing it :)

Exactly, so I'm not sure why we are even having this conversation all
over again. I agree on not wasting virtual ink anymore. I'm not
forcing anyone to follow my advice, I expect others to not force me to
follow theirs.

>
> -Toke
>
