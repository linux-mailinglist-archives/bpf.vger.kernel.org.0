Return-Path: <bpf+bounces-37682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A33959862
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 12:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EADC51C20A15
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 10:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7E81E200D;
	Wed, 21 Aug 2024 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWUjwhhG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741DC1E1FF7;
	Wed, 21 Aug 2024 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231078; cv=none; b=qYNne2QJIUtjduF4MziVhiXLRDHDY5U5bWsFffGRnNJbyvZJjIyFlESYW+asAtt+YbZKyeMdYjKp3SEXts/2562YyuA29cnKyEXzFe94pbdostE0BVaeQN49CK+XeWpJ/mwetRKmNsdq/iyWXlEY+u7lj/GhCmXO0o+DAszslQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231078; c=relaxed/simple;
	bh=Ywp7NcpnCMuqPfE+GLopXcZTqZp8OwH7DsU1MM1Uvok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tU9+d0q1d1/17jMv7GYns2O3sE02H61IJ9I9Y0y36zvC2hnDkDgJEfZjvuVhNv0HpJwoQmsOnAFQvfupRj0yjrAu5jV2T1Ow26sIUBkLxYqVVVUYqZ+8L+/aLpouTidYUZxiZ8VyN/Mg7AaokSpwjCfZrT69koMwPqijzFFC6Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWUjwhhG; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f3f163e379so21753021fa.3;
        Wed, 21 Aug 2024 02:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724231074; x=1724835874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQyXVakCnD9AZzp0xmBayVuIl6MjtbJL7Z4qpL7iJbA=;
        b=GWUjwhhGkgfAqAGr1mg0go4mrb7vW6VJeyAyQMgaOYG5eVTwf2+Dmq7SjDj4EHTCll
         db7sNMp4NWqKfev0KK4GaCmdbfqo0f8ikPgnyqUNv0P8GEvSb6Rs1CMHDzin/QCmcFp/
         4q+fWi3Q+4qP/lFKct65eJ5KYf9Rbp3q6NyPsEYBVGuWMUgcc4d7YIQ7nE9k1JtbslPi
         XvAqX7OHLRx9H1yDE1++anfbTknroU2s2EsAIPdONQA7YYV0dvcqbPrGGcRJkxG2w5qe
         iShN1slflTHKAkk9NC2OlpMKfqjuv7c0zFxPnFFfMPsoPoNBfjkhEiLWm7ujn/6WVROn
         GX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724231074; x=1724835874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQyXVakCnD9AZzp0xmBayVuIl6MjtbJL7Z4qpL7iJbA=;
        b=OKmwQx8a6cmOp5vI2x8oidsc/CyexKYSmTvIol3PA55xq6qHqJ27TZngm3szcYdvxN
         1pcI5JyB61RnTI3lHxbGELxUjP87vGyySpluKT2UT3WaQ5DxlA1w9poSsAoicNMAZ2PR
         dAjS6+mKlqJ5le9QI3g2gw/+2d2blRAwmMzMXkpPQccN33ZDEje9+S4h1IHcjDd3MG5P
         M45NqE3OL0c47td+l5EW0cTJYd6qDUfiEv9OiDKaJXp/sy9NI68nCaFDXHdJBV9obxTg
         P5etd+9aLePeCW/kYrAsY9DNrz6jXUtvoktOvdWiIDPW3l3cpugQF01cyGer+PT4V0+4
         3AuA==
X-Forwarded-Encrypted: i=1; AJvYcCV29RbFGLJgs7EdVoBpNbnq+koFsHPVN9U4z9xf4eVg3kOkN9ywvU0/a6mlgCT8RF0Le+urHFwdOf8RXdk0@vger.kernel.org, AJvYcCXtSP+IMkcCSd/edLpDigVH2fK4Q72ikg1JpLavC9YlXTT0JGbazJR9IboezzPL17xfM7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2C8OgwawYxnDTpYQK0KnGLRw65LBkAeQd5/tFORvZ2bGaRsSv
	GTUSS8IWqSb/1a7H+1fUzBo1aB6dEWQaVmOUSPvapLdDKkxTsYWmPp8rzyd7K60dWaxL67x78oy
	UNKw5g4VfeDqyeMlyf0ZkoZmjknA=
X-Google-Smtp-Source: AGHT+IEy+oQR59XQpe8RT620QZLRAnB3TDZ8MXU8CDjFDOYmBV7q2xPu3BzPff+Eu+P7g4mg6rnnSJl0a5DgUL6MtYU=
X-Received: by 2002:a2e:9954:0:b0:2f1:5d61:937e with SMTP id
 38308e7fff4ca-2f3f88d3b82mr11858681fa.29.1724231074080; Wed, 21 Aug 2024
 02:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821064632.38716-3-soma.nakata01@gmail.com> <66d4df96-3493-4b12-8bd8-e26c42cd342d@wanadoo.fr>
In-Reply-To: <66d4df96-3493-4b12-8bd8-e26c42cd342d@wanadoo.fr>
From: Soma Nakata <soma.nakata01@gmail.com>
Date: Wed, 21 Aug 2024 18:04:23 +0900
Message-ID: <CAOpe7Sc8_ie97RXG2Wzw=0COOpKzRmThZA_W6RCuvVe7iC-C9Q@mail.gmail.com>
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

Hi,

You're correct, I should add a NULL check.

zfree(&map->st_ops->tname) causes error because tname has
`const` qualifier.
Also, I found st_ops->type has the same issue.
Therefore, I propose removing `const` from `tname` and `type`
fields of `struct bpf_struct_ops`, and duplicating them from btf.

>
> Le 21/08/2024 =C3=A0 08:46, Soma Nakata a =C3=A9crit :
> > `tname` is returned by `btf__name_by_offset()` as well as `var_name`,
> > and these addresses point to strings in the btf. Since their locations
> > may change while loading the bpf program, using `strdup()` ensures
> > `tname` is safely stored.
> >
> > Signed-off-by: Soma Nakata <soma.nakata01@gmail.com>
> > ---
> >   tools/lib/bpf/libbpf.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index a3be6f8fac09..ece1f1af2cd4 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -1423,7 +1423,7 @@ static int init_struct_ops_maps(struct bpf_object=
 *obj, const char *sec_name,
> >               memcpy(st_ops->data,
> >                      data->d_buf + vsi->offset,
> >                      type->size);
> > -             st_ops->tname =3D tname;
> > +             st_ops->tname =3D strdup(tname);
>
> Hi,
>
> Should a NULL check be added (as done a few lines above for the
> [cm]alloc()) and bpf_map__destroy() updated with a
> zfree(&map->st_ops->tname) ?
>
> CJ
>
> >               st_ops->type =3D type;
> >               st_ops->type_id =3D type_id;
> >
>

