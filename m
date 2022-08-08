Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE0958CDFD
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 20:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbiHHSu0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 14:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiHHSu0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 14:50:26 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5460D2BDB;
        Mon,  8 Aug 2022 11:50:25 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id m7so7138595qkk.6;
        Mon, 08 Aug 2022 11:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=CNwwDG91/cQtB9h9wroV5Dt5GugboE8Fb+whaUk8GuI=;
        b=23PUq3+Bl7np0FHtDFT0XM6ANHxmLMw8IWvoeAtmc6gJ6mUDZW8p41o08uL1IO/EdM
         sFxHwNC+/W5mnb7H7RoGrJVM0RaUskHNa2k6/tTOYJxQWmDPIuo3niCxqQ7LPCddGtbG
         dDqTV4RDhfADUf2QiasmzmhScmFmrDy1o/lcPcNSUHI3zFlPuYWBBwrngorOlzDeiI9m
         IYbE0K6JGx/VN7+BZ0FNR+1RO8HxZ82aS0BO++X2YRsZPnWP0gLl9pmGrYJZowfav0IT
         YQZOWuQRoygkhkRd7iEnox+osbsE/ibxY+lVBV+hCEzKjaxsDt9EHHVC1ys3pWo/FfNg
         drTQ==
X-Gm-Message-State: ACgBeo3u5GynXA1XFvKiKNy3oy0SQ9onhr/Pi9ieyd0qqeMBrRRhsXXE
        caVZQSR81I2AVn+q9IUUtV8=
X-Google-Smtp-Source: AA6agR4TY6QomiBko61+5U9hdoW4O8E3hlCC6sd8r4LQV7dQQzQTY/o0O+BlmAMZDPAYlN4iOSHrtg==
X-Received: by 2002:a05:620a:4411:b0:6b6:59a:5456 with SMTP id v17-20020a05620a441100b006b6059a5456mr14289184qkp.574.1659984624231;
        Mon, 08 Aug 2022 11:50:24 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-005.fbsv.net. [2a03:2880:20ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id f15-20020a05620a408f00b006b5905999easm10243404qko.121.2022.08.08.11.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 11:50:24 -0700 (PDT)
Date:   Mon, 8 Aug 2022 11:50:21 -0700
From:   David Vernet <void@manifault.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, Kernel-team@fb.com
Subject: Re: [PATCH 1/5] bpf: Clear callee saved regs after updating REG0
Message-ID: <20220808185021.6papg2iwujlcaqlc@dev0025.ash9.facebook.com>
References: <20220808155341.2479054-1-void@manifault.com>
 <CAJnrk1YL1N371vkRDx9E6_OU2GwCj4sVzasBdjmYNUBuzygF_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1YL1N371vkRDx9E6_OU2GwCj4sVzasBdjmYNUBuzygF_g@mail.gmail.com>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 08, 2022 at 11:14:48AM -0700, Joanne Koong wrote:
> On Mon, Aug 8, 2022 at 8:53 AM David Vernet <void@manifault.com> wrote:
> >
> > In the verifier, we currently reset all of the registers containing caller
> > saved args before updating the callee's return register (REG0). In a
> > follow-on patch, we will need to be able to be able to inspect the caller
> > saved registers when updating REG0 to determine if a dynptr that's passed
> > to a helper function was allocated by a helper, or allocated by a program.
> >
> > This patch therefore updates check_helper_call() to clear the caller saved
> > regs after updating REG0.
> >
> Overall lgtm

Thanks for the quick review!

> There's a patch [0] that finds + stores the ref obj id before the
> caller saved regs get reset, which would make this patch not needed.

Interesting. Indeed, that would solve this issue, and I'm fine with that
approach as well, if not preferential to it.

> That hasn't been merged in yet though and I think there's pros for
> either approach.
> 
> In the one where we find + store the ref obj id before any caller
> saved regs get reset, the pro is that getting the dynptr metadata (eg
> ref obj id and in the near future, the dynptr type as well) earlier
> will be useful (eg when we add skb/xdp dynptrs [1], we'll need to know
> the type of the dynptr in order to determine whether to set the return
> reg as PTR_TO_PACKET). In this patch, the pro is that the logic is a
> lot more obvious to readers that the ref obj id for the dynptr gets
> found and set in order to store it in the return reg's ref obj id.
> 
> I personally lean more towards the approach in [0] because I think
> that ends up being cleaner for future extensibility, but I don't feel
> strongly about it and would be happy going with this approach as well

So, I think regardless of whether this gets merged, [0] is probably worth
merging as I agree that it simplifies the current logic for setting the ref
obj id and is a purely positive change on its own.

When I was originally typing my response to your email, I was wondering
whether it would be useful to keep the state in the caller saved registers
for the logic in 7360 - 7489 in general for the future even if [0] is
applied. It's probably simpler, however, to keep what we have now and just
reset all of the registers. So if [0] gets merged, I can just remove this
patch from the set.

> [0] https://lore.kernel.org/bpf/20220722175807.4038317-1-joannelkoong@gmail.com/#t
> 
> [1] https://lore.kernel.org/bpf/20220726184706.954822-1-joannelkoong@gmail.com/T/#t
> 
> > Signed-off-by: David Vernet <void@manifault.com>
> > ---
> >  kernel/bpf/verifier.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 096fdac70165..938ba1536249 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -7348,11 +7348,9 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >         if (err)
> >                 return err;
> >
> > -       /* reset caller saved regs */
> > -       for (i = 0; i < CALLER_SAVED_REGS; i++) {
> > -               mark_reg_not_init(env, regs, caller_saved[i]);
> > -               check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
> > -       }
> > +       /* reset return reg */
> > +       mark_reg_not_init(env, regs, BPF_REG_0);
> > +       check_reg_arg(env, BPF_REG_0, DST_OP_NO_MARK);
> >
> >         /* helper call returns 64-bit value. */
> >         regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
> > @@ -7488,6 +7486,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >                 regs[BPF_REG_0].ref_obj_id = dynptr_id;
> >         }
> >
> > +       /* reset remaining caller saved regs */
> > +       BUILD_BUG_ON(caller_saved[0] != BPF_REG_0);
> 
> nit: caller_saved is a read-only const, so I don't think this line is needed

It being a read-only const is was why I made this a BUILD_BUG_ON. My
intention here was to ensure that we're not accidentally skipping the
resetting of caller_saved[0]. The original code iterated from
caller_saved[0] -> caller_saved[CALLER_SAVED_REGS - 1]. Now that we're
starting from caller_saved[1], this compile-time assertion verifies that
we're not accidentally skipping caller_saved[0] by checking that it's the
same as BPF_REG_0, which is reset above. Does that make sense?

> > +       for (i = 1; i < CALLER_SAVED_REGS; i++) {
> 
> nit: maybe "for i = BPF_REG_1" ?

Good suggestion, will apply in the v2 (if there is one and we don't decide
to just go with [0] :-))

Thanks,
David
