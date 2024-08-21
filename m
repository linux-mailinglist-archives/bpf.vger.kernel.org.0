Return-Path: <bpf+bounces-37697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61989959A13
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 13:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285D128328E
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 11:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2F61AF4EB;
	Wed, 21 Aug 2024 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAwXHFj0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A391AF4E1;
	Wed, 21 Aug 2024 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724237602; cv=none; b=W8WPZdp2bb7VRtsvE3WEBV4jd8b/pIVeLFEBwKTknV0B8xU/KQXaHgAZhfrs3Zsu0wyHfT62NWH2KWGuBrebB87DoQ5vyDu2p4GL8mttTnadQa9WO7nDlRFgahNO5BgcPGa3KAF94L+8x7yzULM3nq63ikd0XQddS+MTRjtVHkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724237602; c=relaxed/simple;
	bh=mA0adj883xXJeQ+aUyZEE9rMNJjjfthxo2uEk/V8c+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuNm2RfJISKo5Qc59MS/AnW+0UeU8qflgBonbdjVfWCLi8Fn+OaWfDTUfywzUJd5eilgRbJNrEQUeWDSm5IAwsbkfgZ434E9yLQV4wET88dUuqzLzQFl1DWPtTUfBiJRwsHRHkEW4x80eLWRjoJW3tiElEDzhlF9Qn5R8YbgjrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAwXHFj0; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f3bfcc2727so45360291fa.0;
        Wed, 21 Aug 2024 03:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724237599; x=1724842399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwrhvYn9IYVNLiK3zBjH9it7CSXvTZVRRNnHjqyFWC4=;
        b=MAwXHFj0GDqT3mFb2HCFPxPPEcvmjdc8eQHn2GasinX6BJZVH/YngQWaLmCG3R2fVw
         DjwpzPCeVtDV6dKADgAe4jyKXI3+9MNSeM8HhdXi0knKmwCMJyh1q1Q7tvpK1j0kllun
         3vgkS2IDyqYzP/ScjR8n6+SLi9jJAFGIQAx4Dd25inxutHJ8ekWgn/Sl6bvaz0Cv9H5a
         wNkjkFQCIWk6MdN4bdTcH2N2lhxjSH8Njb6hsgoEDj9WTHDukm27hxpg5TuH1kiGWofX
         rdUvjM2SHJEphO5Hqxo7jjmqBJpJ+Krz3ioJ4qOx+D3Ae2XgsWyGxpFKbyOPo6cd6RNd
         X6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724237599; x=1724842399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwrhvYn9IYVNLiK3zBjH9it7CSXvTZVRRNnHjqyFWC4=;
        b=dXwTW0aG4Ud1hnFsUbEDGhzcXoD0bZl881GoSU66rhAwH9UrnsS3z1CRBv5wERi4Wp
         cQG631BCxcLuPbwAOLXr8sMLiKC/S7xvzUToZNGoPFdAxwypj666d6tS7aXC/Bk5VQry
         D58uVq0TVyGBaez5NuA2FuYKczBSB3MPIINRiYk/2C2DSE4uhYjvtiPqgdIu5UCBi/BZ
         QSU6f81ivstmcAQUsihqKZMfXhz7yVw4/AYe3dLo66+vSevcT/fGtYlilt2ZdhuzR6G7
         YkJjn2pSvDmUFu5/OxwY7UQlJBxAyWJIfzZs71lLffhrel8MV/dJbwgDHYvTT7v+nkWj
         pf0g==
X-Forwarded-Encrypted: i=1; AJvYcCUZwjmeqgKBQg/YbyqKIIN0P4j393caxPdCUQOBtWI6rHw+Btb+AdXQDuqGTGEeuyI5HVk=@vger.kernel.org, AJvYcCVD86E+rKxFy5fTcVcUetNn3/+7rcyjQkg9SOA8e6Q8aagecQjK5tG6rV8YnsTbVfqNizxZSbWT27n+uquT@vger.kernel.org
X-Gm-Message-State: AOJu0YxuSEQ0Ws+5PNYl8z9RbG6xlb5SkRdMwjxl86EwDpBOc5qrZKnV
	u+XCOZN/FpBQ7hZImzfzn3AGIgRpvJRYMJBophPg4Y6TMz6vD9eFfXD5SlxUOriLXUKoENgm09R
	GWcaQBpBcYgfiStl8UYYwq3MqseE=
X-Google-Smtp-Source: AGHT+IECWcn8Uo67Cg+Q2ui9lNvRZZC4chMa38kqPfI4/6bbV1tH5ZSipAy9ZcBD7Id60gd6jnBxLOlJypovB4cedY8=
X-Received: by 2002:a05:651c:1508:b0:2ef:c8a1:ff4 with SMTP id
 38308e7fff4ca-2f3f87ec71cmr14949941fa.7.1724237598094; Wed, 21 Aug 2024
 03:53:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821064632.38716-3-soma.nakata01@gmail.com>
 <66d4df96-3493-4b12-8bd8-e26c42cd342d@wanadoo.fr> <CAOpe7Sc8_ie97RXG2Wzw=0COOpKzRmThZA_W6RCuvVe7iC-C9Q@mail.gmail.com>
In-Reply-To: <CAOpe7Sc8_ie97RXG2Wzw=0COOpKzRmThZA_W6RCuvVe7iC-C9Q@mail.gmail.com>
From: Soma Nakata <soma.nakata01@gmail.com>
Date: Wed, 21 Aug 2024 19:53:06 +0900
Message-ID: <CAOpe7ScEK4PZ=43QhMSeJnh4PpJ67T1R5m45pFhkeD3EiQzUKQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Initialize st_ops->tname with strdup()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

`type` field is supposed to directly point to the btf in functions
like `btf_members()`. So I will make change only to `tname` field
in this patch.

On Wed, Aug 21, 2024 at 6:04=E2=80=AFPM Soma Nakata <soma.nakata01@gmail.co=
m> wrote:
>
> Hi,
>
> You're correct, I should add a NULL check.
>
> zfree(&map->st_ops->tname) causes error because tname has
> `const` qualifier.
> Also, I found st_ops->type has the same issue.
> Therefore, I propose removing `const` from `tname` and `type`
> fields of `struct bpf_struct_ops`, and duplicating them from btf.
>
> >
> > Le 21/08/2024 =C3=A0 08:46, Soma Nakata a =C3=A9crit :
> > > `tname` is returned by `btf__name_by_offset()` as well as `var_name`,
> > > and these addresses point to strings in the btf. Since their location=
s
> > > may change while loading the bpf program, using `strdup()` ensures
> > > `tname` is safely stored.
> > >
> > > Signed-off-by: Soma Nakata <soma.nakata01@gmail.com>
> > > ---
> > >   tools/lib/bpf/libbpf.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index a3be6f8fac09..ece1f1af2cd4 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -1423,7 +1423,7 @@ static int init_struct_ops_maps(struct bpf_obje=
ct *obj, const char *sec_name,
> > >               memcpy(st_ops->data,
> > >                      data->d_buf + vsi->offset,
> > >                      type->size);
> > > -             st_ops->tname =3D tname;
> > > +             st_ops->tname =3D strdup(tname);
> >
> > Hi,
> >
> > Should a NULL check be added (as done a few lines above for the
> > [cm]alloc()) and bpf_map__destroy() updated with a
> > zfree(&map->st_ops->tname) ?
> >
> > CJ
> >
> > >               st_ops->type =3D type;
> > >               st_ops->type_id =3D type_id;
> > >
> >

