Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5A66E8609
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 01:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjDSXmz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 19:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDSXmy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 19:42:54 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F65110C2;
        Wed, 19 Apr 2023 16:42:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5083bd8e226so356080a12.3;
        Wed, 19 Apr 2023 16:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681947771; x=1684539771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw9VM9KUGkZj01MxwzeB9PPrMpaYXSZVF7gL2fEFefg=;
        b=Wgg3xcCHXwl8+yIriCQXBjQFDOkMn0q8H+ScIjWpKu9ibYXBxAjbdMVEWe/dV+EkZ7
         U9FWDTwWNorQdqL2CHQDS3ta/flUC087Y0Sb3sKEqGDEcpLBHT+Bk3wjYPqHvLiEchYB
         HFXLWw0HZpzzYmS14N14Xf3Cl62Z5csoWSAyw+bGqZMti+5I5PE1BoBKhSaQrZAnbA1G
         wOC/AT6hsSjeauaIMdqEIyKWalgsj6lSXUlrgCMAnH2USpR/nlq3PD5Zn3r5r3ILktbh
         4v3wAlfTIPvBF0FT9a3/uV3cdJe5Id5ma3IRaoEp+6X9lF9j8EsqiLYn5X+NhpPtwH2z
         L3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681947771; x=1684539771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw9VM9KUGkZj01MxwzeB9PPrMpaYXSZVF7gL2fEFefg=;
        b=Dbh7ctNweQb5guVw+3WVXdjFnuL3UWNRWJm+PJ33bAp5r7XvdU4MuVDm5jblHi2exU
         FViYt31QOZShzsCnpyZztJmyCOt4/4qqdFFiZnQv8jPUInCOkVcBt5cEL63u9ZIcPFBt
         2ypuNg/UrKVrdR5JOG16PeWReZKXsHlkgIql1Dxs8xFZw/Pl6sZpn5q0tsBiMN7MEMXl
         yElI/2/K6EVpn1kbGceZx1xyuOgsPd+vP2t0sj+GegKeJskOBrtyTprX09qHBrL159Xl
         n6f9Ina98uXBjgoNHR/YsaenUyXvMzC53b3+J9rN2wsOzhLZTpTvDFp+xfYk9oSpGGLq
         w92A==
X-Gm-Message-State: AAQBX9fgr4vx6tKYfK1wsLu/vq5S6CX1HIfgqPjPOZ6j7KbzD32UQnl8
        HOkbxspai8WFE1Xpp18hXieR8VnQLobOSz7XZ4y8ktaY
X-Google-Smtp-Source: AKy350aNcefGMSDkhAE/CcDzv20Ov6rIxQZPuxDaqfyPWwapxealwtmmaHkCKenYUyw0iq6dCww7Y0DSBVQDBZhHkw4=
X-Received: by 2002:aa7:cb84:0:b0:504:8c1a:70db with SMTP id
 r4-20020aa7cb84000000b005048c1a70dbmr7261342edt.32.1681947770548; Wed, 19 Apr
 2023 16:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <ZDfKBPXDQxH8HeX9@syu-laptop> <CACdoK4L5A-qdUyQwVbe-KE+0NBPbgqYC1v0uf0i1U_S7KSnmuw@mail.gmail.com>
 <20230414095007.GF63923@kunlun.suse.cz> <b933fad3-7759-00d4-94cb-f20dd363b794@isovalent.com>
 <20230414161520.GJ63923@kunlun.suse.cz> <CAEf4Bzaw6DBHn=S9zKCXTSh7jW8xL9K6bzi1Q-e8j93thi2hmg@mail.gmail.com>
 <20230418112454.GA15906@kitsune.suse.cz> <CAEf4BzZf50fX7T9k47u+9YQrMbSLxLeA1qWwrdWToCZkMhynjg@mail.gmail.com>
 <20230418174132.GE15906@kitsune.suse.cz> <ZD/3Ll7UPucyOYkk@syu-laptop.lan>
 <CAEf4BzZfGewUgYsNNqCgES5Y5-pqbSRDbhtKiuSC7=G_83tyig@mail.gmail.com> <87zg73tvm1.fsf@toke.dk>
In-Reply-To: <87zg73tvm1.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 19 Apr 2023 16:42:38 -0700
Message-ID: <CAEf4BzY9Hr2M7dZXaTZCP4SRat+KpN42c89LG1Msn4PB+1O1YA@mail.gmail.com>
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

