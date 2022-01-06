Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75336485CF2
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 01:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343556AbiAFAKe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jan 2022 19:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343561AbiAFAKU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jan 2022 19:10:20 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F3CC061245
        for <bpf@vger.kernel.org>; Wed,  5 Jan 2022 16:10:19 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id e128so1154202iof.1
        for <bpf@vger.kernel.org>; Wed, 05 Jan 2022 16:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=02LO2J4GzrWsdiUyGm+SjdN1D8VCxMKer1ltHRH8yV0=;
        b=gslvmRKX5TOxqleP8yR2WWDJvJg2PXAb1FYXepxvoS6lq2hacHsLSZe+uIKz3P2JBq
         yPzvhMiOdo3EDIrXF4S/gJmCpdotIYpxbkiT0gXd7yepX7bSjVU8BdY9p6Z0/mHrKZ40
         ZoXkEk1ojoQfz+1x16F4OLk6HOXFyQ88CUbttzLoGsGmv4dMhAsUbTPLyGZx9YeB7d3U
         Ndbfm3gVfL4GsALc2Op8Cw8IvBkJKlouOdat0oN9LhbgKA/tvHMyejzWMBQ8V/OmRIeJ
         HM8B/6tcAL9cXa69ahFVKf7BYJtfiHjK7wPlIMKlsUdaj8y9RkB3O4Jcsrp9clV3MTp2
         Gtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=02LO2J4GzrWsdiUyGm+SjdN1D8VCxMKer1ltHRH8yV0=;
        b=Y5/tqDRuqvtjHbhzFn4G0WxLXR/0B64pf4YrEXJ8GCm7iX949PFBLW+Cb9+D7SL6Um
         jX7t+N8l/hVSGf4+F8IZVBbtuK9KoFP5WaysOMcFrmaksw+Cxz+l1QdFAL/109F4HIyf
         t678v4bk3ExufGwhwY4MpdWyeX4uUEMwVK3QkwlRYH5GzL9ATWeWG37IeG0EmLI41LfV
         DmvJvgLW7elhB5nbxLwP7KNaOhtexOBrogBTNlxLqo24Tl9EUvd6Ovx3pV7E3Kbutwg1
         UgXst49QyLgqkmqqXVedxLGWCgZIBdfZ80L/IYagfHgOdVHJnkDtkQBIEONaeCp+Tq2y
         +kvw==
X-Gm-Message-State: AOAM532OlmVSn20TaYUWm+PMCLW/q41EqwM4eCZo40sfHpHu1RXXDbPx
        3mVXKKWT3H6FuI4cZP7qZoWvcGsCdSz4AyfCWXHKVgVC
X-Google-Smtp-Source: ABdhPJxja/OrWfDQMFO4VhWm6hqD1ltMCHd27NrxUGKTOq/EbhF2RVVkE0P+CJrd8pot4ohx2R0CrADEUbjoz7rpIAA=
X-Received: by 2002:a02:c72e:: with SMTP id h14mr27578803jao.103.1641427818836;
 Wed, 05 Jan 2022 16:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20220105000601.2090044-1-christylee@fb.com>
In-Reply-To: <20220105000601.2090044-1-christylee@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Jan 2022 16:10:07 -0800
Message-ID: <CAEf4BzZz53jbCr9TzUydoPKHoyw9hbvRXLO0X+TN2xotPFMz3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf 1.0: deprecate bpf_map__is_offload_neutral()
To:     Christy Lee <christylee@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Christy Lee <christyc.y.lee@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 4, 2022 at 4:06 PM Christy Lee <christylee@fb.com> wrote:
>
> Deprecate bpf_map__is_offload_neutral(). It=E2=80=99s most probably broke=
n
> already. PERF_EVENT_ARRAY isn=E2=80=99t the only map that=E2=80=99s not s=
uitable
> for hardware offloading. Applications can directly check map type
> instead.
>
> [0] Closes: https://github.com/libbpf/libbpf/issues/306
>
> Signed-off-by: Christy Lee <christylee@fb.com>
> ---

Applied to bpf-next, thanks!

>  tools/bpf/bpftool/prog.c | 2 +-
>  tools/lib/bpf/libbpf.h   | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index f874896c4154..2a21d50516bc 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1655,7 +1655,7 @@ static int load_with_options(int argc, char **argv,=
 bool first_prog_only)
>         j =3D 0;
>         idx =3D 0;
>         bpf_object__for_each_map(map, obj) {
> -               if (!bpf_map__is_offload_neutral(map))
> +               if (bpf_map__type(map) !=3D BPF_MAP_TYPE_PERF_EVENT_ARRAY=
)
>                         bpf_map__set_ifindex(map, ifindex);
>
>                 if (j < old_map_fds && idx =3D=3D map_replace[j].idx) {
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 85dfef88b3d2..ec4309cb9771 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -744,6 +744,7 @@ LIBBPF_API void *bpf_map__priv(const struct bpf_map *=
map);
>  LIBBPF_API int bpf_map__set_initial_value(struct bpf_map *map,
>                                           const void *data, size_t size);
>  LIBBPF_API const void *bpf_map__initial_value(struct bpf_map *map, size_=
t *psize);
> +LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_map__type() instead")
>  LIBBPF_API bool bpf_map__is_offload_neutral(const struct bpf_map *map);
>
>  /**
> --
> 2.30.2
>
