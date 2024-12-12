Return-Path: <bpf+bounces-46746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C779EFF3C
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 23:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD74165793
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 22:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A8F1DE2CB;
	Thu, 12 Dec 2024 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbiRF/Yw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF8D2F2F;
	Thu, 12 Dec 2024 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734042300; cv=none; b=g3efoB5QpW39+I1EzvuqPo7AmmEYD7CeadeF/Zn+fkvur+9yjNzQhFkIYa8JK5suCBEox3X+pYj9QH8JnvpYoaT0jnHSwVeY2tBmWvzaX/++dey2U3Fmp3ZlLV5/xnAse2vKjgwTtw/D7JUsdJsCAfg9Uc4l4f9sBseFf+HG1HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734042300; c=relaxed/simple;
	bh=YNFfRhXnSCMoy1cq0GyE9xjMgFb6ScECeniSdt+KuTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5Vvua44pR4RbZ/5SikfupY9ipyy5HlhGtFgsGw3ACCviPbReyv9aNoWWFnCTz8cT/qlA9AcLqMYWUbTgle1L5y63U8MmQoHJA4EFqeLajzRSx0KmdE5enn5mqZff6wHrJzZhELnYAitVnJJ4WS0o+weMMT90bBHBDPS5goiwo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbiRF/Yw; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2efded08c79so816065a91.0;
        Thu, 12 Dec 2024 14:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734042298; x=1734647098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4zgfdFDJ1IUU/4ek2APthZIQtUgvUoq5PaLeafGTto=;
        b=gbiRF/YwPaYdOLheUPwvuQ7dKo9nFY0pHzJYALF7Jf0ZMM5jmiZsbijB6+5nJBstay
         Ed/iKrraCYNko1bFdRaP+9b3j9St9QchR/beEKW8AbAkS0WLWR7Az1w3N3MFH4103++V
         h9oC2sToGnEmtawb1/A32C0yPPb73kTyRKsIYvZHLfU4mq4l459TTOfM/tRI4yQXSw5B
         B77yyyVHFzeLH2A6NClbM+6h6G4i0KeAYMaKzzDGIzUBFAb1zMDoj5teENwFzu/fxIPJ
         mCMvU9B2CrmLQgdkKPDV3lHQyJyNPWxFIT9FTqMvtoEsGAyZSzRHV6iBxynLFMvlVIg1
         IszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734042298; x=1734647098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4zgfdFDJ1IUU/4ek2APthZIQtUgvUoq5PaLeafGTto=;
        b=Gm5JzbdPecvZubqXIsNYEEfS7860u2Hzpe8FACqSdgG/7ecrN84f3nV/8dX9GHYdEM
         5VqUI+GtZEmnDYXksxXAvrqK421iFxOsWjkjilGpMjYmKGrlBkycjJWbsMFAvBqunB/G
         rVhF66XIjAuYBjMAPhNoGlAWvU02Zih9fJYhomR1bBBcfud+fzR90rXlV5Q7Qjj53h9k
         IWy9Tnpr0yUSQE1so9nsacakqwhd9u1+acYLFud7uMzfW0XsPaRDafsJio3NlsGUQfRm
         kfsaZmakuogQFtcf6gW6gaM28jQt7fe98Peite+qHLf9tqkH0RUq5YHm9zi6yvr7sV3x
         cAIg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ2Xt+J/RFyaSUUcLaV6/KbswJygoYT8Nb3SWuhI1g622pArzkYK7Pl9ps/ZU/RoRTtx0=@vger.kernel.org, AJvYcCVWSx/1UDu2+tqA1M89vCPIoILd7zh/WiJwZQRuO1mxTKFhBZgdoPc7/1qsX4eeURTlopzYDY83dPE0aA==@vger.kernel.org, AJvYcCWQ0eM2+CO8n8Ea190cf8zYdQStXRUvUFI/OWMFoiH/BJqxARSi8EolkzIJ8tJUbXvTvz4DlOjNNdB4Hw==@vger.kernel.org, AJvYcCXJ8rM261R1uRRl4WceoeJyOuOkcGDFXclDzVHHynFjWv/E/LmHE+lFFhlfmw8wJbCPNCqh0YBg@vger.kernel.org
X-Gm-Message-State: AOJu0YzAAM/3BP/4d4hf6dX4AoYIi7CfPoRhewcLovnskQiKyiEfm4NB
	i82VyVXlKtp8i4zwju0N3B62kTC+vN/yDMLpO0YIfYR19UAhoVKPD0cJGj/Eem1wsRDSrcAI1F/
	m1FuTP7/cltD/VyuS9X316aZtciI=
X-Gm-Gg: ASbGnctEU9pGdlRdGwI1oUyJ52Er4tfFrOif/MjobTxpw11V1/CFtXW3p+f6+vpQh+n
	Pk7RtD7OmtTfg4lMcv8p2A04Pn2jvVdTCwfCAf6iM8ozQ6KiDs8TF/A==
X-Google-Smtp-Source: AGHT+IHOB+8hLEKkduBdR3nAqxcFs6LGe5zfSqHYsxR4gPGBKpCzZn4Rzacq6aT9lBZWpmBo4EYOw4uZvJ6MTz51FlQ=
X-Received: by 2002:a17:90a:e70d:b0:2ee:df57:b194 with SMTP id
 98e67ed59e1d1-2f28fd6b922mr540057a91.21.1734042298072; Thu, 12 Dec 2024
 14:24:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210040404.10606-1-alibuda@linux.alibaba.com> <20241210040404.10606-5-alibuda@linux.alibaba.com>
