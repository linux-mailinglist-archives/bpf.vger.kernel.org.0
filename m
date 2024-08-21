Return-Path: <bpf+bounces-37717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F88959EAA
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 15:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02F42829A6
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 13:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F2A199FC9;
	Wed, 21 Aug 2024 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzswCW8x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388D015B134;
	Wed, 21 Aug 2024 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247053; cv=none; b=LPS78iqv3bHm3bqVN6cGkd5AaUdmz/fRM7wZj3FgSbnC/DsY0r9o892PWwPPSaAlZmth34gXyGDjqbqHRExQkhJZeBTqOK8nqwjpIxTZZVi+uqJTgxbqIZD87WzADS0kHtXyAZZm1qROdyefz7WXweR8FhdLufsAc+V64vWn+Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247053; c=relaxed/simple;
	bh=/ZlcAclZ37TSTvbQpAc9IvF/OvM+CrJSAoGiSf+Xbn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWacb3s1JSOvr9HqvZJ3qUjpaIW0ppDbh+ggjRIH5oOJGrwcgyldmM1AKSZhT5noyPKEK/frXB5AWJ/zWOruDjSPrPp06lDsHDy2QpsJaRzCEajuzO9sH7tghnTSayJZgrQd68pnjocCSTGA1Fve+Lnq4FkpzbSJmqjyIZRsSkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzswCW8x; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f3cb747fafso52102231fa.3;
        Wed, 21 Aug 2024 06:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724247050; x=1724851850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GMhjOj/io4lNVWIGajJILmq1tA+tWIb/OdK/+JtnDY=;
        b=DzswCW8x8NhcHjfP/oAQ6W56Ef1fwRIVZf2GI5ZXZwk9rOf91fH6Dn1jDdu21S/yd8
         TIMwMnqanfoRJZx6EWuJeoO5kvhos9if8NTNBM/CjPm0/fkcnTOQ4wPK5d0XeHjsyc/Q
         LSEdIGzC8IoxMN3VUkWvjzAj0Lm4/kVLGtUyLoUg5HCwL3kRaX8cGpGXhZhi42Mfs8Eq
         xwUgUNaJwGE8raDJXZyRrSuwF5Eqgn4/qA0qR7gv3E4DYL7nqqFj3kiAI8mh7ENb+BvE
         6nv3OIV7WFa0TMGrfqZliyDZdaZk6WKW3KTXc6PM+Qb9WWl+yl49hvDFusEUzr/vBxm0
         hFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724247050; x=1724851850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GMhjOj/io4lNVWIGajJILmq1tA+tWIb/OdK/+JtnDY=;
        b=BfnSEaDrWFiOx9+MB+0Ok99YZxJnYtDmXJnrOisMaZFUWjtG5g+zQW/1QKBmPXZCGv
         ZEmsn+lmsIbhpmt4RrusWuU4MtuhyAbKCiEfVZ6VxuW7tvRsQBV9/UCaqY0m0ggP7l3m
         yC3Wc0AEvNMQrX2Z2CbBHaEXD4wPiUvrbk9yItmL8lzxmeRFOE7dDX4Ga3ko4LXqby5r
         32LQ1bRbh5vuQ53jGwn2gjqxp2t/0nl/ReBKIK52t3Ir2u9LLQccmvQxrslgTHkIBgrR
         3TD5wQK43qARdKyPQeHF/XrqCC7jjXEWI4kU5MvnBe9AYnViSLjKGsnlG/MCRvEJbGsY
         K52w==
