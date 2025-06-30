Return-Path: <bpf+bounces-61821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5071AEDD45
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36A0F7AA7B3
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 12:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129B828B3ED;
	Mon, 30 Jun 2025 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH/6mGqs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E599228A1F4;
	Mon, 30 Jun 2025 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287125; cv=none; b=KUJzEbmFxBaocNaMu/bDNJ2lsogqoM5k7RPY1v5xpTW+RrS61bfgiImODMySu44VLxr+fwk+O/FsL+oQY/FnqgVWJrWYfJ0ppVS9t8GfhHSRnkaOG30NQoX/uAakgkDvsvyCDo8k4qgiijKbDuFpmu3kdujNnCo0WFM+2SIpDgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287125; c=relaxed/simple;
	bh=PJZB2LTP+nIg+2ZFOmQb84WtlA1mbm+djr8Gxg2J32Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYY4Tcki5cp9dkcZ6K/G9h5SSbsY2u9YTG+zhwKpJ7j06Uc3Rz02No0zbIo28RyumRuthsqg/uNndovNT5dwm3PRPqkEQm2LWEQoGc2mIo1IIHEFOMw00x+WZX9+9RS840JQiqdY9c3J9L+EtAHZBEG3X7EtFSFXK+AiZ2B9vfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SH/6mGqs; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3df3ce3ec91so9073545ab.2;
        Mon, 30 Jun 2025 05:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751287123; x=1751891923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsnecPbSaP1mu7PRNsZyCzBrVSxK3dq3AH+iKWjWc9I=;
        b=SH/6mGqs1G3TOB8r/vWJiMegczIEF1Ixj36lYuYr4yZOLPouLCXbcwMqdiz5TD551B
         uK0PvsDSO+qebIMasHDK2cBMR72fWv6bzWPq/YAlgDaWYOcGiJffPVudn5VeM7XCDAp1
         MVBWcgmcRg2cU+BfU+8nAh50Ccsr/GENNnxN1+7jrAF9CByPNZVNVyCutw0gdipaeY6G
         UcOkkjXEGM+0y0BZW5n0KU2ecWwXitBWugFdqipj8yNU4EErno8+pMPeRGS4mY+qklfw
         ZbX5ryC1xOMyPSO0RIR46dyl/rhkID4EsowUUrbS8YNZlDeM3PRDNRLB+wB8dTzipzoi
         1o6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751287123; x=1751891923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsnecPbSaP1mu7PRNsZyCzBrVSxK3dq3AH+iKWjWc9I=;
        b=shyZFYcqbm7UzwOA3svlaAs7xaKd70T6J9MCOuw6PymhiJV+5ckwMb6CDJJVNaau62
         AwFbatZx+AUx7tHpPZzFIRGhx4sfXksrUHWN6lDfc0y+VWJCGC/UiuG8rdnzPsfeK8Gr
         fXb+shcfvq15AFKy4LoUub0uxVblxf9O9na9Kj34idUYNk8MR6jPYONmjLeGZjYG6a3W
         Ym7HvCYrDHAvgUr2KjXutRzaPqOLcmWUnmhEbAYG6JB7QrW9IYFDIgBOIWMyEdDvIGXB
         yVimoebftPprQrP1JtKNwR7GES258j/hN0i7MWcUhc65xhT8uJw8oWGWt/1ye2rB+ga8
         GBrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeU6KGyrIizNz8uoJbm/qs62SfyB5pJU+agpxAjCq83tpOmHlVGfDV9FZMDuNGRZew6M6vONgK@vger.kernel.org, AJvYcCXcNSr+CsCRTxyTcHRRvf5NUpNFw6yZFoJZSBNPtvGaTwQ7qr4GpTYhD7g6zDZaKsmKUtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7d5hv70vzawmTnAxvSz2o2zrGs8RIcp4Z5o209wnUu8nVhiz
	oqMGdfPdk5dD1osJ4d4V6bUpD53W7xNK9V5PJD8lkgT74wIFTSUenRlQVtTe9srw74l2sdIN9+L
	35ZVHCRC/lF39OfJ6E64cDe+GZRdsVu8JPSwT
X-Gm-Gg: ASbGncuf0EPCbz2vF4ciLwTnoFbr2iW9TWM34qK4xG6gfI3qJVSMMksRZQsefBipm2T
	dcP02+7RU3YkHCdm6jdzVdd+sqgVAl+vgvd7pUFuD2fCYBVXwscEebDid9gLMGpZlIx1JAUv2xx
	CXX3UVwC4OsD6rNjZcJ+18DurL08HOoGOQOfJL0VAloDk=
X-Google-Smtp-Source: AGHT+IFo4oYyUnIsIB2rP4eVVmVQIC3hAax545MFgi40GBcBGMjzjIoo2LWzY9lptKu2B9LaNCw2MAI2oQJWIBboEzk=
X-Received: by 2002:a05:6e02:1486:b0:3dc:7df8:c830 with SMTP id
 e9e14a558f8ab-3df4ab4af1cmr144042655ab.7.1751287122792; Mon, 30 Jun 2025
 05:38:42 -0700 (PDT)
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
Date: Mon, 30 Jun 2025 20:38:06 +0800
X-Gm-Features: Ac12FXwg78Q2IlQXo2SQulM1oGWVU2F_ntr4LtCbyLYp8hcaRpHG2_CUV4ur0_w
Message-ID: <CAL+tcoAAVbavbZA8rZLo4ygAyEgPDw7frH6R+rAtJSaTL2XvMw@mail.gmail.com>
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

Sorry again. I still don't follow you. Do you mean this patch doesn't
work as expected in busy polling mode? I tried to use '-B -b 256' and
I managed to see the correct budget value returned from getsockopt().

How is this max tx budget related to the busy polling mode, I wonder?

Or are you talking about the performance test I mentioned? I probably
know what happened there (due to some limit on the host side), but I
still need more time.

Thanks,
Jason

>
> >
> > Thanks,
> > Jason
> >
> > >
> > > > >
> > > > > Using the default configure 32 as the max budget iteration:
> > > > >  sock0@eth0:1 txonly xdp-drv
> > > > >                    pps            pkts           1.01
> > > > > rx                 0              0
> > > > > tx                 48,574         49,152
> > > > >
> > > > > Enlarging the value to 256:
> > > > >  sock0@eth0:1 txonly xdp-drv
> > > > >                    pps            pkts           1.00
> > > > > rx                 0              0
> > > > > tx                 148,277        148,736
> > > > >
> > > > > Enlarging the value to 512:
> > > > >  sock0@eth0:1 txonly xdp-drv
> > > > >                    pps            pkts           1.00
> > > > > rx                 0              0
> > > > > tx                 226,306        227,072
> > > > >
> > > > > The performance of pps goes up by 365% (with max budget set as 51=
2)
> > > > > which is an incredible number :)
> > > >
> > > > Weird thing. I purchased another VM and didn't manage to see such a
> > > > huge improvement.... Good luck is that I own that good machine whic=
h
> > > > is still reproducible and I'm still digging in it. So please ignore
> > > > this noise for now :|
> > > >
> > > > Thanks,
> > > > Jason

