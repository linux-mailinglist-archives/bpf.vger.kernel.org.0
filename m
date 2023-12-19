Return-Path: <bpf+bounces-18336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4648190AB
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 20:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07AC1F25DD0
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 19:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062A338FA7;
	Tue, 19 Dec 2023 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6d5BUci"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071D938F87
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cb21afa6c1so68682851fa.0
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 11:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703013848; x=1703618648; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RTVnyj6oU6r3J3r0EgF5z+NnjntJl+RH84LohA02Q5I=;
        b=m6d5BUcia0Y8ZAijIQvLG6//Sor5lkaNW4mTycNo8sM0HF8AZP1IFxpRsGJze9yNMB
         /6kiieMoOFFRQfw8kbnuY9HVkAxZH3p+5psFtFxWm4JNs2S0Kr/+6qcSFnVMUY3xgS/D
         7UQJAEACEqkj3OGGk+pIhAnZhZDAVbbACTVjP5EimnSlZu5BD/INvMgS2TVKSTphGgoB
         6Ysx6sywSd/j4oZyosJEg49pId6jGPKb2B52q4qyIGxam6WjBESjLl1Ier35uAiVGM6N
         A9zY9lxwZkrY1FRgF/DviXlsBhs2SQiJwFvvojmUdnn9NgvVhyU/CyAblrY6FyBP91+9
         8Wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703013848; x=1703618648;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTVnyj6oU6r3J3r0EgF5z+NnjntJl+RH84LohA02Q5I=;
        b=UsTI5xdpK0Pxwf3dDpiLOeT6qbJhQHQNrBp7MonX9j7s9JLKHnifJqH9hzkWDyFb0l
         eVaEdSm5qsvl1JQ/iwin7skyY1+PdT1F0wwDRa3ny4SEnRdTXIhYhwkhOrxM5k6z8aIf
         tSBHO4BBHAItOUMpwnBB4jgX8jED5o7qkkd0TYRytCk5pSXD4ow45bMji/ht6u1RZr4L
         hkDszC7C2aM0a96aerof6aObXWmOKo/j7mxN8B3TaB4x3q/qSb5nIEqxI7T96Q2GUtDk
         pnhfotRot/uYWy6qjjWRvjR0q/J6S4WXFq3Xcfxh73+OC4GomzHPoHuxXtGi8j2s+ZcA
         ObXA==
X-Gm-Message-State: AOJu0Yy7dhl8syHBcWdDqzBGrGqWtXGnwDvQBeIl8o7dllXKqyutNYGW
	PzEJTAPvw3exFzi0LuoPcfw=
X-Google-Smtp-Source: AGHT+IGMaUQxcS0lUQVh4yUfnwO1WzC/otJxNGW/zJRE+4gMXgXlMqUYhp6RTqEX0Heszn3BwxvbTw==
X-Received: by 2002:a2e:87d9:0:b0:2cc:5fba:1d91 with SMTP id v25-20020a2e87d9000000b002cc5fba1d91mr2796965ljj.104.1703013847500;
        Tue, 19 Dec 2023 11:24:07 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id t13-20020a2e534d000000b002cc32fbe2e5sm2416772ljd.51.2023.12.19.11.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 11:24:06 -0800 (PST)
Message-ID: <ca3347ad8fee1a03afddf0d89ddca4d533ddacf3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] bpf: Simplify checking size of helper
 accesses
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org, Alexei
	Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Date: Tue, 19 Dec 2023 21:24:05 +0200
In-Reply-To: <CAEf4BzZPC0zV_ETO_BPe58aZnDx_GrhpVejr3=-Hzx176P1Kvw@mail.gmail.com>
References: <20231217010649.577814-1-andreimatei1@gmail.com>
	 <20231217010649.577814-2-andreimatei1@gmail.com>
	 <658b22003f90e066ba7d6585aa444c3e401ff0ac.camel@gmail.com>
	 <CABWLseu+uALXXwaSGJ=zJhoZuWH3Lajby-ip8oKAmTOLxci7Vw@mail.gmail.com>
	 <0994aae8e3086cb93f25a47ee9e81a6894dbff26.camel@gmail.com>
	 <CAEf4BzZPC0zV_ETO_BPe58aZnDx_GrhpVejr3=-Hzx176P1Kvw@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-19 at 11:08 -0800, Andrii Nakryiko wrote:
[...]
> > > As a btw, I'll say that we don't allow variable-offset accesses to bt=
f ptr [2].
> > > I don't know if this should influence how we treat the access size...=
 but
> > > maybe? Like, should we disallow variable-sized accesses on the same a=
rgument as
> > > disallowing variable-offset ones (whatever that argument may be)? I d=
on't know
> > > what I'm talking about (generally BTF is foreign to me), but I imagin=
e this all
> > > means that currently the verifier allows one to read from an array fi=
eld by
> > > starting at a compile-time constant offset, and extending to a variab=
le size.
> > > However, you cannot start from an arbitrary offset, though. Does this
> > > combination of being strict about the offset but permissive about the=
 size make
> > > sense?
> >=20
> > I agree with you, that disallowing variable size access in BTF case
> > might make sense. check_ptr_to_btf_access() calls either:
> > a. env->ops->btf_struct_access(), which is one of the following:
> >    1. _tc_cls_act_btf_struct_access() (through a function pointer),
> >       which allows accessing exactly one field: struct nf_conn->mark;
> >    2. bpf_tcp_ca_btf_struct_access, which allows accessing several
> >       fields in sock, tcp_sock and inet_connection_sock structures.
> > b. btf_struct_access(), which checks the following:
> >    1. part with btf_find_struct_meta() checks that access does not reac=
h
> >       to some forbidden field;
>=20
> wouldn't variable size access be problematic here without properly
> working with size range (instead of a max offset)? Just because max
> offset falls into allowed field, doesn't mean that min offset falls
> into allowed field. What's even worth, both min and max by themselves
> can fall into allowed fields (different ones, though), but between
> those two fields there will be a forbidden one?

As far as I understand that part, it checks for each forbidden field that
it does not intersect with full range [off, off + max_size].

> >    2. btf_struct_walk() checks that offset and size of the access match
> >       offset and size of some field in the target BTF structure;
> >=20
> > Technically, checks a.1, a.2 and b.1 are ok with variable size access,
> > but b.2 is not and it does not seem to be verified.
> >=20
> > I tried a patch below and test_progs seem to pass locally
> > (but I have some troubles with my local setup at the moment,
> >  so it should be double-checked).
> >=20
> > > I'll take guidance. If people prefer we don't touch this code at all,=
 that's
> > > fine. Although it doesn't feel good to be driven simply by fear.
> >=20
> > Would be good if others could comment.
>=20
> Given the current (seemingly incomplete) checking logic Andrei change
> makes sense. But the variable-sized BTF access throws a wrinkle into
> this, no? It can't be checked just at min/max offset boundaries, as I
> mentioned above.

Yes, probably this patch makes sense as-is, as a logic is already not
consistent.

[...]

> but maybe BTF access has to be checked separately and then
> we can keep the check that does pure dump memory access checks simply
> and correctly?

check_helper_mem_access() is called form many places, so BTF handling
should probably remain there. What it lacks is a notion of variable
size access.

[...]

