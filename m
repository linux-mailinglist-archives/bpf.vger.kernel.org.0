Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49AD46FAD0
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 07:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhLJG5O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 01:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhLJG5L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Dec 2021 01:57:11 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B414C061746
        for <bpf@vger.kernel.org>; Thu,  9 Dec 2021 22:53:37 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 131so19115644ybc.7
        for <bpf@vger.kernel.org>; Thu, 09 Dec 2021 22:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LYbBFTYA8WP3uLhYuQL/+al5l4be5UQELNQGVjPVkjQ=;
        b=WFZaI8hVYFzotwNf9HFYNzQJ7d4HV9hcxS+2h8DP6GEMj4fnJ6maiLgnglvrIB/CEG
         oMpMTXWySQER68gq40XP9oGrpGv1J4HXlSc6kA1wwU2h03s4c3BpKgXq7bCpcxBqH8bL
         BoYAikO/i9f1d7Sy/4sYA5nm7Ieh+84oRSKo1TGcgf+s4x0n5ILcmiBBHgOV/qgePUVQ
         CzS5WRjRwuY0k88aPtzm+r4pN3LatDwGv8i7YPjFrYAEAiJrG4TE+/bhmU3yGFtT6iPD
         OU8iBXLEWQB6Cl4wwMBXHw2RbsQ3NKaJCMugPdIMIolo0DkkJ4iAF06XCaJxCgcYYNhz
         Q9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LYbBFTYA8WP3uLhYuQL/+al5l4be5UQELNQGVjPVkjQ=;
        b=VTpOZdAxMkeUJM9ibsbyF0seCaGx9Oa15E+vr2yeNC/CZf8HgIs0Uh+y9elqtbob4A
         /lJVup/ssUepd7+1dNY+lHQntWq+pv9vUukgfpz5b6ivhGv1URgpfWar66OvJZKg8hJz
         R3MnpeqQrq1lPV9IBsjsF7s3FtJXwyxQaf/ZmJx2hFaU9bAfdyTttJe8vKskeqx+7CMM
         4EFGKiLpSwo2G/uy7qdhO479E1jGPuMB2X+bZaN/4agGh33F2UDatlgjmt339SSwcIgn
         CQGHXKqwcUx1G+sL4suZKgLGb/QRE3G5VPcHrsvn6+8GMPFhX2lDI4ApPXLdQjDgqEO5
         no4w==
X-Gm-Message-State: AOAM532Hm1Jk6NsuK5gbRd0hXjmbmGloBd2WJ/YpUQ+udXUZpN5hAB0v
        74Judxb09C3lZc28O8jfxIcTi+T3D4tWIUGdQbOX7oAZeiI=
X-Google-Smtp-Source: ABdhPJyH5W8edtFJm9TsyzerliaY7KyAZxArimbI1yVwxUQj472jw2HgKASgWETkY7w5f/mdrj+RRveB8AqwBuIDZc8=
X-Received: by 2002:a25:37cb:: with SMTP id e194mr12869300yba.449.1639119216108;
 Thu, 09 Dec 2021 22:53:36 -0800 (PST)
MIME-Version: 1.0
References: <b3962370-b24a-d366-4d5c-ed2755f552fc@linux.alibaba.com>
In-Reply-To: <b3962370-b24a-d366-4d5c-ed2755f552fc@linux.alibaba.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 9 Dec 2021 22:53:25 -0800
Message-ID: <CAEf4Bzbxf4kEtCEWBSonomEp7ZiKBD50k-U941i=okKfgKb6FQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: add "bool skipped" to struct bpf_map
To:     Shuyi Cheng <chengshuyi@linux.alibaba.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 9, 2021 at 7:05 PM Shuyi Cheng <chengshuyi@linux.alibaba.com> w=
rote:
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

This doesn't apply cleanly, can you please rebase on top of the latest
bpf-next and resubmit? The changes themselves look good.

> v1:
> https://lore.kernel.org/bpf/CAEf4BzbtQGnGZTLbTdy1GHK54f5S7YNFQak7BuEfaqGE=
wqNNJA@mail.gmail.com/T/#m80ec7f8bc69dbcf4a5945e2aa6f16145901afc40
> v1->v2:
> -- add "bool skipped" to struct bpf_map.
> -- replace "bpf_map__is_internal(map) && !kernel_supports(obj,
> FEAT_GLOBAL_DATA))" with map->skipped
>
>   tools/lib/bpf/libbpf.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 18d95c6a89fe..a5bad6b43c15 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -432,6 +432,7 @@ struct bpf_map {
>         bool pinned;
>         bool reused;
>         __u64 map_extra;
> +       bool skipped;

please move up after pinned and reused to improve padding usage, thanks

>   };
>
>   enum extern_type {
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
>
