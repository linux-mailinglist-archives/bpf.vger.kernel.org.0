Return-Path: <bpf+bounces-33835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0EE926BAB
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 00:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A17B20EAA
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 22:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B0C1922F8;
	Wed,  3 Jul 2024 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhLcPazT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C421C68D;
	Wed,  3 Jul 2024 22:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720046371; cv=none; b=mysRdRDD8n57WNH+75Uxc4aB4KVuMDg3OSkK8fCPDR/T4UyNkdO5n3JeI4U56Ra/xeTijoSY6Ch+5Cw6eAtNaL0l71TvU3eisDR58Wod8nvnZ2pfTA9z20Na5tJW4GHaRKOvgEwngzE8ta+1Wd4UB/EctQz4S+fn+tUAkvuIAAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720046371; c=relaxed/simple;
	bh=1BgN09tJcD3ylA6qFAtoMI1gjQ6sMPuy7sgcQ2PipHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BM8aoa6iAY3pt9XubIATITf5uLAViluIB1g1Jcmj3wKnJABfbGnIYA+C98kinB4tZIga+9ESzRrYnRRyE2OFMTPPCc7rirG2pJqmt4AbLu6eScX7hkc/jS5GOsuYvi8fOdKhhbhPHfOYVrvCeElhHuw768Heykj7acjEk+wDAi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhLcPazT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929EDC2BD10;
	Wed,  3 Jul 2024 22:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720046370;
	bh=1BgN09tJcD3ylA6qFAtoMI1gjQ6sMPuy7sgcQ2PipHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LhLcPazTUERr2j0S5ALF+gdMrnL7T7oN/gi8ir6iF4J2HzmE18Um36K2HmYL/pyXk
	 oaJCdRsu7aTtyZxFpkENKFvoe7LkLivGyTrStVxz30AQIs/CRw/4CACGlEt5gYH5RC
	 iP/tZ2BU+cyEXcRFwM9JTagc09zmIDVHplE2WL7Wy6eqF3fByP9+sEKskJ/PCAnIP0
	 s1E850+MFHm3qWUILeWXNWaXNU1ONWLIKh+WSzsmdGCBN2+f/hm6uys18SNE+0fz0t
	 ir6A7wAOLwyXNomm0d0R9eycVd2sXLHWwplJZNpN/RMmqNc5fiSPTUffgbDsnI0dE/
	 /clJ6fFAATt2Q==
Date: Wed, 3 Jul 2024 15:39:27 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, x86@kernel.org,
	mingo@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, rihams@fb.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf,x86: avoid missing caller address in stack
 traces captured in uprobe
Message-ID: <20240703223927.zby4glzbngjqxemd@treble>
References: <20240703040203.3368505-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240703040203.3368505-1-andrii@kernel.org>

On Tue, Jul 02, 2024 at 09:02:03PM -0700, Andrii Nakryiko wrote:
> @@ -2833,6 +2858,18 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
>  
>  	fp = compat_ptr(ss_base + regs->bp);
>  	pagefault_disable();
> +
> +#ifdef CONFIG_UPROBES
> +	/* see perf_callchain_user() below for why we do this */
> +	if (current->utask) {
> +		u32 ret_addr;
> +
> +		if (is_uprobe_at_func_entry(regs, current->utask->auprobe) &&
> +		    !__get_user(ret_addr, (const u32 __user *)regs->sp))

Shouldn't the regs->sp value be checked with __access_ok() before
calling __get_user()?

Also, instead of littering functions with ifdefs it would be better to
abstract this out into a separate function which has an "always return
false" version for !CONFIG_UPROBES.  Then the above could be simplified to
something like:

	...
 	pagefault_disable();

	if (is_uprobe_at_func_entry(regs, current) &&
	    __access_ok(regs->sp, 4) &&
	    !__get_user(ret_addr, (const u32 __user *)regs->sp))
	    	perf_callchain_store(entry, ret_addr);
	...

Also it's good practice to wait at least several days before posting new
versions to avoid spamming reviewers and to give them time to digest
what you've already sent.

-- 
Josh

