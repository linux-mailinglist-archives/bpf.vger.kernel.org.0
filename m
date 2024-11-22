Return-Path: <bpf+bounces-45437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9E59D56D0
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 01:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA49DB21446
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 00:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BC35223;
	Fri, 22 Nov 2024 00:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuP57TFB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9EC2309A3
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 00:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732236181; cv=none; b=KlrawzeHCdsCmYa2z+tPLigJPiFeHuSGZCdX8LGREwnqUXU8jYyDtrzbOBpe+hE7FDauBLlYuiiPezuw14kjI1XJAxDUjXrpHx9zZmkViujlsrYacTpF/NCXkWMgOBAyxGkry4YOxsRMx3VCOvPIltBqEgh/7B7ObeOwS8t1Zgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732236181; c=relaxed/simple;
	bh=Mk/LRvr/HKRWNEJJRXTr7BBRuGP+/N6Vg2sM0mrVhEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tk19Eeqg7KXTebqM2NNHxjerJEaqIvp64FoakdMqByQB+3bQwVJZ6e866fgAxvk6MNx2gJnK4yOqXB1M4x78bTFh689aHRo707hX+MhyR8O20i8aPDQqgDrHIQuU+ni5NVpQvhK0OGjONl9Tv7/NdoaqBRNlLwu1FAj27qwfmBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuP57TFB; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a9e8522445dso230165866b.1
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 16:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732236177; x=1732840977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Omc+drJkkOz37GtYY7+VG1GACjAPouunz+VsbqkZXgg=;
        b=RuP57TFBBnvrIaGds7NogiB7ayyvEAriNm4SR3WQzs8ue525UBlNuUUpbE2Wq7JHCZ
         66a5XOayqmQrpzna+5AW5o2N4lcS27cuC2Ji6dQUYPodq9CVzYxDMiemiTrRJcuebd6n
         oyuugz8FaBdh01RhjuW5yEAYMsGRZ/kFjItDbYFdxR2iXTzc60nzP6L2xxgWTMeZaM3p
         wmqWWilP3V5zFJ0xAgeRMmTU9boAcU2ZyG8PJGLyby7+ESFKbqOA0YnR4tMt345GVyJO
         LflHVk307cr23s2uZtWV7BxwTzvCrsm2hklTn7DJZv2gbBMwTfSHWuMCfIa+MLOQKOtw
         wg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732236177; x=1732840977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Omc+drJkkOz37GtYY7+VG1GACjAPouunz+VsbqkZXgg=;
        b=GejkoPJOC8QAUy1mxiZEcCBei3xZLsIBADswyaFuN8OaySIG3oQA7mxtCsGDMOMPvo
         MqRUsUgISrYpr70nl0KlbcxOd0zO8qk+Cs5XXEx1zZYsUwmQNI4MpsGGvG8cpKKXKdNG
         71t30L8AS9Z6l53CqcMW/1fYzNdL2pyjnolAmpAcYiwYmCNIghG9hIIvZTue/1RvdBxh
         pwKTtuov0Ck3fJ6fb3Py2nJjmnDWSgAg67AKOnNCKam80IyAbwagLj0OUb1Dm883Zst/
         M0azwseP1ufcDL9KDhAxC1b4W0nLnAGNnzm1+t15NGZFB15uisWC4qv1naMKlDoRbRNy
         ZtnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiBPDCpSJW7EhtvDBzeIjkbMqbPfyu0uaZUJlUh+xFkGoUqK75rkQq1LFkCr5tOl+soOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH5f9xJFjyzqVY8bRsLMHQKfuZ4EtPsav1jNBAa7nEaCsJHIru
	1yjazxKM0LCWxObolvEhHh7Cm/qk1FsKp35dK7HaYVz3/lrGe//a2RkERDqcVKgLf23ecyaNd9m
	cDH5lNIQTo/ZhPxUwHWbIXCHOIbzk+Yn4ih0=
X-Gm-Gg: ASbGncuBAGm5Pi8S2wdSAPx6428aFP/kDnJSwZQhYhWOKfQUzbc88TkKSL67IOYkAtO
	JerBI/ZoEiaDEcjFy2AktcF0yWGw8Qv+O6w==
X-Google-Smtp-Source: AGHT+IF1LtAXdjsLgl2T0qUlaB2PAmp96nXJsSuhFDewIg4GlrLkpzhIJ6omAIuIwNg/+wJkXoVQqphtCNKQhHui+0M=
X-Received: by 2002:a17:907:7845:b0:aa5:1617:c162 with SMTP id
 a640c23a62f3a-aa51617e2c0mr9669466b.17.1732236177330; Thu, 21 Nov 2024
 16:42:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121005329.408873-1-memxor@gmail.com> <20241121005329.408873-6-memxor@gmail.com>
 <c49e756f6e4ef492a68b7cd3b856240282963f8e.camel@gmail.com>
 <CAP01T75FEfodis5YLie5kBPG4FSyyinSAa0m+ZP8H+_PhseWRQ@mail.gmail.com> <CAADnVQKenFC_pRBd2Erb=OBO9R+CPnxiz8krsgkFHNNm84ERvQ@mail.gmail.com>
