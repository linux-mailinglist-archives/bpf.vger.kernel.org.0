Return-Path: <bpf+bounces-57947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA35AB1F0C
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 23:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E94F1BA1FC9
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 21:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF3925FA0B;
	Fri,  9 May 2025 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zzn7JuVf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E60D226CF4
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 21:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746826102; cv=none; b=IFOdbLbFZu1mcK4XA1VvvdG5GNxftZrMWE8AejQUNqs+jsZ//MKHya81HbhzDBfwRT5wm87aenVh2oK/ZJpN2NUnYOjPoELwAKNYEHUvWcrayB5lK1yqMebzCakjMIS/4lCCWRiwSgBObMF9gddAGa6DGORanK3HOwD4cJfSxOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746826102; c=relaxed/simple;
	bh=2o0SacpOPXs6dF0c9DYCrS8s6rRvXV1cwYiAe/DMPgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCmmfk0DJwF8HwH1E1fI2dVK5BZOX/tcc5Alz1DxGTLuBiYLzQm90/vq1TENo0anTwwEBN7LTofsO/Bd+umIUsN8Oc6TELt0/PAIWWKmGEvJ7eLGDWBc43NIA37jtNs8dR/SHxLXP/piXG/8QnEJ9PxrjnR+Ty6X9DIUAE4YNQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zzn7JuVf; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b200047a6a5so1871134a12.0
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 14:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746826100; x=1747430900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewAJKffBGw5h5/Rh+zR7jSqIfA+UpfATpD+94WJV5/c=;
        b=Zzn7JuVft081cZOXOJh7DtwV9vqH8DgFg/BykkHmVBQaGSgJXJrNzGuG0OlM4sHUX0
         9KoLAO0ms7H3bxZ0boLpLQwtjI+GaPmEKwlKc0GNiTt0lQHM1LKDSrCpcRIzpopCDMG3
         mDrwH0tqaCg5jPFO0Dp906De+FnB4qt48PoOqs295rP45y5PyaQzZaxo4jUZ3qpXhOnQ
         cKeagGlsp0yvpV7gZokQjXbfGlKKASpo5Wyp+UQi9UUu9JxYaUxnsjLc5qXqjCAN6+oG
         Gs8TOAB0ZpuH/NCXPLw9eWKl1iF/E1+z9haVFYg7WQVMaQNhB4LITUPeins1kBd5qzRN
         2pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746826100; x=1747430900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewAJKffBGw5h5/Rh+zR7jSqIfA+UpfATpD+94WJV5/c=;
        b=R6IaYqbqlUzD/vf9PLVW99//IX09iZYqOCE2CS5nWZMAw1JwqDs7Leu1qyoaXMXODa
         kKaryLffPjXAJLA3Wu/sLnK5KL2xFKibBMJYZzLgtoLtKKVoj3goenRb0PptA0wMbLZn
         1HRAkSdxh5PPb4Bfo5m/bFkWpVXeQGv0rofg3eNFhddutz9K4/C4lKyNZWqB8S6JWIlm
         5Ftf+9bXvQX1pbyQP6On8wezrh/JpZG0Tvri06YR/48NDt908iqNFKIhyxK4hGFkmKHS
         UgICTPq6Wilr68hlMCNYQdo+cQLqd6Pz/DVIQpxUL+yeJ49lBVors3QJ4YGaaEiJfDJ3
         sSOw==
X-Forwarded-Encrypted: i=1; AJvYcCU7Ct5eMK5WQUH/Y1+QPH0poCbSVcEKHO0JPPVYOwTsMB99KdRUoRcv404rAGVCSidJzOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxkoBZJs+JkCgdB1MQHKu1OnXJoAexoDmqWvOLViiaq2CAjG3b
	lR2igh6+hXB8SkbdvgFXQIh2+MniAyds4k4MBuriR3hP5TQ9VsbAt8hQl+2riTfwo6etD3oXu92
	LrX4ZJeUzmP/nn139AoPYGaUY4qA=
X-Gm-Gg: ASbGncvy9RDbT/+/fqo/UAu14zWCWMVN1IQzefDEqnwZj+fSqDt6Zw02Cf9lU6fVekD
	fmr+gjiGz9KU2RjiZHNxsnZPPN5Zfqg6xJzTy3XDQwKxX7YwQWZ40RtmQfIVAc3EMSu1mfHnTaJ
	0KKhnWXcZtODWvdyQQWYlZry9eYfLOm52xrTQIqs0KIER8E9Xf
