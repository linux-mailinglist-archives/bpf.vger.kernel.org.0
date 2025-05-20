Return-Path: <bpf+bounces-58583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15A4ABDEA9
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 17:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3458C1625
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 15:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAEB25F96C;
	Tue, 20 May 2025 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJQr4VA5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0152C25EF90;
	Tue, 20 May 2025 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754313; cv=none; b=QEg46BcrRxUnoE6bOjverB9JpNzEA9Iut7DA9mQz377pHvubTD5+YHg2tgFZBv9XY5FAnF7+z5abt19GJqwzoLureWLHmcU3HQubJCSNQdZZOPkjw6bl7xXGny+9UTrvjg18kWoSBz+QBAwWhWd+hmoBY8i8SzDVnhZt1lZqZfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754313; c=relaxed/simple;
	bh=G7HZ66SmdXHKt4VEr2YiAj2viFMQ+WdO1H2Y1UCRV84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0m96KzAnP3ABH7lhCzMuGD0xog+wLT9OSZZwJclf7cf0Sbnrtv590hmO8ahE92HpcztyYE4BODOhw143u2qn1UenfWAa38FNakaR6mUYZ1ne3WvuajLB805iNLxyNXXrBY/FAgLliMn2vKRKuLEccWdadoDQBc/uB0kTH7Sb8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJQr4VA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289BBC4CEE9;
	Tue, 20 May 2025 15:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747754312;
	bh=G7HZ66SmdXHKt4VEr2YiAj2viFMQ+WdO1H2Y1UCRV84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJQr4VA5P33AB4hSfUm1KKA+XEwvVN5s14iaLvcFWwkhzP17ru1yv6xyd+pP5cfZu
	 Zqvf5j6At+TDaDtj0bYiJIbAtpIFn8hIK3c2kwJk1CjjgJ1B63mbCm+vtL+kWPLfCq
	 Z883NsZoIoYKHYCH1aoDwAWKpfuPkRIlGkbz1xW2CJgUS1mI3CnZ/wyjyEEUr8wFs5
	 V+3WAnRn4sMg52KkgDZolIwVyjX08O/xsjz8Mm5u4A8AgMcr2d1VX2F5vPbhZVuTV+
	 r7dKZegDU9DNiluk/bbYquj9b0sWPjh/qM3LqvjEXmhbAJuhe1jIifB7aUdbt2fw+I
	 dEVoGqLky2b1A==
Date: Tue, 20 May 2025 16:18:27 +0100
From: Simon Horman <horms@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	sdf@fomichev.me, netdev@vger.kernel.org, bpf@vger.kernel.org,
	jdamato@fastly.com, martin.lau@kernel.org, hramamurthy@google.com
Subject: Re: [PATCH net-next] eth: bnxt: fix deadlock when xdp is attached or
 detached
Message-ID: <20250520151827.GA365796@horms.kernel.org>
References: <20250520071155.2462843-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520071155.2462843-1-ap420073@gmail.com>

On Tue, May 20, 2025 at 07:11:55AM +0000, Taehee Yoo wrote:
> When xdp is attached or detached, dev->ndo_bpf() is called by
> do_setlink(), and it acquires netdev_lock() if needed.
> Unlike other drivers, the bnxt driver is protected by netdev_lock while
> xdp is attached/detached because it sets dev->request_ops_lock to true.
> 
> So, the bnxt_xdp(), that is callback of ->ndo_bpf should not acquire
> netdev_lock().
> But the xdp_features_{set | clear}_redirect_target() was changed to
> acquire netdev_lock() internally.
> It causes a deadlock.
> To fix this problem, bnxt driver should use
> xdp_features_{set | clear}_redirect_target_locked() instead.
> 
> Splat looks like:
> ============================================
> WARNING: possible recursive locking detected
> 6.15.0-rc6+ #1 Not tainted
> --------------------------------------------
> bpftool/1745 is trying to acquire lock:
> ffff888131b85038 (&dev->lock){+.+.}-{4:4}, at: xdp_features_set_redirect_target+0x1f/0x80
> 
> but task is already holding lock:
> ffff888131b85038 (&dev->lock){+.+.}-{4:4}, at: do_setlink.constprop.0+0x24e/0x35d0
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&dev->lock);
>   lock(&dev->lock);
> 
>  *** DEADLOCK ***

...

> 
> Fixes: 03df156dd3a6 ("xdp: double protect netdev->xdp_flags with netdev->lock")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> 
> This is a bugfix patch but target branch is net-next because the cause
> commit is not yet merged to net.

Reviewed-by: Simon Horman <horms@kernel.org>


