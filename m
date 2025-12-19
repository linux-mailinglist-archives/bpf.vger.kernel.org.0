Return-Path: <bpf+bounces-77172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCF6CD12C5
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 18:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B06C43034628
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 17:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB2528000B;
	Fri, 19 Dec 2025 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaTnEYgy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909694A35
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766165731; cv=none; b=GCre1lB5Cn6Abj6nlzN7zuPr4Ar6soJ7tg6umlyUfeCmTCjGG+32iNaeMmTiN5Ew/Cda4r9AFl/7h0gaf4w0eTvQ4YN0/xIiFlvqxWiG6dBm4pNn0+nDr5ZN9vTHPhcZsEH4vWp+crShlZUvPX1Dz2Phpynzs7mbIfI3G8OKGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766165731; c=relaxed/simple;
	bh=fXViTuteqKVVekjtxBy4prAcNKmgRl9rBBgBVQTUDGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLAK2yzyX8BmFruI60rhtcfkDSgUjTsNVt3Tt0V1jn5r78FszO2vG9YlvOjAq2JbSuiNdBYntM7NvWx3rsMIqoVAAiJkXW2axPy1MDWcHxKUGX/i9V2OtK70mTQw9VS/t8sbvGw4q99jmLsPw5rjrCbjmHzNpkgkxCjvcsmfyDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaTnEYgy; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c1d98ba11so2235837a91.3
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 09:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766165728; x=1766770528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QohxViHdKZtAy+o3qNWWxVcmYdb+Y36LjgMu2WdXpZ4=;
        b=BaTnEYgyn813mHbFixXMcJEKibyTzvmtJqdDgFLuCVdtIm7b2oc47ws+VlooNrKg+2
         OVT3aBxy6yS00mQd9/rQR+vNHRu/EuI1nTfv7PoCfbpliK7qqt6YRyzqrj1cP5tmaec/
         NYT9ilKZOInL+ld75cWijuwYnE+qkqlbOW/p8bEfOsHd1LoMgaK0rvRAnc22J3E7NnOs
         HStHwMfcajRVWWQUrHbaDK331rh+zd9CMdRdI1hrBdUxsC14v+2NQw+eRA4ONbA6dBPH
         teB65aB3agaFDsrFALwxWg7OV7DqcR0fClUq3EqJ0Jp0BrsFBC7gNnhpF5KdAO2Kw1H8
         BUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766165728; x=1766770528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QohxViHdKZtAy+o3qNWWxVcmYdb+Y36LjgMu2WdXpZ4=;
        b=PECwJTlGFdYZpq+nDRBydOleaTFKphlGwiLF7czIs2bH6x6RV0qc8XFRoj20hgbjDL
         DDDuDg0WTseT1iYAzTx4kS5U0dBMRkIX96bwYtFD7Yzx395BC0PS7c1rnvl8sJJThYMY
         0m0Wkfoe2EqJJjK4NJkapdYhE3Da3JDpQQeMfiszoFu9kQntCUPbGJSltJSiYqKP0YbO
         tETiQAxMRddB1DoU24mcD4npwocFb43V6l1UaMW400jmjrVROxlLJjdsNQvvQbcutSwn
         6lSAyOmDGmSOTW6LI7GldXE/cep+a4K+9F2Hn+/EGQtYA4nDP67jPLFxO2fGVKOLpZVH
         qpxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeFypIUaiT39VnVcKBmHv5PfbMZ6d3JlDsFHwknoV2teBU+4D/4CPsxZWJh8dZKt7srR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEPiZZHYy0Dbg0dvyeQtfelds8ACrLKz2GW7SqX1b5xb5M4gDG
	aeJnzHQ7ys1wzxKjGvCyvDu/UqSsPX51Vp8BTparxHY1byV1fq8vfYw5zoaf29vWZRbv8onTCCl
	ANcgO+F0RNQUIl2XQvzlY22EMwRGtCvY=
X-Gm-Gg: AY/fxX49S1v+D7vXAeZr245USTA6zqf12tY8rxQ4LaiM9NdlUlUnX3qAPoF+/MbCEvC
	nsrHl1Ypl2h3m+yQ1FREqyiXC0fuy8fbMFqWW/B3oc+Bm4OssVla5b4rJVZm/2jTUwvo5YFaLoX
	aZ+vqrdWeAd4uXp2v1YfHb8AYMIlTllk7q5luwjZurURASfCAcu6oGt00QyAZFQGY9/Cg6fhnzh
	btr6F2ZQHHED/tnDrdRhsQrstUjFEo6kvr8ieulYXPH+qJ8WWh/uALiIiYYPFLdG7ftBAQ=
