Return-Path: <bpf+bounces-45425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 056669D5621
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 00:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0989DB22612
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 23:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225781DE4C5;
	Thu, 21 Nov 2024 23:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a061neMB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8461C9DD8
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732231174; cv=none; b=rebgoOK9okVoMJIW5E3k8pmnt+o4nZMfz2xv4uL0We12gp+qG60tTohoV+vRhk+1s+kWNOmfcocmS7W1k1JzkVK2SH+DpWyuCENpiMLoB0D3xiZ2DCCD/9VfygSqHVAJ/C55LNLXzjrBW/WHmMpyf462CFSzD6IwhA11uEcDvzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732231174; c=relaxed/simple;
	bh=myLqRyjQBF8/PIkzF2wRV0r91ZVG1GL/v18NgDsa9AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuzpgcqNavXV0nZ007iMwrtFbmoMM97V7P/Z3roFfp7jtAkL8HJE5o7VVcP+f5A2l2I4Sl1siG5aZS2WXDqsF29ixiIjSOgciwkGQyITa2dDLDVA0eVy4YL1BviUOZU4ISzObPEposkR7SH6a65rOOh+B+m4zRib255kV9J1dRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a061neMB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e91403950dso1208496a91.3
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 15:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732231172; x=1732835972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0n0Lmmb1qjcuuaNJlW6ub7H+WSYZ0teD4L+Xb4Op1e0=;
        b=a061neMB0r/1Wo3nYX5dCLl1sNEIEC4TX7bLdmbDl1jRDqXAJc+nHYAGouct7cOQUC
         sqgcat49CdpOWrfxUX2ixJu//YrCoV9viMqwo3en3RqxxI8viDd4HdT67W1fEgYoUfku
         k49tXq4YUXzgOjgKGzb2gCgMzBbP/e60XN6IFSUNnlFicKhQUuehZYvqNTTrqF8dKPMI
         kRqeS9CobdCdlVf6QvV0epDAvtuvWzySLP/aGaQnlbQyFOK9L7CfAnh8mLtl4xN+k+ek
         1mh4ylyBFGAyloz3ha+XTPZhfguod/ACJjGb2xtTkkGjCh3w3XbTB9EEz9JrUTjd8Iak
         D3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732231172; x=1732835972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0n0Lmmb1qjcuuaNJlW6ub7H+WSYZ0teD4L+Xb4Op1e0=;
        b=utcHszXzXpljSL/o+cyZN6kEHL/toSRuLPhdP94VR1f3EFFEMcOmXKmmwLozplew0D
         jP4zITj8SSfldG5iZCaU+2MCxIExo2+ZcB5zki891x+ZMFhP/lNPYrk4ok7+IGTPENTc
         5iQ5bhdrK36MXDIciZNr+lBYz4ruhPfCw0E+3sdJBlyod/d40QBGbJQgJJfrMC28vHbG
         xKJmA8GKNvIIzk170lutv+UrOlkRkumWBEpI71GVYFOLVRV4EAgPb31x4RVyI47wujQN
         apDzqNrA6Y1rLAl0KDERqvxpLt8crJ82F69WteN0EulOeB2Ro8x3PzOTN/9I6iauDf9d
         dgVA==
X-Gm-Message-State: AOJu0YzV+XRc9G1BO5mvVbv/9sb/tmJAWRRHG6TdNCYy54FvhByjCV3c
	6mSdYvwSu/oqHpkJYlWnVMDs48COzfuKaJuXHJL/+WW7D1djF2JQZHONxLZ6cNbbEHkM13l38Ej
	qNhlt4AeoKraJmbrdCF0p+aLCctc=
X-Gm-Gg: ASbGncvTsXHyossLFBPBp4KlSID4YDfGZEDLuuPuzxAuTT8Qq9cyU/BtaRRB+HXqkTs
	Floc48eSxbgfyxHpMEEKG3b9ync1R9GxD1djaWHFSnzAhu4c=
X-Google-Smtp-Source: AGHT+IEnl/HxJuH9vxRxfJIBOmGKwv3e04tmYqIK8DRiyBW1JrmEcbZiJEiGXaFXV8ZUoYYDGu6Fzd1fh9RORXXVIFU=
X-Received: by 2002:a17:90b:5446:b0:2ea:3f34:f1a0 with SMTP id
 98e67ed59e1d1-2eb0e8662e6mr778589a91.30.1732231171586; Thu, 21 Nov 2024
 15:19:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120170206.2592931-1-ajor@meta.com>
