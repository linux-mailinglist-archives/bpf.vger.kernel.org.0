Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8988E6E6B3A
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 19:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjDRRlp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 13:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjDRRlh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 13:41:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D88098;
        Tue, 18 Apr 2023 10:41:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0BA131FD66;
        Tue, 18 Apr 2023 17:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681839694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3eb2SP3L7M38kUUWL5AITsqgXvmwqZe8rBRx8YrgY/U=;
        b=z1yIM92/K1Pg/ZO7Lu+MLuqx8gRzn/zDluMyevc8o2o7vRJTz8fU6MgcxEUSP079BSHnbm
        vonGamxmYO1l1pqOt5e/Xc4tsnYBp+5Dy7ssVpCKldrYluapH0xk6Qanm71CCJU3G7kkIa
        m8hyjIzbNrNsgQQp+586V4wTv6ML5tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681839694;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3eb2SP3L7M38kUUWL5AITsqgXvmwqZe8rBRx8YrgY/U=;
        b=sIdTMAcLDsEnYu3x4t1PMOV1SA4QjmLP9YhcXlhGAjgGl4BV5ZRSKxFwXdj5mcqn1Grair
        7TXuYp9SxiKxVwBA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 42B142C141;
        Tue, 18 Apr 2023 17:41:33 +0000 (UTC)
Date:   Tue, 18 Apr 2023 19:41:32 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org,
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
Message-ID: <20230418174132.GE15906@kitsune.suse.cz>
References: <ZDfKBPXDQxH8HeX9@syu-laptop>
 <CACdoK4L5A-qdUyQwVbe-KE+0NBPbgqYC1v0uf0i1U_S7KSnmuw@mail.gmail.com>
 <20230414095007.GF63923@kunlun.suse.cz>
 <b933fad3-7759-00d4-94cb-f20dd363b794@isovalent.com>
 <20230414161520.GJ63923@kunlun.suse.cz>
 <CAEf4Bzaw6DBHn=S9zKCXTSh7jW8xL9K6bzi1Q-e8j93thi2hmg@mail.gmail.com>
 <20230418112454.GA15906@kitsune.suse.cz>
 <CAEf4BzZf50fX7T9k47u+9YQrMbSLxLeA1qWwrdWToCZkMhynjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZf50fX7T9k47u+9YQrMbSLxLeA1qWwrdWToCZkMhynjg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 18, 2023 at 09:38:20AM -0700, Andrii Nakryiko wrote:
> On Tue, Apr 18, 2023 at 4:24 AM Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > On Mon, Apr 17, 2023 at 05:20:03PM -0700, Andrii Nakryiko wrote:
> > > On Fri, Apr 14, 2023 at 9:15 AM Michal Suchánek <msuchanek@suse.de> wrote:
> > > >
> > > > On Fri, Apr 14, 2023 at 01:30:02PM +0100, Quentin Monnet wrote:
> > > > > 2023-04-14 11:50 UTC+0200 ~ Michal Suchánek <msuchanek@suse.de>
> > > > > > Hello,
> > > > > >
> > > > > > On Fri, Apr 14, 2023 at 01:35:20AM +0100, Quentin Monnet wrote:
> > > > > >> Hi Shung-Hsi,
> > > > > >>
> > > > > >> On Thu, 13 Apr 2023 at 10:23, Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > > > > >>>
> > > > > >>> Hi,
> > > > > >>>
> > > > > >>> I'm considering switch to bpftool's mirror on GitHub for packaging (instead
> > > > > >>> of using the source found in kernel), but realize that it should goes
> > > > > >>> hand-in-hand with how libbpf is packaged, which eventually leads these
> > > > > >>> questions:
> > > > > >>>
> > > > > >>>   What is the suggested approach for packaging bpftool and libbpf?
> > > > > >>>   Which source is preferred, GitHub or kernel?
> > > > > >>
> > > > > >> As you can see from the previous discussions, the suggested approach
> > > > > >> would be to package from the GitHub mirror, with libbpf and bpftool in
> > > > > >> sync.
> > > > > >>
> > > > > >> My main argument for the mirror is that it keeps things simpler, and
> > > > > >> there's no need to deal with the rest of the kernel sources for these
> > > > > >> packages. Download from the mirrors, build, ship. But then I have
> > > > > >> limited experience at packaging for distros, and I can understand
> > > > > >> Toke's point of view, too. So ultimately, the call is yours.
> > > > > >
> > > > > > Things get only ever more complex when submodules are involved.
> > > > >
> > > > > I understand the generic pain points from your other email. But could
> > > > > you be more specific for the case of bpftool? It's not like we're
> > > > > shipping all lib dependencies as submodules. Sync-ups are specifically
> > > > > aligned to the same commit used to sync the libbpf mirror, so that it's
> > > > > pretty much as if we had the right version of the library shipped in the
> > > > > repository - only, it's one --recurse-submodules away.
> > > >
> > > > It's so in every project that uses submodules. Except git does not
> > > > recurse into submodules by default, you have to fix it up by hand.
> > > > Forges don't support submodules so you will not get the submodule when
> > > > downloading the project archive, and won't see it the the project tree.
> > >
> > > git submodule update --init --recursive didn't work?
> >
> > That's one part of the manual fixup.
> >
> > The other part is after each git operation that could possibly cause the
> > submodules to go out of sync, basically any operation that changes the
> > checked-out commit.
> >
> > Of course, you can make some shell aliases that append whatever submodule
> > chicanery to whatever git command you might issue, and tell everyone
> > else to do that, and then it will work in that one shell, and not in any
> > other shell nor any tool that invokes git directly.
> 
> Are we discussing a *standard* Git submodule feature and argue that
> because it might be cumbersome or unfamiliar to some engineers that
> projects should avoid using Git submodules?

