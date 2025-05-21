Return-Path: <bpf+bounces-58643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DE9ABEE31
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 10:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3711890B9C
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 08:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF5A237194;
	Wed, 21 May 2025 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Te1UzWPM"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA7922DF8C;
	Wed, 21 May 2025 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747816903; cv=none; b=WHeuHYXtDSVDNWuDYJxS6cnGF1NaUoIW3LxmPurf1GHtZsZd696sgh1klzcgTEIPLLJv65iE3iisHQnThUrgOJ1svJyfDiHCDolovFP4GszdjeXZIg4JlGPfKgRF68y8csc7pLlctVbsnSD+oD3ksU5z3x16SOujn0fxtfN6ngI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747816903; c=relaxed/simple;
	bh=uDw+ZJwPUxdSq79IaOADCgJrAkenZYaEAEllmnA9MDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eA/bmtPtoZroSfbvZRVWjaZdsZtr68irX14ZaUXZDw+xxPzCt+ubn8oQwaMEQ2QyTnZlap/lXM3QsezxqhQvLqqgswZhRLXOBtcPLZkyZtZ4Agp/aA0nZrwSLPfZR3IkGZhYQyC4HE668zmFRncUSOX1Vi7jbfZsNisdgmwY1gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Te1UzWPM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 85448206832E; Wed, 21 May 2025 01:41:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 85448206832E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747816901;
	bh=tm3MPeyl5HQEq5tXrQRcuuPXKgXrLcNsWDnrjbtd2j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Te1UzWPMJbaE7ikWZF5NBSuS4LtcbCPuwnIeM7MGge51yMYKZt47Mv25LGNXiuHwd
	 fpV0GNyvDTyo6ID/nGVU90BzMl8A1TpX9F8Jd+q1qt5vwCSL5cVH1gpLXPAJHitAru
	 9pPqZyvMre1TESFttWl5kkfXE1jRtvY5qdCCdYUQ=
Date: Wed, 21 May 2025 01:41:41 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, kuniyu@amazon.com,
	ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	ssengar@microsoft.com, stable@vger.kernel.org
Subject: Re: [PATCH net] hv_netvsc: fix potential deadlock in
 netvsc_vf_setxdp()
Message-ID: <20250521084141.GA10135@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1747540070-11086-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1747540070-11086-1-git-send-email-ssengar@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sat, May 17, 2025 at 08:47:50PM -0700, Saurabh Sengar wrote:
> The MANA driver's probe registers netdevice via the following call chain:
> 
> mana_probe()
>   register_netdev()
>     register_netdevice()
> 
> register_netdevice() calls notifier callback for netvsc driver,
> holding the netdev mutex via netdev_lock_ops().
> 
> Further this netvsc notifier callback end up attempting to acquire the
> same lock again in dev_xdp_propagate() leading to deadlock.
> 
> netvsc_netdev_event()
>   netvsc_vf_setxdp()
>     dev_xdp_propagate()
> 
> This deadlock was not observed so far because net_shaper_ops was never
> set and this lock in noop in this case. Fix this by using
> netif_xdp_propagate instead of dev_xdp_propagate to avoid recursive
> locking in this path.
> 
> This issue has not observed so far because net_shaper_ops was unset,
> making the lock path effectively a no-op. To prevent recursive locking
> and avoid this deadlock, replace dev_xdp_propagate() with
> netif_xdp_propagate(), which does not acquire the lock again.
> 
> Also, clean up the unregistration path by removing unnecessary call to
> netvsc_vf_setxdp(), since unregister_netdevice_many_notify() already
> performs this cleanup via dev_xdp_uninstall.
> 
> Fixes: 97246d6d21c2 ("net: hold netdev instance lock during ndo_bpf")
> Cc: stable@vger.kernel.org
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---

Built and booted successfully. 

Tested-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com> 

Thanks!

