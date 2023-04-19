Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571FC6E81F6
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 21:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjDSTfi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 15:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjDSTfh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 15:35:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B455B4C25;
        Wed, 19 Apr 2023 12:35:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ud9so1032845ejc.7;
        Wed, 19 Apr 2023 12:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681932934; x=1684524934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yocVYO2TXHAmkPuE1+azUQcGdGaRI5PFQgwLZBpyHP0=;
        b=DZpsFzWFmT9ASFnb08RKM50ZGA17LxwG0TCjBKe1dhWKunfVGekhfA3d1zE7xLpviT
         qz/SdCzHTU6lpxUufC5Zd74qCyQRoVb71klD5IIrBReppqoRbtsXWoWL1G/Iy0bN8bOE
         zwY29R80F5vENMy2TXankG15Yb6kEEFtbVnY5N5R2FY9BIKsjWwbO16oUmXA4vUKbi+h
         8lsGx9ArJf5ve97gfnbRmqvaffhWM2XGf6Wpl99zv343+YnnneYfMrUcqPAJB+D86alN
         2qWHc3CbFoGNW8623DVv3S9Yr+gKlImXIlic1d7tY0EktW6tF/EiB2FsBm0qyVFtv7Jg
         xHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681932934; x=1684524934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yocVYO2TXHAmkPuE1+azUQcGdGaRI5PFQgwLZBpyHP0=;
        b=CUKYktBGhoySsBu6jBJY1nUDN1GTZCrTQ87EI5HywYBq7h6YWp/BAcj8RAciXdA70W
         XjcHCwmIIMf2F35Y8C/y2zi7r8wq0iddF/w3C2RbWcDq310GslTAuajw/bWMuAtZ/TIf
         whvmYtxlyvuKiHgVPCaVyIPK9TAentDGfnDHTyM+JOyv4DuUazTx/zdZ8OY4jESeXRLr
         W+XUyiI3SJx4WyVR/SF+GXkWPqu/k/6aP3gQW7+WzwhvopJKYqXMw0OQk0QhoTkWoUlu
         q796qenCnnolbOU8z6Gt3+Hyw4n53AIaQ1J77v3Gh6A9/NVWBcSfC152p0i+f1ipWtGR
         23Lg==
X-Gm-Message-State: AAQBX9fHJ3aGHpOmciHFGHPOwPAJM0qNTxBwHVHycesL5TyLraBedWvF
        PQceU0SgllS0sr5rK96I2goH/WDLxzAHCCWY8KE=
X-Google-Smtp-Source: AKy350YuFiyFjgvwfJziKhwfHennuClsU9vk4jic2pAWGCrXuAN+kmIC8BjfbJF7x8w1Hq6aQ3ktthwpy33jXAhdm9U=
X-Received: by 2002:a17:906:4f02:b0:94e:f9b:66e7 with SMTP id
 t2-20020a1709064f0200b0094e0f9b66e7mr15474614eju.13.1681932933860; Wed, 19
 Apr 2023 12:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <ZDfKBPXDQxH8HeX9@syu-laptop> <CACdoK4L5A-qdUyQwVbe-KE+0NBPbgqYC1v0uf0i1U_S7KSnmuw@mail.gmail.com>
 <20230414095007.GF63923@kunlun.suse.cz> <b933fad3-7759-00d4-94cb-f20dd363b794@isovalent.com>
 <20230414161520.GJ63923@kunlun.suse.cz> <CAEf4Bzaw6DBHn=S9zKCXTSh7jW8xL9K6bzi1Q-e8j93thi2hmg@mail.gmail.com>
 <20230418112454.GA15906@kitsune.suse.cz> <CAEf4BzZf50fX7T9k47u+9YQrMbSLxLeA1qWwrdWToCZkMhynjg@mail.gmail.com>
 <20230418174132.GE15906@kitsune.suse.cz>
In-Reply-To: <20230418174132.GE15906@kitsune.suse.cz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 19 Apr 2023 12:35:21 -0700
Message-ID: <CAEf4BzbN0-NXgD_S1Ff+4_D-iF3g9eP8jvy31ddqZcM6Oix5ww@mail.gmail.com>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org,
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
        Mahe Tardy <mahe.tardy@gmail.com>
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

