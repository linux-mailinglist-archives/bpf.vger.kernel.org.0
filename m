Return-Path: <bpf+bounces-65813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B0CB28E3A
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 15:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9976B17400B
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 13:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143A82E7F1F;
	Sat, 16 Aug 2025 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2MRwElQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D1128D8E2;
	Sat, 16 Aug 2025 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755351760; cv=none; b=MyXboRm+TFd7gmBfzLtPGbRyBphHILqHQrv8NZnNWAufMkIv88hKBX7UsJjowEwykr6fkjMuQoUk17W82pVDtit9qlZZPxQJvnLQYmffvbPkA9jxV6IXzlCtqMG7wUc6K7WoILeMXF+k7cIhm2prnWOqq3jIW7s7ErkZgk8mFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755351760; c=relaxed/simple;
	bh=OZuIaBOmedKot2HOsJWKoMXa9XSUijkvkJIkaVqOWRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4xNbRGtv8ETwRGDF2tcpGSNMneuwvQgqfUXfPPxQtb0XQCQlHn7VLIyUecI911DNlmBryTdFBPiOjHiOD3o362Cw0VyHNqVro3JtPDI5JLUCZXWuRsMstzeAynigUL5HwM0mPmaD7CwGGAeAs9k49+MU9X2Zvpe8vvIZjnHB6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2MRwElQ; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3e61c51f1d6so5424255ab.1;
        Sat, 16 Aug 2025 06:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755351757; x=1755956557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhmKQzcOekZzAwdLyZWpxh49oR8IKfZ2izyiE0R8FjQ=;
        b=Y2MRwElQqN1tf58xyEsIXmKGpog9i1fAz0fSHktuADHQRqlL89IYGNq/gAWO68fVFb
         4mBRDGK4WdPDG/miRBO/QpQP33a0JGmBBOH6I/SBdbTtmyAvSB3k3GAVaPZAG+GTE6nc
         bFORsxbFxaoPflJ0/B5bCic8mu5sKO6kf1Qz04lt+VH7GFmYecL4S+0Y6mhsm5DSBTdq
         UgvwFHn2uq3CsXKXKM4k97VlJVtzy+w+HzZr93+zUCM8frO23HBTK5/qQuWZ8CT7ZSE8
         mjjNqkNiC2U5PdiwSwB69YOwuMPooWFU7+oNliuYnOnejATRzokE8JGhTF9Ph4efPxBk
         5Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755351757; x=1755956557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhmKQzcOekZzAwdLyZWpxh49oR8IKfZ2izyiE0R8FjQ=;
        b=r8J/tKOsuXh5huGWNHhAT0E/QCcKHViMrKEaP7JOX4WpcpIdnXtiLykHfAcPPEhbgv
         YhU/d3qON9cjFsWhKspR81Pq/zopbJNOX+WrEeVYdGj6JZzVyMZbeNSOxuYiSNZU/yW3
         1wl/AWYXS08Tcn+yNiGPkK9WnVjvHcyLxR7oKqq4k4WWdgR28P6DsoIWDfKNjrP7G7Sw
         B596KFsp55FzVm5E6txjMkXVKu/hg9c08CZLlgqXoVQRNObiisooiDsjDhedQQsPJbx8
         g9BeSo7J/gv6jNpfEabHkP0tm6ituwuDi2sOvoGpTCa7NyKKQbKwCl1+vK1cihZZeUh5
         ORmA==
X-Forwarded-Encrypted: i=1; AJvYcCWc7CbrAY5EB51hnYUucrWcobWCSotjk9wTNvsYgAs5T4Jj5wyhY+n4WCwN4pSjEjSQSqxy1a/U@vger.kernel.org, AJvYcCXWwVeYz7sZ5aJPQhtPQTQh0pEvvB9VU/oqjHIZy2rBBhU9eJNfg0axLko7Z0lwhyVIfpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGU1dLUQ17Dq9rlavTY57oLFxX0bPTJ4fq/c7cP03qqjUgYM/K
	NTZWaE3Kb4pVLa/BcmA72Gh9g0yefWnutEPvg6INGINMdoHJ3Oo+/iP63PjleMG6gfvwlQ/GJ5A
	wch0fZuBRVXUNRJxltbK4Tlgc04X6C9c=
