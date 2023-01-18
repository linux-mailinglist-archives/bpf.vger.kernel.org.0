Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6DE672430
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 17:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjARQx7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 11:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjARQx5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 11:53:57 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4722EA5D3
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 08:53:56 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id l14so20346701qvw.12
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 08:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Se5pzVcy8yYw9hX0iljYERwy7YURcFd22xGAU8NttTM=;
        b=2DXkZzerEivn2lxk2qfOutc8UBBwYu36pf0sirP7pAmkz/in+m+xWGXDDmRN+Utizd
         EmR8qmT0MVe9aRZTGk7RFIsTWNP504i95KvDx3jS7J0S8K4768/Fnl4ajOA/rtYQ1E3B
         7sjKLIWoyfN6HwR/1BTBkGC300h8NUqmdXeu56xvZYZgiopuTHklKfGahkL901knu2R1
         34ZUNVcXzPQaNxK7gIKhik6KFP/q9Cu5GCd+mQBMLgfV51Qln4kdbQ6GHu3f3F/uofem
         Bh72jl1N1JvZUtrqle780mBgrnjg8cHvHCrNZEPrbvlIv3kKfMNLZPkD9M10/TKW8Skv
         G4+A==
X-Gm-Message-State: AFqh2kqryT7PWQAMRp/dGytq70uAtNpTYjYH9lxF/7iIe803JSerldtB
        lVs91H0M3hdxndoe/zQxiZw=
X-Google-Smtp-Source: AMrXdXva/n5NBLm1Nf7rJwKnsgJNuH1Rn4h+tQHQMslSi15EkRLDR5V3Tu6eeLxBeNYBe7Ej+du3Zw==
X-Received: by 2002:a05:6214:32f:b0:532:299d:99c9 with SMTP id j15-20020a056214032f00b00532299d99c9mr9171872qvu.1.1674060835179;
        Wed, 18 Jan 2023 08:53:55 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id t2-20020a37ea02000000b006fb9bbb071fsm22494619qkj.29.2023.01.18.08.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:53:54 -0800 (PST)
Date:   Wed, 18 Jan 2023 10:53:58 -0600
From:   David Vernet <void@manifault.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [RFC PATCH v2] Documentation/bpf: Add a description of "stable
 kfuncs"
Message-ID: <Y8gkJv4l2LHNJW1x@maniforge.lan>
References: <20230117212731.442859-1-toke@redhat.com>
 <CAKH8qBuvBomTXqNB+a6n_PbJKSNFazrAxEWsVT-=4XfztuJ7dw@mail.gmail.com>
 <87v8l4byyb.fsf@toke.dk>
 <CAKH8qBs=nEhhy2Qu7CpyAHx6gOaWR25tRF7aopti5-TSuw66HQ@mail.gmail.com>
 <CAADnVQKy1QzM+wg1BxfYA30QsTaM4M5RRCi+VHN6A7ah2BeZZw@mail.gmail.com>
 <CAKH8qBvZgoOe24MMY+Jn-6guJzGVuJS9zW4v6H+fhgcp7X_9jQ@mail.gmail.com>
 <3500bace-de87-0335-3fe3-6a5c0b4ce6ad@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3500bace-de87-0335-3fe3-6a5c0b4ce6ad@iogearbox.net>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 18, 2023 at 11:48:59AM +0100, Daniel Borkmann wrote:
> On 1/18/23 3:00 AM, Stanislav Fomichev wrote:
> > On Tue, Jan 17, 2023 at 3:19 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Tue, Jan 17, 2023 at 2:20 PM Stanislav Fomichev <sdf@google.com> wrote:
> > > > On Tue, Jan 17, 2023 at 2:04 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> > > > > Stanislav Fomichev <sdf@google.com> writes:
> > > > > > On Tue, Jan 17, 2023 at 1:27 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> > > > > > > 
> > > > > > > Following up on the discussion at the BPF office hours, this patch adds a
> > > > > > > description of the (new) concept of "stable kfuncs", which are kfuncs that
> > > > > > > offer a "more stable" interface than what we have now, but is still not
> > > > > > > part of UAPI.
> > > > > > > 
> > > > > > > This is mostly meant as a straw man proposal to focus discussions around
> > > > > > > stability guarantees. From the discussion, it seemed clear that there were
> > > > > > > at least some people (myself included) who felt that there needs to be some
> > > > > > > way to export functionality that we consider "stable" (in the sense of
> > > > > > > "applications can rely on its continuing existence").
> > > > > > > 
> > > > > > > One option is to keep BPF helpers as the stable interface and implement
> > > > > > > some technical solution for moving functionality from kfuncs to helpers
> > > > > > > once it has stood the test of time and we're comfortable committing to it
> > > > > > > as a stable API. Another is to freeze the helper definitions, and instead
> > > > > > > use kfuncs for this purpose as well, by marking a subset of them as
> > > > > > > "stable" in some way. Or we can do both and have multiple levels of
> > > > > > > "stable", I suppose.
> > > > > > > 
> > > > > > > This patch is an attempt to describe what the "stable kfuncs" idea might
> > > > > > > look like, as well as to formulate some criteria for what we mean by
> > > > > > > "stable", and describe an explicit deprecation procedure. Feel free to
> > > > > > > critique any part of this (including rejecting the notion entirely).
> > > > > > > 
> > > > > > > Some people mentioned (in the office hours) that should we decide to go in
> > > > > > > this direction, there's some work that needs to be done in libbpf (and
> > > > > > > probably the kernel too?) to bring the kfunc developer experience up to par
> > > > > > > with helpers. Things like exporting kfunc definitions to vmlinux.h (to make
> > > > > > > them discoverable), and having CO-RE support for using them, etc. I kinda
> > > > > > > consider that orthogonal to what's described here, but I do think we should
> > > > > > > fix those issues before implementing the procedures described here.
> > > > > > > 
> > > > > > > v2:
> > > > > > > - Incorporate Daniel's changes
> > > > > > > 
> > > > > > > Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> > > > > > > ---
> > > > > > >   Documentation/bpf/kfuncs.rst | 87 +++++++++++++++++++++++++++++++++---
> > > > > > >   1 file changed, 81 insertions(+), 6 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> > > > > > > index 9fd7fb539f85..dd40a4ee35f2 100644
> > > > > > > --- a/Documentation/bpf/kfuncs.rst
> > > > > > > +++ b/Documentation/bpf/kfuncs.rst
> > > > > > > @@ -7,9 +7,9 @@ BPF Kernel Functions (kfuncs)
> > > > > > > 
> > > > > > >   BPF Kernel Functions or more commonly known as kfuncs are functions in the Linux
> > > > > > >   kernel which are exposed for use by BPF programs. Unlike normal BPF helpers,
> > > > > > > -kfuncs do not have a stable interface and can change from one kernel release to
> > > > > > > -another. Hence, BPF programs need to be updated in response to changes in the
> > > > > > > -kernel.
> > > > > > > +kfuncs by default do not have a stable interface and can change from one kernel
> > > > > > > +release to another. Hence, BPF programs may need to be updated in response to
> > > > > > > +changes in the kernel. See :ref:`BPF_kfunc_stability`.
> > > > > > > 
> > > > > > >   2. Defining a kfunc
> > > > > > >   ===================
> > > > > > > @@ -223,14 +223,89 @@ type. An example is shown below::
> > > > > > >           }
> > > > > > >           late_initcall(init_subsystem);
> > > > > > > 
> > > > > > > -3. Core kfuncs
> > > > > > > +
> > > > > > > +.. _BPF_kfunc_stability:
> 
> small nit: please also link from Documentation/bpf/bpf_design_QA.rst, so these sections
> here are easier to find.
> 
> > > > > > > +3. API (in)stability of kfuncs
> > > > > > > +==============================
> > > > > > > +
> > > > > > > +By default, kfuncs exported to BPF programs are considered a kernel-internal
> > > > > > > +interface that can change between kernel versions. This means that BPF programs
> > > > > > > +using kfuncs may need to adapt to changes between kernel versions. In the
> > > > > > > +extreme case that could also include removal of a kfunc. In other words, kfuncs
> > > > > > > +are _not_ part of the kernel UAPI! Rather, these kfuncs can be thought of as
> > > > > > > +being similar to internal kernel API functions exported using the
> > > > > > 
> > > > > > [..]
> > > > > > 
> > > > > > > +``EXPORT_SYMBOL_GPL`` macro. All new BPF kernel helper-like functionality must
> > > > > > > +initially start out as kfuncs.
> > > > > > 
> > > > > > To clarify, as part of this proposal, are we making a decision here
> > > > > > that we ban new helpers going forward?
> > > > > 
> > > > > Good question! That is one of the things I'm hoping we can clear up by
> > > > > this discussing. I don't have a strong opinion on the matter myself, as
> > > > > long as there is *some* way to mark a subset of helpers/kfuncs as
> > > > > "stable"...
> > > > 
> > > > Might be worth it to capitalize in this case to indicate that it's a
> > > > MUST from the RFC world? (or go with SHOULD otherwise).
> > > > I'm fine either way. The only thing that stops me from fully embracing
> > > > MUST is the kfunc requirement on the explicit jit support; I'm not
> > > > sure why it exists and at this point I'm too afraid to ask. But having
> > > > MUST here might give us motivation to address the shortcomings...
> > > 
> > > Did you do:
> > > git grep bpf_jit_supports_kfunc_call
> > > and didn't find your favorite architecture there and
> > > didn't find it in the upcoming patches for riscv and arm32?
> > > If you care about kfuncs on arm32 please help reviewing posted patches.
> > 
> > Exactly why I'm going to support whatever decision is being made here.
> > Just trying to clarify what that decision is.
> 
> My $0.02 is that I don't think we need to make a hard-cut ban as part of this.
> The 'All new BPF kernel helper-like functionality must initially start out as
> kfuncs.' is pretty clear where things would need to start out with, and we could
> leave the option on the table if really needed to go BPF helper route when
> promoting kfunc to stable at the same time. I had that in the text suggestion
> earlier, it's more corner case and maybe we'll never need it but we also don't
> drive ourselves into a corner where we close the door on it. Lets let the infra
> around kfuncs evolve further first.

