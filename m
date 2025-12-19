Return-Path: <bpf+bounces-77132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D193CCE8FD
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 06:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 406BD303A1BE
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 05:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56072D12EC;
	Fri, 19 Dec 2025 05:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QojprOBa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A177629BD8E
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 05:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766122939; cv=none; b=Ly8oE46J6x/tI5Gz2cXCPjgg6YeHvM6PASxXexMYbhsYm41b9EmpMao9/CPXIgwbuZP3e6r2fqqGAluiWJT1Hux7EQHy0dY4xNCjUZe12qMeWINM0CQwp3Xvhyt6/+dt5b6ibtol3UIU19oA09g7JyKXxXETeNf9GXOgwNDHZn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766122939; c=relaxed/simple;
	bh=2d/Fo3EzvU6FIlo1pKZo5iOvZac4t0b8y+6fzuOXEsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=deaRdOawtyp2Q0L5BgcgGKYdBzc/MKUP15LqQUU++GywvykSiLdVBQjtuo7H/XBoSAy+nKnFGg9thlbE/i/O09KDYmtkcRGpd9f0z7vt15d0NlQzQcuKVEWEKcfM5gHX+TC41MJkLNj4Pb9rfN0+GRWdXnZ+yyEFOTwUhIGdbhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QojprOBa; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b81ec3701so1284705a12.1
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 21:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766122936; x=1766727736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIssrB7Ni7FX0+QC6de9P5DMoU/KGnLUM5xD5taO9oI=;
        b=QojprOBa5aIgnlZYZfChlqrwz0Yh5XtJikQFrcH75WDhV+6q2rwdgANozMHnOzQth4
         /RLUaWYpg5/kNP60wD5rVbhRlDu1aCJhlQ1EM6QoS9JQLUgnzZ4l0TiOIutuGbX3JK6A
         q2AjhUjtoiZhZFw6Sat0JiKMGpDeKH/G6jXTr+AiN3e1ZuIx0tSh8VFaJv8KEAGeDGG/
         KdVEOR4ERZuuxdsHdCs0OsxygBBlp1WOB9xFPo+o9gBHv9/A+So/QtNAmWrRPHMymoPa
         q9B4z5UcQx0Mn5xt7m1VG3zIdSekAv2x8OpDGcHVD+XvoUbeJ/iW4w5m4BvvTX4YlppV
         A7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766122936; x=1766727736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WIssrB7Ni7FX0+QC6de9P5DMoU/KGnLUM5xD5taO9oI=;
        b=O2KQOvVVhbqP7frjWHoWMe3BB5Jaa9tzk8T9bB50o+V2U7jEXczl+z00urHA6+UZeO
         XY4+tL8R7cnsmtiWVIZmWxlcfKMBdJp6OTh7njFSn0PhCRVtEw4GYepW3ManDcTjO++o
         D90gfQv2kmUDyj7rBsZwU0EqD/EACPgYZkH2o2BiJK9OhB+mg9rlTzLGrNYDdVS6hNWI
         u7GdUKCPd9Gdc0g2g3B2UW2eXGmUy2dDRy2izVhgO4dDgXMypmMJooK1oPeLECuPqHi9
         5x/qRURQaC1i3mj2ZKAiQhbpOS3sFhNvjFHVKjEslB6QdorTMAtXB2NRsJxP9LRheDwc
         8qEw==
X-Forwarded-Encrypted: i=1; AJvYcCVi9vBK9mRjyfPgekqQk7fWeORgal3n0BJE2RsDu+wsea+Gp6H+pvgspGCXaeO3fGRLtss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1c9rt/+Sk412n8GaPboSTz1ja/h+ABLJy1KW1vM4T6yZILxuM
	VD825lQVUd0cYj7Ai553wsMzXdtNZqKfc3l427PdgT7wKyWuRDFb9MUjCIneC/213IBUPkSwqwN
	yVUWObRjGTwNx1hB9wPXscgYk5QuWGsw=
