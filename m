Return-Path: <bpf+bounces-54704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AF9A70867
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 18:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E60188E647
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 17:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450E125C717;
	Tue, 25 Mar 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rQkSHL1J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DE518DB0C
	for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742924689; cv=none; b=mRro8CG6iiKPcIVNfKpmYUh1TSA2zrC2b2+y/7J3fR5hzHnPh/PwUBch7mAXlVDprVh8rf91wXQ0XRwb0/R79603rMBBWBM+9vtbeWc5tjKjQxqsxKTJIAYU3wWH8ALL/hkS7EjGTLZKTzGrM8mXx/UgMP3K0Th6RSjaFM1wSiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742924689; c=relaxed/simple;
	bh=o6g5HoC32I+6BiDO8vCfhv3kf+WezCmeDCwVZM3gAjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FwwmbLg4IHdXD3lHDR5Vbb2DzZpfM1N3Pa893ZxGCGqYYK1NKksMwuGHh03dgk05X7oeUhaa8Z67BWBrAXy28rhcvmqAEEPsUJWUC/8SEHLTnme67jjjOTq9mJQCodXF1+Gr3u4aMboUPC9Mon4gk6dtjQmcjb7FcKD0bgrHth0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rQkSHL1J; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2240aad70f2so18595ad.0
        for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742924687; x=1743529487; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C557zFYMQNx6YZaNFk9a2tG90MlGVtliFmUOKVTtxbE=;
        b=rQkSHL1JHmNlhh0a1ZWsWrS999xui5awFO7BqNybosaOIJkRSHoufCZWqAwL5S6AS5
         waRJ/Abd9VjTSU2xFn5DNNCxCteivYlWCvsF+QbpfCjLB+31YxihfXUmJFRpIqKiJw7R
         hVtTQUDvrJbnbSkACK4QT9Wspv5WeolxnfXYwVD9zT0zGD9e+jOYRt+angMGN3vEuG0m
         QJeqI1pcc8uUnQ6RV7cDgyrzNA9H6xH1zdeA9PbS5Ushbk6/pamcxu7PfSSJxA/z0rig
         30aVkBQKVQRjZZHcGUN41wcme+ClwhGrczWAEtatTyzSqEBKup4x31schAjjWRPUzPHG
         QxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742924687; x=1743529487;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C557zFYMQNx6YZaNFk9a2tG90MlGVtliFmUOKVTtxbE=;
        b=Cy/Yhuaeo24yNomTwQAyhrzjVD5+8ef3FzyyOsyvPD9cWjoj3q06XdpO9UvdJ5brzI
         tSahReFO4XWF3gXNhTNhWwjysjCTUbXoaRzoUrO8hPVxOgUlUjln03Z0mftWCSsMAcIx
         g5KP9RMBZL/6dSiWv9oh0qVUk1sxqKY2KzfMVybz94gNRbNWMj2Ie7QMmro6z1SRNNaC
         Y5RjVQTOw3V7XE/9hMCOmXyBpuaynPxSae9WPyRGHbXG83j+ijrnpNoSGielQ7PjoaoQ
         F0WgtrMKQDD1KmUUcjdSti9g00z3hwL2c2iW5/Y/SJrE6L/rg0LikeMZW4/jebipJD6f
         6ZLw==
X-Forwarded-Encrypted: i=1; AJvYcCVAamVkAE92yf4hZvX/kCsBFC9ysuXqwZYPuj/v//AAteMs0P8Vfef/uxVJR+MfCvO0xFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydil6op8/gkyeqzEQfn61XZprpxi6yF0tD/v6e8SHWg1DTRImH
	G0jZnhAaSf7dNEB1D/brRUSVo+xk4ewn972nljPYhYONswPDtPfvuJZ9DhdbOPGfYIKwOsm3NbM
	/ge5PEA/RJSREgf7R/sak5nEj1GXcR10vc5rK
X-Gm-Gg: ASbGncsCmSMfKRpAA0+LrV/F8/QRMLqNGVUkTHL3k2wSijTWIuNqMJ5aFVKrqEdQ6bI
	1V+lbpZ3sQdMnuEoUVfucyR3GlGXyMrt+4zSlBeg8cXv8Ir64OKTzsS7xBYLhKuGFPufeWpCVk6
	hVLXNNHs2LdRX7JB+rhOcIxtiXGMx256aSZ8Oott+q69OW5IsIzuwcHA==
X-Google-Smtp-Source: AGHT+IHPelgDScufsa6zAdrdNBGBs5B6xqAFz7eUGQGOmOqHwOhJ5MfpsvqJ85TCgQC7BKeJ/DkvYhul0b9i7GXTf4c=
X-Received: by 2002:a17:903:2c6:b0:21f:2ded:bfa0 with SMTP id
 d9443c01a7336-22799f80a6bmr9127625ad.25.1742924687095; Tue, 25 Mar 2025
 10:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com> <20250122174308.350350-11-irogers@google.com>
In-Reply-To: <20250122174308.350350-11-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 25 Mar 2025 10:44:34 -0700
X-Gm-Features: AQ5f1JpIGP8wbMVFe85DxBTilH4hLmUR3dv-unPSph-h7lFMwMVjU6DwDza6nuM
Message-ID: <CAP-5=fUt4rvEWRY=O6-EM0GGgOxz3VL933OgSYET2HxCi8fsCA@mail.gmail.com>
Subject: Re: [PATCH v3 10/18] perf dso: Support BPF programs in dso__read_symbol
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 9:43=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> Set the buffer to the code in the BPF linear info. This enables BPF
> JIT code disassembly by LLVM and capstone. Move the disassmble_bpf
> calls to disassemble_objdump so that they are only called after
> falling back to the objdump option.

