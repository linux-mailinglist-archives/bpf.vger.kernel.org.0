Return-Path: <bpf+bounces-60613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58E6AD9333
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 18:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 236AE7B10C8
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078AD2153D4;
	Fri, 13 Jun 2025 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Siqo1lD2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BC1213E83;
	Fri, 13 Jun 2025 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833508; cv=none; b=td6Am0p/B8l9FhMLUMgFlnPw98oUJUX9DfSKhaNplmKk8a+0AbETRUWc7xH4tUav3/etI5mZgZMmflIMPTfoX5eWzewxau3FlBgrKQYP2xdjXHGjJPr4HKV9IKUV35i6xJ9evcQVIYUaKw+hDY9OJ2mfNAiqHokJNFC1yatBHGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833508; c=relaxed/simple;
	bh=PTrj3PGYBSiXZH65v/wOwyOSvwyWg/BIGlckLX9Awec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyYfjBqRXu6x4RyRsnVW/WpO/0yTUaV7ygQ4U832Hp8sqLoEkhWFP0pjJgrXS1g5nv5Kt2PgKUhprUMeknLYyyNd9eSp18Qg57y1epY82cz5gGxgWpQLtLOaiic38hKjGB8XbE3AFtJqPp8kJirvaPxiB0V2FT0prcaB8CCFTbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Siqo1lD2; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7487d2b524eso1303897b3a.0;
        Fri, 13 Jun 2025 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749833506; x=1750438306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgaZ0q289Nq8tK0lI3HpaPXgYh5tVi0FHv+Av0kmyp0=;
        b=Siqo1lD2woB9f1/hCLFy3fCst6NJaHL3EM3omzwRPN5/VSgA22OKGrUnZAvF/f1Yt3
         kfFe7VpqvEhnmPE1Iy4hNtiCiqGoTW2QwxHvOk/BQOfu/FahgZ6Le+lkBxL2IF9HPxrv
         LMDQgk+3MPGLeIw8uj2MBXihwNj7IW+4MMFelHQAitlfx+P/WHc4nlxmaIY5kGYaalJG
         Jzjas8GJkHajvLQpCpUmX11vNJU4xlMmjtm0HLaFh3xsrGY1YV0NBK6Shws5zYVYrIjF
         l+9IbaSjyt4zSHA14WOfK7/0BfTMeuCiIxIm0PL87E1kaoRbcztGBJCLwOTYQ515xpdA
         pxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749833506; x=1750438306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgaZ0q289Nq8tK0lI3HpaPXgYh5tVi0FHv+Av0kmyp0=;
        b=AVaZm2TjCEAEzbelDBQ7ZX3ozv1rajqpRRL0sioA3aR9T+ZMhJy9c3GTQMXgNTTfnt
         lEVtBO/DatQcjwzGvMEDGyMCvDrBZqrgQYacgIbFrDpksNESydJm52a/GqCYwjivtTRk
         VP90aQEYsAhOBylf2YS1EQ1jtCMEpbEnjKrWQfzGbThxCyML+yo9YFjZhJl04vUHtLuI
         N31/TSMdgXbWICKBKC70YImi/vzShEWJQni30IRCuPHcTxgBBKfbIwb0JErmTtf4fYOV
         wZEUrBufcn8LTikB85QosNxXdnXybnfai79jvgWRGEzWsOc+Uft7PLucsvF+UPGUCZ6y
         8cBw==
X-Forwarded-Encrypted: i=1; AJvYcCUTerFWFeANDXRCuqCYnO1gO8IPGrlfWgNI8LBPevlye/CVVT9VI+pkADyO3pqqQzhiQ/e8aPhUg/75/ysfXu0ARv2b/RY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4j5nsfn03eORfD71q8L8C7bCUSgrWVFoWRU49ccIsdYGBYJfr
	fmWjif7+UXoLqP3gXftBl0fNQkkWZ49z5m/PB2dN0tQ5PxBt7xK0w7TIxOF42L+QS5b7JJ9fFng
	JKexlzCaebQJ1leQAAudBWpcAiiUJspSKbjB/8fY=
X-Gm-Gg: ASbGncuB4kCsk+CsiGQRFJCAVIZYUv87sJjVGiU1Uf+A3UMHkQ/2awARER07emOqbYV
	wQTZp0vkm3gLswTcTtusdhcPkGpavw7eVhYn4GYKlk39g6ecW9V+WoADQ1aZ8T0xF3hYlyd0UOA
	E0Cf+Oarpt71aD105SVUKUDOpdoveU8NVzfIqujdlyRG7Z6ZDJUb5RYeOD4cI=