X-Gm-Gg: AY/fxX5v3YCE4C0f27lVqY4ffLeHA/dmq7T3nkvnuhFf2TcZoDbZ8cFHwYThHNrT5Yc
	GKzpakIrjLuKtdJSQqyh51MM7Q/CZvhzaA2fyiYfy3KjFjInqxtF0dfq853RAlR/PbMqZ1jFA0F
	4c903Bp02UMQBqkpJFskLF15aXY5bXCAIcDXBZzWH2q7OzPVSD3ZJoWtIUxME2v4KxFxQgwTGSP
	4gQjf51Ymfzxr8p/yv355caoL4kGjZaHNzGBnXT38fEwD2OzKHSMDEg1IE1aDB8z3QwQpqD
X-Google-Smtp-Source: AGHT+IE391Zo/I4OnEADMbnLsXL50TqJBoNLlwXazjnqHBh2Ue7xVAxSXjWurIV3OJenG37hYjmXffgZk0NoAwBZ9Yc=
X-Received: by 2002:a17:907:e109:b0:b80:3846:d46 with SMTP id
 a640c23a62f3a-b80384610eamr103906066b.20.1766122935767; Thu, 18 Dec 2025
 21:42:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-11-dolinux.peng@gmail.com> <CAEf4BzZG9i9uVSyPq=6=t7KDgxvXX6GgDkKA4fCd11Un5HQJhQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZG9i9uVSyPq=6=t7KDgxvXX6GgDkKA4fCd11Un5HQJhQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 19 Dec 2025 13:42:04 +0800
X-Gm-Features: AQt7F2pMeJ8kozqZEj8_RkTzKc9unWhTIbQYgiPJnoZXjG8NX5qk25a2_SR_Wo8
Message-ID: <CAErzpmtgFGVdy69O6jLvPRvp4sy1E_u=Hi+CkLC+se6UNDyS7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 10/13] libbpf: Optimize the performance of determine_ptr_size
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 8:03=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > Leverage the performance improvement of btf__find_by_name_kind() when
> > BTF is sorted. For sorted BTF, the function uses binary search with
> > O(log n) complexity instead of linear search, providing significant
> > performance benefits, especially for large BTF like vmlinux.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > ---
> >  tools/lib/bpf/btf.c | 20 ++++++--------------
> >  1 file changed, 6 insertions(+), 14 deletions(-)
> >
>
> nice and clean

Thank you.

>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index c63d46b7d74b..b5b0898d033d 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -659,29 +659,21 @@ static int determine_ptr_size(const struct btf *b=
tf)
> >                 "int long unsigned",
> >         };
> >         const struct btf_type *t;
> > -       const char *name;
> > -       int i, j, n;
> > +       int i, id;
> >
> >         if (btf->base_btf && btf->base_btf->ptr_sz > 0)
> >                 return btf->base_btf->ptr_sz;
> >
> > -       n =3D btf__type_cnt(btf);
> > -       for (i =3D 1; i < n; i++) {
> > -               t =3D btf__type_by_id(btf, i);
> > -               if (!btf_is_int(t))
> > +       for (i =3D 0; i < ARRAY_SIZE(long_aliases); i++) {
> > +               id =3D btf__find_by_name_kind(btf, long_aliases[i], BTF=
_KIND_INT);
> > +               if (id < 0)
> >                         continue;
> >
> > +               t =3D btf__type_by_id(btf, id);
> >                 if (t->size !=3D 4 && t->size !=3D 8)
> >                         continue;
> >
> > -               name =3D btf__name_by_offset(btf, t->name_off);
> > -               if (!name)
> > -                       continue;
> > -
> > -               for (j =3D 0; j < ARRAY_SIZE(long_aliases); j++) {
> > -                       if (strcmp(name, long_aliases[j]) =3D=3D 0)
> > -                               return t->size;
> > -               }
> > +               return t->size;
> >         }
> >
> >         return -1;
> > --
> > 2.34.1
> >

