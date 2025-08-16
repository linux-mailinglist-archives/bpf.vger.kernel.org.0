Return-Path: <bpf+bounces-65797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFF6B28902
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 02:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D09E7A9B4A
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 00:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92FC23DE;
	Sat, 16 Aug 2025 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsrBEdKi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA473208;
	Sat, 16 Aug 2025 00:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302620; cv=none; b=nnXNMJCgKQi8Y4vrfW2v9+ndZf6l+75fgtFteyNEKX0H1h1L0GQlJJFTobJ1iQyv6+1DlU+da9WYwDmv4IVxQJAJVRIcnNQWmVv8a9IVgBGLS6g5d3JRncCeZ2upo2qWl/xnq5fXf1sJ6IUWJfzt4FWUDYb7U3e1tRUUnu9nSls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302620; c=relaxed/simple;
	bh=6XncJXKXHXIOKvYZZECDIMij/FvpiGfYxLAnoc/pj8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpjUeIMXUUHq/ZRwkgkaWeBzH2LjnBgfEmTMnfS7GU4b6wq5vvIT94Z+o4uOua9u4ZRFYK4ZPuTr1TeTHa3GMrz+qNkUa95/tnXwKR1KE+aAY0v3Red/cX1PlwOXSR+42M1BVWe7XhK70geiKySXg2uFvulpuOtAIZiYTS7uD80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsrBEdKi; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e584a51a3fso580915ab.2;
        Fri, 15 Aug 2025 17:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755302617; x=1755907417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kc8sqh2x1VrQ8A0LrTywTYFGnzuhVgf0glcrmNBYGR8=;
        b=FsrBEdKib6FSzOF5X6Kdbpe7o8x0LhKtyA5nxnRJefh7PANSBjEYP7ZrhkZC00mf5Q
         PwmEUZ8LnhoraczwkjGghdcb+/AcebH9E7L4tgyA9PuRjmCJqjklYVAi94O5RIWGTuGz
         rsivut/jyr1+bbWKM+Hutgv9ovMTPKDXF4Q8YBS77BrT3cBmKDMMAV7OP/5kgn7egH3v
         nf69ZTQ7tx6tFOQ4JKXhH80Oy+DcWkUC1RBfgAOekksFDiO3zPqcRxNrgO8dAZPSOyBQ
         5WM7svueIfbzQYYgmke0yVycj8oY3osjAG1OJlwZ/MZ+rA0IWHPsjNRbSFB1bkn/pSKm
         D9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755302617; x=1755907417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kc8sqh2x1VrQ8A0LrTywTYFGnzuhVgf0glcrmNBYGR8=;
        b=BTj3M95J3CR8gTSFI4igMrnCsF1Kby/jlqKrGuUb+sHtK9/WnuHqxiDfNBieRiBmKS
         vNQLBVvYHhMSO0lmgY/6jyG9Aa82WU2O0csuIeHPwtLXk3sBR2Erci88/IjVQAHREZ3/
         2yHD0rVo3HbAc2Q7aZ2eu7MMNBZQiaNjQgfwPvIxyTqusHjGN13MGivSeCdDWpHaS0na
         UOuHQ1K6aO7JhIJRRFrifUIt+30VifzYUI3Z6QDtTjhnLslbf/7y4nkHHT6z/mems6jV
         jaJ6Ca4Q8PauHEofobwXyZCjNpHcCL1k1RA9LkXaFv2TaK3FFL4g8zS4SYoANmHXRqr2
         GpVA==
X-Forwarded-Encrypted: i=1; AJvYcCUFJw5UMYlOQk7evCRtH34a8phr2KLRJcu6+0xWbUaz5s7QgBuvHee5iOJQkIq4x5CMKQGAyzwP@vger.kernel.org, AJvYcCVkpS0opVFRqebCHWHSLcsqstrY7y20OwbTsYvIN+wVIfG6Hc7LrwueTR/Kdg0Z2Op2CQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9yJ+uVclx9kzDu7zwYjESQz5N8w4T+48aUpZkmrItEpMG/k4A
	CyPm94HoPS+8cXHcqB+X/Ys4uQ195r8swfjYMys/jlEIsfUJocbbbJvSy2egflkYD41VEam4nYK
	bTqu8azzRsncZh8OwZKRv0/dBZYMTbBQ=
X-Gm-Gg: ASbGncstrTWX/NcTz9LZpediQTC7d5XmRnLBqDLA26Akc2i1v23IJbVarUQR6dUXH1W
	9RI7VY75vkm2IjRyK7NqsDA3uHLby1bWl6VGT0YPn1wwj5kVlJjqLQZGZVrzC8nBZfYsVI+QRsn
	tfaqGz1lLpu3tdJsM+7QFYjGfgP3oX3P1ribweOkZkGgrLQGShWwYcGtG+10J2XDGTJbOOpnzZn
	nuLpQ==
