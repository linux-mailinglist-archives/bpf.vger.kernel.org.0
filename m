Return-Path: <bpf+bounces-4720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8EA74E5A0
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 06:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F253281671
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 04:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9594424;
	Tue, 11 Jul 2023 04:00:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5878B3D6E;
	Tue, 11 Jul 2023 04:00:43 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B5D12A;
	Mon, 10 Jul 2023 21:00:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51e48e1f6d1so3577747a12.1;
        Mon, 10 Jul 2023 21:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689048038; x=1691640038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOryFyqClcuZHD0bAntKnO0NvSim7Crvrdqffvbgo3s=;
        b=XTwc6oo2L3c5i3cYbPpzyUBu4CHWyUOu3LxZ87fAmfnTsk5FKVZLJrx5Ua0RKXu3Zz
         Nlh2RB5Sh1gC64fYBKvSbgIA24WhNJOPlbXWMIBgVuVgURQbJqopYuNz7oRKiYlhOjP2
         bx4WTADAmhSK6Y/Bjh0XzAwkzTFagIbFvfdB7wpjyWf0IpygwDelf9B9yyFgZ88jLWAX
         najWqUtuHVQWnC4N1ijMNIJdPVqhKMPNLvty/DrO9lPzrLGY1XVJS6otPRjEdLJ0i6Yy
         OzhJhbhRfeW5gky/sxmMJvanYQmClZHITxHQ269PstXyhCOthDMISVHL213BGCEN81pp
         4Dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689048038; x=1691640038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOryFyqClcuZHD0bAntKnO0NvSim7Crvrdqffvbgo3s=;
        b=Woo/5O94QENNvy32wZ7CJksW5Uewv8LXoWVlLItrrAAOt4a8UZusKjKH38pWJ0uraR
         OeSlAuJ46eFMFWVryFV+itiSqHERLgd+AUt9DlnWI6tkzPeIAJcUuiKMR84Z26bOrEHc
         cESF6pDYtq5pLAX4Id2xzjdBZaWb7vCObVo0pnrrDrYwd1Iqe3tH7tWPRRoKilm04GnI
         qbixKErdDy3U2ED0gH5KNQcuaJM7TDV7QjY0d9Y/waF7SEwjSuR3lSmm/zc6u4EwF1Tc
         Mxi1oLNaNx7L9a2ShBeK5QP36lgocgOEVcWb1Yg+La1EqPRNzD85ubqBXBKhkJUxbZrz
         j/xg==
X-Gm-Message-State: ABy/qLaZXff3YenUsmfoalxGhxqGTdbk6ixSh36QQurTEhIG+2L0eQZ6
	Iz9nL2X1GXMFslawD0e6gQ67WHOHS0IrkLCtiY0=
X-Google-Smtp-Source: APBJJlEYwmo9bQXtCez6GGDlHVPbByJT8EmIfvGkS0KcfwmlqJmzzKlyxI+C6pRmgnHImLzT6jAhTnHvkVuJ2wP3DvE=
X-Received: by 2002:a05:6402:8d0:b0:51e:f23:5555 with SMTP id
 d16-20020a05640208d000b0051e0f235555mr12778871edz.33.1689048038211; Mon, 10
 Jul 2023 21:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710201218.19460-1-daniel@iogearbox.net> <20230710201218.19460-4-daniel@iogearbox.net>
In-Reply-To: <20230710201218.19460-4-daniel@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 10 Jul 2023 21:00:25 -0700
Message-ID: <CAEf4BzaGbVe3ip_cDxV0u8bBUEVExdqHXOFBorHWZ0tpDBLLnw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/8] libbpf: Add opts-based
 attach/detach/query API for tcx
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, 
	razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com, 
	kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org, 
	davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 1:12=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Extend libbpf attach opts and add a new detach opts API so this can be us=
ed
> to add/remove fd-based tcx BPF programs. The old-style bpf_prog_detach() =
and
> bpf_prog_detach2() APIs are refactored to reuse the new bpf_prog_detach_o=
pts()
> internally.
>
> The bpf_prog_query_opts() API got extended to be able to handle the new
> link_ids, link_attach_flags and revision fields.
>
> For concrete usage examples, see the extensive selftests that have been
> developed as part of this series.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  tools/lib/bpf/bpf.c      | 105 +++++++++++++++++++++++++--------------
>  tools/lib/bpf/bpf.h      |  92 ++++++++++++++++++++++++++++------
>  tools/lib/bpf/libbpf.c   |  12 +++--
>  tools/lib/bpf/libbpf.map |   1 +
>  4 files changed, 157 insertions(+), 53 deletions(-)
>

