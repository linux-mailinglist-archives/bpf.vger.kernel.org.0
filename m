Return-Path: <bpf+bounces-43040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7519AE1AE
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 11:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B48E1C21243
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 09:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02B01C07E9;
	Thu, 24 Oct 2024 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QWlWgIhc"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C52F1B6CE2;
	Thu, 24 Oct 2024 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763839; cv=none; b=dB4L27WMLouv6umZpTlMkVXnlGwz4g51ygq8sAGu6SuNBXZmJHdch5CKGf3zUu/h6t1MMQis/cp8kaC3HWTULAMtpibLj8iSlnu19KHZ55sYWOO6RUXBI2EUXQlCd5DDRTl95YtaVB18NsLtbQnKlbWXrnKCgi7MsuOhR+q3HBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763839; c=relaxed/simple;
	bh=CZeq0cZpSpFXcRcaNBDH6xOyf+OZwVKpMGiQjSVFnvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3f2PTQqb2HvdUh6IyvOhrH4rHsjHxmr+ufu2OnUlBC/mRkSqzoQqNiauvT/lJxTkwiMMFveMZW1UjeE/zzxsjHMGUyuctW6soptDVW7h55ihfdmcM2FFIoVwQewEAF2YSDqoUPmudjdHH/JJT7uHg7AC6eoh1XkORatKU1Vzr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QWlWgIhc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rzpvzquYLWtBHVgVkBB32hWAp+AI3BVUB9oT07w6q0k=; b=QWlWgIhchbPRGKHewwzWOna/4/
	p/ueuwd3CjrM2/ZUlhh+eYL/Dxdn0K61jVg9/tSzMzxb2eVGvKW2BK9oixA+0CpgPP5sMu0kRrSsP
	mZxbEwUMev3gMfIhcWP8P6x+7Gc3/8MdOyNC20el1poSgIn5MOZof6FDGwNCQKRlIBMdFDQ1kbpOo
	e2OvUDgkSMJFsciLZgoVHVMoR7nYztJfaE/c6zl9oyDDG/DXUon3rgaMDkzirZd06WUsOzRUiLFq9
	65NEWncjyDKBMQUa6nE0OXNgGHTIs1mcK/ohhjuuwTC2tjRybStJmWzJk0iUBwljvdxwJpnRqxpyR
	PKkx2SOQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3uaS-00000008dc2-1BLX;
	Thu, 24 Oct 2024 09:57:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 63EEB300599; Thu, 24 Oct 2024 11:56:59 +0200 (CEST)
Date: Thu, 24 Oct 2024 11:56:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, oleg@redhat.com, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, akpm@linux-foundation.org, mjguzik@gmail.com,
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org,
	vbabka@suse.cz, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com
Subject: Re: [PATCH v3 tip/perf/core 1/4] mm: introduce
 mmap_lock_speculation_{start|end}
Message-ID: <20241024095659.GD9767@noisy.programming.kicks-ass.net>
References: <20241010205644.3831427-1-andrii@kernel.org>
 <20241010205644.3831427-2-andrii@kernel.org>
 <20241023201031.GF11151@noisy.programming.kicks-ass.net>
 <CAJuCfpFMhoCmqGJMU2uc4JHmk9zh88JzhZAeSz3DgvXEh+u+_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFMhoCmqGJMU2uc4JHmk9zh88JzhZAeSz3DgvXEh+u+_g@mail.gmail.com>

On Wed, Oct 23, 2024 at 03:17:01PM -0700, Suren Baghdasaryan wrote:

> > Or better yet, just use seqcount...
> 
> Yeah, with these changes it does look a lot like seqcount now...
> I can take another stab at rewriting this using seqcount_t but one
> issue that Jann was concerned about is the counter being int vs long.
> seqcount_t uses unsigned, so I'm not sure how to address that if I
> were to use seqcount_t. Any suggestions how to address that before I
> move forward with a rewrite?

So if that issue is real, it is not specific to this case. Specifically
preemptible seqcount will be similarly affected. So we should probably
address that in the seqcount implementation.