In-Reply-To: <20241120170206.2592931-1-ajor@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 21 Nov 2024 15:19:19 -0800
Message-ID: <CAEf4BzbvoNYti9sg1GUAsM-K2EF=Cc6VLNYkexDZMZjyO13bAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Extend linker API to support in-memory
 ELF files
To: Alastair Robertson <ajor@meta.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 9:02=E2=80=AFAM Alastair Robertson <ajor@meta.com> =
wrote:
>
> The new_fd, add_fd and finalize_fd functions correspond to the original
> new, add_file and finalize functions, but accept an FD instead of a file
> name. This gives API consumers the option of using anonymous
> files/memfds to avoid writing ELFs to disk.
>
> This new API will be useful for performing linking as part of
> bpftrace's JIT compilation.
>
> The add_buf function is a convenience wrapper that does the work of
> creating a memfd for the caller.
>
> Signed-off-by: Alastair Robertson <ajor@meta.com>
> ---
>  tools/lib/bpf/libbpf.h   |   9 ++
>  tools/lib/bpf/libbpf.map |   4 +
>  tools/lib/bpf/linker.c   | 229 +++++++++++++++++++++++++++++----------
>  3 files changed, 185 insertions(+), 57 deletions(-)
>

Hey Alastair,

I think adding these new APIs makes sense, but I'll nitpick a bit below.

But overall it would be good to extract preparatory stuff like change
to obj->filename everywhere and stuff like this that's pretty
widespread, but very distracting. I'll point it out as I go through
the patch below.


> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b2ce3a72b11d..aae8f954c4fc 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1796,10 +1796,19 @@ struct bpf_linker_file_opts {
>  struct bpf_linker;
>
>  LIBBPF_API struct bpf_linker *bpf_linker__new(const char *filename, stru=
ct bpf_linker_opts *opts);
> +LIBBPF_API struct bpf_linker *bpf_linker__new_fd(const char *name, int f=
d,
> +                                                struct bpf_linker_opts *=
opts);

API nitpick, given `int fd` is the main thing, let's put it as a first argu=
ment.

As for the "name" parameter, it's only going to be used for logging
and error reporting, right? I'm more inclined to add it into
bpf_linker_opts as some sort of name override field. It will keep the
API clean, we can always have some default "fd=3D%d" name, unless the
user provides a more meaningful (for them) name. And for
filename-based APIs we can still use that name as an override (if it's
provided).

>  LIBBPF_API int bpf_linker__add_file(struct bpf_linker *linker,
>                                     const char *filename,
>                                     const struct bpf_linker_file_opts *op=
ts);
> +LIBBPF_API int bpf_linker__add_fd(struct bpf_linker *linker,
> +                                 const char *name, int fd,

same nit about fd being first param, and question if we need "name" at all

> +                                 const struct bpf_linker_file_opts *opts=
);
> +LIBBPF_API int bpf_linker__add_buf(struct bpf_linker *linker, const char=
 *name,
> +                                  void *buffer, int buffer_sz,
> +                                  const struct bpf_linker_file_opts *opt=
s);

ditto, buffer + buffer_sz should come right after linker (and let's
shorten to "buf" and "buf_sz"?)

>  LIBBPF_API int bpf_linker__finalize(struct bpf_linker *linker);
> +LIBBPF_API int bpf_linker__finalize_fd(struct bpf_linker *linker);

this I don't think we need, let's see below

>  LIBBPF_API void bpf_linker__free(struct bpf_linker *linker);
>
>  /*
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 54b6f312cfa8..e767f34c1d08 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -432,4 +432,8 @@ LIBBPF_1.5.0 {
>  } LIBBPF_1.4.0;
>
>  LIBBPF_1.6.0 {
> +               bpf_linker__new_fd;
> +               bpf_linker__add_fd;
> +               bpf_linker__add_buf;
> +               bpf_linker__finalize_fd;

this should be sorted

>  } LIBBPF_1.5.0;
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index cf71d149fe26..6571ed8b858f 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -4,6 +4,8 @@
>   *
>   * Copyright (c) 2021 Facebook
>   */
> +#define _GNU_SOURCE

please add #ifndef guard around, we have/had issues with _GNU_SOURCE
being re-defined
> +
>  #include <stdbool.h>
>  #include <stddef.h>
>  #include <stdio.h>
> @@ -16,6 +18,7 @@
>  #include <elf.h>
>  #include <libelf.h>
>  #include <fcntl.h>
> +#include <sys/mman.h>
>  #include "libbpf.h"
>  #include "btf.h"
>  #include "libbpf_internal.h"
> @@ -157,9 +160,9 @@ struct bpf_linker {
>  #define pr_warn_elf(fmt, ...)                                           =
                       \
>         libbpf_print(LIBBPF_WARN, "libbpf: " fmt ": %s\n", ##__VA_ARGS__,=
 elf_errmsg(-1))
>
> -static int init_output_elf(struct bpf_linker *linker, const char *file);
> +static int init_output_elf(struct bpf_linker *linker);
>
> -static int linker_load_obj_file(struct bpf_linker *linker, const char *f=
ilename,
> +static int linker_load_obj_file(struct bpf_linker *linker,
>                                 const struct bpf_linker_file_opts *opts,
>                                 struct src_obj *obj);
>  static int linker_sanity_check_elf(struct src_obj *obj);
> @@ -233,9 +236,56 @@ struct bpf_linker *bpf_linker__new(const char *filen=
ame, struct bpf_linker_opts
>         if (!linker)
>                 return errno =3D ENOMEM, NULL;
>
> -       linker->fd =3D -1;
> +       linker->filename =3D strdup(filename);
> +       if (!linker->filename)
> +               return errno =3D ENOMEM, NULL;
> +
> +       linker->fd =3D open(filename, O_WRONLY | O_CREAT | O_TRUNC | O_CL=
OEXEC, 0644);
> +       if (linker->fd < 0) {
> +               err =3D -errno;
> +               pr_warn("failed to create '%s': %d\n", filename, err);
> +               goto err_out;
> +       }
> +
> +       err =3D init_output_elf(linker);
> +       if (err)
> +               goto err_out;
> +
> +       return linker;
> +
> +err_out:
> +       bpf_linker__free(linker);
> +       return errno =3D -err, NULL;
> +}
> +
> +struct bpf_linker *bpf_linker__new_fd(const char *name, int fd,
> +                                     struct bpf_linker_opts *opts)
> +{
> +       struct bpf_linker *linker;
> +       int err;
> +
> +       if (fd < 0)
> +               return errno =3D EINVAL, NULL;
> +
> +       if (!OPTS_VALID(opts, bpf_linker_opts))
> +               return errno =3D EINVAL, NULL;
> +
> +       if (elf_version(EV_CURRENT) =3D=3D EV_NONE) {
> +               pr_warn_elf("libelf initialization failed");
> +               return errno =3D EINVAL, NULL;
> +       }
> +
> +       linker =3D calloc(1, sizeof(*linker));
> +       if (!linker)
> +               return errno =3D ENOMEM, NULL;
> +
> +       linker->filename =3D strdup(name);
> +       if (!linker->filename)
> +               return errno =3D ENOMEM, NULL;
> +
> +       linker->fd =3D fd;
>
> -       err =3D init_output_elf(linker, filename);
> +       err =3D init_output_elf(linker);
>         if (err)
>                 goto err_out;
>
> @@ -294,23 +344,12 @@ static Elf64_Sym *add_new_sym(struct bpf_linker *li=
nker, size_t *sym_idx)
>         return sym;
>  }
>
> -static int init_output_elf(struct bpf_linker *linker, const char *file)
> +static int init_output_elf(struct bpf_linker *linker)
>  {
>         int err, str_off;
>         Elf64_Sym *init_sym;
>         struct dst_sec *sec;
>
> -       linker->filename =3D strdup(file);
> -       if (!linker->filename)
> -               return -ENOMEM;
> -
> -       linker->fd =3D open(file, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXE=
C, 0644);
> -       if (linker->fd < 0) {
> -               err =3D -errno;
> -               pr_warn("failed to create '%s': %s\n", file, errstr(err))=
;
> -               return err;
> -       }
> -
>         linker->elf =3D elf_begin(linker->fd, ELF_C_WRITE, NULL);
>         if (!linker->elf) {
>                 pr_warn_elf("failed to create ELF object");
> @@ -436,10 +475,9 @@ static int init_output_elf(struct bpf_linker *linker=
, const char *file)
>         return 0;
>  }
>
> -int bpf_linker__add_file(struct bpf_linker *linker, const char *filename=
,
> -                        const struct bpf_linker_file_opts *opts)
> +static int linker_add_common(struct bpf_linker *linker, struct src_obj *=
obj,
> +                            const struct bpf_linker_file_opts *opts)

it seems like bpf_linker__add_file() should be implemented on top of
bpf_linker__add_fd() + clean up on error, do we need
"linker_add_common"?

>  {
> -       struct src_obj obj =3D {};
>         int err =3D 0;
>
>         if (!OPTS_VALID(opts, bpf_linker_file_opts))
> @@ -448,25 +486,91 @@ int bpf_linker__add_file(struct bpf_linker *linker,=
 const char *filename,
>         if (!linker->elf)
>                 return libbpf_err(-EINVAL);
>
> -       err =3D err ?: linker_load_obj_file(linker, filename, opts, &obj)=
;
> -       err =3D err ?: linker_append_sec_data(linker, &obj);
> -       err =3D err ?: linker_append_elf_syms(linker, &obj);
> -       err =3D err ?: linker_append_elf_relos(linker, &obj);
> -       err =3D err ?: linker_append_btf(linker, &obj);
> -       err =3D err ?: linker_append_btf_ext(linker, &obj);
> +       err =3D err ?: linker_load_obj_file(linker, opts, obj);
> +       err =3D err ?: linker_append_sec_data(linker, obj);
> +       err =3D err ?: linker_append_elf_syms(linker, obj);
> +       err =3D err ?: linker_append_elf_relos(linker, obj);
> +       err =3D err ?: linker_append_btf(linker, obj);
> +       err =3D err ?: linker_append_btf_ext(linker, obj);
>
>         /* free up src_obj resources */
> -       free(obj.btf_type_map);
> -       btf__free(obj.btf);
> -       btf_ext__free(obj.btf_ext);
> -       free(obj.secs);
> -       free(obj.sym_map);
> -       if (obj.elf)
> -               elf_end(obj.elf);
> +       free(obj->btf_type_map);
> +       btf__free(obj->btf);
> +       btf_ext__free(obj->btf_ext);
> +       free(obj->secs);
> +       free(obj->sym_map);
> +       if (obj->elf)
> +               elf_end(obj->elf);
> +       /* leave obj->fd for the caller to clean up if appropriate */
> +
> +       return libbpf_err(err);
> +}
> +
> +int bpf_linker__add_file(struct bpf_linker *linker, const char *filename=
,
> +                        const struct bpf_linker_file_opts *opts)
> +{
> +       struct src_obj obj =3D {};
> +       int ret;
> +
> +       obj.filename =3D filename;
> +       obj.fd =3D open(filename, O_RDONLY | O_CLOEXEC);
> +       if (obj.fd < 0) {
> +               pr_warn("failed to open file '%s': %s\n", filename, errst=
r(errno));
> +               return -errno;
> +       }
> +
> +       ret =3D linker_add_common(linker, &obj, opts);

this can be just bpf_linker__add_fd() call, no?

> +
>         if (obj.fd >=3D 0)
>                 close(obj.fd);
>
> -       return libbpf_err(err);
> +       return ret;
> +}
> +
> +int bpf_linker__add_fd(struct bpf_linker *linker, const char *name, int =
fd,
> +                      const struct bpf_linker_file_opts *opts)
> +{
> +       struct src_obj obj =3D {};
> +
> +       if (fd < 0)
> +               return libbpf_err(-EINVAL);
> +
> +       obj.filename =3D name;
> +       obj.fd =3D fd;
> +
> +       return linker_add_common(linker, &obj, opts);
> +}
> +
> +int bpf_linker__add_buf(struct bpf_linker *linker, const char *name,
> +                       void *buffer, int buffer_sz,
> +                       const struct bpf_linker_file_opts *opts)
> +{
> +       struct src_obj obj =3D {};
> +       int written, ret;
> +
> +       obj.filename =3D name;
> +       obj.fd =3D memfd_create(name, 0);
> +       if (obj.fd < 0) {
> +               pr_warn("failed to create memfd '%s': %s\n", name, errstr=
(errno));
> +               return -errno;
> +       }
> +
> +       written =3D 0;
> +       while (written < buffer_sz) {
> +               ret =3D write(obj.fd, buffer, buffer_sz);
> +               if (ret < 0) {
> +                       pr_warn("failed to write '%s': %s\n", name, errst=
r(errno));
> +                       return -errno;
> +               }
> +               written +=3D ret;
> +       }
> +
> +       ret =3D linker_add_common(linker, &obj, opts);

ditto, bpf_linker__add_fd() should be fine

> +
> +       if (obj.fd >=3D 0)
> +               close(obj.fd);
> +
> +       return ret;
>  }
>
>  static bool is_dwarf_sec_name(const char *name)
> @@ -534,7 +638,7 @@ static struct src_sec *add_src_sec(struct src_obj *ob=
j, const char *sec_name)
>         return sec;
>  }
>
> -static int linker_load_obj_file(struct bpf_linker *linker, const char *f=
ilename,
> +static int linker_load_obj_file(struct bpf_linker *linker,
>                                 const struct bpf_linker_file_opts *opts,
>                                 struct src_obj *obj)
>  {
> @@ -554,20 +658,12 @@ static int linker_load_obj_file(struct bpf_linker *=
linker, const char *filename,
>  #error "Unknown __BYTE_ORDER__"
>  #endif
>
> -       pr_debug("linker: adding object file '%s'...\n", filename);
> -
> -       obj->filename =3D filename;
> +       pr_debug("linker: adding object file '%s'...\n", obj->filename);
>

so it would be nice to refactor this obj->filename as an initial patch
(and whatever other "cosmetic" changes necessary to add new APIs),
that way we can have more focused patch for new APIs

> -       obj->fd =3D open(filename, O_RDONLY | O_CLOEXEC);
> -       if (obj->fd < 0) {
> -               err =3D -errno;
> -               pr_warn("failed to open file '%s': %s\n", filename, errst=
r(err));
> -               return err;
> -       }
>         obj->elf =3D elf_begin(obj->fd, ELF_C_READ_MMAP, NULL);
>         if (!obj->elf) {
>                 err =3D -errno;
> -               pr_warn_elf("failed to parse ELF file '%s'", filename);
> +               pr_warn_elf("failed to parse ELF file '%s'", obj->filenam=
e);
>                 return err;
>         }
>
> @@ -575,7 +671,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
>         ehdr =3D elf64_getehdr(obj->elf);
>         if (!ehdr) {
>                 err =3D -errno;
> -               pr_warn_elf("failed to get ELF header for %s", filename);
> +               pr_warn_elf("failed to get ELF header for %s", obj->filen=
ame);
>                 return err;
>         }
>
> @@ -583,7 +679,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
>         obj_byteorder =3D ehdr->e_ident[EI_DATA];
>         if (obj_byteorder !=3D ELFDATA2LSB && obj_byteorder !=3D ELFDATA2=
MSB) {
>                 err =3D -EOPNOTSUPP;
> -               pr_warn("unknown byte order of ELF file %s\n", filename);
> +               pr_warn("unknown byte order of ELF file %s\n", obj->filen=
ame);
>                 return err;
>         }
>         if (link_byteorder =3D=3D ELFDATANONE) {
> @@ -593,7 +689,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
>                          obj_byteorder =3D=3D ELFDATA2MSB ? "big" : "litt=
le");
>         } else if (link_byteorder !=3D obj_byteorder) {
>                 err =3D -EOPNOTSUPP;
> -               pr_warn("byte order mismatch with ELF file %s\n", filenam=
e);
> +               pr_warn("byte order mismatch with ELF file %s\n", obj->fi=
lename);
>                 return err;
>         }
>
> @@ -601,13 +697,13 @@ static int linker_load_obj_file(struct bpf_linker *=
linker, const char *filename,
>             || ehdr->e_machine !=3D EM_BPF
>             || ehdr->e_ident[EI_CLASS] !=3D ELFCLASS64) {
>                 err =3D -EOPNOTSUPP;
> -               pr_warn_elf("unsupported kind of ELF file %s", filename);
> +               pr_warn_elf("unsupported kind of ELF file %s", obj->filen=
ame);
>                 return err;
>         }
>
>         if (elf_getshdrstrndx(obj->elf, &obj->shstrs_sec_idx)) {
>                 err =3D -errno;
> -               pr_warn_elf("failed to get SHSTRTAB section index for %s"=
, filename);
> +               pr_warn_elf("failed to get SHSTRTAB section index for %s"=
, obj->filename);
>                 return err;
>         }
>
> @@ -620,7 +716,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
>                 if (!shdr) {
>                         err =3D -errno;
>                         pr_warn_elf("failed to get section #%zu header fo=
r %s",
> -                                   sec_idx, filename);
> +                                   sec_idx, obj->filename);
>                         return err;
>                 }
>
> @@ -628,7 +724,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
>                 if (!sec_name) {
>                         err =3D -errno;
>                         pr_warn_elf("failed to get section #%zu name for =
%s",
> -                                   sec_idx, filename);
> +                                   sec_idx, obj->filename);
>                         return err;
>                 }
>
> @@ -636,7 +732,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
>                 if (!data) {
>                         err =3D -errno;
>                         pr_warn_elf("failed to get section #%zu (%s) data=
 from %s",
> -                                   sec_idx, sec_name, filename);
> +                                   sec_idx, sec_name, obj->filename);
>                         return err;
>                 }
>
> @@ -672,7 +768,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
>                                 err =3D libbpf_get_error(obj->btf);
>                                 if (err) {
>                                         pr_warn("failed to parse .BTF fro=
m %s: %s\n",
> -                                               filename, errstr(err));
> +                                               obj->filename, errstr(err=
));
>                                         return err;
>                                 }
>                                 sec->skipped =3D true;
> @@ -683,7 +779,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
>                                 err =3D libbpf_get_error(obj->btf_ext);
>                                 if (err) {
>                                         pr_warn("failed to parse .BTF.ext=
 from '%s': %s\n",
> -                                               filename, errstr(err));
> +                                               obj->filename, errstr(err=
));
>                                         return err;
>                                 }
>                                 sec->skipped =3D true;
> @@ -700,7 +796,7 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
>                         break;
>                 default:
>                         pr_warn("unrecognized section #%zu (%s) in %s\n",
> -                               sec_idx, sec_name, filename);
> +                               sec_idx, sec_name, obj->filename);
>                         err =3D -EINVAL;
>                         return err;
>                 }

