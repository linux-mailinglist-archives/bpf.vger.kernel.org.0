Return-Path: <bpf+bounces-64356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209C1B11BF3
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 12:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764263A4431
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D37F2E5419;
	Fri, 25 Jul 2025 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUb1qlPi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D531E2D5C73;
	Fri, 25 Jul 2025 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438188; cv=none; b=WEQW4sFiLrnazqTSWb6dDHpVBqHtHqFh0ySlT4VGkQh8NCZJmN+8Au7faSOazu/eTmlPu1SSTqjXn2u1FilG0vhiihjywn6f/Dnra1n4Xm/pFFvcHB2y3GMxG1+pa8K5NXQkmq5u+1i6wXv+hM/DlWketZ477N7GizzdFdi04rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438188; c=relaxed/simple;
	bh=6Xb36q4u8EaZ8wb3rw4qUH3bcyqJaHwWfUqfctwHZsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SErlwUmOitR/+8pBCSlk9qVASAniPYwZiKNrWAtAaHzN6znj5ZMsR8n+ejZlmrh7zxVOirQvvIaQ5yYJfcQo+9gu32woOCOafYc9yCgCdPR1SnjBzTqNhhyrngCKhRqpH1ZvIC2NLvc9xUdhRFFWNyWCpCgAthAluxLV0mc9XY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUb1qlPi; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3df210930f7so9012395ab.1;
        Fri, 25 Jul 2025 03:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753438186; x=1754042986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwcA7KaLuWYtPonBTfmTLOODFtpn/AAVVGlX14czsrM=;
        b=UUb1qlPiW7IYwttPsJTserggDs0Ffy8ybb8Dxqx0BGglJXqsapNuVi2iy6QDhwFV/K
         l1Gz34aKPHHGalDTKEjmVWb5oPIRXKL/Zztmnbnetd9lq8bwr04SAkCtpeca1nSQeHkM
         m3yBpfDArXniVuu1GFPnp4d0BAE4ISo2ASOJvZeArYf9V3WUwVkpeiX6YJ7mJDH5gL7D
         mWKyz76HLIezEm4JPZ8LKeUOqg+LSX27zgPyVIczEs8cePHyuBfu7C8l/HWKfdXcFpug
         XR3Jrc975xVZ891M85MoycYMOtomH0/gbu7FuRx6KhTN8TkYFjuqAITqdeIVokVzGJ+n
         sVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753438186; x=1754042986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwcA7KaLuWYtPonBTfmTLOODFtpn/AAVVGlX14czsrM=;
        b=qaEEzEZDJvyISEOpbE7ltBtOxyB8eK4O4wYip1yb0z1SoC8nO8K1GUQrtuBymJin+r
         C6/f3lC51kVDY8s1+ME1LbLfbtBszqHDy2r3FnX82bWkRCIDpycUGn6YrthvmJC9RIJ/
         eToaADmORhFtlL1uEgYja/mrud+Ju1XvPYAnSDnPoTnTRkl2/zeiAo/IikMAoy/vbue9
         9B2kt10FUQ2bMDV9mktmqyvAB1SVjti4s4cisYWhRTC3oVsHSorUq3M9MPSqQxkWBBfx
         VijfhhmiT3xiadywR/DfIIqtgYAwmP5SFWvf2+6AI8r56+7uST9eDy0HrWjp8HMmggjE
         uzRw==
X-Forwarded-Encrypted: i=1; AJvYcCUeBaUdl0OhbudUTnku8irXDvIbIxYCtIIvO1uV8izKVUb2qc/bQRoB0tTUEpsom6sEt4lOTVM0@vger.kernel.org, AJvYcCUwgZTgD5SrMMdOO/SEzVFiIJ6b7D0/NcJewyHg+tQwn9NgyaljIi9Q3ulBp/yqsL/jlmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyPgbzE4LxLT/+BRU4gIZ+k+LueEwJSwHnnMNZ3xDCeBz0i3uC
	K7iTdyE7bu0Z+6LjlS+fz3D35OqTn+HVNLPCJHPI1yHFnsBZK1H/UJuBnePyIz9zhsdW5PyMoo0
	HcEQ5Cj2q5TXHExCbAKqbbHSyBAFJn3w=
X-Gm-Gg: ASbGncvNBXoeTZHzKcdlsYgutc29gcjrdOJ56B0Lq6qolhFM3euO2zW6tNUBTVoyIoG
	eOfNQ97D3AfHTSUy7QIs1vgq3VGDc061W8JRsfNs/e1Rm6c1fMKIUWGzxy3wOwxOOCV1S9vk49w
	DfWlv7JECnSk+pHscJzfyG7mSSC+fvgFftzniOcQPQLcmYZcgBSCIO6vTEt4zpQmYBh2iATwLn+
	dkZwA==
