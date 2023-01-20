Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513FE674C13
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjATFXl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjATFX2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:23:28 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7F17AF2B
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 21:13:30 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id j9so3401973qtv.4
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 21:13:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGy3wMp3y4lL4EtPCQWFfPOohR30UXAfIJ3Dnz2XE34=;
        b=3ty0lKYgzgqAinu4H4dcEbQCqfJ5xSIaNYhrkYrsELt6GTjP2Y3V6BEthB3s9wskgr
         OzxJTLxZ0qRGj1FLFykkIUwxv34NLxeV86CTDGIe5EkSDmUe60JhC0tuFLpawao9fRry
         VTs2Z7WuQXFCrgbEgXK/DDvnWeu4WDSb3u+crSOJBGZxuAtWkgI/wIwbwX3S6ep5B8xQ
         +BMrOWjhWEJnnZCi2zvuKsIub0j1Yp7i0QY7olL3RcgISjnUvyWtmX5/x6Nx7+a0ztqV
         GVn4Bx2aty8CZu8k57fqceKYA1+rL9M1wuiDqcyBB2npKI3C9HWTenzgiyQJayzSqNGS
         jSzw==
X-Gm-Message-State: AFqh2kpQDWY1vtyzzbTWR3+KY0iS+bh6EGZduM71bp5aX5taLO184iOF
        iYvE39nAFTUsXzUZSEXs9LE=
X-Google-Smtp-Source: AMrXdXsbHsT4GzMrKzs7QBL5K/8B4XUx4h+NbEwWsR/Qt5+AaFtPw3OxPRwZbCbMaGNE0P5RgfKCSw==
X-Received: by 2002:ac8:6712:0:b0:3b6:3a58:912d with SMTP id e18-20020ac86712000000b003b63a58912dmr19147238qtp.0.1674191596721;
        Thu, 19 Jan 2023 21:13:16 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id ce15-20020a05622a41cf00b003b62e9c82ebsm7544701qtb.48.2023.01.19.21.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 21:13:16 -0800 (PST)
Date:   Thu, 19 Jan 2023 23:13:20 -0600
From:   David Vernet <void@manifault.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 bpf-next 01/13] bpf: Support multiple arg regs w/
 ref_obj_id for kfuncs
Message-ID: <Y8oi8PeoW8HvRDft@maniforge.lan>
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
 <20221217082506.1570898-2-davemarchevsky@fb.com>
 <Y602StijD+4Nymf6@maniforge.lan>
 <CAADnVQJREMX7p6QwmPsX9xsGnd3+CqB2WQbokf1vev6h7ZS7Pg@mail.gmail.com>
 <Y63HrbJV+rTSmvVe@maniforge.lan>
 <afcae0f4-97a0-b06e-0a4e-7955ca7dbc7c@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afcae0f4-97a0-b06e-0a4e-7955ca7dbc7c@meta.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 17, 2023 at 12:26:32PM -0500, Dave Marchevsky wrote:
> On 12/29/22 12:00 PM, David Vernet wrote:
> > On Thu, Dec 29, 2022 at 08:50:19AM -0800, Alexei Starovoitov wrote:
> >> On Wed, Dec 28, 2022 at 10:40 PM David Vernet <void@manifault.com> wrote:
> >>>
> >>> On Sat, Dec 17, 2022 at 12:24:54AM -0800, Dave Marchevsky wrote:
> >>>> Currently, kfuncs marked KF_RELEASE indicate that they release some
> >>>> previously-acquired arg. The verifier assumes that such a function will
> >>>> only have one arg reg w/ ref_obj_id set, and that that arg is the one to
> >>>> be released. Multiple kfunc arg regs have ref_obj_id set is considered
> >>>> an invalid state.
> >>>>
> >>>> For helpers, RELEASE is used to tag a particular arg in the function
> >>>> proto, not the function itself. The arg with OBJ_RELEASE type tag is the
> >>>> arg that the helper will release. There can only be one such tagged arg.
> >>>> When verifying arg regs, multiple helper arg regs w/ ref_obj_id set is
> >>>> also considered an invalid state.
> >>>>
> >>>> Later patches in this series will result in some linked_list helpers
> >>>> marked KF_RELEASE having a valid reason to take two ref_obj_id args.
> >>>> Specifically, bpf_list_push_{front,back} can push a node to a list head
> >>>> which is itself part of a list node. In such a scenario both arguments
> >>>> to these functions would have ref_obj_id > 0, thus would fail
> >>>> verification under current logic.
> >>>>
> >>>> This patch changes kfunc ref_obj_id searching logic to find the last arg
> >>>> reg w/ ref_obj_id and consider that the reg-to-release. This should be
> >>>> backwards-compatible with all current kfuncs as they only expect one
> >>>> such arg reg.
> >>>
> >>> Can't say I'm a huge fan of this proposal :-( While I think it's really
> >>> unfortunate that kfunc flags are not defined per-arg for this exact type
> >>> of reason, adding more flag-specific semantics like this is IMO a step
> >>> in the wrong direction.  It's similar to the existing __sz and __k
> >>> argument-naming semantics that inform the verifier that the arguments
> >>> have special meaning. All of these little additions of special-case
> >>> handling for kfunc flags end up requiring people writing kfuncs (and
> >>> sometimes calling them) to read through the verifier to understand
> >>> what's going on (though I will say that it's nice that __sz and __k are
> >>> properly documented in [0]).
> >>
> >> Before getting to pros/cons of KF_* vs name suffix vs helper style
> >> per-arg description...
> >> It's important to highlight that here we're talking about
> >> link list and rb tree kfuncs that are not like other kfuncs.
> >> Majority of kfuncs can be added by subsystems like hid-bpf
> >> without touching the verifier.
> > 
> > I hear you and I agree. It wasn't my intention to drag us into a larger
> > discussion about kfuncs vs. helpers, but rather just to point out that I
> > think we have to try hard to avoid adding special-case logic that
> > requires looking into the verifier to understand the semantics. I think
> > we're on the same page about this, based on this and your other
> > response.
> > 
> 
> In another thread you also mentioned that hypothetical "kfunc writer" persona
> shouldn't have to understand kfunc flags in order to add their simple kfunc, and
> I think your comments here are also presupposing a "kfunc writer" persona that
> doesn't look at the verifier. Having such a person able to add kfuncs without
> understanding the verifier is a good goal, but doesn't reflect current
> reality when the kfunc needs to have any special semantics.

