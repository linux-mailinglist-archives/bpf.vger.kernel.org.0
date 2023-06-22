Return-Path: <bpf+bounces-3199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC83873AC49
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 00:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BCBE28183A
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 22:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB7E22572;
	Thu, 22 Jun 2023 22:03:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2493622557
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 22:03:02 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100531BD0
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 15:03:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3113dabc549so6591013f8f.1
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 15:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687471379; x=1690063379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmhqMgt9JydWi9RjQqxjbTagQswa8W+5CzJ3Q++Hdxw=;
        b=G/4gp5yVi6ZQ+W0TVtbWbaJnu8yCL0tH98YY5YwE1XS4HXylOIiuU/hGe/Z3AG0SWI
         RUXARFvJp7RyjsPPOPYNNKOd0KFMNBB7sWrzyu06ycY9UYYnAqAnMzKWmaRKuqWBAoeE
         kj5nVvxzdhTHPLyQeyh7/sUZYYLpxrHodSIopGRG+DpdYTiZJRliHt0fIUBz1vqk+RTx
         8qU76WS4A6pF7ksB3vUgolkmY35MYPbi9XRkUAtb4N3wfTDMlCBC/wfCNDe5Nt1h/lB7
         v8w459cmn0uBlFQ3MQ8juqwFsScdeUQRVEs04d3+eJKb5wbtYfptxey2374rzUKGueq9
         qNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687471379; x=1690063379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmhqMgt9JydWi9RjQqxjbTagQswa8W+5CzJ3Q++Hdxw=;
        b=Eyn7E3SxDjv4Adu1IXPGtsAH+gRaX1MT2D3ryVfvgdxXHCJCTnx1AtsU4kP64cSbf1
         Y5pMrfz/BUFmcfTOlMQX7hf0QTztju/6A8P5nTgInsOXji3Pqkzf/H5pCtZ0UDzMvHnG
         5WmvpogNFI9n9oBVs+adTrwWQm4KMB8HrJwXRwQ9/0yZmwb7LxstRfyj/4Kszw7LlfZy
         BaQv/X6tCQdFEuG63HqcarkKc7+lX7xmsQ6QUFRTCxpAQNgTFi4tYjQHAjzBSqtRXvHi
         4GYUrZOUVGz68+oteVWbkaWUaTPLQrW3BhRkKzgJ+oQu1YEqxOqsGM9DRGWWFiA/hoUW
         12Kg==
X-Gm-Message-State: AC+VfDxDj7f4WlHY7DDYCNvjgRoCjhHQysiF6XVt5kgoduQkuIUFEbTy
	MQmsGklCRD/OxqZaEXMtCRc3Xt1TLO+iZ718ryE=
X-Google-Smtp-Source: ACHHUZ7AXlhilhovzlgOXgF8nROwDkVajU8mgY9FHypO2y98QCmm2n4TSvHuP0LVjD/+qEvogt9JirVEIhpMwQM4TLg=
X-Received: by 2002:adf:f811:0:b0:311:17af:df96 with SMTP id
 s17-20020adff811000000b0031117afdf96mr19955126wrp.44.1687471379232; Thu, 22
 Jun 2023 15:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230616171728.530116-1-alan.maguire@oracle.com> <20230616171728.530116-3-alan.maguire@oracle.com>
In-Reply-To: <20230616171728.530116-3-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jun 2023 15:02:47 -0700
Message-ID: <CAEf4BzZ_s+MxxbQP99s5vbduHO-WE6VXMvZjCC270xgpmK9r2w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/9] libbpf: support handling of kind layout
 section in BTF
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

