Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9C16E558C
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 02:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjDRABA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 20:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjDRAA7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 20:00:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244D0198E;
        Mon, 17 Apr 2023 17:00:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-504e232fe47so5329415a12.2;
        Mon, 17 Apr 2023 17:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681776056; x=1684368056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4TMrmpt9Qoluso51XCUMt6W+F45yON2Jsdyjso9IvA=;
        b=j3E4+ypt2T9iplRU68+AIz2LamQzDx4SGKM7ekNasmzRQvYkoaN1Qx+lI1t/ns4rPU
         LRxSN3qCrS/itxwwewJOiYWIocn3oPq4rW0v+PISP0vomWP6iwW/Eh3sSFSwjMGFGL2L
         CKXyg4yC5tnI/jSnKZJUxVHuaO+UOIsFSwanu5XPB40B9iPvu8RmGGQFqbpiKwdbNhvM
         czJ8OS3wzf4gRFWDueUTSaIXW+wSrA1psi8jszZPehGDsTKrQdQbpF/dCEHOK2MOpgGX
         5SRp/QE7fDP35PYM1otDbNoAQNMC2owPR0m8HVWSjsDg49e4IKZuXx0dK6xAy9+84jBD
         8Pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681776056; x=1684368056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4TMrmpt9Qoluso51XCUMt6W+F45yON2Jsdyjso9IvA=;
        b=gE5nSfPN9bYXN+8NcREP361R1JCLQAcGj/D+tC1c9dbAYparrE+Epq9njIF3nrk2NF
         guGhvG911YDH2tec5ZZQa5f4rRPG4GEwe5wDaiicsRCfE6gdD5rh22793z2Ar+07TSls
         Dz6hky5ItCLeoA79mJiGmoGJiAnfsH5SFpaNGjsAZFvp1O0Pu/5wY18TtCIu5y3o9ig5
         9JxLpuaNajT38usADJtKBb4Gjw40Q9i0Pw9MTFbMkcGUbRSqVHCb5KT+ldhqy7ffzQ6V
         O3rU5BT8nUxJ/PR5SaTbpiBvtsZ0IZ5Au4vIAjMYo8FtfCz5gNeI3jmH3ZbVnDHheR0e
         7XVg==
X-Gm-Message-State: AAQBX9d8F3Ndba5wckBqQ1Y/quj65easUTq9mYzHOGDSjwiJjkotF/ot
        4Dp0OaxrI3QfCJ/JtkevTgHYHLVOI2lak4jLdF0=
X-Google-Smtp-Source: AKy350YD2TpjkkwHKzx4Fgjf2UaVH06/42D+QkJwrk/L7u6Ul726cHr4rvdx9VJPHLNG13wvo3mtISMld3S2vt3zexo=
X-Received: by 2002:a50:bb08:0:b0:504:9200:8c88 with SMTP id
 y8-20020a50bb08000000b0050492008c88mr356920ede.1.1681776056429; Mon, 17 Apr
 2023 17:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <ZDfKBPXDQxH8HeX9@syu-laptop> <CACdoK4L5A-qdUyQwVbe-KE+0NBPbgqYC1v0uf0i1U_S7KSnmuw@mail.gmail.com>
In-Reply-To: <CACdoK4L5A-qdUyQwVbe-KE+0NBPbgqYC1v0uf0i1U_S7KSnmuw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 17 Apr 2023 17:00:44 -0700
Message-ID: <CAEf4Bzbxd9VWO2OGVT1XqsVRBXRTZGe5rSzFM=Ef4oUUovZFuA@mail.gmail.com>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Tony Jones <tonyj@suse.de>,
        Michal Suchanek <msuchanek@suse.de>,
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

On Thu, Apr 13, 2023 at 5:35=E2=80=AFPM Quentin Monnet <quentin@isovalent.c=
om> wrote:
>
> Hi Shung-Hsi,
>
> On Thu, 13 Apr 2023 at 10:23, Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> >
> > Hi,
> >
> > I'm considering switch to bpftool's mirror on GitHub for packaging (ins=
tead
> > of using the source found in kernel), but realize that it should goes
> > hand-in-hand with how libbpf is packaged, which eventually leads these
> > questions:
> >
> >   What is the suggested approach for packaging bpftool and libbpf?
> >   Which source is preferred, GitHub or kernel?
>
> As you can see from the previous discussions, the suggested approach
> would be to package from the GitHub mirror, with libbpf and bpftool in
> sync.
>
> My main argument for the mirror is that it keeps things simpler, and
> there's no need to deal with the rest of the kernel sources for these
> packages. Download from the mirrors, build, ship. But then I have
> limited experience at packaging for distros, and I can understand
> Toke's point of view, too. So ultimately, the call is yours.
>
> >   Does bpftool work on older kernel?
>
> It should, although it's not perfect. Most features from current
> bpftool should work as expected on older kernels. However, if I
> remember correctly you would have trouble loading programs on pre-BTF
> kernels, because bpftool relies on libbpf >=3D 1.0 and only accepts map
> definitions with BTF info, and attempts to create these maps with BTF,
> which fails and blocks the load process.

