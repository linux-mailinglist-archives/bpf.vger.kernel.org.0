Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D2B6E1FBA
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 11:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjDNJuM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 05:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjDNJuM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 05:50:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0955FD3;
        Fri, 14 Apr 2023 02:50:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E0A5C1FD93;
        Fri, 14 Apr 2023 09:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681465808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4+DxuhQaSafHmB0fnTETPui1QWhu4dvKLY9o0ZuxF1E=;
        b=n6qxxvSTWZuBBKfPup45D5i3TFHuFyR5VcGgIRmoT3/L5uNpnEuoR+076GHIHgDoTKLD69
        6RjsTfYOSNkS5g2ELbgoJnA3pnaWBoPBFkbvSUr9jwXlugkeAAp06j9a3+u00W2NsS0p7u
        yhsohI/Ba+/dnaQ1p/fm9vqScf/52VU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681465808;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4+DxuhQaSafHmB0fnTETPui1QWhu4dvKLY9o0ZuxF1E=;
        b=3GuUFBpfm4beD6p9zjYmB4muj6M66sUy4pHawP4F/fgLWcpIc04ot/L9dzSUeNAv2dYYni
        8NBhUAylDhMqJqAQ==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5A70B2C143;
        Fri, 14 Apr 2023 09:50:08 +0000 (UTC)
Date:   Fri, 14 Apr 2023 11:50:07 +0200
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
Message-ID: <20230414095007.GF63923@kunlun.suse.cz>
References: <ZDfKBPXDQxH8HeX9@syu-laptop>
 <CACdoK4L5A-qdUyQwVbe-KE+0NBPbgqYC1v0uf0i1U_S7KSnmuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACdoK4L5A-qdUyQwVbe-KE+0NBPbgqYC1v0uf0i1U_S7KSnmuw@mail.gmail.com>
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

Hello,

On Fri, Apr 14, 2023 at 01:35:20AM +0100, Quentin Monnet wrote:
> Hi Shung-Hsi,
> 
> On Thu, 13 Apr 2023 at 10:23, Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> >
> > Hi,
> >
> > I'm considering switch to bpftool's mirror on GitHub for packaging (instead
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

Things get only ever more complex when submodules are involved.

> >   Does bpftool work on older kernel?
> 
> It should, although it's not perfect. Most features from current
> bpftool should work as expected on older kernels. However, if I
> remember correctly you would have trouble loading programs on pre-BTF
> kernels, because bpftool relies on libbpf >= 1.0 and only accepts map
> definitions with BTF info, and attempts to create these maps with BTF,
> which fails and blocks the load process.
> 
> But we're trying to keep backward-compatibility, so if we're only
> talking of kernels recent enough to support BTF, then I'd expect
> bpftool to work. If this is not the case, please report on this list.

It won't build:
https://lore.kernel.org/bpf/20220421003152.339542-3-alobakin@pm.me/

> > Our current approach is that we (openSUSE/SLES) essentially have two version
> > of libbpf: a public shared library that uses GitHub mirror as source, which
> > the general userspace sees and links to; and a private static library built
> > from kernel source used by bpftool, perf, resolve_btfids, selftests, etc.
> > A survey of other distros (Arch, Debian, Fedora, Ubuntu) suggest that they
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
> > This approach means that the version of bpftool and libbpf are _not_ always
> > in sync[1], which I read may causes problem since libbpf and bpftool depends
> > on specific version of each other[2].
> 
> Whatever source you use, I would strongly recommend finding a way to
> keep both in sync. Libbpf has stabilised its API when reaching 1.0,
> but bpftool taps into some of the internals of the library. Features
> or new definitions are usually added at the same time to libbpf and
> bpftool, and if you get a mismatch between the two, you're taking
> risks to get build issues.

In other words no API exists.

> > Using the GitHub mirror of bpftool to package both libbpf and bpftool would
> > kept their version in sync, and was suggested[3]. Although the same could be
> > said if we switch back to packaging libbpf from kernel source, an additional
> > appeal for using GitHub mirrors is that it decouples bpftool from kernel,
> > making it easily upgradable and with a clearer changelog (the latter is
> > quite important for enterprise users) like libbpf.
> 
> Happy to read these changelogs I write are useful to someone :). Yes,
> this is my point.

Yes, publishing the changelog in a usable way relieves others of the
need to write thier own, usually with less understanding of the changes
in question. That's generally the idea of opensource - not endlessly
repeating what has already been done :)

> > The main concern with using GitHub mirror is that bpftool may be updated far
> > beyond the version that comes with the runtime kernel. AFAIK bpftool should
> > work on older kernel since CO-RE is used for built-in BPF iterators and the
> > underlying libbpf work on older kernel itself. Nonetheless, it would be nice
> > to get a confirmation from the maintainers.
> 
> As explained above - Mostly, it should work. Otherwise, we can look
> into fixing it.
> 
> As a side note, I'm open to suggestions/contributions to make life
> easier for packaging for the mirror. For example, Mahé and I recently
> added GitHub workflows to ship statically-built binaries for amd64 and
> arm64 on releases, as well as tarballs with both bpftool+libbpf
> sources. If there's something else to make packaging easier, I'm happy
> to talk about it.

Make it possible to build with system-installed libbpf. If it's released
it should have versioned dependency on a libbpf release, and libbpf from
that version on should be good enough to build it.

I tried copying those 'private' headers into a separate directory, and
link against static libbpf, and it seems to work. Of course, having
an actual API would be much better.

Thanks

Michal
