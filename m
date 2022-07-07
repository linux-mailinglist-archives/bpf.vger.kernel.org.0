Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B2E56AED4
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 01:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbiGGXH0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 19:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbiGGXH0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 19:07:26 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D128610FFB
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 16:07:24 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso235245pjo.0
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 16:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P80ntBkVpAcsj2MWPd0PznGt2UbGJIAet138D5TXy4M=;
        b=WmGbZOObEKUsa+PvGTFfRdqSqk0gu36sEhij46xSehzsWaBrIt6EttQNG8N0tLTQS6
         KAQzGUBAOMJzFiP3QWCbCqfFY984qFHp3Qke1rpHtOfR6U/mVl6CUODvcJEXx5NM7M6l
         yxWWAKTLELaUNAzU1GNt0qL4BrJuyjdjqPPGUTHaf90hHX9HPOK5t+kA0slzblZ5ijCO
         r1rgw4VZFgBqqgWNB12bDDrQy1fFzwjtq3jTyKHW2yCd8IzmmdkPPOYZ62nRk8ZL7fBY
         B+mB/SigQbbbOhcK9F6IWtR9WGKiZzLUKaZbWFyxNnOiVKlahp4psko2uM8JFIxtnHxq
         GKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P80ntBkVpAcsj2MWPd0PznGt2UbGJIAet138D5TXy4M=;
        b=W4TH5VZznXZoSuhXCeGaawj3R1acFJncXKxzU8Z/kJKO2m6pbh3NcRw2IEvXAycOIp
         W/qD/xWpth41t3jU5zO9lNWKRt9RqDKUpntZJvy7bNVposwLtAsv+6RcAhinfjgPUvPW
         HXgZS7bH4VVgJDUnI+pcwn9cATT3+mF7LO8Cyny/KG7pBFBXPGOFJHPm0CmEU87AJJjL
         sG04eD4lD6ov6f1+MBPXu0PRIBuVEOO6bmZ+7o5zoSHzh0nUs6L5dzKfoYmsJoVmbaSk
         l3EI17nI0rQjYaRKB2NzDEZFcUCRZFh8qIP4hQUHqh90qAwMfRpSvIVoxfGUaJrH0Myr
         BIqg==
X-Gm-Message-State: AJIora9jH+j906FMDZwK7WthBYeQRdGVoPf7irAQLVO9uMOeRQ2LD5CG
        Ggjynnx5eF05k6v77ZnD/I+MpYKFyXVDcz0GwisFUw==
X-Google-Smtp-Source: AGRyM1v3RhdzRU2Giu0Uq1JwgnhTw+jeqxzl4LMnVlFLsUMIytKfWqjFGvUa1VsthwCIYIRIg/XC3U96cI6NxsaPCxA=
X-Received: by 2002:a17:90b:388b:b0:1ed:406:492c with SMTP id
 mu11-20020a17090b388b00b001ed0406492cmr304236pjb.31.1657235244123; Thu, 07
 Jul 2022 16:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220707160233.2078550-1-sdf@google.com> <20220707181451.6xdtdesokuetj4ud@kafai-mbp.dhcp.thefacebook.com>
 <YscxieVQayT2cVgi@google.com> <20220707220854.cbbydamsasjctxos@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220707220854.cbbydamsasjctxos@kafai-mbp.dhcp.thefacebook.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 7 Jul 2022 16:07:13 -0700
