Return-Path: <bpf+bounces-1556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAFD718F7C
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 02:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4C91C20F8F
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 00:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2F310E9;
	Thu,  1 Jun 2023 00:23:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5C4EA1
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 00:23:52 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843EE11F
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 17:23:50 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2af225e5b4bso2567521fa.3
        for <bpf@vger.kernel.org>; Wed, 31 May 2023 17:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685579029; x=1688171029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GG1RjFwW4DWNdYD1UKHtP2oDV1lQL/iFPhMLiiwkw9Y=;
        b=MIvW0DH5bvZRuBHDWco42KXDknPWpRLAcngL4zx3jnqKDFytzWVRTAd9bHEyrSGd/6
         dAOZLloJU7klm0GxJ9iyuPHrAQK1Az4Zhc5apaiw4PyTDczxRBWgNtOVSe54l8S6kwXT
         joW3aZin5wi/n4Of/ryB42RK8t1IXjbJF1XURn2n1ilH7noegu5YH2773wg8z3tMEMDU
         prDRcJ/CdF/OAN0MH4+/odlL36bx9Sir4L1bnRmb/cgMiO5hIwQcAgGgYKYqFVgBqFx7
         6qL4UsBg1dJGuNxPMy+u9sLBSkKclFvTEingJF1dM5WJ5PRAjzUy6jmOzk3csFj1EyOX
         hJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685579029; x=1688171029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GG1RjFwW4DWNdYD1UKHtP2oDV1lQL/iFPhMLiiwkw9Y=;
        b=UfMM7n2t4BREvOxvhyqRofQWrlVDkHDMFNh3BafDDDkRf4+drNQiCti6Ksh6yQpIk/
         WQVd9MVVJdHAHAYjodFcCityoKFMSpF9orVsSH788sjJykhNNxqq1sMd6vExuK+jAYOX
         WIKe+iFbAjz43Ds/QEL0Nc7ow3gCKRNxQCSMAWAjLVd8/B/6wptLd38jnOnDzlFak4FH
         IVWRxCss5oeMMvGx7dFdIv3xslyW3d0ZUEoDh3QVPsO2SYHqZ22PRwz9HjEm0cMWGq31
         UItWapE2jekk18mcwb9pJFiA3sziUqgOTJRYNJA0+L0SPIO6wYWKLo9vS0OUNzOQhfbx
         Uxfg==
X-Gm-Message-State: AC+VfDwtAwrpWPhjbOCmA3Csvs2ofiMCYsNhqpGnXL9DxBcL9MwnCy/g
	705GO/jy75VbJORohgcGOgytJOz9e7sxADCB7v0=
X-Google-Smtp-Source: ACHHUZ7wOA856AsSArGuBvOjniyAL6OfUlV7CddjjyHm4yMrSaZ8RiUImDS4UlG9PMur3S9ox0eK0EsdM3CKsf0aNWA=
X-Received: by 2002:a05:651c:112:b0:2ad:92b9:83b4 with SMTP id
 a18-20020a05651c011200b002ad92b983b4mr3313793ljb.5.1685579028381; Wed, 31 May
 2023 17:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230530172739.447290-1-eddyz87@gmail.com> <20230530172739.447290-2-eddyz87@gmail.com>
 <CAEf4BzYJbzR0f5HyjLMJEmBdHkydQiOjdkk=K4AkXWTwnXsWEg@mail.gmail.com>
 <f2abf39bcd4de841a89bb248de9e242a880aaa93.camel@gmail.com>
 <CAEf4BzYjvjbm9g1N9Z04kXV1N3+KH+dZ_sq_0NWuhyuJ+A18UQ@mail.gmail.com>
 <a13ee48ac037d0dbb6796c7ea5965140ec7ef726.camel@gmail.com>
 <CAEf4BzYE_7m3FNc6dtZeKb6tNbW4xkhz6SVdV6KetD5reSer6A@mail.gmail.com>
 <aa64ee05281ec952df41b7a7842ed2836ae79762.camel@gmail.com>
 <CAEf4BzZVd2=QnXe-A_n9zBYKcsY=DiHhH3EG8yB9Cq5+8D5jcQ@mail.gmail.com>
 <eaa12a66fa3e06e24232507359fa0a07f43d514d.camel@gmail.com>
 <CAEf4Bza+60Wjbk=Hww1joxoykx+HeyP_Nv5igP7V0RZi=-3OVg@mail.gmail.com> <12d9acab03e76491a34318dc2973b60f10712239.camel@gmail.com>
