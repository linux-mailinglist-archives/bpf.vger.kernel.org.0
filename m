Return-Path: <bpf+bounces-20441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD6383E746
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 00:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0141C26495
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 23:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C39150A83;
	Fri, 26 Jan 2024 23:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8Q2iKTI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F1525578
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 23:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313119; cv=none; b=YSwwtKF66xqDAh2J4dz2HnLGMDsO5XJdgh41ZY1BW5SF7VFwfqUXOxuhASSQaZaUdp8N8Z+FeZSv5BpYuc9PCHntJ/PkD4D1wnOxIFzpscF70FyTPUcsAQMSeophFISGAlJ5bhg0RSmSmYEFpab0ZJLWl+Gc52FcFktCaWjhYKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313119; c=relaxed/simple;
	bh=cFgQyrYfYsGQB+ZDLgYjgAUL2FCkZUj8gbL6Majnbtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZ6+3UjSOzVExcGUJV9j/u6aAVRfc8+6UPp8Ht/ygdJ0DtQZFmiXEMW5OLCX3gjafjQRtAO5QnEDlw75Xl/Lfdi0IxoyfH6mKUIYQ1Vmc3gshKzRAhTNmFE98bzMhrJX8gR3cB7qEIIaKYreqpuFvxgcJBOYM3PWhrpWaHuB4U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8Q2iKTI; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5999f3f6ce9so861333eaf.0
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 15:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706313116; x=1706917916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mPuXZlWPKJqRAlhckcqKYpJeAKh2GPSuFQiOgXV8mk=;
        b=O8Q2iKTIAEB1Z/dTYprf3fbyhjlOPGBcSPp1ygeEZjtYTw0jJb8sdShh5gxYdiVc3a
         DWSl39jfaMmeHabs08tjNdF+wIMazWvdI/lkIjYR1YXZr2Ap4pHI0uL/cfA8wdgY9dDy
         YcehwV8i1F5me8uX0CoMLRWr7n+g6g0P1ssSaQU6qQUnL1iD87cs3ZVZvWjI+X6oSMDK
         03ZmJasxnTX35VDk/7rFKVehNQ2HPXKc7IUjYbM50yeabcfVdkfnTzRtZzuTSyoQvxFo
         4GP+zjr7zRhNs/81PazBRhsfgTFjHs92VhlOE1UmC8xtzVnOelL0hGT7ZVRpDi5AJzAf
         yyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706313116; x=1706917916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mPuXZlWPKJqRAlhckcqKYpJeAKh2GPSuFQiOgXV8mk=;
        b=kPFv6sotQl0dSP0hsw7Krq5bQP8zfuanx/+BFkrvz9nlqulAst8wWZlt0tuiiZsTgh
         mmNx2WqGOLFjimlaJ1w0YRYEX7kj+bAYmx1bCjt5U6QK564L3Uvh7qQ1DJVrnvT+z3eH
         QekM87PJDhGZjtYW7FnGmmWm8eToiF8t0JVcH/QHFcxyrNP31ji4qcsbqAcFGi8sUyp7
         pIRQGEWvJxLvpnvTGox8tR1YlKzbH7CecnpJnDOp7hiDU/Pt2xpW8DF2Qap9K77y4Ws1
         3IBAMfrkinRA7YK4hlslP0ScRGpXi1LgL4LFOVcoaT3salY8g/dxfFkQQ7yw6tLCS4/E
         LakA==
X-Gm-Message-State: AOJu0YzGCsnqGZSWHzREWCC2ddprbOeNqCUVVg7rAA0QnVSsk8xS+aSb
	nteQzHXXPzAurAtgVWashegsoaJEzo7HuyuWc197QWiT4pLLHPb8OXpCa3LwEk5MIEJy8Oc0Io6
	HijDdD3FbrAxoTfB2VfLE0vamCto=
