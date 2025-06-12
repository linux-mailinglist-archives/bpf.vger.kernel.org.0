Return-Path: <bpf+bounces-60422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F11A4AD64AB
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 02:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9161F3AC97A
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 00:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A711474B8;
	Thu, 12 Jun 2025 00:40:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3393B280;
	Thu, 12 Jun 2025 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749688837; cv=none; b=OjXMrVtMRy4nLg9UJp5eK0wPs7YAtaYchLENMFrQO3FiNn811ooqn4+Lqc9YzkzK2SsL1okrC1/PC7HPdAY3Oql4ttqGZZl/3F9oeKGvSqc/qno2xhVC6A7IwxHbm7h3BVTnz5hNMNQCZV0YpYFuGqXBzQZ+solCbNBFzQ6dPWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749688837; c=relaxed/simple;
	bh=sEo29Y4UUQrtzYpx+2sKnZH/o6C4OT1r4wZBTH7Tvls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVgF5K5I7PBaUWpiXXHcuF5cmKrFbkTs5yHYWEZ5DG99rPGOjDpeSkGL3mAFMG978nvUKXJ9Mjj3Ixk0eXvC5J+tkPNsrCE3vbRgH3UHweQk2DjRhf7hVovyY+R9P1BKYiU9/d51S1F9fYLq//yzTeRM3h/kQOj5nmili5T3bJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-1b-684a21ffb9fe
Date: Thu, 12 Jun 2025 09:40:26 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, willy@infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: Re: [PATCH net-next 0/9] Split netmem from struct page
Message-ID: <20250612004026.GB41589@system.software.com>
References: <20250609043225.77229-1-byungchul@sk.com>
 <8c7c1039-5b9c-4060-8292-87047dfd9845@gmail.com>
 <CAHS8izNiFA71bbLd1fq3sFh1CuC5Zh19f53XMPYk2Dj8iOfkOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNiFA71bbLd1fq3sFh1CuC5Zh19f53XMPYk2Dj8iOfkOA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTURzGPXsve10OXqeto4XiuirYjT78qaigD50kwzC6mbiVL201V2xl
	GlhWi0iadjGouWyilZdoNW9TTGuJZhcSu7AuZlhZdJnk1DJX5qtEfvvxPH+eHwcORymKmXBO
	Z9grGA0avYqV0bJvQUWxI1Fx2vk+8zSwOa6xUPEzA66+dTFgK69B0D/0Sgq+5lYWiosGKbA9
	NtMw4PhFwYeWbil0XemhoeF4LQXdefdYsJiHKTjiKpVAe00uA/m/LlNQm/1WCk/qbSy8uTbC
	QI/bQkObtYyGrtwV0GJXwuCDrwiaHbUSGDx5kYWzHXYW3pm7EHTc7aah4HAuAkejh4HhnzZ2
	RRSpKnshIXXWTimxO/eRytIYkuPpoIiz/ARLnH1npOT18waW3Ds/TJM6l09CLEe9LPn+4SVN
	ehufscRR9YwmD+3NUuJzRiTwW2RLUwW9Ll0wzlumlmmL3IeZPTdkGWXmHiYbmbkcFMhhfhFu
	t7xichA3xu87D4kxzc/EzqffpCKz/Gzs8QxRIofy0bik8fTouYyjeC+Drw/VjxUh/HL84/U7
	VmQ5D9g31MaKRwregXB20xc0XgTjtgvvaZGp0VV/YQcliil+Kr76hxuPI/HR6oKxzUB+He7p
	amREnsxPx7drWiXiJuYbOHzfewyNPyAM3yn10KdQsHWCwjpBYf2vsE5Q2BFdjhQ6Q3qaRqdf
	NFebadBlzN2+O82JRr/OlSx/kgv1tSe6Ec8hVZDcpV2tVTCadFNmmhthjlKFypUho5E8VZN5
	QDDuTjHu0wsmN5rK0aop8oWD+1MV/A7NXmGXIOwRjP9aCRcYno3i0h7G+5O2LVCGxsTLTqy5
	/DslmcrxHpkzc5kqwq8OD03xL1+8M96CrLZa1ZcZVc7cJWELIzZX1bP9tyqpJxkVsauiTCcH
	Dm44p3Ekzki+FBD0edPdR8FZYZKS+1sTlDtmTVobXRiw9tjNcwGR6qAKdVP1x5ru9Z8MK/O+
	9pL6jfkvVLRJq1kQQxlNmr+mcmk/NgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG++9cdlwtjtcOGkmrsItZgcGbRkYQ/ZUIg27Uh1zt0EbbjM1E
	u5DmMhy5NLuumQvNvESLaW6GaGxiSkY2W9jFJlomWJq35VIyV0R++/E8D7/3y8sQQblUOKNQ
	p/EatVQpoUWkaFd8ztqZpUny9QNOBkyWBzRUT2bA/R47BaaqOgTjvvdCGGt+RkPpXS8Bppc6
	EiYsPwn43NIrBE95PwkNF20E9F5upSFfN0XAeXuFAJzFbRR01BkouPrzHgG2rB4hdD4x0fDx
	wQwF/Y58EtqMlSR4DFuhxRwG3udfETRbbALwXiqmochlpqFP50HgcvaScDvbgMDS2EXB1KSJ
	3irBtZVvBbje2C3EZutJXFOxGuu7XAS2VuXR2Dp6RYg/vGmgcevNKRLX28cEOD9niMYjn9+R
	eLjRTePSge8CbKl1k7jd3CxMDjwo2izjlYp0XrNuS4pIfteRTZ14JMqo1PVTWUjH6BHDcGws
	96n7nB4FMCS7grO+/ib0M81GcV1dPsLPIewqrqyxkNIjEUOwQxT30PfkTxHMJnA/PvTRfhaz
	wI352mj/KIi1IC6raRD9LQK5tlufSD8Ts9bpOy7Cf5hgI7j7v5i/cSSX8/j2H2cAu5vr9zRS
	fg5ll3FP654JCtBC4xyTcY7J+N9knGMyI7IKhSjU6SqpQrkxRntcnqlWZMQcTVVZ0ex3lJ+d
	LrSj8c4dDsQySLJAbJcnyoMoabo2U+VAHENIQsRhwbORWCbNPMVrUg9rTip5rQNFMKRkkThp
	P58SxB6TpvHHef4Er/nXCpiA8CwkXzP6a0/fznkbkqOqS3rcNwabhl5NIm0CljQcYIOzhfHq
	a4ZmR9Glkt17j6zT13hVm2TOF4dSWhSx7La49unumS86kypv/sSFRdcLwojnr4fbQ0siNbeS
	c23u4AVn9kW/kGviFqau3FK/eKdsInp57PYlZa3GuIq0stP5Ix0fqxMlpFYu3bCa0GilvwFy
	0WHmGQMAAA==
