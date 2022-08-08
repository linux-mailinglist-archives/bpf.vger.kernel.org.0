Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C18258D080
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 01:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbiHHXcy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 19:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiHHXcx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 19:32:53 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC57183BD;
        Mon,  8 Aug 2022 16:32:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x21so13174892edd.3;
        Mon, 08 Aug 2022 16:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CIXA4MSQ+6QaYHNm/6Jco4hxXt/+NqpIOuwnKHF6mgk=;
        b=XXnOJtMc9+m/JOakJbcKPG7GWV9MFHJ/hTyU2WrnDcsXY0as0Z5X3u+rMA7dWscD8S
         pJ2wdJOARfOUyZINLUTK+4ZtqdHBRA8AaLO17PEtyQZaToad+COLAL3tgP1X6xKvxdun
         h1lp18ByrOMG5DtdwFtD3w4IxO0opTEWqUOhOUu39WwH3dhIiY6jw31st3KgtSTQThdv
         E+vMPZmgk1xpTwp21p5Gz/4h7eBoP0nIrNDyKMaXsmwqoivlU3l3HPLS/gCW4ml4eDHI
         un5l001XYMqcXs95HQBKH08kzLYJXf3qZaacJlwhiVNC5koYA61OcmUVD98hvkynlPFO
         klIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CIXA4MSQ+6QaYHNm/6Jco4hxXt/+NqpIOuwnKHF6mgk=;
        b=FXYudtVtIAudWR+etZa9Bl0x9Ylbj2Vo8OL6EFOgjBz/vlfgpt8kRd55crDEGYw3dk
         QijUnd5uLNqIKT4UiBXG3yDenbqaUo9rIO0XOWMmDDi0RSWNaQ9NNjTQxCFtUPfKQq+p
         zv4hI2sIgHayPDvCqobg1MDsvNS+A8jOZ8yqkamioZSb6dKZkCSNXSGb1l49bFtF4zFd
         4i+800ryG2cWyekIBaaL4BeXCEWjGyjLun4MG6gLnM1zfu74Ls2VjSPH+Z0r3GmCbNKJ
         v2guy2wR4hEqngELZ3MBoLID+zaC1hOWN1nOzv+/Vy7Mzr3JNxKhvrLHF0pfYCyBKiah
         nexA==
X-Gm-Message-State: ACgBeo1lFS7C5mQ+xrj9rKym1f9UZpGEIuPJVwJTin3BCMlA4CaKK+M3
        nsM2TkRCNM6GiWxMMYjinszW1N6ySAwzX2SBLIo=
X-Google-Smtp-Source: AA6agR7dWx4nxeXPZUvLRcmd4Xv1CsTtnzQ3CR5cfJOyE7vfan0wvHnMI48RgsMf8DqYYC5/cc8cY0hk+ZGRr+GJ3DQ=
X-Received: by 2002:a05:6402:2b98:b0:43e:107:183d with SMTP id
 fj24-20020a0564022b9800b0043e0107183dmr19812321edb.366.1660001570729; Mon, 08
 Aug 2022 16:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220808155341.2479054-1-void@manifault.com> <CAJnrk1YL1N371vkRDx9E6_OU2GwCj4sVzasBdjmYNUBuzygF_g@mail.gmail.com>
 <20220808185021.6papg2iwujlcaqlc@dev0025.ash9.facebook.com>