X-Google-Smtp-Source: AGHT+IEF+W11PtP74KfbSmFcPDS3EYQ1KU6WOyhiuJmd/bSzrVzihbeWkhrpfBr8V7igQaflRBpud1QCaXh2wsJlTkk=
X-Received: by 2002:a05:6358:2611:b0:176:c47b:7ef5 with SMTP id
 l17-20020a056358261100b00176c47b7ef5mr859465rwc.4.1706313116339; Fri, 26 Jan
 2024 15:51:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126220407.2424-1-git@brycekahle.com>
In-Reply-To: <20240126220407.2424-1-git@brycekahle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Jan 2024 15:51:44 -0800
Message-ID: <CAEf4BzbnsD-80+yg7-mN+vhf5M0TwwBmGQYuovssvqd1sXeu=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpftool: add support for split BTF to gen min_core_btf
To: Bryce Kahle <git@brycekahle.com>
Cc: bpf@vger.kernel.org, quentin@isovalent.com, ast@kernel.org, 
	daniel@iogearbox.net, Bryce Kahle <bryce.kahle@datadoghq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 2:04=E2=80=AFPM Bryce Kahle <git@brycekahle.com> wr=
ote:
>
> From: Bryce Kahle <bryce.kahle@datadoghq.com>
>
> Enables a user to generate minimized kernel module BTF.
>
> If an eBPF program probes a function within a kernel module or uses
> types that come from a kernel module, split BTF is required. The split
> module BTF contains only the BTF types that are unique to the module.
> It will reference the base/vmlinux BTF types and always starts its type
> IDs at X+1 where X is the largest type ID in the base BTF.
>
> Minimization allows a user to ship only the types necessary to do
> relocations for the program(s) in the provided eBPF object file(s). A
> minimized module BTF will still not contain vmlinux BTF types, so you
> should always minimize the vmlinux file first, and then minimize the
> kernel module file.
>
> Example:
>
> bpftool gen min_core_btf vmlinux.btf vm-min.btf prog.bpf.o
> bpftool -B vm-min.btf gen min_core_btf mod.btf mod-min.btf prog.bpf.o
>
> Signed-off-by: Bryce Kahle <bryce.kahle@datadoghq.com>
> ---
>  .../bpf/bpftool/Documentation/bpftool-gen.rst  | 18 +++++++++++++++++-
>  tools/bpf/bpftool/gen.c                        | 17 ++++++++++++-----
>  2 files changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/=
bpftool/Documentation/bpftool-gen.rst
> index 5006e724d..e067d3b05 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> @@ -16,7 +16,7 @@ SYNOPSIS
>
>         **bpftool** [*OPTIONS*] **gen** *COMMAND*
>
> -       *OPTIONS* :=3D { |COMMON_OPTIONS| | { **-L** | **--use-loader** }=
 }
> +       *OPTIONS* :=3D { |COMMON_OPTIONS| | { **-B** | **--base-btf** } |=
 { **-L** | **--use-loader** } }
