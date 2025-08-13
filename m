Return-Path: <bpf+bounces-65516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D04B24A28
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 15:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4F81BC51E1
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 13:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CE02E62AE;
	Wed, 13 Aug 2025 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMrA3azs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E282746A;
	Wed, 13 Aug 2025 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090414; cv=none; b=NhYd7X3UNqL6DiWa7K7sadAEY428Pu2QZla/Dmzx84eyvpUEhvbo4EF6IvL4sJnlI464l23QV/WLyAhn/19gSbA7BUdDccfJU9StfkLh0CQCbJMYKOhm4r+kpqwaevhRydFK+9k/SuhEM3l2Qxblfyxf8Wxl1dYJmSfbloju/Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090414; c=relaxed/simple;
	bh=cP+4vt5PAQvjxMdamelCvLQoKCc909Vtx4x3NMw1h7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DH5LfyCdIMohqYyQ9iffYTKS72aMzJCPxngQoImg1OlXQjwCQXYAZS7M7fNEi7UqAddwBaV6YB6TKlLdJ9aN8lXlQyD68Z6zWGJ3NXUnAettLczwEjrpWlXAb9H0lFbbM1KVXbuvZfnTVsJUGJ8BnLk7uWr61Sx+5P+I2Hfl6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMrA3azs; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e5477e8effso16420745ab.1;
        Wed, 13 Aug 2025 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755090412; x=1755695212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zgjPIVTvjy0z/uPtaNpnGb4sVcyVdZVL/38Pg/mpjo=;
        b=NMrA3azsSjwet7xlQbLGpC2wXfYcOP6WfJWDjU0mj4afIFXLzrrogJn7cZvS2Na0Pl
         J1zxZLzSVxMR38xZqvLJDb7FHIvZyDELzV2UQeqQ5yIR6H+sS7usOJwu2Fo7YryCX21b
         5r9lYQYLM8dLMurOOJeBVbG0MJZgOBa8sTSJkHrMNbCExGXnTOJytU+kBvQUrB+gBmF1
         mpfUDghikeudD6UFYqnsibEkqEAKXKiblcIpW7dJUVq/SeEOrdrUs25mbQFsVGXt/rrx
         vLIUgKeJ+xkCcL5pBHULBIK4/u1kCvvKhG4sQJU3dSb+B2LWd89UUglMPVj+0Bf6JUJ/
         XF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090412; x=1755695212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zgjPIVTvjy0z/uPtaNpnGb4sVcyVdZVL/38Pg/mpjo=;
        b=ibiEpTb8qQvvBlsZN2IAcaYnjBMkJi4vF/BTuDhRKrxk9SqP1G7ofieT+cr0Y9Xwzs
         PD9CMoIbaW1XvQu5fpA5winIzW3mfBZmnH83v6eW6Z/VmdDe5wCj/Bk6WDr8YOEmBu2b
         NguphqFdZgpWn/RH2KzK24h/PD3IuqnVIX5qDEAEXzwgsZHPL1TM21lcmCh3tPpEfqX8
         j3x2j/EhB3S23ZMCHsi5+Bapv7VmtIc73e0ZH4c2t9A6A2pBswPDYChuAETp78V0RzIC
         Eb6Wq+degqz+o4KkYJPfNLdMD774lD6NJCCPS131oMl38SEtHVNfyr5OSkvbgXUTxGq7
         Gu+w==
X-Forwarded-Encrypted: i=1; AJvYcCVseTZkR0y/o76mlFLyg7wSapABjZbJv0ghyVlNAeuP7ArsINAXfY9zqnCeOjQb1sd1rsY=@vger.kernel.org, AJvYcCXpjGn5/+1mbeQRHsp7p2gN++0vsQW21pvw8qCrLBHrHAxZuw0R66og257NkfO4k72ePFrqdJlE@vger.kernel.org
X-Gm-Message-State: AOJu0YwJowHehBgGWEzPfY3jd0ovyapv4/Sc1RClrz5I1/DcxYyV5hPi
	lSOHxQpcf1N66r9RjaqbSGsUvmR/OfQaN7ulJbNscAQZe2lptk/8ssSsNwR1Swgrfto1cYzLrtX
	gqn0mybxpw33dD4AvYRQ+z4MyLcyxP/o=
X-Gm-Gg: ASbGncuWZ/Toor2UmN6kRzqwP9Vu7JJX2lNwg0+R9gfovI/Fs+DvULyPLkclC5egCvG
	q3Xi1PMI0HOx3L7zh5CQ5v0Bc97//vmGlIU+lJ/+pkQNh0/8umygV3mcgLdJYsoiB0IDUhxePeL
	VtASxsPnRcdBIx8+K7pYV6khb1Vr45i87ggW+iEAFHjM7Q8CzvB/KyERmbjfxx27AhtpNyjTyLl
	NWu+Os=
X-Google-Smtp-Source: AGHT+IHH8V9/1E4C2vr2fmi1+N8WxqnKC9HKfWuo2j2dZflIe017upAFIhrfH6sGT4ESpwKbp2Ddab3pqcPSInOEg34=
X-Received: by 2002:a05:6e02:380e:b0:3e5:29a3:b552 with SMTP id
 e9e14a558f8ab-3e567353e9emr50093215ab.3.1755090411267; Wed, 13 Aug 2025
 06:06:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811131236.56206-1-kerneljasonxing@gmail.com>
 <20250811131236.56206-3-kerneljasonxing@gmail.com> <b07b8930-e644-45a2-bef8-06f4494e7a39@kernel.org>
 <aJt+kBqXT/RgLGvR@boxer> <CAL+tcoBrT7WnPP9c+fhRxYyqyf0dZsMAP9=ghvcWRc2rTsF3Ag@mail.gmail.com>
