Return-Path: <bpf+bounces-21463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5833484D74B
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 01:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AA31C22F4B
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 00:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF17DDBE;
	Thu,  8 Feb 2024 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv4AqPGC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D920214267;
	Thu,  8 Feb 2024 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353430; cv=none; b=N0/1c0/80JhMrcSZdWxSaeH6kgS0DPsE5HmZnTVRmMWH7Rsd5gJxUGY9ESJZiB+fWiudofmbOdy4HKohUbrvb5ODRHm/R/TPHx8W+YrqXq5GK0M863arHQnId101AFkOllXt1mlSJbvIQuY86H3sQTUwUiqmrmrKXwVfRIZJJy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353430; c=relaxed/simple;
	bh=nXpn5BlvGSY0sc64IXz6i7AkTu8HDnw+rRcIZuYB39M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PUHcbecSn9astc/NfXDvETA+VG7/iTg2TEzAkNOI2bel/9BOgwjMwkXQhGNo4vf58RN3DLMMHaW5YkoJW9NayrPgBwo/1sHZ6w4OKTdOdSdjgIGcVsNLB8/vA4LI+mGO2aNfYkmtFGAUxoCNa3gEw9nBtZs7458ySz/lRVs2nKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bv4AqPGC; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bfedaaeeacso675466b6e.0;
        Wed, 07 Feb 2024 16:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707353428; x=1707958228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhnRrncVP4lzPLUrvGryxvbt7W38XLsNAzwHJ2tdxwE=;
        b=bv4AqPGC104QzX5+m5JWIuEtk1ITVITOczNCVZQuc0ix0puVrBkSGGEYLFhB50lEv9
         oR7d6K0MogepQQcsyRL8mSdOx8dzHo1cSdqE8+b03pFrQM6K+m8g8L8KfvrsKZzsDf5H
         GcV3fc/RKRmHxQouydKa13aPtTO0pG5ohct0iAxUG7SZ2WXO2dDqdqmPPGgQjeU3vXoH
         LMDjJ0U8KzH0t9NAmvB56dSrDzhA3AEewMXK/r9UUkWfcAaZptQQganeLFQLGhOP6+N2
         tW1CZ9zZYK1GwJZNqope5x5z6v0j9k76PgU8GFjDEFhJC63Vp0HfdI2G5xiZDxt/VDVD
         dP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707353428; x=1707958228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhnRrncVP4lzPLUrvGryxvbt7W38XLsNAzwHJ2tdxwE=;
        b=o/DNrr6A35XBuJXoA7DzaTwc8Z+FEsxEtrdVOIh2kRG4zkLDZftp4ZOhCZzUKvosSn
         vgPZjPV16Jo0Rw9wQbMf7JeUOoRXhEXvbojizkyEGyRbPmNwwQ/o9rZFoEzYW7EUn+KU
         IKIvff6oZ3HOSg+aGH24EBC49Znhorr9h0aU1vmQrYEzuWTjqC5ggbc4lXGa3r0ePOGu
         yo17eZrVt/EetAgHZ7D65/LX6keHvzbMMPsgBMNYHhF0n+/PtVcEEBlRqH0Tg7YbmTHC
         dJ/hr7CsvgUXYzTqJAfpGHrMDCfXB9Ih35+Aibgx6P/DGuDtCh/KQ2S1YcUgCNbpa1jU
         ZCxg==
X-Forwarded-Encrypted: i=1; AJvYcCX0t+aycd2gi1kWQ+0cd3WUSFGAT0Vg0bs29I0Bji+VPntxWRMggYB1sCwx0pgKU1NmiIxRfQx3NoWw0ULRoxBhdq0iV3BdHJDrOpCP9EZadAXe7hKzixvI5+95UvOEsL5g
X-Gm-Message-State: AOJu0YwRs3XGRaaQBFDlal7m+u3JmhRQ1dJUEOX0PD4rYvuEaTfGMySo
	Nue8H1523632apJtBKKCetJDwfoZxWv2BQtx3s1UqBZ/JCMDwvh3yf0sbISbrn4zoEji/VkW90V
	+7K2iYkiEDbbhmNss4rT9/WxDa9Y=
X-Google-Smtp-Source: AGHT+IEUlO2zukqDSovYWf07rNVodK+7DJ9CthjKAroh1jaO14yZj9yENxACYznvsy5rK6d2wuYPvIevh8czG1Byig4=
X-Received: by 2002:a05:6808:22a5:b0:3bf:e45c:cd6 with SMTP id
 bo37-20020a05680822a500b003bfe45c0cd6mr8387192oib.26.1707353427806; Wed, 07
 Feb 2024 16:50:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707080349.git.dxu@dxuuu.xyz> <9b8ebd13300e28bd92a2e6de4fb04f85c1b6ce7c.1707080349.git.dxu@dxuuu.xyz>
