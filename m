Return-Path: <bpf+bounces-32312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A6B90B613
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 18:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C32F1C2320F
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 16:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC801798F;
	Mon, 17 Jun 2024 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDktvP4c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DE917BA4
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641077; cv=none; b=fH8EdAKl3xh+LGbLeZdOKreKu8lniLInibodn/hYH22WkFlM+iD/Qv5z/TKqcixGK1+gUAtV1+DiWX0sobHWh2/ppK0BlBpQ0NkeFp3ac10GOxS6h3zwuGo1leE3+bSc7APeDoND5/XXTfV1EBKnpu+9kFceElGNIrW2N9QbDTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641077; c=relaxed/simple;
	bh=qMCfS0G7fZ75Wfzv8pPsxiiFoiN1YgacotFvokOcqDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K49ZjQZrQttXFuVto9fOk5VAQzCvAqGH+RDBvjtut/2C6GeY4vgz0dS+0uz7kd1HnQdFlXA4PeNaCqh7+BHyGSy8u8ude0sOBJJpDexf0WqbmmvwH76R9GKvAZZD+jWrT4/hq7mW9Z7ZeponXeqRUiV3d0KXAQby/SnxjuRXk70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDktvP4c; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-421d32fda86so47233955e9.0
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718641074; x=1719245874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijHqb4PwTbbvt9UJwNzjX0AorXhcentPV68tHk7o8Is=;
        b=BDktvP4cw+u9GEHXdSHAZ0Rt75LsmemOoU8sGIzgj7XhjyYL8O0aSJJpgt7pOb0oWz
         I2WBry9UxZyMlUTNzZkVIv7I+Rhw7nWNSw8bhDQ+OjOCXoMcibzkMAmWZ6QYE+0sxTf6
         9+dW7NEB098KZqelCQeAiMnjiZGfSTpjor3vVgLNPcAscL0yH4y+pMLoo3iiW9bV2h0N
         FmYcJhHMzkWEJUDdUECfZD/wu31ZG7zQumBSQkFlYxr2U8ygEZRfDRq5jkRt/NHEvV3w
         q2u5+RnxC754i1JHe7WlxwnsOARxvZGR7NVCgkoX/Zce1CnbiwvviA8GBG2RxfbdH3Xa
         T4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718641074; x=1719245874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijHqb4PwTbbvt9UJwNzjX0AorXhcentPV68tHk7o8Is=;
        b=Jmu/AvR9wvGHCUDt37wHwaUenPEoyR+XuqifOTa58PcLfq5MLkxzjv+G7Ae2ckVIuP
         PV7qCdHTsMuhK/sTLCALRMZ9gFzvvVuA6gZ2mUikGrrfCWIYlY9o/Q6uTtm8qWPmJRtC
         lxrc29mG8PXKDVV/i8AVY6wpDabCRTLtncRCIFfIqQNzJqFG+Dzj51M0TxaqlMpVS0Xt
         O7xWP7oS0sUKiEGH+8iRJKXeu1KvDV5c67CNgpdeQ1TxoXO8nUaL9oyZKx69Pf8e7ubT
         QlGD+otI7DNBtbzEDLAa6eBTJ/vE19Eetz7eg0q2BIClKBHmm19su0A7fw1fbX17xfA3
         /EaA==
X-Gm-Message-State: AOJu0YwgnoMz7aE5fnEqsOSlTPGhA1JJflXvqGn70KA/1r+RcA+iC7Me
	9hRkVuoteR2IClnvFxZ6fPAjWNECKCuQkw3jmmCFn12kxEThnQyzs5Z7Bmekcqu6KzncRx2F74o
	XiZ0+Muj7xzKSBlNA+iRsQkGsu5M=
