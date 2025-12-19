Return-Path: <bpf+bounces-77127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD14ECCE7CF
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 06:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3F3330285A5
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 05:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025A52BE029;
	Fri, 19 Dec 2025 05:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7Tz1hPN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B3C2264CB
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 05:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766120851; cv=none; b=La2r61NV2KRiKlnyxSwJsVGk8yhZZ+AseWGkQIMKTokTmFNbwJfRX+JCjCUxjvYKXttRr6SaByUTk1FFFFvC1VuiCEOpBPAEWma76QwxRQdwsutdL/uH9KboI5mJVroi/nbZlvgvBLFTrZHMwPBUWh+Xq8OYWJHEFuJf+Gh5TbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766120851; c=relaxed/simple;
	bh=/PqMDfHlgwA4Dfg00VUouUAAheUwA6LqX/ge8ZcElug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UobHXRv8lT4gflBLVz35XrKDcEUWKD5ZoYGTYhTn7qxAp9lmHnwC9yJMDj4aDXItaTgvUx/K10iwC7DEnn9Y/kASqfiTMh+1/l7tiHIEYUpYlvp+egZiNJaf8coFiUs48CcLM5q1kSeeS0SsqHD5fxC649kABNUS1DXDcETYayM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7Tz1hPN; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so2562405a12.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 21:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766120848; x=1766725648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5aJc9Ft0Oicca4g+MphUEOv8dP4L16YzoQQDP1uwCU=;
        b=h7Tz1hPNcpUQgvSFS7/ze5QmN+sesv8ZBsRDgS2/M8jhGEpLXjUOKnUwMzAChGakQI
         8lqmRvt6dtsHGBrBnmZRtthlMVkebhZ6o5gvvXtEST+3EcbDrqSHNhpan9+9Gqzu7J0p
         nFgD2Db25IXrUJzmNIWCTCoeYiVOCBKTcOf1TJR59QS9y4GQy5Xkf8ZTjMrdEzZPb0+/
         0lfFr9SNEJSxz/VHdjh+I7FhCyfl82b/Om8bUqriZh9mboDbXzFOYVo0iU5b2V9TNypl
         Murf1bNyi45EuGXhihDmTEAnrLMQNKwWlafaBszQyXR3NhSueiyDWVeGF6PfK0Qy4Caj
         EFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766120848; x=1766725648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G5aJc9Ft0Oicca4g+MphUEOv8dP4L16YzoQQDP1uwCU=;
        b=jK7q1GieFAaJL1wY69DYm3mGlXaGW0H8DLUnZnLaqM6weWxyCWIwUaQfNdlQdbyq0g
         0jkB6xDD7HjjKD+D6SveUtr5Bc8ta+EMiolddVppKrsnd8WUGIDVuLKho3FICSJrv1y3
         Uaa+AHl1rifDjuiQO5fVLwjsnq7VymEV/wxR4e+GZc1V0h9Why2+txN6pi02/agkpOzg
         6pq5Cn9XOXVOFZJdDtS47NJuyDCeWXrK3VcB31voS46Zd/ql9HaRQ7v3svhfTrTQFFNc
         bRFy6LG7WcBCtGqDdFrYOOO7pWLfiujQ13j23A28ra5sbQMcaprgKiCxm7pHZF15zuMg
         9qKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeP/FRKXjQJ2DXNIi2000NruaWiVYSpu6wvzpQD+eT/2K+97QtEdFgeYF2XCoaMGptoMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbLlZxScdjkgDsF+7Km0n4xHl6Xa+lIqxshMF/z3p98srOjNmm
	VJoVWOD1HFg3atBTIebKFgdcM8xIKXwFIiDVO4ywtZTYxzqUa31JDHi8qc1gnL6MptvvAOt7IkF
	2OrQ7V+hvWLHYPodETqKq0m59ZH43HAk=
