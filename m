Return-Path: <bpf+bounces-68932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C37B898C5
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 14:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C454F620A0C
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C7C21B19D;
	Fri, 19 Sep 2025 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfsnRFjm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4530935942
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758286440; cv=none; b=SyB44IrYPF5i82FICbEf0GpPxz9a4aMzSFGBbXxTRR9XligdTsswEB3vDvdZtpndU7Gxa2f+yB4letNiUu57gVdD2A10Guc8sncxXUo8m8PmNbcAMrmbQInUYXoe9E/20mciaQlPXhfJJzcEF8eQGEYNRl17D7aG9xPoEMb3ZW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758286440; c=relaxed/simple;
	bh=OQMWPd8ZLmEVPyJ8L2EAOr1dOvBWKRPT25iV8BVEZeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZ4cmRlmGNxJZPyVg439qW+RazNFDAexO61F5KfnLO1CDPBHpAgRzNcoqyEgy/+VUlmBGHO5fB6JYSWx7TGLk3UCuuwNnDqhhmx9fkK85wYsXrAgmkRDefqtzb+Psd53c5rHGOt9zn9xYbYumVAlMgezby0fkqK7ZVmklYtdg58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfsnRFjm; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b149efbed4eso337794766b.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 05:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758286436; x=1758891236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tB7LlnkiscLpo3gkcuwWhYvknilidlR1GUjxm0/lGo=;
        b=IfsnRFjmlTOfazY2dWR9m5Icrre2yQMUTCiNxFXKTHoKkshbEFFZWzJD6mymyv1ejy
         kiH/ERjS9eDLP7P7FT4f2Wu+z/Mifr3+ATL3JCDePIJQ2HR/MIeABG/BSE84WXAxVfVp
         nAzxmPYg7EsF4bBwWdlGOMDCKFTFT3Eaw4BXqh5+e8mIVnM4UCBHBk8I5++AEkr1aCj3
         Q4uXR8l3/XTC5Hfk5vpBiTgaAruDAEVG3c1qmaKfxpnVJ85nMvp4/W+U0o/Dd5EVUoRb
         lUk6r9ezX5qEzFsYVJvxZsiWfc7/n5AxH3J2P0dg6ZN6GQFzyaogFrBK/X5/Wdi/3d/k
         5T5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758286436; x=1758891236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tB7LlnkiscLpo3gkcuwWhYvknilidlR1GUjxm0/lGo=;
        b=gb/yMIb1b9ePyiamfdM64flbJcR4n4eY4p7AT4YPRL5gVe2wbgJIPeJws41Gwfdvrc
         B0d6719fczGeIkJfyfr0SDLAKiUUzQtmmarpLj+VqgpTUVT7mBOAPmoHb+7ESP/WTAlU
         PhlBNcq+LrSoZgYdDH+eJ3SzFC+n+I66ytie0S69y6D3mnc5yUaNMEDmnIzocKlpy17U
         4k75ys+TzhO537dlN4JMbh5InH953YnisCu427eSlqiKpc298lYnvuYzZtn3oYJAxDCr
         G3GI04YNkCcI2fENLmqKKViD59DDaWyDye+zPhEMjxGAWcP15ru7jfwsOnn82fuJUBmb
         9jIw==
X-Forwarded-Encrypted: i=1; AJvYcCX0WdwGlK0chY24hJvDbo7qkzWHPtNTzqBiM7BYytF3dK489mKmVkn2fnYMUoXh0b/Hxps=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcs9nsZJw12DM8nxhYuqdSn6I1ilOO1WV/YSNA3Id0MZptzGWx
	zJFfjdHlrmWMS6WTFMqP9RxBvsBfIlBUqhaqFhSYsgoTIeWBPsNThg0fWqH79F818bXOv4/lkJO
	FDNLKamjrnPOlJR47D7tnxK6EeuFG2uekdj+4
