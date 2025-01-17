Return-Path: <bpf+bounces-49227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63936A1571B
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 19:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EAE03A2A6A
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 18:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB2A1DFD81;
	Fri, 17 Jan 2025 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBnz7DNy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85161DF97F;
	Fri, 17 Jan 2025 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139025; cv=none; b=hzDOfvCnXZV2kzFRa1k0enYlCAs87UKJmy9u6FQOSMytV+v1CvPdw7tHopYONovyUhdDjnBk14FYRS7JwQgWh1RYKpxEmpYK7Z8hoTaPV+shckQAzKGMYAgS7HBB0J+lBb/z71DoDfFjyfG+4bM9A5jG9z379GlC6wjUn7MJBR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139025; c=relaxed/simple;
	bh=L5nptAiaGY2hZpZb1eHBCcH++P2uqkiVoyI3tk7Jz1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+s1BBT3dw9Qj4lMlFrHkkMoIhIzLhraCS8URoB1IMYiFu5+8/gNs5fTtGtsMgRdIrNvgA+9XKh/WBVy/pIkZfbEYeOFoNi9Ig+GzZeOZbEhYraDhsSyJYlzFBHEF047hTf+sFxChxx9+KqymFyfo71xucGBl4El9DTiq3QYYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBnz7DNy; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso3462428a91.1;
        Fri, 17 Jan 2025 10:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737139023; x=1737743823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/paU3XV2YsdW8sqUdUFAzVL/jr9cL20VV7Pd7X+jfQo=;
        b=jBnz7DNyBDc0KzCvuble9xh/KNs1BDPuaAL027+/jWJXt5aHFI6WmvjGowjx73grX0
         B45n4ZMvy7XaOXuIlBeJirgLcHyhEU71VAl4Dah7hci+oCfFM2NTj0OcDUZufDKSqdCm
         pG1YZkJcy4chxfWvDOQjlAoqVgjfNQcek1QN7rlEgGnbefnWPV1+pJgo7FJvSmkCHac6
         RiVxb6ifmoQZ+qXEepD6krrhT7vI06JJtehYk2gL5nFLdjf0GIbzI1Ls7TLAeuVObI7e
         6CUPzn7VAhG1fEwInaYH12i2Zbcq0hhEiyLW2cG03mhjeyee5EP1yhrTFn+K+TTb2VmL
         lFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737139023; x=1737743823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/paU3XV2YsdW8sqUdUFAzVL/jr9cL20VV7Pd7X+jfQo=;
        b=W54ayDDRb5j5++2Cy7YR0TgOx3iKe3lPUhIldk+S8e1YIk+Sph+qvdeZ5eC7Mo6X7K
         +Q6fVfN3OUx557MVCLDbS3uVnlVYu6CYQ5CbdC6dPV0dVsnLWOP8xYZljpCLBe92zh7V
         XPfihaSyANHtRwlXmRR2pFgzlqhPoFx+791inxvei11lL/IA6ps8W8/1oQdIbRSxvDH5
         b4jBp5a2xI7om1gzP8CzVeD7+813No+oYDgiffdUBwK0UFZTRfleRp3mkNq0IQcY8kKo
         La0plFIVhdB37UDvxROvr6P0oaM2iq/0uGQzKRQ1MZ++GsgVyAcGLlSD2qkEmdJ8ARWp
         vBkw==
X-Forwarded-Encrypted: i=1; AJvYcCV7G9ibuecgzcXVg6QJWnkWE8EUy53WostzEl27HVNEhWbjCifeYnf2REEmFUg+IOZ534wPfbLM@vger.kernel.org, AJvYcCX5J1Zk0sAQyZRbumtVUUCFJR77qotZ4bN6KloH1OvWw81CjbrA3yhY0rjs0URWOKFQrWo=@vger.kernel.org, AJvYcCXEtZnLYCeEOWPluCxdbA01ldcl4VLlmQQ3VUOSmCt/SJav9YT7kLz3axEXb9BhpDhaeLAHaV48i7sYXg==@vger.kernel.org, AJvYcCXcfC9jb0I6JF/68KWoGILKz6Y1/E/2Qj2Lz0sT00QegSPGYqXqN25qvyMSG8JLKX9foNsaG4uvab0lqg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn519TAm8z0PCrvawjiITyEGZQj9ChAxj2+3S6yLenUneVyq8b
	ORiG9jFG8xCuJj86e2yBF5qxL8eb0Jv2nykJA1VE8bl06OWsXaHtCdXGvvVac9uTlqN7OqeLpL/
	ComVtxjfTzjnns9LZzOm0gtyrzXI=