X-Forwarded-Encrypted: i=1; AJvYcCV0STv6XdRgE5fWl+CO4lzlmk/3QF6OBUEFq/AIcXjv9kS7cFpUbFLGrTnNk1NyBDV3xN1AzFjggI2449iw@vger.kernel.org, AJvYcCXgFMsmwss8nTPHNrgj8w2wD85QcTMp4mRDUo8psMBUIpcKh5vGc8UqTCIqbRq3pOqjQpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAQ0+7aYuUb7fObZU9XPEps5m3lbKj5JUU3UinnWmrAuOoeLlH
	AXHx1Ff+lz1Ji931Ly3B1V1rG/qyVww3ckRgVFKzFvHI6LKkHqQ4F6hHR3BFMbfxg/B7ebIHn+q
	3sr+PSHn3knrj2gLPN20qREQzth8=
X-Google-Smtp-Source: AGHT+IH8VOQ2ctJPT4jX29fDswjssKW86maK9GcZiWUqw4Gy3Qr78CeejZhdHpxupBYKm2X/anLDiAr7ZWu70BFGimo=
X-Received: by 2002:a2e:b687:0:b0:2f3:b77b:dee2 with SMTP id
 38308e7fff4ca-2f3f8b7437emr13469741fa.48.1724247049804; Wed, 21 Aug 2024
 06:30:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821112344.54299-3-soma.nakata01@gmail.com> <ecd1af32-8e6b-45d3-8434-0e981fd198ea@wanadoo.fr>
In-Reply-To: <ecd1af32-8e6b-45d3-8434-0e981fd198ea@wanadoo.fr>
From: Soma Nakata <soma.nakata01@gmail.com>
Date: Wed, 21 Aug 2024 22:30:35 +0900
Message-ID: <CAOpe7SdG_Y0M5dJJ-C3NJ6-bfjHAshz+Ok-MzcBiGuaiYyTeRw@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: Initialize st_ops->tname with strdup()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 9:16=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 21/08/2024 =C3=A0 13:23, Soma Nakata a =C3=A9crit :
> > `tname` is returned by `btf__name_by_offset()` as well as `var_name`,
> > and these addresses point to strings in the btf. Since their locations
> > may change while loading the bpf program, using `strdup()` ensures
> > `tname` is safely stored.
> >
> > Signed-off-by: Soma Nakata <soma.nakata01@gmail.com>
> > ---
> >   tools/lib/bpf/libbpf.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index a3be6f8fac09..f4ad1b993ec5 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -496,7 +496,7 @@ struct bpf_program {
> >   };
> >
> >   struct bpf_struct_ops {
> > -     const char *tname;
> > +     char *tname;
> >       const struct btf_type *type;
> >       struct bpf_program **progs;
> >       __u32 *kern_func_off;
> > @@ -1423,7 +1423,9 @@ static int init_struct_ops_maps(struct bpf_object=
 *obj, const char *sec_name,
> >               memcpy(st_ops->data,
> >                      data->d_buf + vsi->offset,
> >                      type->size);
> > -             st_ops->tname =3D tname;
> > +             st_ops->tname =3D strdup(tname);
> > +             if (!st_ops->tname)
> > +                     return -ENOMEM;
>
> Certainly a matter of taste, but I would personally move it just after
> "st_ops->kern_func_off =3D malloc()" and add the NULL check with the
> existing ones.
>
> BTW, there are some memory leaks if 1 or more allocations fail in this
> function.
> Not sure if it is an issue or not, and what should be done in this case.

You mean the line below?
if (!st_ops->data || !st_ops->progs || !st_ops->kern_func_off)
seems it says the size of them are in descending order or something.
But regardless, this looks like a memory leak.
I will send another patch on this.

thanks,

>
> CJ
>
>
> >               st_ops->type =3D type;
> >               st_ops->type_id =3D type_id;
> >
> > @@ -8984,6 +8986,7 @@ static void bpf_map__destroy(struct bpf_map *map)
> >       map->mmaped =3D NULL;
> >
> >       if (map->st_ops) {
> > +             zfree(&map->st_ops->tname);
> >               zfree(&map->st_ops->data);
> >               zfree(&map->st_ops->progs);
> >               zfree(&map->st_ops->kern_func_off);
>

