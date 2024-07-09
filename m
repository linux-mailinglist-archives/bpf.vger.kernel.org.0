Return-Path: <bpf+bounces-34245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190F392BCEE
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 16:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1F81C21CD7
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 14:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF4519CD02;
	Tue,  9 Jul 2024 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I54xNbqG"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E41519B5A3;
	Tue,  9 Jul 2024 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535392; cv=none; b=tHX5JmwlPphJUXoyJuLRl5vCKWMJ93rPuPj1BWcYQLUk36hszLEV2KBIkmztbMFdZ+nB0Iyr/Ps09cJ4eXrwicMysArHv0bKiJgx0SEf/0vbbkrD/okFVUCNWmkrq6JRnzKK7G4w4glgkwyN0IONv6f/ZrSBRc2ZlDq5QZX33JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535392; c=relaxed/simple;
	bh=LduHVRTiC3iwHFbu7vmilxzgzegVbn8n+xpf0P1SlRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRCXYgtjKnmkvnJRW3Zu8h/O4DpLeEvF2znBj9GxY9LD7U5WamrftdK6vGTUs5ppq2eltW+Ub3GW5iP8B1rA6DdVBT/ON+kA8eJnhX/+n4/WF8C0N977P1dM2kHW0DjSx2d8Py1d8dR5rlkj5M3mguJw3hZ4Fr9xskdizdzNnBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I54xNbqG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ghxjHQXmqKv2FuT84efTP3gquWcgHP51+Q9Ttn5jjuk=; b=I54xNbqGMOf+iwW+idlyrZ3ymr
	xboIMGHlXCHfVTe3iVzX2aGGYsGhr2B6z4pFc+3pvMvU0tVBCwSwnv0fPS2y2Y0jjrilZ3sAtVGjP
	dMKCK5xgG1cQXhWNYLIBxCDuAkJ6OB8DN2rWGQ/5vVWZQl3Ixj4IL+CzXebwO6d/OwggE3GRd50m4
	9yXwt6D62ClhdQIK+GWC4i8bF5deqe0jL6062gycKkpn8pCCM/0T2/9+99V/2E8cgk42KsXgQjKq/
	AnsVORiql0LJhKrPKnxlo8tcaST16j7MQs6NOLLHsLOk0ZJeco4IRuJ0SuRKOTuKPR5me4GnstSTy
	xCGUEgag==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRBqi-00000007yKV-1ZZx;
	Tue, 09 Jul 2024 14:29:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A8FE93006B7; Tue,  9 Jul 2024 16:29:43 +0200 (CEST)
Date: Tue, 9 Jul 2024 16:29:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org,
	clm@meta.com, bpf <bpf@vger.kernel.org>, willy@infradead.org
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <20240709142943.GL27299@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
 <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090153.GF27299@noisy.programming.kicks-ass.net>
 <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop>

On Tue, Jul 09, 2024 at 07:11:23AM -0700, Paul E. McKenney wrote:
> On Tue, Jul 09, 2024 at 11:01:53AM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 08, 2024 at 05:25:14PM -0700, Andrii Nakryiko wrote:
> > 
> > > Quick profiling for the 8-threaded benchmark shows that we spend >20%
> > > in mmap_read_lock/mmap_read_unlock in find_active_uprobe. I think
> > > that's what would prevent uprobes from scaling linearly. If you have
> > > some good ideas on how to get rid of that, I think it would be
> > > extremely beneficial. 
> > 
> > That's find_vma() and friends. I started RCU-ifying that a *long* time
> > ago when I started the speculative page fault patches. I sorta lost
> > track of that effort, Willy where are we with that?
> > 
> > Specifically, how feasible would it be to get a simple RCU based
> > find_vma() version sorted these days?
> 
> Liam's and Willy's Maple Tree work, combined with Suren's per-VMA locking
> combined with some of Vlastimil's slab work is pushing in that direction.
> I believe that things are getting pretty close.

So I fundamentally do not believe in per-VMA locking. Specifically for
this case that would be trading one hot line for another. I tried
telling people that, but it doesn't seem to stick :/

Per VMA refcounts or per VMA locks are a complete fail IMO.

I suppose I should go dig out the latest versions of those patches to
see where they're at :/