X-Gm-Gg: ASbGnctCEF21aOtTplhr0CGacO6HnsJBOmSZ9oiGTdAqTf57gWOS5BAJLAlptdBNJNo
	RURZK1tPJ2cdqskgGwkO1vxIz4Wga7RPE0b5C
X-Google-Smtp-Source: AGHT+IHlKXjKmNWGoqU/eH4r2mE6aT+7ReHvtK4TLTDiMthduAsThbIwDyr+XObLaRSjQuTbphVlH9jain7orH9zxZE=
X-Received: by 2002:a17:90b:534b:b0:2ee:a6f0:f54 with SMTP id
 98e67ed59e1d1-2f782c93df5mr5199405a91.13.1737139023096; Fri, 17 Jan 2025
 10:37:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116074442.79304-1-alibuda@linux.alibaba.com> <20250116074442.79304-5-alibuda@linux.alibaba.com>
In-Reply-To: <20250116074442.79304-5-alibuda@linux.alibaba.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Jan 2025 10:36:50 -0800
X-Gm-Features: AbW1kvZPOA_e4VBRxGF2UR8BvcgPSnH8-FR3ERgszYydOW9nflDbMRjIRPEPz28
Message-ID: <CAEf4BzZvxqiQ2J1XQMm-ZDBjSsmtJJk6-_RbexPk9vWxAO=ksw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 4/5] libbpf: fix error when st-prefix_ops and
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

On Wed, Jan 15, 2025 at 11:45=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.co=
m> wrote:
>
> When a struct_ops named xxx_ops was registered by a module, and
> it will be used in both built-in modules and the module itself,
> so that the btf_type of xxx_ops will be present in btf_vmlinux
> instead of in btf_mod, which means that the btf_type of
> bpf_struct_ops_xxx_ops and xxx_ops will not be in the same btf.
>
> Here are four possible case:
>
> +--------+---------------+-------------+---------------------------------=
+
> |        | st_ops_xxx_ops| xxx_ops     |                                 =
|
> +--------+---------------+-------------+---------------------------------=
+
> | case 0 | btf_vmlinux   | bft_vmlinux | be used and reg only in vmlinux =
|
> +--------+---------------+-------------+---------------------------------=
+
> | case 1 | btf_vmlinux   | bpf_mod     | INVALID                         =
|
> +--------+---------------+-------------+---------------------------------=
+
> | case 2 | btf_mod       | btf_vmlinux | reg in mod but be used both in  =
|
> |        |               |             | vmlinux and mod.                =
|
> +--------+---------------+-------------+---------------------------------=
+
> | case 3 | btf_mod       | btf_mod     | be used and reg only in mod     =
|
> +--------+---------------+-------------+---------------------------------=
+
>
> At present, cases 0, 1, and 3 can be correctly identified, because
> st_ops_xxx_ops is searched from the same btf with xxx_ops. In order to
> handle case 2 correctly without affecting other cases, we cannot simply
> change the search method for st_ops_xxx_ops from find_btf_by_prefix_kind(=
)
> to find_ksym_btf_id(), because in this way, case 1 will not be
> recognized anymore.
>
> To address the issue, we always look for st_ops_xxx_ops first,
> figure out the btf, and then look for xxx_ops with the very btf to avoid
> such issue.
>
> Fixes: 590a00888250 ("bpf: libbpf: Add STRUCT_OPS support")
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>  tools/lib/bpf/libbpf.c | 41 +++++++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 18 deletions(-)
>

