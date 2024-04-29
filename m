Return-Path: <bpf+bounces-28151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E8F8B633E
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 22:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB052831FA
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 20:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C471411C9;
	Mon, 29 Apr 2024 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG8nfiYB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7891119B
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 20:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421448; cv=none; b=j1/z1Oyihj+d5bAl/KPtbcsLHdXpCH/eFn9lbipCa9PUnaxY5EryAmBF4kKDUTdMytPvh9GbxVpbtvnW9v34eBHTsoSFZaVC8ifm4zKLwSxig8yQ/l4lxnN1ohHnLALpDc9R/NQMMvP6u2bk8osQB0netvnjC3c7lyEG8+4Ao3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421448; c=relaxed/simple;
	bh=+MdjASWCZ75qKNgnmyNU9ffjmCCvpXv0EKZqFw4aTik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBJ/9RamWlivnciUiZnYsV1gsbBDJ3ZERbYdTeeI4yiJZy9edUCmCzlY5dSDtIex8B+2/49k4gENf2MD2v3EBraJ4coUEvGEYRmuYMmqjc8mvf2BgxcydH3we1R8R5RHKBOLn3A5Rx5v9UFCDcTSch1tPhbYXk/5a/Ur9o7k1gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG8nfiYB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d3907ff128so3982889a12.3
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 13:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714421446; x=1715026246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=364RMmqj7oyHLLjA8L1ifli9D/uDu2QkH1xXJJvNKh8=;
        b=DG8nfiYBMRJFkQ3wcaYTzOLrdDu7l1KC2PgUsmiv959gbb8t0oewDtsJvZmqHM+CBh
         Q0PUtabhrLJ7hB/dd7iZDEWa20Zh8bo2Rr/VtHG9VQWWi+XKPebCOrtrlsv6P2L/Ra4l
         +XOnzgTI61s9DoXhRwP6QNM6YRAL5B2C57/ZXKr0zaTJx/WwdpJqArf3a5nj6Uyt1k6w
         FAhKZMsF+lviXqUcPi62xJ1iXcl3jnSJsaF9z3t1IFe7uhx0tlVrt7tK975XHCxarf5D
         KgZb4zqxalzDNGlaDF067YznLC5Z7lgR5Jv1KBI6EuDz36Tng4CWO+saHERMLKBgTrV5
         kUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714421446; x=1715026246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=364RMmqj7oyHLLjA8L1ifli9D/uDu2QkH1xXJJvNKh8=;
        b=A5Ka6dPmIXeEBKEaIIfO4B9Gu4qKIajgoi5moxVai+pnwZEtzkabYANlY5XvRkiZq/
         fAMLFF+9j6LtGEJh3oeNTuIyG1iLdKhG00HFT32XKiiBXVSvOZB10T+s/o596PhD3hoW
         zwJksrMp1JgTeZpigqK1imqtK2O/+gALw80yq4Y3U3TfJcQx7s3l4UIGtRzm6wMbhlXc
         BFvmEeqRlKSS8UAHTSOcSjSHp7ZJ8yEaK1W5xHoncwEQyj3FsZg7VRi9zfA4yNYMt93U
         7IghHDfOiRO4kBpt0TVcEBbAviRr3mjCKY9pSltVeg8iFRz1okC1qHs7XrKswi1QhgUN
         tuQQ==
X-Gm-Message-State: AOJu0YzFslDzNQw9BBlmSboiPQ5hh+MP+RjF44hxC1qXuZpXf0qfboXl
	bNQJslnUiw4wOprKrKClfuPu3epUV1+pbCS5yxOQcosCA+DwZmuFLdpty+aSUr3KQZdMcTvC9Kp
	QC76kOLhYGpU2As1ComCQpMg4IJ8=
