Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF45F6E2827
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 18:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDNQPZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 12:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNQPZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 12:15:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84835188;
        Fri, 14 Apr 2023 09:15:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3940D1FDAC;
        Fri, 14 Apr 2023 16:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681488922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NQr3pcc3xCz9vRhuLlOqvVhOjVzkpREyXxWnCb+3Lwk=;
        b=BbYFdQeE645tCM/hTz0LsfuNffdBFSytxLTswZLXJG8a6iMCWKY8iX8k5bV9V/bG4tWYFu
        tXvqtlsNIUeX5VAjMC0AjlCmKNU16B/kde8nnM6uVAMlBYr3woEwoQOtt/aT8K/YZLXg3k
        4a+nFTY8g2NnQT+HpbfuQGED5lpbXu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681488922;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NQr3pcc3xCz9vRhuLlOqvVhOjVzkpREyXxWnCb+3Lwk=;
        b=nWm+Deb9xph8iZfN9Gy/G7S1rfe+4EA2ENuajUyefuiv5AfhY91wme/yIdWNt1e6tHAhNB
        0OVU4KXyLr1Z0YBg==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 75EE82C143;
        Fri, 14 Apr 2023 16:15:21 +0000 (UTC)
Date:   Fri, 14 Apr 2023 18:15:20 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Tony Jones <tonyj@suse.de>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>,
        Mahe Tardy <mahe.tardy@gmail.com>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
Message-ID: <20230414161520.GJ63923@kunlun.suse.cz>
References: <ZDfKBPXDQxH8HeX9@syu-laptop>
 <CACdoK4L5A-qdUyQwVbe-KE+0NBPbgqYC1v0uf0i1U_S7KSnmuw@mail.gmail.com>
 <20230414095007.GF63923@kunlun.suse.cz>
 <b933fad3-7759-00d4-94cb-f20dd363b794@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b933fad3-7759-00d4-94cb-f20dd363b794@isovalent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 14, 2023 at 01:30:02PM +0100, Quentin Monnet wrote:
> 2023-04-14 11:50 UTC+0200 ~ Michal Suchánek <msuchanek@suse.de>
> > Hello,
> > 
> > On Fri, Apr 14, 2023 at 01:35:20AM +0100, Quentin Monnet wrote:
> >> Hi Shung-Hsi,
> >>
> >> On Thu, 13 Apr 2023 at 10:23, Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> >>>
> >>> Hi,
> >>>
> >>> I'm considering switch to bpftool's mirror on GitHub for packaging (instead
> >>> of using the source found in kernel), but realize that it should goes
> >>> hand-in-hand with how libbpf is packaged, which eventually leads these
> >>> questions:
> >>>
> >>>   What is the suggested approach for packaging bpftool and libbpf?
> >>>   Which source is preferred, GitHub or kernel?
> >>
> >> As you can see from the previous discussions, the suggested approach
> >> would be to package from the GitHub mirror, with libbpf and bpftool in
> >> sync.
> >>
> >> My main argument for the mirror is that it keeps things simpler, and
> >> there's no need to deal with the rest of the kernel sources for these
> >> packages. Download from the mirrors, build, ship. But then I have
> >> limited experience at packaging for distros, and I can understand
> >> Toke's point of view, too. So ultimately, the call is yours.
> > 
> > Things get only ever more complex when submodules are involved.
> 
> I understand the generic pain points from your other email. But could
> you be more specific for the case of bpftool? It's not like we're
> shipping all lib dependencies as submodules. Sync-ups are specifically
> aligned to the same commit used to sync the libbpf mirror, so that it's
> pretty much as if we had the right version of the library shipped in the
> repository - only, it's one --recurse-submodules away.

It's so in every project that uses submodules. Except git does not
recurse into submodules by default, you have to fix it up by hand.
Forges don't support submodules so you will not get the submodule when
downloading the project archive, and won't see it the the project tree.

After previous experience with submodules I did not even try, I just
patched the makefile to use system libbpf before attempting anything
else.

> >>>   Does bpftool work on older kernel?
> >>
> >> It should, although it's not perfect. Most features from current
> >> bpftool should work as expected on older kernels. However, if I
> >> remember correctly you would have trouble loading programs on pre-BTF
> >> kernels, because bpftool relies on libbpf >= 1.0 and only accepts map
> >> definitions with BTF info, and attempts to create these maps with BTF,
> >> which fails and blocks the load process.
> >>
> >> But we're trying to keep backward-compatibility, so if we're only
> >> talking of kernels recent enough to support BTF, then I'd expect
> >> bpftool to work. If this is not the case, please report on this list.
> > 
> > It won't build:
> > https://lore.kernel.org/bpf/20220421003152.339542-3-alobakin@pm.me/
> 
> True in this case, and this is something that needs to get fixed. Thanks
> for reopening that thread! Are you building bpftool on kernels older
> than 5.15? (genuine curiosity)

Yes, 5.14 and 5.3. I would not be able to notice this particular
breakage otherwise.

