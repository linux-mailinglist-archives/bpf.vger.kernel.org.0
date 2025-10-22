Return-Path: <bpf+bounces-71729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA347BFC5DD
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 16:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C7B44351135
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 14:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7957F34AAE7;
	Wed, 22 Oct 2025 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ni0FVWAM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD11329C51;
	Wed, 22 Oct 2025 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141844; cv=none; b=mw9/HoI6prDQJGQ8baOShyqKAxy+tuPziwkxeV4yujiDQM4srEa8H9tdabzgLcw1ELWrBSsjcjzPY2zCmWXcVt4Is1ifeMdILPWRhw9U/0X8VUhSjBKqeRoUktamRKW6PHO9xT9hP4R7deZi1TuOZ7CnoxUA3xm6fVv51lrD4mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141844; c=relaxed/simple;
	bh=djPYKjLNpujT9UWSdxS+LwDKZXuToGzFEeI/1zO8Gbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyHftCvxH2F2raIOmYWlsbZLflZIg6RjXNwuqPHFkr/sEujIfO1T3wPphbsOznb7qTDX5x0zVaC4EtKYI7Fr5yzGn4GoMBaogBbTlRXEgtSwDDz2wn/HGxh3kaM/avZU5xWdZREaLzFBuRPxv7r9/d2il7MyDvWmNbPEy7r1IQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ni0FVWAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC5CC4CEE7;
	Wed, 22 Oct 2025 14:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761141843;
	bh=djPYKjLNpujT9UWSdxS+LwDKZXuToGzFEeI/1zO8Gbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ni0FVWAMjvNHBXwT70nTiJspsXgatH+BWkNmvKVvMiBPR+jHH4Dv/czd3xgn1MV8u
	 HHXlZZwYnWIoiiK9rDWP24tMD9xnWrntcSVU/abClr0RFCnhNoSDz5x0uxumQ+cXmf
	 SK0uqh8duCWqsAV47F/fazxNDzQhaeDRiZbMzLgBXISHu8xGObSQCaXFiWvgIh/PMQ
	 ohX2f4gBpOnyfU+BzInaqm5xjvdlH8IiyBzloaylUGzltJfQh2S61I25Q8vjP04YrE
	 jVT8xIvAy2XRPJDaDKEPdnLI5+vV51lqfOxjiXRHFQ5I2VaMNpFvx+QlBcjd3uHWgS
	 PPhjHinF9F1yw==
Date: Wed, 22 Oct 2025 07:04:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <ilias.apalodimas@linaro.org>, <toke@redhat.com>,
 <lorenzo@kernel.org>, <netdev@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <andrii@kernel.org>, <stfomichev@gmail.com>,
 <syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v2 bpf 1/2] xdp: update xdp_rxq_info's mem type in XDP
 generic hook
Message-ID: <20251022070401.0a02452d@kernel.org>
In-Reply-To: <aPi+cfwuGq2r+8RZ@boxer>
References: <20251017143103.2620164-1-maciej.fijalkowski@intel.com>
	<20251017143103.2620164-2-maciej.fijalkowski@intel.com>
	<50cbda75-9e0c-4d04-8d01-75dc533b8bb9@kernel.org>
	<025d2281-caf0-4f88-8f31-b0bfa5596aec@intel.com>
	<aPZ3FvcIVOPVxQum@boxer>
	<20251021180136.39431ed3@kernel.org>
	<aPi+cfwuGq2r+8RZ@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 13:22:25 +0200 Maciej Fijalkowski wrote:
> > > veth's pp works on order-0 pages well, however I agree it would be better
> > > to use virt_to_head_page() here.  
> > 
> > In this case the mem.type update is for consuming frags only, right?
> > We can't free the head itself since the skb is attached to it.
> > So running the predicates on xdp->data is probably wrong.  
> 
> See the veth patch where we bump refcount of related pages in order to
> keep the data as skb is consumed.

That one is wrong too. In veth's case since we care about refs on
individual frags you _should_ actually use skb->pp_recycle for the
condition. And you need to test whether each individual fragment
is from the PP. Basically call skb_pp_frag_ref() like
skb_try_coalesce() does?

BTW it is _not_ legal to call get_page() on slab pages any more
so all of this code should probably fail when head_frag=0.
But let's leave that problem to someone else.

> > Is it possible to get to bpf_prog_run_generic_xdp() (with frags)
> > and without going thru netif_skb_check_for_xdp() ? If no then
> > frags must have come from skb_pp_cow(). 
> > And the type is always MEM_TYPE_PAGE_POOL ?  
> 
> We have a fallback path netif_skb_check_for_xdp() that linearizes skb, in
> case COW code failed. But bare in mind that bpf_prog_run_generic_xdp() has
> other callsites, besides generic XDP itself (cpumap and devmap). That is
> why I wouldn't like to base this helper on assumptions such as frags
> presence -> mem_type is pp.

I assumed cpumap and devmap must be hit from a generic XDP handler.
Ergo we also much have gone thru the COW.