Not really. Libbpf won't upload BTF if the kernel doesn't support it
and it's not required for correct BPF map (e.g., local storage) or BPF
program functioning.

>
> But we're trying to keep backward-compatibility, so if we're only
> talking of kernels recent enough to support BTF, then I'd expect
> bpftool to work. If this is not the case, please report on this list.
>
> >
> > Our current approach is that we (openSUSE/SLES) essentially have two ve=
rsion
> > of libbpf: a public shared library that uses GitHub mirror as source, w=
hich
> > the general userspace sees and links to; and a private static library b=
uilt
> > from kernel source used by bpftool, perf, resolve_btfids, selftests, et=
c.
> > A survey of other distros (Arch, Debian, Fedora, Ubuntu) suggest that t=
hey
> > took similar approach.
>
> I would like them to reconsider this choice eventually. Sounds like
> for RHEL, this will be a tough sell :). At least, I'd love Ubuntu to
> have a real bpftool package instead of having to install
> linux-tools-common + linux-tools-generic, or to have distros in
> general (Ubuntu/Debian at least) stop compiling out the JIT
> disassembler, although this is not strictly related to the location of
> the sources. I've not found the time to reach out to package
> maintainers yet.
>
> >
> > This approach means that the version of bpftool and libbpf are _not_ al=
ways
> > in sync[1], which I read may causes problem since libbpf and bpftool de=
pends
> > on specific version of each other[2].
>
> Whatever source you use, I would strongly recommend finding a way to
> keep both in sync. Libbpf has stabilised its API when reaching 1.0,
> but bpftool taps into some of the internals of the library. Features
> or new definitions are usually added at the same time to libbpf and
> bpftool, and if you get a mismatch between the two, you're taking
> risks to get build issues.
>
> >
> > Using the GitHub mirror of bpftool to package both libbpf and bpftool w=
ould
> > kept their version in sync, and was suggested[3]. Although the same cou=
ld be
> > said if we switch back to packaging libbpf from kernel source, an addit=
ional
> > appeal for using GitHub mirrors is that it decouples bpftool from kerne=
l,
> > making it easily upgradable and with a clearer changelog (the latter is
> > quite important for enterprise users) like libbpf.
>
> Happy to read these changelogs I write are useful to someone :). Yes,
> this is my point.
>
> >
> > The main concern with using GitHub mirror is that bpftool may be update=
d far
> > beyond the version that comes with the runtime kernel. AFAIK bpftool sh=
ould
> > work on older kernel since CO-RE is used for built-in BPF iterators and=
 the
> > underlying libbpf work on older kernel itself. Nonetheless, it would be=
 nice
> > to get a confirmation from the maintainers.
>
> As explained above - Mostly, it should work. Otherwise, we can look
> into fixing it.
>
> As a side note, I'm open to suggestions/contributions to make life
> easier for packaging for the mirror. For example, Mah=C3=A9 and I recentl=
y
> added GitHub workflows to ship statically-built binaries for amd64 and
> arm64 on releases, as well as tarballs with both bpftool+libbpf
> sources. If there's something else to make packaging easier, I'm happy
> to talk about it.

Please contribute this for veristat ([0]) and retsnoop ([1]). I've
been packaging submodule sources for them using a simple script ([2]),
but if this can be automated, that would be awesome. Thanks!

  [0] https://github.com/libbpf/veristat/
  [1] https://github.com/anakryiko/retsnoop/
  [2] https://github.com/anakryiko/retsnoop/blob/master/scripts/archive-src=
s-full.sh

>
> >
> > Are there any other downsides to switching to GitHub mirror for bpftool=
?
>
> Nothing else comes to mind, but again I'm not packaging for distros.

+1.

Libbpf, bpftool, and other libbpf-dependent tools are meant to be
backwards compatible with old kernels as much as possible. Bugs do
happen, but those should be reported and fixed. Otherwise if some
newer feature is requiring a newer kernel, we always try to develop it
in a way that will fail gracefully. So there is no reason to not
switch to Github-based mirrors, for both libbpf and bpftool.

> See Toke's message.
>
> I hope this helps,
> Quentin
