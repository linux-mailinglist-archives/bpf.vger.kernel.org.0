Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B166F7226
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 20:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjEDSwp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 14:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjEDSwm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 14:52:42 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257C359FB
        for <bpf@vger.kernel.org>; Thu,  4 May 2023 11:52:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50b383222f7so1315268a12.3
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 11:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683226359; x=1685818359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rT4/nOGoZI4coeSIrj17Stx0rMGAadIPdrKnlqcwSeQ=;
        b=UKqF6nNfm/NjdimOzepckXVZWilaSs/H3ub9yocvl9zQwmELhJVWq9UStPk2XubfgD
         v94e8Hu7HYD6Ayr7gtx7TMkfew282+3Hgt4Mpg8KE7pN2TEDfdJaEJuMX/UcKgw6Dn6J
         IIrzrEADAFSTJp7XBV0wUjxSxacDGTNTh6q6U+mF9l+QE6jee1kg3MffUPNIZCBLFLX9
         rhf+LlSjiNAaZ/z7bt1kSrFbdjjFz0HkHbS/awRFQc9ZPFnkfCVtoh2607t4Z3oJh/PN
         dLYc7dxf93WMoU1SODMNphhL0/NXip7r1xWto+kGszl2Sq8V61Y6i9ijKoup5ZYZGdrz
         ZTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683226359; x=1685818359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rT4/nOGoZI4coeSIrj17Stx0rMGAadIPdrKnlqcwSeQ=;
        b=UBH804kqxBTjPIqv1K9KdYO6G24nlQrV9p+9C5jLnqaH0dDArAYiz+hC1M+O/aNQyr
         aZS20YqAqCyGGmoFdBeTNXOLWLcQGQDf70DHMaI95KGSek1eWfTPg0RoOjyZWQV1Mr+Z
         DzibaXM19St7HQj0gQWUUSRQPwfHWjyD7PL/vkjxvuGlke48PilIlUa6m1iPrOSI07AS
         smhaUHV2X4tva/jgt4qJlNWEACaFjVL1QhEIxcwLEcnN/j0R1CR/vYKLVF8ZheA2mVA+
         4MIK9w92V96FL9cQfUrdBM22jyd9Hm65QQhklTmX9K5Ke4+BymEQd0sSyCdBtGV8umz6
         uFYw==
X-Gm-Message-State: AC+VfDy462l5oU0wkBlAMOPsASfxMx73RXDSHanoWevfrH75O6RnHPUU
        deBztSpWX70gVNzLWrQCvqQ6kJFFuBPAI/dttxc=
X-Google-Smtp-Source: ACHHUZ7aiEQIASGStDbHFHy93tmzFzf7k8PL+XHz9xX36Gl8yJ1TeewhsaFIrQHePRXN9zkP41kravAd4wBd7OKw6UI=
X-Received: by 2002:a17:906:dc8f:b0:94a:a887:c29f with SMTP id
 cs15-20020a170906dc8f00b0094aa887c29fmr7977560ejc.68.1683226359382; Thu, 04
 May 2023 11:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230502230619.2592406-1-andrii@kernel.org> <20230502230619.2592406-2-andrii@kernel.org>
 <ZFKn4JjmiGTHyWpj@google.com> <CAEf4Bza5MOxkV_MUHUadCHtPaUiCQF59mPGukn+qrqgXxsL3vQ@mail.gmail.com>
 <CAKH8qBvzthpfNyzQe=iaGufispzYaTDn4Ls5gLZH9Z3=UOeb8g@mail.gmail.com>
In-Reply-To: <CAKH8qBvzthpfNyzQe=iaGufispzYaTDn4Ls5gLZH9Z3=UOeb8g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 4 May 2023 11:52:27 -0700
Message-ID: <CAEf4BzYczH2wkRdZM=UK9gp_ut0ve0jBRnXfHHNb+17Pm+8JFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/10] bpf: move unprivileged checks into
 map_create() and bpf_prog_load()
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 3, 2023 at 3:33=E2=80=AFPM Stanislav Fomichev <sdf@google.com> =
wrote:
>
> On Wed, May 3, 2023 at 12:04=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, May 3, 2023 at 11:28=E2=80=AFAM Stanislav Fomichev <sdf@google.=
com> wrote:
> > >
> > > On 05/02, Andrii Nakryiko wrote:
> > > > Make each bpf() syscall command a bit more self-contained, making i=
t
> > > > easier to further enhance it. We move sysctl_unprivileged_bpf_disab=
led
> > > > handling down to map_create() and bpf_prog_load(), two special comm=
ands
> > > > in this regard.
> > > >
> > > > Also swap the order of checks, calling bpf_capable() only if
> > > > sysctl_unprivileged_bpf_disabled is true, avoiding unnecessary audi=
t
> > > > messages.
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  kernel/bpf/syscall.c | 37 ++++++++++++++++++++++---------------
> > > >  1 file changed, 22 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > > index 14f39c1e573e..d5009fafe0f4 100644
> > > > --- a/kernel/bpf/syscall.c
> > > > +++ b/kernel/bpf/syscall.c
> > > > @@ -1132,6 +1132,17 @@ static int map_create(union bpf_attr *attr)
> > > >       int f_flags;
> > > >       int err;
> > >
> > > [..]
> > >
> > > > +     /* Intent here is for unprivileged_bpf_disabled to block key =
object
> > > > +      * creation commands for unprivileged users; other actions de=
pend
> > > > +      * of fd availability and access to bpffs, so are dependent o=
n
> > > > +      * object creation success.  Capabilities are later verified =
for
> > > > +      * operations such as load and map create, so even with unpri=
vileged
> > > > +      * BPF disabled, capability checks are still carried out for =
these
> > > > +      * and other operations.
> > > > +      */
> > > > +     if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
> > > > +             return -EPERM;
> > > > +
> > >
> > > Does it make sense to have something like unpriv_bpf_capable() to avo=
id
> > > the copy-paste?
> >
> > It's a simple if condition used in exactly two places, so I had
> > preference to keep permissions checks grouped together in the same
> > block of code in respective MAP_CREATE and PROG_LOAD handlers. I can
> > factor it out into a function, but I see little value in that, tbh.
>
> Ack, up to you. I'm more concerned about the comment tbh, not the check i=
tself.

I'll trim those comments down and keep relevant map *or* prog parts.
