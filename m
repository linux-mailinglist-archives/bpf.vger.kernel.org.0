Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A7D6E8227
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 21:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjDSTxG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 15:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjDSTwx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 15:52:53 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3806D7A88;
        Wed, 19 Apr 2023 12:52:41 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5055141a8fdso230430a12.3;
        Wed, 19 Apr 2023 12:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681933959; x=1684525959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5v6OBLKwybxWT3pyZdPYJQ5rSEDUDj6R+xIKT5XQaDU=;
        b=sTPmR9+G1+getD8eaFegvxntKawU0CfCH0A8kBEnth/lfX+Z5Kkgn/dZEUZqpedq4b
         jASjIh/h1GgRruQVyRuqgslA5HekCiqUWiPv7NUuYGKIdv2e5h9QVpa0jYP0T9R2ySBg
         aqvU3a+LrcoFfoBEIVkO1G6ymSWEbrt46g0mP0gV27xNdFhiuS65XCpZ4BLYo7ZmYhlO
         GIdmMdALPkPvTYEgaR4YzEobtGXP3EnBqXOCzHa9vkPSLc7Ckd1YgVGYIx2Qu77j0ySU
         lsGRZdJRNE53qxFnTyGmQODZt7qlt9UdM7oK01hhVrWNSpDF4ELrLpWM8RYXT+T4e+Jo
         BP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681933959; x=1684525959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5v6OBLKwybxWT3pyZdPYJQ5rSEDUDj6R+xIKT5XQaDU=;
        b=GlLsuDHDq5pmkKuY5Sdh9JTLnJgS8AJc7K2NliI7cytst/8AM2kv5JCxwN+nd/FdQM
         K73hRnqjhZ2I85Pi0DT93A40FLvGpKVEYyh//TFoazMqOxJHUZPQEVyjP7CaB6JQBpn+
         S4o3FF7CxsnKjoGmAaQogQdfZNjuUN5yHLH89Bo5zwFr4iZOrxh3J+z6yF/SrSvcmlMT
         0GfTeN9GamIzoi1HbRsOe1bNX0JHJa5wsGnENjtGpzDcK3JAxEkoz2gPqc6M1hWr6bsZ
         c5ATEjVuF+6KC71UQrb27mkS1flC0jl3ZoY5Jh0sIlfa9Vs34q0RP82ZKXF2FBBQvtPv
         dckw==
X-Gm-Message-State: AAQBX9dVw+C3FxKZRWCZhuDNeOK6Aj/W3Au3DOyvpBqMrUTynHCO3l1m
        3+U5vLQOsVv/hjdu63ZcD5c/HeeDqDh75qWnyf8=
X-Google-Smtp-Source: AKy350bZOAQTFK/nrLCAADYRTDOwmQWcTY4MdYmiYmgAl6pNdRwTrVFjUc0ChLXvkoGFpQRZAo4Y9BUOyOpqLjvrguw=
X-Received: by 2002:a05:6402:7c1:b0:4fc:c644:6149 with SMTP id
 u1-20020a05640207c100b004fcc6446149mr6978252edy.0.1681933959248; Wed, 19 Apr
 2023 12:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <ZDfKBPXDQxH8HeX9@syu-laptop> <CACdoK4L5A-qdUyQwVbe-KE+0NBPbgqYC1v0uf0i1U_S7KSnmuw@mail.gmail.com>
 <20230414095007.GF63923@kunlun.suse.cz> <b933fad3-7759-00d4-94cb-f20dd363b794@isovalent.com>
 <20230414161520.GJ63923@kunlun.suse.cz> <CAEf4Bzaw6DBHn=S9zKCXTSh7jW8xL9K6bzi1Q-e8j93thi2hmg@mail.gmail.com>
 <20230418112454.GA15906@kitsune.suse.cz> <CAEf4BzZf50fX7T9k47u+9YQrMbSLxLeA1qWwrdWToCZkMhynjg@mail.gmail.com>
 <20230418174132.GE15906@kitsune.suse.cz> <ZD/3Ll7UPucyOYkk@syu-laptop.lan>
