Return-Path: <bpf+bounces-11242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F377B5FE4
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 06:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9728F28179D
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 04:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091B6111A;
	Tue,  3 Oct 2023 04:29:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAAC10FE
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 04:29:46 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7762CA4
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 21:29:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50348c54439so1974e87.1
        for <bpf@vger.kernel.org>; Mon, 02 Oct 2023 21:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696307382; x=1696912182; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3y9Js+pAcFfNUWfPPAIRNP6iI7Eb6pjWxsOR6R2pNEU=;
        b=ROpCwvPGOGudhTANCiLhdAUpk8nZRHfl+NBWikVrjvdUb7SCCNq8I5/jr2+xGovNj7
         L6aCyW6MdbP0WNTHFRFJXd2p4kDWUjDY6vPwgLq+ksmAH/YJeAX5gq9AvasvW87icf5w
         /Do5YKcSJualnYS6rZIqFSFIw+ZB7/JvVQabbwbH5vX6f+6nba0AK0tKDOJUpyDy/mHF
         6uTESAlLyinoRvrWINXiA+v+39EanWD6uS6rQbbjNxNbPTQsGUDNmUI/QFmNyi7Nc8KH
         s06qOtW1V1nIip5rcUzBZP1+HJx6AtctOVpTnYPre1hUWt28czoaLdcxLlQOQychU5vL
         Inhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696307382; x=1696912182;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3y9Js+pAcFfNUWfPPAIRNP6iI7Eb6pjWxsOR6R2pNEU=;
        b=LLNIL+ZZ/pXg2hkUB/e4T1NGpuCRaSy1qRcRbvWLpN6M+QbcO+U8Rq6g3LFAQm7l5i
         EoE6FHGJY3hTukXmkYRl0TsrMZ2TL2J8bgnozxPcDsLZqthp9HvslMpl5jtWLHGKmf0p
         GVR9uwAdbloiaIJhZwq64/+x0oXtW+lDdFmWJi0UfAPfhJPEYXkTDzDKIZCmPjFrGSHZ
         3Pi9dIPFchCGSvrpRmu4iZLFRQsvqgY8mHeih3GArJZxiZGRyKxs9gOTjgiwTVEDFJ3Z
         0ngg0YjUCsKxqFR5gCySozqSGwexaBX00ULHD7N4bn38YJ3fW8tQxjfIpw5/hBYbIctg
         cLxg==
X-Gm-Message-State: AOJu0YyCh8rCtbN2LyesrP04WNGqO7yNXzYaK90ZB9WZ8janxSczm4Bd
	9gdKztZKRMwQukgeZcRS/+ZIy15e4AQy4tOOb6tyBg==
X-Google-Smtp-Source: AGHT+IF2l/kPSCizOfppxnDy2kjAdT9nG3HM0xcm3P3O5GuGnoP6CwxyNXsUeLNb19p+Ixj6ayjU3LNyhj9UGML3LJc=
X-Received: by 2002:ac2:4e6c:0:b0:501:a2b4:8ff5 with SMTP id
 y12-20020ac24e6c000000b00501a2b48ff5mr29738lfs.7.1696307381734; Mon, 02 Oct
 2023 21:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231002223219.2966816-1-irogers@google.com>
In-Reply-To: <20231002223219.2966816-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 2 Oct 2023 21:29:29 -0700
Message-ID: <CAP-5=fWmxKHLGnQqBjUb8MZFak6YaKMPGKKWwBiCc6XWZbVPDw@mail.gmail.com>
Subject: Re: [PATCH v1] bpftool: Align output skeleton ELF code
To: Quentin Monnet <quentin@isovalent.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 3:32=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> libbpf accesses the ELF data requiring at least 8 byte alignment,
> however, the data is generated into a C string that doesn't guarantee
> alignment. Fix this by assigning to an aligned char array, use sizeof
> on the array, less one for the \0 terminator.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---

Perhaps this could have a fixes tag:
Fixes: d510296d331a ("bpftool: Use syscall/loader program in "prog
load" and "gen skeleton" command.")

The unaligned problem was seen in perf's offcpu code as well as bcc's
libbpf_tools. I didn't see problems with map data and opts data, but
inspection of the code shows they likely have the same issue. I was
testing with -fsanitize=3Dalignment and
-fsanitize-undefined-trap-on-error.

Thanks,
Ian

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

