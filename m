Return-Path: <bpf+bounces-28955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98AC8BEE82
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 23:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF4F285FE7
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 21:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD9A634E2;
	Tue,  7 May 2024 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx2xQSES"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD358AB8
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715115775; cv=none; b=D0bDiLO4686rUBdJq1JBcW6/94RT+VtFNfxwD9Bxbpzl9S/YT1cueXbuQLJKvV6lKmJczTGI8BCUCdNvkgU6MRvn+BCzyUIMEOvhPcSy2KNOFrdztrqSM/QVOJkUPzf9/bMXwy4USmXsip1PrWChtFrk/N4j5Zg52IPvR98CzaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715115775; c=relaxed/simple;
	bh=o9MRgMMTCKt4E7yiA/eQOdjc7EHIO8JZWAyqA1XJBFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5oDEPuA2PCIHXGwJX9xohn1tMAwjRJE2F+0ZC+ovt77WwdzFPsxFhAnI8v8fnnJXhSanKAKCjBQ63D9APG7mM5vQ+nHpo9l/C0m8fY0ZSxgJdvOcNhWdCP6N6AmJPN/wWUwN6RIwKCV07l53+Kxd2C03QANODwPbaegJAlThVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sx2xQSES; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-61bbb208ea5so2744042a12.0
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715115773; x=1715720573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJ6eFOQD9wKWmw0jmG9mZYbT5jB5pVkTdtuGF8nS5M0=;
        b=Sx2xQSESs7SSAfDEl4NEy4yHZmelAzmpdyfmaLAu/BuWXJD9IIV+0cQlWFtEdGSVco
         w0KY+PsABHoANyEYGj5r/6q5+ltTGMQ6e3XMs4+/JlRCecxlajQF8ki//BnkMDggI/95
         hOH1Li1YcQHeeHtSv3B9NrY9mbW3RETrklUMUM4gZfHGRsVw69aclaGPTVUUo5HsXtjl
         wDrAkECycgZY5F8GAUecERwAxJaXSlRdbY2O7mJnhRgebYRRj0dvAbvGZrRVDwhDe6Ef
         G1F38k3Z4gfXW3X9ifog8pAih1a79ueI4+bxnJksmhXZFDf81TTcOO4QIHD6mxSaYEnN
         C/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715115773; x=1715720573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJ6eFOQD9wKWmw0jmG9mZYbT5jB5pVkTdtuGF8nS5M0=;
        b=V/elmJ4aKc/pQII5PWXhgj1O1JNnh3GZ8sVd6yJLYhqGeY5ubB1ifGD6GS9tqZGRGP
         0L+U9HWhIwpHParS/oBRewyqALOcJgfqnZewrSk08WIKvRKdDMRH7NrVtPhjvxHXr9P/
         q8D6yK0m9g0dsIITIJAwLML8kFkymAEwKbELexw2kfF2A2ILzmVke6azCC0XU1jW0TMC
         9yR3BHSq3aDTPeOxUkKLu3v2e+WU8ePO42Wxxusx94b9TYff6jObRaybuVAaK34FVDuC
         oEw3GVLIMFGm1NgGtDp/e39GWu/QVnSRanxsBI8HoAL3k8Eul8DXerRB85RexfXd3ISD
         h3sw==
X-Gm-Message-State: AOJu0YxNaLxTwZpe05o/sCrKOqsUVZWW+Lt/n9fFdp12mMsADDyKAk48
	1hFdtc9BWuo4F6yKWCFooqtJ8pvxc7TJ0um0kLGVBMCDuK5f/c7750AjQhv11J4jDQC4jqB58ZP
	rxAo64h/5FeMY8p7+aYRlrf9G39c=
X-Google-Smtp-Source: AGHT+IFZiUIruKzfzZ6bH8xzkmveVhZ8oAiiIi7DRAWBlFklxpNNz9SKsmmKyClpHh8IXpWthCMiMD0aUv5BLwUh+aY=
X-Received: by 2002:a17:90a:39cd:b0:2b4:3669:65f0 with SMTP id
 98e67ed59e1d1-2b6163a2764mr724165a91.6.1715115773042; Tue, 07 May 2024
 14:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506134458.727621-1-yatsenko@meta.com>
