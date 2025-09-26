Return-Path: <bpf+bounces-69864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D22DBA50D0
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 22:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CF33BFD9C
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 20:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966C528505E;
	Fri, 26 Sep 2025 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6K5CG30"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909117260A
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758917599; cv=none; b=o9Qlsh1SYb+dQOcqJFkB15kLrSZJNf6CKTqDEXywCyc1qgkoaGOgzKtC1jb4c60oT+um0IVKS456I/6TR5V4Kpiiw2jfjGClj9M+pHShE+r00B9LwoKtwzvWw9yPte7RloJLISdQINLnQ5zix93POTnsblQSXYbBI54dzLgXO/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758917599; c=relaxed/simple;
	bh=ockMKje8IiP3ZkK2AE6a5yj/VWFQ9iypReLwJDNvmR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goNMdg8HHy5eUR2/YafziJSSxWo/9zwRlgXy2lnJIM8H08oNUMHz9k8Ir67ncF6ynjjx22mE7zW/VWW094sM8yNFrLPhRpN4Hr09tYwXYV/pKgn/J3abW9T78a4daN1ZOA3buubvxutCjWqrEZJiIyBbdZvwH/Cy8onjb+/jLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6K5CG30; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so2969576a91.0
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 13:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758917596; x=1759522396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azJ7D3HhTIhe5KhU07JKwHjsPi1hvzfaP5sawhvAHr4=;
        b=I6K5CG304Mikg6FT/CbhLl3z8M7G/4m08XEMF5FaNEt0+3bXMsY4ef7IKn3CYfHG6M
         HAgucfltRaYO0bMGBXRF6ycrN0iZ+OpLZrM8U88agu5tfiMHx1YtfMuHUk+ZWf4CgHgT
         iETTzLINHPlyBNBhCjB9Uzd15bK9IpSyNhrzjhgWIuB3MwxvyNzYt2XwwrqVYYE4K7ex
         AA5lXwLqM9t3hEuQJlTvUyvhi/8Awjrf0/yvY9y5H5r2mgqtzG3FSEW+dz3yZwGDXv0y
         vcQR1N1ABqK/K+ay9qei9jwIPccS0r3p+GLbgL4gcDl4HC8UTIHS/FFo7O2quQZTnAsl
         JpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758917596; x=1759522396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azJ7D3HhTIhe5KhU07JKwHjsPi1hvzfaP5sawhvAHr4=;
        b=Uqny/o812xoRLRJxPg/bSv7vpDgSERp3B2LV8usvbIvsT9gOsAtXr/arMHoXc3OpWZ
         BjCr/qBheBzXkqZCVyS1Nfz9xfZ/2Pn+m+S+nnMCjDG2auzSZurVRFSXegO+I/MHe+hu
         qu0sEIOrsQhfAZ6/aJHTk3anTYJY9Smx+H8PjA5Zifjwdeaa8pDvRj2sQnB+mrNDE3HC
         jRk5F309htvDhZ00vcbs74KMOSbEf5Q1MFV2EXqq28yOsztg+nCF5x5NtgDeQaTD913b
         876mLVu5NVgFmYkIHdjxkztZWVXgznvI7+ESUap6bVOxj9ss+xCtTnOGs72XmCTJ1ohy
         Sb4g==
X-Forwarded-Encrypted: i=1; AJvYcCXkhijD2aWkN9zUlOf9xEca1AXhnJ9qI9Bl53wmXDqwkyGNzMMtGLFsltFNKMvlJ3xdSGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1br43uSXbHj7r/1slz6r4gRULOfskt7w2jOmAtvLlXIpEVuXw
	bjYKjRMzrg4+ytdBvbWE553UVlAZtchEPL60+qS3NvA+Dh7jo4Aq8uBJm1SvTUcq9zkko1KzwNb
	lJfdJNVxE2CvRUGN/NNP1btiGyC+gRRkRHQ==
X-Gm-Gg: ASbGncs1SQx9ILB1gGoGheVHiw+Yi5YNoEOyYwUUfY3sRKwpsUjQJz9CRAAkEB+18oB
	Lsu+YgVM3tWbve21BP2KSnVUXtxaD5N7Ty27DW4Wzp5mFsv0zX8aTt5XihIGyHn0J/MdYi4aR5c
	RxUNy4eq3DVyuC+xttLqz+JfXjPFQO8IreaFu+LlNasyh1HOs/LBt58UfOC99bClQksEYw6EoXF
	Sn4cnLh/6PfKfXnEe/R/Dc/c9JQJZqZ5w==
X-Google-Smtp-Source: AGHT+IE9wktAnJaXtU0PxcthBauR24TfJwetpBW/V+26k16vTx5pCVgALqEiwxzd5//zsiqXJsPyO+D1zjUVWDi51VA=
X-Received: by 2002:a17:90b:4a49:b0:32b:a332:7a0a with SMTP id
 98e67ed59e1d1-3342a242c7cmr8106347a91.1.1758917595750; Fri, 26 Sep 2025
 13:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926071751.108293-1-alibuda@linux.alibaba.com> <bf53fe2d-366f-46eb-bd9c-5820ebd87db7@linux.dev>