On Wed, Apr 19, 2023 at 2:23=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Wed, Apr 19, 2023 at 7:14=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse=
.com> wrote:
> >>
> >> On Tue, Apr 18, 2023 at 07:41:32PM +0200, Michal Such=C3=A1nek wrote:
> >> > On Tue, Apr 18, 2023 at 09:38:20AM -0700, Andrii Nakryiko wrote:
> >> > > On Tue, Apr 18, 2023 at 4:24=E2=80=AFAM Michal Such=C3=A1nek <msuc=
hanek@suse.de> wrote:
> >> > > >
> >> > > > On Mon, Apr 17, 2023 at 05:20:03PM -0700, Andrii Nakryiko wrote:
> >> > > > > On Fri, Apr 14, 2023 at 9:15=E2=80=AFAM Michal Such=C3=A1nek <=
msuchanek@suse.de> wrote:
> >> > > > > > On Fri, Apr 14, 2023 at 01:30:02PM +0100, Quentin Monnet wro=
te:
> >> > > > > > > 2023-04-14 11:50 UTC+0200 ~ Michal Such=C3=A1nek <msuchane=
k@suse.de>
> >> > > > > > > > Hello,
> >> > > > > > > >
> >> > > > > > > > On Fri, Apr 14, 2023 at 01:35:20AM +0100, Quentin Monnet=
 wrote:
> >> > > > > > > >> Hi Shung-Hsi,
> >> > > > > > > >>
> >> > > > > > > >> On Thu, 13 Apr 2023 at 10:23, Shung-Hsi Yu <shung-hsi.y=
u@suse.com> wrote:
> >> > > > > > > >>>
> >> > > > > > > >>> Hi,
> >> > > > > > > >>>
> >> > > > > > > >>> I'm considering switch to bpftool's mirror on GitHub f=
or packaging (instead
> >> > > > > > > >>> of using the source found in kernel), but realize that=
 it should goes
> >> > > > > > > >>> hand-in-hand with how libbpf is packaged, which eventu=
ally leads these
> >> > > > > > > >>> questions:
> >> > > > > > > >>>
> >> > > > > > > >>>   What is the suggested approach for packaging bpftool=
 and libbpf?
> >> > > > > > > >>>   Which source is preferred, GitHub or kernel?
> >> > > > > > > >>
> >> > > > > > > >> As you can see from the previous discussions, the sugge=
sted approach
> >> > > > > > > >> would be to package from the GitHub mirror, with libbpf=
 and bpftool in
> >> > > > > > > >> sync.
> >> > > > > > > >>
> >> > > > > > > >> My main argument for the mirror is that it keeps things=
 simpler, and
> >> > > > > > > >> there's no need to deal with the rest of the kernel sou=
rces for these
> >> > > > > > > >> packages. Download from the mirrors, build, ship. But t=
hen I have
> >> > > > > > > >> limited experience at packaging for distros, and I can =
understand
> >> > > > > > > >> Toke's point of view, too. So ultimately, the call is y=
ours.
> >> > > > > > > >
> >> > > > > > > > Things get only ever more complex when submodules are in=
volved.
> >> > > > > > >
> >> > > > > > > I understand the generic pain points from your other email=
. But could
> >> > > > > > > you be more specific for the case of bpftool? It's not lik=
e we're
> >> > > > > > > shipping all lib dependencies as submodules. Sync-ups are =
specifically
> >> > > > > > > aligned to the same commit used to sync the libbpf mirror,=
 so that it's
> >> > > > > > > pretty much as if we had the right version of the library =
shipped in the
> >> > > > > > > repository - only, it's one --recurse-submodules away.
> >> > > > > >
> >> > > > > > It's so in every project that uses submodules. Except git do=
es not
> >> > > > > > recurse into submodules by default, you have to fix it up by=
 hand.
