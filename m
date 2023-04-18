Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F846E69B3
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 18:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjDRQi5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 12:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjDRQi5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 12:38:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360DB974C;
        Tue, 18 Apr 2023 09:38:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94a35b0ec77so677658766b.3;
        Tue, 18 Apr 2023 09:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681835912; x=1684427912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw10kcaau1ppZSeiQ6y8o4ntvcL42o09SfowW0BsPd0=;
        b=FEKt/kqiRwzrscLDly4Dof4+7zfHN+rsXB5tHg8FACrvz7ZyethLOtTfKCRDxxPQqX
         4u1EDW1rDApi5rX6VtdtZd+/GKrw7KQmoe002F7uHotpTmDJjlaUmlr7r/Yno+J6dqG/
         HcnVFiUpoBSSEg7F+eBrSd/QUAlLHyJNbcPg1etYOaIWEpvvGxNZToqlAt8+XFTyVXCg
         6fIjguou6m/jRDDgZSVzlc1rDFfky77At/6gEASb/b6dJpsaXkPISwmfs9alNKnLyWik
         619TJPltbAbTy1CX5TxgQQgRxSpjTVWGyvlakJpcc/fNYKQy7sufvhTQhji5yse8J4W8
         FNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681835912; x=1684427912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sw10kcaau1ppZSeiQ6y8o4ntvcL42o09SfowW0BsPd0=;
        b=j5cFKloDDtZbftrFJLQ78QJC318ZY46gCJGLYdOvP2q+UbafkfN4bMDN13x9eapbAQ
         7vj3qPdDHzimpnUM0PSL7mow9eDVLDUPfiU/j3E/Lz89zfHt4XkZmJ30D1eEsZAlDJrq
         W0dfG4u6k8qlpj7IQsJVtec4oKmtisaNJgolFOtMHKl+ZTRJgeBtP6aizMkubFbmyz5l
         iQvx6t1pWcfaOHYTyAhi6LwAapLstCriSkS20/s50kjWofyEl5gBmNIcyZ4CIilDcgCZ
         rNCwRAJMruRaln9W/HjywyZAEp54NlLdXIFIpb5EgdkpucNf23DGeFMugHD3sY//BViQ
         L4cg==
X-Gm-Message-State: AAQBX9dLqivWQFW1ei9XSMo27T6DsWGGWKjFSIwX2ma3w5Y+uXmmKtnI
        NMk15VzimkAKXPLKwI8VLc6E+Zdn1CEH8CqXfnM=
X-Google-Smtp-Source: AKy350alXFUzzbCET0wbJ1lSAAgWpShd3nm6ksWajKjHo/A3JKOJQneLg/ggjfe8pHfC2Bnlndu7aJV1o/Z3kQIrEes=
X-Received: by 2002:aa7:cd95:0:b0:502:61d8:233b with SMTP id
 x21-20020aa7cd95000000b0050261d8233bmr3368146edv.19.1681835912405; Tue, 18
 Apr 2023 09:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <ZDfKBPXDQxH8HeX9@syu-laptop> <CACdoK4L5A-qdUyQwVbe-KE+0NBPbgqYC1v0uf0i1U_S7KSnmuw@mail.gmail.com>
 <20230414095007.GF63923@kunlun.suse.cz> <b933fad3-7759-00d4-94cb-f20dd363b794@isovalent.com>
 <20230414161520.GJ63923@kunlun.suse.cz> <CAEf4Bzaw6DBHn=S9zKCXTSh7jW8xL9K6bzi1Q-e8j93thi2hmg@mail.gmail.com>
 <20230418112454.GA15906@kitsune.suse.cz>
In-Reply-To: <20230418112454.GA15906@kitsune.suse.cz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 18 Apr 2023 09:38:20 -0700
Message-ID: <CAEf4BzZf50fX7T9k47u+9YQrMbSLxLeA1qWwrdWToCZkMhynjg@mail.gmail.com>
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

On Tue, Apr 18, 2023 at 4:24=E2=80=AFAM Michal Such=C3=A1nek <msuchanek@sus=
e.de> wrote:
>
> On Mon, Apr 17, 2023 at 05:20:03PM -0700, Andrii Nakryiko wrote:
> > On Fri, Apr 14, 2023 at 9:15=E2=80=AFAM Michal Such=C3=A1nek <msuchanek=
@suse.de> wrote:
> > >
> > > On Fri, Apr 14, 2023 at 01:30:02PM +0100, Quentin Monnet wrote:
> > > > 2023-04-14 11:50 UTC+0200 ~ Michal Such=C3=A1nek <msuchanek@suse.de=
>
> > > > > Hello,
> > > > >
> > > > > On Fri, Apr 14, 2023 at 01:35:20AM +0100, Quentin Monnet wrote:
> > > > >> Hi Shung-Hsi,
> > > > >>
> > > > >> On Thu, 13 Apr 2023 at 10:23, Shung-Hsi Yu <shung-hsi.yu@suse.co=
m> wrote:
> > > > >>>
> > > > >>> Hi,
> > > > >>>
> > > > >>> I'm considering switch to bpftool's mirror on GitHub for packag=
ing (instead
> > > > >>> of using the source found in kernel), but realize that it shoul=
d goes
> > > > >>> hand-in-hand with how libbpf is packaged, which eventually lead=
s these
> > > > >>> questions:
> > > > >>>
> > > > >>>   What is the suggested approach for packaging bpftool and libb=
pf?
> > > > >>>   Which source is preferred, GitHub or kernel?
> > > > >>
> > > > >> As you can see from the previous discussions, the suggested appr=
oach
> > > > >> would be to package from the GitHub mirror, with libbpf and bpft=
ool in
> > > > >> sync.
> > > > >>
> > > > >> My main argument for the mirror is that it keeps things simpler,=
 and
