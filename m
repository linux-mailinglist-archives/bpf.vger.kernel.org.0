Return-Path: <bpf+bounces-78806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B05DED1BFD0
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BEB5300BBCF
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49382EE5F5;
	Wed, 14 Jan 2026 01:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps1N9uyw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A612C1DF25C
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768355360; cv=none; b=iVzpuHQ3TaL3qF9lfLJH94fKJHBwFreHEOLqQ77atQnmxzILElZmJUl3j4l6vyZSJId2lVqF/FO4ZC87BMhO7HrW/rbYz90SoNQXmD6e+soJZJsfmB/cnuTrpj6r08EUW3TEH2KPm9+zIsXQElBMGJCJfZ6DmbRnh2KZ3qLCY78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768355360; c=relaxed/simple;
	bh=GcPBYle2UY0TsGxyrHXndfCmm4g02ubRWfykX1Q6SV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BR0Lvw+8MWS+2JUlAJrYYNtRbRAysmRc2sji0UUdUQhI/0OyDOd5/V7JH8voAfOojXghx4r0Ztp2cURaJIfwGcLfSBTUx5htXjZ9hTX7KUeYSzzqsgcBE/cLSWGrPiuASb526yPgOOC4vYuDhRFHfGSLyURBzSYpnbvuKOLuhTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps1N9uyw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8719aeebc8so458344566b.3
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 17:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768355357; x=1768960157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fbTD91Yc6BxI43Vnt8FP1n4Ymu/LDH777oBTaDdgN8=;
        b=Ps1N9uywCHlzFZqEGAaAvVYDBh4XdC3S0UUdt7FK6r4NhmCCOyvGBhULTO4IycHunP
         ZkDgYpTS+KRKw3D3ZFD4oGt4N2li5gFtdlN6vMWEgnwIUBMZzbLRMnJlB2OofTD9zA8c
         PFp97zeqAA1zImL/5BDca9sBwi/6kw30WJ2rFP/71HZCugQjEwy7E6rZxIN2K21rBI8J
         aBIGKPwpSC1vVsRQgysyHJfJXCF2I3PoiO8p3XQevhduW1WNPqjQ+/MowRMKxTaiMHg1
         eDPV1bLztu+ZuRM9ByeH6zU7EZsIxfOcDHOEZwMF3SNrhAOYwgYbMnhYZ/t9xwH3Cv+j
         zrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768355357; x=1768960157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1fbTD91Yc6BxI43Vnt8FP1n4Ymu/LDH777oBTaDdgN8=;
        b=MYpkGdmhBTowMQ0m4hP93RP6S/ehhLFbp3JK+A+/IaAfeVSbwdsyTMuOne7osokCwZ
         DpFMqXEzZWJJjN8A3aM6+3s3un3XHhaZxXGEWB1H5OdRt7S+NcBA9X6WRQiPco//duqZ
         FTJdUmg7EloqcB/Oc5vD0pWlfvgbrCSaj1QT1JSTkS78TxBYutc1LBssh2UgbIj1hMIV
         jfnknU9q9pyreNftqWOvAI2ecmdiGcHC1zabI/xHPdjalP0U50TSOjQyUWW4s/cr4p/W
         7ylih3DT3dDkZg0MachvvUPELlzJgJraP+80eprth4pO3TWi1Thl68yOx2pgimhwKq76
         toYA==
X-Forwarded-Encrypted: i=1; AJvYcCU45P0RwBYhvshJEnbLbf04M4GWlM2z0umrI6Avyrm6uD5/wcA86BJkttNkrO9uE+XkrCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlfaVILIbpJuDbrPg6gB6jUbkSsewz1tgyzBDoqD5PGqBIV+nC
	KMsMJLeC1dJeuQvle/+mc8dVkrJwsVt9uQKfvcVn5TnbWuSXEI4haZvwba1kYwVtM1rqi4UV4QQ
	aJkViVRWUiDbhHGBqdff1IaWRRXhOWDE=
X-Gm-Gg: AY/fxX5F5sERoHVdBIpuVAeGtb78PF9O2mNKGru/88SKcrb1G3tRrO5mM9CHEPDjQ+I
	ArARZraxJBgVUN2CWoncJZeTlSK/UToa56jsghRDrEXUgtdJaIiYwKhP8JHNeo7959jHYgz8Jik
	u7qdTvg+7+ZY07nngP0/wOklhhz8dZRqHrMmMKYrU4xh3naVTIm7q4RrZif1Xk/s/UDls3+heYG
	AunSLPFoBqaNhJBOGs6d+69yOvHAPqavQisKyKPdHfIJaUKBtmrfoBHaQ+NHwcnRdopsGRR