On Tue, Apr 18, 2023 at 10:41=E2=80=AFAM Michal Such=C3=A1nek <msuchanek@su=
se.de> wrote:
>
> On Tue, Apr 18, 2023 at 09:38:20AM -0700, Andrii Nakryiko wrote:
> > On Tue, Apr 18, 2023 at 4:24=E2=80=AFAM Michal Such=C3=A1nek <msuchanek=
@suse.de> wrote:
> > >
> > > On Mon, Apr 17, 2023 at 05:20:03PM -0700, Andrii Nakryiko wrote:
> > > > On Fri, Apr 14, 2023 at 9:15=E2=80=AFAM Michal Such=C3=A1nek <msuch=
anek@suse.de> wrote:
> > > > >
> > > > > On Fri, Apr 14, 2023 at 01:30:02PM +0100, Quentin Monnet wrote:
> > > > > > 2023-04-14 11:50 UTC+0200 ~ Michal Such=C3=A1nek <msuchanek@sus=
e.de>
> > > > > > > Hello,
> > > > > > >
> > > > > > > On Fri, Apr 14, 2023 at 01:35:20AM +0100, Quentin Monnet wrot=
e:
> > > > > > >> Hi Shung-Hsi,
> > > > > > >>
> > > > > > >> On Thu, 13 Apr 2023 at 10:23, Shung-Hsi Yu <shung-hsi.yu@sus=
e.com> wrote:
> > > > > > >>>
> > > > > > >>> Hi,
> > > > > > >>>
> > > > > > >>> I'm considering switch to bpftool's mirror on GitHub for pa=
ckaging (instead
> > > > > > >>> of using the source found in kernel), but realize that it s=
hould goes
> > > > > > >>> hand-in-hand with how libbpf is packaged, which eventually =
leads these
> > > > > > >>> questions:
> > > > > > >>>
> > > > > > >>>   What is the suggested approach for packaging bpftool and =
libbpf?
> > > > > > >>>   Which source is preferred, GitHub or kernel?
> > > > > > >>
> > > > > > >> As you can see from the previous discussions, the suggested =
approach
> > > > > > >> would be to package from the GitHub mirror, with libbpf and =
bpftool in
> > > > > > >> sync.
> > > > > > >>
> > > > > > >> My main argument for the mirror is that it keeps things simp=
ler, and
> > > > > > >> there's no need to deal with the rest of the kernel sources =
for these
> > > > > > >> packages. Download from the mirrors, build, ship. But then I=
 have
> > > > > > >> limited experience at packaging for distros, and I can under=
stand
> > > > > > >> Toke's point of view, too. So ultimately, the call is yours.
> > > > > > >
> > > > > > > Things get only ever more complex when submodules are involve=
d.
> > > > > >
> > > > > > I understand the generic pain points from your other email. But=
 could
> > > > > > you be more specific for the case of bpftool? It's not like we'=
re
> > > > > > shipping all lib dependencies as submodules. Sync-ups are speci=
fically
> > > > > > aligned to the same commit used to sync the libbpf mirror, so t=
hat it's
> > > > > > pretty much as if we had the right version of the library shipp=
ed in the
> > > > > > repository - only, it's one --recurse-submodules away.
> > > > >
> > > > > It's so in every project that uses submodules. Except git does no=
t
> > > > > recurse into submodules by default, you have to fix it up by hand=
.
> > > > > Forges don't support submodules so you will not get the submodule=
 when
> > > > > downloading the project archive, and won't see it the the project=
 tree.
> > > >
> > > > git submodule update --init --recursive didn't work?
> > >
> > > That's one part of the manual fixup.
> > >
> > > The other part is after each git operation that could possibly cause =
the
> > > submodules to go out of sync, basically any operation that changes th=
e
> > > checked-out commit.
> > >
> > > Of course, you can make some shell aliases that append whatever submo=
dule
> > > chicanery to whatever git command you might issue, and tell everyone
> > > else to do that, and then it will work in that one shell, and not in =
any
> > > other shell nor any tool that invokes git directly.
> >
> > Are we discussing a *standard* Git submodule feature and argue that
> > because it might be cumbersome or unfamiliar to some engineers that
> > projects should avoid using Git submodules?
>
> As far as I am aware they are unfamiliar to *most* engineers, and for
> good reasons.
>
> > For one, I don't have any special aliases for dealing with Git
> > submodules and it works fine. If I jump between branches or tags which
> > update Git submodule reference, I do above `git submodule update
> > --init --recursive` explicitly if I see that Git status shows
> > out-of-sync Git submodule state. If I want to update a Git submodule,
> > I update the submodule's Git repo, and then git add it in the repo
> > that uses this submodule. I haven't run into any other issues with
> > this.
>
> You know, git could just handle submodules automagically. As you say,
> it's not rocket science. For historical reasons it does not.
>
> With that working with submodules is cumbersome, and it's additional
> thing that can break down that the engineer needs to be constantly aware
> of increasing the mental overhead of working with such projects.
>
> It may not be much of a problem for people who work with such projects
> daily but not everyone does. Those who don't need to do the mental
> switch whenever submodules are encountered, and are prone to getting
> issues when they forget that they have to go that extra mile for this
> specific project.

