Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221996E55AD
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 02:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjDRAUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 20:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDRAUT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 20:20:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DF53AB3;
        Mon, 17 Apr 2023 17:20:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fy21so25789923ejb.9;
        Mon, 17 Apr 2023 17:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681777216; x=1684369216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVC6/jCCxTExzUCln9j4tkKXKwBDg1tiD0MMR3Xnd4A=;
        b=nL7gaGcFcfYvx7XJuz86iMuGzxW69/QIeasqnkfjDmUsgtAuJ6bY7pU+t0MRQLPVnO
         I5WDbr7G7nbVHs12dVITyM0YEaZrsD1weYnpqb0cLVmC6uzBf0ZgTUKy3Z3FIfF9Alp/
         JgoGEbVEHRhAgiFmpOm9aq76rBZJtCG54g9lhKLbhI8zFkiUceKjsA8zQhHk9Sv/qIT1
         mdWXnSPsjRowowqDfiIv9Lq38ati9ClXPnFShlJGchYPQPwGCmEtcAgjiAObSlG3qn7e
         IUtqwRUw0THQboavl89lDNBtGVlBAS5LXjoofA6EnbgbMDmCiYfuTLUs2ZpYsLBP+Xie
         SCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681777216; x=1684369216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVC6/jCCxTExzUCln9j4tkKXKwBDg1tiD0MMR3Xnd4A=;
        b=ITrU1Vfv0C1Oa0mNmVRPBjsiQzqVT+InRePB0+UYjTFSqNONqYpHbN10qrxTTrNm4Z
         GQosT56udV5vcfaA5t0RFaZglUrYfvSxx7m+Q/ZXaC2IUNRzhMsWr/Crx4U6gjFEfKCG
         UrwdHejqlDnUJByvXVudUhH6V86fpZxJMqb5lWpt9aycwbngVsWgpA/rCkm4AROTNFlJ
         6VGheA7y8x8H5VTIfuyafXhXLU9ws39EVcEKkPj2fSUBMcUnY/l7d4oPUVzVgDYd49Ii
         GVfitxlealAviXckuTknIWdnv+VZd/S13gSe+HD3dYaQA4/MwjD/AG2VJrTyhDENQBVx
         TTsg==
X-Gm-Message-State: AAQBX9f5OpfwQi2F8dWMsD+FBOTj7XcjwsLERI6A2af1sSXLtn4RfE83
        6m+ds3L7CZzlsSvJxfMLnMo64hbuML4BHV3OSlA=
X-Google-Smtp-Source: AKy350bT+8645PkiGO5jlr236pQGQKSYFZbx+3Hoy35S0cyUyARSOhzZb3LC07+XnlOCRY2y1LTS88e1JPLrVTW2Zh4=
X-Received: by 2002:a17:906:b817:b0:94a:7c21:6ade with SMTP id
 dv23-20020a170906b81700b0094a7c216ademr3631486ejb.5.1681777215959; Mon, 17
 Apr 2023 17:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <ZDfKBPXDQxH8HeX9@syu-laptop> <CACdoK4L5A-qdUyQwVbe-KE+0NBPbgqYC1v0uf0i1U_S7KSnmuw@mail.gmail.com>
 <20230414095007.GF63923@kunlun.suse.cz> <b933fad3-7759-00d4-94cb-f20dd363b794@isovalent.com>
 <20230414161520.GJ63923@kunlun.suse.cz>
In-Reply-To: <20230414161520.GJ63923@kunlun.suse.cz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 17 Apr 2023 17:20:03 -0700
Message-ID: <CAEf4Bzaw6DBHn=S9zKCXTSh7jW8xL9K6bzi1Q-e8j93thi2hmg@mail.gmail.com>
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