X-Gm-Gg: ASbGncu9buqeea8CTcrHoJI22/g8p4ZqXLx8ur4TNVXg6Mox5ajUjx1AB+DP9Df8PEl
	TpuHb94C4Wenh7UDyaDb3lC0REh0j5MLtgTh3vPtsmyrF4Gr0dLZRhFCpG0ygCO8UAE3eGrNR5V
	l6hfm9fQevyCtA5gw6oI8GbZvqvSL4Nr/kBAQKhQlhchjnEneliE3g11oF8OQfwkFRKPRqmcGB8
	9MndXM=
X-Google-Smtp-Source: AGHT+IHH7XwMu22VqN8X1d22sZYSxl3Qydm+Sk+uYhQNpR1xVQiDNqZCD9ceBV25RdiTZMPsN4pV9REjhQrznmB0GmU=
X-Received: by 2002:a05:6e02:4710:b0:3e5:8169:e14 with SMTP id
 e9e14a558f8ab-3e581691195mr94371055ab.12.1755351757444; Sat, 16 Aug 2025
 06:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811131236.56206-1-kerneljasonxing@gmail.com>
 <20250811131236.56206-3-kerneljasonxing@gmail.com> <b07b8930-e644-45a2-bef8-06f4494e7a39@kernel.org>
 <aJt+kBqXT/RgLGvR@boxer> <CAL+tcoBrT7WnPP9c+fhRxYyqyf0dZsMAP9=ghvcWRc2rTsF3Ag@mail.gmail.com>
 <CAL+tcoAst1xs=xCLykUoj1=Vj-0LtVyK-qrcDyoy4mQrHgW1kg@mail.gmail.com>
 <d34bf5f5-9626-442d-bdd2-b3ada51d556e@kernel.org> <CAL+tcoAesfv_SmkQCpijVRM0YRAg9ujYuX4gL1UD3QnjWhD0dw@mail.gmail.com>
In-Reply-To: <CAL+tcoAesfv_SmkQCpijVRM0YRAg9ujYuX4gL1UD3QnjWhD0dw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 16 Aug 2025 21:42:01 +0800
X-Gm-Features: Ac12FXxdrPMmbSfqMenW8gArV3RmF6TjcjiBRf0ABErnKgqCd1msM0qParzCdSY
Message-ID: <CAL+tcoDAa=4c4tQDH4WZ8T7MZqmsw1Q3ZgV7fOwNtaQRVuY-aA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] xsk: support generic batch xmit in copy mode
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 8:03=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Sat, Aug 16, 2025 at 12:40=E2=80=AFAM Jesper Dangaard Brouer <hawk@ker=
nel.org> wrote:
> >
> >
> >
> > On 13/08/2025 15.06, Jason Xing wrote:
> > > On Wed, Aug 13, 2025 at 9:02=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > >>
> > >> On Wed, Aug 13, 2025 at 1:49=E2=80=AFAM Maciej Fijalkowski
> > >> <maciej.fijalkowski@intel.com> wrote:
> > >>>
> > >>> On Tue, Aug 12, 2025 at 04:30:03PM +0200, Jesper Dangaard Brouer wr=
ote:
> > >>>>
> > >>>>
> > >>>> On 11/08/2025 15.12, Jason Xing wrote:
> > >>>>> From: Jason Xing <kernelxing@tencent.com>
> > >>>>>
> > >>>>> Zerocopy mode has a good feature named multi buffer while copy mo=
de has
> > >>>>> to transmit skb one by one like normal flows. The latter might lo=
se the
> > >>>>> bypass power to some extent because of grabbing/releasing the sam=
e tx
> > >>>>> queue lock and disabling/enabling bh and stuff on a packet basis.
> > >>>>> Contending the same queue lock will bring a worse result.
> > >>>>>
> > >>>>
> > >>>> I actually think that it is worth optimizing the non-zerocopy mode=
 for
> > >>>> AF_XDP.  My use-case was virtual net_devices like veth.
> > >>>>
> > >>>>
> > >>>>> This patch supports batch feature by permitting owning the queue =
lock to
> > >>>>> send the generic_xmit_batch number of packets at one time. To fur=
ther
> > >>>>> achieve a better result, some codes[1] are removed on purpose fro=
m
> > >>>>> xsk_direct_xmit_batch() as referred to __dev_direct_xmit().
> > >>>>>
> > >>>>> [1]
> > >>>>> 1. advance the device check to granularity of sendto syscall.
> > >>>>> 2. remove validating packets because of its uselessness.
> > >>>>> 3. remove operation of softnet_data.xmit.recursion because it's n=
ot
> > >>>>>      necessary.
> > >>>>> 4. remove BQL flow control. We don't need to do BQL control becau=
se it
> > >>>>>      probably limit the speed. An ideal scenario is to use a stan=
dalone and
> > >>>>>      clean tx queue to send packets only for xsk. Less competitio=
n shows
> > >>>>>      better performance results.
> > >>>>>
> > >>>>> Experiments:
> > >>>>> 1) Tested on virtio_net:
> > >>>>
> > >>>> If you also want to test on veth, then an optimization is to incre=
ase
> > >>>> dev->needed_headroom to XDP_PACKET_HEADROOM (256), as this avoids =
non-zc
> > >>>> AF_XDP packets getting reallocated by veth driver. I never complet=
ed
> > >>>> upstreaming this[1] before I left Red Hat.  (virtio_net might also=
 benefit)
