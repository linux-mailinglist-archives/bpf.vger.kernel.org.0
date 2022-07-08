Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3C456C4D0
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 02:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbiGHXRM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 19:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiGHXRL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 19:17:11 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3924D2D1EA
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 16:17:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sb34so36795ejc.11
        for <bpf@vger.kernel.org>; Fri, 08 Jul 2022 16:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uEte+AcMORgI8ePwxR/p7Ilp4bNfIcLgaiJV6AtUMsQ=;
        b=PddYhANhgE10xYufejpGEO3/QlJS7ows0Rgl7V/2sFPkWCWJztZa60mnftoyrYOw5s
         Rm1o6lSR2JGLoqGPYYgt4dYBFoTiPOIPPsUMV2lcRs1scAwWTCgFDFVCo3naAc12A3HF
         m5wLa/rfCdp5t9kfb8C9hjhTcpudTy45rpDi1Ky6tsVC9mpeqVm7yiF8WM6RCfwlk/Z6
         J900hjGdaHXYnu0nwjGxND0w3uuhvuftNLv1cMgXsS8N1T8xjPkI/l2Lh+TjlkzNc96r
         sPMb+OgYwiQJfvBJqMuZnS4QzSrN4GEuGro7lnjDjNn6BZaP8DfzeJVh/vXQWW5LAzCi
         xjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uEte+AcMORgI8ePwxR/p7Ilp4bNfIcLgaiJV6AtUMsQ=;
        b=Ow+2xSrHEivz6gK3R6Vq/kpONQ79BIba9bI+Be3X2tA4bJ4R2L2uc4/pYbrYb5JQGr
         9qiQTkWhAwkAJeLUxpB9e7Vty8WVpQyIPzSDGHymcAkokEX3eoYrMWj8XsbVO1BQIMUB
         +SZLrMxCizu35XxdDMaIYna7g5Sp6fF1bzzGtpaUjvTlo0TYrGoMCZW95i6PbUwvQhO2
         G1O5QDP56DhWFmULeLPcnx+13X2gcKjEsyFp5XsMxDxW5ZM6WffClA1WvvA6yew5OBPF
         9L9l62X+UNAG/xKQY3HTYMzQFKU5F+7UkB+c+mk+rpHZXw/CtYuwkSqAc/sBgfyl8+oa
         YD9Q==
X-Gm-Message-State: AJIora831XTQt0EQJL5/9FEqBctpPrG/yAPQpLGmO9NzMc7KQlidp7AY
        mJ9CU0Z/perzuk+2EIzOBScZZQ3U5mM9U7gDzF4=
X-Google-Smtp-Source: AGRyM1tOISUfYTOJr8OJWbD9LhC0t6Uf1ngDHVch/hL8YBNIIzXXKis6NPjabYspylZm8oY5qSoaKVXmOL3Tju2Kbb8=
X-Received: by 2002:a17:906:6a11:b0:726:97b8:51e9 with SMTP id
 qw17-20020a1709066a1100b0072697b851e9mr6076509ejc.115.1657322228785; Fri, 08
 Jul 2022 16:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAJGfEnaNB8bm3rRyeYU8TcvgTbxnHMfoDbmZW_VEc2O+Ex3g=A@mail.gmail.com>
In-Reply-To: <CAJGfEnaNB8bm3rRyeYU8TcvgTbxnHMfoDbmZW_VEc2O+Ex3g=A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Jul 2022 16:16:57 -0700
Message-ID: <CAEf4BzZtSPvM1H-tvZUuB312x7--WnAQfi_kJTjK57jp6-+gvQ@mail.gmail.com>
Subject: Re: [PATCH RFC]libbpf:fail to get the pinned bpf map, because the
 length of the name was limited
To:     anquan wu <leiqi1323@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, martin.lau@linux.dev,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>
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

On Fri, Jul 8, 2022 at 5:12 AM anquan wu <leiqi1323@gmail.com> wrote:
>
> BPF map name was limited to BPF_OBJ_NAME_LEN from https://github.com/torv=
alds/linux/blob/master/include/uapi/linux/bpf.h#L1286.
>
> If a map name is defined as being longer than BPF_OBJ_NAME_LEN , it will =
be truncated to BPF_OBJ_NAME_LEN when a userspace program creates the map u=
sing bpf syscall . A pinned map also generates a path in the /sys.
>
> bpf(BPF_OBJ_GET, {pathname=3D"/sys/fs/bpf/process_pinned_map", bpf_fd=3D0=
, file_flags=3D0}, 144) =3D -1 ENOENT (No such file or directory)
>
> bpf(BPF_MAP_CREATE, {map_type=3DBPF_MAP_TYPE_HASH, key_size=3D4, value_si=
ze=3D4, max_entries=3D1024, map_flags=3D0, inner_map_fd=3D0, map_name=3D"pr=
ocess_pinned_", map_ifindex=3D0, btf_fd=3D3, btf_key_type_id=3D6, btf_value=
_type_id=3D10, btf_vmlinux_value_type_id=3D0}, 72) =3D 4
>
> bpf(BPF_OBJ_PIN, {pathname=3D"/sys/fs/bpf/process_pinned_map", bpf_fd=3D4=
, file_flags=3D0}, 144) =3D 0
>
> If the previous program wanted to reuse the map=EF=BC=8Cit can not get bp=
f_map by name, because the name of the program is only partially the same a=
s the name which get from pinned path.
>
> I came up with a solution.
>
> If the name of pinned map are the same as the name of bpf object for the =
first (BPF_OBJ_NAME_LEN - 1), bpf map name still uses the name of bpf objec=
t.
>
> Signed-off-by: anquan.wu <leiqi96@hotmail.com>
> ---

Please read how to properly format the patch. Start with [0]

  [0] https://kernelnewbies.org/FirstKernelPatch


>  tools/lib/bpf/libbpf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e89cc9c885b3..73c7f5093073 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4337,7 +4337,11 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
>     if (err)
>         return libbpf_err(err);
>
> -   new_name =3D strdup(info.name);
> +   if (!strncmp(map->name, info.name, strlen(info.name))) {
> +       new_name =3D strdup(map->name);
> +   } else {
> +       new_name =3D strdup(info.name);
> +   }

as for the approach... I think it would be a bit safer to improve the
name truncation. Make sure that strlen(info.name) is exactly
BPF_OBJ_NAME_LEN - 1, and only then if strncmp() matches use
map->name.

>     if (!new_name)
>         return libbpf_err(-errno);
>
> --