X-Gm-Gg: AY/fxX7BlmxurP1XQlWepLv1rAqanS1aZzKpDARJq/I/QyG4mVm2MaDlJwipzfoP5S5
	WEEY90ye66PMqQcLsk9DaPyNhErj66B402EPtgsmSe78IzRF10+GiHvs+b62ZQ7lXQU/a+WDgW1
	2vUc+U+gdnoLphS6esSqvuUZ/5pF2fOBiQqk4Db4B7rywZAjnyCV8VE6+DMLP/i3gU6P3q3KjPo
	otHh/hJfKDiUKK3zCzRB6AvzDkddrOL1oXInEoehilnVQtSJQNnUxRaElH/z9IAlcm2IfDXcOTK
	LMoc76k=
X-Google-Smtp-Source: AGHT+IHMOL/W7lT0tC+rLkITekv5HZIwTVWt7riHBg7ETr4d9elalcOY4le9XBNUzcdJwf6Jloh90PIzRtDvhSLDt/Y=
X-Received: by 2002:a50:fb10:0:b0:64b:4333:1ece with SMTP id
 4fb4d7f45d1cf-64b8edba915mr1216279a12.34.1766120847792; Thu, 18 Dec 2025
 21:07:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-7-dolinux.peng@gmail.com> <290a67f65e9f7083895b5177d524e3ce27e9f93c.camel@gmail.com>
