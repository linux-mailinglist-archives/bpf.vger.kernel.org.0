Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151286F34FA
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 19:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjEARWj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 13:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjEARWj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 13:22:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F2AAF
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 10:22:37 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-247048f86c7so1867254a91.2
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 10:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682961757; x=1685553757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7qr7oMdU5snpdoqJjqsCI3MsZUQrdB0euSf+RhEyzo=;
        b=rRHPWq53PY4gJLnSLDGS2WRy4q4PllMG10fl94mIsMsqZtaOc7KCC2WSLG8kQs6tmd
         QK87c8feSoWHuQogH+WkjWQEmcbH7X4Uf1Rmbp+EPzstxpMJD71t/CAxgllhoOaaTKtv
         MNaGRhVrWn8PQcBGgCG2ebJO3/UrmUDNA5Cs1TqZnawn7Zdyj6MQ6Fii2CYljacAnxzi
         C7DRJuqypNc2WFPHTKt9kg35mJbyz4YEpFpGCqNEAdV8i9VGHJKzziA3nZqi1l1r7Y/J
         SFnlUrGdekVuzKl+jRFUSHZ/NnOBernvnRDoi8Th0AfaN5f2r4//jJY/zm0q3pPBBhPM
         ogGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682961757; x=1685553757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7qr7oMdU5snpdoqJjqsCI3MsZUQrdB0euSf+RhEyzo=;
        b=WnHJhpbp8nRHEsme+3iGbUlp+eeEE9l77EtUoDtf4+9rRNxpkE0tPr5aqQPKNy8gxD
         pWucS6i/95ekoukYTYdc6KCw+T1A1nEqBP5hAlP3cFHSm3M5Io4P1PIeq0eNsjNR445m
         UWATteq4FuAcBlZO6fF6OvxikiSc4sfZUr1TO1q4R9LQrHP4yxLAVItSnk7LPMgJuLlz
         FwxXgWmcL2oUx3xx4MoBryfWKP+bEK/sYipGkY0DTD59xeKvAyj/pSQD7u45/XKlWfs7
         Jg1616Uu5AeTcv89JSEZ3udfBvOdSmIaZTseHeWQCxR5XBMZny/b/JZictu8Z294pZBR
         JNBQ==
X-Gm-Message-State: AC+VfDzNe8rZ+rAOPCFFcwcxL0bzBkxs9MAVLHhD6gmuqlqO5BV60J3y
        /5RJH8+c31AalxbZqlUi9L05QQDQZvqhibakx2MyKg==
X-Google-Smtp-Source: ACHHUZ5axBFx/JVtbBxGRujzV0ABNEO9mJtqZ4MI2HiTKuyQ5vnQSg2nZGTenLfunqL7eOFEbeKeE9G2eYawppLWpHY=
X-Received: by 2002:a17:90b:4d0a:b0:247:8ce1:996e with SMTP id
 mw10-20020a17090b4d0a00b002478ce1996emr14509117pjb.29.1682961757031; Mon, 01
 May 2023 10:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230427200409.1785263-1-sdf@google.com> <20230427200409.1785263-3-sdf@google.com>
 <ac7c31cc-7f8f-1066-1aa1-ad4d734998c5@linux.dev> <CAKH8qBu=ehBZsusAaVwxO1DNK=NxFupR8RwtotsPSZmdiTw=Zw@mail.gmail.com>
 <CAKH8qBt-+GDxcfoQP6rmodQzRbZ-Lz11wUpVmP98zDm4qxJKAw@mail.gmail.com> <b87d7403-a64e-3678-19a0-1b0072ee4198@linux.dev>
In-Reply-To: <b87d7403-a64e-3678-19a0-1b0072ee4198@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 1 May 2023 10:22:25 -0700
Message-ID: <CAKH8qBs2wB95dMr=1rEu-cgOBWrY+wmD5mC_R=gaVOLX18HVgQ@mail.gmail.com>
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

