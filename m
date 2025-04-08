Return-Path: <bpf+bounces-55463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9CAA80EA2
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 16:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2727C4A600F
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 14:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A862522D789;
	Tue,  8 Apr 2025 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lixf5KHG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECA71B6CE5;
	Tue,  8 Apr 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744123032; cv=none; b=ty9F/Ic0H0dRzpnLGf2e6aUWvfUDrIzBO859CjdcsFDgBeUX8JBpTsWUGEgUuZ6SbPsI29kte5NVNvGghqgH8bvgnzTJWJEPH1idlUqfAoVxjGcWF1vZC18YdplCoMOPvHYftxnAryHI8y278kHT4iHZJdEbPI1Ra+0/1hmcvVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744123032; c=relaxed/simple;
	bh=ge7Yi7sJL1C7pl6511bZFnXdwJzMPUqWBNRdwjkzS8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9jGt39TbYodSK1bGU8HKNBlNumda9WRJskdme7UimiXGwdOCIXjIn4lDpzYEfabfAJuWLIErhhpLEKrYa7vONu7KbjTtbo3oataJ9ohrvpWTWwUAxm7lrxG6B5wj71ozt8bZc4ZK/nyiRhfXx+MtjWaOoh9eoy6MKCJE0WSmFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lixf5KHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7F3C4CEEB;
	Tue,  8 Apr 2025 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744123031;
	bh=ge7Yi7sJL1C7pl6511bZFnXdwJzMPUqWBNRdwjkzS8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lixf5KHGMLgrJHRF0vXObNxfQVuWjjQKvS6Run+Q0sxRNDh7nGg00pGvTON5bejy6
	 /H7zP+PKgO3AHBvFDlScfylFFrPXBMO8ZPTzA7qhFrX/YngpDVbcmc43jbX+Ac720W
	 2bRlb54Z7mRBel+jUzTAeNYDeY9IQmEWj1G99Y7vo/aChGUUuxqxKDzgHmGuU2A4ce
	 yugvuVQLVYxKc3sEZ8mCz4Bbs419T+/fdcPZlSBWGG7xEQqI7q+U4xzhNnhOuCbHNK
	 +L9TAM5bHfROj51JGapXbzojYT4Hdwbm3Wz1SU40PAi2EgIFZwWhgHUL08EN4A4x2v
	 aYjeRT+sIt9Uw==
Date: Tue, 8 Apr 2025 07:37:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Bui Quang Minh
 <minhquangbui99@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, "David S . Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio-net: disable delayed refill when pausing rx
Message-ID: <20250408073709.4e054636@kernel.org>
In-Reply-To: <1b78c63b-7c07-4d25-8785-bfb0e28c71ad@redhat.com>
References: <20250404093903.37416-1-minhquangbui99@gmail.com>
	<1743987836.9938157-1-xuanzhuo@linux.alibaba.com>
	<30419bd6-13b1-4426-9f93-b38b66ef7c3a@gmail.com>
	<CACGkMEs7O7D5sztwJVn45c+1pap20Oi5f=02Sy_qxFjbeHuYiQ@mail.gmail.com>
	<1b78c63b-7c07-4d25-8785-bfb0e28c71ad@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Apr 2025 11:28:54 +0200 Paolo Abeni wrote:
> >> When napi_disable is called on an already disabled napi, it will sleep
> >> in napi_disable_locked while still holding the netdev_lock. As a result,
> >> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
> >> This leads to refill_work and the pause-then-resume tx are stuck altogether.  
> > 
> > This needs to be added to the chagelog. And it looks like this is a fix for
> > 
> > commit 413f0271f3966e0c73d4937963f19335af19e628
> > Author: Jakub Kicinski <kuba@kernel.org>
> > Date:   Tue Jan 14 19:53:14 2025 -0800
> > 
> >     net: protect NAPI enablement with netdev_lock()
> > 
> > ?
> > 
> > I wonder if it's simpler to just hold the netdev lock in resize or xsk
> > binding instead of this.  
> 
> Setting:
> 
> 	dev->request_ops_lock = true;
> 
> in virtnet_probe() before calling register_netdevice() should achieve
> the above. Could you please have a try?

Can we do that or do we need a more tailored fix? request_ops_lock only
appeared in 6.15 and the bug AFAIU dates back to 6.14. We don't normally
worry about given the stream of fixes - request_ops_lock is a bit risky.
Jason's suggestion AFAIU is just to wrap the disable/enable pairs in
the lock. We can try request_ops_lock in -next ?

Bui Quang Minh, could you add a selftest for this problem?
See tools/testing/selftests/drivers/net/virtio_net/
You can re-use / extend the XSK helper from
tools/testing/selftests/drivers/net/xdp_helper.c ?
(move it to tools/testing/selftests/net/lib for easier access)

