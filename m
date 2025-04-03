Return-Path: <bpf+bounces-55201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F55A79A58
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 05:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EECD171D61
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 03:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C68419258E;
	Thu,  3 Apr 2025 03:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YJE0OOvF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACF918DF81;
	Thu,  3 Apr 2025 03:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743649973; cv=none; b=CABTySuGm6DDCHLm+gakgkJ+8M1ALW1687ocu2soF1yOEYrI5fiZLlSkXE6f/j45GAiqTdiukVdKvaCsisuCLQHfX0IaFtNZWSODN0T4ogu4J69S5laEJlcuRXw1czBpZNY8nABvCurkKFWJvBUjq3Vi7FdJVEup7I/wzW/LA+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743649973; c=relaxed/simple;
	bh=1xDAv7xNFkDp0p5nPVZCofADwxBSlY8y96TWnOtMZmw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iM8N7qq4vT0SVzG5N4yX3hS+ua+Tcg/zbFmhkvad1lyMGZPtuwzIdvZ9x4C33uCu0sPEqj190JUzuS1NkVJBAeMrTo5AX0HnyUAjR25y9F+ckMXZlxrdc4pfZmMbwYSHdoOxd4lW5d7Rd0fpbMnnPvyZhtRvb16UcKxyyrmxI+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YJE0OOvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2A9C4CEE7;
	Thu,  3 Apr 2025 03:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1743649973;
	bh=1xDAv7xNFkDp0p5nPVZCofADwxBSlY8y96TWnOtMZmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YJE0OOvFUUtYU9PfndqJ7H4TJj7zfhe/IQzBoknRXzTeAO/UVpk9G9qej60jXRtdj
	 KSjXVGGSTYwnY13G81URc8I54W4146W86tqSrwCDEjQGU3W008TeqVZB5MPMjPNpaO
	 d6EIkaDkZPy9WBdsQl4lFQq+bmbEhOhl/1X+SaFI=
Date: Wed, 2 Apr 2025 20:12:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 peterz@infradead.org, vbabka@suse.cz, bigeasy@linutronix.de,
 rostedt@goodmis.org, shakeel.butt@linux.dev, mhocko@suse.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] locking/local_lock, mm: Replace localtry_ helpers
 with local_trylock_t type
Message-Id: <20250402201252.8926c547a327ce91c61fd620@linux-foundation.org>
In-Reply-To: <20250403025514.41186-1-alexei.starovoitov@gmail.com>
References: <20250403025514.41186-1-alexei.starovoitov@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Apr 2025 19:55:14 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> Partially revert commit 0aaddfb06882 ("locking/local_lock: Introduce localtry_lock_t").
> Remove localtry_*() helpers, since localtry_lock() name might
> be misinterpreted as "try lock".
> 

So many macros grumble.

+#define local_trylock_init(lock)	__local_trylock_init(lock)
+#define local_trylock(lock)		__local_trylock(lock)
+#define local_trylock_irqsave(lock, flags)			\
+#define __local_trylock_init(lock) __local_lock_init(lock.llock)
+#define __local_lock_acquire(lock)					\
+#define __local_trylock(lock)					\
+#define __local_trylock_irqsave(lock, flags)			\
+#define __local_lock_release(lock)					\
+#define __local_unlock(lock)					\
+#define __local_unlock_irq(lock)				\
+#define __local_unlock_irqrestore(lock, flags)			\
+#define __local_lock_nested_bh(lock)				\
+#define __local_unlock_nested_bh(lock)				\
+#define __local_trylock_init(l)			__local_lock_init(l)
+#define __local_trylock(lock)					\
+#define __local_trylock_irqsave(lock, flags)			\

I expect many of these could have been implemented as static inlines.

Oh well, that's a separate project for someone sometime.