X-Google-Smtp-Source: AGHT+IEFgJakZyYeFdOphnfoDM6tWy8x5/ZWyjwSq3E4IIK1yiT+CFpMgxx3z0LTTy4+0uxN/VryqIG4oYSodCngBjg=
X-Received: by 2002:a05:6e02:1c08:b0:3e5:67a6:d418 with SMTP id
 e9e14a558f8ab-3e57e83d558mr86203435ab.3.1755302617407; Fri, 15 Aug 2025
 17:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811131236.56206-1-kerneljasonxing@gmail.com>
 <20250811131236.56206-3-kerneljasonxing@gmail.com> <b07b8930-e644-45a2-bef8-06f4494e7a39@kernel.org>
 <aJt+kBqXT/RgLGvR@boxer> <CAL+tcoBrT7WnPP9c+fhRxYyqyf0dZsMAP9=ghvcWRc2rTsF3Ag@mail.gmail.com>
 <CAL+tcoAst1xs=xCLykUoj1=Vj-0LtVyK-qrcDyoy4mQrHgW1kg@mail.gmail.com> <d34bf5f5-9626-442d-bdd2-b3ada51d556e@kernel.org>
In-Reply-To: <d34bf5f5-9626-442d-bdd2-b3ada51d556e@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 16 Aug 2025 08:03:01 +0800
X-Gm-Features: Ac12FXzHr-7YE3J955vos4taAN8VW1TV88KmECh1L813GQLlrASC0m62RmtWDyc
Message-ID: <CAL+tcoAesfv_SmkQCpijVRM0YRAg9ujYuX4gL1UD3QnjWhD0dw@mail.gmail.com>
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

On Sat, Aug 16, 2025 at 12:40=E2=80=AFAM Jesper Dangaard Brouer <hawk@kerne=
l.org> wrote:
>
>
>
> On 13/08/2025 15.06, Jason Xing wrote:
> > On Wed, Aug 13, 2025 at 9:02=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> >>
> >> On Wed, Aug 13, 2025 at 1:49=E2=80=AFAM Maciej Fijalkowski
> >> <maciej.fijalkowski@intel.com> wrote:
> >>>
> >>> On Tue, Aug 12, 2025 at 04:30:03PM +0200, Jesper Dangaard Brouer wrot=
e:
> >>>>
> >>>>
> >>>> On 11/08/2025 15.12, Jason Xing wrote:
> >>>>> From: Jason Xing <kernelxing@tencent.com>
> >>>>>
> >>>>> Zerocopy mode has a good feature named multi buffer while copy mode=
 has
> >>>>> to transmit skb one by one like normal flows. The latter might lose=
 the
> >>>>> bypass power to some extent because of grabbing/releasing the same =
tx
> >>>>> queue lock and disabling/enabling bh and stuff on a packet basis.
> >>>>> Contending the same queue lock will bring a worse result.
> >>>>>
> >>>>
> >>>> I actually think that it is worth optimizing the non-zerocopy mode f=
or
> >>>> AF_XDP.  My use-case was virtual net_devices like veth.
> >>>>
> >>>>
> >>>>> This patch supports batch feature by permitting owning the queue lo=
ck to
> >>>>> send the generic_xmit_batch number of packets at one time. To furth=
er
> >>>>> achieve a better result, some codes[1] are removed on purpose from
> >>>>> xsk_direct_xmit_batch() as referred to __dev_direct_xmit().
> >>>>>
> >>>>> [1]
> >>>>> 1. advance the device check to granularity of sendto syscall.
> >>>>> 2. remove validating packets because of its uselessness.
> >>>>> 3. remove operation of softnet_data.xmit.recursion because it's not
> >>>>>      necessary.
> >>>>> 4. remove BQL flow control. We don't need to do BQL control because=
 it