X-Google-Smtp-Source: AGHT+IFWeY/l3BXLpuv42enQUa2PPWE6BTTfsqKqz6HrhJVkiDB3i24d21S0nGJYKpuWDQFOOkWAax03a9fwjRO8RUA=
X-Received: by 2002:a17:90b:3145:b0:2ff:556f:bf9 with SMTP id
 98e67ed59e1d1-30c3f9095cbmr6919887a91.4.1746826100078; Fri, 09 May 2025
 14:28:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-10-memxor@gmail.com>
 <82fa97637f995a1a004221b8d4e869e775a5f008.camel@gmail.com>
 <CAP01T74ND3d=deo=YVpETG7HVfUf4rD21TEkJJmsByVS+BTy-g@mail.gmail.com> <a36c2910e77477af62b5ff03aa7f6e665babe506.camel@gmail.com>
In-Reply-To: <a36c2910e77477af62b5ff03aa7f6e665babe506.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 May 2025 14:28:07 -0700
X-Gm-Features: ATxdqUEidSHUNAdQvCqrZpgX6xOI5cJfB8QY2yofVSuD-mqbBGxB6K5G6c4JBPY
Message-ID: <CAEf4BzboFXQO-mTmEwK1bJhO4V5+YKAvdJsPXMXKJtCe1tm4wQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 09/11] libbpf: Add bpf_stream_printk() macro
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 11:16=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2025-05-09 at 01:33 +0200, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > > > -#define ___bpf_pick_printk(...) \
> > > > -     ___bpf_nth(_, ##__VA_ARGS__, __bpf_vprintk, __bpf_vprintk, __=
bpf_vprintk,       \
> > > > -                __bpf_vprintk, __bpf_vprintk, __bpf_vprintk, __bpf=
_vprintk,          \
> > > > -                __bpf_vprintk, __bpf_vprintk, __bpf_printk /*3*/, =
__bpf_printk /*2*/,\
> > > > -                __bpf_printk /*1*/, __bpf_printk /*0*/)
> > > > +#define ___bpf_pick_printk(choice, choice_3, ...)                 =
   \
> > > > +     ___bpf_nth(_, ##__VA_ARGS__, choice, choice, choice,         =
   \
> > > > +                choice, choice, choice, choice,                   =
   \
> > > > +                choice, choice, choice_3 /*3*/, choice_3 /*2*/,   =
   \
> > > > +                choice_3 /*1*/, choice_3 /*0*/)
> > > >
> > > >  /* Helper macro to print out debug messages */
> > > > -#define bpf_printk(fmt, args...) ___bpf_pick_printk(args)(fmt, ##a=
rgs)
> > > > +#define __bpf_trace_printk(fmt, args...) \
> > > > +     ___bpf_pick_printk(__bpf_vprintk, __bpf_printk, args)(fmt, ##=
args)
> > > > +#define __bpf_stream_printk(stream, fmt, args...) \
> > > > +     ___bpf_pick_printk(__bpf_stream_vprintk, __bpf_stream_vprintk=
, args)(stream, fmt, ##args)
> > >                            ^^^^^^^^^^^^^^^^^^^^  ^^^^^^^^^^^^^^^^^^^^
> > >                            These two parameters are identical,
> > >                            why is ___bpf_pick_printk is necessary in =
such case?
> >
> > In our case choice and choice_3 are the same, but for bpf_printk
> > they're different, I was mostly trying to reuse the pick_printk
> > machinery for both (which dispatches correctly to the actual macro).
> >
>
> But ___bpf_pick_printk is a noop if two identical choices are supplied,
> so there is nothing to reuse. E.g. nothing breaks after the following cha=
nge:
>
>    #define __bpf_trace_printk(fmt, args...) \
>           ___bpf_pick_printk(__bpf_vprintk, __bpf_printk, args)(fmt, ##ar=
gs)
>   -#define __bpf_stream_printk(stream, fmt, args...) \
>   -       ___bpf_pick_printk(__bpf_stream_vprintk, __bpf_stream_vprintk, =
args)(stream, fmt, ##args)
>
>   -#define bpf_stream_printk(stream, fmt, args...) __bpf_stream_printk(st=
ream, fmt, ##args)
>   +#define bpf_stream_printk(stream, fmt, args...) __bpf_stream_vprintk(s=
tream, fmt, ##args)
>
>    #define bpf_printk(arg, args...) __bpf_trace_printk(arg, ##args)
>
> Which allows to shorten this patch.
> Or do I miss something?
>

+1, we have this ___bpf_pick_printk business because we want to use
older bpf_trace_printk() that accepts values directly if possible (for
best support of old kernels). With bpf_stream_vprintk() it's always
values-in-array approach, so no need for all this extra macro
machinery, IMO.

> [...]
>

