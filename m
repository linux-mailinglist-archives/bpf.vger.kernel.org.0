Return-Path: <bpf+bounces-78218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C804FD029AD
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 13:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 602C9310E274
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 12:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691333E8344;
	Thu,  8 Jan 2026 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVSnuss/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBE743A23B
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767872027; cv=none; b=kuhFKLY7ogg8FYcoCmrXx+XnjNytyBfuCL1YjXGuiwNtZBaDKpACy1Lz8KhvPSY4lCfdFQbj+zAxxupDPi+T8548Uk9mOrQ6UnCV200qZutgWw1Z5i+PIZLKw0TBwkePNpVa6cWOIaI0WNEe/ii7ymMCg9X7t0QicAIbSeUYuDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767872027; c=relaxed/simple;
	bh=xsjydUGOGmJfB99jVJevtn3YZPMWfw33kkBdbJAnKu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsC6DBvXlK+60Tbd7kbxIMR4gaQhrxr8DsP+MaVSrBS7d5fCKA/X5djNMpgG5wWiXueUyiNYlDHhmikqH2W6/KDUqF9lRMdxUGY5eEH4FvNyrARM+Pp1oFnB1wGEBvAqhCWjLeanfle/pUSprpnRLAqlkwz0QQnVmNjRw123NFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVSnuss/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7277324204so478899866b.0
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 03:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767872022; x=1768476822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vqNur6zNBdmuVpnpvoanbRmCBqKN0J+v+0/8vi5LlQ=;
        b=MVSnuss/lhvyNpFi//lRzobr/5L+5n9MW6Dav5nd71QteT3xCOmWkzBjyofNu6o83C
         Sb+wlAvD1AFw+Jpdgu6jZV4Lqj8bkb8w61zxHvRoKcMLd3dUHdieWBrhAfD5B6nKnt/L
         8Vs8kPs76Bt7UaB3DJg/F7rLYcygSZJTzn/PGNau6z7Ag8ZbKlH1l3unEqgEAGughIMW
         Arm6oNwEZ4m1tR2GoiZ2F34INO2mpVtMCdkUYnemcR0nhMsn5sike2yORv+gekjkCuVG
         bUW1YIbQ0FfLZDymwG8XvR+/MprQEKqvN3COjNtOCdDAMfB7C6OP1WA0b2+62/LsdL7O
         WGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767872022; x=1768476822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5vqNur6zNBdmuVpnpvoanbRmCBqKN0J+v+0/8vi5LlQ=;
        b=VZh0pRPmq5hQR6ws6ia8kcf5dCcwys4eEJDLSZOlG23Dd+guwaJ6MwginS3akg1POP
         ooYi9Sj2Qrzn3GitCfOkqP9gwVLt8EcmKl3vEKRabH05wBvJq0PK0HPuM4ZjCt5SnjCo
         ohtq+Y9t3TsrKELnRQ0YjRoLhZow2QncGixq2TSSHH2hzsE7fc/vKpTWljzr1wv5BEA1
         QfCQKqI+uFzTRr7QQnThu/Cxqzo1bY22RelJgjmwIR9UoJCIWKEI5w6flgNlaUk/3D+d
         oAjk27rPGtJr0fi4MP+8jnEHUz+fKWVIQb+ImDC3d5EwtdiCyNblsCI4ekiWK4L4XIAV
         5YJg==
X-Gm-Message-State: AOJu0Yxbl1y7LBNAhgDnErFLWHQbphoejWg/pp0LHUTZkBd6EF0NBGtA
	a0kyJ3bnVGxnzidpfOAM4f4h1m4muJST151GCl7GTNEjXN5ie6xdb+H7jmKjODVytRLC30poY7E
	QT1wXLPnvR643F6PLgsq8KDZB9rTBVE9Auwrh
X-Gm-Gg: AY/fxX7sfSzyU6OYmma6XslXqJ3dud0y37wNPvLzZ3fL5b0QLx3nN8ajTFFOLPUGB26
	xE80UxKKG/CETGzJVb0tuM+b6n/IizySfFizWALZfbTVihOH34CC7KA8eNgbrf38a/eWNccqYCc
	aOI2GrvHcfV63oxlfZSR9YTtfrCcQ0+qdjmI031EtejEXrF/t3ew1m0rpPpySMQDp2J0XZZRZml
	NOvjD/MGPEc+T9BmcPoIpPKvYnX/rfWBaryGdb8hU9yAFReZObAHJItmYaIHpFz84hYgMopRUtI
	EQP5UJ16OyluNlRk36tmiw==
