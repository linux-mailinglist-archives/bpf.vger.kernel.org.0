Return-Path: <bpf+bounces-77251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 305EFCD30C7
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 15:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD99F300A9C7
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 14:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5410829E10F;
	Sat, 20 Dec 2025 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0sSIeVk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C167295DAC
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766240872; cv=none; b=f+jtpj8P1YDiDmxJJ95bfF6upEfoa8wsy/C4vpOUhunx2ivhWNWCoHGK6TN8O7ACllpeSFog1tWAH9+EQyrAspCq1Jd4k+jgZ948NV6XYrmVAru8SZ46ACm0+RWcLeMlb2Zop040rAgGzpny+SDjWEBmBYtIvz04/VLWcLC1WjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766240872; c=relaxed/simple;
	bh=nB86Zlla7535/VDB52ZKP/t1BfuDXzRYkpyGiMzmp8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PInFp1MS2rridBjYI48Jd+q6udnoK/dI6ejrfLpM0JU16PhsoCSS8CbEgKWcrkA18gkP6of+mthHKCj86hqSDwsc7uno3uRDMhJjUATf4/ZkU9ByeJQrXsgCPrMgxPEp+x86NL8OWvwF90bwt/1Ianb9Ui87xJOiHfjiw7HXWz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0sSIeVk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b735e278fa1so471286966b.0
        for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 06:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766240868; x=1766845668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0gslejGc35upFCwb6TD21764bMRjjlwmwPWNGxW/sM=;
        b=m0sSIeVk6k9KINXwCPLUa/Tb5S5wh9SPCBl3XB0mYV2s8vv+E4heT/2opTrofZKVtb
         4kugccpDQdqTqgNLOft0zdd7Z1dis8ogh4BWAlecr0Nuz4+4sS51xFBA8kyb2sTPn6Y8
         F8qoObYdFBG1KdX510jZDOft4Y5QRl0dz7AGjjxSpoG6ZXSxjNcRpWk1p5nyLBTecd6V
         XSJKYS0n2f8qiF4jgj8KGjP6bsn8ZQ0tTKsywPqPMJHy2yNVqVdcSPfCEcFdeTWXM0Qo
         oOME+XtisXDHoZnekGlVfxDomS0uNqM6vVQj/E6PKdwDv2Qs/gmlvNuvSVyJBog/hk06
         QZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766240868; x=1766845668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+0gslejGc35upFCwb6TD21764bMRjjlwmwPWNGxW/sM=;
        b=Y0wnz9SmofXTNEtXJlUEFgBoPPSukz9DuPEo8pTLtkLq0ZNBSVgU/cMwG5k5rPMLHL
         kq/wFR+gVsjnGf5ILQ3YJrdXZVQY692O809qpTyhthPAqcuYbg+MEc7bJfxah9ybIQ7D
         WlzGYlpnPsyZefycuMfK2RRd/lxteWDwzl5D+7tHUDwvVoOUL3t1iC7/0/zvsz9cd5wv
         on18WvAYDQiMKrcBVauXq3OWWUxVKRHSCFUQNHCI0OjeiAqzrnpJwBQ7yW5JOhWuoyEa
         /pHUj68dZUvbkBo2lccmllFYdT/KkMw91Aa1x3MEnjjuj91n25eVDv7XRUoIQ0RAXlIY
         l4dA==
X-Forwarded-Encrypted: i=1; AJvYcCWv3nPJt4dGhTyG/i1dQmY8xDSPijOMMcDOWjT2eZVdeAi08E0DDkkmx7NGiZHwTpjsa+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YySRSLYx2N+qmbUtyU/tiKYwIA6yAeES7KBM7xF6vOZDf9nZgE2
	mRemNggt2q7/aPhD4VrGR6g5sVbTPrC7tyVSN6z4atcj5APdh15VbwwU9NOvfszQYKT+JbKID8A
	uNUzFk7twXpPeVUw3212RH9Z+NhXRVUA=
X-Gm-Gg: AY/fxX5EcNsbQDrE9xA6Tv3n/3cmicEb71OSJHobxwpX5iegt8ODiSkZxqvJmMSQYtR
	LoX9IlVrp7QmSt1vszAI8SMbHlBPkKivpaAGyLp2UXjFhC/jQfKOXtYFmh6c+tK/KIDAjBzhVwp
	LtNM5PHzQTZWhCGbI65NGatghwDIDG9IjtbBn5ifSYLXTSeD78EGDDr3gQYuXpO+th11o/XI0Xi
	n9s/C118la7y3LRukzUcaczB54UuJjtniXSTVzjGIKfAVGafqxB4qERdpo7u/80M+I1s+y5YwYi
	mICJKUo=