In-Reply-To: <ZD/3Ll7UPucyOYkk@syu-laptop.lan>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 19 Apr 2023 12:52:26 -0700
Message-ID: <CAEf4BzZfGewUgYsNNqCgES5Y5-pqbSRDbhtKiuSC7=G_83tyig@mail.gmail.com>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Tony Jones <tonyj@suse.de>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
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

On Wed, Apr 19, 2023 at 7:14=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> On Tue, Apr 18, 2023 at 07:41:32PM +0200, Michal Such=C3=A1nek wrote:
> > On Tue, Apr 18, 2023 at 09:38:20AM -0700, Andrii Nakryiko wrote:
> > > On Tue, Apr 18, 2023 at 4:24=E2=80=AFAM Michal Such=C3=A1nek <msuchan=
ek@suse.de> wrote:
> > > >
> > > > On Mon, Apr 17, 2023 at 05:20:03PM -0700, Andrii Nakryiko wrote:
> > > > > On Fri, Apr 14, 2023 at 9:15=E2=80=AFAM Michal Such=C3=A1nek <msu=
chanek@suse.de> wrote:
> > > > > > On Fri, Apr 14, 2023 at 01:30:02PM +0100, Quentin Monnet wrote:
> > > > > > > 2023-04-14 11:50 UTC+0200 ~ Michal Such=C3=A1nek <msuchanek@s=
use.de>
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > On Fri, Apr 14, 2023 at 01:35:20AM +0100, Quentin Monnet wr=
ote:
> > > > > > > >> Hi Shung-Hsi,
> > > > > > > >>
> > > > > > > >> On Thu, 13 Apr 2023 at 10:23, Shung-Hsi Yu <shung-hsi.yu@s=
use.com> wrote:
> > > > > > > >>>
> > > > > > > >>> Hi,
> > > > > > > >>>
> > > > > > > >>> I'm considering switch to bpftool's mirror on GitHub for =
packaging (instead
> > > > > > > >>> of using the source found in kernel), but realize that it=
 should goes
> > > > > > > >>> hand-in-hand with how libbpf is packaged, which eventuall=
y leads these
> > > > > > > >>> questions:
> > > > > > > >>>
> > > > > > > >>>   What is the suggested approach for packaging bpftool an=
d libbpf?
> > > > > > > >>>   Which source is preferred, GitHub or kernel?
> > > > > > > >>
> > > > > > > >> As you can see from the previous discussions, the suggeste=
d approach
> > > > > > > >> would be to package from the GitHub mirror, with libbpf an=
d bpftool in
> > > > > > > >> sync.
> > > > > > > >>
> > > > > > > >> My main argument for the mirror is that it keeps things si=
mpler, and
> > > > > > > >> there's no need to deal with the rest of the kernel source=
s for these
> > > > > > > >> packages. Download from the mirrors, build, ship. But then=
 I have
> > > > > > > >> limited experience at packaging for distros, and I can und=
erstand
> > > > > > > >> Toke's point of view, too. So ultimately, the call is your=
s.
> > > > > > > >
> > > > > > > > Things get only ever more complex when submodules are invol=
ved.
> > > > > > >
> > > > > > > I understand the generic pain points from your other email. B=
ut could
> > > > > > > you be more specific for the case of bpftool? It's not like w=
e're
> > > > > > > shipping all lib dependencies as submodules. Sync-ups are spe=
cifically
> > > > > > > aligned to the same commit used to sync the libbpf mirror, so=
 that it's