In-Reply-To: <290a67f65e9f7083895b5177d524e3ce27e9f93c.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 19 Dec 2025 13:07:15 +0800
X-Gm-Features: AQt7F2r8XK2ieUEt1RgbHrvAQ0bmXRPieBdaUDR4iFcKxIZAkddPINyjEi9hrOg
Message-ID: <CAErzpmuqB_b9gM4JX6ACFh0oL7Ov57GF09pt0dtMm9YjY4tYXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 06/13] btf: Optimize type lookup with binary search
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 5:38=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2025-12-18 at 19:30 +0800, Donglin Peng wrote:
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > Improve btf_find_by_name_kind() performance by adding binary search
> > support for sorted types. Falls back to linear search for compatibility=
.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > ---
>
> (One nit below).
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> >  kernel/bpf/btf.c | 85 +++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 76 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 0de8fc8a0e0b..0394f0c8ef74 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -259,6 +259,7 @@ struct btf {
> >       void *nohdr_data;
> >       struct btf_header hdr;
> >       u32 nr_types; /* includes VOID for base BTF */
> > +     u32 sorted_start_id;
> >       u32 types_size;
> >       u32 data_size;
> >       refcount_t refcnt;
> > @@ -494,6 +495,11 @@ static bool btf_type_is_modifier(const struct btf_=
type *t)
> >       return false;
> >  }
> >
> > +static int btf_start_id(const struct btf *btf)
> > +{
> > +     return btf->start_id + (btf->base_btf ? 0 : 1);
> > +}
> > +
> >  bool btf_type_is_void(const struct btf_type *t)
> >  {
> >       return t =3D=3D &btf_void;
> > @@ -544,21 +550,79 @@ u32 btf_nr_types(const struct btf *btf)
> >       return total;
> >  }
> >
> > +static s32 btf_find_by_name_bsearch(const struct btf *btf, const char =
*name,
> > +                                 s32 start_id, s32 end_id)
> > +{
> > +     const struct btf_type *t;
> > +     const char *tname;
> > +     s32 l, r, m, lmost =3D -ENOENT;
> > +     int ret;
> > +
> > +     l =3D start_id;
> > +     r =3D end_id;
> > +     while (l <=3D r) {
> > +             m =3D l + (r - l) / 2;
> > +             t =3D btf_type_by_id(btf, m);
> > +             tname =3D btf_name_by_offset(btf, t->name_off);
> > +             ret =3D strcmp(tname, name);
> > +             if (ret < 0) {
> > +                     l =3D m + 1;
> > +             } else {
> > +                     if (ret =3D=3D 0)
> > +                             lmost =3D m;
> > +                     r =3D m - 1;
> > +             }
> > +     }
> > +
> > +     return lmost;
> > +}
> > +
> >  s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 =
kind)
> >  {
> > +     const struct btf *base_btf =3D btf_base_btf(btf);
> >       const struct btf_type *t;
> >       const char *tname;
> > -     u32 i, total;
> > +     s32 idx;
> >
> > -     total =3D btf_nr_types(btf);
> > -     for (i =3D 1; i < total; i++) {
> > -             t =3D btf_type_by_id(btf, i);
> > -             if (BTF_INFO_KIND(t->info) !=3D kind)
> > -                     continue;
> > +     if (base_btf) {
> > +             idx =3D btf_find_by_name_kind(base_btf, name, kind);
> > +             if (idx > 0)
> > +                     return idx;
> > +     }
> >
> > -             tname =3D btf_name_by_offset(btf, t->name_off);
> > -             if (!strcmp(tname, name))
> > -                     return i;
> > +     if (btf->sorted_start_id > 0 && name[0]) {
>             ^^^^^^^^^^^^^^^^^^^^^^^^
> Nit: Maybe pull the is_sorted helper into this patch-set?

Thanks, will do it.

>
> > +             /* skip anonymous types */
> > +             s32 start_id =3D btf->sorted_start_id;
> > +             s32 end_id =3D btf_nr_types(btf) - 1;
> > +
> > +             idx =3D btf_find_by_name_bsearch(btf, name, start_id, end=
_id);
> > +             if (idx < 0)
> > +                     return -ENOENT;
> > +
> > +             t =3D btf_type_by_id(btf, idx);
> > +             if (BTF_INFO_KIND(t->info) =3D=3D kind)
> > +                     return idx;
> > +
> > +             for (idx++; idx <=3D end_id; idx++) {
> > +                     t =3D btf_type_by_id(btf, idx);
> > +                     tname =3D btf_name_by_offset(btf, t->name_off);
> > +                     if (strcmp(tname, name) !=3D 0)
> > +                             return -ENOENT;
> > +                     if (BTF_INFO_KIND(t->info) =3D=3D kind)
> > +                             return idx;
> > +             }
> > +     } else {
> > +             u32 i, total;
> > +
> > +             total =3D btf_nr_types(btf);
> > +             for (i =3D btf_start_id(btf); i < total; i++) {
> > +                     t =3D btf_type_by_id(btf, i);
> > +                     if (BTF_INFO_KIND(t->info) !=3D kind)
> > +                             continue;
> > +                     tname =3D btf_name_by_offset(btf, t->name_off);
> > +                     if (strcmp(tname, name) =3D=3D 0)
> > +                             return i;
> > +             }
> >       }
> >
> >       return -ENOENT;
> > @@ -5791,6 +5855,7 @@ static struct btf *btf_parse(const union bpf_attr=
 *attr, bpfptr_t uattr, u32 uat
> >               goto errout;
> >       }
> >       env->btf =3D btf;
> > +     btf->sorted_start_id =3D 0;
> >
> >       data =3D kvmalloc(attr->btf_size, GFP_KERNEL | __GFP_NOWARN);
> >       if (!data) {
> > @@ -6210,6 +6275,7 @@ static struct btf *btf_parse_base(struct btf_veri=
fier_env *env, const char *name
> >       btf->data =3D data;
> >       btf->data_size =3D data_size;
> >       btf->kernel_btf =3D true;
> > +     btf->sorted_start_id =3D 0;
> >       snprintf(btf->name, sizeof(btf->name), "%s", name);
> >
> >       err =3D btf_parse_hdr(env);
> > @@ -6327,6 +6393,7 @@ static struct btf *btf_parse_module(const char *m=
odule_name, const void *data,
> >       btf->start_id =3D base_btf->nr_types;
> >       btf->start_str_off =3D base_btf->hdr.str_len;
> >       btf->kernel_btf =3D true;
> > +     btf->sorted_start_id =3D 0;
> >       snprintf(btf->name, sizeof(btf->name), "%s", module_name);
> >
> >       btf->data =3D kvmemdup(data, data_size, GFP_KERNEL | __GFP_NOWARN=
);

