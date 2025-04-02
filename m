Return-Path: <bpf+bounces-55122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312CEA78742
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 06:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD3F3AACE6
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 04:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAB023026D;
	Wed,  2 Apr 2025 04:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CUbBeCGr"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEB98632B;
	Wed,  2 Apr 2025 04:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743568157; cv=none; b=X5lithbaXX81y78mMK3QuG3RYRbVI49c+QSSGCwcj2bWXm9MdfLe6tvPy/J7/50p125l2BRsotAN33MX6YK2pUio80D9pjx3WnKSAJWepCQLtmtrdlZSqbZYZcahzoFKYlf4rRaHNf+hrRfRhtAgT3R3s6bzCEwrx1b+dnZLGWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743568157; c=relaxed/simple;
	bh=TsjZ5qHec+BLwK3MjMgqZa/Y6ZeFgQeWxIvPrxBJ2AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWeNSOIZvJsHYMLHrnwWwuaRn+XxkqMQQpn7h+iWSFX30d0HUtThKZWjGBsFlQ+pGwrpKuCf0I6XT0L/xOVzSD8nINUWa4W23oIx9bUnO3IYP0U2uxKy+GVhodY1W0p393gWK9pOFV6Epb8jbs5skAPwSxrl1P2a3u1UnX4akZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CUbBeCGr; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 1 Apr 2025 21:29:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743568152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5NR6EYwPfMVgROEL2dm2qwR6XWAXVQz6akFvE7Z2xsQ=;
	b=CUbBeCGrruCoHQ6IlqtWfosAvZqvkFo19JVTp1duPxjt22wc7Ry5Wjtzw+OT/AUu1jC4Jx
	HEhHxMx4b33kLiKgEdamAdAna+os8TUq+AhYOLi25Ban6lb7+cjd6CCbMlPd1KTy9hu4Ez
	eMz/DqvFtSpu7tGZpp3LzTSzbAo/IRc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz, bigeasy@linutronix.de, 
	rostedt@goodmis.org, mhocko@suse.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm] mm/page_alloc: Avoid second trylock of zone->lock
Message-ID: <a6z7nozoprpbnf34z2rnah375sgakethpip6rpxtkd6xknqxm3@kxir5he5rbra>
References: <20250331002809.94758-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331002809.94758-1-alexei.starovoitov@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Mar 30, 2025 at 05:28:09PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> spin_trylock followed by spin_lock will cause extra write cache
> access. If the lock is contended it may cause unnecessary cache
> line bouncing and will execute redundant irq restore/save pair.
> Therefore, check alloc/fpi_flags first and use spin_trylock or
> spin_lock.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Fixes: 97769a53f117 ("mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