In-Reply-To: <9b8ebd13300e28bd92a2e6de4fb04f85c1b6ce7c.1707080349.git.dxu@dxuuu.xyz>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Feb 2024 16:50:15 -0800
Message-ID: <CAEf4BzaSSTY0KTBYACvvVUeKVWd9wO+FM91E-9ES4dHwY-wX+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpftool: Support dumping kfunc prototypes
 from BTF
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: quentin@isovalent.com, daniel@iogearbox.net, ast@kernel.org, 
	andrii@kernel.org, olsajiri@gmail.com, alan.maguire@oracle.com, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 1:07=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This patch enables dumping kfunc prototypes from bpftool. This is useful
> b/c with this patch, end users will no longer have to manually define
> kfunc prototypes. For the kernel tree, this also means we can drop
> kfunc prototypes from:
>
>         tools/testing/selftests/bpf/bpf_kfuncs.h
>         tools/testing/selftests/bpf/bpf_experimental.h
>
> Example usage:
>
>         $ make PAHOLE=3D/home/dxu/dev/pahole/build/pahole -j30 vmlinux
>
>         $ ./tools/bpf/bpftool/bpftool btf dump file ./vmlinux format c | =
rg "__ksym;" | head -3
>         extern void cgroup_rstat_updated(struct cgroup *cgrp, int cpu) __=
weak __ksym;
>         extern void cgroup_rstat_flush(struct cgroup *cgrp) __weak __ksym=
;
>         extern struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)=
 __weak __ksym;
>
> Note that this patch is only effective after the enabling pahole [0]
> change is merged and the resulting feature enabled with
> --btf_features=3Ddecl_tag_kfuncs.
>
> [0]: https://lore.kernel.org/bpf/cover.1707071969.git.dxu@dxuuu.xyz/
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/bpf/bpftool/btf.c | 45 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 91fcb75babe3..0fd78a476286 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -20,6 +20,8 @@
>  #include "json_writer.h"
>  #include "main.h"
>
> +#define KFUNC_DECL_TAG         "bpf_kfunc"
> +
>  static const char * const btf_kind_str[NR_BTF_KINDS] =3D {
>         [BTF_KIND_UNKN]         =3D "UNKNOWN",
>         [BTF_KIND_INT]          =3D "INT",
> @@ -454,6 +456,39 @@ static int dump_btf_raw(const struct btf *btf,
>         return 0;
>  }
>
> +static int dump_btf_kfuncs(struct btf_dump *d, const struct btf *btf)
> +{
> +       DECLARE_LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts);

nit: use shorter LIBBPF_OPTS, DECLARE_LIBBPF_OPTS is a "deprecated"
macro name I hid, but didn't remove

> +       int cnt =3D btf__type_cnt(btf);
> +       int i;
> +
> +       for (i =3D 1; i < cnt; i++) {
> +               const struct btf_type *t =3D btf__type_by_id(btf, i);
> +               const struct btf_type *kft;
> +               const char *name;
> +               int err;
> +
> +               if (!btf_is_decl_tag(t))
> +                       continue;
> +
> +               name =3D btf__name_by_offset(btf, t->name_off);
> +               if (strncmp(name, KFUNC_DECL_TAG, sizeof(KFUNC_DECL_TAG))=
)
> +                       continue;

should we do a bit more sanity checking here? Check that component_idx
=3D -1 (entire func) and pointee type is FUNC?

> +
> +               printf("extern ");
> +
> +               kft =3D btf__type_by_id(btf, t->type);

nit: reuse t?

> +               opts.field_name =3D btf__name_by_offset(btf, kft->name_of=
f);
> +               err =3D btf_dump__emit_type_decl(d, kft->type, &opts);
> +               if (err)
> +                       return err;
> +
> +               printf(" __weak __ksym;\n\n");

why extra endline?

though I'd ensure two empty lines before the first kfunc declaration
to visually separate it from other type. Maybe even add a comment like
`/* BPF kfuncs */` or something like that?

> +       }
> +
> +       return 0;
> +}
> +
>  static void __printf(2, 0) btf_dump_printf(void *ctx,
>                                            const char *fmt, va_list args)
>  {
> @@ -476,6 +511,12 @@ static int dump_btf_c(const struct btf *btf,
>         printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
>         printf("#pragma clang attribute push (__attribute__((preserve_acc=
ess_index)), apply_to =3D record)\n");
>         printf("#endif\n\n");
> +       printf("#ifndef __ksym\n");
> +       printf("#define __ksym __attribute__((section(\".ksyms\")))\n");
> +       printf("#endif\n\n");
> +       printf("#ifndef __weak\n");
> +       printf("#define __weak __attribute__((weak))\n");
> +       printf("#endif\n\n");
>
>         if (root_type_cnt) {
>                 for (i =3D 0; i < root_type_cnt; i++) {
> @@ -491,6 +532,10 @@ static int dump_btf_c(const struct btf *btf,
>                         if (err)
>                                 goto done;
>                 }
> +
> +               err =3D dump_btf_kfuncs(d, btf);
> +               if (err)
> +                       goto done;
>         }
>
>         printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
> --
> 2.42.1
>

