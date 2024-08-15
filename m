Return-Path: <bpf+bounces-37319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58A5953D2A
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354901F264B8
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA9E1547C0;
	Thu, 15 Aug 2024 22:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atERHpg9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982EB487BF
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 22:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723759758; cv=none; b=U5Tir2hke+O0I5VRH9m5laUoZE3Fc7TqMdvfqIS6Wjp5H1Jb9ocEPLbVaUysR4rMGcH4UQIkPLWYl5OcfyPouuNFAgzIOzx6jAjLFyXvzjhRk/iLhQ1CGxIRLxnkGz2+zHXD/2eLzM0pA8coSSAiMZz8NE//WaCJSqwJ0dzpWm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723759758; c=relaxed/simple;
	bh=uEJ4o/9qt3/9KimYgPDy+Z7GsAbQ/ybiPpIhqe4tkRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ViV2OcXjawPWxI1+519eot0h0SooE8wjPmHTrUC87rz/GsVEB4DAADjlSuCXTsJ7LNacw2dp7wWPe0vUqiZQ7SPx0fJ4rQ8hi8KpUftO318QcU2phqnkM/zwv02k/gzUzC38clG5KQ/ha1m5deEd+fQQEVf2zVooS5wMitd/P7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atERHpg9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-201ed196debso13151145ad.1
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 15:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723759757; x=1724364557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqXO3bIkPM3S2nPE5R5OHFKdWFYNHJE+M5pRj53PwgA=;
        b=atERHpg9Q7pd54VJTEwEaSWKSFHCoKdUb1Hij+ey2CqUr5vWjsm+uJPS51T87vhhop
         ATPE77OhKEkMW8yrfdJeFI06u1L36Yxq6EBexStJYYdb2skncxS9NNr+bTqWC8NKKyOx
         HfVB+me/l+ImFrPE7y4EfH3E3HgzKlCWlxZVadcXmWY68WYIFGSUbhnZG3xOkmkBU3zW
         MBo/S+E0ZZAvWCyhwaD7lXxDYQyeZIr9laCo6ewZ1rm/Y0P8KAckqn49sQaqrdrgDJ4b
         qUk4bwDilVAlo/7IiouRHVMuLQQm4O4Vowj+NHb/NEsHOES1KS2FtmmfBn+Ejo7PhSsb
         c7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723759757; x=1724364557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqXO3bIkPM3S2nPE5R5OHFKdWFYNHJE+M5pRj53PwgA=;
        b=YNX3vcFxl4sdqsyywBbLl+1T/QJEDLYR2m4cvvXQ48Hn4ATdnGi/ka0LaV2Ef7j1SV
         USrJjJDzGIn2EYNTlS3y+Lh95GxhkQrVr0xvtZ1iaozefW/G7mJZ4lCTAxurlgVFFPbq
         ow/V7gDSb+nmQAChDOmmTbAMQ5L/YooylC034uyeLHKJDjJtYJAY5YH4CQGSmFwvkYVi
         lcc7DGiFLqfhsBSSrhl4P1Rudr8Ag4c5Vh8eknyR72sb0Z266E7lgI3rMxisroHA39pJ
         onHI7Qtnk4GcT5pmydoSV5hmpg0mX++8kfOS9Iyo2c/EOZxyyXwN6OCKxtqEaSfnxt6W
         +Opg==
X-Forwarded-Encrypted: i=1; AJvYcCV9DNiGN5OkJG9ZURaXsialv4kijd5of7wI8RHk1UXSFOmVMdomPCDZ/pLiZzgA/7jQF2EOH9ZU1/kfQgJ5kAMspEAu
X-Gm-Message-State: AOJu0YyR4SOnt7CDY/6/GY3uTIzJhKKyQ7lF+L+jbTrRD1FNPPmJlTHr
	J8hKZ7IuUQd/J1Zpx8eSDCCijuWGtg5DAbBw3mpD5KrU5uHVummWFJU93SsKU7yeNW4iwRDhPAm
	hMHwzMedlpQaY/BO8ogFbNaBvVRo=
X-Google-Smtp-Source: AGHT+IFMIO3m74ns2graKokc2UMHPk4+/ELOu0OgXQnQZgNwnaObDAIC2MTDSEpCH5f5l6br61joNsHdysXUnALwSmA=
X-Received: by 2002:a17:90b:3714:b0:2c9:63ef:95b9 with SMTP id
 98e67ed59e1d1-2d3dfc66dafmr1210604a91.14.1723759756855; Thu, 15 Aug 2024
 15:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809010518.1137758-1-eddyz87@gmail.com> <20240809010518.1137758-5-eddyz87@gmail.com>
 <78d7872d-4644-4a9a-9ef2-f4823fd7944f@linux.dev> <f49cc01dfea19be0d287995e8bb539a14dd31cf1.camel@gmail.com>
In-Reply-To: <f49cc01dfea19be0d287995e8bb539a14dd31cf1.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 15:09:05 -0700
Message-ID: <CAEf4BzbB+mhUO754io-qJXcdpYdfYF0G-LdamRAWLsdYsbptvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: validate jit behaviour for
 tail calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, hffilwlqm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 2:47=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-08-15 at 14:32 -0700, Yonghong Song wrote:
>
> [...]
>
> > > +__success
> > > +/* program entry for main(), regular function prologue */
> > > +__jit_x86("        endbr64")
> > > +__jit_x86("        nopl    (%rax,%rax)")
> > > +__jit_x86("        xorq    %rax, %rax")
> > > +__jit_x86("        pushq   %rbp")
> > > +__jit_x86("        movq    %rsp, %rbp")
> >
> > How do we hanble multi architectures (x86, arm64, riscv64)?
> >
> > Do we support the following?
> >
> > __jit_x86(...)
> > __jit_x86(...)
> > ...
> >
> > __jit_arm64(...)
> > __jit_arm64(...)
> > ...
> >
> > __jit_riscv64(...)
> > __jit_riscv64(...)
> > ...
>
> ^^^^
> I was thinking about this variant (and this is how things are now impleme=
nted).
> Whenever there would be a need for that, just add one more arch
> specific macro.
>
> >
> > Or we can use macro like
> >
> > #ifdef __TARGET_ARCH_x86
> > __jit(...)
> > ...
> > #elif defined(__TARGET_ARCH_arm64)
> > __jit(...)
> > ...
> > #elif defined(...)
> >
> > Or we can have
> >
> > __arch_x86_64
> > __jit(...) // code for x86
> > ...
> >
> > __arch_arm64
> > __jit(...) // code for arm64
> > ...
> >
> > __arch_riscv
> > __jit(...) // code for riscv
> > ...
>
> This also looks good, and will work better with "*_next" and "*_not"
> variants if we are going to borrow from llvm-lit/FileCheck.
>

shorter __jit() and then arch-specific __arch_blah seems pretty clean,
so if it's not too hard, let's do this.

BTW, in your implementation you are collecting expected messages for
all specified architectures, but really there will always be just one
valid subset. So maybe just discard all non-host architectures upfront
during "parsing" of decl tags?

> > For xlated, different archs could share the same code.
> > Bot for jited code, different arch has different encoding,
> > so we need to figure out a format suitable for multiple
> > archs.
>
> I'll go with whatever way mailing list likes better.
>
> [...]
>