> > >>>>
> > >>>>   [1] https://github.com/xdp-project/xdp-project/blob/main/areas/c=
ore/veth_benchmark04.org
> > >>>>
> > >>>>
> > >>>> (more below...)
> > >>>>
> > >>>>> With this patch series applied, the performance number of xdpsock=
[2] goes
> > >>>>> up by 33%. Before, it was 767743 pps; while after it was 1021486 =
pps.
> > >>>>> If we test with another thread competing the same queue, a 28% in=
crease
> > >>>>> (from 405466 pps to 521076 pps) can be observed.
> > >>>>> 2) Tested on ixgbe:
> > >>>>> The results of zerocopy and copy mode are respectively 1303277 pp=
s and
> > >>>>> 1187347 pps. After this socket option took effect, copy mode reac=
hes
> > >>>>> 1472367 which was higher than zerocopy mode impressively.
> > >>>>>
> > >>>>> [2]: ./xdpsock -i eth1 -t  -S -s 64
> > >>>>>
> > >>>>> It's worth mentioning batch process might bring high latency in c=
ertain
> > >>>>> cases. The recommended value is 32.
> > >>>
> > >>> Given the issue I spotted on your ixgbe batching patch, the compari=
son
> > >>> against zc performance is probably not reliable.
> > >>
> > >> I have to clarify the thing: zc performance was tested without that
> > >> series applied. That means without that series, the number is 130327=
7
> > >> pps. What I used is './xdpsock -i enp2s0f0np0 -t -q 11  -z -s 64'.
> > >
> >
> > My i40e device is running at 40Gbit/s.
> > I see significantly higher packet per sec (pps) that you are reporting:
> >
> > $ sudo ./xdpsock -i i40e2 --txonly -q 2 -z -s 64
> >
> >   sock0@i40e2:2 txonly xdp-drv
> >                     pps            pkts           1.00
> > rx                 0              0
> > tx                 21,546,859     21,552,896
> >
> >
> > The "copy" mode (-c/--copy) looks like this:
> >
> > $ sudo ./xdpsock -i i40e2 --txonly -q 2 --copy -s 64
> >
> >   sock0@i40e2:2 txonly xdp-drv
> >                     pps            pkts           1.00
> > rx                 0              0
> > tx                 2,135,424      2,136,192
> >
> >
> > The skb-mode (-S, --xdp-skb) looks like this:
> >
> > $ sudo ./xdpsock -i i40e2 --txonly -q 2 --xdp-skb -s 64
> >
> >   sock0@i40e2:2 txonly xdp-skb
> >                     pps            pkts           1.00
> > rx                 0              0
> > tx                 2,187,992      2,188,800
> >
> >
> > The HUGE performance gap to "xdp-drv" zero-copy mode, tells me that
> > there is a huge potential for improving the performance for the copy
> > mode, both "native" xdp-drv and xdp-skb, cases.
> > Thus, the work your are doing here is important.
>
> Great! Thanks for your affirmation.
>
> >
> >
> > > ------
> > > @Maciej Fijalkowski
> > > Interesting thing is that copy mode is way worse than zerocopy if the
> > > nic is _i40e_.
> > >
> > > With ixgbe, even copy mode reaches nearly 50-60% of the full speed
> > > (which is only 1Gb/sec) while either zc or batch version copy mode
> > > reaches 70%.
> > > With i40e, copy mode only reaches nearly 9% while zc mode 70%. i40e
> > > has a much faster speed (10Gb/sec) comparatively.
> > >
> > > Here are some summaries (budget 32, batch 32):
> > >                 copy       batch         zc
> > > i40e       1,777,859   2,102,579   14,880,643
> > > ixgbe      1,187,347   1,472,367    1,303,277
> > >
> > (added thousands separators to make above readable)
> >
> > Those number only make sense if
> >   i40e runs at link speed 10Git/s and
> >   ixgbe runs at link speed 1Gbit/s
> >
> >
> > > For i40e, here are numbers around the batch copy mode (budget is 128)=
:
> > > no batch       batch 64
> > > 1825027      2228328.
> > > Side note: 2228328 seems to be the max limit in copy mode with this
> > > series applied after testing with different settings.
> > >
> > > It turns out that testing on i40e is definitely needed because the
> > > xdpsock test hits the bottleneck on ixgbe.
> > >
> > > -----
> > > @Jesper Dangaard Brouer
> > > In terms of the 'more' boolean as Jesper said, related drivers might
> > > need changes like this because in the 'for' loop of the batch process
> > > in xsk_direct_xmit_batch(), drivers may fail to send and then break
> > > the 'for' loop, which leads to no chance to kick the hardware.
> >
> > If sending with 'more' indicator and driver fail to send, then it is th=
e
> > responsibility of the driver to update the tail-ptr/doorbell.
> > Example for ixgbe driver:
> >   https://elixir.bootlin.com/linux/v6.16/source/drivers/net/ethernet/in=
tel/ixgbe/ixgbe_main.c#L8879-L8880
>
> Thanks for sharing this. I'm learning :)
>
> >
> > > Or we
> > > can keep trying to send in xsk_direct_xmit_batch() instead of breakin=
g
> > > immediately even if the driver becomes busy right now.
> > >
> > > As to ixgbe, the performance doesn't improve as I analyzed (because i=
t
> > > already reaches 70% of full speed).
> > >
> >
> > If ixgbe runs at 1Gbit/s then remember Ethernet wire-speed is 1.488
> > Mpps. Thus, you are much closer than 70% to wire-speed.
>
> Right. 70% probably is the maximum number that xdpsock can reach.
>
> >
> >
> > > As to i40e, only adding 'more' logic, the number goes from 2102579 to
> > > 2585224 with the 32 batch and 32 budget settings. The number goes fro=
m
> > > 2200013 to 2697313 with the  batch and 64 budget settings. See! 22+%
> > > improvement!
> >
> > That is a very big performance gain IMHO. Shows that avoiding the tail-
> > ptr/doorbell between each packet have a huge benefit.
>
> That's right, and I will include it into the series as you suggested. Tha=
nks!
>
> >
> > > As to virtio_net, no obvious change here probably because the hardirq
> > > logic doesn't have a huge effect.
> > >
> >
> > Perhaps virtio_net doesn't implement the SKB 'more' feature?
>
> Oh, let me investigate it more deeply.