In-Reply-To: <20220808185021.6papg2iwujlcaqlc@dev0025.ash9.facebook.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 8 Aug 2022 16:32:39 -0700
Message-ID: <CAJnrk1bxiYfaR-2aM-PQdg75UQxWt0XJZxxrMs3sfZo02vvkYw@mail.gmail.com>
Subject: Re: [PATCH 1/5] bpf: Clear callee saved regs after updating REG0
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, Kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 8, 2022 at 11:50 AM David Vernet <void@manifault.com> wrote:
>
> On Mon, Aug 08, 2022 at 11:14:48AM -0700, Joanne Koong wrote:
> > On Mon, Aug 8, 2022 at 8:53 AM David Vernet <void@manifault.com> wrote:
> > >
> > > In the verifier, we currently reset all of the registers containing caller
> > > saved args before updating the callee's return register (REG0). In a
> > > follow-on patch, we will need to be able to be able to inspect the caller
> > > saved registers when updating REG0 to determine if a dynptr that's passed
> > > to a helper function was allocated by a helper, or allocated by a program.
> > >
> > > This patch therefore updates check_helper_call() to clear the caller saved
> > > regs after updating REG0.
> > >
> > Overall lgtm
>
> Thanks for the quick review!
>
> > There's a patch [0] that finds + stores the ref obj id before the
> > caller saved regs get reset, which would make this patch not needed.
>
> Interesting. Indeed, that would solve this issue, and I'm fine with that
> approach as well, if not preferential to it.
>
> > That hasn't been merged in yet though and I think there's pros for
> > either approach.
> >
> > In the one where we find + store the ref obj id before any caller
> > saved regs get reset, the pro is that getting the dynptr metadata (eg
> > ref obj id and in the near future, the dynptr type as well) earlier
> > will be useful (eg when we add skb/xdp dynptrs [1], we'll need to know
> > the type of the dynptr in order to determine whether to set the return
> > reg as PTR_TO_PACKET). In this patch, the pro is that the logic is a
> > lot more obvious to readers that the ref obj id for the dynptr gets
> > found and set in order to store it in the return reg's ref obj id.
> >
> > I personally lean more towards the approach in [0] because I think
> > that ends up being cleaner for future extensibility, but I don't feel
> > strongly about it and would be happy going with this approach as well
>
> So, I think regardless of whether this gets merged, [0] is probably worth
> merging as I agree that it simplifies the current logic for setting the ref
> obj id and is a purely positive change on its own.
>
> When I was originally typing my response to your email, I was wondering
> whether it would be useful to keep the state in the caller saved registers
> for the logic in 7360 - 7489 in general for the future even if [0] is
> applied. It's probably simpler, however, to keep what we have now and just
> reset all of the registers. So if [0] gets merged, I can just remove this
> patch from the set.

sounds great!

>
> > [0] https://lore.kernel.org/bpf/20220722175807.4038317-1-joannelkoong@gmail.com/#t
> >
> > [1] https://lore.kernel.org/bpf/20220726184706.954822-1-joannelkoong@gmail.com/T/#t
> >
> > > Signed-off-by: David Vernet <void@manifault.com>
> > > ---
> > >  kernel/bpf/verifier.c | 15 ++++++++++-----
> > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 096fdac70165..938ba1536249 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -7348,11 +7348,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> > >         if (err)
> > >                 return err;
> > >
> > > -       /* reset caller saved regs */
> > > -       for (i = 0; i < CALLER_SAVED_REGS; i++) {
> > > -               mark_reg_not_init(env, regs, caller_saved[i]);
> > > -               check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
> > > -       }
> > > +       /* reset return reg */
> > > +       mark_reg_not_init(env, regs, BPF_REG_0);
> > > +       check_reg_arg(env, BPF_REG_0, DST_OP_NO_MARK);
> > >
> > >         /* helper call returns 64-bit value. */
> > >         regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
> > > @@ -7488,6 +7486,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> > >                 regs[BPF_REG_0].ref_obj_id = dynptr_id;
> > >         }
> > >
> > > +       /* reset remaining caller saved regs */
> > > +       BUILD_BUG_ON(caller_saved[0] != BPF_REG_0);
> >
> > nit: caller_saved is a read-only const, so I don't think this line is needed
>
> It being a read-only const is was why I made this a BUILD_BUG_ON. My
> intention here was to ensure that we're not accidentally skipping the
> resetting of caller_saved[0]. The original code iterated from
> caller_saved[0] -> caller_saved[CALLER_SAVED_REGS - 1]. Now that we're
> starting from caller_saved[1], this compile-time assertion verifies that
> we're not accidentally skipping caller_saved[0] by checking that it's the
> same as BPF_REG_0, which is reset above. Does that make sense?

I think it's an invariant that r0 - r5 are the caller saved args and
that caller_saved[0] will always be BPF_REG_0. I'm having a hard time
seeing a case where this would change in the future, but then again, I
am also not a fortune teller so maybe I am wrong here :) I don't think
it's a big deal though so I don't feel strongly about this

>
> > > +       for (i = 1; i < CALLER_SAVED_REGS; i++) {
> >
> > nit: maybe "for i = BPF_REG_1" ?
>
> Good suggestion, will apply in the v2 (if there is one and we don't decide
> to just go with [0] :-))
>
> Thanks,
> David
