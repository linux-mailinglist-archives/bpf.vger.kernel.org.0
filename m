Return-Path: <bpf+bounces-3202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE91573AC4D
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 00:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880832810BD
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 22:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F2C22573;
	Thu, 22 Jun 2023 22:04:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB9420690
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 22:04:51 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FD61BE1
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 15:04:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3113da5260dso5080229f8f.2
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 15:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687471487; x=1690063487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1hTy5vdu1bOFWMATojKwDYdxlFvKiz+PnwXaMeypU0=;
        b=Umw+5f8zPs41B/Du+e9q41NSw1AIDNRQDDQq0XQ0yPzggT9Qb9kMQdSLmZWyamxOcA
         wZQNUNAQlRO33Alizd1a557MlZAajnZvUBss+vWfTXd++zpWP0xtWtgShY1frgAQSuLu
         PRdNphhsm/Pf0A+mwzD2rPGn69rnbVkxbAqqKlBk0geBNl8Lf8pXNiNkncF4mOCG4j08
         ih1sRElFeFlE0wPXhhvOyy81OSvFoRN5fclAi0ptGClfcY2hV5qpfpWYWPqGd+Gmniyl
         TRPOm+ta2H4ql0pfRhWQEAMx7w41kH9BlGKutRTs5ya5l2hmJe04Mi0iVH+1gLlxj4M8
         2kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687471487; x=1690063487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1hTy5vdu1bOFWMATojKwDYdxlFvKiz+PnwXaMeypU0=;
        b=fia2bvCWtCK+lzKSf+6bblq4mOc7ky5GHIdz99z9AuI4fUnKCnJg2P/cQ7OTRXsICX
         +impLzEgAolrSMhxc5ffrJQMxd3YrHPiWtTla2wveE2XsE5Fj+DzWIG3B/WjuKaDNDdO
         Pzkk9OtgimYl+RXoie1fbetZJgM3/Zo0zUbtPK+vNL6jowajOyM7/Sw0Itn3ggNJdcce
         FxxntZkrf7yMRQqz0lxhvj44IGaM8dY2L9GMwr5DPUE5gf+5hW9D1DVb5dLZO1FbemO6
         uuUomDHWSBNBE7nr5jeqHyDxmiirKjb4D0QJXzIaZa2EptRTilP8KX03HN8XBIlVUljS
         ML9Q==
X-Gm-Message-State: AC+VfDxsA+uMVlaZ1us8r5YTPVWd6PE3TGogCR6Rs8Nful55Md3IGBWP
	cj0QWqy5AqckP/8JZReshvAdafdh3ilL7AlmMcc=
X-Google-Smtp-Source: ACHHUZ7bi3tcmu1oGzUbXGBoZGyr75w5rp3th7BGwChqBtT5xWfCFx8ukUA/8wcDiL64sNyRWrrG76Tyxfll+/Vdi44=
X-Received: by 2002:a5d:558a:0:b0:30f:be0f:fbf with SMTP id
 i10-20020a5d558a000000b0030fbe0f0fbfmr2921386wrv.22.1687471487450; Thu, 22
 Jun 2023 15:04:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230616171728.530116-1-alan.maguire@oracle.com> <20230616171728.530116-6-alan.maguire@oracle.com>
