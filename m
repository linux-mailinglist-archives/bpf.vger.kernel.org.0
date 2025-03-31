Return-Path: <bpf+bounces-54932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDB3A760FF
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 10:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61D33A3EAE
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 08:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6276A1D54E2;
	Mon, 31 Mar 2025 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4fK++R/3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yP8dsOUQ"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE63FBF6;
	Mon, 31 Mar 2025 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408709; cv=none; b=YXPkelO0CasmCe9VejghUyt51b0MA+nBMukpCYPe2g7PDumxtNSZj0dF2MUnVNzDPYGirJy89H81a9FdoDaxppE/g7sBcFqRmpnTrsh9IzNl5kNIE2/8qeq4FNs+IgrI0LxlDx2l0tTv9T3ywgMVcfQ0UY+HkvHrs6wcLwXV7us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408709; c=relaxed/simple;
	bh=uQhYal9UwEqjXNAo1smgmNLLoGPn4qMCTT/QmCnFELg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMknmygRppNdG2Jyz3RDSpGMy7vrR9hhna9soPzwUg+7/Td4gSYf1l0uK5tztMI9uIK7kLq069HrLp+uWqtVkHRjjxP2yhDmnmq83R6HMR5UCN220ZekMUcK8+phWcdAanwjrraTBYAK3gISkOxnZX2TbtOiLIZEH0PhBfCGq8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4fK++R/3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yP8dsOUQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 31 Mar 2025 10:11:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743408704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RrTBk4l8xgKnE0zLzA8TtC6W0ocP3bb6+3R/hmfaxoM=;
	b=4fK++R/3BR88LnWzrXmxsmE6tRPOFK4URrpxLet7uTeZxcRBA8zrzWWWfNPgVk+fbnWETh
	zQ281DRJecqNlHNTFMRJQtBU2Xw+a+IM5mcTCsrUiz1nw7gAqfENyiml6EvBGohafCmiOb
	11CpIy1cpF6sJxd3lIxrmgB6w/4LowtLk9EvPRNa4EH8XCv41V/aMT80Pn6DjnD2kaVrn3
	qE/0bEogJpTYMbivPgE3og7DXOvg0SiGc9jLe0iZC4YpkjbKwKeotg5lWk6JmIvbjxt33y
	U+G6Q0hZmc2liG6jm+rmxozaAofzybBYVR4Uknxw8BYXsaZZ3KmPkDrzaVXEBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743408704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RrTBk4l8xgKnE0zLzA8TtC6W0ocP3bb6+3R/hmfaxoM=;
	b=yP8dsOUQucE4FGkVS5oIQDiSZ4KbEWzFXD0givLvid9ZDyd/7Xk2+0IdW6tA3BuegnfJ3q
	YkJzBx44aAkD+dAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
	rostedt@goodmis.org, shakeel.butt@linux.dev, mhocko@suse.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm] mm/page_alloc: Avoid second trylock of zone->lock
Message-ID: <20250331081143.cPXjY7PZ@linutronix.de>
References: <20250331002809.94758-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250331002809.94758-1-alexei.starovoitov@gmail.com>

On 2025-03-30 17:28:09 [-0700], Alexei Starovoitov wrote:
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

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

