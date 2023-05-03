Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7D16F6153
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 00:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjECWdW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 18:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECWdU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 18:33:20 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBC976AB
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 15:33:17 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-24decf5cc03so3452382a91.0
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 15:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683153197; x=1685745197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JhF/sdEAnxVcWbx2g/uZLw7zF9ZClbNWAXuc1vCOdw=;
        b=AqzQVES+t9TvrRIZ2SeJux+f4ndr3lC6X07iEYcrjo3Q9n8e9eGMlGAxTJNtvfbwAV
         wqsSDXibdMa5sUQKdOnFfaMN4iqBxJ7rx7SuwTjrkRXRV47tz7fcFAm/lkhmeVDDtZO1
         D50jmMGzFJF4JyP6zWTG7dFNJ1I9qfngO7ThHwAkWItb+Sa+cK6Rd7430s14Go1YMIF6
         83nndloVs7o8OdzynqMGPx5hqRnt1A5sIDj0BeOvPXchS1RAnYzdODszKfydA7Caq/r9
         XbCwQOl9vhSOefXiw85IxQffSok6zWzFY1P7B9fvtv4V8P6nFsBNaKXEyPE/+6ez99dO
         XZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683153197; x=1685745197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JhF/sdEAnxVcWbx2g/uZLw7zF9ZClbNWAXuc1vCOdw=;
        b=P8SiOGK6P72hrAc+fbZlGAZZn7vlUgy5eRLYcuznIRRZk6AR+1ZvD4q/V1j/crEJSp
         MTxUl0ix5znXlYCCvO2YGsctJvs/iz7Q0m606X7j1S6+6abkSGg1FgB5gvK720ydPnnU
         aLq6xVGM2Pxy/nheNtjRr0I7OFCNMnttj11fdtsRRQZsoPwrg0ti2v1WE7YalSBbOpPd
         aDDahKaT974kLOZ91cS80mIgNwyoCkC+0tvIJW4gGNJx0G7hTl2m0sVGGnXV/mCkm2Bb
         Za28924alfcwf6bJb3JXgLz7qwltCqzxilOEBYEuYQkN5I6rpxQTvGJG4vcmjLdJdNSi
         BAlw==
X-Gm-Message-State: AC+VfDy54cyVImRcsaMYSKMnq7aW54gqA5xupof5/KORzwU1O3WrviAK
        HvFNKlqgWgVAFeR3F02CnRi9x/9QcsHS0rbL7hsH6E+VeDqtVsYfHAZeDA==
X-Google-Smtp-Source: ACHHUZ4tTMmXNoBK4uuS9MFUEQxSpZcwFpTmrXGPpVkeNztp2QIWGSh6Di8OskV1yQ5XfbAK50+GNcEQZxSCycUpJIw=
X-Received: by 2002:a17:90a:1109:b0:246:5968:43f0 with SMTP id
 d9-20020a17090a110900b00246596843f0mr165910pja.10.1683153197130; Wed, 03 May
 2023 15:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230502230619.2592406-1-andrii@kernel.org> <20230502230619.2592406-2-andrii@kernel.org>
 <ZFKn4JjmiGTHyWpj@google.com> <CAEf4Bza5MOxkV_MUHUadCHtPaUiCQF59mPGukn+qrqgXxsL3vQ@mail.gmail.com>
In-Reply-To: <CAEf4Bza5MOxkV_MUHUadCHtPaUiCQF59mPGukn+qrqgXxsL3vQ@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 3 May 2023 15:33:05 -0700
Message-ID: <CAKH8qBvzthpfNyzQe=iaGufispzYaTDn4Ls5gLZH9Z3=UOeb8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/10] bpf: move unprivileged checks into
 map_create() and bpf_prog_load()
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        kernel-team@meta.com
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

On Wed, May 3, 2023 at 12:04=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, May 3, 2023 at 11:28=E2=80=AFAM Stanislav Fomichev <sdf@google.co=
m> wrote:
> >
> > On 05/02, Andrii Nakryiko wrote:
> > > Make each bpf() syscall command a bit more self-contained, making it
> > > easier to further enhance it. We move sysctl_unprivileged_bpf_disable=
d
> > > handling down to map_create() and bpf_prog_load(), two special comman=
ds
> > > in this regard.
> > >
> > > Also swap the order of checks, calling bpf_capable() only if
> > > sysctl_unprivileged_bpf_disabled is true, avoiding unnecessary audit
> > > messages.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  kernel/bpf/syscall.c | 37 ++++++++++++++++++++++---------------
> > >  1 file changed, 22 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > index 14f39c1e573e..d5009fafe0f4 100644
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -1132,6 +1132,17 @@ static int map_create(union bpf_attr *attr)
> > >       int f_flags;
> > >       int err;
> >
> > [..]
> >
> > > +     /* Intent here is for unprivileged_bpf_disabled to block key ob=
ject
> > > +      * creation commands for unprivileged users; other actions depe=
nd
> > > +      * of fd availability and access to bpffs, so are dependent on
> > > +      * object creation success.  Capabilities are later verified fo=
r
> > > +      * operations such as load and map create, so even with unprivi=
leged
> > > +      * BPF disabled, capability checks are still carried out for th=
ese
> > > +      * and other operations.
> > > +      */
> > > +     if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
> > > +             return -EPERM;
> > > +
> >
> > Does it make sense to have something like unpriv_bpf_capable() to avoid
> > the copy-paste?
>
> It's a simple if condition used in exactly two places, so I had
> preference to keep permissions checks grouped together in the same
> block of code in respective MAP_CREATE and PROG_LOAD handlers. I can
> factor it out into a function, but I see little value in that, tbh.

Ack, up to you. I'm more concerned about the comment tbh, not the check its=
elf.
