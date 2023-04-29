Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BCE6F21A8
	for <lists+bpf@lfdr.de>; Sat, 29 Apr 2023 02:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346783AbjD2Acw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 20:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjD2Acu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 20:32:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934EC3A88
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 17:32:49 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a68f2345c5so4416055ad.2
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 17:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682728369; x=1685320369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t94lyxxQoKdItpGu19LKW+pl7URHXTU8m0AU6qJaVzw=;
        b=T9uHR2ZAl8U/G/Qq7rD2d2G0U9abnYfLpoGFPoToKCX9gaXmHwKQuG8SNeMKXQ1BGm
         mjLDr8Ein86x0AduMlOXNn1PHTmk5XQVloBnE6B+3/BzIm/ZKSI0E7eLZz6i03TqZy/D
         LJtDvJt4UdKJCKlS0Mg25ErM5XIzOlAuSsI0ySZVTJFhnvJ8uhPVM76pT9vA7f6rl63P
         E/aXOYi8UKRcH4X4N7LsAYPLFabAkwSfaVr8Yf51jiGRATcQK20iotqz3KU4MC4pL6Q+
         kVPBZ1It5tg9LdzXLiIZyfvsJ4uHTyK2IXVXWJAV+dC+JlDnPqDWkl11tss7QWLrq4TP
         23tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682728369; x=1685320369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t94lyxxQoKdItpGu19LKW+pl7URHXTU8m0AU6qJaVzw=;
        b=jYlJHk5D51Ntb4aAcWxiiwXnZ3bd+PuHyoLjMfahiDHdoZkrU6fwKIfcIq6pEMqt0j
         l3eOHYHQ8MoazjURqPKHIScS/MZon7BOOHb2ODmo41XEBLTnxDDLoifbVAjcpjxMaLyK
         PZGe3IrImiKJmDPwASfe4ViWCMdjnI4gXRoIZLhQ8jhM+FjOnY0Zi6kiVxTVIlF7uj+4
         SGer7Aw5p62eFVWONobSzT7Ah4JcwXZ8/Kdf15VbMsKkosfyr5i7eZIibiLInVdbIN3C
         TmQ//4lF444H3rTjEpz/qXhaOk2lo+DA6EiHMMq4wwIHt0R24Khxt2nGKLXMeRpdX4gt
         FOEA==
X-Gm-Message-State: AC+VfDytBp9fjJYs4ykG9h4VY2W+S82wSINSzyb3FTRkVuqGTQ36+Mew
        MCREh5zzaCeiNjLFuGYwohqjmLIV61F3vY1pc8UZZNKS9psUeawmcsXBGeDq
X-Google-Smtp-Source: ACHHUZ6iZSJiYGNZm3oSv4+DJUvN3zLcxsSBgf/189g1IdOxGbslFhVCugUnvdS6MbIp0enKArr+KZDIZsDeDJzSx3s=
X-Received: by 2002:a17:903:244f:b0:1a9:b977:81c7 with SMTP id
 l15-20020a170903244f00b001a9b97781c7mr8129841pls.62.1682728368855; Fri, 28
 Apr 2023 17:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230427200409.1785263-1-sdf@google.com> <20230427200409.1785263-3-sdf@google.com>
 <ac7c31cc-7f8f-1066-1aa1-ad4d734998c5@linux.dev> <CAKH8qBu=ehBZsusAaVwxO1DNK=NxFupR8RwtotsPSZmdiTw=Zw@mail.gmail.com>
In-Reply-To: <CAKH8qBu=ehBZsusAaVwxO1DNK=NxFupR8RwtotsPSZmdiTw=Zw@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 28 Apr 2023 17:32:37 -0700
Message-ID: <CAKH8qBt-+GDxcfoQP6rmodQzRbZ-Lz11wUpVmP98zDm4qxJKAw@mail.gmail.com>
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

On Fri, Apr 28, 2023 at 4:59=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On Fri, Apr 28, 2023 at 4:57=E2=80=AFPM Martin KaFai Lau <martin.lau@linu=
x.dev> wrote:
> >
> > On 4/27/23 1:04 PM, Stanislav Fomichev wrote:
> > > Instead of assuming EFAULT, let's assume the BPF program's
> > > output is ignored.
> > >
> > > Remove "getsockopt: deny arbitrary ctx->retval" because it
> > > was actually testing optlen. We have separate set of tests
> > > for retval.
> > >
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > ---
> > >   .../selftests/bpf/prog_tests/sockopt.c        | 80 ++++++++++++++++=
+--
> > >   1 file changed, 74 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools=
/testing/selftests/bpf/prog_tests/sockopt.c
> > > index aa4debf62fc6..8dad30ce910e 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
> > > @@ -273,10 +273,30 @@ static struct sockopt_test {
> > >               .error =3D EFAULT_GETSOCKOPT,
> > >       },
> > >       {
> > > -             .descr =3D "getsockopt: deny arbitrary ctx->retval",
> > > +             .descr =3D "getsockopt: ignore >PAGE_SIZE optlen",
> > >               .insns =3D {
> > > -                     /* ctx->retval =3D 123 */
> > > -                     BPF_MOV64_IMM(BPF_REG_0, 123),
> > > +                     /* write 0xFF to the first optval byte */
> > > +
> > > +                     /* r6 =3D ctx->optval */
> > > +                     BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1,
> > > +                                 offsetof(struct bpf_sockopt, optval=
)),
> > > +                     /* r2 =3D ctx->optval */
> > > +                     BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
> > > +                     /* r6 =3D ctx->optval + 1 */
> > > +                     BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 1),
> > > +
> > > +                     /* r7 =3D ctx->optval_end */
> > > +                     BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_1,
> > > +                                 offsetof(struct bpf_sockopt, optval=
_end)),
> > > +
> > > +                     /* if (ctx->optval + 1 <=3D ctx->optval_end) { =
*/
> > > +                     BPF_JMP_REG(BPF_JGT, BPF_REG_6, BPF_REG_7, 1),
> > > +                     /* ctx->optval[0] =3D 0xF0 */
> > > +                     BPF_ST_MEM(BPF_B, BPF_REG_2, 0, 0xFF),
> > > +                     /* } */
> > > +
> > > +                     /* ctx->retval =3D 0 */
> > > +                     BPF_MOV64_IMM(BPF_REG_0, 0),
> > >                       BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_0,
> > >                                   offsetof(struct bpf_sockopt, retval=
)),
> > >
> > > @@ -287,9 +307,10 @@ static struct sockopt_test {
> > >               .attach_type =3D BPF_CGROUP_GETSOCKOPT,
> > >               .expected_attach_type =3D BPF_CGROUP_GETSOCKOPT,
> > >
> > > -             .get_optlen =3D 64,
> > > -
> > > -             .error =3D EFAULT_GETSOCKOPT,
> > > +             .get_level =3D 1234,
> > > +             .get_optname =3D 5678,
> > > +             .get_optval =3D {}, /* the changes are ignored */
> > > +             .get_optlen =3D 4096 + 1,
> >
> > The patchset looks good. Thanks for taking care of it.
> >
> > One question, is it safe to the assume 4096 page size for all platforms=
 in the
> > selftests?
>
> Good question; let me respin with sysconf() just to be safe..

Argh, the compiler yells at me:
error: initializer element is not a compile-time constant

I guess I'm just gonna do #define PAGE_SIZE 4096 and if we do hit some
problems on the other archs, I'll ifdef it in one place.
