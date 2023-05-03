Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A159D6F5ED3
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 21:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjECTEj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 15:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjECTEi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 15:04:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A4176A7
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 12:04:37 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94f6c285d22so1118115666b.2
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683140675; x=1685732675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IV44xfebAjDyuLnLoxT2+vLTT/1LQV7Hc/sAf5dzEmo=;
        b=n4eN+PWVBPNX7Ckutu68E6MfuimQFgT/01Kfrt+dkwdh3Hka46Jqwt19lSAJSgMr97
         xJKx7ebFA8ISw4swm5mK1tCB2lZ17nqmoVadqH6q4lDCHBDZpL/Aan5hjK1vMTir6W/4
         WOEtFIRD+CcPy4jkzmJJ0h4akactymL/xV2nK42asm1N0xQ5SuoGxNaZ07FHJb+B27s1
         w1YoRHFO3r3yzT6ObT1bI+V0vd9TK6cXiEXdn4ZPtDnE9NuyrwuHT6A/KWaLsCSoq2OL
         HH+u+4J1+d5Xz/tM6zuF09McT4o9bzaaBIyzbogUFcmBJxuBui5Q8Z0BEPLjlPKPyTRN
         ekwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683140675; x=1685732675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IV44xfebAjDyuLnLoxT2+vLTT/1LQV7Hc/sAf5dzEmo=;
        b=eZe1kPmYPcgSaoU19Xy6abmEDzq9e1ixMPzGPMdWXZJgsSoRjStMpw1Pv6uw159CpU
         7jSSKYRssLNcyAaouwV1DsUaqxleniEUEoSXxYTCzvaAFKhfPQBb2o0Dx5D6fhsq5aV6
         0a1ZaBXHmIEEGmPQUmLX2eQqXO8Km0YFBhBIFNqsCOU30zvZ82G6gW28kpUrIbK7/NMU
         pbaBKBf4jkddFKBhjjMO7OzAuTNyokJx0733xdTEjkQpZgJIVKdxPU7D6oxLBF1R1PpJ
         N79g07KVsQvpZ0DQomPwJ4FhgPBWQOpU8Ve3CLrQ7Tm8xAKspOPlbJ3vHAHcyONpnyxO
         0VUg==
X-Gm-Message-State: AC+VfDwodPXCh7rVvQQSW8wHKWsTFU1Hi+3wzUPzl0u/w4zHFaYZIqci
        5zxU5k3ae8JPG5NBLk7xVdhUzQ43J/WpM41igpA=
X-Google-Smtp-Source: ACHHUZ6tTEK+7QYouAn2Tc3NB8+BWqT7IU5oG2atxhtnWQ4lO/FDAAqZoiWCiWYB2lPwpv8u+V0frYcdenfk479w+3g=
X-Received: by 2002:a17:907:805:b0:94f:cee:56f2 with SMTP id
 wv5-20020a170907080500b0094f0cee56f2mr4580421ejb.4.1683140675525; Wed, 03 May
 2023 12:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230502230619.2592406-1-andrii@kernel.org> <20230502230619.2592406-2-andrii@kernel.org>
 <ZFKn4JjmiGTHyWpj@google.com>
In-Reply-To: <ZFKn4JjmiGTHyWpj@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 3 May 2023 12:04:23 -0700
Message-ID: <CAEf4Bza5MOxkV_MUHUadCHtPaUiCQF59mPGukn+qrqgXxsL3vQ@mail.gmail.com>
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

On Wed, May 3, 2023 at 11:28=E2=80=AFAM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On 05/02, Andrii Nakryiko wrote:
> > Make each bpf() syscall command a bit more self-contained, making it
> > easier to further enhance it. We move sysctl_unprivileged_bpf_disabled
> > handling down to map_create() and bpf_prog_load(), two special commands
> > in this regard.
> >
> > Also swap the order of checks, calling bpf_capable() only if
> > sysctl_unprivileged_bpf_disabled is true, avoiding unnecessary audit
> > messages.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/syscall.c | 37 ++++++++++++++++++++++---------------
> >  1 file changed, 22 insertions(+), 15 deletions(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 14f39c1e573e..d5009fafe0f4 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -1132,6 +1132,17 @@ static int map_create(union bpf_attr *attr)
> >       int f_flags;
> >       int err;
>
> [..]
>
> > +     /* Intent here is for unprivileged_bpf_disabled to block key obje=
ct
> > +      * creation commands for unprivileged users; other actions depend
> > +      * of fd availability and access to bpffs, so are dependent on
> > +      * object creation success.  Capabilities are later verified for
> > +      * operations such as load and map create, so even with unprivile=
ged
> > +      * BPF disabled, capability checks are still carried out for thes=
e
> > +      * and other operations.
> > +      */
> > +     if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
> > +             return -EPERM;
> > +
>
> Does it make sense to have something like unpriv_bpf_capable() to avoid
> the copy-paste?

It's a simple if condition used in exactly two places, so I had
preference to keep permissions checks grouped together in the same
block of code in respective MAP_CREATE and PROG_LOAD handlers. I can
factor it out into a function, but I see little value in that, tbh.
