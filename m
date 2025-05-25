Return-Path: <bpf+bounces-58910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EA4AC35FD
	for <lists+bpf@lfdr.de>; Sun, 25 May 2025 19:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D473B0B05
	for <lists+bpf@lfdr.de>; Sun, 25 May 2025 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C89125A633;
	Sun, 25 May 2025 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FcYx/Clo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A78822D4ED
	for <bpf@vger.kernel.org>; Sun, 25 May 2025 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748195099; cv=none; b=HbjhyK3K+YMOzVrp8vfEH1A11taqkIey5OuCAG/J/QtCt7svR6KCnsmBXmSajSfsthe+FRauuqVcdFoLQnD0+3Je4s4y+aNxMAYNZjAWTvLlWay6+8dtcF/a25DKuwOykcrbz0mYH/I5HCTnZSFFSz+ZGQiqmm07V80BWgvdkfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748195099; c=relaxed/simple;
	bh=nWsLzmIJWGS1Xl7vBXPSHkgM/qkaZf1/zzniqjOnEvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ToeouRRQ+4btDv5d7IXsfcANkkb1SjCsBWVRqrZ8vY3y887DSwk2lFsXh22RqIoPM26s5yarfIxphH+2st1GJF6WNA0cjOGfCCgNYvSHSRQGGyydziOWpAFPMR+EBfuCXbkG4umHRHmT1u2rcstikqv02XBzBFdt25Vzx0x9Zc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FcYx/Clo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-231ba6da557so208275ad.1
        for <bpf@vger.kernel.org>; Sun, 25 May 2025 10:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748195098; x=1748799898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IANK8/D/9AjR/6N4kd6bQcHsSXv8BeLUuMW3H+pxVUU=;
        b=FcYx/CloyIEzXZXfRgC77VArpVM5dlMhgstq9qWZd8+2u8EnLckbqIuHVHhVTMf/MP
         Vqjea4u5TLnq9u0Y0Y5cE6NJizVSpXKVJ2k4/rJQbdCZljIdrqijqShZTJ6ct53+UAnd
         fmDkcZ02Q4EDhVKRgmWK93B/TyiRYBwPJWjCUgMtfd3J4TbGahG0b9nJ+W9LnWSrFWp6
         eCEeqMTw6quZ8Iit/E7qcjMYJMqoG0FT9tFt3K1uNGuWvdW5OXKcuxM/lzlce7z9NXEu
         ttDqz9mAljNt8qtsoPTojLcbhmbWaha8xdpyOtn9XCFt1CHx7Swpa9dPySPktwwFRsvk
         jMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748195098; x=1748799898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IANK8/D/9AjR/6N4kd6bQcHsSXv8BeLUuMW3H+pxVUU=;
        b=q8A/WaDVqN6I3gsxDiiQwWgp/VMc59j9ERS5rFKnZ8kGJC7E+W/hgIAxINvdgQPHHm
         8YgvTc27ULuZ+vFPPweIJ7PWJX/5rRJt0YXbPfN4u9pgX43oPDb8hV4NZxwLa9bsSbtk
         h76JR/rPLPbGpL5U1HlitHLR8cpBLmI7AQyggHR8EEX+Gz1OpFRrE6dIhsI/MKlHylvh
         hGgDLKELOD6kHtMFPCVd/Yt3h7tSwWCbe5LQm/U5Be/P1mZE0neYcCB7ez/Dl9BWOxU3
         t83qi1qQp/9P3qCUXMaiMSuLvAALaptwBa2KYz52lU2lGG71eme5uH5jxOtR3xkbnIuq
         BSVw==
X-Forwarded-Encrypted: i=1; AJvYcCXYC4yqVHaqJpHXVEsTuOu4p2vmpVsSg6FJ10Hp8P7ksG4OgwP70ZlMAukMNZHZcVehpT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvY6tiG83j0Huf+DjNpwuqlOiMv5OjLF2ip6WVfecEoQW4Zic0
	uzk4fE5/VVoafYBtTzGLh4jnumWJx5cMDbmaQmeCeVAYSsu1kAph1xo+F0/tcJGlHRyyhNLKcPw
	jwfsAq1o+ruZYUyObxi3Hx90q8dF0aPO+3ZbmH9tb
