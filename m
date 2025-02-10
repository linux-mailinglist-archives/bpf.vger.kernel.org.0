Return-Path: <bpf+bounces-50944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AE6A2E847
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 10:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD04164AC6
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 09:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE651C6FE3;
	Mon, 10 Feb 2025 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CLZ+s75h"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B380C1C3C0F;
	Mon, 10 Feb 2025 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181214; cv=none; b=Wwpph1lPc9OEuElqZdu9fk8s1wvdjA7jQUp6n8tF0ahx/iTszOcPvdFbc/lZo4nEqVJHzJGxR93uO4KmQJ0sLo+yFIKUIFjzhug3UcdH+EqUa+F9KBGFEACGA66RfmCE5FyjL68xOUJ0nDl5fL9sZj8CcVyqCOKfJhpJSzFm5CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181214; c=relaxed/simple;
	bh=bOvDRrgXH6phjEcMFiDdEDrs3Vrvfib1N+WLCTV+ORk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDY8bdfCeUtDvaJcuUjina+ZA/9wmTg1co3kBKc/YfIHDYvfnwj3ZbXtQ4C1EDToyn9F/5olyDyuKp6cGErOUwc8K7zoo6eJJsNNZ4Bb+kxO6CAtQnbRJkKt5SbQPCKP/0wFQrb0KpTBNj0vbHferEqmmpgK9ZxJB1fNCNjJ+i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CLZ+s75h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s8Mwq3rMEa8CkQmRNyS/s+cyYunNKj5Wlg7L/VvKRhc=; b=CLZ+s75h+0rfLi/5P96AEUisat
	9NPxjkymmufjZFkx2Qg00zQQknhLs2i3RWzR0OV3cfSvk8UZ2iNO7RyvW3jRZv2JIIOz4lXzn3QVh
	ZNrDBOu/UUC9HIStKK5n1QPCExb86xogvlwW1BxGRgYd29njnz1IoJ6qvC6jwIcptojfr7zGkCuiX
	L5EYdA5eo6pvF+yymPngVl7yx2b7U2eKoTgvku7tnnRqvaO1ddnhBLxFDG7iT8bKgmu5hZO4FTkYz
	223I67HaSLf8Qkq/NyJ+v5J74UdJE6Gb/S9K+gjdzNIWqBvmOs5h9xJyBCIgXvDIbYxNhafSsSAuU
	UgJjc69g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1thQTl-0000000FThV-2RSc;
	Mon, 10 Feb 2025 09:53:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2DFFA300318; Mon, 10 Feb 2025 10:53:25 +0100 (CET)
Date: Mon, 10 Feb 2025 10:53:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 17/26] rqspinlock: Hardcode cond_acquire
 loops to asm-generic implementation
Message-ID: <20250210095324.GG10324@noisy.programming.kicks-ass.net>
References: <20250206105435.2159977-1-memxor@gmail.com>
 <20250206105435.2159977-18-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206105435.2159977-18-memxor@gmail.com>

On Thu, Feb 06, 2025 at 02:54:25AM -0800, Kumar Kartikeya Dwivedi wrote:
> Currently, for rqspinlock usage, the implementation of
> smp_cond_load_acquire (and thus, atomic_cond_read_acquire) are
> susceptible to stalls on arm64, because they do not guarantee that the
> conditional expression will be repeatedly invoked if the address being
> loaded from is not written to by other CPUs. When support for
> event-streams is absent (which unblocks stuck WFE-based loops every
> ~100us), we may end up being stuck forever.
> 
> This causes a problem for us, as we need to repeatedly invoke the
> RES_CHECK_TIMEOUT in the spin loop to break out when the timeout
> expires.
> 
> Hardcode the implementation to the asm-generic version in rqspinlock.c
> until support for smp_cond_load_acquire_timewait [0] lands upstream.
> 

*sigh*.. this patch should go *before* patch 8. As is that's still
horribly broken and I was WTF-ing because your 0/n changelog said you
fixed it.