On Fri, Apr 14, 2023 at 9:15=E2=80=AFAM Michal Such=C3=A1nek <msuchanek@sus=
e.de> wrote:
>
> On Fri, Apr 14, 2023 at 01:30:02PM +0100, Quentin Monnet wrote:
> > 2023-04-14 11:50 UTC+0200 ~ Michal Such=C3=A1nek <msuchanek@suse.de>
> > > Hello,
> > >
> > > On Fri, Apr 14, 2023 at 01:35:20AM +0100, Quentin Monnet wrote:
> > >> Hi Shung-Hsi,
> > >>
> > >> On Thu, 13 Apr 2023 at 10:23, Shung-Hsi Yu <shung-hsi.yu@suse.com> w=
rote:
> > >>>
> > >>> Hi,
> > >>>
> > >>> I'm considering switch to bpftool's mirror on GitHub for packaging =
(instead
> > >>> of using the source found in kernel), but realize that it should go=
es
> > >>> hand-in-hand with how libbpf is packaged, which eventually leads th=
ese
> > >>> questions:
> > >>>
> > >>>   What is the suggested approach for packaging bpftool and libbpf?
> > >>>   Which source is preferred, GitHub or kernel?
> > >>
> > >> As you can see from the previous discussions, the suggested approach
> > >> would be to package from the GitHub mirror, with libbpf and bpftool =
in
> > >> sync.
> > >>
> > >> My main argument for the mirror is that it keeps things simpler, and
> > >> there's no need to deal with the rest of the kernel sources for thes=
e
> > >> packages. Download from the mirrors, build, ship. But then I have
> > >> limited experience at packaging for distros, and I can understand
> > >> Toke's point of view, too. So ultimately, the call is yours.
> > >
> > > Things get only ever more complex when submodules are involved.
> >
> > I understand the generic pain points from your other email. But could
> > you be more specific for the case of bpftool? It's not like we're
> > shipping all lib dependencies as submodules. Sync-ups are specifically
> > aligned to the same commit used to sync the libbpf mirror, so that it's
> > pretty much as if we had the right version of the library shipped in th=
e
> > repository - only, it's one --recurse-submodules away.
>
> It's so in every project that uses submodules. Except git does not
> recurse into submodules by default, you have to fix it up by hand.
> Forges don't support submodules so you will not get the submodule when
> downloading the project archive, and won't see it the the project tree.

git submodule update --init --recursive didn't work?

>
> After previous experience with submodules I did not even try, I just
> patched the makefile to use system libbpf before attempting anything
> else.

Quentin mentioned that he's packaging (or will package) libbpf sources
as part of bpftool release on Github. I've been this for other
libbpf-using tools as well, and it works pretty well (at least for
Fedora and ArchLinux). E.g., srcs-full-* archives for veristat ([0])

By switching up actual libbpf used to compile with bpftool, you are
potentially introducing subtle problems that your users will be quite
unhappy about, if they run into them. Let's work together to make it
easier for you to package bpftool properly. We can't switch bpftool to
reliably use system-wide libbpf (either static or shared, doesn't
matter) because of dependency on internal functionality.


  [0] https://github.com/libbpf/veristat/releases/tag/v0.1

>
> > >>>   Does bpftool work on older kernel?
> > >>
> > >> It should, although it's not perfect. Most features from current
> > >> bpftool should work as expected on older kernels. However, if I
> > >> remember correctly you would have trouble loading programs on pre-BT=
F
> > >> kernels, because bpftool relies on libbpf >=3D 1.0 and only accepts =
map
> > >> definitions with BTF info, and attempts to create these maps with BT=
F,
> > >> which fails and blocks the load process.
> > >>
> > >> But we're trying to keep backward-compatibility, so if we're only
> > >> talking of kernels recent enough to support BTF, then I'd expect
> > >> bpftool to work. If this is not the case, please report on this list=
.
> > >
> > > It won't build:
> > > https://lore.kernel.org/bpf/20220421003152.339542-3-alobakin@pm.me/
> >
> > True in this case, and this is something that needs to get fixed. Thank=
s
> > for reopening that thread! Are you building bpftool on kernels older
> > than 5.15? (genuine curiosity)
>
> Yes, 5.14 and 5.3. I would not be able to notice this particular
> breakage otherwise.
>
> > >>> Our current approach is that we (openSUSE/SLES) essentially have tw=
o version
> > >>> of libbpf: a public shared library that uses GitHub mirror as sourc=
e, which
> > >>> the general userspace sees and links to; and a private static libra=
ry built
> > >>> from kernel source used by bpftool, perf, resolve_btfids, selftests=
, etc.
> > >>> A survey of other distros (Arch, Debian, Fedora, Ubuntu) suggest th=
at they
> > >>> took similar approach.
> > >>
> > >> I would like them to reconsider this choice eventually. Sounds like
> > >> for RHEL, this will be a tough sell :). At least, I'd love Ubuntu to
> > >> have a real bpftool package instead of having to install
> > >> linux-tools-common + linux-tools-generic, or to have distros in
> > >> general (Ubuntu/Debian at least) stop compiling out the JIT
> > >> disassembler, although this is not strictly related to the location =
of
> > >> the sources. I've not found the time to reach out to package
> > >> maintainers yet.
> > >>
> > >>>
> > >>> This approach means that the version of bpftool and libbpf are _not=
_ always
> > >>> in sync[1], which I read may causes problem since libbpf and bpftoo=
l depends
> > >>> on specific version of each other[2].
> > >>
> > >> Whatever source you use, I would strongly recommend finding a way to
> > >> keep both in sync. Libbpf has stabilised its API when reaching 1.0,
> > >> but bpftool taps into some of the internals of the library. Features
> > >> or new definitions are usually added at the same time to libbpf and
> > >> bpftool, and if you get a mismatch between the two, you're taking
> > >> risks to get build issues.
> > >
> > > In other words no API exists.
> >
> > Of course it does. Libbpf exposes a specific set of functions to user
> > applications.
> >
> > But correct, from bpftool's perspective, there are a few locations wher=
e
> > we accept to derogate and to access to the internals directly, making i=
t
> > more dependent on a specific version, or commit, of libbpf, and blurrin=
g
> > the notion of API.
> >
> > This special relationship is nothing new though, and it has been
> > discussed before. It derives from both tools being developed in the sam=
e
> > repository, and bpftool being so tightly linked to libbpf - it has been
> > qualified of command-line interface for libbpf in the past. Bpftool's
>
> If bpftool is a commandline interface for libbpf maybe the best choice
> is to just dump both into the same repository, and provide make targets
> for building one, the other, and both.