Agreed that it's the current reality that you need to read the verifier
to add kfuncs, but I disagree with the sentiment that it's therefore
acceptable to add what are arguably somewhat odd semantics in the
interim that move us in the opposite direction of getting there.

> Regardless, I'd expect that anyone adding further new-style Graph
> datastructures, old-style maps, or new datastructures unrelated to either,
> will be closer to "verifier expert" than "random person adding a few kfuncs".

This doesn't affect just graph datastructure kfunc authors though, it
affects anyone adding a kfunc. It just happens to be needed specifically
for graph data structures. If we really end up needing this, IMO it
would be better to get rid of KF_ACQUIRE and KF_RELEASE flags and just
use __acq / __rel suffixes to match __k and __sz.

> 
> >> Here we're paving the way for graph (aka new gen data structs)
> >> and so far not only kfuncs, but their arg types have to have
> >> special handling inside the verifier.
> >> There is not much yet to generalize and expose as generic KF_
> >> flag or as a name suffix.
> >> Therefore I think it's more appropriate to implement them
> >> with minimal verifier changes and minimal complexity.
> > 
> > Agreed
> > 
> 
> 'Generalize' was addressed in Patch 2's thread.
> 
> >> There is no 3rd graph algorithm on the horizon after link list
> >> and rbtree. Instead there is a big todo list for
> >> 'multi owner graph node' and 'bpf_refcount_t'.
> > 
> > In this case my point in [0] of the only option for generalizing being
> > to have something like KF_GRAPH_INSERT / KF_GRAPH_REMOVE is just not the
> > way forward (which I also said was my opinion when I pointed it out as
> > an option). Let's just special-case these kfuncs. There's already a
> > precedence for doing that in the verifier anyways. Minimal complexity,
> > minimal API changes. It's a win-win.
> > 
> > [0]: https://lore.kernel.org/all/Y63GLqZil9l1NzY4@maniforge.lan/
> > 
> 
> There's certainly precedent for adding special-case "kfunc_id == KFUNC_whatever"
> all over the verifier. It's a bad precedent, though, for reasons discussed in
> [0].
> 
> To specifically address your points here, I don't buy the argument that
> special-casing based on func id is "minimal complexity, minimal API changes".
> Re: 'complexity': the logic implementing the complicated semantic will be
> added regardless, it just won't have a name that's easily referenced in docs
> and mailing list discussions.
> 
> Similarly, re: 'API changes': if by 'API' here you mean "API that's exposed
> to folks adding kfuncs" - see my comments about "kfunc writer" persona above.
> We can think of the verifier itself as an API too - with a single bpf_check
> function. That API's behavior is indeed changed here, regardless of whether
> the added semantics are gated by a kfunc flag or special-case checks. I don't
> think that hiding complexity behind special-case checks when there could be
> a named flag simplifies anything. The complexity is added regardless, question
> is how many breadcrumbs and pointers we want to leave for folks trying to make
> sense of it in the future.
> 
>   [0]: https://lore.kernel.org/bpf/9763aed7-0284-e400-b4dc-ed01718d8e1e@meta.com/

Will reply on that thread.

> 
> >> Those will require bigger changes in the verifier,
> >> so I'd like to avoid premature generalization :) as analogous
> >> to premature optimization :)
> > 
> > And of course given my points above and in other threads: agreed. I
> > think we have an ideal middle-ground for minimizing complexity in the
> > short term, and some nice follow-on todo-list items to work on in the
> > medium-long term which will continue to improve things without
> > (negatively) affecting users in any way. All SGTM
