Return-Path: <bpf+bounces-67388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4913B430B8
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 05:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DC95E5FCE
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 03:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157F522B8A6;
	Thu,  4 Sep 2025 03:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="UJbp9oQO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AB27E107
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 03:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756958317; cv=none; b=gJtxGCxWdwtu+wh26qrLpsae6XEORvZq3onxL0+f+hUq/n8JB/RVR0SiW3ixfmViy1GZsQ2y7CdZ5jDYdWVvw30C4sL/i7VtChAxZq1lRFIkq9HQo0dIRtaw0HFvbveXtZT4tWU03z2CBb4+zzAgz5YiZtfmO8g5fBvwmAQQN9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756958317; c=relaxed/simple;
	bh=+rXXxOB+OEB8xG56G10rYz3XXsV4fu6ja9srvzVKxxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrYg+48wDdWqSk+5Y+ts8PLP0+UwhfRpo1a55t9eOqBUxm3WK3WDZc173nXrEcsK51VKwZDayidcmtNyC7kWvbH/GgJD0GKZ7LK+twpMT3PbRYfqItjkW2fIOoVrUDqmv6yVMWyvol0xv1vETv71l44SqEF9bIU4WRGGceaowVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=UJbp9oQO; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f7ab2a84eso561445e87.1
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 20:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1756958313; x=1757563113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VhhM16Stf7vyA77g+HaAZhQu0TNv44cntB0IdQQAV4=;
        b=UJbp9oQOAtrC9sUDnJDJ8dRmKIW7hx7LZ+1xwwkiaUFPeJh6HBG57/dXcT2geoxwib
         aj1Sx+sh7z0mUmXOmqNhyfetO3ZpEc5Nx2oSsHaXRYvdqVsska6rTAdO8R4iqbMxnkOZ
         +hk3/sAAtm5i8An1e2as3SFC02o+3B1x9Hebw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756958313; x=1757563113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VhhM16Stf7vyA77g+HaAZhQu0TNv44cntB0IdQQAV4=;
        b=f/gZdu/+VMhUiRbVqwXw2KQwyg9+I7PRLPgebK0oh7O3iEt7ONtw4/cVUGdooPM+D5
         lV62lt2LRr99EXznpHWBdAsXnBfJqqAYDcI2uKWoj8CsPQw1h33ZOHV3ksWqTo0LcCzG
         X9PsEHuFAO6EYpUKheNmGKmqiwPBL+HsH/uzuE0RFuiQ5kpy+q967K9C2P+j+yHpSCpC
         xsaj8yFeY18ITf2S2ydqYLhr8fEhyCHEXfWOyliwS47cGvy3SdjWTELWQhX6vHr70bOJ
         9X5/vuZcZXSTR86HigoninSPnsyfSpYxlPhQPcMQhh3TrryXgqRYFlE8bMfB8x8g3SL1
         OvbA==
X-Forwarded-Encrypted: i=1; AJvYcCVrbEh9guneORC6huLPyMzzFuRh0t+6nW6pjmst6IxI+2kVfFWhoOOgLr4Bm3A9SjBNZnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZjFC4MeTXg59Y09+JJ7V8h54B4qt5TtuqcUo5lpzx2leIgNRV
	sV0jXrNVoze2JHpQoyWHnr9CTKsoqQ3qe7PTwIe7/Uye0t585LmQtHn92fuN4DzD1zXVu1YC99p
	Tp5XLXt184rws8aV62XiOkpi+JzQAFS5jH2Nhh41LvA==
X-Gm-Gg: ASbGncuZ3dUsickEroIfSL7jY8c3qmRpHZXKN8IZEbO9/B0B+cUr2f0nATjGqmesgQv
	YIrTleP8hzExkia+4xKenwfg9InGN5WoYouQ4F4JpeFVoX0xoKtRBuBq9SQiEl29fZXxalDpoIn
	h9dJLXZ/zOMc1dHTBZ+E1Pee28IlTarPajnHLB8fiH5pkXj4CYHe+0OHc33UgsWW9qvbP5Kl2Lx
	M55GpEbB7ZAUfPzFturdUSrLKxqpght8D64aXD6F/a+7gUhH4OoJPh8VCV6Msw=
X-Google-Smtp-Source: AGHT+IGzBhzHz6EsCdpX8zlmDcPUrnT7rfCaeQWIlJN2l0CB+B2qTgqLypR8Mhfahru8f6wrnnqX3weuqiRAVdajrpM=
X-Received: by 2002:a05:6512:3b12:b0:55f:3ebc:133d with SMTP id
 2adb3069b0e04-55f708b5558mr5115245e87.21.1756958313081; Wed, 03 Sep 2025
 20:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
 <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-2-bfcd5033a77c@openai.com>
 <b840533a-25e1-4884-9d9e-222d9bf79635@gmail.com> <CADg4-L_83eNn9huME6tuZKeQWyG2xkKCUj9erqzMBGxWt=NKcA@mail.gmail.com>
 <CAMB2axNT0rF_ToMcj9yagZE3VqHhQpB7MX=zSem5J1gyDqPJcw@mail.gmail.com>
