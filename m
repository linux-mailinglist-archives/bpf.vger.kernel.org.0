Return-Path: <bpf+bounces-61907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70175AEEB34
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 02:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15D41BC15C7
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 00:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366F872622;
	Tue,  1 Jul 2025 00:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0T6u+lc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A712C347D5;
	Tue,  1 Jul 2025 00:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751329255; cv=none; b=CjvN4q/iX77YJ2AogoE1YiWG7Ab0Q7GxWRhB3EWc/X7PFKog9olPRxLzi5GI/yki91V21WDeE0ffz01um9pFSvaH4RcdFGITeQ+eH+mNein4jlE0ZkQ01zzUee9HYGkaJ58up/peQ9dbysfHpK2CTbduyzBBfuSa9vf2KSLcJOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751329255; c=relaxed/simple;
	bh=1zva/vyvpeqf+VyPVIat7QLdr9isufIskxi8szsQ9e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKoleKrJY6Pb28+8gG85ZcNSwQ88o3MXIOi6u0aXEVTzDqgb5yUj2cPrYkRdXa6PutG53Vt3f3O6iFiR2RN6EEsFIncHjONaHZMYQ6PoCJqHnzpbd1QLYyaLwNub1op6oNLCzn9Eh+y5T6ZG5pbWQh0WPs2FBA/ou+I5i6w1dWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0T6u+lc; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3de18fdeab0so44894655ab.3;
        Mon, 30 Jun 2025 17:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751329253; x=1751934053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEBCdoj55gHUDc+Kc3khDe1kXAkYl31rGdURJbmNFHs=;
        b=b0T6u+lcbUFpxflcQ0rw/xwWjX5uKogO7Y+AcRSOGsaIES5bmPjuA09sZHumZteIdZ
         wz5KIiMSiX9DLF2OFYDow1Mz5qMfpioGlzcIrQpqMcPfs0xCeN156MgKzJ1KqiUir+l8
         Qus98+LAv3NpucWVwZhw3Wds2lEdekv/lXM5CSJ0NZZksucQTog6aj87lC6pbxwyyR9L
         z5wPSsHLbMOzfsvRGoG5gKxl599qcK5R37omS00V3kjSZy/tKcx/GqgJcbnTZ3itelGa
         F0bidi09jO2KWbCK/ZR9I83K8Y/jTyMS+iILFotm61q2OTNhouWvwGswZrkXyDHQGRP8
         46Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751329253; x=1751934053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEBCdoj55gHUDc+Kc3khDe1kXAkYl31rGdURJbmNFHs=;
        b=LffvRb3ei8Wn+CZsUNaX8pbfkPnYE3SNzYycx5y9c+l6GdV4XmthpZm+GqrTmG33Ae
         qRg/hNxHCkXLfadZ5dniepbEKKipxEvzwYTYdjIYsTcgEnrKCRyD1z9KYukd+GP7HZXt
         vGW00cUuo9k5LhryBmVALF5VEIXCSl+HawiQDXdLSFu79nIFvwquXP5gl/Wz1cnN2q+U
         AE0p0uBgfEkuK7ad+Blt7b14jZNIWpz02W2nnOiocSCDGfz4MrMVx8IaUTJig2yNBf1V
         +Sid5yrKTaQ0p+wEu/muCKh4KP6Brm70WUpLBifbQKJJiP9GvuzkImZJs26/9R81OZA4
         zsZg==
X-Forwarded-Encrypted: i=1; AJvYcCWR27L6CdhJe25jx/4MnPmq3C2A1IbpkN1RvDNBuGAg3lRcCVrcCA/w4KQzrUdwBBQQ45Um2Klk@vger.kernel.org, AJvYcCXoptvPZWQAabbVA141JINfxYgU0D0cvHskOKTDxAicAkdTrF8c8EdWqKRepxFN/1kaBAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLdxNxRZhG9vPu9GKeypLqIq3wRRYAnsgzTWVyJXpm3pTMqYQs
	y6M4VyNd2am1EVwEV09OHUQhpaO3qeR1xt/BXQYUnZ+vCWpTcIs0r2DIbDB26u/jJPr540p8ojZ
	EJCNjdeZFd7KN5AG7/Ag5DyJ0enR4+9A=
X-Gm-Gg: ASbGncu/zaWsi5vEHpnqkmFquyQ6pE0MJK3vh350UUTsqOgF8CQ/BvgFjKgnFr2w2Go
	EuinQI8BC79X2e7Hw2tBZOknOBWtlWqRWlnNZMHSr9hRaCQmWqfCOYLluWq7x/lqSv6kgRQ2Wuy
	eZq+1XK6mvkf7v55YCBx6gq+6PpgUmPo2a5Qcb+nSOOg==
X-Google-Smtp-Source: AGHT+IFOAnKHo4eiJk08bURW/bxpCeR/U7Ix+nvOQBBNU0O4inbT9887YDOiPbmYhq1JoGU15uGzmoXuA9+RKAx+bQE=
X-Received: by 2002:a05:6e02:370c:b0:3dc:79e5:e696 with SMTP id
 e9e14a558f8ab-3df4aba3be2mr165686535ab.11.1751329252593; Mon, 30 Jun 2025
 17:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627110121.73228-1-kerneljasonxing@gmail.com>
 <CAL+tcoCSd_LA8w9ov7+_sOWLt3EU1rcqK8Sa6UF5S-xgfAGPnA@mail.gmail.com>
 <CAL+tcoCCM+m6eJ1VNoeF2UMdFOhMjJ1z2FVUoMJk=js++hk0RQ@mail.gmail.com>
 <aGJ5DDtFAZ/IsE0B@boxer> <CAL+tcoB+_5p4V3WgMmpGnrjj-+axTDkhKoYS=1cMKxTRs68JAA@mail.gmail.com>
 <aGKCM2z1I85AAXFc@boxer>