In-Reply-To: <bf53fe2d-366f-46eb-bd9c-5820ebd87db7@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Sep 2025 13:12:59 -0700
X-Gm-Features: AS18NWDCAjm_CCwW4B5mtgKQl5ZzUHpMh8GaGW0BqCqWybt4qyHd4Xb5OMFtX94
Message-ID: <CAEf4BzZibyj4cyeMBAhGUWMVJ8P9ZeiwZgXF8HV90L8iwmkjTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix error when st-prefix_ops and ops
 from differ btf
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, pabeni@redhat.com, song@kernel.org, sdf@google.com, 
	haoluo@google.com, yhs@fb.com, edumazet@google.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, jolsa@kernel.org, mjambigi@linux.ibm.com, 
	wenjia@linux.ibm.com, wintera@linux.ibm.com, dust.li@linux.alibaba.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, bpf@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	sidraya@linux.ibm.com, jaka@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 9:53=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 9/26/25 12:17 AM, D. Wythe wrote:
> > When a module registers a struct_ops, the struct_ops type and its
> > corresponding map_value type ("bpf_struct_ops_") may reside in differen=
t
> > btf objects, here are four possible case:
> >
> > +--------+---------------+-------------+-------------------------------=
--+
> > |        |bpf_struct_ops_| xxx_ops     |                               =
  |
> > +--------+---------------+-------------+-------------------------------=
--+
> > | case 0 | btf_vmlinux   | bft_vmlinux | be used and reg only in vmlinu=
x |
>
> s/bft/btf/
>
> > +--------+---------------+-------------+-------------------------------=
--+
> > | case 1 | btf_vmlinux   | mod_btf     | INVALID                       =
  |
> > +--------+---------------+-------------+-------------------------------=
--+
> > | case 2 | mod_btf       | btf_vmlinux | reg in mod but be used both in=
  |
> > |        |               |             | vmlinux and mod.              =
  |
> > +--------+---------------+-------------+-------------------------------=
--+
> > | case 3 | mod_btf       | mod_btf     | be used and reg only in mod   =
  |
> > +--------+---------------+-------------+-------------------------------=
--+
> >
> > Currently we figure out the mod_btf by searching with the struct_ops ty=
pe,
> > which makes it impossible to figure out the mod_btf when the struct_ops
> > type is in btf_vmlinux while it's corresponding map_value type is in
> > mod_btf (case 2).
> >
> > The fix is to use the corresponding map_value type ("bpf_struct_ops_")
> > as the lookup anchor instead of the struct_ops type to figure out the
> > `btf` and `mod_btf` via find_ksym_btf_id(), and then we can locate
> > the kern_type_id via btf__find_by_name_kind() with the `btf` we just
> > obtained from find_ksym_btf_id().
> >
> > With this change the lookup obtains the correct btf and mod_btf for cas=
e 2,
> > preserves correct behavior for other valid cases, and still fails as
> > expected for the invalid scenario (case 1).
> >
> > Fixes: 590a00888250 ("bpf: libbpf: Add STRUCT_OPS support")
> > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   tools/lib/bpf/libbpf.c | 37 ++++++++++++++++++-------------------
> >   1 file changed, 18 insertions(+), 19 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 5161c2b39875..a93eed660404 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -1018,35 +1018,34 @@ find_struct_ops_kern_types(struct bpf_object *o=
bj, const char *tname_raw,
> >       const struct btf_member *kern_data_member;
> >       struct btf *btf =3D NULL;
> >       __s32 kern_vtype_id, kern_type_id;
> > -     char tname[256];
> > +     char tname[256], stname[256];

I adjusted tname size down to 192 to avoid compiler complains that
snprintf below can truncate output (useless warning, but oh well)

> >       __u32 i;
> >
> >       snprintf(tname, sizeof(tname), "%.*s",
> >                (int)bpf_core_essential_name_len(tname_raw), tname_raw);
> >
> > -     kern_type_id =3D find_ksym_btf_id(obj, tname, BTF_KIND_STRUCT,
> > -                                     &btf, mod_btf);
> > -     if (kern_type_id < 0) {
> > -             pr_warn("struct_ops init_kern: struct %s is not found in =
kernel BTF\n",
> > -                     tname);
> > -             return kern_type_id;
> > -     }
> > -     kern_type =3D btf__type_by_id(btf, kern_type_id);
> > +     snprintf(stname, sizeof(stname), "%s%.*s", STRUCT_OPS_VALUE_PREFI=
X,
> > +              (int)strlen(tname), tname);
>
> nit. strlen(tname) should not be needed. Others lgtm.

yeah, dropped that while applying, thanks. this was a copy/paste from
tname's snprint, but there we do actually need a prefix of a type, not
here, so strlen() makes no sense


applied to bpf-next

>
> Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
>
>
>

