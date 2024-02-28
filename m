Return-Path: <bpf+bounces-22954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8173386BC30
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52BB1C22DA3
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAD316423;
	Wed, 28 Feb 2024 23:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEHJ4o0o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D684613D311
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 23:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162908; cv=none; b=nRqQLBXVt80uZPrz7B86KAFjcIpYEny+l8IvtQJJsaLdaCXWPvMGhz3chR5M5ybzKBB6UL/g9Bv/1SKHJ61wJUM0FFSVbn9eAbFEzJ56rBhOavaIbgYl6uV7klRZy+ds/XWEU0M1o9Hl/eFxzGTPtvOGjRTFQlSllpFfc9Rzwh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162908; c=relaxed/simple;
	bh=BLzI/0negtTF1k9smmyoXWED3Uo2ckgKHAX+cy+qty8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SneStqKLJ/cKTPQRMSQyURLie5bQyp6s9xHyQxG0tz09sbNnYFAg0kjTlw2K2TL3FF96cucVhUU7a+sX7mMwAZccsLrcyuTxXBzDbkmt1GcDVQSXwSyJpodyoxvPTkkrPSVqc/e557fo270F9gRe0YzHO1j0hTTcBiQOQExMovI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEHJ4o0o; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc1ff58fe4so3426325ad.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 15:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709162906; x=1709767706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puLhld6QZfR0YeXkAnWtz/y8eEJxAWcIYLM3kTkEbM8=;
        b=FEHJ4o0oILYSLLKSRluQdaBnvBfbCJrOryfY7uP9mc4TWiek4LJCtu+eTtPEP2vq8G
         Bi2MQOvcVd5UDd/+rFmr5EtRTGvLlnz96P7p/PeT7/8xhRs1eV1IQT2krHDVm9Aat9wJ
         k2QmdW5/64BaOS4FkvYLD6CVfSZ0P84us1UssEP1oL6iv+gVr2iZpSR+hv1Xd5MtfTlM
         QMh/LcuPWZj1V/Rp0ECYbfnerwCQqORMovPzpt+v9CRzK9Fdtj2L4820iiYzVVqBQk7r
         VybqXhch7xCxCc/OUIRiPPJbanqH7efm6hKrB1vWK4GN0l42mxifD20QTblN6SrgfIWa
         30fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709162906; x=1709767706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puLhld6QZfR0YeXkAnWtz/y8eEJxAWcIYLM3kTkEbM8=;
        b=INJrYE5z0QfOgC2nKFYPWFYWzqbt2dv5CbCPXaenOqRbDQnsZ0caRX3WHMtAdQkfMy
         L2OnUb2pd3mSQ0yEEEEAkhv7YwIejdu6EdW631Qi1PGcygUQxX6nJVkfi9S+N7KNdbXm
         rzs0Hcmo/iUo32xHAsPba/2amaL/SpyGAaAC835B0/AwESp68SSq3LnzraavEkjeITDB
         qw1vfT2ANAM03/i0VizTbPGOK5OhcXV2wpk8R25NZc5eoEc4Qsz3DOdlKFaOUXzhirt+
         1+3NQM+lpcGXpZ8QFyNLmzdBLs6sgpY8YaDKSEYWYohMO3i/LOB3S+OdjGM0wErkL9Wl
         URMg==
X-Gm-Message-State: AOJu0Yy61hxxOLxDrC7QpChqvrsAEk3ZlHYsLlr8FtMQW6TZZKNDcC6s
	e1yb2CUnBhiKMiQ6N4SzFknRxfhgPD+cpTzRWoHko4c7e6kgbKB38T6PRRU3tq0yLzKJi50K81L
	FH4HmqwWoV5F5tBSmC4juFKum1strjOLi
X-Google-Smtp-Source: AGHT+IFY/FGI3d97obTeqeOTq9XQuVBmKQjt+dLg+pulidaFXR3ZBN4W0QqRFY8IzTdvb41I/3ucMvycYlaUkHVth48=
X-Received: by 2002:a17:902:7845:b0:1dc:30d7:ff37 with SMTP id
 e5-20020a170902784500b001dc30d7ff37mr368170pln.42.1709162906268; Wed, 28 Feb
 2024 15:28:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227204556.17524-1-eddyz87@gmail.com> <20240227204556.17524-3-eddyz87@gmail.com>
