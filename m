Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2186D850C
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 19:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjDERlw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 13:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjDERlv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 13:41:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E326182
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 10:41:46 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r11so143043839edd.5
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 10:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680716505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrfhqCaplJcyM3oyz5yMxpT0GoKVQql+VaMHUCcz4MU=;
        b=Q8svRBADX4VJ6tVopsH1rxRZflRSNw1rKhoF3Hh+B7/4Sz0LK+A5cpdg5M0J6TDAXx
         P2DOQuZYpXde0yyI0HjP9ayfU2+jsalGXJAfSDgOpqPkR2QmNp6fzUedwOXhONgehFgZ
         MhUqlo6Fd3AwAKJOgWjW+9d+2e9wZ9+jotWTJdNjqc91eigpS62/5pYyKpAr3o+Yg5UV
         Sgv/U9+CCH65z5VHVH4ekgO1dgCdNb7fIoYRpYVvjBKHWxbMINv50V9cvs2rdfMxSvnO
         co9aWlc5dBy2fZt71+GTrn6aLlXTlY1q042R4QWSEPHAb03WEERuDYWWFbZ9Gg24b2H3
         BdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680716505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrfhqCaplJcyM3oyz5yMxpT0GoKVQql+VaMHUCcz4MU=;
        b=GHyboBaqpaO6U9jFRY4TXEeLOcbvvMlJmg9SJ4ph9GvtCDzDtF6k8+V6Pm64T3Fcu4
         NkoTmlXBePw/EXlEUg/lzJRKh+vtpmw1/Tua+x8eVJaXRz7eShouwVL4fLbsgm2Zwz/G
         vqpPX0UXChA05Y70KCuo2tz52q3DKhIongmwW1IVLgt5wDzJhfud61RFhNe/7p/tUK6x
         NrQLehV6dloyFsOT0rQG5zXYOFbPf5fJSUQ0wEOZ6AJrRYQpaEHMJkX7h5PmTLZEDvx1
         kJzv6Rn+436khb95sGSamDhsO/4eHz956Mohea2/uW3/ucs7ynVihceoZ90YSEkCrqdv
         j4HQ==
X-Gm-Message-State: AAQBX9d2JvEFmdF4xasxuL/d5bqDbkk3Zp97WbqjtxMhK8jnOOyZ145G
        y1Xba4F5ofp7z8VjXIpUUWcumfpUq6PzeoUCZLs=
X-Google-Smtp-Source: AKy350bTUU8oMo0gWZAEE4PrjzrKvKXMA7h+2t0BytI5ITgAHTHGnGBrSmOyR19/ysOVevcmVaKHgRGcp7ZpEzWki84=
X-Received: by 2002:a17:907:2112:b0:8ab:b606:9728 with SMTP id
 qn18-20020a170907211200b008abb6069728mr2019588ejb.5.1680716505002; Wed, 05
 Apr 2023 10:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <20230404043659.2282536-14-andrii@kernel.org>
 <CAN+4W8gxKYN=hpSgZ7UWuEBpx_XTHEgsNhhf+znQgnCzM6K5XQ@mail.gmail.com>
In-Reply-To: <CAN+4W8gxKYN=hpSgZ7UWuEBpx_XTHEgsNhhf+znQgnCzM6K5XQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Apr 2023 10:41:32 -0700
Message-ID: <CAEf4BzYfLVpaik8Q5vCKivKW3kF7=0BEPOnwBHM2uYkmkZEfnA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 13/19] bpf: simplify internal verifier log interface
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        timo@incline.eu, robin.goegge@isovalent.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 5, 2023 at 10:29=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> wr=
ote:
>
> On Tue, Apr 4, 2023 at 5:37=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
> >
> > Simplify internal verifier log API down to bpf_vlog_init() and
> > bpf_vlog_finalize(). The former handles input arguments validation in
> > one place and makes it easier to change it. The latter subsumes -ENOSPC
> > (truncation) and -EFAULT handling and simplifies both caller's code
> > (bpf_check() and btf_parse()).
> >
> > For btf_parse(), this patch also makes sure that verifier log
> > finalization happens even if there is some error condition during BTF
> > verification process prior to normal finalization step.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Acked-by: Lorenz Bauer <lmb@isovalent.com>
>
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 1e974383f0e6..9aeac68ae7ea 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -5504,16 +5504,30 @@ static int btf_check_type_tags(struct btf_verif=
ier_env *env,
> >         return 0;
> >  }
> >
> > +static int finalize_log(struct bpf_verifier_log *log, bpfptr_t uattr, =
u32 uattr_size)
> > +{
> > +       u32 log_size_actual;
> > +       int err;
> > +
> > +       err =3D bpf_vlog_finalize(log, &log_size_actual);
> > +
> > +       if (uattr_size >=3D offsetofend(union bpf_attr, btf_log_size_ac=
tual) &&
> > +           copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, btf_l=
og_size_actual),
> > +                                 &log_size_actual, sizeof(log_size_act=
ual)))
>
> Why not share this with the verifier as well?

it's different field names (right now, log_size_actual for
BPF_PROG_LOAD and btf_log_size_actual for BPF_BTF_LOAD), so different
offsets as well. We could pass offsets, but that seems ugly and I
don't think it would save us much in terms of complexity.
