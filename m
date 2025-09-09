Return-Path: <bpf+bounces-67883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24594B50202
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B64B1C2723D
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 16:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE86310647;
	Tue,  9 Sep 2025 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3634Gfg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD902797B5
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757433602; cv=none; b=gDVt3ZWDo0V54vj6muU7+Ymr2VSq1Fd3Zvnjf2vD1Z0pDmlQDhk4yyomlbqcfBvmDCJQ34uO+NLP2Xey81LMnhYYgHyQc9WZQ83vjUsOsKCz+/LSyO+0ndV2vsl+HnZCu4JP+KGvfBoOb1Je2DyOvN+MVbVU8Ke60PGghaHsvoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757433602; c=relaxed/simple;
	bh=a6gyM2WYYSLYzVtGYR6l7hBtgJSgUX0SBRq2KFtrHH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXjGIHXMleq82W1HrHQAGrIt/2AmRUFIWT6FFTV+L87NfhD8MD37EQCXeXFZz35T/JQl8IhSvFvpUcuG4wzxVrnsR6Fc7pfb4mgKLSQo7pAg8ydh0lxYD9ZDoPaabLvyuIakq4M8ELKQKt6keISGRSRAnoF2av6gedgkiJtV9pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3634Gfg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45de6ab6ce7so15428375e9.1
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 09:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757433598; x=1758038398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7gL2iTFan+DF3N3s6TTsmvk1RmX9qDA15J2E4gPuVk=;
        b=C3634Gfg9HjSTabaesdfmmFLriXMOhAxYpd92GyqEUclJupa4f80P6xTUU/meJQwy2
         mtpOMZBpiDwi1Xgw7CCGVGIWxH6zzsGinrjmZuRnji4Fb9hL/RH5+lmFR20Sma+fnjY5
         dAiwN+YbGkZSaFMqjFgnvT6yAwqhgtwJV6DVwBzuZ7R4RstG4eIVFilS0Gx1w7QVNG1m
         2bROJeqtTuzu4A8anZT+Jm7f3R647/ggBNxvWGpsSE4xSX9wXqlowCZa1tnq18B5FR64
         /r50vRcHpYpqql/26LZhFwdLdSuTv54ql31awH1ScExjwTB3DcL8vZdCCdINxmnTyZhe
         /MKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757433598; x=1758038398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7gL2iTFan+DF3N3s6TTsmvk1RmX9qDA15J2E4gPuVk=;
        b=b5NNqzQrtH9WnPdz+osvD0dkl3XPKrIbFkb72n0eqNqoWMBmUn3E1umMx0e2AD7OF2
         hRMU3WaEtIa/LCb/hxFpzxx+wnxyq3zA2gqJSCvtMBjYiml7PDMzRm+CwpXdlK5KcmLd
         sL/r0O8eflBAXnizh98qNiW/ycY5KZctx+tqU4bz6+vkeWq4GWkiFWjO3LXZX6T7YZoV
         T+OKlQieziSo4m33w2uDVFsAD6bxbfwLHgjH3EdBwv8+u3zJv6hrntsAoK5DI8Ky4+Ae
         nwlHeT72ur8Fv+xi6hkCY/WpMnTjEW+H4VCD0sivkHBtYhnTAqmE5AHQIzhd+48e61GN
         iGOg==
X-Forwarded-Encrypted: i=1; AJvYcCW3g+06NYoAAVXJYxgeE67UViyYwTvYnE+xEy6E7F4nwIqOKhPtug4DGYSX7If4M1VejyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg1Yvy+rNwbNtQ+jogF2eCwzJpPq3ZX+ot7ZajB61IiiB+kRBZ
	ja60XMY1sGrfqOiZoa0hgfKH/vFHOgF2mcAPl8wXG3Kzeq998tVRBhTJ+rd7PrO1kSZeqzq8kx0
	dOEL6Qho8KRFSDQBhS8W8MnmkBFG2Sxc=
X-Gm-Gg: ASbGncsC3tYo8t/rYLBXz2Gmuz3LVIw1/0CwmftFYaY+x1ZXZx4CtkVLQEfvGJG7lFO
	hodf/lS/+rJAUAqagHchMsGczYd8WBkcDLmsrFSHIQ5mU8JyK6AycHw9gnArp30QmyANzWOjdou
	qAGtf0M0zfQlq6D3H8c0Q5AFlitTf9lyKqQrSkh6MHsRDhsI0M9DtZImiyDHtmyYjRDRvtoPeEo
	iaU0jgqwD6yV9UyhmSD1qo=
