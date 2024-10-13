Return-Path: <bpf+bounces-41824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7700799B8C5
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 09:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3727C2824A2
	for <lists+bpf@lfdr.de>; Sun, 13 Oct 2024 07:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0167213AA2E;
	Sun, 13 Oct 2024 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OhvQ4iYg"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C402139D0B
	for <bpf@vger.kernel.org>; Sun, 13 Oct 2024 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728806214; cv=none; b=je8f868ltguYt0RDuPeQDjdJh7I/2EGgf/e+zSaSW+EhlFmjWNnL9eDJeyj9fjfG34LTLBBGmEA9PSSe/76dej5XPRXPex5Dku9XyhMfCi5MAE6DAnG0U+AlH3NzNgbjgj2vo5EckS3jNvWJdbKTQZx5HxYVPQQ5OhFCvrFwHcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728806214; c=relaxed/simple;
	bh=D48w3EHfC4XQxOzpIIrw10rJRqxgNy/vry9jE7GFnEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBaIlNHvGCCe4iT5ynsqJTknesoGkUfcboMlbiHgeiG+i78BytEB2T2ByXPeZLVYc1H1YfnzsQGVlJW9bMCWtV8yIvLIPiNRpCQpBJts6jCjNl/ZD4HeHXu1tV4SZzQs5MLxaUNIOFvxAUUWfhnz2e+PcVuPaDVO0/28Ldp0/dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OhvQ4iYg; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 13 Oct 2024 00:56:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728806210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IS5ld+TSbl+kNeWYScFUSy7z01NMJzyZaBDFgbTS7x8=;
	b=OhvQ4iYgQjx1Ivs6+rhB5cpNBwGPd/E5l5cDdaNPjVzTE/2cfC+hf2xYcTR/DKozTU4ojp
	Qlm26be7xHp0rZ+QnStIMg3L+9bCvlr04ioz18Z3+NkoWCTNc702C5gPCjnTBW+3Q8VuOc
	oOKozOG5j3pb4yABfFfmnMxsT2Vgw8w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, 
	mhocko@kernel.org, vbabka@suse.cz, hannes@cmpxchg.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com
Subject: Re: [PATCH v3 tip/perf/core 2/4] mm: switch to 64-bit
 mm_lock_seq/vm_lock_seq on 64-bit architectures
Message-ID: <55hskn2iz5ixsl6wvupnhx7hkzcvx2u4muswvzi4wuqplmu2uo@rj72ypyeksjy>
References: <20241010205644.3831427-1-andrii@kernel.org>
 <20241010205644.3831427-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010205644.3831427-3-andrii@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 10, 2024 at 01:56:42PM GMT, Andrii Nakryiko wrote:
> To increase mm->mm_lock_seq robustness, switch it from int to long, so
> that it's a 64-bit counter on 64-bit systems and we can stop worrying
> about it wrapping around in just ~4 billion iterations. Same goes for
> VMA's matching vm_lock_seq, which is derived from mm_lock_seq.
> 
> I didn't use __u64 outright to keep 32-bit architectures unaffected, but
> if it seems important enough, I have nothing against using __u64.
> 
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

