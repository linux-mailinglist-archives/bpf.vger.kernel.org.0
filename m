Return-Path: <bpf+bounces-22906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC4786B71E
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 19:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B86CB227F9
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F0F40858;
	Wed, 28 Feb 2024 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1Qln2Hv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF1579B61
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144737; cv=none; b=BfK1Te9xPb+xiunZ0BuMKQr1PoWFcdgt+TElFf7jQXLEOQMytrc3FNsh3JluCwM3WCK2ifFuuGOHUx8MKGzglibia5+BOVSCX1crlxpMFuDPTSQVazmrQu91x+pCpaaDAEHb98PJtbInQxeTJ75aY9bTCjQS6+VnA1rkMT7vaao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144737; c=relaxed/simple;
	bh=jDn3PoQgr5Tbc5ouZT8NBdtAUqfQnZvjWDJtQSjek7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNzp/I/X/QQf8PGDnFcy34xEm+5BHb+AT2tRRt1mSDX/K3VuFuEH5C429PzXirjgWxokKpEuDrdo2txVw1qZ4cDwv6V4e34+FUcrESXY6gx00TWAwYBfW7W6SN9+eq1Ml+s0hZ7xD0RqELEVTlsl2uJ3qXrHorjA4tzungYlTzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1Qln2Hv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc13fb0133so694395ad.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 10:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709144735; x=1709749535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsSPz7OYLkF9D7DtZ4y+G8MaKh9NFNoMFuHwtXi7FGw=;
        b=a1Qln2HvcC9g3PvRZxa2ojrd0Aw0D21tGDAtiX8KDoNXPr8+gpG8U7sbE0JfK2RCnd
         iwcEBMt4hNt6TA7YpLTxDTUsFVmyiepwbnVNFE1ogrbwRVEH8fbDvE6FcecoOFBRoL4u
         1C45YeLYfwK3YMIRosFNdHG5YIWVOUu99VklBu3kApzXOTMr8rM9qwP/hHXqR3ykaF/c
         /7mZRe6Oeu7pcSp0pd9AqT3bwoYrwlmAtzLnKbftJLLaTphf5xOMv/BoTMUpuP9VPEh1
         sF4LgafopfVwZnw6YtRI1ln3kxSxLZ3t3hX4P2JEJG1MT6K3w4tAPBdAPiqlCxh/Z6gk
         fYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709144735; x=1709749535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsSPz7OYLkF9D7DtZ4y+G8MaKh9NFNoMFuHwtXi7FGw=;
        b=i+E7/LTJb86N4nub1hgAMzww/P6IBboov/wsNR0S6yaWIJbGIKEIWChfepfH+X7uC7
         lljm6H5xm5r9hoKKNsAZlm2d/IluLGuIx+ri/7XG8+kn0M5clL/B32yhT/ZMlLN5RocQ
         iequbUbNIumhVHs9b3rnqezXFF7SwfuklVFEvnK96FSOG8lzVxjyFuHTxBGGowmp+c6t
         86uP11dcjUMuAkLVroAHpGtp197xBCHSq9aomyD4+qFYMYBRl2b8MczcftJcBbKiwIY5
         JkpAJFiCvoiYT/XDVIRUANDek0L9d/ddZNR+5j4wMWe2PhX+dBtZwfocUf2ceA8OsBSw
         Pr1A==
X-Gm-Message-State: AOJu0YyngU3/m0ybn+IuzMvU0YZE11yywVihOEEOFUBUcEELGwNMlzRz
	gSZWKUDH7foXdZc1WUiazo3pW1iMYs20EVA6jS7C6clWoEM1u4Zy5LAcaN6mB5wTgbuu5F9ntaP
	AP+TTc1pjC+q50W5JvbaKkEcpgss=
