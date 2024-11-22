Return-Path: <bpf+bounces-45456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F639D5DC4
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 12:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E06B25C01
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 11:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0AF1DE2B2;
	Fri, 22 Nov 2024 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FxGSQpdO"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D9714A84;
	Fri, 22 Nov 2024 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273668; cv=none; b=iP2oW5XKpNle6h5Y3Ti6iwxM4YFyZVCQYpm0eYHexBp2rTouyRPXjZosZieKtxiKddctvsGskJJiPyWcRLFQRREHkz4zuD23q0CyXdztatMd66wVnBM8/gmRY+i1mQVtK6Gksv5YDYjNOftim6mwjTYenCX8qqCjsS3/0kCA6N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273668; c=relaxed/simple;
	bh=CI1lIANsrzEeHGjqXoJmc6I7iBCghDKQ8XngPTMVJ7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyOG0ngmfBMCQcbbAMVUMHKgfLSpMtR7tclhIKIBtwKRe4uJsAVyCbTLcwAjv/6YAeerERnXsZf4DIAKJAtcCAkrTbA7GpiPz7QOiuyYXZY1hgOSe1Ge2wYUI7c1uu9cLGmefLYKfLe53yf0+ZieSzcuPDDpKvRLC8lK0eD8/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FxGSQpdO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jji/7XRHcaGMBULxQ6QXItOGJLcPdj5UvUmIxK4X7tw=; b=FxGSQpdO9Gg4KSR0Myh6q/JWhz
	tD8ewDhyuKBh+Fzfgyv+hQN1PTeNExqJkHHXIjVWoNtIm8+JNXPiDVIYufft6wqhvozBi2pYB7GPx
	fpYtIieaVy9PBujdu+sowJEA3eVs4zAX0mWIy5HfQli6E4JUWDTI+mqjerbQOUiIBTyQ0DVg/zhXS
	cBa9FoZJdjCn5RJCZSoYNGvUeC9Ux3N5ywK23efFob/IPmtj2JzDqSoFHqMox0rnPadU1EMh6CJRi
	xav8wsvMt7Tju/KBN8NRlvTImYnLrFIGz6Ez+yhDxkp5+6MWGYy3GTSk5eB2NmecNRtpVUM4rEYD6
	C3mNiXOw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tERVh-00000000hHe-2Eox;
	Fri, 22 Nov 2024 11:07:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3086D30066A; Fri, 22 Nov 2024 12:07:37 +0100 (CET)
Date: Fri, 22 Nov 2024 12:07:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, mingo@kernel.org,
	torvalds@linux-foundation.org, oleg@redhat.com, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, mjguzik@gmail.com,
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org,
	vbabka@suse.cz, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	david@redhat.com, arnd@arndb.de, viro@zeniv.linux.org.uk,
	hca@linux.ibm.com
Subject: Re: [PATCH v5 tip/perf/core 0/2] uprobes: speculative lockless
 VMA-to-uprobe lookup
Message-ID: <20241122110737.GP24774@noisy.programming.kicks-ass.net>
References: <20241122035922.3321100-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122035922.3321100-1-andrii@kernel.org>

On Thu, Nov 21, 2024 at 07:59:20PM -0800, Andrii Nakryiko wrote:

> Andrii Nakryiko (2):
>   uprobes: simplify find_active_uprobe_rcu() VMA checks
>   uprobes: add speculative lockless VMA-to-inode-to-uprobe resolution

Thanks, assuming Suren is okay with me carrying his patches through tip,
I'll make this land in tip/perf/core after -rc1.

