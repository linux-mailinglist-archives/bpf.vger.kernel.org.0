Return-Path: <bpf+bounces-46213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A839E9E6205
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 01:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635632823BF
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 00:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912B8C2C8;
	Fri,  6 Dec 2024 00:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYcdu0iV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F9318E1A
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 00:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443999; cv=none; b=c0zj74RtATbBR84uIiIx/23dvENTd/bzEZS1JKD6scRxMhQTrqMvYBTlJjRPia2xcjRJpn+SZBd7bUcfYti4C/vjWt/CXZmMypqz0aWA6rmfHB7EdbGpGumC2Xm7E78kA+0Tf8M4mT5D8iUoimzYq1vW0p5S221eW5DLhC3l8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443999; c=relaxed/simple;
	bh=d+pN2swYp1b98cmrRAp63eMCiuA8fwnSjwmtqulD2bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0BLtaDOuvtsuvVpcFG+vUoraMlG0ZDU/MuzArfXRnRRuigDolP5NU+1JUFqdffUEmyVBFcFSl2XmlIW1pcNUkpsskabCGaZwEEZ+FBIY0BmvSGu6RdFi5rPM00te2zWzl5iyjNtwyHxBi2agLKfUo7WaWauO6OLj1ysjBmCdKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYcdu0iV; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-aa6332dde13so116362866b.1
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 16:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733443995; x=1734048795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCqVX0uey5lgIZQS85zxan5KwgFJsPjFItnsX+zeMn0=;
        b=fYcdu0iV43RDtHsGm5+8vWcKApmB7RfO+uL99bFwnyh98+2toaBdXvSRpzN0RDHqJ0
         qCS0bS0C9UPh0am1T+X4eRA7gIyociPH0140C0ILfLlEos8VACc0GrONUSOwgEOvrPFx
         3+IxF+PCOUFpr/re4fOamlWVrweP0hDwetngJaIlpVcGzUK0p1Tpic0T+Sf+qVl9sjeC
         M4/3tT6jB2GaEWs4ZY7IKXOgn+xE34VSETmhiUmZQwa//w6Gx0sg/kC8Wnkn4Z/snzmL
         8Q3BDwsJ8WtLwujQjpXfocEvvua4d4GqJAdgaAf/DLONp7tDdst7NjyKf289oIhJQ0yw
         lXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443995; x=1734048795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCqVX0uey5lgIZQS85zxan5KwgFJsPjFItnsX+zeMn0=;
        b=wWeke4ZIJ/ByX/fL8TDX0B2gWd87N5ISl0KBWJTcCThAlrsHlkRCSZkGxs3EluNBgY
         uD/QmhMpJ9JTImbxu5a0sp3Naz5oYxYSC9zi5zRkn6S1wdNRBfI7rW8tNFYE4pkpNa+T
         cLclAC3dRzxE8RyPY/1OPx/dKSrgziqSzNUaGmTh7tBbnUhGpG/3o9hEdfBrUuh3ars4
         uixHkXh+nqSxomBh/OguWL7eM0T+NjxVLyJV8vfiP/TKuK47IA7W8sqkw1njweHZz9PV
         u2S1h2bF0pssLtM8KU4n/iYqkM3RML/Ie+4kw/OcBwx4Z+M4hVUIWa+L7FnZh5EUPm7D
         kmfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuDyJQ4DyX2VMBJPqLzH/qgZ8jub5FtS8ovDEKRA3eG9/ZYU+muxbRy9NR6Sbo3kh+oBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdphcEC8A+AmTrANbWa31oRbhk/WIgAryTS4jouOFz5+cw1Neg
	sqiOyYMAQFeSjzb3ls4obKDg+FzCRoywPNWMwYbzQqYR18uIaok95asbKMaagXhTTPdmi03lE3h
	3NcM8sOpcpyOPerSywve0CVHgfu0=
X-Gm-Gg: ASbGncv1TtCrApJD5yl+LrYBFER1BS/H9s5U+dahEbxiyiHgL0PmgDippNfUjN1qOPz
	xIfHr/aEUbHCWN8fPYc2ZNaxi/gUO+ddcA3/P3obVu9sDP3sddvyuxqqscN2ebWyo
X-Google-Smtp-Source: AGHT+IHWW+Wnjpdc7UUowCvKxVZxJ4iiJu5RnLkSBWfgVkWWYx5iTmtlU6O9ysVozn5U0fZYfZhmjxfVoUat9YqAS3Q=
X-Received: by 2002:a17:906:23ea:b0:aa6:2753:ba08 with SMTP id
 a640c23a62f3a-aa639fa4c53mr59288266b.6.1733443995309; Thu, 05 Dec 2024
 16:13:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com> <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
In-Reply-To: <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Dec 2024 01:12:39 +0100
Message-ID: <CAP01T77t=6j+dS74fOvM=72=RG054pg6+bUs2KL4ATUWxgwiDA@mail.gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, andrii <andrii@kernel.org>, 
	Nick Zavaritsky <mejedi@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Dec 2024 at 01:04, Andrii Nakryiko <andrii.nakryiko@gmail.com> wr=