In-Reply-To: <CAL+tcoBrT7WnPP9c+fhRxYyqyf0dZsMAP9=ghvcWRc2rTsF3Ag@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 13 Aug 2025 21:06:13 +0800
X-Gm-Features: Ac12FXx_ydiL6UJH_p5roqRvbtA0-Ok9yPXA4-OC-Wod3KEm7z9o9pSqI0YqhVo
Message-ID: <CAL+tcoAst1xs=xCLykUoj1=Vj-0LtVyK-qrcDyoy4mQrHgW1kg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] xsk: support generic batch xmit in copy mode
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 9:02=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Wed, Aug 13, 2025 at 1:49=E2=80=AFAM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Tue, Aug 12, 2025 at 04:30:03PM +0200, Jesper Dangaard Brouer wrote:
> > >
> > >
> > > On 11/08/2025 15.12, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Zerocopy mode has a good feature named multi buffer while copy mode=
 has
> > > > to transmit skb one by one like normal flows. The latter might lose=
 the
> > > > bypass power to some extent because of grabbing/releasing the same =
tx
> > > > queue lock and disabling/enabling bh and stuff on a packet basis.
> > > > Contending the same queue lock will bring a worse result.
> > > >
> > >
> > > I actually think that it is worth optimizing the non-zerocopy mode fo=
r
> > > AF_XDP.  My use-case was virtual net_devices like veth.
> > >
> > >
> > > > This patch supports batch feature by permitting owning the queue lo=
ck to
> > > > send the generic_xmit_batch number of packets at one time. To furth=
er
> > > > achieve a better result, some codes[1] are removed on purpose from
> > > > xsk_direct_xmit_batch() as referred to __dev_direct_xmit().
> > > >
> > > > [1]
> > > > 1. advance the device check to granularity of sendto syscall.
> > > > 2. remove validating packets because of its uselessness.
> > > > 3. remove operation of softnet_data.xmit.recursion because it's not
> > > >     necessary.
> > > > 4. remove BQL flow control. We don't need to do BQL control because=
 it
> > > >     probably limit the speed. An ideal scenario is to use a standal=
one and
> > > >     clean tx queue to send packets only for xsk. Less competition s=
hows
> > > >     better performance results.
> > > >
> > > > Experiments:
> > > > 1) Tested on virtio_net:
> > >
> > > If you also want to test on veth, then an optimization is to increase
> > > dev->needed_headroom to XDP_PACKET_HEADROOM (256), as this avoids non=
-zc
> > > AF_XDP packets getting reallocated by veth driver. I never completed
> > > upstreaming this[1] before I left Red Hat.  (virtio_net might also be=
nefit)
> > >
> > >  [1] https://github.com/xdp-project/xdp-project/blob/main/areas/core/=
veth_benchmark04.org
> > >
> > >
> > > (more below...)
> > >
> > > > With this patch series applied, the performance number of xdpsock[2=
] goes
> > > > up by 33%. Before, it was 767743 pps; while after it was 1021486 pp=
s.
> > > > If we test with another thread competing the same queue, a 28% incr=
ease
> > > > (from 405466 pps to 521076 pps) can be observed.
> > > > 2) Tested on ixgbe:
> > > > The results of zerocopy and copy mode are respectively 1303277 pps =
and
> > > > 1187347 pps. After this socket option took effect, copy mode reache=
s
> > > > 1472367 which was higher than zerocopy mode impressively.
> > > >
> > > > [2]: ./xdpsock -i eth1 -t  -S -s 64
> > > >
> > > > It's worth mentioning batch process might bring high latency in cer=
tain
> > > > cases. The recommended value is 32.
> >
> > Given the issue I spotted on your ixgbe batching patch, the comparison
> > against zc performance is probably not reliable.
>
> I have to clarify the thing: zc performance was tested without that
> series applied. That means without that series, the number is 1303277
> pps. What I used is './xdpsock -i enp2s0f0np0 -t -q 11  -z -s 64'.

------
@Maciej Fijalkowski
Interesting thing is that copy mode is way worse than zerocopy if the
nic is _i40e_.

With ixgbe, even copy mode reaches nearly 50-60% of the full speed
(which is only 1Gb/sec) while either zc or batch version copy mode
reaches 70%.
With i40e, copy mode only reaches nearly 9% while zc mode 70%. i40e
has a much faster speed (10Gb/sec) comparatively.

Here are some summaries (budget 32, batch 32):
                 copy      batch             zc
i40e      1777859  2102579     14880643
ixgbe    1187347  1472367     1303277

For i40e, here are numbers around the batch copy mode (budget is 128):
no batch       batch 64
1825027      2228328.
Side note: 2228328 seems to be the max limit in copy mode with this
series applied after testing with different settings.

It turns out that testing on i40e is definitely needed because the
xdpsock test hits the bottleneck on ixgbe.

-----
@Jesper Dangaard Brouer
In terms of the 'more' boolean as Jesper said, related drivers might
need changes like this because in the 'for' loop of the batch process
in xsk_direct_xmit_batch(), drivers may fail to send and then break
the 'for' loop, which leads to no chance to kick the hardware. Or we
can keep trying to send in xsk_direct_xmit_batch() instead of breaking
immediately even if the driver becomes busy right now.

As to ixgbe, the performance doesn't improve as I analyzed (because it
already reaches 70% of full speed).

As to i40e, only adding 'more' logic, the number goes from 2102579 to
2585224 with the 32 batch and 32 budget settings. The number goes from
2200013 to 2697313 with the  batch and 64 budget settings. See! 22+%
improvement!

As to virtio_net, no obvious change here probably because the hardirq
logic doesn't have a huge effect.

Thanks,
Jason

