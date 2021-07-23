Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229413D35B2
	for <lists+bpf@lfdr.de>; Fri, 23 Jul 2021 09:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhGWHIs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Jul 2021 03:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbhGWHIr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Jul 2021 03:08:47 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A5FC06175F
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 00:49:20 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id n19so1581278ioz.0
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 00:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=57dSd3sWdoIoqqNR18Q5PmaEmzSIBlSRlytHsP4JtRc=;
        b=flRAEuAksxmz7jFVcXlqpzp8nlWbJ1123RRrYNX0bGrAfQS2krvg5CKYGAs4jGdPM+
         nhUJcwCa61PZK1UH16HRJunJOfSumAh0gRIswKmX1sOjU52vOtEEYEufaM/VpwIiTv9k
         cy8LeV0kAbRZKwR+IAax4q7ZvVrtTDXhPH+/olRXrpA4JVWJani48fLjA0nVhVcZVZJV
         DES59q77dEstLTP6z2EBRWTgKa7KO8IwmcY7xi9/ng1VKh6JWZ1ocPC1X6Mx1gQYV1Nf
         6njJZvTUFgzVuHJnutU6YOFeEJz7NP4zVpessNeB+iz6jFJQGvFbj9cFHJ6PZAR+Rql3
         o2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=57dSd3sWdoIoqqNR18Q5PmaEmzSIBlSRlytHsP4JtRc=;
        b=He/DRnf+gWI6ItRr3vYSDi5SW8IKoV758Uvxn2Z6oqhfiPm6SD3PoZE0hzoQqNn7t+
         Xwl90NWyO4q4uX3PZNS+Se10bGrcxXTAeOUp8kpNWyqmVQtgjfQl+nhxiMt+/lQYLQSc
         Ev/zAjXqTDMILrgLbRrJKvJlEcBJqUXniz112DuK4J6GoqbjVM8VyyouVW6RrhEXdhbh
         kABuTJt2+9O7arFh8xXWQdQfUWgInlQ/Rw4skZalCKddfe2vs7pVavkyVnAnTM1QYw2x
         omYNv7pn5aYv1WG+vwLVE7+YviEluRcp5Sl7qOjvj87NmB50NZFbD5PLXbxpOKTMEoaT
         dEtw==
X-Gm-Message-State: AOAM533t/8xgG5w8t8cKKMMeRl3e61Y6XVnzT8v+uf8JJoYWVHwgwfBL
        slhdLvW+Ti4xD6+vb01mIh3OTE7h4pK/hGUWpw==
X-Google-Smtp-Source: ABdhPJxXsmLocWtsuE67hSi074X6g79UDI3FCJD7S62KQepvNefkASszeSrC+K3aZH0Iox1mkRAt8D2FFmp5c09judc=
X-Received: by 2002:a5d:8602:: with SMTP id f2mr3021824iol.61.1627026559072;
 Fri, 23 Jul 2021 00:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210722162526.32444-1-tallossos@gmail.com> <CAEf4BzaJwBQvDhAYie-xSjQzUggr7FZVyVoa0X25TcfYxnWT=w@mail.gmail.com>
In-Reply-To: <CAEf4BzaJwBQvDhAYie-xSjQzUggr7FZVyVoa0X25TcfYxnWT=w@mail.gmail.com>
From:   Tal Lossos <tallossos@gmail.com>
Date:   Fri, 23 Jul 2021 10:49:07 +0300
Message-ID: <CAO15rPmcBKq7DJeMzRhD1pTu4yDYzy6VsJSayZnsuYFW30zeGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Remove deprecated bpf_object__find_map_by_offset
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Tal Lossos <tallossos@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi no worries!
I've submitted a fix for the patch which re-adds the deleted API in libbpf.=
map.
Since we want to do it only when we're about to release libbpf 1.0 we
can just wait with it until then :)


=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=95=D7=
=B3, 23 =D7=91=D7=99=D7=95=D7=9C=D7=99 2021 =D7=91-6:12 =D7=9E=D7=90=D7=AA =
=E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
<=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Thu, Jul 22, 2021 at 9:26 AM Tal Lossos <tallossos@gmail.com> wrote:
> >
> > Removing bpf_object__find_map_by_offset as part of the effort to move
> > towards a v1.0 for libbpf: https://github.com/libbpf/libbpf/issues/302.
> >
> > Signed-off-by: Tal Lossos <tallossos@gmail.com>
> > ---
>
> Thanks for helping with the libbpf 1.0 effort! But we shouldn't be
> removing APIs until right before 1.0 release, otherwise we are
> breaking backwards compatibility guarantees. So this will have to wait
> until then (even though I don't believe anyone is using
> bpf_object__find_map_by_offset() in the wild).
>
> >  tools/lib/bpf/libbpf.c   | 6 ------
> >  tools/lib/bpf/libbpf.h   | 7 -------
> >  tools/lib/bpf/libbpf.map | 1 -
> >  3 files changed, 14 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 4c153c379989..6b021b893579 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -9956,12 +9956,6 @@ bpf_object__find_map_fd_by_name(const struct bpf=
_object *obj, const char *name)
> >         return bpf_map__fd(bpf_object__find_map_by_name(obj, name));
> >  }
> >
> > -struct bpf_map *
> > -bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset)
> > -{
> > -       return libbpf_err_ptr(-ENOTSUP);
> > -}
> > -
> >  long libbpf_get_error(const void *ptr)
> >  {
> >         if (!IS_ERR_OR_NULL(ptr))
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 6b08c1023609..1de34b315277 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -422,13 +422,6 @@ bpf_object__find_map_by_name(const struct bpf_obje=
ct *obj, const char *name);
> >  LIBBPF_API int
> >  bpf_object__find_map_fd_by_name(const struct bpf_object *obj, const ch=
ar *name);
> >
> > -/*
> > - * Get bpf_map through the offset of corresponding struct bpf_map_def
> > - * in the BPF object file.
> > - */
> > -LIBBPF_API struct bpf_map *
> > -bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset);
> > -
> >  LIBBPF_API struct bpf_map *
> >  bpf_map__next(const struct bpf_map *map, const struct bpf_object *obj)=
;
> >  #define bpf_object__for_each_map(pos, obj)             \
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index 5bfc10722647..220d22b73b9c 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -38,7 +38,6 @@ LIBBPF_0.0.1 {
> >                 bpf_object__btf_fd;
> >                 bpf_object__close;
> >                 bpf_object__find_map_by_name;
> > -               bpf_object__find_map_by_offset;
>
> we can't retroactively modify libbpf.map for already released
> versions. I think once we are ready for libbpf 1.0 we'll just dump all
> the non-deleted APIs into a LIBBPF_1.0.0 section without inheriting
> from the last 0.x version.
>
> >                 bpf_object__find_program_by_title;
> >                 bpf_object__kversion;
> >                 bpf_object__load;
> > --
> > 2.27.0
> >
