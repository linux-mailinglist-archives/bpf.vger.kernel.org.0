Return-Path: <bpf+bounces-45435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0170C9D56C2
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 01:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CC82B217A8
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 00:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF13469D;
	Fri, 22 Nov 2024 00:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg6XUcd6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D011853
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 00:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732235576; cv=none; b=VwcFh/QtUD0kOtclVT/8LcqAeSmgEWJdlufLsSKAGdaQKxlWWmbM+Rjm91N2/WvXoAWhWYpXJ3AkxhJkAj245H9zpLgFck9B9uTheSFornHuu65aIw9+HHI/vi8XJ+lWKKuOpGcGZJfn+qlOwQV03w5TYcakMQW3H1ZLStNIzN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732235576; c=relaxed/simple;
	bh=ElSsttoFn2tGSNq82VTCshnhAkd6hfWiXA+i8XzFziM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcTuwbiWEFNJK/Fq06L8ytvVOLZD78w74w51MO5wyfYH3uVG07abaurMTdqSZEj9Ut+BUnGemII/Bz31jwS3+hiC0i/0Ny6hgI/875SrdX/zEo5jrDoJgLVrLhHDtthC1wU2JADV9fO2TOy5sLyJQhbk9X6MoMKwJ/iYCIrVkbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fg6XUcd6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43193678216so13931345e9.0
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 16:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732235573; x=1732840373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RL1lgmMyWO+nl8XA8JUiAgLOBzU7S7bZemUo2gpmwro=;
        b=fg6XUcd6aOVLel6zZVHI1q+EPy0uAH2kMDMeJ3YiqM2r4YrzMAObIb5dLSf9cl40i1
         UXkUpJp1heZ4eHhgsvLRNmIlGsjR7iFunBeLihgILvc/l2iTb8R4Fc0p94xt+HDuw4i5
         2+b6Yrw0ps9U7rYMAj7WCUqVruRrRynPV7Gdg/v86rSsq3GOGT2deGPjjXSjd1tZSYvh
         bwuWcWTvaPkKx3wiI/B1J5sNXyl3SkLSsBtMUYKs0zK0YjZiJrmn6b6jTrzZx+xoXicD
         U1cjBtiPnqkymzZNQD4VyrxPYC7be9TxRmA+MjvG0LW/kNuDepcRLHOaqGQHWMPvoSGX
         in/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732235573; x=1732840373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RL1lgmMyWO+nl8XA8JUiAgLOBzU7S7bZemUo2gpmwro=;
        b=HhQoMTCYeTETMglo0U0qyLdo++Fe6jiV7fczhFEp/jFF2XUSnZfURvg2l5fF/BemqH
         xYOdIpGcOTVmGKZDP7db82nukAKsLKOMbGzfKFxbdCQygkw36R+42LUV5WmvEuQbth7Z
         aZElmrEFanejWFWvs+S4YNd028NzpXegyST75fTe791S+37lCOxMgvrU90thtq/y7aoi
         L/iVuGr/LtEeRgeTpZMhkH3EhZnLU2G09gPaKkI2Ost+UWZ0n/tLmD7WQ7P+JJP5E4u2
         pK+M46bxo5Y+UOm2cA2W9m8ods0SwURtlS57j7tML4spQ28FufecIjrM4dzqBUoSR6TH
         AtRA==
X-Forwarded-Encrypted: i=1; AJvYcCXWuOJWbhXg+7DyvgeSG2GR/npDdZS/OsSJJJUzFkXTK2aKhu9G7gXk6u0Fu15GlP9jRlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6n+Wn8Ijca6juaUe4Mml95iJbhNYITqjdq6hlk/a40S+XjFmf
	bpg0L2qAVZb0FJuqLjx41W8YIElKjhIvZN8G9HmV9MG9GwWTYKoS6DDhWEbTQuL6Xu+o7R2HQAa
	8KbcRPHzYSu4ZYa6MnkUp8vlfk28ytOmo
X-Gm-Gg: ASbGncsa25h1BWQRWNauZIoNSg7wqWrc2Y6+pxvLI7QErkePiwMMYh3gc+1xQdYqiFK
	43dnzceKiWIQo0fYOGQ46YMfpFVen4Q==
