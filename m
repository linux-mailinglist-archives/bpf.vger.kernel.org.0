Return-Path: <bpf+bounces-28279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C10638B7F1D
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 19:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4AD41C2340A
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 17:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25231180A9C;
	Tue, 30 Apr 2024 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZgCtj0n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBB3180A74
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498889; cv=none; b=ZkO0kBzqtCyJ4IEW/pojFHnDyBY62hvA8ZxOMKkzWd1Nhz61BwVHZpEb3gvaVxjIlOCbI2jDPw0Tpt8yUcPuzp/CYYqkLX0yhz98bir5ic5JlvdOxmwbnzN9EdgbwFotNJB1qWHyNCgMOolgckeuo77OlxmqRbzrba8I/7wnBEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498889; c=relaxed/simple;
	bh=lWkPiPATGzdg5bw/iM/O4a8HQIl3S6ddW1MRXltpcS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUe/BRripomxeyL3ns+HjlKXljedsigDtcw9x9KVe8K5floUFnCxMYseyyyzpLjk+yEYjNIF+6iUFaINIKQQLNmrATi07I1ibL+tPcRYFGQ7lT9VDh6OCdVCwXXLOkSv6p+jdyNVhHV+2bEYC3bFcxw//gr5O9Xpg1Zqd0L+j8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZgCtj0n; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dca1efad59so4265386a12.2
        for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 10:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714498887; x=1715103687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1joj3ibdZCwFqc7zRgoQW4vhIuQnuhYIxqvky1cSNg=;
        b=JZgCtj0nzKT0PGH90q9pT94ediOYolimBbb7vfkQH71AWwbSC24engC1VzSdsoZ1fs
         eYnLExbcJoSF+8xynE8IjFc8IgqMrrH2r2V1il5GrwDWBlW9RAteaFPJtkDnvH24/QfW
         Tzvx3FH/9fNU1aiXN4EXfFp2953YhztYPfzLnp+Ui1Xzqklrob4TWr3KNgrsllD82p34
         DzExpqa5yckXGZyMu6v+ksZ8+313N+Z5aYg2WYzBn076qpRukGbVJb6vwR20kzwAlZct
         +T4p9nM1VIYmwoRSpoJfO9I7uu3+KWRk+EjA+17RPbb9l/MIU5W/QKHEA/Ciw8fTyLZJ
         kCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498887; x=1715103687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1joj3ibdZCwFqc7zRgoQW4vhIuQnuhYIxqvky1cSNg=;
        b=GdZ19IvTLV9qxpEFmcdskOlw7nu29yn3Ebix6QqjyXKf0L4ldW3g4ACMug2eN8Di24
         Msra81yvdev6H2bOwwyJYwn9NHfc1OQ8Zl2sRkDDaRs36uVnrtamoLmN5fQAFp2meHDU
         SMT72+b+GRK2Sm5KpT4yeRqIXD3fM9c3PzSjg5A1pI+HUz/oKeoJy29OkW5ZNwAGmdBJ
         VLfSaB9QYV8qF2/7ss5Dm5jhq5FizBcHCVEliODe6OAfxcJdL/rToP1l0cO8jnUwDYOW
         zvztJO7RvKmXZ0SdxWbAYOH1JaWptJt2lwuUhlP3WACuU6/mpA5Y2AaBejJF/ipHIdNF
         OcRw==
X-Forwarded-Encrypted: i=1; AJvYcCWOPej4+I4vWvZLW3ek6rZ2rmtlakWCSi04bdMEar20YgpxSVeqiPSoZvxmKcgUu2dThwC++9QtHVeGPltN5p5iUwbD
X-Gm-Message-State: AOJu0Yz14wBr0NOEjt3bLdcV3+joFmy2qPic7oVjU927c1hl3qUe5CQL
	3n9XuqClrQxZp4kHp2hSQMhZv1HeOfSDRxvk4WvmWBFVHkDchqL0+rN6zowE95jfHwvRpwmfav/
	QtrJ3Y7ZbPJ2GKoM7TS+dpZRnq6E=
