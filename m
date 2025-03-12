Return-Path: <bpf+bounces-53921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF082A5E41D
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 20:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C613A5EBF
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 19:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85802580ED;
	Wed, 12 Mar 2025 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pQPjkoF1"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD581E5B7D
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741806383; cv=none; b=boi6g1Jap/EFJRy7u1wW5wBddVNmsx0TL4u9T6twEWGiHInYhMGsKvOfbqs1JxpMawYTkeijYHNvbTHEdp+l9JfjYEYkhE7rbvuiE120ukGr7JtbCgWYzvSK60R2fcyQ6FYI7z2rJsctiFBxlhAVkUhTCXVsbHOlz49edpdpPII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741806383; c=relaxed/simple;
	bh=L5zb19m/qRUY6q/AgTOBfXr2AsPqf/dRjm/OEyvutJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gc1HQ9Is/+iuPfHnQUVcYYH53uPxOcanwvg+Acg+WkbRqyN01p/SZCpGaTzgBNcMwJUQ8lGWwOLNyhrg8HZbxn+hsmxkrzZvViWSjCiw/gyY7gHaItzrqvwC/eBvUR52aTzMnq5dlj3KVtv/JPxHqNzdp0QvuG/HNlh97FC8duM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pQPjkoF1; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 12 Mar 2025 12:06:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741806378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=taQrTtRT6oKrmvrbMflaeFBHHQcfBZ3zC2RW9QpVfrE=;
	b=pQPjkoF1TjMWNogAMZSj/7G+VJWY+f94bgcxZSrwbLOtQtg3hQZcwKl5UAiLFO0zbNCUW+
	8nEMMjtbDq/oCiOxHHvCbeYjDq6nBHgmKEcdtOtoqZ5oNkkCyxPnT4xjjNTffHlx/HoIkh
	j8I4Aq8oUWThc29uOsDlcC+VX/VVlpo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v9 2/6] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Message-ID: <igjisv7v3o2efey3qkhcrqjchlqvjn54c4dneo2atmown6pweq@jwohzvtldfzf>
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
 <20250222024427.30294-3-alexei.starovoitov@gmail.com>
 <20250310190427.32ce3ba9adb3771198fe2a5c@linux-foundation.org>
 <CAADnVQJsYcMfn4XjAtgo9gHsiUs-BX-PEyi1oPHy5_gEuWKHFQ@mail.gmail.com>
 <4d75c5a8-a538-4d7d-aaf4-8ecf1d1be6b9@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d75c5a8-a538-4d7d-aaf4-8ecf1d1be6b9@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 12, 2025 at 11:00:20AM +0100, Vlastimil Babka wrote:
[...]
> 
> But if we can achieve the same without such reserved objects, I think it's
> even better. Performance and maintainability doesn't need to necessarily
> suffer. Maybe it can even improve in the process. E.g. if we build upon
> patches 1+4 and swith memcg stock locking to the non-irqsave variant, we
> should avoid some overhead there (something similar was tried there in the
> past but reverted when making it RT compatible).

In hindsight that revert was the bad decision. We accepted so much
complexity in memcg code for RT without questioning about a real world
use-case. Are there really RT users who want memcg or are using memcg? I
can not think of some RT user fine with memcg limits enforcement
(reclaim and throttling).

I am on the path to bypass per-cpu memcg stocks for RT kernels. The
stats would still need to be careful but I don't see any reason to keep
the complexity in memcg stocks for RT. IMO RT should prefer
predictability over performance, so bypassing memcg stocks should be
fine.

