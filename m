Return-Path: <bpf+bounces-64374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8185CB11E65
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 14:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB53F587C6F
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 12:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FC22E4256;
	Fri, 25 Jul 2025 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK88I0VG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550272D3A64;
	Fri, 25 Jul 2025 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446101; cv=none; b=SzXhFykFQ70fRGlTjWC3qH28xMQecfNIXzxeZHbd3nDBgD4eCHEcvFP9wZqPeHHiSenBPCLUMOldmAf7yveyt5Rxmtam4oo/375uwwJe0umO3JG2ufxEdph8dBMnd8iKbe6kyDmJHZw5YV+xTlQdUSpLqqLuhaYxk231eW1WgiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446101; c=relaxed/simple;
	bh=xACj9feXS1RmWrfFyYHVI74fN/xzs9DHaqDK5WLfzRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKi6kMqwWQB4+/Nbe/XyQ58W1MIpZTFkmBrJvlHGfNqZgXGZgpUlrVKK+v6LMonXqNYT7D11CFiEBxIHDEolxcK0ySccBy5H9sUzljr5HEV5ZxeU1HzCjNMRdCk9MxEQ3gtejDgP6cLyEYZfW0gxFEJKbB4TbZqPDRPh0ybuxsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BK88I0VG; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3da73df6c4eso15557465ab.0;
        Fri, 25 Jul 2025 05:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753446099; x=1754050899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W13LH+UK8D4i4jKHiisS0BChwj6oA7twJsq3FXAduDw=;
        b=BK88I0VGIhBWl0N9wS6AFdDibihGiCzgegLSx/PjtxNjUkyYNZFW5aJx1+YpvF9W18
         P4F5dPSFp5R4A5TCneU1lEcufYtrn5tf8h3ss+WIwEnOk0OV7QgEsGL1DnnqLt70lQQu
         9MbNeMmaizcnmvpmXx3elvXuUpTkuPUs84QSk1hBYirTZwOR3ZnH3sVsYtYDsuBRLSCC
         BwuKSCF4d/Yec7BU6BsnDMoa8bOl+kl1YtphY9GBo6rK5FTtc1cqOxUy+6NhCuGN6GBh
         ym0bGqQYByMMtPZ6gAuGdfDeKAarI7RvMDyJ6kpjevDp8lMYBa9dSmKRee28yYw0t3Gb
         pE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753446099; x=1754050899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W13LH+UK8D4i4jKHiisS0BChwj6oA7twJsq3FXAduDw=;
        b=b1q0N2Gk4q/9N5McRhcTwe2EGrG/IjQKAwpEQgKDBaVqYmDQVb7KkWG55seiCh+N2/
         iWbs/2+LsuVev5MXj4XmMWpZp/z47bmePjzp9BDNfhg7xLjubRm21JKxUP7G8sUI7J1D
         YP9BukmY66JQ8ydIM59JVC6N6BMma6R+1wFAwJRzFPF/jXDYz1I18UWWmE37gCbPmxmg
         JV6NVS/0N4FznyhLvG6wZfTvBj3kKqrS6ihyZtozT4FVw0G2SwAYDieQGq3GrGjUYjLD
         DphBtpI8fY+h+F+3YLzkYhadvrYVvD0BlgMIAfX9SQ+49895DeZdfvG3ak/eg+VvlMA9
         9rnw==
X-Forwarded-Encrypted: i=1; AJvYcCWwhLP+LEd5lNi2yAnLZOXsOjagmUe9FPUDRGO64nXQRo6gwTWB/BDX7MOcw02uFXgoZpQ=@vger.kernel.org, AJvYcCXjC5plcOw24+cmTRKcXQCG377B9fe+zrYSYe2Ba8kHp6q3emxUj3qs+lyQq9UojlRRtLqMhL1g@vger.kernel.org
X-Gm-Message-State: AOJu0YwwOiauGlI13xs1RpEPn61Z01lOzZXwSge3ZV4ontUjYLyIOKRn
	mrVdp2mNwBnGjMb+vNyDi74Zcf7xgiv1WZBBeaLWsSMU21Hg3Fe5P69uU5XTxQFDR4VQ8HNDFK9
	5cx4UlvGSxAat8RyR1kA65gcpbMMzhqc=
X-Gm-Gg: ASbGncucwvRieriUadXdvHdix1WL7IJJpix/hPc9mgxsNfClGJMWIkCJ0dh5u2o0pfE
	ydpcxOWawB/A98Uyf3Vw2G3A5wrKUbUu/VceN4Ol7uTQdfamodXS2Rx6tEO7GPMnwCCF6NAj4AV
	E1ULkTA0tFE5iVLhuS440VeC7F5Moei7So4r2oWwMNFeDEK0V4eI1KvQN0jBUdw63iovu6LyKWx
	uOYDg==
