Return-Path: <bpf+bounces-69861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9862BA4FBE
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 21:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0A0188D120
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 19:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EF327FD49;
	Fri, 26 Sep 2025 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+UoXvST"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D11A0728;
	Fri, 26 Sep 2025 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758915613; cv=none; b=jV9Xjqy0K/hRXB0ZHgw0cLH3dbEwAXnqxaz1i19ldD5KySfKLLG5Xh7ECA16oIR/CbAduhvWEeEJ2JHPzv0VXN6QF/iOh73wn7nk1dC+nplboZ6EBFdTCVT+lyq/Pwin76dqrU59Z69ThNHYZCFXbRd490T4NEosYg6XlkWfEik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758915613; c=relaxed/simple;
	bh=EO6z0Phj/ld9M4A1WmxS9LVoI+ci/L4osGwLhXb/yQg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXROXf43lY87XsZGlOhHNzaV1t7N2nT3hxU1JcBlDrQjJVPwCJ5olJe9nB7E3h0fHI5U7FWqtn/98lgn44vdqvm4aO5Tyqk3Fn/h50QVbze/334V0bqW3akIX+l5wWi9heoLBsb+d9pQ9QsghMYjAupjllFmJdsOAki8Z7hHZWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+UoXvST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1105DC4CEF4;
	Fri, 26 Sep 2025 19:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758915611;
	bh=EO6z0Phj/ld9M4A1WmxS9LVoI+ci/L4osGwLhXb/yQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W+UoXvSTAbANd76Wvw8qouFDDpPal5Sq7D1tY6YAnKofK5Bmz+O76xsutRLhuYlQ4
	 7CovVXGfEOyINH20AB+ElzGQhSjWlSThaKmz0xnz3003oIsMAuX6+rFV8G5qXAJ6lj
	 xq/kBkmlIYSeBocLrfP2xWbRNLSxXXrjGO592sDSow7hQwLB0NkNOe+uWbBMWjdjSI
	 qt6r1LfGnSD3BoyyC+jOsDXhP9WRWXAHPfvAykkuO63Bf9WfIIoCMdxnwdglRs3B1R
	 tCHwwzEiswu9PmtqJhFGcl4jOjHlXzT05Swh4x6L6tllN3Wmar0nGNgfvTOpxFT8nb
	 mWNE75QEZuRDA==
Date: Fri, 26 Sep 2025 12:40:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Octavian Purdila <tavip@google.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
 <john.fastabend@gmail.com>, <sdf@fomichev.me>, <ahmed.zaki@intel.com>,
 <aleksander.lobakin@intel.com>, <toke@redhat.com>, <lorenzo@kernel.org>,
 <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Kuniyuki Iwashima
 <kuniyu@google.com>
Subject: Re: [PATCH net] xdp: use multi-buff only if receive queue supports
 page pool
Message-ID: <20250926124010.4566617b@kernel.org>
In-Reply-To: <aNZ33HRt+SxltbcP@boxer>
References: <20250924060843.2280499-1-tavip@google.com>
	<20250924170914.20aac680@kernel.org>
	<CAGWr4cQCp4OwF8ESCk4QtEmPUCkhgVXZitp5esDc++rgxUhO8A@mail.gmail.com>
	<aNUObDuryXVFJ1T9@boxer>
	<20250925191219.13a29106@kernel.org>
	<CAGWr4cSiVDTUDfqAsHrsu1TRbumDf-rUUP=Q9PVajwUTHf2bYg@mail.gmail.com>
	<aNZ33HRt+SxltbcP@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Sep 2025 13:24:12 +0200 Maciej Fijalkowski wrote:
> On Fri, Sep 26, 2025 at 12:33:46AM -0700, Octavian Purdila wrote:
> > On Thu, Sep 25, 2025 at 7:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote: =20
> > Ah, yes, you are right. So my comment in the commit message about
> > TUN/TAP registering a page shared memory model is wrong. But I think
> > the fix is still correct for the reported syzkaller issue. From
> > bpf_prog_run_generic_xdp:
> >=20
> >         rxqueue =3D netif_get_rxqueue(skb);
> >         xdp_init_buff(xdp, frame_sz, rxq: &rxqueue->xdp_rxq);
> >=20
> > So xdp_buff's rxq is set to the netstack queue for the generic XDP
> > hook. And adding the check in netif_skb_check_for_xdp based on the
> > netstack queue should be correct, right? =20
>=20
> Per my limited understanding your change is making skb_cow_data_for_xdp()
> a dead code as I don't see mem model being registered for these stack
> queues - netif_alloc_rx_queues() only calls xdp_rxq_info_reg() and
> mem.type defaults to MEM_TYPE_PAGE_SHARED as it's defined as 0, which
> means it's never going to be MEM_TYPE_PAGE_POOL.

Hah, that's a great catch, how did I miss that..

The reason for the cow is that frags can be shared, we are not allowed
to modify them. It's orthogonal.

> IMHO that single case where we rewrite skb to memory backed by page pool
> should have it reflected in mem.type so __xdp_return() potentially used in
> bpf helpers could act correctly.
>=20
> > > Well, IDK how helpful the flow below would be but:
> > >
> > > veth_xdp_xmit() -> [ptr ring] -> veth_xdp_rcv() -> veth_xdp_rcv_one()
> > >                                                                |
> > >                             | xdp_convert_frame_to_buff()   <-'
> > >     ( "re-stamps" ;) ->     | xdp->rxq =3D &rq->xdp_rxq;
> > >   can eat frags but now rxq | bpf_prog_run_xdp()
> > >          is veth's          |
> > >
> > > I just glanced at the code so >50% changes I'm wrong, but that's what
> > > I meant. =20
> >=20
> > Thanks for the clarification, I thought that "re-stamps" means the:
> >=20
> >     xdp->rxq->mem.type =3D frame->mem_type;
> >=20
> > from veth_xdp_rcv_one in the XDP_TX/XDP_REDIRECT cases.
> >=20
> > And yes, now I think the same issue can happen because veth sets the
> > memory model to MEM_TYPE_PAGE_SHARED but veth_convert_skb_to_xdp_buff
> > calls skb_pp_cow_data that uses page_pool for allocations. I'll try to
> > see if I can adapt the syzkaller repro to trigger it for confirmation. =
=20
>=20
> That is a good catch.

FWIW I think all calls to xdp_convert_frame_to_buff() must come with
the hack that cpu_map_bpf_prog_run_xdp() is doing today. Declare rxq
on the stack and fill in the mem info there. I wonder if we should add
something to the API (xdp_convert_frame_to_buff()) to make sure people
don't forget to do this..