In-Reply-To: <aGKCM2z1I85AAXFc@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 1 Jul 2025 08:20:16 +0800
X-Gm-Features: Ac12FXxbXll0iFIoZhuB9QgHAotM7rhT8ycjzj-6aD5iphT-LY7JvuebDcVCFsY
Message-ID: <CAL+tcoBj_cv761-rair8vgvhgu1+DSFoNd2nZspvjtm3dKKxXw@mail.gmail.com>
Subject: Re: [PATCH net-next v6] net: xsk: introduce XDP_MAX_TX_BUDGET set/getsockopt
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 8:25=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Mon, Jun 30, 2025 at 08:07:01PM +0800, Jason Xing wrote:
> > On Mon, Jun 30, 2025 at 7:47=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Sun, Jun 29, 2025 at 06:43:05PM +0800, Jason Xing wrote:
> > > > On Sun, Jun 29, 2025 at 10:51=E2=80=AFAM Jason Xing <kerneljasonxin=
g@gmail.com> wrote:
> > > > >
> > > > > On Fri, Jun 27, 2025 at 7:01=E2=80=AFPM Jason Xing <kerneljasonxi=
ng@gmail.com> wrote:
> > > > > >
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > This patch provides a setsockopt method to let applications lev=
erage to
> > > > > > adjust how many descs to be handled at most in one send syscall=
. It
> > > > > > mitigates the situation where the default value (32) that is to=
o small
> > > > > > leads to higher frequency of triggering send syscall.
> > > > > >
> > > > > > Considering the prosperity/complexity the applications have, th=
ere is no
> > > > > > absolutely ideal suggestion fitting all cases. So keep 32 as it=
s default
> > > > > > value like before.
> > > > > >
> > > > > > The patch does the following things:
> > > > > > - Add XDP_MAX_TX_BUDGET socket option.
> > > > > > - Convert TX_BATCH_SIZE to tx_budget_spent.
> > > > > > - Set tx_budget_spent to 32 by default in the initialization ph=
ase as a
> > > > > >   per-socket granular control. 32 is also the min value for
> > > > > >   tx_budget_spent.
> > > > > > - Set the range of tx_budget_spent as [32, xs->tx->nentries].
> > > > > >
> > > > > > The idea behind this comes out of real workloads in production.=
 We use a
> > > > > > user-level stack with xsk support to accelerate sending packets=
 and
> > > > > > minimize triggering syscalls. When the packets are aggregated, =
it's not
> > > > > > hard to hit the upper bound (namely, 32). The moment user-space=
 stack
> > > > > > fetches the -EAGAIN error number passed from sendto(), it will =
loop to try
> > > > > > again until all the expected descs from tx ring are sent out to=
 the driver.
> > > > > > Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequ=
ency of
> > > > > > sendto() and higher throughput/PPS.
> > > > > >
> > > > > > Here is what I did in production, along with some numbers as fo=
llows:
> > > > > > For one application I saw lately, I suggested using 128 as max_=
tx_budget
> > > > > > because I saw two limitations without changing any default conf=
iguration:
> > > > > > 1) XDP_MAX_TX_BUDGET, 2) socket sndbuf which is 212992 decided =
by
> > > > > > net.core.wmem_default. As to XDP_MAX_TX_BUDGET, the scenario be=
hind
> > > > > > this was I counted how many descs are transmitted to the driver=
 at one
> > > > > > time of sendto() based on [1] patch and then I calculated the
> > > > > > possibility of hitting the upper bound. Finally I chose 128 as =
a
> > > > > > suitable value because 1) it covers most of the cases, 2) a hig=
her
> > > > > > number would not bring evident results. After twisting the para=
meters,
> > > > > > a stable improvement of around 4% for both PPS and throughput a=
nd less
> > > > > > resources consumption were found to be observed by strace -c -p=
 xxx:
> > > > > > 1) %time was decreased by 7.8%
> > > > > > 2) error counter was decreased from 18367 to 572
> > > > >
> > > > > More interesting numbers are arriving here as I run some benchmar=
ks
> > > > > from xdp-project/bpf-examples/AF_XDP-example/ in my VM.
> > > > >
> > > > > Running "sudo taskset -c 2 ./xdpsock -i eth0 -q 1 -l -N -t -b 256=
"
> > >
> > > do you have a patch against xdpsock that does setsockopt you're
> > > introducing here?
> >
> > Sure, I added the following code in the apply_setsockopt():
> > if (setsockopt(xsk_socket__fd(xsk->xsk), SOL_XDP, 9, &a, sizeof(a)) < 0=
)
> > ...
> >
> > >
> > > -B -b 256 was for enabling busy polling and giving it 256 budget, whi=
ch is
> > > not what you wanted to achieve.
> >
> > I checked that I can use getsockopt to get the budget value the same
> > as what I use setsockopt().
> >
> > Sorry, I don't know what you meant here. Could you say more about it?
>
> I meant that -b is for setting SO_BUSY_POLL_BUDGET. just pick different
> knob for your use case.

After taking a deep sleep, I clearly know what that is... I will try
to test with other parameters. But for me, the primary factor is the
security interception on the host side because of a larger number of
descs containing useless information. Well, I will find a good way to
avoid this in the future...

And what is your opinion of the current patch? I used [32, nentries]
as the min/max range as you advised :)

Thanks,
Jason

