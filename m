Return-Path: <bpf+bounces-56620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4395A9B30F
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 17:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44D3188E13A
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 15:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0288727CB2E;
	Thu, 24 Apr 2025 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0IffPor"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4D82206A4;
	Thu, 24 Apr 2025 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510040; cv=none; b=bMrAGf3AL+dZrqq11Yc3i6X3SZvf2kHCeGnzTHhU7Vjfid7tJEBP94JhMGEzOIyC+5rUs8Kvi0zm/0W8/Kbp4Hj7gAh+x7IzLGIgVJE3Wo26ajKVzPvQmBpab6rUs/6iFle5jspJW/XDSm8c1ncX6dokXwESs1JFy3TBYkoUKWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510040; c=relaxed/simple;
	bh=R82HYVES0xXSReCLGJFbxZHPmhacZ1hchpjzGv4hlAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1fG/fvrHHOJjCz1+wD/MKc6Cq6eOVXwjvH3q9IAmB/Kazae50AIAAw53uX4KIPN5DE+545+SYjimbjhCK8ZErvyienOsRNGM4e4bZXSy6xVRP5ZvrScUV4miigfk+AUD03tJXPSQFmtnrP96rMbIF0Ym4/BXSMV5IftvyGJDis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0IffPor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB4BC4CEE3;
	Thu, 24 Apr 2025 15:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745510040;
	bh=R82HYVES0xXSReCLGJFbxZHPmhacZ1hchpjzGv4hlAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l0IffPorHipTRSznJD6lTnnncCNa9m2P4FK8XAIMF4OiyGgfUKDtIrHKpLd0cdiYY
	 Han7XpVtoscgwGNcjD9yJA+dNOywBTHGXQ/qjgCY6CKJba08j3nLa1XScbkSWMR7LI
	 T4YODjZrm6PRjYQ22DCydCjnZ+vRZsKcB3GmOrP8CpPe+PQX/PfhZlRFNbC2tMbg78
	 TTnDSPSOsIi6B2W1LibkrjuekDyJnsSaA8FDCZeu2YIiPsQQgTVkkGWxVfQ/VKXe3h
	 VpiZH/Fplu3bz7j4BFlSOSk+fXmtKrlrLvIz4c09G8q2vFHgEVRuDT7tGYDpyeF7dl
	 6Cnaty+bFP4ng==
Date: Thu, 24 Apr 2025 08:53:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, tom@herbertland.com, Eric
 Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNl?=
 =?UTF-8?B?bg==?= <toke@toke.dk>, dsahern@kernel.org,
 makita.toshiaki@lab.ntt.co.jp, kernel-team@cloudflare.com, phil@nwl.cc
Subject: Re: [PATCH net-next V6 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
Message-ID: <20250424085358.75d817ae@kernel.org>
In-Reply-To: <c6abaa9f-cd3e-4259-bed6-5e795ff58ecd@kernel.org>
References: <174549933665.608169.392044991754158047.stgit@firesoul>
	<174549940981.608169.4363875844729313831.stgit@firesoul>
	<20250424072352.18aa0df1@kernel.org>
	<c6abaa9f-cd3e-4259-bed6-5e795ff58ecd@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 17:24:51 +0200 Jesper Dangaard Brouer wrote:
> > Looks like I wrote a reply to v5 but didn't hit send. But I may have
> > set v5 to Changes Requested because of it :S Here is my comment:
> > 
> >   I think this is missing a memory barrier. When drivers do this dance
> >   there's usually a barrier between stop and recheck, to make sure the
> >   stop is visible before we check. And vice versa veth_xdp_rcv() needs
> >   to make sure other side sees the "empty" indication before it checks
> >   if the queue is stopped.  
> 
> The call netif_tx_stop_queue(txq); already contains a memory barrier
> smp_mb__before_atomic() plus an atomic set_bit operation.  That should
> be sufficient.

That barrier is _before_ stopping the queue. I'm saying we need a
barrier between stop and emptiness re-check. Note that:
 - smp_mb__after_atomic() is enough, and it 'compiles' to nothing
   on x86
 - all of this is the unlikely path :) You restart the qdisc
   when the ptr ring is completely full so the stopping in absolute
   worst case will happen once or twice per full ptr_ring ?

> And the other side veth_poll(), have a smp_store_mb() before reading
> ptr_ring.
> 
> --Jesper
> 
> p.s.
> I actually had an alternative implementation of this, that only calls
> stop when it is needed.  See below, it kind of looks prettier, but it
> adds an extra memory barrier in the likely path. (And I'm not sure if 
> read memory barrier is strong enough).

Not sure that works either :S

