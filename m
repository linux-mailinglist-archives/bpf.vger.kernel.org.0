Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D062F47089A
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 19:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbhLJS13 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 13:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhLJS13 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Dec 2021 13:27:29 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497F2C061746
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 10:23:54 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id f186so23275483ybg.2
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 10:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kdmA5vszqfIgTO5Armi6aBwj52pmjD5YB9cm/1zlaZE=;
        b=agoBpcQN/CRukGnzaIv89DMy4LHkIldJaUUV3IgO8g6EJZcyDEn0NM6x8Ttqqp/4s1
         2Wu4JgrM7Fouzj8oJjHEh072novftInsaFb1t8WhK5Dg690dNZg/yyVk7yTCpo0BexeK
         MOlS/nhHA8TaHm/IuDsxeQ0MoaRX037b0m2HcKXM8LwBPZT3ObxFrNyJ0/rOgA10Mjmh
         k2YfVXHQuMLRQNraDVVmWfcvdmyxLyxFEE4WTiRchwnQfH3IRiqwQr1uZzDK84Q+1JKX
         7l+24n2n27b+WWZaKBjC7t2G2baIbrwN5yhZBwnfkvQ2AbIqDHFcNrLA33cqrFmRTzj0
         NIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kdmA5vszqfIgTO5Armi6aBwj52pmjD5YB9cm/1zlaZE=;
        b=pDyLlV8UoU6ugHN++QPWZQRHEQWPkBrXkdRqAVL0eNQJeDouGX74fNFrTuxy66Cuvn
         FKYHZiTj6bJD1fI6TfReL41dySa/bWtZeUMiChRj3lnZqGM520BRDmQBofUpS8eMD8Us
         UIsNYGd5irXAmR68m3ggN9AefrYPDadwZYvOUy105tWkohkBReqJbxze/Lomkd7kSces
         i9QIFnlarM0fEPIuGEglso2I9G1igJZw2EDgI2ogciS2csOn4ZyD1qKOfKVFrj2IkSJS
         71ntSyQuBfKe162lqcBORrDi0m/HOjcfKZp7V2GgXtAd5Xy3DrMnlsOsRUKNHEmK+X8J
         m2fA==
X-Gm-Message-State: AOAM533hE1JI5WlX3UWtFn0TibuLHc3Fs9ZKlaHCPpxQHXRa7JjoZdVr
        9W3uodXI57/RFtOzl+dz1VYPjr/44LkrM4+bSPMhNQapQm6UpQ==
X-Google-Smtp-Source: ABdhPJxlPEhWTvVzRigA3y4wvjGsDet4HYlK4lqh+3WnlF5fYOZLzwufZxs/IecCIEWPVP8lMiq7YAcPCl/+H1L/aRc=
X-Received: by 2002:a25:2a89:: with SMTP id q131mr17985341ybq.436.1639160633085;
 Fri, 10 Dec 2021 10:23:53 -0800 (PST)
MIME-Version: 1.0
References: <eb53035b-bf91-674f-2227-cd01ba820935@linux.alibaba.com>
In-Reply-To: <eb53035b-bf91-674f-2227-cd01ba820935@linux.alibaba.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 10 Dec 2021 10:23:41 -0800
Message-ID: <CAEf4BzbAzUCFm6cKDZGNnsf5acokw-LjU7raStY8HZuLJOSHUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] libbpf: add "bool skipped" to struct bpf_map
To:     Shuyi Cheng <chengshuyi@linux.alibaba.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 10, 2021 at 1:40 AM Shuyi Cheng
<chengshuyi@linux.alibaba.com> wrote:
>
> Fix error: "failed to pin map: Bad file descriptor, path:
> /sys/fs/bpf/_rodata_str1_1."
>
> In the old kernel, the global data map will not be created, see [0]. So
> we should skip the pinning of the global data map to avoid
> bpf_object__pin_maps returning error. Therefore, when the map is not
> created, we mark =E2=80=9Cmap->skipped" as true and then check during rel=
ocation
> and during pinning.
>
> Signed-off-by: Shuyi Cheng <chengshuyi@linux.alibaba.com>
> ---
> v2:
> https://lore.kernel.org/bpf/CAEf4Bzbxf4kEtCEWBSonomEp7ZiKBD50k-U941i=3Dok=
KfgKb6FQ@mail.gmail.com/T/#mb884d33b1b5b8e5dfb5a362af0d3c025510b5a4c
> v2->v3:
> -- adjust the "bool skipped" position
>
> v1:
> https://lore.kernel.org/bpf/CAEf4BzbtQGnGZTLbTdy1GHK54f5S7YNFQak7BuEfaqGE=
wqNNJA@mail.gmail.com/T/#m80ec7f8bc69dbcf4a5945e2aa6f16145901afc40
> v1->v2:
> -- add "bool skipped" to struct bpf_map.
> -- replace "bpf_map__is_internal(map) && !kernel_supports(obj,
> FEAT_GLOBAL_DATA))" with map->skipped
>

Ok, I don't know what exactly is happening, but your patch
really-really confuses Patchworks. If you try to download it from
Patchworks, you'll get bpf_object__pin_maps part of the patch put
somewhere here and completely confusing everything. Try not to use
"--" as a list marker, you can see above it's actually used to
demarcate where the commit message ends and patch starts, so that
might be one of the reasons. Adding space in front of bullet points is
also not a bad idea.


Either way, I applied it manually locally and pushed to bpf-next.
Thanks. I'll cherry-pick this one and btf__dedup_deprecated fix from
yesterday into github libbpf and will cut a bugfix v0.6.1 release
shortly.


>   tools/lib/bpf/libbpf.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 18d95c6a89fe..d027e1d620fc 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -431,6 +431,7 @@ struct bpf_map {
>         char *pin_path;
>         bool pinned;
>         bool reused;
> +       bool skipped;
>         __u64 map_extra;
>   };
>
> @@ -5087,8 +5088,10 @@ bpf_object__create_maps(struct bpf_object *obj)
>                  * kernels.
>                  */
>                 if (bpf_map__is_internal(map) &&
> -                   !kernel_supports(obj, FEAT_GLOBAL_DATA))
> +                   !kernel_supports(obj, FEAT_GLOBAL_DATA)) {
> +                       map->skipped =3D true;
>                         continue;
> +               }
>
>                 retried =3D false;
>   retry:
> @@ -5717,8 +5720,7 @@ bpf_object__relocate_data(struct bpf_object *obj,
> struct bpf_program *prog)
>                         } else {
>                                 const struct bpf_map *map =3D &obj->maps[=
relo->map_idx];
>
> -                               if (bpf_map__is_internal(map) &&
> -                                   !kernel_supports(obj, FEAT_GLOBAL_DAT=
A)) {
> +                               if (map->skipped) {
>                                         pr_warn("prog '%s': relo #%d: ker=
nel doesn't support global data\n",
>                                                 prog->name, i);
>                                         return -ENOTSUP;
> @@ -7926,6 +7928,9 @@ int bpf_object__pin_maps(struct bpf_object *obj,
> const char *path)
>                 char *pin_path =3D NULL;
>                 char buf[PATH_MAX];
>
> +               if (map->skipped)
> +                       continue;
> +
>                 if (path) {
>                         int len;
>
> --
> 2.19.1.6.gb485710b
