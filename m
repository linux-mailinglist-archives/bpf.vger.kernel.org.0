Return-Path: <bpf+bounces-66012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FBFB2C57A
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 15:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C15B7AC4B2
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 13:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8803C224247;
	Tue, 19 Aug 2025 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ikoAqHUs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="407GAP/D"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F162EB855;
	Tue, 19 Aug 2025 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609973; cv=none; b=mTqrhhGmEwPQLAE58ShQy6vW62zHdy8z2VpvlgD2ey4jJ9t+4pFTiQOcHobsHzIwyk6YTBjXL0e4L5mUFwdJCWgBb2JpI+GCr4W6dDptDmOvzvqFJMVs8p3QN/3pVJpNCquPi9POnuJfzSCc+QN43ir/P76SHi+vB3a+bYZwot0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609973; c=relaxed/simple;
	bh=11EcSOl8r9sOnuqSlNW5+DwXH08T+2O1JfV8KXSS93c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXNjd/yiVPDkASUhB5/wcI39XliMgbUTqTtIrR3DzJqhytyLVJRp1vRzjsNzmve6jjKdD+Uzjo5Ax73zzOQV9if1nwGRCH+9cFf6btiHRi+8tWhneL09gEG/2giuwAgmENbIIfsa8bneAt7T0G7+MAuFIm0qiDoNrtn5gdGEyxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ikoAqHUs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=407GAP/D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Aug 2025 15:26:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755609969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eKgAKgDD4BgUO6EcawFhOqTDYO3Qs5T6BmZZDdDiLFY=;
	b=ikoAqHUsBHABRb3ZhZuBCW4UUl7aRhUvUxJUsncQtyZMiJgnkYvhY2IgSCkgxM9UX7Z6ps
	ePclUUwdCBf/Vi1qs7dXCsN5UYKjYB6+iAkOLgoYn/GP+5Y+/8wXXtPdx5EgDVvjgkk5Xy
	TEKfDxWOTjRSY4tP11IX0sYuwaL0+nbdWvD+0zhBGuYIttn/Sdm9orvSlewE5gz7s6RQKA
	J2cxGV7UvnuN8GL3zNPv2RonQn0ApuIFdrczsMNmClNfZXk3J3GrWEnvC1FeKWemuP2npe
	ocxwGWRbSLYurqzNn7iQOCiNDF0MaiyzEn89qVJviC5XSeKg5WWWPWHoRBeeiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755609969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eKgAKgDD4BgUO6EcawFhOqTDYO3Qs5T6BmZZDdDiLFY=;
	b=407GAP/DHT70dDA6OZmcIM3mLG5uM9M39sw2IGu+aHsDau9Ex0rZiBokBJ8gSEmtxbvakT
	JWW/1fwY4NN72qDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Thomas Graf <tgraf@suug.ch>,
	Paul McKenney <paulmck@kernel.org>,
	"open list:BPF [RINGBUF]" <bpf@vger.kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH] net/cls_cgroup: Fix task_get_classid() during qdisc run
Message-ID: <20250819132608.ofNuEof6@linutronix.de>
References: <20250819093737.60688-1-laoar.shao@gmail.com>
 <7d2f3767-64c5-4efa-862b-f463751a03bb@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7d2f3767-64c5-4efa-862b-f463751a03bb@iogearbox.net>

On 2025-08-19 14:42:07 [+0200], Daniel Borkmann wrote:
> > --- a/include/net/cls_cgroup.h
> > +++ b/include/net/cls_cgroup.h
> > @@ -63,7 +63,7 @@ static inline u32 task_get_classid(const struct sk_bu=
ff *skb)
> >   	 * calls by looking at the number of nested bh disable calls because
> >   	 * softirqs always disables bh.
> >   	 */
> > -	if (in_serving_softirq()) {
> > +	if (in_softirq()) {
> >   		struct sock *sk =3D skb_to_full_sk(skb);
> >   		/* If there is an sock_cgroup_classid we'll use that. */
=E2=80=A6
> Looking at in_softirq(), the comment says "the following macros are depre=
cated and
> should not be used in new code", see commit 15115830c887 ("preempt: Clean=
up the
> macro maze a bit"). Maybe Sebastian or Paul has input on whether in_softi=
rq() is
> still supposed to be used.

it listed in the deprecated section so I would tend to suggest
softirq_count(). But then in_softirq() kind of describes what is done
while the other two (in_irq, in_interrupt) were ambiguous and people
often mixed them up.
Let me poke someone and then we maybe commit to clean up so leave the
limbo state.

> Thanks,
> Daniel

Sebastian

