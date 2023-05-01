Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95326F3B18
	for <lists+bpf@lfdr.de>; Tue,  2 May 2023 01:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjEAXvN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 19:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjEAXts (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 19:49:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CE9358B
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 16:49:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc1612940so4188829a12.2
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 16:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682984985; x=1685576985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSlhJ/TyuBzqDd6DHaIJvFj1/Uwb11k4H8GCkK10T1A=;
        b=ZMA3IRMykEUY2OGsejq2ldv7FlAj4rI344xwro4Ptxp5DiK0CK7AyZN5NK3VdQeaed
         ilMdHkga+/4T4RxzXpc7ZomhJWlFBiHOjC6NAOQg/JhNTjU/mRI//upuD17auI1bHvXy
         sDMJI8oLnbdsxDFNoRHNJph5CneKPrR46V0Jhlv4HMv9DVsZgINP5Bq8ShTfEpiB7uWg
         u9NSOs8gDzrXDe62YVjFAOGd7nrrAZhrInQZ2e77HnO2UJxY8OuQGPT9ryoJ7MZNMsgk
         cWPz4s+2EOnQgA7S60Sp7YcO2IbHSfsgJ8610U3MynPK1tOvw6t3YqEHBBNHztKjhDSz
         f8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682984985; x=1685576985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSlhJ/TyuBzqDd6DHaIJvFj1/Uwb11k4H8GCkK10T1A=;
        b=eJiMryJb/YAqZpCmNzdGNhmDnpqkcAB676rDuj/83gGhgjzeVS88A1IZ2f8rzw1FUp
         m+ylvpZzrLiyoT3HlSjp9bme5hWCIcILjfdjUAjM5VGE8bTdT2n19p/fXuzDCTeklLxN
         jpdQ5BxLOfdpJqbYifJRtYubVr7IQ2NokmbTqEplWKgsKOJ8JFAWtxJsxdFKRMIjA/YE
         zCkh9kbqmsS7HXeNOyO4e/+iBi2NVHR1/LyHZMNQYYAOLFo9341lv/YqzZR7ZkmB7STl
         GQndLFt5NBNFhsA1wtLPHHe/OJBJT2RB7LqDICdaOL08V7A9bITCXc3MNTq92G95lXfL
         D1iQ==
X-Gm-Message-State: AC+VfDyShIWboQEju5LOFhDNXax4XQSoAFIJiu5LWe257jTtkp1g9Iit
        tdVuv9lWsjxVhHUIgT5DJN5BqPvwATJ16krpgSQaK6of+9k=
X-Google-Smtp-Source: ACHHUZ7a1KDJ7ZWaqAc6zvXrcE79JKKQEnfGe5RlBts0CtIbll4qzlx5ic3YNbcqFLHmpf4+3GC/IDpkit8PBTFXikE=
X-Received: by 2002:a05:6402:12ce:b0:50b:c72a:2b1b with SMTP id
 k14-20020a05640212ce00b0050bc72a2b1bmr3217051edx.19.1682984985148; Mon, 01
 May 2023 16:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230428222754.183432-1-inwardvessel@gmail.com> <20230428222754.183432-2-inwardvessel@gmail.com>
In-Reply-To: <20230428222754.183432-2-inwardvessel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 May 2023 16:49:33 -0700
Message-ID: <CAEf4BzZxpaBfBTD0Lz14k1sWSBJ9WqzHvgbWeci6=DE37uG=JA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add capability for resizing datasec maps
To:     JP Kobryn <inwardvessel@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 28, 2023 at 3:28=E2=80=AFPM JP Kobryn <inwardvessel@gmail.com> =
wrote:
>
> This patch updates bpf_map__set_value_size() so that if the given map is =
a
> datasec, it will attempt to resize it. If the following criteria is met,
> the resizing can be performed:
>  - BTF info is present
>  - the map is a datasec
>  - the datasec contains a single variable
>  - the single variable is an array
>

I think it's too restrictive to require all these conditions just to
be able to resize the map. I'd prefer if libbpf allowed user to resize
a map in any case, but if there is BTF information, libbpf will
helpfully adjust it as necessary.

> The new map_datasec_resize() function is used to perform the resizing
> of the associated memory mapped region and adjust BTF so that the origina=
l
> array variable points to a new BTF array that is sized to cover the
> requested size. The new array size will be rounded up to a multiple of
> the element size.
>
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 138 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 138 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1cbacf9e71f3..991649cacc10 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9412,12 +9412,150 @@ __u32 bpf_map__value_size(const struct bpf_map *=
map)
>         return map->def.value_size;
>  }
>
> +static bool map_is_datasec(struct bpf_map *map)
> +{
> +       struct btf *btf;
> +       struct btf_type *map_type;
> +
> +       btf =3D bpf_object__btf(map->obj);
> +       if (!btf)
> +               return false;
> +
> +       map_type =3D btf_type_by_id(btf, bpf_map__btf_value_type_id(map))=
;
> +
> +       return btf_is_datasec(map_type);
> +}
> +
> +static int map_datasec_resize(struct bpf_map *map, __u32 size)
> +{
> +       int err;
> +       struct btf *btf;
> +       struct btf_type *datasec_type, *var_type, *resolved_type, *array_=
element_type;
> +       struct btf_var_secinfo *var;
> +       struct btf_array *array;
> +       __u32 resolved_id, new_array_id;
> +       __u32 rounded_sz;
> +       __u32 nr_elements;
> +       __u32 old_value_sz =3D map->def.value_size;
> +       size_t old_mmap_sz, new_mmap_sz;
> +
> +       /* btf is required and datasec map must be memory mapped */

as I mentioned above, I'd structure logic to take advantage and adjust
BTF, but not necessarily block the operation

> +       btf =3D bpf_object__btf(map->obj);
> +       if (!btf) {
> +               pr_warn("cannot resize datasec map '%s' while btf info is=
 not present\n",
> +                               bpf_map__name(map));
> +

nit: let's not have unnecessary empty lines (here and below in many places)

another nit: see other pr_warn()s when something happens with map, we
have relatively consistent "map '%s': <message>" pattern, so let's
follow it here for error messages

> +               return -EINVAL;
> +       }
> +
> +       datasec_type =3D btf_type_by_id(btf, bpf_map__btf_value_type_id(m=
ap));
> +       if (!btf_is_datasec(datasec_type)) {
> +               pr_warn("attempted to resize datasec map '%s' but map is =
not a datasec\n",
> +                               bpf_map__name(map));
> +
> +               return -EINVAL;
> +       }
> +
> +       if (!map->mmaped) {
> +               pr_warn("cannot resize datasec map '%s' while map is unex=
pectedly not memory mapped\n",
> +                               bpf_map__name(map));
> +
> +               return -EINVAL;
> +       }
> +
> +       /* datasec must only have a single variable */
> +       if (btf_vlen(datasec_type) !=3D 1) {

so I've been thinking about case like this:

int my_var;
int my_arr[1]; /* should scale to number of CPUs */

I don't see why we wouldn't allow to resize this to 4 + cpu_cnt * 4
size. I don't think it will complicate anything, we just take last
member of DATASEC, it's offset + N * sizeof(array element)


> +               pr_warn("cannot resize datasec map '%s' that does not con=
sist of a single var\n",
> +                               bpf_map__name(map));
> +
> +               return -EINVAL;
> +       }
> +
> +       /* the single variable has to be an array */
> +       var =3D btf_var_secinfos(datasec_type);
> +       resolved_id =3D btf__resolve_type(btf, var->type);

use skip_mods_and_typedefs to skip mods and typedefs?
btf__resolve_type() does more than what you want here

> +       resolved_type =3D btf_type_by_id(btf, resolved_id);
> +       if (!btf_is_array(resolved_type)) {
> +               pr_warn("cannot resize datasec map '%s' whose single var =
is not an array\n",
> +                               bpf_map__name(map));
> +
> +               return -EINVAL;
> +       }
> +
> +       /* create a new array based on the existing array but with new le=
ngth,
> +        * rounding up the requested size for alignment
> +        */
> +       array =3D btf_array(resolved_type);
> +       array_element_type =3D btf_type_by_id(btf, array->type);
> +       rounded_sz =3D roundup(size, array_element_type->size);

let's not do auto-rounding, user should know what they are doing, and
if they get calculation wrong, better return explicit error than try
to guess what user actually wanted

> +       nr_elements =3D rounded_sz / array_element_type->size;
> +       new_array_id =3D btf__add_array(btf, array->index_type, array->ty=
pe,
> +                       nr_elements);
> +       if (new_array_id < 0) {
> +               pr_warn("failed to resize datasec map '%s' due to failure=
 in creating new array\n",
> +                               bpf_map__name(map));
> +               err =3D new_array_id;
> +
> +               goto fail_array;
> +       }
> +
> +       /* adding a new btf type invalidates existing pointers to btf obj=
ects.
> +        * refresh pointers before proceeding
> +        */
> +       datasec_type =3D btf_type_by_id(btf, map->btf_value_type_id);
> +       var =3D btf_var_secinfos(datasec_type);
> +       var_type =3D btf_type_by_id(btf, var->type);
> +
> +       /* remap the associated memory */
> +       old_value_sz =3D map->def.value_size;
> +       old_mmap_sz =3D bpf_map_mmap_sz(map);
> +       map->def.value_size =3D rounded_sz;
> +       new_mmap_sz =3D bpf_map_mmap_sz(map);
> +
> +       if (munmap(map->mmaped, old_mmap_sz)) {
> +               err =3D -errno;
> +               pr_warn("failed to resize datasec map '%s' due to failure=
 in munmap(), err:%d\n",
> +                        bpf_map__name(map), err);
> +
> +               goto fail_mmap;
> +       }
> +
> +       map->mmaped =3D mmap(NULL, new_mmap_sz, PROT_READ | PROT_WRITE,
> +                  MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +       if (map->mmaped =3D=3D MAP_FAILED) {

let's mmap new memory first, and only if that succeeds unmap old one?
Plus, we need to preserve initial values that might have been set
through BPF skeleton or bpf_map__set_initial_value()

and please adjust selftest to validate that modified/non-zero initial
values are preserved during resize; similar to how realloc() behaves


> +               err =3D -errno;
> +               map->mmaped =3D NULL;
> +               pr_warn("failed to resize datasec map '%s' due to failure=
 in mmap(), err:%d\n",
> +                        bpf_map__name(map), err);
> +
> +               goto fail_mmap;
> +       }
> +
> +       /* finally update btf info */
> +       datasec_type->size =3D var->size =3D rounded_sz;
> +       var_type->type =3D new_array_id;
> +
> +       return 0;
> +
> +fail_mmap:
> +       map->def.value_size =3D old_value_sz;
> +
> +fail_array:
> +       return err;
> +}
> +
>  int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
>  {
>         if (map->fd >=3D 0)
>                 return libbpf_err(-EBUSY);
> +
> +       if (map_is_datasec(map))

so, this is not the best way to check this, see LIBBPF_MAP_BSS,
LIBBPF_MAP_DATA, LIBBPF_MAP_RODATA and libbpf_type field in bpf_map

but as I mentioned above, let's structure it such that
map->def.value_size can always be updated, but libbpf tries to adjust
BTF (we can emit warning if all the logical constraints are not
satisfied; and then clearing btf_value_type_id and btf_value_key_id)?

> +               return map_datasec_resize(map, size);
> +
>         map->def.value_size =3D size;
> +
>         return 0;
> +
>  }
>
>  __u32 bpf_map__btf_key_type_id(const struct bpf_map *map)
> --
> 2.40.0
>
