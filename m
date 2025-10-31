Return-Path: <bpf+bounces-73094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D07E1C22F19
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 03:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C083BBDB3
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 02:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E472B26ED3B;
	Fri, 31 Oct 2025 02:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOkc75/5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F5A28E5;
	Fri, 31 Oct 2025 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761876318; cv=none; b=nH7Bt2wz62Pru8IR9/a+1Atl595J0LCHJHxb5ZrzwHZnQocuAXWxDWb1gCA+zwKzToj4tLQgy+5It0O6/2DuZuTv114DP/RbmQdsZQOs7pBfX52/oOy7j58Kp3HREta4IAPxLIMyARI+jIMYL/7gn9PKulYg2X5+tM4V5dzMBlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761876318; c=relaxed/simple;
	bh=P9Tfb4RwA08e0ImGfAA2P1HN0darONaXjzYRa28JM0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HV7qF2kfqN1ry0/plKKG4Q3VHUbzj5grNQv+B+Ad159qOL5hdubCIVWlR2xgd/EK57fBkSbWAadWZA0H8hXLiQoLvV3JeIKy+McaKPjwrfAWVCL48VaBFpsKJTXjU3ghehab3L/MJcaqhzHlFjdQch8OZUGbPP40xR+cnDkjYsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOkc75/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356EEC4CEF1;
	Fri, 31 Oct 2025 02:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761876317;
	bh=P9Tfb4RwA08e0ImGfAA2P1HN0darONaXjzYRa28JM0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YOkc75/5/Z2P5mTFTWqCSpd3k6fw9NeWIJGiG3EfFS0WrEQbNUYYA4S2BFHVmAsqZ
	 sHGo++Q9J3knOnszeVth6EPO0ebkGh5czdAVUdhMqR8faVDu6HJIrr/6WH6pjKP9gs
	 3TKeHpZsKHOPTojAGyzabbgYefUeGTzOd+sH85bI/Iy9wcElS/HatkyaecCzY/8D3m
	 QTQLnatqyxr187q65D0BUyj3sYy5Lp1W7RMYHyCPuBqcjiX/8PtiSxDc+yruQuu72/
	 WZ7l9ctLMlnUad7KDIBJp7Mk32h+kQYu2uweO/iitNPdkTJVuWHe0WsURUy8h7zC8a
	 mxSGWkmKjtmWQ==
Date: Thu, 30 Oct 2025 19:05:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
 <aleksander.lobakin@intel.com>, <ilias.apalodimas@linaro.org>,
 <toke@redhat.com>, <lorenzo@kernel.org>,
 <syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v5 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
Message-ID: <20251030190511.62575480@kernel.org>
In-Reply-To: <aQPJCvBgR3d7lY+g@boxer>
References: <20251029221315.2694841-1-maciej.fijalkowski@intel.com>
	<20251029221315.2694841-2-maciej.fijalkowski@intel.com>
	<20251029165020.26b5dd90@kernel.org>
	<aQNWlB5UL+rK8ZE5@boxer>
	<20251030082519.5db297f3@kernel.org>
	<aQPJCvBgR3d7lY+g@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 21:22:34 +0100 Maciej Fijalkowski wrote:
> > > Why do you say so?
> > > 
> > > netif_receive_generic_xdp()
> > > 	netif_skb_check_for_xdp()
> > > 	skb_cow_data_for_xdp() failed
> > > 		go through skb linearize path
> > > 			returned skb data is backed by kmalloc, not page_pool,
> > > 			means mem type for this particular xdp_buff has to be
> > > 			MEM_TYPE_PAGE_SHARED
> > > 
> > > Are we on the same page now?  
> > 
> > No, I think I already covered this, maybe you disagreed and I missed it.
> > 
> > The mem_type set here is expected to be used only for freeing pages. 
> > XDP can only free fagments (when pkt is trimmed), it cannot free the
> > head from under the skb. So only fragments matter here, we can ignore
> > the head.  
> 
> ...and given that linearize path would make skb a frag-less one...okay -
> I'm buying this! :D I have some other thoughts, but I would like to
> finally close this pandora's box, you probably have similar feelings.
> 
> So plain assignment like:
> xdp->rxq->mem.type = MEM_TYPE_PAGE_POOL;

Yes, LGTM.

> would be fine for you? Plus AI reviewer has kicked me in the nuts on veth
> patch so have to send v6 anyways.

The veth side unfortunately needs more work than Mr Robot points out.
For some reason veth tries to turn skb into an xdp_frame..

Either we have to make it not do that - we could probably call
xdp_do_generic_redirect() and for Tx .. figure out the right incantation 
to give the frame back to the peer veth.

Or, if we didn't hit CoW, you need to actually add the incantation we
removed here, there:

	xdp->rxq->mem.type = skb->pp_recycle && page_pool_page_is_pp(..) ?
		MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;

Or CoW the head retroactively if we hit the Tx/Redir path.

My intuition is that first option (making the handling as similar to
XDP generic as possible) is going to be least buggy long term.