In-Reply-To: <20240227204556.17524-3-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 15:28:14 -0800
Message-ID: <CAEf4BzZL3+g0cN9swTGkH4bZgSFm-McUAyYnpcKLTPMENnW9qw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/8] libbpf: tie struct_ops programs to kernel
 BTF ids, not to local ids
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 12:46=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> Enforce the following existing limitation on struct_ops programs based
> on kernel BTF id instead of program-local BTF id:
>
>     struct_ops BPF prog can be re-used between multiple .struct_ops &
>     .struct_ops.link as long as it's the same struct_ops struct
>     definition and the same function pointer field
>
> This allows reusing same BPF program for versioned struct_ops map
> definitions, e.g.:
>
>     SEC("struct_ops/test")
>     int BPF_PROG(foo) { ... }
>
>     struct some_ops___v1 { int (*test)(void); };
>     struct some_ops___v2 { int (*test)(void); };
>
>     SEC(".struct_ops.link") struct some_ops___v1 a =3D { .test =3D foo }
>     SEC(".struct_ops.link") struct some_ops___v2 b =3D { .test =3D foo }
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 44 ++++++++++++++++++++----------------------
>  1 file changed, 21 insertions(+), 23 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index abe663927013..c239b75d5816 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1134,8 +1134,27 @@ static int bpf_map__init_kern_struct_ops(struct bp=
f_map *map)
>
>                         if (mod_btf)
>                                 prog->attach_btf_obj_fd =3D mod_btf->fd;
> -                       prog->attach_btf_id =3D kern_type_id;
> -                       prog->expected_attach_type =3D kern_member_idx;
> +
> +                       /* if we haven't yet processed this BPF program, =
record proper
> +                        * attach_btf_id and member_idx
> +                        */
> +                       if (!prog->attach_btf_id) {
> +                               prog->attach_btf_id =3D kern_type_id;
> +                               prog->expected_attach_type =3D kern_membe=
r_idx;
> +                       }
> +
> +                       /* struct_ops BPF prog can be re-used between mul=
tiple
> +                        * .struct_ops & .struct_ops.link as long as it's=
 the
> +                        * same struct_ops struct definition and the same
> +                        * function pointer field
> +                        */
> +                       if (prog->attach_btf_id !=3D kern_type_id ||
> +                           prog->expected_attach_type !=3D kern_member_i=
dx) {
> +                               pr_warn("struct_ops reloc %s: cannot use =
prog %s in sec %s with type %u attach_btf_id %u expected_attach_type %u for=
 func ptr %s\n",

Martin already pointed out s/reloc/init_kern/, but I also find "cannot
use prog" a bit too unactionable. Maybe "invalid reuse of prog"?
"reuse" is the key here to point out that this program is used at
least twice, and that in some incompatible way?

> +                                       map->name, prog->name, prog->sec_=
name, prog->type,
> +                                       prog->attach_btf_id, prog->expect=
ed_attach_type, mname);
> +                               return -EINVAL;
> +                       }
>
>                         st_ops->kern_func_off[i] =3D kern_data_off + kern=
_moff;
>
> @@ -9409,27 +9428,6 @@ static int bpf_object__collect_st_ops_relos(struct=
 bpf_object *obj,
>                         return -EINVAL;
>                 }
>
> -               /* if we haven't yet processed this BPF program, record p=
roper
> -                * attach_btf_id and member_idx
> -                */
> -               if (!prog->attach_btf_id) {
> -                       prog->attach_btf_id =3D st_ops->type_id;
> -                       prog->expected_attach_type =3D member_idx;
> -               }
> -
> -               /* struct_ops BPF prog can be re-used between multiple
> -                * .struct_ops & .struct_ops.link as long as it's the
> -                * same struct_ops struct definition and the same
> -                * function pointer field
> -                */
> -               if (prog->attach_btf_id !=3D st_ops->type_id ||
> -                   prog->expected_attach_type !=3D member_idx) {
> -                       pr_warn("struct_ops reloc %s: cannot use prog %s =
in sec %s with type %u attach_btf_id %u expected_attach_type %u for func pt=
r %s\n",
> -                               map->name, prog->name, prog->sec_name, pr=
og->type,
> -                               prog->attach_btf_id, prog->expected_attac=
h_type, name);
> -                       return -EINVAL;
> -               }
> -
>                 st_ops->progs[member_idx] =3D prog;
>         }
>
> --
> 2.43.0
>