In-Reply-To: <CAMB2axNT0rF_ToMcj9yagZE3VqHhQpB7MX=zSem5J1gyDqPJcw@mail.gmail.com>
From: Christoph Paasch <cpaasch@openai.com>
Date: Wed, 3 Sep 2025 20:58:22 -0700
X-Gm-Features: Ac12FXyEVxN5ZWKFYDlH8yCF6n5YGB2wVz9YT2Jh-cXuVpUpcRcRiv3hyYG7hic
Message-ID: <CADg4-L-b9SzPN8EDOc3h_TVAnfTFPQXWpYd3vYD1exXGdH_kOQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
To: Amery Hung <ameryhung@gmail.com>
Cc: Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 5:12=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> On Wed, Sep 3, 2025 at 4:57=E2=80=AFPM Christoph Paasch <cpaasch@openai.c=
om> wrote:
> >
> > On Wed, Sep 3, 2025 at 4:39=E2=80=AFPM Amery Hung <ameryhung@gmail.com>=
 wrote:
> > >
> > >
> > >
> > > On 8/28/25 8:36 PM, Christoph Paasch via B4 Relay wrote:
> > > > From: Christoph Paasch <cpaasch@openai.com>
> > > >
> > > > mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> > > > bytes from the page-pool to the skb's linear part. Those 256 bytes
> > > > include part of the payload.
> > > >
> > > > When attempting to do GRO in skb_gro_receive, if headlen > data_off=
set
> > > > (and skb->head_frag is not set), we end up aggregating packets in t=
he
> > > > frag_list.
> > > >
> > > > This is of course not good when we are CPU-limited. Also causes a w=
orse
> > > > skb->len/truesize ratio,...
> > > >
> > > > So, let's avoid copying parts of the payload to the linear part. We=
 use