> > > > > > > pretty much as if we had the right version of the library shi=
pped in the
> > > > > > > repository - only, it's one --recurse-submodules away.
> > > > > >
> > > > > > It's so in every project that uses submodules. Except git does =
not
> > > > > > recurse into submodules by default, you have to fix it up by ha=
nd.
> > > > > > Forges don't support submodules so you will not get the submodu=
le when
> > > > > > downloading the project archive, and won't see it the the proje=
ct tree.
> > > > >
> > > > > git submodule update --init --recursive didn't work?
> > > >
> > > > That's one part of the manual fixup.
> > > >
> > > > The other part is after each git operation that could possibly caus=
e the
> > > > submodules to go out of sync, basically any operation that changes =
the
> > > > checked-out commit.
> > > >
> > > > Of course, you can make some shell aliases that append whatever sub=
module
> > > > chicanery to whatever git command you might issue, and tell everyon=
e
> > > > else to do that, and then it will work in that one shell, and not i=
n any
> > > > other shell nor any tool that invokes git directly.
> > >
> > > Are we discussing a *standard* Git submodule feature and argue that
> > > because it might be cumbersome or unfamiliar to some engineers that
> > > projects should avoid using Git submodules?
> >
> > As far as I am aware they are unfamiliar to *most* engineers, and for
> > good reasons.
> >
> > > For one, I don't have any special aliases for dealing with Git
> > > submodules and it works fine. If I jump between branches or tags whic=
h
> > > update Git submodule reference, I do above `git submodule update
> > > --init --recursive` explicitly if I see that Git status shows
> > > out-of-sync Git submodule state. If I want to update a Git submodule,
> > > I update the submodule's Git repo, and then git add it in the repo
> > > that uses this submodule. I haven't run into any other issues with
> > > this.
> >
> > You know, git could just handle submodules automagically. As you say,
> > it's not rocket science. For historical reasons it does not.
> >
> > With that working with submodules is cumbersome, and it's additional
> > thing that can break down that the engineer needs to be constantly awar=
e
> > of increasing the mental overhead of working with such projects.
> >
> > It may not be much of a problem for people who work with such projects
> > daily but not everyone does. Those who don't need to do the mental
> > switch whenever submodules are encountered, and are prone to getting
> > issues when they forget that they have to go that extra mile for this
> > specific project.
>
> For me it's less about having to go through the extra loop. It's that
> submodules would require git to be installed, network access, which all a=
dds
> extra moving parts compared to a tarball...
>
> > > > > > After previous experience with submodules I did not even try, I=
 just
> > > > > > patched the makefile to use system libbpf before attempting any=
thing
> > > > > > else.
> > > > >
> > > > > Quentin mentioned that he's packaging (or will package) libbpf so=
urces
> > > > > as part of bpftool release on Github. I've been this for other
> > > > > libbpf-using tools as well, and it works pretty well (at least fo=
r
> > > > > Fedora and ArchLinux). E.g., srcs-full-* archives for veristat ([=
0])
>
> and having libbpf included in bpftool release means the complain above no
> longer holds. Though I have yet test build the mirror version of libbpf a=
nd
> bpftool like Michal has done.

Great. This seems to work well for other tools that use libbpf through
submodule (anakryiko/retsnoop and libbpf/veristat on Github)

>
> > > > > By switching up actual libbpf used to compile with bpftool, you a=
re
> > > > > potentially introducing subtle problems that your users will be q=
uite
> > > > > unhappy about, if they run into them. Let's work together to make=
 it
> > > > > easier for you to package bpftool properly. We can't switch bpfto=
ol to
> > > > > reliably use system-wide libbpf (either static or shared, doesn't
> > > > > matter) because of dependency on internal functionality.
> > > > >
> > > > >
> > > > >   [0] https://github.com/libbpf/veristat/releases/tag/v0.1
> > > >
> > > > So how many copies of libbpf do I need for having a CO-RE toolchain=
?
> > >
> > > What do you mean by "CO-RE toolchain"? bpftool, veristat, retsnoop,
> > > etc are tools. The fact they are using statically linked libbpf
> > > through Git submodule is irrelevant to end users. You need one libbpf
> > > in the system (for those who link dynamically against libbpf), the
> > > rest are just tools.
> > >
> > > >
> > > > Will different tools have different view of the kernel because they=
 each
