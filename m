Return-Path: <bpf+bounces-49679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A84AA1BA57
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 17:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B82018906E6
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 16:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805F118EFCC;
	Fri, 24 Jan 2025 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oNEtmoRu"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8BE156649
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737736109; cv=none; b=aFWZcpWJRlaMGSksPzhu9j4To+mbtjNqC80Agdeu3Z2XYUUZ9izjsnrYWlWGFqr3t12vbZpXDqL8IR+EQer1ViQEV64Jr0a8GTPGu+9/odVUrkSYeMQiyRZ3PB2oRhwCs1L096aEOBkJgJ/m/rHEpMpxBk3D/ArqkKgAXMgpM4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737736109; c=relaxed/simple;
	bh=ezPn5AZD9BoLjkr9/XF5/26e+Umxh/iPtpyHseXFGng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNiSfxw54z9rBvnJ57OhB9d3W7S+/PwvUN5QmnUO9M1auZbg5hQyEwUT49jq7qTAZg8uwfbEfe6y9TOcRV2PE2AFSR1j1j0PwrwTrdGwPeYohqfNr/yobOdbzgSEIx5obqk8wzRQ9ywdOytygh/cAr1UOCDQvinHrLCDEyf8Rgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oNEtmoRu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Irbw1bGTK9gYgpshyOyAQdC0GwwG9zFKQ+fCPPFgO+Y=; b=oNEtmoRulpKzxP9axT7jkgDXDe
	Pte02DiB3LLnzFujy4qy8z0ivQEFNO8djkZCl/m6s5qUmTlapagKLHqX5Ohl6/vlrAIkwYSEeOHHp
	umyTJxuFDMyJvslktxkwxlXNx1XH/Ea8l6nX/I6ZB0FFlbUEowjlYU3lbzAipot6fJz9geX+y7glZ
	BX5x8B07FS7vYh0iqqCmjFTlIcCoq/zA4LoC7ARBjy0+Kd2KVjZJorKlaL+Bb32Oh9GzPhbtKQuL0
	1rvajr2yYK5QIjLh8eGtmLPqAUS3eQMR3h1C82M6J0pG1SeQ6V9C3jWw6fOtfEUMxFkHZwveeaBx0
	q5drOqRw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tbMXd-0000000Gqrz-1XhV;
	Fri, 24 Jan 2025 16:28:21 +0000
Date: Fri, 24 Jan 2025 16:28:21 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, bpf <bpf@vger.kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
	Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
	Kernel Team <kernel-team@fb.com>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH bpf-next v6 0/6] bpf, mm: Introduce try_alloc_pages()
Message-ID: <Z5O_pcGpSh94Hbvu@casper.infradead.org>
References: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
 <Z5OgvePdlqRoKMyx@casper.infradead.org>
 <e5c1eed1-3ea2-4452-a871-3308c90e932b@suse.cz>
 <CAADnVQJhU3EYp3fWYcTFtZobJUAaWRQmjjBSw5te9OpUaM8TNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJhU3EYp3fWYcTFtZobJUAaWRQmjjBSw5te9OpUaM8TNw@mail.gmail.com>

On Fri, Jan 24, 2025 at 08:19:19AM -0800, Alexei Starovoitov wrote:
> I spotted this line:
> VM_BUG_ON_PAGE(compound && compound_order(page) != order, page);
> that line alone was a good enough reason to use __GFP_COMP,
> but since it's debug only I could only guess where the future lies.
> 
> Should it be something like:
> 
> if (WARN_ON(compound && compound_order(page) != order))
>  order = compound_order(page);
> 
> since proceeding with the wrong order is certain to crash.
> ?

It's hard to say.  We've got a discrepancy between "order at free call
site" and "order recorded in page".  We might, for example, have a
memory corruption which has overwritten the compound_order() stored in
the struct page, in which case the 'order' passed in is the correct one,
and "correcting" it to the corrupt one stored in struct page would be
the thing which caused the crash.

I'd leave it as VM_BUG_ON().

