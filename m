Return-Path: <bpf+bounces-61580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FF3AE8FD0
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 23:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5D43AEC94
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 21:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55FE210F4A;
	Wed, 25 Jun 2025 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPJKbcwn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED7B1C5D72;
	Wed, 25 Jun 2025 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750885439; cv=none; b=Ato0j+AfyaFFR2deNRhmXPDfWB+QFDgPfKuxU6CNqFEblRpuXh2zShnijxDcggQABQDmJANLshbbo5jw8vSCaySEkcgs94bGWLaL8f6/QjJTfqGFqVmG3gGmXHsH4JvTIrMEB0WrOqPb9nAv+QjDna+7wsg4nyitnDQC5Dt4psg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750885439; c=relaxed/simple;
	bh=PhkYe7t5yFDyw6IQO26rETSMJSLnXIw9aFwWd1vgons=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZqOVf6VHcsOdLOazTPjUACIt5SzTzb/GSMZxD4rkn1txX2JIHsOANNdN8dH/4aB8HcXWIs4ie3ZK7uYAEJoYmu8CTxUdscMwVCP9ThxzlUI/t8kLPUn5mV5Mh3fEdGvgoILOC98TB4nEFhqrWuj8ityd7oEkjwjigr/rJ0YF9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPJKbcwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893BBC4CEEA;
	Wed, 25 Jun 2025 21:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750885439;
	bh=PhkYe7t5yFDyw6IQO26rETSMJSLnXIw9aFwWd1vgons=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CPJKbcwnABYLJfLjYd/Ztzca4lPfzmpMY3nKt1JjNb2OdqqWe/iQ51Hbf/yNQkkHW
	 i3ewTwnBTTYC6oAWa50bsHi1XTasTVIuvyN8zIgr15ST/AVZgoQvPvX8bXo8UfFJ9r
	 bvavyu9rFAZ4U9yEjPy81yEaD3d8ZlKf1zYBuHMlXOEJLLs48CK/l1fBKuVGn0kSYc
	 6h9ZScC6y0DmJ+htdlAlm2a/Po/zuQRNilquIzIzOgDUpAxhjdL0DzislgD0zf6BMp
	 4UT6jglIYa0UZ7cEy4P3bxfz5X62EKsAo+Ll81ryT1vaj6NQpGE8cZPSTyUZokkNAq
	 B7DIKIo4//eNQ==
Date: Wed, 25 Jun 2025 14:03:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, syzbot
 <syzbot+e67ea9c235b13b4f0020@syzkaller.appspotmail.com>, andrii@kernel.org,
 ast@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, jonathan.lemon@gmail.com, linux-kernel@vger.kernel.org,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in xsk_notifier (3)
Message-ID: <20250625140357.6203d0af@kernel.org>
In-Reply-To: <aFxgg4rCQ8tfM9dw@mini-arch>
References: <685af3b1.a00a0220.2e5631.0091.GAE@google.com>
	<CAL+tcoB0as6+5VOk9nu0M_OH4TqT6NjDZBZmgQgdQcYx0pciCw@mail.gmail.com>
	<aFwQZhpWIxVLJ1Ui@mini-arch>
	<CAL+tcoCmiT9XXUVGwcT1NB6bLVK69php-oH+9UL+mH6_HYxGhA@mail.gmail.com>
	<aFwZ5WWj835sDGpS@mini-arch>
	<aFxgg4rCQ8tfM9dw@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 13:48:03 -0700 Stanislav Fomichev wrote:
> > > I'm still learning the af_xdp. Sure, I'm interested in it, just a bit
> > > worried if I'm capable of completing it. I will try then.  
> > 
> > SG, thanks! If you need more details lmk, but basically we need to reorder
> > netdev_lock_ops() and mutex_lock(lock: &xs->mutex)+XSK_READY check.
> > And similarly for cleanup (out_unlock/out_release) path.  
> 
> Jakub just told me that I'm wrong and it looks similar to commit
> f0433eea4688 ("net: don't mix device locking in dev_close_many()
> calls"). So this is not as easy as flipping the lock ordering :-(

I don't think registering a netdev from NETDEV_UP even of another
netdev is going to play way with instance locks and lockdep.
This is likely a false positive but if syzbot keeps complaining
we could:

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index 995a7207bdf8..f357a7ac70ac 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -81,7 +81,7 @@ static struct lapbethdev *lapbeth_get_x25_dev(struct net_device *dev)
 
 static __inline__ int dev_is_ethdev(struct net_device *dev)
 {
-       return dev->type == ARPHRD_ETHER && strncmp(dev->name, "dummy", 5);
+       return dev->type == ARPHRD_ETHER && !netdev_need_ops_lock(dev);
 }
 
IDK what the dummy hack is there for, it's been like that since 
git begun..