X-Google-Smtp-Source: AGHT+IFSqoxkFpABbdMcJaNzyGYmGc4xjHjCIM8X/zHPlCkM/HdSau+yh2peywu2M4/RKaPdP9MJRl1p7PFuV2NH/uk=
X-Received: by 2002:a17:902:d2cf:b0:1db:c390:1fdc with SMTP id
 n15-20020a170902d2cf00b001dbc3901fdcmr320247plc.1.1709144734621; Wed, 28 Feb
 2024 10:25:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227010432.714127-1-thinker.li@gmail.com> <20240227010432.714127-5-thinker.li@gmail.com>
In-Reply-To: <20240227010432.714127-5-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 10:25:22 -0800
Message-ID: <CAEf4BzZFdyq1U2wNP4oZJy8MZrNPhp8zXFoC7mJwu=WYx_hCkg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/6] bpftool: generated shadow variables for
 struct_ops maps.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, quentin@isovalent.com, 
	sinquersw@gmail.com, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 5:04=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.com>=
 wrote:
>
> Declares and defines a pointer of the shadow type for each struct_ops map=
.
>
> The code generator will create an anonymous struct type as the shadow typ=
e
> for each struct_ops map. The shadow type is translated from the original
> struct type of the map. The user of the skeleton use pointers of them to
> access the values of struct_ops maps.
>
> However, shadow types only supports certain types of fields, including
> scalar types and function pointers. Any fields of unsupported types are
> translated into an array of characters to occupy the space of the origina=
l
> field. Function pointers are translated into pointers of the struct
> bpf_program. Additionally, padding fields are generated to occupy the spa=
ce
> between two consecutive fields.
>
> The pointers of shadow types of struct_osp maps are initialized when
> *__open_opts() in skeletons are called. For a map called FOO, the user ca=
n
> access it through the pointer at skel->struct_ops.FOO.
>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  tools/bpf/bpftool/gen.c | 235 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 234 insertions(+), 1 deletion(-)
>

Looks pretty good overall, but I have a few stylistical nits, see below.

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index a9334c57e859..a21c92d95401 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -909,6 +909,207 @@ codegen_progs_skeleton(struct bpf_object *obj, size=
_t prog_cnt, bool populate_li
>         }
>  }
>
> +static int walk_st_ops_shadow_vars(struct btf *btf,
> +                                  const char *ident,
> +                                  const struct bpf_map *map)
> +{
> +       DECLARE_LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts,
> +                           .indent_level =3D 3,
> +                           );

DECLARE_LIBBPF_OPTS is legacy, please use shorter (but equivalent)
LIBBPF_OPTS() macro. Also formatting is a bit weird, let's do just

LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts, .indent_level =3D 3);