Other than a few nits below, LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 66173ddb5a2d..202bc4c1001e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1005,14 +1005,33 @@ find_struct_ops_kern_types(struct bpf_object *obj=
, const char *tname_raw,
>         const struct btf_member *kern_data_member;
>         struct btf *btf =3D NULL;
>         __s32 kern_vtype_id, kern_type_id;
> -       char tname[256];
> +       char tname[256], stname[256];
> +       int ret;
>         __u32 i;
>
>         snprintf(tname, sizeof(tname), "%.*s",
>                  (int)bpf_core_essential_name_len(tname_raw), tname_raw);
>
> -       kern_type_id =3D find_ksym_btf_id(obj, tname, BTF_KIND_STRUCT,
> +       ret =3D snprintf(stname, sizeof(stname), "%s%s", STRUCT_OPS_VALUE=
_PREFIX,
> +                      tname);
> +       if (ret < 0 || ret >=3D sizeof(stname))
> +               return -ENAMETOOLONG;

see preexisting snprintf() above, we don't really handle truncation
errors explicitly, they are extremely unlikely and not expected at
all, and worst case nothing will be found and user will get some
-ENOENT or something like that eventually. I'd drop this extra error
checking and keep it streamlines, similar to tname

> +
> +       /* Look for the corresponding "map_value" type that will be used
> +        * in map_update(BPF_MAP_TYPE_STRUCT_OPS) first, figure out the b=
tf
> +        * and the mod_btf.
> +        * For example, find "struct bpf_struct_ops_tcp_congestion_ops".
> +        */
> +       kern_vtype_id =3D find_ksym_btf_id(obj, stname, BTF_KIND_STRUCT,
>                                         &btf, mod_btf);

nit: if this fits under 100 characters, keep it single line

> +       if (kern_vtype_id < 0) {
> +               pr_warn("struct_ops init_kern: struct %s is not found in =
kernel BTF\n",
> +                               stname);

same nit about preserving single-line statements as much as possible,
they are much easier to read

> +               return kern_vtype_id;
> +       }
> +       kern_vtype =3D btf__type_by_id(btf, kern_vtype_id);
> +
> +       kern_type_id =3D btf__find_by_name_kind(btf, tname, BTF_KIND_STRU=
CT);
>         if (kern_type_id < 0) {
>                 pr_warn("struct_ops init_kern: struct %s is not found in =
kernel BTF\n",
>                         tname);
> @@ -1020,20 +1039,6 @@ find_struct_ops_kern_types(struct bpf_object *obj,=
 const char *tname_raw,
>         }
>         kern_type =3D btf__type_by_id(btf, kern_type_id);
>
> -       /* Find the corresponding "map_value" type that will be used
> -        * in map_update(BPF_MAP_TYPE_STRUCT_OPS).  For example,
> -        * find "struct bpf_struct_ops_tcp_congestion_ops" from the
> -        * btf_vmlinux.
> -        */
> -       kern_vtype_id =3D find_btf_by_prefix_kind(btf, STRUCT_OPS_VALUE_P=
REFIX,
> -                                               tname, BTF_KIND_STRUCT);
> -       if (kern_vtype_id < 0) {
> -               pr_warn("struct_ops init_kern: struct %s%s is not found i=
n kernel BTF\n",
> -                       STRUCT_OPS_VALUE_PREFIX, tname);
> -               return kern_vtype_id;
> -       }
> -       kern_vtype =3D btf__type_by_id(btf, kern_vtype_id);
> -
>         /* Find "struct tcp_congestion_ops" from
>          * struct bpf_struct_ops_tcp_congestion_ops {
>          *      [ ... ]
> @@ -1046,8 +1051,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, =
const char *tname_raw,
>                         break;
>         }
>         if (i =3D=3D btf_vlen(kern_vtype)) {
> -               pr_warn("struct_ops init_kern: struct %s data is not foun=
d in struct %s%s\n",
> -                       tname, STRUCT_OPS_VALUE_PREFIX, tname);
> +               pr_warn("struct_ops init_kern: struct %s data is not foun=
d in struct %s\n",
> +                       tname, stname);
>                 return -EINVAL;
>         }
>
> --
> 2.45.0
>

