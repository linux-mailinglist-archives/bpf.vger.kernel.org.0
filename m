Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DDD658F5B
	for <lists+bpf@lfdr.de>; Thu, 29 Dec 2022 18:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiL2RAl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 12:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbiL2RA0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 12:00:26 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7E610FC2
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 09:00:25 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id bp44so12784164qtb.0
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 09:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FE+3orv6Ns/IA4s0EwezT5vnqvghWwWBamaae0X2cOM=;
        b=FdYD7vj/pr3GKJm0Od0KseFAHmzF9j/3dDAxgCI4Sa2SE4zKjCPVLwpePKh7ZaAf6W
         XqC/ORHA0hklkmm1Pc9+nCef1C3TJ2MZ+MGQVSFZFlFl+16YjD0eV5gtrjfT9V3TfdZB
         bl3eyN4fD/Hsy+yCwJIzoOUGMNI82xrmnU5nJpbFcBL7WzvAuVMczWUhriiJq+eUdSU7
         Gv++p3oZ1fbrhO6NSXb/e5ChKp89RhMk4siu8+ExO0yTcHDx6NVvt8C5dYGn9TTUztVc
         hhdhmOHeCj3n5yxeWvmM7S+LIInOP0ZRdn/n6LBZbX+LTczmedtcdKlumbF6YFdp78U4
         EDkQ==
X-Gm-Message-State: AFqh2koVXd5UIb/wJM9ATpnv5CmFrQvkrEpO06HsTtY97/aluA9teWLN
        9aZjlvfPFeNPAw1HieJqknY=
X-Google-Smtp-Source: AMrXdXvcFtwats1XDeo+LCk6nllRW+0h1W5s5UJQr2Dl2Kw6EMFJCaoWB7JHq3a4Mn02J9d3PJvyTw==
X-Received: by 2002:ac8:776f:0:b0:3a7:f3f0:483 with SMTP id h15-20020ac8776f000000b003a7f3f00483mr35212201qtu.60.1672333224597;
        Thu, 29 Dec 2022 09:00:24 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:290a])
        by smtp.gmail.com with ESMTPSA id u15-20020a37ab0f000000b006fafc111b12sm13305380qke.83.2022.12.29.09.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 09:00:24 -0800 (PST)
Date:   Thu, 29 Dec 2022 11:00:29 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 bpf-next 01/13] bpf: Support multiple arg regs w/
 ref_obj_id for kfuncs
Message-ID: <Y63HrbJV+rTSmvVe@maniforge.lan>
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
 <20221217082506.1570898-2-davemarchevsky@fb.com>
 <Y602StijD+4Nymf6@maniforge.lan>
 <CAADnVQJREMX7p6QwmPsX9xsGnd3+CqB2WQbokf1vev6h7ZS7Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJREMX7p6QwmPsX9xsGnd3+CqB2WQbokf1vev6h7ZS7Pg@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 29, 2022 at 08:50:19AM -0800, Alexei Starovoitov wrote:
> On Wed, Dec 28, 2022 at 10:40 PM David Vernet <void@manifault.com> wrote:
> >
> > On Sat, Dec 17, 2022 at 12:24:54AM -0800, Dave Marchevsky wrote:
> > > Currently, kfuncs marked KF_RELEASE indicate that they release some
> > > previously-acquired arg. The verifier assumes that such a function will
> > > only have one arg reg w/ ref_obj_id set, and that that arg is the one to
> > > be released. Multiple kfunc arg regs have ref_obj_id set is considered
> > > an invalid state.
> > >
> > > For helpers, RELEASE is used to tag a particular arg in the function
> > > proto, not the function itself. The arg with OBJ_RELEASE type tag is the
> > > arg that the helper will release. There can only be one such tagged arg.
> > > When verifying arg regs, multiple helper arg regs w/ ref_obj_id set is
> > > also considered an invalid state.
> > >
> > > Later patches in this series will result in some linked_list helpers
> > > marked KF_RELEASE having a valid reason to take two ref_obj_id args.
> > > Specifically, bpf_list_push_{front,back} can push a node to a list head
> > > which is itself part of a list node. In such a scenario both arguments
> > > to these functions would have ref_obj_id > 0, thus would fail
> > > verification under current logic.
> > >
> > > This patch changes kfunc ref_obj_id searching logic to find the last arg
> > > reg w/ ref_obj_id and consider that the reg-to-release. This should be
> > > backwards-compatible with all current kfuncs as they only expect one
> > > such arg reg.
> >
> > Can't say I'm a huge fan of this proposal :-( While I think it's really
> > unfortunate that kfunc flags are not defined per-arg for this exact type
> > of reason, adding more flag-specific semantics like this is IMO a step
> > in the wrong direction.  It's similar to the existing __sz and __k
> > argument-naming semantics that inform the verifier that the arguments
> > have special meaning. All of these little additions of special-case
> > handling for kfunc flags end up requiring people writing kfuncs (and
> > sometimes calling them) to read through the verifier to understand
> > what's going on (though I will say that it's nice that __sz and __k are
> > properly documented in [0]).
> 
> Before getting to pros/cons of KF_* vs name suffix vs helper style
> per-arg description...
> It's important to highlight that here we're talking about
> link list and rb tree kfuncs that are not like other kfuncs.
> Majority of kfuncs can be added by subsystems like hid-bpf
> without touching the verifier.

I hear you and I agree. It wasn't my intention to drag us into a larger
discussion about kfuncs vs. helpers, but rather just to point out that I
think we have to try hard to avoid adding special-case logic that
requires looking into the verifier to understand the semantics. I think
we're on the same page about this, based on this and your other
response.

> Here we're paving the way for graph (aka new gen data structs)
> and so far not only kfuncs, but their arg types have to have
> special handling inside the verifier.
> There is not much yet to generalize and expose as generic KF_
> flag or as a name suffix.
> Therefore I think it's more appropriate to implement them
> with minimal verifier changes and minimal complexity.

Agreed

> There is no 3rd graph algorithm on the horizon after link list
> and rbtree. Instead there is a big todo list for
> 'multi owner graph node' and 'bpf_refcount_t'.

In this case my point in [0] of the only option for generalizing being
to have something like KF_GRAPH_INSERT / KF_GRAPH_REMOVE is just not the
way forward (which I also said was my opinion when I pointed it out as
an option). Let's just special-case these kfuncs. There's already a
precedence for doing that in the verifier anyways. Minimal complexity,
minimal API changes. It's a win-win.

[0]: https://lore.kernel.org/all/Y63GLqZil9l1NzY4@maniforge.lan/

> Those will require bigger changes in the verifier,
> so I'd like to avoid premature generalization :) as analogous
> to premature optimization :)

And of course given my points above and in other threads: agreed. I
think we have an ideal middle-ground for minimizing complexity in the
short term, and some nice follow-on todo-list items to work on in the
medium-long term which will continue to improve things without
(negatively) affecting users in any way. All SGTM