In-Reply-To: <20230616171728.530116-6-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jun 2023 15:04:35 -0700
Message-ID: <CAEf4BzbeTk87XtqSL+9DTqtVu0Eokr+eDJ-Ytek7G_BgSGMPEg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/9] libbpf: add kind layout encoding, crc support
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	quentin@isovalent.com, jolsa@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 16, 2023 at 10:18=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> Support encoding of BTF kind layout data and crcs via
> btf__new_empty_opts().
>
> Current supported opts are base_btf, add_kind_layout and
> add_crc.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c      | 99 ++++++++++++++++++++++++++++++++++++++--
>  tools/lib/bpf/btf.h      | 11 +++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 108 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 457997c2a43c..060a93809f64 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -16,6 +16,7 @@
>  #include <linux/err.h>
>  #include <linux/btf.h>
>  #include <gelf.h>
> +#include <zlib.h>
>  #include "btf.h"
>  #include "bpf.h"
>  #include "libbpf.h"
> @@ -882,8 +883,58 @@ void btf__free(struct btf *btf)
>         free(btf);
>  }
>
> -static struct btf *btf_new_empty(struct btf *base_btf)
> +static void btf_add_kind_layout(struct btf *btf, __u8 kind,
> +                               __u16 flags, __u8 info_sz, __u8 elem_sz)
>  {
> +       struct btf_kind_layout *k =3D &btf->kind_layout[kind];
> +
> +       k->flags =3D flags;
> +       k->info_sz =3D info_sz;
> +       k->elem_sz =3D elem_sz;
> +       btf->hdr->kind_layout_len +=3D sizeof(*k);
> +}
> +
> +static int btf_ensure_modifiable(struct btf *btf);
> +
> +static int btf_add_kind_layouts(struct btf *btf, struct btf_new_opts *op=
ts)
> +{
> +       if (btf_ensure_modifiable(btf))
> +               return libbpf_err(-ENOMEM);
> +
> +       btf->kind_layout =3D calloc(NR_BTF_KINDS, sizeof(struct btf_kind_=
layout));
> +
> +       if (!btf->kind_layout)
> +               return -ENOMEM;
> +
> +       /* all supported kinds should describe their layout here. */

why not have a static table for each known kind and then just memcpy
it? Seems both more elegant and more maintainable?

static struct btf_kind_layout layout[] =3D {
    [BTF_KIND_UNKN] =3D {0, 0, 0},
    [BTF_KIND_UNKN] =3D {0, sizeof(__u32), 0},
    ...
    [BTF_KIND_STRUCT] =3D {0, 0, sizeof(struct btf_member)},
};

?


> +       btf_add_kind_layout(btf, BTF_KIND_UNKN, 0, 0, 0);
> +       btf_add_kind_layout(btf, BTF_KIND_INT, 0, sizeof(__u32), 0);
> +       btf_add_kind_layout(btf, BTF_KIND_PTR, 0, 0, 0);
> +       btf_add_kind_layout(btf, BTF_KIND_ARRAY, 0, sizeof(struct btf_arr=
ay), 0);
> +       btf_add_kind_layout(btf, BTF_KIND_STRUCT, 0, 0, sizeof(struct btf=
_member));
> +       btf_add_kind_layout(btf, BTF_KIND_UNION, 0, 0, sizeof(struct btf_=
member));
> +       btf_add_kind_layout(btf, BTF_KIND_ENUM, 0, 0, sizeof(struct btf_e=
num));
> +       btf_add_kind_layout(btf, BTF_KIND_FWD, 0, 0, 0);
> +       btf_add_kind_layout(btf, BTF_KIND_TYPEDEF, 0, 0, 0);
> +       btf_add_kind_layout(btf, BTF_KIND_VOLATILE, 0, 0, 0);
> +       btf_add_kind_layout(btf, BTF_KIND_CONST, 0, 0, 0);
> +       btf_add_kind_layout(btf, BTF_KIND_RESTRICT, 0, 0, 0);
> +       btf_add_kind_layout(btf, BTF_KIND_FUNC, 0, 0, 0);
> +       btf_add_kind_layout(btf, BTF_KIND_FUNC_PROTO, 0, 0, sizeof(struct=
 btf_param));
> +       btf_add_kind_layout(btf, BTF_KIND_VAR, 0, sizeof(struct btf_var),=
 0);
> +       btf_add_kind_layout(btf, BTF_KIND_DATASEC, 0, 0, sizeof(struct bt=
f_var_secinfo));
> +       btf_add_kind_layout(btf, BTF_KIND_FLOAT, 0, 0, 0);
> +       btf_add_kind_layout(btf, BTF_KIND_DECL_TAG, BTF_KIND_LAYOUT_OPTIO=
NAL,
> +                                                       sizeof(struct btf=
_decl_tag), 0);
> +       btf_add_kind_layout(btf, BTF_KIND_TYPE_TAG, BTF_KIND_LAYOUT_OPTIO=
NAL, 0, 0);
> +       btf_add_kind_layout(btf, BTF_KIND_ENUM64, 0, 0, sizeof(struct btf=
_enum64));
> +
> +       return 0;
> +}
> +
> +static struct btf *btf_new_empty(struct btf_new_opts *opts)
> +{
> +       struct btf *base_btf =3D OPTS_GET(opts, base_btf, NULL);
>         struct btf *btf;
>
>         btf =3D calloc(1, sizeof(*btf));
> @@ -920,17 +971,53 @@ static struct btf *btf_new_empty(struct btf *base_b=
tf)
>         btf->strs_data =3D btf->raw_data + btf->hdr->hdr_len;
>         btf->hdr->str_len =3D base_btf ? 0 : 1; /* empty string at offset=
 0 */
>
> +       if (opts->add_kind_layout) {
> +               int err =3D btf_add_kind_layouts(btf, opts);
> +

as I mentioned, I'd always add it internally, but allow to control
whether it has to be emitted into raw_data

> +               if (err) {
> +                       free(btf->raw_data);
> +                       free(btf);
> +                       return ERR_PTR(err);
> +               }
> +       }
> +       if (opts->add_crc) {
> +               if (btf->base_btf) {
> +                       struct btf_header *base_hdr =3D btf->base_btf->hd=
r;
> +
> +                       if (base_hdr->hdr_len >=3D sizeof(struct btf_head=
er) &&
> +                           base_hdr->flags & BTF_FLAG_CRC_SET) {
> +                               btf->hdr->base_crc =3D base_hdr->crc;
> +                               btf->hdr->flags |=3D BTF_FLAG_BASE_CRC_SE=
T;
> +                       }
> +               }
> +               btf->hdr->flags |=3D BTF_FLAG_CRC_SET;
> +       }
> +
>         return btf;
>  }
>
>  struct btf *btf__new_empty(void)
>  {
> -       return libbpf_ptr(btf_new_empty(NULL));
> +       LIBBPF_OPTS(btf_new_opts, opts);
> +
> +       return libbpf_ptr(btf_new_empty(&opts));

why? just pass NULL, it's fine, no need to create empty opts

>  }
>
>  struct btf *btf__new_empty_split(struct btf *base_btf)
>  {
> -       return libbpf_ptr(btf_new_empty(base_btf));
> +       LIBBPF_OPTS(btf_new_opts, opts);
> +
> +       opts.base_btf =3D base_btf;

nit: it's cleaner to initialize opts on declaration in this case

LIBBPF_OPTS(btf_new_opts, opts, .base_btf =3D base_btf);

> +
> +       return libbpf_ptr(btf_new_empty(&opts));
> +}
> +
> +struct btf *btf__new_empty_opts(struct btf_new_opts *opts)
> +{
> +       if (!OPTS_VALID(opts, btf_new_opts))
> +               return libbpf_err_ptr(-EINVAL);
> +
> +       return libbpf_ptr(btf_new_empty(opts));
>  }
>
>  static struct btf *btf_new(const void *data, __u32 size, struct btf *bas=
e_btf)
> @@ -1377,6 +1464,12 @@ static void *btf_get_raw_data(const struct btf *bt=
f, __u32 *size, bool swap_endi
>                         btf_bswap_kind_layout_sec(p, hdr->kind_layout_len=
);
>                 p +=3D hdr->kind_layout_len;
>         }
> +       if (hdr->flags & BTF_FLAG_CRC_SET) {
> +               struct btf_header *h =3D data;
> +
> +               h->crc =3D crc32(0L, (const Bytef *)&data, sizeof(data));

is crc32() part of zlib's public API?

> +       }
> +
>         *size =3D data_sz;
>         return data;
>  err_out:
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 8e6880d91c84..d25bd5c19eec 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -107,6 +107,17 @@ LIBBPF_API struct btf *btf__new_empty(void);
>   */
>  LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
>
> +struct btf_new_opts {
> +       size_t sz;
> +       struct btf *base_btf;   /* optional base BTF */
> +       bool add_kind_layout;   /* add BTF kind layout information */

I'd say let's make it opt-out option and by default do emit kind
layout? so rather "skip_kind_layout"

> +       bool add_crc;           /* add CRC information */

same for crc? "skip_crc"?

btw, does add_crc imply both crc and base_crc (if base_btf !=3D NULL)?
just thinking out loud if we need to control that independently...



> +       size_t:0;
> +};
> +#define btf_new_opts__last_field add_crc
> +
> +LIBBPF_API struct btf *btf__new_empty_opts(struct btf_new_opts *opts);
> +
>  LIBBPF_API struct btf *btf__parse(const char *path, struct btf_ext **btf=
_ext);
>  LIBBPF_API struct btf *btf__parse_split(const char *path, struct btf *ba=
se_btf);
>  LIBBPF_API struct btf *btf__parse_elf(const char *path, struct btf_ext *=
*btf_ext);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 7521a2fb7626..edd8be4b21d0 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -395,4 +395,5 @@ LIBBPF_1.2.0 {
>  LIBBPF_1.3.0 {
>         global:
>                 bpf_obj_pin_opts;
> +               btf__new_empty_opts;
>  } LIBBPF_1.2.0;
> --
> 2.39.3
>