It would be nice to land this series in part because of supporting BPF
disassembly with LLVM and capstone, possible because of the cleanups
and refactorings.

Thanks,
Ian

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/disasm.c | 12 +++---
>  tools/perf/util/dso.c    | 85 +++++++++++++++++++++++++---------------
>  2 files changed, 60 insertions(+), 37 deletions(-)
>
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index a9cc588a3006..99b9c21e02b0 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -1500,6 +1500,12 @@ static int symbol__disassemble_objdump(const char =
*filename, struct symbol *sym,
>         struct child_process objdump_process;
>         int err;
>
> +       if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__BPF_PROG_INFO)
> +               return symbol__disassemble_bpf(sym, args);
> +
> +       if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__BPF_IMAGE)
> +               return symbol__disassemble_bpf_image(sym, args);
> +
>         err =3D asprintf(&command,
>                  "%s %s%s --start-address=3D0x%016" PRIx64
>                  " --stop-address=3D0x%016" PRIx64
> @@ -1681,11 +1687,7 @@ int symbol__disassemble(struct symbol *sym, struct=
 annotate_args *args)
>
>         pr_debug("annotating [%p] %30s : [%p] %30s\n", dso, dso__long_nam=
e(dso), sym, sym->name);
>
> -       if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__BPF_PROG_INFO) =
{
> -               return symbol__disassemble_bpf(sym, args);
> -       } else if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__BPF_IMAG=
E) {
> -               return symbol__disassemble_bpf_image(sym, args);
> -       } else if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__NOT_FOUN=
D) {
> +       if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__NOT_FOUND) {
>                 return SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE=
;
>         } else if (dso__is_kcore(dso)) {
>                 kce.addr =3D map__rip_2objdump(map, sym->start);
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 0285904ed26d..a90799bed230 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1686,48 +1686,69 @@ const u8 *dso__read_symbol(struct dso *dso, const=
 char *symfs_filename,
>                            const struct map *map, const struct symbol *sy=
m,
>                            u8 **out_buf, u64 *out_buf_len, bool *is_64bit=
)
>  {
> -       struct nscookie nsc;
>         u64 start =3D map__rip_2objdump(map, sym->start);
>         u64 end =3D map__rip_2objdump(map, sym->end);
> -       int fd, count;
> -       u8 *buf =3D NULL;
> -       size_t len;
> -       struct find_file_offset_data data =3D {
> -               .ip =3D start,
> -       };
> +       const u8 *buf;
> +       size_t len =3D end - start;
>
>         *out_buf =3D NULL;
>         *out_buf_len =3D 0;
>         *is_64bit =3D false;
>
> -       nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> -       fd =3D open(symfs_filename, O_RDONLY);
> -       nsinfo__mountns_exit(&nsc);
> -       if (fd < 0)
> +       if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__BPF_IMAGE) {
> +               pr_debug("No BPF image disassembly support\n");
>                 return NULL;
> +       } else if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__BPF_PROG=
_INFO) {
> +#ifdef HAVE_LIBBPF_SUPPORT
> +               struct bpf_prog_info_node *info_node;
> +               struct perf_bpil *info_linear;
> +
> +               *is_64bit =3D sizeof(void *) =3D=3D sizeof(u64);
> +               info_node =3D perf_env__find_bpf_prog_info(dso__bpf_prog(=
dso)->env,
> +                                                        dso__bpf_prog(ds=
o)->id);
> +               if (!info_node) {
> +                       errno =3D SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
> +                       return NULL;
> +               }
> +               info_linear =3D info_node->info_linear;
> +               buf =3D (const u8 *)(uintptr_t)(info_linear->info.jited_p=
rog_insns);
> +               assert(len <=3D info_linear->info.jited_prog_len);
> +#else
> +               pr_debug("No BPF program disassembly support\n");
> +               return NULL;
> +#endif
> +       } else {
> +               struct nscookie nsc;
> +               int fd;
> +               ssize_t count;
> +               struct find_file_offset_data data =3D {
> +                       .ip =3D start,
> +               };
> +               u8 *code_buf =3D NULL;
>
> -       if (file__read_maps(fd, /*exe=3D*/true, find_file_offset, &data, =
is_64bit) =3D=3D 0)
> -               goto err;
> -
> -       len =3D end - start;
> -       buf =3D malloc(len);
> -       if (buf =3D=3D NULL)
> -               goto err;
> -
> -       count =3D pread(fd, buf, len, data.offset);
> -       close(fd);
> -       fd =3D -1;
> -
> -       if ((u64)count !=3D len)
> -               goto err;
> +               nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> +               fd =3D open(symfs_filename, O_RDONLY);
> +               nsinfo__mountns_exit(&nsc);
> +               if (fd < 0)
> +                       return NULL;
>
> -       *out_buf =3D buf;
> +               if (file__read_maps(fd, /*exe=3D*/true, find_file_offset,=
 &data, is_64bit) =3D=3D 0) {
> +                       close(fd);
> +                       return NULL;
> +               }
> +               buf =3D code_buf =3D malloc(len);
> +               if (buf =3D=3D NULL) {
> +                       close(fd);
> +                       return NULL;
> +               }
> +               count =3D pread(fd, code_buf, len, data.offset);
> +               close(fd);
> +               if ((u64)count !=3D len) {
> +                       free(code_buf);
> +                       return NULL;
> +               }
> +               *out_buf =3D code_buf;
> +       }
>         *out_buf_len =3D len;
>         return buf;
> -
> -err:
> -       if (fd >=3D 0)
> -               close(fd);
> -       free(buf);
> -       return NULL;
>  }
> --
> 2.48.1.262.g85cc9f2d1e-goog
>

