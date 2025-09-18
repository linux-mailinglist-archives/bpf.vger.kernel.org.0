Return-Path: <bpf+bounces-68831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC346B862A0
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 19:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9479948179F
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39383128B4;
	Thu, 18 Sep 2025 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIaCLbRG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E752641C3
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215429; cv=none; b=JkX/lGHUczhyaGUas1VTy5n8ALVx24hOce7EIqPVbMiUGdnFqy+hgFneFZJFiFwPPL39ocKs7HaONVMNV0AgKEwN+Y5rl5sAVY1UevJwCb/9NbD9AeRZzMTQGDoifg2wRhKzCLdLNPlxW70ym3GFjzbpUeCTAZqNFYfCFyMmVbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215429; c=relaxed/simple;
	bh=YI8RA2ytG2xs1eCsIp+PTqTNX4zI+BHViznX9fef3VQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQTo70WBAJpy1V75eqZx90k99s/Oeew7zy6LK0N4PVmpSdHqdjjnZSw7mL4Q9kB/VIQpz8BxOpyjD3ut7RAddh9CrCwqLMk60F2ggZkhQvnYvE5Uas3J7JOK0+P5KtgM5X1z/JuHsqQX7uWt9Q/gETVuJzBcpbgPqGZcfb5n/PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIaCLbRG; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d60157747so9782127b3.0
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 10:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758215425; x=1758820225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qB9O3ec38+znlFHr1fzc8jDdf/gGLgy85TrcRWaQpCU=;
        b=FIaCLbRGBMHQWlqecIUA4BpI6s/qI4YUgPHjCxtGuw3a/3gN38DvnvXMwIwnjGc3Q/
         ifAA/c2zlBAWwjjFC0hSdn5EZzK6tZns2ARakASWDBtr/O+eXTp8I9LlF4ryIc1ygdxy
         PLlYO4MngSJIbUmDrdQ2hQazd38Qzl0uy1MWmJX6zCEs7mdRrNM8ENk5cLjruL+LY95T
         /Bm8k7dpekPy4GcTCR9bCjWN+hAqLB4jmyNmxtVGknkGzwWA3Z1wzmYNh8Lpt04Homuq
         ovk03HxUVHm/URpZtK1zwcY+Qj8kdKtjLr0eABFTFMJ1sokjSijWlmte2BE3vTdWCy67
         MDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758215425; x=1758820225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qB9O3ec38+znlFHr1fzc8jDdf/gGLgy85TrcRWaQpCU=;
        b=sfUO5G/mqKudiYkHOZLNfoaq+ZlSAZLU9+CC6uOtVpn37mH8/tBY3icXRxxud/VFGL
         Pf9o99qFWAbaVRoU5Ms6qxq8oP3FhNsvAU911TDoGDeDR978zOPDgxy2Scy7t9k8C13T
         Yf8PglJwmDNDQQHqNzHscmp+5h9rlOWZi83n9scknj2kHZ4JFXpYfPfy203n63ZTC3nL
         sW4ej1syQm68PUL2HoEHJeA8qURRVfrk0V49H9Jv1XB0UofgkkDqMVuUhdWNPzOoB+QH
         tj+K1OeNHG30nvk/RH6f3WXPs5Kg74yblxI1GsJOmz3c35GXO623hv83PE+YsWzWz0d1
         pa+Q==
X-Gm-Message-State: AOJu0YzB8lhb3XKwZZJGuNScd8pVFTm/TJB1OLrkojrXrR3VwD0XdbZx
	fT+0dQs55uzLL6AWShJa6795k+f6CX+VcjJPHL2VwvtcCX8CTWGpzpnthtvkMV6kl9EaTsmELaG
	vJpsCYe3sZHOg1z/geZjHchg3jh18Wv0=
X-Gm-Gg: ASbGncupwjijK/i1QsjZ8rJA/GbqyDNw8mp1D3zU1TaT+1By/YzXpKqDVe8VTkhdtnA
	x7Fc7wPHXKGkR0+mKUkFU+nNbSEX1eyngwCJDsFGqFmikvwRcvz6uyfL/I3hBnSwrGjlOh57ok5
	+ZYrg7JUdSu+Iciqdx5Xqym+u8Drj6CV5wqtl96VwSjkZFU0GZ/OKBJF8VCT+XPH8ULfq8HqQV3
	Rw9a35rhh1s9d+JA9/M3K4A6Tls
X-Google-Smtp-Source: AGHT+IHVTfesJsLCMyUbVZAYwNjK+an45+xyrXELuCVla8jbqNlF5y1ORfkpp6j8k3NtJ5ZVyWUG7rvN3jnrquMTlj0=
X-Received: by 2002:a05:690c:48c9:b0:724:a06b:cafa with SMTP id
 00721157ae682-73d3aeca818mr2071947b3.33.1758215425039; Thu, 18 Sep 2025
 10:10:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757862238.git.paul.chaignon@gmail.com> <6bed34f91f4624c45fd7f31079246d3b3751a31f.1757862238.git.paul.chaignon@gmail.com>
 <CAMB2axOX-J5fDa8EuB42oHEvXQ+OGpUmEaetCQb4g41imvaYCg@mail.gmail.com> <aMsw7z7xNnDfCdaa@mail.gmail.com>
