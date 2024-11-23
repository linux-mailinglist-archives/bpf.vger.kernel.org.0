Return-Path: <bpf+bounces-45515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F190C9D6B78
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 21:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B0A2B2308C
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 20:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C249819CCF4;
	Sat, 23 Nov 2024 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tvsmohZn"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670D333987;
	Sat, 23 Nov 2024 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732394157; cv=none; b=h49LucKwUTS7CdZ8TMdTRcVjChiRlRH0r417SePzMVgcQW1cMGxM7/qaTvoCVShOCucInTHmY2W1yzrge0NioQ8J4u4MGfgIt5ziK2NwX0OJ4CE1kAa9QstZcdlNOjCJgrruAdc+CD5yNz5yBMwCQG6UvqtR39AJQvJFDf72nd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732394157; c=relaxed/simple;
	bh=UPnbEj/wR6IWBl5QwMzrmznuEAtXvgXYessq0ZHlz44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBYeQBxOFbMN2YctFXv32KtrS8JsTDT4nT+kOIHGLodOMMNrLS9n2MJ5MwKTD4r0VYPmAGTqNHKVasoAMX7g9drw0TL9K0nrA3/ZrKsBeZqqWZ70p0aj4QzDZf44bV4N/BpBTTn3YWVpP+83kX9Iaa9QomJAFAKK/9d5fiZ/tC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tvsmohZn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=GdVQpQrfD7NNVHIk8DzcTICGaQJm+Hj9wTrUx6w60jg=; b=tvsmohZnvW56+CtucddUOTPfra
	IiCMRN23sXi1G57fmhetkiR29/2Zw1/oozkQFXRvVMUH4Je5rMu2awV6ODo4psup0ZnJNisW9Xilw
	Ec3CZ1EKNbdpg4WPyTIzd8dw58d7N3jQy0BA9RQgHIzLWO0mmBh1w53jyGxyHo+JpUn9UVoY5Bsvv
	RbFjwv/1d3i5Oud44UE1WpXx+wBTxyyYmJ5hqCR8tWTb+nl3GeeVU3CA3oleElzrOkCFD8+U4o8Jw
	u228ki2F/5pm3gP7zJeuX1f5aHsE4+ey3grxaiPr0tXbANcusa87gkXANh2VW8ELQ5C7unYTJaskE
	StJdgCtw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEwr0-00000009boY-2OAo;
	Sat, 23 Nov 2024 20:35:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 61DE8300201; Sat, 23 Nov 2024 21:35:43 +0100 (CET)
Date: Sat, 23 Nov 2024 21:35:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, akpm@linux-foundation.org, mingo@kernel.org,
	torvalds@linux-foundation.org, oleg@redhat.com, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
	willy@infradead.org, mjguzik@gmail.com, brauner@kernel.org,
	jannh@google.com, mhocko@kernel.org, vbabka@suse.cz,
	shakeel.butt@linux.dev, hannes@cmpxchg.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	david@redhat.com, arnd@arndb.de, viro@zeniv.linux.org.uk,
	hca@linux.ibm.com
Subject: Re: [PATCH v5 tip/perf/core 0/2] uprobes: speculative lockless
 VMA-to-uprobe lookup
Message-ID: <20241123203543.GC20633@noisy.programming.kicks-ass.net>
References: <20241122035922.3321100-1-andrii@kernel.org>
 <20241122110737.GP24774@noisy.programming.kicks-ass.net>
 <CAJuCfpFvHwjMDdFGjCfg+fta2=Ccif7XReTH6TpC+V+PZ1JmAQ@mail.gmail.com>
 <CAJuCfpFy27B3B=4QvATTzaM44Ferf1scbt0JCdrCdj2gzo52+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFy27B3B=4QvATTzaM44Ferf1scbt0JCdrCdj2gzo52+A@mail.gmail.com>

On Fri, Nov 22, 2024 at 09:48:11AM -0800, Suren Baghdasaryan wrote:
> On Fri, Nov 22, 2024 at 7:04 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Fri, Nov 22, 2024 at 3:07 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Nov 21, 2024 at 07:59:20PM -0800, Andrii Nakryiko wrote:
> > >
> > > > Andrii Nakryiko (2):
> > > >   uprobes: simplify find_active_uprobe_rcu() VMA checks
> > > >   uprobes: add speculative lockless VMA-to-inode-to-uprobe resolution
> > >
> > > Thanks, assuming Suren is okay with me carrying his patches through tip,
> > > I'll make this land in tip/perf/core after -rc1.
> >
> > No objections from me. Thanks!
> 
> I just fixed a build issue in one of my patches for an odd config, so
> please use the latest version of the patchset from here:
> https://lore.kernel.org/all/20241122174416.1367052-1-surenb@google.com/

updated, thanks!

