Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0C44CB48E
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 02:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiCCBrK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 20:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiCCBrI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 20:47:08 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F691B6E0A
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 17:46:23 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id t11so4127706ioi.7
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 17:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uRmh59C62LguyCZekkJ3qE7+Z4hMAzhr28yr3XMNPdY=;
        b=E0JHJNHXD9pBeUiHtOAdyGaOC/bDM6XksPDUhog/3pgAdOigQ3oYNJVpRELnV+ebw7
         EkNYPUqh0NqpiZH1lqYX34LxDDygTXLiEEcQu+dxukwcj4ldGQlhhQODnQoxh+/TCSK6
         UD1BEXFEoUadPOdD5KEW7XqwDSTwzzAssp91gguHsOr90o/stNp2b0Q7pTUSz3TLoDAZ
         j4BJOSzN59zcmoPYlCRsBBIftVT2qvFum4coGf6z2CMJj+sstHER2uwLdvs0zw2TdEPd
         yi0yq1oGiHByXzg08Qh3q2ajRU1mnQ0znHFyDZK3jRPUsMxFHhS+RGkdpwz3fsw1Cnvt
         pXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uRmh59C62LguyCZekkJ3qE7+Z4hMAzhr28yr3XMNPdY=;
        b=46wg/n+PZRf+iZcKQOI9EVhYpRE5DDoOPo4h+p9+NHNfB2AOuzUgi5gq09KrGW1fYy
         DAfrM+wo5yQo0YoMcU05/Spe/6oJOFDnGby0mwybc/u5SSi71r4LLfAGAmekTqq35jti
         v50rRDRYIXWzzr6bvnS5TKslw+qf8jXFugjKqMZRZZFlpJfgBgSGamxW4C3mzSNwBUtS
         WugWQ47fCzxvXkegaflrxciMYNuFJ4a4VzFpWqguxphPcWaE/DFqN3x8JHs2ck2r1TYb
         mMF5VfufwzfanZFWcxov9jDF1QviA2zQVL3BymBHprLQeAjcN7AqvxKdI8OejfkMq7YF
         GxIA==
X-Gm-Message-State: AOAM5317jWBur55gMNPSuRNNxV8JpzoCWtCUfd2VRmnwXnFZ0OSOKLuE
        tQD4humzZ/8mBEHZV2VbO034JnIHz/auxHWkdvc=
X-Google-Smtp-Source: ABdhPJzFmY2ED5qC0M02N+u2YSDENKxFhjjJrTq1r6aOJaKz0lVJoxpEBQyoMJLz4YhnezmQx9mwO24dUuKDbtIsT5c=
X-Received: by 2002:a05:6602:210c:b0:640:7616:d93a with SMTP id
 x12-20020a056602210c00b006407616d93amr24847989iox.154.1646271983204; Wed, 02
 Mar 2022 17:46:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1646188795.git.delyank@fb.com> <a679538775e08c6f7686c2aec201589b47eda483.1646188795.git.delyank@fb.com>
In-Reply-To: <a679538775e08c6f7686c2aec201589b47eda483.1646188795.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Mar 2022 17:46:11 -0800
Message-ID: <CAEf4BzZzAToLHESKrddn2y1FoLHHUVGzJe7=1ih0E3EA7BBdHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpftool: add support for subskeletons
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 1, 2022 at 6:49 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> Subskeletons are headers which require an already loaded program to
> operate.
>
> For example, when a BPF library is linked into a larger BPF object file,
> the library userspace needs a way to access its own global variables
> without requiring knowledge about the larger program at build time.
>
> As a result, subskeletons require a loaded bpf_object to open().
> Further, they find their own symbols in the larger program by
> walking BTF type data at run time.
>
> At this time, only globals are supported, though non-owning references
> to links, programs, and other objects may be added as the needs arise.

There is a need (I needed it in libusdt, for example). Let's add it
from the very beginning, especially that it can be done in *exactly*
the same form as for skeletons.

>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  tools/bpf/bpftool/gen.c | 322 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 313 insertions(+), 9 deletions(-)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 145734b4fe41..ea292e09c17b 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -125,14 +125,14 @@ static int codegen_datasec_def(struct bpf_object *obj,
>                                struct btf *btf,
>                                struct btf_dump *d,
>                                const struct btf_type *sec,
> -                              const char *obj_name)
> +                              const char *obj_name,
> +                              bool subskel)