X-Google-Smtp-Source: AGHT+IGIxV3SR4hk2BUBd0NgvS2NY7oI58peGeLGA5r509xYJpDfUh/CB9fPYWTaXp+W9iXZOcpqsmTy4FpXMYdIzvI=
X-Received: by 2002:a17:90a:e2ce:b0:2b2:32c2:44b4 with SMTP id
 fr14-20020a17090ae2ce00b002b232c244b4mr208986pjb.10.1714498886840; Tue, 30
 Apr 2024 10:41:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
 <20240424154806.3417662-10-alan.maguire@oracle.com> <CAEf4BzYr8ONqLuH0q+FFJijx3ADrqn464pf8E4A3s+uJ03cyVQ@mail.gmail.com>
 <8483cbf7-6729-471c-8aa8-f88c9e306fe5@oracle.com>
In-Reply-To: <8483cbf7-6729-471c-8aa8-f88c9e306fe5@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 Apr 2024 10:41:14 -0700
Message-ID: <CAEf4BzYnw3n_qHGCBGPxYw1Q1S8d+uF62MybJakgcAG9=CF-Bw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 09/13] libbpf: split BTF relocation
To: Alan Maguire <alan.maguire@oracle.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 9:57=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 30/04/2024 01:14, Andrii Nakryiko wrote:
> > On Wed, Apr 24, 2024 at 8:49=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> Map distilled base BTF type ids referenced in split BTF and their
> >> references to the base BTF passed in, and if the mapping succeeds,
> >> reparent the split BTF to the base BTF.
> >>
> >> Relocation rules are
> >>
> >> - base types must match exactly
> >> - enum[64] types should match all value name/value pairs, but the
> >>   to-be-relocated enum[64] can also define additional name/value pairs
> >> - an enum64 can match an enum and vice versa provided the values match
> >>   as described above
> >> - named fwds match to the correspondingly-named struct/union/enum/enum=
64
> >> - structs with no members match to the correspondingly-named struct/un=
ion
> >>   provided their sizes match
> >> - anon struct/unions must have field names/offsets specified in base
> >>   reference BTF matched by those in base BTF we are matching with
> >>
> >> Relocation can not recurse, since it will be used in-kernel also and
> >> we do not want to blow up the kernel stack when carrying out type
> >> compatibility checks.  Hence we use a stack for reference type
> >> relocation rather then recursive function calls.  The approach however
> >> is the same; we use a depth-first search to match the referents
> >> associated with reference types, and work back from there to match
> >> the reference type itself.
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  tools/lib/bpf/Build             |   2 +-
> >>  tools/lib/bpf/btf.c             |  58 +++
> >>  tools/lib/bpf/btf.h             |   8 +
> >>  tools/lib/bpf/btf_relocate.c    | 601 +++++++++++++++++++++++++++++++=
+
> >>  tools/lib/bpf/libbpf.map        |   1 +
> >>  tools/lib/bpf/libbpf_internal.h |   2 +
> >>  6 files changed, 671 insertions(+), 1 deletion(-)
> >>  create mode 100644 tools/lib/bpf/btf_relocate.c
> >>
> >> diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
> >> index b6619199a706..336da6844d42 100644
> >> --- a/tools/lib/bpf/Build
> >> +++ b/tools/lib/bpf/Build
> >> @@ -1,4 +1,4 @@
> >>  libbpf-y :=3D libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.=
o \
> >>             netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
> >>             btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_c=
ore.o \
> >> -           usdt.o zip.o elf.o features.o
> >> +           usdt.o zip.o elf.o features.o btf_relocate.o
> >> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> >> index 9036c1dc45d0..f00a84fea9b5 100644
> >> --- a/tools/lib/bpf/btf.c
> >> +++ b/tools/lib/bpf/btf.c
> >> @@ -5541,3 +5541,61 @@ int btf__distill_base(const struct btf *src_btf=
, struct btf **new_base_btf,
> >>         errno =3D -ret;
> >>         return ret;
> >>  }
> >> +
> >> +struct btf_rewrite_strs {
> >> +       struct btf *btf;
> >> +       const struct btf *old_base_btf;
> >> +       int str_start;
> >> +       int str_diff;
> >> +};
> >> +
> >> +static int btf_rewrite_strs(__u32 *str_off, void *ctx)
> >> +{
> >> +       struct btf_rewrite_strs *r =3D ctx;
> >> +       const char *s;
> >> +       int off;
> >> +
> >> +       if (!*str_off)
> >> +               return 0;
> >> +       if (*str_off >=3D r->str_start) {
> >> +               *str_off +=3D r->str_diff;
> >> +       } else {
> >> +               s =3D btf__str_by_offset(r->old_base_btf, *str_off);
> >> +               if (!s)
> >> +                       return -ENOENT;
> >> +               off =3D btf__add_str(r->btf, s);
> >> +               if (off < 0)
> >> +                       return off;
> >> +               *str_off =3D off;
> >> +       }
> >> +       return 0;
> >> +}
> >> +
> >> +int btf_set_base_btf(struct btf *btf, struct btf *base_btf)
> >> +{
> >> +       struct btf_rewrite_strs r =3D {};
> >> +       struct btf_type *t;
> >> +       int i, err;
> >> +
> >> +       r.old_base_btf =3D btf__base_btf(btf);
> >> +       if (!r.old_base_btf)
> >> +               return -EINVAL;
> >> +       r.btf =3D btf;
> >> +       r.str_start =3D r.old_base_btf->hdr->str_len;
> >> +       r.str_diff =3D base_btf->hdr->str_len - r.old_base_btf->hdr->s=
tr_len;
> >> +       btf->base_btf =3D base_btf;
> >> +       btf->start_id =3D btf__type_cnt(base_btf);
> >> +       btf->start_str_off =3D base_btf->hdr->str_len;
> >> +       for (i =3D 0; i < btf->nr_types; i++) {
> >> +               t =3D (struct btf_type *)btf__type_by_id(btf, i + btf-=
>start_id);
> >
> > btf_type_by_id()
> >
> >> +               err =3D btf_type_visit_str_offs(t, btf_rewrite_strs, &=
r);
> >> +               if (err)
> >> +                       break;
> >> +       }
> >> +       return err;
> >> +}
> >> +
> >> +int btf__relocate(struct btf *btf, const struct btf *base_btf)
> >> +{
> >> +       return btf_relocate(btf, base_btf, NULL);
> >> +}
> >
> > [...]
> >
> >> +               /* either names must match or both be anon. */
> >> +               if (t->name_off && nt->name_off) {
> >> +                       if (strcmp(btf__name_by_offset(r->btf, t->name=
_off),
> >> +                                  btf__name_by_offset(r->base_btf, nt=
->name_off)))
> >> +                               continue;
> >> +               } else if (t->name_off !=3D nt->name_off) {
> >> +                       continue;
> >> +               }
> >
> > btf__name_by_offset(0) return "", so you don't need this if/else
> > guard, just do strcmp()
> >
> >> +               *tp =3D nt;
> >> +               *id =3D i;
> >> +               return 0;
> >> +       }
> >> +       return -ENOENT;
> >> +}
> >> +
> >> +static int btf_relocate_int(struct btf_relocate *r, const char *name,
> >> +                            const struct btf_type *t, const struct bt=
f_type *bt)
> >> +{
> >> +       __u8 encoding, bencoding, bits, bbits;
> >> +
> >> +       if (t->size !=3D bt->size) {
> >> +               pr_warn("INT types '%s' disagree on size; distilled ba=
se BTF says %d; base BTF says %d\n",
> >> +                       name, t->size, bt->size);
> >> +               return -EINVAL;
> >> +       }
> >> +       encoding =3D btf_int_encoding(t);
> >> +       bencoding =3D btf_int_encoding(bt);
> >> +       if (encoding !=3D bencoding) {
> >> +               pr_warn("INT types '%s' disagree on encoding; distille=
d base BTF says '(%s/%s/%s); base BTF says '(%s/%s/%s)'\n",
> >> +                       name,
> >> +                       encoding & BTF_INT_SIGNED ? "signed" : "unsign=
ed",
> >> +                       encoding & BTF_INT_CHAR ? "char" : "nonchar",
> >> +                       encoding & BTF_INT_BOOL ? "bool" : "nonbool",
> >> +                       bencoding & BTF_INT_SIGNED ? "signed" : "unsig=
ned",
> >> +                       bencoding & BTF_INT_CHAR ? "char" : "nonchar",
> >> +                       bencoding & BTF_INT_BOOL ? "bool" : "nonbool")=
;
> >> +               return -EINVAL;
> >> +       }
> >> +       bits =3D btf_int_bits(t);
> >> +       bbits =3D btf_int_bits(bt);
> >> +       if (bits !=3D bbits) {
> >
> > nit: this b* prefix is a bit ugly, maybe use enc/base_enc and bits/base=
_bits?
> >
> >> +               pr_warn("INT types '%s' disagree on bit size; distille=
d base BTF says %d; base BTF says %d\n",
> >> +                       name, bits, bbits);
> >> +               return -EINVAL;
> >> +       }
> >> +       return 0;
> >> +}
> >> +
> >> +static int btf_relocate_float(struct btf_relocate *r, const char *nam=
e,
> >> +                              const struct btf_type *t, const struct =
btf_type *bt)
> >> +{
> >> +
> >> +       if (t->size !=3D bt->size) {
> >> +               pr_warn("float types '%s' disagree on size; distilled =
base BTF says %d; base BTF says %d\n",
> >> +                       name, t->size, bt->size);
> >> +               return -EINVAL;
> >> +       }
> >> +       return 0;
> >> +}
> >> +
> >> +/* ensure each enum[64] value in type t has equivalent in base BTF an=
d that
> >> + * values match; we must support matching enum64 to enum and vice ver=
sa
> >> + * as well as enum to enum and enum64 to enum64.
> >> + */
> >> +static int btf_relocate_enum(struct btf_relocate *r, const char *name=
,
> >> +                             const struct btf_type *t, const struct b=
tf_type *bt)
> >> +{
> >> +       struct btf_enum *v =3D btf_enum(t);
> >> +       struct btf_enum *bv =3D btf_enum(bt);
> >> +       struct btf_enum64 *v64 =3D btf_enum64(t);
> >> +       struct btf_enum64 *bv64 =3D btf_enum64(bt);
> >> +       bool found, match, bisenum, isenum;
> >
> > is_enum? bisenum is a bit too much to read without underscores (and
> > I'd still use base_ prefix)
> >
> >> +       const char *vname, *bvname;
> >> +       __u32 name_off, bname_off;
> >> +       __u64 val =3D 0, bval =3D 0;
> >> +       int i, j;
> >> +
> >
> > [...]
> >
> >> +               if (!match) {
> >> +                       if (t->name_off)
> >> +                               pr_warn("ENUM[64] types '%s' disagree =
on enum value '%s'; distilled base BTF specifies value %lld; base BTF speci=
fies value %lld\n",
> >> +                                       name, vname, val, bval);
> >> +                       return -EINVAL;
> >> +               }
> >
> > What's the motivation to check enum values if we don't really do any
> > check like this for struct/union? It feels like just checking that
> > enum names and byte sizes match would be adequate, no?
> >
> > I have similar feelings about INT checks, we assume the kernel module
> > was built against valid base BTF in the first place, so as long as
> > general memory layout matches, it should be OK to relocate. So I'd
> > stick to NAME + size checks.
> >
> > If the kernel module was built with an enum definition that's not
> > compatible with the base kernel, it's a bigger problem than BTF. Just
> > like what we discussed with STRUCT/UNION.
> >
> >> +       }
> >> +       return 0;
> >> +}
> >> +
> >> +/* relocate base types (int, float, enum, enum64 and fwd) */
> >> +static int btf_relocate_base_type(struct btf_relocate *r, __u32 id)
> >> +{
> >> +       const struct btf_type *t =3D btf_type_by_id(r->dist_base_btf, =
id);
> >> +       const char *name =3D btf__name_by_offset(r->dist_base_btf, t->=
name_off);
> >> +       const struct btf_type *bt =3D NULL;
> >> +       __u32 base_id =3D 0;
> >> +       int err =3D 0;
> >> +
> >> +       switch (btf_kind(t)) {
> >> +       case BTF_KIND_INT:
> >> +       case BTF_KIND_ENUM:
> >> +       case BTF_KIND_FLOAT:
> >> +       case BTF_KIND_ENUM64:
> >> +       case BTF_KIND_FWD:
> >> +               break;
> >> +       default:
> >> +               return 0;
> >
> > why this is not an error?
> >
> >> +       }
> >> +
> >> +       if (r->map[id] <=3D BTF_MAX_NR_TYPES)
> >> +               return 0;
> >> +
> >> +       while ((err =3D btf_relocate_find_next(r, t, &base_id, &bt)) !=
=3D -ENOENT) {
> >> +               bt =3D btf_type_by_id(r->base_btf, base_id);
> >> +               switch (btf_kind(t)) {
> >> +               case BTF_KIND_INT:
> >> +                       err =3D btf_relocate_int(r, name, t, bt);
> >> +                       break;
> >> +               case BTF_KIND_ENUM:
> >> +               case BTF_KIND_ENUM64:
> >> +                       err =3D btf_relocate_enum(r, name, t, bt);
> >> +                       break;
> >> +               case BTF_KIND_FLOAT:
> >> +                       err =3D btf_relocate_float(r, name, t, bt);
> >> +                       break;
> >> +               case BTF_KIND_FWD:
> >> +                       err =3D 0;
> >> +                       break;
> >> +               default:
> >> +                       return 0;
> >> +               }
> >> +               if (!err) {
> >> +                       r->map[id] =3D base_id;
> >> +                       return 0;
> >> +               }
> >> +       }
> >
> > I'm apprehensive of this linear search (many times) over vmlinux BTF,
> > it feels slow and sloppy, tbh
> >
> > What if we mandate that distilled base BTF should be sorted by (kind,
> > name) by pahole/libbpf (which is simple enough to do), and then we can
> > do a single linear pass over vmlinux BTF + quick binary search over
> > distilled base BTF, marking (on the side) which base distilled BTF
> > type was processed. Then keep a pointer of processed distilled base
> > BTF types, and if at the end it doesn't match base distilled BTF
> > number of types, we couldn't relocate some of base types.
> >
>
> Hmm, so are you saying something like
>
>         foreach vmlinux type
>                 binary search for an equivalent distilled base type, and =
record the
> mapping
>
> ? Would be great to just have to iterate once alright.

Yes. You'd just need an extra quick pass to check with distilled base
types weren't marked, which would be an error condition.

>
> > Simple and fast, WDYT? Or if we don't want to make pahole/libbpf sort,
> > we can build *distilled base* index cheaply in memory, and do
> > effectively the same (that's perhaps a bit more robust, but I think we
> > can just say that distilled base has to be sorted).
> >
>
> Sorting BTF is something that's come up a lot. We should probably do it;
> more below..
>
> > For STRUCT/UNION we'd need to do two searches, once for FWD+name and
> > if not found (embedded struct/union case) STRUCT/UNION+name, but
> > that's still fast with two binary searches.
> >
> > A lot of the code below would go away (once we keep only named types
> > in distilled base), so I didn't spend much time reviewing it, sorry.
> >
>
> The only concern I'd have is that the kernel would I suppose need to be
> skeptical of getting sorted data (in distilled base or elsewhere), so
> we'd probably need to validate sort order I guess. We could share some
> of the mechanics of sorting in btf_common.c to do that specifically for
> .BTF.base, but thinking about it, as part of general BTF validation we
> could mark BTF as sorted or not. What would be nice about this is that
> once we knew BTF was sorted,  we could speed up btf_find_by_name_kind()
> by using binary search on the sorted BTF.

Given distilled base BTF is small, I was thinking the kernel can just
do its own sorting when the module is loaded, it's a few KB of
integers at most, so isn't a problem.

As for generally sorting vmlinux BTF... I think it gets tricky,
because, generally speaking, just KIND+NAME is not enough to define
unique sorting (what do we do with anon types? how do we deal with
reference types that only have some arbitrary BTF ID (which will get
remapped after sorting, mind you)? It gets hairy. BTF is a graph, we
are talking about defining some unique order on a graph, it's not a
straightforward problem.

So I'd focus on getting this distilled base thing working fast and
reliably, before trying to improve BTF sorting in general.

Speaking of sorting, Mykyta (cc'ed) is working on teaching *bpftool*
to do a sane ordering of types so that vmlinux.h output is a)
meaningfully (from human POV) sorted and b) vmlinux.h overall is more
"stable" between slight changes to vmlinux BTF itself, so that they
can be more meaningfully diffed. This is in no way related to sorting
vmlinux BTF data itself (sorting is done on the fly before generating
vmlinux.h), but I thought I'd mention that as you are probably
interested in this as well.


>
>
> >> +       return err;
> >> +}
> >> +
> >
> > [...]

