Return-Path: <bpf+bounces-38776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEF7969FC3
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 16:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38722B23CC9
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2024 14:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DA439AE3;
	Tue,  3 Sep 2024 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FNJ0VdPq"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E5D2AE75;
	Tue,  3 Sep 2024 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372209; cv=none; b=M1euvAPXLLE0Vfya68DzotbSCaThGRc4w33ErhNdc8T4wYGCmz+zRD+tHJl50sK5ZoBtzHZ+utkCXs1HKkVjkzk1AWDJhr/xhvmlv/QNI0n6+n4znLQZj64OAMU/t+kBg4Ai/p7k/eOf34gqy0oTh1yXrf9mfQy9KO5yASkF8Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372209; c=relaxed/simple;
	bh=6nyRXQTwr4tYNLCS1u9IT2f7nTj+nNw5xAtCwaBLsWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnNUDxb1ynsWjqo9tDHz9b3HlSlLecBR4a/KV/g9N9gn+7WdpyH9J3gDHJmqHb6Y58s+puPZQ1/L3sgzXySIzTDQCIdSldR8ltzcOv2zfMEpDSpz6Y3xqHP979YPFEV3YOXEqVW/6cMfBEZT4A0P6cOte1ddk9URyHLTcoDXUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FNJ0VdPq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FzLJhyXmehlWY085+oiO2T8+INZxNdpP2QPPOIIqxXg=; b=FNJ0VdPqtqAthGm16MBbUylxv9
	3cDZ2Vx9ufInOyjNKF7hzbMm+qZ/FAkxxyCEHT21nSPOKPSw+hBstfWbvnIJsTSqbHNBJl8Ahxsr8
	R76Kcuf4x8itetZ7P4eyXOji676zyo3XOjYtgo3lh8wFuKtgkkaSSX6RQrVkWaa1T8daEW3cneMR7
	okQmSmKgYiJpys4VP8TGAa7bjsCJ0anSdgmTif/jDqZFXaDQsBLtSFXvNDXXIX0io+vV7SpvaWsEO
	NUHgAiokqpGr9Hl5erEe79+TIjHr/qk+J4uV84W3IKcXTQUnvgQE2bQvF0I0Gpm/vdeHalC62wmIa
	9Nd70JOg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1slU7s-00000008IeA-3RA3;
	Tue, 03 Sep 2024 14:03:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E19EE30050D; Tue,  3 Sep 2024 16:03:19 +0200 (CEST)
Date: Tue, 3 Sep 2024 16:03:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 0/8] uprobes: RCU-protected hot path optimizations
Message-ID: <20240903140319.GA4723@noisy.programming.kicks-ass.net>
References: <20240829183741.3331213-1-andrii@kernel.org>
 <20240830102400.GA20163@redhat.com>
 <20240903132103.GV4723@noisy.programming.kicks-ass.net>
 <20240903135943.GE17936@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903135943.GE17936@redhat.com>

On Tue, Sep 03, 2024 at 03:59:43PM +0200, Oleg Nesterov wrote:
> On 09/03, Peter Zijlstra wrote:
> >
> > On Fri, Aug 30, 2024 at 12:24:01PM +0200, Oleg Nesterov wrote:
> > > On 08/29, Andrii Nakryiko wrote:
> > > >
> > > > v3->v4:
> > > >   - added back consumer_rwsem into consumer_del(), which was accidentally
> > > >     omitted earlier (Jiri);
> > >
> > > still,
> > >
> > > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> > >
> >
> > Let me go queue this in perf/core then. Thanks!
> 
> FYI, Andrii was going to send another revision due to missing include
> inux/rcupdate_trace.h in kernel/events/uprobes.c.
> 
> See the build failure reported kernel test robot:
> https://lore.kernel.org/all/202408310130.t9EBKteQ-lkp@intel.com/

No problem, I'll sit on it.