I think that's reasonable, though I also think it would be good for us
to be concrete about what we mean by "if really needed to go BPF helper
route". One of Andrii's main points (hopefully I'm not misrepresenting
anything) was that having things as kfuncs requires JIT support, which
means that architectures which don't yet have JIT support wouldn't be
able to reap the benefits of whatever functionality is added with
kfuncs. On the other hand, Alexei pointed out in [0] that riscv and
arm32 support is coming for JIT.

[0]: https://lore.kernel.org/all/CAADnVQKy1QzM+wg1BxfYA30QsTaM4M5RRCi+VHN6A7ah2BeZZw@mail.gmail.com/

I propose that we also specify that wanting the feature to be present on
non-JIT / non-BTF kernels is not a sufficient reason for making them a
helper. Not because there are no tradeoffs in doing so, but rather
because:

1. I think we just need to make a decision and be consistent here to
   avoid more lengthy debates.

2. I think that if something is really useful on an architecture, people
   will add JIT support for it. An argument could always be made that we
   should be able to rely only on the interpreter for new architectures
   that are added, etc. As more time passes, BPF sans JIT (i.e.
   interpreter BPF) will be less and less useful, and will diverge more
   and more from JIT-BPF. It's really inevitable anyways given the
   direction that things are going, and IMO we should just embrace that
   and focus on enabling JIT / modern BPF on useful architectures rather
   than adding things to helpers for the sake of those platforms.

Thanks,
David
