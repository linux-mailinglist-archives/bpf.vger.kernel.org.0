Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBD9459A77
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 04:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhKWDb3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 22:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhKWDb3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 22:31:29 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04295C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 19:28:22 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id v64so55702902ybi.5
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 19:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBucYicehroZO4TlfVit6kmUISHdU3x2IjYV10v+VS4=;
        b=E7QKHO1iDuVtoBFdrjuebpU/pVbO4IhTX1ZDuVyA4YpwUCLy3QwXMsGvTKII7udAnZ
         P75UyuEMiSYzLsprxw82MAbH9l7EnReIsSgytusddwaltXm6raRc6Tj2CWEIyz5ZW/EY
         8fDlS8yW88anERKeRbWxKMmiCvZC89AbfjzuUHFP58Wj17raWxcoShGCS4UYGen5DfEj
         d96GIpbczaXq9nbdfoeJN6Al+59XwiL7f7Bs4CuOkSJjkdS0/iFsEtIioGES9Anp+rJS
         RXru25Rwqq2atoV1aJfn+Syl3VMr5n8WyBRSOAY7t0neTHN9+xkFpcsAr8pCB3QB18bS
         iDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBucYicehroZO4TlfVit6kmUISHdU3x2IjYV10v+VS4=;
        b=1wKQ9y4zccW4FMU1RZoYCR2Gl4Xo6pvOsEs+o6IRoduLjvdLglymyF2nx12Bee9E/R
         iva1x3daD9wuUanJeKv+FuNPAZ3AaK9UsYmqbWPf8Of6zFOhqNue4j7cQs0VI/dRWvRn
         RT90P6pzwTFWhrvjQHwK2xlFf1GlXbLAs3bkgsRL57jLrem4Lck7Od7j3VupLmpuygUY
         Nz5PiJRov18Mc+2AnSG9UsMO2oaf1gchAWc2R1MWgfsf6fYYfj5Lj3gVpEZQbGk1c4Zw
         3HY8+Zr82+aTpGpwhwsRg+212ff7ZLH2waHDRHZZup2ViwfvlWyu7ybjv3Hof2UL47dK
         gLIA==
X-Gm-Message-State: AOAM530vPS4DGu/no/tYsAVQ2yrwrorz/b+02+F4M8MVIDmoUUMkp/kh
        8S9QE0FpqPVyjRfzA2OYQmwODq+bJNA0i6H5BCS7FfW2YNA=
X-Google-Smtp-Source: ABdhPJzmR/7oeCZ88as0oKLtCkSDbCevAF/e27dNogXK3QwGbvCbPHkxOFMUNIYnIRuHVdsr9M8VJrZUzJCVDpEd8bI=
X-Received: by 2002:a05:6902:68d:: with SMTP id i13mr2647646ybt.2.1637638101073;
 Mon, 22 Nov 2021 19:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20211121135440.3205482-1-hengqi.chen@gmail.com> <20211121135440.3205482-2-hengqi.chen@gmail.com>
In-Reply-To: <20211121135440.3205482-2-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Nov 2021 19:28:10 -0800
Message-ID: <CAEf4BzYMdyxe6yLw6Y4XFkN-b1xsyjs9onvvOZXvpAE1KwPgoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Support static initialization of BPF_MAP_TYPE_PROG_ARRAY
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 21, 2021 at 5:55 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Support static initialization of BPF_MAP_TYPE_PROG_ARRAY with a
> syntax similar to map-in-map initialization ([0]):
>
>     SEC("socket")
>     int tailcall_1(void *ctx)
>     {
>         return 0;
>     }
>
>     struct {
>         __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>         __uint(max_entries, 2);
>         __uint(key_size, sizeof(__u32));
>         __array(values, int (void *));
>     } prog_array_init SEC(".maps") = {
>         .values = {
>             [1] = (void *)&tailcall_1,
>         },
>     };
>
> Here's the relevant part of libbpf debug log showing what's
> going on with prog-array initialization:
>
> libbpf: sec '.relsocket': collecting relocation for section(3) 'socket'
> libbpf: sec '.relsocket': relo #0: insn #2 against 'prog_array_init'
> libbpf: prog 'entry': found map 0 (prog_array_init, sec 4, off 0) for insn #0
> libbpf: .maps relo #0: for 3 value 0 rel->r_offset 32 name 53 ('tailcall_1')
> libbpf: .maps relo #0: map 'prog_array_init' slot [1] points to prog 'tailcall_1'
> libbpf: map 'prog_array_init': created successfully, fd=5
> libbpf: map 'prog_array_init': slot [1] set to prog 'tailcall_1' fd=6
>
>   [0] Closes: https://github.com/libbpf/libbpf/issues/354
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 146 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 122 insertions(+), 24 deletions(-)
>

Just a few nits and suggestions below, but it looks great overall, thanks!

[...]

