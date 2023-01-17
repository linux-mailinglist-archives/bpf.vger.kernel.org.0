Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACB966E540
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 18:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjAQRtL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 12:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjAQRrn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 12:47:43 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C0034C35
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 09:36:58 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x10so43249845edd.10
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 09:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge16SnlTlESjqkHYW2PE/kVUrco29/A9b58EoFdObQ8=;
        b=FlPOXugIObvtI3s8aVpY4HFj6yaEDh1XqeebjeKuqD7spmPncq35OmHHWnQULncZ2F
         DA7o+53KsMAp/0hFH8d+qNwKt9v3lTEBEItjQYsOb1hJaBABd7pH6F1HgxaUmrId2AFd
         PmdhDji5qDyH4o3WSSZttWo97mFXzcilOkcPU5AYPyiZrW4f8uIWGxJFDXAZQXrprAT4
         t2GN6+k85WFXLdDzYaCQhm/Kvl0Y5klqYDacrK50KqDEzIRAgr9IJvSZaemcfhZ/oUlC
         1MOKhlDQcuWd4wg0s6KnjjcvKqcj6x5Mfrij1fSxF4N8DHvBkLthdIwpgXAvP0pwtv2C
         7VxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ge16SnlTlESjqkHYW2PE/kVUrco29/A9b58EoFdObQ8=;
        b=B7WHlu5s5crhEz6Wzj8CTZWXMd6b2cR/4v4ApZIkaX3JJAFjXNHrZ0QU4cS6WK69ux
         Za4sB2vban5aF4FgP0kgRniI/XrXcwFo3zErOiqqmM4AYq9t58DVwU5mlt8CEyi3uK6r
         CxduuXqyXxRim+44nK5DAMA5VVbr3pgQSiIraxco8xDqWCq/vu1UKJ8cKadHb+YCzqKi
         tbSdpXKQibzPZOiWuMWCJ8zgb9tlI5uHLkUhV/LWGXIpOKj35y1zTrB1cOXCaxTn8bYl
         UM6yBzSAFBbhZKO6jhzUOnDZqd7wqfoMqjRX5fOIyMbr9wErBYMnntUXj+qLxkGVKJwC
         BFcw==
X-Gm-Message-State: AFqh2kpi5SZTOPEVPFHVxqnzKAeApry3bNKEMpwrUNE0+23EyGlGbtnk
        V23UMMQkAgdKvOG7GBgxTnEJj+vHvJRHRxgGLgo=
X-Google-Smtp-Source: AMrXdXtEviH+Bh+0vEPbDx9Aw3E/1YfjhkiYLWZnuAkrPdKQBRM+fZaKmOgQyTBvYuzfy9mZJIcEuPC65cYz6l5FZoU=
X-Received: by 2002:aa7:dc07:0:b0:499:bfa7:832d with SMTP id
 b7-20020aa7dc07000000b00499bfa7832dmr490084edu.338.1673977017238; Tue, 17 Jan
 2023 09:36:57 -0800 (PST)
MIME-Version: 1.0
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
 <20221217082506.1570898-2-davemarchevsky@fb.com> <Y602StijD+4Nymf6@maniforge.lan>
 <CAADnVQJREMX7p6QwmPsX9xsGnd3+CqB2WQbokf1vev6h7ZS7Pg@mail.gmail.com>
 <Y63HrbJV+rTSmvVe@maniforge.lan> <afcae0f4-97a0-b06e-0a4e-7955ca7dbc7c@meta.com>
In-Reply-To: <afcae0f4-97a0-b06e-0a4e-7955ca7dbc7c@meta.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 17 Jan 2023 09:36:46 -0800
Message-ID: <CAADnVQJLnLpLjWgWqDPc96Jgk+OHZTeNux+iiyFjCcy+mQK5HA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/13] bpf: Support multiple arg regs w/
 ref_obj_id for kfuncs
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     David Vernet <void@manifault.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 17, 2023 at 9:26 AM Dave Marchevsky <davemarchevsky@meta.com> wrote:
>
> In another thread you also mentioned that hypothetical "kfunc writer" persona
> shouldn't have to understand kfunc flags in order to add their simple kfunc, and
> I think your comments here are also presupposing a "kfunc writer" persona that
> doesn't look at the verifier. Having such a person able to add kfuncs without
> understanding the verifier is a good goal, but doesn't reflect current
> reality when the kfunc needs to have any special semantics.

agree on that goal.

> Regardless, I'd expect that anyone adding further new-style Graph
> datastructures, old-style maps, or new datastructures unrelated to either,
> will be closer to "verifier expert" than "random person adding a few kfuncs".

also agree, since it's a reality right now.

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

I could have agreed to this as well if I didn't go and remove
all the new KF_*OWN* flags.
imo the resulting diff of mine vs your initial patch is easier to
follow and reason about.
So for this case "kfunc_id == KFUNC_whatever" is cleaner.
It doesn't mean that it will be the case in other situations.