Thanks for doc comments! Looks good, left a few nits with suggestions
for simplifying code, but it's minor.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 3b0da19715e1..3dfc43b477c3 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -629,55 +629,87 @@ int bpf_prog_attach(int prog_fd, int target_fd, enu=
m bpf_attach_type type,
>         return bpf_prog_attach_opts(prog_fd, target_fd, type, &opts);
>  }
>
> -int bpf_prog_attach_opts(int prog_fd, int target_fd,
> -                         enum bpf_attach_type type,
> -                         const struct bpf_prog_attach_opts *opts)
> +int bpf_prog_attach_opts(int prog_fd, int target,
> +                        enum bpf_attach_type type,
> +                        const struct bpf_prog_attach_opts *opts)
>  {
> -       const size_t attr_sz =3D offsetofend(union bpf_attr, replace_bpf_=
fd);
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, expected_rev=
ision);
> +       __u32 relative_id, flags;
>         union bpf_attr attr;
> -       int ret;
> +       int ret, relative;
>
>         if (!OPTS_VALID(opts, bpf_prog_attach_opts))
>                 return libbpf_err(-EINVAL);
>
> +       relative_id =3D OPTS_GET(opts, relative_id, 0);
> +       relative =3D OPTS_GET(opts, relative_fd, 0);
> +       flags =3D OPTS_GET(opts, flags, 0);
> +
> +       /* validate we don't have unexpected combinations of non-zero fie=
lds */
> +       if (relative > 0 && relative_id)
> +               return libbpf_err(-EINVAL);

I left a comment in the next patch about this, I think it should be
simple `if (relative_fd && relative_id) { /* bad */ }`. But see the
next patch for why.

> +       if (relative_id) {
> +               relative =3D relative_id;
> +               flags |=3D BPF_F_ID;
> +       }

it's a bit hard to follow as written (to me at least). How about a
slight variation that has less in-place state update


int relative_fd, relative_id;

relative_fd =3D OPTS_GET(opts, relative_fd, 0);
relative_id =3D OPTS_GET(opts, relative_id, 0);

/* only one of fd or id can be specified */
if (relative_fd && relative_id > 0)
    return libbpf_err(-EINVAL);

... then see further below

> +
>         memset(&attr, 0, attr_sz);
> -       attr.target_fd     =3D target_fd;
> -       attr.attach_bpf_fd =3D prog_fd;
> -       attr.attach_type   =3D type;
> -       attr.attach_flags  =3D OPTS_GET(opts, flags, 0);
> -       attr.replace_bpf_fd =3D OPTS_GET(opts, replace_prog_fd, 0);
> +       attr.target_fd          =3D target;
> +       attr.attach_bpf_fd      =3D prog_fd;
> +       attr.attach_type        =3D type;
> +       attr.attach_flags       =3D flags;
> +       attr.relative_fd        =3D relative;

instead of two lines above, have simple if/else

if (relative_if) {
    attr.relative_id =3D relative_id;
    attr.attach_flags =3D flags | BPF_F_ID;
} else {
    attr.relative_fd =3D relative_fd;
    attr.attach_flags =3D flags;
}

This combined with the piece above seems very straightforward in terms
of what is checked and what's passed into attr. WDYT?

> +       attr.replace_bpf_fd     =3D OPTS_GET(opts, replace_fd, 0);
> +       attr.expected_revision  =3D OPTS_GET(opts, expected_revision, 0);
>
>         ret =3D sys_bpf(BPF_PROG_ATTACH, &attr, attr_sz);
>         return libbpf_err_errno(ret);
>  }
>
> -int bpf_prog_detach(int target_fd, enum bpf_attach_type type)
> +int bpf_prog_detach_opts(int prog_fd, int target,
> +                        enum bpf_attach_type type,
> +                        const struct bpf_prog_detach_opts *opts)
>  {
> -       const size_t attr_sz =3D offsetofend(union bpf_attr, replace_bpf_=
fd);
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, expected_rev=
ision);
> +       __u32 relative_id, flags;
>         union bpf_attr attr;
> -       int ret;
> +       int ret, relative;
> +
> +       if (!OPTS_VALID(opts, bpf_prog_detach_opts))
> +               return libbpf_err(-EINVAL);
> +
> +       relative_id =3D OPTS_GET(opts, relative_id, 0);
> +       relative =3D OPTS_GET(opts, relative_fd, 0);
> +       flags =3D OPTS_GET(opts, flags, 0);
> +
> +       /* validate we don't have unexpected combinations of non-zero fie=
lds */
> +       if (relative > 0 && relative_id)
> +               return libbpf_err(-EINVAL);
> +       if (relative_id) {
> +               relative =3D relative_id;
> +               flags |=3D BPF_F_ID;
> +       }

see above, I think the same data flow simplification can be done

>
>         memset(&attr, 0, attr_sz);
> -       attr.target_fd   =3D target_fd;
> -       attr.attach_type =3D type;
> +       attr.target_fd          =3D target;
> +       attr.attach_bpf_fd      =3D prog_fd;
> +       attr.attach_type        =3D type;
> +       attr.attach_flags       =3D flags;
> +       attr.relative_fd        =3D relative;
> +       attr.expected_revision  =3D OPTS_GET(opts, expected_revision, 0);
>
>         ret =3D sys_bpf(BPF_PROG_DETACH, &attr, attr_sz);
>         return libbpf_err_errno(ret);
>  }
>

[...]

> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index d9ec4407befa..a95d39bbef90 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -396,4 +396,5 @@ LIBBPF_1.3.0 {
>         global:
>                 bpf_obj_pin_opts;
>                 bpf_program__attach_netfilter;
> +               bpf_prog_detach_opts;

I think it sorts before bpf_program__attach_netfilter?

>  } LIBBPF_1.2.0;


> --
> 2.34.1
>

