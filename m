Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47643662463
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 12:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjAILk2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 06:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbjAILkF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 06:40:05 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A64BBC
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 03:40:04 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id b17so1696601pld.7
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 03:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w8inhaCjfnPZaeONRMBj8RCnjk4ubcoC8sf61WBoNjc=;
        b=T1pzQvBAJLNtnU44KYqHGo3ulYw9mgQyyUqSWZnBdRiluUU+SukO2d3ZQ31Xc2rUIa
         mINU1uIylvNLWTDF6E+DCW439WWKbW6xW/3rXO1pVVDJhpGkY+rAzE/Dtwr3PBsgDW7f
         MR6CMP3ZGToOGePAuNsNpxKnLYPYYE3xtOcoo0NogJdWXB9cyQZ6vweKetDjWS57YnUm
         DQTt0YJbajxWCnfYMx3dfygxL8NYqHRBNcTtdBYtVGAHJIz6M7z/OfAQhZRaDjIx3GJY
         wI7Zqdf7kmBLlekwwBqpvp0ei5NyP4E365+m970Ky/vow12i0xUtlgpoLJUcJSN7wrQw
         366Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8inhaCjfnPZaeONRMBj8RCnjk4ubcoC8sf61WBoNjc=;
        b=6UpQ+wQFvR1/Gq/1hFqy1qO4CCPkJUG9w/u3MXfrkAaHLf439jYP7sHMzR2DnjYqAO
         UDcbs+iRzLMGicNLd7n0SfHP3FBlMapZDsP+Opd/9wstWb4il47YaL4BJWaH+93ITCGX
         TTi4g/9PRQLW3a0gkwKF1GSx3nMMf5beRK+ppG8KCkxKgmy5ZduxDHsw040ra/u0wzvm
         z52zZQfEMVrwld6C9Jt5zCrwWMvsoDGDRdfm5U0WlO3gr9F4zmE6F9vbK5joR+qW7Xr3
         vVrLaMGUzciQzrgV1HOiuXiMKrQ8y/1mvtADXgXEiNIESc+r/6RCx6o3Q7JRdUivJZbt
         yRkA==
X-Gm-Message-State: AFqh2kqKOyy6X76hzMX4uXf5ijVGoNffgckRqSz7rqI80n9b6vRlIcZC
        YBrWh7E03bWLktqre7PFMgg=
X-Google-Smtp-Source: AMrXdXt6JqFjZpaymns2ieM6IhhXNPJQZSsoMlE7Ei/ZBeyknlrMY+r/WJiWlNgnQNV3j5H4DNdCtA==
X-Received: by 2002:a17:902:e04b:b0:192:6b23:e38b with SMTP id x11-20020a170902e04b00b001926b23e38bmr53794548plx.24.1673264404095;
        Mon, 09 Jan 2023 03:40:04 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902654400b0018bde2250fcsm4549436pln.203.2023.01.09.03.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 03:40:03 -0800 (PST)
Date:   Mon, 9 Jan 2023 17:10:01 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v1 4/8] bpf: Allow reinitializing unreferenced
 dynptr stack slots
Message-ID: <20230109114001.54xlg56d7brhdenx@apollo>
References: <20230101083403.332783-1-memxor@gmail.com>
 <20230101083403.332783-5-memxor@gmail.com>
 <CAEf4BzYVjd=Z-7n1E=wsMdPD-guOoDz-Cedc9=+QisZ9m2150w@mail.gmail.com>
 <CAJnrk1athR7gdpN4HvQS07WH70OymLzE0Bb+wc1eDz8yeJ4rfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1athR7gdpN4HvQS07WH70OymLzE0Bb+wc1eDz8yeJ4rfg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jan 07, 2023 at 01:03:24AM IST, Joanne Koong wrote:
> On Wed, Jan 4, 2023 at 2:44 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sun, Jan 1, 2023 at 12:34 AM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > Consider a program like below:
> > >
> > > void prog(void)
> > > {
> > >         {
> > >                 struct bpf_dynptr ptr;
> > >                 bpf_dynptr_from_mem(...);
> > >         }
> > >         ...
> > >         {
> > >                 struct bpf_dynptr ptr;
> > >                 bpf_dynptr_from_mem(...);
> > >         }
> > > }
> > >
> > > Here, the C compiler based on lifetime rules in the C standard would be
> > > well within in its rights to share stack storage for dynptr 'ptr' as
> > > their lifetimes do not overlap in the two distinct scopes. Currently,
> > > such an example would be rejected by the verifier, but this is too
> > > strict. Instead, we should allow reinitializing over dynptr stack slots
> > > and forget information about the old dynptr object.
> > >
> >
> > As mentioned in the previous patch, shouldn't we allow this only for
> > dynptrs that don't require OBJ_RELEASE, which would be those with
> > ref_obj_id == 0?
> >
>
> +1
>

Ack, I'll make this change.

> >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 16 +++++++++-------
> > >  1 file changed, 9 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index b985d90505cc..e85e8c4be00d 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -786,6 +786,9 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
> > >         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
> > >                 return -EINVAL;
> > >
> > > +       destroy_stack_slots_dynptr(env, state, spi);
> > > +       destroy_stack_slots_dynptr(env, state, spi - 1);
>
> We don't need the 2nd call since destroy_slots_dynptr() destroys both slots
>

We do, I'll add a comment explaining this.
There are two cases.

    [d1][d1][d2][d2]
spi   3   2   1   0

If initializing on spi = 3, it will destroy d1, spi - 1 will see no STACK_DYNPTR
and simply ignore the call.
But in case we initialize on spi = 2, it will destroy d1 but not d2, only the
next call will destroy the dynptr at d2.

So for the case where we initialize over slots of two adjacent dynptrs, we'll
miss that case without making the 2nd call.

The call simply means 'destroy any dynptr which spi belongs to'. So it needs to
be made for both, as both spi and spi-1 may belong to different dynptrs.