>                         t = skip_mods_and_typedefs(btf, btf_array(t)->type, NULL);
>                         if (!btf_is_ptr(t)) {
> -                               pr_warn("map '%s': map-in-map inner def is of unexpected kind %s.\n",
> -                                       map_name, btf_kind_str(t));
> +                               if (is_map_in_map)
> +                                       pr_warn("map '%s': map-in-map inner def is of unexpected kind %s.\n",
> +                                               map_name, btf_kind_str(t));
> +                               else
> +                                       pr_warn("map '%s': prog-array value def is of unexpected kind %s.\n",

maybe let's do

const char *desc = is_map_in_map ? "map-in-map inner" : "prog-array value";

and use desc in those three pr_warn() messages?

> +                                               map_name, btf_kind_str(t));
>                                 return -EINVAL;
>                         }
>                         t = skip_mods_and_typedefs(btf, t->type, NULL);
> -                       if (!btf_is_struct(t)) {
> +                       if (is_prog_array) {
> +                               if (btf_is_func_proto(t))
> +                                       return 0;

you can't return on success here, there could technically be other
fields after "values". Can you please also invert the condition so
that error handling happens first and then we continue:

if (!btf_is_func_proto(t)) {
    pr_warn(..);
    return -EINVAl;
}
continue;

It's more consistent with the other logic in this function


> +                               pr_warn("map '%s': prog-array value def is of unexpected kind %s.\n",
> +                                               map_name, btf_kind_str(t));
> +                               return -EINVAL;
> +                       }
> +                       if (is_map_in_map && !btf_is_struct(t)) {

well, it can't be anything else, so I guess drop the is_map_in_map check?

>                                 pr_warn("map '%s': map-in-map inner def is of unexpected kind %s.\n",
>                                         map_name, btf_kind_str(t));
>                                 return -EINVAL;
> @@ -4964,12 +4985,16 @@ static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)
>         unsigned int i;
>         int fd, err = 0;
>
> +       if (map->def.type == BPF_MAP_TYPE_PROG_ARRAY)
> +               return 0;

let's leave a comment that PROG_ARRAY can only be initialized once all
the programs are loaded, so this will be done later

Better still, it would be good to also rename init_map_slots to
init_map_in_map_slots and do the PROG_ARRAY check outside, in
bpf_object__create_maps(). This creates a nice symmetry with
init_prog_array (should it be named init_prog_array_slots for
consistency?). WDYT?

> +
>         for (i = 0; i < map->init_slots_sz; i++) {
>                 if (!map->init_slots[i])
>                         continue;
>
>                 targ_map = map->init_slots[i];
>                 fd = bpf_map__fd(targ_map);
> +
>                 if (obj->gen_loader) {
>                         pr_warn("// TODO map_update_elem: idx %td key %d value==map_idx %td\n",
>                                 map - obj->maps, i, targ_map - obj->maps);
> @@ -4980,8 +5005,7 @@ static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)
>                 if (err) {
>                         err = -errno;
>                         pr_warn("map '%s': failed to initialize slot [%d] to map '%s' fd=%d: %d\n",
> -                               map->name, i, targ_map->name,
> -                               fd, err);
> +                               map->name, i, targ_map->name, fd, err);
>                         return err;
>                 }
>                 pr_debug("map '%s': slot [%d] set to map '%s' fd=%d\n",
> @@ -4994,6 +5018,60 @@ static int init_map_slots(struct bpf_object *obj, struct bpf_map *map)
>         return 0;
>  }
>
> +static int init_prog_array(struct bpf_object *obj, struct bpf_map *map)
> +{
> +       const struct bpf_program *targ_prog;
> +       unsigned int i;
> +       int fd, err = 0;

you always set err, no need to zero-initialize it

> +
> +       for (i = 0; i < map->init_slots_sz; i++) {
> +               if (!map->init_slots[i])
> +                       continue;
> +
> +               targ_prog = map->init_slots[i];
> +               fd = bpf_program__fd(targ_prog);
> +
> +               if (obj->gen_loader) {
> +                       return -ENOTSUP;
> +               } else {
> +                       err = bpf_map_update_elem(map->fd, &i, &fd, 0);
> +               }
> +               if (err) {
> +                       err = -errno;
> +                       pr_warn("map '%s': failed to initialize slot [%d] to prog '%s' fd=%d: %d\n",
> +                               map->name, i, targ_prog->name, fd, err);
> +                       return err;
> +               }
> +               pr_debug("map '%s': slot [%d] set to prog '%s' fd=%d\n",
> +                        map->name, i, targ_prog->name, fd);
> +       }
> +
> +       zfree(&map->init_slots);
> +       map->init_slots_sz = 0;
> +
> +       return 0;
> +}
> +
> +static int bpf_object_init_prog_array(struct bpf_object *obj)

s/prog_array/prog_arrays/

> +{
> +       struct bpf_map *map;
> +       int i, err;
> +
> +       for (i = 0; i < obj->nr_maps; i++) {
> +               map = &obj->maps[i];
> +
> +               if (map->def.type == BPF_MAP_TYPE_PROG_ARRAY &&
> +                   map->init_slots_sz) {

nit: longer single line is fine here (but you can also invert the
condition and continue early to avoid extra level of nestedness)

> +                       err = init_prog_array(obj, map);
> +                       if (err < 0) {
> +                               zclose(map->fd);
> +                               return err;
> +                       }
> +               }
> +       }
> +       return 0;
> +}
> +
>  static int
>  bpf_object__create_maps(struct bpf_object *obj)
>  {
> @@ -6174,7 +6252,9 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
>         int i, j, nrels, new_sz;
>         const struct btf_var_secinfo *vi = NULL;
>         const struct btf_type *sec, *var, *def;
> -       struct bpf_map *map = NULL, *targ_map;
> +       struct bpf_map *map = NULL, *targ_map = NULL;
> +       struct bpf_program *targ_prog = NULL;
> +       bool is_prog_array, is_map_in_map;
>         const struct btf_member *member;
>         const char *name, *mname;
>         unsigned int moff;
> @@ -6203,11 +6283,6 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
>                         return -LIBBPF_ERRNO__FORMAT;
>                 }
>                 name = elf_sym_str(obj, sym->st_name) ?: "<?>";
> -               if (sym->st_shndx != obj->efile.btf_maps_shndx) {
> -                       pr_warn(".maps relo #%d: '%s' isn't a BTF-defined map\n",
> -                               i, name);
> -                       return -LIBBPF_ERRNO__RELOC;
> -               }
>
>                 pr_debug(".maps relo #%d: for %zd value %zd rel->r_offset %zu name %d ('%s')\n",
>                          i, (ssize_t)(rel->r_info >> 32), (size_t)sym->st_value,
> @@ -6229,8 +6304,20 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
>                         return -EINVAL;
>                 }
>
> -               if (!bpf_map_type__is_map_in_map(map->def.type))
> +               is_map_in_map = bpf_map_type__is_map_in_map(map->def.type);
> +               is_prog_array = map->def.type == BPF_MAP_TYPE_PROG_ARRAY;
> +               if (!is_map_in_map && !is_prog_array)
>                         return -EINVAL;
> +               if (is_map_in_map && sym->st_shndx != obj->efile.btf_maps_shndx) {
> +                       pr_warn(".maps relo #%d: '%s' isn't a BTF-defined map\n",
> +                               i, name);
> +                       return -LIBBPF_ERRNO__RELOC;
> +               }
> +               if (is_prog_array && !bpf_object__find_program_by_name(obj, name)) {

let's do an additional check on the program you found with find_program_by_name:

  1. prog->sec_idx == sym->st_shndx
  2. prog->sec_insn_off * 8 == sym->st_value
  3. !prog_is_subprog(obj, prog)

This will make sure you have the correct entry-point BPF program (not
a subprog) and we point to its beginning (no offset into the program).


> +                       pr_warn(".maps relo #%d: '%s' isn't a BPF program\n",

"entry-point" is an important distinction, please mention that. You
can't put sub-programs into PROG_ARRAY.

> +                               i, name);
> +                       return -LIBBPF_ERRNO__RELOC;
> +               }
>                 if (map->def.type == BPF_MAP_TYPE_HASH_OF_MAPS &&
>                     map->def.key_size != sizeof(int)) {
>                         pr_warn(".maps relo #%d: hash-of-maps '%s' should have key size %zu.\n",
> @@ -6238,9 +6325,15 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
>                         return -EINVAL;
>                 }
>
> -               targ_map = bpf_object__find_map_by_name(obj, name);
> -               if (!targ_map)
> -                       return -ESRCH;
> +               if (is_map_in_map) {
> +                       targ_map = bpf_object__find_map_by_name(obj, name);
> +                       if (!targ_map)
> +                               return -ESRCH;
> +               } else {
> +                       targ_prog = bpf_object__find_program_by_name(obj, name);
> +                       if (!targ_prog)
> +                               return -ESRCH;
> +               }
>
>                 var = btf__type_by_id(obj->btf, vi->type);
>                 def = skip_mods_and_typedefs(obj->btf, var->type, NULL);
> @@ -6272,10 +6365,14 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
>                                (new_sz - map->init_slots_sz) * host_ptr_sz);
>                         map->init_slots_sz = new_sz;
>                 }
> -               map->init_slots[moff] = targ_map;
> +               map->init_slots[moff] = is_map_in_map ? (void *)targ_map : (void *)targ_prog;
>
> -               pr_debug(".maps relo #%d: map '%s' slot [%d] points to map '%s'\n",
> -                        i, map->name, moff, name);
> +               if (is_map_in_map)
> +                       pr_debug(".maps relo #%d: map '%s' slot [%d] points to map '%s'\n",
> +                                i, map->name, moff, name);
> +               else
> +                       pr_debug(".maps relo #%d: map '%s' slot [%d] points to prog '%s'\n",
> +                                i, map->name, moff, name);

similar as above `is_map_in_map ? "map" : "prog"` will keep it short
and not duplicated


>         }
>
>         return 0;
> @@ -7293,6 +7390,7 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
>         err = err ? : bpf_object__create_maps(obj);
>         err = err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : attr->target_btf_path);
>         err = err ? : bpf_object__load_progs(obj, attr->log_level);
> +       err = err ? : bpf_object_init_prog_array(obj);
>
>         if (obj->gen_loader) {
>                 /* reset FDs */
> --
> 2.30.2
