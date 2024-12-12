Return-Path: <bpf+bounces-46762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2329F002F
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A68188E0E5
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 23:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DAE1DED52;
	Thu, 12 Dec 2024 23:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwFpIzun"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A3D1D6188
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046165; cv=none; b=TVRIrB2MhFtLK4gbcgr17FzDn7+cjr5EiyLeTCPyhsZ9Bw3MKtoxfc2HNN3+S9O4jww2dcE0r8vQtyO+RzYdHli0lUYko/Rc8xzVKSQKXbGakFVwZDnIMg5tbkb6cfzF6WebHQOM1mOlBPmM6Uy0Q5vG26UFdMU+wua1m3Ue0ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046165; c=relaxed/simple;
	bh=SwgfFQtYBbS84uHOrPPFUiBKN/uNt9QW8ngBn7yo6iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dy7anic3rcEsWqMnBBBqsgEezNPGxXAxG2uxg13D1lCQ/GcovXyiusoPCFZ8DBbr+XA4MZPHdqJ3+fYPzTvc2vO+TJqwfQbA5VLG31ZTULR+GRyWAEdaYyr+CKkuRY+uZXD2z1vegYGYqSVGaYBYe0XtGfmROnsRIyQK2PJ3tGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwFpIzun; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso913122a91.1
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 15:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734046163; x=1734650963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDEpVRYf1BEFa+oV5q921SdpI1NFvW3UZL8yhq7ETjs=;
        b=GwFpIzuny3QXqrCD1QeXOmUnWhdxjjbFaIrLvfKeT8FUJLeNfH8EQ45IpUrnnxwn9Y
         hk/n5s+1wqHAOEau6I5mLzpenBBoRIYB2EQ6XM60Zfyysp3L4mLbowabFizvWFINRjsy
         Q8iD0pgkZD8qn4LP8YPmeNoOSor9zm83ZgK5gsYi0DR4KZOojOK3ZMNpnOzDze7X9iSA
         vSPqH2zCA1MdQzSFffHhiiwqN/hZeWTfTfLK7Egv6YFyJH4UXZgHomkVd7lkje7JbZqh
         iuN02NmmdAlj5YBlCotm9QYMJAmGhCHBXdV7INYuUiejzmrjTtgVEqhOofWAEuqRIRGx
         lorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046163; x=1734650963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDEpVRYf1BEFa+oV5q921SdpI1NFvW3UZL8yhq7ETjs=;
        b=GGBYU36fxreIvsD0+NVnutDkkQWTsFplnAcJEEX0X+yRCFgGCJ/v2oEAlfTXfZUr0H
         qODCVXVHnyrmAqQurcpfa3OW1iXAnEIBLuL/HxXpr8qVUchgRI+36cfg7ho+2IhQHrgI
         GY7AHgdVQ8mraQTI0oFr28ZTnJn65yaB1jm+RbRB+OtlC9cl+8WVWGfa7ROZnMylPGhj
         XRY8WWx7ExawB3Kd/4b3JrhiGb1ct8O3uR5KYC9RIYt2NlZmnKu0Qf93b/D3HH2lUEhy
         XnU7qgT7l1hbyIQC84Ds38ghNiueO9bCauRSZDsEM3h7PcTYZ2/tUb3Ldbcvgl7hQLH0
         xCOw==
X-Gm-Message-State: AOJu0Yx7bMDJkL053C5n9gzbBbmsR3+Q1/UbSnFWNq6N7xlAmSDEy4OX
	spyo69gKFAAM+R4ZAZauWoBeCCKbLMN2R/ohTvEvGctkK6Y2lmmX7AHkXiNXip/m0g1kyC47/5m
	044WjD93hQ1lQMIYJIdVe0+M3giU=
X-Gm-Gg: ASbGncul4lhB6mRh+YbxRAsJU2u8BCBFN7wOlNait4YfCd4uX0c5ECI9SCzAelTpwBi
	p0HeO69Z0Jono0ICSy7cUuB8tQ6LdpRFmflDxyWb7NWOaDJALU6E55A==
X-Google-Smtp-Source: AGHT+IH8+8PoxIR6Cr9v5P1zd6LssqKLBOpj0rqqSyKD9j7NC3WyIAdqJNOn0CEYEmFUmF8Oe/vhuJFsTXP/VH8vWgQ=
X-Received: by 2002:a17:90b:2b45:b0:2ee:d7d3:3008 with SMTP id
 98e67ed59e1d1-2f28fb63badmr1125467a91.12.1734046163186; Thu, 12 Dec 2024
 15:29:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211164030.573042-1-ajor@meta.com> <20241211164030.573042-3-ajor@meta.com>