In-Reply-To: <aMsw7z7xNnDfCdaa@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 18 Sep 2025 10:10:12 -0700
X-Gm-Features: AS18NWBhvj1ftru-BeR0mz5tEFdI5Jvsuswx-K6rBWx7M2pIfQcWvkkHzxpfWd4
Message-ID: <CAMB2axODvwCRLpdHDz97HqzVFyt-YFh4U9-3Lvu=8_8UPfUvcA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:06=E2=80=AFPM Paul Chaignon <paul.chaignon@gmail.=
com> wrote:
>
> Thanks for the review Amery!
>
> On Mon, Sep 15, 2025 at 05:27:05PM -0700, Amery Hung wrote:
> > On Sun, Sep 14, 2025 at 8:10=E2=80=AFAM Paul Chaignon <paul.chaignon@gm=
ail.com> wrote:
>
> [...]
>
> > >  static void *bpf_test_init(const union bpf_attr *kattr, u32 user_siz=
e,
> > > -                          u32 size, u32 headroom, u32 tailroom)
> > > +                          u32 size, u32 headroom, u32 tailroom, bool=
 nonlinear)
> > >  {
> > >         void __user *data_in =3D u64_to_user_ptr(kattr->test.data_in)=
;
> > > -       void *data;
> > > +       void *data, *dst;
> > >
> > >         if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom =
- tailroom)
> > >                 return ERR_PTR(-EINVAL);
> > >
> > > -       size =3D SKB_DATA_ALIGN(size);
> > > -       data =3D kzalloc(size + headroom + tailroom, GFP_USER);
> > > +       /* In non-linear case, data_in is copied to the paged data */
> > > +       if (nonlinear) {
> > > +               data =3D alloc_page(GFP_USER);
> >
> > Do we need more pages here for non-linear data larger than a page?
>
> We're limiting user_size above to be at most
> PAGE_SIZE-headroom-tailroom, so I don't think we support more than a
> page of data. Am I missing something?
>

[...]

> >
> > > +       } else {
> > > +               size =3D SKB_DATA_ALIGN(size);
> > > +               data =3D kzalloc(size + headroom + tailroom, GFP_USER=
);
> > > +       }
> > >         if (!data)
> > >                 return ERR_PTR(-ENOMEM);
> > >
> > > -       if (copy_from_user(data + headroom, data_in, user_size)) {
> > > +       if (nonlinear)
> > > +               dst =3D page_address(data);
> > > +       else
> > > +               dst =3D data + headroom;
> > > +       if (copy_from_user(dst, data_in, user_size)) {
> > >                 kfree(data);
> >
> > syzbot reported a bug. It seems like data allocated through
> > alloc_page() got freed by kfree() here.
>
> Yep, I've fixed it and it will be in the v3.
>
> [...]
>
> > > @@ -1029,6 +1033,27 @@ int bpf_prog_test_run_skb(struct bpf_prog *pro=
g, const union bpf_attr *kattr,
> > >                 break;
> > >         }
> > >
> > > +       if (is_nonlinear && !is_l2)
> > > +               return -EINVAL;
> > > +
> > > +       data =3D bpf_test_init(kattr, kattr->test.data_size_in,
> > > +                            size, NET_SKB_PAD + NET_IP_ALIGN,
> > > +                            SKB_DATA_ALIGN(sizeof(struct skb_shared_=
info)),
> > > +                            is_nonlinear);
> > > +       if (IS_ERR(data))
> > > +               return PTR_ERR(data);
> > > +
> > > +       ctx =3D bpf_ctx_init(kattr, sizeof(struct __sk_buff));
> > > +       if (IS_ERR(ctx)) {
> > > +               ret =3D PTR_ERR(ctx);
> > > +               ctx =3D NULL;
> > > +               goto out;
> > > +       }
> > > +
> > > +       linear_size =3D hh_len;
> > > +       if (is_nonlinear && ctx && ctx->data_end > linear_size)
> > > +               linear_size =3D ctx->data_end;
> >
> > I think BPF_F_TEST_SKB_NON_LINEAR may not be necessary.
> >
> > To not break backward compatibility (assuming existing users most
> > likely zero initialized ctx), when ctx->data_end =3D=3D 0 || ctx->data_=
end
> > =3D=3D data_size_in, allocate a linear skb as it used to be. Then, if
> > ctx->data_end < data_size_in, allocate a non-linear skb.
> >
> > WDYT?
>
> That makes sense, if only to be consistent with your patchset. It should
> be doable by just calling bpf_ctx_init before bpf_test_init. I'll try
> that.
>
> >
> > > +
> > >         sk =3D sk_alloc(net, AF_UNSPEC, GFP_USER, &bpf_dummy_proto, 1=
);
> > >         if (!sk) {
> > >                 ret =3D -ENOMEM;
> > > @@ -1036,15 +1061,32 @@ int bpf_prog_test_run_skb(struct bpf_prog *pr=
og, const union bpf_attr *kattr,
> > >         }
> > >         sock_init_data(NULL, sk);
> > >
> > > -       skb =3D slab_build_skb(data);
> > > +       if (is_nonlinear)
> > > +               skb =3D alloc_skb(NET_SKB_PAD + NET_IP_ALIGN + size +
> > > +                               SKB_DATA_ALIGN(sizeof(struct skb_shar=
ed_info)),
> > > +                               GFP_USER);
> > > +       else
> > > +               skb =3D slab_build_skb(data);
> > >         if (!skb) {
> > >                 ret =3D -ENOMEM;
> > >                 goto out;
> > >         }
> > > +
> > >         skb->sk =3D sk;
> > >
> > >         skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
> > > -       __skb_put(skb, size);
> > > +
> > > +       if (is_nonlinear) {
> > > +               skb_fill_page_desc(skb, 0, data, 0, size);
> > > +               skb->truesize +=3D PAGE_SIZE;
> > > +               skb->data_len =3D size;
> > > +               skb->len =3D size;
> >
> > Do we need to update skb_shared_info?
>
> skb_fill_page_desc() already does, at least the skb_shinfo(skb)->frags[0]=
.
> Do you have something else in mind?
>

I mis-read bpf_test_init(). Thanks for the clarification!

> [...]
>

