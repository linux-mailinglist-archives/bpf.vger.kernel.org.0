Return-Path: <bpf+bounces-77072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2EECCE0B0
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B95BB3038949
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780D71D5CDE;
	Fri, 19 Dec 2025 00:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yr3VtWpd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8995B176FB1
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 00:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766103568; cv=none; b=SdLL7e8rMLDG33MlNWSP4DrRJ9L+41M8xO6VNwxT8paEz61Oqqg547hYStxKkwmkf/+6QkuxLgW5PJd0wFT6mGJKTn5v8psKTQXkgGSOlct4cPK2qkFNJDHztGyjeUzBAAT9ihlQ5TpcmvT3ARACHWfiLm96HemF+H9eMSXNkRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766103568; c=relaxed/simple;
	bh=0x6Kw69dyiZtSl6ZTnPyjGBdpxP8xesMEn89IHq2Xq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFKlUGqzS+aNk03wz5DP2QxRptIM+1VYr9a1y9n5J6Z0euzgcjYqp1ERQajw7F9XN2bilKnPZf5Uzh7e7TwqyWaMPE/aOSiTKtEDsgmRTaKm7RO2nLdzQMlLX5hZnP0yhO+8R1V6QLn29TmLtrz+UwqJQk5ypEIIbU57SalKldI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yr3VtWpd; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c277ea011so1253182a91.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 16:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766103566; x=1766708366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MH2zTcsy9cCPii9o1vMTiIoPfymBu3GhOo8iZLao8rE=;
        b=Yr3VtWpdlUl/ePzqsjRXUMAvMoriFHBReyIOQ2Vzw6jblrYHlhpajMfkw5NLHOk7jX
         RGU778XiCTtXTYKn85Fwg0IBdvkZXotpHtl+jldmkpL3hI+MZazCj7SN6nqT0s20u36P
         oeVLiLXbB7RvcunXHWwBsrTyS9ndGUtIm6zd0YOHFm+YkCjlr06G8Nr/jqHMQaL134dt
         YqCSNoSZ81Ci1obine+7BBnoWDhK//iFQSTl69We8qoxecl7P0UoOz5sQa98eQjgCwJG
         XOnaooQJwQEu3oo14j5MoWAVi4RqAKkX4Plyr2Qq/RFvx7mqqtMT3+zOU9Fk+8I482Pg
         LRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766103566; x=1766708366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MH2zTcsy9cCPii9o1vMTiIoPfymBu3GhOo8iZLao8rE=;
        b=cepzjCo1NcmsPchkjfmICActHe3hgtCgsKO6ExZfYpCiL90WV6cPRfvcMfc+Goae8T
         VZJlgAFHvScZ2iGtgD54W4VNN7nCWbhpjoi8aS4ROy/p43VuPHvFaV0EO0qDOGPOOjoD
         9a0aM7JiirSdpODpYFm6ArMr+RbPWzoyySSk9k6CDYh5MSQ8x6ZSnhO1m+maJ+nZxmkc
         TO/2e3ZCbMIcPGX5BV0LeUbW64mEXPdHcEriESgwQ+XnwCwEfiPXosKAq3J4PpgC/gHA
         aGXGP/+OVMsIGHnsiCK23KJNjehXmMO4bX9REacfP5CXNYIf3cBraSqXWYi8f77QL/r7
         Wusw==
X-Forwarded-Encrypted: i=1; AJvYcCVAzbqZ55/O5U/H9YZRwko4ij4+c1pBid5MxQAEXLPDQz+zKdILVfHwW/h/SBT7yatV7Co=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Ni5J08JrMNaHOs0VpLGxycDkakXDZSVbeSpE0zTJGt2PVGxu
	B7QPsvutItZ2L8FdPDvx44yERZRKqT+pbfQWRB3iPPrQrOS6+UrGWxUhHp/lj1dZm5yvq49diHk
	tnNAw7xLI5WiogTA5KHW48MiIBBnCJ4c=