> >> > > > > > Forges don't support submodules so you will not get the subm=
odule when
> >> > > > > > downloading the project archive, and won't see it the the pr=
oject tree.
> >> > > > >
> >> > > > > git submodule update --init --recursive didn't work?
> >> > > >
> >> > > > That's one part of the manual fixup.
> >> > > >
> >> > > > The other part is after each git operation that could possibly c=
ause the
> >> > > > submodules to go out of sync, basically any operation that chang=
es the
> >> > > > checked-out commit.
> >> > > >
> >> > > > Of course, you can make some shell aliases that append whatever =
submodule
> >> > > > chicanery to whatever git command you might issue, and tell ever=
yone
> >> > > > else to do that, and then it will work in that one shell, and no=
t in any
> >> > > > other shell nor any tool that invokes git directly.
> >> > >
> >> > > Are we discussing a *standard* Git submodule feature and argue tha=
t
> >> > > because it might be cumbersome or unfamiliar to some engineers tha=
t
> >> > > projects should avoid using Git submodules?
> >> >
> >> > As far as I am aware they are unfamiliar to *most* engineers, and fo=
r
> >> > good reasons.
> >> >
> >> > > For one, I don't have any special aliases for dealing with Git
> >> > > submodules and it works fine. If I jump between branches or tags w=
hich
> >> > > update Git submodule reference, I do above `git submodule update
> >> > > --init --recursive` explicitly if I see that Git status shows
> >> > > out-of-sync Git submodule state. If I want to update a Git submodu=
le,
> >> > > I update the submodule's Git repo, and then git add it in the repo
> >> > > that uses this submodule. I haven't run into any other issues with
> >> > > this.
> >> >
> >> > You know, git could just handle submodules automagically. As you say=
,
> >> > it's not rocket science. For historical reasons it does not.
> >> >
> >> > With that working with submodules is cumbersome, and it's additional
> >> > thing that can break down that the engineer needs to be constantly a=
ware
> >> > of increasing the mental overhead of working with such projects.
> >> >
> >> > It may not be much of a problem for people who work with such projec=
ts
> >> > daily but not everyone does. Those who don't need to do the mental
> >> > switch whenever submodules are encountered, and are prone to getting
> >> > issues when they forget that they have to go that extra mile for thi=
s
> >> > specific project.
> >>
> >> For me it's less about having to go through the extra loop. It's that
> >> submodules would require git to be installed, network access, which al=
l adds
> >> extra moving parts compared to a tarball...
> >>
> >> > > > > > After previous experience with submodules I did not even try=
, I just
> >> > > > > > patched the makefile to use system libbpf before attempting =
anything
> >> > > > > > else.
> >> > > > >
> >> > > > > Quentin mentioned that he's packaging (or will package) libbpf=
 sources
> >> > > > > as part of bpftool release on Github. I've been this for other
> >> > > > > libbpf-using tools as well, and it works pretty well (at least=
 for
> >> > > > > Fedora and ArchLinux). E.g., srcs-full-* archives for veristat=
 ([0])
> >>
> >> and having libbpf included in bpftool release means the complain above=
 no
> >> longer holds. Though I have yet test build the mirror version of libbp=
f and
> >> bpftool like Michal has done.
> >
> > Great. This seems to work well for other tools that use libbpf through
> > submodule (anakryiko/retsnoop and libbpf/veristat on Github)
> >
> >>
> >> > > > > By switching up actual libbpf used to compile with bpftool, yo=
u are
> >> > > > > potentially introducing subtle problems that your users will b=
e quite
> >> > > > > unhappy about, if they run into them. Let's work together to m=
ake it
> >> > > > > easier for you to package bpftool properly. We can't switch bp=
ftool to
> >> > > > > reliably use system-wide libbpf (either static or shared, does=
n't
> >> > > > > matter) because of dependency on internal functionality.
> >> > > > >
> >> > > > >
> >> > > > >   [0] https://github.com/libbpf/veristat/releases/tag/v0.1
> >> > > >
> >> > > > So how many copies of libbpf do I need for having a CO-RE toolch=
ain?
> >> > >
> >> > > What do you mean by "CO-RE toolchain"? bpftool, veristat, retsnoop=
,
> >> > > etc are tools. The fact they are using statically linked libbpf
> >> > > through Git submodule is irrelevant to end users. You need one lib=
bpf
> >> > > in the system (for those who link dynamically against libbpf), the
> >> > > rest are just tools.
> >> > >
> >> > > >
> >> > > > Will different tools have different view of the kernel because t=
hey each
> >> > > > use different private copy of libbpf with different features?
> >> > >
> >> > > That's up to tools, not libbpf. You are over pivoting on libbpf he=
re.
> >> > > There is one view of the kernel, it depends on what features the
> >> > > kernel supports. If the tool requires some specific functionality =
of
> >> > > libbpf, it will update its Git submodule reference to get a versio=
n of
> >> > > libbpf that provides that feature. That's the point, an
> >> > > application/tool is in control of what kind of features it gets fr=
om
> >> > > libbpf.
> >>
> >> Since libbpf has a stable API & ABI, is it theoretically possible for
> >> bpftool, veristat, retsnoop, etc. all share the same version of libbpf=
?
> >
> > No, because libbpf is not just a set of APIs. Newer libbpf versions
> > support more BPF-side features, more kernel features, etc, etc. Libbpf
> > is not a typical user-space library, it is a BPF loader, and even if
> > user-visible API doesn't change, libbpf's support for various BPF-side
> > features is extended. Which is important for tools like bpftool,
> > retsnoop, veristat which rely on loading and working with BPF object
> > files.
>
> The converse of this is also true: if your system is upgraded to a new
> kernel version with new BPF features, the libbpf version should follow
> it, and all applications linked against it will automatically take
> advantage of any bugfixes regardless without having to wait for each
> application to be updated.