I agree with you that Git submodules are not the most straightforward
feature usability-wise. Where I disagree is that this is enough reason
to not use Git submodules. They do provide a lot of value.

>
> > > > > After previous experience with submodules I did not even try, I j=
ust
> > > > > patched the makefile to use system libbpf before attempting anyth=
ing
> > > > > else.
> > > >
> > > > Quentin mentioned that he's packaging (or will package) libbpf sour=
ces
> > > > as part of bpftool release on Github. I've been this for other
> > > > libbpf-using tools as well, and it works pretty well (at least for
> > > > Fedora and ArchLinux). E.g., srcs-full-* archives for veristat ([0]=
)
> > > >
> > > > By switching up actual libbpf used to compile with bpftool, you are
> > > > potentially introducing subtle problems that your users will be qui=
te
> > > > unhappy about, if they run into them. Let's work together to make i=
t
> > > > easier for you to package bpftool properly. We can't switch bpftool=
 to
> > > > reliably use system-wide libbpf (either static or shared, doesn't
> > > > matter) because of dependency on internal functionality.
> > > >
> > > >
> > > >   [0] https://github.com/libbpf/veristat/releases/tag/v0.1
> > >
> > > So how many copies of libbpf do I need for having a CO-RE toolchain?
> >
> > What do you mean by "CO-RE toolchain"? bpftool, veristat, retsnoop,
> > etc are tools. The fact they are using statically linked libbpf
> > through Git submodule is irrelevant to end users. You need one libbpf
> > in the system (for those who link dynamically against libbpf), the
> > rest are just tools.
> >
> > >
> > > Will different tools have different view of the kernel because they e=
ach
> > > use different private copy of libbpf with different features?
> >
> > That's up to tools, not libbpf. You are over pivoting on libbpf here.
> > There is one view of the kernel, it depends on what features the
> > kernel supports. If the tool requires some specific functionality of
> > libbpf, it will update its Git submodule reference to get a version of
> > libbpf that provides that feature. That's the point, an
> > application/tool is in control of what kind of features it gets from
> > libbpf.
> >
> > >
> > > When there is a bug in libbpf how many places need to be patched to f=
ix
> > > it?
> >
> > That's up to tools, again. If the bug is affecting them, they should
> > cut a new version of their *tool*, using a patched version of libbpf
> > from Github. If it doesn't affect them, then it doesn't matter *to
> > them*.
>
> I don't share your optimism about this happening in the real world.
>
> For one the issue that the github tarballs do not contain the submodule
> and thus cannot be built was raised nearly two months ago, and while a
> test snapshot that does include the submodule is released, a release
> does not exist yet.

Because no one raised this issue earlier (for bpftool). Fedora
packagers raised it for retsnoop, so retsnoop has it. That's how
development works, one can't anticipate all the possible issues, they
need to be reported and worked on.

>
> For people to make use of the repository without a release cut they need
> to replicate that submodule support - that is add support for submodules
> in their development tooling. Otherwise you personally cutting a release
> becomes a single point of failure.

I hope distros won't be packaging an unreleased version, though?

>
> Because there is no API it's not really advisable to just apply patches
> on top of the last release either. Applying patches may cause the main
> project and the submodule to go out of sync, the submodule would not get
> updated by applying a patch to the main project, and the other way
> around.

I'm not sure where we are going with this overall discussion at this point,=
 tbh.

>
> Suppose a severe security bug that requires patching libbpf is found.
> Now there is a number of tools that are each tied to one specific
> version of libbpf, and cannot be upgraded to up-to-date fixed version
> because that would break them. I would hope that never happens.
> Nonetheless, libbpf is used to generate code, and if the code is
> generated wrong worst case it can have severe security implications.
>

Yes, I hear this argument from packagers all the time. Yet, somehow
it's been fine for the last few years. Please realize that there are
many reasons why we do want submodules and static linking of libbpf,
and accept that projects do decide to stick to submodules. It might
not be perfect, but the benefits of such an approach outweigh the
hypothetical issues you brought up.

This has all been discussed multiple times, as I said, I don't think
any of us added anything new to previous discussions. So if you are
interested, please work with us to improve your life as a packager,
but also accept the way this project is set up on Github.

> Thanks
>
> Michal