X-Google-Smtp-Source: AGHT+IFRymVrlpJJ4BAonWCsL/+r8WSJMSNuMbpY8zrvmljbDVDbqKoXVsrQLDR1EuHfMUVL6pX4J6YeHK7YXOZGL3Q=
X-Received: by 2002:a17:907:c994:b0:b80:40d2:9652 with SMTP id
 a640c23a62f3a-b8040d296a2mr259496666b.65.1766240868133; Sat, 20 Dec 2025
 06:27:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-12-dolinux.peng@gmail.com> <CAEf4BzZGz1k4ma4hYL-nR_e5QQxuzM3Y+VxZNWe_YupeQMj0-w@mail.gmail.com>
 <CAErzpmuuSfBOomFbre-OBrW5+PHbvxgjrWZApZ=UC2LP0c5kQw@mail.gmail.com> <CAEf4BzYoyTfCX22kFUS2ymZPehQEbGeQztzGkAMuAL7d1bnUkw@mail.gmail.com>
In-Reply-To: <CAEf4BzYoyTfCX22kFUS2ymZPehQEbGeQztzGkAMuAL7d1bnUkw@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sat, 20 Dec 2025 22:27:36 +0800
X-Gm-Features: AQt7F2rwGXPUAgYHvu9v8w-sMY5DSD7Oux2_a7DeuTijPyR5M9elQdhLLV2t2NQ
Message-ID: <CAErzpmtgpsdVe3U0aja3M4x4tgW-sHrP5987Ly3s24+4RqyU=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 11/13] libbpf: Add btf_is_sorted and
 btf_sorted_start_id helpers to refactor the code
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com>=E4=BA=8E2025=E5=B9=B412=E6=9C=
=8820=E6=97=A5 =E5=91=A8=E5=85=AD01:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Dec 18, 2025 at 9:51=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > On Fri, Dec 19, 2025 at 8:05=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gm=
ail.com> wrote:
> > > >
> > > > From: pengdonglin <pengdonglin@xiaomi.com>
> > > >
> > > > Introduce two new helper functions to clarify the code and no
> > > > functional changes are introduced.
> > > >
> > > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > > ---
> > > >  tools/lib/bpf/btf.c             | 14 ++++++++++++--
> > > >  tools/lib/bpf/libbpf_internal.h |  2 ++
> > > >  2 files changed, 14 insertions(+), 2 deletions(-)
> > > >
> > >
> > > It just adds more functions to jump to and check what it's doing. I
> > > don't think this adds much value, just drop this patch
> >
> > Could adding the __always_inline be acceptable?
>
> No! This is not a performance concern, just mental overhead when
> reading the code.

Thanks, will remove it.

>
>
>
> >
> > >
> > >
> > > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > > index b5b0898d033d..571b72bd90b5 100644
> > > > --- a/tools/lib/bpf/btf.c
> > > > +++ b/tools/lib/bpf/btf.c
> > > > @@ -626,6 +626,16 @@ const struct btf *btf__base_btf(const struct b=
tf *btf)
> > > >         return btf->base_btf;
> > > >  }
> > > >
> > > > +int btf_sorted_start_id(const struct btf *btf)
> > > > +{
> > > > +       return btf->sorted_start_id;
> > > > +}
> > > > +
> > > > +bool btf_is_sorted(const struct btf *btf)
> > > > +{
> > > > +       return btf->sorted_start_id > 0;
> > > > +}
> > > > +
> > > >  /* internal helper returning non-const pointer to a type */
> > > >  struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_=
id)
> > > >  {
> > > > @@ -976,11 +986,11 @@ static __s32 btf_find_by_name_kind(const stru=
ct btf *btf, int start_id,
> > > >         if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =
=3D=3D 0)
> > > >                 return 0;
> > > >
> > > > -       if (btf->sorted_start_id > 0 && type_name[0]) {
> > > > +       if (btf_is_sorted(btf) && type_name[0]) {
> > > >                 __s32 end_id =3D btf__type_cnt(btf) - 1;
> > > >
> > > >                 /* skip anonymous types */
> > > > -               start_id =3D max(start_id, btf->sorted_start_id);
> > > > +               start_id =3D max(start_id, btf_sorted_start_id(btf)=
);
> > > >                 idx =3D btf_find_by_name_bsearch(btf, type_name, st=
art_id, end_id);
> > > >                 if (unlikely(idx < 0))
> > > >                         return libbpf_err(-ENOENT);
> > > > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf=
_internal.h
> > > > index fc59b21b51b5..95e6848396b4 100644
> > > > --- a/tools/lib/bpf/libbpf_internal.h
> > > > +++ b/tools/lib/bpf/libbpf_internal.h
> > > > @@ -250,6 +250,8 @@ const struct btf_type *skip_mods_and_typedefs(c=
onst struct btf *btf, __u32 id, _
> > > >  const struct btf_header *btf_header(const struct btf *btf);
> > > >  void btf_set_base_btf(struct btf *btf, const struct btf *base_btf)=
;
> > > >  int btf_relocate(struct btf *btf, const struct btf *base_btf, __u3=
2 **id_map);
> > > > +int btf_sorted_start_id(const struct btf *btf);
> > > > +bool btf_is_sorted(const struct btf *btf);
> > > >
> > > >  static inline enum btf_func_linkage btf_func_linkage(const struct =
btf_type *t)
> > > >  {
> > > > --
> > > > 2.34.1
> > > >

