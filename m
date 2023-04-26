Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCC96EFB11
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 21:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbjDZTZE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 15:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbjDZTYt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 15:24:49 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2860226B8
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:24:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5066ce4f725so10991143a12.1
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682537068; x=1685129068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdLbvibj1IxG+sUfqeICR4jorhWVaQNVTMb8cqMkFWI=;
        b=km/EjHcPmHBUxhiJzJjs8yoRwpv+IbRot/Ym5oBwU8+xfH77QJ1pVr5x68Tmjn1v6a
         ge7htmuI5DxW46iHayr5jwVcX24Uvpm/kESTadwlb7e5V8lCfWvt6wJb044qqGoGz9MF
         4+DdRKW7xZ2YAauvl+FgiGf6MYoEs/XMPuuVY6y4gFhCLbzv2U59mM/TQ5pusORBNYhf
         9jzWu5FpzhS50jla5XPEgZhrNHJ38iv3GyOCc4plsTVHDEGa6fNmVbYi5JhDD+vqO0YL
         QikijJSeweruHPJAv8mSirYmSJnb1NvX3VYGYEkHz/o46tZ6nQNRvJec6yTFrkt9x7Df
         ZB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682537068; x=1685129068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdLbvibj1IxG+sUfqeICR4jorhWVaQNVTMb8cqMkFWI=;
        b=I8w8u5NwpZ0Le5zz9DhIltx2W4FGq8aq/xP8H45Q1UHsPon2NjoUar9iPgpPnI3GfF
         3Lp0UYVfd9E0EGg7nyRqqps5nzwqAPqnswJq7sZj2Y5LnbWcrRPfcqe4Fs6t6hKjRQoH
         J/vHmWPjJ1fvbThYLgndHAXz7iB4ahuotrUaWJE1SQBuufh47FPWwL0jiWSuYTsJyxOo
         783zJuXb+qr12Jh67uk1DJsSbbzdrvuD7HlGTTsor7pD8d3Uc8hXEp+IzxZ8O7hRmV+m
         kPWizDyH/eMucgqwkTyzo0bnBT1UtuVKi2MHaM1fUuVONldG0jmhiAyzq0Wjw4c01gR+
         H3iw==
X-Gm-Message-State: AAQBX9fq0XI4slpCBE3pDmQ2IWvP+wvK6ZvrtM1cOspkTCdXfHsi4lat
        xpRB0PG0RkthizecqpkNKtx2Goruy7D7jt3MYDE=
X-Google-Smtp-Source: AKy350Ylj/V59SXkPNZIuFnRVYwaqIeoaIps1ITGOYb70oxli7/hPADAlKYoSiYmgqa4jnXy+INGxN9WVFvdNb6M2x4=
X-Received: by 2002:a50:e604:0:b0:506:e626:2da with SMTP id
 y4-20020a50e604000000b00506e62602damr22245472edm.4.1682537068417; Wed, 26 Apr
 2023 12:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230424160447.2005755-1-jolsa@kernel.org> <20230424160447.2005755-9-jolsa@kernel.org>
In-Reply-To: <20230424160447.2005755-9-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 12:24:16 -0700
Message-ID: <CAEf4BzYKkPHBqbr1pXjA6jEkvJTpu0bjFHt0Nu0bm4un3DD6mQ@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next 08/20] libbpf: Add elf_find_patern_func_offset
 function
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 24, 2023 at 9:06=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding elf_find_patern_func_offset function that looks up
> offsets for symbols specified by pattern argument.
>
> The 'pattern' argument allows wildcards (*?' supported).
>
> Offsets are returned in allocated array together with its
> size and needs to be released by the caller.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---


Why do we need to expose any elf-related helpers as libbpf public API?
Just to use them in selftests? If yes, then selftests can use libbpf
internal helpers just like bpftool due to static linking. In general,
it of course doesn't make sense for libbpf to provide ELF helpers as
part of its API.

Also s/patern/pattern/.


>  tools/lib/bpf/libbpf.c   | 121 +++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   |   7 +++
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 129 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0b15609d4573..7eb7035f7b73 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11052,6 +11052,127 @@ elf_find_multi_func_offset(const char *binary_p=
ath, int cnt,
>         return ret;
>  }
>
> +struct match_pattern_data {
> +       const char *pattern;
> +       struct elf_func_offset *func_offs;
> +       size_t func_offs_cnt;
> +       size_t func_offs_cap;
> +};
> +
> +static int pattern_done(void *_data)
> +{
> +       struct match_pattern_data *data =3D _data;
> +
> +       // If we found anything in the first symbol section, do not searc=
h others
> +       // to avoid duplicates.

C++ comment


> +       return data->func_offs_cnt;
> +}
> +

[...]
