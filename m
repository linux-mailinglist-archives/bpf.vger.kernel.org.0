Return-Path: <bpf+bounces-60094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7311FAD28DD
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF2A18923A1
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 21:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1093223300;
	Mon,  9 Jun 2025 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9zqKs0+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4C3155A4E
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749505047; cv=none; b=F3ko9ECVS3OECGr6kQ/dmaJVjPXHLPG3mtzPHjkbynuipNN0PtaReOfHKqjk9ziB3gItnrYwEas+byesHwHY1Mt3S2bwU6kUZ7mzpG8MceEvgkcEGwH1RWk2Xnaggw04mVp7o5s/GqiHxAu1G3B/9UaMhlSC34uEXTgsPQ3O9wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749505047; c=relaxed/simple;
	bh=E4kVdnJyNBOzsK2ubywSpWtLJtgfo5Ptb1LY9S7+UYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAF+05uYB/gRnS8iTZqdoLdU++9869GMxNDkmgHOHasNirLCIplX8LNAJLvV+KLoeN1IwefMrPtIiXVtiAnlTWJw+Vs3HJZjhFFqBwLUNEpTNH8N2O9eEFsmYxa9wTraBpHF3jIG9XtJVyi0vhHR8ZAPOf+oKsYoWiQTsFItGUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9zqKs0+; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b2f1032e1c4so4437202a12.3
        for <bpf@vger.kernel.org>; Mon, 09 Jun 2025 14:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749505045; x=1750109845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqpVLgH96lMNbMDL9xo9D2HBha9k4urItiv8k+IEx0g=;
        b=k9zqKs0+uxGFM8aCkfJ91TChR1ZfMiMHXKcFrwZfRmJj/72D+pcpn9OwGHu2SjehR6
         xbEw78m1fD+7jC8uzhqgDdkGa4ILLWeNORZBsa+OgDE+saKWaGGpEm+ODVCtXf5yFfaw
         7jbCc6GO8T/4ppvNWcpDKn6KKjD470pxGgzkdSb2VyZjA+IkLYXYcaa7p3NanGs5wGL0
         GKw4cIDyTDuhNyDa+h0RjQqYDVeBnD6A33MOhrnvsqaUO9PKcGsbkzC45SpSztgi4uFu
         o1WRMNR93nUpFQp0DW8q8JvIHIcfhHddskFLTgdM3ObrqOVMzM5fPLFiBCXiKAoGm1Tw
         AIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749505045; x=1750109845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqpVLgH96lMNbMDL9xo9D2HBha9k4urItiv8k+IEx0g=;
        b=v7J6V0Bvv1W0vAXHHjD9TTK5tfFjX3GkRPpOSx+jPG6CAefzjxUGmJGjz6wg/XrU40
         TTEgsxyEM7iLj/2vlBOYbJpeNX1O3Dnjlni+YRVgTDqRzAN77GVpF2jvFlZHFL6iyxTd
         jS3VxM6QZel21TB2lvbp4NthlVpdtKvTbnqlv6FeCT7sSHqRtw9NoLn+UTyw32P+kuoS
         ceXC1oebrJCc/W7lnfzvVGs1yhO+vo90Wj5xvZ0SJSN4qecHtACvGM2cfM3aJd76D6IQ
         VkaidbcWmzTIicO8I8QDXckx3NiOwdk86QW97E/j80WB9E26rbRpdxmJ/Mlx9BzgbC5a
         NJmQ==
X-Gm-Message-State: AOJu0YyPm8x6gN46GSt3Hu938XEyqIQI1m/N84BzJXB4uTYAMzGRsvST
	6/z8BRv7mf6WaS0f9ijGm0U7TrkKGmlQkOlgsGtyH0I+uCeL9zjons6rPhE29ZI3Wwy5CPrdbIz
	74lOHf5MpVtrJz/80jJyIYEGTBCt7mhM=
X-Gm-Gg: ASbGncsMVFshmJB5x5g2LnlQKL0zpZJd+O84sVykChzi1eNd5NcCnmNqzugq6sfAoFc
	9A7MX3IaVsdGIAEJdRPbT979XkPgyqVU7S0JlVBI2UFmWYg3/c/IzkxKMfZMY9s61VeZYXQnzuN
	+bGI+Zq9It5TEr4qPCmmCBEiHoOOsU5INOJUgd+HL+konIUbiaWAgTDVRpVrI=
X-Google-Smtp-Source: AGHT+IEsZgJ5S6q6EbM5O4EAlnRUsiYcrSNgSKMzOPQpArcn5kuTLt0ewOEPSda9fkQ3fHEUHdotkqLUEr1jY+R+mO0=
X-Received: by 2002:a17:90b:3b92:b0:311:a4d6:30f8 with SMTP id
 98e67ed59e1d1-313472ec763mr20375665a91.13.1749505044900; Mon, 09 Jun 2025
 14:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605183642.1323795-1-mykyta.yatsenko5@gmail.com> <20250605183642.1323795-3-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250605183642.1323795-3-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Jun 2025 14:37:12 -0700
