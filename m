Return-Path: <bpf+bounces-73992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 654E6C4243A
	for <lists+bpf@lfdr.de>; Sat, 08 Nov 2025 02:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11E2334A87E
	for <lists+bpf@lfdr.de>; Sat,  8 Nov 2025 01:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F052BE7A7;
	Sat,  8 Nov 2025 01:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mf+Gza0J"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE8D219A71;
	Sat,  8 Nov 2025 01:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762566887; cv=none; b=dOTmGwJd3AQIFWNnqYvUn4gONq74S4xAPIFOY+3o7dD8FtEQ7mHRagvq/kc06PdBG+oAuVi1QkI5lfOD72zL7W+tFbEHDufL8pzV2ew1TYKRTHwwiLawP3Gd+qbylIWDqo/cdWbJXXNEmq69f6fAN8747GeOrWCI9ntpFYedfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762566887; c=relaxed/simple;
	bh=KwsTq0eN5+f8YdZnUHqQpE5xoyBoiV9hCa9F5h/P17o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoOejuhJ4T/aVt0pqcsopypYvRYqPybM1zGiK5cj+mBGgQyc3Axb9cf7LGe1tuF4atgi+YnytxGICKdr8+83tUM9lm25oxMFj1ZdJUyHZM2pF1m1B1FH757MBv/7O3CszZdypaVlvouwVqsOjQGR2spAoARA9rb6SuDF5gYb7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mf+Gza0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBE8C4CEF5;
	Sat,  8 Nov 2025 01:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762566887;
	bh=KwsTq0eN5+f8YdZnUHqQpE5xoyBoiV9hCa9F5h/P17o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mf+Gza0JFU9wwYzaaLr+Yz+a/NK52E0dh7W0GPm5dBRZRLEOWC1aoz67jd6UiXZWN
	 ggugPJh3Rg4bNcs3N4qCQzqznHh0xcz1m8CbkRqwTFfohJ0meHtsYwdDwL9s8sl2lJ
	 3a+mBCq6YiSdLHlhQ60jbpdiMIZzsZw58o/QpPzYYETu5oaaKm2chHyHNDd4Gt5Tyw
	 V67EoOgzymb0GmmZMZgazI7b9yPArdQk+846eQQXKxWHFgrZOxzznH/XkOtvfQziCO
	 vYen+B+Jdbu+C1c5Sb/fhOtVMLquY0lG83/vFpnHKEUdQqUsQnH4rV0CdBnXDahCst
	 IKf0IseIm7i/A==
Date: Fri, 7 Nov 2025 17:54:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@toke.dk>, Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 ihor.solodrai@linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 makita.toshiaki@lab.ntt.co.jp, toshiaki.makita1@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net V3 1/2] veth: enable dev_watchdog for detecting
 stalled TXQs
Message-ID: <20251107175445.58eba452@kernel.org>
In-Reply-To: <b9f01e64-f7cc-4f5a-9716-5767b37e2245@kernel.org>
References: <176236363962.30034.10275956147958212569.stgit@firesoul>
	<176236369293.30034.1875162194564877560.stgit@firesoul>
	<20251106172919.24540443@kernel.org>
	<b9f01e64-f7cc-4f5a-9716-5767b37e2245@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Nov 2025 14:42:58 +0100 Jesper Dangaard Brouer wrote:
> > I think this belongs in net-next.. Fail safe is not really a bug fix.
> > I'm slightly worried we're missing a corner case and will cause
> > timeouts to get printed for someone's config.
> 
> This is a recovery fix.  If the race condition fix isn't 100% then this
> patch will allow veth to recover.  Thus, to me it makes sense to group
> these two patches together.
> 
> I'm more worried that we we're missing a corner case that we cannot
> recover from. Than triggering timeouts to get printed, for a config
> where NAPI consumer veth_poll() takes more that 5 seconds to run (budget
> max 64 packets this needs to consume packets at a rate less than 12.8
> pps). It might be good to get some warnings if the system is operating
> this slow.
> 
> Also remember this is not the default config that most people use.
> The code is only activated if attaching a qdisc to veth, which isn't
> default. Plus, NAPI mode need to be activated, where in normal NAPI mode
> the producer and consumer usually runs on the same CPU, which makes it
> impossible to overflow the ptr_ring.  The veth backpressure is primarily
> needed when running with threaded-NAPI, where it is natural that
> producer and consumer runs on different CPUs. In our production setup
> the consumer is always slower than the producer (as the product inside
> the namespace have installed too many nftables rules).

I understand all of this, but IMO the fix is in patch 2.
This is a resiliency improvement, not a fix.

> >> +static void veth_tx_timeout(struct net_device *dev, unsigned int txqueue)
> >> +{
> >> +	struct netdev_queue *txq = netdev_get_tx_queue(dev, txqueue);
> >> +
> >> +	netdev_err(dev, "veth backpressure stalled(n:%ld) TXQ(%u) re-enable\n",
> >> +		   atomic_long_read(&txq->trans_timeout), txqueue);  
> > 
> > If you think the trans_timeout is useful, let's add it to the message
> > core prints? And then we can make this msg just veth specific, I don't
> > think we should be repeating what core already printed.  
> 
> The trans_timeout is a counter for how many times this TXQ have seen a
> timeout.  It is practical as it directly tell us if this a frequent
> event (without having to search log files for similar events).
> 
> It does make sense to add this to the core message ("NETDEV WATCHDOG")
> with the same argument.  For physical NICs these logs are present in
> production. Looking at logs through Kibana (right now) and it would make
> my life easier to see the number of times the individual queues have
> experienced timeouts.  The logs naturally gets spaced in time by the
> timeout, making it harder to tell the even frequency. Such a patch would
> naturally go though net-next.

Right, I see how it'd be useful. I think it's worth adding in the core.

> Do you still want me to remove the frequency counter from this message?
> By the same argument it is practical for me to have as a single log line
> when troubleshooting this in practice. 

IOW it makes it easier to query logs for veth timeouts vs non-veth
timeouts? I'm tempted to suggest adding driver name to the logs in
the core :) but it's fine, I'm already asking you to add the timeout
count in the core.

I'm just trying to make sure everyone can benefit from the good ideas,
rather than hiding them in one driver.

> BTW, I've already backported this watchdog patch to prod kernel
> (without race fix) and I'll try to reproduce the race in staging/lab
> on some ARM64 servers.  If I reproduce it will be practical to have
> this counter.

