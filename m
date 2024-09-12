Return-Path: <bpf+bounces-39726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 332EC976C23
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 16:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659511C23EB3
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 14:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44F81AE845;
	Thu, 12 Sep 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aNCGov2V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3EKcb1I7"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9FE1A288;
	Thu, 12 Sep 2024 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151436; cv=none; b=qDRNHy0rcK2bOtcUzgZ2Ww1NOhDfK5Cnw+RuVfSt8FmM+UxsKh8ec5YN1lD7bskQKLXc021NkYw/uFyA/SFQV0DURnjjnZa7bHjcTGyJyDArFQOHzyQHrwp0CSx4ESGVasJSTdMiF9FrG98KvDBwdxBLGg5VJNGpDjIV80FWeUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151436; c=relaxed/simple;
	bh=c9BNPsL77m1gQNF1oxGnA6X84UuD3I9ZPTkZK7KMHYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dyn5aRvjbEaiVk3itkgkqLUkY9pNprGDVHL+vNhfE7yUeRsXUjQigogslkf5/30hZ1Xikg7rRG/LTvZ74wNjPuUzohJVl3OAyFDwIUGez/jOWvpLZ7NXUc2AKc1fyr379xprzq/HlYgFn3iOvejlqdfbH3Bi0MTD80Ba8MrCMRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aNCGov2V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3EKcb1I7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Sep 2024 16:30:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726151431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YMoxcCQIasVaG6BJNCbOIJ88x2l5R7R9pyvVhbXBFnc=;
	b=aNCGov2VgbjIooThREsfzPjpq3/+0RsA2TGGPjCizETv00FQWtsB4EGS1kZ+srN0bM6mvT
	Kl1EfcYeaHZVa4zl76A1cpSVEGu2T/WYZA0mqljxyu8N8fYTxJFhcahR713Hhc47HYRNI3
	G5AdSUP8ncjj/IaLqxfZCnJCdtHk1MifeZ632iTp33zIfDGI8f7Q3oLp9aCWGzdYDnwum+
	eUOg6lA4h6wbSOKSZBv1R+jdutsZKNbPs96R5keQU0Ku+Sp76kjaQvuIVjl9Wj52ADoA7v
	RyyKfKM9ipabZNUsjP/Xj8X30AVKi5gPM1XawjaY+7rUECH/aLjD4GvSzEaSeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726151431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YMoxcCQIasVaG6BJNCbOIJ88x2l5R7R9pyvVhbXBFnc=;
	b=3EKcb1I7TH/mpczaBA3bRNietzZphMO2D0yDuHkW49ln5odOfqWdI3pNwB2EaH8n3LlaRC
	O2NsyIyIY+oop/Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Breno Leitao <leitao@debian.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>, andrii@kernel.org, ast@kernel.org,
	syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>,
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev,
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org,
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [PATCH net-net] tun: Assign missing bpf_net_context.
Message-ID: <20240912143029.x5iudw-g@linutronix.de>
References: <000000000000adb970061c354f06@google.com>
 <20240702114026.1e1f72b7@kernel.org>
 <20240703122758.i6lt_jii@linutronix.de>
 <20240703120143.43cc1770@kernel.org>
 <20240912-simple-fascinating-mackerel-8fe7c0@devvm32600>
 <20240912122847.x70_LgN_@linutronix.de>
 <20240912-hypnotic-messy-leopard-f1d2b0@leitao>
 <9a2a1cce-8d92-4d10-87ea-4cdf1934d5fb@linux.dev>
 <20240912-organic-spoonbill-of-discourse-ad2e6e@leitao>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912-organic-spoonbill-of-discourse-ad2e6e@leitao>

On 2024-09-12 07:19:54 [-0700], Breno Leitao wrote:
> Hello Vadim,
> 
> On Thu, Sep 12, 2024 at 02:32:55PM +0100, Vadim Fedorenko wrote:
> > On 12/09/2024 14:17, Breno Leitao wrote:
> > > @@ -72,6 +73,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
> > >   	struct net_device *peer;
> > >   	int len = skb->len;
> > > +	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
> > >   	rcu_read_lock();
> > 
> > Hi Breno,
> > 
> > looks like bpf_net_ctx should be set under rcu read lock...
> 
> Why exactly?
> 
> I saw in some examples where bpf_net_ctx_set() was set inside the
> rcu_read_lock(), but, I was not able to come up with justification to do
> the same. Would you mind elaborating why this might be needed inside the
> lock?

It might have been done due to simpler nesting or other reasons but
there is no requirement to do this under RCU protection. The assignment
and cleanup is always performed task-local.

> Thanks for the review,
> --breno

Sebastian