Message-ID: <CAKH8qBtM=oaZey8s5aTumK77OtSJtxSi1gU7P8vqsuyUj7Mvrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: check attach_func_proto more carefully
 in check_return_code
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        syzbot+5cc0730bd4b4d2c5f152@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 7, 2022 at 3:09 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Thu, Jul 07, 2022 at 12:18:33PM -0700, sdf@google.com wrote:
> > On 07/07, Martin KaFai Lau wrote:
> > > On Thu, Jul 07, 2022 at 09:02:33AM -0700, Stanislav Fomichev wrote:
> > > > Syzkaller reports the following crash:
> > > > RIP: 0010:check_return_code kernel/bpf/verifier.c:10575 [inline]
> > > > RIP: 0010:do_check kernel/bpf/verifier.c:12346 [inline]
> > > > RIP: 0010:do_check_common+0xb3d2/0xd250 kernel/bpf/verifier.c:14610
> > > >
> > > > With the following reproducer:
> > > > bpf$PROG_LOAD_XDP(0x5, &(0x7f00000004c0)={0xd, 0x3,
> > > &(0x7f0000000000)=ANY=[@ANYBLOB="1800000000000019000000000000000095"],
> > > &(0x7f0000000300)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, 0x2b,
> > > 0xffffffffffffffff, 0x8, 0x0, 0x0, 0x10, 0x0}, 0x80)
> > > >
> > > > Because we don't enforce expected_attach_type for XDP programs,
> > > > we end up in hitting 'if (prog->expected_attach_type == BPF_LSM_CGROUP'
> > > > part in check_return_code and follow up with testing
> > > > `prog->aux->attach_func_proto->type`, but `prog->aux->attach_func_proto`
> > > > is NULL.
> > > >
> > > > Add explicit prog_type check for the "Note, BPF_LSM_CGROUP that
> > > > attach ..." condition. Also, don't skip return code check for
> > > > LSM/STRUCT_OPS.
> > > >
> > > > The above actually brings an issue with existing selftest which
> > > > tries to return EPERM from void inet_csk_clone. Fix the
> > > > test (and move called_socket_clone to make sure it's not
> > > > incremented in case of an error) and add a new one to explicitly
> > > > verify this condition.
> > > >
> > > > v2:
> > > > - Martin: don't add new helper, check prog_type instead
> > > > - Martin: check expected_attach_type as well at the function entry
> > > > - Update selftest to verify this condition
> > > >
> > > > Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
> > > > Reported-by: syzbot+5cc0730bd4b4d2c5f152@syzkaller.appspotmail.com
> > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > ---
> > > >  kernel/bpf/verifier.c                              |  2 ++
> > > >  .../testing/selftests/bpf/prog_tests/lsm_cgroup.c  | 12 ++++++++++++
> > > >  tools/testing/selftests/bpf/progs/lsm_cgroup.c     | 12 ++++++------
> > > >  .../selftests/bpf/progs/lsm_cgroup_nonvoid.c       | 14 ++++++++++++++
> > > >  4 files changed, 34 insertions(+), 6 deletions(-)
> > > >  create mode 100644
> > > tools/testing/selftests/bpf/progs/lsm_cgroup_nonvoid.c
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index df3ec6b05f05..2bc1e7252778 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -10445,6 +10445,7 @@ static int check_return_code(struct
> > > bpf_verifier_env *env)
> > > >
> > > >   /* LSM and struct_ops func-ptr's return type could be "void" */
> > > >   if (!is_subprog &&
> > > > +     prog->expected_attach_type != BPF_LSM_CGROUP &&
> > > BPF_PROG_TYPE_STRUCT_OPS also uses the expected_attach_type,
> > > so the expected_attach_type check should only be done for LSM prog alone.
> > > Others lgtm.
> >
> > In this case, something like the following should be sufficient?
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 2bc1e7252778..6702a5fc12e6 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10445,11 +10445,13 @@ static int check_return_code(struct
> > bpf_verifier_env *env)
> >
> >       /* LSM and struct_ops func-ptr's return type could be "void" */
> >       if (!is_subprog &&
> > -         prog->expected_attach_type != BPF_LSM_CGROUP &&
> > -         (prog_type == BPF_PROG_TYPE_STRUCT_OPS ||
> > -          prog_type == BPF_PROG_TYPE_LSM) &&
> > -         !prog->aux->attach_func_proto->type)
> > -             return 0;
> > +         !prog->aux->attach_func_proto->type) {
> prog_type check has to be done first since prog->aux->attach_func_proto
> depends on the prog_type.
>
> How about a small tweak on top of yours ?

Looks good, thanks! Will test and resend sometime tomorrow.

>         /* LSM and struct_ops func-ptr's return type could be "void" */
>         if (!is_subprog) {
>                 switch (prog_type) {
>                 case BPF_PROG_TYPE_LSM:
>                         if (prog->expected_attach_type == BPF_LSM_CGROUP)
>                                 /* cgroup prog needs to return 0 or 1 */
>                                 break;
>                         fallthrough;
>                 case BPF_PROG_TYPE_STRUCT_OPS:
>                         if (!prog->aux->attach_func_proto->type)
>                                 return 0;
>                         break;
>                 default:
>                         break;
>                 }
>         }
>
> > +             if (prog_type == BPF_PROG_TYPE_STRUCT_OPS)
> > +                     return 0;
> > +             if (prog_type == BPF_PROG_TYPE_LSM &&
> > +                 prog->expected_attach_type != BPF_LSM_CGROUP)
> > +                     return 0;
> > +     }
> >
> >       /* eBPF calling convention is such that R0 is used
> >        * to return the value from eBPF program.
> >
> > > >       (prog_type == BPF_PROG_TYPE_STRUCT_OPS ||
> > > >        prog_type == BPF_PROG_TYPE_LSM) &&
> > > >       !prog->aux->attach_func_proto->type)
> > > > @@ -10572,6 +10573,7 @@ static int check_return_code(struct
> > > bpf_verifier_env *env)
> > > >   if (!tnum_in(range, reg->var_off)) {
> > > >           verbose_invalid_scalar(env, reg, &range, "program exit", "R0");
> > > >           if (prog->expected_attach_type == BPF_LSM_CGROUP &&
> > > > +             prog_type == BPF_PROG_TYPE_LSM &&
> > > >               !prog->aux->attach_func_proto->type)
> > > >                   verbose(env, "Note, BPF_LSM_CGROUP that attach to void LSM hooks
> > > can't modify return value!\n");
> > > >           return -EINVAL;
