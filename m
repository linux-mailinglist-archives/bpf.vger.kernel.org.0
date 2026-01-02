Return-Path: <bpf+bounces-77704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E077DCEF2BA
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 19:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99EE03043F26
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6FB30DD0B;
	Fri,  2 Jan 2026 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+3LXfF8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB0F314D0E
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767377198; cv=none; b=TUk0lRqZAqEFtZEZWAHJrQo7jx6btNWC/lj0oIm1UWfIiVeUHUnJuz7n0eag8WytdgjBL8W9UBJrvbYVXdFNSHry5IVhjaBSBIdC+la/mit+oJe8Z1lI9vWXDZBqd4TcV/WKmDyBwMprQYlDhFs4SoEboV28zAHYtik7XPsbj40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767377198; c=relaxed/simple;
	bh=XOo3IeTw77v00FtG/fT4tm8LWfTRaZodknOewEyiZ94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hh6Yvi/Huht1qihUN3t/IO0TifhsUf4F5o4rWO6+QbanQppXACPTFfJ8Gkf8X8MMsM/w9/tqrsQlSJIquKJuiU70Eum/hvN3tJcnDFqX6QL9TjRCEV7QCZCpdx3oVkDM0NTYfrwumsz9/+Z8wtNq7Qj4rjLFiTcdxWElRF7sLu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+3LXfF8; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b8b5410a1so13942826a12.2
        for <bpf@vger.kernel.org>; Fri, 02 Jan 2026 10:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767377191; x=1767981991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3txhFJnftFVHg8JVIRDFlhLDfCdDu7NdhGrjrKRZCbA=;
        b=H+3LXfF8OcLbYMyg6Xz6/vGetHCn10tuBfF2/cF0k2HgY4EJ/q6OFIOy7WqONK4kWA
         0J9bCHnZ3WTTO/2DLa2tgcgnLagHOeO2V1Te/aWKEfJCoE0altBnE5ESO5k/wnNVF0yk
         QeFdtyl1CFzhd/CWaJgsczZetMtu6Z9yfAkTrYiPNvDDobjDUhRgVq8g0/2bRpzIwXQW
         RkZ3L8cOUwCP22QSd0C1/C4CjvYtCzHVWFwlrH4wKfwXkgO6gGx0uOH++o72oC1CqCZT
         l7N5bgm+MWE4ctHd4gdK6LeaU6ANd7miCjAFIpUdjwc7BmIiJNiiGHqvLZVLpB6taBSs
         qYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767377191; x=1767981991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3txhFJnftFVHg8JVIRDFlhLDfCdDu7NdhGrjrKRZCbA=;
        b=ZxUia9rV1gEbB4v9x+LcZYZrwra0xCpPnZ30b1L5v/kXU8lhHTeqwDre76tNBHxnqd
         bPWYrCmMCFloss3FUEEAJQPm31o9POzu2IIHfWqcQZdcE0bJ+4Dp1l6BPUrVVY0YvCKo
         7bJ/hh0WTznD2Co0MS3hs/Qv6PdaQYh5eMz6c1EYecZNI2ai2coSs2IHuZKNSZ90mb0o
         sXohdpz0V14eeYMCQEmIlAxIoG5xmQU0PrLGOSinRayFdeEhJmUQzYLHaNLkTygyfGb2
         qZTVab9ZDhupGJjIsyI9uHTZQg4bImZ4wbhl/qS45PrSHhFbtxBP18quyxd/7V5LUdQR
         WcvA==
X-Gm-Message-State: AOJu0Yz1BRngwonGdSLsS1Vk0y7LtC/ZITbwQhzx4l5ds3l2Us3Ofyrp
	3Jzo3KJhTJGK3hA6O/z1y+zGlBzROx/qg8MPkiyd04btWYgY9+TMmJrF1ZJGTRqHS5Ss2HQkDpu
	TCtlTU0LBKQfeobSEtWNSZ7H3QT528co=
X-Gm-Gg: AY/fxX6vVsnAxzkBbtL3OHXT+Fjb/m+G4DIGkr1aMKq542kTgjiU0gy9j3Q7eP/DI1B
	radtQPq8zJL4/ef29Cn6sUNjS1x/UAQHbJrKeENueLmdzduZuXldSB0E69XBzpOfaY0OUbM2jBh
	jB9dYpuFGGVJhu+38JQ9hJ1LU66bqW7OyLan2SfsG0hC7xY5jPGnHPzR3pZ7vEK1pScLhhH1nIn
	BUbsyBfPFaOZ1XRgxQcwv0dTzAddhOTDR4mfW36ZpdhNpqXaGBzbNXRO381M6WlYKAE3Dwx59Mf
	S1TdUGU0qA==
X-Google-Smtp-Source: AGHT+IE+Chz3uNu8B/EjEnlkLRyN4CraKCof1NRO3jOpC82d46IUYZh8mc4WzTjS+ooCe5hsrhaoRswDoHSD2xE0Fhs=
X-Received: by 2002:a05:6402:1e93:b0:64d:57a8:1ff3 with SMTP id
 4fb4d7f45d1cf-64d57a82362mr34772049a12.4.1767377191272; Fri, 02 Jan 2026
 10:06:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102151852.570285-1-puranjay@kernel.org> <20260102151852.570285-3-puranjay@kernel.org>
 <CAADnVQJECvWkJ5XuCrq1Oujg9T+n+3Y-vmb=rw+Y0crRVzRkSA@mail.gmail.com>
In-Reply-To: <CAADnVQJECvWkJ5XuCrq1Oujg9T+n+3Y-vmb=rw+Y0crRVzRkSA@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 2 Jan 2026 18:06:18 +0000
X-Gm-Features: AQt7F2qp2tCFzLTa2nWMP6-Z9KzjJLeDphGy5oo-fg2-Q6avW8rTiuQ4c09BY5Q
Message-ID: <CANk7y0hkp74Cq-wAZOCyk4XV2KVaWNUzBZxO7ZuwvmCNMM3NAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpf: arena: Reintroduce memcg accounting
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 5:56=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jan 2, 2026 at 7:19=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
> >
> >         if (map->map_type !=3D BPF_MAP_TYPE_ARENA)
> > @@ -885,7 +907,11 @@ __bpf_kfunc int bpf_arena_reserve_pages(void *p__m=
ap, void *ptr__ign, u32 page_c
> >         if (!page_cnt)
> >                 return 0;
> >
> > -       return arena_reserve_pages(arena, (long)ptr__ign, page_cnt);
> > +       bpf_map_memcg_enter(map, &old_memcg, &new_memcg);
> > +       ret =3D arena_reserve_pages(arena, (long)ptr__ign, page_cnt);
> > +       bpf_map_memcg_exit(old_memcg, new_memcg);
>
> This one can also move into arena_reserve_pages() for
> symmetry with the rest and wrap range_tree_clear() call.
>
> pw-bot: cr

Okay, sending v4 with this now.