> > > > eth_get_headlen() to parse the headers and compute the length of th=
e
> > > > protocol headers, which will be used to copy the relevant bits ot t=
he
> > > > skb's linear part.
> > > >
> > > > We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the netw=
orking
> > > > stack needs to call pskb_may_pull() later on, we don't need to real=
locate
> > > > memory.
> > > >
> > > > This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NI=
C and
> > > > LRO enabled):
> > > >
> > > > BEFORE:
> > > > =3D=3D=3D=3D=3D=3D=3D
> > > > (netserver pinned to core receiving interrupts)
> > > > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> > > >   87380  16384 262144    60.01    32547.82
> > > >
> > > > (netserver pinned to adjacent core receiving interrupts)
> > > > $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> > > >   87380  16384 262144    60.00    52531.67
> > > >
> > > > AFTER:
> > > > =3D=3D=3D=3D=3D=3D
> > > > (netserver pinned to core receiving interrupts)
> > > > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> > > >   87380  16384 262144    60.00    52896.06
> > > >
> > > > (netserver pinned to adjacent core receiving interrupts)
> > > >   $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> > > >   87380  16384 262144    60.00    85094.90
> > > >
> > > > Additional tests across a larger range of parameters w/ and w/o LRO=
, w/
> > > > and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), diff=
erent
> > > > TCP read/write-sizes as well as UDP benchmarks, all have shown equa=
l or
> > > > better performance with this patch.
> > > >
> > > > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> > > > ---
> > > >   drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 5 +++++
> > > >   1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/driv=
ers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > > index 8bedbda522808cbabc8e62ae91a8c25d66725ebb..792bb647ba28668ad77=
89c328456e3609440455d 100644
> > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > > @@ -2047,6 +2047,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx=
5e_rq *rq, struct mlx5e_mpw_info *w
> > > >               dma_sync_single_for_cpu(rq->pdev, addr + head_offset,=
 headlen,
> > > >                                       rq->buff.map_dir);
> > > >
> > > > +             headlen =3D eth_get_headlen(skb->dev, head_addr, head=
len);
> > > > +
> > >
> > > Hi,
> > >
> > > I am building on top of this patchset and got a kernel crash. It was
> > > triggered by attaching an xdp program.
> > >
> > > I think the problem is skb->dev is still NULL here. It will be set la=
ter by:
> > > mlx5e_complete_rx_cqe() -> mlx5e_build_rx_skb() -> eth_type_trans()
> >
> > Hmmm... Not sure what happened here...
> > I'm almost certain I tested with xdp as well...
> >
> > I will try again later/tomorrow.
> >
>
> Here is the command that triggers the panic:
>
> ip link set dev eth0 mtu 8000 xdp obj
> /root/ksft-net-drv/net/lib/xdp_native.bpf.o sec xdp.frags
>
> and I should have attached the log:
>
> [ 2851.287387] BUG: kernel NULL pointer dereference, address: 00000000000=
00100
> [ 2851.301329] #PF: supervisor read access in kernel mode
> [ 2851.311602] #PF: error_code(0x0000) - not-present page
> [ 2851.321879] PGD 0 P4D 0
> [ 2851.326944] Oops: Oops: 0000 [#1] SMP
> [ 2851.334272] CPU: 11 UID: 0 PID: 0 Comm: swapper/11 Kdump: loaded
> Tainted: G S          E       6.17.0-rc1-gcf50ef415525 #305 NONE
> [ 2851.357759] Tainted: [S]=3DCPU_OUT_OF_SPEC, [E]=3DUNSIGNED_MODULE
> [ 2851.369252] Hardware name: Wiwynn Delta Lake MP/Delta Lake-Class1,
> BIOS Y3DL401 09/04/2024
> [ 2851.385787] RIP: 0010:eth_get_headlen+0x16/0x90
> [ 2851.394850] Code: 5e 41 5f 5d c3 b8 f2 ff ff ff eb f0 cc cc cc cc
> cc cc cc cc 0f 1f 44 00 00 41 56 53 48 83 ec 10 89 d3 83 fa 0e 72 68
> 49 89 f6 <48> 8b bf 00 01 00 00 44 0f b7 4e 0c c7 44 24 08 00 00 00 00
> 48 c7
> [ 2851.432413] RSP: 0018:ffffc90000720cc8 EFLAGS: 00010212
> [ 2851.442864] RAX: 0000000000000000 RBX: 000000000000008a RCX: 000000000=
00000a0
> [ 2851.457141] RDX: 000000000000008a RSI: ffff8885a5aee100 RDI: 000000000=
0000000
> [ 2851.471417] RBP: ffff8883d01f3900 R08: ffff888204c7c000 R09: 000000000=
0000000
> [ 2851.485696] R10: ffff8883d01f3900 R11: ffff8885a5aee340 R12: ffff8885a=
dd00030
> [ 2851.499969] R13: ffff8885add00030 R14: ffff8885a5aee100 R15: 000000000=
0000000
> [ 2851.514245] FS:  0000000000000000(0000) GS:ffff8890b4427000(0000)
> knlGS:0000000000000000
> [ 2851.530433] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2851.541931] CR2: 0000000000000100 CR3: 000000107d412003 CR4: 000000000=
07726f0
> [ 2851.556208] PKRU: 55555554
> [ 2851.561623] Call Trace:
> [ 2851.566514]  <IRQ>
> [ 2851.570540]  mlx5e_skb_from_cqe_mpwrq_nonlinear+0x7af/0x8d0
> [ 2851.581689]  mlx5e_handle_rx_cqe_mpwrq+0xbc/0x180
> [ 2851.591096]  mlx5e_poll_rx_cq+0x2ef/0x780
> [ 2851.599114]  mlx5e_napi_poll+0x10c/0x710
> [ 2851.606959]  __napi_poll+0x28/0x160
> [ 2851.613934]  net_rx_action+0x1c0/0x350
> [ 2851.621434]  ? mlx5_eq_comp_int+0xdf/0x190
> [ 2851.629628]  ? sched_clock+0x5/0x10
> [ 2851.636603]  ? sched_clock_cpu+0xc/0x170
> [ 2851.644450]  handle_softirqs+0xd8/0x280
> [ 2851.652121]  __irq_exit_rcu.llvm.7416059615185659459+0x44/0xd0
> [ 2851.663788]  common_interrupt+0x85/0x90
> [ 2851.671457]  </IRQ>
> [ 2851.675653]  <TASK>
> [ 2851.679850]  asm_common_interrupt+0x22/0x40

Oh, I see why I didn't hit the bug when testing with xdp... I wasn't
using a multi-buffer xdp prog and thus had to reduce the MTU and so
ended up not using the mlx5e_skb_from_cqe_mpwrq_nonlinear()
code-path...

I can reproduce the panic and will fix it.


Christoph

>
> Thanks for taking a look!
> Amery
>
> > Thanks!
> > Christoph
> >
> > >
> > >
> > > >               frag_offset +=3D headlen;
> > > >               byte_cnt -=3D headlen;
> > > >               linear_hr =3D skb_headroom(skb);
> > > > @@ -2123,6 +2125,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx=
5e_rq *rq, struct mlx5e_mpw_info *w
> > > >                               pagep->frags++;
> > > >                       while (++pagep < frag_page);
> > > >               }
> > > > +
> > > > +             headlen =3D eth_get_headlen(skb->dev, mxbuf->xdp.data=
, headlen);
> > > > +
> > > >               __pskb_pull_tail(skb, headlen);
> > > >       } else {
> > > >               if (xdp_buff_has_frags(&mxbuf->xdp)) {
> > > >
> > >

