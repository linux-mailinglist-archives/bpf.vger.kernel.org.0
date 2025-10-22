Return-Path: <bpf+bounces-71675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B2FBFA8E8
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 09:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87AEC4F90FD
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 07:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548DC2F8BF7;
	Wed, 22 Oct 2025 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jda5Tkw7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23522F7ACF
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 07:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118159; cv=none; b=ZAt/WSmBKCXzVs3j1EHDlB+gzK5tEQ/nIuxJuuL9SyFTxlF7Eu1GX2r3nPcjyQpi3+gNQSrpLop3CiIg12z8quluWwDHMQZyvr+XFcOAResG8KmLOnxXmjNAx3QRZnqQHtnWTurOgq7x2Xtjig+O1d9xKni5G6c6VJW4B1nr/ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118159; c=relaxed/simple;
	bh=e6+RD0fQsZX6Z88W+ISwe+GQbVT5iKpFFDHyqWKJ6s8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3xrbnkhIRcjqC+1apnNlzQkzQSKLciCbxmkEwvxsZCcmZBqGVxrojI/eIjlW6bqdi/Cj/41yL9irgilCnaKEhR0GMrHaIOrbkt0XEQNjlX36jHVlXjrsdiAxA7WbG1NNxABH/rE7pxrxnUgpHUfjSRqjOJ9/ESg7k2Ildibb8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jda5Tkw7; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-938de0df471so539482739f.2
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 00:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761118157; x=1761722957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xWsLx8kXa1EhoyDlGrX8mNfXD+60A38wfmzRpmXo5g=;
        b=Jda5Tkw7xK5AEhPVi9XX22c1SzS9RKs8eqIihB/C1mGsjEI0afIzsJqJLb4dDQ9yzK
         Q9/v1HbFOG7ld6GMm8PVHY5i0RwQ/NGrt2ASq7K+ETO5SGlOMqOwOLsVXioKG9Zo4wsd
         UH5jkp0iyaAoQODjLiGolUTq7x67ZNfOU27YfjVztMcsTjlduw9QrppNAmbKKeE+wuSN
         iX7keWqEWfwQOXXz5zVxDzZCM9kRQRHcdDEBX91EfGYCzpM8cPdf40lwFSWCgqecxkbz
         VZ7VU90+DdvJ0jyUHb9FS+g1C9o0y5UV5f/0E07PuTqQzb25glKlUwPCcIYZOEsIOgLI
         +uGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761118157; x=1761722957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xWsLx8kXa1EhoyDlGrX8mNfXD+60A38wfmzRpmXo5g=;
        b=GziFw1P91WkUw8eii3+LJ4snWMENAb+1pDHtYar2D0YJG9JKAICUCY049k2q1wIcLg
         cV/u/Al0LycdUV5VtZVaWMnK4jNA5t9mnsk+51wmS0AduKvB1Pu9QcPaRXPv9seSEqkF
         6Y0y/u0J7ec4fFPmps8+OfUPTdOLahBpTF8UxM7+ypDJUh/E80j6nK+ez2BCPCt7qg0l
         iz0ELbTacPR4qIWWCoG1ePooT95MzGc1V/Wtxcjg2UsjWgUl9ldidRTcb5bebsWCSh2s
         HoERlBRG4MzfW133GR9zAmqhaAegHKddWn6+FQP+Sf/8leHq0wjjTD6N8EObstxLyd7F
         05hw==
X-Forwarded-Encrypted: i=1; AJvYcCXFvKeAfZxQg4cWKtWhCzkdLo/UnXKsHP9i4GTrTd42lb53Q/HdTBPDIn0qWAKtbPcbu3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB5OIZqZIdO1MZv+YXiUoHlH4zX/gcfUhNj25jHKzp+WOqrmVp
	jVgzyhr7hlciXbE5wAhm9EmJMzU9vevDwcwLwvg2J8J2cHpIJVYG1S1wkzLLoJPkMZZKjtkG47h
	jkmpU3A2SbVJ0DYoXWEG2BEZpNW/W7e4=
X-Gm-Gg: ASbGncvM6UW6qbygnGXWR/ru5vgimLOxvO87Rc1NsnAxmoDfEORh4zlZOH+lQXUi2q3
	5CdclEgbdo3n2F0iqfjEFfoGY4q0GQ4a3/yyTnj2vklVUVuMOBbnjYyS8Se8edbceNBhQMgNNZ2
	Sa1NhVjHF0bhcr1lE+KgKafiuSoOvBF8FubodF3t9TmekHQ4yEC6ZSn1/uKuHDuMCzCGifKEOAu
	a/rVXQ60gNQ27ZiKijYLUzxWBdGqZdSH9H3j934I+8qqTEH4w0s0WX0BRVv