In-Reply-To: <20240506134458.727621-1-yatsenko@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 May 2024 14:02:40 -0700
Message-ID: <CAEf4BzZ+nw6iu8RO1xJutRf+qnxAotHx47bXuJuw8AT-5Z3QfQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: introduce btf c dump sorting
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Quentin Monnet <qmo@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 6:45=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Provide a way to sort bpftool c dump output, to simplify vmlinux.h
> diffing and forcing more natural definitions ordering.
>
> Use `normalized` argument in bpftool CLI after `format c` for example:
> ```
> bpftool btf dump file /sys/kernel/btf/fuse format c normalized
> ```
>
> Definitions are sorted by their BTF kind ranks, lexicographically and
> typedefs are forced to go right after their base type.
>
> Type ranks
>
> Assign ranks to btf kinds (defined in function btf_type_rank) to set
> next order:
> 1. Anonymous enums
> 2. Anonymous enums64
> 3. Named enums
> 4. Named enums64
> 5. Trivial types typedefs (ints, then floats)
> 6. Structs
> 7. Unions
> 8. Function prototypes
> 9. Forward declarations
>
> Lexicographical ordering
>
> Definitions within the same BTF kind are ordered by their names.
> Anonymous enums are ordered by their first element.
>
> Forcing typedefs to go right after their base type
>
> To make sure that typedefs are emitted right after their base type,
> we build a list of type's typedefs (struct typedef_ref) and after
> emitting type, its typedefs are emitted as well (lexicographically)
>
> There is a small flaw in this implementation:
> Type dependencies are resolved by bpf lib, so when type is dumped
> because it is a dependency, its typedefs are not output right after it,
> as bpflib does not have the list of typedefs for a given type.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/bpf/bpftool/btf.c | 264 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 259 insertions(+), 5 deletions(-)
>

I applied this locally to experiment. Generated vmlinux.h for the
production (a bit older) kernel and then for latest bpf-next/master
kernel. And then tried diff between normalized vmlinux.h dumps and
non-normalized.

It took a bit for the diff tool to generate, but I think diff for
normalized vmlinux.h is actually very usable. You can see an example
at [1]. It shows whole new types being added in front of existing
ones. And for existing ones it shows only parts that actually changed.
It's quite nice. And note that I used a relatively stale production
kernel vs latest upstream bpf-next, *AND* with different (bigger)
Kconfig. So for more incremental changes in kernel config/version the
diff should be much slower.

I think this idea of normalizing vmlinux.h works and is useful.

Eduard, Quentin, please take a look when you get a chance.

My high-level feedback. I like the idea and it seems to work well in
practice. I do think, though, that the current implementation is a bit
over-engineered. I'd drop all the complexity with TYPEDEF and try to
get almost the same behavior with a slightly different ranking
strategy.

Tracking which types are emitted seems unnecessary btf_dumper is doing
that already internally. So I think overall flow could be basically
three steps:

  - precalculate/cache "sort names" and ranks;
  - sort based on those two, construct 0-based list of types to emit
  - just go linearly over that sorted list, call btf_dump__dump_type()
on each one with original type ID; if the type was already emitted or
is not the type that's emitted as an independent type (e.g.,
FUNC_PROTO), btf_dump__dump_type() should do the right thing (do
nothing).

Any flaws in the above proposal?

  [1] https://gist.github.com/anakryiko/cca678c8f77833d9eb99ffc102612e28

> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 91fcb75babe3..93c876e90b04 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -11,6 +11,7 @@
>  #include <linux/btf.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <linux/list.h>
>
>  #include <bpf/bpf.h>
>  #include <bpf/btf.h>
> @@ -43,6 +44,20 @@ static const char * const btf_kind_str[NR_BTF_KINDS] =
=3D {
>         [BTF_KIND_ENUM64]       =3D "ENUM64",
>  };
>
> +struct typedef_ref {
> +       struct sort_datum *datum;
> +       struct list_head list;
> +};
> +
> +struct sort_datum {
> +       __u32 index;
> +       int type_rank;
> +       bool emitted;
> +       const char *name;
> +       // List of typedefs of this type

let's not use C++-style comments in C code, please stick to /* */

> +       struct list_head *typedef_list;
> +};
> +
>  static const char *btf_int_enc_str(__u8 encoding)
>  {
>         switch (encoding) {
> @@ -460,8 +475,233 @@ static void __printf(2, 0) btf_dump_printf(void *ct=
x,
>         vfprintf(stdout, fmt, args);
>  }
>
> +static int btf_type_rank(const struct btf *btf, __u32 index, bool has_na=
me)
> +{
> +       const struct btf_type *btf_type =3D btf__type_by_id(btf, index);

nit: we normally use `t` when there is one BTF type that function is
working with, it's nice and short that way

> +       const int max_rank =3D 1000;
> +
> +       has_name |=3D (bool)btf_type->name_off;

this is a rather unconventional way of writing

if (btf_type->name_off)
    has_name =3D true;

> +
> +       switch (btf_kind(btf_type)) {
> +       case BTF_KIND_ENUM:
> +               return 100 + (btf_type->name_off =3D=3D 0 ? 0 : 1);
> +       case BTF_KIND_ENUM64:
> +               return 200 + (btf_type->name_off =3D=3D 0 ? 0 : 1);

nit: ENUM and ENUM64 are not fundamentally different, I'd rank them
absolutely the same

> +       case BTF_KIND_INT:
> +               return 300;
> +       case BTF_KIND_FLOAT:
> +               return 400;
> +       case BTF_KIND_VAR:
> +               return 500;

doesn't really matter, because VAR is not emitted by btf_dumper, but
I'd put it right before DATASEC, they are related (i.e., I'd just drop
them to max_rank for now)

> +
> +       case BTF_KIND_STRUCT:
> +               return 600 + (has_name ? 0 : max_rank);
> +       case BTF_KIND_UNION:
> +               return 700 + (has_name ? 0 : max_rank);

struct/union are also conceptually on the same footing, let's rank them the=
 same

> +       case BTF_KIND_FUNC_PROTO:
> +               return 800 + (has_name ? 0 : max_rank);

func_proto by itself is not emitted, it can be emitted as part of TYPEDEF o=
nly

> +
> +       case BTF_KIND_FWD:
> +               return 900;
> +
> +       case BTF_KIND_ARRAY:
> +               return 1 + btf_type_rank(btf, btf_array(btf_type)->type, =
has_name);

similarly not an independent type, but maybe it's ranking influences
the order of typedef, still reading the rest of the logic...

> +
> +       case BTF_KIND_CONST:
> +       case BTF_KIND_PTR:
> +       case BTF_KIND_VOLATILE:
> +       case BTF_KIND_RESTRICT:
> +       case BTF_KIND_TYPE_TAG:
> +       case BTF_KIND_TYPEDEF:
> +               return 1 + btf_type_rank(btf, btf_type->type, has_name);
> +
> +       default:
> +               return max_rank;
> +       }
> +}
> +
> +static const char *btf_type_sort_name(const struct btf *btf, __u32 index=
)
> +{
> +       const struct btf_type *btf_type =3D btf__type_by_id(btf, index);

nit: btf_type -> t

> +       const int kind =3D btf_kind(btf_type);
> +       const char *name =3D btf__name_by_offset(btf, btf_type->name_off)=
;
> +
> +       // Use name of the first element for anonymous enums

/* */

> +       if (!btf_type->name_off && (kind =3D=3D BTF_KIND_ENUM || kind =3D=
=3D BTF_KIND_ENUM64))
> +               name =3D btf__name_by_offset(btf, btf_enum(btf_type)->nam=
e_off);

we could have empty enums, but they should be named (because they are
effectively a forward-declaration of an enum), but it would be nice to
guard btf_enum() access by checking vlen first

> +
> +       return name;
> +}
> +
> +static int btf_type_compare(const void *left, const void *right)
> +{
> +       const struct sort_datum *datum1 =3D (const struct sort_datum *)le=
ft;
> +       const struct sort_datum *datum2 =3D (const struct sort_datum *)ri=
ght;
> +
> +       if (datum1->type_rank !=3D datum2->type_rank)
> +               return datum1->type_rank < datum2->type_rank ? -1 : 1;
> +
> +       return strcmp(datum1->name, datum2->name);
> +}
> +
> +static int emit_typedefs(struct list_head *typedef_list, int *sorted_ind=
exes)
> +{
> +       struct typedef_ref *type;
> +       int current_index =3D 0;
> +
> +       if (!typedef_list)
> +               return 0;
> +       list_for_each_entry(type, typedef_list, list) {
> +               if (type->datum->emitted)
> +                       continue;
> +               type->datum->emitted =3D true;
> +               sorted_indexes[current_index++] =3D type->datum->index;
> +               current_index +=3D emit_typedefs(type->datum->typedef_lis=
t,
> +                                       sorted_indexes + current_index);
> +       }
> +       return current_index;
> +}
> +
> +static void free_typedefs(struct list_head *typedef_list)
> +{
> +       struct typedef_ref *type;
> +       struct typedef_ref *temp_type;
> +
> +       if (!typedef_list)
> +               return;
> +       list_for_each_entry_safe(type, temp_type, typedef_list, list) {
> +               list_del(&type->list);
> +               free(type);
> +       }
> +       free(typedef_list);
> +}
> +
> +static void add_typedef_ref(const struct btf *btf, struct sort_datum *pa=
rent,
> +                           struct typedef_ref *new_ref)
> +{
> +       struct typedef_ref *current_child;
> +       const char *new_child_name =3D new_ref->datum->name;
> +
> +       if (!parent->typedef_list) {
> +               parent->typedef_list =3D malloc(sizeof(struct list_head))=
;
> +               INIT_LIST_HEAD(parent->typedef_list);
> +               list_add(&new_ref->list, parent->typedef_list);
> +               return;
> +       }
> +       list_for_each_entry(current_child, parent->typedef_list, list) {
> +               const struct btf_type *t =3D btf__type_by_id(btf, current=
_child->datum->index);
> +               const char *current_name =3D btf_str(btf, t->name_off);
> +
> +               if (list_is_last(&current_child->list, parent->typedef_li=
st)) {
> +                       list_add(&new_ref->list, &current_child->list);
> +                       return;
> +               }
> +               if (strcmp(new_child_name, current_name) < 0) {
> +                       list_add_tail(&new_ref->list, &current_child->lis=
t);
> +                       return;
> +               }
> +       }
> +}
> +
> +static int find_base_typedef_type(const struct btf *btf, int index)
> +{
> +       const struct btf_type *type =3D btf__type_by_id(btf, index);
> +       int kind =3D btf_kind(type);
> +       int base_idx;
> +
> +       if (kind !=3D BTF_KIND_TYPEDEF)
> +               return 0;
> +
> +       do {
> +               base_idx =3D kind =3D=3D BTF_KIND_ARRAY ? btf_array(type)=
->type : type->type;
> +               type =3D btf__type_by_id(btf, base_idx);
> +               kind =3D btf_kind(type);
> +       } while (kind =3D=3D BTF_KIND_ARRAY ||
> +                  kind =3D=3D BTF_KIND_PTR ||
> +                  kind =3D=3D BTF_KIND_CONST ||
> +                  kind =3D=3D BTF_KIND_VOLATILE ||
> +                  kind =3D=3D BTF_KIND_RESTRICT ||
> +                  kind =3D=3D BTF_KIND_TYPE_TAG);
> +
> +       return base_idx;
> +}
> +

can we avoid all this complexity with TYPEDEFs if we just rank them
just like the type they are pointing to? I.e., TYPEDEF -> STRUCT is
just a struct, TYPEDEF -> TYPEDEF -> INT is just an INT. Emitting the
TYPEDEF type will force all the dependent types to be emitted, which
is good.

If we also use this "pointee type"'s name as TYPEDEF's sort name, it
will also put it in the position where it should be, right? There
might be some insignificant deviations, but I think it would keep the
code much simpler (and either way we are striving for something that
more-or-less works as expected in practice, not designing some API
that's set in stone).

WDYT?

> +static int *sort_btf_c(const struct btf *btf)
> +{
> +       int total_root_types;
> +       struct sort_datum *datums;
> +       int *sorted_indexes =3D NULL;
> +       int *type_index_to_datum_index;

nit: most of these names are unnecessarily verbose. It's one
relatively straightforward function, just use shorter names "n",
"idxs", "idx_to_datum", stuff like this. Cooler and shorter C names
:))

> +
> +       if (!btf)
> +               return sorted_indexes;

this would be a horrible bug if this happens, don't guard against it here

> +
> +       total_root_types =3D btf__type_cnt(btf);
> +       datums =3D malloc(sizeof(struct sort_datum) * total_root_types);
> +
> +       for (int i =3D 1; i < total_root_types; ++i) {
> +               struct sort_datum *current_datum =3D datums + i;
> +
> +               current_datum->index =3D i;
> +               current_datum->name =3D btf_type_sort_name(btf, i);
> +               current_datum->type_rank =3D btf_type_rank(btf, i, false)=
;
> +               current_datum->emitted =3D false;

btf_dump__dump_type() keeps track of which types are already emitted,
you probably don't need to do this explicitly?

> +               current_datum->typedef_list =3D NULL;
> +       }
> +
> +       qsort(datums + 1, total_root_types - 1, sizeof(struct sort_datum)=
, btf_type_compare);

do we really need to do 1-based indexing?

> +
> +       // Build a mapping from btf type id to datums array index
> +       type_index_to_datum_index =3D malloc(sizeof(int) * total_root_typ=
es);
> +       type_index_to_datum_index[0] =3D 0;
> +       for (int i =3D 1; i < total_root_types; ++i)
> +               type_index_to_datum_index[datums[i].index] =3D i;
> +
> +       for (int i =3D 1; i < total_root_types; ++i) {
> +               struct sort_datum *current_datum =3D datums + i;
> +               const struct btf_type *current_type =3D btf__type_by_id(b=
tf, current_datum->index);
> +               int base_index;
> +               struct sort_datum *base_datum;
> +               const struct btf_type *base_type;
> +               struct typedef_ref *new_ref;
> +
> +               if (btf_kind(current_type) !=3D BTF_KIND_TYPEDEF)
> +                       continue;
> +
> +               base_index =3D find_base_typedef_type(btf, current_datum-=
>index);
> +               if (!base_index)
> +                       continue;
> +
> +               base_datum =3D datums + type_index_to_datum_index[base_in=
dex];
> +               base_type =3D btf__type_by_id(btf, base_datum->index);
> +               if (!base_type->name_off)
> +                       continue;
> +
> +               new_ref =3D malloc(sizeof(struct typedef_ref));
> +               new_ref->datum =3D current_datum;
> +
> +               add_typedef_ref(btf, base_datum, new_ref);
> +       }
> +
> +       sorted_indexes =3D malloc(sizeof(int) * total_root_types);

nit: here and above, gotta check your malloc()'s for NULL results, it's C

> +       sorted_indexes[0] =3D 0;
> +       for (int emit_index =3D 1, datum_index =3D 1; emit_index < total_=
root_types; ++datum_index) {
> +               struct sort_datum *datum =3D datums + datum_index;
> +
> +               if (datum->emitted)
> +                       continue;
> +               datum->emitted =3D true;
> +               sorted_indexes[emit_index++] =3D datum->index;
> +               emit_index +=3D emit_typedefs(datum->typedef_list, sorted=
_indexes + emit_index);
> +               free_typedefs(datum->typedef_list);
> +       }
> +       free(type_index_to_datum_index);
> +       free(datums);
> +       return sorted_indexes;
> +}
> +
>  static int dump_btf_c(const struct btf *btf,
> -                     __u32 *root_type_ids, int root_type_cnt)
> +                     __u32 *root_type_ids, int root_type_cnt, bool norma=
lized)
>  {
>         struct btf_dump *d;
>         int err =3D 0, i;
> @@ -485,12 +725,17 @@ static int dump_btf_c(const struct btf *btf,
>                 }
>         } else {
>                 int cnt =3D btf__type_cnt(btf);
> -
> +               int *sorted_indexes =3D normalized ? sort_btf_c(btf) : NU=
LL;

keep empty line between variable declaration and the rest of the code
in the block. Also see below, I'd declare sorted_indexes at the
function level, init to NULL, and free at the end, keeping clean up
simpler

>                 for (i =3D 1; i < cnt; i++) {
> -                       err =3D btf_dump__dump_type(d, i);
> +                       int idx =3D sorted_indexes ? sorted_indexes[i] : =
i;
> +
> +                       err =3D btf_dump__dump_type(d, idx);
>                         if (err)
> -                               goto done;
> +                               break;
>                 }
> +               free(sorted_indexes);
> +               if (err)
> +                       goto done;

too convoluted, just free(sorted_indexes) next to btf_dump__free() at
the very end, initialize it to NULL and be done with it.

>         }
>
>         printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
> @@ -553,6 +798,7 @@ static int do_dump(int argc, char **argv)
>         __u32 root_type_ids[2];
>         int root_type_cnt =3D 0;
>         bool dump_c =3D false;
> +       bool normalized =3D false;
>         __u32 btf_id =3D -1;
>         const char *src;
>         int fd =3D -1;
> @@ -663,6 +909,14 @@ static int do_dump(int argc, char **argv)
>                                 goto done;
>                         }
>                         NEXT_ARG();
> +               } else if (strcmp(*argv, "normalized") =3D=3D 0) {

use is_prefix() helper, then we can do `bpftool btf dump file <path>
format c norm` without having to spell out entire "normalized"

> +                       if (!dump_c) {
> +                               p_err("Only C dump supports normalization=
");
> +                               err =3D -EINVAL;
> +                               goto done;
> +                       }

this should be checked after processing all the options, we shouldn't
assume any mutual ordering between them

> +                       normalized =3D true;
> +                       NEXT_ARG();
>                 } else {
>                         p_err("unrecognized option: '%s'", *argv);
>                         err =3D -EINVAL;
> @@ -691,7 +945,7 @@ static int do_dump(int argc, char **argv)
>                         err =3D -ENOTSUP;
>                         goto done;
>                 }
> -               err =3D dump_btf_c(btf, root_type_ids, root_type_cnt);
> +               err =3D dump_btf_c(btf, root_type_ids, root_type_cnt, nor=
malized);
>         } else {
>                 err =3D dump_btf_raw(btf, root_type_ids, root_type_cnt);
>         }
> --
> 2.44.0
>