X-Gm-Gg: ASbGncv/GCBRmyv1m3t6glzB+UXtS1G1pRHjGg0IiA9C+NYzf7j26LpQ4dUBl0zx0Kc
	a+0jSMXVrqvwWkwMfM6ErsPXCqlsK45gPsqd8eVd7rrDI+YdoFVA52X+QE2qNtnbmQRDQASeBCV
	2lg5GqCjpNOByX2XAcZgRfY4omEhQrybYc1OBLLDgLcKUQWzy7drUvT4Hsj4Z3MkUwr/LbVm9iO
	DxSBb1yO52wzrbQRuZFznJmAlwTSWhh7L8XOwtl
X-Google-Smtp-Source: AGHT+IFsxrzOWNwUPdSvUUlSZPK2jbK78kbW0CS7rD3NKOzSDwXJDerL4/iWn1UBqea6zobugbAnGVkNCeJOQV0hvE0=
X-Received: by 2002:a17:906:fe08:b0:b0c:99b8:8ac5 with SMTP id
 a640c23a62f3a-b24f4428a64mr284073466b.44.1758286436218; Fri, 19 Sep 2025
 05:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918132615.193388-1-mykyta.yatsenko5@gmail.com>
 <20250918132615.193388-8-mykyta.yatsenko5@gmail.com> <CAADnVQJfGqKpOhQpx_a-kKfv34XRE=hDZAN=u-=CVppUF5wfzA@mail.gmail.com>
 <171ddd7f-a100-4800-b0f3-1ac8e25c13d8@gmail.com>
