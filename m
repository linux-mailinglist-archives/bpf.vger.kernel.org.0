Return-Path: <bpf+bounces-63107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B51B02872
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 02:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353677BDE60
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 00:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097D3136658;
	Sat, 12 Jul 2025 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1kP1Gdd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E7F25760
	for <bpf@vger.kernel.org>; Sat, 12 Jul 2025 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281437; cv=none; b=Li28Aqplb33xdAe0sA2yjJRC5xHy5xGqW81tEypqGEhVZl0mIKPtBjqAIXP173FCwQbt6wdQHkXgIHJ3iNx1lTC0aerojYhFkPQ9ojX6D4ozMyAAPgzTpkWq1Bb1J+sIRbPrqRjnzRaYLendmllnvd3tvJ0zUrnIYlEZVOvCugg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281437; c=relaxed/simple;
	bh=3sRUhiPWJjILp/oVvMIDhZIFW1VfG6JAHnk1R6QKTys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Voj2TSVdy5AreHZEHaEMCllNL6KfzSwUr1EW5/HDwlyY0rujImJE1m9BMWLBclq/7rqzLDRvN19Ru+Iin5xSPGnb8wl+A16Fq30p7ZQZa2wqWV21rbGKVP1f96XMdvB06UHRMGLvu87TnEDZs9GXPKv1TCQSO5iqqX3ZrOQ1QiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1kP1Gdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D6EC4CEED
	for <bpf@vger.kernel.org>; Sat, 12 Jul 2025 00:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752281436;
	bh=3sRUhiPWJjILp/oVvMIDhZIFW1VfG6JAHnk1R6QKTys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F1kP1Gddry7LHxfWYkK00bWIGmcpHwKa3qOLO6CY2ieiWfXG6CuR8omeX4MCw/zkx
	 6DotnIt6zR1sD3RO43QKrb4P6uDbhod8TAGGdk81uaYfJGkDuvLcQPBlNQC18D+ID5
	 nP7K4cS3jKVWx6qfxUcbN7Jtq8o59wRuMhp42tXJwC4Yk/Dnbjy21/GoQ5s5NFtEme
	 ZDWxZ4DOh4aUtQRhbTG60+Un2sGc0gQ2kiOz9MOHwkBOApE+blh4hBkOe5nIuIZrL3
	 S3QDyOX2ONJi7XI5+WFlAq303EzTQBkvGpooCCGnGDpnG9tHKbtjVI6fohDdI3/QP5
	 +zoRvkr76VzAg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so5164876a12.3
        for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 17:50:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YwoZIlDL8IV87uwxtR1XKTRv8GxP+PAHuaP+TW7SNjtwdA07KqB
	5XNDBHY/RgwEBGG7ZCVIPfRx1hSqhgUWNRr2REOogNx9xmqHH453QOSh0r5loCwfmfbKgAmuu6B
	qLcbe17tx3c6F6lSvptC12FeQmobIMWVclCTb5rWK
X-Google-Smtp-Source: AGHT+IGa/4mXAZ4xtTVDS8Vqd1Huao5hKl32xz1yeoucnoThOnX1ZQddZnKMx5cZBTCEQ38obb3R8lfCW4sqYyB7VII=
X-Received: by 2002:a05:6402:20c9:b0:607:f257:ad1e with SMTP id
 4fb4d7f45d1cf-611e84ad4e9mr3251869a12.22.1752281434445; Fri, 11 Jul 2025
 17:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-6-kpsingh@kernel.org>
 <CAEf4BzYiWv9suM6PuyJuFaDiRUXZxOhy1_pBkHqZwGN+Nn=2Eg@mail.gmail.com>
 <CACYkzJ5PtcXCHB3vWTPJyOkUL+PuEH9cL1r66Hz=1wxrT3NEUg@mail.gmail.com> <CAEf4BzZghpnHaV+z2GYDNCApzLuxMW6_=4afgpO+D7AG-zTSFQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZghpnHaV+z2GYDNCApzLuxMW6_=4afgpO+D7AG-zTSFQ@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Sat, 12 Jul 2025 02:50:23 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5gwT-f0vUYvMOwG4jZKZeP_iFMKH8=aEKx8CRB-W07cA@mail.gmail.com>