X-Gm-Gg: ASbGncuO2sqaC1KrK9V3XZb3umtYmAw11Eu7pZ9vFzbFIR+hXkOl+7b1fFqlo4oo7MR
	815BkaVCMUhJrSwqTJEQMs2CyZagmG7FQiNLVIxtRLpkWxk/QE1X+2BmWoYrKi2OaWwV98BDh4t
	dR801F7tGI8QD7zgPuYZQPMxtwdj6zK+6MZ00gvmMnO9q6
X-Google-Smtp-Source: AGHT+IGz7qYD3MLOkzKDUyyKjvvaPiJliOPXfnWKADod9dQ7d/qlG43TQQsvx5FNMeaXBQeuBvwVCG+Tbr8M3sTA7m0=
X-Received: by 2002:a17:902:d2c9:b0:216:4d90:47af with SMTP id
 d9443c01a7336-2341b559cb1mr1954595ad.29.1748195097126; Sun, 25 May 2025
 10:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <1747950086-1246773-3-git-send-email-tariqt@nvidia.com> <CAHS8izOUs-CEAzuBrE9rz_X5XHqJmWfrar8VtzrFJrS9=8zQLw@mail.gmail.com>
 <c677zoajklqi3dg7wtnyw65licssvxxt3lmz5hvzfw3sm6w32g@pfd2ynqjkyov>
In-Reply-To: <c677zoajklqi3dg7wtnyw65licssvxxt3lmz5hvzfw3sm6w32g@pfd2ynqjkyov>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 25 May 2025 10:44:43 -0700
X-Gm-Features: AX0GCFtdXkYKEpP6898csQCklxhoo91C4IqEXyK-lWaxbO_kBhPkxPiVpqQr_ws
Message-ID: <CAHS8izMM9Hgk12zhoc+ify1MBwepqByHKC3k1gB5daH=ancgqA@mail.gmail.com>
Subject: Re: [PATCH net-next V2 02/11] net: Add skb_can_coalesce for netmem
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 6:04=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> On Thu, May 22, 2025 at 04:09:35PM -0700, Mina Almasry wrote:
> > On Thu, May 22, 2025 at 2:43=E2=80=AFPM Tariq Toukan <tariqt@nvidia.com=
> wrote:
> > >
> > > From: Dragos Tatulea <dtatulea@nvidia.com>
> > >
> > > Allow drivers that have moved over to netmem to do fragment coalescin=
g.
> > >
> > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> > > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > > ---
> > >  include/linux/skbuff.h | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > > index 5520524c93bf..e8e2860183b4 100644
> > > --- a/include/linux/skbuff.h
> > > +++ b/include/linux/skbuff.h
> > > @@ -3887,6 +3887,18 @@ static inline bool skb_can_coalesce(struct sk_=
buff *skb, int i,
> > >         return false;
> > >  }
> > >
> > > +static inline bool skb_can_coalesce_netmem(struct sk_buff *skb, int =
i,
> > > +                                          const netmem_ref netmem, i=
nt off)
> > > +{
> > > +       if (i) {
> > > +               const skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i =
- 1];
> > > +
> > > +               return netmem =3D=3D skb_frag_netmem(frag) &&
> > > +                      off =3D=3D skb_frag_off(frag) + skb_frag_size(=
frag);
> > > +       }
> > > +       return false;
> > > +}
> > > +
> >
> > Can we limit the code duplication by changing skb_can_coalesce to call
> > skb_can_coalesce_netmem? Or is that too bad for perf?
> >
> > static inline bool skb_can_coalesce(struct sk_buff *skb, int i, const
> > struct page *page, int off) {
> >     skb_can_coalesce_netmem(skb, i, page_to_netmem(page), off);
> > }
> >
> > It's always safe to cast a page to netmem.
> >
> I think it makes sense and I don't see an issue with perf as everything
> stays inline and the cast should be free.
>
> As netmems are used only for rx and skb_zcopy() seems to be used
> only for tx (IIUC), maybe it makes sense to keep the skb_zcopy() check
> within skb_can_coalesce(). Like below. Any thoughts?
>

[net|dev]mems can now be in the TX path too:
https://lore.kernel.org/netdev/20250508004830.4100853-1-almasrymina@google.=
com/

And even without explicit TX support, IIUC from Kuba RX packets can
always be looped back to the TX path via forwarding or tc and what
not. So let's leave the skb_zcopy check in the common path for now
unless we're sure the move is safe.

--=20
Thanks,
Mina