X-Google-Smtp-Source: AGHT+IGCQfRuquuAyQOAuVLvm+GNAcgg6AI5QJxnhOUZAClkJFLEdE1GyF94DIg3kgit8SIzn4YW/+Ei2xN3tbG3gmw=
X-Received: by 2002:a05:600c:8b22:b0:458:be62:dcd3 with SMTP id
 5b1f17b1804b1-45dddec82fdmr138798675e9.17.1757433598459; Tue, 09 Sep 2025
 08:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908044025.77519-1-leon.hwang@linux.dev> <20250908044025.77519-2-leon.hwang@linux.dev>
 <b0505a919d39e8151d0e14d9e41950f19d3807e0.camel@gmail.com>
 <603b37f4ef1a3ccbb661eaf11f56da9144bdcb66.camel@gmail.com>
 <aL9bvqeEfDLBiv5U@google.com> <CAADnVQ+56_gvS328irDEuGoDGFH6iywKriACtsre7h5a7eiJbw@mail.gmail.com>
 <aL_snlcI4zC4HtZw@google.com>
In-Reply-To: <aL_snlcI4zC4HtZw@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Sep 2025 08:59:46 -0700
X-Gm-Features: AS18NWD3083B03AjFgepgaEw4Cw0OA43jnzuaec0jqt-oFJKJ0zvriXJbqQjZ4M
Message-ID: <CAADnVQJMe4wVwTBUct2t2JOVOaHrJr0joBqsO1B123Yf8SHNwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject bpf_timer for PREEMPT_RT
To: Peilin Ye <yepeilin@google.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, kernel-patches-bot@fb.com, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 2:00=E2=80=AFAM Peilin Ye <yepeilin@google.com> wrot=
e:
>
> On Mon, Sep 08, 2025 at 03:51:00PM -0700, Alexei Starovoitov wrote:
> > On Mon, Sep 8, 2025 at 3:42=E2=80=AFPM Peilin Ye <yepeilin@google.com> =
wrote:
> > > Just in case - actually there was a patch that does this:
> > >
> > > [2] https://lore.kernel.org/bpf/20250905061919.439648-1-yepeilin@goog=
le.com/
> > >
> > > It was then superseded by the patches you linked [1] above however,
> > > since per discussion in [2], "use bpf_mem_alloc() to skip memcg
> > > accounting because it can trigger hardlockups" is a workaround instea=
d
> > > of a proper fix.
> > >
> > > I wonder if this new issue on PREEMPT_RT would justify [2] over [1]?
> > > IIUC, until kmalloc_nolock() becomes available:
> > >
> > > [1] (plus Leon's patch here) means no bpf_timer on PREEMPT_RT, but we
> > > still have memcg accounting for non-PREEMPT_RT; [2] means no memcg
> > > accounting.
> >
> > I didn't comment on the above statement earlier, because
> > I thought you meant "no memcg accounting _inline_",
> > but reading above it sounds that you think that bpf_mem_alloc()
> > doesn't do memcg accounting at all ?
> > That's incorrect. bpf_mem_alloc() always uses memcg accounting
>
> Ah, I see - kernel/bpf/memalloc.c:alloc_bulk() via irq_work.  Thanks for
> the correction!
>
> > , but the usage is nuanced. bpf_global_ma is counted towards root memcg=
,
> > since it's created during boot. While hash map powered by bpf_mem_alloc
> > is using memcg of the user that created that map.
>
> - - -
> IIUC, this "sleeping function called from invalid context" message on
> PREEMPT_RT is because ___slab_alloc() does local_lock_irqsave(), with
> IRQ disabled by __bpf_async_init():
>
>         __bpf_spin_lock_irqsave(&async->lock);
>         t =3D async->timer;
>         if (t) {
>                 ret =3D -EBUSY;
>                 goto out;
>         }
>
>         /* allocate hrtimer via map_kmalloc to use memcg accounting */
>         cb =3D bpf_map_kmalloc_node(map, size, __GFP_HIGH, map->numa_node=
);
>
> For my understanding, is/how is kmalloc_nolock() going to resolve this?
> Patch [3] changes ___slab_alloc() to:
>
>           /* must check again c->slab in case we got preempted and it cha=
nged */
>  -        local_lock_irqsave(&s->cpu_slab->lock, flags);
>  +        local_lock_cpu_slab(s, &flags);
>
> But for PREEMPT_RT, local_lock_cpu_slab() still does
> local_lock_irqsave(), and the comment says that we can't call it with
> IRQ disabled:
>
>  +         * On PREEMPT_RT an invocation is not possible from IRQ-off or =
preempt
>  +         * disabled context. The lock will always be acquired and if ne=
eded it
>  +         * block and sleep until the lock is available.

Of course. Not saying that s/kmalloc/kmalloc_nolock/ is a silver bullet.
bpf_timer needs other work. __bpf_spin_lock_irqsave() needs to go, etc.