X-Google-Smtp-Source: AGHT+IEO0oRKiqmhVxDLCyoaq6Ckc1LJb5SgD4c4cIiWyvJUUmxzm3g9+54zDbqRqx1SnUgOWUNKLXrgb4uvclj5GvY=
X-Received: by 2002:a05:6e02:268a:b0:3e2:c21d:ea12 with SMTP id
 e9e14a558f8ab-3e3c469e087mr21637465ab.7.1753438185698; Fri, 25 Jul 2025
 03:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720091123.474-1-kerneljasonxing@gmail.com>
 <20250720091123.474-6-kerneljasonxing@gmail.com> <aINVrP8vrxIkxhZr@boxer>
In-Reply-To: <aINVrP8vrxIkxhZr@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 25 Jul 2025 18:09:09 +0800
X-Gm-Features: Ac12FXxgQxWQ7KsFDT7kDoQDgYCj29bZVUsJjFV_BB_qO-IFkjocCpGIJmW1Hvo
Message-ID: <CAL+tcoD0W2owb211ZAO7M3qWU=EFGx+S9O7GNKidj0+oowfpdw@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] ixgbe: xsk: add TX multi-buffer support
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maciej,

On Fri, Jul 25, 2025 at 6:00=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sun, Jul 20, 2025 at 05:11:23PM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Use the common interface to see if the desc is the end of packets. If
> > so, set IXGBE_TXD_CMD_EOP bit instead of setting for all preceding
> > descriptors. This is also how i40e driver did in commit a92b96c4ae10
> > ("i40e: xsk: add TX multi-buffer support").
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++++
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 4 +++-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/ne=
t/ethernet/intel/ixgbe/ixgbe_main.c
> > index a59fd8f74b5e..c34737065f9e 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > @@ -52,6 +52,8 @@
> >  #include "ixgbe_txrx_common.h"
> >  #include "devlink/devlink.h"
> >
> > +#define IXGBE_MAX_BUFFER_TXD 4
> > +
> >  char ixgbe_driver_name[] =3D "ixgbe";
> >  static const char ixgbe_driver_string[] =3D
> >                             "Intel(R) 10 Gigabit PCI Express Network Dr=
iver";
> > @@ -11805,6 +11807,8 @@ static int ixgbe_probe(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
> >       netdev->xdp_features =3D NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_RE=
DIRECT |
> >                              NETDEV_XDP_ACT_XSK_ZEROCOPY;
> >
> > +     netdev->xdp_zc_max_segs =3D IXGBE_MAX_BUFFER_TXD;
>
> Hi Jason,
>
> nack to this as you would allow fragmented frames on Rx side which is not
> supported even with your patchset.

I'm not sure about this one, to be honest when I observed no
performance impact with this patch. How could we support the idea of
this patch, I wonder? Do we need to correspondingly adjust the
hardware? Sorry that I wasn't able to find such information in the
datasheet :(

>
> Generally ixgbe needs some love, i have several patches in my backlog plu=
s
> I think Larysa will be focusing on this driver.

Though ixgbe is an old driver, we still have thousands of machines
running with this driver. Looking forward to your patch then.

Thanks,
Jason

>
> please stick to enabling xsk batching on tx side.
>
> > +
> >       /* MTU range: 68 - 9710 */
> >       netdev->min_mtu =3D ETH_MIN_MTU;
> >       netdev->max_mtu =3D IXGBE_MAX_JUMBO_FRAME_SIZE - (ETH_HLEN + ETH_=
FCS_LEN);
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net=
/ethernet/intel/ixgbe/ixgbe_xsk.c
> > index 9fe2c4bf8bc5..3d9fa4f2403e 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > @@ -424,7 +424,9 @@ static void ixgbe_xmit_pkt(struct ixgbe_ring *xdp_r=
ing, struct xdp_desc *desc,
> >       cmd_type =3D IXGBE_ADVTXD_DTYP_DATA |
> >                  IXGBE_ADVTXD_DCMD_DEXT |
> >                  IXGBE_ADVTXD_DCMD_IFCS;
> > -     cmd_type |=3D desc[i].len | IXGBE_TXD_CMD_EOP;
> > +     cmd_type |=3D desc[i].len;
> > +     if (xsk_is_eop_desc(&desc[i]))
> > +             cmd_type |=3D IXGBE_TXD_CMD_EOP;
> >       tx_desc->read.cmd_type_len =3D cpu_to_le32(cmd_type);
> >       tx_desc->read.olinfo_status =3D
> >               cpu_to_le32(desc[i].len << IXGBE_ADVTXD_PAYLEN_SHIFT);
> > --
> > 2.41.3
> >

