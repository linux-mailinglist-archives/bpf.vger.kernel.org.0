Return-Path: <bpf+bounces-63387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F71BB069DD
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 01:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3473AB22E
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 23:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDF22D5C8E;
	Tue, 15 Jul 2025 23:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEufuYNy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF76218EBA;
	Tue, 15 Jul 2025 23:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752621929; cv=none; b=FyyRvJYX38Z0eW5m8Yb+nvDFlIw4be4TSppV4ViC5KEVGINESpUNSMY9bYhzvlLw1jePEKbTxa9Dek1BZWI1KxcOGZdsNARTMzibOgSBn6isfnaPev4dX7nQf4h2H4l0q6UNGudRfNucKQY7VTpBlSeehipt5Oi4q5li3VK/db4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752621929; c=relaxed/simple;
	bh=PnF+QZfrZx4uy23bWAMbSfboe2Pv15rSrLX8/R6LkGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAmQFn6wFCxCSvyz2p92aQlHG9Y3hcq1tbh+UMk6NXJ1lNJ4mjH56e469MyCvxxst7+MlXSB5BIi/teE4in5WjIQhGMgmfTHN1dilhbmAr//8jyqYY1aT0pj9hEqjZXeCaswiCQdLt4ELTPU550vZbj0UjmfRvMDudQf2T5cH+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEufuYNy; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ddd2710d14so51829635ab.2;
        Tue, 15 Jul 2025 16:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752621927; x=1753226727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2GaMtMUlQkMeFc3V+wOZRGegwVoKB3cqKkwwMoR1c0=;
        b=EEufuYNyk3znEt8tNSY5d6CNgBhdVGaxiOTJeGZsFA0VPZu/J6xiD2VI9puV2rY6cj
         v1xtHZmBC07Sq8Hx9rgxWd5LO6irUC4p0jowvG93gOVuu98d044f58O3eGwsvg7jER3l
         PX+1fNtl+tAUvsCBXnNhU5uoLeeqwtJpi4rh5BM6OcFQDdiiTn5YErIJkF+hRGfGVeLq
         +j6euapWkkggOoIqbNvgc+uAd6E+MVjBxbZoJ+zZa4yQ/AomCkXdRbzhZc/hx3YHIhXL
         D1d1rtb/ioHeUWbSJ8f+fOpFXV0eaBhwB97sTSrlpqJNlTocj7nuPxwDv0hPRaV+iVDr
         V0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752621927; x=1753226727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2GaMtMUlQkMeFc3V+wOZRGegwVoKB3cqKkwwMoR1c0=;
        b=Hly5ADR+BHxXCW+I+kGOxugmsW1grIYcagTzVE3FN6w84ag/3+59oFvuBmOiRMLoj7
         xdMgV24pju/W2t0W46Yml2N2te78OoaSrngs8IBMYkH+ML5+g9lgw2Koe+39SbLRldFf
         VAeKjWZ52vFJ+CrufqiXUkhSY31Puu7WtX+pQjnrrZV8OTHEGz5NmqNJT/n9d+QSD3Xx
         LbJNVQxYFr87aSsK1DnDavNVGRnqM6jE2JUOvxdykY+v+Kz9ToT/H2YMQsfWdqxH3Qjl
         6RhTBFtaJdeuGjT4HpIUhbqrGLI1d1g0Izv1xXgkSyPUXr7tsJAflwzMfOo5CtzEIYCv
         T+JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPvBiuZwDAz6Z1jcq35Euwch1XHgVxLcwwlBVP09XVl3qq6UF31gKkNjwmiO1nLGasAYo=@vger.kernel.org, AJvYcCUdeuVwiYoqVrYJHwhazqZThirt0/CdnOe2lge+vhPJ3p2vYRWeWojwqH97qNUD0fsahU6D/IHQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxnoP2IAu1RBouLFihGZudHwt2hrK66tFu9Bnuanvkqe65qug9f
	lD7WsrMuLTruamTy/ppZLx73dCafi+sB14yD1lZtECxq7o6dgJ9bnbHrpERVF1pBB8PzD2DJKb5
	jhWawWaK9A974YgyittH6QfaqQ3uQ/rg=