> > > > >> there's no need to deal with the rest of the kernel sources for =
these
> > > > >> packages. Download from the mirrors, build, ship. But then I hav=
e
> > > > >> limited experience at packaging for distros, and I can understan=
d
> > > > >> Toke's point of view, too. So ultimately, the call is yours.
> > > > >
> > > > > Things get only ever more complex when submodules are involved.
> > > >
> > > > I understand the generic pain points from your other email. But cou=
ld
> > > > you be more specific for the case of bpftool? It's not like we're
> > > > shipping all lib dependencies as submodules. Sync-ups are specifica=
lly
> > > > aligned to the same commit used to sync the libbpf mirror, so that =
it's
> > > > pretty much as if we had the right version of the library shipped i=
n the
> > > > repository - only, it's one --recurse-submodules away.
> > >
> > > It's so in every project that uses submodules. Except git does not
> > > recurse into submodules by default, you have to fix it up by hand.
> > > Forges don't support submodules so you will not get the submodule whe=
n
> > > downloading the project archive, and won't see it the the project tre=
e.
> >
> > git submodule update --init --recursive didn't work?
>
> That's one part of the manual fixup.
>
> The other part is after each git operation that could possibly cause the
> submodules to go out of sync, basically any operation that changes the
> checked-out commit.
>
> Of course, you can make some shell aliases that append whatever submodule
> chicanery to whatever git command you might issue, and tell everyone
> else to do that, and then it will work in that one shell, and not in any
> other shell nor any tool that invokes git directly.

Are we discussing a *standard* Git submodule feature and argue that
because it might be cumbersome or unfamiliar to some engineers that
projects should avoid using Git submodules?

For one, I don't have any special aliases for dealing with Git
submodules and it works fine. If I jump between branches or tags which
update Git submodule reference, I do above `git submodule update
--init --recursive` explicitly if I see that Git status shows
out-of-sync Git submodule state. If I want to update a Git submodule,
I update the submodule's Git repo, and then git add it in the repo
that uses this submodule. I haven't run into any other issues with
this.

Having said that, I do realize that some build systems have more
troubles with Git submodules (this was a complaint from Fedora
packagers), and I empathize with this, which is why I do the archiving
of submodule sources when cutting releases. If you'd prefer some other
way of dealing with this, please let's have a constructive discussion
about that. Suggesting projects to stop using Git submodules isn't
that, IMO.

>
> > > After previous experience with submodules I did not even try, I just
> > > patched the makefile to use system libbpf before attempting anything
> > > else.
> >
> > Quentin mentioned that he's packaging (or will package) libbpf sources
> > as part of bpftool release on Github. I've been this for other
> > libbpf-using tools as well, and it works pretty well (at least for
> > Fedora and ArchLinux). E.g., srcs-full-* archives for veristat ([0])
> >
> > By switching up actual libbpf used to compile with bpftool, you are
> > potentially introducing subtle problems that your users will be quite
> > unhappy about, if they run into them. Let's work together to make it
> > easier for you to package bpftool properly. We can't switch bpftool to
> > reliably use system-wide libbpf (either static or shared, doesn't
> > matter) because of dependency on internal functionality.
> >
> >
> >   [0] https://github.com/libbpf/veristat/releases/tag/v0.1
>
> So how many copies of libbpf do I need for having a CO-RE toolchain?

What do you mean by "CO-RE toolchain"? bpftool, veristat, retsnoop,
etc are tools. The fact they are using statically linked libbpf
through Git submodule is irrelevant to end users. You need one libbpf
in the system (for those who link dynamically against libbpf), the
rest are just tools.

>
> Will different tools have different view of the kernel because they each
> use different private copy of libbpf with different features?

That's up to tools, not libbpf. You are over pivoting on libbpf here.
There is one view of the kernel, it depends on what features the
kernel supports. If the tool requires some specific functionality of
libbpf, it will update its Git submodule reference to get a version of
libbpf that provides that feature. That's the point, an
application/tool is in control of what kind of features it gets from
libbpf.

>
> When there is a bug in libbpf how many places need to be patched to fix
> it?

That's up to tools, again. If the bug is affecting them, they should
cut a new version of their *tool*, using a patched version of libbpf
from Github. If it doesn't affect them, then it doesn't matter *to
them*.

>
> Thanks
>
> Michal