On Fri, Jun 16, 2023 at 10:17=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> support reading in kind layout fixing endian issues on reading;
> also support writing kind layout section to raw BTF object.
> There is not yet an API to populate the kind layout with meaningful
> information.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 132 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 99 insertions(+), 33 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 8484b563b53d..f9f919fdc728 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -39,40 +39,44 @@ struct btf {
>

[...]

>         struct btf_header *hdr;
>
> @@ -116,6 +120,8 @@ struct btf {
>         /* whether strings are already deduplicated */
>         bool strs_deduped;
>
> +       struct btf_kind_layout *kind_layout;
> +
>         /* BTF object FD, if loaded into kernel */
>         int fd;
>
> @@ -215,6 +221,13 @@ static void btf_bswap_hdr(struct btf_header *h)
>         h->type_len =3D bswap_32(h->type_len);
>         h->str_off =3D bswap_32(h->str_off);
>         h->str_len =3D bswap_32(h->str_len);
> +       if (h->hdr_len >=3D sizeof(struct btf_header)) {
> +               h->kind_layout_off =3D bswap_32(h->kind_layout_off);
> +               h->kind_layout_len =3D bswap_32(h->kind_layout_len);
> +               h->crc =3D bswap_32(h->crc);
> +               h->base_crc =3D bswap_32(h->base_crc);
> +       }
> +

nit: unnecessary empty line

>  }
>
>  static int btf_parse_hdr(struct btf *btf)
> @@ -222,14 +235,17 @@ static int btf_parse_hdr(struct btf *btf)
>         struct btf_header *hdr =3D btf->hdr;
>         __u32 meta_left;
>
> -       if (btf->raw_size < sizeof(struct btf_header)) {
> +       if (btf->raw_size < BTF_HEADER_MIN_LEN) {
>                 pr_debug("BTF header not found\n");
>                 return -EINVAL;
>         }
>
>         if (hdr->magic =3D=3D bswap_16(BTF_MAGIC)) {
> +               int swapped_len =3D bswap_32(hdr->hdr_len);
> +
>                 btf->swapped_endian =3D true;
> -               if (bswap_32(hdr->hdr_len) !=3D sizeof(struct btf_header)=
) {
> +               if (swapped_len !=3D sizeof(struct btf_header) &&
> +                   swapped_len !=3D BTF_HEADER_MIN_LEN) {
>                         pr_warn("Can't load BTF with non-native endiannes=
s due to unsupported header length %u\n",
>                                 bswap_32(hdr->hdr_len));
>                         return -ENOTSUP;
> @@ -285,6 +301,32 @@ static int btf_parse_str_sec(struct btf *btf)
>         return 0;
>  }
>
> +static void btf_bswap_kind_layout_sec(struct btf_kind_layout *k, int len=
)
> +{
> +       struct btf_kind_layout *end =3D (void *)k + len;
> +
> +       while (k < end) {
> +               k->flags =3D bswap_16(k->flags);
> +               k++;
> +       }
> +}
> +
> +static int btf_parse_kind_layout_sec(struct btf *btf)
> +{
> +       const struct btf_header *hdr =3D btf->hdr;
> +
> +       if (hdr->hdr_len < sizeof(struct btf_header) ||
> +           !hdr->kind_layout_off || !hdr->kind_layout_len)
> +               return 0;

instead of having to remember to check `hdr->hdr_len < sizeof(struct
btf_header)` before accessing kind_layout_off and kind_layout_len,
let's just allocate a copy of full btf_header on initialization, copy
min(sizeof(struct btf_header), hdr->len) into it, and then point
btf->hdr to this copy everywhere?

> +       if (hdr->kind_layout_len < sizeof(struct btf_kind_layout)) {

shouldn't it be the check that hdr->kind_layout_len is a multiple of
sizeof(struct btf_kind_layout) ?

> +               pr_debug("Invalid BTF kind layout section\n");
> +               return -EINVAL;
> +       }
> +       btf->kind_layout =3D btf->raw_data + btf->hdr->hdr_len + btf->hdr=
->kind_layout_off;
> +
> +       return 0;
> +}
> +
>  static int btf_type_size(const struct btf_type *t)
>  {
>         const int base_size =3D sizeof(struct btf_type);
> @@ -901,6 +943,7 @@ static struct btf *btf_new(const void *data, __u32 si=
ze, struct btf *base_btf)
>         btf->types_data =3D btf->raw_data + btf->hdr->hdr_len + btf->hdr-=
>type_off;
>
>         err =3D btf_parse_str_sec(btf);
> +       err =3D err ?: btf_parse_kind_layout_sec(btf);
>         err =3D err ?: btf_parse_type_sec(btf);
>         if (err)
>                 goto done;
> @@ -1267,6 +1310,11 @@ static void *btf_get_raw_data(const struct btf *bt=
f, __u32 *size, bool swap_endi
>         }
>
>         data_sz =3D hdr->hdr_len + hdr->type_len + hdr->str_len;
> +       if (btf->kind_layout) {
> +               data_sz =3D roundup(data_sz, 4);
> +               data_sz +=3D hdr->kind_layout_len;
> +               hdr->kind_layout_off =3D roundup(hdr->type_len + hdr->str=
_len, 4);

can we avoid modifying hdr here? we expect const struct btf *, so it's
a bit iffy that we are adjusting header here

maybe we can just make sure that kind_layout_off is always maintained corre=
ctly?

> +       }
>         data =3D calloc(1, data_sz);
>         if (!data)
>                 return NULL;
> @@ -1293,8 +1341,15 @@ static void *btf_get_raw_data(const struct btf *bt=
f, __u32 *size, bool swap_endi
>         p +=3D hdr->type_len;
>
>         memcpy(p, btf_strs_data(btf), hdr->str_len);
> -       p +=3D hdr->str_len;
> +       /* round up to 4 byte alignment to match offset above */
> +       p =3D data + hdr->hdr_len + roundup(hdr->type_len + hdr->str_len,=
 4);

instead of reimplementing roundup logic, why not just use
hdr->kind_layout_off here?

>
> +       if (btf->kind_layout) {
> +               memcpy(p, btf->kind_layout, hdr->kind_layout_len);
> +               if (swap_endian)
> +                       btf_bswap_kind_layout_sec(p, hdr->kind_layout_len=
);
> +               p +=3D hdr->kind_layout_len;
> +       }
>         *size =3D data_sz;
>         return data;
>  err_out:
> @@ -1425,13 +1480,13 @@ static void btf_invalidate_raw_data(struct btf *b=
tf)
>         }
>  }
>
> -/* Ensure BTF is ready to be modified (by splitting into a three memory
> - * regions for header, types, and strings). Also invalidate cached
> - * raw_data, if any.
> +/* Ensure BTF is ready to be modified (by splitting into a three or four=
 memory

nit: gmail suggests that "a" is not necessary before "three" here

> + * regions for header, types, strings and optional kind layout). Also in=
validate
> + * cached raw_data, if any.
>   */
>  static int btf_ensure_modifiable(struct btf *btf)
>  {
> -       void *hdr, *types;
> +       void *hdr, *types, *kind_layout =3D NULL;
>         struct strset *set =3D NULL;
>         int err =3D -ENOMEM;
>
> @@ -1446,9 +1501,17 @@ static int btf_ensure_modifiable(struct btf *btf)
>         types =3D malloc(btf->hdr->type_len);
>         if (!hdr || !types)
>                 goto err_out;
> +       if (btf->hdr->hdr_len >=3D sizeof(struct btf_header)  &&
> +           btf->hdr->kind_layout_off && btf->hdr->kind_layout_len) {
> +               kind_layout =3D calloc(1, btf->hdr->kind_layout_len);
> +               if (!kind_layout)
> +                       goto err_out;
> +       }
>
>         memcpy(hdr, btf->hdr, btf->hdr->hdr_len);
>         memcpy(types, btf->types_data, btf->hdr->type_len);
> +       if (kind_layout)
> +               memcpy(kind_layout, btf->kind_layout, btf->hdr->kind_layo=
ut_len);
>

let's just emit kind_layout always, why making it optional on writing
out new BTF?

why not make it always present internally in libbpf, and either read
it from BTF, if it's present, or created it from scratch based on
libbpf's version and knowledge of all the kinds? This will be simpler,
the only place where we'd need to handle it optionally is during
initialization


>         /* build lookup index for all strings */
>         set =3D strset__new(BTF_MAX_STR_OFFSET, btf->strs_data, btf->hdr-=
>str_len);
> @@ -1463,6 +1526,8 @@ static int btf_ensure_modifiable(struct btf *btf)
>         btf->types_data_cap =3D btf->hdr->type_len;
>         btf->strs_data =3D NULL;
>         btf->strs_set =3D set;
> +       btf->kind_layout =3D kind_layout;
> +
>         /* if BTF was created from scratch, all strings are guaranteed to=
 be
>          * unique and deduplicated
>          */
> @@ -1480,6 +1545,7 @@ static int btf_ensure_modifiable(struct btf *btf)
>         strset__free(set);
>         free(hdr);
>         free(types);
> +       free(kind_layout);
>         return err;
>  }
>
> --
> 2.39.3
>

