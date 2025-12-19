Return-Path: <bpf+bounces-77133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C19CCE96C
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 06:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C18C6302CB9C
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 05:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AF42D59FA;
	Fri, 19 Dec 2025 05:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/GSjt71"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD3F298CBC
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 05:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766123405; cv=none; b=eGxEOZyCV6S641RQ/aJuASSZJYm/gTpzQADOE88qRNivH6NJH2SLKLFvKkm3QxpDW2FxmLcx7FOvPLE/Z/fjMVF7QYjWskKybNT+Led8dn3000luPurJwSgnDditjO8gqOg/LoYpMKfSc7Orox8djVgENOn4V97NGo5mzR3ls6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766123405; c=relaxed/simple;
	bh=tLhgL+xufj03AftKPBkvnMndo1tIROZgjNq2b13A3PA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNFtfXQiwJiDUkK2Uw+1G6NvTCu1P5+ah/hp8esYIdIkzjMVuFqYIXH1aoBTgM1MhjtYSWYrM0ABCEVg6UKSmZs6ng+AHKZkUxhFAY0qkcPf5qJFQ6lthcRdAQSNSCgT57nuKtdC+Ip6TuX3ZyxVZMO1EtR3NRvRTaajaRiIVGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/GSjt71; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b58553449so1845162a12.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 21:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766123402; x=1766728202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcGxWWVAQka5QJkxbnZts8I8NyYoBfYSYSLhID22rVM=;
        b=K/GSjt71OTywDRxHGBZkVYkQftcK9LV061u/+x7QA+6iuILQFyD4J+6mKqi43bpRzV
         XVVgXKZY7SCNPkhg1CRtBt11wESLljp2ATyd+34YIJ4DapYV7fD6fZe62EKvPYviJ+ZH
         nNPefkx2w4BEP6MkU34CcyYYizAMiFxZ1Jm7XkLesPEEvDXvzqITa2EeYVtKQztbmuzF
         6/qgEuB3OehbsXBMtqjWLTcuoBxRgDFPz9rWApkcd3uC5quJSQ+UPmLlsD7CS6pu3jjp
         0zouwyCMxrIVjbOgWHOlFxiRNrLROic34ezDGc51NS8clO18vcnpPIsjvgTGidta2d/M
         97hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766123402; x=1766728202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hcGxWWVAQka5QJkxbnZts8I8NyYoBfYSYSLhID22rVM=;
        b=HrqWxQQxY2DmDHhWH163opZbmvMAclUenbeUdUJq6nGbOCWA0Rx2hOeBP5D5yj/heO
         MPTi2SFetyM5XiEfh4vmOZ2ofxH3dn3GkS54xpKjvJ2OcWX5rbVkvGWONaKzr4tTVCME
         ALra+AIr1kYtOBXDCD4m6MSFHYNvPrfUk//q5GsNUqCIk5inXTQsOxcJ2WU0UNYNUPCl
         rA7E+KKeosqAFu85EO/zUA7EPzz9iN2dApbcojLpY2x2S7ugQ3+SPYHYQpz3zt6EsvbF
         doOMyWQZAYQJ4+rDbmemlIt0CtnYyy1w6xJp3o24b4W2aY2Tr/qJfSDl/mx+UdV2rt+m
         jaKw==
X-Forwarded-Encrypted: i=1; AJvYcCVVw7rlSZNNDTpalkpgKp9YFjUVoKArNXAP5rtV2HdOjfjLZn27rpZubDb7o8GEb32pJj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/QaDpUZUbKVLduX+v0q3ROqLf26qEp7vhtL0IGuI41HpAnO3M
	sn4Pofg/JCicUzKdemGnwC9ecEgFB2TQdHtfMXzoUPEwrHe8dRCkcc1ul1TQNuHZeN/zOOSYFPk
	ncM3A7fgXdMFIYZa9snag9nvyIv+FRg0=
