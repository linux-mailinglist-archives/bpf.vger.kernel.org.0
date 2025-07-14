Return-Path: <bpf+bounces-63256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3B8B0491B
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 23:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D492A3AD514
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 21:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AFE25A33E;
	Mon, 14 Jul 2025 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBMvBztC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B043323AB87;
	Mon, 14 Jul 2025 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752527152; cv=none; b=IPiUyy6Qti0SyHT21vSFI3PAnDYOMFGN2893WUzwIqAXCSHWQVal6ooXU/L9HwchcITVoU3MAlo42pUbqRepbnuK+6R24tt1tu4OBq+LG/2WQ1tlQryUSBTVL4tGgW+qrqWfCJbfVYZOP/mjjGYx88RI+cdGT62/9KVEunCLFT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752527152; c=relaxed/simple;
	bh=NusgdEidmqg7WdLyA3nBpIQMXLCY2DEchKW9L6Su5k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ai9hHRbVMPjcvJwlRl/sGu0JPqOPFgarIwZpfyiL36iGwOUfkBrOBn8xE96Z5INEtcY7MuEIFV+oU08yrMHDiOsJTuSl6W5UjA9P1CJIw6GTxWlHIP4LbUJCN8HJu/gvClA1M7lo9BejrUAjnlkOjtE1DPzDhDB1GFohgrXNXIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBMvBztC; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso5267086a91.0;
        Mon, 14 Jul 2025 14:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752527150; x=1753131950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjbOZUP2p87+AFpsykpDIoA3T27NYccoxH/LzMqLX/8=;
        b=BBMvBztC04Ken0GqVH1f0T8KwS4f9ox8aX9EGcmKefkYOUdrQEXVIUMRzr0tjEJ1YQ
         zTIGvXki1Gk7U+PgybNANoIAu81/9j65iEz3S8tfB4ZJAu0CHglBTSMwiK3mbGKVG0po
         DEAxoBPZ0xbJscWD5qKZ4YFx5Dcxf90SHiWOkMwsUtKQqYMph1zQySrtSCE1OxC9MTzS
         +IXrCa6y4TOw5fZPhpBpF/bdEpGDVQ9QNYpKdBtAqJugWBDqZl1iQDpKkeqBbwnvKCUY
         nqpC1KAfglTWrYHxqWV2xPKqS0ZhZJy3eJ0AyNZrO4kYuy6v73jay5yswWDsd/Ozjamf
         6gdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752527150; x=1753131950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjbOZUP2p87+AFpsykpDIoA3T27NYccoxH/LzMqLX/8=;
        b=g/rjnOVTgccZjiPyP54fOH2zTuzrSjaz9QMARzjUdBzShNrh0sHYZApJp4HT75BrYt
         Euht35bsjQgwFXJ8p+8JjIvUm+igpDrvqEOTSxquPhTfVop65IS8B4sVRnfrc+0hn4cf
         eAZsfNbjjvHzVCjt4FNOISDeNkWbJgfaAWBgsfEoLpL+GVAjjURe150wdn9w9DPDyWm9
         BU47dP6kJc/oVuJhV+OG41hrmPGBp0JKDCCSJz+4AyVOY30aabaWndaGB246t8Zg3aWl
         L4OVa99EbDotTmCp1m3ZJRM7bRKIOgOEBJ6v6tCFuqBa7UpKEh6EVrzw66EP1/koG02F
         0ACQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLAjCkCqyjbBKVxqL+og7SVWIJfWLwIgM7HOIb1A27T5BmPvGPC9AH+We8k7iA6nfRgNr/yDUHAsN09nGQ7is8Quahyq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUjmjNl/i2/QBYRohYBWbUkq4ni251nNsBeTqajUBZdUxQQudY
	uYGaCrm1XckF8GlzDyp1DNZwIp7p6N8dqEhHVPs+cjRA2PBRu1+ZHOpirdtYczGJH+mAEQAHd/B
	sluefLIfYFEKeAnYdb66VwiG1n1T1c10=
