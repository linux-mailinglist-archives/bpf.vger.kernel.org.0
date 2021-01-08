Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B439E2EF929
	for <lists+bpf@lfdr.de>; Fri,  8 Jan 2021 21:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbhAHU0O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jan 2021 15:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbhAHU0O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jan 2021 15:26:14 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09C2C061380;
        Fri,  8 Jan 2021 12:25:33 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id u203so10532960ybb.2;
        Fri, 08 Jan 2021 12:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oyFWoz9ZBkG/9fD01WqqQ9V3Wvlu3oAY5p/OWrRVFXo=;
        b=fbnADsDJ3KhVD4fmLtswJOHo1oKMXPr5yqaCIqvaoFlYpBGADBzkxspbX5GZcqKTzN
         tEVRJhsoYVK0LkVHxSjxaZfzWZZGS0eWN4ecP1DQFIKpDe1wuuhuHDgKcp4D5AiBPXhO
         PT+apN5bGYChrLfK53aVgBaiBASumbs8hYcYD8VaF+y2lEfuZsI2Wv1BAutiiTja94rP
         hBle6sjaD9tv+qmvIA6ssOQGltGf0W5sZBMXvXQZEL4tn6bJqxoGtDcSMZO8jm0KhHRt
         fF30qzQltd1yvF6RWCI8H74eR9qWjejdw2TntXhKdbQ5/lhy8+DMejyRq6INe/IUBCr/
         LIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oyFWoz9ZBkG/9fD01WqqQ9V3Wvlu3oAY5p/OWrRVFXo=;
        b=qqtFoBH1Q+rTz3eFhAyRR/QulJgOGqO9I7N8c3qtbfNBRqtON7z2quJBczxbtgPQXj
         grPGYPzAKg4I3C8pUYFB+1tpTG9ncunxw/h3TO7A5YpVduYK30WEGlkltS/bYe0aw85i
         8qMFx63/DSQeoArlXDexQM15kVNvKS6Rhv/lCX7S6+VVcLT5c2Xo9qvFwc7hkv3x60AD
         C0mJjM5NrTfrtCEYIDSugiE2O4a05hLi4A/SFDgbYmxgQ11i3GPwMoUXpWe8yZXD0sPp
         MGMsmDS/57lJot9fcsUNtiZIxtOcqqxGKXxWwdLv0GLTJtDjfWPxzZ4AMOOMEpOUFmeU
         qUBg==
X-Gm-Message-State: AOAM531xtojrIFMaLyx4yKX32V8BBrtOmyTAJCteqR15LuYtlw2gGaQw
        oLVUWi+Szn4ChsP5ZHOPqEUMjfJ05o2hIuK6lJM=
X-Google-Smtp-Source: ABdhPJyc1F4e3RuLHb51W+RDdAbcnxWn06EGTpl6dLuxZFiSdfTs7ZDcsBdLBDqqD+wqnt1Wv4syCJ3dT+ikyws/PtE=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr7920774ybe.403.1610137533031;
 Fri, 08 Jan 2021 12:25:33 -0800 (PST)
MIME-Version: 1.0
References: <HKAPR02MB42916F8599BF7B58AD73C27AE0AE0@HKAPR02MB4291.apcprd02.prod.outlook.com>
In-Reply-To: <HKAPR02MB42916F8599BF7B58AD73C27AE0AE0@HKAPR02MB4291.apcprd02.prod.outlook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Jan 2021 12:25:22 -0800
Message-ID: <CAEf4BzZr=hgWGuU4EPEZbavAsN7hy+j-9RQAL7xvfMJ8hqv58g@mail.gmail.com>
Subject: Re: [PATCH] tools/bpf: Remove unnecessary parameter in bpf_object__probe_loading
To:     =?UTF-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>
Cc:     "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 7, 2021 at 6:08 PM =E5=BD=AD=E6=B5=A9(Richard) <richard.peng@op=
po.com> wrote:
>
> struct bpf_object *obj is not used in bpf_object__probe_loading, so we
> can remove it.
>
> Signed-off-by: Peng Hao <richard.peng@oppo.com>
> ---

It causes no harm, no performance cost, and no maintenance issues. I
consider eventually allowing to have a per-bpf_object log callback (as
opposed to current global one), so at that time I'd need to re-add
struct bpf_object back to this. Which means just unnecessary code
churn.

So thanks for the patch, there is nothing wrong with it, but I'll
leave this code as is for now. Thanks!


>  tools/lib/bpf/libbpf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 313034117070..17d90779f09a 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3685,7 +3685,7 @@ int bpf_map__resize(struct bpf_map *map, __u32 max_=
entries)
>  }
>
>  static int
> -bpf_object__probe_loading(struct bpf_object *obj)
> +bpf_object__probe_loading(void)
>  {
>         struct bpf_load_program_attr attr;
>         char *cp, errmsg[STRERR_BUFSIZE];
> @@ -7258,7 +7258,7 @@ int bpf_object__load_xattr(struct bpf_object_load_a=
ttr *attr)
>                 return -EINVAL;
>         }
>
> -       err =3D bpf_object__probe_loading(obj);
> +       err =3D bpf_object__probe_loading();
>         err =3D err ? : bpf_object__load_vmlinux_btf(obj);
>         err =3D err ? : bpf_object__resolve_externs(obj, obj->kconfig);
>         err =3D err ? : bpf_object__sanitize_and_load_btf(obj);
> --
> 2.18.4
