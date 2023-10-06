Return-Path: <bpf+bounces-11568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1F37BC035
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 22:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857CC282043
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 20:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B5D43ABB;
	Fri,  6 Oct 2023 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDVVEFv8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195013D38E
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 20:20:27 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD80DC2;
	Fri,  6 Oct 2023 13:20:24 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-533edb5ac54so4726432a12.0;
        Fri, 06 Oct 2023 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696623623; x=1697228423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKhoOovJJCN2upy+4Afr69/fh1TMRJWzCU1Zea4v2kE=;
        b=PDVVEFv8gIqFq3oHh6twa4sOauegXiPp1XL2qFvuk4iVzNTRZ6oq3rZkp7Bka9I+sK
         PCiZSFtltVr6V+8+7tldooPU/9lFOtNYRvo0v+jZQeFqUJMxMMZGnxet+hejOD1NFukw
         Lt27bTLn95cP2puvOjEoUVuchnjR3UsTdxt0nuF03uZ8TZOnxT/DFmtj1iYM4juCgOUQ
         gCcWXwuyMI0m9JDXYFIzX07JlLNxfneB4Ey/SjbV3CcQEZwMFNVwV9LuTkxEFIBzC88P
         FsAdawsRrHjmV8shCfeBozXd1nP54fBF0xX+NDLmRWC0qims9FPiXWwP+0ea8kEqzufN
         FmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623623; x=1697228423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKhoOovJJCN2upy+4Afr69/fh1TMRJWzCU1Zea4v2kE=;
        b=WSUUrYI6F3aMXbVJX+vjmViYDuM1YekvqaOKTQ5rfxlRwnI++CYVjRj9hUDASkpC4T
         V3Ha0N50xZzzoslRX+/e5ESjknc/092ML1ns2LonCcVJEcsBAPQXpNoAVcVC81ls38ad
         sHJRs+Csxis2/f4iCrtwWU6pvYeGCpuGjpj2alOWm0eN87UK0N4razyZoJpHj5ERKSN3
         DuuYpUjaCDdok95Le31IjjqMbfd17w1UFo0+dCZ/3t/ytTl51A3CfBjfF80vCGQfV9Ot
         jGc8IGe8ri03fjd8J8OCuIXml1dBAXLGSTrB9QU19FsPDhUywCmbvy/4QMz3Z0Pe70Fw
         yrRQ==
X-Gm-Message-State: AOJu0YzlNbJAQFpAkGjiuEAqRrtDDR9/bnc2yfCPT2eZ71K4EaEMvWih
	Td5HgBTzQhVT81ORUckAXUeiKyib1eK/PdEfN4TEf1yxNCs=
X-Google-Smtp-Source: AGHT+IFzBm9NPnRnmS8KzfFV5+HqYcGQ+gqqDuIW64le9nHxHtHRtiylHsLDpMMTFMiBw97Ki6fkalJg7XGv9Jw0h1g=
X-Received: by 2002:aa7:d151:0:b0:530:db58:61c8 with SMTP id
 r17-20020aa7d151000000b00530db5861c8mr8699991edo.23.1696623622922; Fri, 06
 Oct 2023 13:20:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005220324.3635499-1-irogers@google.com>
In-Reply-To: <20231005220324.3635499-1-irogers@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Oct 2023 13:20:11 -0700
Message-ID: <CAEf4Bza0YGVW0G-oO3h1j0L0ytiKsn-pRbuqU39C2wO0VP__BA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] bpftool: Align output skeleton ELF code
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 5, 2023 at 3:03=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
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
> Acked-by: Quentin Monnet <quentin@isovalent.com>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> ---
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

Seems like you based this on top of bpf tree, can you please rebase
onto bpf-next, it has a small change here and I can't apply it cleanly
anymore. Other than that it looks good. Thanks!


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
> 2.42.0.609.gbb76f46606-goog
>

