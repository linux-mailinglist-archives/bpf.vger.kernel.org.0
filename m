Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2895066072D
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 20:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjAFTdh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 14:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbjAFTdg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 14:33:36 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C5E68C8C
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 11:33:35 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id g4so2911359ybg.7
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 11:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zl+K9mBsHqYH3SpXS6JEsVU8sQnntUil4q2yO9vk4Wk=;
        b=NCDZvzwpbQiFX2sUlxE/JnRNCMI+YDGaG8BPqBYUsancr3nuPT3j00vddcl3a+n34V
         osudKkvLcpCKUU7FUd84CqG+noYdVhjWcfhbzPGiuoaT6kKU0m8QMgPwq3WVtoRmn9ro
         1QFypWprwKxvzHM++OaTmRs7Wp/tqzKqrtJEsDtRBOKiYA5HXJAHVlL5jt/WWHsiE8mu
         Fd7Do3hZkno/WTMCiUdFRWqRPmQQnfursmd1xXyoWC3Q2rqOxrkEFBwMZ89u+hI6Etea
         14J5swz/p6UrH//52Ygaip1dhlG5yAkUv1pROHplGHq/cHm/Qa6eGF47PSLyrvFLax/V
         mK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zl+K9mBsHqYH3SpXS6JEsVU8sQnntUil4q2yO9vk4Wk=;
        b=Qx/3TrK/p1w6q1/TZ7UGzFmVc4Yxf4g8TN67o6M6gBvVyyMyn9F8I/JrqdHOyMMY/c
         Lqbdpr4MPP7ulkKZrIgA8jyoDyponPHv1Ofx4MEUnqdFfkJjQD7f7Z7mDy9QeqgaPuAo
         oGJ8F1XIRGGKa5tpQYGdNWqyFUefn2EnlG+NU9P4/3s40Sq2fzdkr1yIUw4E3mBaL/0T
         O8adVikB8E8l3r4jpSrMJDfAVXFcw+2Yg1U+Ls+sa+CP+BIlObMK6Itto8MY0tu2KR8Y
         tdm7hXB3Hr2Nx8SVJTw1HXZp3r4Win5rXGqaokinYbpExKsZ1QBvDuVtn48V1u/yxy4n
         FJDA==
X-Gm-Message-State: AFqh2kqsF3n8pzCDmfpz3z5/t40vOHoW2OABq48dnTwsHo64gpVz8BbY
        lX5QV+wt742ruCaewN8RpPE9FIwz6Ac9KVMJ0UU=
X-Google-Smtp-Source: AMrXdXsigtXk+Or2DYnh54FLvfz+zOxmke9lex5w9foIj+7QT5tney1bdS+gBWnSjf57t8JabibtQbf1CEvnhYvXFGY=
X-Received: by 2002:a25:b78c:0:b0:769:74cd:9c63 with SMTP id
 n12-20020a25b78c000000b0076974cd9c63mr5603900ybh.257.1673033615131; Fri, 06
 Jan 2023 11:33:35 -0800 (PST)
MIME-Version: 1.0
References: <20230101083403.332783-1-memxor@gmail.com> <20230101083403.332783-5-memxor@gmail.com>
 <CAEf4BzYVjd=Z-7n1E=wsMdPD-guOoDz-Cedc9=+QisZ9m2150w@mail.gmail.com>
In-Reply-To: <CAEf4BzYVjd=Z-7n1E=wsMdPD-guOoDz-Cedc9=+QisZ9m2150w@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 6 Jan 2023 11:33:24 -0800
Message-ID: <CAJnrk1athR7gdpN4HvQS07WH70OymLzE0Bb+wc1eDz8yeJ4rfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/8] bpf: Allow reinitializing unreferenced
 dynptr stack slots
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
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

On Wed, Jan 4, 2023 at 2:44 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Jan 1, 2023 at 12:34 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Consider a program like below:
> >
> > void prog(void)
> > {
> >         {
> >                 struct bpf_dynptr ptr;
> >                 bpf_dynptr_from_mem(...);
> >         }
> >         ...
> >         {
> >                 struct bpf_dynptr ptr;
> >                 bpf_dynptr_from_mem(...);
> >         }
> > }
> >
> > Here, the C compiler based on lifetime rules in the C standard would be
> > well within in its rights to share stack storage for dynptr 'ptr' as
> > their lifetimes do not overlap in the two distinct scopes. Currently,
> > such an example would be rejected by the verifier, but this is too
> > strict. Instead, we should allow reinitializing over dynptr stack slots
> > and forget information about the old dynptr object.
> >
>
> As mentioned in the previous patch, shouldn't we allow this only for
> dynptrs that don't require OBJ_RELEASE, which would be those with
> ref_obj_id == 0?
>

+1

>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index b985d90505cc..e85e8c4be00d 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -786,6 +786,9 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
> >         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
> >                 return -EINVAL;
> >
> > +       destroy_stack_slots_dynptr(env, state, spi);
> > +       destroy_stack_slots_dynptr(env, state, spi - 1);

We don't need the 2nd call since destroy_slots_dynptr() destroys both slots

> > +
> >         for (i = 0; i < BPF_REG_SIZE; i++) {
> >                 state->stack[spi].slot_type[i] = STACK_DYNPTR;
> >                 state->stack[spi - 1].slot_type[i] = STACK_DYNPTR;
> > @@ -901,7 +904,7 @@ static void destroy_stack_slots_dynptr(struct bpf_verifier_env *env,
> >  static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> >  {
> >         struct bpf_func_state *state = func(env, reg);
> > -       int spi, i;
> > +       int spi;
> >
> >         if (reg->type == CONST_PTR_TO_DYNPTR)
> >                 return false;
> > @@ -914,12 +917,11 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
> >         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
> >                 return true;
> >
> > -       for (i = 0; i < BPF_REG_SIZE; i++) {
> > -               if (state->stack[spi].slot_type[i] == STACK_DYNPTR ||
> > -                   state->stack[spi - 1].slot_type[i] == STACK_DYNPTR)
> > -                       return false;
> > -       }
> > -
> > +       /* We allow overwriting existing STACK_DYNPTR slots, see
> > +        * mark_stack_slots_dynptr which calls destroy_stack_slots_dynptr to
> > +        * ensure dynptr objects at the slots we are touching are completely
> > +        * destructed before we reinitialize them for a new one.
> > +        */
> >         return true;
> >  }
> >
> > --
> > 2.39.0
> >
