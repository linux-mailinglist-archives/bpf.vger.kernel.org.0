Return-Path: <bpf+bounces-53658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CFFA57F63
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 23:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8875318923B6
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 22:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03CB21324B;
	Sat,  8 Mar 2025 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajlgNmDj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5A3212B37;
	Sat,  8 Mar 2025 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741473706; cv=none; b=hVwMt67PmwBGGNPMC7ovHwYTmc8AIuZ+m25CRQyCkEKcJ4FZzniuWNLFVFQmkl5jnW4xf/eEw6hBSc3wT6rYVAguROZtm8hjvnXUvy/bM6hd5OsgRSBm80TmxpuaKyIYRa2U/w240Rb/6aikhmJAaMIRj8WHTkLbmKZheMGxAQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741473706; c=relaxed/simple;
	bh=GlFnB3LmY4qSlV2qqA+wWWfR6yvVmGRtqr6ttgjWXCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W4ZhZOEi8ewxU7y7Ikckqfvyy9OX7vblUWGGMb4ZkMz39jYmL/rM3onYVHUUT14RbuMrdTH2Jo+vRJjmE+05mqqrHZcIL5y9M4KU2YDTnd09kGPjX32SGaeLUyQ7N7L/srPRdCR+ucJgenduCcnzFSRLNc3ZgQmblliEEryW7Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajlgNmDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A0EC4CEE0;
	Sat,  8 Mar 2025 22:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741473705;
	bh=GlFnB3LmY4qSlV2qqA+wWWfR6yvVmGRtqr6ttgjWXCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ajlgNmDjlcv6pwqOkP2ggq3If+GfP6ZdeFdir/KMjee4Up8FQ7IW46cSoXN+/ZpIW
	 TFDbLAB/uETzYbnlB6OiCWTycYLhFt3n0O3vlzSx9KhJBirixYtfdUe1hwfoUJdZZN
	 RBpUspuUcXobz/6BSrHn3qo1tu4KfQ+iowrpRpiiX7dQ1iWUZfYppDlHceDaTayYK2
	 o4D5HkumK3AW+erjkvYwGUyDhdf4aTzaONe1HD6B98XmJcYjtd0CRdgKTgVvSaXVwx
	 mXJKUPTBQvb0xXL4uPqp0E15WFeZvCOmIAyo66xjLxWO7tFl7UnPsBPTj5MDQj9xto
	 d237g5t4FHDjg==
Date: Sat, 8 Mar 2025 14:41:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kohei Enju <enjuk@amazon.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, "Ahmed Zaki"
 <ahmed.zaki@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Kohei Enju <kohei.enju@gmail.com>
Subject: Re: [PATCH net-next v1] dev: remove netdev_lock() and
 netdev_lock_ops() in register_netdevice().
Message-ID: <20250308144142.4f68c0be@kernel.org>
In-Reply-To: <20250308131813.4f8c8f0d@kernel.org>
References: <20250308203835.60633-2-enjuk@amazon.com>
	<20250308131813.4f8c8f0d@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Mar 2025 13:18:13 -0800 Jakub Kicinski wrote:
> On Sun, 9 Mar 2025 05:37:18 +0900 Kohei Enju wrote:
> > Both netdev_lock() and netdev_lock_ops() are called before
> > list_netdevice() in register_netdevice().
> > No other context can access the struct net_device, so we don't need these
> > locks in this context.  
> 
> Doesn't sysfs get registered earlier?
> I'm afraid not being able to take the lock from the registration
> path ties our hands too much. Maybe we need to make a more serious
> attempt at letting the caller take the lock?

Looking closer at the report - we are violating the contract that only
drivers which opted in get their ops called under the instance lock.
iavf had a similar problem but it had to opt in. WiFi doesn't.

Maybe we can bring the address semaphore back?
We just need to take it before the ops lock in do_setlink.
A bit ugly but would work?