> +       const struct btf_type *map_type, *member_type;
> +       __u32 map_type_id, member_type_id;
> +       __u32 offset, next_offset =3D 0;
> +       const struct btf_member *m;
> +       const char *member_name;
> +       struct btf_dump *d =3D NULL;
> +       int i, err =3D 0;
> +       int size, map_size;
> +
> +       map_type_id =3D bpf_map__btf_value_type_id(map);
> +       if (map_type_id =3D=3D 0)
> +               return -EINVAL;
> +       map_type =3D btf__type_by_id(btf, map_type_id);
> +       if (!map_type)
> +               return -EINVAL;
> +
> +       d =3D btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
> +       if (!d)
> +               return -errno;
> +
> +       for (i =3D 0, m =3D btf_members(map_type);
> +            i < btf_vlen(map_type);
> +            i++, m++) {

let's move `n =3D btf_vlen(map_type)` out of for loop and keep for()
itself as a single-line

> +               member_type =3D skip_mods_and_typedefs(btf, m->type,
> +                                                    &member_type_id);

the line length limit is 100, try to keep single-lines if possible

> +               if (!member_type) {
> +                       err =3D -EINVAL;
> +                       goto out;
> +               }

this can't happen, no need to add so much error handling

> +
> +               member_name =3D btf__name_by_offset(btf, m->name_off);
> +               if (!member_name) {
> +                       err =3D -EINVAL;
> +                       goto out;
> +               }

same here, let's assume BTF is correct, no need to double-check these thing=
s

> +
> +               offset =3D m->offset / 8;
> +               if (next_offset !=3D offset) {
> +                       printf("\t\t\tchar __padding_%d[%d];\n",
> +                              i - 1, offset - next_offset);

why i-1? that will give us `__padding_-1[...]` if the very first field
is not aligned (I know, it's unlikely and hypothetical, but still).
Let's just use i as a number for simplicity.

> +               }
> +
> +               switch (btf_kind(member_type)) {
> +               case BTF_KIND_INT:
> +               case BTF_KIND_FLOAT:
> +               case BTF_KIND_ENUM:
> +               case BTF_KIND_ENUM64:
> +                       /* scalar type */
> +                       printf("\t\t\t");
> +                       opts.field_name =3D member_name;
> +                       err =3D btf_dump__emit_type_decl(d, member_type_i=
d,
> +                                                      &opts);

same nit about single lines up to 100 characters (I didn't measure if
this fits, but I hope it does)

> +                       if (err)
> +                               goto out;
> +                       printf(";\n");
> +
> +                       size =3D btf__resolve_size(btf, member_type_id);
> +                       if (size < 0) {
> +                               err =3D size;
> +                               goto out;
> +                       }
> +
> +                       next_offset =3D offset + size;
> +                       break;
> +
> +               case BTF_KIND_PTR:
> +                       if (resolve_func_ptr(btf, m->type, NULL)) {
> +                               /* Function pointer */
> +                               printf("\t\t\tconst struct bpf_program *%=
s;\n",

Why const? technically, user can call libbpf bpf_program___*() APIs on
this and adjust them before the skeleton is loaded, right? Not sure if
const buys us anything, so I'd drop it.

> +                                      member_name);
> +
> +                               next_offset =3D offset + sizeof(void *);
> +                               break;
> +                       }
> +                       /* All pointer types are unsupported except for
> +                        * function pointers.
> +                        */
> +                       fallthrough;
> +
> +               default:
> +                       /* Unsupported types
> +                        *
> +                        * Types other than scalar types and function
> +                        * pointers are currently not supported in order =
to
> +                        * prevent conflicts in the generated code caused
> +                        * by multiple definitions. For instance, if the
> +                        * struct type FOO is used in a struct_ops map,
> +                        * bpftool has to generate definitions for FOO,
> +                        * which may result in conflicts if FOO is define=
d
> +                        * in different skeleton files.
> +                        */
> +                       if (i =3D=3D btf_vlen(map_type) - 1) {
> +                               map_size =3D btf__resolve_size(btf, map_t=
ype_id);
> +                               if (map_size < 0)
> +                                       return -EINVAL;
> +                               size =3D map_size - offset;
> +                       } else {
> +                               size =3D (m[1].offset - m->offset) / 8;
> +                       }

You are trying to support both unsupported field and any necessary
padding with the same field. I think it's just confuses things. Let's
keep this part just for unsupported field (and thus use field's size),
and then any extra padding between fields or at the end of a struct
should be handled just as pure padding.

> +
> +                       printf("\t\t\tchar __padding_%d[%d];\n", i, size)=
;

should we name this `__unsupported_%d[%d]` to distinguish from
padding? It would be easier to realize that some portions are actually
not-yet-supported things and call it out, if it should be supported

> +
> +                       next_offset =3D offset + size;
> +                       break;
> +               }
> +       }

With the above remark about splitting unsupported and padding, you
need to handle remaining padding at the end of a struct here after the
loop

> +
> +out:
> +       btf_dump__free(d);
> +
> +       return err;
> +}
> +
> +/* Generate the pointer of the shadow type for a struct_ops map.
> + *
> + * This function adds a pointer of the shadow type for a struct_ops map.
> + * The members of a struct_ops map can be exported through a pointer to =
a
> + * shadow type. The user can access these members through the pointer.
> + *
> + * A shadow type includes not all members, only members of some types.
> + * They are scalar types and function pointers. The function pointers ar=
e
> + * translated to the pointer of the struct bpf_program. The scalar types
> + * are translated to the original type without any modifiers.
> + *
> + * Unsupported types will be translated to a char array to occupy the sa=
me
> + * space as the original field. However, the user should not access them
> + * directly. These unsupported fields are also renamed as __padding_*

as mentioned above, I think it's useful to have them named
__unsupported_* so that users can realize that there is something that
is unsupported

> + * . They may be reordered or shifted due to changes in the original str=
uct

nit: dot at the beginning of the line. Also the comment about "may be
reordered or shifted" is confusing, I'm not sure what the problem is.
I'd drop this part of the comment completely, I don't think anything
can be shifted/shuffled, we just don't expose some fields and replace
them with opaque bytes.

> + * type. Accessing them through the generated names may unintentionally
> + * corrupt data.
> + */
> +static int gen_st_ops_shadow_type(struct btf *btf, const char *ident,
> +                                 const struct bpf_map *map)
> +{
> +       int err;
> +
> +       printf("\t\tstruct {\n");

would it be useful to still name this type? E.g., if it is `struct
bpf_struct_ops_tcp_congestion_ops in vmlinux BTF` we can name this one
as <skeleton-name>__bpf_struct_ops_tcp_congestion_ops. We have a
similar pattern for bss/data/rodata sections, having names is useful.

> +
> +       err =3D walk_st_ops_shadow_vars(btf, ident, map);
> +       if (err)
> +               return err;
> +
> +       printf("\t\t} *%s;\n", ident);
> +
> +       return 0;
> +}
> +
> +static int gen_st_ops_shadow(struct btf *btf, struct bpf_object *obj)
> +{
> +       struct bpf_map *map;
> +       char ident[256];
> +       int err;
> +
> +       /* Generate the pointers to shadow types of
> +        * struct_ops maps.
> +        */
> +       printf("\tstruct {\n");
> +       bpf_object__for_each_map(map, obj) {
> +               if (bpf_map__type(map) !=3D BPF_MAP_TYPE_STRUCT_OPS)
> +                       continue;
> +               if (!get_map_ident(map, ident, sizeof(ident)))
> +                       continue;
> +               err =3D gen_st_ops_shadow_type(btf, ident, map);
> +               if (err)
> +                       return err;
> +       }
> +       printf("\t} struct_ops;\n");
> +
> +       return 0;
> +}
> +
> +/* Generate the code to initialize the pointers of shadow types. */
> +static void gen_st_ops_shadow_init(struct btf *btf, struct bpf_object *o=
bj)
> +{
> +       struct bpf_map *map;
> +       char ident[256];
> +
> +       /* Initialize the pointers to_ops shadow types of
> +        * struct_ops maps.
> +        */
> +       bpf_object__for_each_map(map, obj) {
> +               if (bpf_map__type(map) !=3D BPF_MAP_TYPE_STRUCT_OPS)
> +                       continue;
> +               if (!get_map_ident(map, ident, sizeof(ident)))
> +                       continue;
> +               codegen("\
> +                       \n\
> +                               obj->struct_ops.%1$s =3D                 =
     \n\
> +                                       bpf_map__initial_value(obj->maps.=
%1$s, NULL);\n\

nit: keep on single line?

> +                       \n\
> +                       ", ident);
> +       }
> +}
> +
>  static int do_skeleton(int argc, char **argv)
>  {
>         char header_guard[MAX_OBJ_NAME_LEN + sizeof("__SKEL_H__")];
> @@ -923,6 +1124,7 @@ static int do_skeleton(int argc, char **argv)
>         struct bpf_map *map;
>         struct btf *btf;
>         struct stat st;
> +       int st_ops_cnt =3D 0;
>
>         if (!REQ_ARGS(1)) {
>                 usage();
> @@ -1039,6 +1241,8 @@ static int do_skeleton(int argc, char **argv)
>                 );
>         }
>
> +       btf =3D bpf_object__btf(obj);
> +
>         if (map_cnt) {
>                 printf("\tstruct {\n");
>                 bpf_object__for_each_map(map, obj) {
> @@ -1048,8 +1252,15 @@ static int do_skeleton(int argc, char **argv)
>                                 printf("\t\tstruct bpf_map_desc %s;\n", i=
dent);
>                         else
>                                 printf("\t\tstruct bpf_map *%s;\n", ident=
);
> +                       if (bpf_map__type(map) =3D=3D BPF_MAP_TYPE_STRUCT=
_OPS)
> +                               st_ops_cnt++;
>                 }
>                 printf("\t} maps;\n");
> +               if (st_ops_cnt && btf) {
> +                       err =3D gen_st_ops_shadow(btf, obj);
> +                       if (err)
> +                               goto out;
> +               }

move it out of `if (map_cnt) { ... }` block, just like you do it in
do_subskeleton?

>         }
>
>         if (prog_cnt) {
> @@ -1075,7 +1286,6 @@ static int do_skeleton(int argc, char **argv)
>                 printf("\t} links;\n");
>         }
>
> -       btf =3D bpf_object__btf(obj);
>         if (btf) {
>                 err =3D codegen_datasecs(obj, obj_name);
>                 if (err)
> @@ -1133,6 +1343,13 @@ static int do_skeleton(int argc, char **argv)
>                         if (err)                                         =
   \n\
>                                 goto err_out;                            =
   \n\
>                                                                          =
   \n\
> +               ", obj_name);
> +
> +       if (st_ops_cnt && btf)
> +               gen_st_ops_shadow_init(btf, obj);

gen_st_ops_shadow_init() and gen_st_ops_shadow() can do st_ops_cnt
calculation inside, keeping this high-level logic a bit cleaner. Just
call `gen_st_ops_shadow_init()` unconditionally and let it do nothing
if there are no struct_ops maps (or no BTF).

> +
> +       codegen("\
> +               \n\
>                         return obj;                                      =
   \n\
>                 err_out:                                                 =
   \n\
>                         %1$s__destroy(obj);                              =
   \n\
> @@ -1296,6 +1513,7 @@ static int do_subskeleton(int argc, char **argv)
>         struct btf *btf;
>         const struct btf_type *map_type, *var_type;
>         const struct btf_var_secinfo *var;
> +       int st_ops_cnt =3D 0;
>         struct stat st;
>
>         if (!REQ_ARGS(1)) {
> @@ -1438,10 +1656,18 @@ static int do_subskeleton(int argc, char **argv)
>                         if (!get_map_ident(map, ident, sizeof(ident)))
>                                 continue;
>                         printf("\t\tstruct bpf_map *%s;\n", ident);
> +                       if (bpf_map__type(map) =3D=3D BPF_MAP_TYPE_STRUCT=
_OPS)
> +                               st_ops_cnt++;

see above, I think it can be hidden inside gen_st_ops_shadow[_init]()
functions to keep things cleaner


>                 }
>                 printf("\t} maps;\n");
>         }
>
> +       if (st_ops_cnt && btf) {
> +               err =3D gen_st_ops_shadow(btf, obj);
> +               if (err)
> +                       goto out;
> +       }
> +
>         if (prog_cnt) {
>                 printf("\tstruct {\n");
>                 bpf_object__for_each_program(prog, obj) {
> @@ -1553,6 +1779,13 @@ static int do_subskeleton(int argc, char **argv)
>                         if (err)                                         =
   \n\
>                                 goto err;                                =
   \n\
>                                                                          =
   \n\
> +               ");
> +
> +       if (st_ops_cnt && btf)
> +               gen_st_ops_shadow_init(btf, obj);
> +
> +       codegen("\
> +               \n\
>                         return obj;                                      =
   \n\
>                 err:                                                     =
   \n\
>                         %1$s__destroy(obj);                              =
   \n\
> --
> 2.34.1
>

