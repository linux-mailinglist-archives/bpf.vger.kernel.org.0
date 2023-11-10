Return-Path: <bpf+bounces-14728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB007E792F
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 07:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1897C280F91
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 06:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0326127;
	Fri, 10 Nov 2023 06:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB7z2OUt"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E411568E
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 06:21:47 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC1E4C31
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:21:45 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5094cb3a036so2217110e87.2
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 22:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699597303; x=1700202103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hToQ5Cj8l4RxryRjiaaqVawjc0UDw/kI+oQ6dgneS7E=;
        b=gB7z2OUtLBfNgKiFqMhlgEVsaRe8jfTlkGQ5bHNrTMNs7Q88h3tSqCcV6SaDuS5vnc
         FxnTDTxxqoQYq542z1lKM63WNrbSIDr4Gp0PE0nbLvsj1D2JpX2u/w4YzHg0L6MNp/++
         t1lEVZcgXVy713nOUq4/wOSidED6ECErY4/6+2aWTvhSf9CK+hBpZJ2DUF7kX5en4xte
         JyCBv+QZRYn4ZmAnYRoko/W4PUGC3Bl7g0ej/eCqRAr0K1bPB7ig16O2e9sms8eYbZXE
         o36eA/fkSgOJ+rA/dJDIXNBLNnu1vQUJ/Snox4wko1Zu7T+0POps7wLBUQswahZVPIla
         Jcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699597303; x=1700202103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hToQ5Cj8l4RxryRjiaaqVawjc0UDw/kI+oQ6dgneS7E=;
        b=ln9CaqCReMU9tsCoPZeV/E9eY5JAOXtQajgiamj0rBmmZLFkNGwjviKG1h1xZhjnqs
         ph7WV17EAyA1G6fWxoYpmROcLAob+XHvwTSdMB/7no8KT/79ymjc8Q6n/MU7pXOOUiFO
         1sMGW5t1ve+XvuNJdWk2BKmAXkvOJjS+fCH28aLw+sdQOrls+kMCHGsKCLu3z3llzYlg
         ubhUAAsrI5MlPCLc0uY+GLkdg10RNqlygGTmDROQYFf/8BGup/MURO6TdJ9yLsO6kzVK
         8SsK6dSJNOhJrf9g9wELJqTYYYUU3uljRNckb06KbS3R9qrZy2CKKGHzQuY66xfZdTAO
         0BXQ==
X-Gm-Message-State: AOJu0YwAzIM6grXyzTEfxGVqCdTfn0UrAAn9moDMzh+B3Ybnipi3Xm87
	9du4X6E1zXkno4kL414JjdzrAQHG6DRZPR+teFulZ0OXfMc=
X-Google-Smtp-Source: AGHT+IEli5ShRVaRWimHI8jM6NATqIt4CVbMmPF7TEl5rpnyV1KfGy1VJihopOirD/NWwkGlf9UWcFM17KMf/VNZk1k=
X-Received: by 2002:a50:aacf:0:b0:542:d591:443b with SMTP id
 r15-20020a50aacf000000b00542d591443bmr5035492edc.17.1699595404289; Thu, 09
 Nov 2023 21:50:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109092838.721233-1-jolsa@kernel.org> <20231109092838.721233-2-jolsa@kernel.org>
In-Reply-To: <20231109092838.721233-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 21:49:53 -0800
Message-ID: <CAEf4BzZcOPREXiPa=toWd3iyHmeezJ=SqD9f4NreeytzhszyLQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/6] libbpf: Add st_type argument to
 elf_resolve_syms_offsets function
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 1:28=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We need to get offsets for static variables in following changes,
> so making elf_resolve_syms_offsets to take st_type value as argument
> and passing it to elf_sym_iter_new.
>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/elf.c                                        | 5 +++--
>  tools/lib/bpf/libbpf.c                                     | 2 +-
>  tools/lib/bpf/libbpf_internal.h                            | 3 ++-
>  tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 2 +-
>  4 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> index 2a62bf411bb3..b02faec748a5 100644
> --- a/tools/lib/bpf/elf.c
> +++ b/tools/lib/bpf/elf.c
> @@ -407,7 +407,8 @@ static int symbol_cmp(const void *a, const void *b)
>   * size, that needs to be released by the caller.
>   */
>  int elf_resolve_syms_offsets(const char *binary_path, int cnt,
> -                            const char **syms, unsigned long **poffsets)
> +                            const char **syms, unsigned long **poffsets,
> +                            int st_type)
>  {
>         int sh_types[2] =3D { SHT_DYNSYM, SHT_SYMTAB };
>         int err =3D 0, i, cnt_done =3D 0;
> @@ -438,7 +439,7 @@ int elf_resolve_syms_offsets(const char *binary_path,=
 int cnt,
>                 struct elf_sym_iter iter;
>                 struct elf_sym *sym;
>
> -               err =3D elf_sym_iter_new(&iter, elf_fd.elf, binary_path, =
sh_types[i], STT_FUNC);
> +               err =3D elf_sym_iter_new(&iter, elf_fd.elf, binary_path, =
sh_types[i], st_type);
>                 if (err =3D=3D -ENOENT)
>                         continue;
>                 if (err)
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e067be95da3c..ea9b8158c20d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11447,7 +11447,7 @@ bpf_program__attach_uprobe_multi(const struct bpf=
_program *prog,
>                         return libbpf_err_ptr(err);
>                 offsets =3D resolved_offsets;
>         } else if (syms) {
> -               err =3D elf_resolve_syms_offsets(path, cnt, syms, &resolv=
ed_offsets);
> +               err =3D elf_resolve_syms_offsets(path, cnt, syms, &resolv=
ed_offsets, STT_FUNC);
>                 if (err < 0)
>                         return libbpf_err_ptr(err);
>                 offsets =3D resolved_offsets;
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index f0f08635adb0..b5d334754e5d 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -594,7 +594,8 @@ int elf_open(const char *binary_path, struct elf_fd *=
elf_fd);
>  void elf_close(struct elf_fd *elf_fd);
>
>  int elf_resolve_syms_offsets(const char *binary_path, int cnt,
> -                            const char **syms, unsigned long **poffsets)=
;
> +                            const char **syms, unsigned long **poffsets,
> +                            int st_type);
>  int elf_resolve_pattern_offsets(const char *binary_path, const char *pat=
tern,
>                                  unsigned long **poffsets, size_t *pcnt);
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index cd051d3901a9..ece260cf2c0b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -249,7 +249,7 @@ static void __test_link_api(struct child *child)
>         int link_extra_fd =3D -1;
>         int err;
>
> -       err =3D elf_resolve_syms_offsets(path, 3, syms, (unsigned long **=
) &offsets);
> +       err =3D elf_resolve_syms_offsets(path, 3, syms, (unsigned long **=
) &offsets, STT_FUNC);
>         if (!ASSERT_OK(err, "elf_resolve_syms_offsets"))
>                 return;
>
> --
> 2.41.0
>