X-CFilter-Loop: Reflected

On Wed, Jun 11, 2025 at 01:48:36PM -0700, Mina Almasry wrote:
> On Wed, Jun 11, 2025 at 7:24 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
> >
> > On 6/9/25 05:32, Byungchul Park wrote:
> > > Hi all,
> > >
> > > In this version, I'm posting non-controversial patches first.  I will
> > > post the rest more carefully later.  In this version, no update has been
> > > applied except excluding some patches from the previous version.  See
> > > the changes below.
> >
> > fwiw, I tried it with net_iov (zcrx), it didn't blow up during a
> > short test.
> >
> 
> FWIW, I ran my devmem TCP tests, and pp benchmark regression tests.
> Both look good to me. For the pp benchmark:

Thanks for the test.

	Byungchul
> 
> Before:
> 
> Fast path results:
> no-softirq-page_pool01 Per elem: 11 cycles(tsc) 4.337 ns
> 
> ptr_ring results:
> no-softirq-page_pool02 Per elem: 529 cycles(tsc) 196.073 ns
> 
> slow path results:
> no-softirq-page_pool03 Per elem: 554 cycles(tsc) 205.195 ns
> 
> After:
> 
> Fast path results:
> no-softirq-page_pool01 Per elem: 11 cycles(tsc) 4.401 ns
> 
> ptr_ring results:
> no-softirq-page_pool02 Per elem: 530 cycles(tsc) 196.443 ns
> 
> slow path results:
> no-softirq-page_pool03 Per elem: 551 cycles(tsc) 204.287 ns
> 
> 
> 
> -- 
> Thanks,
> Mina