X-Gm-Gg: AY/fxX4HjmidxHY6kp7O85/D6rqzBPbmVcsvSxPG7kyF+NneNetcNrWayuUTi7W7Kb9
	yB4mg9XNbH0jOubFRxC2aQbpUEHKKR6ppZPP699g0BbQfv09OJyg4jKvkO0NU7pyIFtsh/BCD9n
	eCzHfH7vDI5loaNJqGPty3SRmLt4Mxz89iO3PFTH58mAAZpBzNgwdxgih85aqhJesrGTkkFwZKP
	ofJ2Ns10YNd6ubkvFtS57y2gPSA1BHKdC56jBTGFVhCm06wBuYazPufPWQKWXpwWYCeSPaeeXQg
	AQwqYsvkOnE=
X-Google-Smtp-Source: AGHT+IE6US4ydfh6U3pSidpRDdEKAAMUeNx1KpRDpX3q2W3WFWjSaG5PuVSBv7woojHNJj8UsslIV6sKuB9VZ+BAVdI=
X-Received: by 2002:a17:90b:4a44:b0:32d:db5b:7636 with SMTP id
 98e67ed59e1d1-34e921e0556mr965441a91.27.1766103565873; Thu, 18 Dec 2025
 16:19:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-5-dolinux.peng@gmail.com> <CAEf4BzbSMwW4es5D9i=bpSjALo8u+oW-9vdQ7=DBoTBtMoJ1Tg@mail.gmail.com>
 <d161fb1f8b7a3b994fe3ed4a00e01fc1f1af3513.camel@gmail.com>
In-Reply-To: <d161fb1f8b7a3b994fe3ed4a00e01fc1f1af3513.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 16:19:13 -0800
X-Gm-Features: AQt7F2oa98PfZs5wmmDebyT4s8sIR8nTkzIjwU6xqZmf0bX8rLkGy7wN2NpcYy4
Message-ID: <CAEf4Bzamgpk7Dj2uMrCmVEijvyHKqUguWJU7h+12pSr3S7F1hQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 04/13] libbpf: Optimize type lookup with
 binary search for sorted BTF
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 4:13=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2025-12-18 at 15:29 -0800, Andrii Nakryiko wrote:
>
> [...]
>
> > >  static __s32 btf_find_by_name_kind(const struct btf *btf, int start_=
id,
> > >                                    const char *type_name, __u32 kind)
> >
> > kind is defined as u32 but you expect caller to pass -1 to ignore the
> > kind. Use int here.
> >
> > >  {
> > > -       __u32 i, nr_types =3D btf__type_cnt(btf);
> > > +       const struct btf_type *t;
> > > +       const char *tname;
> > > +       __s32 idx;
> > > +
> > > +       if (start_id < btf->start_id) {
> > > +               idx =3D btf_find_by_name_kind(btf->base_btf, start_id=
,
> > > +                                           type_name, kind);
> > > +               if (idx >=3D 0)
> > > +                       return idx;
> > > +               start_id =3D btf->start_id;
> > > +       }
> > >
> > > -       if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
> > > +       if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =
=3D=3D 0)
> > >                 return 0;
> > >
> > > -       for (i =3D start_id; i < nr_types; i++) {
> > > -               const struct btf_type *t =3D btf__type_by_id(btf, i);
> > > -               const char *name;
> > > +       if (btf->sorted_start_id > 0 && type_name[0]) {
> > > +               __s32 end_id =3D btf__type_cnt(btf) - 1;
> > > +
> > > +               /* skip anonymous types */
> > > +               start_id =3D max(start_id, btf->sorted_start_id);
> >
> > can sorted_start_id ever be smaller than start_id?
>
> sorted_start_id can be zero, at two callsites for this function
> start_id is passed as btf->start_id and 1.

Can it with the check above?

  if (btf->sorted_start_id > 0 && type_name[0]) {


This branch is a known sorted case. That's why all these start_id
manipulations look weird and sloppy.

>
> >
> > > +               idx =3D btf_find_by_name_bsearch(btf, type_name, star=
t_id, end_id);
> >
> > is there ever a time when btf_find_by_name_bsearch() will work with
> > different start_id and end_id? why is this not done inside the
> > btf_find_by_name_bsearch()?
> >
>
> [...]