Here I'm going to update two things:

#1
Virtio_net driver does implement the more feature at the link:
https://elixir.bootlin.com/linux/v6.16/source/drivers/net/virtio_net.c#L335=
2

If there is 'more' indicator without setting __QUEUE_STATE_DRV_XOFF,
then driver will not notify the host.

#2
As to the previous question about xsk that might fail to sense the
BUSY error from the driver, I double checked and saw it can be
problematic:
i40e_xmit_frame_ring()
    -> if (i40e_maybe_stop_tx(tx_ring, count + 4 + 1)) {
              return NETDEV_TX_BUSY;
It means that at the very beginning of driver sending packets on i40e
driver, it might be stopped due to the above case in the middle of
sending a number of packets even in the normal sending process (see
dev_hard_start_xmit()). Then the qdisc will miss the opportunity to
ask the driver to kick. The same situation could be applied to this
xsk batch xmit.

Notice that the case is different from the BQL limit and check in
ixgbe_tx_map() (see the link you mentioned). We cannot prevent it
because DQL algo might not stop sending packets but the above code
snippet can. I checked mlx4 and mlx5 and didn't spot any chance where
the BUSY value could be returned in the xmit process.

So I wonder if we fix the problem from the driver side like this
regardless of the current batch xmit:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 048c33039130..81cc2219632b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -3904,6 +3904,7 @@ static netdev_tx_t i40e_xmit_frame_ring(struct
sk_buff *skb,
         */
        if (i40e_maybe_stop_tx(tx_ring, count + 4 + 1)) {
                tx_ring->tx_stats.tx_busy++;
+               writel(tx_ring->next_to_use, tx_ring->tail);
                return NETDEV_TX_BUSY;
        }

If so, there are a few drivers needing to be adjusted... I'm not sure
if I'm moving in the right direction...

Thanks,
Jason

>
> BTW, I'm not sure if you missed the previous last email, what do you
> think of socket level accounting after reading that reply?
>
> Thanks,
> Jason
>
> >
> > --Jesper
> >

