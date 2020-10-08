Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6002287C82
	for <lists+bpf@lfdr.de>; Thu,  8 Oct 2020 21:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgJHTcy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Oct 2020 15:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJHTcy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Oct 2020 15:32:54 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D98C0613D2;
        Thu,  8 Oct 2020 12:32:54 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id j76so5402372ybg.3;
        Thu, 08 Oct 2020 12:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lJiVyF8lYseP3MyH+TqVr5lzl2Yk+yGjrNLl/qjax8s=;
        b=Tulpt3da9pOfXt/5s3jw4gP1oOIW+5evQJZiLhuAoW7STSQZskoBTnCPgbPF2/qpkD
         ND89oqm2j2Lehk5Lv/wPjKo9MUqDErcNKsUg6Fyw34LYMce/+BSYRS7eCHreaW1YU/c/
         u32xJPbx0fKu3o5sy4YRKHfmREimVzI5CUK63nXm8qkj6OqG9hVps+ybfiuPrqxd8jNv
         I/Ae7gFtS0y02K3DC0jAyApU3yXycbO2dKAOO/6Vr5uz11tgSNdISogYevo2i4gGGfsN
         W/HJmjDaNmlDrq3Rl+gRtBKtKzP4GEduS9H8Fx2UbtpYYwjMwSOZ+H3wUWilS5kRDyYB
         9+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lJiVyF8lYseP3MyH+TqVr5lzl2Yk+yGjrNLl/qjax8s=;
        b=SZGjfEuL3o9KxAkCGiRva5SndMkOsmS9WzKTM8RT80ThZ5ZmyXn3QZpJlIGPmcvJ2n
         zJ4VJDL3UXBUk0SRlyheyqrr9OD6zw38/6iZqxzmCF/cw3LeBM7+PXVdPhqP190VZ4GD
         K/Vx5OK9C4Ttvi+dV34kd4z+petREApqcHKQ+gJBvVa38FW+auc3fmiTz2dDvi3D101I
         BsfBLIRPYVC/TNtqx4ZefhMd19Av2+alyzgmMTq6B44NgNVuZk9NzNl42DNXVzGD9O3n
         /PyQGrGBcUhPt8iwVDVy/RxVEK8aXhOCLzm0uwVZ81fu2qucIsgraLZY0M1C2FWKmY18
         DpiQ==
X-Gm-Message-State: AOAM532Rkbudp/btO5QB+FObKFvuQer6EtybP9JQdH2eZRPlnGaPbBZp
        v41RpZWtcTLds+DcmG1vQbMtAnBDTtkXk5SNpsg=
X-Google-Smtp-Source: ABdhPJzveCuqIbrfOzihsGa+eJBpFpC/K/JgLKs4Wp8Fg2VosS6VgsHUq68kAgKxuLQ3YAm7J42UpHj8OFn++jmZRc8=
X-Received: by 2002:a25:2a4b:: with SMTP id q72mr6980562ybq.27.1602185573415;
 Thu, 08 Oct 2020 12:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200930042742.2525310-1-andriin@fb.com> <20200930042742.2525310-5-andriin@fb.com>
 <20201008180651.GD246083@kernel.org>
In-Reply-To: <20201008180651.GD246083@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 8 Oct 2020 12:32:42 -0700
Message-ID: <CAEf4BzbOUQv0JQqJ=BuTkKz5XFo=ZpiskaXEmeEfsgTD5_eBmw@mail.gmail.com>
Subject: Re: [PATCH dwarves 04/11] btf_loader: use libbpf to load BTF
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andriin@fb.com>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 8, 2020 at 11:59 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Sep 29, 2020 at 09:27:35PM -0700, Andrii Nakryiko escreveu:
> > Switch BTF loading to completely use libbpf's own struct btf and related APIs.
> > BTF encoding is still happening with pahole's own code, so these two code
> > paths are not sharing anything now. String fetching is happening based on
> > whether btfe->strings were set to non-NULL pointer by btf_encoder.
>
> This patch is not applying, since there was a fix in the btf_loader.c
> file where lexblocks (DWARF concept) wasn't being initialized and then
> some other tool was segfaulting when trying to traverse an uninitialized
> list.
>
> I tried applying this patch by hand, but it seems it needs some
> massaging before I can use plain vim on it:
>
> diff --git a/btf_loader.c b/btf_loader.c
> index 9db76957a7e5..c31ee61060f1 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -46,21 +46,17 @@ static void *tag__alloc(const size_t size)
>  }
> =20
>  static int btf_elf__load_ftype(struct btf_elf *btfe, struct ftype *proto=
> , uint32_t tag,
> -                              uint32_t type, uint16_t vlen, struct btf_param *args, uint32_t=
>  id)
> +                              const struct btf_type *tp, uint32_t id)
>  {
> -       int i;
> +       const struct btf_param *param =3D btf_params(tp);
> +       int i, vlen =3D btf_vlen(tp);
> =20
>         proto->tag.tag  =3D tag;
> -       proto->tag.type =3D type;
> +       proto->tag.type =3D tp->type;
>         INIT_LIST_HEAD(&proto->parms);
> =20
> -       for (i =3D 0; i < vlen; ++i) {
>
>
> Can you please check?
>
> The first three patches are already applied an in master, both at
> kernel.org and its mirror at github.com.

Sure, no problem. I'll rebase the rest and post as v2.

>
> - Arnaldo
>

[...]
