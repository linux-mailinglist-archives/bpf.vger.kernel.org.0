Return-Path: <bpf+bounces-74614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A8BC5FD7A
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B3524E1FE3
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 01:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0FC19F464;
	Sat, 15 Nov 2025 01:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVZJyPhh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B392AD32
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763170781; cv=none; b=C6vurMc729QIrE7fFDSwjaVKEFxeT8+eY89Ci+yRVti83T7SAoYEWXreQdwZbWksPkoLndmARNSLfUGWxMg+8g3690EOMNogUceP63ePY3f7Jz2z0fymLpvvCBt+FzuOLiXX/gdGHgkYH8A97YjvLHs3jpQ4VkxxOjEdEwNLnlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763170781; c=relaxed/simple;
	bh=XqTLHUw6EGSd5UzXBq5uLo+heHnhjRtuAXeLTNmDDZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jeaxRl+b/oRVPXFKaiS53ugSDUd//p5xXkmriBYYfuPvj0PpLYbQSdG+aBZEoyHhNky1+GTU+G2PdP/1vL9MrlR8k2FIFkWA2EhX5wQY1dqSkAGsbIPRTW7stmf0qXImMCjn9NIQq9NBOQDN1WaJWfIzAVi7kcUs+pXMiaB572M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVZJyPhh; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3108f41fso1445378f8f.3
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 17:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763170778; x=1763775578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKTa7UKdXZcDnvNUJQr5+1bPvcqDUrHZO3Dlk8/+37o=;
        b=RVZJyPhhrQwFbqUsu2SZdTkYZNu0A4qS0e3Mur9JsEROkSn1RCBOPgtaNm18syeHyj
         HN6A/PhwAuL9ASD0TmWTShnTEtxm4BxCqcUUzNsrQZpp/1BQIGD51haCtejfWmRkoyEt
         gcVgpUV8HKMTFD/rVhOGUCBG+06B6ZVyq8cFKl7W7WBcyofMTLIQDt7XTHR4qEwN443S
         Px1KDLRp3LfwdLsvMR5HmvDeVxgsUlbXHJtwrhehqCd/bJqOHfqZ8+0G+ziG9edoanGP
         78cIEilKF3hfRpZBhN9UTikBqrwhoRanjsSi82hEOTkxjk8L5N2m3ir+Me73VWmC1eUx
         BxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763170778; x=1763775578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rKTa7UKdXZcDnvNUJQr5+1bPvcqDUrHZO3Dlk8/+37o=;
        b=sb1FO5ebftkfjHqCL1/dzK8xDcSLbUuAgfUHCka97nqtSdAgbuvj3dZNJp9paGbHrO
         s8wWhYSDbeNBUF4w1ETijoIUVOuOf56yfJQZt9g9cc6o4kx+MCg+pAtnVRftqLx0UW8r
         fL3LicgoAWa1dSh5rUvWY4NdVxTMnzPSxoQtO5DjiRtegM3F4rGn9Kcxdma2nKc7oXYv
         m6Cguk0X59+fVGAdQyEObk55Wq4CDTSWuKIKQM6mvhURWMZ0HCcMUVhuavzRL5jfMwbf
         GiqoZqJJivEqk6QGidRlM8r0FgIowfueGpxQy674HiZp4G002a4NT6X8pwUaQ8XnVp03
         +G7g==
X-Gm-Message-State: AOJu0Yzx8rbkBE1opVYvigjxwjFiNoijT06pzE09TyAq3n145wgbvIow
	9nDV5Wzcv+OOz7HpbaJla72rTZRD2suYRpVTvDIbeLm83j1Fnj6uJXmvrzIDxmyrO9b+gkHI99K
	fCxYhCREXdzmlGSP9qMifgkMZUM8DPrI=
X-Gm-Gg: ASbGncsiEigYYnzpSTMRUc5WxzVL+VgE47qOjFHijLuTE1k425qb9Ei4b2AeKn5Qdsd
	Wd2IqcfYouc9uLj6Mg7SGLZbwO9nVewlKIvdaKT5NhU0Rd1JiXZKYSN/ffctL2h0XgM18xbvBg0
	ok6moUSqd2U/Ruq2girS4Zy372mK1qqqnSSxgGdixA3X81q5NBukOtEiXZB+XwQiDjZxt5YbSv5
	oK4Dw12IgK09L9cY3qRgCL6ZxovOohO5OTfdHBmOji0xo1vTbOuqH+ry21FwHfzREZbbOcUfYPT
	uwlYAsZRCavELUaHMWcZy9OySdEFmXBXp3OI92jdAmik0KLEIg==