X-Google-Smtp-Source: AGHT+IEAPA3lWUTt8XaDF6xEjDIyMEdj3ldjKbLyCc5SjcjOoaHHxly6D3hb/3j7pWotpFpHEi7eB0inlSoiAcLdhx0=
X-Received: by 2002:a17:90b:3d89:b0:340:d569:d295 with SMTP id
 98e67ed59e1d1-34e921b092emr3370036a91.24.1766165728328; Fri, 19 Dec 2025
 09:35:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-12-dolinux.peng@gmail.com> <CAEf4BzZGz1k4ma4hYL-nR_e5QQxuzM3Y+VxZNWe_YupeQMj0-w@mail.gmail.com>
 <CAErzpmuuSfBOomFbre-OBrW5+PHbvxgjrWZApZ=UC2LP0c5kQw@mail.gmail.com>
In-Reply-To: <CAErzpmuuSfBOomFbre-OBrW5+PHbvxgjrWZApZ=UC2LP0c5kQw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Dec 2025 09:35:16 -0800
X-Gm-Features: AQt7F2qrMFBKT3EYTE9UixwIQLbxo7SItsgua1tcYteuoqjww74mHuAqYMHwdSw
Message-ID: <CAEf4BzYoyTfCX22kFUS2ymZPehQEbGeQztzGkAMuAL7d1bnUkw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 11/13] libbpf: Add btf_is_sorted and
 btf_sorted_start_id helpers to refactor the code
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 9:51=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Fri, Dec 19, 2025 at 8:05=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmai=
l.com> wrote:
> > >
> > > From: pengdonglin <pengdonglin@xiaomi.com>
> > >
> > > Introduce two new helper functions to clarify the code and no
> > > functional changes are introduced.
> > >
> > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > ---
> > >  tools/lib/bpf/btf.c             | 14 ++++++++++++--
> > >  tools/lib/bpf/libbpf_internal.h |  2 ++
> > >  2 files changed, 14 insertions(+), 2 deletions(-)
> > >
> >
> > It just adds more functions to jump to and check what it's doing. I
> > don't think this adds much value, just drop this patch
>
> Could adding the __always_inline be acceptable?

No! This is not a performance concern, just mental overhead when
reading the code.

>
> >
> >
> > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > index b5b0898d033d..571b72bd90b5 100644
> > > --- a/tools/lib/bpf/btf.c
> > > +++ b/tools/lib/bpf/btf.c
> > > @@ -626,6 +626,16 @@ const struct btf *btf__base_btf(const struct btf=
 *btf)
> > >         return btf->base_btf;
> > >  }
> > >
> > > +int btf_sorted_start_id(const struct btf *btf)
> > > +{
> > > +       return btf->sorted_start_id;
> > > +}
> > > +
> > > +bool btf_is_sorted(const struct btf *btf)
> > > +{
> > > +       return btf->sorted_start_id > 0;
> > > +}
> > > +
> > >  /* internal helper returning non-const pointer to a type */
> > >  struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id=
)
> > >  {
> > > @@ -976,11 +986,11 @@ static __s32 btf_find_by_name_kind(const struct=
 btf *btf, int start_id,
> > >         if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =
=3D=3D 0)
> > >                 return 0;
> > >
> > > -       if (btf->sorted_start_id > 0 && type_name[0]) {
> > > +       if (btf_is_sorted(btf) && type_name[0]) {
> > >                 __s32 end_id =3D btf__type_cnt(btf) - 1;
> > >
> > >                 /* skip anonymous types */
> > > -               start_id =3D max(start_id, btf->sorted_start_id);
> > > +               start_id =3D max(start_id, btf_sorted_start_id(btf));
> > >                 idx =3D btf_find_by_name_bsearch(btf, type_name, star=
t_id, end_id);
> > >                 if (unlikely(idx < 0))
> > >                         return libbpf_err(-ENOENT);
> > > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_i=
nternal.h
> > > index fc59b21b51b5..95e6848396b4 100644
> > > --- a/tools/lib/bpf/libbpf_internal.h
> > > +++ b/tools/lib/bpf/libbpf_internal.h
> > > @@ -250,6 +250,8 @@ const struct btf_type *skip_mods_and_typedefs(con=
st struct btf *btf, __u32 id, _
> > >  const struct btf_header *btf_header(const struct btf *btf);
> > >  void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
> > >  int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 =
**id_map);
> > > +int btf_sorted_start_id(const struct btf *btf);
> > > +bool btf_is_sorted(const struct btf *btf);
> > >
> > >  static inline enum btf_func_linkage btf_func_linkage(const struct bt=
f_type *t)
> > >  {
> > > --
> > > 2.34.1
> > >