> > > > use different private copy of libbpf with different features?
> > >
> > > That's up to tools, not libbpf. You are over pivoting on libbpf here.
> > > There is one view of the kernel, it depends on what features the
> > > kernel supports. If the tool requires some specific functionality of
> > > libbpf, it will update its Git submodule reference to get a version o=
f
> > > libbpf that provides that feature. That's the point, an
> > > application/tool is in control of what kind of features it gets from
> > > libbpf.
>
> Since libbpf has a stable API & ABI, is it theoretically possible for
> bpftool, veristat, retsnoop, etc. all share the same version of libbpf?

No, because libbpf is not just a set of APIs. Newer libbpf versions
support more BPF-side features, more kernel features, etc, etc. Libbpf
is not a typical user-space library, it is a BPF loader, and even if
user-visible API doesn't change, libbpf's support for various BPF-side
features is extended. Which is important for tools like bpftool,
retsnoop, veristat which rely on loading and working with BPF object
files.

>
> What I'd like to do it build libbpf and bpftool out of bpftool GitHub
> mirror's release tarball (w/ submodule included, which exists now for
> snapshot). For the rest of the tool that does not depends on libbpf priva=
te
> function, have them dynamically link to the libbpf built from bpftool's
> source, just like how libelf is dynamically linked.

Please don't do it, let applications control which libbpf versions
they are using. It's not just about user space APIs, I can't emphasize
this enough. Don't think you know better than developers of respective
applications, don't try to dictate how those applications should be
organized and developed.

One good example is iproute2, which chose to link (or not) with libbpf
dynamically. Now users periodically report various issues where their
BPF object files are not loaded, and it often comes down to unexpected
version of libbpf (or lack of libbpf support altogether) which which
iproute2 was built/deployed. This is just putting a burden on iproute2
users, and accidentally libbpf maintainers, for no good reason.

>
> I'm not saying that those tools should not have libbpf as submodule; as
> submodule do look useful. But for packaging I really would like to have t=
he
> option of choosing the exact version of libbpf being used.

The exact version of libbpf used by bpftool, retsnoop, veristat, etc
*is not relevant* to you as a packager. If you want happy users, use
*exact* version of libbpf from submodule to build them, with which
application was developed, tested, and advertised supported BPF
features. There is no reuse to be done here, they all can be on
different (and sometimes not yet released) libbpf version. For good
reasons, which are outside of your control as a packager.

>
> > > > When there is a bug in libbpf how many places need to be patched to=
 fix
> > > > it?
> > >
> > > That's up to tools, again. If the bug is affecting them, they should
> > > cut a new version of their *tool*, using a patched version of libbpf
> > > from Github. If it doesn't affect them, then it doesn't matter *to
> > > them*.
> >
> > I don't share your optimism about this happening in the real world.
> >
> > For one the issue that the github tarballs do not contain the submodule
> > and thus cannot be built was raised nearly two months ago, and while a
> > test snapshot that does include the submodule is released, a release
> > does not exist yet.
> >
> > For people to make use of the repository without a release cut they nee=
d
> > to replicate that submodule support - that is add support for submodule=
s
> > in their development tooling. Otherwise you personally cutting a releas=
e
> > becomes a single point of failure.
> >
> > Because there is no API it's not really advisable to just apply patches
> > on top of the last release either. Applying patches may cause the main
> > project and the submodule to go out of sync, the submodule would not ge=
t
> > updated by applying a patch to the main project, and the other way
> > around.
> >
> > Suppose a severe security bug that requires patching libbpf is found.
> > Now there is a number of tools that are each tied to one specific
> > version of libbpf, and cannot be upgraded to up-to-date fixed version
> > because that would break them. I would hope that never happens.
> > Nonetheless, libbpf is used to generate code, and if the code is
> > generated wrong worst case it can have severe security implications.
> >
> > Thanks
> >
> > Michal