X-Gm-Gg: ASbGncun+Lw1G8P1TTDWt7F+p8n800iFIG7Fc0SsBE3Ynt4/dVY6OUPr+MrYL+Z9w9y
	kI+NcrWhmxYoDrwbW//+kkVGf/JAHv59CFFfVOZJgzC5Jo7LZYz4avzli++4SwlEXIn1uIS0D2I
	qUEvostQoMdTpaqskFuWlrvZBF+P3zaTTRqmYl4PKNmqZO9lYNGvLPsqqsta4puJcwUIRloipgK
	DOQ8/EKLdqC4DNBpN09AYE=
X-Google-Smtp-Source: AGHT+IF0eemj59tu5WQxp9B7wK4lrZ/MFsXjYqjmK+pUqG5vzb6SjNxEhzxwFmuLF/36YG+KOmdD4Txr1V1SceZxdKY=
X-Received: by 2002:a17:90a:d610:b0:313:fb08:4261 with SMTP id
 98e67ed59e1d1-31c4cd55c4cmr21017440a91.32.1752527149792; Mon, 14 Jul 2025
 14:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-6-kpsingh@kernel.org>
 <CAEf4BzYiWv9suM6PuyJuFaDiRUXZxOhy1_pBkHqZwGN+Nn=2Eg@mail.gmail.com>
 <CACYkzJ4qs=CuKxjLkqqt+UeFTgqsqT9NvX_33C5QYGHry6femg@mail.gmail.com> <CACYkzJ6d6=mftCjCDw=cWOZqj87Asv7LNL_wyF=KeCjU=vSE4g@mail.gmail.com>
In-Reply-To: <CACYkzJ6d6=mftCjCDw=cWOZqj87Asv7LNL_wyF=KeCjU=vSE4g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 14 Jul 2025 14:05:34 -0700
X-Gm-Features: Ac12FXwmolxB6HyYYRdL65YaqZvyfUl4479ldpgWhqX5OQ21shua_llwYFXpcgo
Message-ID: <CAEf4BzYtU2VCJfW+P=1Wj7hxOW+Up6jWCTJ-YPs6jLL05JzMGQ@mail.gmail.com>
Subject: Re: [PATCH 05/12] libbpf: Support exclusive map creation
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 5:55=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote=
:
>
> On Mon, Jul 14, 2025 at 2:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
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
> > Does this look better to you, the next instruction has to be the
> > second half of the double word right?
> >
> > for (int i =3D 0; i < prog->insns_cnt; i++) {
> >     purged[i] =3D prog->insns[i];
> >     if (purged[i].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &&
> >         (purged[i].src_reg =3D=3D BPF_PSEUDO_MAP_FD ||
> >          purged[i].src_reg =3D=3D BPF_PSEUDO_MAP_VALUE)) {
> >         purged[i].imm =3D 0;
> >         i++;
> >         if (i >=3D prog->insns_cnt ||
> >             prog->insns[i].code !=3D 0 ||
> >             prog->insns[i].dst_reg !=3D 0 ||
> >             prog->insns[i].src_reg !=3D 0 ||
> >             prog->insns[i].off !=3D 0) {
> >             return -EINVAL;
> >         }
>
> I mean ofcourse
>
> err =3D -EINVAL;
> goto out;
>
> to free the buffer.


Yes, but I'd probably modify it a bit for conciseness:

struct bpf_insn *purged, *insn;
int i;

purged =3D calloc(..);
memcpy(purged, prog->insns, ...);

for (i =3D 0; i < prog->insns_cnt; i++) {
    insn =3D &purged[i];
    if (insn[0].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &&
        (insn[0].src_reg =3D=3D BPF_PSEUDO_MAP_FD || ...) {
        insn[0].imm =3D 0;
        if (i >=3D prog_insns_cnt) {
            err =3D -EINVAL;
            goto err;
        }
        insn[1].imm =3D 0;
        i++;
}


(I'm not sure libbpf needs to check code,dst_reg,src_reg,off for
ldimm64, verifier will do it anyways, so I'd protect against
out-of-bounds access only)

I'd even consider just doing:

if (i + 1 < prog->insns_cnt && insn[0].code =3D=3D (BPF_LD | BPF_IMM |
BPF_DW) ...) {
    insn[0].imm =3D 0;
    insn[1].imm =3D 0;
    i++;
}


i.e., don't even error out, verifier will do that anyway later because
program is malformed, and hash won't even matter at that point

[...]

