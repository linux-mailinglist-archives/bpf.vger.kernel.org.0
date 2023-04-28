Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7716F2176
	for <lists+bpf@lfdr.de>; Sat, 29 Apr 2023 01:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346621AbjD1X7x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 19:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjD1X7w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 19:59:52 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11E2213C
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 16:59:50 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-518d325b8a2so365297a12.0
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 16:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682726390; x=1685318390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVp1M1/KIVht30zWppXGrDsK4XnG/NqceW7/0Cw1cxY=;
        b=DzfYCeJqgs6XVJofDJsEKflxo/+zvscs6V5AxsvpSVjvGkFN7/m2eajAu8mLulIgeH
         XZsziatILI2+IABW6KftYRe87Cv5VV9n0yPf7+qGJi35QECnXlM5PlsBRbYDmzKboVlb
         YS71s5+blNF3934vMZHpbhtUPKiydEZ/+EtiZDF6Ft/VjSUxakKlapLGXvvwVdGcR6dD
         0rGaNoN3BuArFen1T2YLgTFg6bmHbj83UErIQsINlOOM4TEKRR2wp+8WgLIWi0GnWavR
         oE9xdruHg10A/QqLHt03aK6FlhAMeapt1rbGFvX+Ggmeq5JJWzR4IKMXF5zC3ZFWoiWA
         Ja1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682726390; x=1685318390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVp1M1/KIVht30zWppXGrDsK4XnG/NqceW7/0Cw1cxY=;
        b=gSJ4fULOMITHT/7dioFUAO0w+Lcmo/jm7LVkNE0kJRjDPISIYcQclU9xLoAukho28Z
         Zo0rA5nufRs54nb6UC+dCdE5DFSdwOCk2it3yH7wKCkqspuxa8nQJfk+kx5dCcV69DKN
         NJ1xnRsbazQc+8mTYswZib84R6sxMG7PARn1lyuI0gFeVk5b9uUZG8O41yJ+vDw7Axi0
         6j1AfShWjNfZpw2paFYomU81AKoYNqMF+WZoaqQcJ04Igo1I54jvHubTHxmNnUoFux7j
         q14ZT2edeeyGbb3wxcyOLQ9UdJ3pgf6jYJXaaqoLoJwH8/flhnWY08fY4yWyksPqog0u
         KpoA==
X-Gm-Message-State: AC+VfDxDxmescJI/Y5Ht2DSHDPpWza5dWxmFpmrhFg7mCXobjfGhRefg
        Y1G9IGp/fs5T0LwIFejgYEWyTlwbD3aa9NEu6eYLiA==
X-Google-Smtp-Source: ACHHUZ47SqQfe8BMa2KNApgOUldgy03ihHuj8tF/vr2bmwBoLqaS55huDUgA5QzR7YPApA1GYn9g9yDFl1CmLr5mQwQ=
X-Received: by 2002:a17:90a:bb17:b0:24d:d7fd:86c3 with SMTP id
 u23-20020a17090abb1700b0024dd7fd86c3mr153962pjr.16.1682726390278; Fri, 28 Apr
 2023 16:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230427200409.1785263-1-sdf@google.com> <20230427200409.1785263-3-sdf@google.com>
 <ac7c31cc-7f8f-1066-1aa1-ad4d734998c5@linux.dev>
In-Reply-To: <ac7c31cc-7f8f-1066-1aa1-ad4d734998c5@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 28 Apr 2023 16:59:39 -0700
Message-ID: <CAKH8qBu=ehBZsusAaVwxO1DNK=NxFupR8RwtotsPSZmdiTw=Zw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: Update EFAULT
 {g,s}etsockopt selftests
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Apr 28, 2023 at 4:57=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 4/27/23 1:04 PM, Stanislav Fomichev wrote:
> > Instead of assuming EFAULT, let's assume the BPF program's
> > output is ignored.
> >
> > Remove "getsockopt: deny arbitrary ctx->retval" because it
> > was actually testing optlen. We have separate set of tests
> > for retval.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >   .../selftests/bpf/prog_tests/sockopt.c        | 80 +++++++++++++++++-=
-
> >   1 file changed, 74 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/t=
esting/selftests/bpf/prog_tests/sockopt.c
> > index aa4debf62fc6..8dad30ce910e 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
> > @@ -273,10 +273,30 @@ static struct sockopt_test {
> >               .error =3D EFAULT_GETSOCKOPT,
> >       },
> >       {
> > -             .descr =3D "getsockopt: deny arbitrary ctx->retval",
> > +             .descr =3D "getsockopt: ignore >PAGE_SIZE optlen",
> >               .insns =3D {
> > -                     /* ctx->retval =3D 123 */
> > -                     BPF_MOV64_IMM(BPF_REG_0, 123),
> > +                     /* write 0xFF to the first optval byte */
> > +
> > +                     /* r6 =3D ctx->optval */
> > +                     BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1,
> > +                                 offsetof(struct bpf_sockopt, optval))=
,
> > +                     /* r2 =3D ctx->optval */
> > +                     BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
> > +                     /* r6 =3D ctx->optval + 1 */
> > +                     BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
> > +
> > +                     /* r7 =3D ctx->optval_end */
> > +                     BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_1,
> > +                                 offsetof(struct bpf_sockopt, optval_e=
nd)),
> > +
> > +                     /* if (ctx->optval + 1 <=3D ctx->optval_end) { */
> > +                     BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
> > +                     /* ctx->optval[0] =3D 0xF0 */
> > +                     BPF_ST_MEM(BPF_B, BPF_REG_2, 0, 0xFF),
> > +                     /* } */
> > +
> > +                     /* ctx->retval =3D 0 */
> > +                     BPF_MOV64_IMM(BPF_REG_0, 0),
> >                       BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
> >                                   offsetof(struct bpf_sockopt, retval))=
,
> >
> > @@ -287,9 +307,10 @@ static struct sockopt_test {
> >               .attach_type =3D BPF_CGROUP_GETSOCKOPT,
> >               .expected_attach_type =3D BPF_CGROUP_GETSOCKOPT,
> >
> > -             .get_optlen =3D 64,
> > -
> > -             .error =3D EFAULT_GETSOCKOPT,
> > +             .get_level =3D 1234,
> > +             .get_optname =3D 5678,
> > +             .get_optval =3D {}, /* the changes are ignored */
> > +             .get_optlen =3D 4096 + 1,
>
> The patchset looks good. Thanks for taking care of it.
>
> One question, is it safe to the assume 4096 page size for all platforms i=
n the
> selftests?

Good question; let me respin with sysconf() just to be safe..