X-Received: by 2002:a17:906:6a02:b0:b87:25a6:a906 with SMTP id
 a640c23a62f3a-b87677e0680mr25164066b.46.1768355356989; Tue, 13 Jan 2026
 17:49:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109130003.3313716-1-dolinux.peng@gmail.com>
 <20260109130003.3313716-5-dolinux.peng@gmail.com> <CAEf4BzZkNdZuSWb+G98LDSn3gL22p+g7-dHqFVH6jcqUsrKYVA@mail.gmail.com>
In-Reply-To: <CAEf4BzZkNdZuSWb+G98LDSn3gL22p+g7-dHqFVH6jcqUsrKYVA@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 14 Jan 2026 09:49:06 +0800
X-Gm-Features: AZwV_Qimb0HZGJh9IM83z2GV5y12aN5T2yq0WEPvKBTWhUnnYv4mzOxxPRsoWsU
Message-ID: <CAErzpmvj0JM_TuYwR0FPbZ_jNAqqeq1dRK1n6r_nGiEzjQ8oDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 04/11] libbpf: Optimize type lookup with
 binary search for sorted BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 8:29=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jan 9, 2026 at 5:00=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.c=
om> wrote:
> >
> > From: Donglin Peng <pengdonglin@xiaomi.com>
> >
> > This patch introduces binary search optimization for BTF type lookups
> > when the BTF instance contains sorted types.
> >
> > The optimization significantly improves performance when searching for
> > types in large BTF instances with sorted types. For unsorted BTF, the
> > implementation falls back to the original linear search.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> > ---
> >  tools/lib/bpf/btf.c | 90 +++++++++++++++++++++++++++++++++------------
> >  1 file changed, 66 insertions(+), 24 deletions(-)
> >
>
> [...]
>
> >  static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id=
,
> > -                                  const char *type_name, __u32 kind)
> > +                                  const char *type_name, __s32 kind)
> >  {
> > -       __u32 i, nr_types =3D btf__type_cnt(btf);
> > +       const struct btf_type *t;
> > +       const char *tname;
> > +       __s32 idx;
> > +
> > +       if (start_id < btf->start_id) {
> > +               idx =3D btf_find_by_name_kind(btf->base_btf, start_id,
> > +                                           type_name, kind);
> > +               if (idx >=3D 0)
> > +                       return idx;
> > +               start_id =3D btf->start_id;
> > +       }
> >
> > -       if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
> > +       if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =3D=
=3D 0)
> >                 return 0;
> >
> > -       for (i =3D start_id; i < nr_types; i++) {
> > -               const struct btf_type *t =3D btf__type_by_id(btf, i);
> > -               const char *name;
> > +       if (btf->named_start_id > 0 && type_name[0]) {
> > +               start_id =3D max(start_id, btf->named_start_id);
> > +               idx =3D btf_find_type_by_name_bsearch(btf, type_name, s=
tart_id);
> > +               for (; idx < btf__type_cnt(btf); idx++) {
>
> I hope the compiler will optimize out btf__type_cnt() and won't be
> recalculating it all the time, but I'd absolutely make sure by keeping
> nr_types local variable which you deleted for some reason. Please
> include in your follow up.

Thanks, I will optimize it.

>
> > +                       t =3D btf__type_by_id(btf, idx);
> > +                       tname =3D btf__str_by_offset(btf, t->name_off);
> > +                       if (strcmp(tname, type_name) !=3D 0)
> > +                               return libbpf_err(-ENOENT);
> > +                       if (kind < 0 || btf_kind(t) =3D=3D kind)
> > +                               return idx;
> > +               }
> > +       } else {
> > +               __u32 i, total;
> >
> > -               if (btf_kind(t) !=3D kind)
> > -                       continue;
> > -               name =3D btf__name_by_offset(btf, t->name_off);
> > -               if (name && !strcmp(type_name, name))
> > -                       return i;
> > +               total =3D btf__type_cnt(btf);
>
> and here you have a local total pre-calculated. Just move it outside
> of this if/else and use in both branches

Thanks, I will fix it.

>
> (I adjusted this trivially while applying, also unified idx,i -> id

Thanks, I will fix it in v13.

>
>
> > +               for (i =3D start_id; i < total; i++) {
> > +                       t =3D btf_type_by_id(btf, i);
> > +                       if (kind > 0 && btf_kind(t) !=3D kind)
> > +                               continue;
> > +                       tname =3D btf__str_by_offset(btf, t->name_off);
> > +                       if (strcmp(tname, type_name) =3D=3D 0)
> > +                               return i;
> > +               }
> >         }
> >
>
> [...]