bpftool is way more than just an interface to libbpf, so it doesn't
make sense to bundle them in one repo. Yes, we take advantage of them
being developed together to give it more and better features, which
otherwise we probably just wouldn't add to either libbpf or bpftool
(like BTFgen, for example).

This whole submodule vs shared library has been discussed so many
times. We are open to making your life easier as a packager where
possible, if you can be specific about the issues that are hurting
you. But this relationship between bpftool and libbpf and use of
internal APIs was a conscious decision and it has its big benefits,
which definitely outweigh git submodule inconvenience. We are not
changing it, it's pretty fundamental for bpftool.

>
> > version number itself is aligned on libbpf's. (As a side note, bpftool
> > used to pull libbpf's headers directly from libbpf's dir instead of
> > installing them locally, which facilitated this mix-in for
> > public/internal headers in the first place.)
> >
> > I know you advocated making the required functions part of the API,
> > given that some users (such as bpftool) need them. These functions are
> > not exposed, by choice. They are not judged relevant to generic user
> > space application (I'm sure libbpf's maintainers are opened to
> > discussion if use cases come up). Some of the internals we get from
> > libbpf are also mostly to avoid re-implementing things, such as netlink
> > attributes processing, or implementing hash maps. These have nothing to
> > do in libbpf's API.
>
> And we do not have microframeworks for implementing reusable hashmaps or
> netlink parsers. I am sure that bpftool is not the first nor last tool
> that needs a hashmap or parse netlink but the ecosystem for small
> single-purpose C libraries never really took off.
>
> > >>> The main concern with using GitHub mirror is that bpftool may be up=
dated far
> > >>> beyond the version that comes with the runtime kernel. AFAIK bpftoo=
l should
> > >>> work on older kernel since CO-RE is used for built-in BPF iterators=
 and the
> > >>> underlying libbpf work on older kernel itself. Nonetheless, it woul=
d be nice
> > >>> to get a confirmation from the maintainers.
> > >>
> > >> As explained above - Mostly, it should work. Otherwise, we can look
> > >> into fixing it.
> > >>
> > >> As a side note, I'm open to suggestions/contributions to make life
> > >> easier for packaging for the mirror. For example, Mah=C3=A9 and I re=
cently
> > >> added GitHub workflows to ship statically-built binaries for amd64 a=
nd
> > >> arm64 on releases, as well as tarballs with both bpftool+libbpf
> > >> sources. If there's something else to make packaging easier, I'm hap=
py
> > >> to talk about it.
> > >
> > > Make it possible to build with system-installed libbpf. If it's relea=
sed
> > > it should have versioned dependency on a libbpf release, and libbpf f=
rom
> > > that version on should be good enough to build it.
> > >
> > > I tried copying those 'private' headers into a separate directory, an=
d
> > > link against static libbpf, and it seems to work. Of course, having
> > > an actual API would be much better.
> >
> > Just as you said yourself, the missing stability is in the way. I don't
> > see this happening as long as bpftool is using libbpf's internals. I do
> > expect builds to work most of the time by copying the headers as you
> > did, but as soon as something changes and it no longer does, everyone
> > will start filing issues on GitHub instead of using the version that
> > works, and I don't want that.
>
> So these are not really separate projects, they should ship together.
>
> > As for decoupling from the internal: making the functions part of the
> > API is not an option. One option could be to move this code into furthe=
r
> > dependencies shared between libbpf and bpftool - although I guess libbp=
f
> > developers will have little appetite for that. We could also duplicate
> > the necessary code in bpftool, which doesn't sound optimal, but might b=
e
> > one solution. Other options have been discussed before, such as moving
> > bpftool into libbpf's directory/mirror and shipping both together, but
> > there was no consensus at the time, and I don't expect libbpf to ship
> > with bpftool any time soon.
>
> Why is that? Is there any speciffic reason for the sepaaration if
> bpftool needs specific libbpf anyway?
>
> Thanks
>
> Michal
