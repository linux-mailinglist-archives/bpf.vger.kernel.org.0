Return-Path: <bpf+bounces-72930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1841C1DAE6
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 00:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BB53A6D07
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 23:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9576830ACFD;
	Wed, 29 Oct 2025 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xrkhe0rt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B1B3016EC;
	Wed, 29 Oct 2025 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761780167; cv=none; b=aZP8zH9JiBHZRsr9Fy6LxkLGsCS5MvhawkrtIwyg3utFVztFRybEhqOEMI0HQKqn2eCIyu28fuuWRNxIoxPQ2JOZAIxGisuCYLrIa0jxHHnsWJNDtWUv4wViNPR6ip/sWJg2aU69Te3h3FrztLAGWo8HS+2ObPNV4zuDzsFv+w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761780167; c=relaxed/simple;
	bh=XfK7JHGgcV2jmqGRlhl77zkJdT4cOEZMdGSvay6g27A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2TP8rVWp8VQrkIuxrcO8icnhnfYt1Yw5WPRrDJZ8ObsncVe7kNdTFo2686tK5qOD8V4vL5E7DHW3WZy4uz+ZQ1lJP0YDEgUTvmOSpw1jTdDCxwzWxvK07RV3kctq7VEX0KeZiLkOT0aHopNOspazWXbT7XwVheanuAknPn7DFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xrkhe0rt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360F0C4CEF7;
	Wed, 29 Oct 2025 23:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761780166;
	bh=XfK7JHGgcV2jmqGRlhl77zkJdT4cOEZMdGSvay6g27A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xrkhe0rtaX4KOAJ+gY5UlxEt0y35cZWhbvxyi+jCGcbfi0BWzsJua982+1JHIsvGP
	 QE1iLwBplea8YZf053uMX0qb4S4M8SiDRLuoW2dg/qevMR3Oy2gfCz94mYhkevaiO9
	 A77hU402kWytO3vcjC63sXilMIwiG38QPhuxLDsU2IDKeoTsjUulBsb/Rqu05aV6GR
	 DDCIa5n/mCikyf/uGpQ41DzK0VIYL/w9VJk4LZn3IwVFWOA+iAetX1N5bAmNrHIKVd
	 a8ObIFge+dBTavJ/Cz8JEzFt0SMroWKc4/Q2zW/0AuUXLXjuoTRcyIQLqC5vPXGF28
	 cytqHosTnzQuQ==
Date: Wed, 29 Oct 2025 16:22:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, kerneljasonxing@gmail.com,
 fw@strlen.de
Subject: Re: [PATCH 2/2 bpf v2] xsk: avoid data corruption on cq descriptor
 number
Message-ID: <20251029162245.5ea2ee3e@kernel.org>
In-Reply-To: <b21cf80c-5d69-4914-aa45-00f9527f3436@suse.de>
References: <20251028183032.5350-1-fmancera@suse.de>
	<20251028183032.5350-2-fmancera@suse.de>
	<20251028160107.5c161a4f@kernel.org>
	<b21cf80c-5d69-4914-aa45-00f9527f3436@suse.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 08:51:58 +0100 Fernando Fernandez Mancera wrote:
> On 10/29/25 12:01 AM, Jakub Kicinski wrote:
> > On Tue, 28 Oct 2025 19:30:32 +0100 Fernando Fernandez Mancera wrote:  
> >> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> >> production"), the descriptor number is stored in skb control block and
> >> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
> >> pool's completion queue.  
> > 
> > Looking at the past discussion it sounds like you want to optimize
> > the single descriptor case? Can you not use a magic pointer for that?
> > 
> > 	#define XSK_DESTRUCT_SINGLE_BUF	(void *)1
> > 	destructor_arg = XSK_DESTRUCT_SINGLE_BUF
> > 
> > Let's target this fix at net, please, I think the complexity here is
> > all in skbs paths.  
> 
> I might be missing something here but if the destructor_arg pointer is 
> used to do this, where should we store the umem address associated with 
> it? In the proposed approach the skb extension should not be increased 
> for non-fragmented traffic as there is only a single descriptor and 
> therefore we can store the umem address in destructor_arg directly.

I see. Pointers are always aligned to 8B, you can stash the "pointer
type" there. If the bottom bit is 1 it's a umem and the skb was
single-chunk. If it's non-0 then it's a full kmalloc'ed struct.

> The size of the skb extension will only increase for fragmented traffic 
> (multiple descriptors).. but sure, if there is a fallback to the 
> slowpath, it will burden a bit the performance. Although, for that to 
> happen the must have tried to use AF_XDP family initially.. AFAICS, the 
> size of skb extension is only increased when skb_ext_add() is called.

To be clear by adding an skb extension you are de-facto allocating 
a bit in the skb struct. Just one of the bits of the active_extensions
field instead of a separate bitfield. If you can depend on the socket
association instead this is quite wasteful.