X-Gm-Features: Ac12FXwDvI5eMnt5p9x30lKAqU7hE8D-bPZ7W0Vjc2quP2t7Qd-oU_jCAo9Jdzs
Message-ID: <CACYkzJ5gwT-f0vUYvMOwG4jZKZeP_iFMKH8=aEKx8CRB-W07cA@mail.gmail.com>
Subject: Re: [PATCH 05/12] libbpf: Support exclusive map creation
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 6:51=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jun 12, 2025 at 4:42=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> >
> > On Fri, Jun 13, 2025 at 12:56=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> =
wrote:
> > > >
> > > > Implement a convenient method i.e. bpf_map__make_exclusive which
> > > > calculates the hash for the program and registers it with the map f=
or
> > > > creation as an exclusive map when the objects are loaded.
> > > >
> > > > The hash of the program must be computed after all the relocations =
are
> > > > done.
> > > >
> > > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > > ---
> > > >  tools/lib/bpf/bpf.c            |  4 +-
> > > >  tools/lib/bpf/bpf.h            |  4 +-
> > > >  tools/lib/bpf/libbpf.c         | 68 ++++++++++++++++++++++++++++++=
+++-
> > > >  tools/lib/bpf/libbpf.h         | 13 +++++++
> > > >  tools/lib/bpf/libbpf.map       |  5 +++
> > > >  tools/lib/bpf/libbpf_version.h |  2 +-
> > > >  6 files changed, 92 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > > > index a9c3e33d0f8a..11fa2d64ccca 100644
> > > > --- a/tools/lib/bpf/bpf.c
> > > > +++ b/tools/lib/bpf/bpf.c
> > > > @@ -172,7 +172,7 @@ int bpf_map_create(enum bpf_map_type map_type,
> > > >                    __u32 max_entries,
> > > >                    const struct bpf_map_create_opts *opts)
> > > >  {
> > > > -       const size_t attr_sz =3D offsetofend(union bpf_attr, map_to=
ken_fd);
> > > > +       const size_t attr_sz =3D offsetofend(union bpf_attr, excl_p=
rog_hash);
> > > >         union bpf_attr attr;
> > > >         int fd;
> > > >
> > > > @@ -203,6 +203,8 @@ int bpf_map_create(enum bpf_map_type map_type,
> > > >         attr.map_ifindex =3D OPTS_GET(opts, map_ifindex, 0);
> > > >
> > > >         attr.map_token_fd =3D OPTS_GET(opts, token_fd, 0);
> > > > +       attr.excl_prog_hash =3D ptr_to_u64(OPTS_GET(opts, excl_prog=
_hash, NULL));
> > > > +       attr.excl_prog_hash_size =3D OPTS_GET(opts, excl_prog_hash_=
size, 0);
> > > >
> > > >         fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> > > >         return libbpf_err_errno(fd);
> > > > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > > > index 777627d33d25..a82b79c0c349 100644
> > > > --- a/tools/lib/bpf/bpf.h
> > > > +++ b/tools/lib/bpf/bpf.h
> > > > @@ -54,9 +54,11 @@ struct bpf_map_create_opts {
> > > >         __s32 value_type_btf_obj_fd;
> > > >
> > > >         __u32 token_fd;
> > > > +       __u32 excl_prog_hash_size;
> > > > +       const void *excl_prog_hash;
> > > >         size_t :0;
> > > >  };
> > > > -#define bpf_map_create_opts__last_field token_fd
> > > > +#define bpf_map_create_opts__last_field excl_prog_hash
> > > >
> > > >  LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
> > > >                               const char *map_name,
> > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > index 475038d04cb4..17de756973f4 100644
> > > > --- a/tools/lib/bpf/libbpf.c
> > > > +++ b/tools/lib/bpf/libbpf.c
> > > > @@ -499,6 +499,7 @@ struct bpf_program {
> > > >         __u32 line_info_rec_size;
> > > >         __u32 line_info_cnt;
> > > >         __u32 prog_flags;
> > > > +       __u8  hash[SHA256_DIGEST_LENGTH];
> > > >  };
> > > >
> > > >  struct bpf_struct_ops {
> > > > @@ -578,6 +579,8 @@ struct bpf_map {
> > > >         bool autocreate;
> > > >         bool autoattach;
> > > >         __u64 map_extra;
> > > > +       const void *excl_prog_sha;
> > > > +       __u32 excl_prog_sha_size;
> > > >  };
> > > >
> > > >  enum extern_type {
> > > > @@ -4485,6 +4488,43 @@ bpf_object__section_to_libbpf_map_type(const=
 struct bpf_object *obj, int shndx)
> > > >         }
> > > >  }
> > > >
> > > > +static int bpf_program__compute_hash(struct bpf_program *prog)
> > > > +{
> > > > +       struct bpf_insn *purged;
> > > > +       bool was_ld_map;
> > > > +       int i, err;
> > > > +
> > > > +       purged =3D calloc(1, BPF_INSN_SZ * prog->insns_cnt);
> > > > +       if (!purged)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       /* If relocations have been done, the map_fd needs to be
> > > > +        * discarded for the digest calculation.
> > > > +        */
> > >
> > > all this looks sketchy, let's think about some more robust approach
> > > here rather than randomly clearing some fields of some instructions..=
.
> >
> > This is exactly what the kernel does:
> >
> > https://elixir.bootlin.com/linux/v6.15.1/source/kernel/bpf/core.c#L314
> >
> > We will need to update both, it does not clear them of instructions,
> > it clears an immediate value that is the FD of the map which is
> > unstable.
>
> Looking at what libbpf is doing with relocations, we are missing the
> case of src_reg =3D=3D BPF_PSEUDO_BTF_ID in which we are setting
> insn[1].imm to kernel module BTF FD (so unstable value as well). So I
> guess we should fix kernel-side logic there as well?

One can consider a magic number here, although really zero is fine.
It's an  unstable parameter and It just means that the signature does
not attest to this value that is obtained because it is obtained at
runtime.

>
>
> But overall, it's of course funny, because for a long while we've been
> saying that calculating the signature/hash of a BPF program by masking
> some parts of instructions (containing FDs and addresses) is not good
> and not secure. Now we are doing exactly that to "predict" and define
> which BPF program has exclusivity rights. This shouldn't be a problem
> for lskel as BPF program code is supposed to be stable, but it feels
> weird to do it as a general case.
>
> >
> > >
> > > > +       for (i =3D 0, was_ld_map =3D false; i < prog->insns_cnt; i+=
+) {
> > > > +               purged[i] =3D prog->insns[i];
> > > > +               if (!was_ld_map &&
> > > > +                   purged[i].code =3D=3D (BPF_LD | BPF_IMM | BPF_D=
W) &&
> > > > +                   (purged[i].src_reg =3D=3D BPF_PSEUDO_MAP_FD ||
> > > > +                    purged[i].src_reg =3D=3D BPF_PSEUDO_MAP_VALUE)=
) {
> > > > +                       was_ld_map =3D true;
> > > > +                       purged[i].imm =3D 0;
> > > > +               } else if (was_ld_map && purged[i].code =3D=3D 0 &&
> > > > +                          purged[i].dst_reg =3D=3D 0 && purged[i].=
src_reg =3D=3D 0 &&
> > > > +                          purged[i].off =3D=3D 0) {
> > > > +                       was_ld_map =3D false;
> > > > +                       purged[i].imm =3D 0;
> > > > +               } else {
> > > > +                       was_ld_map =3D false;
> > > > +               }
> > > > +       }
> > >
> > > this was_ld_map business is... unnecessary? Just access purged[i + 1]
> > > (checking i + 1 < prog->insns_cnt, of course), and i +=3D 1. This
> > > stateful approach is an unnecessary complication, IMO
> >
> > Again, I did not do much here. Happy to make it better though.
> >
>
> I don't know why kernel code was written in this more stateful form,
> but I find it much harder to follow, especially given that it's
> trivial to handle two-instruction ldimm64 in one go. And both libbpf
> and verifier code does handle ldimm64 as insn[0] and insn[1] parts at
> the same time elsewhere (e.g., see resolve_pseudo_ldimm64()). So at
> least for libbpf side, let's do a simpler implementation (I'd do it
> for kernel code as well, but I'm not insisting).
>
> [...]
>
> > > > +       map->excl_prog_sha =3D prog->hash;
> > > > +       map->excl_prog_sha_size =3D SHA256_DIGEST_LENGTH;
> > >
> > > this is a hack, I assume that's why you compute that hash for any
> > > program all the time, right? Well, first, if this is called before
> > > bpf_object_prepare(), it will silently do the wrong thing.
> > >
> > > But also I don't think we should calculate hash proactively, we could
> > > do this lazily.
> > >
>
> So this bothered me and felt wrong. And I realized that you are doing
> it at the wrong abstraction level here. Instead of trying to calculate
> exclusivity hash in bpf_map__make_exclusive(), we should just record
> `struct bpf_program *` pointer as an exclusive target bpf program. And
> only calculate hash at map creation time where we know that the BPF
> program has been relocated.
>
> At that time we can also error out if bpf_program turned out to be
> disabled to be loaded, etc.
>
> I'd also call this a bit more like any other setter (and would add a
> getter for completeness): bpf_map__set_exclusive_program() and
> bpf_map__exclusive_program(). And I guess we can allow overwriting
> exclusive program pointer, given this explicit setter semantics.
>
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +
> > > >  static struct bpf_map *
> > > >  __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *=
obj, int i)
> > > >  {
>
> [...]