X-Gm-Gg: AY/fxX6AQhdmHfIB3CfVEUcnVlcGPmNQe+quIndH5884JFxWSQBupYOMx2i+J7gIifd
	3HxBN0j0wPlEDH7R8Mwvaop6b3iOQoM40Ooq2tdJpeJmMJ+fjiWa2k0KTVh/2bLbRkCLXWmSEdk
	U1wTGYpD4EdcW0sl/BCRPLubYuIkuhnbTa+62Zt/I2itCqeWhJzk+zfRWpaCQVRccxgE7lhMmCL
	8aRi9dlM3v6FR+UJ0+nxLSxN69tK/Yk9kSjxxZqseQdODMY9sCdUo6+JbKSl0e/1VtuHfaLGk9/
	+/CKNeA=
X-Google-Smtp-Source: AGHT+IFP9Mb8Mz17bED4+8kvePrFfqUV8UG0SppRPP74q5Iqw279b9p9SCe8qy3XK6G49gC5qRM1uOHZ1f1Yy9iOQBA=
X-Received: by 2002:a17:907:2d0e:b0:b73:80de:e6b2 with SMTP id
 a640c23a62f3a-b803705dbd1mr194824766b.31.1766123402048; Thu, 18 Dec 2025
 21:50:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-12-dolinux.peng@gmail.com> <8fce5fd3524dc58b11250104837e241aa3f25420.camel@gmail.com>
In-Reply-To: <8fce5fd3524dc58b11250104837e241aa3f25420.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 19 Dec 2025 13:49:50 +0800
X-Gm-Features: AQt7F2qxro7sCqMS9UbbvkeX2ko3ijJ9R0A9CMZT7bKi0MmZSXAR0NukwUr9sxs
Message-ID: <CAErzpmuTJpgwafJzR=LNudNXTzL-=LpmEdF6zxr=s6hkDUDhvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 11/13] libbpf: Add btf_is_sorted and
 btf_sorted_start_id helpers to refactor the code
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 6:33=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2025-12-18 at 19:30 +0800, Donglin Peng wrote:
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > Introduce two new helper functions to clarify the code and no
> > functional changes are introduced.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > ---
> >  tools/lib/bpf/btf.c             | 14 ++++++++++++--
> >  tools/lib/bpf/libbpf_internal.h |  2 ++
> >  2 files changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index b5b0898d033d..571b72bd90b5 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -626,6 +626,16 @@ const struct btf *btf__base_btf(const struct btf *=
btf)
> >       return btf->base_btf;
> >  }
> >
> > +int btf_sorted_start_id(const struct btf *btf)
> > +{
> > +     return btf->sorted_start_id;
> > +}
>
> Having this function declared differently in kernel and in libbpf is a
> bit confusing. Is it needed in libbpf at all?

Thanks. Keeping it consistent between libbpf and kernel side.
Will remove in the next version.

>
> > +bool btf_is_sorted(const struct btf *btf)
> > +{
> > +     return btf->sorted_start_id > 0;
> > +}
> > +
>
> Please squash this with the first btf_find_by_name_kind() change.

Yes.

>
> >  /* internal helper returning non-const pointer to a type */
> >  struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id)
> >  {
> > @@ -976,11 +986,11 @@ static __s32 btf_find_by_name_kind(const struct b=
tf *btf, int start_id,
> >       if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =3D=3D=
 0)
> >               return 0;
> >
> > -     if (btf->sorted_start_id > 0 && type_name[0]) {
> > +     if (btf_is_sorted(btf) && type_name[0]) {
> >               __s32 end_id =3D btf__type_cnt(btf) - 1;
> >
> >               /* skip anonymous types */
> > -             start_id =3D max(start_id, btf->sorted_start_id);
> > +             start_id =3D max(start_id, btf_sorted_start_id(btf));
> >               idx =3D btf_find_by_name_bsearch(btf, type_name, start_id=
, end_id);
> >               if (unlikely(idx < 0))
> >                       return libbpf_err(-ENOENT);
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_int=
ernal.h
> > index fc59b21b51b5..95e6848396b4 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -250,6 +250,8 @@ const struct btf_type *skip_mods_and_typedefs(const=
 struct btf *btf, __u32 id, _
> >  const struct btf_header *btf_header(const struct btf *btf);
> >  void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
> >  int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **=
id_map);
> > +int btf_sorted_start_id(const struct btf *btf);
> > +bool btf_is_sorted(const struct btf *btf);
> >
> >  static inline enum btf_func_linkage btf_func_linkage(const struct btf_=
type *t)
> >  {

