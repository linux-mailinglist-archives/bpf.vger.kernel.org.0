Return-Path: <bpf+bounces-55203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 813F7A79AB9
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 06:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622A3188F0E1
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 04:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B714196C7B;
	Thu,  3 Apr 2025 04:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ImOU2w14"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ABD2CA6;
	Thu,  3 Apr 2025 04:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743653171; cv=none; b=ajoEWV6PBE/2f9cOsranyebJ18G+k+FHp6vuNs7oZ+LlRbnDCt3pKlfykkXqqaYPmyic/zJIAbMi6pQ7N+GV/hKbgl/nnGdHdX7o+oINOcJ+r4Z24+87mOUE4vkPhtY//tdoQA4hrBasRJPx6truyMC2JO7eHC2x3rWuRgppB3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743653171; c=relaxed/simple;
	bh=tx7Q6sxWKaEyBEvbYMAJX5reWYJ30urOhzxsfXs360k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cB/kdI5Iz2x4kotENyWW5Bl9A6gg1cg/X9538uyAuVE+cU6wR0A39gkIi+QrLlF/nmjRXCw845JCyUacC/HfY8MRyz2ub1m7L7BryzG+qdHCFFPuqA5rpgtVonT2gdvSD2Qw3+W9wk9pb/2MLxPHrMu44BWsfjt+Y0qrJiccaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ImOU2w14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65755C4CEE3;
	Thu,  3 Apr 2025 04:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1743653170;
	bh=tx7Q6sxWKaEyBEvbYMAJX5reWYJ30urOhzxsfXs360k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ImOU2w14Q+gG5DxCwCIMOlhP5QvRjvEeRVIy8FhIBgCMIKR12jeUuFschXhKEvD+Z
	 p0jbh3/IvcqAQmtMAeQuDeBinx0vrYt5Ct6JE18mjaq1WIpO7VE8T+CNdhyy/mULC1
	 Uwxo9HGNv0aDsA341mFhpDZObJrRm1drNlKRU4hQ=
Date: Wed, 2 Apr 2025 21:06:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Vlastimil
 Babka <vbabka@suse.cz>, Sebastian Sewior <bigeasy@linutronix.de>, Steven
 Rostedt <rostedt@goodmis.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Michal Hocko <mhocko@suse.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] locking/local_lock, mm: Replace localtry_ helpers
 with local_trylock_t type
Message-Id: <20250402210609.8277eb512a78dcc4fa3702b3@linux-foundation.org>
In-Reply-To: <CAADnVQ+Uy_sctUkEFN4P6GEO_=5Q6n2XNonWaJYfz7uW90QWTQ@mail.gmail.com>
References: <20250403025514.41186-1-alexei.starovoitov@gmail.com>
	<20250402201252.8926c547a327ce91c61fd620@linux-foundation.org>
	<CAADnVQ+Uy_sctUkEFN4P6GEO_=5Q6n2XNonWaJYfz7uW90QWTQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 2 Apr 2025 20:48:39 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Wed, Apr 2, 2025 at 8:12 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed,  2 Apr 2025 19:55:14 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > > Partially revert commit 0aaddfb06882 ("locking/local_lock: Introduce localtry_lock_t").
> > > Remove localtry_*() helpers, since localtry_lock() name might
> > > be misinterpreted as "try lock".
> > >
> >
> > So many macros grumble.
> >
> > +#define local_trylock_init(lock)       __local_trylock_init(lock)
> > +#define local_trylock(lock)            __local_trylock(lock)
> > +#define local_trylock_irqsave(lock, flags)                     \
> > +#define __local_trylock_init(lock) __local_lock_init(lock.llock)
> > +#define __local_lock_acquire(lock)                                     \
> > +#define __local_trylock(lock)                                  \
> > +#define __local_trylock_irqsave(lock, flags)                   \
> > +#define __local_lock_release(lock)                                     \
> > +#define __local_unlock(lock)                                   \
> > +#define __local_unlock_irq(lock)                               \
> > +#define __local_unlock_irqrestore(lock, flags)                 \
> > +#define __local_lock_nested_bh(lock)                           \
> > +#define __local_unlock_nested_bh(lock)                         \
> > +#define __local_trylock_init(l)                        __local_lock_init(l)
> > +#define __local_trylock(lock)                                  \
> > +#define __local_trylock_irqsave(lock, flags)                   \
> >
> > I expect many of these could have been implemented as static inlines.
> >
> > Oh well, that's a separate project for someone sometime.
> 
> They need to be macroses otherwise _Generic() trick won't work.

Ah.

> Thanks for applying v3.
> 
> Do you want to take "mm/page_alloc: Avoid second trylock of zone->lock"
> fix as well ?

Added, thanks.

