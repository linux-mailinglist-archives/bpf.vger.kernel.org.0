Return-Path: <bpf+bounces-46180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FD19E603B
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 22:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790081884E4E
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 21:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075081C8FA8;
	Thu,  5 Dec 2024 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEuZ4EZ3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18B81AD9F9
	for <bpf@vger.kernel.org>; Thu,  5 Dec 2024 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733435224; cv=none; b=jPYXvqpGFrmoD8A8Qp4xPb50aHi5cfXXn57oTssa+JzqtHtlQ20xyi0thtjc9wfCmQ25shEFWxWoeJXJHPAhleVHxxjPsW0AgWeeOkStAnaOmDUmRhMusIAo46J6/lQi5hGTx4crDpjytP7WuehmI9BMGirEvHJG6yZSPMZKo+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733435224; c=relaxed/simple;
	bh=1T/UiITcfhDYaDJVGc5yjuKrNLzxNgHr2iweWtKO9d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/2No6SmPVQPfT++QtshMU9TtimPrIKhgbZSf9QoWHTHfRgO9cKee0q1RCE5hvKWJOJ8fZvB8zB1ft5/CVEjV7g/wgAspxnHsuLYP6t0vzsmm5kyHzIJuc8sDjYM7661EAMoSZMcfHkZsTwRMT8mWbmAtVEy4B6qbc+e0wYkgl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEuZ4EZ3; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ef6af22ea8so137906a91.0
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 13:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733435222; x=1734040022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWyFW9ruwlyG3sr0NCyk61KB9ldxifEllbAngRM3AF4=;
        b=eEuZ4EZ3cF479PpFpbG/0uhX1ecyU4bZdkd05c6JckoA7vpuaozCP9V6EZUEiNKrup
         bqDP7Rg3NQxXFWXia9Du4CXXJavX6XZgdlNWWCYp8YMyLkJWNQfn3Fp9bfaHI9qAT1To
         juLH9wRPzIdjxhX59ys+Xx9nwkTMLqCY3ha2voVq+f0dJxIv7ByFHmPjPyywe6ZmV4ou
         fCGInR2Y/c33kc4LnjSwwVnu1SqH0d6xsCrDW+lGqcaL6nkNS7tzQ9fjogxk365VkKsf
         +90dbkMsyu2dIsniqH5F2T0I6q7Ll+DfUDxPdcWYNsxBhwxZhGCVySntqO7t2/etCbqK
         9lAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733435222; x=1734040022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWyFW9ruwlyG3sr0NCyk61KB9ldxifEllbAngRM3AF4=;
        b=btu7xlpfK1igteoJ0OoYCV9jmx3PZThPrVwickbmwa84U+0OeC41FgnA8DTXKKqqcu
         qEtKNsPPZ9AMezP/sofh3GUgJU3XjWWdQKR0jDW1OaCd5JrlYBAe+nSuPzcdAUoQFQC9
         Us6Q+lP6rUWsWDZZxMmNs3GPoxK2ej8fGf5BhBYo4etdKIzQR8D1SWdOtDyN2OUwWWHI
         sLXrbtPX/O4V7ODhYmJYsWYH6vBhgel3AFovyljRSPrle3tTs8Q7Sqisacfhj0YvvbsQ
         XValEoQdRyUjG9soG9ACNzBWzdK8xQdUCdWITcUoGjDxjSfeH7kb57KHW4Mza0DwIVOv
         pI7A==
X-Forwarded-Encrypted: i=1; AJvYcCVa9sCFf2qiJfbDO1W7PCjQzvKcynfLodwyvGch18nVz+m+K+EMa3hHz7McMLNrXuwqmRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzqcwmbgNEBtLo4XzimZ4vGPfUk7L70Z0HsmSEH9+jy5FTGYW0
	T8QMMigIt1RXkXDnpPvGrbqzLO8/um6D8hGDHKGuISsnkA02LC1pt+H6L/Df2NuNb2EvFrDxPn/
	RQ+LP0VTX/t0HmclZei094gLxflU=
X-Gm-Gg: ASbGncvMfc5SExiVSjM5qtgVKXr0kq5+IUZuI1B+JRU3nAUxhT7lsfdodZUMTRM00FX
	rXY30kHt/txyGtJMM5XKsNb5fHeBQVQ7y+myyRBzml6/GqcA=
X-Google-Smtp-Source: AGHT+IEx2cipmUcvI+TdJTkpyBk8i657Iu7EWlF8ZuMZUxKEHvRL3YDb7Nf/b81mTTKyb5xkV1StQV+5XfpX/+r2lUY=
X-Received: by 2002:a17:90b:53ce:b0:2ee:df70:1ff3 with SMTP id
 98e67ed59e1d1-2ef69199134mr1382452a91.0.1733435222098; Thu, 05 Dec 2024
 13:47:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205135942.65262-1-qmo@kernel.org>
In-Reply-To: <20241205135942.65262-1-qmo@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Dec 2024 13:46:50 -0800
Message-ID: <CAEf4BzazrH+QrzJP+honiLWACSheQVuJpj7asdKFvx-rcQB+1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Fix segfault due to libelf functions not
 setting errno