In-Reply-To: <12d9acab03e76491a34318dc2973b60f10712239.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 31 May 2023 17:23:36 -0700
Message-ID: <CAEf4BzZNJmfNWTdkoGE__-G_1GMC4S2=xStpS92NtJts3PVWTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 31, 2023 at 4:42=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2023-05-31 at 15:54 -0700, Andrii Nakryiko wrote:
> > [...]
> >
> > well, what can I say... force all imprecise logic isn't that
> > straightforward either, but so far it still holds. And the big idea
> > here is similar: whatever happens between two checkpoints doesn't
> > matter if its effect is not visible at the end of the checkpoint.
> >
> > So I guess the intent of my proposal is correct: every time we mark r6
> > as precise, we should mark r7 as well in each state in which they are
> > still linked. Which necessitates to do this on each walk up the state
> > chain.
> >
> > At least let's give it a try and see how it holds up against existing
> > tests and whatever test you can come up with?..
>
> I'll try this thing, thanks a lot for all the input!
> Hopefully will get back tomorrow.

Great, let's see how it goes.

>
> > [...]
> >
> > BTW, I did contemplate extending jmp_history to contain extra flags
> > about "interesting" instructions, though. Specifically, last
> > unsupported case for precision backtracking is when register other
> > than r10 is used for stack access (which can happen when one passes a
> > pointer to a SCALAR to parent function's stack), for which having a
> > bit next to such instruction saying "this is really a stack access"
> > would help cover the last class of unsupported situations.
>
> Yes, it would have required some kind of redesign for this case as
> well. My expectation is that only a few registers get range on each
> find_equal_scalars() call, so storing big masks for all frame levels
> is very sub-optimal.
>
> > But this is a pretty significant complication. And to make it really
> > practical, we'd need to think very hard on how to implement
> > jmp_history more efficiently, without constant reallocations. I have a
> > hunch that jmp_history should be one large resizable array that all
> > states share and just point into different parts of it. When state is
> > pushed to the stack, we just remember at which index it starts. When a
> > state is finalized, its jump history segment shouldn't be needed by
> > that state and can be reused by its siblings and parent states.
> > Ultimately, we only have a linear chain of actively worked-on states
> > which do use jmp_history, and all others either don't need it
> > *anymore* (verified states) or don't need it *yet* (enqueued states).
> >
> > This would allow us to even have an exact "log of execution" with
> > insn_idx and associated extra information, but it will be code path
> > dependent, unlike bpf_insn_aux. And the best property is that it will
> > never grow beyond 1 million instructions deep (absolute worst case).
>
> I'm not sure I understand why is it bounded.
> Conditionals and loops potentially give big number of possible
> execution paths over a small number of instructions.
> So, keeping per-path / per-instruction still is going to blow up in
> terms of memory use. To keep it bounded (?) something smart needs to
> know which visited states could never be visited again.

#define BPF_COMPLEXITY_LIMIT_INSNS      1000000 /* yes. 1M insns */

that's the bound, you can't go above that

>
> > We might not even need backtracking in its current form if we just
> > proactively maintain involved registers information (something that we
> > currently derive during instruction interpretation in backtrack_insn).
>
> Well, precision marks still have to be propagated backwards, so some
> form of "backward movement" within a state will have to happen anyway.
> Like, we have a combination of forward and backward analyses in any case.
> Sounds a bit like you want to converge the design to some kind of a
> classical data flow analysis, but have states instead of basic blocks.

It's just an idea. And yes, there will still be backtracking, just
less of "let's try to understand what's going on based on instruction
itself". So instead of deriving that we are exiting from subprog, we
can have a flag that says "this instruction is exit from subprog". The
advantage would be an overall simplification and keeping instruction
interpretation in one place.

But this is offtopic, we can talk about this separately. It's not
urgent and not even imminent change.

>
> > So at some point I'd like to get to thinking and implementing this,
> > but it isn't the most pressing need right now, of course.
> > [...]