X-Google-Smtp-Source: AGHT+IFqn/S8GFl7PTqh038f7AZ7hspd/BnAlS0ICp1c8QzoDh+kNYzEgJiqhxsXDW5OwLooSQChB03aZxpCjzLxdgE=
X-Received: by 2002:a05:6000:2008:b0:429:c450:8fad with SMTP id
 ffacd0b85a97d-42b59396f60mr5031087f8f.53.1763170778380; Fri, 14 Nov 2025
 17:39:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114031039.63852-1-alexei.starovoitov@gmail.com>
 <20251114031039.63852-2-alexei.starovoitov@gmail.com> <55fb1a1f8d976e30dbaceff6f07b9e661cdc77f1.camel@gmail.com>
 <CAADnVQJB3BbspTWzqi=D7WqkwwuCiQL+es=LVhr=i-uYfJaBdQ@mail.gmail.com> <a99a127ad59926581ad8e12194b644bad59c37ad.camel@gmail.com>
In-Reply-To: <a99a127ad59926581ad8e12194b644bad59c37ad.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 17:39:27 -0800
X-Gm-Features: AWmQ_bkwQ-sPwUeoSaGxgerzpm3cfwuCq6CM9JbzclDb-EKVzldhS5Xixg20cyU
Message-ID: <CAADnVQKuWLZ7RpCF8ErmeHZeMS8shgS4FLLzJ2d7PzxX1nWaiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for s>>=31 and s>>=63
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Hao Sun <sunhao.th@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 5:36=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2025-11-14 at 17:32 -0800, Alexei Starovoitov wrote:
> > On Fri, Nov 14, 2025 at 5:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Thu, 2025-11-13 at 19:10 -0800, Alexei Starovoitov wrote:
> > >
> > > [...]
> > >
> > > > +SEC("socket")
> > > > +__description("s>>=3D31")
> > > > +__success __success_unpriv __retval(0)
> > > > +__naked void arsh_31(void)
> > > > +{
> > > > +     asm volatile ("                                 \
> > > > +     call %[bpf_get_prandom_u32];                    \
> > > > +     w2 =3D w0;                                        \
> > > > +     w2 s>>=3D 31;                                     \
> > > > +     w2 &=3D -134;                                     \
> > > > +     if w2 s> -1 goto +2;                            \
> > > > +     if w2 !=3D 0xffffff78 goto +1;                    \
> > > > +     w0 /=3D 0;                                        \
> > > > +     w0 =3D 0;                                         \
> > > > +     exit;                                           \
> > > > +"    :
> > > > +     : __imm(bpf_get_prandom_u32)
> > > > +     : __clobber_all);
> > > > +}
> > >
> > > Tbh, I find this test case a bit more convoluted then necessary.
> > > I'd use smaller constants, removed the 'if ... s> ...' and added some
> > > commentary, e.g. as below:
> > >
> > > SEC("socket")
> > > __success
> > > __naked void arsh_31(void)
> > > {
> > >         asm volatile ("                                 \
> > >         call %[bpf_get_prandom_u32];                    \
> > >         w2 =3D w0;                                        \
> > >         w2 s>>=3D 31;     /* w2 is in range [-1,0] here */\
> > >         w2 &=3D -2;       /* w2 is either -2 or 0 here  */\
> > >         if w2 !=3D -4 goto +1;                            \
> > >         w0 /=3D 0;                                        \
> > >         exit;                                           \
> > > "       :
> > >         : __imm(bpf_get_prandom_u32)
> > >         : __clobber_all);
> > > }
> >
> > Come on :) Now you're nitpicking on constants and extra 'if' ?
> > I'll keep the original, since that's what it was in the code,
> > and will keep __retval(0), since yours doesn't clear w0.
>
> I did the same for other test cases. My mind breaks when I try to
> figure out what's going on with -134 and 0xffffff78 and why s> -1 is
> important.  At-least please add some comments.

We have other asm test cases that were copied verbatim
from llvm generated code. I don't think it's human's job to
clean them up to a minimal level. Perfect is an enemy of good.

