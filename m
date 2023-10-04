Return-Path: <bpf+bounces-11334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C78C57B75BD
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 02:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5A2D22812E1
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 00:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393D8374;
	Wed,  4 Oct 2023 00:20:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567117E
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 00:20:11 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF00EA7;
	Tue,  3 Oct 2023 17:20:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9b281a2aa94so274277766b.2;
        Tue, 03 Oct 2023 17:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696378808; x=1696983608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/As1VhnozQGSmkx2UPQKSVlv7yhYS02UudRqOf6rBnQ=;
        b=BS5ybtHfiGQtBZ0ocmDZWehMwXUrE+q2P0Af2fXQqeTIVwF+gL6QZXxJmm/BKTRdhO
         AtxfohmCszymb+kkJAq+hFeh1xsKyWeE5fb5Tjcl9SoQAl/24blDeObxF+A8LolAQH2X
         p5fNWZZvteAg4yHj4OnXoY/S+IM1sdZOClyjM7Vo1gdTWcBHm0gfxRJ1rNA6/Ef8xbwE
         /yDOity50BSha7GjLFMKcs+0ivnn8hm81NB6cfjHq2/CvRikFOgqD+5+HoXNVESJ4xMA
         a8umLH4Zwz61py+z8SuIKtNWt2vQw2ubhqSQxNfAmShCl8ljkZ/TYhOoWevFXaQ//lDV
         JgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696378808; x=1696983608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/As1VhnozQGSmkx2UPQKSVlv7yhYS02UudRqOf6rBnQ=;
        b=VNEjXibSr1rQKAeTPriUI0usVQwhpAPLj5rZnneDxqPVtsRlD8gDTJEEh8IpcDLXVO
         RdLvdBhU0GF58PAqHTP4YizFF9xNWVn9nuRHQA9NR9Iqzdjo6NvXsFLW77Z6J4IHQTl2
         UR2dEycAwhSJuRmB7YTEIm3m1L/5rCy5AO7fKhPs+XQzCdeILN8Mwed3aB/Xf2/p+hQq
         od3OZnDQPl/63521Qz2+jdndttshA5lg1ZO1Zgk+EB6WFWRlJMCbZhr+C9aVD4My9U5b
         RT6iZiAzDezW5VwEUbawsaqtOKGawOg3oinyRwQk00Hm7bjC0ar4/QHKbFs4TinnfgmZ
         xt9A==
X-Gm-Message-State: AOJu0YzPiUmmXelblYiJV8FSmunpB7ezZcpBKCYlT2wICKHpsc8Fq52C
	IAOJrZfv6Qt8eW3ZEBbouBdtfLqeoPxSDmltmns=
X-Google-Smtp-Source: AGHT+IEPgi3RYw3kAAWCjOk2e4sxVjRJabqJboxaKI/KgrhFcDR7ljN6iPFKt63ztp8NFI9JAIhrx9w74NsX5SLUii0=
X-Received: by 2002:a17:906:1daa:b0:9b8:b683:5854 with SMTP id
 u10-20020a1709061daa00b009b8b6835854mr103108ejh.61.1696378807949; Tue, 03 Oct
 2023 17:20:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003191412.3171385-1-irogers@google.com>
In-Reply-To: <20231003191412.3171385-1-irogers@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Oct 2023 17:19:56 -0700
Message-ID: <CAEf4BzYiayepsmABmVjhCgYoy4VZMFya6vYOhWQqx4Zt5+w+Sg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpftool: Align output skeleton ELF code
To: Ian Rogers <irogers@google.com>
Cc: Quentin Monnet <quentin@isovalent.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 12:15=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> libbpf accesses the ELF data requiring at least 8 byte alignment,
> however, the data is generated into a C string that doesn't guarantee
> alignment. Fix this by assigning to an aligned char array. Use sizeof
> on the array, less one for the \0 terminator, rather than generating a
> constant.
>
> Fixes: a6cc6b34b93e ("bpftool: Provide a helper method for accessing skel=
eton's embedded ELF data")
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> ---

See CI failures ([0]). You messed up tabs somewhere.

  [0] https://github.com/kernel-patches/bpf/actions/runs/6397510833/job/173=
65616392?pr=3D5756


>  tools/bpf/bpftool/gen.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 2883660d6b67..b8ebcee9bc56 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -1209,7 +1209,7 @@ static int do_skeleton(int argc, char **argv)
>         codegen("\
>                 \n\
>                                                                          =
   \n\
> -                       s->data =3D (void *)%2$s__elf_bytes(&s->data_sz);=
     \n\
> +                       s->data =3D (void *)%1$s__elf_bytes(&s->data_sz);=
     \n\
>                                                                          =
   \n\
>                         obj->skeleton =3D s;                             =
     \n\
>                         return 0;                                        =
   \n\
> @@ -1218,12 +1218,12 @@ static int do_skeleton(int argc, char **argv)
>                         return err;                                      =
   \n\
>                 }                                                        =
   \n\
>                                                                          =
   \n\
> -               static inline const void *%2$s__elf_bytes(size_t *sz)    =
   \n\
> +               static inline const void *%1$s__elf_bytes(size_t *sz)    =
   \n\
>                 {                                                        =
   \n\
> -                       *sz =3D %1$d;                                    =
     \n\
> -                       return (const void *)\"\\                        =
   \n\
> -               "
> -               , file_sz, obj_name);
> +                       static const char data[] __attribute__((__aligned=
__(8))) =3D \"\\\n\
> +               ",
> +               obj_name
> +       );
>
>         /* embed contents of BPF object file */
>         print_hex(obj_data, file_sz);
> @@ -1231,6 +1231,9 @@ static int do_skeleton(int argc, char **argv)
>         codegen("\
>                 \n\
>                 \";                                                      =
   \n\
> +                                                                        =
   \n\
> +                       *sz =3D sizeof(data) - 1;                        =
     \n\
> +                       return (const void *)data;                       =
   \n\
>                 }                                                        =
   \n\
>                                                                          =
   \n\
>                 #ifdef __cplusplus                                       =
   \n\
> --
> 2.42.0.582.g8ccd20d70d-goog
>

