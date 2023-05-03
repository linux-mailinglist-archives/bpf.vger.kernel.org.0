Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A406F5DE4
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 20:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjECS2T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 14:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjECS2Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 14:28:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0630172A2
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 11:28:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24df4ecdb87so2976522a91.0
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683138487; x=1685730487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13pG8Jfzcl3AVAc2j641dag6XneDrW67pUErNWntZq0=;
        b=2hru3XGw3w5kSDLlUcbv3wW0Zj5M3uJyGtLSNnKcUOWvUmi5w+lrUL+CORHb2AUhGT
         /M4Y2tFVrqiNshXIKY1cOaf59rxhgSGEVc59gOF0/gwOFt55p0hYGl3X+faWnxhsuYxv
         LidCb4RfIRWdP5Jq+5nvKSnrOPrdaXJARBLV9Xay7xtj3+oR1UB+kCi2QBWBpAZOAhPu
         Db0mWt7EopCACp1SJ81cURUWqx4KmQCf9i5Y7+zTvzZ8L3Vg/wIyyek1F9Zbn9dYbe+x
         hHxRhJp1uFG6jPhtsC7+ZAThLHqtnHL7NswE9eIq7ssnf34lwT102+l4nzdOoM20onOD
         JnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683138487; x=1685730487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13pG8Jfzcl3AVAc2j641dag6XneDrW67pUErNWntZq0=;
        b=RW85RFFTH/2YBs6Bxl8Fs576Qn91StA9jNYs5WWUqL/nLYLtXE1rcdf28yaigKXC/r
         oZYy2tm+WBAA8pCW2Gziok6Jky0m42IYzcZhkp+LnJFeerVlCqA3ATcCQiP2MsRZHjZV
         oR0zlSGGuTiPbq8G84wQN5i+QSo0jfzyexAW16cN7tL76JytJUOrilB9iBncEgydJ+AK
         KFRzTbtQ5OCIXCU50XVFx0ffvEznBpbsCLHTXsVziQMwCTNHq4tTVnuFErsdKyrxWyzI
         LKURHZWWKTnR7CekY9V/OVWwoY9nG+i1Apkv8sJbR5TzjzMIru3QWfRMYzbe7c7Lmtu4
         1snw==
X-Gm-Message-State: AC+VfDwLiuZvB/NKareagaDlgbGtOWnUUiDdrDRiWarkNeBN6jnlxT1x
        vxqvBMsXU10P8S/WHr1lWgLWWUVVshUhaAfi+jE/hg==
X-Google-Smtp-Source: ACHHUZ4dzE0ov6bkUUyCkjkArzZ6LaN/Odih9TpbBWqoYLgWsVygkqI5UFgspOMTRAQYW4T86DiDcNB0U/ugXAKoPVY=
X-Received: by 2002:a17:90b:3ecb:b0:247:5654:fcf3 with SMTP id
 rm11-20020a17090b3ecb00b002475654fcf3mr21652853pjb.11.1683138487295; Wed, 03
 May 2023 11:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230501194825.2864150-1-sdf@google.com> <20230501194825.2864150-3-sdf@google.com>
 <9cc9a5f6-35cd-cfa3-8034-18dac9f20d6f@linux.dev> <00537b92-c8f8-e101-1016-0ee980b028f1@linux.dev>
In-Reply-To: <00537b92-c8f8-e101-1016-0ee980b028f1@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 3 May 2023 11:27:56 -0700
Message-ID: <CAKH8qBsFMMqJ97qCFhxMToB+O+PLp-kUM5=7sOwDDff+KLq1Mw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] selftests/bpf: Update EFAULT
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

On Tue, May 2, 2023 at 5:43=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 5/2/23 5:29 PM, Martin KaFai Lau wrote:
> > On 5/1/23 12:48 PM, Stanislav Fomichev wrote:
> >> Instead of assuming EFAULT, let's assume the BPF program's
> >> output is ignored.
> >>
> >> Remove "getsockopt: deny arbitrary ctx->retval" because it
> >> was actually testing optlen. We have separate set of tests
> >> for retval.
> >>
> >> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> >> ---
> >>   .../selftests/bpf/prog_tests/sockopt.c        | 98 +++++++++++++++++=
--
> >>   1 file changed, 92 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c
> >> b/tools/testing/selftests/bpf/prog_tests/sockopt.c
> >> index aa4debf62fc6..a7bc9dc93ce0 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
> >> @@ -5,6 +5,10 @@
> >>   static char bpf_log_buf[4096];
> >>   static bool verbose;
> >> +#ifndef PAGE_SIZE
> >> +#define PAGE_SIZE 4096
> >> +#endif
> >> +
> >>   enum sockopt_test_error {
> >>       OK =3D 0,
> >>       DENY_LOAD,
> >> @@ -273,10 +277,30 @@ static struct sockopt_test {
> >>           .error =3D EFAULT_GETSOCKOPT,
> >>       },
> >>       {
> >> -        .descr =3D "getsockopt: deny arbitrary ctx->retval",
> >> +        .descr =3D "getsockopt: ignore >PAGE_SIZE optlen",
> >>           .insns =3D {
> >> -            /* ctx->retval =3D 123 */
> >> -            BPF_MOV64_IMM(BPF_REG_0, 123),
> >> +            /* write 0xFF to the first optval byte */
> >> +
> >> +            /* r6 =3D ctx->optval */
> >> +            BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1,
> >> +                    offsetof(struct bpf_sockopt, optval)),
> >> +            /* r2 =3D ctx->optval */
> >> +            BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
> >> +            /* r6 =3D ctx->optval + 1 */
> >> +            BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
> >> +
> >> +            /* r7 =3D ctx->optval_end */
> >> +            BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_1,
> >> +                    offsetof(struct bpf_sockopt, optval_end)),
> >> +
> >> +            /* if (ctx->optval + 1 <=3D ctx->optval_end) { */
> >> +            BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
> >> +            /* ctx->optval[0] =3D 0xF0 */
> >> +            BPF_ST_MEM(BPF_B, BPF_REG_2, 0, 0xFF),
> >> +            /* } */
> >> +
> >> +            /* ctx->retval =3D 0 */
> >> +            BPF_MOV64_IMM(BPF_REG_0, 0),
> >
> >
> > This is an interesting test case. One more question just came to my min=
d,
> > does it make sense to also ignore the bpf-prog's 'ctx->retval =3D 0' in=
 getsockopt
> > considering its optval change has already been ignored. Something like:
> >
> >      if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
> >          if (orig_optlen > PAGE_SIZE && ctx.optlen >=3D 0) {
> >              pr_info_once("bpf getsockopt: ignoring program buffer with
> > optlen=3D%d (max_optlen=3D%d)\n",
> >                       ctx.optlen, max_optlen);
> >              ret =3D retval;
> >                          goto out;
> >                  }
> >                  ret =3D -EFAULT;
> >                  goto out;
> >          }
>
> Previous one has indentation off. Meaning to be:
>
>         if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
>                 if (orig_optlen > PAGE_SIZE && ctx.optlen >=3D 0) {
>                         pr_info_once("bpf getsockopt: ignoring program bu=
ffer with optlen=3D%d
> (max_optlen=3D%d)\n",
>                                      ctx.optlen, max_optlen);
>                         ret =3D retval;
>                         goto out;
>                 }
>                 ret =3D -EFAULT;
>                 goto out;
>         }

Good idea. I'll also try to add 'retval =3D 123' to this testcase to verify=
.