seems like subskel's datasec codegen is considerably different (and
simpler, really) than skeleton's, I'd add a separate function for it
instead of all this if (subskel) special-casing. Main concern for
skeleton is generating correct memory layout, while for subskel we
just need to generate a list of pointers without any regard to memory
layout.

>  {
>         const char *sec_name = btf__name_by_offset(btf, sec->name_off);
>         const struct btf_var_secinfo *sec_var = btf_var_secinfos(sec);
>         int i, err, off = 0, pad_cnt = 0, vlen = btf_vlen(sec);
>         char var_ident[256], sec_ident[256];
>         bool strip_mods = false;
> -

why? there should be an empty line between variable block and first statement

>         if (!get_datasec_ident(sec_name, sec_ident, sizeof(sec_ident)))
>                 return 0;
>
> @@ -183,7 +183,7 @@ static int codegen_datasec_def(struct bpf_object *obj,
>                         align = 4;
>
>                 align_off = (off + align - 1) / align * align;
> -               if (align_off != need_off) {
> +               if (align_off != need_off && !subskel) {
>                         printf("\t\tchar __pad%d[%d];\n",
>                                pad_cnt, need_off - off);
>                         pad_cnt++;
> @@ -197,6 +197,15 @@ static int codegen_datasec_def(struct bpf_object *obj,
>                 strncat(var_ident, var_name, sizeof(var_ident) - 1);
>                 sanitize_identifier(var_ident);
>
> +               /* to emit a pointer to the type in the map, we need to
> +                * make sure our btf has that pointer type first.
> +                */
> +               if (subskel) {
> +                       var_type_id = btf__add_ptr(btf, var_type_id);
> +                       if (var_type_id < 0)
> +                               return var_type_id;
> +               }
> +

it's unfortunate to have to modify original BTF just to have this '*'
added.  If I remember correctly, C syntax for pointers has special
case only for arrays and func prototypes, so it should work with this
logic (not tested, obviously)

1. if top variable type is array or func_proto, set var_ident to "(*<variable>)"
2. otherwise set var_ident to "*<variable>"

we'd need to test it for array and func_proto, but it definitely
should work for all other cases


>                 printf("\t\t");
>                 err = btf_dump__emit_type_decl(d, var_type_id, &opts);
>                 if (err)
> @@ -205,7 +214,10 @@ static int codegen_datasec_def(struct bpf_object *obj,
>
>                 off = sec_var->offset + sec_var->size;
>         }
> -       printf("        } *%s;\n", sec_ident);
> +       if (subskel)
> +               printf("        } %s;\n", sec_ident);
> +       else
> +               printf("        } *%s;\n", sec_ident);
>         return 0;
>  }
>
> @@ -231,7 +243,7 @@ static const struct btf_type *find_type_for_map(struct btf *btf, const char *map
>         return NULL;
>  }
>
> -static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
> +static int codegen_datasecs(struct bpf_object *obj, const char *obj_name, bool subskel)
>  {
>         struct btf *btf = bpf_object__btf(obj);
>         struct btf_dump *d;
> @@ -240,6 +252,13 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
>         char map_ident[256];
>         int err = 0;
>
> +       /* When generating a subskeleton, we need to emit _pointers_
> +        * to the types in the maps. Use a new btf object as storage for these
> +        * new types as they're not guaranteed to already exist.
> +        */
> +       if (subskel)
> +               btf = btf__new_empty_split(btf);
> +
>         d = btf_dump__new(btf, codegen_btf_dump_printf, NULL, NULL);
>         err = libbpf_get_error(d);
>         if (err)
> @@ -264,11 +283,11 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
>                  * map. It will still be memory-mapped and its contents
>                  * accessible from user-space through BPF skeleton.
>                  */
> -               if (!sec) {
> +               if (!sec && !subskel) {
>                         printf("        struct %s__%s {\n", obj_name, map_ident);
>                         printf("        } *%s;\n", map_ident);
> -               } else {
> -                       err = codegen_datasec_def(obj, btf, d, sec, obj_name);
> +               } else if (sec) {
> +                       err = codegen_datasec_def(obj, btf, d, sec, obj_name, subskel);
>                         if (err)
>                                 goto out;
>                 }
> @@ -276,6 +295,8 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
>
>
>  out:
> +       if (subskel)
> +               btf__free(btf);
>         btf_dump__free(d);
>         return err;
>  }
> @@ -896,7 +917,7 @@ static int do_skeleton(int argc, char **argv)
>
>         btf = bpf_object__btf(obj);
>         if (btf) {
> -               err = codegen_datasecs(obj, obj_name);
> +               err = codegen_datasecs(obj, obj_name, false);
>                 if (err)
>                         goto out;
>         }
> @@ -1141,6 +1162,287 @@ static int do_skeleton(int argc, char **argv)
>         return err;
>  }
>
> +/* Subskeletons are like skeletons, except they don't own the bpf_object,
> + * associated maps, links, etc. Instead, they know about the existence of
> + * a certain number of datasec fields and are able to find their locations
> + * _at runtime_ from an already loaded bpf_object.
> + *
> + * This allows for library-like BPF objects to have userspace counterparts
> + * with access to their globals without having to know anything about the
> + * final BPF object that the library was linked into.
> + */
> +static int do_subskeleton(int argc, char **argv)
> +{
> +       char header_guard[MAX_OBJ_NAME_LEN + sizeof("__SKEL_H__")];

use __SUBSKEL_H__ here?

> +       size_t i, len, file_sz, mmap_sz, sym_sz = 0, sym_idx = 0;
> +       DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
> +       char obj_name[MAX_OBJ_NAME_LEN] = "", *obj_data;
> +       struct bpf_object *obj = NULL;
> +       const char *file, *var_name;
> +       char ident[256], var_ident[256];
> +       int fd, err = -1, map_type_id;
> +       const struct bpf_map *map;
> +       struct btf *btf;
> +       const struct btf_type *map_type, *var_type;
> +       const struct btf_var_secinfo *var;
> +       struct stat st;
> +
> +       if (!REQ_ARGS(1)) {
> +               usage();
> +               return -1;
> +       }
> +       file = GET_ARG();
> +
> +       while (argc) {
> +               if (!REQ_ARGS(2))
> +                       return -1;
> +
> +               if (is_prefix(*argv, "name")) {
> +                       NEXT_ARG();
> +
> +                       if (obj_name[0] != '\0') {
> +                               p_err("object name already specified");
> +                               return -1;
> +                       }
> +
> +                       strncpy(obj_name, *argv, MAX_OBJ_NAME_LEN - 1);
> +                       obj_name[MAX_OBJ_NAME_LEN - 1] = '\0';

we should probably force obj_name to be an empty string, so that all
map names match their proper section names

> +               } else {
> +                       p_err("unknown arg %s", *argv);
> +                       return -1;
> +               }
> +
> +               NEXT_ARG();
> +       }
> +
> +       if (argc) {
> +               p_err("extra unknown arguments");
> +               return -1;
> +       }
> +
> +       if (use_loader) {
> +               p_err("cannot use loader for subskeletons");
> +               return -1;
> +       }
> +
> +       if (stat(file, &st)) {
> +               p_err("failed to stat() %s: %s", file, strerror(errno));
> +               return -1;
> +       }
> +       file_sz = st.st_size;
> +       mmap_sz = roundup(file_sz, sysconf(_SC_PAGE_SIZE));
> +       fd = open(file, O_RDONLY);
> +       if (fd < 0) {
> +               p_err("failed to open() %s: %s", file, strerror(errno));
> +               return -1;
> +       }
> +       obj_data = mmap(NULL, mmap_sz, PROT_READ, MAP_PRIVATE, fd, 0);
> +       if (obj_data == MAP_FAILED) {
> +               obj_data = NULL;
> +               p_err("failed to mmap() %s: %s", file, strerror(errno));
> +               goto out;
> +       }
> +       if (obj_name[0] == '\0')
> +               get_obj_name(obj_name, file);
> +       opts.object_name = obj_name;
> +       if (verifier_logs)
> +               /* log_level1 + log_level2 + stats, but not stable UAPI */
> +               opts.kernel_log_level = 1 + 2 + 4;

hm.. we shouldn't need this, we are not loading anything into kernel
and don't use light skeleton

> +       obj = bpf_object__open_mem(obj_data, file_sz, &opts);
> +       err = libbpf_get_error(obj);

no need for libbpf_get_error() anymore, bpftool is in libbpf 1.0 mode,
so it will get NULL on error and error itself will be in errno

> +       if (err) {
> +               char err_buf[256];
> +
> +               libbpf_strerror(err, err_buf, sizeof(err_buf));
> +               p_err("failed to open BPF object file: %s", err_buf);
> +               obj = NULL;
> +               goto out;
> +       }
> +
> +       btf = bpf_object__btf(obj);
> +       err = libbpf_get_error(btf);

same

> +       if (err) {
> +               err = -1;
> +               p_err("need btf type information for %s", obj_name);
> +               goto out;
> +       }
> +
> +       /* First, count how many symbols we have to link. */
> +       bpf_object__for_each_map(map, obj) {
> +               if (!bpf_map__is_internal(map))
> +                       continue;
> +
> +               if (!(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
> +                       continue;
> +
> +               if (!get_map_ident(map, ident, sizeof(ident)))
> +                       continue;
> +
> +               map_type_id = btf__find_by_name_kind(btf, bpf_map__section_name(map), BTF_KIND_DATASEC);

if we set obj_name to "", bpf_map__name() should return ELF section
name here, so no need to expose this as an API


oh, but also bpf_map__btf_value_type_id() should give you this ID directly


> +               if (map_type_id < 0) {
> +                       err = map_type_id;
> +                       goto out;
> +               }
> +               map_type = btf__type_by_id(btf, map_type_id);
> +
> +               for (i = 0, var = btf_var_secinfos(map_type), len = btf_vlen(map_type);
> +                    i < len;
> +                    i++, var++) {

nit: move those long one-time assignments out of the for() loop and
keep it single-line?

> +                       sym_sz++;
> +               }
> +       }
> +
> +       get_header_guard(header_guard, obj_name);
> +       codegen("\
> +       \n\
> +       /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */   \n\
> +                                                                   \n\
> +       /* THIS FILE IS AUTOGENERATED! */                           \n\
> +       #ifndef %2$s                                                \n\
> +       #define %2$s                                                \n\
> +                                                                   \n\
> +       #include <errno.h>                                          \n\
> +       #include <stdlib.h>                                         \n\
> +       #include <bpf/libbpf.h>                                     \n\
> +                                                                   \n\
> +       struct %1$s {                                               \n\
> +               struct bpf_object *obj;                             \n\
> +               struct bpf_object_subskeleton *subskel;             \n\
> +       ", obj_name, header_guard);
> +
> +       err = codegen_datasecs(obj, obj_name, true);
> +       if (err)
> +               goto out;
> +
> +       /* emit code that will allocate enough storage for all symbols */
> +       codegen("\
> +               \n\
> +                                                                           \n\
> +               #ifdef __cplusplus                                          \n\
> +                       static inline struct %1$s *open(const struct bpf_object *src);\n\
> +                       static inline void %1$s::destroy(struct %1$s *skel);\n\
> +               #endif /* __cplusplus */                                    \n\
> +               };                                                          \n\
> +                                                                           \n\
> +               static inline void                                          \n\
> +               %1$s__destroy(struct %1$s *skel)                            \n\
> +               {                                                           \n\
> +                       if (!skel)                                          \n\
> +                               return;                                     \n\
> +                       if (skel->subskel)                                  \n\
> +                               bpf_object__destroy_subskeleton(skel->subskel);\n\
> +                       free(skel);                                         \n\
> +               }                                                           \n\
> +                                                                           \n\
> +               static inline struct %1$s *                                 \n\
> +               %1$s__open(const struct bpf_object *src)                    \n\
> +               {                                                           \n\
> +                       struct %1$s *obj;                                   \n\
> +                       struct bpf_object_subskeleton *subskel;             \n\
> +                       struct bpf_sym_skeleton *syms;                      \n\
> +                       int err;                                            \n\
> +                                                                           \n\
> +                       obj = (struct %1$s *)calloc(1, sizeof(*obj));       \n\
> +                       if (!obj) {                                         \n\
> +                               errno = ENOMEM;                             \n\
> +                               return NULL;                                \n\
> +                       }                                                   \n\
> +                       subskel = (struct bpf_object_subskeleton *)calloc(1, sizeof(*subskel));\n\
> +                       if (!subskel) {                                     \n\
> +                               errno = ENOMEM;                             \n\
> +                               return NULL;                                \n\

leaking obj here

> +                       }                                                   \n\
> +                       subskel->sz = sizeof(*subskel);                     \n\
> +                       subskel->obj = src;                                 \n\
> +                       subskel->sym_skel_sz = sizeof(struct bpf_sym_skeleton); \n\
> +                       subskel->sym_cnt = %2$d;                            \n\
> +                       obj->subskel = subskel;                             \n\
> +                                                                           \n\
> +                       syms = (struct bpf_sym_skeleton *)calloc(%2$d, sizeof(*syms));\n\
> +                       if (!syms) {                                        \n\
> +                               free(subskel);                              \n\
> +                               errno = ENOMEM;                             \n\
> +                               return NULL;                                \n\

same, obj is leaked


> +                       }                                                   \n\
> +                       subskel->syms = syms;                               \n\
> +                                                                           \n\
> +               ",
> +               obj_name, sym_sz
> +       );
> +
> +       /* walk through each symbol and emit the runtime representation
> +        */

nit: keep this comment single-lined?

> +       bpf_object__for_each_map(map, obj) {
> +               if (!bpf_map__is_internal(map))
> +                       continue;
> +
> +               if (!(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
> +                       continue;
> +
> +               if (!get_map_ident(map, ident, sizeof(ident)))
> +                       continue;

this sequence of ifs seems so frequently repeated that it's probably
time to add a helper function?

> +
> +               map_type_id = btf__find_by_name_kind(btf, bpf_map__section_name(map), BTF_KIND_DATASEC);
> +               if (map_type_id < 0) {
> +                       err = map_type_id;
> +                       goto out;
> +               }
> +               map_type = btf__type_by_id(btf, map_type_id);
> +
> +               for (i = 0, var = btf_var_secinfos(map_type), len = btf_vlen(map_type);
> +                    i < len;
> +                    i++, var++, sym_idx++) {

similar as above, var and len assignment doesn't have to inside the for

> +                       var_type = btf__type_by_id(btf, var->type);
> +                       var_name = btf__name_by_offset(btf, var_type->name_off);
> +
> +                       var_ident[0] = '\0';
> +                       strncat(var_ident, var_name, sizeof(var_ident) - 1);
> +                       sanitize_identifier(var_ident);
> +
> +                       codegen("\
> +                       \n\
> +                               syms[%4$d].name = \"%1$s\";                 \n\
> +                               syms[%4$d].section = \"%3$s\";              \n\
> +                               syms[%4$d].addr = (void**) &obj->%2$s.%1$s; \n\
> +                       ", var_ident, ident, bpf_map__section_name(map), sym_idx);
> +               }
> +       }

why not assign subskel->sym_cnt here using sym_idx and avoid that
extra loop over all variables above?


> +
> +       codegen("\
> +               \n\
> +                                                                           \n\
> +                       err = bpf_object__open_subskeleton(subskel);        \n\
> +                       if (err) {                                          \n\
> +                               %1$s__destroy(obj);                         \n\
> +                               errno = err;                                \n\
> +                               return NULL;                                \n\
> +                       }                                                   \n\
> +                                                                           \n\
> +                       return obj;                                         \n\
> +               }                                                           \n\
> +               ",
> +               obj_name);
> +
> +       codegen("\
> +               \n\
> +                                                                           \n\
> +               #ifdef __cplusplus                                          \n\
> +               struct %1$s *%1$s::open(const struct bpf_object *src) { return %1$s__open(src); }\n\
> +               void %1$s::destroy(struct %1$s *skel) { %1$s__destroy(skel); }\n\
> +               #endif /* __cplusplus */                                    \n\
> +                                                                           \n\
> +               #endif /* %2$s */                                           \n\
> +               ",
> +               obj_name, header_guard);
> +       err = 0;
> +out:
> +       bpf_object__close(obj);
> +       if (obj_data)
> +               munmap(obj_data, mmap_sz);
> +       close(fd);
> +       return err;
> +}
> +
>  static int do_object(int argc, char **argv)
>  {
>         struct bpf_linker *linker;
> @@ -1192,6 +1494,7 @@ static int do_help(int argc, char **argv)
>         fprintf(stderr,
>                 "Usage: %1$s %2$s object OUTPUT_FILE INPUT_FILE [INPUT_FILE...]\n"
>                 "       %1$s %2$s skeleton FILE [name OBJECT_NAME]\n"
> +               "       %1$s %2$s subskeleton FILE [name OBJECT_NAME]\n"

Quentin will remind you that you should also update the man page and
bash completion script :)

>                 "       %1$s %2$s min_core_btf INPUT OUTPUT OBJECT [OBJECT...]\n"
>                 "       %1$s %2$s help\n"
>                 "\n"
> @@ -1788,6 +2091,7 @@ static int do_min_core_btf(int argc, char **argv)
>  static const struct cmd cmds[] = {
>         { "object",             do_object },
>         { "skeleton",           do_skeleton },
> +       { "subskeleton",        do_subskeleton },
>         { "min_core_btf",       do_min_core_btf},
>         { "help",               do_help },
>         { 0 }
> --
> 2.34.1