ote:
>
> On Tue, Dec 3, 2024 at 1:42=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Tue, 2024-12-03 at 12:19 -0800, Eduard Zingerman wrote:
> > > On Tue, 2024-12-03 at 17:26 +0100, Nick Zavaritsky wrote:
> > > > Hi,
> > > >
> > > > Calls to helpers such as bpf_skb_pull_data, are supposed to invalid=
ate
> > > > all prior checks on packet pointers.
> > > >
> > > > I noticed that if I wrap a call to bpf_skb_pull_data in a function =
with
> > > > global linkage, pointers checked prior to the call are still consid=
ered
> > > > valid after the call. The program is accepted on 6.8 and 6.13-rc1.
> > > >
> > > > I'm curious if it is by design and if not, if it is a known issue.
> > > > Please find the program below.
> > > >
> > > > #include <linux/bpf.h>
> > > > #include <bpf/bpf_helpers.h>
> > > >
> > > > __attribute__((__noinline__))
> > > > long skb_pull_data(struct __sk_buff *sk, __u32 len)
> > > > {
> > > >     return bpf_skb_pull_data(sk, len);
> > > > }
> > > >
> > > > SEC("tc")
> > > > int test_invalidate_checks(struct __sk_buff *sk)
> > > > {
> > > >     int *p =3D (void *)(long)sk->data;
> > > >     if ((void *)(p + 1) > (void *)(long)sk->data_end) return TCX_DR=
OP;
> > > >     skb_pull_data(sk, 0);
> > > >     *p =3D 42;
> > > >     return TCX_PASS;
> > > > }
> > > >
> > > > If I remove noinline or add static, the program is rejected as expe=
cted.
> > > >
> > >
> > > Hi Nick,
> > >
> > > Thank you for the report. This is a bug. Technically, packet pointers
> > > are invalidated by clear_all_pkt_pointers() called from check_helper_=
callf().
> > > This functions looks through all packets in current verifier state.
> > > However, global functions are verified independent of call sites,
> > > so pointer 'p' does not exist in verifier state when 'skb_pull_data'
> > > is verified, and thus is not invalidated.
> > >
> >
> > There are several ways to fix this:
> > - The "dumb" way:
> >   - forbid calling helpers that bpf_helper_changes_pkt_data()
> >     from global functions.
> > - The "simple" way:
> >   - at some early stage:
> >     - scan all global functions, to see if there are any calls to
> >       helpers that bpf_helper_changes_pkt_data(). If there are,
> >       remember this as an "effect" of the function;
> >     - build a call-graph of global functions and propagate computed
> >       effects over this call-graph (if A calls B and B does
> >       clear_all_pkt_pointers(), then A also does it).
> >   - during main verification phase, if a call to a global function is
> >     verified, check it's effects and update state accordingly
> >     (e.g. call clear_all_pkt_pointers()).
> > - The "correct" way:
> >   - build a call-graph of global functions;
> >   - verify these functions in a post-order;
> >   - while verifying, collect "effects" information
> >     (so far, the single effect is whether or not
> >      clear_all_pkt_pointers() had been ever called for the function);
>
> So this is the only "side effect" we have right now? Are there any
> others we have already or can reasonably anticipate? I'm just trying
> to decide if we need to generalize this concept.

It would be good to generalize, we can use such "effects" or
"summarization" to also know whether a global func is sleepable or
not.
This would allow lifting the current restriction of calling them from
atomic contexts seen in verifier state, right that's the only thing
that's preventing the call. So it would be a nice side benefit.

>
> >   - if a call to global function is verified, check it's effects and
> >     update state accordingly (e.g. call clear_all_pkt_pointers()).
> >
> > "dumb" is probably a no-go as it is too restrictive.
> > The only advantage of "simple" over "correct" that I see is
> > that the logic for clear_all_pkt_pointers() remains confined
> > to check_helper_call() and is not duplicated in a separate pass.
>
> "simple" doesn't take into account dead code elimination, undermining
> BPF CO-RE-based feature detection, so I think this is also a no-go
>
> > In theory, this also allows to compute more complex function effects
> > on the main verification pass.
> >
> > I think "simple" is a way to go at the moment.
>
> I think neither of the above are fully valid, tbh. "correct" will do
> eager subprog validation, even if due to dead code elimination that
> global function might not have been called.
>
> From the outset, I think the "right" way to solve this would be to
> start verification from the main program. When we encounter global
> subprog verification, we pause verification for the main program,
> create a new isolated verifier state, proceed with global subprog
> verification, and so on until we check everything. So basically a
> stack of subprogs to validate.
>
> This is PITA, of course, just for this (which is also the question
> about the generalization of the "side effects" concept). So I don't
> know, maybe for now the "dumb" way is the way?
>
> >
> > Alexei, Andrii, what do you think?
> >
>

