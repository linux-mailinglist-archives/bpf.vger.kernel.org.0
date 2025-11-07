Return-Path: <bpf+bounces-73927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D2FC3E2F3
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 02:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3212A4E536C
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 01:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F80F2FC034;
	Fri,  7 Nov 2025 01:59:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8D233993;
	Fri,  7 Nov 2025 01:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480763; cv=none; b=js5SdOC4AiJJ/U1KLJS4EE88TTriKPktADLg2XZdS1o52LzKQcZnYsU+JbpACKIF8uPpNLGozTRuMKjG8eCmVhKBy9i6/qIUfrs9L5t1iwDDOTSgPvborLcw6FVK+xO9c0RUImOiWRPXw1sChZE+y4knlXnBVLEjcFuCtkSUO1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480763; c=relaxed/simple;
	bh=7DAjkr9cSxRS0fZbyexesbeKd4d8lXU4RfB66rg63DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVhEPUdk1/VkP86IzN3nZN8rSyIaxeVS8L91qEZtsKMekNTi3nSH4cQXRd8fiLKpIs7BWvq/aPFhSkJTvIR0eJVvBs6D+AxxY3ii0GTBxXAl2TXAF6XxPTn9JCJryj16irXKOftCfdYdiuYdH7hA3KB+IIBEtGHddSSncip8N3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-41-690d526b4ee5
Date: Fri, 7 Nov 2025 10:59:02 +0900
From: Byungchul Park <byungchul@sk.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org,
	tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch,
	edumazet@google.com, pabeni@redhat.com, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
	sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com,
	dtatulea@nvidia.com
Subject: Re: [RFC mm v5 1/2] page_pool: check nmdesc->pp to see its usage as
 page pool for net_iov not page-backed