In-Reply-To: <CAADnVQKenFC_pRBd2Erb=OBO9R+CPnxiz8krsgkFHNNm84ERvQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 22 Nov 2024 01:42:21 +0100
Message-ID: <CAP01T75MbkyYx8YfCivo6jEXByxgVw3UENnj=XayLnE-QRkhvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/7] bpf: Introduce support for bpf_local_irq_{save,restore}
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, kkd@meta.com, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Nov 2024 at 01:32, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 21, 2024 at 2:07=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Thu, 21 Nov 2024 at 21:21, Eduard Zingerman <eddyz87@gmail.com> wrot=
e:
> > >
> > > On Wed, 2024-11-20 at 16:53 -0800, Kumar Kartikeya Dwivedi wrote:
> > > > Teach the verifier about IRQ-disabled sections through the introduc=
tion
> > > > of two new kfuncs, bpf_local_irq_save, to save IRQ state and disabl=
e
> > > > them, and bpf_local_irq_restore, to restore IRQ state and enable th=
em
> > > > back again.
> > > >
> > > > For the purposes of tracking the saved IRQ state, the verifier is t=
aught
> > > > about a new special object on the stack of type STACK_IRQ_FLAG. Thi=
s is
> > > > a 8 byte value which saves the IRQ flags which are to be passed bac=
k to
> > > > the IRQ restore kfunc.
> > > >
> > > > To track a dynamic number of IRQ-disabled regions and their associa=
ted
> > > > saved states, a new resource type RES_TYPE_IRQ is introduced, which=
 its
> > > > state management functions: acquire_irq_state and release_irq_state=
,
> > > > taking advantage of the refactoring and clean ups made in earlier
> > > > commits.
> > > >
> > > > One notable requirement of the kernel's IRQ save and restore API is=
 that
> > > > they cannot happen out of order. For this purpose, resource state i=
s
> > > > extended with a new type-specific member 'prev_id'. This is used to
> > > > remember the ordering of acquisitions of IRQ saved states, so that =
we
> > > > maintain a logical stack in acquisition order of resource identitie=
s,
> > > > and can enforce LIFO ordering when restoring IRQ state. The top of =
the
> > > > stack is maintained using bpf_func_state's active_irq_id.
> > > >
> > > > The logic to detect initialized and unitialized irq flag slots, mar=
king
> > > > and unmarking is similar to how it's done for iterators. We do need=
 to
> > > > update ressafe to perform check_ids based satisfiability check, and
> > > > additionally match prev_id for RES_TYPE_IRQ entries in the resource
> > > > array.
> > > >
> > > > The kfuncs themselves are plain wrappers over local_irq_save and
> > > > local_irq_restore macros.
> > > >
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > >
> > > I think this matches what is done for iterators and dynptrs.
> > >
> > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > >
> > > [...]
> > >
> > > > @@ -263,10 +267,16 @@ struct bpf_resource_state {
> > > >        * is used purely to inform the user of a resource leak.
> > > >        */
> > > >       int insn_idx;
> > > > -     /* Use to keep track of the source object of a lock, to ensur=
e
> > > > -      * it matches on unlock.
> > > > -      */
> > > > -     void *ptr;
> > > > +     union {
> > > > +             /* Use to keep track of the source object of a lock, =
to ensure
> > > > +              * it matches on unlock.
> > > > +              */
> > > > +             void *ptr;
> > > > +             /* Track the reference id preceding the IRQ entry in =
acquisition
> > > > +              * order, to enforce an ordering on the release.
> > > > +              */
> > > > +             int prev_id;
> > > > +     };
> > >
> > > Nit:  Do we anticipate any other resource kinds that would need LIFO =
acquire/release?
> > >       If we do, an alternative to prev_id would be to organize bpf_fu=
nc_state->res as
> > >       a stack (by changing erase_resource_state() implementation).
> >
> > I don't think so, this was the weird case requiring such an ordering,
> > so I tried to find the least intrusive way.
>
> Acquire_refs is already a stack.
> Manual push/pop via prev_id looks unnecessary.
> Just search the top of acquired_refs for id.
> If it doesn't match error.

Ok.

> I don't like this bit either:
> + if (id !=3D state->active_irq_id)
> +               return -EPROTO;
>
>
> Why invent new error codes for such conditions?
> It's EACESS or EINVAL like everywhere else in the verifier.

Ok, though we do use EPROTO in a bunch of places. I just needed
something to distinguish the two errors.
I'll switch to these.

