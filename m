Return-Path: <bpf+bounces-59073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202C3AC5F99
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 04:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F8517AC0BF
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D401C5D44;
	Wed, 28 May 2025 02:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLz5hjWj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904832BD1B
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 02:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399716; cv=none; b=j8qJaMvqug5Bag5q41gzNuShzh6F7axufUuTp0NRvbgq4OgAlZj3gY28gn+QPMhJ0CHSzY+La9FP34e5tdElVygBaRs+I3T/S47UAHmduORcFwoSPWvBleNHCSPupTokK2GtuxDdkKFDIh8Gx5LJ+1L+mat9P2w5n+LErUkkA5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399716; c=relaxed/simple;
	bh=w2pkJCa+NG0DLQdW7DZlb08XDaDYZN60YMKALjcRbRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9FemdjVFiFpqwMXHIYTWART6k3paIo0gv/CZrGFiENEcrWzc543sh9dGkMwzFXRGx0ox4lGKfKll+DM9IBGgfZdhHTVEKyPuRqWxtUN+vEEU1YjmOYHh957VordQqa5t2e32k4dCYId9h74SGLR9EZquBrB55cI9qGxmouJh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLz5hjWj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so25828645e9.2
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 19:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748399713; x=1749004513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51nAeDpNOY9pWYPTuP82l/bKLpEVzRgi66NRXpQXTQU=;
        b=CLz5hjWjZczX0AtjER9ugTyNJjOHBIkAmL86RtgmtHoUYzm+DxF+JLnc2Bkl1v5lam
         Qu98XYyShgSut71VsUHwOs/+OHWy5GmoaCO15gagtLiAi6qOMun75H9B7pG6lmP33hjV
         Epxi1yswB4EqUjFLvvBG0QNJ+IOI7jafnIJOZ8keeuW/GN+OLCwn00XnJnLe6r5YP//T
         bko3+imOXbHiqVsAriLz93/TJcLk/h5a4M4PAyYKKZnCpG2rX6ODJo7ZfdymJIBU17Qo
         jov9L7CDV8p5ZTFYUHdprvmNkRi2P9VnLlK3/MF7xT6T7gA211n7FtZ+qDRWE4YGQfvr
         FGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748399713; x=1749004513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51nAeDpNOY9pWYPTuP82l/bKLpEVzRgi66NRXpQXTQU=;
        b=IRPrwLOO/k0dcnDfzQIXEOR9pHjzgqaniH+QPjNXlrfxX088UMso/AbeqUKRFQZLtP
         u8z3wzlzg+2UHv833c/e0ti2agrYFINjRBCaebqFO02CssIGkVthE0WqSzPeAQD3dbw1
         WcDzRw/Gv4/R/GZgwKj0u5k7IF7spb/EDOYKy8HHXapXGSgk8LlxZyh6y9kf+zGR9c7Q
         DF2IEZUGfBoBoFRNfpdVIidO+RRr3n18SSFy65dMBm71tE/ZStuO0Wl1x4Pd4ZZWh6Pk
         Y/PaeYf50gC0FGiAga63lt6xUBaFAh5y7TqLbcyQpYS8HiaiR2UveGqQyXrKClU9ce1W
         blFA==
X-Forwarded-Encrypted: i=1; AJvYcCXdQpxlJhq8uq4dDqogwac4zbzyIpWTYS0D2q1cOo1vRWaoiR1yQymclhNUSgb/pgIV1a0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGI8L4fqZVNzbeWgUGo1Fg17WgSRIFAGALIKpd+nzCkd8heBm6
	y5ZSSCwO+mYuxicd5I4HF4Go0TnHji4PV2jQLSnXrbxXjaWh8fGlb7faqYxerqQMoGH1VsATHPO
	FabIfzeUcQXnyaI+SmQtU0XneXb6hrI0=
X-Gm-Gg: ASbGnctDy0M012eUml25nY1VXWu/lVmcNO8i6vgfBvY3jCTL6bEt/dbEJcuJnEb38KL
	BJTl9LdCTm9+vwT5FTRqS34PfWXWU3GspDDWYLJDPbfJZxrFgoPfJTBDvYhJ7JaRCGLEZu5bFGQ
	TFSx71UvBcD111G36sDefaF3iHxSCMOiOaYqVNHBvOQZtZulSrtK1TNxx1snYHi7u/DzYoukQ9
