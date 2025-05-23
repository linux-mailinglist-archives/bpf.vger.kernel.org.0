Return-Path: <bpf+bounces-58818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DA5AC1AE2
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 06:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8267B81BC
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 04:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FC72222D8;
	Fri, 23 May 2025 04:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qteADHn1"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572E8367;
	Fri, 23 May 2025 04:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747973174; cv=none; b=DGHy8RNLIT5lwu5gDPB08gSUAPCD+CIapmej8GpKXdTn3b6qmz52Swnn8uUBB3iN9KgQZAL2gIV8dmXSx1TRLS3owE/bHjT7fjGioh2n1AmdUYIIoNSxwmWHYCmmSYW8dpRxf3zmW+XVYlnQlyJDRkmq6LEtyoR81M8HDx6NBZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747973174; c=relaxed/simple;
	bh=Dd6hg5anYs4NDvtjZ+7fjfMWyb/P3mJi/lIxyob4a0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MW0jwiBID1s5SaoEvzWpeaYjuJUR9+YYN6tWP7VSlA4V+5xgEotFPvKr+MlSsrc67+IhBcz/YhrJq+xzBspclIxlP3qHMJ5qqQfu0hn+73i70O+x4epp3aBMii6rWfIxGLyqrae4TWRDiKxboSU+qgo5HjAs1jpfVQxg1juX5pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qteADHn1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id DD8C5201DB37; Thu, 22 May 2025 21:06:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DD8C5201DB37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747973166;
	bh=NAc+eegSvTa3ay9n8M4zgkCmIydrJCYRiYijS0bKWHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qteADHn1rWU9VHl2Z/C4U8p+yUZcUHpD1HTu6F5tS2wBexDJ3bi5X9adO6ru9agQ6
	 3ksSh2+9mxpgeP5AK491vtaBbjHdzBmbrEMLo4D3JEGN1S/gRXNEWItDhKAk1Siuw9
	 oA+4VyzttcT6utUrI+yZWEe8O2iLUhyLdpZjHBgI=
Date: Thu, 22 May 2025 21:06:06 -0700
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
Message-ID: <20250523040606.GA25497@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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
> 
> There's also the call to netvsc_register_vf() on probe path, please
> fix or explain why it doesn't need locking in the commit message.

This patch specifically addresses the netvsc_register_vf() path only.
I omitted the mention of netvsc_register_vf() in the commit message
to keep the function path shorter. The full stack trace is provided below:

[   92.542180]  dev_xdp_propagate+0x2c/0x1b0
[   92.542185]  netvsc_vf_setxdp+0x10d/0x180 [hv_netvsc]
[   92.542192]  netvsc_register_vf.part.0+0x179/0x200 [hv_netvsc]
[   92.542196]  netvsc_netdev_event+0x267/0x340 [hv_netvsc]
[   92.542200]  notifier_call_chain+0x5f/0xc0
[   92.542203]  raw_notifier_call_chain+0x16/0x20
[   92.542205]  call_netdevice_notifiers_info+0x52/0xa0
[   92.542209]  register_netdevice+0x7c8/0xaa0
[   92.542211]  register_netdev+0x1f/0x40
[   92.542214]  mana_probe+0x6e2/0x8e0 [mana]
[   92.542220]  mana_gd_probe+0x187/0x220 [mana]

If you prefer I can update the stack trace in commit meesage
From:

netvsc_netdev_event()
  netvsc_vf_setxdp()
    dev_xdp_propagate()

To:

netvsc_netdev_event()
  netvsc_register_vf()
    netvsc_vf_setxdp()
      dev_xdp_propagate()

- Saurabh

> -- 
> pw-bot: cr