X-Google-Smtp-Source: AGHT+IHoPcoASXBuS4VfzdgyWTlQZ9XHBYYWbhaQ+/ijJCPQYCuLf7L+g3oxL0Ypqjc/j2kNTwIOuWmiEkTEGNOBQwg=
X-Received: by 2002:a05:600c:17d0:b0:423:b5f9:203f with SMTP id
 5b1f17b1804b1-423b5f92170mr52756045e9.5.1718641074325; Mon, 17 Jun 2024
 09:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615181935.76049-1-alexei.starovoitov@gmail.com> <90d6740a-6b7e-474d-a218-50f4e0de343c@google.com>
In-Reply-To: <90d6740a-6b7e-474d-a218-50f4e0de343c@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 17 Jun 2024 09:17:42 -0700
Message-ID: <CAADnVQJJdO+UCYqWZ7pvccAwFNZxxF=KZHTv5SLGq_2Z2Q1hNA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix remap of arena.
To: Barret Rhoden <brho@google.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Pengfei Xu <pengfei.xu@intel.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 8:34=E2=80=AFAM Barret Rhoden <brho@google.com> wro=
te:
>
> On 6/15/24 14:19, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > The bpf arena logic didn't account for mremap operation. Add a refcnt f=
or
> > multiple mmap events to prevent use-after-free in arena_vm_close.
> >
> > Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> > Closes: https://lore.kernel.org/bpf/Zmuw29IhgyPNKnIM@xpf.sh.intel.com/
> > Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >   kernel/bpf/arena.c | 13 +++++++++++++
> >   1 file changed, 13 insertions(+)
> >
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > index 583ee4fe48ef..f31fcaf7ee8e 100644
> > --- a/kernel/bpf/arena.c
> > +++ b/kernel/bpf/arena.c
> > @@ -48,6 +48,7 @@ struct bpf_arena {
> >       struct maple_tree mt;
> >       struct list_head vma_list;
> >       struct mutex lock;
> > +     atomic_t mmap_count;
> >   };
> >
> >   u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
> > @@ -227,12 +228,22 @@ static int remember_vma(struct bpf_arena *arena, =
struct vm_area_struct *vma)
> >       return 0;
> >   }
> >
> > +static void arena_vm_open(struct vm_area_struct *vma)
> > +{
> > +     struct bpf_map *map =3D vma->vm_file->private_data;
> > +     struct bpf_arena *arena =3D container_of(map, struct bpf_arena, m=
ap);
> > +
> > +     atomic_inc(&arena->mmap_count);
> > +}
> > +
> >   static void arena_vm_close(struct vm_area_struct *vma)
> >   {
> >       struct bpf_map *map =3D vma->vm_file->private_data;
> >       struct bpf_arena *arena =3D container_of(map, struct bpf_arena, m=
ap);
> >       struct vma_list *vml;
> >
> > +     if (!atomic_dec_and_test(&arena->mmap_count))
> > +             return;
> >       guard(mutex)(&arena->lock);
> >       vml =3D vma->vm_private_data;
> >       list_del(&vml->head);
> > @@ -287,6 +298,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *v=
mf)
> >   }
> >
> >   static const struct vm_operations_struct arena_vm_ops =3D {
> > +     .open           =3D arena_vm_open,
> >       .close          =3D arena_vm_close,
> >       .fault          =3D arena_vm_fault,
> >   };
> > @@ -361,6 +373,7 @@ static int arena_map_mmap(struct bpf_map *map, stru=
ct vm_area_struct *vma)
> >        */
> >       vm_flags_set(vma, VM_DONTEXPAND);
> >       vma->vm_ops =3D &arena_vm_ops;
> > +     atomic_set(&arena->mmap_count, 1);
>
> i'm not sure, but i have the feeling that this refcnt should be on the
> struct vma_list or something.
>
> what happens if two different processes mmap the same arena?  will the
> second one come in and set the mmap_count =3D 1, clobbering whatever the
> first process had already done?
>
> what are the rules for a vma's vm_ops?  something like: "there will be a
> close() for the initial mmap and for every open()"?

yep.

>
> if that's what it's doing, then this initial refcnt =3D 1 corresponds to
> the remember_vma() call.  in which case, vm_ops->open ought to lookup
> the remembered vma (struct vma_list) and do the incref there.

good point. will change.

pw-bot: cr