X-Google-Smtp-Source: AGHT+IEPIShuk+mVCS1GaQLe/6O7xiKmk84XLA/bOK+4kE+w2xf49d8oU58Vp8hWb5S0e5KbfWFQJv2soLssESkheIQ=
X-Received: by 2002:a05:6e02:3f03:b0:3e2:dc2e:85d8 with SMTP id
 e9e14a558f8ab-3e3c5377a21mr22661995ab.19.1753446099355; Fri, 25 Jul 2025
 05:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720091123.474-1-kerneljasonxing@gmail.com>
 <20250720091123.474-4-kerneljasonxing@gmail.com> <aINSDD1BezlEn_gM@soc-5CG4396X81.clients.intel.com>
In-Reply-To: <aINSDD1BezlEn_gM@soc-5CG4396X81.clients.intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 25 Jul 2025 20:21:03 +0800
X-Gm-Features: Ac12FXwsLiHwfDK_OwTHMCzcEIzX9OGtl7zZ6hoqgP_leACZAesBwzcjUmkIDzo
Message-ID: <CAL+tcoAUW_J62aw3aGBru+0GmaTjoom1qu8Y=aiSc9EGU09Nww@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] ixgbe: xsk: use ixgbe_desc_unused as the
 budget in ixgbe_xmit_zc
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 5:45=E2=80=AFPM Larysa Zaremba <larysa.zaremba@inte=
l.com> wrote:
>
> On Sun, Jul 20, 2025 at 05:11:21PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > - Adjust ixgbe_desc_unused as the budget value.
> > - Avoid checking desc_unused over and over again in the loop.
> >
> > The patch makes ixgbe follow i40e driver that was done in commit
> > 1fd972ebe523 ("i40e: move check of full Tx ring to outside of send loop=
").
> > [ Note that the above i40e patch has problem when ixgbe_desc_unused(tx_=
ring)
> > returns zero. The zero value as the budget value means we don't have an=
y
> > possible descs to be sent, so it should return true instead to tell the
> > napi poll not to launch another poll to handle tx packets.
>
> I do not think such reasoning is correct. If you look at the current matu=
re
> implementation in i40e and ice, it always returns (nb_pkts < budget), so =
when
> the budget is `0`, the napi will always be rescheduled. Zero unused descr=
iptors

Sorry, I'm afraid I don't think so. In ice_xmit_zc(), if the budget is
zero, it will return true because of the following codes:
nb_pkts =3D xsk_tx_peek_release_desc_batch(xsk_pool, budget);
if (!nb_pkts)
        return true;

Supposing there is no single desc in the tx ring, the budget will
always be zero even when the napi poll is triggered.

Thanks,
Jason

> means that the entire ring is held by HW, so it makes sense to retry to
> reclaim some resources ASAP. Also, zero unused normal descriptors does no=
t mean
> there is no UMEM descriptors to process.
>
> Please, remove the following lines and the patch should be fine:
>
> +     if (!budget)
> +             return true;
>
> > Even though
> > that patch behaves correctly by returning true in this case, it happens
> > because of the unexpected underflow of the budget. Taking the current
> > version of i40e_xmit_zc() as an example, it returns true as expected. ]
> > Hence, this patch adds a standalone if statement of zero budget in fron=
t
> > of ixgbe_xmit_zc() as explained before.
> >
> > Use ixgbe_desc_unused to replace the original fixed budget with the num=
ber
> > of available slots in the Tx ring. It can gain some performance.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net=
/ethernet/intel/ixgbe/ixgbe_xsk.c
> > index a463c5ac9c7c..f3d3f5c1cdc7 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > @@ -393,17 +393,14 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_=
ring, unsigned int budget)
> >       struct xsk_buff_pool *pool =3D xdp_ring->xsk_pool;
> >       union ixgbe_adv_tx_desc *tx_desc =3D NULL;
> >       struct ixgbe_tx_buffer *tx_bi;
> > -     bool work_done =3D true;
> >       struct xdp_desc desc;
> >       dma_addr_t dma;
> >       u32 cmd_type;
> >
> > -     while (likely(budget)) {
> > -             if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
> > -                     work_done =3D false;
> > -                     break;
> > -             }
> > +     if (!budget)
> > +             return true;
> >
> > +     while (likely(budget)) {
> >               if (!netif_carrier_ok(xdp_ring->netdev))
> >                       break;
> >
> > @@ -442,7 +439,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ri=
ng, unsigned int budget)
> >               xsk_tx_release(pool);
> >       }
> >
> > -     return !!budget && work_done;
> > +     return !!budget;
> >  }
> >
> >  static void ixgbe_clean_xdp_tx_buffer(struct ixgbe_ring *tx_ring,
> > @@ -505,7 +502,7 @@ bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *=
q_vector,
> >       if (xsk_uses_need_wakeup(pool))
> >               xsk_set_tx_need_wakeup(pool);
> >
> > -     return ixgbe_xmit_zc(tx_ring, q_vector->tx.work_limit);
> > +     return ixgbe_xmit_zc(tx_ring, ixgbe_desc_unused(tx_ring));
> >  }
> >
> >  int ixgbe_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
> > --
> > 2.41.3
> >
> >

