Return-Path: <bpf+bounces-58831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 714ECAC22F3
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 14:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF40DA265C9
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 12:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9304449620;
	Fri, 23 May 2025 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="E0BEV1Pi"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED161FDD;
	Fri, 23 May 2025 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748004506; cv=none; b=hIcM2YlzYg50E2qVitW0OGUwSL5MxsJB2iQGcmuU8rUW8Ue0xnhrs9UoCQjqGBXY1dXpuQtRf0kxbd+evFBCllBnDFdGWLpLIuHLrIQIDMEuari7PCRBr03E1PSAUfMTh7u5yQQyISP5QbjGkbV3Uwk0kKE0oSENoCgPGKW9LnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748004506; c=relaxed/simple;
	bh=ep7ttSMYmIC7dSCZw6rB4THOYgYU0W+j3ONAkquPmvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LA/oOHh/Z9f6iiQJB7iI4LRn7gTtaPG6DtVEiQ9iYdTmfwwXGfAmvqoI8aXjpTOhZZWnrk8utRq9sBcmzh92qnTGDHa1Yd8m5z5IVgzJH1mlkcl2etIBer9g4q1GCxVTtsebKnngA8ycw8Xsr6k9ihUJknpK5Vi4dsR4JJbE4FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=E0BEV1Pi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 2B704206834F; Fri, 23 May 2025 05:48:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2B704206834F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748004504;
	bh=TK3pq8zeypwsvsAQp4lD9eQ6MH7Hnc9VhxYCb1JrU/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E0BEV1PiOKtEampixS2HTrQxuD6/TbQearDIPrcet4PyKtxbMC1/Q71ZYdfiTYVsH
	 moQRlxSHrYNO1KOo90RlnK3/DUbIJDZSuqyoA8rV+E3rS0NoL7tqL/q/1azAgm5xA2
	 jbfWowHxhBACmuy0yY8YgnAdfNdE4lhyN/FnXj8M=
Date: Fri, 23 May 2025 05:48:24 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, kuniyu@amazon.com,
	ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	ssengar@microsoft.com, stable@vger.kernel.org
Subject: Re: [PATCH net,v2] hv_netvsc: fix potential deadlock in
 netvsc_vf_setxdp()
Message-ID: <20250523124824.GA4946@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1747823103-3420-1-git-send-email-ssengar@linux.microsoft.com>
 <20250522151346.57390f40@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522151346.57390f40@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, May 22, 2025 at 03:13:46PM -0700, Jakub Kicinski wrote:
> On Wed, 21 May 2025 03:25:03 -0700 Saurabh Sengar wrote:
> > The MANA driver's probe registers netdevice via the following call chain:
> > 
> > mana_probe()
> >   register_netdev()
> >     register_netdevice()
> > 
> > register_netdevice() calls notifier callback for netvsc driver,
> > holding the netdev mutex via netdev_lock_ops().
> > 
> > Further this netvsc notifier callback end up attempting to acquire the
> > same lock again in dev_xdp_propagate() leading to deadlock.
> > 
> > netvsc_netdev_event()
> >   netvsc_vf_setxdp()
> >     dev_xdp_propagate()
> > 
> > This deadlock was not observed so far because net_shaper_ops was never set,
> 
> The lock is on the VF, I think you meant to say that no device you use
> in Azure is ops locked?

That's right.

> 
> There's also the call to netvsc_register_vf() on probe path, please
> fix or explain why it doesn't need locking in the commit message.

On rethinking I realize you were referring to the netvsc_probe() path not
mana_probe(). Since this lock is effectively a no-op, it doesn't really
matter whether it's there or not.

However, I think we can revisit this when we add ops for any of the VFs.

- Saurabh

