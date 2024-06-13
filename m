Return-Path: <bpf+bounces-32088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C325F9074DB
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 16:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6139D285184
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 14:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F9514658C;
	Thu, 13 Jun 2024 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogjDdw34"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352DC145321;
	Thu, 13 Jun 2024 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718288026; cv=none; b=CKLtDKWHuRYUjbOAlJ1CsMolvil5ER4TVGwQnrq0HIXL2wIIVAlVqyisrLGbpaKPsR1cUcbNR7qYGZlUvKQa1dyLaHI17cLrnQiTP4NPpNpmI/qAXvuzRt0L2LayuTdyBxAGVh5mM/DRs2yDzTvuf2W6rCcKeDZOhJRk315D6jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718288026; c=relaxed/simple;
	bh=miLeVMM2w5yAcnT3uzAx4GpVzV/Y9CzVC17jsvEBUfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFrRW8EsNPzlLdlfDrJ98UN7hAf2zD27vz4a+wAsvDSARhauN1EmjMqobC1P0FqC+2/8s6UcDvaKrrIdcoMepodiM1CjAkTZGmSRXqo1TpwB2h9QBwr8qnhRDAll1A5cmDqcskeC4h9QVYwayQ0ZkvGb8lnBwU7ZqUE0DxuEwpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogjDdw34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C59BC2BBFC;
	Thu, 13 Jun 2024 14:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718288024;
	bh=miLeVMM2w5yAcnT3uzAx4GpVzV/Y9CzVC17jsvEBUfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ogjDdw34aMYbnVFXO1TQJ6gxcFOElu+kQ1l9kcwCvX/5TJXX6Y46YnhOfBue9+SfZ
	 KpPZTJi+ymmNr/Fe68Gb+Dj57jzeUz4dXcdurC3Y09XSnhkysiQrzzFouyiUXmPG+h
	 0Kw32Ke9rEiUSd1lqkOMQXvXVpp7YdjaLVT8YQdUjqxJpeUE/hzDrskqDgJmQaAtLh
	 37Y3FO250POxonskubWav59Lxb9Vj8N2COWpo2ifg80tyiSjgFNLU5YuwuFpltcUAS
	 pavfyYFer7rPxxkOfzw+IPQUsivZ0OlfTrFK3ejk/7EUpbu2SoYv2OJdtoIY5zQygp
	 rp62AoeqnUtCw==
Date: Thu, 13 Jun 2024 07:13:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: <intel-wired-lan@lists.osuosl.org>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <magnus.karlsson@intel.com>, Michal Kubiak <michal.kubiak@intel.com>
Subject: Re: [PATCH iwl-net 0/3] ice: fix synchronization between .ndo_bpf()
 and reset
Message-ID: <20240613071343.019e7dca@kernel.org>
In-Reply-To: <ZmqztPo6UDIC6gKx@lzaremba-mobl.ger.corp.intel.com>
References: <20240610153716.31493-1-larysa.zaremba@intel.com>
	<20240611193837.4ffb2401@kernel.org>
	<ZmlGppe04yuGHvPx@lzaremba-mobl.ger.corp.intel.com>
	<20240612140935.54981c49@kernel.org>
	<ZmqztPo6UDIC6gKx@lzaremba-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 10:54:12 +0200 Larysa Zaremba wrote:
> > > The locking mechanisms I use here do not look pretty, but if I am not missing 
> > > anything, the synchronization they provide must be robust.  
> > 
> > Robust as in they may be correct here, but you lose lockdep and all
> > other infra normal mutex would give you.
> 
> I know, but __netif_queue_set_napi() requires rtnl_lock() inside the potential 
> critical section and creates a deadlock this way. However, after reading 
> patches that introduce this function, I think it is called too early in the
> configuration. Seems like it should be called somewhere right after 
> netif_set_real_num_rx/_tx_queues(), much later in the configuration where we 
> already hold the rtnl_lock(). In such way, ice_vsi_rebuild() could be protected 
> with an internal mutex. WDYT?

On a quick look I think that may work. For setting the NAPI it makes
sense - netif_set_real_num_rx/_tx_queues() and netif_queue_set_napi()
both inform netdev about the queue config, so its logical to keep them
together. I was worried there may be an inconveniently placed
netif_queue_set_napi() call which is clearing the NAPI pointer.
But I don't see one.

> > > A prettier way of protecting the same critical sections would be replacing 
> > > ICE_CFG_BUSY around ice_vsi_rebuild() with rtnl_lock(), this would eliminate 
> > > locking code from .ndo_bpf() altogether, ice_rebuild_pending() logic will have 
> > > to stay.
> > > 
> > > At some point I have decided to avoid using rtnl_lock(), if I do not have to. I 
> > > think this is a goal worth pursuing?  
> > 
> > Is the reset for failure recovery, rather than reconfiguration? 
> > If so netif_device_detach() is generally the best way of avoiding
> > getting called (I think I mentioned it to someone @intal recently).  
> 
> AFAIK, netif_device_detach() does not affect .ndo_bpf() calls. We were trying 
> such approach with idpf and it does work for ethtool, but not for XDP.

I reckon that's an unintentional omission. In theory XDP is "pure
software" but if the device is running driver will likely have to
touch HW to reconfigure. So, if you're willing, do send a ndo_bpf 
patch to add a detached check.