X-Gm-Gg: ASbGnctiswLmrLUfOJyphJphtGa/QL71dw+ULpa/TL4GSY5gPgL1pvWG8Mqh/q2RbwK
	OaOn+liAYDCNw2Mt4vkRcvkv9R+JlXi16AoIQ0VlCFuQ2rvXG+5mCK5/v1S+L/AEQJ+x0GQRphb
	t4ucyJNOMkC1m2r9jRE9X22VudmEUehVJ8Q+jXdkI2tcPtbHCY9Ihp4f8sluKVODq0ziOIb2KS1
	9mwW1U=
X-Google-Smtp-Source: AGHT+IFXNfnaKAlPKxOB52l6U0XJ4Xi0KnyFZAkvtlt/yRB7FIZdxp9QDpSH3xUIQuVa2odyhkU4T08blDT20FfTS6o=
X-Received: by 2002:a05:6e02:3b0a:b0:3df:4234:df7b with SMTP id
 e9e14a558f8ab-3e282d62ac7mr7522715ab.3.1752621926476; Tue, 15 Jul 2025
 16:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713025756.24601-1-kerneljasonxing@gmail.com>
 <aHUqR5_NoU8BYbz5@mini-arch> <CAL+tcoCiL0jjUO8RPiWX-+9VtjQm50ZeM5MQXn3Q6m+yNYryzQ@mail.gmail.com>
 <aHa9qLUtD3nR3Xl7@mini-arch>
In-Reply-To: <aHa9qLUtD3nR3Xl7@mini-arch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 16 Jul 2025 07:24:50 +0800
X-Gm-Features: Ac12FXx0o0gA9u13k3n_KY-QBIvNxXGJILCzX8HHYOCVsLP1om_6NiUPp9jgNOw
Message-ID: <CAL+tcoB1aBsB5EtgnrPg-t4CebU2ZFFDp8L-9DjRTeOuYGQ-GQ@mail.gmail.com>
Subject: Re: [PATCH net-next] xsk: skip validating skb list in xmit path
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, joe@dama.to, willemdebruijn.kernel@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 4:44=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 07/15, Jason Xing wrote:
> > On Tue, Jul 15, 2025 at 12:03=E2=80=AFAM Stanislav Fomichev
> > <stfomichev@gmail.com> wrote:
> > >
> > > On 07/13, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > For xsk, it's not needed to validate and check the skb in
> > > > validate_xmit_skb_list() in copy mode because xsk_build_skb() doesn=
't
> > > > and doesn't need to prepare those requisites to validate. Xsk is ju=
st
> > > > responsible for delivering raw data from userspace to the driver.
> > >
> > > So the __dev_direct_xmit was taken out of af_packet in commit 865b03f=
21162
> > > ("dev: packet: make packet_direct_xmit a common function"). And a cal=
l
> > > to validate_xmit_skb_list was added in 104ba78c9880 ("packet: on dire=
ct_xmit,
> > > limit tso and csum to supported devices") to support TSO. Since we do=
n't
> > > support tso/vlan offloads in xsk_build_skb, removing validate_xmit_sk=
b_list
> > > seems fair.
> >
> > Right, if you don't mind, I think I will copy&paste your words in the
> > next respin.
> >
> > >
> > > Although, again, if you care about performance, why not use zerocopy
> > > mode?
> >
> > I attached the performance impact because I'm working on the different
> > modes in xsk to see how it really behaves. You can take it as a kind
> > of investigation :)
> >
> > I like zc mode, but the fact is that:
> > 1) with ixgbe driver, my machine could totally lose connection as long
> > as the xsk tries to send packets. I'm still debugging it :(
> > 2) some customers using virtio_net don't have a supported host, so
> > copy mode is the only one choice.
> >
> > >
> > > > Skipping numerous checks somehow contributes to the transmission
> > > > especially in the extremely hot path.
> > > >
> > > > Performance-wise, I used './xdpsock -i enp2s0f0np0 -t  -S -s 64' to=
 verify
