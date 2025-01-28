Return-Path: <bpf+bounces-49976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9DCA210A9
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 19:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8709118835A9
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 18:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396B71DE4E7;
	Tue, 28 Jan 2025 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ueYbhafi"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAC81DE4DB
	for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738088340; cv=none; b=Ti6LnQbAnTdVyZUW6QmIsbyYpdXZsDBP4UpWzSs8x5X3n5YSTAfiPp73+rKv/ASMJ9lMqWnAsI+87xdHCFjdMoxwDhzM7WCi7G9RHWLaJSHaz0b5XZXA8sCvbl7kS8VUbrgjN2XXwhsVNSB6Seys8CT2HT+e9d1R90hgBEemiv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738088340; c=relaxed/simple;
	bh=7EYkcxl5Gp68EWIEgZGMcs+NEBvsryb0QBApbrytCvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdhsBxlinjSv7rbOPyJvHvUPgTq3UeYKZSjgx6oinSgografiSNTx2/+YW4RUqWu0QXm+CrU9JIDV1SL7+DCFYZSA3MGSmNUrqugWjbIxwDTvI5+nK1uNoQdiVEPuNg7Z+p50HaZFXTXbxW99nByphJ0yz3JeGsazpV4j3mnzL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ueYbhafi; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 28 Jan 2025 10:18:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738088336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IwyhlDOlF0RVPBXuw0iwcRsivnX/SUhgtB5IsaWgmuE=;
	b=ueYbhafiRlXeScY+CKXGi0xTWMN2py9r4Higq5fd8o3w4BpK1mUwDjogDDnrcF8YFZ1cSs
	bP2Gim5GTIeN1S+ZCExWHGNOI41hUCw/gGcf996UtFjUjQeF+8WvkwgG1q6RCPs2XpsuN7
	cInRIezlyElhB4358A8ArSifZda0SfY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com, 
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz, bigeasy@linutronix.de, 
	rostedt@goodmis.org, houtao1@huawei.com, hannes@cmpxchg.org, mhocko@suse.com, 
	willy@infradead.org, tglx@linutronix.de, jannh@google.com, tj@kernel.org, 
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v6 2/6] mm, bpf: Introduce free_pages_nolock()
Message-ID: <lw3jfvdnjdlyo5rzxacw2q2hd2efgso2bao55sypuxu43doeze@wdebedjxo2r7>
References: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
 <20250124035655.78899-3-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124035655.78899-3-alexei.starovoitov@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 23, 2025 at 07:56:51PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Introduce free_pages_nolock() that can free pages without taking locks.
> It relies on trylock and can be called from any context.
> Since spin_trylock() cannot be used in PREEMPT_RT from hard IRQ or NMI
> it uses lockless link list to stash the pages which will be freed
> by subsequent free_pages() from good context.
> 
> Do not use llist unconditionally. BPF maps continuously
> allocate/free, so we cannot unconditionally delay the freeing to
> llist. When the memory becomes free make it available to the
> kernel and BPF users right away if possible, and fallback to
> llist as the last resort.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