X-Google-Smtp-Source: AGHT+IHVmBC8j5dp/KpNY9DSGBiXfXoNreUv73Oc3fbNbUoSHsQlDfp/toJKq7RbbobHFg5VQB7cb7hsSC0F7zoQVic=
X-Received: by 2002:a05:6a20:e68d:b0:1f5:9069:e563 with SMTP id
 adf61e73a8af0-21fbd5f207cmr74535637.21.1749833506089; Fri, 13 Jun 2025
 09:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-6-kpsingh@kernel.org>
 <CAEf4BzYiWv9suM6PuyJuFaDiRUXZxOhy1_pBkHqZwGN+Nn=2Eg@mail.gmail.com> <CACYkzJ5PtcXCHB3vWTPJyOkUL+PuEH9cL1r66Hz=1wxrT3NEUg@mail.gmail.com>
In-Reply-To: <CACYkzJ5PtcXCHB3vWTPJyOkUL+PuEH9cL1r66Hz=1wxrT3NEUg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Jun 2025 09:51:32 -0700
X-Gm-Features: AX0GCFtcCSxSAh3DuySR-XgxMXXjqhhwCFo_95OsTVNPjJW_QxmuNYf-W4sE0yM
Message-ID: <CAEf4BzZghpnHaV+z2GYDNCApzLuxMW6_=4afgpO+D7AG-zTSFQ@mail.gmail.com>
Subject: Re: [PATCH 05/12] libbpf: Support exclusive map creation
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 4:42=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> On Fri, Jun 13, 2025 at 12:56=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> wr=
ote:
> > >
> > > Implement a convenient method i.e. bpf_map__make_exclusive which
> > > calculates the hash for the program and registers it with the map for
> > > creation as an exclusive map when the objects are loaded.
> > >
> > > The hash of the program must be computed after all the relocations ar=
e
> > > done.
> > >
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > ---
> > >  tools/lib/bpf/bpf.c            |  4 +-
> > >  tools/lib/bpf/bpf.h            |  4 +-
> > >  tools/lib/bpf/libbpf.c         | 68 ++++++++++++++++++++++++++++++++=
+-
> > >  tools/lib/bpf/libbpf.h         | 13 +++++++
> > >  tools/lib/bpf/libbpf.map       |  5 +++
> > >  tools/lib/bpf/libbpf_version.h |  2 +-
> > >  6 files changed, 92 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > > index a9c3e33d0f8a..11fa2d64ccca 100644
> > > --- a/tools/lib/bpf/bpf.c
> > > +++ b/tools/lib/bpf/bpf.c
> > > @@ -172,7 +172,7 @@ int bpf_map_create(enum bpf_map_type map_type,
> > >                    __u32 max_entries,
> > >                    const struct bpf_map_create_opts *opts)
> > >  {
> > > -       const size_t attr_sz =3D offsetofend(union bpf_attr, map_toke=
n_fd);
> > > +       const size_t attr_sz =3D offsetofend(union bpf_attr, excl_pro=
g_hash);
> > >         union bpf_attr attr;
> > >         int fd;
> > >
> > > @@ -203,6 +203,8 @@ int bpf_map_create(enum bpf_map_type map_type,
> > >         attr.map_ifindex =3D OPTS_GET(opts, map_ifindex, 0);
> > >
> > >         attr.map_token_fd =3D OPTS_GET(opts, token_fd, 0);
> > > +       attr.excl_prog_hash =3D ptr_to_u64(OPTS_GET(opts, excl_prog_h=
ash, NULL));
> > > +       attr.excl_prog_hash_size =3D OPTS_GET(opts, excl_prog_hash_si=
ze, 0);
> > >
> > >         fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> > >         return libbpf_err_errno(fd);
> > > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > > index 777627d33d25..a82b79c0c349 100644
> > > --- a/tools/lib/bpf/bpf.h
> > > +++ b/tools/lib/bpf/bpf.h
> > > @@ -54,9 +54,11 @@ struct bpf_map_create_opts {
> > >         __s32 value_type_btf_obj_fd;
> > >
> > >         __u32 token_fd;
> > > +       __u32 excl_prog_hash_size;
> > > +       const void *excl_prog_hash;
> > >         size_t :0;
> > >  };
> > > -#define bpf_map_create_opts__last_field token_fd
> > > +#define bpf_map_create_opts__last_field excl_prog_hash
> > >
> > >  LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
> > >                               const char *map_name,
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 475038d04cb4..17de756973f4 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -499,6 +499,7 @@ struct bpf_program {
> > >         __u32 line_info_rec_size;
> > >         __u32 line_info_cnt;
> > >         __u32 prog_flags;
> > > +       __u8  hash[SHA256_DIGEST_LENGTH];
> > >  };
> > >
> > >  struct bpf_struct_ops {
> > > @@ -578,6 +579,8 @@ struct bpf_map {
> > >         bool autocreate;
> > >         bool autoattach;
> > >         __u64 map_extra;
> > > +       const void *excl_prog_sha;
> > > +       __u32 excl_prog_sha_size;
> > >  };
> > >
> > >  enum extern_type {
> > > @@ -4485,6 +4488,43 @@ bpf_object__section_to_libbpf_map_type(const s=
truct bpf_object *obj, int shndx)
> > >         }
> > >  }
> > >
> > > +static int bpf_program__compute_hash(struct bpf_program *prog)
> > > +{
> > > +       struct bpf_insn *purged;
> > > +       bool was_ld_map;
> > > +       int i, err;
> > > +
> > > +       purged =3D calloc(1, BPF_INSN_SZ * prog->insns_cnt);
> > > +       if (!purged)
> > > +               return -ENOMEM;
> > > +
> > > +       /* If relocations have been done, the map_fd needs to be
> > > +        * discarded for the digest calculation.
> > > +        */
> >
> > all this looks sketchy, let's think about some more robust approach
> > here rather than randomly clearing some fields of some instructions...
>
> This is exactly what the kernel does:
>
> https://elixir.bootlin.com/linux/v6.15.1/source/kernel/bpf/core.c#L314
>
> We will need to update both, it does not clear them of instructions,
> it clears an immediate value that is the FD of the map which is
> unstable.

Looking at what libbpf is doing with relocations, we are missing the
case of src_reg =3D=3D BPF_PSEUDO_BTF_ID in which we are setting
insn[1].imm to kernel module BTF FD (so unstable value as well). So I
guess we should fix kernel-side logic there as well?


But overall, it's of course funny, because for a long while we've been
saying that calculating the signature/hash of a BPF program by masking
some parts of instructions (containing FDs and addresses) is not good
and not secure. Now we are doing exactly that to "predict" and define
which BPF program has exclusivity rights. This shouldn't be a problem
for lskel as BPF program code is supposed to be stable, but it feels
weird to do it as a general case.

>
> >
> > > +       for (i =3D 0, was_ld_map =3D false; i < prog->insns_cnt; i++)=
 {
> > > +               purged[i] =3D prog->insns[i];
> > > +               if (!was_ld_map &&
> > > +                   purged[i].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW)=
 &&
> > > +                   (purged[i].src_reg =3D=3D BPF_PSEUDO_MAP_FD ||
> > > +                    purged[i].src_reg =3D=3D BPF_PSEUDO_MAP_VALUE)) =
{
> > > +                       was_ld_map =3D true;
> > > +                       purged[i].imm =3D 0;
> > > +               } else if (was_ld_map && purged[i].code =3D=3D 0 &&
> > > +                          purged[i].dst_reg =3D=3D 0 && purged[i].sr=
c_reg =3D=3D 0 &&
> > > +                          purged[i].off =3D=3D 0) {
> > > +                       was_ld_map =3D false;
> > > +                       purged[i].imm =3D 0;
> > > +               } else {
> > > +                       was_ld_map =3D false;
> > > +               }
> > > +       }
> >
> > this was_ld_map business is... unnecessary? Just access purged[i + 1]
> > (checking i + 1 < prog->insns_cnt, of course), and i +=3D 1. This
> > stateful approach is an unnecessary complication, IMO
>
> Again, I did not do much here. Happy to make it better though.
>

I don't know why kernel code was written in this more stateful form,
but I find it much harder to follow, especially given that it's
trivial to handle two-instruction ldimm64 in one go. And both libbpf
and verifier code does handle ldimm64 as insn[0] and insn[1] parts at
the same time elsewhere (e.g., see resolve_pseudo_ldimm64()). So at
least for libbpf side, let's do a simpler implementation (I'd do it
for kernel code as well, but I'm not insisting).

[...]

> > > +       map->excl_prog_sha =3D prog->hash;
> > > +       map->excl_prog_sha_size =3D SHA256_DIGEST_LENGTH;
> >
> > this is a hack, I assume that's why you compute that hash for any
> > program all the time, right? Well, first, if this is called before
> > bpf_object_prepare(), it will silently do the wrong thing.
> >
> > But also I don't think we should calculate hash proactively, we could
> > do this lazily.
> >

So this bothered me and felt wrong. And I realized that you are doing
it at the wrong abstraction level here. Instead of trying to calculate
exclusivity hash in bpf_map__make_exclusive(), we should just record
`struct bpf_program *` pointer as an exclusive target bpf program. And
only calculate hash at map creation time where we know that the BPF
program has been relocated.

At that time we can also error out if bpf_program turned out to be
disabled to be loaded, etc.

I'd also call this a bit more like any other setter (and would add a
getter for completeness): bpf_map__set_exclusive_program() and
bpf_map__exclusive_program(). And I guess we can allow overwriting
exclusive program pointer, given this explicit setter semantics.

> > > +       return 0;
> > > +}
> > > +
> > > +
> > >  static struct bpf_map *
> > >  __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *ob=
j, int i)
> > >  {

[...]