In-Reply-To: <20241210040404.10606-5-alibuda@linux.alibaba.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Dec 2024 14:24:46 -0800
Message-ID: <CAEf4BzYMWTTnniPN-2cmjkPOefDFOLgbdo0cHzmMNJiFPL8riQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/5] libbpf: fix error when st-prefix_ops and
 ops from differ btf
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	pabeni@redhat.com, song@kernel.org, sdf@google.com, haoluo@google.com, 
	yhs@fb.com, edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org, 
	davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 8:04=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.com>=
 wrote:
>
> When a struct_ops named xxx_ops was registered by a module, and
> it will be used in both built-in modules and the module itself,
> so that the btf_type of xxx_ops will be present in btf_vmlinux
> instead of in btf_mod, which means that the btf_type of
> bpf_struct_ops_xxx_ops and xxx_ops will not be in the same btf.
>
> Here are four possible case:
>
> +--------+-------------+-------------+---------------------------------+
> |        | st_opx_xxx  | xxx         |                                 |
> +--------+-------------+-------------+---------------------------------+
> | case 0 | btf_vmlinux | bft_vmlinux | be used and reg only in vmlinux |
> +--------+-------------+-------------+---------------------------------+
> | case 1 | btf_vmlinux | bpf_mod     | INVALID                         |
> +--------+-------------+-------------+---------------------------------+
> | case 2 | btf_mod     | btf_vmlinux | reg in mod but be used both in  |
> |        |             |             | vmlinux and mod.                |
> +--------+-------------+-------------+---------------------------------+
> | case 3 | btf_mod     | btf_mod     | be used and reg only in mod     |
> +--------+-------------+-------------+---------------------------------+
>
> At present, cases 0, 1, and 3 can be correctly identified, because
> st_ops_xxx is searched from the same btf with xxx. In order to
> handle case 2 correctly without affecting other cases, we cannot simply
> change the search method for st_ops_xxx from find_btf_by_prefix_kind()
> to find_ksym_btf_id(), because in this way, case 1 will not be
> recognized anymore.
>
> To address this issue, if st_ops_xxx cannot be found in the btf with xxx
> and mod_btf does not exist, do find_ksym_btf_id() again to
> avoid such issue.
>
> Fixes: 590a00888250 ("bpf: libbpf: Add STRUCT_OPS support")
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>  tools/lib/bpf/libbpf.c | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 66173ddb5a2d..046feab4ec36 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -994,6 +994,27 @@ static int find_ksym_btf_id(struct bpf_object *obj, =
const char *ksym_name,
>  static int find_btf_by_prefix_kind(const struct btf *btf, const char *pr=
efix,
>                                    const char *name, __u32 kind);
>
> +static int
> +find_ksym_btf_id_by_prefix_kind(struct bpf_object *obj, const char *pref=
ix,
> +                               const char *name,
> +                               __u16 kind, struct btf **res_btf,
> +                               struct module_btf **res_mod_btf)
> +{
> +       char btf_type_name[128];
> +       int ret;
> +
> +       ret =3D snprintf(btf_type_name, sizeof(btf_type_name),
> +                      "%s%s", prefix, name);
> +       /* snprintf returns the number of characters written excluding th=
e
> +        * terminating null. So, if >=3D BTF_MAX_NAME_SIZE are written, i=
t
> +        * indicates truncation.
> +        */
> +       if (ret < 0 || ret >=3D sizeof(btf_type_name))
> +               return -ENAMETOOLONG;
> +
> +       return find_ksym_btf_id(obj, btf_type_name, kind, res_btf, res_mo=
d_btf);
> +}

I don't think we need this helper, see below.

> +
>  static int
>  find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw=
,
>                            struct module_btf **mod_btf,
> @@ -1028,9 +1049,16 @@ find_struct_ops_kern_types(struct bpf_object *obj,=
 const char *tname_raw,
>         kern_vtype_id =3D find_btf_by_prefix_kind(btf, STRUCT_OPS_VALUE_P=
REFIX,
>                                                 tname, BTF_KIND_STRUCT);

instead of using find_btf_by_prefix_kind, let's have:

1) snprintf(STRUCT_OPS_VALUE_PREFIX, tname) right here in this
function, so we have expected type constructed and ready to be used
and reused, if necessary
2) call btf__find_by_name_kind() instead of find_btf_by_prefix_kind()
3) if (kern_vtype_id < 0 && !*mod_btf)
      kern_vtype_id =3D find_ksym_btf_id(...)
4) if (kern_vtype_id < 0) /* now emit error and error out */

>         if (kern_vtype_id < 0) {
> -               pr_warn("struct_ops init_kern: struct %s%s is not found i=
n kernel BTF\n",
> -                       STRUCT_OPS_VALUE_PREFIX, tname);
> -               return kern_vtype_id;
> +               if (kern_vtype_id =3D=3D -ENOENT && !*mod_btf)
> +                       kern_vtype_id =3D
> +                               find_ksym_btf_id_by_prefix_kind(obj, STRU=
CT_OPS_VALUE_PREFIX,
> +                                                               tname, BT=
F_KIND_STRUCT, &btf,
> +                                                               mod_btf);
> +               if (kern_vtype_id < 0) {
> +                       pr_warn("struct_ops init_kern: struct %s%s is not=
 found in kernel BTF\n",
> +                               STRUCT_OPS_VALUE_PREFIX, tname);
> +                       return kern_vtype_id;
> +               }
>         }
>         kern_vtype =3D btf__type_by_id(btf, kern_vtype_id);
>
> --
> 2.45.0
>