In-Reply-To: <20241211164030.573042-3-ajor@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Dec 2024 15:29:11 -0800
Message-ID: <CAEf4BzZd6XYbFN6oz71HYTNCc0aCn8Yn-ALGHk-ip2AaRtV8LQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] libbpf: Extend linker API to support
 in-memory ELF files
To: Alastair Robertson <ajor@meta.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 8:40=E2=80=AFAM Alastair Robertson <ajor@meta.com> =
wrote:
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
>  tools/lib/bpf/libbpf.h   |   5 ++
>  tools/lib/bpf/libbpf.map |   4 +
>  tools/lib/bpf/linker.c   | 163 ++++++++++++++++++++++++++++++++++-----
>  3 files changed, 152 insertions(+), 20 deletions(-)
>

There were a bunch of errno mishandling issues and a small memory
leak. I fixed all that up and landed in bpf-next.

> +int bpf_linker__add_file(struct bpf_linker *linker, const char *filename=
,
> +                        const struct bpf_linker_file_opts *opts)
> +{
> +       int fd, ret;
> +
> +       if (!OPTS_VALID(opts, bpf_linker_file_opts))
> +               return libbpf_err(-EINVAL);
> +
> +       if (!linker->elf)
> +               return libbpf_err(-EINVAL);
> +
> +       fd =3D open(filename, O_RDONLY | O_CLOEXEC);
> +       if (fd < 0) {
> +               pr_warn("failed to open file '%s': %s\n", filename, errst=
r(errno));
> +               return -errno;

same issue with errno clobbering, fixed, but please be careful with
errno, pretty much anything can clobber errno in libc, except free()
and maybe a few more APIs

> +       }
> +
> +       ret =3D bpf_linker_add_file(linker, fd, filename);
> +
> +       close(fd);
> +
> +       return ret;

this needed to be libbpf_err(ret), because close() can clobber errno,
added while applying

> +}
> +
> +int bpf_linker__add_fd(struct bpf_linker *linker, int fd,
> +                      const struct bpf_linker_file_opts *opts)
> +{
> +       char filename[32];
> +       int ret;
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
> +       snprintf(filename, sizeof(filename), "fd:%d", fd);
> +
> +       ret =3D bpf_linker_add_file(linker, fd, filename);
> +
> +       return ret;

here as well

> +}
> +
> +int bpf_linker__add_buf(struct bpf_linker *linker, void *buf, size_t buf=
_sz,
> +                       const struct bpf_linker_file_opts *opts)
> +{
> +       char filename[32];
> +       int fd, written, ret;
> +
> +       if (!OPTS_VALID(opts, bpf_linker_file_opts))
> +               return libbpf_err(-EINVAL);
> +
> +       if (!linker->elf)
> +               return libbpf_err(-EINVAL);
> +
> +       snprintf(filename, sizeof(filename), "mem:%p+%zu", buf, buf_sz);
> +
> +       fd =3D memfd_create(filename, 0);
> +       if (fd < 0) {

and here

> +               pr_warn("failed to create memfd '%s': %s\n", filename, er=
rstr(errno));
> +               return -errno;
> +       }
> +
> +       written =3D 0;
> +       while (written < buf_sz) {
> +               ret =3D write(fd, buf, buf_sz);
> +               if (ret < 0) {

and here

and also you were leaking memfd here, I added jump to close(fd)

> +                       pr_warn("failed to write '%s': %s\n", filename, e=
rrstr(errno));
> +                       return -errno;
> +               }
> +               written +=3D ret;
> +       }
> +
> +       ret =3D bpf_linker_add_file(linker, fd, filename);
> +
> +       close(fd);
> +
> +       return ret;

and here


> +}
> +
>  static bool is_dwarf_sec_name(const char *name)
>  {
>         /* approximation, but the actual list is too long */
> @@ -2686,9 +2808,10 @@ int bpf_linker__finalize(struct bpf_linker *linker=
)
>         }
>
>         elf_end(linker->elf);
> -       close(linker->fd);
> -
>         linker->elf =3D NULL;
> +
> +       if (linker->fd_is_owned)
> +               close(linker->fd);
>         linker->fd =3D -1;
>
>         return 0;
> --
> 2.43.5
>