X-Google-Smtp-Source: AGHT+IH+VYXotmw7Jjq8zOcoTNAebzgNeE013bB8AN2L23igBuxFjaiug4asiBgUKchqCILNjgmqIjHJkZOr+CpPi24=
X-Received: by 2002:a17:90a:c403:b0:2b1:9fa4:16fd with SMTP id
 i3-20020a17090ac40300b002b19fa416fdmr4065437pjt.4.1714421446288; Mon, 29 Apr
 2024 13:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714133551.git.vmalik@redhat.com> <239e6c07800fa0c6c7540589e6ba0a49ba419237.1714133551.git.vmalik@redhat.com>
In-Reply-To: <239e6c07800fa0c6c7540589e6ba0a49ba419237.1714133551.git.vmalik@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 13:10:34 -0700
Message-ID: <CAEf4BzaUn+zhAAD=JKaT==hgJn85a0rUvJc1j30yHWE4uJujFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: support "module:function" syntax for
 tracing programs
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:17=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> In some situations, it is useful to explicitly specify a kernel module
> to search for a tracing program target (e.g. when a function of the same
> name exists in multiple modules or in vmlinux).
>
> This patch enables that by allowing the "module:function" syntax for the
> find_kernel_btf_id function. Thanks to this, the syntax can be used both
> from a SEC macro (i.e. `SEC(fentry/module:function)`) and via the
> bpf_program__set_attach_target API call.
>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  tools/lib/bpf/libbpf.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
>

Looks good, just stylistic nits below.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 97eb6e5dd7c8..5a136876cd1c 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9858,16 +9858,28 @@ static int find_kernel_btf_id(struct bpf_object *=
obj, const char *attach_name,
>                               enum bpf_attach_type attach_type,
>                               int *btf_obj_fd, int *btf_type_id)
>  {
> -       int ret, i;
> +       int ret, i, mod_len;
> +       const char *fun_name, *mod_name =3D NULL;

bikeshedding nit, but let's call it fn_name ("fun" doesn't associate
with "function" in my head at all)

>
> -       ret =3D find_attach_btf_id(obj->btf_vmlinux, attach_name, attach_=
type);
> -       if (ret > 0) {
> -               *btf_obj_fd =3D 0; /* vmlinux BTF */
> -               *btf_type_id =3D ret;
> -               return 0;
> +       fun_name =3D strchr(attach_name, ':');
> +       if (fun_name) {
> +               mod_name =3D attach_name;
> +               mod_len =3D fun_name - mod_name;
> +               fun_name++;
> +       }
> +
> +       if (!mod_name || strncmp(mod_name, "vmlinux", mod_len) =3D=3D 0) =
{
> +               ret =3D find_attach_btf_id(obj->btf_vmlinux,
> +                                        mod_name ? fun_name : attach_nam=
e,
> +                                        attach_type);
> +               if (ret > 0) {
> +                       *btf_obj_fd =3D 0; /* vmlinux BTF */
> +                       *btf_type_id =3D ret;
> +                       return 0;
> +               }
> +               if (ret !=3D -ENOENT)
> +                       return ret;
>         }
> -       if (ret !=3D -ENOENT)
> -               return ret;
>
>         ret =3D load_module_btfs(obj);
>         if (ret)
> @@ -9876,7 +9888,10 @@ static int find_kernel_btf_id(struct bpf_object *o=
bj, const char *attach_name,
>         for (i =3D 0; i < obj->btf_module_cnt; i++) {
>                 const struct module_btf *mod =3D &obj->btf_modules[i];
>
> -               ret =3D find_attach_btf_id(mod->btf, attach_name, attach_=
type);
> +               if (mod_name && strncmp(mod->name, mod_name, mod_len))

please add explicit `=3D=3D 0` after strncmp(), like you did above for vmli=
nux

> +                       continue;
> +
> +               ret =3D find_attach_btf_id(mod->btf, mod_name ? fun_name =
: attach_name, attach_type);
>                 if (ret > 0) {
>                         *btf_obj_fd =3D mod->fd;
>                         *btf_type_id =3D ret;
> --
> 2.44.0
>

