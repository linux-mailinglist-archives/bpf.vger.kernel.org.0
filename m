Return-Path: <bpf+bounces-673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B876370594E
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 23:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D105B281375
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 21:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B51271F1;
	Tue, 16 May 2023 21:11:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71176290EA
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 21:11:12 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5617E729B
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 14:11:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bceaf07b8so26656360a12.3
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 14:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684271469; x=1686863469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lUwP4KNi2lnkmyVmTJSGSMuxvN/4wZ7KQNu1zmymoc=;
        b=EigBFzZCrTqqJr085Q3FIxch/LgB19Basg+q5zwU1gSTUTiPQigkyFWhDOtMOGFCo3
         lyUiyowGGR+8+2sJJqnzbVxaj7a3jkgl5CPVqv8sBb5kg49eug8A3sQX3sUNvu0u8juz
         m3YR4e+WxZk/7f3ZWOvjmf+sDRVlYHrSJnjlXtXbiXbHWPpQTwVTyCNEgCFmqPoC1PN9
         Po4L5SPvP+pkALSahRcPSRYP5A3VugulKtY9ClyjQiOv8V5BKQu7eJRyqegydUJZIMsV
         q0wV3jC+OvL58XfylWjexAkb4FHCLEfQFa9wYFOdMfG5kMCxJ7uxx6XMdqfmbarYcCDV
         ldwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684271469; x=1686863469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lUwP4KNi2lnkmyVmTJSGSMuxvN/4wZ7KQNu1zmymoc=;
        b=aIPN0hJH/xeMCu0NXOy/uABoCajFIYWo2E/Em2luoUQjzKc9YzTY3XRETCH4BnAGwN
         /tHEs3tAMtj46c3uD3yyMvNYMVAdMsPNUSPTQgaGqHcm/gY9ka3+7w1DcNEm7nBfaqAl
         X/plfUi4Dd894Zawu+03nIzsyVMJe9RTVdl7Kyb4oeToHfE2xtlwYrF8+RyVj4Y7oRv6
         U7Z6Lopr2xE9RuAlMs2KDPSd9rWpocU+uQSGhkhlp7gFn5EDGMqBio6xaYCVbUG1U1tL
         qdstLKuolQ5yT9Pi8vAv85h0xkeN9ZAbm/zvDxvmh0wz4rIOQ61BQVNe0hLWwndFAZy8
         MgJQ==
X-Gm-Message-State: AC+VfDzfDoHpkrzkxHLIJWBfNDHpYeD+Z9NZgatnkzSevFvQFEnvX1uz
	LrKPQDxRVPUqGYpeZzjKOka7U6iplL9J8F26LK0=
X-Google-Smtp-Source: ACHHUZ6N9ScXlMxwC2+ufQ2VT8Ibi6maTn2C69XqTIwXht4mV8RvQ76mjBDiIVmND2KMuwptGR4mrxwEoB5NU+sQZPo=
X-Received: by 2002:a17:907:70a:b0:953:9024:1b50 with SMTP id
 xb10-20020a170907070a00b0095390241b50mr33257371ejb.74.1684271468334; Tue, 16
 May 2023 14:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230510223342.12886-1-inwardvessel@gmail.com> <20230510223342.12886-2-inwardvessel@gmail.com>
In-Reply-To: <20230510223342.12886-2-inwardvessel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 May 2023 14:10:56 -0700
Message-ID: <CAEf4BzZbTYLMPNdXWL4i6Wn1qk+hxgcMFuG=1THwz2mPiC7HJg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] libbpf: add capability for resizing
 datasec maps
To: JP Kobryn <inwardvessel@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 10, 2023 at 3:33=E2=80=AFPM JP Kobryn <inwardvessel@gmail.com> =
wrote:
>
> This patch updates bpf_map__set_value_size() so that if the given map is
> memory mapped, it will attempt to resize the mapped region. Initial
> contents of the mapped region are preserved. BTF is not required, but
> after the mapping is resized an attempt is made to adjust the associated
> BTF information if the following criteria is met:
>  - BTF info is present
>  - the map is a datasec
>  - the final variable in the datasec is an array
>
> ... the resulting BTF info will be updated so that the final array
> variable is associated with a new BTF array type sized to cover the
> requested size.
>
> Note that the initial resizing of the memory mapped region can succeed
> while the subsequent BTF adjustment can fail. In this case, BTF info is
> dropped from the map by clearing the key and value type.
>
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---

