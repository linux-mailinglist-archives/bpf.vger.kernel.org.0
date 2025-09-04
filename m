Return-Path: <bpf+bounces-67369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25684B42E04
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 02:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E263B3B9B
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 00:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E85D3BBF2;
	Thu,  4 Sep 2025 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8cEhtfE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF1C1BC3F;
	Thu,  4 Sep 2025 00:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944731; cv=none; b=bUMNSC04d49ojMbtxVNwKCT8LKPIaeLU1ZQjE05VlX64Ds94I/AOYPC5PMQj7LIDzauDb1NAkwchvbTnqQMzkBk7XniJqxp/4PwIjnBd3SkWFRh2NvBbEjXL1Oc0JYHCAcTASVYW8Fcm3KJXWQL0gVkTnF0D77r6Z779PAfM29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944731; c=relaxed/simple;
	bh=DFBonaf0VF8blV7cwkIygrA0kAPu4J4GyQwRNkgYbGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzyv2ffZMCE0TqiVxAina4gJvVj6XoJ1dPbQ8jsg+FqsJsHEqTewYuw7cMp9Yw8Kb87luqxxKoDJ99AQAWBBpqGMMlw9h2lq3WyGh9Rt1ITXlsA85Czv/HQ8tQaKBoS7qS0Ei6dGFyaL27Q9hPu3uqDCnkyPIlk9hUkDg0BhqCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8cEhtfE; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d60504bf8so4990277b3.2;
        Wed, 03 Sep 2025 17:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756944729; x=1757549529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0o3TWxeaazhwYBbFCC4hkUMWT/pMIrsDXN2DtbJmOA=;
        b=h8cEhtfE3jfuftyOwDAUFGci+eKWXarNXsufITxr9sW70wEsP2SBddu1o0IUI7MUiw
         DYEhEA3f8K12d7OmWCVieGiRY4+lDLBlVIP6f5CTCgFRxHNpng6QNvfAAKk+aKfxc2QR
         yHyj+uimxOePc0qB1yTiRhtdy7rnHxturHeKOnrnFsJEfNnozGpiHmuFGJkoBuHt2wrT
         9Cb5/ATP92zf2/HxXKAm48bVmBtOnD3jPlM2F9dCLjOQ7OCQXv64xK00eDf0B+YmUZSa
         kyU6PfZ4t/07HOAy50afj+4633jKvIXF1IXRlaQ7arky+dPdZjIn2gIbpvB84EVze6sU
         21ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756944729; x=1757549529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0o3TWxeaazhwYBbFCC4hkUMWT/pMIrsDXN2DtbJmOA=;
        b=VJcIyso/Vh83Kq0FlfonDVofLqiWWpMQRgMA9hxsLQWICZ4B2zJEejX1VDI/7mU8tk
         kWWZzTkEhAT8yaym+yqrvDATNJDdgf8o+Hr2SkV439OC0JGS1lHed7xtpTjQrbuTsbdg
         9UpC6hTmiww0XlCT66FzBDS78ECfW0iW9hKRubN1/gqzHzMWplPer62RMwVo2Mw6obJQ
         ARFwFV+SR2qQLncKSXSCXyOI4kYKM3EJfL77cPFe3fknxntalxYa0ngS+g7hESGdrNcS
         WBoWm1qeZXUytoqyhu63Ar6raWybK8vO2PNEZZMhd8B/MvgtrJKCQ3EFKekNU6JqB+u8
         atOg==
X-Forwarded-Encrypted: i=1; AJvYcCWMR7hBLu1eswhkVbEXJXYdTQe9bwhF1yHnrKvYUejPvVnyH2Pd2XH0YooADECy9EuUMriC/+T2@vger.kernel.org, AJvYcCWaShmmmMsYpDb633AhO1CV1dhIUsCCtJ/ynIt83tFPNg63imE9oGbYGn4xHSb6Od9bp5k=@vger.kernel.org, AJvYcCWl0REuL2isE8Ep3XvCo9l+B8ugTA7n1H4hcgBVaihOjPo6YV1R5FUjk/TBOY6bzgQWeTxTJiRro+8a+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7weOWI+W9kd8Zx6weVIEj4CU5w5TwlrxHSc27ZqXWfPmVUTa7
	77TekqW/ijp0+Ox2ikc+Y8IErJE3AVc6SIp66iCx93JdXJ/Bbl8EjC13TNs1CrpyM3ZOZ492EDk
	DK2UMJoNKHQE5RU25EQ/f4t/8HdDVHjw=