X-Google-Smtp-Source: AGHT+IGDIyEZHWzdBCUSs65vxG8YUr+XuN7mp2AGAkhG7rc6lHMPOXUtnoud6YH4HMj475XcrNFkre3MkYHKctklXcs=
X-Received: by 2002:a05:6000:2ce:b0:37d:446a:4142 with SMTP id
 ffacd0b85a97d-38260b867a5mr726295f8f.32.1732235572462; Thu, 21 Nov 2024
 16:32:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121005329.408873-1-memxor@gmail.com> <20241121005329.408873-6-memxor@gmail.com>
 <c49e756f6e4ef492a68b7cd3b856240282963f8e.camel@gmail.com> <CAP01T75FEfodis5YLie5kBPG4FSyyinSAa0m+ZP8H+_PhseWRQ@mail.gmail.com>
In-Reply-To: <CAP01T75FEfodis5YLie5kBPG4FSyyinSAa0m+ZP8H+_PhseWRQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 21 Nov 2024 16:32:41 -0800
Message-ID: <CAADnVQKenFC_pRBd2Erb=OBO9R+CPnxiz8krsgkFHNNm84ERvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/7] bpf: Introduce support for bpf_local_irq_{save,restore}
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, kkd@meta.com, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 2:07=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Thu, 21 Nov 2024 at 21:21, Eduard Zingerman <eddyz87@gmail.com> wrote:
> >
> > On Wed, 2024-11-20 at 16:53 -0800, Kumar Kartikeya Dwivedi wrote:
> > > Teach the verifier about IRQ-disabled sections through the introducti=
on
> > > of two new kfuncs, bpf_local_irq_save, to save IRQ state and disable
> > > them, and bpf_local_irq_restore, to restore IRQ state and enable them
> > > back again.
> > >
> > > For the purposes of tracking the saved IRQ state, the verifier is tau=
ght
> > > about a new special object on the stack of type STACK_IRQ_FLAG. This =
is
> > > a 8 byte value which saves the IRQ flags which are to be passed back =
to
> > > the IRQ restore kfunc.
> > >
> > > To track a dynamic number of IRQ-disabled regions and their associate=
d
> > > saved states, a new resource type RES_TYPE_IRQ is introduced, which i=
ts
> > > state management functions: acquire_irq_state and release_irq_state,
> > > taking advantage of the refactoring and clean ups made in earlier
> > > commits.
> > >
> > > One notable requirement of the kernel's IRQ save and restore API is t=
hat
> > > they cannot happen out of order. For this purpose, resource state is
> > > extended with a new type-specific member 'prev_id'. This is used to
> > > remember the ordering of acquisitions of IRQ saved states, so that we
> > > maintain a logical stack in acquisition order of resource identities,
> > > and can enforce LIFO ordering when restoring IRQ state. The top of th=
e
> > > stack is maintained using bpf_func_state's active_irq_id.
> > >
> > > The logic to detect initialized and unitialized irq flag slots, marki=
ng
> > > and unmarking is similar to how it's done for iterators. We do need t=
o
> > > update ressafe to perform check_ids based satisfiability check, and
> > > additionally match prev_id for RES_TYPE_IRQ entries in the resource
> > > array.
> > >
> > > The kfuncs themselves are plain wrappers over local_irq_save and
> > > local_irq_restore macros.
> > >
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> >
> > I think this matches what is done for iterators and dynptrs.
> >
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >
> > [...]
> >
> > > @@ -263,10 +267,16 @@ struct bpf_resource_state {
> > >        * is used purely to inform the user of a resource leak.
> > >        */
> > >       int insn_idx;
> > > -     /* Use to keep track of the source object of a lock, to ensure
> > > -      * it matches on unlock.
> > > -      */
> > > -     void *ptr;
> > > +     union {
> > > +             /* Use to keep track of the source object of a lock, to=
 ensure
> > > +              * it matches on unlock.
> > > +              */
> > > +             void *ptr;
> > > +             /* Track the reference id preceding the IRQ entry in ac=
quisition
> > > +              * order, to enforce an ordering on the release.
> > > +              */
> > > +             int prev_id;
> > > +     };
> >
> > Nit:  Do we anticipate any other resource kinds that would need LIFO ac=
quire/release?
> >       If we do, an alternative to prev_id would be to organize bpf_func=
_state->res as
> >       a stack (by changing erase_resource_state() implementation).
>
> I don't think so, this was the weird case requiring such an ordering,
> so I tried to find the least intrusive way.

Acquire_refs is already a stack.
Manual push/pop via prev_id looks unnecessary.
Just search the top of acquired_refs for id.
If it doesn't match error.

I don't like this bit either:
+ if (id !=3D state->active_irq_id)
+               return -EPROTO;


Why invent new error codes for such conditions?
It's EACESS or EINVAL like everywhere else in the verifier.