As far as I am aware they are unfamiliar to *most* engineers, and for
good reasons.

> For one, I don't have any special aliases for dealing with Git
> submodules and it works fine. If I jump between branches or tags which
> update Git submodule reference, I do above `git submodule update
> --init --recursive` explicitly if I see that Git status shows
> out-of-sync Git submodule state. If I want to update a Git submodule,
> I update the submodule's Git repo, and then git add it in the repo
> that uses this submodule. I haven't run into any other issues with
> this.

You know, git could just handle submodules automagically. As you say,
it's not rocket science. For historical reasons it does not.

With that working with submodules is cumbersome, and it's additional
thing that can break down that the engineer needs to be constantly aware
of increasing the mental overhead of working with such projects.

It may not be much of a problem for people who work with such projects
daily but not everyone does. Those who don't need to do the mental
switch whenever submodules are encountered, and are prone to getting
issues when they forget that they have to go that extra mile for this
specific project.

> > > > After previous experience with submodules I did not even try, I just
> > > > patched the makefile to use system libbpf before attempting anything
> > > > else.
> > >
> > > Quentin mentioned that he's packaging (or will package) libbpf sources
> > > as part of bpftool release on Github. I've been this for other
> > > libbpf-using tools as well, and it works pretty well (at least for
> > > Fedora and ArchLinux). E.g., srcs-full-* archives for veristat ([0])
> > >
> > > By switching up actual libbpf used to compile with bpftool, you are
> > > potentially introducing subtle problems that your users will be quite
> > > unhappy about, if they run into them. Let's work together to make it
> > > easier for you to package bpftool properly. We can't switch bpftool to
> > > reliably use system-wide libbpf (either static or shared, doesn't
> > > matter) because of dependency on internal functionality.
> > >
> > >
> > >   [0] https://github.com/libbpf/veristat/releases/tag/v0.1
> >
> > So how many copies of libbpf do I need for having a CO-RE toolchain?
> 
> What do you mean by "CO-RE toolchain"? bpftool, veristat, retsnoop,
> etc are tools. The fact they are using statically linked libbpf
> through Git submodule is irrelevant to end users. You need one libbpf
> in the system (for those who link dynamically against libbpf), the
> rest are just tools.
> 
> >
> > Will different tools have different view of the kernel because they each
> > use different private copy of libbpf with different features?
> 
> That's up to tools, not libbpf. You are over pivoting on libbpf here.
> There is one view of the kernel, it depends on what features the
> kernel supports. If the tool requires some specific functionality of
> libbpf, it will update its Git submodule reference to get a version of
> libbpf that provides that feature. That's the point, an
> application/tool is in control of what kind of features it gets from
> libbpf.
> 
> >
> > When there is a bug in libbpf how many places need to be patched to fix
> > it?
> 
> That's up to tools, again. If the bug is affecting them, they should
> cut a new version of their *tool*, using a patched version of libbpf
> from Github. If it doesn't affect them, then it doesn't matter *to
> them*.

I don't share your optimism about this happening in the real world.

For one the issue that the github tarballs do not contain the submodule
and thus cannot be built was raised nearly two months ago, and while a
test snapshot that does include the submodule is released, a release
does not exist yet.

For people to make use of the repository without a release cut they need
to replicate that submodule support - that is add support for submodules
in their development tooling. Otherwise you personally cutting a release
becomes a single point of failure.

Because there is no API it's not really advisable to just apply patches
on top of the last release either. Applying patches may cause the main
project and the submodule to go out of sync, the submodule would not get
updated by applying a patch to the main project, and the other way
around.

Suppose a severe security bug that requires patching libbpf is found.
Now there is a number of tools that are each tied to one specific
version of libbpf, and cannot be upgraded to up-to-date fixed version
because that would break them. I would hope that never happens.
Nonetheless, libbpf is used to generate code, and if the code is
generated wrong worst case it can have severe security implications.

Thanks

Michal