>
>         *COMMAND* :=3D { **object** | **skeleton** | **help** }
>
> @@ -202,6 +202,14 @@ OPTIONS
>  =3D=3D=3D=3D=3D=3D=3D
>         .. include:: common_options.rst
>
> +       -B, --base-btf *FILE*
> +                 Pass a base BTF object. Base BTF objects are typically =
used
> +                 with BTF objects for kernel modules. To avoid duplicati=
ng
> +                 all kernel symbols required by modules, BTF objects for
> +                 modules are "split", they are built incrementally on to=
p of
> +                 the kernel (vmlinux) BTF object. So the base BTF refere=
nce
> +                 should usually point to the kernel BTF.
> +
>         -L, --use-loader
>                   For skeletons, generate a "light" skeleton (also known =
as "loader"
>                   skeleton). A light skeleton contains a loader eBPF prog=
ram. It does
> @@ -444,3 +452,11 @@ ones given to min_core_btf.
>    obj =3D bpf_object__open_file("one.bpf.o", &opts);
>
>    ...
> +
> +Kernel module BTF may also be minimized by using the -B option:
> +
> +**$ bpftool -B 5.4.0-smaller.btf gen min_core_btf 5.4.0-module.btf 5.4.0=
-module-smaller.btf one.bpf.o**
> +
> +A minimized module BTF will still not contain vmlinux BTF types, so you
> +should always minimize the vmlinux file first, and then minimize the
> +kernel module file.
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index ee3ce2b80..634c809a5 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -1630,6 +1630,7 @@ static int do_help(int argc, char **argv)
>                 "       %1$s %2$s help\n"
>                 "\n"
>                 "       " HELP_SPEC_OPTIONS " |\n"
> +               "                    {-B|--base-btf} |\n"
>                 "                    {-L|--use-loader} }\n"
>                 "",
>                 bin_name, "gen");
> @@ -1695,14 +1696,14 @@ btfgen_new_info(const char *targ_btf_path)
>         if (!info)
>                 return NULL;
>
> -       info->src_btf =3D btf__parse(targ_btf_path, NULL);
> +       info->src_btf =3D btf__parse_split(targ_btf_path, base_btf);
>         if (!info->src_btf) {
>                 err =3D -errno;
>                 p_err("failed parsing '%s' BTF file: %s", targ_btf_path, =
strerror(errno));
>                 goto err_out;
>         }
>
> -       info->marked_btf =3D btf__parse(targ_btf_path, NULL);
> +       info->marked_btf =3D btf__parse_split(targ_btf_path, base_btf);
>         if (!info->marked_btf) {
>                 err =3D -errno;
>                 p_err("failed parsing '%s' BTF file: %s", targ_btf_path, =
strerror(errno));
> @@ -2141,10 +2142,16 @@ static struct btf *btfgen_get_btf(struct btfgen_i=
nfo *info)
>  {
>         struct btf *btf_new =3D NULL;
>         unsigned int *ids =3D NULL;
> +       const struct btf *base;
>         unsigned int i, n =3D btf__type_cnt(info->marked_btf);
> +       int start_id =3D 1;
>         int err =3D 0;
>
> -       btf_new =3D btf__new_empty();
> +       base =3D btf__base_btf(info->src_btf);
> +       if (base)
> +               start_id =3D btf__type_cnt(base);

stylistic nit, I'd do:

int start_id, err =3D 0;

and then here

start_id =3D base ? btf__type_cnt(base) : 1;

I'd also name base as base_btf to make it clearer that it's a btf object

> +
> +       btf_new =3D btf__new_empty_split((struct btf *)base);

um... and this cast didn't trigger any warnings for you? It might work
ok currently, but clearly the code expects that base_btf might be
modified, so sharing the same base_btf between two split BTF instances
is just a recipe for a hard-to-debug issues, long term.

Let's create a copy of base BTF instead? You can use btf__raw_data() +
btf__new() to make a simple clone

pw-bot: cr

>         if (!btf_new) {
>                 err =3D -errno;
>                 goto err_out;
> @@ -2157,7 +2164,7 @@ static struct btf *btfgen_get_btf(struct btfgen_inf=
o *info)
>         }
>
>         /* first pass: add all marked types to btf_new and add their new =
ids to the ids map */
> -       for (i =3D 1; i < n; i++) {
> +       for (i =3D start_id; i < n; i++) {
>                 const struct btf_type *cloned_type, *type;
>                 const char *name;
>                 int new_id;
> @@ -2213,7 +2220,7 @@ static struct btf *btfgen_get_btf(struct btfgen_inf=
o *info)
>         }
>
>         /* second pass: fix up type ids */
> -       for (i =3D 1; i < btf__type_cnt(btf_new); i++) {
> +       for (i =3D start_id; i < btf__type_cnt(btf_new); i++) {
>                 struct btf_type *btf_type =3D (struct btf_type *) btf__ty=
pe_by_id(btf_new, i);
>
>                 err =3D btf_type_visit_type_ids(btf_type, btfgen_remap_id=
, ids);
> --
> 2.25.1
>
>

