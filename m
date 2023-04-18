Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D756E5FC6
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 13:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjDRLZD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 07:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjDRLY7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 07:24:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936F926AD;
        Tue, 18 Apr 2023 04:24:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 37FFB21AA0;
        Tue, 18 Apr 2023 11:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681817096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MdkJCV7f5Ac2ntduoTetXVXp/PQMi+c9C0tNoVNScKY=;
        b=qAytfKf7MNDvMoILZXRngYNjDobpfljf5QN4LygD49uIGtNUx904Bib6uRCBvnvzPcfecI
        nxhx31zhOBtNEeL+rgoHg/lzv4Sbt2mHQppz9zPHYKdtQVj07a70hYEVHSInXFEB4Hwc64
        8B7q/bgeMS9KjSnehuFWQxJHyv7s3TY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681817096;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MdkJCV7f5Ac2ntduoTetXVXp/PQMi+c9C0tNoVNScKY=;
        b=fviJZePif+JJuieQxqpaO2q8LBobELARISEcPqtUG+wIZNA3aALozQF+zTL4InvqFsSK1I
        DhI443+Rv0MhC1Ag==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 834F42C141;
        Tue, 18 Apr 2023 11:24:55 +0000 (UTC)
Date:   Tue, 18 Apr 2023 13:24:54 +0200
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
Message-ID: <20230418112454.GA15906@kitsune.suse.cz>
References: <ZDfKBPXDQxH8HeX9@syu-laptop>
 <CACdoK4L5A-qdUyQwVbe-KE+0NBPbgqYC1v0uf0i1U_S7KSnmuw@mail.gmail.com>
 <20230414095007.GF63923@kunlun.suse.cz>
 <b933fad3-7759-00d4-94cb-f20dd363b794@isovalent.com>
 <20230414161520.GJ63923@kunlun.suse.cz>
 <CAEf4Bzaw6DBHn=S9zKCXTSh7jW8xL9K6bzi1Q-e8j93thi2hmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzaw6DBHn=S9zKCXTSh7jW8xL9K6bzi1Q-e8j93thi2hmg@mail.gmail.com>
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

On Mon, Apr 17, 2023 at 05:20:03PM -0700, Andrii Nakryiko wrote:
> On Fri, Apr 14, 2023 at 9:15 AM Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > On Fri, Apr 14, 2023 at 01:30:02PM +0100, Quentin Monnet wrote:
> > > 2023-04-14 11:50 UTC+0200 ~ Michal Suchánek <msuchanek@suse.de>
> > > > Hello,
> > > >
> > > > On Fri, Apr 14, 2023 at 01:35:20AM +0100, Quentin Monnet wrote:
> > > >> Hi Shung-Hsi,
> > > >>
> > > >> On Thu, 13 Apr 2023 at 10:23, Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > > >>>
> > > >>> Hi,
> > > >>>
> > > >>> I'm considering switch to bpftool's mirror on GitHub for packaging (instead
> > > >>> of using the source found in kernel), but realize that it should goes
> > > >>> hand-in-hand with how libbpf is packaged, which eventually leads these
> > > >>> questions:
> > > >>>
> > > >>>   What is the suggested approach for packaging bpftool and libbpf?
> > > >>>   Which source is preferred, GitHub or kernel?
> > > >>
> > > >> As you can see from the previous discussions, the suggested approach
> > > >> would be to package from the GitHub mirror, with libbpf and bpftool in
> > > >> sync.
> > > >>
> > > >> My main argument for the mirror is that it keeps things simpler, and
> > > >> there's no need to deal with the rest of the kernel sources for these
> > > >> packages. Download from the mirrors, build, ship. But then I have
> > > >> limited experience at packaging for distros, and I can understand
> > > >> Toke's point of view, too. So ultimately, the call is yours.
> > > >
> > > > Things get only ever more complex when submodules are involved.
> > >
> > > I understand the generic pain points from your other email. But could
> > > you be more specific for the case of bpftool? It's not like we're
> > > shipping all lib dependencies as submodules. Sync-ups are specifically
> > > aligned to the same commit used to sync the libbpf mirror, so that it's
> > > pretty much as if we had the right version of the library shipped in the
> > > repository - only, it's one --recurse-submodules away.
> >
> > It's so in every project that uses submodules. Except git does not
> > recurse into submodules by default, you have to fix it up by hand.
> > Forges don't support submodules so you will not get the submodule when
> > downloading the project archive, and won't see it the the project tree.
> 
> git submodule update --init --recursive didn't work?

That's one part of the manual fixup.

The other part is after each git operation that could possibly cause the
submodules to go out of sync, basically any operation that changes the
checked-out commit.

Of course, you can make some shell aliases that append whatever submodule
chicanery to whatever git command you might issue, and tell everyone
else to do that, and then it will work in that one shell, and not in any
other shell nor any tool that invokes git directly.

> > After previous experience with submodules I did not even try, I just
> > patched the makefile to use system libbpf before attempting anything
> > else.
> 
> Quentin mentioned that he's packaging (or will package) libbpf sources
> as part of bpftool release on Github. I've been this for other
> libbpf-using tools as well, and it works pretty well (at least for
> Fedora and ArchLinux). E.g., srcs-full-* archives for veristat ([0])
> 
> By switching up actual libbpf used to compile with bpftool, you are
> potentially introducing subtle problems that your users will be quite
> unhappy about, if they run into them. Let's work together to make it
> easier for you to package bpftool properly. We can't switch bpftool to
> reliably use system-wide libbpf (either static or shared, doesn't
> matter) because of dependency on internal functionality.
> 
> 
>   [0] https://github.com/libbpf/veristat/releases/tag/v0.1

So how many copies of libbpf do I need for having a CO-RE toolchain?

Will different tools have different view of the kernel because they each
use different private copy of libbpf with different features?

When there is a bug in libbpf how many places need to be patched to fix
it?

Thanks

Michal