X-Google-Smtp-Source: AGHT+IEMQs46FYuK0UI1MEAVFIHBLx00DlZZb8L4vutnDp0SkNqW1Uu2tJG+z1bluZnJFb1eByYQ9I58ql27Kylc5NE=
X-Received: by 2002:a5d:584c:0:b0:3a4:d4cd:b0a with SMTP id
 ffacd0b85a97d-3a4d4cd0df1mr9356376f8f.28.1748399712476; Tue, 27 May 2025
 19:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526162146.24429-1-leon.hwang@linux.dev> <20250526162146.24429-3-leon.hwang@linux.dev>
 <CAADnVQJZ1dpSf3AtfNsvovogfC75eVs=PiYXMivUpDHDow3Row@mail.gmail.com> <CAEf4Bzbw9G4HhL4_ecbgc2=bDbZuVEA2zLnChgqT_WCsq11krQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzbw9G4HhL4_ecbgc2=bDbZuVEA2zLnChgqT_WCsq11krQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 May 2025 19:35:01 -0700
X-Gm-Features: AX0GCFvqj2S2dJz2JOxz68e7rULmS93OerKf5sTkQCsUoLmg7w2y8iLm3aaq5oU
Message-ID: <CAADnVQLxzJMAYymtWMFZb6eAK+ha_shRfh+m3W3yFO4dLn-YeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf, libbpf: Support global percpu data
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, Quentin Monnet <qmo@kernel.org>, 
	Daniel Xu <dxu@dxuuu.xyz>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 4:25=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, May 27, 2025 at 3:40=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, May 26, 2025 at 9:22=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> > > +
> > > +       data_sz =3D map->def.value_size;
> > > +       if (is_percpu) {
> > > +               num_cpus =3D libbpf_num_possible_cpus();
> > > +               if (num_cpus < 0) {
> > > +                       err =3D num_cpus;
> > > +                       return err;
> > > +               }
> > > +
> > > +               data_sz =3D data_sz * num_cpus;
> > > +               data =3D malloc(data_sz);
> > > +               if (!data) {
> > > +                       err =3D -ENOMEM;
> > > +                       return err;
> > > +               }
> > > +
> > > +               elem_sz =3D map->def.value_size;
> > > +               for (i =3D 0; i < num_cpus; i++)
> > > +                       memcpy(data + i * elem_sz, map->mmaped, elem_=
sz);
> > > +       } else {
> > > +               data =3D map->mmaped;
> > > +       }
> > >
> > >         if (obj->gen_loader) {
> > >                 bpf_gen__map_update_elem(obj->gen_loader, map - obj->=
maps,
> > > -                                        map->mmaped, map->def.value_=
size);
> > > +                                        data, data_sz);
> >
> > I missed it earlier, but now I wonder how this is supposed to work ?
> > skel and lskel may be generated on a system with N cpus,
> > but loaded with M cpus.
> >
> > Another concern is num_cpus multiplier can be huge.
> > lksel adds all that init data into a global array.
> > Pls avoid this multiplier.
>
> Hm... For skel, the number of CPUs at runtime isn't a problem, it's
> only memory waste for this temporary data. But it is forced on us by
> kernel contract for MAP_UPDATE_ELEM for per-CPU maps.
>
> Should we have a flag for map update command for per-CPU maps that
> would mean "use this data as a value for each CPU"? Then we can
> provide just a small piece of initialization data and not have to rely
> on the number of CPUs. This will also make lskel part very simple.

Initially it felt too specific, but I think it makes sense.
The contract was too restrictive. Let's add the flag.

> Alternatively (and perhaps more flexibly) we can extend
> MAP_UPDATE_ELEM with ability to specify specific CPU for per-CPU maps.
> I'd probably have a MAP_LOOKUP_ELEM counterpart for this as well. Then
> skeleton/light skeleton code can iterate given number of times to
> initialize all CPUs using small initial data image.

I guess this can be a follow up.
With extra flag lookup/update/delete can look into a new field
in that anonymous struct:
        struct { /* anonymous struct used by BPF_MAP_*_ELEM and
BPF_MAP_FREEZE commands */
                __u32           map_fd;
                __aligned_u64   key;
                union {
                        __aligned_u64 value;
                        __aligned_u64 next_key;
                };
                __u64           flags;
        };

There is also "batch" version of lookup/update/delete.
They probably will need to be extended as well for consistency ?
So I'd only go with the "use data to update all CPUs" flag for now.

