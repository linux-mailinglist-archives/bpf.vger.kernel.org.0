Return-Path: <bpf+bounces-3200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4108773AC4A
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 00:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0002B2815E3
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 22:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE43E22571;
	Thu, 22 Jun 2023 22:03:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16C21091
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 22:03:29 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEE81BE1
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 15:03:28 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3110a5f2832so1180102f8f.1
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 15:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687471406; x=1690063406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVO0WQxL1JSykPOiPXuJlmR+Ln3CM+lEJeNlPfq/cJg=;
        b=HzBuOuTzDCQ/juCGpIlog2HPHkDFDM3URjHsmnGPQDPKDG0G9mAEPw7ZlV8VyMipyp
         heKpDAFQaNHLAqcTLVKb1rrKpFxLWvon+1AgCB+83E+nzBrHHJfZOBdVTwFfIIzDgF4t
         vH/gvWIXcx4JuCNjtfMHCpEiCKAvbSgMVWil7ipt4EpJg9UWWi8DgbhCrOCDx2BdWz1X
         W9zZfUDKGjJ/FQbgZn0G/j5cxLB7/aP4G9pKZshmog2icg2mAMWCp2C19K0rJEiw7/hY
         Vg6S/juAfDuEOhHcrWCM577QbZCfzYJOzdOYOosRwoLHzYWemBmMnUmgPEZYRRu7x9aN
         Uz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687471406; x=1690063406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVO0WQxL1JSykPOiPXuJlmR+Ln3CM+lEJeNlPfq/cJg=;
        b=aL3d/zXICMGaUtACkv0GZ6FRDTiZl8vFRMhz3Y+yTK5pJzzHljoJ6Q0z1BbO5qojWH
         cxyhJXBSahEXQLIgf2FiECoGF1f7o+QslUuZMWD0VIS//aqbUT1u1aVUdb7NQqvmRau8
         zvUgJKzMZ7Q0th9E9xtaG+z7vDyTZ3T+2pXWcpnDs1AKkopt4PQ3ecmW+QkpHUaUqDg1
         p0K/cqD98xj3dgzwng6mwHlubAKJxJhj9x1GSY+a1X7XZt/Kt8afWtfj7CWfF/KR9fid
         aA4qvgiReYHVr85Gd9tUlp2joP10EZ3nUPJD43f3/LAkatj2Q/UgOlMhTUG1YZx8Gddf
         JkLw==
X-Gm-Message-State: AC+VfDzHW2QnDUfrM0GsknuTwUXqf0mbTE8eUM6urY1NQzqfTioWlhae
	SkZXjBvSJcETUd+aiC4Agd7r2+4x0PlnbQfHnBw=
X-Google-Smtp-Source: ACHHUZ5uNwkedOiqu0cgHX+SqqExDanWtupLmh/BiVmkhaaVBvLtPh3C8090S7k1KzyNjHwvb4YNrV2Zb+OJkh+p1qc=
X-Received: by 2002:a05:600c:1e0e:b0:3f8:fa24:2d27 with SMTP id
 ay14-20020a05600c1e0e00b003f8fa242d27mr16592623wmb.13.1687471406598; Thu, 22
 Jun 2023 15:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230616171728.530116-1-alan.maguire@oracle.com> <20230616171728.530116-4-alan.maguire@oracle.com>
In-Reply-To: <20230616171728.530116-4-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jun 2023 15:03:14 -0700
Message-ID: <CAEf4BzZ-U0qtrMcWSXq1NhV6UbUDW0L8in4uYoS_A1_FVau+hQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/9] libbpf: use kind layout to compute an
 unknown kind size
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
> This allows BTF parsing to proceed even if we do not know the
> kind.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 41 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index f9f919fdc728..457997c2a43c 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -327,7 +327,35 @@ static int btf_parse_kind_layout_sec(struct btf *btf=
)
>         return 0;
>  }
>
> -static int btf_type_size(const struct btf_type *t)
> +/* for unknown kinds, consult kind layout. */
> +static int btf_type_size_unknown(const struct btf *btf, const struct btf=
_type *t)
> +{
> +       int size =3D sizeof(struct btf_type);
> +       struct btf_kind_layout *k =3D NULL;
> +       __u16 vlen =3D btf_vlen(t);
> +       __u8 kind =3D btf_kind(t);
> +
> +       if (btf->kind_layout)
> +               k =3D &btf->kind_layout[kind];

see my suggestion on the previous patch. Let's make this layout
information mandatory internally and always use it consistently.

simpler code, more testing for this new code path


> +
> +       if (!k || (void *)k > ((void *)btf->kind_layout + btf->hdr->kind_=
layout_len)) {
> +               pr_debug("Unsupported BTF_KIND: %u\n", btf_kind(t));
> +               return -EINVAL;
> +       }
> +
> +       if (!(k->flags & BTF_KIND_LAYOUT_OPTIONAL)) {
> +               /* a required kind, and we do not know about it.. */
> +               pr_debug("unknown but required kind: %u\n", kind);
> +               return -EINVAL;
> +       }
> +
> +       size +=3D k->info_sz;
> +       size +=3D vlen * k->elem_sz;
> +
> +       return size;
> +}
> +
> +static int btf_type_size(const struct btf *btf, const struct btf_type *t=
)
>  {
>         const int base_size =3D sizeof(struct btf_type);
>         __u16 vlen =3D btf_vlen(t);
> @@ -363,8 +391,7 @@ static int btf_type_size(const struct btf_type *t)
>         case BTF_KIND_DECL_TAG:
>                 return base_size + sizeof(struct btf_decl_tag);
>         default:
> -               pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
> -               return -EINVAL;
> +               return btf_type_size_unknown(btf, t);
>         }
>  }
>
> @@ -463,7 +490,7 @@ static int btf_parse_type_sec(struct btf *btf)
>                 if (btf->swapped_endian)
>                         btf_bswap_type_base(next_type);
>
> -               type_size =3D btf_type_size(next_type);
> +               type_size =3D btf_type_size(btf, next_type);
>                 if (type_size < 0)
>                         return type_size;
>                 if (next_type + type_size > end_type) {
> @@ -1672,7 +1699,7 @@ int btf__add_type(struct btf *btf, const struct btf=
 *src_btf, const struct btf_t
>         struct btf_type *t;
>         int sz, err;
>
> -       sz =3D btf_type_size(src_type);
> +       sz =3D btf_type_size(src_btf, src_type);
>         if (sz < 0)
>                 return libbpf_err(sz);
>
> @@ -1753,7 +1780,7 @@ int btf__add_btf(struct btf *btf, const struct btf =
*src_btf)
>         memcpy(t, src_btf->types_data, data_sz);
>
>         for (i =3D 0; i < cnt; i++) {
> -               sz =3D btf_type_size(t);
> +               sz =3D btf_type_size(src_btf, t);
>                 if (sz < 0) {
>                         /* unlikely, has to be corrupted src_btf */
>                         err =3D sz;
> @@ -4749,7 +4776,7 @@ static int btf_dedup_compact_types(struct btf_dedup=
 *d)
>                         continue;
>
>                 t =3D btf__type_by_id(d->btf, id);
> -               len =3D btf_type_size(t);
> +               len =3D btf_type_size(d->btf, t);
>                 if (len < 0)
>                         return len;
>
> --
> 2.39.3
>