> >>> Our current approach is that we (openSUSE/SLES) essentially have two version
> >>> of libbpf: a public shared library that uses GitHub mirror as source, which
> >>> the general userspace sees and links to; and a private static library built
> >>> from kernel source used by bpftool, perf, resolve_btfids, selftests, etc.
> >>> A survey of other distros (Arch, Debian, Fedora, Ubuntu) suggest that they
> >>> took similar approach.
> >>
> >> I would like them to reconsider this choice eventually. Sounds like
> >> for RHEL, this will be a tough sell :). At least, I'd love Ubuntu to
> >> have a real bpftool package instead of having to install
> >> linux-tools-common + linux-tools-generic, or to have distros in
> >> general (Ubuntu/Debian at least) stop compiling out the JIT
> >> disassembler, although this is not strictly related to the location of
> >> the sources. I've not found the time to reach out to package
> >> maintainers yet.
> >>
> >>>
> >>> This approach means that the version of bpftool and libbpf are _not_ always
> >>> in sync[1], which I read may causes problem since libbpf and bpftool depends
> >>> on specific version of each other[2].
> >>
> >> Whatever source you use, I would strongly recommend finding a way to
> >> keep both in sync. Libbpf has stabilised its API when reaching 1.0,
> >> but bpftool taps into some of the internals of the library. Features
> >> or new definitions are usually added at the same time to libbpf and
> >> bpftool, and if you get a mismatch between the two, you're taking
> >> risks to get build issues.
> > 
> > In other words no API exists.
> 
> Of course it does. Libbpf exposes a specific set of functions to user
> applications.
> 
> But correct, from bpftool's perspective, there are a few locations where
> we accept to derogate and to access to the internals directly, making it
> more dependent on a specific version, or commit, of libbpf, and blurring
> the notion of API.
> 
> This special relationship is nothing new though, and it has been
> discussed before. It derives from both tools being developed in the same
> repository, and bpftool being so tightly linked to libbpf - it has been
> qualified of command-line interface for libbpf in the past. Bpftool's

If bpftool is a commandline interface for libbpf maybe the best choice
is to just dump both into the same repository, and provide make targets
for building one, the other, and both.

> version number itself is aligned on libbpf's. (As a side note, bpftool
> used to pull libbpf's headers directly from libbpf's dir instead of
> installing them locally, which facilitated this mix-in for
> public/internal headers in the first place.)
> 
> I know you advocated making the required functions part of the API,
> given that some users (such as bpftool) need them. These functions are
> not exposed, by choice. They are not judged relevant to generic user
> space application (I'm sure libbpf's maintainers are opened to
> discussion if use cases come up). Some of the internals we get from
> libbpf are also mostly to avoid re-implementing things, such as netlink
> attributes processing, or implementing hash maps. These have nothing to
> do in libbpf's API.

And we do not have microframeworks for implementing reusable hashmaps or
netlink parsers. I am sure that bpftool is not the first nor last tool
that needs a hashmap or parse netlink but the ecosystem for small
single-purpose C libraries never really took off.

> >>> The main concern with using GitHub mirror is that bpftool may be updated far
> >>> beyond the version that comes with the runtime kernel. AFAIK bpftool should
> >>> work on older kernel since CO-RE is used for built-in BPF iterators and the
> >>> underlying libbpf work on older kernel itself. Nonetheless, it would be nice
> >>> to get a confirmation from the maintainers.
> >>
> >> As explained above - Mostly, it should work. Otherwise, we can look
> >> into fixing it.
> >>
> >> As a side note, I'm open to suggestions/contributions to make life
> >> easier for packaging for the mirror. For example, Mahé and I recently
> >> added GitHub workflows to ship statically-built binaries for amd64 and
> >> arm64 on releases, as well as tarballs with both bpftool+libbpf
> >> sources. If there's something else to make packaging easier, I'm happy
> >> to talk about it.
> > 
> > Make it possible to build with system-installed libbpf. If it's released
> > it should have versioned dependency on a libbpf release, and libbpf from
> > that version on should be good enough to build it.
> > 
> > I tried copying those 'private' headers into a separate directory, and
> > link against static libbpf, and it seems to work. Of course, having
> > an actual API would be much better.
> 
> Just as you said yourself, the missing stability is in the way. I don't
> see this happening as long as bpftool is using libbpf's internals. I do
> expect builds to work most of the time by copying the headers as you
> did, but as soon as something changes and it no longer does, everyone
> will start filing issues on GitHub instead of using the version that
> works, and I don't want that.

So these are not really separate projects, they should ship together.

> As for decoupling from the internal: making the functions part of the
> API is not an option. One option could be to move this code into further
> dependencies shared between libbpf and bpftool - although I guess libbpf
> developers will have little appetite for that. We could also duplicate
> the necessary code in bpftool, which doesn't sound optimal, but might be
> one solution. Other options have been discussed before, such as moving
> bpftool into libbpf's directory/mirror and shipping both together, but
> there was no consensus at the time, and I don't expect libbpf to ship
> with bpftool any time soon.

Why is that? Is there any speciffic reason for the sepaaration if
bpftool needs specific libbpf anyway?

Thanks

Michal
