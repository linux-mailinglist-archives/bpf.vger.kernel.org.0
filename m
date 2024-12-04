Return-Path: <bpf+bounces-46101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B774F9E452B
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 20:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF614B33D6A
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 18:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC7C1A8F78;
	Wed,  4 Dec 2024 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKP3gAFi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F52B2391AC
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733337352; cv=none; b=UbF6ak7/ewA0CHFdlS47ZaJrPupAX0nIe5wApxPZC3uHHpSFxnJlSkQCc8Lk3AdZWlav+zNcDSHwAbctyi0DbKAcrUJuDn/b+4oKqloIqezL6mvj56dPi6XOnqUfJw4v7jdcge3cKz2eQ0ZcztrDPv1dSVn8HmHUcRUEqIs7fVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733337352; c=relaxed/simple;
	bh=UDgH0Dr333V7NmZFkAwLapjPO9AOy8FRhDqWL3cf5d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mf307FHHwb18K9lACxaIEXwIUKOMcLSOXGRirioOiPAj7fz6Alipb8Vt7b7Ls6hIR7GLehVpJID3cn9LBODwQRw7PgqasSmzVQtFPu/0DkUQ4WEQITKCpqmvpSIwSf0/HJBp+S+Ng5Tm79OMhX5zJO13n94pikQg6zeRqY5Ow5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKP3gAFi; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2eb1433958dso89447a91.2
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 10:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733337349; x=1733942149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9kXj0vQGZAZXmYckZ9z1XrtD3pmJZ1leyH83Ym+9ug=;
        b=ZKP3gAFiIruZIcywcsMO/WpRMU16QF3HcMuglvvsaPBFmtNzRY0fhBQqzEChFtQd1H
         puBrnMqOnwIKvibTNkFDys1rYgBAgCUWGgmdKvYqCR2FFu2BlOCBpmC9MZuUDHEJEosY
         +N/CGZckxiT0Mj/0QsgX5kiMkFo3DqWj36OQBMwPPVjAuOcfYofpLcFglErjukwLT30D
         liV5r9yS02+TWoP9rvV9B/wG1iNVXjbI7vfbRgE17WNPf3znuoI2bhpYjrQVACesIBU6
         LAp4zAWTUG9zE4Xkib++qTZiIniULHqPBhb/kKYSMcWB+c6qQqM303fyTH534FvXa96F
         baGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733337349; x=1733942149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9kXj0vQGZAZXmYckZ9z1XrtD3pmJZ1leyH83Ym+9ug=;
        b=XDBfRYyeuZOC+XQ7Cye0KhwyTfcRDhFtAGy+UZF2iVdMjfSRmvEdcOxVKeyT9bNj0C
         ft7tWFK5H41CV/dzXMPILcrmA5ou95cR45ZW1ctcQPuTzh+C491ADsZuTM+DluG/YatJ
         mhcN7c1+XEmCG+yKdZ9EmiPWjTYSstqX+4K8pkI5QoYUhfEy4KOdd7zAUZRTt7nVuDGT
         ahUggRU8V+jfWJPoYACFiSl+QbldUloUyfMwtlEY7rfUsVQbX03f0UWJ9O3TkLd5G/fl
         Q4m9p0ClRHk3lfu7Nbgzk2dTy2AfkcSyQH9rtoXMZtSrikE3QWH7Da6qPz67jQHV/1+r
         30/g==
X-Gm-Message-State: AOJu0YwSDLOKPriwfGV6vnxDDSV/EeKghPOlcenBuPbvBzad4u0HCrnH
	ElDjlwaVYTKjnNhoPoPvT4ftgVYDXVPerV8B9G5BsDXW+xCLzkcsjWbl4pSM+71FaKZhK6c8Mla
	G8/UD2Va2T8+ssg/ilEW5BzhOSkg=
X-Gm-Gg: ASbGncurWwkHsULNZ4p8L9oUGgQ03GMqxUsPYY/u4PxLaa1P7IP+ct+zJWRFpqFixUI
	VdJsEtY2IzIOw6cv1Aq7GrxwXQTcW9j6Eg9d7DMPMiDikHNk=