X-Gm-Gg: ASbGncs/Ivi+RcArcZQB2Jyq70HbW4SR24zSSuR09NDJ7YMx46qUXul4yeGRzM2pY1b
	e/WMCO/SE9A4AtoTb8+OJw9Ed/NH1kjOX1Gb3vigrYvKQB1448ZSBTV2SZ9JUC/B2SktmTAIuKv
	/YI5E13MgV3cmG42BPQWXBqReFjmYzwCeMcASZUOfbiKN9Q+g/NL5Utx33oxCx+Ag1qaKP2rXk3
	4skTAKnZuwgWvhyzoCj+oVd
X-Google-Smtp-Source: AGHT+IG9HLsifqsq+7IaWjS+JAG0dRd6IsWbKkh8GJlIsLCmAHPxVQhGalSOIST0ADoamJaCG1osPqLcKztwoWqDOnI=
X-Received: by 2002:a05:690c:c85:b0:71f:efa8:5881 with SMTP id
 00721157ae682-72276512bbamr219977577b3.30.1756944728572; Wed, 03 Sep 2025
 17:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
 <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-2-bfcd5033a77c@openai.com>
 <b840533a-25e1-4884-9d9e-222d9bf79635@gmail.com> <CADg4-L_83eNn9huME6tuZKeQWyG2xkKCUj9erqzMBGxWt=NKcA@mail.gmail.com>
In-Reply-To: <CADg4-L_83eNn9huME6tuZKeQWyG2xkKCUj9erqzMBGxWt=NKcA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 3 Sep 2025 17:11:55 -0700
X-Gm-Features: Ac12FXxfN1O0baIk1WwtBKZX4md6sgE1dmIWHoj4qAijpJ5KPQnF5iYhxhR6tx4
Message-ID: <CAMB2axNT0rF_ToMcj9yagZE3VqHhQpB7MX=zSem5J1gyDqPJcw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
To: Christoph Paasch <cpaasch@openai.com>
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

On Wed, Sep 3, 2025 at 4:57=E2=80=AFPM Christoph Paasch <cpaasch@openai.com=
> wrote:
>
> On Wed, Sep 3, 2025 at 4:39=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
> >
> >
> >
> > On 8/28/25 8:36 PM, Christoph Paasch via B4 Relay wrote:
> > > From: Christoph Paasch <cpaasch@openai.com>
> > >
> > > mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> > > bytes from the page-pool to the skb's linear part. Those 256 bytes
> > > include part of the payload.
> > >
> > > When attempting to do GRO in skb_gro_receive, if headlen > data_offse=
t
> > > (and skb->head_frag is not set), we end up aggregating packets in the
> > > frag_list.
> > >
> > > This is of course not good when we are CPU-limited. Also causes a wor=
se
> > > skb->len/truesize ratio,...
> > >
> > > So, let's avoid copying parts of the payload to the linear part. We u=
se
> > > eth_get_headlen() to parse the headers and compute the length of the
> > > protocol headers, which will be used to copy the relevant bits ot the
> > > skb's linear part.
> > >
> > > We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the networ=
king
> > > stack needs to call pskb_may_pull() later on, we don't need to reallo=
cate
> > > memory.
> > >
> > > This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC =
and
> > > LRO enabled):
> > >
> > > BEFORE:
> > > =3D=3D=3D=3D=3D=3D=3D
> > > (netserver pinned to core receiving interrupts)
> > > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> > >   87380  16384 262144    60.01    32547.82
> > >
> > > (netserver pinned to adjacent core receiving interrupts)
> > > $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> > >   87380  16384 262144    60.00    52531.67
> > >
> > > AFTER:
> > > =3D=3D=3D=3D=3D=3D
> > > (netserver pinned to core receiving interrupts)
> > > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> > >   87380  16384 262144    60.00    52896.06
> > >
> > > (netserver pinned to adjacent core receiving interrupts)
> > >   $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> > >   87380  16384 262144    60.00    85094.90
> > >
> > > Additional tests across a larger range of parameters w/ and w/o LRO, =
w/
> > > and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), differ=
ent
> > > TCP read/write-sizes as well as UDP benchmarks, all have shown equal =
or
> > > better performance with this patch.
> > >
> > > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> > > ---
> > >   drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/driver=
s/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > index 8bedbda522808cbabc8e62ae91a8c25d66725ebb..792bb647ba28668ad7789=
c328456e3609440455d 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > @@ -2047,6 +2047,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e=
_rq *rq, struct mlx5e_mpw_info *w
> > >               dma_sync_single_for_cpu(rq->pdev, addr + head_offset, h=
eadlen,
> > >                                       rq->buff.map_dir);
> > >
> > > +             headlen =3D eth_get_headlen(skb->dev, head_addr, headle=
n);
> > > +
> >
> > Hi,
> >
> > I am building on top of this patchset and got a kernel crash. It was
> > triggered by attaching an xdp program.
> >
> > I think the problem is skb->dev is still NULL here. It will be set late=
r by:
> > mlx5e_complete_rx_cqe() -> mlx5e_build_rx_skb() -> eth_type_trans()
>
> Hmmm... Not sure what happened here...
> I'm almost certain I tested with xdp as well...
>
> I will try again later/tomorrow.
>