On Fri, Apr 28, 2023 at 5:44=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 4/28/23 5:32 PM, Stanislav Fomichev wrote:
> > On Fri, Apr 28, 2023 at 4:59=E2=80=AFPM Stanislav Fomichev <sdf@google.=
com> wrote:
> >>
> >> On Fri, Apr 28, 2023 at 4:57=E2=80=AFPM Martin KaFai Lau <martin.lau@l=
inux.dev> wrote:
> >>>
> >>> On 4/27/23 1:04 PM, Stanislav Fomichev wrote:
> >>>> Instead of assuming EFAULT, let's assume the BPF program's
> >>>> output is ignored.
> >>>>
> >>>> Remove "getsockopt: deny arbitrary ctx->retval" because it
> >>>> was actually testing optlen. We have separate set of tests
> >>>> for retval.
> >>>>
> >>>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> >>>> ---
> >>>>    .../selftests/bpf/prog_tests/sockopt.c        | 80 ++++++++++++++=
+++--
> >>>>    1 file changed, 74 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tool=
s/testing/selftests/bpf/prog_tests/sockopt.c
> >>>> index aa4debf62fc6..8dad30ce910e 100644
> >>>> --- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
> >>>> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
> >>>> @@ -273,10 +273,30 @@ static struct sockopt_test {
> >>>>                .error =3D EFAULT_GETSOCKOPT,
> >>>>        },
> >>>>        {
> >>>> -             .descr =3D "getsockopt: deny arbitrary ctx->retval",
> >>>> +             .descr =3D "getsockopt: ignore >PAGE_SIZE optlen",
> >>>>                .insns =3D {
> >>>> -                     /* ctx->retval =3D 123 */
> >>>> -                     BPF_MOV64_IMM(BPF_REG_0, 123),
> >>>> +                     /* write 0xFF to the first optval byte */
> >>>> +
> >>>> +                     /* r6 =3D ctx->optval */
> >>>> +                     BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1,
> >>>> +                                 offsetof(struct bpf_sockopt, optva=
l)),
> >>>> +                     /* r2 =3D ctx->optval */
> >>>> +                     BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
> >>>> +                     /* r6 =3D ctx->optval + 1 */
> >>>> +                     BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
> >>>> +
> >>>> +                     /* r7 =3D ctx->optval_end */
> >>>> +                     BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_1,
> >>>> +                                 offsetof(struct bpf_sockopt, optva=
l_end)),
> >>>> +
> >>>> +                     /* if (ctx->optval + 1 <=3D ctx->optval_end) {=
 */
> >>>> +                     BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
> >>>> +                     /* ctx->optval[0] =3D 0xF0 */
> >>>> +                     BPF_ST_MEM(BPF_B, BPF_REG_2, 0, 0xFF),
> >>>> +                     /* } */
> >>>> +
> >>>> +                     /* ctx->retval =3D 0 */
> >>>> +                     BPF_MOV64_IMM(BPF_REG_0, 0),
> >>>>                        BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
> >>>>                                    offsetof(struct bpf_sockopt, retv=
al)),
> >>>>
> >>>> @@ -287,9 +307,10 @@ static struct sockopt_test {
> >>>>                .attach_type =3D BPF_CGROUP_GETSOCKOPT,
> >>>>                .expected_attach_type =3D BPF_CGROUP_GETSOCKOPT,
> >>>>
> >>>> -             .get_optlen =3D 64,
> >>>> -
> >>>> -             .error =3D EFAULT_GETSOCKOPT,
> >>>> +             .get_level =3D 1234,
> >>>> +             .get_optname =3D 5678,
> >>>> +             .get_optval =3D {}, /* the changes are ignored */
> >>>> +             .get_optlen =3D 4096 + 1,
> >>>
> >>> The patchset looks good. Thanks for taking care of it.
> >>>
> >>> One question, is it safe to the assume 4096 page size for all platfor=
ms in the
> >>> selftests?
> >>
> >> Good question; let me respin with sysconf() just to be safe..
> >
> > Argh, the compiler yells at me:
> > error: initializer element is not a compile-time constant
> >
> > I guess I'm just gonna do #define PAGE_SIZE 4096 and if we do hit some
> > problems on the other archs, I'll ifdef it in one place.
>
> or run_test() can reinit optlen to sysconf_page_size + 1 if optlen =3D=3D=
 4097.

Maybe I can do something like the following?

               if (test->set_optlen >=3D PAGE_SIZE) {
                       int num_pages =3D test->set_optlen / PAGE_SIZE;
                       int remainder =3D test->set_optlen % PAGE_SIZE;

                       test->set_optlen =3D num_pages *
sysconf(_SC_PAGESIZE) + remainder;
               }

More verbose, but less magical than depending on 4097. For the BPF
side, I can probably pass proper value via bss..