In-Reply-To: <171ddd7f-a100-4800-b0f3-1ac8e25c13d8@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 19 Sep 2025 14:53:19 +0200
X-Gm-Features: AS18NWB4PFYOYQmzjOTMDz-NlRLgu4s7J3MePPSKsNnUSI_s57VSg3aj5oh-gik
Message-ID: <CAP01T76m5DLzy5TKjrDOG5JQqjtSZOHkJtMRx8vNbWZSK4CGnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 7/8] bpf: task work scheduling kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Sept 2025 at 14:27, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 9/19/25 01:56, Alexei Starovoitov wrote:
> > On Thu, Sep 18, 2025 at 6:26=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> +static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf=
_task_work *tw,
> >> +                                                          struct bpf_=
map *map)
> >> +{
> >> +       struct bpf_task_work_ctx *ctx;
> >> +
> >> +       /* early check to avoid any work, we'll double check at the en=
d again */
> >> +       if (!atomic64_read(&map->usercnt))
> >> +               return ERR_PTR(-EBUSY);
> >> +
> >> +       ctx =3D bpf_task_work_fetch_ctx(tw, map);
> >> +       if (IS_ERR(ctx))
> >> +               return ctx;
> >> +
> >> +       /* try to get ref for task_work callback to hold */
> >> +       if (!bpf_task_work_ctx_tryget(ctx))
> >> +               return ERR_PTR(-EBUSY);
> >> +
> >> +       if (cmpxchg(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING) !=3D =
BPF_TW_STANDBY) {
> >> +               /* lost acquiring race or map_release_uref() stole it =
from us, put ref and bail */
> >> +               bpf_task_work_ctx_put(ctx);
> >> +               return ERR_PTR(-EBUSY);
> >> +       }
> >> +
> >> +       /*
> >> +        * Double check that map->usercnt wasn't dropped while we were
> >> +        * preparing context, and if it was, we need to clean up as if
> >> +        * map_release_uref() was called; bpf_task_work_cancel_and_fre=
e()
> >> +        * is safe to be called twice on the same task work
> >> +        */
> >> +       if (!atomic64_read(&map->usercnt)) {
> >> +               /* drop ref we just got for task_work callback itself =
*/
> >> +               bpf_task_work_ctx_put(ctx);
> >> +               /* transfer map's ref into cancel_and_free() */
> >> +               bpf_task_work_cancel_and_free(tw);
> >> +               return ERR_PTR(-EBUSY);
> >> +       }
> >> +
> >> +       return ctx;
> >> +}
> > If I understood the logic correctly the usercnt handling
> > is very much best effort: "let's try to detect usercnt=3D=3D0
> > and clean thing up, but if we don't detect it should be ok too".
> > I think it distracts from the main state transition logic.
> > I think it's better to remove both map->usercnt checks
> > and comment how the race with release_uref() is handled
> > through the state transitions.
> >
> > Why above usercnt=3D=3D0 check is racy?
> > Because usercnt could have become zero right after this atomic64_read()=
.
> > Then valid ctx (though maybe detached) would have been returned
> > to bpf_task_work_schedule(), and it would proceed with
> > irq_work_queue().
> > tw->ctx either already xchg-ed to NULL or will be soon.
> >
> > The bpf_task_work_irq() callback would fire eventually it will do
> >   + if (cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING) !=3D
> > BPF_TW_PENDING) {
> >
> > if releas_uref() already did bpf_task_work_cancel_and_free()
> > then ctx->state =3D=3D BPF_TW_FREED and
> >    +   bpf_task_work_ctx_put(ctx);
> >    +   return;
> >    + }
> > will be called on this detached ctx.
> >
> > but xchg(&ctx->state, BPF_TW_FREED) might not have been done.
> > so the code will proceed...
> > and further it looks correct when it comes to handling
> > races with cancel_and_free().
> >
> > The point that usercnt=3D=3D0 or not doesn't change thing.
> > We don't check it in the steps after acquire_ctx().
> > It looks to me these two checks in bpf_task_work_acquire_ctx()
> > don't fix any race.
> > It seems to me they can be removed without affecting correctness,
> > and if so, let's remove them to avoid misleading
> > readers and ourselves in the future that they matter.
> >
> > Note, similar usercnt checks in bpf_timer are not analogous,
> > since they're done under lock with async->cb manipulations.
> >
> >
> > Also I believe Eduard requested stess test to be part of patchset.
> > Please include it. I'd like to see what kind of stress testing
> > was done. Patch 8 is just basic sanity.
> An example of race condition I'm handling is:
> Imagine usercnt gets to 0, and then for some map value cancel_and_free()
> (detach context) races with bpf_task_work_fetch_ctx() (attach context),
> if this race resolves to context first being detached (by
> cancel_and_free())
> and then new one attached (by scheduling codepath).
> Detached context state is set to FREED and it's deallocated.
> But newly attached context state is STANDBY (cancel_and_free() has never
> seen it)
> and map holds the refcnt to it, which never go to 0, as cancel_and_free()
> for the element has been already called, so we never free it.
>
> It's not a problem if usercnt goes to 0 after we attached a context,
> because cancel_and_free() will detach and
> put the refcnt, and scheduling codepath will see the FREED state.
>
> Other thing is checking usercnt =3D=3D 0 before context initialization -
> that's preventing allocation and attach a context to a map that has
> already done cleanup. Cleanup won't happen again and this new context
> is leaked.
>
> Trying to summarize:
>   1) First check for usercnt =3D=3D 0 is needed so that we don't allocate
> contexts
> for map that has already cleaned up.
>   2) Second check is needed in case of clean up is triggered during conte=
xt
> initialization/attach, potentially leading to newly attached context leak=
,
> as cancel_and_free() was called for old context and won't be called for
> new one.
>   3) After context initialization/attach is done, we don't need checking
> for usercnt,
> as cancel_and_free() will detach and transition to FREED. The state
> transition will
> be seen by scheduling codepath.

I agree, I don't see how we can avoid checking usercnt. Maybe we don't
need to check it twice, i.e. optimistically first and then again after
cmpxchg and can only do it once.
Since this is not a common case it's nbd that we have to put and
deallocate stuff. But if we don't do usercnt check at all, we will
leak memory.
Once usercnt drops to zero and task work lingers in map value, nothing
will come and free it anymore, short of user deleting the map value
manually, which is not guaranteed.