X-Google-Smtp-Source: AGHT+IGhFpxpjwtMyJ+C4IhcJNQZ7/mktsMqcJEDxjH6zwTb2XQrHctrRwMPhzbedz8TQpX/XU7gVg4yGA35BGp7W9k=
X-Received: by 2002:a17:907:9283:b0:b76:3399:457b with SMTP id
 a640c23a62f3a-b84453a18a9mr520958266b.37.1767872021924; Thu, 08 Jan 2026
 03:33:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107203941.1063754-1-puranjay@kernel.org> <20260107203941.1063754-3-puranjay@kernel.org>
 <c58877171779ba86762ff413007a61227e7a928c.camel@gmail.com>
In-Reply-To: <c58877171779ba86762ff413007a61227e7a928c.camel@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 8 Jan 2026 11:33:27 +0000
X-Gm-Features: AQt7F2pBWp9UkttCLCPyGCi35YbyxMumQIulXRVxZ5Ohcg8rYnnEwimz1JfE0o0
Message-ID: <CANk7y0hrrAiweXkPGd7XGL-BLU-g4U+Wj=j7BSXGXD_acaQK_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Add tests for linked register
 tracking with negative offsets
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 6:55=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2026-01-07 at 12:39 -0800, Puranjay Mohan wrote:
>
> [...]
>
> > +/*
> > + * Test that sync_linked_regs() correctly handles large offset differe=
nces.
> > + * r1.off =3D S32_MIN, r2.off =3D 1, delta =3D S32_MIN - 1 requires 64=
-bit math.
> > + */
> > +SEC("socket")
> > +__description("scalars: linked regs sync with large delta (S32_MIN off=
set)")
> > +__success
> > +__naked void scalars_sync_delta_overflow(void)
> > +{
> > +     asm volatile ("                                 \
> > +     call %[bpf_get_prandom_u32];                    \
> > +     r0 &=3D 0xff;                                     \
> > +     r1 =3D r0;                                        \
> > +     r2 =3D r0;                                        \
> > +     r1 +=3D %[s32_min];                               \
> > +     r2 +=3D 1;                                        \
> > +     if r2 s< 100 goto l2_overflow;                  \
>
> If I remove the above check the test case still passes.
> What is the purpose of the test?
> If the purpose is to check that S32_MIN can be used as delta for
> BPF_ADD operations, then constants in the second comparison should be
> picked in a way for comparison to be unpredictable w/o first comparison.
>
> > +     if r1 s< 0 goto l2_overflow;                    \
>
> > +     r0 /=3D 0;                                        \
> > +l2_overflow:                                         \
> > +     r0 =3D 0;                                         \
> > +     exit;                                           \
> > +"    :
> > +     : __imm(bpf_get_prandom_u32),
> > +       [s32_min]"i"((int)(-2147483647 - 1))
> > +     : __clobber_all);
> > +}
> > +
> > +/*
> > + * Another large delta case: r1.off =3D S32_MAX, r2.off =3D -1.
> > + * delta =3D S32_MAX - (-1) =3D S32_MAX + 1 requires 64-bit math.
> > + */
> > +SEC("socket")
> > +__description("scalars: linked regs sync with large delta (S32_MAX off=
set)")
> > +__success
> > +__naked void scalars_sync_delta_overflow_large_range(void)
> > +{
> > +     asm volatile ("                                 \
> > +     call %[bpf_get_prandom_u32];                    \
> > +     r0 &=3D 0xff;                                     \
> > +     r1 =3D r0;                                        \
> > +     r2 =3D r0;                                        \
> > +     r1 +=3D %[s32_max];                               \
> > +     r2 +=3D -1;                                       \
> > +     if r2 s< 0 goto l2_large;                       \
>
> Same issue here.
>
> > +     if r1 s>=3D 0 goto l2_large;                      \
> > +     r0 /=3D 0;                                        \
> > +l2_large:                                            \
> > +     r0 =3D 0;                                         \
> > +     exit;                                           \
> > +"    :
> > +     : __imm(bpf_get_prandom_u32),
> > +       [s32_max]"i"((int)2147483647)
>                        ^^^^^^^^^^^^^^^
> Out of curiosity, did you write this by hand or was it generated?

So, these two are generated by claude and the we want to test if the
line  __mark_reg_known(&fake_reg, (s64)reg->off -
(s64)known_reg->off); in sync_linked_regs() working correctly. Before
patch 1 it looked like  __mark_reg_known(&fake_reg, (s32)reg->off -
(s32)known_reg->off) and it would break for the pair of values
(S32_MAX, -1) and (S32_MIN, 1).

So, this test fails before the change from (s32) to (s64) in
sync_linked_regs, if I remove the lines that you are referring to (if
r2 s< 0 goto l2_large;, etc.) then it passes even with (s32).

So, I think this test is checking the right things.