It's coming along pretty nicely, still few bugs and unnecessary
complications, but easy to fix.

Can you please also add a doc-comment in libbpf.h for
bpf_map__set_value_size() describing what this API is doing and
explicitly point out that once mmap-able BPF map is resized, all
previous pointers returned from bpf_map__initial_value() and BPF
skeleton pointers for corresponding data section will be invalidated
and have to be re-initialized. This is an important and subtle point,
best to call it out very explicitly.


>  tools/lib/bpf/libbpf.c | 158 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 157 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1cbacf9e71f3..50cfe2bd4ba0 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1510,6 +1510,39 @@ static size_t bpf_map_mmap_sz(const struct bpf_map=
 *map)
>         return map_sz;
>  }
>
> +static int bpf_map_mmap_resize(struct bpf_map *map, size_t old_sz, size_=
t new_sz)
> +{
> +       void *mmaped;
> +
> +       if (!map->mmaped)
> +               return -EINVAL;
> +
> +       if (old_sz =3D=3D new_sz)
> +               return 0;
> +
> +       mmaped =3D mmap(NULL, new_sz, PROT_READ | PROT_WRITE,
> +                       MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +       if (mmaped =3D=3D MAP_FAILED)
> +               return libbpf_err(-errno);

no need to use libbpf_err() here, it's internal function

> +
> +       /* copy pre-existing contents to new region,
> +        * using the minimum of old/new size
> +        */
> +       memcpy(mmaped, map->mmaped, min(old_sz, new_sz));
> +
> +       if (munmap(map->mmaped, old_sz)) {
> +               pr_warn("map '%s': failed to unmap\n", bpf_map__name(map)=
);
> +               if (munmap(mmaped, new_sz))
> +                       pr_warn("map '%s': failed to unmap temp region\n"=
,
> +                                       bpf_map__name(map));
> +               return libbpf_err(-errno);
> +       }

this seems a bit too paranoid. Let's just unconditionally
`munmap(map->mmaped, old_sz);` and that's it. Don't add warning and
definitely don't try to unmap newly mapped region. As is this code
could lead to double-free, effectively.

> +
> +       map->mmaped =3D mmaped;
> +
> +       return 0;
> +}
> +
>  static char *internal_map_name(struct bpf_object *obj, const char *real_=
name)
>  {
>         char map_name[BPF_OBJ_NAME_LEN], *p;
> @@ -9412,12 +9445,135 @@ __u32 bpf_map__value_size(const struct bpf_map *=
map)
>         return map->def.value_size;
>  }
>
> +static int map_btf_datasec_resize(struct bpf_map *map, __u32 size)
> +{
> +       int err;
> +       int i, vlen;
> +       struct btf *btf;
> +       const struct btf_type *array_type, *array_element_type;
> +       struct btf_type *datasec_type, *var_type;
> +       struct btf_var_secinfo *var;
> +       const struct btf_array *array;
> +       __u32 offset, nr_elements, new_array_id;
> +
> +       /* check btf existence */
> +       btf =3D bpf_object__btf(map->obj);
> +       if (!btf)
> +               return -ENOENT;
> +
> +       /* verify map is datasec */
> +       datasec_type =3D btf_type_by_id(btf, bpf_map__btf_value_type_id(m=
ap));
> +       if (!btf_is_datasec(datasec_type)) {
> +               pr_warn("map '%s': attempted to resize but map is not a d=
atasec\n",

"map value type is not a datasec". map is not a datasec, it's value type is

> +                               bpf_map__name(map));
> +               return -EINVAL;
> +       }
> +
> +       /* verify datasec has at least one var */
> +       vlen =3D btf_vlen(datasec_type);
> +       if (vlen =3D=3D 0) {
> +               pr_warn("map '%s': attempted to resize but map vlen =3D=
=3D 0\n",

maybe "map value datasec is empty"? "vlen" is not necessarily
something that users will easily recognize and understand

> +                               bpf_map__name(map));
> +               return -EINVAL;
> +       }
> +
> +       /* walk to the last var in the datasec,
> +        * increasing the offset as we pass each var
> +        */
> +       var =3D btf_var_secinfos(datasec_type);
> +       offset =3D 0;
> +       for (i =3D 0; i < vlen - 1; i++) {
> +               offset +=3D var->size;
> +               var++;
> +       }

it's both incorrect and overcomplicated. Just:

var =3D btf_var_secinfos(datasec_type)[vlen - 1];
offset =3D var->offset;

> +
> +       /* verify last var in the datasec is an array */
> +       var_type =3D btf_type_by_id(btf, var->type);
> +       array_type =3D skip_mods_and_typedefs(btf, var_type->type, NULL);
> +       if (!btf_is_array(array_type)) {
> +               pr_warn("map '%s': cannot be resized last var must be arr=
ay\n",

"cannot be resized, last var must be an array"?

> +                               bpf_map__name(map));
> +               return -EINVAL;
> +       }
> +
> +       /* verify request size aligns with array */
> +       array =3D btf_array(array_type);
> +       array_element_type =3D btf_type_by_id(btf, array->type);

not enough, need to skip_mods_and_typedefs() first, etc. But probably
simpler to just use btf__resolve_size(array->type)? And don't forget
to check that we get > 0 result, otherwise we run a risk of division
by zero below

> +       if ((size - offset) % array_element_type->size !=3D 0) {
> +               pr_warn("map '%s': attempted to resize but requested size=
 does not align\n",
> +                               bpf_map__name(map));
> +               return -EINVAL;
> +       }
> +
> +       /* create a new array based on the existing array,
> +        * but with new length
> +        */
> +       nr_elements =3D (size - offset) / array_element_type->size;
> +       new_array_id =3D btf__add_array(btf, array->index_type, array->ty=
pe,
> +                       nr_elements);
> +       if (new_array_id < 0) {
> +               pr_warn("map '%s': failed to create new array\n",

this is a very unlikely error to happen, unless there is some bug (the
only legitimate reason is -ENOMEM, which we generally don't log
everywhere). So let's drop unnecessary pr_warn() here.

> +                               bpf_map__name(map));
> +               err =3D new_array_id;
> +               return err;
> +       }
> +
> +       /* adding a new btf type invalidates existing pointers to btf obj=
ects,
> +        * so refresh pointers before proceeding
> +        */
> +       datasec_type =3D btf_type_by_id(btf, map->btf_value_type_id);
> +       var =3D btf_var_secinfos(datasec_type);
> +       for (i =3D 0; i < vlen - 1; i++)
> +               var++;

as I showed above, btf_var_secinfos(datasec_type)[vlen - 1], no need
for linear search

> +       var_type =3D btf_type_by_id(btf, var->type);
> +
> +       /* finally update btf info */
> +       datasec_type->size =3D size;
> +       var->size =3D size - offset;
> +       var_type->type =3D new_array_id;
> +
> +       return 0;
> +}
> +
>  int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
>  {
> +       int err;
> +       __u32 old_size;
> +
>         if (map->fd >=3D 0)
>                 return libbpf_err(-EBUSY);
> -       map->def.value_size =3D size;
> +
> +       old_size =3D map->def.value_size;
> +
> +       if (map->mmaped) {
> +               size_t mmap_old_sz, mmap_new_sz;
> +
> +               mmap_old_sz =3D bpf_map_mmap_sz(map);
> +               map->def.value_size =3D size;
> +               mmap_new_sz =3D bpf_map_mmap_sz(map);

it's ugly that we need to modify map->def.value_size just to calculate
mmap region size. Let's add a helper that would take value_size and
max_entries explicitly and return mmap size? This will make this
function simpler as well as map->def.value_size will be updated once
at the very end, regardless of map->mmaped or not.

> +
> +               err =3D bpf_map_mmap_resize(map, mmap_old_sz, mmap_new_sz=
);
> +               if (err) {
> +                       pr_warn("map '%s': failed to resize memory mapped=
 region\n",
> +                                       bpf_map__name(map));
> +                       goto err_out;
> +               }
> +               err =3D map_btf_datasec_resize(map, size);
> +               if (err && err !=3D -ENOENT) {
> +                       pr_warn("map '%s': failed to adjust btf for resiz=
ed map. dropping btf info\n",

nit, either capitalize "Dropping", or (preferably) turn it into a
single sentence: "failed to adjust BTF for resized map, clearing BTF
key/value type info\n". Dropping is ambiguous and sounds more
dangerous than it really is


> +                                       bpf_map__name(map));
> +                       map->btf_value_type_id =3D 0;
> +                       map->btf_key_type_id =3D 0;
> +               }
> +       } else {
> +               map->def.value_size =3D size;
> +       }
> +
>         return 0;
> +
> +err_out:
> +       map->def.value_size =3D old_size;
> +       return libbpf_err(err);
>  }
>
>  __u32 bpf_map__btf_key_type_id(const struct bpf_map *map)
> --
> 2.40.0
>

