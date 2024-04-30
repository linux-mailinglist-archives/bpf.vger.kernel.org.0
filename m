Return-Path: <bpf+bounces-28222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01F48B66D0
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 02:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631F7282D31
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 00:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F47E63D;
	Tue, 30 Apr 2024 00:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCYYDZtI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC882635
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 00:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714436107; cv=none; b=symxs1/r0A0nu8sY6b7xxwfL+k6criT8dqSKWUXs7BHdqv9vCC4gyY8kvaH6vXbb+snZRC0kNBbiMTkfmFs4ILLegP8MBC89H8RxHMoQGsx6XOvJyopK6QiPIWBPDinwC455u+Pfj/vewwfi1tQDtebIB8Gx++Qb+FIL0Hs0d7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714436107; c=relaxed/simple;
	bh=qQ/gxU+H/RrJw6x+tvYibalr80TrhEhK2vwLXFuUrps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C15Cs3ut/qdgAW+wv6/DbZxRSadeMcO5v1dFtf3tec9hQ+xhqm6vf6HDE75ytB+m+boz2nOx6nS3SYlCMOk6qqu3JVRsIWZ+Sf2eC2xSbgauwN+NBKQmhyu8e6xdl5ov+/fL+Xe2Xb6rgcmLLSJYShGv7FPsTdzSNCrpv0lDrIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCYYDZtI; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d3907ff128so4119096a12.3
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 17:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714436105; x=1715040905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBPnY45ullt3taGN043nhmVH6EhP1+dUXe/R/ZRREpk=;
        b=KCYYDZtI2WjgqU5NXLtrTcZkwF6n7e9812BVYTno6cVdHfOsEK3qxAZBkObPWJzXBG
         3TqxExpmwyN8VN9n2kp++rTy7yiF8IjbdVZYvei688OPVb1zLK8htI7WQ22U0E/WiOJG
         an7YgG9SBhDRVDZkcCD9sHo1S4ltbhBFZu5y2mL4hEU4RMUsrnJxxtdBXhQq2py+dxm8
         MkgkzQk0tthUR7NKxE77ouHkA8iyRah303bpidUnfXa9LFqka61BqtKs68J3MwmqkBWp
         JosFkJ1qOKUV5hrC+6ClBDwVVSYkImWg0TUzZmTOObhgS7AUMLFIbT7shPG800l9UnwA
         qaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714436105; x=1715040905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBPnY45ullt3taGN043nhmVH6EhP1+dUXe/R/ZRREpk=;
        b=gvdSZrJ4i+1bICnGT8TR6NwSBb4OeSTs2HaaQB3xKO20eyVU3c8EAkWJZuC0aXYsI7
         VrGnLlUc+0Dy9/UQRCqx8IEn0mij+rl2vl1ghSPfr3aLXHbLfOb4AnHE6Ln022n4cIfq
         O5/RTSRJ4aXhbR6Rof5GtvqsrXvVES6b2mp4FL/ofSYFYDP0H8fKc8kKETU64oXhH9x8
         Y2I5a0CiOUWTme3MFlVJZtHH2pVEeRh3tJI2J5XnwziyGb1r2K+28ptOUgil7M4KCxGU
         s7QcSYAKFefelXNxl2AlVHM4Vz58xAqhYGbjX+Obvulb5WOnOgOJzA26w4fqHqgsPDVh
         Z78Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4uzsCzor2yDfmJtcivcW/76BTRzulnQFk9FahHMdxEtNCyLKgnjneZWCeZTEwWGdXkFa6vzmfokI9r/k1adHWZgzH
X-Gm-Message-State: AOJu0Yw0J3ElwsLZgUVS25pI6TgoVQCHqaBMeTiVXrcZeMHTghAnA1i8
	3872uRv9Spu3B9fUmZA4+fPEyKJYfdKfNpwc4ImgITph/nRyVSEsOaT/plrQUj0V/Vc8NzCb7Mv
	ckDdRnR6ysc1HL2YnHqCUNE+bCg0=