X-Gm-Features: AX0GCFuiDSmuAiLXblQIw2IqbiefZHJcHjXiKBrYxF7RQEp84I6hAi7CrBCWtgA
Message-ID: <CAEf4BzaWS4exprOLUN78QfH-_HzL4KQr6cw3rr1_gt3sHroYug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: support array presets in veristat
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 11:36=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Implement support for presetting values for array elements in veristat.
> For example:
> ```
> sudo ./veristat set_global_vars.bpf.o -G "arr[3] =3D 1"
> ```
> Arrays of structures and structure of arrays work, but each individual
> scalar value has to be set separately: `foo[1].bar[2] =3D value`.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 145 +++++++++++++++++++++----
>  1 file changed, 126 insertions(+), 19 deletions(-)
>

[...]

> @@ -1440,7 +1458,7 @@ static int append_var_preset(struct var_preset **pr=
esets, int *cnt, const char *
>         memset(cur, 0, sizeof(*cur));
>         (*cnt)++;
>
> -       if (sscanf(expr, "%s =3D %s %n", var, val, &n) !=3D 2 || n !=3D s=
trlen(expr)) {
> +       if (sscanf(expr, "%[][a-zA-Z0-9_.] =3D %s %n", var, val, &n) !=3D=
 2 || n !=3D strlen(expr)) {
>                 fprintf(stderr, "Failed to parse expression '%s'\n", expr=
);
>                 return -EINVAL;
>         }
> @@ -1533,6 +1551,74 @@ static bool is_preset_supported(const struct btf_t=
ype *t)
>         return btf_is_int(t) || btf_is_enum(t) || btf_is_enum64(t);
>  }
>
> +static int find_enum_value(const struct btf *btf, const char *name, int =
*value)

shouldn't value be long long or u64?

> +{
> +       const struct btf_type *t;
> +       int cnt, i;
> +       long long lvalue;
> +
> +       cnt =3D btf__type_cnt(btf);
> +       for (i =3D 1; i !=3D cnt; ++i) {
> +               t =3D btf__type_by_id(btf, i);
> +
> +               if (!btf_is_any_enum(t))
> +                       continue;
> +
> +               if (enum_value_from_name(btf, t, name, &lvalue) =3D=3D 0)=
 {
> +                       *value =3D (int)lvalue;

why truncating here?

> +                       return 0;
> +               }
> +       }
> +       return -ESRCH;
> +}
> +
> +static int adjust_array_secinfo(const struct btf *btf, const struct btf_=
type *t,
> +                               const struct var_preset_atom *var_atom,
> +                               struct btf_var_secinfo *sinfo)
> +{
> +       struct btf_array *barr;
> +       const struct btf_type *type;
> +       int tid, index;
> +
> +       if (!btf_is_array(t))
> +               return -EINVAL;
> +
> +       barr =3D btf_array(t);
> +       tid =3D btf__resolve_type(btf, barr->type);
> +       type =3D btf__type_by_id(btf, tid);
> +       if (!btf_is_int(type) && !btf_is_any_enum(type) && !btf_is_compos=
ite(type)) {
> +               fprintf(stderr,
> +                       "Unsupported array type for variable %s. Only int=
, enum, struct, union are supported\n",

array element type?

> +                       var_atom->name);
> +               return -EINVAL;
> +       }
> +       switch (var_atom->index.type) {
> +       case INTEGRAL:
> +               index =3D var_atom->index.ivalue;
> +               break;
> +       case ENUMERATOR:
> +               if (find_enum_value(btf, var_atom->index.svalue, &index) =
!=3D 0) {
> +                       fprintf(stderr, "Could not find array index as en=
um value %s",

nit: maybe "Can't resolve %s enum as an array index"?

> +                               var_atom->index.svalue);
> +                       return -EINVAL;
> +               }
> +               break;
> +       case NONE:
> +               fprintf(stderr, "Array index is expected for %s\n", var_a=
tom->name);
> +               return -EINVAL;
> +       }
> +
> +       if (index < 0 || index >=3D barr->nelems) {
> +               fprintf(stderr, "Preset index %d is invalid or out of bou=
nds [0, %d]\n",

nelems is u32, so %u

> +                       index, barr->nelems);
> +               return -EINVAL;
> +       }
> +       sinfo->size =3D type->size;
> +       sinfo->type =3D tid;
> +       sinfo->offset +=3D index * type->size;
> +       return 0;
> +}
> +
>  const int btf_find_member(const struct btf *btf,
>                           const struct btf_type *parent_type,
>                           __u32 parent_offset,
> @@ -1540,7 +1626,7 @@ const int btf_find_member(const struct btf *btf,
>                           int *member_tid,
>                           __u32 *member_offset)
>  {
> -       int i;
> +       int i, err;
>
>         if (!btf_is_composite(parent_type))
>                 return -EINVAL;
> @@ -1559,16 +1645,27 @@ const int btf_find_member(const struct btf *btf,
>                 if (member->name_off) {
>                         const char *name =3D btf__name_by_offset(btf, mem=
ber->name_off);
>
> -                       if (strcmp(var_atom->name, name) =3D=3D 0) {
> -                               if (btf_member_bitfield_size(parent_type,=
 i) !=3D 0) {
> -                                       fprintf(stderr, "Bitfield presets=
 are not supported %s\n",
> -                                               name);
> -                                       return -EINVAL;
> -                               }
> -                               *member_offset =3D parent_offset + member=
->offset;
> -                               *member_tid =3D tid;
> -                               return 0;
> +                       if (strcmp(var_atom->name, name) !=3D 0)
> +                               continue;
> +
> +                       if (btf_member_bitfield_size(parent_type, i) !=3D=
 0) {
> +                               fprintf(stderr, "Bitfield presets are not=
 supported %s\n",
> +                                       name);
> +                               return -EINVAL;
> +                       }
> +                       *member_offset =3D parent_offset + member->offset=
;
> +                       *member_tid =3D tid;
> +                       if (btf_is_array(member_type)) {
> +                               struct btf_var_secinfo sinfo =3D {.offset=
 =3D 0};
> +
> +                               err =3D adjust_array_secinfo(btf, member_=
type,
> +                                                          var_atom, &sin=
fo);
> +                               if (err)
> +                                       return err;
> +                               *member_tid =3D sinfo.type;
> +                               *member_offset +=3D sinfo.offset * 8;
>                         }
> +                       return 0;
>                 } else if (btf_is_composite(member_type)) {
>                         int err;

error message if array index is specified for non-array type?

please check again my comments around this functions from [0]

  [0] https://lore.kernel.org/bpf/CAEf4Bzb3=3DbrMXMBZ-AGj8xdr80XEs2Og0XeZ1z=
uiHnFNWWPJJQ@mail.gmail.com/

>
> @@ -1579,7 +1676,7 @@ const int btf_find_member(const struct btf *btf,
>                 }
>         }
>
> -       return -EINVAL;
> +       return -ESRCH;
>  }
>
>  static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
> @@ -1590,6 +1687,12 @@ static int adjust_var_secinfo(struct btf *btf, con=
st struct btf_type *t,
>         __u32 member_offset =3D 0;
>
>         base_type =3D btf__type_by_id(btf, btf__resolve_type(btf, t->type=
));
> +       if (btf_is_array(base_type)) {
> +               err =3D adjust_array_secinfo(btf, base_type, &preset->ato=
ms[0], sinfo);
> +               if (err)
> +                       return err;
> +               base_type =3D btf__type_by_id(btf, sinfo->type);
> +       }
>
>         for (i =3D 1; i < preset->atom_count; ++i) {
>                 err =3D btf_find_member(btf, base_type, 0, &preset->atoms=
[i],
> @@ -1739,8 +1842,9 @@ static int set_global_vars(struct bpf_object *obj, =
struct var_preset *presets, i
>         }
>         for (i =3D 0; i < npresets; ++i) {
>                 if (!presets[i].applied) {
> -                       fprintf(stderr, "Global variable preset %s has no=
t been applied\n",
> -                               presets[i].full_name);
> +                       fprintf(stderr, "Global variable preset %s has no=
t been applied %s\n",

is this a debugging leftover? not sure why logging both full name and
just first atom?..


> +                               presets[i].full_name, presets[i].atoms[0]=
.name);
> +                       err =3D -EINVAL;
>                 }
>                 presets[i].applied =3D false;
>         }
> @@ -2928,8 +3032,11 @@ int main(int argc, char **argv)
>         free(env.deny_filters);
>         for (i =3D 0; i < env.npresets; ++i) {
>                 free(env.presets[i].full_name);
> -               for (j =3D 0; j < env.presets[i].atom_count; ++j)
> +               for (j =3D 0; j < env.presets[i].atom_count; ++j) {
>                         free(env.presets[i].atoms[j].name);
> +                       if (env.presets[i].atoms[j].index.type =3D=3D ENU=
MERATOR)
> +                               free(env.presets[i].atoms[j].index.svalue=
);
> +               }
>                 free(env.presets[i].atoms);
>                 if (env.presets[i].value.type =3D=3D ENUMERATOR)
>                         free(env.presets[i].value.svalue);
> --
> 2.49.0
>

