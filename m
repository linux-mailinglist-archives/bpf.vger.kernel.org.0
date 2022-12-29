Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD850658F3D
	for <lists+bpf@lfdr.de>; Thu, 29 Dec 2022 17:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiL2Quf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 11:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiL2Qud (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 11:50:33 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B344A2613
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 08:50:32 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id u9so46389018ejo.0
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 08:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QHLEfdhmEqBsU9fQ7s/z0l3yPxaaPcFppLabamKrS/A=;
        b=caLJV7mih5UcBUhzqUfAuvf1EMvVW+W9+4v+9M+FMnRe32rt9ZWSWpUMEa0vnqTPiK
         /6Us5/omhHhrxhW4Ndhp6v9Do1jVLKApb2Gh/8KbuVh+1Gh1dI5kxyNg1BIf1ES0D8pT
         eltE9aCt90TjWn2B+cnzUtKULJARuxwhjXl/5KLkPVXPzmqVbQih26nKfUISiceHUkrg
         3ueaUVQzttnEtpjaffONxj+xzwv8UZJoGR3TX8eiHXuOC/aWwNzs0nCthIl/NbIrN3gA
         H6ekEQN9FvZrTIlMiKCuYR0rJ8u3hAMLrV+kHpjuonjNQM9oojWMmrZLckUEowCZJeVE
         1QAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHLEfdhmEqBsU9fQ7s/z0l3yPxaaPcFppLabamKrS/A=;
        b=4HK9hQz3qpQ9ZrfIfN4yvyG+3Tlg96xtFu4DheLzyooQfNNKDacKOMasI89tLYBeIs
         zt39zI7Cbm0B0Sy21Hk5EJJdVHf+MUySUcwNudL76XwGkuu1BJ2kGntEn/9vjqWeoGa5
         9JIheYIkEqwBENHeuQAdugzSYePyTemLFlBjaxJowPl4HU6LBiSuXt/NvZ7Noo73ceI/
         fSt/nLiPhVQtdQHfR9qkby2U/f2owuLRC74nPhTSH8gHhFRiAsHA6xW9xt+nna5o16RL
         EGUUVdsBgssz1Ytz2T3PTSExqcb5GM6HZdt0vVz97Oki/6iYoG35TMVsOLvqxOLlYlk2
         o4VQ==
X-Gm-Message-State: AFqh2koyXy8Gphz8ZVvewqeiIk93V9ypM4muKh/ceC/KLWpO6UUy7MSG
        xtmPWyQEV1xV+Vtv9DKYMmu/RI8hGXPoUiQqae0=
X-Google-Smtp-Source: AMrXdXscF5k4/IgcYx7iIW7JGAqFTHsxL+Rxh3qZcQ64I06bWDVlQ/oWG9zP3uiXfQBQXvhZ/zpznKfBuSSxppOi2Og=
X-Received: by 2002:a17:906:2818:b0:836:e897:648a with SMTP id
 r24-20020a170906281800b00836e897648amr1507563ejc.94.1672332631061; Thu, 29
 Dec 2022 08:50:31 -0800 (PST)
MIME-Version: 1.0
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
 <20221217082506.1570898-2-davemarchevsky@fb.com> <Y602StijD+4Nymf6@maniforge.lan>
In-Reply-To: <Y602StijD+4Nymf6@maniforge.lan>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 29 Dec 2022 08:50:19 -0800
Message-ID: <CAADnVQJREMX7p6QwmPsX9xsGnd3+CqB2WQbokf1vev6h7ZS7Pg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/13] bpf: Support multiple arg regs w/
 ref_obj_id for kfuncs
To:     David Vernet <void@manifault.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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

On Wed, Dec 28, 2022 at 10:40 PM David Vernet <void@manifault.com> wrote:
>
> On Sat, Dec 17, 2022 at 12:24:54AM -0800, Dave Marchevsky wrote:
> > Currently, kfuncs marked KF_RELEASE indicate that they release some
> > previously-acquired arg. The verifier assumes that such a function will
> > only have one arg reg w/ ref_obj_id set, and that that arg is the one to
> > be released. Multiple kfunc arg regs have ref_obj_id set is considered
> > an invalid state.
> >
> > For helpers, RELEASE is used to tag a particular arg in the function
> > proto, not the function itself. The arg with OBJ_RELEASE type tag is the
> > arg that the helper will release. There can only be one such tagged arg.
> > When verifying arg regs, multiple helper arg regs w/ ref_obj_id set is
> > also considered an invalid state.
> >
> > Later patches in this series will result in some linked_list helpers
> > marked KF_RELEASE having a valid reason to take two ref_obj_id args.
> > Specifically, bpf_list_push_{front,back} can push a node to a list head
> > which is itself part of a list node. In such a scenario both arguments
> > to these functions would have ref_obj_id > 0, thus would fail
> > verification under current logic.
> >
> > This patch changes kfunc ref_obj_id searching logic to find the last arg
> > reg w/ ref_obj_id and consider that the reg-to-release. This should be
> > backwards-compatible with all current kfuncs as they only expect one
> > such arg reg.
>
> Can't say I'm a huge fan of this proposal :-( While I think it's really
> unfortunate that kfunc flags are not defined per-arg for this exact type
> of reason, adding more flag-specific semantics like this is IMO a step
> in the wrong direction.  It's similar to the existing __sz and __k
> argument-naming semantics that inform the verifier that the arguments
> have special meaning. All of these little additions of special-case
> handling for kfunc flags end up requiring people writing kfuncs (and
> sometimes calling them) to read through the verifier to understand
> what's going on (though I will say that it's nice that __sz and __k are
> properly documented in [0]).

Before getting to pros/cons of KF_* vs name suffix vs helper style
per-arg description...
It's important to highlight that here we're talking about
link list and rb tree kfuncs that are not like other kfuncs.
Majority of kfuncs can be added by subsystems like hid-bpf
without touching the verifier.
Here we're paving the way for graph (aka new gen data structs)
and so far not only kfuncs, but their arg types have to have
special handling inside the verifier.
There is not much yet to generalize and expose as generic KF_
flag or as a name suffix.
Therefore I think it's more appropriate to implement them
with minimal verifier changes and minimal complexity.
There is no 3rd graph algorithm on the horizon after link list
and rbtree. Instead there is a big todo list for
'multi owner graph node' and 'bpf_refcount_t'.
Those will require bigger changes in the verifier,
so I'd like to avoid premature generalization :) as analogous
to premature optimization :)