X-Google-Smtp-Source: AGHT+IEegBw0QV38k7RA5lNGC/XONy6AMZXYQrtej5+3BsH0zeg9xVOXEVWURktsCsMY6kcaSnh5/admVTGteZzrE94=
X-Received: by 2002:a17:90a:c403:b0:2b1:9fa4:16fd with SMTP id
 i3-20020a17090ac40300b002b19fa416fdmr4630706pjt.4.1714436105110; Mon, 29 Apr
 2024 17:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424154806.3417662-1-alan.maguire@oracle.com> <20240424154806.3417662-10-alan.maguire@oracle.com>
In-Reply-To: <20240424154806.3417662-10-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 17:14:52 -0700
Message-ID: <CAEf4BzYr8ONqLuH0q+FFJijx3ADrqn464pf8E4A3s+uJ03cyVQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 09/13] libbpf: split BTF relocation
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 8:49=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Map distilled base BTF type ids referenced in split BTF and their
> references to the base BTF passed in, and if the mapping succeeds,
> reparent the split BTF to the base BTF.
>
> Relocation rules are
>
> - base types must match exactly
> - enum[64] types should match all value name/value pairs, but the
>   to-be-relocated enum[64] can also define additional name/value pairs
> - an enum64 can match an enum and vice versa provided the values match
>   as described above
> - named fwds match to the correspondingly-named struct/union/enum/enum64
> - structs with no members match to the correspondingly-named struct/union
>   provided their sizes match
> - anon struct/unions must have field names/offsets specified in base
>   reference BTF matched by those in base BTF we are matching with
>
> Relocation can not recurse, since it will be used in-kernel also and
> we do not want to blow up the kernel stack when carrying out type
> compatibility checks.  Hence we use a stack for reference type
> relocation rather then recursive function calls.  The approach however
> is the same; we use a depth-first search to match the referents
> associated with reference types, and work back from there to match
> the reference type itself.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/Build             |   2 +-
>  tools/lib/bpf/btf.c             |  58 +++
>  tools/lib/bpf/btf.h             |   8 +
>  tools/lib/bpf/btf_relocate.c    | 601 ++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.map        |   1 +
>  tools/lib/bpf/libbpf_internal.h |   2 +
>  6 files changed, 671 insertions(+), 1 deletion(-)
>  create mode 100644 tools/lib/bpf/btf_relocate.c
>
> diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
> index b6619199a706..336da6844d42 100644
> --- a/tools/lib/bpf/Build
> +++ b/tools/lib/bpf/Build
> @@ -1,4 +1,4 @@
>  libbpf-y :=3D libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
>             netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
>             btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core=
.o \
> -           usdt.o zip.o elf.o features.o
> +           usdt.o zip.o elf.o features.o btf_relocate.o
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 9036c1dc45d0..f00a84fea9b5 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -5541,3 +5541,61 @@ int btf__distill_base(const struct btf *src_btf, s=
truct btf **new_base_btf,
>         errno =3D -ret;
>         return ret;
>  }
> +
> +struct btf_rewrite_strs {
> +       struct btf *btf;
> +       const struct btf *old_base_btf;
> +       int str_start;
> +       int str_diff;
> +};
> +
> +static int btf_rewrite_strs(__u32 *str_off, void *ctx)
> +{
> +       struct btf_rewrite_strs *r =3D ctx;
> +       const char *s;
> +       int off;
> +
> +       if (!*str_off)
> +               return 0;
> +       if (*str_off >=3D r->str_start) {
> +               *str_off +=3D r->str_diff;
> +       } else {
> +               s =3D btf__str_by_offset(r->old_base_btf, *str_off);
> +               if (!s)
> +                       return -ENOENT;
> +               off =3D btf__add_str(r->btf, s);
> +               if (off < 0)
> +                       return off;
> +               *str_off =3D off;
> +       }
> +       return 0;
> +}
> +
> +int btf_set_base_btf(struct btf *btf, struct btf *base_btf)
> +{
> +       struct btf_rewrite_strs r =3D {};
> +       struct btf_type *t;
> +       int i, err;
> +
> +       r.old_base_btf =3D btf__base_btf(btf);
> +       if (!r.old_base_btf)
> +               return -EINVAL;
> +       r.btf =3D btf;
> +       r.str_start =3D r.old_base_btf->hdr->str_len;
> +       r.str_diff =3D base_btf->hdr->str_len - r.old_base_btf->hdr->str_=
len;
> +       btf->base_btf =3D base_btf;
> +       btf->start_id =3D btf__type_cnt(base_btf);
> +       btf->start_str_off =3D base_btf->hdr->str_len;
> +       for (i =3D 0; i < btf->nr_types; i++) {
> +               t =3D (struct btf_type *)btf__type_by_id(btf, i + btf->st=
art_id);

btf_type_by_id()

> +               err =3D btf_type_visit_str_offs(t, btf_rewrite_strs, &r);
> +               if (err)
> +                       break;
> +       }
> +       return err;
> +}
> +
> +int btf__relocate(struct btf *btf, const struct btf *base_btf)
> +{
> +       return btf_relocate(btf, base_btf, NULL);
> +}