No, if my application was not developed to take advantage of a new
kernel feature, newer libbpf will do nothing for me. If my application
wants to support that feature, I'll update my application and
correspondingly update libbpf embedded in it. If my application is
affected by some bug fix, I'll update libbpf even faster than distros
will get to it.

I've heard all such arguments over the last few years. They are not
convincing and my own practical experience shows irrelevance of the
above argument.

>
> Libbpf is really no different from any other library here, and I really
> don't get why you keep insisting it's "special"...

It's special in the sense that it provides two sets of APIs -- for
user-space (typical libraries) and BPF object files. Besides that, for
BPF-side it's not even a set of APIs (headers, helpers, etc), it also
provides some set of functionality that can improve or be extended
over time. E.g., libbpf used to not support non-inlined BPF
subprograms, and then it started supporting them. In terms of API/ABI
-- nothing changed. Yet the change is very important.

Now, I build a tool that is using libbpf and some BPF functionality,
e.g., retsnoop. Libbpf just got SEC("ksyscall") support. Retsnoop
wants to take advantage of it. I just go and use SEC("ksyscall")
programs in .bpf.c files that are embedded inside retsnoop. I don't
have to *and don't want to* do feature detection of whether a
particular libbpf version that happens to be installed/packaged on the
system supports this version. I *know* it does, because I control it,
through a submodule. That's what I care about.

Whether some distro insists on libbpf being shared across any
libbpf-using application or not is none of my concern. Libbpf is an
implementation detail of my application (retsnoop), it's not for the
packager to decide how I develop and structure my tool.

>
> >> What I'd like to do it build libbpf and bpftool out of bpftool GitHub
> >> mirror's release tarball (w/ submodule included, which exists now for
> >> snapshot). For the rest of the tool that does not depends on libbpf pr=
ivate
> >> function, have them dynamically link to the libbpf built from bpftool'=
s
> >> source, just like how libelf is dynamically linked.
> >
> > Please don't do it, let applications control which libbpf versions
> > they are using. It's not just about user space APIs, I can't emphasize
> > this enough. Don't think you know better than developers of respective
> > applications, don't try to dictate how those applications should be
> > organized and developed.
>
> A well-behaved application will detect which features are available in

No, a well-behaved application will provide a reliable functionality
without necessarily paying maintenance and development cost of a maze
of #ifdef-ery just to satisfy arbitrary distro requirements of linking
with some shared library ("because security").

> the system version of the libraries they use, and if something is
> missing that it needs, either work around it or refuse to build. We do
> this with libbpf in xdp-tools and the only issues we've had with it has
> been the changing API in pre-1.0 libbpf...
>
> > One good example is iproute2, which chose to link (or not) with libbpf
> > dynamically. Now users periodically report various issues where their
> > BPF object files are not loaded, and it often comes down to unexpected
> > version of libbpf (or lack of libbpf support altogether) which which
> > iproute2 was built/deployed. This is just putting a burden on iproute2
> > users, and accidentally libbpf maintainers, for no good reason.
>
> How would this have been any different if iproute2 was statically linked
> against libbpf?

iproute2 version would determine what BPF features are supported, and
it would be consistent across distros and end user systems, regardless
of what libbpf shared library happens to be packaged and installed.
And users would know that starting from version X iproute2 is
libbpf-1.0+ compatible in what sort of BPF object file features are
supported by iproute2 when loading BPF programs.

>
> >> I'm not saying that those tools should not have libbpf as submodule; a=
s
> >> submodule do look useful. But for packaging I really would like to hav=
e the
> >> option of choosing the exact version of libbpf being used.
> >
> > The exact version of libbpf used by bpftool, retsnoop, veristat, etc
> > *is not relevant* to you as a packager. If you want happy users, use
> > *exact* version of libbpf from submodule to build them, with which
> > application was developed, tested, and advertised supported BPF
> > features. There is no reuse to be done here, they all can be on
> > different (and sometimes not yet released) libbpf version. For good
> > reasons, which are outside of your control as a packager.
>
> This is... just not how distributions work. As a user I trust my
> distribution to provide me with a coherent system where critical system
> libraries are maintained and receive timely updates. And I absolutely
> trust the distribution more to do this over application developers who
> just vendor in some version as a submodule and leave it there until they
> need a new feature...

Ok.

>
> -Toke
>