as I mentioned all of the above logging changes don't have to be in this pa=
tch

> @@ -2634,7 +2730,7 @@ static int linker_append_btf_ext(struct bpf_linker =
*linker, struct src_obj *obj)
>         return 0;
>  }
>
> -int bpf_linker__finalize(struct bpf_linker *linker)
> +int linker_finalize_common(struct bpf_linker *linker)
>  {
>         struct dst_sec *sec;
>         size_t strs_sz;
> @@ -2693,9 +2789,28 @@ int bpf_linker__finalize(struct bpf_linker *linker=
)
>         }
>
>         elf_end(linker->elf);
> +       linker->elf =3D NULL;
> +
> +       /* leave linker->fd for the caller to close if appropriate */
> +
> +       return 0;
> +}
> +
> +int bpf_linker__finalize(struct bpf_linker *linker)
> +{
> +       linker_finalize_common(linker);
> +
>         close(linker->fd);
> +       linker->fd =3D -1;
>
> -       linker->elf =3D NULL;
> +       return 0;
> +}
> +
> +int bpf_linker__finalize_fd(struct bpf_linker *linker)
> +{


so as I mentioned, I don't think we need an extra finalize variant. We
can just remember in linker struct whether we own fd or it was just
passed to use, and then existing bpf_linker__finalize() will just
check that and skip close, if necessary

This will also make it harder to mismatch new and finalize APIs.

pw-bot: cr

> +       linker_finalize_common(linker);
> +
> +       /* linker->fd was opened by the caller, so do not close it here *=
/
>         linker->fd =3D -1;
>
>         return 0;
> --
> 2.43.5
>