Here is the command that triggers the panic:

ip link set dev eth0 mtu 8000 xdp obj
/root/ksft-net-drv/net/lib/xdp_native.bpf.o sec xdp.frags

and I should have attached the log:

[ 2851.287387] BUG: kernel NULL pointer dereference, address: 0000000000000=
100
[ 2851.301329] #PF: supervisor read access in kernel mode
[ 2851.311602] #PF: error_code(0x0000) - not-present page
[ 2851.321879] PGD 0 P4D 0
[ 2851.326944] Oops: Oops: 0000 [#1] SMP
[ 2851.334272] CPU: 11 UID: 0 PID: 0 Comm: swapper/11 Kdump: loaded
Tainted: G S          E       6.17.0-rc1-gcf50ef415525 #305 NONE
[ 2851.357759] Tainted: [S]=3DCPU_OUT_OF_SPEC, [E]=3DUNSIGNED_MODULE
[ 2851.369252] Hardware name: Wiwynn Delta Lake MP/Delta Lake-Class1,
BIOS Y3DL401 09/04/2024
[ 2851.385787] RIP: 0010:eth_get_headlen+0x16/0x90
[ 2851.394850] Code: 5e 41 5f 5d c3 b8 f2 ff ff ff eb f0 cc cc cc cc
cc cc cc cc 0f 1f 44 00 00 41 56 53 48 83 ec 10 89 d3 83 fa 0e 72 68
49 89 f6 <48> 8b bf 00 01 00 00 44 0f b7 4e 0c c7 44 24 08 00 00 00 00
48 c7
[ 2851.432413] RSP: 0018:ffffc90000720cc8 EFLAGS: 00010212
[ 2851.442864] RAX: 0000000000000000 RBX: 000000000000008a RCX: 00000000000=
000a0
[ 2851.457141] RDX: 000000000000008a RSI: ffff8885a5aee100 RDI: 00000000000=
00000
[ 2851.471417] RBP: ffff8883d01f3900 R08: ffff888204c7c000 R09: 00000000000=
00000
[ 2851.485696] R10: ffff8883d01f3900 R11: ffff8885a5aee340 R12: ffff8885add=
00030
[ 2851.499969] R13: ffff8885add00030 R14: ffff8885a5aee100 R15: 00000000000=
00000
[ 2851.514245] FS:  0000000000000000(0000) GS:ffff8890b4427000(0000)
knlGS:0000000000000000
[ 2851.530433] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2851.541931] CR2: 0000000000000100 CR3: 000000107d412003 CR4: 00000000007=
726f0
[ 2851.556208] PKRU: 55555554
[ 2851.561623] Call Trace:
[ 2851.566514]  <IRQ>
[ 2851.570540]  mlx5e_skb_from_cqe_mpwrq_nonlinear+0x7af/0x8d0
[ 2851.581689]  mlx5e_handle_rx_cqe_mpwrq+0xbc/0x180
[ 2851.591096]  mlx5e_poll_rx_cq+0x2ef/0x780
[ 2851.599114]  mlx5e_napi_poll+0x10c/0x710
[ 2851.606959]  __napi_poll+0x28/0x160
[ 2851.613934]  net_rx_action+0x1c0/0x350
[ 2851.621434]  ? mlx5_eq_comp_int+0xdf/0x190
[ 2851.629628]  ? sched_clock+0x5/0x10
[ 2851.636603]  ? sched_clock_cpu+0xc/0x170
[ 2851.644450]  handle_softirqs+0xd8/0x280
[ 2851.652121]  __irq_exit_rcu.llvm.7416059615185659459+0x44/0xd0
[ 2851.663788]  common_interrupt+0x85/0x90
[ 2851.671457]  </IRQ>
[ 2851.675653]  <TASK>
[ 2851.679850]  asm_common_interrupt+0x22/0x40

Thanks for taking a look!
Amery

> Thanks!
> Christoph
>
> >
> >
> > >               frag_offset +=3D headlen;
> > >               byte_cnt -=3D headlen;
> > >               linear_hr =3D skb_headroom(skb);
> > > @@ -2123,6 +2125,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e=
_rq *rq, struct mlx5e_mpw_info *w
> > >                               pagep->frags++;
> > >                       while (++pagep < frag_page);
> > >               }
> > > +
> > > +             headlen =3D eth_get_headlen(skb->dev, mxbuf->xdp.data, =
headlen);
> > > +
> > >               __pskb_pull_tail(skb, headlen);
> > >       } else {
> > >               if (xdp_buff_has_frags(&mxbuf->xdp)) {
> > >
> >

