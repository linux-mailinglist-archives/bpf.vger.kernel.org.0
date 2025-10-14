Return-Path: <bpf+bounces-70941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7417BDBB6E
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 00:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE893E2B73
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 22:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6011245005;
	Tue, 14 Oct 2025 22:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LDY5mFre"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217DC1547D2
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 22:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760482640; cv=none; b=phYilCZcKJhGTeEWO6Ix/oo3DiXxjqLCxlqpWY92Ie3NGOGUPy/IrISQS55ZPYxy62tW9EhktU9qRck5pToIdj13aOcrRviiFxiMYcMD+p3JCVwDI44lfXVckalv/EMsfIggdPtmz3MjpzzFDKGLIbR1ZQHcR+IVEWHF9+KNB9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760482640; c=relaxed/simple;
	bh=dAqZjjshee4jOh4sIWXnJyV3egKGrh0G3eAUaqM5kkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbHgFjzTCmSpBrwjIZvcrhejdYKitEnlCZR92s4eZrr3wEHj4OeShJ43blfRWVRiEegGXkysJ4nCLftOjDlPVtGdNuqUgccmRC3T8BZ3YVn7IaH6xGkamrCLENjEMKgVHbkEhKKx4HO2cg6nIN7aN3Z2oI/WPy9qg5PGnOM7oFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LDY5mFre; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 14 Oct 2025 15:57:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760482636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dRhy5pXAiQl4JPAdYHEJpTxKiPwF/nTrHCkBnWAbo/A=;
	b=LDY5mFre+DitGOhyqu1GnrOHBiIq9UCsNNZUR8Y8e4ORBcMGksT5qu3WyakL62mrgaMKqk
	b3TaGb3B5E3oqIzMyHPha306UJdZSRl5r0VWL7/4p4A6cmwVMvfU+cPu+tEAGPhlItHHtJ
	Xfkijkcc+/6IOOVSchy7JRB8G1A5Zys=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, vbabka@suse.cz, yepeilin@google.com, harry.yoo@oracle.com, 
	linux-mm@kvack.org
Subject: Re: [PATCH bpf] bpf: Replace bpf_map_kmalloc_node() with
 kmalloc_nolock() to allocate bpf_async_cb structures.
Message-ID: <ts7ewzhspasn2n3gfpscqpvhhzeod7cv6nml4g457ytzgojbek@gd5vts6hpdjf>
References: <20251014212541.67930-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014212541.67930-1-alexei.starovoitov@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 14, 2025 at 02:25:41PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The following kmemleak splat:
> [    8.105530] kmemleak: Trying to color unknown object at 0xff11000100e918c0 as Black
> [    8.106521] Call Trace:
> [    8.106521]  <TASK>
> [    8.106521]  dump_stack_lvl+0x4b/0x70
> [    8.106521]  kvfree_call_rcu+0xcb/0x3b0
> [    8.106521]  ? hrtimer_cancel+0x21/0x40
> [    8.106521]  bpf_obj_free_fields+0x193/0x200
> [    8.106521]  htab_map_update_elem+0x29c/0x410
> [    8.106521]  bpf_prog_cfc8cd0f42c04044_overwrite_cb+0x47/0x4b
> [    8.106521]  bpf_prog_8c30cd7c4db2e963_overwrite_timer+0x65/0x86
> [    8.106521]  bpf_prog_test_run_syscall+0xe1/0x2a0
> 
> happens due to the combination of features and fixes, but mainly due to
> commit 6d78b4473cdb ("bpf: Tell memcg to use allow_spinning=false path in bpf_timer_init()")
> It's using __GFP_HIGH, which instructs slub/kmemleak internals to skip
> kmemleak_alloc_recursive() on allocation, so subsequent kfree_rcu()->
> kvfree_call_rcu()->kmemleak_ignore() complains with the above splat.
> 
> To fix this imbalance, replace bpf_map_kmalloc_node() with
> kmalloc_nolock() and kfree_rcu() with call_rcu() + kfree_nolock() to
> make sure that the objects allocated with kmalloc_nolock() are freed
> with kfree_nolock() rather than the implicit kfree() that kfree_rcu()
> uses internally.
> 
> Note, the kmalloc_nolock() happens under bpf_spin_lock_irqsave(), so
> it will always fail in PREEMPT_RT. This is not an issue at the moment,
> since bpf_timers are disabled in PREEMPT_RT. In the future
> bpf_spin_lock will be replaced with state machine similar to
> bpf_task_work.
> 
> Fixes: 6d78b4473cdb ("bpf: Tell memcg to use allow_spinning=false path in bpf_timer_init()")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