[...]

> +               /* either names must match or both be anon. */
> +               if (t->name_off && nt->name_off) {
> +                       if (strcmp(btf__name_by_offset(r->btf, t->name_of=
f),
> +                                  btf__name_by_offset(r->base_btf, nt->n=
ame_off)))
> +                               continue;
> +               } else if (t->name_off !=3D nt->name_off) {
> +                       continue;
> +               }

btf__name_by_offset(0) return "", so you don't need this if/else
guard, just do strcmp()

> +               *tp =3D nt;
> +               *id =3D i;
> +               return 0;
> +       }
> +       return -ENOENT;
> +}
> +
> +static int btf_relocate_int(struct btf_relocate *r, const char *name,
> +                            const struct btf_type *t, const struct btf_t=
ype *bt)
> +{
> +       __u8 encoding, bencoding, bits, bbits;
> +
> +       if (t->size !=3D bt->size) {
> +               pr_warn("INT types '%s' disagree on size; distilled base =
BTF says %d; base BTF says %d\n",
> +                       name, t->size, bt->size);
> +               return -EINVAL;
> +       }
> +       encoding =3D btf_int_encoding(t);
> +       bencoding =3D btf_int_encoding(bt);
> +       if (encoding !=3D bencoding) {
> +               pr_warn("INT types '%s' disagree on encoding; distilled b=
ase BTF says '(%s/%s/%s); base BTF says '(%s/%s/%s)'\n",
> +                       name,
> +                       encoding & BTF_INT_SIGNED ? "signed" : "unsigned"=
,
> +                       encoding & BTF_INT_CHAR ? "char" : "nonchar",
> +                       encoding & BTF_INT_BOOL ? "bool" : "nonbool",
> +                       bencoding & BTF_INT_SIGNED ? "signed" : "unsigned=
",
> +                       bencoding & BTF_INT_CHAR ? "char" : "nonchar",
> +                       bencoding & BTF_INT_BOOL ? "bool" : "nonbool");
> +               return -EINVAL;
> +       }
> +       bits =3D btf_int_bits(t);
> +       bbits =3D btf_int_bits(bt);
> +       if (bits !=3D bbits) {

nit: this b* prefix is a bit ugly, maybe use enc/base_enc and bits/base_bit=
s?

> +               pr_warn("INT types '%s' disagree on bit size; distilled b=
ase BTF says %d; base BTF says %d\n",
> +                       name, bits, bbits);
> +               return -EINVAL;
> +       }
> +       return 0;
> +}
> +
> +static int btf_relocate_float(struct btf_relocate *r, const char *name,
> +                              const struct btf_type *t, const struct btf=
_type *bt)
> +{
> +
> +       if (t->size !=3D bt->size) {
> +               pr_warn("float types '%s' disagree on size; distilled bas=
e BTF says %d; base BTF says %d\n",
> +                       name, t->size, bt->size);
> +               return -EINVAL;
> +       }
> +       return 0;
> +}
> +
> +/* ensure each enum[64] value in type t has equivalent in base BTF and t=
hat
> + * values match; we must support matching enum64 to enum and vice versa
> + * as well as enum to enum and enum64 to enum64.
> + */
> +static int btf_relocate_enum(struct btf_relocate *r, const char *name,
> +                             const struct btf_type *t, const struct btf_=
type *bt)
> +{
> +       struct btf_enum *v =3D btf_enum(t);
> +       struct btf_enum *bv =3D btf_enum(bt);
> +       struct btf_enum64 *v64 =3D btf_enum64(t);
> +       struct btf_enum64 *bv64 =3D btf_enum64(bt);
> +       bool found, match, bisenum, isenum;

is_enum? bisenum is a bit too much to read without underscores (and
I'd still use base_ prefix)

> +       const char *vname, *bvname;
> +       __u32 name_off, bname_off;
> +       __u64 val =3D 0, bval =3D 0;
> +       int i, j;
> +

[...]

> +               if (!match) {
> +                       if (t->name_off)
> +                               pr_warn("ENUM[64] types '%s' disagree on =
enum value '%s'; distilled base BTF specifies value %lld; base BTF specifie=
s value %lld\n",
> +                                       name, vname, val, bval);
> +                       return -EINVAL;
> +               }

What's the motivation to check enum values if we don't really do any
check like this for struct/union? It feels like just checking that
enum names and byte sizes match would be adequate, no?

I have similar feelings about INT checks, we assume the kernel module
was built against valid base BTF in the first place, so as long as
general memory layout matches, it should be OK to relocate. So I'd
stick to NAME + size checks.

If the kernel module was built with an enum definition that's not
compatible with the base kernel, it's a bigger problem than BTF. Just
like what we discussed with STRUCT/UNION.

> +       }
> +       return 0;
> +}
> +
> +/* relocate base types (int, float, enum, enum64 and fwd) */
> +static int btf_relocate_base_type(struct btf_relocate *r, __u32 id)
> +{
> +       const struct btf_type *t =3D btf_type_by_id(r->dist_base_btf, id)=
;
> +       const char *name =3D btf__name_by_offset(r->dist_base_btf, t->nam=
e_off);
> +       const struct btf_type *bt =3D NULL;
> +       __u32 base_id =3D 0;
> +       int err =3D 0;
> +
> +       switch (btf_kind(t)) {
> +       case BTF_KIND_INT:
> +       case BTF_KIND_ENUM:
> +       case BTF_KIND_FLOAT:
> +       case BTF_KIND_ENUM64:
> +       case BTF_KIND_FWD:
> +               break;
> +       default:
> +               return 0;

why this is not an error?

> +       }
> +
> +       if (r->map[id] <=3D BTF_MAX_NR_TYPES)
> +               return 0;
> +
> +       while ((err =3D btf_relocate_find_next(r, t, &base_id, &bt)) !=3D=
 -ENOENT) {
> +               bt =3D btf_type_by_id(r->base_btf, base_id);
> +               switch (btf_kind(t)) {
> +               case BTF_KIND_INT:
> +                       err =3D btf_relocate_int(r, name, t, bt);
> +                       break;
> +               case BTF_KIND_ENUM:
> +               case BTF_KIND_ENUM64:
> +                       err =3D btf_relocate_enum(r, name, t, bt);
> +                       break;
> +               case BTF_KIND_FLOAT:
> +                       err =3D btf_relocate_float(r, name, t, bt);
> +                       break;
> +               case BTF_KIND_FWD:
> +                       err =3D 0;
> +                       break;
> +               default:
> +                       return 0;
> +               }
> +               if (!err) {
> +                       r->map[id] =3D base_id;
> +                       return 0;
> +               }
> +       }

I'm apprehensive of this linear search (many times) over vmlinux BTF,
it feels slow and sloppy, tbh

What if we mandate that distilled base BTF should be sorted by (kind,
name) by pahole/libbpf (which is simple enough to do), and then we can
do a single linear pass over vmlinux BTF + quick binary search over
distilled base BTF, marking (on the side) which base distilled BTF
type was processed. Then keep a pointer of processed distilled base
BTF types, and if at the end it doesn't match base distilled BTF
number of types, we couldn't relocate some of base types.

Simple and fast, WDYT? Or if we don't want to make pahole/libbpf sort,
we can build *distilled base* index cheaply in memory, and do
effectively the same (that's perhaps a bit more robust, but I think we
can just say that distilled base has to be sorted).

For STRUCT/UNION we'd need to do two searches, once for FWD+name and
if not found (embedded struct/union case) STRUCT/UNION+name, but
that's still fast with two binary searches.

A lot of the code below would go away (once we keep only named types
in distilled base), so I didn't spend much time reviewing it, sorry.

> +       return err;
> +}
> +

[...]