To: Quentin Monnet <qmo@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 5:59=E2=80=AFAM Quentin Monnet <qmo@kernel.org> wrot=
e:
>
> Libelf functions do not set errno on failure. Instead, it relies on its
> internal _elf_errno value, that can be retrieved via elf_errno (or the
> corresponding message via elf_errmsg()). From "man libelf":
>
>     If a libelf function encounters an error it will set an internal
>     error code that can be retrieved with elf_errno. Each thread
>     maintains its own separate error code. The meaning of each error
>     code can be determined with elf_errmsg, which returns a string
>     describing the error.
>
> As a consequence, libbpf should not return -errno when a function from
> libelf fails, because an empty value will not be interpreted as an error
> and won't prevent the program to stop. This is visible in
> bpf_linker__add_file(), for example, where we call a succession of
> functions that rely on libelf:
>
>     err =3D err ?: linker_load_obj_file(linker, filename, opts, &obj);
>     err =3D err ?: linker_append_sec_data(linker, &obj);
>     err =3D err ?: linker_append_elf_syms(linker, &obj);
>     err =3D err ?: linker_append_elf_relos(linker, &obj);
>     err =3D err ?: linker_append_btf(linker, &obj);
>     err =3D err ?: linker_append_btf_ext(linker, &obj);
>
> If the object file that we try to process is not, in fact, a correct
> object file, linker_load_obj_file() may fail with errno not being set,
> and return 0. In this case we attempt to run linker_append_elf_sysms()
> and may segfault.
>
> This can happen (and was discovered) with bpftool:
>
>     $ bpftool gen object output.o sample_ret0.bpf.c
>     libbpf: failed to get ELF header for sample_ret0.bpf.c: invalid `Elf'=
 handle
>     zsh: segmentation fault (core dumped)  bpftool gen object output.o sa=
mple_ret0.bpf.c
>
> Fix the issue by returning a non-null error code (-EINVAL) when libelf
> functions fail.
>
> Fixes: faf6ed321cf6 ("libbpf: Add BPF static linker APIs")
> Signed-off-by: Quentin Monnet <qmo@kernel.org>
> ---
>  tools/lib/bpf/linker.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>

Ok, so *this* is the real issue with SIGSEGV that we were trying to
"prevent" by file path comparison in that bpftool-specific patch,
right? LGTM, I'll apply to bpf-next.

> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index cf71d149fe26..e56ba6e67451 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -566,17 +566,15 @@ static int linker_load_obj_file(struct bpf_linker *=
linker, const char *filename,
>         }
>         obj->elf =3D elf_begin(obj->fd, ELF_C_READ_MMAP, NULL);
>         if (!obj->elf) {
> -               err =3D -errno;
>                 pr_warn_elf("failed to parse ELF file '%s'", filename);
> -               return err;
> +               return -EINVAL;
>         }
>
>         /* Sanity check ELF file high-level properties */
>         ehdr =3D elf64_getehdr(obj->elf);
>         if (!ehdr) {
> -               err =3D -errno;
>                 pr_warn_elf("failed to get ELF header for %s", filename);
> -               return err;
> +               return -EINVAL;
>         }
>
>         /* Linker output endianness set by first input object */
> @@ -606,9 +604,8 @@ static int linker_load_obj_file(struct bpf_linker *li=
nker, const char *filename,
>         }
>
>         if (elf_getshdrstrndx(obj->elf, &obj->shstrs_sec_idx)) {
> -               err =3D -errno;
>                 pr_warn_elf("failed to get SHSTRTAB section index for %s"=
, filename);
> -               return err;
> +               return -EINVAL;
>         }
>
>         scn =3D NULL;
> @@ -618,26 +615,23 @@ static int linker_load_obj_file(struct bpf_linker *=
linker, const char *filename,
>
>                 shdr =3D elf64_getshdr(scn);
>                 if (!shdr) {
> -                       err =3D -errno;
>                         pr_warn_elf("failed to get section #%zu header fo=
r %s",
>                                     sec_idx, filename);
> -                       return err;
> +                       return -EINVAL;
>                 }
>
>                 sec_name =3D elf_strptr(obj->elf, obj->shstrs_sec_idx, sh=
dr->sh_name);
>                 if (!sec_name) {
> -                       err =3D -errno;
>                         pr_warn_elf("failed to get section #%zu name for =
%s",
>                                     sec_idx, filename);
> -                       return err;
> +                       return -EINVAL;
>                 }
>
>                 data =3D elf_getdata(scn, 0);
>                 if (!data) {
> -                       err =3D -errno;
>                         pr_warn_elf("failed to get section #%zu (%s) data=
 from %s",
>                                     sec_idx, sec_name, filename);
> -                       return err;
> +                       return -EINVAL;
>                 }
>
>                 sec =3D add_src_sec(obj, sec_name);
> @@ -2680,14 +2674,14 @@ int bpf_linker__finalize(struct bpf_linker *linke=
r)
>
>         /* Finalize ELF layout */
>         if (elf_update(linker->elf, ELF_C_NULL) < 0) {
> -               err =3D -errno;
> +               err =3D -EINVAL;
>                 pr_warn_elf("failed to finalize ELF layout");
>                 return libbpf_err(err);
>         }
>
>         /* Write out final ELF contents */
>         if (elf_update(linker->elf, ELF_C_WRITE) < 0) {
> -               err =3D -errno;
> +               err =3D -EINVAL;
>                 pr_warn_elf("failed to write ELF contents");
>                 return libbpf_err(err);
>         }
> --
> 2.43.0
>