Message-ID: <20251107015902.GA3021@system.software.com>
References: <20251103075108.26437-1-byungchul@sk.com>
 <20251103075108.26437-2-byungchul@sk.com>
 <20251106173320.2f8e683a@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106173320.2f8e683a@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHefZeHY5eV+ZT9mkFkZXaKjpBFwmKByKQpA9dqEZ70eFctZlp
	EGw1yCLNlZLOBbPwbhmzdFqW6dQsupnF201tVlIts1XiUrI5k/r2439+/M/5cHhKeZ+Zy+sM
	6aLRoNGrWDkt/xJesjR1q0IX3z6wBBy1NSxUj2ZCeb+bgUDNoAwcVfUIfgRecTDR3IHgu6eT
	hc9tfgSXSkYocDyy0vCz9hcFjU2DCD4VXmbhfYeXg2rXFugr+0DDzRMNFHjP3GUhxzpGQXNg
	iINj7opgcZ2Zg8f1uQzk/yqloMHcz8HTJgcLvTUTDHxozaGhy15Jw3CBh4K+3ATocM6Gkfs+
	BJ7aBhmMnL7AwrOiJhlcb37GwbluJwsD1j4E3W1eGgrGs1kotuQiGBsNVg7l/WCguL2XS4gl
	FkliSZvvK0WuVb6QkeeFNppIt+7JSKP9DUecrkOkriKGnJK6KeKqOskSl/8sR14/v8mSu4Vj
	NGl8u5o0ur/LSM7xITYxcod8jVbU6zJEY9y6vfKUHlsBe8DGZeaP25AZ3WNOoTAeCyuwK2dC
	Ns21Te30JNPCAux5UB5yWGEhlqQANcmzgrm1rijoyHlKGOZwodQbkmYK6Xj4qzkkKYRV2Ho+
	LyQphWyEzdceMlODCNxV9C60gRJisPT7Y3AzH+RoXP6bn4zDhGX4ZbGDneRIYT5uqe/8e5yP
	x/mWGVM8B9+pkOg8JNj/a7X/12r/1+pEVBVS6gwZaRqdfkVsSpZBlxm7b3+aCwVfrOzo+E43
	8j9OakUCj1ThitFb4Tolo8kwZaW1IsxTqlmKlYZgpNBqso6Ixv17jIf0oqkVRfO0KkqhHjms
	VQrJmnQxVRQPiMbpqYwPm2tGmgfmnuNnH+0+mKdUETG6M/lKbkJWqbp90TxjprZgV+CqN25V
	Mlg4v9q9zdG1vqpF/T4+sNvmWxvYbsIZzVe615c7xMhPzprEj6hoMEq/9kZSqSsqgvHoTu7t
	SWiJ3vBtw4zhMt/yJ/HC6ZLs253ezUcXL9940Q91WvVLQJtUtClFsyyGMpo0fwAGlwewXgMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe8/lPcfh4qRWh4KIGUiCWVD0RFFSVC/dCUGoD7Xy1MZ05bZE
	g2DmoJI0V4pzrrKrl6zBNJ2SEc57mKVmxywty6Iys1ymadpcRH378/tfni8PTwfdYefxWr1J
	MujVcSqsYBQ7VqdG6HYrtUsbh4PB4SzBcGs0CQpeuVkYK3lPgaO4HIF3rJuDqep6BMO1DRg+
	eb4huHZlhAZHq4WB786fNFRWvUfw0XYbQ399Hwe3XNuh9+Y7Bu6dqqCh71wjhnTLOA3VY4Mc
	nHQX+oZLzRx4Ljax8Lg8g4WsnzdoqDC/4qC9yoGhp2SKhXc16Qw02YsYGMqupaE3Iwrq8+fA
	yMMBBLXOCgpGzl7E8DS3ioK71U85uNCWj+GNpRdBm6ePgeyJ0xjyUjIQjI/6JgczvSzk1fVw
	UZEkRZYx8Qx8oUlZURdFOm1Whsj3mylSaX/JkXzXMVJaGE7S5DaauIrPYOL6dp4jLzrvYdJo
	G2dI5etVpNI9TJH01EG8a84exZpYKU6bKBki1+5XaDqs2fiolUvKmrAiM2pm01AALwrLRWdV
	HTOtGWGRWNtS4OdYCBNleYye1iE+binN9WUUPC0McaJN7vGHggWTOPTF7A8phZWiJSfTHwoS
	TiPRXPaI/WPMEpty3/ov0EK4KE9+oNIQ79PzxYJJfhoHCMvE53kOPK1nC6Hig/IGKhMp7f+1
	7f+17f/a+YguRiFafWK8Whu3YolRp0nWa5OWHDwS70K+L7p5YsLqRt72zTVI4JEqUDl6P1Ab
	xKoTjcnxNUjkaVWIcoXeh5Sx6uTjkuHIPsOxOMlYg+bzjGquckuMtD9IOKw2STpJOioZ/roU
	HzDPjCIWShFXTZrV/S11V36sD5W6Cp1FXMZXnRT941JMk+34rkMm3PU46xfbfHiGl3q9lcR0
	5CRulDXrLjNbyg3DmxIGPd0fo9PDnsxMeNbxxjip++wZMMd+bd0bvKAl8nNdf1H71uvRoTsD
	E8qiFk+JYQeuP8nZcMZeuC0l1W2n12CvijFq1MvCaYNR/RuahmFKQQMAAA==
X-CFilter-Loop: Reflected

On Thu, Nov 06, 2025 at 05:33:20PM -0800, Jakub Kicinski wrote:
> On Mon,  3 Nov 2025 16:51:07 +0900 Byungchul Park wrote:
> > However, for net_iov not
			  ^
		*not* page-backed

> > page-backed, the identification cannot be based on the page_type.
> > Instead, nmdesc->pp can be used to see if it belongs to a page pool, by
> > making sure nmdesc->pp is NULL otherwise.
> 
> Please explain why. Isn't the type just a value in a field?
> Which net_iov could also set accordingly.. ?

page_type field is in 'struct page', so 'struct page' can check the type.

However, the field is not in 'struct net_iov', so 'struct net_iov' that
is not backed by page, cannot use the type checking to see if it's page
pool'ed instance.

I'm afraid I didn't get your questions.  I will try to explain again
properly if you give me more detail and example about your questions or
requirement.

	Byungchul