> >>>>>      probably limit the speed. An ideal scenario is to use a standa=
lone and
> >>>>>      clean tx queue to send packets only for xsk. Less competition =
shows
> >>>>>      better performance results.
> >>>>>
> >>>>> Experiments:
> >>>>> 1) Tested on virtio_net:
> >>>>
> >>>> If you also want to test on veth, then an optimization is to increas=
e
> >>>> dev->needed_headroom to XDP_PACKET_HEADROOM (256), as this avoids no=
n-zc
> >>>> AF_XDP packets getting reallocated by veth driver. I never completed
> >>>> upstreaming this[1] before I left Red Hat.  (virtio_net might also b=
enefit)
> >>>>
> >>>>   [1] https://github.com/xdp-project/xdp-project/blob/main/areas/cor=
e/veth_benchmark04.org
> >>>>
> >>>>
> >>>> (more below...)
> >>>>
> >>>>> With this patch series applied, the performance number of xdpsock[2=
] goes
> >>>>> up by 33%. Before, it was 767743 pps; while after it was 1021486 pp=
s.
> >>>>> If we test with another thread competing the same queue, a 28% incr=
ease
> >>>>> (from 405466 pps to 521076 pps) can be observed.
> >>>>> 2) Tested on ixgbe:
> >>>>> The results of zerocopy and copy mode are respectively 1303277 pps =
and
> >>>>> 1187347 pps. After this socket option took effect, copy mode reache=
s
> >>>>> 1472367 which was higher than zerocopy mode impressively.
> >>>>>
> >>>>> [2]: ./xdpsock -i eth1 -t  -S -s 64
> >>>>>
> >>>>> It's worth mentioning batch process might bring high latency in cer=
tain
> >>>>> cases. The recommended value is 32.
> >>>
> >>> Given the issue I spotted on your ixgbe batching patch, the compariso=
n
> >>> against zc performance is probably not reliable.
> >>
> >> I have to clarify the thing: zc performance was tested without that
> >> series applied. That means without that series, the number is 1303277
> >> pps. What I used is './xdpsock -i enp2s0f0np0 -t -q 11  -z -s 64'.
> >
>
> My i40e device is running at 40Gbit/s.
> I see significantly higher packet per sec (pps) that you are reporting:
>
> $ sudo ./xdpsock -i i40e2 --txonly -q 2 -z -s 64
>
>   sock0@i40e2:2 txonly xdp-drv
>                     pps            pkts           1.00
> rx                 0              0
> tx                 21,546,859     21,552,896
>
>
> The "copy" mode (-c/--copy) looks like this:
>
> $ sudo ./xdpsock -i i40e2 --txonly -q 2 --copy -s 64
>
>   sock0@i40e2:2 txonly xdp-drv
>                     pps            pkts           1.00
> rx                 0              0
> tx                 2,135,424      2,136,192
>
>
> The skb-mode (-S, --xdp-skb) looks like this:
>
> $ sudo ./xdpsock -i i40e2 --txonly -q 2 --xdp-skb -s 64
>
>   sock0@i40e2:2 txonly xdp-skb
>                     pps            pkts           1.00
> rx                 0              0
> tx                 2,187,992      2,188,800
>
>
> The HUGE performance gap to "xdp-drv" zero-copy mode, tells me that
> there is a huge potential for improving the performance for the copy
> mode, both "native" xdp-drv and xdp-skb, cases.
> Thus, the work your are doing here is important.

Great! Thanks for your affirmation.

>
>
> > ------
> > @Maciej Fijalkowski
> > Interesting thing is that copy mode is way worse than zerocopy if the
> > nic is _i40e_.
> >
> > With ixgbe, even copy mode reaches nearly 50-60% of the full speed
> > (which is only 1Gb/sec) while either zc or batch version copy mode
> > reaches 70%.
> > With i40e, copy mode only reaches nearly 9% while zc mode 70%. i40e
> > has a much faster speed (10Gb/sec) comparatively.
> >
> > Here are some summaries (budget 32, batch 32):
> >                 copy       batch         zc
> > i40e       1,777,859   2,102,579   14,880,643
> > ixgbe      1,187,347   1,472,367    1,303,277
> >
> (added thousands separators to make above readable)
>
> Those number only make sense if
>   i40e runs at link speed 10Git/s and
>   ixgbe runs at link speed 1Gbit/s
>
>
> > For i40e, here are numbers around the batch copy mode (budget is 128):
> > no batch       batch 64
> > 1825027      2228328.
> > Side note: 2228328 seems to be the max limit in copy mode with this
> > series applied after testing with different settings.
> >
> > It turns out that testing on i40e is definitely needed because the
> > xdpsock test hits the bottleneck on ixgbe.
> >
> > -----
> > @Jesper Dangaard Brouer
> > In terms of the 'more' boolean as Jesper said, related drivers might
> > need changes like this because in the 'for' loop of the batch process
> > in xsk_direct_xmit_batch(), drivers may fail to send and then break
> > the 'for' loop, which leads to no chance to kick the hardware.
>
> If sending with 'more' indicator and driver fail to send, then it is the
> responsibility of the driver to update the tail-ptr/doorbell.
> Example for ixgbe driver:
>   https://elixir.bootlin.com/linux/v6.16/source/drivers/net/ethernet/inte=
l/ixgbe/ixgbe_main.c#L8879-L8880

Thanks for sharing this. I'm learning :)

>
> > Or we
> > can keep trying to send in xsk_direct_xmit_batch() instead of breaking
> > immediately even if the driver becomes busy right now.
> >
> > As to ixgbe, the performance doesn't improve as I analyzed (because it
> > already reaches 70% of full speed).
> >
>
> If ixgbe runs at 1Gbit/s then remember Ethernet wire-speed is 1.488
> Mpps. Thus, you are much closer than 70% to wire-speed.

Right. 70% probably is the maximum number that xdpsock can reach.

>
>
> > As to i40e, only adding 'more' logic, the number goes from 2102579 to
> > 2585224 with the 32 batch and 32 budget settings. The number goes from
> > 2200013 to 2697313 with the  batch and 64 budget settings. See! 22+%
> > improvement!
>
> That is a very big performance gain IMHO. Shows that avoiding the tail-
> ptr/doorbell between each packet have a huge benefit.

That's right, and I will include it into the series as you suggested. Thank=
s!

>
> > As to virtio_net, no obvious change here probably because the hardirq
> > logic doesn't have a huge effect.
> >
>
> Perhaps virtio_net doesn't implement the SKB 'more' feature?

Oh, let me investigate it more deeply.

BTW, I'm not sure if you missed the previous last email, what do you
think of socket level accounting after reading that reply?

Thanks,
Jason

>
> --Jesper
>

