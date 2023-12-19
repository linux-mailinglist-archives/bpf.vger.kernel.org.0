Return-Path: <bpf+bounces-18338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A7C8190C2
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 20:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343101C24B8E
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 19:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D882138FB3;
	Tue, 19 Dec 2023 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1h/h5G+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC21838F87
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c6ea99429so50136765e9.3
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 11:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703014324; x=1703619124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jh1bpFZitOgqTQkBCm5Bhi3NQ2RWRj7to2xsOwMrx64=;
        b=E1h/h5G+IyvsX6VK710EZY5APZZWnJ08OyC9mNYrGEpCotzfJyXeYf/BBxcvs5Obxc
         mwQc2bQOXCDUAjVElz2+fV1kyhZiIstOfOTHQ2768ViNcUDt60v3ZjGFA/aFVTeDiZKc
         Aq+HQEuYYDaTOx6Rjj45sNejx4JW4WS/Y/e8nRwJSjYHoFLAEC59Leh/7rdiVYQNwUHX
         06sPYTQfEkVIJTf5L/PVdAj3rr/8RP9ymlCd40VEt5ozg2ilF1vrRtQA/AZQnMf3HXjQ
         uGAVYHz1hZwkMzUJolcPI0fwtnrwkx4enjfEHf0aDTeKYdVWo1RA9kegrYzcoiGMFFZ3
         yyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703014324; x=1703619124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jh1bpFZitOgqTQkBCm5Bhi3NQ2RWRj7to2xsOwMrx64=;
        b=NfPxGXqiwY+lQJYetbTR+u2UUMabzzl15DL81zk0gNVpcNHuX41Nzn18mvRsVDk53i
         n36BsMuvM3Ethq1em5t+L4Vi1vIErOzp5GXUf2+34/dxkeYQMVyS0SIHLq79jDW9v6oR
         JD74ZQ37UIR3AgCT3qVg3GhqmxRwJWZnUNj7JCW9C9v4OQ8rTAehqExd2FQ1jnvdpMw5
         pqV3/kX5Fl8+NAT9wVU/8Ys8j3Yjgn9UhIZcfys2FBXZUUhmcQWmZUD4t8jqPoWFyb+Q
         qHDru1zaQqOfYc2JdiCb1wFcEUTSTYq7KD2JNm7qb9kEE78a+OFeJFQrZFNuO4Yt95rl
         ZfKw==
X-Gm-Message-State: AOJu0Yy0nDLlhOaWbHjpCHToVPq+lMkBL1Vk3t+vfMNoEoxImBCSKca1
	lGIJ+YmPnZ8R/6qDRXQx/e1EvwxcWrghfxbnRLY=
X-Google-Smtp-Source: AGHT+IEBcwxXI6wFFp0qczXxYGsUt8YKERM9FQvtjvHPj+Z/V2tWgUiKvu2I9y3tQvM0rHzUHkj/rh78vgke8Bll0F0=
X-Received: by 2002:a05:600c:19d0:b0:40c:6b8e:ab2d with SMTP id
 u16-20020a05600c19d000b0040c6b8eab2dmr2522071wmq.212.1703014323801; Tue, 19
 Dec 2023 11:32:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217010649.577814-1-andreimatei1@gmail.com>
 <20231217010649.577814-2-andreimatei1@gmail.com> <658b22003f90e066ba7d6585aa444c3e401ff0ac.camel@gmail.com>
 <CABWLseu+uALXXwaSGJ=zJhoZuWH3Lajby-ip8oKAmTOLxci7Vw@mail.gmail.com>
 <0994aae8e3086cb93f25a47ee9e81a6894dbff26.camel@gmail.com>
 <CAEf4BzZPC0zV_ETO_BPe58aZnDx_GrhpVejr3=-Hzx176P1Kvw@mail.gmail.com> <ca3347ad8fee1a03afddf0d89ddca4d533ddacf3.camel@gmail.com>
In-Reply-To: <ca3347ad8fee1a03afddf0d89ddca4d533ddacf3.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Dec 2023 11:31:51 -0800
Message-ID: <CAEf4BzYvRrTg2+j8T+JkEoa3+hFvoHMXRrT7qKvhhTR+=fR=WA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] bpf: Simplify checking size of helper accesses
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 11:24=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2023-12-19 at 11:08 -0800, Andrii Nakryiko wrote:
> [...]
> > > > As a btw, I'll say that we don't allow variable-offset accesses to =
btf ptr [2].
> > > > I don't know if this should influence how we treat the access size.=
.. but
> > > > maybe? Like, should we disallow variable-sized accesses on the same=
 argument as
> > > > disallowing variable-offset ones (whatever that argument may be)? I=
 don't know
> > > > what I'm talking about (generally BTF is foreign to me), but I imag=
ine this all
> > > > means that currently the verifier allows one to read from an array =
field by
> > > > starting at a compile-time constant offset, and extending to a vari=
able size.
> > > > However, you cannot start from an arbitrary offset, though. Does th=
is
> > > > combination of being strict about the offset but permissive about t=
he size make
> > > > sense?
> > >
> > > I agree with you, that disallowing variable size access in BTF case
> > > might make sense. check_ptr_to_btf_access() calls either:
> > > a. env->ops->btf_struct_access(), which is one of the following:
> > >    1. _tc_cls_act_btf_struct_access() (through a function pointer),
> > >       which allows accessing exactly one field: struct nf_conn->mark;
> > >    2. bpf_tcp_ca_btf_struct_access, which allows accessing several
> > >       fields in sock, tcp_sock and inet_connection_sock structures.
> > > b. btf_struct_access(), which checks the following:
> > >    1. part with btf_find_struct_meta() checks that access does not re=
ach
> > >       to some forbidden field;
> >
> > wouldn't variable size access be problematic here without properly
> > working with size range (instead of a max offset)? Just because max
> > offset falls into allowed field, doesn't mean that min offset falls
> > into allowed field. What's even worth, both min and max by themselves
> > can fall into allowed fields (different ones, though), but between
> > those two fields there will be a forbidden one?
>
> As far as I understand that part, it checks for each forbidden field that
> it does not intersect with full range [off, off + max_size].

Ah, that's great. I probably should go and read that code before
asking questions and making suggestions :)

>
> > >    2. btf_struct_walk() checks that offset and size of the access mat=
ch
> > >       offset and size of some field in the target BTF structure;
> > >
> > > Technically, checks a.1, a.2 and b.1 are ok with variable size access=
,
> > > but b.2 is not and it does not seem to be verified.
> > >
> > > I tried a patch below and test_progs seem to pass locally
> > > (but I have some troubles with my local setup at the moment,
> > >  so it should be double-checked).
> > >
> > > > I'll take guidance. If people prefer we don't touch this code at al=
l, that's
> > > > fine. Although it doesn't feel good to be driven simply by fear.
> > >
> > > Would be good if others could comment.
> >
> > Given the current (seemingly incomplete) checking logic Andrei change
> > makes sense. But the variable-sized BTF access throws a wrinkle into
> > this, no? It can't be checked just at min/max offset boundaries, as I
> > mentioned above.
>
> Yes, probably this patch makes sense as-is, as a logic is already not
> consistent.

+1, I'd just factor out error message changes, they are separate, IMO
>
> [...]
>
> > but maybe BTF access has to be checked separately and then
> > we can keep the check that does pure dump memory access checks simply
> > and correctly?
>
> check_helper_mem_access() is called form many places, so BTF handling
> should probably remain there. What it lacks is a notion of variable
> size access.
>

agreed

> [...]