X-Google-Smtp-Source: AGHT+IED9n+RqHtN1Th1MJ7JnCSzY0Rl5WA7S8AQjtZkIJPKqYfBIw2vQZWOdi7nfIlSGidEA+5NpJL057JdqlYVYy4=
X-Received: by 2002:a05:6e02:152d:b0:42f:9dd5:3ebb with SMTP id
 e9e14a558f8ab-430c529a04bmr264434365ab.24.1761118156832; Wed, 22 Oct 2025
 00:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021173200.7908-1-alessandro.d@gmail.com> <20251021173200.7908-2-alessandro.d@gmail.com>
 <CAL+tcoCwGQyNSv9BZ_jfsia6YFoyT790iknqxG7bB7wVi3C_vQ@mail.gmail.com> <SA1SPRMB0026CD60501E3684B5EC67F290F3A@SA1SPRMB0026.namprd11.prod.outlook.com>
In-Reply-To: <SA1SPRMB0026CD60501E3684B5EC67F290F3A@SA1SPRMB0026.namprd11.prod.outlook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 22 Oct 2025 15:28:40 +0800
X-Gm-Features: AS18NWAhx58WtTUi2JT6G4CTg1bh9I5sPKQJwMylvFKZ_SujWev48qLzNJTayaU
Message-ID: <CAL+tcoD0Mu0ShAN3Jp5Kt=bheQzm-4Q999_Fzw=y8zt7L9GuLg@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] i40e: xsk: advance next_to_clean on status descriptors
To: "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Cc: Alessandro Decina <alessandro.d@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 1:41=E2=80=AFPM Sarkar, Tirthendu
<tirthendu.sarkar@intel.com> wrote:
>
> > From: Jason Xing <kerneljasonxing@gmail.com>
> > Sent: 22 October 2025 08:41
> > On Wed, Oct 22, 2025 at 1:33=E2=80=AFAM Alessandro Decina
> > <alessandro.d@gmail.com> wrote:
> > >
> > > Whenever a status descriptor is received, i40e processes and skips ov=
er
> > > it, correctly updating next_to_process but forgetting to update
> > > next_to_clean. In the next iteration this accidentally causes the
> > > creation of an invalid multi-buffer xdp_buff where the first fragment
> > > is the status descriptor.
> > >
> > > If then a skb is constructed from such an invalid buffer - because th=
e
> > > eBPF program returns XDP_PASS - a panic occurs:
> > >
> > > [ 5866.367317] BUG: unable to handle page fault for address:
> > ffd31c37eab1c980
> > > [ 5866.375050] #PF: supervisor read access in kernel mode
> > > [ 5866.380825] #PF: error_code(0x0000) - not-present page
> > > [ 5866.386602] PGD 0
> > > [ 5866.388867] Oops: Oops: 0000 [#1] SMP NOPTI
> > > [ 5866.393575] CPU: 34 UID: 0 PID: 0 Comm: swapper/34 Not tainted
> > 6.17.0-custom #1 PREEMPT(voluntary)
> > > [ 5866.403740] Hardware name: Supermicro AS -2115GT-HNTR/H13SST-G,
> > BIOS 3.2 03/20/2025
> > > [ 5866.412339] RIP: 0010:memcpy+0x8/0x10
> > > [ 5866.416454] Code: cc cc 90 cc cc cc cc cc cc cc cc cc cc cc cc cc =
cc cc 90 90
> > 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 48 89 f8 48 89 d1 <f3> =
a4
> > e9 fc 26 c0 fe 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> > > [ 5866.437538] RSP: 0018:ff428d9ec0bb0ca8 EFLAGS: 00010286
> > > [ 5866.443415] RAX: ff2dd26dbd8f0000 RBX: ff2dd265ad161400 RCX:
> > 00000000000004e1
> > > [ 5866.451435] RDX: 00000000000004e1 RSI: ffd31c37eab1c980 RDI:
> > ff2dd26dbd8f0000
> > > [ 5866.459454] RBP: ff428d9ec0bb0d40 R08: 0000000000000000 R09:
> > 0000000000000000
> > > [ 5866.467470] R10: 0000000000000000 R11: 0000000000000000 R12:
> > ff428d9eec726ef8
> > > [ 5866.475490] R13: ff2dd26dbd8f0000 R14: ff2dd265ca2f9fc0 R15:
> > ff2dd26548548b80
> > > [ 5866.483509] FS:  0000000000000000(0000)
> > GS:ff2dd2c363592000(0000) knlGS:0000000000000000
> > > [ 5866.492600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 5866.499060] CR2: ffd31c37eab1c980 CR3: 0000000178d7b040 CR4:
> > 0000000000f71ef0
> > > [ 5866.507079] PKRU: 55555554
> > > [ 5866.510125] Call Trace:
> > > [ 5866.512867]  <IRQ>
> > > [ 5866.515132]  ? i40e_clean_rx_irq_zc+0xc50/0xe60 [i40e]
> > > [ 5866.520921]  i40e_napi_poll+0x2d8/0x1890 [i40e]
> > > [ 5866.526022]  ? srso_alias_return_thunk+0x5/0xfbef5
> > > [ 5866.531408]  ? raise_softirq+0x24/0x70
> > > [ 5866.535623]  ? srso_alias_return_thunk+0x5/0xfbef5
> > > [ 5866.541011]  ? srso_alias_return_thunk+0x5/0xfbef5
> > > [ 5866.546397]  ? rcu_sched_clock_irq+0x225/0x1800
> > > [ 5866.551493]  __napi_poll+0x30/0x230
> > > [ 5866.555423]  net_rx_action+0x20b/0x3f0
> > > [ 5866.559643]  handle_softirqs+0xe4/0x340
> > > [ 5866.563962]  __irq_exit_rcu+0x10e/0x130
> > > [ 5866.568283]  irq_exit_rcu+0xe/0x20
> > > [ 5866.572110]  common_interrupt+0xb6/0xe0
> > > [ 5866.576425]  </IRQ>
> > > [ 5866.578791]  <TASK>
> > >
> > > Advance next_to_clean to ensure invalid xdp_buff(s) aren't created.
> > >
> > > Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> > > Signed-off-by: Alessandro Decina <alessandro.d@gmail.com>
> > > ---
> > >  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > > index 9f47388eaba5..dbc19083bbb7 100644
> > > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > > @@ -441,13 +441,18 @@ int i40e_clean_rx_irq_zc(struct i40e_ring
> > *rx_ring, int budget)
> > >                 dma_rmb();
> > >
> > >                 if (i40e_rx_is_programming_status(qword)) {
> > > +                       u16 ntp;
> > > +
> > >                         i40e_clean_programming_status(rx_ring,
> > >                                                       rx_desc->raw.qw=
ord[0],
> > >                                                       qword);
> > >                         bi =3D *i40e_rx_bi(rx_ring, next_to_process);
> > >                         xsk_buff_free(bi);
> > > -                       if (++next_to_process =3D=3D count)
> > > +                       ntp =3D next_to_process++;
> > > +                       if (next_to_process =3D=3D count)
> > >                                 next_to_process =3D 0;
> > > +                       if (next_to_clean =3D=3D ntp)
> > > +                               next_to_clean =3D next_to_process;
> > >                         continue;
> > >                 }
> > >
> > > --
> > > 2.43.0
> > >
> > >
> >
> > I'm copying your reply from v1 as shown below so that we can continue
> > with the discussion :)
> >
> > > It really depends on whether a status descriptor can be received in t=
he
> > > middle of multi-buffer packet. Based on the existing code, I assumed =
it
> > > can. Therefore, consider this case:
> > >
> > > [valid_1st_packet][status_descriptor][valid_2nd_packet]
> > >
> > > In this case you want to skip status_descriptor but keep the existing
> > > logic that leads to:
> > >
> > >     first =3D next_to_clean =3D valid_1st_packet
> > >
> > > so then you can go and add valid_2nd_packet as a fragment to the firs=
t.
> >
> > Sorry, honestly, I still don't follow you.
> >
> > Looking at the case you provided, I think @first always pointing to
> > valid_1st_packet is valid which does not bring any trouble. You mean
> > the case is what you're trying to handle?
> >
> > You patch updates next_to_clean that is only used at the very
> > beginning, so it will not affect @first. Imaging the following case:
> >
> >      [status_descriptor][valid_1st_packet][valid_2nd_packet]
> >
> > Even if the next_to_clean is updated, the @first still points to
> > [status_descriptor] that is invalid and that will later cause the
> > panic when constructing the skb.
> >
> > I'm afraid that we're not on the same page. Let me confirm that it is
> > @first that points to the status descriptor that causes the panic,
> > right? Could you share with us the exact case just like you did as
> > above. Thank you.
> >
> > Thanks,
> > Jason
>
> I believe the issue is not that status_descriptor is getting into multi-b=
uffer packet but not updating next_to_clean results in I40E_DESC_UNUSED() t=
o return incorrect values.
> A similar issue was reported and fixed on the non-ZC path: https://lore.k=
ernel.org/netdev/20231004083454.20143-1-tirthendu.sarkar@intel.com/

Great, thanks! Now everything is clear to me. I think it would be
great if Alessandro can add/revise something like this in the commit
message.

Anyway, as to the code itself, feel free to add my tag:
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

>
> Thanks,
> Tirthendu