X-Google-Smtp-Source: AGHT+IHx84CuFhAQ31CEl/BMJss8AfIZG2wsV2nTQJy/QCIZ+rRM/1UZcZBFmgGlvRkczHV+cu+0/nAOo9iuMpRo/Kc=
X-Received: by 2002:a17:90b:3891:b0:2ee:ead6:6213 with SMTP id
 98e67ed59e1d1-2ef1ce96270mr7614994a91.19.1733337349513; Wed, 04 Dec 2024
 10:35:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204161101.1148347-1-ajor@meta.com> <20241204161101.1148347-3-ajor@meta.com>
In-Reply-To: <20241204161101.1148347-3-ajor@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Dec 2024 10:35:36 -0800
Message-ID: <CAEf4BzbZoq1pwq1CZShVzWELC0=eJycFvqPuDXOFEcyu9zYUpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] libbpf: Extend linker API to support
 in-memory ELF files
To: Alastair Robertson <ajor@meta.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 8:11=E2=80=AFAM Alastair Robertson <ajor@meta.com> w=
rote:
>
> The new_fd and add_fd functions correspond to the original new and
> add_file functions, but accept an FD instead of a file name. This
> gives API consumers the option of using anonymous files/memfds to
> avoid writing ELFs to disk.
>
> This new API will be useful for performing linking as part of
> bpftrace's JIT compilation.
>
> The add_buf function is a convenience wrapper that does the work of
> creating a memfd for the caller.
>
> Signed-off-by: Alastair Robertson <ajor@meta.com>
> ---
>  tools/lib/bpf/libbpf.h   |  12 +++-
>  tools/lib/bpf/libbpf.map |   3 +
>  tools/lib/bpf/linker.c   | 143 ++++++++++++++++++++++++++++++++++++---
>  3 files changed, 145 insertions(+), 13 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b2ce3a72b11d..7a88830a3431 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1784,21 +1784,29 @@ enum libbpf_tristate {
>  struct bpf_linker_opts {
>         /* size of this struct, for forward/backward compatibility */
>         size_t sz;
> +       const char *filename;
>  };
> -#define bpf_linker_opts__last_field sz
> +#define bpf_linker_opts__last_field filename
>
>  struct bpf_linker_file_opts {
>         /* size of this struct, for forward/backward compatibility */
>         size_t sz;
> +       const char *filename;
>  };
> -#define bpf_linker_file_opts__last_field sz
> +#define bpf_linker_file_opts__last_field filename
>
>  struct bpf_linker;
>
>  LIBBPF_API struct bpf_linker *bpf_linker__new(const char *filename, stru=
ct bpf_linker_opts *opts);
> +LIBBPF_API struct bpf_linker *bpf_linker__new_fd(int fd, struct bpf_link=
er_opts *opts);
>  LIBBPF_API int bpf_linker__add_file(struct bpf_linker *linker,
>                                     const char *filename,
>                                     const struct bpf_linker_file_opts *op=
ts);
> +LIBBPF_API int bpf_linker__add_fd(struct bpf_linker *linker, int fd,
> +                                 const struct bpf_linker_file_opts *opts=
);
> +LIBBPF_API int bpf_linker__add_buf(struct bpf_linker *linker, const char=
 *name,
> +                                  void *buf, int buf_sz,
> +                                  const struct bpf_linker_file_opts *opt=
s);
>  LIBBPF_API int bpf_linker__finalize(struct bpf_linker *linker);
>  LIBBPF_API void bpf_linker__free(struct bpf_linker *linker);
>
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 54b6f312cfa8..23f2a30778f0 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -432,4 +432,7 @@ LIBBPF_1.5.0 {
>  } LIBBPF_1.4.0;
>
>  LIBBPF_1.6.0 {

this should have "global:", see other version sections

> +               bpf_linker__add_buf;
> +               bpf_linker__add_fd;
> +               bpf_linker__new_fd;
>  } LIBBPF_1.5.0;
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 375896a94e6a..fd98469fa20d 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -4,6 +4,10 @@
>   *
>   * Copyright (c) 2021 Facebook
>   */
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +
>  #include <stdbool.h>
>  #include <stddef.h>
>  #include <stdio.h>
> @@ -16,6 +20,7 @@
>  #include <elf.h>
>  #include <libelf.h>
>  #include <fcntl.h>
> +#include <sys/mman.h>
>  #include "libbpf.h"
>  #include "btf.h"
>  #include "libbpf_internal.h"
> @@ -152,6 +157,8 @@ struct bpf_linker {
>         /* global (including extern) ELF symbols */
>         int glob_sym_cnt;
>         struct glob_sym *glob_syms;
> +
> +       bool fd_is_owned;
>  };
>
>  #define pr_warn_elf(fmt, ...)                                           =
                       \
> @@ -243,6 +250,54 @@ struct bpf_linker *bpf_linker__new(const char *filen=
ame, struct bpf_linker_opts
>                 pr_warn("failed to create '%s': %d\n", filename, err);
>                 goto err_out;
>         }
> +       linker->fd_is_owned =3D true;
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
> +#define LINKER_MAX_FD_NAME_SIZE 24

meh, overkill to add the constant, see below

> +
> +struct bpf_linker *bpf_linker__new_fd(int fd, struct bpf_linker_opts *op=
ts)
> +{
> +       struct bpf_linker *linker;
> +       const char *filename;
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
> +       filename =3D OPTS_GET(opts, filename, NULL);
> +       if (filename) {
> +               linker->filename =3D strdup(filename);
> +       } else {
> +               linker->filename =3D malloc(LINKER_MAX_FD_NAME_SIZE);
> +               if (!linker->filename)
> +                       return errno =3D ENOMEM, NULL;

so you didn't do strdup() result check for the case when filename is
specified. And you are not cleaning up calloc() on error. I'd
restructure this a bit differently and avoid LINKER_MAX_FD_NAME_SIZE:


char buf[32];

...

filename =3D OPTS_GET(opts, filename, NULL);
if (!filename) {
    snprintf(buf, sizeof(buf), "fd:%d", fd);
    filename =3D buf;
}
linker->filename =3D strdup(filename);
if (!linker->filename) {
    err =3D -ENOMEM;
    goto err_out;
}

WDYT?

> +               snprintf(linker->filename, LINKER_MAX_FD_NAME_SIZE, "fd:%=
d", fd);
> +       }
> +
> +       linker->fd =3D fd;
> +       linker->fd_is_owned =3D false;
>
>         err =3D init_output_elf(linker);
>         if (err)
> @@ -435,16 +490,15 @@ static int init_output_elf(struct bpf_linker *linke=
r)
>  }
>
>  int bpf_linker__add_file(struct bpf_linker *linker, const char *filename=
,
> -                        const struct bpf_linker_file_opts *opts)
> +                        const struct bpf_linker_file_opts *input_opts)

don't rename, why?

>  {
> -       struct src_obj obj =3D {};
> -       int err =3D 0, fd;
> +       int fd, ret;
>
> -       if (!OPTS_VALID(opts, bpf_linker_file_opts))
> -               return libbpf_err(-EINVAL);
> +       LIBBPF_OPTS(bpf_linker_file_opts, opts);

this is a variable declaration, no empty lines between variable declaration=
s

>
> -       if (!linker->elf)
> -               return libbpf_err(-EINVAL);
> +       if (input_opts)
> +               opts =3D *input_opts;

this is not OK due to backwards/forward compat issues (different sizes
of struct that user code knows about and libbpf expects). This bit me
before with skeletons, let's not repeat the same mistake.

but this does suck that filename hint has to be passed through opts,
so perhaps we do need a common function that won't rely on opts
struct. I.e.,

bpf_linker_add_file(linker, fd, filename) /* no other options are
supported, so nothing extra to pass */

and then bpf_linker__add_fd() and bpf_linker__add_file() both call
into bpf_linker_add_file() after checking opts for validity and
extracting filename/fd

pw-bot: cr

> +       opts.filename =3D filename;
>
>         fd =3D open(filename, O_RDONLY | O_CLOEXEC);
>         if (fd < 0) {
> @@ -452,6 +506,37 @@ int bpf_linker__add_file(struct bpf_linker *linker, =
const char *filename,
>                 return -errno;
>         }
>
> +       ret =3D bpf_linker__add_fd(linker, fd, &opts);
> +
> +       close(fd);
> +
> +       return ret;
> +}
> +
> +int bpf_linker__add_fd(struct bpf_linker *linker, int fd,
> +                      const struct bpf_linker_file_opts *opts)
> +{
> +       struct src_obj obj =3D {};
> +       const char *filename;
> +       char name[LINKER_MAX_FD_NAME_SIZE];
> +       int err =3D 0;
> +
> +       if (!OPTS_VALID(opts, bpf_linker_file_opts))
> +               return libbpf_err(-EINVAL);
> +
> +       if (!linker->elf)
> +               return libbpf_err(-EINVAL);
> +
> +       if (fd < 0)
> +               return libbpf_err(-EINVAL);
> +
> +       filename =3D OPTS_GET(opts, filename, NULL);
> +       if (filename) {
> +               obj.filename =3D filename;
> +       } else {
> +               snprintf(name, sizeof(name), "fd:%d", fd);
> +               obj.filename =3D name;
> +       }
>         obj.fd =3D fd;
>
>         err =3D err ?: linker_load_obj_file(linker, opts, &obj);
> @@ -469,12 +554,47 @@ int bpf_linker__add_file(struct bpf_linker *linker,=
 const char *filename,
>         free(obj.sym_map);
>         if (obj.elf)
>                 elf_end(obj.elf);
> -       if (obj.fd >=3D 0)
> -               close(obj.fd);
> +       /* leave obj.fd for the caller to clean up if appropriate */
>
>         return libbpf_err(err);
>  }
>
> +int bpf_linker__add_buf(struct bpf_linker *linker, const char *name,

why is the buffer name passed as an argument instead of through
opts.filename? let's keep it simple and consistent

and if user didn't care to pass opts.filename, just do some
"mem:%p+%zu", buf, buf_sz thing

> +                       void *buf, int buf_sz,

size_t for buf_sz

> +                       const struct bpf_linker_file_opts *input_opts)

nit: "opts", keep it short and consistent

> +{
> +       int fd, written, ret;
> +
> +       LIBBPF_OPTS(bpf_linker_file_opts, opts);

same about empty lines between variable declarations

> +
> +       if (input_opts)
> +               opts =3D *input_opts;
> +       opts.filename =3D name;
> +

and that bpf_linker_add_file() common function should be easily used
here as well, right?

> +       fd =3D memfd_create(name, 0);
> +       if (fd < 0) {
> +               pr_warn("failed to create memfd '%s': %s\n", name, errstr=
(errno));
> +               return -errno;
> +       }
> +
> +       written =3D 0;
> +       while (written < buf_sz) {
> +               ret =3D write(fd, buf, buf_sz);
> +               if (ret < 0) {
> +                       pr_warn("failed to write '%s': %s\n", name, errst=
r(errno));
> +                       return -errno;
> +               }
> +               written +=3D ret;
> +       }
> +
> +       ret =3D bpf_linker__add_fd(linker, fd, &opts);
> +
> +       if (fd >=3D 0)
> +               close(fd);
> +
> +       return ret;
> +}
> +
>  static bool is_dwarf_sec_name(const char *name)
>  {
>         /* approximation, but the actual list is too long */
> @@ -2691,9 +2811,10 @@ int bpf_linker__finalize(struct bpf_linker *linker=
)
>         }
>
>         elf_end(linker->elf);
> -       close(linker->fd);
> -
>         linker->elf =3D NULL;
> +
> +       if (linker->fd_is_owned)

you should do the same check in bpf_linker__free(), no?

> +               close(linker->fd);
>         linker->fd =3D -1;
>
>         return 0;
> --
> 2.43.5
>

