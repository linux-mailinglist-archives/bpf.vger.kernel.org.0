Return-Path: <bpf+bounces-34259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CA592C216
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 19:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604A9B2E74F
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 17:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C251AD9C7;
	Tue,  9 Jul 2024 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZaR7Ei/e"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8769F19E82B;
	Tue,  9 Jul 2024 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542643; cv=none; b=ChjcYcIdLVwbdSSPwxQn74jXJfaXoDLyp7jIondEBCYFx5y0BnQjXhrDCEO1o6T5IMB+7K7hdcnmK4KoW9nEcYMKgC5pRefRNZ7raU8uMHpdsezgQcAPhynKJ1MYcRcXDCggH7sQdoMFHCUxAaK+87QJ8MGfWYhlwsBQqL8ootY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542643; c=relaxed/simple;
	bh=+J135aSrqRX9xE08EI2dz/9gEk4k8tD5i2S4SEz08/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ji4hpgc66DfvS6th9f9PQNIB4Plt1EEjNyYj4v58uVaWGPu4Sehwv+3Q9NU+0QZam1QlhqajH+7BDCmnDh4mlLho6LsoaTWoqntkm6W7gj3f0vlCJmIqmEupceu/0FWQxToWq3qPhIN1zVbn64hKR+WQNu5WR6NcLYQBkFIIwdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZaR7Ei/e; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7XRXfrB2fmvhSy87pLmluWUrfWrZdc4sO1XIVyso348=; b=ZaR7Ei/ex4FOsarOP4tLl94nhr
	e1cacMyPF3N9oJdwpcqL2UaDdrA9n6fy53iEtvxvEI7BvwDLHDNwMQlSYkn13tosWrD09EvYRooub
	qm/knWfWhIaQ5ZqqPUpCROJfAmN2pKzRJbRDj6ykEoPro5AGzXkQT98enA5+VnfrEE0/GONxKkhMM
	B5sJLa+mAC/FS5nW81j9UtlF4WKn9H7MLTtz+u8+9naiT7T3rtVjvHcBnz5PPPudrPYvx6XJ09SRl
	lFZEqd+QMLcSn+RRmZF8flLzN0TJv1KLh4v3B1w1i1xVSv1NaCp8hfUYFANFfNgweNN6uc9ObyPT4
	MxVFMG6A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRDji-0000000845p-0jEz;
	Tue, 09 Jul 2024 16:30:38 +0000
Date: Tue, 9 Jul 2024 17:30:38 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, jolsa@kernel.org,
	clm@meta.com, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <Zo1lrpO3suceheVj@casper.infradead.org>
References: <20240708091241.544262971@infradead.org>
 <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090153.GF27299@noisy.programming.kicks-ass.net>
 <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop>
 <20240709142943.GL27299@noisy.programming.kicks-ass.net>
 <Zo1hBFS7c_J-Yx-7@casper.infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo1hBFS7c_J-Yx-7@casper.infradead.org>

On Tue, Jul 09, 2024 at 05:10:45PM +0100, Matthew Wilcox wrote:
> > So I fundamentally do not believe in per-VMA locking. Specifically for
> > this case that would be trading one hot line for another. I tried
> > telling people that, but it doesn't seem to stick :/
> 
> SRCU also had its own performance problems, so we've got problems one
> way or the other.  The per-VMA lock probably doesn't work quite the way
> you think it does, but it absoutely can be a hot cacheline.
> 
> I did propose a store-free variant at LSFMM 2022 and again at 2023,
> but was voted down.  https://lwn.net/Articles/932298/

Actually, the 2022 version has a bit more of the flavour of the
argument: https://lwn.net/Articles/893906/