> > > > the guess and then measured on the machine with ixgbe driver. It st=
ably
> > > > goes up by 5.48%, which can be seen in the shown below:
> > > > Before:
> > > >  sock0@enp2s0f0np0:0 txonly xdp-skb
> > > >                    pps            pkts           1.00
> > > > rx                 0              0
> > > > tx                 1,187,410      3,513,536
> > > > After:
> > > >  sock0@enp2s0f0np0:0 txonly xdp-skb
> > > >                    pps            pkts           1.00
> > > > rx                 0              0
> > > > tx                 1,252,590      2,459,456
> > > >
> > > > This patch also removes total ~4% consumption which can be observed
> > > > by perf:
> > > > |--2.97%--validate_xmit_skb
> > > > |          |
> > > > |           --1.76%--netif_skb_features
> > > > |                     |
> > > > |                      --0.65%--skb_network_protocol
> > > > |
> > > > |--1.06%--validate_xmit_xfrm
> > >
> > > It is a bit surprising that mostly no-op validate_xmit_skb_list takes
> > > 4% of the cycles. netif_skb_features taking ~2%? Any idea why? Is
> > > it unoptimized kernel? Which driver is it?
> >
> > No idea on this one, sorry. I tested with different drivers (like
> > i40e) and it turned out to be nearly the same result.
>
> I was trying to follow validate_xmit_skb_list, but too many things
> happen in there. Although, without gso/vlan, most of these should
> be no-op. Plus you have xfrm compiled in. So still surprising, let's see
> if other people have any suggestions.
>
> > One of my machines looks like this:
> > # lspci -vv | grep -i ether
> > 02:00.0 Ethernet controller: Intel Corporation Ethernet Controller
> > 10-Gigabit X540-AT2 (rev 01)
> > 02:00.1 Ethernet controller: Intel Corporation Ethernet Controller
> > 10-Gigabit X540-AT2 (rev 01)
> > # lscpu
> > Architecture:                x86_64
> >   CPU op-mode(s):            32-bit, 64-bit
> >   Address sizes:             46 bits physical, 48 bits virtual
> >   Byte Order:                Little Endian
> > CPU(s):                      48
> >   On-line CPU(s) list:       0-47
> > Vendor ID:                   GenuineIntel
> >   BIOS Vendor ID:            Intel(R) Corporation
> >   Model name:                Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GHz
> >     BIOS Model name:         Intel(R) Xeon(R) CPU E5-2670 v3 @ 2.30GHz
> >  CPU @ 2.3GHz
> >     BIOS CPU family:         179
> >     CPU family:              6
> >     Model:                   63
> >     Thread(s) per core:      2
> >     Core(s) per socket:      12
> >     Socket(s):               2
> >     Stepping:                2
> >     CPU(s) scaling MHz:      96%
> >     CPU max MHz:             3100.0000
> >     CPU min MHz:             1200.0000
> >     BogoMIPS:                4589.31
> >     Flags:                   fpu vme de pse tsc msr pae mce cx8 apic
> > sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss
> > ht tm pbe syscall nx pdpe1gb rdtscp lm constant_ts
> >                              c arch_perfmon pebs bts rep_good nopl
> > xtopology nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor
> > ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm p
> >                              cid dca sse4_1 sse4_2 x2apic movbe popcnt
> > tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm cpuid_fault
> > epb intel_ppin ssbd ibrs ibpb stibp tpr_shadow fl
> >                              expriority ept vpid ept_ad fsgsbase
> > tsc_adjust bmi1 avx2 smep bmi2 erms invpcid cqm xsaveopt cqm_llc
> > cqm_occup_llc dtherm ida arat pln pts vnmi md_clear flush_l
> >                              1d
> >
> > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  include/linux/netdevice.h |  4 ++--
> > > >  net/core/dev.c            | 10 ++++++----
> > > >  net/xdp/xsk.c             |  2 +-
> > > >  3 files changed, 9 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > > index a80d21a14612..2df44c22406c 100644
> > > > --- a/include/linux/netdevice.h
> > > > +++ b/include/linux/netdevice.h
> > > > @@ -3351,7 +3351,7 @@ u16 dev_pick_tx_zero(struct net_device *dev, =
struct sk_buff *skb,
> > > >                    struct net_device *sb_dev);
> > > >
> > > >  int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_de=
v);
> > > > -int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
> > > > +int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id, bool vali=
date);
> > > >
> > > >  static inline int dev_queue_xmit(struct sk_buff *skb)
> > > >  {
> > > > @@ -3368,7 +3368,7 @@ static inline int dev_direct_xmit(struct sk_b=
uff *skb, u16 queue_id)
> > > >  {
> > > >       int ret;
> > > >
> > > > -     ret =3D __dev_direct_xmit(skb, queue_id);
> > > > +     ret =3D __dev_direct_xmit(skb, queue_id, true);
> > > >       if (!dev_xmit_complete(ret))
> > > >               kfree_skb(skb);
> > > >       return ret;
> > >
> > > Implementation wise, will it be better if we move a call to validate_=
xmit_skb_list
> > > from __dev_direct_xmit to dev_direct_xmit (and a few other callers of
> > > __dev_direct_xmit)? This will avoid the new flag.
> >
> > __dev_direct_xmit() helper was developed to serve the xsk type a few
> > years ago. For now it has only two callers. If we expect to avoid a
> > new parameter, we will also move the dev check[1] as below to the
> > callers of __dev_direct_xmit(). Then move validate_xmit_skb_list to
> > __dev_direct_xmit(). It's not that concise, I assume? I'm not sure if
> > I miss your point.
> >
> > [1]
> > if (unlikely(!netif_running(dev) ||  !netif_carrier_ok(dev)))
> >         goto drop;
>
> We can keep the check in its original place. I don't think the order of
> the checks matters? I was thinking something along these (untested)
> lines. Avoids one conditional in each path (not that it matters)..

Sorry, in my point of view, one additional flag is really not a big
deal even though it is on the hot path. A new flag doesn't cause any
side effects at all, does it? On the contrary, running on top of the
following code snippet, if the netdevice is down, dev_direct_xmit()
will take a lot of time to run validate_xmit_skb_list() before two
simple device if-statements.

Since the status of the patch was marked 'changed-requested', I will
send a v2 as you requested.

Thanks,
Jason

>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index e6131c529af4..36cdeef6a5e9 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3367,8 +3367,15 @@ static inline int dev_queue_xmit_accel(struct sk_b=
uff *skb,
>
>  static inline int dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
>  {
> +       struct sk_buff *orig_skb =3D skb;
> +       bool again =3D false;
>         int ret;
>
> +       skb =3D validate_xmit_skb_list(skb, dev, &again);
> +       if (skb !=3D orig_skb) {
> +               /* dropped_inc and kfree */
> +       }
> +
>         ret =3D __dev_direct_xmit(skb, queue_id);
>         if (!dev_xmit_complete(ret))
>                 kfree_skb(skb);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 26253802f6cd..d3b9a75852fd 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4744,19 +4744,13 @@ EXPORT_SYMBOL(__dev_queue_xmit);
>  int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
>  {
>         struct net_device *dev =3D skb->dev;
> -       struct sk_buff *orig_skb =3D skb;
>         struct netdev_queue *txq;
>         int ret =3D NETDEV_TX_BUSY;
> -       bool again =3D false;
>
>         if (unlikely(!netif_running(dev) ||
>                      !netif_carrier_ok(dev)))
>                 goto drop;
>
> -       skb =3D validate_xmit_skb_list(skb, dev, &again);
> -       if (skb !=3D orig_skb)
> -               goto drop;
> -
>         skb_set_queue_mapping(skb, queue_id);
>         txq =3D skb_get_tx_queue(dev, skb);
>

